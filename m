Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A111F5153BA
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 Apr 2022 20:32:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380026AbiD2SfJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 29 Apr 2022 14:35:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380019AbiD2SfH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 29 Apr 2022 14:35:07 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCFEDA27E6
        for <linux-btrfs@vger.kernel.org>; Fri, 29 Apr 2022 11:31:48 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 85FB221877;
        Fri, 29 Apr 2022 18:31:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1651257107; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aKBvd/f5vpbg2oLIbcvmoXoFhS10XFAKfLbjyTNcC18=;
        b=M+Xr4Su8HEipeevJf57/aWyp/iFHp2o8P9HHb6a09F9f1+FT65XxKsuBIBetpVXNOJSFf9
        L0QB9Y5HjbhaygyRb4xw2lcQGY+pDgrcmWi11YzUcFm08NrjwRoSjGAjmrHEbs92V0lVMd
        z6jkHk8XwHf+z7XHLVX2IeIr0MfIZ70=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 7E5C92C141;
        Fri, 29 Apr 2022 18:31:47 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id DD873DA7DE; Fri, 29 Apr 2022 20:27:39 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 6/9] btrfs: open code extent_set_compress_type helpers
Date:   Fri, 29 Apr 2022 20:27:39 +0200
Message-Id: <fafc7bad921737290f418866b119ea7e2c727edf.1651255990.git.dsterba@suse.com>
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

The helpers extent_set_compress_type and extent_compress_type have
become trivial after previous cleanups and can be removed.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/extent_io.c |  8 +++-----
 fs/btrfs/extent_io.h | 11 -----------
 2 files changed, 3 insertions(+), 16 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index efea465d0e9b..3d5cc5769350 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2562,7 +2562,7 @@ static struct io_failure_record *btrfs_get_io_failure_record(struct inode *inode
 	logical = em->block_start + logical;
 	if (test_bit(EXTENT_FLAG_COMPRESSED, &em->flags)) {
 		logical = em->block_start;
-		extent_set_compress_type(&failrec->bio_flags, em->compress_type);
+		failrec->bio_flags = em->compress_type;
 	}
 
 	btrfs_debug(fs_info,
@@ -3681,10 +3681,8 @@ static int btrfs_do_readpage(struct page *page, struct extent_map **em_cached,
 		BUG_ON(extent_map_end(em) <= cur);
 		BUG_ON(end < cur);
 
-		if (test_bit(EXTENT_FLAG_COMPRESSED, &em->flags)) {
-			extent_set_compress_type(&this_bio_flag,
-						 em->compress_type);
-		}
+		if (test_bit(EXTENT_FLAG_COMPRESSED, &em->flags))
+			this_bio_flag = em->compress_type;
 
 		iosize = min(extent_map_end(em) - cur, end - cur + 1);
 		cur_end = min(extent_map_end(em) - 1, end);
diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
index ba793cb7a3a2..fdbfe801dbe2 100644
--- a/fs/btrfs/extent_io.h
+++ b/fs/btrfs/extent_io.h
@@ -140,17 +140,6 @@ static inline void extent_changeset_free(struct extent_changeset *changeset)
 	kfree(changeset);
 }
 
-static inline void extent_set_compress_type(unsigned long *bio_flags,
-					    int compress_type)
-{
-	*bio_flags = compress_type;
-}
-
-static inline int extent_compress_type(unsigned long bio_flags)
-{
-	return bio_flags;
-}
-
 struct extent_map_tree;
 
 typedef struct extent_map *(get_extent_t)(struct btrfs_inode *inode,
-- 
2.34.1

