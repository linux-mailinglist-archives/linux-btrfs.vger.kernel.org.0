Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 932E311537A
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Dec 2019 15:46:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726501AbfLFOqO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 6 Dec 2019 09:46:14 -0500
Received: from mail-qv1-f65.google.com ([209.85.219.65]:34772 "EHLO
        mail-qv1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726268AbfLFOqO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 6 Dec 2019 09:46:14 -0500
Received: by mail-qv1-f65.google.com with SMTP id o18so2736171qvf.1
        for <linux-btrfs@vger.kernel.org>; Fri, 06 Dec 2019 06:46:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=NuQnZrNm+zWRDf4U3gbj/yt1uwasHUr7OtgrIEG2bHM=;
        b=s7JlJCCeIwuSiKcBxRqn0ukfy1uOqIRNgclWp7zMbPhHi/TP3ImE6FjQAZBHH4joOy
         UI3bhBuouBVHY8G6UaT5coGzsDXUi4s6hcGexEuj9ksZSCB9m78efY9oO2q+mi+hEgzo
         8LXh9cYqYwDgmoQOWB2K2gBC3HPTf4DZe209qb2UnNTn2eqs2vCar08DgIT5LtolmRce
         8XNeLeOcHw5dMEt27N1y9HOX0hFGxJmHjOMcakIRggvmnWWk+0iBkaOM70w17cLBUhjN
         dxWG1QFC2PoJQXjlQmziMX3m+k3qFUWbnpbLt2kVlVfmvYBmkWOjP1ePt/XXRRRnmQsV
         0vvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NuQnZrNm+zWRDf4U3gbj/yt1uwasHUr7OtgrIEG2bHM=;
        b=mXzI1WfGpp2F7hlet/2urthjRkWqyFmCzhNhex0hzmHbcsZZYK0nLTyrtNrUvCXPXe
         Z/eU1SVBFsEdRB30YbOPx2Ma11fAHFOg74pMg0hUtEr8SjhlrwxmGUXPOHuA9Ws4zgB0
         /M+U9DMLn1xA80wOhk7u5inzGl50wdhUfjlQpleRQzCPfxJutKiX2yKzqyxYSoutp01R
         naNtawLODhHMKYprRe8tu+2Bbqnj7zooCe0NK341+S4h6NXetpFhwvHdxvwfO6VGSkqE
         LOGbz9pOYPbetS7o8qNZ9JIlMzuDFP001YYkmHW5+SosS9azJ+u9ADrDa3Sw1IYVCHKh
         7ObA==
X-Gm-Message-State: APjAAAWo+dMIslgqGgzfOdtvjk2XSagv6gju9skrHLl2peC9rPQPRE88
        99ko47UveGS2M7LWF6luGaZ01zcTXHI+iw==
X-Google-Smtp-Source: APXvYqySAOuj6/RmFePM7E0yOzLMtK9L9Om1UQjy7D9v7rno+2/ipIF3WOnUjQ87R3De5duUPB8Yjw==
X-Received: by 2002:a0c:d6c8:: with SMTP id l8mr13094291qvi.44.1575643573214;
        Fri, 06 Dec 2019 06:46:13 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id f26sm6462532qtv.77.2019.12.06.06.46.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2019 06:46:12 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 18/44] btrfs: hold a ref on the root in search_ioctl
Date:   Fri,  6 Dec 2019 09:45:12 -0500
Message-Id: <20191206144538.168112-19-josef@toxicpanda.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191206144538.168112-1-josef@toxicpanda.com>
References: <20191206144538.168112-1-josef@toxicpanda.com>
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
index 29c363a70fe7..e01363cd2bbe 100644
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
2.23.0

