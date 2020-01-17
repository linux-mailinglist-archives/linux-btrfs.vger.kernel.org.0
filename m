Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 46EA2140B7F
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Jan 2020 14:49:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729121AbgAQNs5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Jan 2020 08:48:57 -0500
Received: from mail-qv1-f68.google.com ([209.85.219.68]:33200 "EHLO
        mail-qv1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729108AbgAQNs4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Jan 2020 08:48:56 -0500
Received: by mail-qv1-f68.google.com with SMTP id z3so10716982qvn.0
        for <linux-btrfs@vger.kernel.org>; Fri, 17 Jan 2020 05:48:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=v3jy/bucDHb1mxW6er9m37yXCMVg9C8Ly2cHcVVVXag=;
        b=Ct0ALcCnvQj2dOfwwXwNw01Pai5lhXroo2O7wWxEE1pwnScR0PCQZZjnwgEsFiVkwl
         2yGjVNHihjzdw6L+5ZHv7o/3FXV5r0aYEm/vZI8v7Y4m1G6sGZxbwudn5vmoivmuKkV0
         vQoRDlzMTnQ+oA95nH4AttgKlxig8aw9fBUEzlzfZ9iq/PRODp33xaGwVJpi2Y7mKnsz
         Z3KNPN69a0aZCgfBNaOAxBXVJVJTRP4n/sj6tre2HwBKonnzR53H3PBnQMMam+zp984V
         16vb9JBFGndls2vbx4H2ykxIlgqJcLxJJpGEvL8psKfHIDNNrSGD9b6f9DaVs1OAF0B2
         tTYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=v3jy/bucDHb1mxW6er9m37yXCMVg9C8Ly2cHcVVVXag=;
        b=S7Ydvmyby/A5kQevSWiYrRSKpWUVRBHC0nyhOJIhCtNaBoFCdcwtgOKJEVvLlxg2IX
         UhHSpH1KV26Pq+C+i2XTwAMgIHbdyM8WAqc747KuEZETIfxlOrfH0jWBDRHUwal1Yh4i
         SvIUEXiRH2+ZEGqT6rjgAm6n8GdlD6QsSX9KmgZgSHtx5y5jEo9WFtHecJKGXIzifx5B
         EbmkNDoCgD8vXZSiZJUWT5Az+d6Rn2f/TzTzw6KQQJPKrbc4fwjtjVkN4Uso8HmnfghW
         Dc1mE/rH9k8E24VtLKC5Av1H0Toz/ja5j+MQoy9YUBP6afZlQjdxv5/h7ELTeksu8oYH
         gmbg==
X-Gm-Message-State: APjAAAU3wZHgTJdKqBwylaf8gvqMF4eIbnjhesBvehjQNphu+dGvvwRk
        JUuAUwgaNiP4wI7PyxKZlMcBsD2AgUrCew==
X-Google-Smtp-Source: APXvYqxP3cE4Bn+U5juAtWseUwJnrXVwiXkWVGgWmdHzK6PTiKVL3gwllEb7OH/gRoiazwaL0yaU5w==
X-Received: by 2002:a05:6214:8cb:: with SMTP id da11mr7435546qvb.228.1579268935372;
        Fri, 17 Jan 2020 05:48:55 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id h204sm165813qke.6.2020.01.17.05.48.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2020 05:48:54 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 32/43] btrfs: hold a ref on the root in get_subvol_name_from_objectid
Date:   Fri, 17 Jan 2020 08:47:47 -0500
Message-Id: <20200117134758.41494-33-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200117134758.41494-1-josef@toxicpanda.com>
References: <20200117134758.41494-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We lookup the name of a subvol which means we'll cross into different
roots.  Hold a ref while we're doing the look ups in the fs_root we're
searching.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/super.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 3118bc01321e..5c3a1b7de6ee 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -1101,6 +1101,10 @@ static char *get_subvol_name_from_objectid(struct btrfs_fs_info *fs_info,
 			ret = PTR_ERR(fs_root);
 			goto err;
 		}
+		if (!btrfs_grab_fs_root(fs_root)) {
+			ret = -ENOENT;
+			goto err;
+		}
 
 		/*
 		 * Walk up the filesystem tree by inode refs until we hit the
@@ -1113,13 +1117,16 @@ static char *get_subvol_name_from_objectid(struct btrfs_fs_info *fs_info,
 
 			ret = btrfs_search_slot(NULL, fs_root, &key, path, 0, 0);
 			if (ret < 0) {
+				btrfs_put_fs_root(fs_root);
 				goto err;
 			} else if (ret > 0) {
 				ret = btrfs_previous_item(fs_root, path, dirid,
 							  BTRFS_INODE_REF_KEY);
 				if (ret < 0) {
+					btrfs_put_fs_root(fs_root);
 					goto err;
 				} else if (ret > 0) {
+					btrfs_put_fs_root(fs_root);
 					ret = -ENOENT;
 					goto err;
 				}
@@ -1136,6 +1143,7 @@ static char *get_subvol_name_from_objectid(struct btrfs_fs_info *fs_info,
 			ptr -= len + 1;
 			if (ptr < name) {
 				ret = -ENAMETOOLONG;
+				btrfs_put_fs_root(fs_root);
 				goto err;
 			}
 			read_extent_buffer(path->nodes[0], ptr + 1,
@@ -1143,6 +1151,7 @@ static char *get_subvol_name_from_objectid(struct btrfs_fs_info *fs_info,
 			ptr[0] = '/';
 			btrfs_release_path(path);
 		}
+		btrfs_put_fs_root(fs_root);
 	}
 
 	btrfs_free_path(path);
-- 
2.24.1

