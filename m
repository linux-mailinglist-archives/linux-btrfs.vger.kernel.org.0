Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 27FCE140B72
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Jan 2020 14:49:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729044AbgAQNse (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Jan 2020 08:48:34 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:42815 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729039AbgAQNse (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Jan 2020 08:48:34 -0500
Received: by mail-qk1-f193.google.com with SMTP id z14so22685281qkg.9
        for <linux-btrfs@vger.kernel.org>; Fri, 17 Jan 2020 05:48:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=RqkGJtTlwbicUPBLGp2IaZBBFNmS7nDH0ciMWvbfcF4=;
        b=Czy/zaGCqWB3sLs/ACPLE+iREssRFJRb/Hrrv/SOo8EsZT6mhzKC0qKttLXbKj6SvZ
         vXMdSVgYNrglVOZS5e/ozjcg16tYQXp4kDH+h+U5LuUCiMuB4MwgEU4zhTMln3iJU2+q
         kcmG5WKRceSHsP1Av4bEqHVeEWeigCtpUvmwAtWRMyEsyrQbpez9Kj58zjFFpYCmpcnK
         3B+yaqzJ/nrXhMisaNty0O7cl9dHEqbfra69Msh3ehl2CegPq/f7k7lEuDRXFof/EySx
         kDA6sk3RUsMdMF0SsA+c1rZve+hZBFYcbVcWDNfiema0gBOUHxcR305Dd0QrMw2fNstt
         SdKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RqkGJtTlwbicUPBLGp2IaZBBFNmS7nDH0ciMWvbfcF4=;
        b=kThUSq3kTGSWktyJlymgbmlA+TJllq+Xe7irsXLHKmY3JXZMhun4u5LJ9mX03lhZFR
         q9EKA/z+JIV3YgIjR55iCQ+aj447fQQqBgnR+uF0nq4YvkgEqTlshxC/p0Kclhlgnbvj
         kVu2TWOnswQsf8sEJzDe2oX51Blmy/rxPeJjkvaC67GHSm+MQOV9FzRIuu6BluEneQIj
         6E6Xs1wXSYyVHeogKb9VlJJPB+NoYCE0e5flqnlDvCoyQ6umXwS7jj5v81R2CByBy5ME
         23ZfJfFtzqNqVOPOKvpSh4rsj6QjEUJGg7qfasaMxJ+UB+OwIij04Z4V01u90tffx8sv
         ZO/g==
X-Gm-Message-State: APjAAAWNWtzvDCZRmwkI29u+D1oOHtnSfUSntHExj67skwHq1rRIc/X0
        BYhv18NqGEb3DL9IGrVuri0JrGsCjACxaQ==
X-Google-Smtp-Source: APXvYqxxlNSaI06tLee7AFmKeRw3X0E+9w+NZapx4sU6FO94YymWeFM6gSkgXvvxILZKW0pGrYlSFQ==
X-Received: by 2002:a37:2e82:: with SMTP id u124mr32526126qkh.294.1579268913088;
        Fri, 17 Jan 2020 05:48:33 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id b7sm12885672qtj.15.2020.01.17.05.48.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2020 05:48:32 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 19/43] btrfs: hold a ref on the root in btrfs_ioctl_get_subvol_info
Date:   Fri, 17 Jan 2020 08:47:34 -0500
Message-Id: <20200117134758.41494-20-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200117134758.41494-1-josef@toxicpanda.com>
References: <20200117134758.41494-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We look up whatever root userspace has given us, we need to hold a ref
throughout this operation.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/ioctl.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 5fffa1b6f685..7d30c7821490 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -2683,6 +2683,10 @@ static int btrfs_ioctl_get_subvol_info(struct file *file, void __user *argp)
 	root = btrfs_get_fs_root(fs_info, &key, true);
 	if (IS_ERR(root)) {
 		ret = PTR_ERR(root);
+		goto out_free;
+	}
+	if (!btrfs_grab_fs_root(root)) {
+		ret = -ENOENT;
 		goto out;
 	}
 	root_item = &root->root_item;
@@ -2760,6 +2764,8 @@ static int btrfs_ioctl_get_subvol_info(struct file *file, void __user *argp)
 		ret = -EFAULT;
 
 out:
+	btrfs_put_fs_root(root);
+out_free:
 	btrfs_free_path(path);
 	kzfree(subvol_info);
 	return ret;
-- 
2.24.1

