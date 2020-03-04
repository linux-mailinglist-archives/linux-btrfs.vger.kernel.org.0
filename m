Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 42B90178B47
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Mar 2020 08:27:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728278AbgCDH1L (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 4 Mar 2020 02:27:11 -0500
Received: from mx2.suse.de ([195.135.220.15]:34098 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727026AbgCDH1K (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 4 Mar 2020 02:27:10 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 28ED0AD78
        for <linux-btrfs@vger.kernel.org>; Wed,  4 Mar 2020 07:27:09 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 1/2] btrfs-progs: check: Detect overlap csum items
Date:   Wed,  4 Mar 2020 15:27:00 +0800
Message-Id: <20200304072701.38403-2-wqu@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200304072701.38403-1-wqu@suse.com>
References: <20200304072701.38403-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

There is a report about csum item overlap, which makes newer btrfs
kernel to reject it due to tree-checker.

Now let btrfs-progs have the same ability to detect such problem.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 check/main.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/check/main.c b/check/main.c
index d02dd1636852..c526c72d158e 100644
--- a/check/main.c
+++ b/check/main.c
@@ -5893,6 +5893,7 @@ static int check_csums(struct btrfs_root *root)
 	struct btrfs_path path;
 	struct extent_buffer *leaf;
 	struct btrfs_key key;
+	u64 last_data_end = 0;
 	u64 offset = 0, num_bytes = 0;
 	u16 csum_size = btrfs_super_csum_size(root->fs_info->super_copy);
 	int errors = 0;
@@ -5952,6 +5953,13 @@ static int check_csums(struct btrfs_root *root)
 			continue;
 		}
 
+		if (key.offset < last_data_end) {
+			error(
+	"csum overlap, current bytenr=%llu prev_end=%llu, eb=%llu slot=%u",
+				key.offset, last_data_end, leaf->start,
+				path.slots[0]);
+			errors++;
+		}
 		data_len = (btrfs_item_size_nr(leaf, path.slots[0]) /
 			      csum_size) * root->fs_info->sectorsize;
 		if (!verify_csum)
@@ -5982,6 +5990,7 @@ skip_csum_check:
 			num_bytes = 0;
 		}
 		num_bytes += data_len;
+		last_data_end = key.offset + data_len;
 		path.slots[0]++;
 	}
 
-- 
2.25.1

