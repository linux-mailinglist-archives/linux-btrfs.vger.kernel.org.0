Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE491714CDD
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 May 2023 17:18:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229785AbjE2PRl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 29 May 2023 11:17:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229767AbjE2PR0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 29 May 2023 11:17:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7A19CF
        for <linux-btrfs@vger.kernel.org>; Mon, 29 May 2023 08:17:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4C6EB615AF
        for <linux-btrfs@vger.kernel.org>; Mon, 29 May 2023 15:17:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38DBCC4339B
        for <linux-btrfs@vger.kernel.org>; Mon, 29 May 2023 15:17:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685373444;
        bh=SmtNh4wkuoLzutOi1oeW7k/3ncP8tpUUbMj64KQBVVg=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=bmVZejTCFJKK5EfyZ+HblWvFaDm87JZTqbUDhpGJGNbTrFhMz3Hqdej8p9TmNSUfk
         dAVGMktOMunS2iVvap/AMU/Yh23DxQpLjfDXKP7kfYAiHWb6e1cdx3LOhLQp9IUQjn
         EMvuGuyu+F/JJv/NvX/3uOIyahgfqYgXgNGshQoO+mj6IkZmPVLqz/4TgQEpBrXs+h
         FNJaWZgMqB196vyMN8jxt++cl4uzFU9CL9vMKSFBcO1TBEBqZREuRHjJr1Evx7Brts
         IoibBcq3vZaD5VXYsBiSM1+D262LoRaX+x42okhaX/iiU4zJ2fo2QenVenwnUAzr2g
         MxUGf85oTLsqQ==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 10/11] btrfs: remove unnecessary prototype declarations at disk-io.c
Date:   Mon, 29 May 2023 16:17:06 +0100
Message-Id: <241c90672d9a483bdab79a442c0d4a809097df37.1685363099.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1685363099.git.fdmanana@suse.com>
References: <cover.1685363099.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

We have a few static functions at disk-io.c for which we have a forward
declaration of their prototype, but it's not needed because all those
functions are defined before they are called, so remove them.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/disk-io.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 793f7e48d62e..fb7ec47f21f1 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -60,15 +60,6 @@
 				 BTRFS_SUPER_FLAG_METADUMP |\
 				 BTRFS_SUPER_FLAG_METADUMP_V2)
 
-static void btrfs_destroy_ordered_extents(struct btrfs_root *root);
-static int btrfs_destroy_delayed_refs(struct btrfs_transaction *trans,
-				      struct btrfs_fs_info *fs_info);
-static void btrfs_destroy_delalloc_inodes(struct btrfs_root *root);
-static int btrfs_destroy_marked_extents(struct btrfs_fs_info *fs_info,
-					struct extent_io_tree *dirty_pages,
-					int mark);
-static int btrfs_destroy_pinned_extent(struct btrfs_fs_info *fs_info,
-				       struct extent_io_tree *pinned_extents);
 static int btrfs_cleanup_transaction(struct btrfs_fs_info *fs_info);
 static void btrfs_error_commit_super(struct btrfs_fs_info *fs_info);
 
-- 
2.34.1

