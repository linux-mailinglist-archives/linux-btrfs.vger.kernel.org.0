Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4DF10115370
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Dec 2019 15:45:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726404AbfLFOp5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 6 Dec 2019 09:45:57 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:46569 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726234AbfLFOp5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 6 Dec 2019 09:45:57 -0500
Received: by mail-qk1-f193.google.com with SMTP id f5so6612288qkm.13
        for <linux-btrfs@vger.kernel.org>; Fri, 06 Dec 2019 06:45:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=eM74Qhf90adFFXMMYOsNfwd0edDFEp5pWt/y2NDeBzU=;
        b=tMaJOVV7OgSBwSLD+NHGSU/TMJc7VBtm+qmT0Ot/7elZ+F0xLldBffsV/lLuyHqITA
         Bepk6lmCUj1ajMH1CM1YOIzNpRNeBSUY2DwK1v+/Ao98GHez13zAoRcQadfT08PHclhJ
         5ptx6epfKP3TUKbBSZ0jRkl9dR9M8MEFo24QEIYgn3nIkZwNHu38MzJ0Pdr5mSze3ObT
         Rz31AvILRGBR2eehyGcRUjwB2/6+wQEBsfXdaz+UkE8El8EafaRhTsQhFs/PPtsSvorl
         5ANaiUImLUigW+v8EMjr4lVVoz5+2RI5kmvD4bMGmnEeEUzmQzH2Ug6UuULZoLZdeLC0
         JzTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eM74Qhf90adFFXMMYOsNfwd0edDFEp5pWt/y2NDeBzU=;
        b=bwZ4EJT1Kg9xZTORL2TK+AZriyQM8yuy2b2O+8sghHVpNugpoVsNeB6BxrYhrQqKGp
         PW5CD8s2i5sciFLLteIK/6MA1VRwhtJ/9wP2v4gjhb3xh34tcC5xwDPgwSbwble6vvV5
         AySknkLy2LBg+DQIaXNhz+c1JKHYANSc4WDb88DVJX8aPIoLzWJ0uCIVVvjcLqD/ClUy
         8cKJ9PaWlE6G0gfRppI+hnNg2SDOvK8geQdzHzkHwwfz5nS5zSLvhvtFsh0ORz0nhTdY
         GSJ4yCwIw87sdJ8su3wcc+ZMLk+Pg5Huh93vP00f2Y9dj7v60RW9Kq3t7X24tK1b48Cf
         XGIA==
X-Gm-Message-State: APjAAAU33RgR27DVowTNF5ouuVq0SogDIeyKMvLoafgxslhrX4r0XGYW
        3RJ4l0YccChSZDw9cQaz2Ld7IswToWU4ow==
X-Google-Smtp-Source: APXvYqwXmW981PmO1cEnJnIaw5Uasqtg/QItWNCWq0FJ5W7MqmT93HfYvmdj3iMvSUnb1XzieP7YZA==
X-Received: by 2002:a37:27cf:: with SMTP id n198mr14062447qkn.188.1575643555589;
        Fri, 06 Dec 2019 06:45:55 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id f13sm6247307qtj.14.2019.12.06.06.45.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2019 06:45:54 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 08/44] btrfs: make the fs root init functions static
Date:   Fri,  6 Dec 2019 09:45:02 -0500
Message-Id: <20191206144538.168112-9-josef@toxicpanda.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191206144538.168112-1-josef@toxicpanda.com>
References: <20191206144538.168112-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Now that the orphan cleanup stuff doesn't use this directly we can just
make them static.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/disk-io.c | 6 +++---
 fs/btrfs/disk-io.h | 3 ---
 2 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index fba2ca4965c4..4c55db4b3147 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -1439,7 +1439,7 @@ struct btrfs_root *btrfs_read_tree_root(struct btrfs_root *tree_root,
 	goto out;
 }
 
-int btrfs_init_fs_root(struct btrfs_root *root)
+static int btrfs_init_fs_root(struct btrfs_root *root)
 {
 	int ret;
 	struct btrfs_subvolume_writers *writers;
@@ -1490,8 +1490,8 @@ int btrfs_init_fs_root(struct btrfs_root *root)
 	return ret;
 }
 
-struct btrfs_root *btrfs_lookup_fs_root(struct btrfs_fs_info *fs_info,
-					u64 root_id)
+static struct btrfs_root *btrfs_lookup_fs_root(struct btrfs_fs_info *fs_info,
+					       u64 root_id)
 {
 	struct btrfs_root *root;
 
diff --git a/fs/btrfs/disk-io.h b/fs/btrfs/disk-io.h
index f5ef9ace903a..5b38558e164d 100644
--- a/fs/btrfs/disk-io.h
+++ b/fs/btrfs/disk-io.h
@@ -60,9 +60,6 @@ int btrfs_read_dev_one_super(struct block_device *bdev, int copy_num,
 int btrfs_commit_super(struct btrfs_fs_info *fs_info);
 struct btrfs_root *btrfs_read_tree_root(struct btrfs_root *tree_root,
 					struct btrfs_key *key);
-int btrfs_init_fs_root(struct btrfs_root *root);
-struct btrfs_root *btrfs_lookup_fs_root(struct btrfs_fs_info *fs_info,
-					u64 root_id);
 int btrfs_insert_fs_root(struct btrfs_fs_info *fs_info,
 			 struct btrfs_root *root);
 void btrfs_free_fs_roots(struct btrfs_fs_info *fs_info);
-- 
2.23.0

