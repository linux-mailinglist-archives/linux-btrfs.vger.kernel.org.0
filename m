Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A67C7AAFA7
	for <lists+linux-btrfs@lfdr.de>; Fri, 22 Sep 2023 12:38:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233380AbjIVKhr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 22 Sep 2023 06:37:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233360AbjIVKhj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 22 Sep 2023 06:37:39 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2CDF180
        for <linux-btrfs@vger.kernel.org>; Fri, 22 Sep 2023 03:37:32 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1C38C433CA
        for <linux-btrfs@vger.kernel.org>; Fri, 22 Sep 2023 10:37:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695379052;
        bh=4yzHn+H4coxQ7pJvHFrIwhY2XlutsNk7ePQVuM0Vaic=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=PMwj8VjAGZcZavdKyML3q49p8cO1GOmRGAJomfkDIa6nGniNSA/f31PaTthr3oant
         GCy/q+f689c4gqohB7dXy8devqFi+nhGxZOXIjERNe4oHdIplQT09BMN4fys+norBI
         ZesOCI3enQALmyIYYXC2Awy4ucl8Wd/ccn0TMlhT1ynQshrmHDuSG0gd6sBi7Zn2r/
         0hXhQgB37cNv2sIwP0Hf4t2Lm+nlGOnCb0yB2SQ5ncahNTEduiiFu9IiMt8LAVc4EN
         TkLgRi00c5rOjLbagPyGHPwYS/zpWXqhaGop5xiHyapJbMqEaJE+26jdwba1iSavg9
         j+YxwkHVpwlUg==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 2/8] btrfs: remove noline from btrfs_update_inode()
Date:   Fri, 22 Sep 2023 11:37:20 +0100
Message-Id: <dcf9aac4d009439f8becedb0d50b6f2702c0897f.1695333082.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1695333082.git.fdmanana@suse.com>
References: <cover.1695333082.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

The noinline attribute of btrfs_update_inode() is pointless as the
function is exported and widely used, so remove it.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/inode.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index f16dfeabeaf0..fb7d7d0077f0 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -4001,9 +4001,9 @@ static noinline int btrfs_update_inode_item(struct btrfs_trans_handle *trans,
 /*
  * copy everything in the in-memory inode into the btree.
  */
-noinline int btrfs_update_inode(struct btrfs_trans_handle *trans,
-				struct btrfs_root *root,
-				struct btrfs_inode *inode)
+int btrfs_update_inode(struct btrfs_trans_handle *trans,
+		       struct btrfs_root *root,
+		       struct btrfs_inode *inode)
 {
 	struct btrfs_fs_info *fs_info = root->fs_info;
 	int ret;
-- 
2.40.1

