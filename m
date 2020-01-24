Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 84A81148946
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Jan 2020 15:34:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404635AbgAXOeC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 24 Jan 2020 09:34:02 -0500
Received: from mail-qv1-f67.google.com ([209.85.219.67]:36871 "EHLO
        mail-qv1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404591AbgAXOeB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 24 Jan 2020 09:34:01 -0500
Received: by mail-qv1-f67.google.com with SMTP id f16so983132qvi.4
        for <linux-btrfs@vger.kernel.org>; Fri, 24 Jan 2020 06:34:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=v3jy/bucDHb1mxW6er9m37yXCMVg9C8Ly2cHcVVVXag=;
        b=oRRHd2ZSLlbBOFg70OvhtuuF1mK5Xpi38c2ky89qMMeEmYbOX7qS5iMWX/K9Vl0wYG
         77rnxKra5OYP1DyERCg4zeerP6m/uqdT9fsVKwAmE3kdOhuExA5xrz+aK3vQMHBHcdqz
         2UJftnNnK+kTsUyi+ZLVOiyBWr82UIoi9pr85vT4dhWIUKJRD6v92X+8LDYemiHhMO/k
         VtUeIc0TiwmUVNMW0yrOeDLMFezCuq2OzBQMjgAvXfq67r95Af+54RBLg1IGinecO/Bp
         zlSxUCy2mi+X+DW7v8f02SyAe2ovzSTyYkb/67Fd0GtI2a3sULexVQgvXgRRftPndvBT
         nWKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=v3jy/bucDHb1mxW6er9m37yXCMVg9C8Ly2cHcVVVXag=;
        b=bIHn/+9Pmgk3NvIeVmFQzi1xZLQ8FfAOAQtx3+BZolKCqoZAhQrviqdN5leopHN3bu
         8M2bXSUjD7MF3qOv8M7tWq8nTkksBh0FRlxCUbpuzxTXIAVo43u9uA2yw7ru7hgpO9/w
         lQXPaLvpkxh72YASaKcUIDQQDL4XFNQNsWOdBBQNkjYZMbW5MdZTrr9hINnHcXEzganx
         eSHW1Kk0iPYm4PsqYzQhLG8YxMoDK6QiKTKG9LgQXQzRh3iYT8uyBCtO0D/mYSYhvg6V
         HZ4t41DYIogMk4dOHjA6NUofKGLJ1Hv5Oy9jafw+bbirybJGc1pXPZ4PgOpG+cx9eo0I
         mhrA==
X-Gm-Message-State: APjAAAXyGXMy9gTkTKawvCuzEZU9+N/+iJmP6vvjs30IqTnw37bvEZIJ
        JHfNqmjmEtvyPjv/TEw7mUwXsWaBnmJZLA==
X-Google-Smtp-Source: APXvYqyiIDv4PxTtwydJWapt/rMVhGeDIZ8/nsp2JjS0CRt4mtSKfWcPMScrQrF4RcJRESYTjHI1aw==
X-Received: by 2002:a05:6214:13a3:: with SMTP id h3mr3060286qvz.212.1579876440654;
        Fri, 24 Jan 2020 06:34:00 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id f28sm1336368qkk.130.2020.01.24.06.33.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jan 2020 06:34:00 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     kernel-team@fb.com, linux-btrfs@vger.kernel.org
Subject: [PATCH 32/44] btrfs: hold a ref on the root in get_subvol_name_from_objectid
Date:   Fri, 24 Jan 2020 09:32:49 -0500
Message-Id: <20200124143301.2186319-33-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200124143301.2186319-1-josef@toxicpanda.com>
References: <20200124143301.2186319-1-josef@toxicpanda.com>
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

