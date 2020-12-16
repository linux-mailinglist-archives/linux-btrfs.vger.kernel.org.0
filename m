Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57CFF2DC42C
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Dec 2020 17:28:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726745AbgLPQ2Z (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 16 Dec 2020 11:28:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726737AbgLPQ2Y (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 16 Dec 2020 11:28:24 -0500
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70CDFC0611CC
        for <linux-btrfs@vger.kernel.org>; Wed, 16 Dec 2020 08:27:16 -0800 (PST)
Received: by mail-qt1-x834.google.com with SMTP id g24so5194498qtq.12
        for <linux-btrfs@vger.kernel.org>; Wed, 16 Dec 2020 08:27:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=rXkllivM/LlDIU6qMHpbw+hMYUQ5EKZq1LEuGXDx7tg=;
        b=Bk5S592a/a6bstIEbfiRCoS0ZX1xLA/M+YU7KdaMzwfQv9NUeX054gXdVbHcKLLA1A
         Nra3r30YjgiOAhtCjsRbsGpe5lDF7cByBrTgp3SBoreOD1viqVdze5P/hhYG7qzgwZ5X
         xTXyWSYaBGHDXUj2OxItVoO5PlEjWfYuWzrReNX0AUU2Js56xQBJSvOtFmgqCR/LRFLE
         eKDKl7mDqj1Tuy9cK0fZBfhGnsASXCGQkaTQFTr+e8XaVB2qK+rcuv0LmLMMZ+QZ1+FJ
         dgiWlMJaLFXGXFsD/RsovbIhQMfcC8szeMpHeuAHFsUn2btye6AaERqaqTpp0OeecxFV
         apog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rXkllivM/LlDIU6qMHpbw+hMYUQ5EKZq1LEuGXDx7tg=;
        b=BLZlvA8AjTWLdr4OSIWhGzGjPRcjNup1CJDn8QVX/7uyJyzZN6nYC2Z8UB1GDC5Jof
         VbH0q0p7dkihYDx28XPFTx32I0GlxynjBfADu4QX05qOpfEbf0k1yrzn5wLPzb2kDgeH
         IOy1cvm1RY/ZmPF8yqSQMAkgJVw0k48P+m64V0+atmkUtOTVEo62JsFW/iLiSfPJdbRY
         nty8M/E8CLr+uYYLBay2Y+wrnsmdV7RpJ1bC/WnxDVi23Zw+wJuw/hI0TEVr+NMXEcjE
         llaD9PQSuHh+YTKt03IvY9sR1MywvYHZIGHKFqt4SuTSsk54EaZFpUFZ8XvuT8+8Gx59
         jIrA==
X-Gm-Message-State: AOAM531rKbj/i/D/7jBE6g9qxnYXxaMjtEzB5iUkBA5uwnn8EcXzGPL4
        fiYvF5OOS7VaO6p4zKB0j5/ycyRlBtlFM5jB
X-Google-Smtp-Source: ABdhPJyw3bAlny92qrLpd9ag4M86Ul2Jc9EVR12oUJiqy0lQ8i/x3IoD6YuSitBqmFTZgHHBdL+Qqw==
X-Received: by 2002:ac8:6f12:: with SMTP id g18mr43655127qtv.335.1608136035443;
        Wed, 16 Dec 2020 08:27:15 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id o4sm513851qkc.93.2020.12.16.08.27.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Dec 2020 08:27:14 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v7 11/38] btrfs: handle btrfs_record_root_in_trans failure in create_subvol
Date:   Wed, 16 Dec 2020 11:26:27 -0500
Message-Id: <15ada5c3cf18400d11eb0ae0c0fa2e54f4b9c87c.1608135849.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1608135849.git.josef@toxicpanda.com>
References: <cover.1608135849.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

btrfs_record_root_in_trans will return errors in the future, so handle
the error properly in create_subvol.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/ioctl.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index af8d01659562..2d0782f7e0e0 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -714,7 +714,12 @@ static noinline int create_subvol(struct inode *dir,
 	/* Freeing will be done in btrfs_put_root() of new_root */
 	anon_dev = 0;
 
-	btrfs_record_root_in_trans(trans, new_root);
+	ret = btrfs_record_root_in_trans(trans, new_root);
+	if (ret) {
+		btrfs_put_root(new_root);
+		btrfs_abort_transaction(trans, ret);
+		goto fail;
+	}
 
 	ret = btrfs_create_subvol_root(trans, new_root, root, new_dirid);
 	if (!ret) {
-- 
2.26.2

