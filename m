Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 99AC912D4AE
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Dec 2019 22:31:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727727AbfL3VbZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 30 Dec 2019 16:31:25 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:36617 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727691AbfL3VbY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 30 Dec 2019 16:31:24 -0500
Received: by mail-qt1-f194.google.com with SMTP id q20so30472668qtp.3
        for <linux-btrfs@vger.kernel.org>; Mon, 30 Dec 2019 13:31:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=ieUAFwhIKx4DpFgDaDO4d7DYtH2i4i+TfaHpqbulT6s=;
        b=1o++Dc5Of2VvouuOvMwiaJFXwKrF1ei9b3uwaJXmfZymfUlX6pXhFts6fI+zogdhTt
         NAvEpH5fIYvfCU1KDhYIXRJghk6F1k0F6q7kXA/WcActz8TQj3xEa6ZYo14q7KUNR/cs
         e0q5+b66q+HPVyF1xUpPHUtNDLtRn2+GE1crK9OQcM/tEGWSOaxxS8nqG2dSqG/0MGag
         nWost0pjJeq/j+GiYMsTk4QcLY9IeuMwN0mWCDqpt3uxkeajiT/iMHNcn5D/TXELQ4im
         bZkmjQq/mfVBiOQoSO8SmJqc8QLX+k4eeLltAD8ShEjJlppNqAVPq108t8LvplvHzExn
         oWvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ieUAFwhIKx4DpFgDaDO4d7DYtH2i4i+TfaHpqbulT6s=;
        b=ksWd0rzwDPgzQs+Tzv/XLeLGq2jqfr8shdhER/tCAdiFboeET44YILP4anYPSZTCLV
         OiRfhu1B1oyioifzm5YOtKpSLU4R73LxgjrndDILLid3XP/7OnVBufyI8v6ZT3uYhNcg
         +rzydptascAzsJH+PrASeSyzeXEZyLILJsF++VSaYRfwLc6g37ka8L8aml1Asotcmqdc
         NOWtCCvG9lDjTxljFpqPROLs+I1SknYq8FDBTux+mLf5Puo1QgHtIJeZBDo9pd/C5Ywt
         k+TtwD8WNVB9xa2rCc31v0CoQCkOaztB6Etp+1C24KtfZulTJMtU65ymRVcooTI2EF0h
         dq4Q==
X-Gm-Message-State: APjAAAXzgGZKTP73Lvyjf/MyIYnD/uiwg7Dy5+EdcApNDN5VM2LIRMS+
        6Q8/t6vilQYzcxn0a0gZAFL0a7etdTqobg==
X-Google-Smtp-Source: APXvYqwHk/KN0NqqqvLl07kwfn9TAVLDDCC92BOqTP8GpWlXXG/bdJ61EYXVmkWQFuHb524e1c9MVQ==
X-Received: by 2002:ac8:408e:: with SMTP id p14mr39693743qtl.66.1577741483740;
        Mon, 30 Dec 2019 13:31:23 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id l33sm14273558qtf.79.2019.12.30.13.31.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Dec 2019 13:31:23 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 1/5] btrfs: use btrfs_ordered_update_i_size in clone_finish_inode_update
Date:   Mon, 30 Dec 2019 16:31:14 -0500
Message-Id: <20191230213118.7532-2-josef@toxicpanda.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191230213118.7532-1-josef@toxicpanda.com>
References: <20191230213118.7532-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We were using btrfs_i_size_write(), which unconditionally jacks up
inode->disk_i_size.  However since clone can operate on ranges we could
have pending ordered extents for a range prior to the start of our clone
operation and thus increase disk_i_size too far and have a hole with no
file extent.

Fix this by using the btrfs_ordered_update_i_size helper which will do
the right thing in the face of pending ordered extents outside of our
clone range.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/ioctl.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 8ec61f3f0291..291dda3b6547 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -3332,8 +3332,10 @@ static int clone_finish_inode_update(struct btrfs_trans_handle *trans,
 	 */
 	if (endoff > destoff + olen)
 		endoff = destoff + olen;
-	if (endoff > inode->i_size)
-		btrfs_i_size_write(BTRFS_I(inode), endoff);
+	if (endoff > inode->i_size) {
+		i_size_write(inode, endoff);
+		btrfs_ordered_update_i_size(inode, endoff, NULL);
+	}
 
 	ret = btrfs_update_inode(trans, root, inode);
 	if (ret) {
-- 
2.23.0

