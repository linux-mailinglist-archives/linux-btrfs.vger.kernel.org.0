Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 508511412D7
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Jan 2020 22:26:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728780AbgAQV0g (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Jan 2020 16:26:36 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:35749 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726587AbgAQV0g (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Jan 2020 16:26:36 -0500
Received: by mail-qt1-f194.google.com with SMTP id e12so22923167qto.2
        for <linux-btrfs@vger.kernel.org>; Fri, 17 Jan 2020 13:26:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=UcvWdvkB+kuoKVdsm56WFQ+OEF9OJP2c6Pzz38qJFgg=;
        b=wBA2ZMQmy0DP5f9Q4/u/qrFfggxjH5FKEVbDPnVNAwsFFEiv+ep92yfLhWqMxmXiQo
         MPuTQk1NKd4M5WReAv+vFiSMaa0TVNEZKLSBLYWYqF+sWcDG48I/YlFx5hT1SNtkq2W5
         i2fnSuicZItBFfx3uM9rB52KVnayX2TI6AQ682znAIgmUncqDr1Cwp6+uT2GRF+UEPio
         27g3oEuuBM7dacP4BiK7z/R8RAEG9yhJRjg0zlrAnIANoIK+t81uMUXFkD7Rnkfi5MJQ
         vB67ecruDc+xaGlS/JeES3p/+uaLMYtZk5sfkQ69Ch+NL++m0BLIb2tVrtmwN5uU7yDk
         ffwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UcvWdvkB+kuoKVdsm56WFQ+OEF9OJP2c6Pzz38qJFgg=;
        b=Ag8sXEA6zqytJv+GYbVoqh8QFSTZ8hI6nJyb+ViPs0Con9ppvLTfikNA1GhnBwUsXG
         Ku48NvZVItAq5dtu6CsZe2NkVZhKGJCflevowqLAm6KaIrJvHfVf6q20ph8mz61BDCLs
         38gyyP432uAnk7x+rpmqKGDCSEftrxMjn4IJR1akDeSfiRTa5h/8cqJZGWBWWEL1TSFg
         vfBjf+9yHeh3+gUaFOGXV3MsL3b3BTjq6/5C+NDKsjhWaFTEbghKjl54K0SUhxwLy6+l
         40vZT0O2CeHbnaXeibt5Xo+duuAemsKJfKfe/nEHOblrDZIUuVmXMtRy+Ue0nAtLBS7n
         Fhag==
X-Gm-Message-State: APjAAAWX2930epx/c0oNxdFgWRZg5NXUBFkkXLjmabLiu5M9dh9/wma1
        fn3v7sSpr7e7X4WIQN0vbL3R2ySCUcX7SA==
X-Google-Smtp-Source: APXvYqxDrnIFu0SIxiPxd1hwNDpTkXjXZuM8t40blTGVk00HjVIJXnut87BuuwRnSaKaBNNxGjQfUw==
X-Received: by 2002:ac8:1a19:: with SMTP id v25mr9730942qtj.146.1579296395038;
        Fri, 17 Jan 2020 13:26:35 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id 124sm12265978qko.11.2020.01.17.13.26.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2020 13:26:34 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 16/43] btrfs: hold a ref on the root in search_ioctl
Date:   Fri, 17 Jan 2020 16:25:35 -0500
Message-Id: <20200117212602.6737-17-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200117212602.6737-1-josef@toxicpanda.com>
References: <20200117212602.6737-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We lookup a arbitrary fs root, we need to hold a ref on that root.  If
we're using our own inodes root then grab a ref on that as well to make
the cleanup easier.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/ioctl.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index b1d74cb09cb4..62dd06b65686 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -2180,7 +2180,7 @@ static noinline int search_ioctl(struct inode *inode,
 
 	if (sk->tree_id == 0) {
 		/* search the root of the inode that was passed */
-		root = BTRFS_I(inode)->root;
+		root = btrfs_grab_fs_root(BTRFS_I(inode)->root);
 	} else {
 		key.objectid = sk->tree_id;
 		key.type = BTRFS_ROOT_ITEM_KEY;
@@ -2190,6 +2190,10 @@ static noinline int search_ioctl(struct inode *inode,
 			btrfs_free_path(path);
 			return PTR_ERR(root);
 		}
+		if (!btrfs_grab_fs_root(root)) {
+			btrfs_free_path(path);
+			return -ENOENT;
+		}
 	}
 
 	key.objectid = sk->min_objectid;
@@ -2214,6 +2218,7 @@ static noinline int search_ioctl(struct inode *inode,
 		ret = 0;
 err:
 	sk->nr_items = num_found;
+	btrfs_put_fs_root(root);
 	btrfs_free_path(path);
 	return ret;
 }
-- 
2.24.1

