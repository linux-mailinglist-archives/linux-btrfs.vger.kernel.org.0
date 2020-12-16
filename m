Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B46C52DC408
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Dec 2020 17:25:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726677AbgLPQXo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 16 Dec 2020 11:23:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726671AbgLPQXo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 16 Dec 2020 11:23:44 -0500
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEFA8C0611C5
        for <linux-btrfs@vger.kernel.org>; Wed, 16 Dec 2020 08:22:37 -0800 (PST)
Received: by mail-qt1-x82f.google.com with SMTP id h19so17562579qtq.13
        for <linux-btrfs@vger.kernel.org>; Wed, 16 Dec 2020 08:22:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=6Meqz591s/ZyFD9Md6tWZufYHS4nUbySwYA7AhCwTDI=;
        b=Ei0CDR9NzH6D+wNaSRBBFLWuMiAa4tSc35rdUxtloFS85cHbQyg3mMjDwOuG4QRPQk
         EPOqo6l+c/wZ0zAvgzk30SF1hdIaxRJT30zcXNBARYUbGB6zvw+lH8MhF+qKA/W2zx6+
         14vT6s++1zUCpAgVSb+2XL4O4MH84xr6PKBoBeKQ7UKw89Y4pFsocjyCR2atwi6AwnWJ
         7I8W1ZVfg8bZoeVPdfuAXHEhP6QQaXCbzzGyP7id+09d41JbB7aSAOdMrWopbzkTkUkD
         KIurZl1WPayXi1rLNDeen0dxhW4Z3N6zVb4bOBnQT22pplZnMTu1IMETMtOqrI7zWPnR
         7AIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6Meqz591s/ZyFD9Md6tWZufYHS4nUbySwYA7AhCwTDI=;
        b=U7VJOZkQaIoMTG9AeemfQ5XZazQ4mZ6MS5TNT7UtO49yGflAKbNff7bePpUgx64gHp
         LKAbHsLgbfoGi0SHx72NcK2+xsb9Err1faYkU2pD1ljc6ybJklBNsH2INb12mqwzpSxH
         YSgUvWtyWOdxFAzAWsgL7091G7tH/YQBf++KJbcfIxzfSMm09NkIovb3M+MW8eemHH2U
         I2iSjOmSjuEvjT1JYBC3rF5a3wAz1Le34PIpWTeL5qNykRF+9CxVn7iaD2mBse0pcdbm
         dIMMQHbldjZJTlPn8gKJeTAGL5oGxTAQstGcJBDMIc7EEokS9wozTrt0BQUgqmY3MaYA
         6H8g==
X-Gm-Message-State: AOAM530Vu8VvjzRJTyrwUKLS+XizSVQCygxojPNKKMDEn0ylGWPwHsXn
        bAJW3kjZVt5SmH09NFQZ3aOwVRVkRKZeao75
X-Google-Smtp-Source: ABdhPJyLHWUIaz11ir9wBCWwKQOr1m+qvanbIT9dX4szQxj6TUmUGAly3mzNXwq97INHvlxuEqQHwQ==
X-Received: by 2002:aed:3051:: with SMTP id 75mr43223907qte.64.1608135755851;
        Wed, 16 Dec 2020 08:22:35 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id v186sm871408qkd.98.2020.12.16.08.22.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Dec 2020 08:22:35 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 09/13] btrfs: modify the new_root highest_objectid under a ref count
Date:   Wed, 16 Dec 2020 11:22:13 -0500
Message-Id: <db3b68c826ae28684100195170a913b13a23b567.1608135557.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1608135557.git.josef@toxicpanda.com>
References: <cover.1608135557.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Qu pointed out a bug in one of my error handling patches, which made me
notice that we modify the new_root->highest_objectid _after_ we've
dropped the ref to the new_root.  This could lead to a possible UAF, fix
this by modifying the ->highest_objectid before we drop our reference to
the new_root.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/ioctl.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index dde49a791f3e..af8d01659562 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -717,6 +717,12 @@ static noinline int create_subvol(struct inode *dir,
 	btrfs_record_root_in_trans(trans, new_root);
 
 	ret = btrfs_create_subvol_root(trans, new_root, root, new_dirid);
+	if (!ret) {
+		mutex_lock(&new_root->objectid_mutex);
+		new_root->highest_objectid = new_dirid;
+		mutex_unlock(&new_root->objectid_mutex);
+	}
+
 	btrfs_put_root(new_root);
 	if (ret) {
 		/* We potentially lose an unused inode item here */
@@ -724,10 +730,6 @@ static noinline int create_subvol(struct inode *dir,
 		goto fail;
 	}
 
-	mutex_lock(&new_root->objectid_mutex);
-	new_root->highest_objectid = new_dirid;
-	mutex_unlock(&new_root->objectid_mutex);
-
 	/*
 	 * insert the directory item
 	 */
-- 
2.26.2

