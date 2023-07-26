Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08519763BCB
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Jul 2023 17:58:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234982AbjGZP6D (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 26 Jul 2023 11:58:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234878AbjGZP5a (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 26 Jul 2023 11:57:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 866122137
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Jul 2023 08:57:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 49FC261B75
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Jul 2023 15:57:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3585EC433C8
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Jul 2023 15:57:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690387048;
        bh=48bl7ut0mASueaRqSiVX59DdtG0D2+ejmOYwNqAsQdk=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=ZxnbL8QiN1kLhkf9oCsvSP2qK1F1msxvweYQilHcJozKY/hdaMra7KVTBVRItKayu
         aw2bb6Iazbe+Qb/ofBJ6FQs/x0f1/oF3yZRvNvk/pYSpGip8zI6GhJba9rCIZySfbg
         +/3Z8mDRXTB45oT30CM6/jRulmwkM6vtKPi/wyeT790CBSJs8/qmPZNSO6jl8wq97z
         MGGvgvilD7RGv0y7PT9gqndsJg/L4gJhNfx45Z/SA/FL8+fPkmXNzpTTTlpY/KivAe
         zYBadwRLQfA+Xr9L8SNYN5/ALhYzQk3DUcczopLEIu384DsOGCJRi78MNq3M24SrJ5
         XQs1aJv+6T0eQ==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 12/17] btrfs: make find_free_dev_extent() static
Date:   Wed, 26 Jul 2023 16:57:08 +0100
Message-Id: <01e3075133547a7e937f3e907218fd33a72528f7.1690383587.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1690383587.git.fdmanana@suse.com>
References: <cover.1690383587.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

The function find_free_dev_extent() is only used within volumes.c, so make
it static and remove its prototype from volumes.h.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/volumes.c | 4 ++--
 fs/btrfs/volumes.h | 2 --
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 9df526c57c3a..e15d02f8520d 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -1725,8 +1725,8 @@ static int find_free_dev_extent_start(struct btrfs_device *device,
 	return ret;
 }
 
-int find_free_dev_extent(struct btrfs_device *device, u64 num_bytes,
-			 u64 *start, u64 *len)
+static int find_free_dev_extent(struct btrfs_device *device, u64 num_bytes,
+				u64 *start, u64 *len)
 {
 	/* FIXME use last free of some kind */
 	return find_free_dev_extent_start(device, num_bytes, 0, start, len);
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index b8c51f16ba86..a59898d51e9e 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -650,8 +650,6 @@ int btrfs_cancel_balance(struct btrfs_fs_info *fs_info);
 int btrfs_create_uuid_tree(struct btrfs_fs_info *fs_info);
 int btrfs_uuid_scan_kthread(void *data);
 bool btrfs_chunk_writeable(struct btrfs_fs_info *fs_info, u64 chunk_offset);
-int find_free_dev_extent(struct btrfs_device *device, u64 num_bytes,
-			 u64 *start, u64 *max_avail);
 void btrfs_dev_stat_inc_and_print(struct btrfs_device *dev, int index);
 int btrfs_get_dev_stats(struct btrfs_fs_info *fs_info,
 			struct btrfs_ioctl_get_dev_stats *stats);
-- 
2.34.1

