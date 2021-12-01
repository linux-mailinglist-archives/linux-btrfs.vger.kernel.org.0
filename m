Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7384246533B
	for <lists+linux-btrfs@lfdr.de>; Wed,  1 Dec 2021 17:45:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351562AbhLAQs4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 1 Dec 2021 11:48:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351539AbhLAQsl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 1 Dec 2021 11:48:41 -0500
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D711CC061761
        for <linux-btrfs@vger.kernel.org>; Wed,  1 Dec 2021 08:45:14 -0800 (PST)
Received: by mail-qt1-x829.google.com with SMTP id v22so24645376qtx.8
        for <linux-btrfs@vger.kernel.org>; Wed, 01 Dec 2021 08:45:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=nsdA7YeRg5Nte7VR2mSPwalK16B3wNzKmBI4V9MpiZ4=;
        b=fo7xZXJYzRROOv3/TECbXaOV4nPdkiSUyjiNUoxEstO74dpDbaClSie1QhWeneNFKB
         HEShHDhncLKmmHJih4ZnVMSQr735/N/3PI34rfyZXhugpkEHnuOCsGzRYEhL+1EDIP9U
         0gXzwSwVCqlkav9rQ+gLaUVoeEWpn6fgTKQplysAMEX7TsA6JR0uLwm4AQRG1Wg9dIo5
         3hlqkTlXpJy1z23bazsbIVrwE5TJWkril9HxIn9qb1n3nA/wXetiM9SVGslniwkoIkCR
         OaoDmBI0w7F0OUdlA/0qV45b5FhYRroe+5eaOD+EhhwsYk8/AQpwffhARuLCQ67l3PBS
         0lCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nsdA7YeRg5Nte7VR2mSPwalK16B3wNzKmBI4V9MpiZ4=;
        b=T+n7yvAmX4JL9/tqjU+ea3BnEsI8Dvvx1x4yx62Ld3VWslQaI8buoBWkgF02+7SupG
         i/6zjgVRcbOb0AUD8PvUmlp5RBV/htViZFYcN2E2bsxy3XcrFk7Pzxlal/W+PrELf3ke
         M4eS91PAYdZFxotxjrLqMrhFGk8ImamVSiXnAs82R7eB2DBllU8ilmY0MTRFrWMww3Ph
         GG3iOunmKAlz8i1HT+joZ3A4X3ArAtwRImSc2JPTp4ob3LkenE+sf7S+psEJFEkpNNI3
         HpH952DjNcQgzgdqQalc6oPgSZ9iy+9PNYUhz1erdlfdzo4zcqjrJf8SdfADxxvoV9p7
         IAsQ==
X-Gm-Message-State: AOAM533mWlfuja1BeshkDnO2y2JqEyIcIjVErXiM3E4YXW7ElXn5Thw+
        OUm2Kizqvc+Afeu4yRTZmVZicQTfyJdArQ==
X-Google-Smtp-Source: ABdhPJwx7x/DiC2T6sf0RTEEQNAulM0y+yJqcSOMLOpGsrqriObCg6++XCEZwzLoqPcIDZT0bFQm9A==
X-Received: by 2002:a05:622a:1746:: with SMTP id l6mr8063947qtk.216.1638377113645;
        Wed, 01 Dec 2021 08:45:13 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id w10sm130561qkp.121.2021.12.01.08.45.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Dec 2021 08:45:13 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 2/2] btrfs: reserve extra space for the free space tree
Date:   Wed,  1 Dec 2021 11:45:09 -0500
Message-Id: <aab24f138d49b8d331a359b66029bb61f12fd44c.1638377089.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1638377089.git.josef@toxicpanda.com>
References: <cover.1638377089.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Filipe reported a problem where sometimes he'd get an ENOSPC abort when
running delayed refs with generic/619 and the free space tree enabled.
This is partly because we do not reserve space for modifying the free
space tree, nor do we have a block rsv associated with that tree.  Fix
this by making sure any free space tree defaults to using the
delayed_refs_rsv, and make sure we reserve the space for those
allocations.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/block-rsv.c   |  1 +
 fs/btrfs/delayed-ref.c | 22 ++++++++++++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/fs/btrfs/block-rsv.c b/fs/btrfs/block-rsv.c
index b3086f252ad0..b3ee49b0b1e8 100644
--- a/fs/btrfs/block-rsv.c
+++ b/fs/btrfs/block-rsv.c
@@ -426,6 +426,7 @@ void btrfs_init_root_block_rsv(struct btrfs_root *root)
 	switch (root->root_key.objectid) {
 	case BTRFS_CSUM_TREE_OBJECTID:
 	case BTRFS_EXTENT_TREE_OBJECTID:
+	case BTRFS_FREE_SPACE_TREE_OBJECTID:
 		root->block_rsv = &fs_info->delayed_refs_rsv;
 		break;
 	case BTRFS_ROOT_TREE_OBJECTID:
diff --git a/fs/btrfs/delayed-ref.c b/fs/btrfs/delayed-ref.c
index da9d20813147..533521be8fdf 100644
--- a/fs/btrfs/delayed-ref.c
+++ b/fs/btrfs/delayed-ref.c
@@ -84,6 +84,17 @@ void btrfs_delayed_refs_rsv_release(struct btrfs_fs_info *fs_info, int nr)
 	u64 num_bytes = btrfs_calc_insert_metadata_size(fs_info, nr);
 	u64 released = 0;
 
+	/*
+	 * We have to check the mount option here because we could be enabling
+	 * the free space tree for the first time and don't have the compat_ro
+	 * option set yet.
+	 *
+	 * We need extra reservations if we have the free space tree because
+	 * we'll have to modify that tree as well.
+	 */
+	if (btrfs_test_opt(fs_info, FREE_SPACE_TREE))
+		num_bytes <<= 1;
+
 	released = btrfs_block_rsv_release(fs_info, block_rsv, num_bytes, NULL);
 	if (released)
 		trace_btrfs_space_reservation(fs_info, "delayed_refs_rsv",
@@ -108,6 +119,17 @@ void btrfs_update_delayed_refs_rsv(struct btrfs_trans_handle *trans)
 
 	num_bytes = btrfs_calc_insert_metadata_size(fs_info,
 						    trans->delayed_ref_updates);
+	/*
+	 * We have to check the mount option here because we could be enabling
+	 * the free space tree for the first time and don't have the compat_ro
+	 * option set yet.
+	 *
+	 * We need extra reservations if we have the free space tree because
+	 * we'll have to modify that tree as well.
+	 */
+	if (btrfs_test_opt(fs_info, FREE_SPACE_TREE))
+		num_bytes <<= 1;
+
 	spin_lock(&delayed_rsv->lock);
 	delayed_rsv->size += num_bytes;
 	delayed_rsv->full = 0;
-- 
2.26.3

