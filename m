Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0EC0711537B
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Dec 2019 15:46:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726511AbfLFOqR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 6 Dec 2019 09:46:17 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:44350 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726268AbfLFOqQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 6 Dec 2019 09:46:16 -0500
Received: by mail-qt1-f193.google.com with SMTP id g17so1376113qtp.11
        for <linux-btrfs@vger.kernel.org>; Fri, 06 Dec 2019 06:46:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=HltDQJl7stAB1vD8G+8gZKXtWOW2fcNixCaDMOY4h3g=;
        b=uVE3+hOYCdkUwOFWnOja5PA46E5LJl8rKLa6ielCevlw3vkHBmQL/rhxUFHhFBwWqR
         HZqMa1vs+WviEGBWVRYctbXUr0zaclHz5FgxS9H1haDrvXgQkn6H6jZwXe+khCA3fewN
         WXmtaIItPifcb8+Af57y0cLv53zW+OMJKHLGEzN+V/dDrdhFX6a3LwrOB1eeTSejjGB2
         51tvLivYhTaiq/mzhxJVnUMvDheHL1JxkuCZoTTuIBXVtdm40gNeDp6dMYwkM0Ri8LOf
         8LAQ66o6C0QgYjpx58nuChTXGpG5sadv0ENzOMrSki4FUYcEcmq6BG11jTww0duGzC0k
         JdGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HltDQJl7stAB1vD8G+8gZKXtWOW2fcNixCaDMOY4h3g=;
        b=U3nZ9MVH0+YvXJnMeGXW1UXitMHyZNLJAxkXnd0fnwyn6b5IdI5ne5/jxneSXCAfcb
         UzHS6SAOmnt43h7BaE7jbzothb8LFMn5th1DQLbMUnMH+Xzl1W98KxAZBqjOA2NvsoKM
         +E/+Xuyw4RQk97XTh6+NJnomPr9llMXkSQwRmB8OYRnw7CbHqJES/Je38SjMZOX3cXov
         Ljdr59O0M8gBXtGoI+pLf6KiO7hXrGHitldNolxj2J7j+O0NDOhaEFxapSjy+kxcCQDH
         zGIeHMNUA1ommTgNCBWqkIZlcd8bP2Og2NgS/+ZsCs4BxOJFSmymRzGH2NugzJ22EL0K
         UHlQ==
X-Gm-Message-State: APjAAAUJ76gIW8x1fNBkg4DA3kJQFE+eH9Xz5h4AGCBi7DXNN6VE6PFY
        EXH0eMxiyP7DmP/7gZnRK1Az63GrLzPs0g==
X-Google-Smtp-Source: APXvYqzeVxi1Wa/7YFRhVNZGHYNh8dcAQmMonAGoeXQNE/XlDqh6SLVsnkWxAhiLTS9VOcAOgCUm0g==
X-Received: by 2002:ac8:1afc:: with SMTP id h57mr12877188qtk.250.1575643575238;
        Fri, 06 Dec 2019 06:46:15 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id y3sm233900qti.57.2019.12.06.06.46.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2019 06:46:14 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 19/44] btrfs: hold a ref on the root in btrfs_search_path_in_tree
Date:   Fri,  6 Dec 2019 09:45:13 -0500
Message-Id: <20191206144538.168112-20-josef@toxicpanda.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191206144538.168112-1-josef@toxicpanda.com>
References: <20191206144538.168112-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We look up an arbitrary fs root, we need to hold a ref on it while we're
doing our search.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/ioctl.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index e01363cd2bbe..b8b5432423e6 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -2328,6 +2328,12 @@ static noinline int btrfs_search_path_in_tree(struct btrfs_fs_info *info,
 	root = btrfs_get_fs_root(info, &key, true);
 	if (IS_ERR(root)) {
 		ret = PTR_ERR(root);
+		root = NULL;
+		goto out;
+	}
+	if (!btrfs_grab_fs_root(root)) {
+		ret = -ENOENT;
+		root = NULL;
 		goto out;
 	}
 
@@ -2378,6 +2384,8 @@ static noinline int btrfs_search_path_in_tree(struct btrfs_fs_info *info,
 	name[total_len] = '\0';
 	ret = 0;
 out:
+	if (root)
+		btrfs_put_fs_root(root);
 	btrfs_free_path(path);
 	return ret;
 }
-- 
2.23.0

