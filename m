Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A420D4F4512
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Apr 2022 00:39:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237023AbiDEPEW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 5 Apr 2022 11:04:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1392014AbiDENt3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 5 Apr 2022 09:49:29 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70A69BC3F
        for <linux-btrfs@vger.kernel.org>; Tue,  5 Apr 2022 05:48:57 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 0FD8A1F856
        for <linux-btrfs@vger.kernel.org>; Tue,  5 Apr 2022 12:48:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1649162936; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=d4thcWRSwsL+mYuw3xcpfOwu8MFFsl1DOQ5FrmcN5GE=;
        b=ji3ktHYAA2up0V5x/ucKDH0OHGViLou4fR3fvBFReOTAJXdJpR+2H/bHz1gnKWxf3nBA4M
        dUuwZ51hIetmGs81/ehI98+hcGgTZ587AyBBHzT8ehFBgDRlFzsBC7acX6GSP8asHBb8Gn
        PstwxKZ9+n9qqhDOBhgJWI88zV/Y0ts=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 641F613A04
        for <linux-btrfs@vger.kernel.org>; Tue,  5 Apr 2022 12:48:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id qPefC7c6TGJLGgAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Tue, 05 Apr 2022 12:48:55 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 6/8] btrfs-progs: remove extent_buffer::fd and extent_buffer::dev_bytes
Date:   Tue,  5 Apr 2022 20:48:28 +0800
Message-Id: <0fd76db333976b6ded293f89629751abf87752d1.1649162174.git.wqu@suse.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1649162174.git.wqu@suse.com>
References: <cover.1649162174.git.wqu@suse.com>
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

Those two members are a shortcut for non-RAID56 profiles.

But we should not use such shortcut, and move all our logical address
read/write to the unified read_data_from_disk()/write_data_to_disk().

With previous refactors, now we're safe to remove them.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 btrfs-corrupt-block.c     |  5 ++---
 kernel-shared/ctree.c     |  5 ++---
 kernel-shared/extent_io.c |  2 --
 kernel-shared/extent_io.h |  2 --
 kernel-shared/volumes.c   | 12 +++---------
 5 files changed, 7 insertions(+), 19 deletions(-)

diff --git a/btrfs-corrupt-block.c b/btrfs-corrupt-block.c
index 92d608e6b9c0..b17e0bf8e1c9 100644
--- a/btrfs-corrupt-block.c
+++ b/btrfs-corrupt-block.c
@@ -55,7 +55,7 @@ static int debug_corrupt_block(struct extent_buffer *eb,
 			if (ret < 0) {
 				errno = -ret;
 				error("cannot read eb bytenr %llu: %m",
-					eb->dev_bytenr);
+					eb->start);
 				return ret;
 			}
 			printf("corrupting %llu copy %d\n", eb->start,
@@ -65,10 +65,9 @@ static int debug_corrupt_block(struct extent_buffer *eb,
 			if (ret < 0) {
 				errno = -ret;
 				error("cannot write eb bytenr %llu: %m",
-					eb->dev_bytenr);
+					eb->start);
 				return ret;
 			}
-			fsync(eb->fd);
 		}
 
 		num_copies = btrfs_num_copies(root->fs_info, eb->start,
diff --git a/kernel-shared/ctree.c b/kernel-shared/ctree.c
index 42bbd50d86a1..ecc37a42eecc 100644
--- a/kernel-shared/ctree.c
+++ b/kernel-shared/ctree.c
@@ -590,10 +590,9 @@ static void generic_err(const struct extent_buffer *buf, int slot,
 {
 	va_list args;
 
-	fprintf(stderr, "corrupt %s: root=%lld block=%llu physical=%llu slot=%d, ",
+	fprintf(stderr, "corrupt %s: root=%lld block=%llu slot=%d, ",
 		btrfs_header_level(buf) == 0 ? "leaf": "node",
-		btrfs_header_owner(buf), btrfs_header_bytenr(buf),
-		buf->dev_bytenr, slot);
+		btrfs_header_owner(buf), btrfs_header_bytenr(buf), slot);
 	va_start(args, fmt);
 	vfprintf(stderr, fmt, args);
 	va_end(args);
diff --git a/kernel-shared/extent_io.c b/kernel-shared/extent_io.c
index c8bb30f62c2d..b8ded5cf7373 100644
--- a/kernel-shared/extent_io.c
+++ b/kernel-shared/extent_io.c
@@ -616,8 +616,6 @@ static struct extent_buffer *__alloc_extent_buffer(struct btrfs_fs_info *info,
 	eb->len = blocksize;
 	eb->refs = 1;
 	eb->flags = 0;
-	eb->fd = -1;
-	eb->dev_bytenr = (u64)-1;
 	eb->cache_node.start = bytenr;
 	eb->cache_node.size = blocksize;
 	eb->fs_info = info;
diff --git a/kernel-shared/extent_io.h b/kernel-shared/extent_io.h
index cd5e893b165a..aa4f34e187ba 100644
--- a/kernel-shared/extent_io.h
+++ b/kernel-shared/extent_io.h
@@ -88,13 +88,11 @@ struct extent_state {
 struct extent_buffer {
 	struct cache_extent cache_node;
 	u64 start;
-	u64 dev_bytenr;
 	struct list_head lru;
 	struct list_head recow;
 	u32 len;
 	int refs;
 	u32 flags;
-	int fd;
 	struct btrfs_fs_info *fs_info;
 	char data[] __attribute__((aligned(8)));
 };
diff --git a/kernel-shared/volumes.c b/kernel-shared/volumes.c
index 7d1e7ea00903..cb49609cc60c 100644
--- a/kernel-shared/volumes.c
+++ b/kernel-shared/volumes.c
@@ -2620,8 +2620,6 @@ static int split_eb_for_raid56(struct btrfs_fs_info *info,
 		eb->len = stripe_len;
 		eb->refs = 1;
 		eb->flags = 0;
-		eb->fd = -1;
-		eb->dev_bytenr = (u64)-1;
 		eb->fs_info = info;
 
 		this_eb_start = raid_map[i];
@@ -2676,9 +2674,6 @@ int write_raid56_with_parity(struct btrfs_fs_info *info,
 	for (i = 0; i < multi->num_stripes; i++) {
 		struct extent_buffer *new_eb;
 		if (raid_map[i] < BTRFS_RAID5_P_STRIPE) {
-			ebs[i]->dev_bytenr = multi->stripes[i].physical;
-			ebs[i]->fd = multi->stripes[i].dev->fd;
-			multi->stripes[i].dev->total_ios++;
 			if (ebs[i]->start != raid_map[i]) {
 				ret = -EINVAL;
 				goto out_free_split;
@@ -2690,8 +2685,6 @@ int write_raid56_with_parity(struct btrfs_fs_info *info,
 			ret = -ENOMEM;
 			goto out_free_split;
 		}
-		new_eb->dev_bytenr = multi->stripes[i].physical;
-		new_eb->fd = multi->stripes[i].dev->fd;
 		multi->stripes[i].dev->total_ios++;
 		new_eb->len = stripe_len;
 		new_eb->fs_info = info;
@@ -2720,8 +2713,9 @@ int write_raid56_with_parity(struct btrfs_fs_info *info,
 	}
 
 	for (i = 0; i < multi->num_stripes; i++) {
-		ret = btrfs_pwrite(ebs[i]->fd, ebs[i]->data, ebs[i]->len,
-				   ebs[i]->dev_bytenr, info->zoned);
+		multi->stripes[i].dev->total_ios++;
+		ret = btrfs_pwrite(multi->stripes[i].dev->fd, ebs[i]->data, ebs[i]->len,
+				   multi->stripes[i].physical, info->zoned);
 		if (ret < 0)
 			goto out_free_split;
 	}
-- 
2.35.1

