Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B4DD51412DB
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Jan 2020 22:26:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728827AbgAQV0l (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Jan 2020 16:26:41 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:46506 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726587AbgAQV0l (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Jan 2020 16:26:41 -0500
Received: by mail-qk1-f194.google.com with SMTP id r14so24117422qke.13
        for <linux-btrfs@vger.kernel.org>; Fri, 17 Jan 2020 13:26:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=RqkGJtTlwbicUPBLGp2IaZBBFNmS7nDH0ciMWvbfcF4=;
        b=CNmYD13Xt45bHSvyGe77D/CGeyLCpvsUZtEb9GyOXz7rNHph+8Xjyv5TI0iWCw8F6+
         M5CMKI2u5QTAgvu6al/rMDaYXnKyCNrlLKcgZlsho/RV5or//r8UVgCGJlrjR9x0T2YO
         7lsnfOHPbF6WPAMeCKQjCi+Qy3SUkBzjhtZ6qefJlM8NKd8vD95r9dgyWbGio+6tQ+Qf
         whzYizPlwoZzv3I4T0kk9XVcEObESjaO5OYh2aymDfEsDWioaBGEbsNFHeocCWYE+SOh
         tEERHXEXV0czJqHsd88lgO61kaEAH8VF/4uVzeuReJLOguKSEzu1diq4D/UIRerCQV6O
         Enww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RqkGJtTlwbicUPBLGp2IaZBBFNmS7nDH0ciMWvbfcF4=;
        b=dWozSX4NYQiGRKy6JjWe2ycOp+mPQXp9xsxcTbhUVOnr7FuKoEySSALD4jgbYuxpWZ
         ToeNQvkGgA5RqCzHco38qPffKelSZ7WYcEnvMMfpNUPEcXDXdq1LvtK581GN3flJZCvl
         Vc58iM5EPycwB5si+t51hVGAvengPldkwbmkpxprOxt1r+K5B97sNwBAsftYTRvI/k0j
         3+yp3HIkJMEjHhgfT61PkLZgTqAfssKRthwGwM8/5lclGBZzF2UxnI/eAKXE1hsH9L2h
         73DsB5RVnu32TzkwQC2FetLKGwdhkEuE0iHR8g2YfN3JyYzzN1eQLBJTQUdM9eAx5MpJ
         7Y8A==
X-Gm-Message-State: APjAAAXMUFJKTGFCH+0GI+1lf5bpEsS8Q4LPxLadDjjnW/gvTE0DEue7
        xZhXzsQjba05QPy/6hbQLiO+i6mheoFZwA==
X-Google-Smtp-Source: APXvYqzH52F1JkRb/0FUlsiH9YZCCA5BDBhMJe3QknqdrZuR4oAdZpcV/QqeXpuvQ5ZQpVlCQ0sF6A==
X-Received: by 2002:ae9:f205:: with SMTP id m5mr40428472qkg.152.1579296400074;
        Fri, 17 Jan 2020 13:26:40 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id b191sm12520447qkg.43.2020.01.17.13.26.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2020 13:26:39 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 19/43] btrfs: hold a ref on the root in btrfs_ioctl_get_subvol_info
Date:   Fri, 17 Jan 2020 16:25:38 -0500
Message-Id: <20200117212602.6737-20-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200117212602.6737-1-josef@toxicpanda.com>
References: <20200117212602.6737-1-josef@toxicpanda.com>
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

