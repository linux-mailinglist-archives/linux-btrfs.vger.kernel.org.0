Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 267362B1000
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Nov 2020 22:21:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727277AbgKLVTy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 12 Nov 2020 16:19:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726995AbgKLVTy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 12 Nov 2020 16:19:54 -0500
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83E70C0613D6
        for <linux-btrfs@vger.kernel.org>; Thu, 12 Nov 2020 13:19:44 -0800 (PST)
Received: by mail-qv1-xf42.google.com with SMTP id ec16so3590909qvb.0
        for <linux-btrfs@vger.kernel.org>; Thu, 12 Nov 2020 13:19:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=EfYInEV6t0ngbzm3iAAzJowfT63gDtURi6aBsy8KoOY=;
        b=ELVC0PlekaaLYQnVkzNwqSwkUMO2KlNHpOFJQENI5Wy5ckGUnIy07GLbfIJJLXfruc
         aH03sjUlsCBstdTEHzRi5e/rBKiYTW2znqLCozdVAJxO1FJpz5CIhC+VyS8wujY4YYJQ
         aVFEDWXdNKot2lzP2aQxTIKNYVMUT8gy54K/bJUSc0dfxVwTi3YYnq2lLO/9wgDAPJs6
         f19xbcX5zEDQ02q0WryE2HolooOTrnCrE0zLRCbzL1fdord4IPrJV1dreIQaX56jPM1G
         Xve7S+zjJhtQOKQz74sRaJi2i40lgPJkwdbrsidCaUN3w/mU1iQ1eToSsGfm0Ozb12WY
         WMBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EfYInEV6t0ngbzm3iAAzJowfT63gDtURi6aBsy8KoOY=;
        b=EHOtHR+I0JdMxe3s1Tw+ti752M/7+H8q/WGNcpA+sxf4JHEEi7XQYeXIkNYwfrFq69
         MHGlIgwUEVrK1WmuAxpT6st5nGKL4QUj/8Q3FekU8strSB04xWIYmVNNXMYaWhPEVyAX
         8IEfq+RBMAK6t3uW3yLRdw8Y0C+ngsebnYBu4cnbUzfteMGxWULv9i2cvZ1TIafuHRDw
         KWUIWrtalEUS5+dukh/68NA3rz1RfPVtCl69ECjBz9XBieWqHSOkIJn17qzpEnLb0kK0
         03YBnWrM3VgmRms7BL8fbrA+zgLsxphDzzwUut9kakcO1BsePuDHGyM+ZPR4WqUHfHBX
         MrVA==
X-Gm-Message-State: AOAM533xLjZUXJMfq4jBC6ymqa1F/L6qgdmfupvJJjkYUTJW5wctud+g
        KhqbstPSdT5RKZ4urFyv60r9jnXRmle+sg==
X-Google-Smtp-Source: ABdhPJzIK87u7j0n790wNZ1MektmgwzLTvuKNqj5yDSaWkP01N5D0p8bih7RWdn3psNWAGJqqu6VXg==
X-Received: by 2002:a0c:9e2f:: with SMTP id p47mr1827746qve.11.1605215983459;
        Thu, 12 Nov 2020 13:19:43 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id z125sm5779170qke.54.2020.11.12.13.19.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2020 13:19:42 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 16/42] btrfs: handle btrfs_record_root_in_trans failure in start_transaction
Date:   Thu, 12 Nov 2020 16:18:43 -0500
Message-Id: <35c8000a8401b51ed4544141174afe49782ab807.1605215645.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1605215645.git.josef@toxicpanda.com>
References: <cover.1605215645.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

btrfs_record_root_in_trans will return errors in the future, so handle
the error properly in start_transaction.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/transaction.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index 9cb379facf7a..c666e6bef0ff 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -737,7 +737,11 @@ start_transaction(struct btrfs_root *root, unsigned int num_items,
 	 * Thus it need to be called after current->journal_info initialized,
 	 * or we can deadlock.
 	 */
-	btrfs_record_root_in_trans(h, root);
+	ret = btrfs_record_root_in_trans(h, root);
+	if (ret) {
+		btrfs_end_transaction(h);
+		return ERR_PTR(ret);
+	}
 
 	return h;
 
-- 
2.26.2

