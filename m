Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75E344C2BB0
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Feb 2022 13:29:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234373AbiBXM3a (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 24 Feb 2022 07:29:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234379AbiBXM3Z (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 24 Feb 2022 07:29:25 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8447E26A38A
        for <linux-btrfs@vger.kernel.org>; Thu, 24 Feb 2022 04:28:55 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 415431F44A
        for <linux-btrfs@vger.kernel.org>; Thu, 24 Feb 2022 12:28:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1645705734; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dZSSFtcbrGBVNIcpYSN6FIBNxhpTs22gzVGtEDNuaGI=;
        b=hziNHRb8geiPNfc2jIlwTkyVYGjufTwJQOWI+ihP+n001d9uDF1xme3ud70nukY0pUudF5
        ChoqwSOqxPaCiUJucRkqSSS0zpcCL1wgUbRm/LkT43A+YbklliTrUGpemmX5V4GswoUmbQ
        i+Q33X1c73V2vVyPdLmNfPzhSFu+IxQ=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8798713AD9
        for <linux-btrfs@vger.kernel.org>; Thu, 24 Feb 2022 12:28:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id CDZjEwV6F2LhAgAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Thu, 24 Feb 2022 12:28:53 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 7/7] btrfs: add trace events for defrag
Date:   Thu, 24 Feb 2022 20:28:41 +0800
Message-Id: <bf2635d213e0c85251c4cd0391d8fbf274d7d637.1645705266.git.wqu@suse.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1645705266.git.wqu@suse.com>
References: <cover.1645705266.git.wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This patch will introduce the following trace events:

- trace_defrag_add_target()
- trace_defrag_one_locked_range()
- trace_defrag_file_start()
- trace_defrag_file_end()

Under most cases, all of them are needed to debug policy related defrag
bugs.

The example output would look like this: (with TASK, CPU, TIMESTAMP and
UUID skipped)

 defrag_file_start: <UUID>: root=5 ino=257 start=0 len=131072 extent_thresh=262144 newer_than=7 flags=0x0 compress=0 max_sectors_to_defrag=1024
 defrag_add_target: <UUID>: root=5 ino=257 target_start=0 target_len=4096 found em=0 len=4096 generation=7
 defrag_add_target: <UUID>: root=5 ino=257 target_start=4096 target_len=4096 found em=4096 len=4096 generation=7
...
 defrag_add_target: <UUID>: root=5 ino=257 target_start=57344 target_len=4096 found em=57344 len=4096 generation=7
 defrag_add_target: <UUID>: root=5 ino=257 target_start=61440 target_len=4096 found em=61440 len=4096 generation=7
 defrag_add_target: <UUID>: root=5 ino=257 target_start=0 target_len=4096 found em=0 len=4096 generation=7
 defrag_add_target: <UUID>: root=5 ino=257 target_start=4096 target_len=4096 found em=4096 len=4096 generation=7
...
 defrag_add_target: <UUID>: root=5 ino=257 target_start=57344 target_len=4096 found em=57344 len=4096 generation=7
 defrag_add_target: <UUID>: root=5 ino=257 target_start=61440 target_len=4096 found em=61440 len=4096 generation=7
 defrag_one_locked_range: <UUID>: root=5 ino=257 start=0 len=65536
 defrag_file_end: <UUID>: root=5 ino=257 sectors_defragged=16 last_scanned=131072 ret=0

Although the defrag_add_target() part is lengthy, it shows some details
of the extent map we get.
With the extra info from defrag_file_start(), we can check if the target
em is correct for our defrag policy.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/ioctl.c             |   4 ++
 include/trace/events/btrfs.h | 127 +++++++++++++++++++++++++++++++++++
 2 files changed, 131 insertions(+)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 1f0bf6181013..0d79dc28a9d4 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -1486,6 +1486,7 @@ static int defrag_collect_targets(struct btrfs_inode *inode,
 add:
 		last_is_target = true;
 		range_len = min(extent_map_end(em), start + len) - cur;
+		trace_defrag_add_target(inode, em, cur, range_len);
 		/*
 		 * This one is a good target, check if it can be merged into
 		 * last range of the target list.
@@ -1581,6 +1582,7 @@ static int defrag_one_locked_target(struct btrfs_inode *inode,
 	ret = btrfs_delalloc_reserve_space(inode, &data_reserved, start, len);
 	if (ret < 0)
 		return ret;
+	trace_defrag_one_locked_range(inode, start, (u32)len);
 	clear_extent_bit(&inode->io_tree, start, start + len - 1,
 			 EXTENT_DELALLOC | EXTENT_DO_ACCOUNTING |
 			 EXTENT_DEFRAG, 0, 0, cached_state);
@@ -1818,6 +1820,7 @@ int btrfs_defrag_file(struct inode *inode, struct file_ra_state *ra,
 	cur = round_down(ctrl->start, fs_info->sectorsize);
 	ctrl->last_scanned = cur;
 	last_byte = round_up(last_byte, fs_info->sectorsize) - 1;
+	trace_defrag_file_start(BTRFS_I(inode), ctrl, cur, last_byte + 1 - cur);
 
 	/*
 	 * If we were not given a ra, allocate a readahead context. As
@@ -1905,6 +1908,7 @@ int btrfs_defrag_file(struct inode *inode, struct file_ra_state *ra,
 		BTRFS_I(inode)->defrag_compress = BTRFS_COMPRESS_NONE;
 		btrfs_inode_unlock(inode, 0);
 	}
+	trace_defrag_file_end(BTRFS_I(inode), ctrl, ret);
 	return ret;
 }
 
diff --git a/include/trace/events/btrfs.h b/include/trace/events/btrfs.h
index f068ff30d654..f46b9858154d 100644
--- a/include/trace/events/btrfs.h
+++ b/include/trace/events/btrfs.h
@@ -30,6 +30,7 @@ struct btrfs_qgroup;
 struct extent_io_tree;
 struct prelim_ref;
 struct btrfs_space_info;
+struct btrfs_defrag_ctrl;
 
 #define show_ref_type(type)						\
 	__print_symbolic(type,						\
@@ -2264,6 +2265,132 @@ DEFINE_EVENT(btrfs__space_info_update, update_bytes_pinned,
 	TP_ARGS(fs_info, sinfo, old, diff)
 );
 
+TRACE_EVENT(defrag_one_locked_range,
+
+	TP_PROTO(const struct btrfs_inode *inode, u64 start, u32 len),
+
+	TP_ARGS(inode, start, len),
+
+	TP_STRUCT__entry_btrfs(
+		__field(	u64,	root		)
+		__field(	u64,	ino		)
+		__field(	u64,	start		)
+		__field(	u32,	len		)
+	),
+
+	TP_fast_assign_btrfs(inode->root->fs_info,
+		__entry->root	= inode->root->root_key.objectid;
+		__entry->ino	= btrfs_ino(inode);
+		__entry->start	= start;
+		__entry->len	= len;
+	),
+
+	TP_printk_btrfs("root=%llu ino=%llu start=%llu len=%u",
+		__entry->root, __entry->ino, __entry->start, __entry->len)
+);
+
+TRACE_EVENT(defrag_add_target,
+
+	TP_PROTO(const struct btrfs_inode *inode, const struct extent_map *em,
+		 u64 start, u32 len),
+
+	TP_ARGS(inode, em, start, len),
+
+	TP_STRUCT__entry_btrfs(
+		__field(	u64,	root		)
+		__field(	u64,	ino		)
+		__field(	u64,	target_start	)
+		__field(	u32,	target_len	)
+		__field(	u64,	em_generation	)
+		__field(	u64,	em_start	)
+		__field(	u64,	em_len		)
+	),
+
+	TP_fast_assign_btrfs(inode->root->fs_info,
+		__entry->root		= inode->root->root_key.objectid;
+		__entry->ino		= btrfs_ino(inode);
+		__entry->target_start	= start;
+		__entry->target_len	= len;
+		__entry->em_generation	= em->generation;
+		__entry->em_start	= em->start;
+		__entry->em_len		= em->len;
+	),
+
+	TP_printk_btrfs("root=%llu ino=%llu target_start=%llu target_len=%u "
+		"found em=%llu len=%llu generation=%llu",
+		__entry->root, __entry->ino, __entry->target_start,
+		__entry->target_len, __entry->em_start, __entry->em_len,
+		__entry->em_generation)
+);
+
+TRACE_EVENT(defrag_file_start,
+
+	TP_PROTO(const struct btrfs_inode *inode,
+		 const struct btrfs_defrag_ctrl *ctrl, u64 start, u64 len),
+
+	TP_ARGS(inode, ctrl, start, len),
+
+	TP_STRUCT__entry_btrfs(
+		__field(	u64,	root			)
+		__field(	u64,	ino			)
+		__field(	u64,	start			)
+		__field(	u64,	len			)
+		__field(	u64,	newer_than		)
+		__field(	u64,	max_sectors_to_defrag	)
+		__field(	u32,	extent_thresh		)
+		__field(	u8,	flags			)
+		__field(	u8,	compress		)
+	),
+
+	TP_fast_assign_btrfs(inode->root->fs_info,
+		__entry->root		= inode->root->root_key.objectid;
+		__entry->ino		= btrfs_ino(inode);
+		__entry->start		= start;
+		__entry->len		= len;
+		__entry->extent_thresh	= ctrl->extent_thresh;
+		__entry->newer_than	= ctrl->newer_than;
+		__entry->max_sectors_to_defrag = ctrl->max_sectors_to_defrag;
+		__entry->flags		= ctrl->flags;
+		__entry->compress	= ctrl->compress;
+	),
+
+	TP_printk_btrfs("root=%llu ino=%llu start=%llu len=%llu "
+		"extent_thresh=%u newer_than=%llu flags=0x%x compress=%u "
+		"max_sectors_to_defrag=%llu",
+		__entry->root, __entry->ino, __entry->start, __entry->len,
+		__entry->extent_thresh, __entry->newer_than, __entry->flags,
+		__entry->compress, __entry->max_sectors_to_defrag)
+);
+
+TRACE_EVENT(defrag_file_end,
+
+	TP_PROTO(const struct btrfs_inode *inode,
+		 const struct btrfs_defrag_ctrl *ctrl, int ret),
+
+	TP_ARGS(inode, ctrl, ret),
+
+	TP_STRUCT__entry_btrfs(
+		__field(	u64,	root			)
+		__field(	u64,	ino			)
+		__field(	u64,	sectors_defragged	)
+		__field(	u64,	last_scanned		)
+		__field(	int,	ret			)
+	),
+
+	TP_fast_assign_btrfs(inode->root->fs_info,
+		__entry->root		= inode->root->root_key.objectid;
+		__entry->ino		= btrfs_ino(inode);
+		__entry->sectors_defragged = ctrl->sectors_defragged;
+		__entry->last_scanned	= ctrl->last_scanned;
+		__entry->ret		= ret;
+	),
+
+	TP_printk_btrfs("root=%llu ino=%llu sectors_defragged=%llu "
+		"last_scanned=%llu ret=%d",
+		__entry->root, __entry->ino, __entry->sectors_defragged,
+		__entry->last_scanned, __entry->ret)
+);
+
 #endif /* _TRACE_BTRFS_H */
 
 /* This part must be outside protection */
-- 
2.35.1

