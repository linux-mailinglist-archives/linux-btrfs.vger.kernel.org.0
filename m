Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D98CA6C2FFF
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Mar 2023 12:14:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230389AbjCULOx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 21 Mar 2023 07:14:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230259AbjCULOt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 21 Mar 2023 07:14:49 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91A1224C80
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Mar 2023 04:14:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D37FDB815C2
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Mar 2023 11:14:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C51EC4339C
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Mar 2023 11:14:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679397262;
        bh=sxN2OgHqV+jAvsHFbRd7CbGMbD//bNO1W6W+F0zQ6No=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=Ni/M23cQ5m+gx/Q2BH3pcXu/76rxnJUto1AwE+iOc7F9m6Tw7LaqEEjuuHEh3yDGD
         DTxJi0ZwOWgzj+9I6ajPUilbGUD1UPCGkdwrykMvLLWGWaiCzlsyGznwR/T8tllyNH
         ikwq04MSf7nBVJYI2Yra2Kyug5YwOEkO+3yxcVHKYohu9eJdZfe89KS+LAq4uqh88E
         SpLzF+Wq+ZMEyPCOMy3stkREkU2vJZdM5OYONiKxK3wk404HstioV2Hzhk/g/K/FwV
         wkIiRspETUdHLlRcGEV3v6eBIxWZQlx7StMuELKzj9oHyU6uDKAy+/y72M5DevlcE2
         /x+3n2ZJ/Zxig==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 20/24] btrfs: calculate correct amount of space for delayed reference when evicting
Date:   Tue, 21 Mar 2023 11:13:56 +0000
Message-Id: <485fb4c5b11a2fa22426656d09ca2ab6c96504bd.1679326434.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1679326426.git.fdmanana@suse.com>
References: <cover.1679326426.git.fdmanana@suse.com>
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

When evicting an inode, we are incorrectly calculating the amount of space
required for a single delayed reference in case the free space tree is
enabled. We have to multiply by 2 the result of
btrfs_calc_insert_metadata_size(). We should be calculating according to
the size update and space release of the delayed block reserve logic at
btrfs_update_delayed_refs_rsv() and btrfs_delayed_refs_rsv_release().

Fix this by using the btrfs_calc_delayed_ref_bytes() helper at
evict_refill_and_join() instead of btrfs_calc_insert_metadata_size().

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 912d5f4aafbc..2e181a0a6f37 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -5230,7 +5230,7 @@ static struct btrfs_trans_handle *evict_refill_and_join(struct btrfs_root *root,
 {
 	struct btrfs_fs_info *fs_info = root->fs_info;
 	struct btrfs_trans_handle *trans;
-	u64 delayed_refs_extra = btrfs_calc_insert_metadata_size(fs_info, 1);
+	u64 delayed_refs_extra = btrfs_calc_delayed_ref_bytes(fs_info, 1);
 	int ret;
 
 	/*
-- 
2.34.1

