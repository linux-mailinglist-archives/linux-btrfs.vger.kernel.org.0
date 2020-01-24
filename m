Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DDB16148934
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Jan 2020 15:34:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404399AbgAXOdc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 24 Jan 2020 09:33:32 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:37091 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404384AbgAXOdb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 24 Jan 2020 09:33:31 -0500
Received: by mail-qk1-f193.google.com with SMTP id 21so2204880qky.4
        for <linux-btrfs@vger.kernel.org>; Fri, 24 Jan 2020 06:33:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=UcvWdvkB+kuoKVdsm56WFQ+OEF9OJP2c6Pzz38qJFgg=;
        b=d/bECHpgVxiFosiCuIO87vwDFJ5KUkC4RY0sM3xcc3dLKVcTm2XdkICA+loVoKqYXj
         QS9Z6PDBIn+xuHipn6/uNf1g/4DOb5NMlvPEdZLEvtKWHu6fC6tE57OfOxZaWTSHZa/h
         ULnat6/90SLHUPsAQGlNEuHf4IlBGaXO4jb7BlAgkC/y91+Mns9cHJkvjvO6r64ybnUA
         5UUdZ345JsAq88Fy6NkrxlrESddMAsWcXEVpqgYzAPVSFhd4Ekbyi9b53v43A85iCmI7
         m589vY/HCbc83m2mL1W+su84LS2qIst/fmzseUwDgjHPZgjG+LBe2QbzMUMGidOsjcIm
         uNhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UcvWdvkB+kuoKVdsm56WFQ+OEF9OJP2c6Pzz38qJFgg=;
        b=p5KP6oUlBqP8dX9gIj0rdiO5FQTTHums+WZU7eiVr00mI/3aDAxLuyd0AD3A/Ne3cX
         3SHEN4/jeNVSOnkOvJPF+/d9izh1h2gZVvR1LNVdSugUcFN5ICQR0rPdsYagGFzxoW3E
         d1bdQ+esDZcvHC1YaMTpsQR3gkCDMlF/jnQ9LnydQCA0GpCD4ShBc3avEwTPLGVYxaxR
         tKbQQT/p5Nbu+cdk9N+ixrG7XmsMlUP92vzmhfZcx4E0yjdBvurflNRxKr7foU5dUyty
         Fp5ObrDcZMX0XmdP2bAvZH1OEji3jmr9qeIp69erQTazOeYNwi2b/VvGQzJ0NHG2BuqX
         /1Vw==
X-Gm-Message-State: APjAAAWOHsFF9peBGczFiSu+6mqNl+AyMcG4K80/yhDZx0PbifaN/Jn+
        vC+OXx2cBYipwjRqvYB4gOIp8w==
X-Google-Smtp-Source: APXvYqznmC1/OY1UOXxSeNhsfZV+xuJC5AuLtkltD1nL7f00yVLPxs4910D1DbPZEWVHzJLdIzf/Mg==
X-Received: by 2002:a05:620a:1509:: with SMTP id i9mr2594311qkk.447.1579876410169;
        Fri, 24 Jan 2020 06:33:30 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id x19sm3288369qtm.47.2020.01.24.06.33.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jan 2020 06:33:29 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     kernel-team@fb.com, linux-btrfs@vger.kernel.org
Subject: [PATCH 16/44] btrfs: hold a ref on the root in search_ioctl
Date:   Fri, 24 Jan 2020 09:32:33 -0500
Message-Id: <20200124143301.2186319-17-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200124143301.2186319-1-josef@toxicpanda.com>
References: <20200124143301.2186319-1-josef@toxicpanda.com>
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

