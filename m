Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6C285153BD
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 Apr 2022 20:32:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380023AbiD2SfL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 29 Apr 2022 14:35:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380027AbiD2SfK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 29 Apr 2022 14:35:10 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D141C6ED8
        for <linux-btrfs@vger.kernel.org>; Fri, 29 Apr 2022 11:31:50 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id ABD571F893;
        Fri, 29 Apr 2022 18:31:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1651257109; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=q+T3S+y3i/5khe8AeuUbGIemPT+EOQIwQ2KtAhK/gLU=;
        b=QwDl+LI7cr+dk19qa+spMRUHyaGZ/S64fa6DKINkBYMj5ynqsdea4aXo6OY1/3rUyYNfu5
        PUZQhMIDxAOeN/SEhw6ScxytKY4ENZIfNEfue9yoOA0fxneS+aoT5IDCN8C+TIo5DCv8aS
        JFc+xrKwaxLxDf394GX9OUNQBgZpRow=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id A477F2C143;
        Fri, 29 Apr 2022 18:31:49 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 09D3ADA7DE; Fri, 29 Apr 2022 20:27:42 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 7/9] btrfs: rename io_failure_record::bio_flags to compress_type
Date:   Fri, 29 Apr 2022 20:27:41 +0200
Message-Id: <54b867c85b5891611c1a8f5a412abb06bbe5db61.1651255990.git.dsterba@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1651255990.git.dsterba@suse.com>
References: <cover.1651255990.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The bio_flags is now used to store unchanged compress type, so unify
that.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/extent_io.c | 6 +++---
 fs/btrfs/extent_io.h | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 3d5cc5769350..ca3d4a6a3b10 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2538,7 +2538,7 @@ static struct io_failure_record *btrfs_get_io_failure_record(struct inode *inode
 	failrec->start = start;
 	failrec->len = sectorsize;
 	failrec->this_mirror = 0;
-	failrec->bio_flags = 0;
+	failrec->compress_type = BTRFS_COMPRESS_NONE;
 
 	read_lock(&em_tree->lock);
 	em = lookup_extent_mapping(em_tree, start, failrec->len);
@@ -2562,7 +2562,7 @@ static struct io_failure_record *btrfs_get_io_failure_record(struct inode *inode
 	logical = em->block_start + logical;
 	if (test_bit(EXTENT_FLAG_COMPRESSED, &em->flags)) {
 		logical = em->block_start;
-		failrec->bio_flags = em->compress_type;
+		failrec->compress_type = em->compress_type;
 	}
 
 	btrfs_debug(fs_info,
@@ -2694,7 +2694,7 @@ int btrfs_repair_one_sector(struct inode *inode,
 	 * will be handled by the endio on the repair_bio, so we can't return an
 	 * error here.
 	 */
-	submit_bio_hook(inode, repair_bio, failrec->this_mirror, failrec->bio_flags);
+	submit_bio_hook(inode, repair_bio, failrec->this_mirror, failrec->compress_type);
 	return BLK_STS_OK;
 }
 
diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
index fdbfe801dbe2..1fa40ab561df 100644
--- a/fs/btrfs/extent_io.h
+++ b/fs/btrfs/extent_io.h
@@ -266,7 +266,7 @@ struct io_failure_record {
 	u64 start;
 	u64 len;
 	u64 logical;
-	unsigned long bio_flags;
+	unsigned int compress_type;
 	int this_mirror;
 	int failed_mirror;
 };
-- 
2.34.1

