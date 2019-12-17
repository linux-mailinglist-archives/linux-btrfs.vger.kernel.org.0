Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 77232123083
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Dec 2019 16:37:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728374AbfLQPhM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 17 Dec 2019 10:37:12 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:41568 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728342AbfLQPhM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 17 Dec 2019 10:37:12 -0500
Received: by mail-qt1-f193.google.com with SMTP id k40so3113490qtk.8
        for <linux-btrfs@vger.kernel.org>; Tue, 17 Dec 2019 07:37:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=NuQnZrNm+zWRDf4U3gbj/yt1uwasHUr7OtgrIEG2bHM=;
        b=eAWvvyTBz4WNE4bo5wWBQqbeFXKSryhzvVrDL5tzK7IeGmSO2pvuz0kc80THM6hnLI
         OA7Yq+qSxHhcoGGK3eJmU5WRgPecyTwuZRMCmoLuwW2Eu4lqXxOCG390V3I94UO9LFpX
         a1tBixsEwBJKxp0CIut7bs+Vjd7baCF2PA9M+j/42r5XWo11jGg8GLHsdSCMw7WDIrwj
         OHkfCfOVklJK72n6x5oqz7+6DcPmsUhVAeceCwompqGoBTIyfMO9Unf+7vlLu2VpA83M
         U38NzH3ejRfzyDp0WRuI+poQ4kQECLXbZbzZv7t6Y7yXmhvDly5Gxi6A9Frp1mhs7+3K
         2BeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NuQnZrNm+zWRDf4U3gbj/yt1uwasHUr7OtgrIEG2bHM=;
        b=eWbMDkcHlF95ks6ltZsoYTaB69WSv/zB70KDXoHbRBE+DBrAwLYYEsAu9yhM9oMF+D
         SFbt8ZcQYg2SarNQSQWs59H58H3T5+r/LG2S/zLnaR64J483iAKsUnUPkJf1OY0EZsQj
         kivu1p0fzvgynxOl91ptNnqI1JS7V1kb5L6rrkZBEn5f3Gulu/+aqmwu9AUs8D/fsNZX
         mnOTBb7dKFHEhYPM4jDyKrl4Dqio73gZcyGWhoo54L+vZD+fhj1/PN4+BSJJuQ4HZeoo
         94OVVwidroaje64jf1dsAtimANmDo/ZUBIcKveD/ngurYSZ970Mtq73eqieYmG/2Uiuf
         wxgg==
X-Gm-Message-State: APjAAAXaQxDdxL08BWeWJejO6OcbDoBr9OWi5ZiH+ZqqE8eN32eBkCKI
        WsQyOnvvb1LfSM9nV7k8Nip2mxp6NHysOQ==
X-Google-Smtp-Source: APXvYqxzH9T2Vf5wRMpje1zgaYAxYMMywhHpR3607nJlhFBgfQHFOjsXQuVVfKhYzqoaItKMfKKmWw==
X-Received: by 2002:ac8:7b4f:: with SMTP id m15mr5115076qtu.48.1576597031041;
        Tue, 17 Dec 2019 07:37:11 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id i28sm8397629qtc.57.2019.12.17.07.37.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2019 07:37:10 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 18/45] btrfs: hold a ref on the root in search_ioctl
Date:   Tue, 17 Dec 2019 10:36:08 -0500
Message-Id: <20191217153635.44733-19-josef@toxicpanda.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191217153635.44733-1-josef@toxicpanda.com>
References: <20191217153635.44733-1-josef@toxicpanda.com>
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

