Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A0B1F148920
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Jan 2020 15:33:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392762AbgAXOdM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 24 Jan 2020 09:33:12 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:37203 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392756AbgAXOdK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 24 Jan 2020 09:33:10 -0500
Received: by mail-qt1-f194.google.com with SMTP id w47so1638841qtk.4
        for <linux-btrfs@vger.kernel.org>; Fri, 24 Jan 2020 06:33:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TP1xlF1/ZZi1NsdI6J3j47bBMEePMqOBzLho3vuckcM=;
        b=Lc7oJJiI0jubqYwlmm0XoiNAe3VtlL2CGHxE9YSrLSM8KXtc/9X09v4NLPpnDV3z5V
         IcGvYPQw9NJn4RgxcOmzqjZx0EXcQVlYykLtwZG3qlKXogBNiAxnvsa98fgIJkTJbKhe
         cAMjkuNSJwDC25dPSyjAJZm++cgCAp+w2f4B5Q9qNS/lzbwZv5ggPW2jnKdtizikZo9s
         tjb89fTeCCY6nC1g7E1u9uoGj+E0G1hRbboifm2ucZKqiomGD5Si/vOXU+XpdrPidqQC
         z1a4COxNbKdzQUSdFPj11Up/Cv8qBYwmP3pWFYSTyhYlicUpO+GL7BQGKKDblNQt56td
         5Gdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TP1xlF1/ZZi1NsdI6J3j47bBMEePMqOBzLho3vuckcM=;
        b=psN7E7dORc/rR/0A31kai5bdpGN3kn+JgoT0pU0sbnROqdbPx/C1dTe0ZqDQYmdCp6
         4ANLc9lQdZtUZKUilgukr2ne5P2SvFKNXzk7wVyZc++ZSUILSMOJyeZq+sKdaXzW4aC1
         3U9T15yAbDUL13tm/47uOIhGSX+ncMftnfdT8qBq8MkxQCXehY6hTYgmA9YWaIyiE/7h
         NjUnMaEqEPeDSFAEQgDO9Wo7YpNMEXtU1eGipMApLumDXP4ATGpQ5DU+cZrMBLdj581E
         1qfAo5Bc8mlImR2mWo9OuWo67NNa3TTkdrfKYAyKqWOjV4vmhENUDILS8Xb/q20vA8gL
         XLbg==
X-Gm-Message-State: APjAAAXaG7JN08asBI5mF8fX9+NX/TOpk8w7GHvikUnB/jLsURMG9gNC
        8BuHH+k8pLR/VDeFu3hPX5aX2w4s/x38tg==
X-Google-Smtp-Source: APXvYqzIAZro883OleiOTXhuNL4FJkep0983LptIgRflPIxHeyUfOsr8iQl2hqqkAY0Tl5LimfVccg==
X-Received: by 2002:ac8:6bc9:: with SMTP id b9mr2399234qtt.108.1579876389057;
        Fri, 24 Jan 2020 06:33:09 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id i4sm3127472qki.45.2020.01.24.06.33.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jan 2020 06:33:08 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     kernel-team@fb.com, linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 03/44] btrfs: make btrfs_find_orphan_roots use btrfs_get_fs_root
Date:   Fri, 24 Jan 2020 09:32:20 -0500
Message-Id: <20200124143301.2186319-4-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200124143301.2186319-1-josef@toxicpanda.com>
References: <20200124143301.2186319-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

btrfs_find_orphan_roots has this weird thing where it looks up the root
in cache to see if it is there before just reading the root.  But the
read it uses just reads the root, it doesn't do any of the init work, we
do that by hand here.  But this is unnecessary, all we really want is to
see if the root still exists and add it to the dead roots list to be
cleaned up, otherwise we delete the orphan item.

Fix this by just using btrfs_get_fs_root directly with check_ref set to
false so we get the orphan root items.  Then we just handle in cache and
out of cache roots the same, add them to the dead roots list and carry
on.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Reviewed-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/root-tree.c | 37 +++----------------------------------
 1 file changed, 3 insertions(+), 34 deletions(-)

diff --git a/fs/btrfs/root-tree.c b/fs/btrfs/root-tree.c
index 612411c74550..094a71c54fa1 100644
--- a/fs/btrfs/root-tree.c
+++ b/fs/btrfs/root-tree.c
@@ -255,25 +255,7 @@ int btrfs_find_orphan_roots(struct btrfs_fs_info *fs_info)
 		root_key.objectid = key.offset;
 		key.offset++;
 
-		/*
-		 * The root might have been inserted already, as before we look
-		 * for orphan roots, log replay might have happened, which
-		 * triggers a transaction commit and qgroup accounting, which
-		 * in turn reads and inserts fs roots while doing backref
-		 * walking.
-		 */
-		root = btrfs_lookup_fs_root(fs_info, root_key.objectid);
-		if (root) {
-			WARN_ON(!test_bit(BTRFS_ROOT_ORPHAN_ITEM_INSERTED,
-					  &root->state));
-			if (btrfs_root_refs(&root->root_item) == 0) {
-				set_bit(BTRFS_ROOT_DEAD_TREE, &root->state);
-				btrfs_add_dead_root(root);
-			}
-			continue;
-		}
-
-		root = btrfs_read_fs_root(tree_root, &root_key);
+		root = btrfs_get_fs_root(fs_info, &root_key, false);
 		err = PTR_ERR_OR_ZERO(root);
 		if (err && err != -ENOENT) {
 			break;
@@ -300,21 +282,8 @@ int btrfs_find_orphan_roots(struct btrfs_fs_info *fs_info)
 			continue;
 		}
 
-		err = btrfs_init_fs_root(root);
-		if (err) {
-			btrfs_free_fs_root(root);
-			break;
-		}
-
-		set_bit(BTRFS_ROOT_ORPHAN_ITEM_INSERTED, &root->state);
-
-		err = btrfs_insert_fs_root(fs_info, root);
-		if (err) {
-			BUG_ON(err == -EEXIST);
-			btrfs_free_fs_root(root);
-			break;
-		}
-
+		WARN_ON(!test_bit(BTRFS_ROOT_ORPHAN_ITEM_INSERTED,
+				  &root->state));
 		if (btrfs_root_refs(&root->root_item) == 0) {
 			set_bit(BTRFS_ROOT_DEAD_TREE, &root->state);
 			btrfs_add_dead_root(root);
-- 
2.24.1

