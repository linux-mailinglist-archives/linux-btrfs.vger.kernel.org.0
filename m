Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9F592D12CF
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Dec 2020 15:02:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726269AbgLGN7e (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Dec 2020 08:59:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725803AbgLGN7e (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 7 Dec 2020 08:59:34 -0500
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7645DC08ED7E
        for <linux-btrfs@vger.kernel.org>; Mon,  7 Dec 2020 05:58:28 -0800 (PST)
Received: by mail-qv1-xf43.google.com with SMTP id 62so6479128qva.11
        for <linux-btrfs@vger.kernel.org>; Mon, 07 Dec 2020 05:58:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=rXkllivM/LlDIU6qMHpbw+hMYUQ5EKZq1LEuGXDx7tg=;
        b=a54b3iK1LuNygCwWnH9aeahviE0esmvxooyQ/es2zAib+g9MEda/Or+3LUrDGllgFq
         +KEgoYy2D6Bn9D4qXkngHuVNxnAGh9O3kdnymquX0N6Jp1TD2ZPcjcZfE9plkEyK++ha
         R0OPfqqhaItGYUA+Ob6Mh7lx1zbLiTtRcfZh91toBBeQmkTm3ElyAk9FZRq1mOLde+ON
         zgQa1ITyyPgia1/LsLzKnbAutJsM6wYaYbN/ZZNl3xWV9pvQ0+xCfApqi+b1MgPywA86
         nyWKR99vtNTcGLfDJiyx5i3GgrZ6PlUzMMp9ky1UiKsiOzVPHwLnCg+Xy8F5jWMp/xRa
         67Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rXkllivM/LlDIU6qMHpbw+hMYUQ5EKZq1LEuGXDx7tg=;
        b=F4+taLriyTsukBncec+tjre6BhGhjNVHmecl/3wCCxF+aY5HJTzZw1YI2ffKbHh+gN
         qdb7iYqYxfHxHIORBnk3347c6cO89eNAb0frn2uSfMJk5PXjTjV+BwrLocRRnIor6z3g
         7AUhlA0ZPCxdh9g+3xxZGt8LB/EBUOnmVTXe3Wgs6vDTHMjlP9YA1ftpFeL/QvhR1BhI
         pZ1USIyS4Co9uaaKIjruJg2ptBAZgeqs87if2GDSgbNJef/PwWbHMYGLCEQwtB1m23qa
         D0+vByj9dWvXjCbBLGIk0X2WwnNOwLb4vzSPWY8XfQ3Ui5n96sDyaLNWQY8r70LPcveM
         txfw==
X-Gm-Message-State: AOAM532um/0fpeIlvLJ/U38vKQN+klzY8Nd6oEB8rbB3QQP+r4wXm75o
        Z8MYbRc1sp2Rv5bKVKfE6D7gIR9M+N5XqDak
X-Google-Smtp-Source: ABdhPJyWAqqz/D+34Cj923b5V86Nfu+7tCxiIiLmv4+YvxFOvcM7vuO4ctAq11mp+2EVztzCz6ginA==
X-Received: by 2002:ad4:4594:: with SMTP id x20mr21640066qvu.49.1607349507362;
        Mon, 07 Dec 2020 05:58:27 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id j124sm12475573qkf.113.2020.12.07.05.58.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Dec 2020 05:58:26 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v5 21/52] btrfs: handle btrfs_record_root_in_trans failure in create_subvol
Date:   Mon,  7 Dec 2020 08:57:13 -0500
Message-Id: <2864d12e55310c1699e5c566626b6447de75e88d.1607349282.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1607349281.git.josef@toxicpanda.com>
References: <cover.1607349281.git.josef@toxicpanda.com>
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

