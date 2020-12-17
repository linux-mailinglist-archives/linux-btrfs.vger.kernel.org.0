Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98B282DD315
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Dec 2020 15:37:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728331AbgLQOh1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 17 Dec 2020 09:37:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726548AbgLQOh0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 17 Dec 2020 09:37:26 -0500
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BAC2C061285
        for <linux-btrfs@vger.kernel.org>; Thu, 17 Dec 2020 06:36:14 -0800 (PST)
Received: by mail-qk1-x72b.google.com with SMTP id n142so26491384qkn.2
        for <linux-btrfs@vger.kernel.org>; Thu, 17 Dec 2020 06:36:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=K0WfX6DWZLfWB9KVQ98ezqOF1fBL9nRKgoSKT5K1YDU=;
        b=SBHmjzSvNmmAL8OzUdVKZ7RbpdIg4/s8lRf8C8tuBE9YAw6BAnJSZQ2lGXBt3QOQj1
         xAteAN0BG3Xh2w5kWVUX8SnldpdT4OZBGq5LsexyI0hfGSyWNBrvX8R6rx767w2jxcbE
         1O94Bhhi3Z7cmsX1sG+GQ+RGbHW7cPKBGlHMjdERXbGxtFaetp7emdwjpSRmvIW2Gp8N
         RCurLEK/aGncciTl7I8Joh+RcF7NPF45Clbv8NjQBSb9W9eRJ+PDaLLP4cwwhJAbx4Xq
         Z8b1qQrp/P+Mc07lq9ap2uJj5mN4zmcmiMg1AfbYao6Ya5BeZ6WU9E5jyMhEjcfi8bzE
         1Sgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=K0WfX6DWZLfWB9KVQ98ezqOF1fBL9nRKgoSKT5K1YDU=;
        b=H/jLrJ1jXJ6NWePL6eSE1h48XhiX9B39H6EBnka49yusDFf2zQgh9YHjaBqsue5YSr
         LAOxYMykgHy3TVfd9WKpD8yGWM3gcipG8fRAGvAig3QJS9fRCt/enG0mL13hntCb0Q8R
         ZQwoVUSB2Ns/DmudOFNVEc0sXLPTM+1YtO+8tuEO1nvK/EQnycQWMGVChR11bFjP6IsV
         i4KKmwx/NFb78ANgzjxsHTxerTPy3YHqZUVjj3RVlsPFbA51Mihuqz1uxYNeRb5o3x57
         kssHJkUYZ8ATdUi3pNuscOUVKEu/wV/vAQA+y3QT3JSgfk5ng+DM9J0D69Mu13/llWkN
         4Z7w==
X-Gm-Message-State: AOAM532vSjk8MU8iOfoeC1IcbEs4PB/tIgaepC7+mlM/c4nPu9huuS0l
        KTtGZca+eE6bLXPcPTsXdE29iBoWfzmDePqn
X-Google-Smtp-Source: ABdhPJwdFImeM4yjxFFj1f1JpwelcK9i+PyBj9VQZj8i8cB56hdQFiXkEhMgTeLenjHFV+YzvStBwQ==
X-Received: by 2002:ae9:ef8b:: with SMTP id d133mr47608050qkg.50.1608215773072;
        Thu, 17 Dec 2020 06:36:13 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id o29sm3303410qtl.7.2020.12.17.06.36.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Dec 2020 06:36:12 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v4 5/6] btrfs: stop running all delayed refs during snapshot
Date:   Thu, 17 Dec 2020 09:36:01 -0500
Message-Id: <8f91eea944203695995bd69512d7e0e37a39bd64.1608215738.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1608215738.git.josef@toxicpanda.com>
References: <cover.1608215738.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This was added a very long time ago to work around issues with delayed
refs and with qgroups.  Both of these issues have since been properly
fixed, so all this does is cause a lot of lock contention with anybody
else who is running delayed refs.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/transaction.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index 4776e055f7f9..6e3abe9b74c0 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -1686,12 +1686,6 @@ static noinline int create_pending_snapshot(struct btrfs_trans_handle *trans,
 		goto fail;
 	}
 
-	ret = btrfs_run_delayed_refs(trans, (unsigned long)-1);
-	if (ret) {
-		btrfs_abort_transaction(trans, ret);
-		goto fail;
-	}
-
 	/*
 	 * Do special qgroup accounting for snapshot, as we do some qgroup
 	 * snapshot hack to do fast snapshot.
@@ -1739,12 +1733,6 @@ static noinline int create_pending_snapshot(struct btrfs_trans_handle *trans,
 		}
 	}
 
-	ret = btrfs_run_delayed_refs(trans, (unsigned long)-1);
-	if (ret) {
-		btrfs_abort_transaction(trans, ret);
-		goto fail;
-	}
-
 fail:
 	pending->error = ret;
 dir_item_existed:
-- 
2.26.2

