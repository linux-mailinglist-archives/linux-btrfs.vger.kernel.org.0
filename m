Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4B8B33983C
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Mar 2021 21:26:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234835AbhCLU0N (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 12 Mar 2021 15:26:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234800AbhCLUZv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 12 Mar 2021 15:25:51 -0500
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12A47C061574
        for <linux-btrfs@vger.kernel.org>; Fri, 12 Mar 2021 12:25:51 -0800 (PST)
Received: by mail-qt1-x82e.google.com with SMTP id u7so4831599qtq.12
        for <linux-btrfs@vger.kernel.org>; Fri, 12 Mar 2021 12:25:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZJxOsvuh1x8H//YwmN29+j5aX5UXFh5/mvrYpeDOYSc=;
        b=P8MiFZH4kLSOl9CdjYHE8IYw6ylZwvMTE5iGZciKjyu/NMUnRDIjc98D0AuuVpGi5k
         qGwB0koFVGlAtgMd6TJhtq1y/3SWyGomdP2RaEMehRhv1CHcsTsr92JhoiKkIUQLBod/
         UtrdcTNP+dXSr8aH5zXiM7myMt+fVU8ZIIeTAx50Yti5y9HVuiJST/1VVEiVIDOfcS8z
         xYw00uocu4xkgELF+0JZ2VhdIoEiMh4EY9MQsqYOiW4Cl214j6x4fGojeLKTIY/aG8J6
         aZjYxhFb6lHhVeQOZyQqV4I2E17jYHurZAzprIgRa5tAzlcFZvOLRxKXVSEDCz6sIL2y
         45EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZJxOsvuh1x8H//YwmN29+j5aX5UXFh5/mvrYpeDOYSc=;
        b=dn6vRZ0mP3jnT59aSCSLBSDeELRGB0wRfa6VrcigiSZPNbybK7MsBu6gtAXdDITplO
         uZskqcvc7i6C03zs1ZqZiAOXsSXYipmiERfW9OBsDZ085rxqDneYNNMluLtCxVQdn2su
         +MT7oQtto0DDcqG+JiYgDW+RK0TY43wM5rVKi+fAqF5+JayHMFldyl8feMpHEBGYZWLd
         OMUEUrGOt2eBF/ZVu/15P55MsdK1cm3vVw9sYhmr+3GBpzuO57wxupA8XFvvuM/SguZj
         iAx4jT+4uBy77mHmD4KLaPGAQeEOPeahuF3rU8+VvJXTuE2MbylfiMW6sQP7WQoekS/y
         /q6Q==
X-Gm-Message-State: AOAM530a5IHjrI935gb2tWuzcuELe8xzlz3JZU014D5PXD1/Tc5TTkeG
        NZ7i/of6Qp2VgZGV8wrGaXxvNvWAq32rzqj5
X-Google-Smtp-Source: ABdhPJwwNUNyVh/w78Hz9Cj6YTYHj6N8JyCUjjwmSQg9CqyrYM/KYrxYVPrroxrZR/WSaq0keF/6Ow==
X-Received: by 2002:ac8:dc2:: with SMTP id t2mr13328600qti.234.1615580750052;
        Fri, 12 Mar 2021 12:25:50 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id e18sm4548549qtr.52.2021.03.12.12.25.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Mar 2021 12:25:49 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Qu Wenruo <wqu@suse.com>
Subject: [PATCH v8 09/39] btrfs: handle btrfs_record_root_in_trans failure in btrfs_delete_subvolume
Date:   Fri, 12 Mar 2021 15:25:04 -0500
Message-Id: <0a799b56d387f1d9dfefb65c62236b03e8bcdaeb.1615580595.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1615580595.git.josef@toxicpanda.com>
References: <cover.1615580595.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

btrfs_record_root_in_trans will return errors in the future, so handle
the error properly in btrfs_delete_subvolume.

Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/inode.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index c64a5e3eca47..48c953d0dde7 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -4317,7 +4317,11 @@ int btrfs_delete_subvolume(struct inode *dir, struct dentry *dentry)
 		goto out_end_trans;
 	}
 
-	btrfs_record_root_in_trans(trans, dest);
+	ret = btrfs_record_root_in_trans(trans, dest);
+	if (ret) {
+		btrfs_abort_transaction(trans, ret);
+		goto out_end_trans;
+	}
 
 	memset(&dest->root_item.drop_progress, 0,
 		sizeof(dest->root_item.drop_progress));
-- 
2.26.2

