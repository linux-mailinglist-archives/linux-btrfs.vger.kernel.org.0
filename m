Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E0F5F11537D
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Dec 2019 15:46:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726551AbfLFOqU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 6 Dec 2019 09:46:20 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:43848 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726527AbfLFOqT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 6 Dec 2019 09:46:19 -0500
Received: by mail-qt1-f196.google.com with SMTP id q8so7326135qtr.10
        for <linux-btrfs@vger.kernel.org>; Fri, 06 Dec 2019 06:46:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=nY6S260pkkxadnMHJ613U0xHjLJQFjsfniOa6pD87ek=;
        b=sm5fhQ/rLwGCL2pAq4rl9aogFlSkegE15usX3CyYsWesuXLDSxnJGzDhE/6OZK9Why
         StbKnrLyjF78ToROC2u/TKK5WIOvaABHnZCyWh31i0unxp1aWwMBSis4QlXuySD442tx
         OuUzTJHjMr8GjTXCx7LVw+CfaZs9hJ+uOzIeguDEzYY2OHhRxGaefNMD6OVBgBL+p0au
         5aC/5r7K1NVIR6kuU/oD31JdHwHA1m+YCGZB7JfLEzK02FoI3/Gi7U7B+FjaJDs6L5Iu
         TcGueF8vKojgPnEuVNU1tdA6Gz8mM+p2z0kwzAzPBt4yGM9qzExPgBWZ+rPPKI6NRJ/N
         FzRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nY6S260pkkxadnMHJ613U0xHjLJQFjsfniOa6pD87ek=;
        b=UtTIdTh2RG2O6eG8RRRSxAiIVYb3qFnSEaHgguZURThdricRhQUC3wAYL95BNgIUrY
         MOPY1a5TY/Jdh0H/kQVRe1BUTw4UNeLpxX5gdj9mdYwgjzi8pX4W7ziaax+/XPBFHWow
         Dpz6981Cua7w/PpWSMvmseRVqnjxZFg8mkpuJzqm7klUL07HrAVvfeg+IhXLHNgcC1vz
         wAtgV/Od8jDus2vLIH1aHY3+2RCeNAJfvrGHYOWwcvClCkEkwbssU2Dq2YaW+tQld2+p
         y+qCl2LKlSR5P5T0dV8SkWHWDwKmVxfgyq96G3Q8jdNCdzp3iYAr6XwB/BOlLBVQ78WO
         eeKw==
X-Gm-Message-State: APjAAAW1ymf8lIvVj1k2IYI8ER29mCURuzFQrZ2/hSDnTrVPxLjoKeCA
        iWBdnYUmpw40vEVHfaqQtB90s212e3Ea3w==
X-Google-Smtp-Source: APXvYqzOQIsMHTiDI42scemRuCRnV1pknaErflLafJzsAa77NlP0ez/COx2bYhSbTEUXNBYfMVAM6w==
X-Received: by 2002:ac8:28a1:: with SMTP id i30mr13381075qti.245.1575643578451;
        Fri, 06 Dec 2019 06:46:18 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id f22sm6738396qtc.43.2019.12.06.06.46.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2019 06:46:17 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 21/44] btrfs: hold a ref on the root in btrfs_ioctl_get_subvol_info
Date:   Fri,  6 Dec 2019 09:45:15 -0500
Message-Id: <20191206144538.168112-22-josef@toxicpanda.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191206144538.168112-1-josef@toxicpanda.com>
References: <20191206144538.168112-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We look up whatever root userspace has given us, we need to hold a ref
throughout this operation.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/ioctl.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 2eb5a5dc07bd..2797a1249f25 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -2683,6 +2683,10 @@ static int btrfs_ioctl_get_subvol_info(struct file *file, void __user *argp)
 	root = btrfs_get_fs_root(fs_info, &key, true);
 	if (IS_ERR(root)) {
 		ret = PTR_ERR(root);
+		goto out_free;
+	}
+	if (!btrfs_grab_fs_root(root)) {
+		ret = -ENOENT;
 		goto out;
 	}
 	root_item = &root->root_item;
@@ -2760,6 +2764,8 @@ static int btrfs_ioctl_get_subvol_info(struct file *file, void __user *argp)
 		ret = -EFAULT;
 
 out:
+	btrfs_put_fs_root(root);
+out_free:
 	btrfs_free_path(path);
 	kzfree(subvol_info);
 	return ret;
-- 
2.23.0

