Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8494D126F05
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Dec 2019 21:39:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727180AbfLSUjz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 19 Dec 2019 15:39:55 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:37870 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727071AbfLSUjz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 19 Dec 2019 15:39:55 -0500
Received: by mail-qk1-f195.google.com with SMTP id 21so5801007qky.4
        for <linux-btrfs@vger.kernel.org>; Thu, 19 Dec 2019 12:39:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RKtL6FOJqVDNDFTC5vTQ9i7tkVXzRFQK9imHwr2plFU=;
        b=lnCg204Kc+H/a3tLpi6yaGF+CwjOEatQDtdoHpm2sliOa6jD6Il2seBURDx1QOSLpp
         3574a7abgXdsxptvALnzqavn0uUF1vv89zBfkdSohF2rmq7eY1VBtbH6SE5RcN5TrNP8
         ZCec9ajm/OK/5SoEScbvT8DN9ln3kESA6JCnG6e1Mv5j41qpMpGlp10z3wNzWmVtrIVb
         n5DJRMbJUB4v0Cqn4l604D842IGAYG/FogWdjwVshIJlH3lhJperA47Wy6ti+qv2SbEN
         bRr2Ghspa+JoaK6PcRkrLuXVS2eBtijxVK1BmiZ4OUyylDczcVK2yAdpy9rcrtdfW4IJ
         4zgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RKtL6FOJqVDNDFTC5vTQ9i7tkVXzRFQK9imHwr2plFU=;
        b=GXIFu2bFnTdR7WKhXEbolvWsxYNNJX7o8bEvlbBN7+yWDzxspOXpidYCPY3q/wGETx
         J+37+0xaxugbv3YuoVO5wnTN3IVqGj/cET3gNkRfueu3TEmj0j/uhQ8rcRox2Usr/CC4
         vUCCbbtLKS3b6gLc1QblfHq+15gLAVxUjPKiahY0fbNq3NvIYNeks0sEsVy8EyVhJmdf
         DFcmV8hAQyWoIKxGjHY74jSJb3yv6g2Z0oAziSwubOoj4VZfw1Q5uzcry4HJbZkitTXn
         YC6G/nROnREU2/F9FUz7j0SM00J3CVAOCSqwzSHMn1Yfr4doUAngS/7mDUPGRKRUA9kh
         FvaA==
X-Gm-Message-State: APjAAAVkihtgONlLf6c+XpXdvn3lFe8ByTJKyS5bMUxyfq4J4Ds6Y2oW
        H8BF9iSzXvcKuQo4eNOoLAePfmPJOtE5Xg==
X-Google-Smtp-Source: APXvYqyEvuuaqqJDOBTTlY+5OCFSGCxnnk/b7/TaoVN2vMd4wpblUticoEzw6TGrMhwKQwlrG/Nimg==
X-Received: by 2002:a37:b53:: with SMTP id 80mr8765338qkl.65.1576787993559;
        Thu, 19 Dec 2019 12:39:53 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id d1sm2198906qto.97.2019.12.19.12.39.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2019 12:39:52 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH] btrfs: free block groups after free'ing fs trees
Date:   Thu, 19 Dec 2019 15:39:51 -0500
Message-Id: <20191219203951.50874-1-josef@toxicpanda.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Sometimes when running generic/475 we would trip the
WARN_ON(cache->reserved) check when free'ing the block groups on umount.
This is because sometimes we don't commit the transaction because of IO
errors and thus do not cleanup the tree logs until at umount time.
These blocks are still reserved until they are cleaned up, but they
aren't cleaned up until _after_ we do the free block groups work.  Fix
this by moving the free after free'ing the fs roots, that way all of the
tree logs are cleaned up and we have a properly cleaned fs.  A bunch of
loops of generic/475 confirmed this fixes the problem.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/disk-io.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index fb60d09d2ac7..ed9f10cd1797 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -4050,12 +4050,12 @@ void __cold close_ctree(struct btrfs_fs_info *fs_info)
 	invalidate_inode_pages2(fs_info->btree_inode->i_mapping);
 	btrfs_stop_all_workers(fs_info);
 
-	btrfs_free_block_groups(fs_info);
-
 	clear_bit(BTRFS_FS_OPEN, &fs_info->flags);
 	free_root_pointers(fs_info, true);
 	btrfs_free_fs_roots(fs_info);
 
+	btrfs_free_block_groups(fs_info);
+
 	iput(fs_info->btree_inode);
 
 #ifdef CONFIG_BTRFS_FS_CHECK_INTEGRITY
-- 
2.23.0

