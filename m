Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C8442B2041
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Nov 2020 17:25:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726691AbgKMQYR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 13 Nov 2020 11:24:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726775AbgKMQYQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 13 Nov 2020 11:24:16 -0500
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65CCEC0613D1
        for <linux-btrfs@vger.kernel.org>; Fri, 13 Nov 2020 08:24:16 -0800 (PST)
Received: by mail-qv1-xf44.google.com with SMTP id ek7so4842042qvb.6
        for <linux-btrfs@vger.kernel.org>; Fri, 13 Nov 2020 08:24:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=dNWXRUaiVdRzj0dHn2Wa8ZREcKdKqXVT4DRXFdjlvqI=;
        b=toSlhcLYgGw6elbvvSOKgwGYL9G+oPn2i/7+OW1vnTdm8toQ3wcrRkfkHaCkbWQCiM
         LXu/DCcOYd/+fBQNl7sJew/TW9VglgUYt8bGsg8b5yDGpi99dBcl879vsSiefM2sUmIZ
         suIj6C5zAQYJF/pWhdfriOKtq5TEQGSsr6x0f67zEXpgJ6D1GEzgUgAgojrPB7IyqcWN
         NW1G2AZbYP7D5i8eJc1xzgGtiAWQE3HMiP25vTHcJJjDfkP1fW499S3PRhdPuRby/EB8
         MSfm0shkpw3+AwCkOuUQBqjPREmv5A62hoHoFnkzYBAYJm8VbJU/l04RJLwptO8F/UER
         E2NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dNWXRUaiVdRzj0dHn2Wa8ZREcKdKqXVT4DRXFdjlvqI=;
        b=DPmN/+rgS4QOaHZDnV/yLRY6cCD/+Tgf9F/j7THmOP5RyAXE4xkmfff5F3wrl/UjlC
         /iimGd4aLVhPhT4t0+5T4mzU6OUp7D6hg2ZxrZGMUsbrwRSOrEpyGbidRrUteyws3yc4
         jU3kN8sKJqsUMH1ORxWjnaAv2DH//ByurT5VxeCNEbIdsmBX2lpBwlrE02pDz5urAN9e
         oWK5LJ37GlnSW/Byh9VdgY1NrFF3fhp7d+TuMbsTSkxs7Fo9c8q+lEq8KJm57Jl8tsXz
         GIkGBHbQ5sOdQWZHDsxVmi0qxvbDheYjcoR5HNwHylwLrXLMZnbns6GC2PXC5GjeSp67
         JKjQ==
X-Gm-Message-State: AOAM5319Pu5F2wAygi742cHqe7xeZw5CrJRNEp+ukHc0Hky0sSv4TzN5
        3PneyxKjdCv6QoTaVuT3H11aNr0GaiCH6g==
X-Google-Smtp-Source: ABdhPJwko5JNUAnXFSvFIIztcdEu2zX9wdIwPa0Z5IrA/aPOlGg8ZxZufC2V/wYxzvbVv02FFOagXg==
X-Received: by 2002:a05:6214:229:: with SMTP id j9mr2965668qvt.51.1605284650414;
        Fri, 13 Nov 2020 08:24:10 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id 199sm2453922qkj.61.2020.11.13.08.24.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2020 08:24:09 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 19/42] btrfs: handle record_root_in_trans failure in create_pending_snapshot
Date:   Fri, 13 Nov 2020 11:23:09 -0500
Message-Id: <dbbec78c645d3b40fcb9584b77f3e10404402759.1605284383.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1605284383.git.josef@toxicpanda.com>
References: <cover.1605284383.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

record_root_in_trans can currently fail, so handle this failure
properly.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/transaction.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index d0f130172622..0aa6d8ddad21 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -1572,8 +1572,9 @@ static noinline int create_pending_snapshot(struct btrfs_trans_handle *trans,
 	dentry = pending->dentry;
 	parent_inode = pending->dir;
 	parent_root = BTRFS_I(parent_inode)->root;
-	record_root_in_trans(trans, parent_root, 0);
-
+	ret = record_root_in_trans(trans, parent_root, 0);
+	if (ret)
+		goto fail;
 	cur_time = current_time(parent_inode);
 
 	/*
@@ -1609,7 +1610,11 @@ static noinline int create_pending_snapshot(struct btrfs_trans_handle *trans,
 		goto fail;
 	}
 
-	record_root_in_trans(trans, root, 0);
+	ret = record_root_in_trans(trans, root, 0);
+	if (ret) {
+		btrfs_abort_transaction(trans, ret);
+		goto fail;
+	}
 	btrfs_set_root_last_snapshot(&root->root_item, trans->transid);
 	memcpy(new_root_item, &root->root_item, sizeof(*new_root_item));
 	btrfs_check_and_init_root_item(new_root_item);
-- 
2.26.2

