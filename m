Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 850331412CA
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Jan 2020 22:26:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726958AbgAQV0M (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Jan 2020 16:26:12 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:40302 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726587AbgAQV0M (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Jan 2020 16:26:12 -0500
Received: by mail-qt1-f195.google.com with SMTP id v25so22902767qto.7
        for <linux-btrfs@vger.kernel.org>; Fri, 17 Jan 2020 13:26:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=zjrVxnsZKo31QWnAbKZVEuBX4NBWPLnoaVZf5LWSJ7k=;
        b=iEKLNWobQ4rFqKjzNiq1Oxp3Bh22HLQ/5vppgEdR/sPYgYbcBjFq5OqWlpYV5K3iHJ
         XWg6H/vGzquX94hIWXsv3LcI/l9wboLnwKmQkahIToDmzLyFdO+MuzBCoLg17Hio2s+2
         pzWPu+O9r7gbL/iM7dzq1O6WPQLevFE+PHSz+Im7HbPO6wwWxNSxZTv4yHsw0c++vleY
         O6uCqFaTIIiE8dPm2RdHkqGQlb7chPi9BTLBHOAinwWDA9WrbCIC60fErmbQBmHaFsVv
         7+GwOytoDjpnQCm8JjLi8V1QI/gVFYT04xVN6w4nhJ20LMQuVLQvLOnH57ePz+S1exiS
         8A1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zjrVxnsZKo31QWnAbKZVEuBX4NBWPLnoaVZf5LWSJ7k=;
        b=HFXZUGxGOpsdPf5I6Z+DPf19+X5i6awdRU7kmjvRABGePA/usyXqTbBvnZBO0/6FfC
         ZEzjwkXe4Jvn3rijhop7dSvUgIi5lDJnRKRQGhbBtsZ3zFCeBFdYk94b1BSRM5Po/Tia
         b7g83IewuUxvTgdhK4WIwGaV91LU8KDiBGmJzI0UEgjfLorYsOMoO446Hy1n7S/7g65X
         /Aflmey0Qj0iEq2jBC/oHluNmvMHflRX7a6tnrqr9oOPisXAVPkhThDNkXpFn5iUo6UQ
         16+rsnLe1VBYC1JwKtmehP9t1YRrmXNvgPO1SeWiN2Ts/yc2dsWiMDc4EqW1hAFjtYO4
         3z6Q==
X-Gm-Message-State: APjAAAWo5kEuh8AgJWx9GMwOSMtPNSH4DJ4dj3zGStVLPHqpGhiSv8tZ
        /U3YnPB78HwAkbm7Dj9Ea7vSNA9UMbK5LQ==
X-Google-Smtp-Source: APXvYqwzrYbNiqwKo6zqaroZIo+LZj4wyEoH/CJLwgfLP02X80D/23PfA/U7KEB9oVrVvRUXDh05JA==
X-Received: by 2002:ac8:969:: with SMTP id z38mr9151590qth.203.1579296370774;
        Fri, 17 Jan 2020 13:26:10 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id k73sm12479170qke.36.2020.01.17.13.26.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2020 13:26:10 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 03/43] btrfs: make btrfs_find_orphan_roots use btrfs_get_fs_root
Date:   Fri, 17 Jan 2020 16:25:22 -0500
Message-Id: <20200117212602.6737-4-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200117212602.6737-1-josef@toxicpanda.com>
References: <20200117212602.6737-1-josef@toxicpanda.com>
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

