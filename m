Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0A94D148932
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Jan 2020 15:34:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404373AbgAXOd3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 24 Jan 2020 09:33:29 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:45167 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404315AbgAXOd2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 24 Jan 2020 09:33:28 -0500
Received: by mail-qt1-f194.google.com with SMTP id d9so1606558qte.12
        for <linux-btrfs@vger.kernel.org>; Fri, 24 Jan 2020 06:33:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=SAiiIaHYxAwFxdCh+4UtFgo8Rs8ZoelHWG4/dfLjKQs=;
        b=Zxv9jxC9O2t4X6HlWcGH5uvCZwr6BnjpCM19D4FLJvh/64jgm9laVFaQ1t+/sdE653
         PuWKBy7DgSk208BcLQt0nQGllAiceu4fcxD6AKlEZX2Fy4ZdkojZ2h0QRZqvYvJahfUJ
         n7JHTfZ1kJOW/KOIENGQPD13pMwtkRSKX6ZnqxkK7kq9L54Vg4kdQorsZlm5Og5dGLW8
         ey18qzN+NmKcwzCpU+O/ygODJrjbwB3fHY2hiYZScMbc/0q5KH52Dv2oA446yQF0ZfZy
         4B+bnO7IW7FnSb0PtcG9We78kzRD6a36CxX8BQXfXOLJC3TtFtmo5hLGaZM/GJIos7Lv
         gw3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SAiiIaHYxAwFxdCh+4UtFgo8Rs8ZoelHWG4/dfLjKQs=;
        b=mgfjAo368Zlo6+3ImIlP3+seb6VzlonsjCvewq1P8dDekyWJcC2ZJW/xQUXm/1idOZ
         4tc6r+fqpv789CZC/3Tib/NBk+BdinuC1E4JXOY7WF2EHwfBI2EzqZSAVgipx9S2ig/z
         rl7C6jIqZZgwc8fL+gc2EQfK5D8vkWBKswju/zspUHV9nZWILJOWMCB93M8nni7U1wbk
         0UbDp7heSLW3iQYGNkp+4t2EgP+66tOpwWqgnmLwz1tzpYziTKGU5fY84oxiSQdurSBC
         XBtEatCC3EIxLa/KRv+uVLGtX6Tz9sf5MsIWOKSTue04IheoOwjHVLrhJrPcigF02MS4
         CXPA==
X-Gm-Message-State: APjAAAUcWUcAtYPhxqsZk5yYgZvpaEStvQ2HTuDKzRDI8koFWNIDAUzh
        mte6I+6nYLQQINd1BY6EU9n7Sb9tN3EW9Q==
X-Google-Smtp-Source: APXvYqwQUVLcQK1G6s3zpQ3IwuzQ0UL+MqkQTBvnSmnLPR7Nz0OnHWa2fjVftJ01yoWZxZzU1Nt3ng==
X-Received: by 2002:ac8:7188:: with SMTP id w8mr2389732qto.139.1579876407063;
        Fri, 24 Jan 2020 06:33:27 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id n20sm3038187qkk.54.2020.01.24.06.33.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jan 2020 06:33:26 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     kernel-team@fb.com, linux-btrfs@vger.kernel.org
Subject: [PATCH 14/44] btrfs: hold a ref on the root in fixup_tree_root_location
Date:   Fri, 24 Jan 2020 09:32:31 -0500
Message-Id: <20200124143301.2186319-15-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200124143301.2186319-1-josef@toxicpanda.com>
References: <20200124143301.2186319-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Looking up the inode from an arbitrary tree means we need to hold a ref
on that root.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/inode.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 8cd1b11c3151..85104886c1e7 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -5026,6 +5026,10 @@ static int fixup_tree_root_location(struct btrfs_fs_info *fs_info,
 		err = PTR_ERR(new_root);
 		goto out;
 	}
+	if (!btrfs_grab_fs_root(new_root)) {
+		err = -ENOENT;
+		goto out;
+	}
 
 	*sub_root = new_root;
 	location->objectid = btrfs_root_dirid(&new_root->root_item);
@@ -5268,6 +5272,8 @@ struct inode *btrfs_lookup_dentry(struct inode *dir, struct dentry *dentry)
 	} else {
 		inode = btrfs_iget(dir->i_sb, &location, sub_root);
 	}
+	if (root != sub_root)
+		btrfs_put_fs_root(sub_root);
 	srcu_read_unlock(&fs_info->subvol_srcu, index);
 
 	if (!IS_ERR(inode) && root != sub_root) {
-- 
2.24.1

