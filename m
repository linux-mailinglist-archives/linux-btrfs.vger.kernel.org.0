Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 839F215F876
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 Feb 2020 22:12:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388181AbgBNVMA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 14 Feb 2020 16:12:00 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:33191 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387904AbgBNVL7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 14 Feb 2020 16:11:59 -0500
Received: by mail-qt1-f194.google.com with SMTP id d5so7956959qto.0
        for <linux-btrfs@vger.kernel.org>; Fri, 14 Feb 2020 13:11:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=dB//t7uZfMe/NEPjjQHH0wtko3JdGlqDF5yCmEpWtmc=;
        b=VWgP1M3JG352I6fMExXJR5X54rb2KWBsiTT8MThkWmMH4Bb3OEinyKVlF7+r4Bcq1T
         U1iMLpsaLYUTv8UfcsgHJgWsAD88CEhbdTu8IIZ+Qrv3374koOgfRPzyxShjyQ9Ndfkh
         CrDKb1YYuGZfS5mcmwA2Usb+TmCs5FsTz08FV7nnXgY5vAXQOXhHopoa9QklNxZtF/P0
         idlUmEZmKoKANDRMEuQasDrkXGW5sSh2hBBuCCwn/YD3NC3IM9VIWCIvJLWQLq66FG3U
         tMkkjI7/jdzf7XyAlZTp1czMI6oBxOOorg4hGlAqXR6laR4ZPrhzKNkfJCk7OjR+wBF6
         bs3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dB//t7uZfMe/NEPjjQHH0wtko3JdGlqDF5yCmEpWtmc=;
        b=DjTKhbBFVr7jchzvoDWjBqquJeFRdfIid9XAJ1ciBMUpSFtcbVPGfXiJ6FmmwxBrOi
         yPJKMaYhfh/v62RBY8N5JZ+2C5thXL554AkUR/5XuTRltWk2FB8KAOXtDzVuLxtlOw5c
         QbbkfBOnyQ9kf9LFyyIbXg3oHTpJBWjKBwNKoaImhIi1S5ZCiRiG6fw1twgF/jbpOJPQ
         +AlFU4fS88XGaJ68ffaffQiFAiIkpHqERhJzBXxDQKvRwmexeYDyKbyJJm3/M3IVhgyo
         TbSmkpyNpR5dmz7aSy/fxDXaFTONu3HgNuNJ2Nb1g7AhxuJ/Q9uJWah/qos5BaGcTxbf
         5kag==
X-Gm-Message-State: APjAAAWzDf86wX+NL8xYSnLqlVwUNeDP7gX8CyRImRhCaoqtgd33KrTG
        GmPo3IS11get3AIz6jXX4zTGvIPDENA=
X-Google-Smtp-Source: APXvYqxmJdHARNf/HcLczYdlMRF+8jQpXAkUtv24PrQ7ihSdLjksK8i2RudPxG3C+J/79Jp7OJpKCg==
X-Received: by 2002:ac8:7159:: with SMTP id h25mr4222083qtp.380.1581714718336;
        Fri, 14 Feb 2020 13:11:58 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id t23sm3754290qtp.82.2020.02.14.13.11.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2020 13:11:57 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 5/8] btrfs: hold a ref on the root on the dead roots list
Date:   Fri, 14 Feb 2020 16:11:44 -0500
Message-Id: <20200214211147.24610-6-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200214211147.24610-1-josef@toxicpanda.com>
References: <20200214211147.24610-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

At the point we add a root to the dead roots list we have no open inodes
for that root, so we need to hold a ref on that root to keep it from
disappearing.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/disk-io.c     | 3 +--
 fs/btrfs/transaction.c | 6 ++++--
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 26eb1564028d..ffbc4c6c17fe 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -2079,8 +2079,7 @@ void btrfs_free_fs_roots(struct btrfs_fs_info *fs_info)
 
 		if (test_bit(BTRFS_ROOT_IN_RADIX, &gang[0]->state))
 			btrfs_drop_and_free_fs_root(fs_info, gang[0]);
-		else
-			btrfs_put_root(gang[0]);
+		btrfs_put_root(gang[0]);
 	}
 
 	while (1) {
diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index 3ffeb9a2c6e6..53af0f55f5f9 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -1260,8 +1260,10 @@ void btrfs_add_dead_root(struct btrfs_root *root)
 	struct btrfs_fs_info *fs_info = root->fs_info;
 
 	spin_lock(&fs_info->trans_lock);
-	if (list_empty(&root->root_list))
+	if (list_empty(&root->root_list)) {
+		btrfs_grab_root(root);
 		list_add_tail(&root->root_list, &fs_info->dead_roots);
+	}
 	spin_unlock(&fs_info->trans_lock);
 }
 
@@ -2443,7 +2445,7 @@ int btrfs_clean_one_deleted_snapshot(struct btrfs_root *root)
 		ret = btrfs_drop_snapshot(root, NULL, 0, 0);
 	else
 		ret = btrfs_drop_snapshot(root, NULL, 1, 0);
-
+	btrfs_put_root(root);
 	return (ret < 0) ? 0 : 1;
 }
 
-- 
2.24.1

