Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63D5A4D0A98
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Mar 2022 23:11:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242265AbiCGWMH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Mar 2022 17:12:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242123AbiCGWMG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 7 Mar 2022 17:12:06 -0500
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C8D47A9B9
        for <linux-btrfs@vger.kernel.org>; Mon,  7 Mar 2022 14:11:11 -0800 (PST)
Received: by mail-qt1-x82b.google.com with SMTP id w1so14594095qtj.2
        for <linux-btrfs@vger.kernel.org>; Mon, 07 Mar 2022 14:11:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=mzqMH+jtMMCgbFgWVMl0xNao/EKzSBpfVXRq6fKQlBQ=;
        b=h5Of31d9hyYRvYtcCIKauWHNq49RbKHruKoG7r30o1BPfAV3XKM6sdnfyxvbSYcmj+
         s06cTiKbvU0EgrVzmjYkh48qfKVij2toxKPXoBJ2G1XrxYhyEplQ3GrJeqkADpNES8lT
         2p0CGjL26e1/y69KF89WIUju1Nt0gi/mqXFuYLAhBC0y9epg2F51dl7YlaJuJb7m0eop
         ITs3mhDKxqV0sXWkRZZy4nhHEGTsVZVZecBtGHPwm6UmI9KCEpJQUhPUNBXJWKQVX6xO
         RSU91FP0aqicE0/mgxnnU9n8EBxtDfj/CR4P+YfRWAot+bzyBxTaNQoDgX7K2PGek8xN
         cjdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mzqMH+jtMMCgbFgWVMl0xNao/EKzSBpfVXRq6fKQlBQ=;
        b=SVuhQMti/hF3bc0l6E+tXpinGq1MnKdmUMu3hGkUK7otdtdWHkMaNuKYr23e4aub8v
         L5J7uhj3Gp1Ge82syHLJ9cUmtY6ow1DnGENcaqm+ThW3+P4S/m9+NDnZieb3rh8JJ6Jx
         XAuGRD52wvs9b0Z1TrMiRn4MM5v7jv457k9tVXdGVss9oc8fQuqt232RgJx71dUkAsO5
         ukM6syDrgHJo1KvAE9dZaIg9vrWOjuaoXmklF3PYAB895Q24RmzcqLVRzx3LvdBVmS2K
         zGjpEOfHXLvCs1k0q3LXXASB7WEH9BUeEhpOS53TFiCGUeKXMOhEOR2+TJAulXWVbK+t
         Rd4Q==
X-Gm-Message-State: AOAM533c+916XdyD2JQ4Jfd0DJurBmUbe8JdtovanCUd+vn4pDoj0MU7
        knRRh8Sl7lEkQwO0UKxnZm2m2FV/5nwXuTFD
X-Google-Smtp-Source: ABdhPJx6M6vz0WxaAv4g8HoTovQQRlcSKaZAc53hZb4pc2N/NChRW5c7stErwuirFCYno0QT02fayw==
X-Received: by 2002:ac8:4e46:0:b0:2cf:942e:518c with SMTP id e6-20020ac84e46000000b002cf942e518cmr11067603qtw.68.1646691070093;
        Mon, 07 Mar 2022 14:11:10 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id e9-20020a05620a014900b005084ce66b44sm6698565qkn.88.2022.03.07.14.11.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 14:11:09 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v5 03/19] btrfs-progs: mkfs: use the btrfs_block_group_root helper
Date:   Mon,  7 Mar 2022 17:10:48 -0500
Message-Id: <a15778e772e1f68d9be9d232c6a79b383ab38735.1646690972.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1646690972.git.josef@toxicpanda.com>
References: <cover.1646690972.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
index 39cb1ce5..6ddfd18a 100644
--- a/check/main.c
+++ b/check/main.c
@@ -9426,6 +9426,7 @@ static int reinit_global_roots(struct btrfs_trans_handle *trans, u64 objectid)
 
 static int reinit_extent_tree(struct btrfs_trans_handle *trans, bool pin)
 {
+	struct btrfs_root *bg_root = btrfs_block_group_root(trans->fs_info);
 	u64 start = 0;
 	int ret;
 
@@ -9499,7 +9500,6 @@ again:
 	while (1) {
 		struct btrfs_block_group_item bgi;
 		struct btrfs_block_group *cache;
-		struct btrfs_root *extent_root = btrfs_extent_root(gfs_info, 0);
 		struct btrfs_key key;
 
 		cache = btrfs_lookup_first_block_group(gfs_info, start);
@@ -9513,7 +9513,7 @@ again:
 		key.objectid = cache->start;
 		key.type = BTRFS_BLOCK_GROUP_ITEM_KEY;
 		key.offset = cache->length;
-		ret = btrfs_insert_item(trans, extent_root, &key, &bgi,
+		ret = btrfs_insert_item(trans, bg_root, &key, &bgi,
 					sizeof(bgi));
 		if (ret) {
 			fprintf(stderr, "Error adding block group\n");
diff --git a/mkfs/main.c b/mkfs/main.c
index 3dd06979..20dc0436 100644
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

