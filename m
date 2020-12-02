Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F09F52CC717
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Dec 2020 20:53:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389615AbgLBTw7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 2 Dec 2020 14:52:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388416AbgLBTw6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 2 Dec 2020 14:52:58 -0500
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7DDFC0613D6
        for <linux-btrfs@vger.kernel.org>; Wed,  2 Dec 2020 11:52:00 -0800 (PST)
Received: by mail-qk1-x742.google.com with SMTP id b144so2441603qkc.13
        for <linux-btrfs@vger.kernel.org>; Wed, 02 Dec 2020 11:52:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=yQW5HdN7qO3+mPtg3gOgxaceIpJN+421WcNEAltwLCs=;
        b=RWRpOmx8QBBnptaQoS+dNyZnEzg/7vUg2GDmmVeokmfGRJ4yy4BCdhODHYSpo68qdi
         /jCuPRFsceX6vyekje6mo5MgUMlbLygN1LIJssLTD3Tv3+kIZGdFxrbjgty6gyDUElRT
         rotRKr3IdZqoh/0keU8LUYeHsilq2jIv2uSu6+cqWNnJEkbgszPoQT/2rtj8HxbBJVc6
         soji+wRLBdReErN1Obgi8G/+DPCXOMag6dlX/+mk3srFNchvrvTuTgNCnhPwhNbDzovm
         JMuSyeHYE3Pvn8tL9EY1zR2C3vOMWqePv7NW8vxIsI99GwmWGjT3KEcPgc8NDgv5yo4p
         bXsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yQW5HdN7qO3+mPtg3gOgxaceIpJN+421WcNEAltwLCs=;
        b=DvGniRemgr/dR+wXq2iLttzzsCaH0oBLqeTM1gUaWPP+Nh4+Tu11FLeWvrlhgg3fDf
         f3bJQOeoTJH7+gnXRzIxVMIlALeMgPHTpHfaQHCl7mBy794nSAAsuNxuA7LjiGVbvxEp
         JCc2Gn5Pz1j2uXlKyx9mcIS0suPkl4RXjKtHMaLhpzLt5pTWxaRZm/Be1KPmtoL1r+XZ
         RgUe4FfAqUtulALemP2u1NptlV5396olYYdQEi8qf91Yc4Ke1xdIrCn0XYYgS9GF9RzW
         mjXN3n5TVUx2+jFIB7REWrBuA+XunoTD9+g1HmhOsQnyecDDpQ70HvJeYVQslbnKA4Xg
         Lq8A==
X-Gm-Message-State: AOAM532XQtHa/Nkj9NmGefLMYw1pGTvq+tSLpx+ixELZkCxoe+0LrORY
        d4t9o3UjBvGpq18ekdnC8nVx1+v7hjmEXQ==
X-Google-Smtp-Source: ABdhPJw5xk1B6D5zv/Hv0iIsigLbuCDLRRSvWG8Y2mNiZW849gxl7HpRh7aRgHls27f//rSyAdc6aw==
X-Received: by 2002:a37:9ecc:: with SMTP id h195mr4100878qke.103.1606938719793;
        Wed, 02 Dec 2020 11:51:59 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id q18sm3029578qkn.96.2020.12.02.11.51.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Dec 2020 11:51:59 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v3 25/54] btrfs: handle record_root_in_trans failure in btrfs_record_root_in_trans
Date:   Wed,  2 Dec 2020 14:50:43 -0500
Message-Id: <f0989980b1e915da3a83bce8028833a8e35e62d9.1606938211.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1606938211.git.josef@toxicpanda.com>
References: <cover.1606938211.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

record_root_in_trans can fail currently, handle this failure properly.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/transaction.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index db676d99b098..087d919de9fb 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -480,6 +480,7 @@ int btrfs_record_root_in_trans(struct btrfs_trans_handle *trans,
 			       struct btrfs_root *root)
 {
 	struct btrfs_fs_info *fs_info = root->fs_info;
+	int ret;
 
 	if (!test_bit(BTRFS_ROOT_SHAREABLE, &root->state))
 		return 0;
@@ -494,10 +495,10 @@ int btrfs_record_root_in_trans(struct btrfs_trans_handle *trans,
 		return 0;
 
 	mutex_lock(&fs_info->reloc_mutex);
-	record_root_in_trans(trans, root, 0);
+	ret = record_root_in_trans(trans, root, 0);
 	mutex_unlock(&fs_info->reloc_mutex);
 
-	return 0;
+	return ret;
 }
 
 static inline int is_transaction_blocked(struct btrfs_transaction *trans)
-- 
2.26.2

