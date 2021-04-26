Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0623836AC2F
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Apr 2021 08:29:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231987AbhDZG3J (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 26 Apr 2021 02:29:09 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:41951 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231937AbhDZG3H (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 26 Apr 2021 02:29:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1619418505; x=1650954505;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tx0Mt8hBm9+wyuz6+bwxLY4Uo3mRSJjrmg+WARGheWQ=;
  b=h83b+o0QL13WpB+guyIjilDoVV96N5zI4ydrGg1kvIpm4VZzqFgOhFF0
   4WFljXjmzMVyj5Mu1fq4OOOklCnHlsTsQH8xK7cDuvX9U+pTXUnARjFd+
   d8HxmRiMv61IRCwZzJH2Mh49pFcYXwQOyfUd3VzXbAvjRX0ir2tZxTHCX
   ab/zxD9GBB4vXPLo4XG+eq/cJAHcb5J2dciRWUVtzqRJkTnFJIE/Jx8D/
   EgUIVX3XSrPYlvp7H+60SLlqaqtqfva/6oZk5fetTjMFdJE3fHz3j2SXX
   d6NsLCLCLdUu5ORV1NCYuLS1ge3fAvoFzicr0Dr7o7a37bcE8qa/Cf19e
   A==;
IronPort-SDR: V79lxG1xbccYPCRKrmECWsS6zZWC8PEjkCXXVSFZEzZYm8DNSkWHkYwG2FTqJ9fAPp8uN9FFDY
 OkGfqV7EES0IVldkqPck3cac+ogzYXrvNyQLc/kotc8RR8TfZXMbJvWeCm+FaaITef36rVGqSN
 2A8Jzy1puopGC01U8AyxZjl68kFUIvK8rCEHYp4KqcE2fFSE50+9Hl2lj/LONatZfGDreK+fXk
 jOBjzaM8+j+zEbDZND8PwSdcQPN0EZdeLXCUt/aQQ8pEzQB0M44qTXxMOp9Dpvs8JHE2HkGst6
 Pks=
X-IronPort-AV: E=Sophos;i="5.82,251,1613404800"; 
   d="scan'208";a="170788130"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 26 Apr 2021 14:28:25 +0800
IronPort-SDR: BXdCgwRwzYbAM5epfa8b93GYmoJuw7eEfe13G4ZLtB9k2bKsHC2yfFPC12f4ck/WWYyxFnIDlD
 2Jazqe1cJ7Ag5PROHeRllxQaqT+wC0Db/YCFfhK1MQkj1tsckVq6/LebwOiPi9Y90pNPpq6Fbf
 xkay8k6IIllaliLl3u9wXGnHPKy0vb28kdhtWFonG3M8labP7vgkiltVwVDqfUaKPNV18lFuNM
 6ZZu2LMcesAWW1sksrLEAfyVAI9IdctWLb2Od8qCHN0z84L+NB08wwsaDw01WSaNdE8ggN4lmw
 +6MN428xABcUbC4eepIsoLX7
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2021 23:08:49 -0700
IronPort-SDR: aHDR/4YzyrtTW8n7jEspTs9N3euHMjfXwiIiYnCBUXgemB0kPVLGBvwZU5Qkq3BWQ+RsrjkdCa
 kSTa84Vk2uvVRuKKBbuQ0ib4KdfyjCCNIEVa2J1wBLuD3WjwAhvoNmu4ouQetbQPksNHYZvFGU
 7VvtpAmQ9LDa4QY33PRpHqBLx8eptmD+3dPQ2d3BxN/dWrgP073ZGTdgBgoP3y+0DVl4bDs3iu
 9mlEVDGqGQ4C4xbkLyP3ufjpV3hg1jIMLxu6URWAmmxeIbpD7ibJaihXA1MQqFnyPVKFhO+126
 uNM=
WDCIronportException: Internal
Received: from bgy2573.ad.shared (HELO naota-xeon.wdc.com) ([10.225.48.58])
  by uls-op-cesaip02.wdc.com with ESMTP; 25 Apr 2021 23:28:25 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH 15/26] btrfs-progs: zoned: redirty clean extent buffers in zoned btrfs
Date:   Mon, 26 Apr 2021 15:27:31 +0900
Message-Id: <c39d81a95024ec3766fde2c7d5a2bd3cb863d8ed.1619416549.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1619416549.git.naohiro.aota@wdc.com>
References: <cover.1619416549.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Tree manipulating operations like merging nodes often release
once-allocated tree nodes. Btrfs cleans such nodes so that pages in the
node are not uselessly written out. On ZONED drives, however, such
optimization blocks the following IOs as the cancellation of the write out
of the freed blocks breaks the sequential write sequence expected by the
device.

This patch check if next dirty extent buffer is continuous to a previously
written one. If not, it redirty extent buffers between the previous one and
the next one, so that all dirty buffers are written sequentially.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 kernel-shared/ctree.h       |  1 +
 kernel-shared/transaction.c |  6 ++++++
 kernel-shared/zoned.c       | 30 ++++++++++++++++++++++++++++++
 kernel-shared/zoned.h       |  8 ++++++++
 4 files changed, 45 insertions(+)

diff --git a/kernel-shared/ctree.h b/kernel-shared/ctree.h
index a68c8bd38bd2..3cca60323e3d 100644
--- a/kernel-shared/ctree.h
+++ b/kernel-shared/ctree.h
@@ -1140,6 +1140,7 @@ struct btrfs_block_group {
 	 * allocation. This is used only with ZONED mode enabled.
 	 */
 	u64 alloc_offset;
+	u64 write_offset;
 };
 
 struct btrfs_device;
diff --git a/kernel-shared/transaction.c b/kernel-shared/transaction.c
index a2e53fb8dfca..5b991651c28e 100644
--- a/kernel-shared/transaction.c
+++ b/kernel-shared/transaction.c
@@ -18,6 +18,7 @@
 #include "kernel-shared/disk-io.h"
 #include "kernel-shared/transaction.h"
 #include "kernel-shared/delayed-ref.h"
+#include "kernel-shared/zoned.h"
 #include "common/messages.h"
 
 struct btrfs_trans_handle* btrfs_start_transaction(struct btrfs_root *root,
@@ -138,10 +139,15 @@ int __commit_transaction(struct btrfs_trans_handle *trans,
 	int ret;
 
 	while(1) {
+again:
 		ret = find_first_extent_bit(tree, 0, &start, &end,
 					    EXTENT_DIRTY);
 		if (ret)
 			break;
+
+		if (btrfs_redirty_extent_buffer_for_zoned(fs_info, start, end))
+			goto again;
+
 		while(start <= end) {
 			eb = find_first_extent_buffer(tree, start);
 			BUG_ON(!eb || eb->start != start);
diff --git a/kernel-shared/zoned.c b/kernel-shared/zoned.c
index 715a7881328c..793c524ed66f 100644
--- a/kernel-shared/zoned.c
+++ b/kernel-shared/zoned.c
@@ -852,10 +852,40 @@ out:
 		ret = -EIO;
 	}
 
+	if (!ret)
+		cache->write_offset = cache->alloc_offset;
+
 	free(alloc_offsets);
 	return ret;
 }
 
+bool btrfs_redirty_extent_buffer_for_zoned(struct btrfs_fs_info *fs_info,
+					   u64 start, u64 end)
+{
+	u64 next;
+	struct btrfs_block_group *cache;
+	struct extent_buffer *eb;
+
+	if (!btrfs_is_zoned(fs_info))
+		return false;
+
+	cache = btrfs_lookup_first_block_group(fs_info, start);
+	BUG_ON(!cache);
+
+	if (cache->start + cache->write_offset < start) {
+		next = cache->start + cache->write_offset;
+		BUG_ON(next + fs_info->nodesize > start);
+		eb = btrfs_find_create_tree_block(fs_info, next);
+		btrfs_mark_buffer_dirty(eb);
+		free_extent_buffer(eb);
+		return true;
+	}
+
+	cache->write_offset += (end + 1 - start);
+
+	return false;
+}
+
 #endif
 
 int btrfs_get_dev_zone_info_all_devices(struct btrfs_fs_info *fs_info)
diff --git a/kernel-shared/zoned.h b/kernel-shared/zoned.h
index 45d77c8daa69..1ba5a9939a3c 100644
--- a/kernel-shared/zoned.h
+++ b/kernel-shared/zoned.h
@@ -87,6 +87,8 @@ u64 btrfs_find_allocatable_zones(struct btrfs_device *device, u64 hole_start,
 				 u64 hole_end, u64 num_bytes);
 int btrfs_load_block_group_zone_info(struct btrfs_fs_info *fs_info,
 				     struct btrfs_block_group *cache);
+bool btrfs_redirty_extent_buffer_for_zoned(struct btrfs_fs_info *fs_info,
+					   u64 start, u64 end);
 #else
 #define sbread(fd, buf, offset) \
 	pread64(fd, buf, BTRFS_SUPER_INFO_SIZE, offset)
@@ -122,6 +124,12 @@ static inline int btrfs_load_block_group_zone_info(
 	return 0;
 }
 
+static inline bool btrfs_redirty_extent_buffer_for_zoned(
+	struct btrfs_fs_info *fs_info, u64 start, u64 end)
+{
+	return false;
+}
+
 #endif /* BTRFS_ZONED */
 
 static inline bool btrfs_dev_is_sequential(struct btrfs_device *device, u64 pos)
-- 
2.31.1

