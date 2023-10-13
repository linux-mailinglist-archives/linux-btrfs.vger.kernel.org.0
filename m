Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CCAD7C84AB
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Oct 2023 13:39:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231567AbjJMLjR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 13 Oct 2023 07:39:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231666AbjJMLiy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 13 Oct 2023 07:38:54 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A177CD47
        for <linux-btrfs@vger.kernel.org>; Fri, 13 Oct 2023 04:38:36 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43F03C433C7
        for <linux-btrfs@vger.kernel.org>; Fri, 13 Oct 2023 11:38:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697197115;
        bh=QvZDJYhVW6OuD/tXcwt6kMy5nbFXDPjbRl4EAV4luH8=;
        h=From:To:Subject:Date:From;
        b=p2Nv7e3G1DSpC2xwOWUmKcXq/HCRRygoMIThV3/6QSqvJw5//Ilpg25rKxCxEjhO+
         Y6hjShGIe2Tgu4eDsjGJrvehQPSYK8l6bzJ2jJHV5jF+JDhYEj3jLYB7w0um91Ww0n
         U0r3RyhbYZ+lg3XiBhWsszYqx55z0ku7rckTk7TswrYSHzaSCP+LBM6xyYrTi0Oiet
         nkxay5ziJgJGJnrDneX3TMQ6gzx9LjxQLttRDRXlL80+Nbzfmjt5OHWlyWtgPQRK/P
         4yyI5u6LMfGzpxnnxh7Jcas4/XPRK9hQfZNCrEnAJfIPlcd9erY2Ot+uYkm57f6j4C
         VL8I1Ll12WI6Q==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: remove duplicate btrfs_clear_buffer_dirty() prototype from disk-io.h
Date:   Fri, 13 Oct 2023 12:38:32 +0100
Message-Id: <603adbf6d55ba4f872bdd7be383fdfb8ecd7bddc.1697196979.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

The prototype for btrfs_clear_buffer_dirty() is declared in both disk-io.h
and extent_io.h, but the function is defined at extent_io.c. So remove the
prototype declaration from disk-io.h.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/disk-io.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/btrfs/disk-io.h b/fs/btrfs/disk-io.h
index 50dab8f639dc..e589359e6a68 100644
--- a/fs/btrfs/disk-io.h
+++ b/fs/btrfs/disk-io.h
@@ -37,8 +37,6 @@ struct extent_buffer *btrfs_find_create_tree_block(
 						struct btrfs_fs_info *fs_info,
 						u64 bytenr, u64 owner_root,
 						int level);
-void btrfs_clear_buffer_dirty(struct btrfs_trans_handle *trans,
-			      struct extent_buffer *buf);
 void btrfs_clear_oneshot_options(struct btrfs_fs_info *fs_info);
 int btrfs_start_pre_rw_mount(struct btrfs_fs_info *fs_info);
 int btrfs_check_super_csum(struct btrfs_fs_info *fs_info,
-- 
2.40.1

