Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABEF82B0FFF
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Nov 2020 22:21:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727261AbgKLVTx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 12 Nov 2020 16:19:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726995AbgKLVTx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 12 Nov 2020 16:19:53 -0500
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 987C5C0613D4
        for <linux-btrfs@vger.kernel.org>; Thu, 12 Nov 2020 13:19:40 -0800 (PST)
Received: by mail-qt1-x844.google.com with SMTP id 7so5239755qtp.1
        for <linux-btrfs@vger.kernel.org>; Thu, 12 Nov 2020 13:19:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=twoMWLzJIbROA2MpLSZs0LqKLPCYENEfTgo6Myg9VCk=;
        b=NNABt7C5/6zTSMwrYRXL/9YOjqtCGO3aYxp/VAnhETmZWS9GRoLwy1gIZR/dGr3Lwe
         Jr3D0VZ1jFgIK4W7R0qmIlhrXaNPB+ZPd2DPNRiDAyNUciadUH3LhBUOveZB1yg1Rs0t
         0JI1UZTicOpsI6cbmV+lqnzqumvFhVDyGomOuvsOy9PapqkjF4sFaC5IEDu7zuP2y0ua
         WCccSh7XlGSv5VTd8a08ctzKd36wE8PW98eqF2tCQhDMRmmpQ8NtCKkkdua7e/XCz5R6
         ofU3JKHji1lC/LUK/zcYYF7bkiS6LjPJFYmtMTcF9Utc8fIU0pOkMiA+ZszyWV+FP06M
         u9hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=twoMWLzJIbROA2MpLSZs0LqKLPCYENEfTgo6Myg9VCk=;
        b=V5d9vSSPzzkJAlxbf513lTgQ4PN9HtxTb5lELPxOUH9MNzKkZnBychG+r+gkywoyMN
         bylPiQJmgOARHwzNn79q+Rc1VdK062roZFkwYJduilbp3Z1GkQNqoKUeRkElTAIddtdL
         d63QZ1/iViANkEWTfJ27y1qm1lsVc+qFK9UQ4mDjWebcJyfFwT+6+i4vJKxnWuazB5gz
         OMr21o4dJ3ziu01s8AqxOmbHdYuYVrUdbH/+Xja91+9vFjw901OdutwwwvbZKOWtWX62
         Rc13kARWHDKWJQDyg5OozEBk+jP38vjcglM5v0N7jLWeCLy20Y6Kg9lwRzI2QaVD2+/M
         3Llg==
X-Gm-Message-State: AOAM532JZ/zHJATK6dNaaDfZBlQk1yWIV2ci5QdVyUHKrHv9kJtGDNCU
        kAGtcUq50gEloU2c7g9UoW3u1k0aAyuRng==
X-Google-Smtp-Source: ABdhPJxkCt2ZsWDb5HAAuxAaaJhaxq3RXT2Zw2ekoR4RB2qTZGTaL88BVvTxR0tmHD/9UTREveG28A==
X-Received: by 2002:ac8:1401:: with SMTP id k1mr1202690qtj.227.1605215979513;
        Thu, 12 Nov 2020 13:19:39 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id j202sm5357659qke.108.2020.11.12.13.19.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2020 13:19:38 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 14/42] btrfs: handle btrfs_record_root_in_trans failure in create_subvol
Date:   Thu, 12 Nov 2020 16:18:41 -0500
Message-Id: <09d4e172b154249e734b646d0b2ddcaa09612590.1605215645.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1605215645.git.josef@toxicpanda.com>
References: <cover.1605215645.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

btrfs_record_root_in_trans will return errors in the future, so handle
the error properly in create_subvol.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/ioctl.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index ea40a19cc4cb..ca25183c9c84 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -702,7 +702,11 @@ static noinline int create_subvol(struct inode *dir,
 	/* Freeing will be done in btrfs_put_root() of new_root */
 	anon_dev = 0;
 
-	btrfs_record_root_in_trans(trans, new_root);
+	ret = btrfs_record_root_in_trans(trans, new_root);
+	if (ret) {
+		btrfs_abort_transaction(trans, ret);
+		goto fail;
+	}
 
 	ret = btrfs_create_subvol_root(trans, new_root, root, new_dirid);
 	btrfs_put_root(new_root);
-- 
2.26.2

