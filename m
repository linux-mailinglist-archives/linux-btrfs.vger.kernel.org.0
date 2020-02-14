Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6E49C15F878
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 Feb 2020 22:12:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388493AbgBNVMF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 14 Feb 2020 16:12:05 -0500
Received: from mail-qv1-f68.google.com ([209.85.219.68]:43190 "EHLO
        mail-qv1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387904AbgBNVME (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 14 Feb 2020 16:12:04 -0500
Received: by mail-qv1-f68.google.com with SMTP id p2so4928032qvo.10
        for <linux-btrfs@vger.kernel.org>; Fri, 14 Feb 2020 13:12:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=kH91x0iQla5n/JC581I0ZPBC8xEDj/M9IpcsYJsldyA=;
        b=VRx8YyphBYJbfvKNLS12EXN/fKHL3vXX87lSZQkIthwLerApPHBeXyIru6t+9CdmF8
         JkvtI3tbSXNbF1obPogjUjv6GHEz1aEBzTAf+UGHR55QkwjUdpbSsz4vEiEb/nl9GQqN
         qS3awws4Vt2UjIMD/iltNNMP3juCPFpqrh5t4xdVac11tRYlmcKZN4Ie8aQkldRUdS1A
         E9EqM69or2GH5Go5U3hq2pWrLVl+MtHI+mb7ogRvLfj2NfrX1gXDYwFKps6JEpAUmuW3
         27NyXV7/DkwEle25YGUBe6juYJ+DyJ/jr2Gmqwimo6I+GGOZKf7LFezfTdyzO1XFGBeD
         GIlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kH91x0iQla5n/JC581I0ZPBC8xEDj/M9IpcsYJsldyA=;
        b=V7zdZtz/JMZn2Y+qJk1SVaWTfCW05jTiEKBTlHCCdpofj9LwnJCj2sA/Z0Cg9nPOM6
         pMDwaYVQZfMoSSs8roumBPU+vJzDJfJkT3JEjxU7oNCSjYRA5HXcmF/lkgJ4FdcnBWp4
         F4lsI2el6T91h4+EeNE0cbxgmpr8qzfh+pvhfbQsbOIUtfUN9nFaPoZEhTUVT9ozpLw0
         JSy/T+SeXab/0imb5Irm47pfKy9wwbQ0YehD8X/i8NSLGJwf/T37MH5Zgdb7TcJhS7Mh
         jHH09zVuSFF94TrPhXVxlSlvemZYgYTz9fS06DFSXpV2NRm+ozMKk7eB6+Kn8Oql7y2h
         2ktQ==
X-Gm-Message-State: APjAAAUlMBThFY4w+F1WCKlW8Ot702qgFu/9awnnznIOieWm8JrjXL+f
        LN+07IF00ORhKr/0dS8d8WlKX8DbQHY=
X-Google-Smtp-Source: APXvYqx0UxqVqhM+Ruhp/WmHQSNuf+Z7gO/nxVFh/1kXqM3i3TEMsuZqJznPCi+NpcTSar6GJwdfQQ==
X-Received: by 2002:a0c:cc8e:: with SMTP id f14mr3938130qvl.119.1581714721969;
        Fri, 14 Feb 2020 13:12:01 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id 85sm3682508qko.49.2020.02.14.13.12.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2020 13:12:01 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 7/8] btrfs: make btrfs_cleanup_fs_roots use the fs_roots_radix_lock
Date:   Fri, 14 Feb 2020 16:11:46 -0500
Message-Id: <20200214211147.24610-8-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200214211147.24610-1-josef@toxicpanda.com>
References: <20200214211147.24610-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The radix root is primarily protected by the fs_roots_radix_lock, so use
that to lookup and get a ref on all of our fs roots in
btrfs_cleanup_fs_roots.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/disk-io.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 052690799d64..ca46ca3e9dca 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -3924,15 +3924,14 @@ int btrfs_cleanup_fs_roots(struct btrfs_fs_info *fs_info)
 	int i = 0;
 	int err = 0;
 	unsigned int ret = 0;
-	int index;
 
 	while (1) {
-		index = srcu_read_lock(&fs_info->subvol_srcu);
+		spin_lock(&fs_info->fs_roots_radix_lock);
 		ret = radix_tree_gang_lookup(&fs_info->fs_roots_radix,
 					     (void **)gang, root_objectid,
 					     ARRAY_SIZE(gang));
 		if (!ret) {
-			srcu_read_unlock(&fs_info->subvol_srcu, index);
+			spin_unlock(&fs_info->fs_roots_radix_lock);
 			break;
 		}
 		root_objectid = gang[ret - 1]->root_key.objectid + 1;
@@ -3946,7 +3945,7 @@ int btrfs_cleanup_fs_roots(struct btrfs_fs_info *fs_info)
 			/* grab all the search result for later use */
 			gang[i] = btrfs_grab_root(gang[i]);
 		}
-		srcu_read_unlock(&fs_info->subvol_srcu, index);
+		spin_unlock(&fs_info->fs_roots_radix_lock);
 
 		for (i = 0; i < ret; i++) {
 			if (!gang[i])
-- 
2.24.1

