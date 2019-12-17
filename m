Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CF61D123086
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Dec 2019 16:37:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728435AbfLQPhS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 17 Dec 2019 10:37:18 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:39414 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728150AbfLQPhR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 17 Dec 2019 10:37:17 -0500
Received: by mail-qt1-f193.google.com with SMTP id e5so7745956qtm.6
        for <linux-btrfs@vger.kernel.org>; Tue, 17 Dec 2019 07:37:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=nY6S260pkkxadnMHJ613U0xHjLJQFjsfniOa6pD87ek=;
        b=N711CevJiC3lKpAPFWxrie630U/KhLVG8ZdW/rOQD7ormc47Wx//B5sLoH3s4aYPsd
         Woe7jb2796TjN5qN2BTR7hZA9gwnFFkFCAQWWSK3eKitQ9vwJA0UOLmZevQLHt1z+F/O
         8Y3+u7T8lyUeb+fpTwuSCcf3cAmNEOlsG7y6uHjSgFlBxaOEjklLq+45rVpGKD0bvqrI
         xb/2ZQD5RDWFKu8t2vqT2AZLp6AZrZGbLdh89BJMhm7qqvSiLXYui+WqeGjSq2tKNydi
         HZlWQEt5OtCs1O4Pw6tmADMT2NEC1/QruSbakKO3GHetvUGcieoAkxNUYUfsEr113lku
         xyGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nY6S260pkkxadnMHJ613U0xHjLJQFjsfniOa6pD87ek=;
        b=WJK8dHljkUWbfpl+D1XzaT1Dp0KyKzZ6uG/G4HChF+0keHUza5Sa4kEekB69YmoGDt
         JPgiZOytcyWxFiKsFpF9wDCViSUrYslEa2inlkfvuo/1L/nLV3Qcl/4qXPsAPV+lstDu
         TnuMEzpjIibZZPylPxyx61u8HRfm4KPG9YwNtUsMQzKrTtyuDv0WgENUxzVrDxE4f18g
         EFTL83NN71JPWZlXd18GxG+yG0N6HoUrdQ7Dl2KW5c7Kiqol1aVf6REt+9LmH6PHkuAJ
         lPF2IXGOWwSw7Vf48Z51dUIVBaTYFbHaL9ZQilVKRXouA6gML90x02PtfWz7e82UXU94
         Hk3A==
X-Gm-Message-State: APjAAAUL82m8hFFjcQTTeKRG5m+A83/269I8EiAyVovFKSlZqQqooDE3
        y0e5GMXI/jnejj7A252RXy8vVQV/DooQGA==
X-Google-Smtp-Source: APXvYqzqeSjNABW7WZHvloV6Y463YlMQymHNEO3fBAlmsIf6N7vyZv0qceBRooRhbqqJ0Km1kqvoQg==
X-Received: by 2002:ac8:1385:: with SMTP id h5mr4931550qtj.59.1576597036338;
        Tue, 17 Dec 2019 07:37:16 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id p19sm8391666qte.81.2019.12.17.07.37.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2019 07:37:15 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 21/45] btrfs: hold a ref on the root in btrfs_ioctl_get_subvol_info
Date:   Tue, 17 Dec 2019 10:36:11 -0500
Message-Id: <20191217153635.44733-22-josef@toxicpanda.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191217153635.44733-1-josef@toxicpanda.com>
References: <20191217153635.44733-1-josef@toxicpanda.com>
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
index 2eb5a5dc07bd..2797a1249f25 100644
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
2.23.0

