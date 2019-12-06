Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0675311538A
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Dec 2019 15:46:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726673AbfLFOqm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 6 Dec 2019 09:46:42 -0500
Received: from mail-qv1-f66.google.com ([209.85.219.66]:40062 "EHLO
        mail-qv1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726264AbfLFOql (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 6 Dec 2019 09:46:41 -0500
Received: by mail-qv1-f66.google.com with SMTP id i3so2721044qvv.7
        for <linux-btrfs@vger.kernel.org>; Fri, 06 Dec 2019 06:46:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=etKLBG9v+n8eeFTRJEZ/+UjoGM5jhhzFStGHRUUo6WM=;
        b=qcpo8vlnv0nGlyhMS2dVqFttBxwyd+ne9XhEze4X0IXmYltqsnReyuupNd7HEuib36
         m/bR5AntX87fHblfOAYOPfRDee0cYySogfvsZi5MbsmkWM0BCOX6rp8TTgpFjv/S6aRi
         6/Ww+RcTAOP8KbkIGi4mEtIedRVnSPezKU0lZaXEaWgKQMg81wDxSPK4zJ1EkUhqtJ25
         u3VfPieD+MQPXWseyjReTkIYDGIkOiZXpF7+CqWhXdtiiF33bKeevz+9hKpTJD0nbYFO
         iyOyz5Yaqr6wFw0SXrYUFynwSBNmeG9RIbOkbaQY4Z8vEPjOemlmkpoi9WGDKlgB5ECw
         2wrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=etKLBG9v+n8eeFTRJEZ/+UjoGM5jhhzFStGHRUUo6WM=;
        b=d6gxdh5KAX7KFmgwqvNRX7PDl9D7XSQbYmQK8GSwE62Z1NqauEdu7Kbzrq0qk9OOQa
         74cEI9F9K4yt5I7acX3WC2ugfYI5oi2n4n5HiCrL4ln93s9NFT9m9AbPeu/D7yocFX3p
         e739si7kc85/gFTSu9XMCZW6rAZYgggIazWhgD18gEPyCTxBCpKCGu2GASEfaYEwmRVJ
         a5KX/WKBRwlQ9PyM//ZWF9zG0SyPdZAgegMvGqAira07cxVNCWlVpsIID8bcMl0i2rV9
         J6lOvbZTMjLDra0Df9wfbjF9JXi+leVir6ISUrSS77qPYQlhL/aa0lxO1VS4F/p/vAgr
         nSSg==
X-Gm-Message-State: APjAAAW1c86eHWzdysmin8mBoJQANYb0DX0B48tVG5A+8Iehn01C6wzA
        Dq7aG7m4/JzpS3NxM/QGjrzWD01I4MEcIw==
X-Google-Smtp-Source: APXvYqzccbD9kA2630YHfQmEXvS4UkceEIiImBFfBcC1OG7D/bTZiezPCpMDwRLF26gDV8iZdeXzYg==
X-Received: by 2002:a0c:e806:: with SMTP id y6mr12606851qvn.148.1575643600637;
        Fri, 06 Dec 2019 06:46:40 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id y184sm5996723qkd.128.2019.12.06.06.46.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2019 06:46:40 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 34/44] btrfs: hold a ref on the root in get_subvol_name_from_objectid
Date:   Fri,  6 Dec 2019 09:45:28 -0500
Message-Id: <20191206144538.168112-35-josef@toxicpanda.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191206144538.168112-1-josef@toxicpanda.com>
References: <20191206144538.168112-1-josef@toxicpanda.com>
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
index e387ca1ac0e5..9c50bee71de9 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -1082,6 +1082,10 @@ static char *get_subvol_name_from_objectid(struct btrfs_fs_info *fs_info,
 			ret = PTR_ERR(fs_root);
 			goto err;
 		}
+		if (!btrfs_grab_fs_root(fs_root)) {
+			ret = -ENOENT;
+			goto err;
+		}
 
 		/*
 		 * Walk up the filesystem tree by inode refs until we hit the
@@ -1094,13 +1098,16 @@ static char *get_subvol_name_from_objectid(struct btrfs_fs_info *fs_info,
 
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
@@ -1117,6 +1124,7 @@ static char *get_subvol_name_from_objectid(struct btrfs_fs_info *fs_info,
 			ptr -= len + 1;
 			if (ptr < name) {
 				ret = -ENAMETOOLONG;
+				btrfs_put_fs_root(fs_root);
 				goto err;
 			}
 			read_extent_buffer(path->nodes[0], ptr + 1,
@@ -1124,6 +1132,7 @@ static char *get_subvol_name_from_objectid(struct btrfs_fs_info *fs_info,
 			ptr[0] = '/';
 			btrfs_release_path(path);
 		}
+		btrfs_put_fs_root(fs_root);
 	}
 
 	btrfs_free_path(path);
-- 
2.23.0

