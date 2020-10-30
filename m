Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 600E32A0FE1
	for <lists+linux-btrfs@lfdr.de>; Fri, 30 Oct 2020 22:03:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727706AbgJ3VDX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 30 Oct 2020 17:03:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726917AbgJ3VDX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 30 Oct 2020 17:03:23 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8276C0613CF
        for <linux-btrfs@vger.kernel.org>; Fri, 30 Oct 2020 14:03:22 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id p45so5155182qtb.5
        for <linux-btrfs@vger.kernel.org>; Fri, 30 Oct 2020 14:03:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=jyAOhBhO0viV5uEUq4XQaZzaVinrCge6QmkS5qPW3k4=;
        b=iDPwYJYDSkjSAZB/tX1HoK5PY63Dw8hdLefUgoIEXoth2YR8cjjKwxuESQS+IeW7Vg
         9SdUc2qHwm3QcDscfBHXbWF8KnaJYo7biI0/rpZWNTIh2hGfEyS/HcA9qV9tc0+pUvut
         v06Qti+/hc7ojKs35/jf41bht+IOHoSHIO30RIPO7c3XTYvZ5+ZnaQB5ryDFze3CSzpB
         z2QjII4PolEEJlM4HjnJufmZXTPV68iLhEbJVvP9X7i+FI3aSDYCHYO3fCIdn7vPVwh4
         HDPlBnWvX+rFv4PUtxlPZL1uEjFmPh+blIi9GGL3k0XPR7wcWyLeShwQ+Dp6K4NpejZg
         oNbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jyAOhBhO0viV5uEUq4XQaZzaVinrCge6QmkS5qPW3k4=;
        b=OL8a98sywmuOHEGedBojCsNQxnaRQQSKY4FJcOZz4RwcmLjfEaazbFeiFdsFZbRDLh
         vkUK2lpqKTUwzDGbUlACAI/rpHoIWMpL1FYTQCt1kswbhNBdvfe/KMeD49XzcTVYmGqH
         GXZdlMer472dn9K5D4XLFGCgw9dfA0zNNnGcnB5S/ChsjszyypdJhycqZ1u9x309dXE/
         Ia0ApcTqBS62TxtqGmFQmG5sIoOy+IGH0ZT7UF3GU6VcY/yfhb26sqtjQ+TitdupVuuf
         xV8ITiePNx16TlZqcPy2LnhobdRyiJI9h3ELw1mvm3qbGpMGlePwYbU7ZCgMNeAuyCIJ
         BXpQ==
X-Gm-Message-State: AOAM533tids/wl6KXYUpNWZUTAN7vUytIkgr4sQJwDEfb56uMHMM5NYh
        ShDR3gxGfexTMHI6wSBxGomHGv1jFZhWy0e/
X-Google-Smtp-Source: ABdhPJzpvViXD1OSk4Ysg5iFPAYvNK9FWLd3i6soGx2XAowSNTsXRBhNxupzx40fXMGS8sygf5xczg==
X-Received: by 2002:ac8:1e84:: with SMTP id c4mr4232747qtm.340.1604091801828;
        Fri, 30 Oct 2020 14:03:21 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id z66sm3387102qkb.50.2020.10.30.14.03.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2020 14:03:20 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 07/14] btrfs: use btrfs_read_node_slot in walk_down_tree
Date:   Fri, 30 Oct 2020 17:02:59 -0400
Message-Id: <191719dc15aa5ce13b7f58ab9e796c18509f0264.1604091530.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1604091530.git.josef@toxicpanda.com>
References: <cover.1604091530.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We're open-coding btrfs_read_node_slot() here, replace with the helper.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/ref-verify.c | 18 ++----------------
 1 file changed, 2 insertions(+), 16 deletions(-)

diff --git a/fs/btrfs/ref-verify.c b/fs/btrfs/ref-verify.c
index 7f03dbe5b609..4c9ddc750914 100644
--- a/fs/btrfs/ref-verify.c
+++ b/fs/btrfs/ref-verify.c
@@ -551,29 +551,15 @@ static int process_leaf(struct btrfs_root *root,
 static int walk_down_tree(struct btrfs_root *root, struct btrfs_path *path,
 			  int level, u64 *bytenr, u64 *num_bytes)
 {
-	struct btrfs_fs_info *fs_info = root->fs_info;
 	struct extent_buffer *eb;
-	u64 block_bytenr, gen;
 	int ret = 0;
 
 	while (level >= 0) {
 		if (level) {
-			struct btrfs_key first_key;
-
-			block_bytenr = btrfs_node_blockptr(path->nodes[level],
-							   path->slots[level]);
-			gen = btrfs_node_ptr_generation(path->nodes[level],
-							path->slots[level]);
-			btrfs_node_key_to_cpu(path->nodes[level], &first_key,
-					      path->slots[level]);
-			eb = read_tree_block(fs_info, block_bytenr, gen,
-					     level - 1, &first_key);
+			eb = btrfs_read_node_slot(path->nodes[level],
+						  path->slots[level]);
 			if (IS_ERR(eb))
 				return PTR_ERR(eb);
-			if (!extent_buffer_uptodate(eb)) {
-				free_extent_buffer(eb);
-				return -EIO;
-			}
 			btrfs_tree_read_lock(eb);
 			btrfs_set_lock_blocking_read(eb);
 			path->nodes[level-1] = eb;
-- 
2.26.2

