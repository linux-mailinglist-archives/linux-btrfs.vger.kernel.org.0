Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E25F0140B61
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Jan 2020 14:49:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728739AbgAQNsH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Jan 2020 08:48:07 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:42417 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728708AbgAQNsG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Jan 2020 08:48:06 -0500
Received: by mail-qt1-f195.google.com with SMTP id j5so21765372qtq.9
        for <linux-btrfs@vger.kernel.org>; Fri, 17 Jan 2020 05:48:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=zjrVxnsZKo31QWnAbKZVEuBX4NBWPLnoaVZf5LWSJ7k=;
        b=G8W6LDcjSQPBfd6VlXZ9AlnwPNk0PmbKysVyFPJtoCDJqlrBO9FSjGOpBfz1suELKJ
         OVPEkrgZbELZTPXuchHZtnSi9nEouXYihVOE4jAvix0/lJsNqfSKUcqSukYQrjn2ShBK
         wZFpI3rQHv7kp0lSg99os90WlUIkhZuE+5F0dL9PWnpWUL0+D/6Qx4rrfz9go+oM903V
         nRSrAWT1Z9dtA+pdXy16ZVdOwodyNOk/ueC4yd6i2gZFxPD34vk4ZAk7SGio334Woxzb
         F6iAQHlOxmvA3mS5L6r+pR3F9VMaTlKEb9qUwOL3Wh3fX9JGawVAZkO0O25HNEufbxG2
         O0Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zjrVxnsZKo31QWnAbKZVEuBX4NBWPLnoaVZf5LWSJ7k=;
        b=V1iBlH2IbJztiZvCpi97zbkqNX5TKbSVdRXQsZtapoyrOmAOdRI0+dJ33+32ZAlPSm
         kPLK9iZQDKHFVs3sh+VycBoi5XlCX6qe2aw0B13U0RCuOk6lTsBsTf169yjJydkgOs2L
         /i0e5OSDICE2B5jjhVmwD9Be3fN/yODmNaE44zgJZ7hcvKDv8AsqCtpMg6uvp9F2RRma
         MK76o+wDbymccoFzWy1RJ57pyJ5nWf6jCdkhYDrmAshHkQAm22HWVgQeea0i0/MVRpy6
         8PkPdZeUY66F7tywRP4mLMOqbP/Tncx3M3jVV3/P1RGjTOV6U+NPvgnIbDFPm0okWL9E
         n0Zw==
X-Gm-Message-State: APjAAAVYb2IFi/NUXM3XOvQAzgW4fRV9fSjimR/SPgFjUjirxZGqfhNJ
        K/r8z0yd98t2bh10i2qwJHOgnoXwYVkt7Q==
X-Google-Smtp-Source: APXvYqznlUBu0L4HUucGNvM8IHVp3vlVViihhhfbe54T20fuzlGL7VFVvnk+cLhItu6OaNvCFGgiHQ==
X-Received: by 2002:aed:36e5:: with SMTP id f92mr7608146qtb.354.1579268885680;
        Fri, 17 Jan 2020 05:48:05 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id s26sm13264934qtc.43.2020.01.17.05.48.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2020 05:48:05 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 03/43] btrfs: make btrfs_find_orphan_roots use btrfs_get_fs_root
Date:   Fri, 17 Jan 2020 08:47:18 -0500
Message-Id: <20200117134758.41494-4-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200117134758.41494-1-josef@toxicpanda.com>
References: <20200117134758.41494-1-josef@toxicpanda.com>
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

