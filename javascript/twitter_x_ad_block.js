// X.com 广告屏蔽脚本（适配 Twitter 改名后的新版 API）
let body = $response.body;
let obj = JSON.parse(body);

function filterPromoted(timeline) {
  if (!timeline || !timeline.instructions) return timeline;

  for (let i = 0; i < timeline.instructions.length; i++) {
    let instruction = timeline.instructions[i];

    // 处理 addEntries 类型的广告
    if (instruction.addEntries && instruction.addEntries.entries) {
      instruction.addEntries.entries = instruction.addEntries.entries.filter((entry) => {
        return !entry.entryId?.includes("promoted") &&
               !entry.content?.item?.promotedMetadata;
      });
    }

    // 处理 replaceEntry 类型的广告
    if (instruction.replaceEntry && instruction.replaceEntry.entry) {
      let entry = instruction.replaceEntry.entry;
      if (entry.content?.item?.promotedMetadata) {
        timeline.instructions[i] = null; // 移除整个广告项
      }
    }
  }

  // 过滤掉 null 项
  timeline.instructions = timeline.instructions.filter(Boolean);
  return timeline;
}

if (obj.timeline) {
  obj.timeline = filterPromoted(obj.timeline);
} else if (obj.data?.home?.home_timeline_urt) {
  obj.data.home.home_timeline_urt = filterPromoted(obj.data.home.home_timeline_urt);
}

$done({ body: JSON.stringify(obj) });