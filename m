Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 150CA1412EB
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Jan 2020 22:28:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729137AbgAQV1D (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Jan 2020 16:27:03 -0500
Received: from mail-qv1-f68.google.com ([209.85.219.68]:38059 "EHLO
        mail-qv1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729117AbgAQV1C (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Jan 2020 16:27:02 -0500
Received: by mail-qv1-f68.google.com with SMTP id t6so11369906qvs.5
        for <linux-btrfs@vger.kernel.org>; Fri, 17 Jan 2020 13:27:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=v3jy/bucDHb1mxW6er9m37yXCMVg9C8Ly2cHcVVVXag=;
        b=n4ZPV/RYJdTKBaiTucNLsxCLXe74G1QzIl/TIrx4N2YshpsxqMSnGJ4URh194dZEGa
         ANB00Qq4eY9Cm0wpafpjv1BVAQmq3PywMB3NEfVe4VOwc6We6c8v7EPZ2SZOak7xyLO3
         IR3LJyUYGvYFI342B2DcGyX3VsbfYLE9NB/9/7yR9ur5cK6F/pw9a7XrMf6E7G1dwmHE
         yH/mSVKeh4Ug1Vy74dXf3kS7ZqITrrsYx5ooJLOLzyKvUPGBr4zf4cncaq48uzgc3w3O
         qyPJanoNfKZpPJbHBnEoGo9i7ng/CFl7ulRwxifkASmfW9f+q2QyZ0A4di3WxSradvdM
         m7tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=v3jy/bucDHb1mxW6er9m37yXCMVg9C8Ly2cHcVVVXag=;
        b=CpsNTy0Xli4G6d24RfVf1YIBRPn0XpZybweNZUiVuPdug9ZeFqOx9LxMv8NiZvWAIJ
         xKNhLHy1YJH3YM/03gb45vQ2YqxaQdObww9WsJxxQ/ON0NFxw1qJ9UoDSI0YfqkEEY68
         rXIzygNGMiw4KW3Lxt8Z4b1Xd+i+d4H7twy7F8aN90EzHycZKDzgbEp7sVaT7Sjy1VIX
         ACAccVz5ZyyxvyvYBXyNLBWmfyBIbNn/UsMJIMg31R/xMVnLSPDwGY2HTWpYJ3KorK5g
         Cye4o11ChCgLwzOJobSqNk6oPX2jbnSEv48zJu46VxzgDxh+Ta4vTHs04TeT3ofngnrr
         SXIQ==
X-Gm-Message-State: APjAAAU9cW2yzkSTvgliN3gZjjhuA+lVOV57f2VhnpIXVCiMsMsWZeN2
        ZUHcElvIJOdD3eNt7Y9UU3LBlfrjacxIdg==
X-Google-Smtp-Source: APXvYqxIbdLsEXeFfK7zKw34m5iwdL62tQPUxiNt7aLtCA2P1u0l+DAfzoDN26LA9lt213NTdKoabQ==
X-Received: by 2002:a0c:c389:: with SMTP id o9mr9980629qvi.232.1579296421486;
        Fri, 17 Jan 2020 13:27:01 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id d143sm12425030qke.123.2020.01.17.13.27.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2020 13:27:00 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 32/43] btrfs: hold a ref on the root in get_subvol_name_from_objectid
Date:   Fri, 17 Jan 2020 16:25:51 -0500
Message-Id: <20200117212602.6737-33-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200117212602.6737-1-josef@toxicpanda.com>
References: <20200117212602.6737-1-josef@toxicpanda.com>
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

