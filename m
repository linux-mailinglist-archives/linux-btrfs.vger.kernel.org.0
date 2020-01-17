Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B9EC1140B80
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Jan 2020 14:49:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729123AbgAQNs6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Jan 2020 08:48:58 -0500
Received: from mail-qv1-f67.google.com ([209.85.219.67]:42597 "EHLO
        mail-qv1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729108AbgAQNs6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Jan 2020 08:48:58 -0500
Received: by mail-qv1-f67.google.com with SMTP id dc14so10691063qvb.9
        for <linux-btrfs@vger.kernel.org>; Fri, 17 Jan 2020 05:48:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=P8XNEd0C6kBDH9BTgE6tDYjoHWT0SVgdH+Usr5cP7to=;
        b=BnQTdpdjctfGLDeMCmC4Xnw5QdMb5QP216qSYyMMi+tNHntfuFqAmOo6hN1RmIigPY
         02jGTA7896pJS5j0mNbhwMMJGHTFS9I/5LvPdvA3hH44CFwF4qrtILmWtpweuAfQWhBD
         wJm+1vOphg1KiQxYz1YLJ7sepDxyRSKB3KGld9Bol7QA+VLtt2SK+bpVgJvxaXDo8ula
         KR/4eyqhumj797DXetwC8UDlC8UxJ7eSb8hDJUOUd+QO143Q5EzOoEAm32mUU+RqNeTa
         8X7yZ6SwH/drpdXNP0yZ613RTB4hXxlfy/MhWqQ6vJMYcFch0pUrr4FLLGSqvZBHsv/h
         xVJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=P8XNEd0C6kBDH9BTgE6tDYjoHWT0SVgdH+Usr5cP7to=;
        b=rK5ZK5XfTexXz6tl5kBAn/a/BGs5u0LKQ1ojVihOZZWkU9HsY52DidFcjKjUrf8/s/
         +NXGERdmrO8duy7JFP7uEnSRaKsm2u0WZZAvi8RFUFwlwBz4do0++Fl2EEdepjL+tEVk
         I2T4B7DP8mBUV4UJTLsdmsArRTVZbcwPjQEYLG8UrKGCS++hAI6aB37kXJPEIxQO9KNh
         xcx+oRepme34ICIYyeRlTMihBA4P7vUNLxvenaKjKVKCRwe7OV9XXcsLV8QUdfubhF3c
         Iz7S8iU010sBKMK94xoX21E7RbT1cKS4J5scGAP0pb4jrDP4WHSuNP9lIIOjjpRdA0WV
         vvmw==
X-Gm-Message-State: APjAAAXjZz0vd2lD5H0uYnbPCPl9FlPNG4zMJFEnSdVv5sJma875NGRJ
        3JrJW56S78cyJFpEVHmNWIFakjIrHyX1qg==
X-Google-Smtp-Source: APXvYqwj3+7cFoqVenaC3/gePPFwRuUWF+pCkSk00GXW6QHgKE+cLyXAPDyF7bxqz8/dL8EnnJKy9A==
X-Received: by 2002:a0c:e84d:: with SMTP id l13mr7740292qvo.53.1579268936985;
        Fri, 17 Jan 2020 05:48:56 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id d25sm11685625qka.39.2020.01.17.05.48.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2020 05:48:56 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 33/43] btrfs: hold a ref on the root in create_pending_snapshot
Date:   Fri, 17 Jan 2020 08:47:48 -0500
Message-Id: <20200117134758.41494-34-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200117134758.41494-1-josef@toxicpanda.com>
References: <20200117134758.41494-1-josef@toxicpanda.com>
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
index 69c39b3d15a5..47953d022328 100644
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
2.24.1

