Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA6D7467FD6
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Dec 2021 23:18:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383407AbhLCWWJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 3 Dec 2021 17:22:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383391AbhLCWWH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 3 Dec 2021 17:22:07 -0500
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD946C061751
        for <linux-btrfs@vger.kernel.org>; Fri,  3 Dec 2021 14:18:42 -0800 (PST)
Received: by mail-qv1-xf33.google.com with SMTP id u16so4154219qvk.4
        for <linux-btrfs@vger.kernel.org>; Fri, 03 Dec 2021 14:18:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=/bBsBjxz1iH6IV9wDQCX9R/1MrdKCI+JQIITaleL4hY=;
        b=vUF3YEXH/SFJxPosSONTvsZ+9eLZtS23+iJ7Z8IzGagN8RM703A39ZM8jhg34E4tqU
         ORN9rt+kY70tzIHChtFJTMlobPAlZXKaxiswNB98XTENkNjIf6sCw1XGyGQMLk6LJTnF
         dPsOmiBP1E1O62jF5l6WMqCixyFpl1TqKJrrLX20X/b84eMN0dUAw6E7rj3PfkWpfQNq
         wXikiclPVW7qGtSfZs/pCvOWUEgDA4nD/ikO0SfDvQW+CKaxU4LSk8drc/Vq8Q+PAKMo
         xnnCyVJSaXqhExhoodi9U955RvR8maL1eQs0rI4rOPP39oQDuSHhZ+sZHG0RTWiSQ5hM
         18Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/bBsBjxz1iH6IV9wDQCX9R/1MrdKCI+JQIITaleL4hY=;
        b=KqMoIClgetGOGA9rO6foQRhmraw+YyYmus2iGjDmcvZDdJU/Yt68BeIhCK472RbITq
         4vSpuMvC2iH1jJ/X3S+G+/sGBeMGnTEfHnFj6pA4C4gIq2ivCG2jIPvEccSn7GAq/6TP
         G7pczClR9UVkAxf8ic1jBpH9fKWSyDYlG2JV3sfarmK0CTtLjCZg0UPbHvuLNomO2mjs
         IFkK7scUs9Pq8j0bMGxGe6N2tDRFXgYpfCEaWnP1DvlDeJWbItcICBMcFZkh8gASzZMT
         CnV5reKL5le9yPcaK/htab9pcciZjYpVeWjS0J17sE7uVSKt7dcdTGfUZucUD/rDsAtN
         rBWg==
X-Gm-Message-State: AOAM531S7tkMa8MZCEu5jwz3vlIy8DWPohh7SkG+EJbXS4RgczvEJNsa
        pckTG5CAqp3B1gefaGK4vvJM3Spc4ZeRtQ==
X-Google-Smtp-Source: ABdhPJywCiGWKdZ3i8Y3q5+yjBkv9JHiJBOhuhAAF89HS9AyhLcgGF0T4cqhFJKEEOCUGPZbGdvXAg==
X-Received: by 2002:a05:6214:20e3:: with SMTP id 3mr22093631qvk.47.1638569921732;
        Fri, 03 Dec 2021 14:18:41 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id a38sm2705959qkp.80.2021.12.03.14.18.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Dec 2021 14:18:41 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 16/18] btrfs: combine extra if statements in btrfs_truncate_inode_items
Date:   Fri,  3 Dec 2021 17:18:18 -0500
Message-Id: <bddeb36f5e7df51bb84904f7311d549a7a6ae201.1638569556.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1638569556.git.josef@toxicpanda.com>
References: <cover.1638569556.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We have

if (del_item)
	// do something
else
	// something else
if (del_item)
	// do yet another thing
else
	// something else entirely

back to back in btrfs_truncate_inode_items, collapse these two sets of
if statements into one.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/inode-item.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/inode-item.c b/fs/btrfs/inode-item.c
index 9c44cf30d930..257a72ec8993 100644
--- a/fs/btrfs/inode-item.c
+++ b/fs/btrfs/inode-item.c
@@ -650,14 +650,11 @@ int btrfs_truncate_inode_items(struct btrfs_trans_handle *trans,
 			}
 		}
 
-		if (del_item)
-			control->last_size = found_key.offset;
-		else
-			control->last_size = new_size;
 		if (del_item) {
 			ASSERT(!pending_del_nr ||
 			       ((path->slots[0] + 1) == pending_del_slot));
 
+			control->last_size = found_key.offset;
 			if (!pending_del_nr) {
 				/* no pending yet, add ourselves */
 				pending_del_slot = path->slots[0];
@@ -669,6 +666,7 @@ int btrfs_truncate_inode_items(struct btrfs_trans_handle *trans,
 				pending_del_slot = path->slots[0];
 			}
 		} else {
+			control->last_size = new_size;
 			break;
 		}
 		should_throttle = false;
-- 
2.26.3

