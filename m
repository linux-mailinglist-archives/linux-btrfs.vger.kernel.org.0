Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51EDB2DC3FB
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Dec 2020 17:23:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726659AbgLPQXG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 16 Dec 2020 11:23:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725769AbgLPQXG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 16 Dec 2020 11:23:06 -0500
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2DCEC0617A7
        for <linux-btrfs@vger.kernel.org>; Wed, 16 Dec 2020 08:22:25 -0800 (PST)
Received: by mail-qv1-xf31.google.com with SMTP id p12so11573871qvj.13
        for <linux-btrfs@vger.kernel.org>; Wed, 16 Dec 2020 08:22:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=ujmuRAt+OgP7KDrxS9o6KW0pRlAEn+NCmzQAqnRpobU=;
        b=usr496MNj2kugGBtLYGwOP7YmkYhJE2mtzXv5eYHvqfDF5t5n4iYlUSwRb6urnAf1d
         HJmfZZ28nPIa6RQQbyyyRZorrpqFdz6UtU4WqOIW2Fhh2eLqU8p02jvfKXbZpV5xcTMx
         A/LQSt+PFx9GkVn+j6wlUUmL13u6IRvBKslJEPvPooCaNJRm2noc91ZoZ8zPJBurLYOQ
         /fRD+hISC3GHndKDnw+rB7bIcDihaVHHGLeXwL0CcWsnb7X3hzqXn0I2Dp28sIhRQ4Pc
         /gw0cQ7g3AL6BVdfQf91NoQ902LIlRsboKoaw2L7dilwilcCD5rXzb8ykq1GjIcSwpBd
         0Njg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ujmuRAt+OgP7KDrxS9o6KW0pRlAEn+NCmzQAqnRpobU=;
        b=CZ6lAxkkFgdABgIT0hRB6SzlmbnMQrR3lDIZNKGbZUhrFgf67HhITkbMOSgPVNLDJQ
         t6R4mOsVfP/y0veR3+/5bjlHj3R4K1B1SQBCPbjtBWgwDCzcTt1rSjbVwiLoACFEgFD+
         6LrzRDZS9N8hwgr/mMOh4ePKT661d1X4mG9TUMZtGlipZ+I60Sn0+Gc4mBkZWsWcjyjc
         e94l2WYwaZoWjzwVFWt3QVJKv71FscGRg/YD/YMVbqE0PVgM4XflKYhg9OIfEHWan34E
         YWN+3andA3Ns4rr+WLvZTNWaAxfWbEjXQ9OI1hZDOWRcoJiO1GHe8FQitIIFhOTMhHaO
         NK6w==
X-Gm-Message-State: AOAM532WpIwk8hnI/+IKe4xIU8mo5et5fVqASEDDKt0WNqSbjNgr9FF5
        nrT7OA3i2bKqElUyA+/2w2Np9EULDmsr+xSa
X-Google-Smtp-Source: ABdhPJwtpn44B/1azdf0pkSrE6LdmX4BeAzfTx/c8QCWd1iTyV+Z154Wjfrbg65Pvl8zAR9/xo7dDw==
X-Received: by 2002:a0c:dc13:: with SMTP id s19mr22363330qvk.26.1608135744521;
        Wed, 16 Dec 2020 08:22:24 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id f17sm1185378qtv.68.2020.12.16.08.22.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Dec 2020 08:22:23 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 03/13] btrfs: fix reloc root leak with 0 ref reloc roots on recovery
Date:   Wed, 16 Dec 2020 11:22:07 -0500
Message-Id: <cb1d741e029c5ead390b2b9be4c57b376672b100.1608135557.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1608135557.git.josef@toxicpanda.com>
References: <cover.1608135557.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

When recovering a relocation, if we run into a reloc root that has 0
refs we simply add it to the reloc_control->reloc_roots list, and then
clean it up later.  The problem with this is __del_reloc_root() doesn't
do anything if the root isn't in the radix tree, which in this case it
won't be because we never call __add_reloc_root() on the reloc_root.

This exit condition simply isn't correct really.  During normal
operation we can remove ourselves from the rb tree and then we're meant
to clean up later at merge_reloc_roots() time, and this happens
correctly.  During recovery we're depending on free_reloc_roots() to
drop our references, but we're short-circuiting.

Fix this by continuing to check if we're on the list and dropping
ourselves from the reloc_control root list and dropping our reference
appropriately.  Change the corresponding BUG_ON() to an ASSERT() that
does the correct thing if we aren't in the rb tree.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/relocation.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index f9500262106e..073666fb7b57 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -668,9 +668,7 @@ static void __del_reloc_root(struct btrfs_root *root)
 			RB_CLEAR_NODE(&node->rb_node);
 		}
 		spin_unlock(&rc->reloc_root_tree.lock);
-		if (!node)
-			return;
-		BUG_ON((struct btrfs_root *)node->data != root);
+		ASSERT(!node || (struct btrfs_root *)node->data == root);
 	}
 
 	/*
-- 
2.26.2

