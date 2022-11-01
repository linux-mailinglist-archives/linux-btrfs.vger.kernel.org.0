Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C1206152E7
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Nov 2022 21:13:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230111AbiKAUM5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 1 Nov 2022 16:12:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230089AbiKAUMx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 1 Nov 2022 16:12:53 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F4381E72A
        for <linux-btrfs@vger.kernel.org>; Tue,  1 Nov 2022 13:12:50 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 06AD81F38A;
        Tue,  1 Nov 2022 20:12:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1667333569; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=j5pYWBI9PWPdNA1+qYJxhPQbqO79Cm+H2zQct7kOAU8=;
        b=BoHQohDUzcVrKZgtsnfzHo5eq74Q48y1l8RzmpDLVXW7+Mq29xEWMopqsNTUneXE2oh7Pc
        gKlthFSq91uhSkSgEHEkmYcIRlIXnsqVWzpDAymTlNqYQuH8mJUG2iPHR+4vQebl67P89e
        QqTZUevSnunnE1mu7bEvVN7uTOUuz18=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 005682C141;
        Tue,  1 Nov 2022 20:12:48 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 487C3DA79D; Tue,  1 Nov 2022 21:12:32 +0100 (CET)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 24/40] btrfs: pass btrfs_inode to __unlink_start_trans
Date:   Tue,  1 Nov 2022 21:12:32 +0100
Message-Id: <ab249cb5cb16fc34b40ce5a344dd74da36a541cf.1667331828.git.dsterba@suse.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <cover.1667331828.git.dsterba@suse.com>
References: <cover.1667331828.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_SOFTFAIL autolearn=ham
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
 fs/btrfs/inode.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index b0504743613c..3307564c80e7 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -4415,9 +4415,9 @@ int btrfs_unlink_inode(struct btrfs_trans_handle *trans,
  * plenty of slack room in the global reserve to migrate, otherwise we cannot
  * allow the unlink to occur.
  */
-static struct btrfs_trans_handle *__unlink_start_trans(struct inode *dir)
+static struct btrfs_trans_handle *__unlink_start_trans(struct btrfs_inode *dir)
 {
-	struct btrfs_root *root = BTRFS_I(dir)->root;
+	struct btrfs_root *root = dir->root;
 
 	/*
 	 * 1 for the possible orphan item
@@ -4443,7 +4443,7 @@ static int btrfs_unlink(struct inode *dir, struct dentry *dentry)
 
 	/* This needs to handle no-key deletions later on */
 
-	trans = __unlink_start_trans(dir);
+	trans = __unlink_start_trans(BTRFS_I(dir));
 	if (IS_ERR(trans)) {
 		ret = PTR_ERR(trans);
 		goto out;
@@ -4856,7 +4856,7 @@ static int btrfs_rmdir(struct inode *dir, struct dentry *dentry)
 
 	/* This needs to handle no-key deletions later on */
 
-	trans = __unlink_start_trans(dir);
+	trans = __unlink_start_trans(BTRFS_I(dir));
 	if (IS_ERR(trans)) {
 		err = PTR_ERR(trans);
 		goto out_notrans;
-- 
2.37.3

