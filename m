Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4BC4114892E
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Jan 2020 15:34:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392771AbgAXOdW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 24 Jan 2020 09:33:22 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:41255 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404149AbgAXOdV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 24 Jan 2020 09:33:21 -0500
Received: by mail-qt1-f193.google.com with SMTP id k40so1624510qtk.8
        for <linux-btrfs@vger.kernel.org>; Fri, 24 Jan 2020 06:33:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LxUmk3tZA8Um4Lf5x+7+lgvEuXrmr4KXpR8o2atv9DY=;
        b=uLypxOyCJuqBAGIum44zBLcIGVJSgeDsiLxZxyvygij/8eQI0lE4DBvm4P9oMIEuHH
         n0Yge9/vRqstPDM2CaKlo60Au5d6WIJBI5HJXyUWELJhh1rkvEshVEKuAWgHNqPwnSeO
         pu/kOYcZdmm1JLQ6JkNiFj1PJFWt9vhmc5qJOxHBW/7tGmxxm7V3mJ+3Wd6xQ8isnNFp
         V8N2yip/02awNuNXh+7ArJmdWPq14UyAUkvTp2M4ZgNySDSNvG25XvPdb98KFildTegp
         4S7GXXDwdnpE4hHLr+AtZPkAl+C+t9Lg62WGmKbVjGmrGatM0sYPgLzlnCQ9twiPPbeu
         UM2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LxUmk3tZA8Um4Lf5x+7+lgvEuXrmr4KXpR8o2atv9DY=;
        b=IAOJ9LcmK7dWX6Q2NU8ynqpbxaVj8uzawdx7fOyJu3YK11hNwmBi6ScKMy+BogV0rR
         oDCHn+4iBrfDFK7kO+N8fSYvj7mQpdc8MRx+UeElTYFvwpRG+P9MtWSQ9S+/bpx8dze5
         BqG5YJFomgqhQ1IrEDrkb2lsuO72Om76F8g1/+jlez+LMEuu3IECl605z3e+CrJ3X7yJ
         YELUl++mqCs9cm+aT7B3o+TGXzUa6T3Dt4c61+KgI0w7oojRqS+BU7wJUB2O76Gv1Y4w
         +Z08n/V85HWMDyoOugXKVJHYarW0THgdscLIPtSWiSt0sDDzO0IOQVOpNmXXAMPC19Fa
         1aCA==
X-Gm-Message-State: APjAAAUpKM/kdOnsnksW7I3uc8UarJYRmMsOgnZmTc3FYKvLBMBhuZra
        TlU/v1NP323tPtI8mH2DUtnODrdqo0I8zg==
X-Google-Smtp-Source: APXvYqyeDM7vbEsIsCoWfOee3I+V0daTPyyCElk7KBYzIwMNTP4BtYV4TO5L0ejdS29ko6xrKq6pYA==
X-Received: by 2002:ac8:2afb:: with SMTP id c56mr2450937qta.112.1579876400382;
        Fri, 24 Jan 2020 06:33:20 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id h8sm3255960qtm.51.2020.01.24.06.33.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jan 2020 06:33:19 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     kernel-team@fb.com, linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 10/44] btrfs: hold a ref on fs roots while they're in the radix tree
Date:   Fri, 24 Jan 2020 09:32:27 -0500
Message-Id: <20200124143301.2186319-11-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200124143301.2186319-1-josef@toxicpanda.com>
References: <20200124143301.2186319-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

If we're sitting in the radix tree, we should probably have a ref for
the radix tree.  Grab a ref on the root when we insert it, and drop it
when it gets deleted.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Reviewed-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/disk-io.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index f030ff87ed18..5f672f016ed8 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -1513,8 +1513,10 @@ int btrfs_insert_fs_root(struct btrfs_fs_info *fs_info,
 	ret = radix_tree_insert(&fs_info->fs_roots_radix,
 				(unsigned long)root->root_key.objectid,
 				root);
-	if (ret == 0)
+	if (ret == 0) {
+		btrfs_grab_fs_root(root);
 		set_bit(BTRFS_ROOT_IN_RADIX, &root->state);
+	}
 	spin_unlock(&fs_info->fs_roots_radix_lock);
 	radix_tree_preload_end();
 
@@ -3814,6 +3816,8 @@ void btrfs_drop_and_free_fs_root(struct btrfs_fs_info *fs_info,
 	spin_lock(&fs_info->fs_roots_radix_lock);
 	radix_tree_delete(&fs_info->fs_roots_radix,
 			  (unsigned long)root->root_key.objectid);
+	if (test_and_clear_bit(BTRFS_ROOT_IN_RADIX, &root->state))
+		btrfs_put_fs_root(root);
 	spin_unlock(&fs_info->fs_roots_radix_lock);
 
 	if (btrfs_root_refs(&root->root_item) == 0)
-- 
2.24.1

