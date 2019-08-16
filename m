Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 605419048B
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Aug 2019 17:20:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727525AbfHPPUZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 16 Aug 2019 11:20:25 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:37077 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727311AbfHPPUZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 16 Aug 2019 11:20:25 -0400
Received: by mail-qk1-f194.google.com with SMTP id s14so5062000qkm.4
        for <linux-btrfs@vger.kernel.org>; Fri, 16 Aug 2019 08:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=uj7RCs2MZoUADRXciWAkYJ4yzZdsQ6VBxGKx7wFHGRo=;
        b=hMVlLyqBzm7E89T0uOCg9eLukqUyLJSDg7oOlqDocwsHV7nFllqKeAQnkQN6UZYwgc
         ULQoNXx42b1yvn4ZRxETjMyit5m3LcyeV7+kP6S/ZWC4dFEdw9PbxOXQoQF7LmyH9BaT
         aSNARZOCHTVo6Vq6KcWKxgTRVOYszAK/ME1aYktjkWNaUhPj2OwhWDpWEmhJKyV0wZ6+
         HaywOhiClRsWBMiQn7NBANvIjd9rlqBQFDA6fTtq6rQXmNuTmY1aj628tUI4l036YuXK
         oM1PhELUIjNsOUYQolMtl/yyNJqWMaa7lkNHYgZG4ogA7RpYtSjcNsMUlq9zeWwzSvpf
         LgOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uj7RCs2MZoUADRXciWAkYJ4yzZdsQ6VBxGKx7wFHGRo=;
        b=QMMeWtFL0I+j0xsIQ6aRrsEGwUfI3nPLqnahMhKNtpV+0FmkJqR+0YmnU0Za0Ig7mf
         xRpwEri/bdm1eivAZwQGzlX0CK54zKqD5o2asfJtx7WXv/Fgfn7ARKPUjHBj+uNTGgjV
         kSMOuvl+eWKVCrtiztZSH88xLTbff1WHztlizmH47aoTCWzYkgiFXubgnprOSr48q+0S
         KQpwwxbubzjQf6+EZQkHkxwhBI3ylcSXZjYJhfTFfQ1J5vlBWNTl5EpK7OZsEx3Odouf
         VJeroCsi9JBef+tmVV36MDl8+hSpyLF8o64Ip9OaWsGeiMjNzPv5zKoCgzLFxFkH9nHg
         pUzg==
X-Gm-Message-State: APjAAAVunBQoec776Sf8QImCYyGZ8giOamd3+OH++V8a/ASsR67o+z+6
        Dc0d6mZJy7Ct0LOIwaEwmow8UjcjOtPNLQ==
X-Google-Smtp-Source: APXvYqz+hGZpkcH64ShV+LnOoR/q6B3617J5a0QTlejQZ1/0EYvK8Z0/vPFpoCvy7FqF0KO5pxe3Mg==
X-Received: by 2002:a37:be41:: with SMTP id o62mr9395196qkf.356.1565968823894;
        Fri, 16 Aug 2019 08:20:23 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id f7sm2967275qtj.16.2019.08.16.08.20.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2019 08:20:23 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 1/5] btrfs: change the minimum global reserve size
Date:   Fri, 16 Aug 2019 11:20:15 -0400
Message-Id: <20190816152019.1962-2-josef@toxicpanda.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190816152019.1962-1-josef@toxicpanda.com>
References: <20190816152019.1962-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

It made sense to have the global reserve set at 16M in the past, but
since it is used less nowadays set the minimum size to the number of
items we'll need to update the main trees we update during a transaction
commit, plus some slop area so we can do unlinks if we need to.

In practice this doesn't affect normal file systems, but for xfstests
where we do things like fill up a fs and then rm * it can fall over in
weird ways.  This enables us for more sane behavior at extremely small
file system sizes.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/block-rsv.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/block-rsv.c b/fs/btrfs/block-rsv.c
index c64b460a4301..657675eef443 100644
--- a/fs/btrfs/block-rsv.c
+++ b/fs/btrfs/block-rsv.c
@@ -258,6 +258,7 @@ void btrfs_update_global_block_rsv(struct btrfs_fs_info *fs_info)
 	struct btrfs_block_rsv *block_rsv = &fs_info->global_block_rsv;
 	struct btrfs_space_info *sinfo = block_rsv->space_info;
 	u64 num_bytes;
+	unsigned min_items;
 
 	/*
 	 * The global block rsv is based on the size of the extent tree, the
@@ -267,7 +268,26 @@ void btrfs_update_global_block_rsv(struct btrfs_fs_info *fs_info)
 	num_bytes = btrfs_root_used(&fs_info->extent_root->root_item) +
 		btrfs_root_used(&fs_info->csum_root->root_item) +
 		btrfs_root_used(&fs_info->tree_root->root_item);
-	num_bytes = max_t(u64, num_bytes, SZ_16M);
+
+	/*
+	 * We at a minimum are going to modify the csum root, the tree root, and
+	 * the extent root.
+	 */
+	min_items = 3;
+
+	/*
+	 * But we also want to reserve enough space so we can do the fallback
+	 * global reserve for an unlink, which is an additional 5 items (see the
+	 * comment in __unlink_start_trans for what we're modifying.)
+	 *
+	 * But we also need space for the delayed ref updates from the unlink,
+	 * so its 10, 5 for the actual operation, and 5 for the delayed ref
+	 * updates.
+	 */
+	min_items += 10;
+
+	num_bytes = max_t(u64, num_bytes,
+			  btrfs_calc_insert_metadata_size(fs_info, min_items));
 
 	spin_lock(&sinfo->lock);
 	spin_lock(&block_rsv->lock);
-- 
2.21.0

