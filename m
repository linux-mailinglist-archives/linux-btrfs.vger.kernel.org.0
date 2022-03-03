Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D65DA4CC9EF
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Mar 2022 00:20:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236581AbiCCXUQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 3 Mar 2022 18:20:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236284AbiCCXUL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 3 Mar 2022 18:20:11 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 441BA14FFDA
        for <linux-btrfs@vger.kernel.org>; Thu,  3 Mar 2022 15:19:25 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id t19so2596875plr.5
        for <linux-btrfs@vger.kernel.org>; Thu, 03 Mar 2022 15:19:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nuKFYZLg4Yh4s47S+CVL48QhHrHOvOA9fdRSW1WoeqQ=;
        b=NPxC2aOTa3QfLU1t1LbjCsLf68388cScscn/uPuZNgvrB+KU0Adk+H7vQ43MVmEoQb
         oNAcCvqDejftWh1res5tE7efuQDvMjtU82e9NK3Hk/+Y9hxs8cO56JOITd7NjR2mKzGH
         9EIA1VR9oPtrXIkk21RO+V/tFLr7LYPzdmGg89J1FcreiZOw1Ayrah0oYnB/ey2I+zvT
         5mg8Tn106hqF0pO7z30ECjvKRJ7YzgNNzyGavKFMTGRjQgnQ+tk48FAVm/Pjo+P1ACTz
         BQvgBQU0FEB0EjiLy9VM8xIWeyldfc9rbUOQbK2tyxEMOg9v+Jnq4c2ZgJYtoo6zCMas
         Irlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nuKFYZLg4Yh4s47S+CVL48QhHrHOvOA9fdRSW1WoeqQ=;
        b=QXnkh3HI4Kva7xUWlhQ01OZ7tIYOdUlfR1Re9EDigFTRiUWINz51j22xXFAbzD/QbF
         X9qw8RDNVUBwFpgyIgEWGt2M0XsDCtAr4LduqubUeRdtmEyLD4nBq+jkfZfhMAtDX26W
         CF94+akl3OryWAiZdQsBncjoVyOGeIdkx0Ck9x1hmO3hvXKrHjK/CAgIw3D/kJk7mfKG
         pS7/18nQJTiRcX2rDFkM2Y2yc42uS636qRZ7688AaHj8VzYkfUNOzgy4N2++scmQAu6B
         9KnlNTchbdUGk8IkbvynK+KH+F1qLwQbljziNkmWxhXnwxnyFnmuA8UaQgTwZgLv1avF
         6B4A==
X-Gm-Message-State: AOAM531uSF8NLaS67vOpBTggkdSB91M9kbJahOSc19605ZrpckMNG5Xl
        63sxIZ+Ut9fGcefs/nhnLEtFxsSi/mCH3w==
X-Google-Smtp-Source: ABdhPJy/WgLF8CgwAjyDZ2z4dGOeDal3j5vOw81OQ5BnChO7UPFM64n9WfBNzfc1LejMrj68z8+Cyw==
X-Received: by 2002:a17:90a:fa95:b0:1bc:509f:c668 with SMTP id cu21-20020a17090afa9500b001bc509fc668mr7806084pjb.189.1646349564474;
        Thu, 03 Mar 2022 15:19:24 -0800 (PST)
Received: from relinquished.tfbnw.net ([2620:10d:c090:400::5:76ce])
        by smtp.gmail.com with ESMTPSA id x7-20020a17090a1f8700b001bf1db72189sm1103507pja.23.2022.03.03.15.19.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Mar 2022 15:19:24 -0800 (PST)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-btrfs@vger.kernel.org
Cc:     kernel-team@fb.com
Subject: [PATCH 04/12] btrfs: remove unnecessary btrfs_i_size_write(0) calls
Date:   Thu,  3 Mar 2022 15:18:54 -0800
Message-Id: <d5cf406f80d674848ef6a175fe3dd78cc7b26ce8.1646348486.git.osandov@fb.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1646348486.git.osandov@fb.com>
References: <cover.1646348486.git.osandov@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

btrfs_new_inode() always returns an inode with i_size and disk_i_size
set to 0 (via inode_init_always() and btrfs_alloc_inode(),
respectively). Remove the unnecessary calls to btrfs_i_size_write() in
btrfs_mkdir() and btrfs_create_subvol_root().

Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 fs/btrfs/inode.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 9c838bdd51cc..244e8d6ed5e4 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -6606,7 +6606,6 @@ static int btrfs_mkdir(struct user_namespace *mnt_userns, struct inode *dir,
 	if (err)
 		goto out_fail;
 
-	btrfs_i_size_write(BTRFS_I(inode), 0);
 	err = btrfs_update_inode(trans, root, BTRFS_I(inode));
 	if (err)
 		goto out_fail;
@@ -8787,7 +8786,6 @@ int btrfs_create_subvol_root(struct btrfs_trans_handle *trans,
 	inode->i_fop = &btrfs_dir_file_operations;
 
 	set_nlink(inode, 1);
-	btrfs_i_size_write(BTRFS_I(inode), 0);
 	unlock_new_inode(inode);
 
 	err = btrfs_subvol_inherit_props(trans, new_root, parent_root);
-- 
2.35.1

