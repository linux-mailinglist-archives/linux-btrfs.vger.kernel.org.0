Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0ECA1467FD7
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Dec 2021 23:18:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383409AbhLCWWK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 3 Dec 2021 17:22:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383406AbhLCWWI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 3 Dec 2021 17:22:08 -0500
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08960C061751
        for <linux-btrfs@vger.kernel.org>; Fri,  3 Dec 2021 14:18:44 -0800 (PST)
Received: by mail-qt1-x82c.google.com with SMTP id q14so4837284qtx.10
        for <linux-btrfs@vger.kernel.org>; Fri, 03 Dec 2021 14:18:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=b8zGFD9fhXMashBpKjDCP8Sd3BJtE+0UViVXFTlarZM=;
        b=h5JkDO+JbidbgHMhmx2QQthuNIku6elAR9KBY7oRuzJK7cCscSaGPfUPRXx8tsJD7F
         ouFR02MfRF57AA/SZzwCY7hrKGdKP3EZkOrn//OggD6zxBPtfbAg1xeEKBEHPzFV92a/
         KG9chtnT4KgoIYye699aEzwMZuObUeHkDFQEZpXZCN3NLKLpnlDiS8ggCdb8oOQCTTzW
         I9pXenXM+EjnhsCbE2XXmEDqk4g1Mb13v5hs670eXjkU9BtqAxJp+eX/tEJAisFO08wq
         pETBUo6BjmpPJ85upe8P3pN3cwAyKSjL85XKPs7HPASUcCmscyD79/BENsQn+nfgr+ax
         NseA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=b8zGFD9fhXMashBpKjDCP8Sd3BJtE+0UViVXFTlarZM=;
        b=kPE3GyrDEdcYSSB3tXxKFOTDKyKR2Lw6RII3O/Is2Lgu0BLkA5BqRgwRzUBr3uImE5
         aJdvNWqHw9J6t9KYrWi5Fxc4xnG+Nw2zgm9I2dVhUCFL8uQLC5nT3sWWcmg9fRKpFkeI
         nLtB6N2FucTpezKcY83iM3Hf7AL3lvIt00AciKMHLqd+hQsRbTVFf+64SbOcraMV/zIJ
         +oF3H/vbdHwd2skiOuR87X5TEx3KRA6WXC75Q7DV82Veov4SAj13XGeCD4M4eTk+olqH
         6ddrbWfsbdVjPnOWzxk4cBFJGlyeK0Ha53l1ckp0EdjHLtgqVR8RPUk2qx56chdeN8EI
         M8vA==
X-Gm-Message-State: AOAM533rAd4JsOvGG017kksobXKUak2rX++7Tc4IBv3EfF930itNGGQS
        0ZxQQhcDX0u+ZVu4OoNEtaFHVe2XfcWcWA==
X-Google-Smtp-Source: ABdhPJz7VwTJNL0NDQzo8RFRk57NnY8XXaLCw6+oRPw53AcS2fT8ogKA5gU5mF5bHh+IasYadX7NEQ==
X-Received: by 2002:ac8:7d0e:: with SMTP id g14mr23421467qtb.638.1638569922975;
        Fri, 03 Dec 2021 14:18:42 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id j126sm2787673qke.103.2021.12.03.14.18.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Dec 2021 14:18:42 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 17/18] btrfs: make should_throttle loop local in btrfs_truncate_inode_items
Date:   Fri,  3 Dec 2021 17:18:19 -0500
Message-Id: <696600c24743e5265c188e7d5522f04870ad080d.1638569556.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1638569556.git.josef@toxicpanda.com>
References: <cover.1638569556.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We reset this bool on every loop through the truncate loop, make this
variable local to the loop.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/inode-item.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/btrfs/inode-item.c b/fs/btrfs/inode-item.c
index 257a72ec8993..4d3a6448aca2 100644
--- a/fs/btrfs/inode-item.c
+++ b/fs/btrfs/inode-item.c
@@ -473,7 +473,6 @@ int btrfs_truncate_inode_items(struct btrfs_trans_handle *trans,
 	int ret;
 	u64 bytes_deleted = 0;
 	bool be_nice = false;
-	bool should_throttle = false;
 
 	ASSERT(control->inode || !control->clear_extent_range);
 	ASSERT(new_size == 0 || control->min_type == BTRFS_EXTENT_DATA_KEY);
@@ -525,6 +524,7 @@ int btrfs_truncate_inode_items(struct btrfs_trans_handle *trans,
 
 	while (1) {
 		u64 clear_start = 0, clear_len = 0, extent_start = 0;
+		bool should_throttle = false;
 
 		fi = NULL;
 		leaf = path->nodes[0];
@@ -669,7 +669,6 @@ int btrfs_truncate_inode_items(struct btrfs_trans_handle *trans,
 			control->last_size = new_size;
 			break;
 		}
-		should_throttle = false;
 
 		if (del_item && extent_start != 0 && !control->skip_ref_updates) {
 			struct btrfs_ref ref = { 0 };
-- 
2.26.3

