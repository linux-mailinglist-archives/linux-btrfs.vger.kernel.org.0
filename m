Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 608DE1412D5
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Jan 2020 22:26:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728721AbgAQV0d (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Jan 2020 16:26:33 -0500
Received: from mail-qv1-f66.google.com ([209.85.219.66]:32918 "EHLO
        mail-qv1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726587AbgAQV0d (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Jan 2020 16:26:33 -0500
Received: by mail-qv1-f66.google.com with SMTP id z3so11385109qvn.0
        for <linux-btrfs@vger.kernel.org>; Fri, 17 Jan 2020 13:26:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=SAiiIaHYxAwFxdCh+4UtFgo8Rs8ZoelHWG4/dfLjKQs=;
        b=2SJUqq3b6eJK1zJgFjT6tIvEDCp9aFuEwNKbl8bNrCkSDeHjhxq6b8y3S4Or2ws4vC
         rjzjfGWT1HS628aCmqw6suT053tFRY02GT7e6OH3JbwaUVStYAwgOzX+mkjYG8nWVnMv
         GKDoWKDyYsFdOXHcsepNDnieHaE/IOzHm0TjHH0/DJ4qO8ddPdwZUrd99vAJVZxLa94B
         Ub9dWHqgcwPT4QyynlCUR8XW+fRcLKbQ0JtljPmMoj1K0iqEg6tWvs8us4HuM+cl6Je8
         qHbRE2jRkuieoQihchxSx3qC15q8LBvzcMJCOICpJwPNMIUJCYpkOsaiVk+cVhhQqdl1
         VQQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SAiiIaHYxAwFxdCh+4UtFgo8Rs8ZoelHWG4/dfLjKQs=;
        b=ArXdNMZsce1GIVA177G5llBrSUw29qxTnQPAjJbcFXbBCa+J9aXFtLIK5OwoF6VEJr
         KtNrCmdfTfgoZLGuOgM0BMTydpSz2V0cfBMUBGHEIUGZDorw20R7FB/RXkg8J6Q+gANZ
         GTj3OrnsjUwA9mI6qGMPmzJB5mNamsMGeiYM2qwdmROawl9BPZQfQq2ydIZw4DMJ+oFx
         Rn2Q5l7MSVnc6lshxOm/+y0MmFjhs8bpzbXkZchcPgyyuUg7FOUNmOiQLW/N98ToD8V0
         Q/T6Shy15QvWjm1lzz7DGW8LxlvdHlxyCH5XKuZME/J4asuXfi9xRgGNCqL678jALLPi
         BsjQ==
X-Gm-Message-State: APjAAAWPo71NR2v1H+He4XvGt3Ae4M0h3UWIRxAIVMi2C/81xNGAo02g
        dP4mdzPe6knNd7bR9eHuvW2a6Sz9S/8sdg==
X-Google-Smtp-Source: APXvYqy738/Ci10X6pmkR5Q4HkcZmbRrY9za+xW3ZXi77MWbuDo1NxhobYwA3tuyp8tpMcRYzdhzWQ==
X-Received: by 2002:a05:6214:1745:: with SMTP id dc5mr9444683qvb.230.1579296391787;
        Fri, 17 Jan 2020 13:26:31 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id k73sm12479564qke.36.2020.01.17.13.26.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2020 13:26:31 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 14/43] btrfs: hold a ref on the root in fixup_tree_root_location
Date:   Fri, 17 Jan 2020 16:25:33 -0500
Message-Id: <20200117212602.6737-15-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200117212602.6737-1-josef@toxicpanda.com>
References: <20200117212602.6737-1-josef@toxicpanda.com>
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

