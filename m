Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAE3D6152D6
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Nov 2022 21:12:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230041AbiKAUM2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 1 Nov 2022 16:12:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230026AbiKAUM1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 1 Nov 2022 16:12:27 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A17981DF34
        for <linux-btrfs@vger.kernel.org>; Tue,  1 Nov 2022 13:12:26 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 5ECA21F8BA;
        Tue,  1 Nov 2022 20:12:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1667333545; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IiYPq20jDH0W5hmkWYlKEZ7h2NUX2oyYY6Xtdlbkz18=;
        b=B3a06rCtJgzzGbCiKAYns8CnAPkpQvnj94mh/OE9D0+q/zvFxJ9bBSOWEsItvj2/jXnbN1
        nefPxiltO6Fn+hAZP8EU8bry1MntfSgiq8FVr7k0PdR7xQsZs0EPo+INEtuY40ZK3MLhVi
        +fh7a7aZm5HcjR/wHXVwDiB7OXojwKA=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 585A82C141;
        Tue,  1 Nov 2022 20:12:25 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id A0A28DA79D; Tue,  1 Nov 2022 21:12:08 +0100 (CET)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 13/40] btrfs: pass btrfs_inode to submit_one_bio
Date:   Tue,  1 Nov 2022 21:12:08 +0100
Message-Id: <b78b3b92f78439fdbe191ec2062ad3f813c1c968.1667331828.git.dsterba@suse.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <cover.1667331828.git.dsterba@suse.com>
References: <cover.1667331828.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The function is for internal interfaces so we should use the
btrfs_inode.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/extent_io.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index bddda397e438..192f604ac7ea 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -117,7 +117,7 @@ static void submit_one_bio(struct btrfs_bio_ctrl *bio_ctrl)
 {
 	struct bio *bio;
 	struct bio_vec *bv;
-	struct inode *inode;
+	struct btrfs_inode *inode;
 	int mirror_num;
 
 	if (!bio_ctrl->bio)
@@ -125,7 +125,7 @@ static void submit_one_bio(struct btrfs_bio_ctrl *bio_ctrl)
 
 	bio = bio_ctrl->bio;
 	bv = bio_first_bvec_all(bio);
-	inode = bv->bv_page->mapping->host;
+	inode = BTRFS_I(bv->bv_page->mapping->host);
 	mirror_num = bio_ctrl->mirror_num;
 
 	/* Caller should ensure the bio has at least some range added */
@@ -133,12 +133,12 @@ static void submit_one_bio(struct btrfs_bio_ctrl *bio_ctrl)
 
 	btrfs_bio(bio)->file_offset = page_offset(bv->bv_page) + bv->bv_offset;
 
-	if (!is_data_inode(inode))
-		btrfs_submit_metadata_bio(BTRFS_I(inode), bio, mirror_num);
+	if (!is_data_inode(&inode->vfs_inode))
+		btrfs_submit_metadata_bio(inode, bio, mirror_num);
 	else if (btrfs_op(bio) == BTRFS_MAP_WRITE)
-		btrfs_submit_data_write_bio(BTRFS_I(inode), bio, mirror_num);
+		btrfs_submit_data_write_bio(inode, bio, mirror_num);
 	else
-		btrfs_submit_data_read_bio(BTRFS_I(inode), bio, mirror_num,
+		btrfs_submit_data_read_bio(inode, bio, mirror_num,
 					   bio_ctrl->compress_type);
 
 	/* The bio is owned by the end_io handler now */
-- 
2.37.3

