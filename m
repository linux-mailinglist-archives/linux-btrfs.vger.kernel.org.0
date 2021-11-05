Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C49F44469D6
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Nov 2021 21:41:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233498AbhKEUnj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 5 Nov 2021 16:43:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233425AbhKEUni (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 5 Nov 2021 16:43:38 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7486CC061714
        for <linux-btrfs@vger.kernel.org>; Fri,  5 Nov 2021 13:40:58 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id g25so8025095qvf.13
        for <linux-btrfs@vger.kernel.org>; Fri, 05 Nov 2021 13:40:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=zXWlqsbvJdBA7V1RQ7p0gyG+qJq1hALP23Ng+qoqb4c=;
        b=I5JuZoD4fCGaqRiOjEfYn9PHP9jn616z8pbtiotgoDfAcwQvk0wSu5gwOtv28bLHcL
         gboKti0TD9aBCkqekBzE4WBY0liplfo7+f8PSWidhizMhLRRa2UIJauSQKWtMNBaFjHm
         eIJL02RcT1Q2PzAPlDssVw8lHTi45QH92Ewa5S0fiK7t3TAKDpBFUbkW85vn1+YrlFcG
         qsRu1cpRWOEB3KRLG7O2AovG9XVihSpTaSgN43P+xfBfND38ohtq0WRiR7Q1otigx9ER
         Ah6JcOe9yAF/1T+18Y+23WEpifEdM2XL2nGpnZNrOXLudQCHyTVx+dH/i9/2yln2u1cS
         y1IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zXWlqsbvJdBA7V1RQ7p0gyG+qJq1hALP23Ng+qoqb4c=;
        b=UUkqptruoV0P9rgPcynBoiNGjB9ehdUZuqE2i/6pimo9ifIo3yy0HOYjTqI5wKNkZN
         chFPjed8iZJrDDu413Mx5YC34xiHaCJZOcym0hdmeQmEvDmZqnuvbzv42/2fKCmp1TTV
         gSIVP+BJXz6zFbuIFhkAd+SDkMoTwQrFoKdG3jxHt2S5ZTi//3SUO8Dp8WkXUuD3XPxa
         RFnZdwMREeAwzB2+czLjQ9wViiQCAo1GZfiqCBGlfstsMKAL7lF4uCGrdIiRtkNoNQAf
         wSnrRktOAq6D3JXCKWP8S8Yiic0yQIYLSyIoIGFs9dDjH1v7ih426QOLKvnSZ8T5ay4u
         M5yg==
X-Gm-Message-State: AOAM530G1AqeeGnYoHA4GMjAW0OHZnbuh0JetXUCnDzp1QTxsMgA39zE
        d7+h1pummHJV66BDW68TKWKtDEMF3POw4Q==
X-Google-Smtp-Source: ABdhPJwgS4YSbk2tJ8JLIDSMOsTaQr3zAdfAfBnSDXcLEh4pxmjUV5l9Mu25EcxIFdiYvoDIiVpbTA==
X-Received: by 2002:a05:6214:1c4a:: with SMTP id if10mr45175783qvb.13.1636144857386;
        Fri, 05 Nov 2021 13:40:57 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id az14sm5899352qkb.125.2021.11.05.13.40.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Nov 2021 13:40:57 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 06/22] btrfs-progs: mkfs: use the btrfs_block_group_root helper
Date:   Fri,  5 Nov 2021 16:40:32 -0400
Message-Id: <742e40465dc7ab1c055900a0468a059c77be5087.1636144275.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1636144275.git.josef@toxicpanda.com>
References: <cover.1636144275.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Instead of accessing the extent root directory for modifying block
groups, use the helper which will do the correct thing based on the
flags of the file system.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 check/main.c | 4 ++--
 mkfs/main.c  | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/check/main.c b/check/main.c
index 5fb28216..7735cce1 100644
--- a/check/main.c
+++ b/check/main.c
@@ -9387,6 +9387,7 @@ static int reinit_global_roots(struct btrfs_trans_handle *trans, u64 objectid)
 
 static int reinit_extent_tree(struct btrfs_trans_handle *trans, bool pin)
 {
+	struct btrfs_root *bg_root = btrfs_block_group_root(trans->fs_info);
 	u64 start = 0;
 	int ret;
 
@@ -9460,7 +9461,6 @@ again:
 	while (1) {
 		struct btrfs_block_group_item bgi;
 		struct btrfs_block_group *cache;
-		struct btrfs_root *extent_root = btrfs_extent_root(gfs_info, 0);
 		struct btrfs_key key;
 
 		cache = btrfs_lookup_first_block_group(gfs_info, start);
@@ -9474,7 +9474,7 @@ again:
 		key.objectid = cache->start;
 		key.type = BTRFS_BLOCK_GROUP_ITEM_KEY;
 		key.offset = cache->length;
-		ret = btrfs_insert_item(trans, extent_root, &key, &bgi,
+		ret = btrfs_insert_item(trans, bg_root, &key, &bgi,
 					sizeof(bgi));
 		if (ret) {
 			fprintf(stderr, "Error adding block group\n");
diff --git a/mkfs/main.c b/mkfs/main.c
index 2c4b7b00..9a57cef8 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -596,7 +596,7 @@ static int cleanup_temp_chunks(struct btrfs_fs_info *fs_info,
 {
 	struct btrfs_trans_handle *trans = NULL;
 	struct btrfs_block_group_item *bgi;
-	struct btrfs_root *root = btrfs_extent_root(fs_info, 0);
+	struct btrfs_root *root = btrfs_block_group_root(fs_info);
 	struct btrfs_key key;
 	struct btrfs_key found_key;
 	struct btrfs_path path;
-- 
2.26.3

