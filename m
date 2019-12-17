Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E762B123074
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Dec 2019 16:36:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727762AbfLQPg4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 17 Dec 2019 10:36:56 -0500
Received: from mail-qv1-f67.google.com ([209.85.219.67]:33816 "EHLO
        mail-qv1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727360AbfLQPg4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 17 Dec 2019 10:36:56 -0500
Received: by mail-qv1-f67.google.com with SMTP id o18so4333402qvf.1
        for <linux-btrfs@vger.kernel.org>; Tue, 17 Dec 2019 07:36:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=TbWQBPE4IoDoquDDkXLWAW/nhtZspOmP74cbSr991NI=;
        b=h3/aX26k6cdGcpcQE0iu+bh8j6Wy/biU6c1QektJ2677Kp9OZBRlDM0pMPfJHUMIsL
         TKYszH0p/Dh1+/oRZ/GOXPw3HDQbAdinW1bfz4hlnK49BgZsvr9FB3ZXXZDYa7pjo8zo
         sF926J6Nfg1XZ5AkDisdkV+a9b4PYaPX2FqFbvEoNXNsZw9H6Rog5+qP6mSRE+9lfkmM
         2HhyNc5wou34qSWxVYfuHZzYfdTN8iSoQr+M0/4EUhy79AQ4WEw8+aEg3vxZ55bv2j3b
         ZpijXnEHg202PiHkOuDTbwUr5b0v0Q6asR3GuiQttCzyrEVXHA5eAZT7NbP6ngNX++v7
         thEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TbWQBPE4IoDoquDDkXLWAW/nhtZspOmP74cbSr991NI=;
        b=kf0zsY8HFl8HmTgFVv4JiPCr0ZHYSkX0/+aDzZsLOGQxUaaILGxqEGxQby0EARUC5W
         9ATG85YtFMXqV4uhMjT3EOc5Q0AM9ZKDnZChLrxjXsl/LP4LIE1nJoPe0QFG6klXeEGd
         AiMp7k+hS7loMn5UeFdri6SH8RAwAF7QiZ3TO4oLGhzi+sBtl3cXPVp44YMBqrERnYvB
         ryPqKBeRYajE8wNTgjEzQ3dQd0d/fHsTBxsZE3dfPCpiJ4YuTNsne8eF8mpCqLpqvZRI
         vuiIItBRs1rJV9/MGfCT/MlQsg7U1SzYB6aFpFaWm2OwyfvbikuwJ6AFbysb2b2WwBo3
         DDnA==
X-Gm-Message-State: APjAAAWn/MFWAq6A5MmUO1jMLKCoGTI4yAz1sYJrVFFY7mteNBv9HgdK
        FQg+GP+fAnChFXk5e6qxCAgnqoTByerHZw==
X-Google-Smtp-Source: APXvYqz+r/z7MfX2bNmEfxfBQQJioProChOiEUBmo0AZx3N/4qcxVI66VQVFoBMcpYAFcVtTo56UQA==
X-Received: by 2002:a0c:ab8f:: with SMTP id j15mr5091592qvb.223.1576597014875;
        Tue, 17 Dec 2019 07:36:54 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id 68sm7188981qkj.102.2019.12.17.07.36.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2019 07:36:53 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 09/45] btrfs: handle NULL roots in btrfs_put/btrfs_grab_fs_root
Date:   Tue, 17 Dec 2019 10:35:59 -0500
Message-Id: <20191217153635.44733-10-josef@toxicpanda.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191217153635.44733-1-josef@toxicpanda.com>
References: <20191217153635.44733-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We want to use this for dropping all roots, and in some error cases we
may not have a root, so handle this to make the cleanup code easier.
Make btrfs_grab_fs_root the same so we can use it in cases where the
root may not exist (like the quota root).

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/disk-io.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/btrfs/disk-io.h b/fs/btrfs/disk-io.h
index 5b38558e164d..7e53da374715 100644
--- a/fs/btrfs/disk-io.h
+++ b/fs/btrfs/disk-io.h
@@ -88,6 +88,8 @@ struct btrfs_root *btrfs_alloc_dummy_root(struct btrfs_fs_info *fs_info);
  */
 static inline struct btrfs_root *btrfs_grab_fs_root(struct btrfs_root *root)
 {
+	if (!root)
+		return NULL;
 	if (refcount_inc_not_zero(&root->refs))
 		return root;
 	return NULL;
@@ -95,6 +97,8 @@ static inline struct btrfs_root *btrfs_grab_fs_root(struct btrfs_root *root)
 
 static inline void btrfs_put_fs_root(struct btrfs_root *root)
 {
+	if (!root)
+		return;
 	if (refcount_dec_and_test(&root->refs))
 		kfree(root);
 }
-- 
2.23.0

