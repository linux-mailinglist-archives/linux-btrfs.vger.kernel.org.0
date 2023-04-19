Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1BAB6E838C
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Apr 2023 23:22:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232344AbjDSVWv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 19 Apr 2023 17:22:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232008AbjDSVWr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 19 Apr 2023 17:22:47 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E92C5FFB
        for <linux-btrfs@vger.kernel.org>; Wed, 19 Apr 2023 14:22:17 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id l17so1001418qvq.10
        for <linux-btrfs@vger.kernel.org>; Wed, 19 Apr 2023 14:22:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20221208.gappssmtp.com; s=20221208; t=1681939264; x=1684531264;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gXYTMM5IFzCAiwb3Gjxa/lzL/UdbgTanL1/vxWy4ljg=;
        b=bCtinitQ54edgQ6VPmuPFM1k2qzM0kMx0Dywnm4GuowzvU35MUbmNG2Zq4teib+Xrz
         paTs/mJKwOqW7wJAX1o0ZVqwTVUEsGutQYJsmlksfT/hDljViuMkcoVezWJFVAZWF5IJ
         kJ5I1NP8b1OxKQDxiLrFCR1MlQ+uOf2UgAQDPqaZX3NeHmzITeYtYWj/0gGN0OESUvle
         Hcd9GmtvairCtkxs2kyZuZrMjzEXmFnm36FZTvfu6Lnbqa3HWTegu1tH1okMlOEvBuh2
         phyL6TcODVMQHruczMu7/bSZnbDvb+8KzySl6hOI+Guok8SfQsr0+xCfKQNd1tAllJ21
         yr1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681939264; x=1684531264;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gXYTMM5IFzCAiwb3Gjxa/lzL/UdbgTanL1/vxWy4ljg=;
        b=ku9+D6vDZgl77IoqP844lA9eF5bP4T4aHsQiCDTIgGGAq9p/wUCzoPwnukeG515R1w
         nw+10P/M8o8p0J+a8Xwmf1JBEhz3PjnY40Z2oxSzuUe9PTOpbtfBA89eLOT8mZ9Sic1W
         fJIxIIqKTlKKy5Y6XQrOHUL0H2sogD5sKhpAzZ33kIEwXuL/EhJvNWZFWuWkijlq4RRK
         HM/HIBLhf5BB+qhb/olBLtqowN3atMP40Ty9jLRVtvDfkBBq6rSdKE0IhlNbu12UTwQl
         hORMeIySCQFA39dgs+QZO46W4hSDFcyv/Xs8sMCWDK7JrkSKF2fX82Nu/4yQz+BaP+SC
         Wu7w==
X-Gm-Message-State: AAQBX9fMIE8tSs3MHspafdxINcndZ9xJA0dMegeYCosFJsWxud2v3KvR
        W9EXTWFTd+V3mJvZhIBf7FA1bDp+akjg52VXKa7zQg==
X-Google-Smtp-Source: AKy350b/ShGTkg4WnoE9/lF2A/wGLi97QpCZNKxZjNfj7SpwtA/AyoVjb+5fQdzIfO+FV4wM6kUibw==
X-Received: by 2002:a05:6214:27e6:b0:5b0:67f3:d91b with SMTP id jt6-20020a05621427e600b005b067f3d91bmr37288722qvb.35.1681939264211;
        Wed, 19 Apr 2023 14:21:04 -0700 (PDT)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id b10-20020a05620a0cca00b0074c398c0bf7sm2289647qkj.71.2023.04.19.14.21.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Apr 2023 14:21:03 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 08/10] btrfs-progs: cleanup args for btrfs_set_disk_extent_flags
Date:   Wed, 19 Apr 2023 17:20:48 -0400
Message-Id: <346af6d7b9a7b23f475a090f4e4fc0d318048a57.1681939107.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <cover.1681939107.git.josef@toxicpanda.com>
References: <cover.1681939107.git.josef@toxicpanda.com>
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

In the kernel we just pass in the extent_buffer and get the fields we
need from that to update the extent ref flags.  Update this helper to
match the kernel to make syncing ctree.c easier.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 kernel-shared/ctree.c       |  4 +---
 kernel-shared/ctree.h       |  4 ++--
 kernel-shared/extent-tree.c | 11 +++++++----
 3 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/kernel-shared/ctree.c b/kernel-shared/ctree.c
index e95dcc79..ea2a7af3 100644
--- a/kernel-shared/ctree.c
+++ b/kernel-shared/ctree.c
@@ -419,9 +419,7 @@ static noinline int update_ref_for_cow(struct btrfs_trans_handle *trans,
 			BUG_ON(ret);
 		}
 		if (new_flags != 0) {
-			ret = btrfs_set_disk_extent_flags(trans, buf->start,
-							  btrfs_header_level(buf),
-							  new_flags);
+			ret = btrfs_set_disk_extent_flags(trans, buf, new_flags);
 			BUG_ON(ret);
 		}
 	} else {
diff --git a/kernel-shared/ctree.h b/kernel-shared/ctree.h
index aaace45e..069e000d 100644
--- a/kernel-shared/ctree.h
+++ b/kernel-shared/ctree.h
@@ -859,8 +859,8 @@ struct extent_buffer *btrfs_alloc_tree_block(struct btrfs_trans_handle *trans,
 int btrfs_lookup_extent_info(struct btrfs_trans_handle *trans,
 			     struct btrfs_fs_info *fs_info, u64 bytenr,
 			     u64 offset, int metadata, u64 *refs, u64 *flags);
-int btrfs_set_disk_extent_flags(struct btrfs_trans_handle *trans, u64 bytenr,
-				int level, u64 flags);
+int btrfs_set_disk_extent_flags(struct btrfs_trans_handle *trans,
+				struct extent_buffer *eb, u64 flags);
 int btrfs_inc_ref(struct btrfs_trans_handle *trans, struct btrfs_root *root,
 		  struct extent_buffer *buf, int record_parent);
 int btrfs_dec_ref(struct btrfs_trans_handle *trans, struct btrfs_root *root,
diff --git a/kernel-shared/extent-tree.c b/kernel-shared/extent-tree.c
index 8a6ab996..cfce4426 100644
--- a/kernel-shared/extent-tree.c
+++ b/kernel-shared/extent-tree.c
@@ -1375,26 +1375,29 @@ out:
 	return ret;
 }
 
-int btrfs_set_disk_extent_flags(struct btrfs_trans_handle *trans, u64 bytenr,
-				int level, u64 flags)
+int btrfs_set_disk_extent_flags(struct btrfs_trans_handle *trans,
+				struct extent_buffer *eb, u64 flags)
 {
 	struct btrfs_fs_info *fs_info = trans->fs_info;
-	struct btrfs_root *extent_root = btrfs_extent_root(fs_info, bytenr);
+	struct btrfs_root *extent_root;
 	struct btrfs_path *path;
 	int ret;
 	struct btrfs_key key;
 	struct extent_buffer *l;
 	struct btrfs_extent_item *item;
 	u32 item_size;
+	u64 bytenr = eb->start;
 	int skinny_metadata = btrfs_fs_incompat(fs_info, SKINNY_METADATA);
 
 	path = btrfs_alloc_path();
 	if (!path)
 		return -ENOMEM;
 
+	extent_root = btrfs_extent_root(fs_info, bytenr);
+
 	key.objectid = bytenr;
 	if (skinny_metadata) {
-		key.offset = level;
+		key.offset = btrfs_header_level(eb);
 		key.type = BTRFS_METADATA_ITEM_KEY;
 	} else {
 		key.offset = fs_info->nodesize;
-- 
2.40.0

