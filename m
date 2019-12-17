Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2F2B6123095
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Dec 2019 16:38:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728635AbfLQPhn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 17 Dec 2019 10:37:43 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:41537 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728130AbfLQPhm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 17 Dec 2019 10:37:42 -0500
Received: by mail-qk1-f194.google.com with SMTP id x129so1116407qke.8
        for <linux-btrfs@vger.kernel.org>; Tue, 17 Dec 2019 07:37:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=jBx27Gqp2ekqvTSlDXB8wC6n+Fi1D6493NIr4uiaG7Y=;
        b=xsTauW6zNn4N93RSsacPaXBStDhOwIniRYkpDsPpqyRiG/RwfzxbUqfCPwsZJ1DTiS
         xX6vaRLmh3lITewOxndgsxai84vX8yX0CGFrk0CtzH0LAIcxSFihq5xw1GG0wj+ZdwbX
         G4Y7PYwNVRV/jBnxVzI9h41aFkDx0ITztQmaKv3G3BMQ+25OzAd5AfsV20hL4JnIVYzN
         ZaLrssvBqxdijgPwg1Fs/0FY49V6jzV6LBQUCPOi09OVcxfn9HthVsfHVf+X5LAZKQiy
         UwIIhTW0yEDeWjb57eWBGK7ShAdjbYCH09EZJEG0rt4DQNxj/OeOgU6Lb/YB3WdTjLTY
         29QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jBx27Gqp2ekqvTSlDXB8wC6n+Fi1D6493NIr4uiaG7Y=;
        b=T0h2J0lm8bRyxcn2RO2HwjNTqRBvrdasu8CTvHxpee7udxLr07+l7/qIANNSCYG0MF
         hD4vjEdyggcFEBjeFRn49+W4/HybUPg2yqVG+otCMs0Gvx3JmdzcRBhd0EkneEqURZWc
         QJY4Ut/1M2IPK4rQFz1rDTuh1nJl4+6SgjTvzTMzKzcfe4yHT5YSvMsiBKIIMdyRBr9F
         yLz5D41WeHGY1oevMMGAZo+CQ+gCwwWl2Vd4uPoU+Ysq+ViaR5b4TAsso8xGSo7ovXcK
         PZAbqmSteZL0WvlMkadWWDZKN7A8O9+77b6UNAOoIOiN1xkaY/SXD4XuwiHJH4edh1rH
         2mSw==
X-Gm-Message-State: APjAAAUTN6I6N3+7cyW+5jO12BYlbhaBCKWCcm0rP1fO1M+P4T4pzY+3
        38lpPdqW1o7PF8R0g5RQhivji0iLiUJdaQ==
X-Google-Smtp-Source: APXvYqxp+kSi17dneZf6jRHdAsLVnwOHMdzOeOfwCoJGVuyp/rDZN7mMco6azTuFU9KuDIt0cAw3Mw==
X-Received: by 2002:a05:620a:10a7:: with SMTP id h7mr5462834qkk.423.1576597061362;
        Tue, 17 Dec 2019 07:37:41 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id j15sm7792214qtn.37.2019.12.17.07.37.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2019 07:37:40 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 35/45] btrfs: hold a ref on the root in create_pending_snapshot
Date:   Tue, 17 Dec 2019 10:36:25 -0500
Message-Id: <20191217153635.44733-36-josef@toxicpanda.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191217153635.44733-1-josef@toxicpanda.com>
References: <20191217153635.44733-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We create the snapshot and then use it for a bunch of things, we need to
hold a ref on it while we're messing with it.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/ioctl.c       | 1 +
 fs/btrfs/transaction.c | 6 ++++++
 2 files changed, 7 insertions(+)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index a3223bec3f5b..d5a994ab9602 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -875,6 +875,7 @@ static int create_snapshot(struct btrfs_root *root, struct inode *dir,
 	d_instantiate(dentry, inode);
 	ret = 0;
 fail:
+	btrfs_put_fs_root(pending_snapshot->snap);
 	btrfs_subvolume_release_metadata(fs_info, &pending_snapshot->block_rsv);
 dec_and_free:
 	if (snapshot_force_cow)
diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index e194d3e4e3a9..7008def3391b 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -1637,6 +1637,12 @@ static noinline int create_pending_snapshot(struct btrfs_trans_handle *trans,
 		btrfs_abort_transaction(trans, ret);
 		goto fail;
 	}
+	if (!btrfs_grab_fs_root(pending->snap)) {
+		ret = -ENOENT;
+		pending->snap = NULL;
+		btrfs_abort_transaction(trans, ret);
+		goto fail;
+	}
 
 	ret = btrfs_reloc_post_snapshot(trans, pending);
 	if (ret) {
-- 
2.23.0

