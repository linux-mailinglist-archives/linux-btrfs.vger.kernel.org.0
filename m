Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D255E1412D1
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Jan 2020 22:26:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727740AbgAQV00 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Jan 2020 16:26:26 -0500
Received: from mail-qv1-f67.google.com ([209.85.219.67]:38033 "EHLO
        mail-qv1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726587AbgAQV00 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Jan 2020 16:26:26 -0500
Received: by mail-qv1-f67.google.com with SMTP id t6so11369141qvs.5
        for <linux-btrfs@vger.kernel.org>; Fri, 17 Jan 2020 13:26:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=L+f5IzV9nT4YAxPklsAU5borgvxb1+yqLE5tB0c9SqY=;
        b=KTbPoS5nzk4M4Q6FUMx8LXQQv2tryJwTt650M/wCDGikLiaGKuvYfBZjzYQWS5ZZmW
         kHTDnTLXF/M96wUrpjAi3SCDrehZg2xiZqMtX8HaPX7FFHx0iKbsVxMfZef7XMU/b2LY
         5K0v5B6Li6DhEFOJHzQ8ebl2dpmc6dxIJmpmpg0lg3dScbmBNFHJWw4x9HYLF2jIGM1b
         frNPBqTA6zugoIHKHKnFfYu6UnEDmhrgBEF2GH4K+Xe0M8PBeF+a7spdMOYFfIeO0oVA
         zk0Oc7C9jzo5FfjZ6gpmbeJVtplwsqtxLxcDvZ6XNecsHsTDoAHV8MoY41m9wz9HJom9
         wF3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=L+f5IzV9nT4YAxPklsAU5borgvxb1+yqLE5tB0c9SqY=;
        b=qkK+L/s1QVesDIx3vqblbXOBePJCpVsfsc7CiWjXVzyBySXSpZrSMneytqer5Diq6g
         aejUgpa/PlV9vXkVK8rOf5fOZeDdAdEKw+G+MayaCw7ohc05ykVvNBCqXAGlK9phLGZn
         YAhDhhiQcEKPCoWHV1rSDlSYGVowAe0u8Wlqz6bl1ilFZ4a6FBrxZeEpkeF0AJWOp7zq
         42QDazeNoJXyd5pGXDOQxNz0oELfdEnILQ1GZqMNPqJECMvUDFt646hN4XMJ0IahOpK8
         yhb6NYgm7zDgwxKom+PoXvXm9e+Xh2Dzkg+sJrT8BV+tlbOKe17rBiPBD2EpvLoAsyJw
         PFLA==
X-Gm-Message-State: APjAAAWWBrD4AVsMofboDVbzkSSv4yx5MtFJNRmCw5x7EeBgP9ySgg/9
        ZrY9u4yBPbfml8t5EmTHq227XZA2a7IaFQ==
X-Google-Smtp-Source: APXvYqyEFeIUbq+e5CHDgy2+mxP1EWfRpsHF7UDRa9mCGw/nJ4BA1hJ0J5mHyWk/Zb1tSAOkonj6qg==
X-Received: by 2002:ad4:4810:: with SMTP id g16mr9394743qvy.22.1579296385102;
        Fri, 17 Jan 2020 13:26:25 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id x34sm13699445qtd.20.2020.01.17.13.26.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2020 13:26:24 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 10/43] btrfs: hold a ref on fs roots while they're in the radix tree
Date:   Fri, 17 Jan 2020 16:25:29 -0500
Message-Id: <20200117212602.6737-11-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200117212602.6737-1-josef@toxicpanda.com>
References: <20200117212602.6737-1-josef@toxicpanda.com>
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

