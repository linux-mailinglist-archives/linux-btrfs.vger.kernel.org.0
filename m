Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 74248148933
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Jan 2020 15:34:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404380AbgAXOda (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 24 Jan 2020 09:33:30 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:43647 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404285AbgAXOd3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 24 Jan 2020 09:33:29 -0500
Received: by mail-qt1-f193.google.com with SMTP id d18so1617744qtj.10
        for <linux-btrfs@vger.kernel.org>; Fri, 24 Jan 2020 06:33:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=hA4iNKOpd+uPQ09XByOlq3GwjvuYpxH5XpAmxRgdPC0=;
        b=MuvFaWPgM61BfbZjQ2r4+UI7/QmprFWkez0dBZFf+9yeDJHEOAigyscfM00GneqnOP
         SL1EeqMfpyc575zsl6bI8/koAx1BSdd2ZIAoPaJDLEus3+VMImjzEu9+LQbeBFay8lzi
         t/7iFxOxH09OcZshvLuszcwzt1b6FjGTZgQ0A5c/WlzzuZ7HFHAadn2+0UCc7S34g+KT
         lWlxnIXOlwBezA4b0sVd7xI82PrnTLPBYyxNyTK82AS4QV+tC2dqzASfJq4Tvwi7T9vz
         wg7UTLA0tVtKMfn84MZUBc5xzaE2OgZvl6cdx5x5Lhn5MNoZHRAdehZMDtGr+o8lfPJc
         XaCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hA4iNKOpd+uPQ09XByOlq3GwjvuYpxH5XpAmxRgdPC0=;
        b=Q17ttM28V33EjsogJn5HLBzAMeiTUWL0Pr5SOkCyZTLZX0xYtaHbigIuEuZgSBrzRt
         kYeolClOy3+wAqmTazHU67BrTwQmvpWUAIvQvRI+syNxjiy4onHjtDu+qOBzp5OJ9JKe
         woiJrvFDSEM4wG6bq29nDRCC+aNwgsO3Nm9vK7Aid64bft2Fy4dk2jsRc62Yzsh1w90M
         pXxF3SLHK+vLFTh30VM1ZpqyL+TJY8Q3+XJC/8q/2aMScZoixgsyJh8YjjtfPmqr735v
         oQIRtkHc3/26dzq8lcZZilu4DY8LDlYC/631BMYLXcBWZJDWXWGTmmnGcojQMWkh7u6j
         TbVw==
X-Gm-Message-State: APjAAAWXZylaIxcA2l4xZb8hNZtE28qM/OrxxYnGCMvyFjYf3kGrIRrl
        MyDH8yRgSI/dixIAa57vS9l3Hg==
X-Google-Smtp-Source: APXvYqzcqR1yMA8F/IntSKfK554vbG639Q2A9cA0o84gKD14LROQRJYFcYgM32HObhNJxr15IQxd3A==
X-Received: by 2002:ac8:4086:: with SMTP id p6mr2367033qtl.161.1579876408626;
        Fri, 24 Jan 2020 06:33:28 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id g16sm3090410qkk.61.2020.01.24.06.33.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jan 2020 06:33:28 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     kernel-team@fb.com, linux-btrfs@vger.kernel.org
Subject: [PATCH 15/44] btrfs: hold a ref on the root in create_subvol
Date:   Fri, 24 Jan 2020 09:32:32 -0500
Message-Id: <20200124143301.2186319-16-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200124143301.2186319-1-josef@toxicpanda.com>
References: <20200124143301.2186319-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We're creating the new root here, but we should hold the ref until after
we've initialized the inode for it.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/ioctl.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 958c0245c363..b1d74cb09cb4 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -672,10 +672,16 @@ static noinline int create_subvol(struct inode *dir,
 		btrfs_abort_transaction(trans, ret);
 		goto fail;
 	}
+	if (!btrfs_grab_fs_root(new_root)) {
+		ret = -ENOENT;
+		btrfs_abort_transaction(trans, ret);
+		goto fail;
+	}
 
 	btrfs_record_root_in_trans(trans, new_root);
 
 	ret = btrfs_create_subvol_root(trans, new_root, root, new_dirid);
+	btrfs_put_fs_root(new_root);
 	if (ret) {
 		/* We potentially lose an unused inode item here */
 		btrfs_abort_transaction(trans, ret);
-- 
2.24.1

