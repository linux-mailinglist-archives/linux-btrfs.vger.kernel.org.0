Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93C852D2F6E
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Dec 2020 17:26:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730236AbgLHQYv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 8 Dec 2020 11:24:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729035AbgLHQYr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 8 Dec 2020 11:24:47 -0500
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B960DC061793
        for <linux-btrfs@vger.kernel.org>; Tue,  8 Dec 2020 08:24:06 -0800 (PST)
Received: by mail-qk1-x741.google.com with SMTP id h20so16448597qkk.4
        for <linux-btrfs@vger.kernel.org>; Tue, 08 Dec 2020 08:24:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=6Meqz591s/ZyFD9Md6tWZufYHS4nUbySwYA7AhCwTDI=;
        b=HLdx/BBvNHzbaVuPj081mpvZpqDOfziRyEAoJcx6XBplWOumksfdsIWKw3w+8J+aWE
         wl1cKxVDGi3Yf7NHPqUQdpJN1kPs9/+I6vjX4WDuYLnldlRzb1q3Cuo8IAFV7E/6qzC7
         iJCFFJCRJiKyH7vnASJfEZksJZZnjqfSX2tus8FMmcb4RB5m1HtcVQ1bkJ9CcmivRfmT
         uTEPz4ZUooVFiB5W7t07cQ323jCCUYOn47jCRRwjJKMaUQOb67NLBtcYalYPIv6GogAQ
         WHyVdBVf7wP2sJQMpdA0smXKxJYIOBgHEhPPQ+FP/TWpA2TGGkzdh7Bow5bMmcB2IIZX
         Yxhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6Meqz591s/ZyFD9Md6tWZufYHS4nUbySwYA7AhCwTDI=;
        b=lNyMlHPjMZT8ygOFmn9gvgIGSsFOPSofJ5V6MkmiJTi2iFFM16GYgNb+aYB4QjtlvE
         Z/+OUvYxLk6uqW7R1IsLkuSOL9QYccv3JCQwrWDssLxSFDggjf9EhHDpI4As6DLJmFef
         NkjCeKBovUqqb4uUzrhHXCpcgzTCW1LAaFbcl2SDL+ctdVJ59+izGHYgM4RWQq5il2+r
         hnRzdMBWBNLtNXhJvy959R/030kajNcXcEMrUWRhgXznvfRERCqw0Um4gv3KkdOY/u5r
         6RxJSDK7GaMlvciFd+eBLBWifc/BB8cVqfXUlNp18AA10vQRpNIoqwaRGCp97XwU0Dk7
         9umg==
X-Gm-Message-State: AOAM530REjPh/wy62S2KwPq+OCOJwT84pA/ZqqlNrwfyDTcRYMrxwbjp
        vesGZmFemfM1aqiaXTPa5edpetjyu8qoaJBj
X-Google-Smtp-Source: ABdhPJx6oYiYW/wBuMPgrS2rP/cAcmhkzoqmiYqWcq+lbIFwJuJrY5OwYiAAuRTo9C4WUh5jwisnHQ==
X-Received: by 2002:a37:801:: with SMTP id 1mr14831429qki.475.1607444645701;
        Tue, 08 Dec 2020 08:24:05 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id w22sm4354128qtt.76.2020.12.08.08.24.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Dec 2020 08:24:05 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v6 02/52] btrfs: modify the new_root highest_objectid under a ref count
Date:   Tue,  8 Dec 2020 11:23:09 -0500
Message-Id: <bc8902e88af1ea39843786dde86b606c01161c69.1607444471.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1607444471.git.josef@toxicpanda.com>
References: <cover.1607444471.git.josef@toxicpanda.com>
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

