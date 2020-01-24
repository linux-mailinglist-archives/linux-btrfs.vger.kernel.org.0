Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 12AA1148939
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Jan 2020 15:34:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404505AbgAXOdi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 24 Jan 2020 09:33:38 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:36801 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404404AbgAXOdg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 24 Jan 2020 09:33:36 -0500
Received: by mail-qk1-f194.google.com with SMTP id w198so950361qkb.3
        for <linux-btrfs@vger.kernel.org>; Fri, 24 Jan 2020 06:33:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=RqkGJtTlwbicUPBLGp2IaZBBFNmS7nDH0ciMWvbfcF4=;
        b=vuTeyCSonUDccR/MiEr2kG1M+c7cl/qOhrSOxioDFcmJAVj/ftK+zWldM0E/pJVv58
         X6u/AqsAULToLX6hX1P7cb8Z3PXvBXThqtw8VbJj9PXgy+lFxXpYdOyKRNWOgcF9JyvO
         8GOfo0TO7mttaIHA/DPYw80LI/RIFl2HLCTavZ8MtwSoWyL1LCUW0/rzA8ys+sypVUq7
         mkp5jcVPoKgD1SfEwWd79AKUlakaD46wb68taWdDK+KiM1f8ED7HIXUj5wIQw99bBfBv
         8LaIQ0egoXvIYANB5/xWHhgyG/KnBrCjWNrRUg1o0+JP7JUCXEAAf9fnJeFMoMQz9g4R
         rPGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RqkGJtTlwbicUPBLGp2IaZBBFNmS7nDH0ciMWvbfcF4=;
        b=Pxy4ACx1uiBaKg1lWCteQn0y0BA8HaR107iPCjnj7KC9H7UKvoG/FqSLy0FYEwiH7v
         QkZ84Q59yCNqiacVCj/zRU52ckUxcYa2PhpCAUINIzVlGIl5+7W+jfCcUeOP3EV05dxz
         qWOQi2p0+Tgbt2+sFeBDq2P3u4YNpMlmHpxlws8XjyZTMy0QpRZNYTYfJX0IHRkGj5VZ
         mlWDlwbMzesp2pQ+xBCXwOYVJQpqndC2YFQeA4MoeXrlOKnztaYK4JrorEWAn7pXexo2
         A3puhgBcYGCXWdkUgBLQDpuEIHenQkfm8/VjarzFxkHkS+nxFcodmolb62nAZo/X7q0E
         yCpw==
X-Gm-Message-State: APjAAAWgOO/bhHbsskzgZ7JCPfrzxUpzgmjB2vB45mER07yzV8kX5X2M
        xnoc6BSPHY9i2c7wjFkO5zCBbWNuhHOTNA==
X-Google-Smtp-Source: APXvYqzmt7vr74RNzCBE+S99Jw1Muocx8sE11NQiLYmww7bw2ZN8qfpKxm743W8C0lLxIRjKuY6sqA==
X-Received: by 2002:a37:9c8b:: with SMTP id f133mr2728924qke.375.1579876414986;
        Fri, 24 Jan 2020 06:33:34 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id k62sm3109856qkc.95.2020.01.24.06.33.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jan 2020 06:33:34 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     kernel-team@fb.com, linux-btrfs@vger.kernel.org
Subject: [PATCH 19/44] btrfs: hold a ref on the root in btrfs_ioctl_get_subvol_info
Date:   Fri, 24 Jan 2020 09:32:36 -0500
Message-Id: <20200124143301.2186319-20-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200124143301.2186319-1-josef@toxicpanda.com>
References: <20200124143301.2186319-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We look up whatever root userspace has given us, we need to hold a ref
throughout this operation.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/ioctl.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 5fffa1b6f685..7d30c7821490 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -2683,6 +2683,10 @@ static int btrfs_ioctl_get_subvol_info(struct file *file, void __user *argp)
 	root = btrfs_get_fs_root(fs_info, &key, true);
 	if (IS_ERR(root)) {
 		ret = PTR_ERR(root);
+		goto out_free;
+	}
+	if (!btrfs_grab_fs_root(root)) {
+		ret = -ENOENT;
 		goto out;
 	}
 	root_item = &root->root_item;
@@ -2760,6 +2764,8 @@ static int btrfs_ioctl_get_subvol_info(struct file *file, void __user *argp)
 		ret = -EFAULT;
 
 out:
+	btrfs_put_fs_root(root);
+out_free:
 	btrfs_free_path(path);
 	kzfree(subvol_info);
 	return ret;
-- 
2.24.1

