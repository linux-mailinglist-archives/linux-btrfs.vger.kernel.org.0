Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3364C2D12BE
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Dec 2020 14:59:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726869AbgLGN6j (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Dec 2020 08:58:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726234AbgLGN6i (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 7 Dec 2020 08:58:38 -0500
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97F70C0613D1
        for <linux-btrfs@vger.kernel.org>; Mon,  7 Dec 2020 05:57:52 -0800 (PST)
Received: by mail-qk1-x744.google.com with SMTP id u4so12479963qkk.10
        for <linux-btrfs@vger.kernel.org>; Mon, 07 Dec 2020 05:57:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=6Meqz591s/ZyFD9Md6tWZufYHS4nUbySwYA7AhCwTDI=;
        b=Ch3sUpdokZB4sdQS3sIpRDvxJxAilQ7R9sBWrD3fsYwoO+cMtNxsJ6tePp142bUuRO
         0uaaTPrBuDTAiWm+crwXHx4JROIWcqvUKjDNwTcS/Sc4NeAhkr5C6hN/cdeczsOgG6dv
         B4SaSg/sbchG0c8vV/9Q29ZFYnzuAdnxHLImTGgmVfI751aedtUIFJ/p4ypSoN3NjjVr
         rYUpTdeCQKkHe5xpqw/cQcuS9tW677hGaONtpaPTGs0n6eOFyGWsr3orQWAtlyiwArMU
         kXpgVIluP/jp3sveJq7pdp2Nde4fITJvH1pluQl7CCe6AJzEIqbHpgqOrYRUJbmMP+FV
         49zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6Meqz591s/ZyFD9Md6tWZufYHS4nUbySwYA7AhCwTDI=;
        b=V1vXJ3H7yid3znZOGHCoZ7EqffD1Ak6KeMWS5TcWbrSEGwXtwhyhcJnY0Np9PLi2cN
         IU0NOTAhhiU0HqYKcoZRULABEtKoa3121igAIGHdoJJEbs+9PAdW3p2N/3CRAEHvy2ME
         jBJwyTOfq8pSmV2tSIWHNTBgB2EGTxqJCL9wcrA20HmtwzByyYkc8rWYT6xMmu1v+rep
         FVWE3PetHSuQMLYVorI9flM+vrDzl7VWKK1atDzZXBYO17kPRr3am3l4E71RsdMCuxQL
         8wodQiFQ9rMp8905jWUDN6Kdfi43mwh4hkQVAvUiKqvDDTupBm5CTpCOa04apIhZwWep
         Eryw==
X-Gm-Message-State: AOAM532fYwkCrKpQczIU3kaS/SEDpI/FHLrOzYThZbszc8c52W5qQ+xf
        1NH+J3gcXxu0wJLjcACbNZzkI2ZDngfkHxDb
X-Google-Smtp-Source: ABdhPJyR5T+mYXTcvk6jC49xys0WT4Pglo2h7AsDsejl+3E6XcNF/C00L7ABnXqyccogp3pqQ24F0w==
X-Received: by 2002:a37:2cc4:: with SMTP id s187mr24452432qkh.385.1607349471358;
        Mon, 07 Dec 2020 05:57:51 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id x189sm4866468qka.26.2020.12.07.05.57.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Dec 2020 05:57:50 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v5 02/52] btrfs: modify the new_root highest_objectid under a ref count
Date:   Mon,  7 Dec 2020 08:56:54 -0500
Message-Id: <790aae14daf733fb8bd0d7cf5b139b18a837004f.1607349282.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1607349281.git.josef@toxicpanda.com>
References: <cover.1607349281.git.josef@toxicpanda.com>
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

