Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BD8FA123092
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Dec 2019 16:38:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728624AbfLQPhh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 17 Dec 2019 10:37:37 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:40873 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728130AbfLQPhh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 17 Dec 2019 10:37:37 -0500
Received: by mail-qk1-f193.google.com with SMTP id c17so7786779qkg.7
        for <linux-btrfs@vger.kernel.org>; Tue, 17 Dec 2019 07:37:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=8+BtdMJI5uKLStglB8bT7gvqEGLI3R/yUBUc0OKAnGo=;
        b=x1HkGmwRUIf7VJI69bdygwJ8hOedBZDYZUOMgIb8kC7C6VNGYorG6RryVR3zbj2t03
         jyvRRast+ngUV1FtJnz/fNqzMaNZBlsxQx3uIxRjhT2CmsPLU33jnKJ0GvxIKvLtrKVp
         +WKH1wZorQDH1gnW9NzW5bB2TLefuikiNiiTVN7H1/xGvS1qF6jF0r9hiPvGGyl76bIj
         SV2HyMtMg2JhobFzr0HGYFwFF2fSgLdjVKqEWatH6fwUVIQWDMIDkT2vWyV8nN2CxC1E
         zEae1GUcddSs36ontawQhONjhJcdbaFWBaU5aZl/Lxx7STIAToRNrx8eDcV8fBsAX0dQ
         Brgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8+BtdMJI5uKLStglB8bT7gvqEGLI3R/yUBUc0OKAnGo=;
        b=MLDW8dI9eIK1nIQHDL25mAWV1zxg9HSig6b6ACTgBRmvQPD+bSDa5WqPxAdMvH+N2J
         rmnDhXx07sTQm4qmojzFiPOMk0wt52R5Ih77/VFr0ONgO83NYKs9mAYSC+O18DZdvvPQ
         B4fr1oGWDSsTkOICUa0p4Z3i1ktqaVeCX4ShVvNbD/M+PImVLlBH/YCmOTLEY5D8mBP0
         dvTLmHcv/hytjKaqukQN6QRkjEvHuesfFceubuaXMPFSdlmjnBVBzfMwV9kvfF5s3EyB
         ewH6HNe6315go9oPyNHjjg6pIzCYjlkh559pA4pN2TjmSXRWbdZkzZQijqS+5Wr5oafc
         Or5w==
X-Gm-Message-State: APjAAAWxk3tQnELA/BzXbSlOYfKFchYE9PZbAiRC7McHZm2Ubn2ZA+kB
        MqPXG6b+B65/32SZVMKu448G/v2I2+s1bw==
X-Google-Smtp-Source: APXvYqxV/T4TRJG6z7ehk6RBABhOCDUCz9x4AT9zie8Wc6o2c4kIXngoPzCGBPKfZspyCWck7QxX5g==
X-Received: by 2002:ae9:f819:: with SMTP id x25mr5723123qkh.192.1576597056298;
        Tue, 17 Dec 2019 07:37:36 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id a24sm6981687qkl.82.2019.12.17.07.37.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2019 07:37:35 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 32/45] btrfs: hold a ref on the root in scrub_print_warning_inode
Date:   Tue, 17 Dec 2019 10:36:22 -0500
Message-Id: <20191217153635.44733-33-josef@toxicpanda.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191217153635.44733-1-josef@toxicpanda.com>
References: <20191217153635.44733-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We look up the root for the bytenr that is failing, so we need to hold a
ref on the root for that operation.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/scrub.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index eed3a8492092..904e860c509c 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -657,6 +657,10 @@ static int scrub_print_warning_inode(u64 inum, u64 offset, u64 root,
 		ret = PTR_ERR(local_root);
 		goto err;
 	}
+	if (!btrfs_grab_fs_root(local_root)) {
+		ret = -ENOENT;
+		goto err;
+	}
 
 	/*
 	 * this makes the path point to (inum INODE_ITEM ioff)
@@ -667,6 +671,7 @@ static int scrub_print_warning_inode(u64 inum, u64 offset, u64 root,
 
 	ret = btrfs_search_slot(NULL, local_root, &key, swarn->path, 0, 0);
 	if (ret) {
+		btrfs_put_fs_root(local_root);
 		btrfs_release_path(swarn->path);
 		goto err;
 	}
@@ -687,6 +692,7 @@ static int scrub_print_warning_inode(u64 inum, u64 offset, u64 root,
 	ipath = init_ipath(4096, local_root, swarn->path);
 	memalloc_nofs_restore(nofs_flag);
 	if (IS_ERR(ipath)) {
+		btrfs_put_fs_root(local_root);
 		ret = PTR_ERR(ipath);
 		ipath = NULL;
 		goto err;
@@ -710,6 +716,7 @@ static int scrub_print_warning_inode(u64 inum, u64 offset, u64 root,
 				  min(isize - offset, (u64)PAGE_SIZE), nlink,
 				  (char *)(unsigned long)ipath->fspath->val[i]);
 
+	btrfs_put_fs_root(local_root);
 	free_ipath(ipath);
 	return 0;
 
-- 
2.23.0

