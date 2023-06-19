Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A0B573496B
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 Jun 2023 02:14:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229487AbjFSAMB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 18 Jun 2023 20:12:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjFSAMA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 18 Jun 2023 20:12:00 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C168B116
        for <linux-btrfs@vger.kernel.org>; Sun, 18 Jun 2023 17:11:58 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 0F2441F855;
        Mon, 19 Jun 2023 00:11:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1687133516; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=kEC/d47V6qyJBoS//i53wyYK7qsgNyGDtaI+f3pIWaY=;
        b=P374atvzcEghMFvBTkKG0m4ki2uyZGYnn2HmaKesV3bPKjZgG/L+6P4ROSQlzelN/iI+5f
        71Z9wV2aK26/8rxouCR0glS7V4guszQDsvZe0JZ6s4lzZ/EHEmgR2T61nkWy5xA1uteEFs
        H0gUivVTMmjNx7WYf5waBkOzQ08HUEw=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1CADF133A9;
        Mon, 19 Jun 2023 00:11:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id xklRNEqdj2SocAAAMHmgww
        (envelope-from <wqu@suse.com>); Mon, 19 Jun 2023 00:11:54 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     dsterba@suse.com
Subject: [PATCH] btrfs: add trace events for bio split at storage layer
Date:   Mon, 19 Jun 2023 08:11:37 +0800
Message-ID: <dd9a8794a1da2a4f3e7c47cc4df42ef972568ce4.1687133480.git.wqu@suse.com>
X-Mailer: git-send-email 2.41.0
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

[BACKGROUND]
David recently reported some weird RAID56 errors where huge btrfs bio
(tens of MiBs) is directly passed to RAID56 path, without proper bio
split.

To my surprise, there is no trace events around the bio split code of
storage layer.

[NEW TRACE EVENTS]
This patch would add 3 new trace events:

- trace_initial_bbio()
- trace_before_split_bbio()
- trace_after_split_bbio()

The example output would look like the following (headers and uuid
removed):

    initial_bbio: root=5 ino=257 logical=389152768 length=524288 opf=0x1 mirror_num=0 map_length=-1
    before_split_bbio: root=5 ino=257 logical=389152768 length=524288 opf=0x1 mirror_num=0 map_length=131072
    after_split_bbio: root=5 ino=257 logical=389152768 length=131072 opf=0x1 mirror_num=0 map_length=131072
    before_split_bbio: root=5 ino=257 logical=389283840 length=393216 opf=0x1 mirror_num=0 map_length=131072
    after_split_bbio: root=5 ino=257 logical=389283840 length=131072 opf=0x1 mirror_num=0 map_length=131072
    before_split_bbio: root=5 ino=257 logical=389414912 length=262144 opf=0x1 mirror_num=0 map_length=131072
    after_split_bbio: root=5 ino=257 logical=389414912 length=131072 opf=0x1 mirror_num=0 map_length=131072
    before_split_bbio: root=5 ino=257 logical=389545984 length=131072 opf=0x1 mirror_num=0 map_length=131072

The above lines show a 512K bbio submitted, then it got split by each
128K boundary (this is a 3 disks RAID5).

    initial_bbio: root=1 ino=1 logical=30441472 length=16384 opf=0x1 mirror_num=0 map_length=-1
    before_split_bbio: root=1 ino=1 logical=30441472 length=16384 opf=0x1 mirror_num=0 map_length=16384
    initial_bbio: root=1 ino=1 logical=30457856 length=16384 opf=0x1 mirror_num=0 map_length=-1
    before_split_bbio: root=1 ino=1 logical=30457856 length=16384 opf=0x1 mirror_num=0 map_length=16384

And the above lines are metadata writes which didn't need to be split at
all.

These new events should allow us to debug bio split related problems
easier.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/bio.c               |  4 +++
 include/trace/events/btrfs.h | 51 ++++++++++++++++++++++++++++++++++++
 2 files changed, 55 insertions(+)

diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
index 12b12443efaa..204c30391086 100644
--- a/fs/btrfs/bio.c
+++ b/fs/btrfs/bio.c
@@ -669,9 +669,12 @@ static bool btrfs_submit_chunk(struct btrfs_bio *bbio, int mirror_num)
 	if (use_append)
 		map_length = min(map_length, fs_info->max_zone_append_size);
 
+	trace_before_split_bbio(bbio, mirror_num, map_length);
+
 	if (map_length < length) {
 		bbio = btrfs_split_bio(fs_info, bbio, map_length, use_append);
 		bio = &bbio->bio;
+		trace_after_split_bbio(bbio, mirror_num, map_length);
 	}
 
 	/*
@@ -731,6 +734,7 @@ void btrfs_submit_bio(struct btrfs_bio *bbio, int mirror_num)
 	/* If bbio->inode is not populated, its file_offset must be 0. */
 	ASSERT(bbio->inode || bbio->file_offset == 0);
 
+	trace_initial_bbio(bbio, mirror_num, -1);
 	while (!btrfs_submit_chunk(bbio, mirror_num))
 		;
 }
diff --git a/include/trace/events/btrfs.h b/include/trace/events/btrfs.h
index c6eee9b414cf..1e6d87abd677 100644
--- a/include/trace/events/btrfs.h
+++ b/include/trace/events/btrfs.h
@@ -31,6 +31,7 @@ struct extent_io_tree;
 struct prelim_ref;
 struct btrfs_space_info;
 struct btrfs_raid_bio;
+struct btrfs_bio;
 struct raid56_bio_trace_info;
 struct find_free_extent_ctl;
 
@@ -2521,6 +2522,56 @@ DEFINE_EVENT(btrfs_raid56_bio, raid56_scrub_read_recover,
 	TP_ARGS(rbio, bio, trace_info)
 );
 
+DECLARE_EVENT_CLASS(btrfs_bio,
+
+	TP_PROTO(const struct btrfs_bio *bbio, int mirror_num, u64 map_length),
+
+	TP_ARGS(bbio, mirror_num, map_length),
+
+	TP_STRUCT__entry_btrfs(
+		__field(	u64,	logical		)
+		__field(	u64,	root		)
+		__field(	u64,	ino		)
+		__field(	s64,	map_length	)
+		__field(	u32,	length		)
+		__field(	int,	mirror_num	)
+		__field(	u8,	opf		)
+	),
+
+	TP_fast_assign_btrfs(bbio->fs_info,
+		__entry->logical	= bbio->bio.bi_iter.bi_sector << SECTOR_SHIFT;
+		__entry->length		= bbio->bio.bi_iter.bi_size;
+		__entry->map_length	= map_length;
+		__entry->mirror_num	= mirror_num;
+		__entry->opf		= bio_op(&bbio->bio);
+		__entry->root		= bbio->inode ?
+					  bbio->inode->root->root_key.objectid : 0;
+		__entry->ino		= bbio->inode ? btrfs_ino(bbio->inode) : 0;
+	),
+	TP_printk_btrfs(
+"root=%lld ino=%llu logical=%llu length=%u opf=0x%x mirror_num=%d map_length=%lld",
+		__entry->root, __entry->ino,
+		__entry->logical, __entry->length, __entry->opf,
+		__entry->mirror_num, __entry->map_length)
+);
+
+DEFINE_EVENT(btrfs_bio, initial_bbio,
+	TP_PROTO(const struct btrfs_bio *bbio, int mirror_num, u64 map_length),
+
+	TP_ARGS(bbio, mirror_num, map_length)
+);
+
+DEFINE_EVENT(btrfs_bio, before_split_bbio,
+	TP_PROTO(const struct btrfs_bio *bbio, int mirror_num, u64 map_length),
+
+	TP_ARGS(bbio, mirror_num, map_length)
+);
+
+DEFINE_EVENT(btrfs_bio, after_split_bbio,
+	TP_PROTO(const struct btrfs_bio *bbio, int mirror_num, u64 map_length),
+
+	TP_ARGS(bbio, mirror_num, map_length)
+);
 #endif /* _TRACE_BTRFS_H */
 
 /* This part must be outside protection */
-- 
2.41.0

