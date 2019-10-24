Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6CEC0E283A
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Oct 2019 04:34:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437083AbfJXCez (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 23 Oct 2019 22:34:55 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:38468 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2408246AbfJXCey (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 23 Oct 2019 22:34:54 -0400
Received: by mail-qt1-f195.google.com with SMTP id o25so22104606qtr.5;
        Wed, 23 Oct 2019 19:34:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Kpk3lLUqgGwLu+uXg2SWXaoH3Lz9YjBH7H2wUph1KgI=;
        b=nWxtxJU3yLMrtDbaMEkPB29QLCMcQtyzX2+hbfzVWMRP3v+2pgmefyckvjP6h5n72d
         I0PgUVUtiNoIpWg0rO8w8Vxtvwl4aTcTTGf9U7olB8sw05kA78KiHu+dJYCcrsn8kV5g
         k2GoOT6orFcDnv38hj/dOQPkiS31f4qTF/d3b7RQM0XzIOvvzygynGDAJcQJPLyZMi57
         vE0jheD1nyUxdYONNZc5/IZxFVud1ocKSoTZT+fUMu/QtYEAmwR7zkqY9cuR3ek2lQi+
         biH1tqQ/UZjQZbuCoeJPj4LR4SSgYJtMXMAYjc5m+n7rREqCUlQmmat5aohDdJEWkq99
         ZXzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Kpk3lLUqgGwLu+uXg2SWXaoH3Lz9YjBH7H2wUph1KgI=;
        b=rZUEKQSnDYYIkL62nV3xltuEp3DdgOHuh2HSecpgf5b1yTwO0IJe8uKl16DHiOXdNz
         36w3Ufy4wtXR+Qc2GkZzorrOgD7jNfAaCu36+kPI+QsfaV8gKLcOMCWhm8V57XMKwrB6
         XUYnkTFc60l77f/FaRKoSpudUrx4mvaxRB9sjTBF+EbdUNY4ymlbY5u2+DbH2QlDbAQx
         WN/+fSWe2XOfa4JJ7o3Y4gpbm/AKdw3higVE66iQT+OClq9UaHAIyBd6xuqWN/DNrM/t
         o8bvuAkhMECwZR82M3rcHuvJa968v3vDSjDWi6nQ4875j99M5XBtqhIY/LDyCK9IF3hB
         5qYQ==
X-Gm-Message-State: APjAAAU6QEX08wUDFsJcuC+xewAr6Je1JMui/MASsU0dV20XPtu/LhBZ
        K3sKFeHYXHdelWbtBux1SQKobvQH
X-Google-Smtp-Source: APXvYqxAGw9VOw8bBlElMlkLouVTAjqYK4ikrAJTc3OBpJnPWW9l1JnFcB25s6S9Vnz0CKe01JbldA==
X-Received: by 2002:a05:6214:803:: with SMTP id df3mr12589055qvb.215.1571884492658;
        Wed, 23 Oct 2019 19:34:52 -0700 (PDT)
Received: from localhost.localdomain ([186.212.94.31])
        by smtp.gmail.com with ESMTPSA id q16sm10252495qke.22.2019.10.23.19.34.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2019 19:34:52 -0700 (PDT)
From:   Marcos Paulo de Souza <marcos.souza.org@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org, mpdesouza@suse.com
Subject: [PATCH 5/5] btrfs: ioctl: Call btrfs_vol_uevent on subvolume deletion
Date:   Wed, 23 Oct 2019 23:36:36 -0300
Message-Id: <20191024023636.21124-6-marcos.souza.org@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191024023636.21124-1-marcos.souza.org@gmail.com>
References: <20191024023636.21124-1-marcos.souza.org@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Marcos Paulo de Souza <mpdesouza@suse.com>

Since the function btrfs_ioctl_snap_destroy is used for deleting both
subvolumes and snapshots it was needed call btrfs_is_snapshot,
which checks a giver btrfs_root and returns true if it's a snapshot.
The current code is interested in subvolumes only.

btrfs_vol_uevent will export two environment variables to udev:
BTRFS_VOL_NAME: containing the name of the subvolume deleted
BTRFS_VOL_DEL: will signalize that a volume is being deleted

One can create a udev rule and check for BTRFS_VOL_DEL being set,
these values one could detect whenever a subvolume is deleted, and
take any action based on the subvolume name contained in BTRFS_VOL_NAME.

Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
---
 fs/btrfs/ioctl.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index c538d3648195..173f2a258508 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -2869,6 +2869,7 @@ static noinline int btrfs_ioctl_snap_destroy(struct file *file,
 {
 	struct dentry *parent = file->f_path.dentry;
 	struct btrfs_fs_info *fs_info = btrfs_sb(parent->d_sb);
+	struct block_device *bdev = fs_info->fs_devices->latest_bdev;
 	struct dentry *dentry;
 	struct inode *dir = d_inode(parent);
 	struct inode *inode;
@@ -2962,6 +2963,10 @@ static noinline int btrfs_ioctl_snap_destroy(struct file *file,
 	err = btrfs_delete_subvolume(dir, dentry);
 	inode_unlock(inode);
 	if (!err) {
+		/* send uevent only to subvolume deletion */
+		if (!btrfs_is_snapshot(dest))
+			btrfs_vol_uevent(bdev, false, vol_args->name);
+
 		fsnotify_rmdir(dir, dentry);
 		d_delete(dentry);
 	}
-- 
2.23.0

