Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 67763109762
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Nov 2019 01:57:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727166AbfKZA5A (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 25 Nov 2019 19:57:00 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:32945 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725945AbfKZA47 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 25 Nov 2019 19:56:59 -0500
Received: by mail-pf1-f196.google.com with SMTP id c184so8294078pfb.0;
        Mon, 25 Nov 2019 16:56:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aCAIdja2mecYCK657/1Jqa9rURX6PmMXn4wD/Vw979E=;
        b=kwSa7APQRJdfgBr6xuHjt8qpSsOidjLh2f1EfpFC1k6MUt/Hq00QF1kkF7XMioI2us
         dGCl4v2iqCz+C5YH8+0pyDOqiRDfE7gJ9qEB4dqOpD5kMLaurWMHXu8W2WN+vIi/+JE4
         ia5srip814Kpj7jyVZmVLiJrQyqr98/AiCz9IcLt6j1Z7b3WXyQkgi07Lw59VL1K5Y3f
         DHkzfg56kDkRutXmHfo8vgynpVm3h455kP9j0O9JkGzQoUCxvQ3o+KNCUhF9wtx8qmPH
         DH938bz40POS/+96gixf4iJ33jRhQX+IcixjHTYQrzzjYg5l95p9y1F7binUi7vZojiN
         MZSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aCAIdja2mecYCK657/1Jqa9rURX6PmMXn4wD/Vw979E=;
        b=iJ3BE+owyOZkZrqVJQxLBRdSlJnFtelsW8cywjUmXS88gG+lrvBjxnaW5ZeMOHOQdB
         2GYDe+vAVJEhTiK/kxQfZgiIg/yxmY0z0ta8uUsFZZkJh1FD4dN3VwRxReoCipDa2Uf0
         Nqe9GUPAmLgOcBBi/qJnn9qAUbr+nayFCIdVGUAg8C4NGa0mLKH8TvhtLJWoxbn+VXnl
         PADNjiFYnVGtkOdAtSuDxvqp+aGR/YUcI19Apxob0c+80rvwpD6CFzmhYcJB8ZrGMG2b
         7yXdoyyC6uS+GzdcC0bhPlM/gP7AhqxreqVPVf82Gj67hePVSurpWbQRaUde28OacouM
         Em4g==
X-Gm-Message-State: APjAAAW+cQN4x+Tgk6kbI/Y01YBKMuFrp6e0FpXCHcdavpf7oovIECfn
        DfgRLjbM6AGrAQXG2+3zP9Dd8Lyw
X-Google-Smtp-Source: APXvYqwj3LGgoahwScqnP8gjni2SV5gkLqs/V2yP6dkcfl5NNv/m6knuu/y9Uhy41it+kTsfKjY/oQ==
X-Received: by 2002:a63:e44b:: with SMTP id i11mr35553225pgk.437.1574729818327;
        Mon, 25 Nov 2019 16:56:58 -0800 (PST)
Received: from hephaestus.prv.suse.net ([186.212.48.108])
        by smtp.gmail.com with ESMTPSA id w15sm9421223pfi.168.2019.11.25.16.56.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2019 16:56:57 -0800 (PST)
From:   Marcos Paulo de Souza <marcos.souza.org@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     dsterba@suse.com, linux-btrfs@vger.kernel.org,
        anand.jain@oracle.com, Marcos Paulo de Souza <mpdesouza@suse.com>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH 2/2] btrfs: qgroup: Return -ENOTCONN instead of -EINVAL
Date:   Mon, 25 Nov 2019 21:58:51 -0300
Message-Id: <20191126005851.11813-3-marcos.souza.org@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191126005851.11813-1-marcos.souza.org@gmail.com>
References: <20191126005851.11813-1-marcos.souza.org@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Marcos Paulo de Souza <mpdesouza@suse.com>

[PROBLEM]
qgroup create/remove code is currently returning EINVAL when the user
tries to create a qgroup on a subvolume without quota enabled. EINVAL is
already being used for too many error scenarios so that is hard to depict
what is the problem.

[FIX]
Currently scrub and balance code return -ENOTCONN when the user tries to
cancel/pause and no scrub or balance is currently running for the desired
subvolume. Do the same here by returning -ENOTCONN  when a user
tries to create/delete/assing/list a qgroup on a subvolume without quota
enabled.

Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
---
 fs/btrfs/qgroup.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index 417fafb4b4f6..b046b04d7cce 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -1259,7 +1259,7 @@ int btrfs_add_qgroup_relation(struct btrfs_trans_handle *trans, u64 src,
 
 	mutex_lock(&fs_info->qgroup_ioctl_lock);
 	if (!fs_info->quota_root) {
-		ret = -EINVAL;
+		ret = -ENOTCONN;
 		goto out;
 	}
 	member = find_qgroup_rb(fs_info, src);
@@ -1318,7 +1318,7 @@ static int __del_qgroup_relation(struct btrfs_trans_handle *trans, u64 src,
 		return -ENOMEM;
 
 	if (!fs_info->quota_root) {
-		ret = -EINVAL;
+		ret = -ENOTCONN;
 		goto out;
 	}
 
@@ -1384,7 +1384,7 @@ int btrfs_create_qgroup(struct btrfs_trans_handle *trans, u64 qgroupid)
 
 	mutex_lock(&fs_info->qgroup_ioctl_lock);
 	if (!fs_info->quota_root) {
-		ret = -EINVAL;
+		ret = -ENOTCONN;
 		goto out;
 	}
 	quota_root = fs_info->quota_root;
@@ -1418,7 +1418,7 @@ int btrfs_remove_qgroup(struct btrfs_trans_handle *trans, u64 qgroupid)
 
 	mutex_lock(&fs_info->qgroup_ioctl_lock);
 	if (!fs_info->quota_root) {
-		ret = -EINVAL;
+		ret = -ENOTCONN;
 		goto out;
 	}
 
@@ -1469,7 +1469,7 @@ int btrfs_limit_qgroup(struct btrfs_trans_handle *trans, u64 qgroupid,
 
 	mutex_lock(&fs_info->qgroup_ioctl_lock);
 	if (!fs_info->quota_root) {
-		ret = -EINVAL;
+		ret = -ENOTCONN;
 		goto out;
 	}
 
-- 
2.23.0

