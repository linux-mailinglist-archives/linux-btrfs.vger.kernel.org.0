Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34AEB2DE9C0
	for <lists+linux-btrfs@lfdr.de>; Fri, 18 Dec 2020 20:26:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733190AbgLRTZz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 18 Dec 2020 14:25:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728047AbgLRTZx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 18 Dec 2020 14:25:53 -0500
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69324C0611C5
        for <linux-btrfs@vger.kernel.org>; Fri, 18 Dec 2020 11:24:41 -0800 (PST)
Received: by mail-qv1-xf2a.google.com with SMTP id s6so1421604qvn.6
        for <linux-btrfs@vger.kernel.org>; Fri, 18 Dec 2020 11:24:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=7vrYbJdgLMqX3E0W/vJIWks1bdSk6AdYJbUzqeEzMuM=;
        b=BISX1M2vzXQAj0HSWE6GPcHnariSQsn0zBMseEb6Hbd75UBpCFEjRt7dut5bQR3uIA
         jn6bQwsn6W9LaBY9vdB5LYbZKynI1UUebGsfqNKxWmiDOtsksq2nudegXAO162GTgkld
         7n5wPQvy/uG/OliPEi2bz00p+0/7T3o5x2LStuD6MTkkmCyPb8+Kg6kaJ1Gbg7+BXKIT
         KURrmW6Ng01sIo7jAWReUsOhxjq+KxwwAAwvyP17zfEktd1QWcs5f8HTdzm8JX4MQ9kQ
         Bt4UA2NysrK3wkMJDn1Z5ojTkSJN8F/8QS6XBbFYPgJVEADPE84rOEx5a/Mb30vFJUum
         GSzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7vrYbJdgLMqX3E0W/vJIWks1bdSk6AdYJbUzqeEzMuM=;
        b=NsdivfDSDDC/IsA4weclvQ6xc2d3925k44EyNLIq7+9tmc/mPA+bj9NJNLvODV4Q/D
         DFj7qccpSCq+F5SV1Q4RZJgcTXCwDwM4gd+JMDlZ+veT5vG69s9HIKnAsUjRAebYe/I5
         oVXRvVt0Wh9BBMusAb7tvBu1aSp+zEdWD10UlY57cgM8cVQ4Ml5SiXaYMv1JdM6C3X1t
         na7vJ0qZR7NUPv05tNhJcLczj7Mjbi0Ctt3vKpdVT2H/6UTrcBOioOCcCLHUJcfF51a5
         Jd0Qg5+B/xS8kesAeDQbDxvva24+fwkQDSupOgAUMtp4cWhrfzil/crKQl0wbzkU8YiV
         JQCg==
X-Gm-Message-State: AOAM532HCFiFzehiS5ya1Dz2hd4P2zXoWMefHZhJRRjEWL7akns10CFg
        /b36eEhQEX6+4yeUZZwBNed68OW9iJmBRXtc
X-Google-Smtp-Source: ABdhPJzR1PU8HG5UJ4qOfftGPxx8Z91rNjOXFSZsOtwL6byAdchAP8ShBnI+sAq1jEyeUZG4CYtWhA==
X-Received: by 2002:ad4:5188:: with SMTP id b8mr5991204qvp.55.1608319480333;
        Fri, 18 Dec 2020 11:24:40 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id u26sm6178107qkm.69.2020.12.18.11.24.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Dec 2020 11:24:39 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v5 7/8] btrfs: stop running all delayed refs during snapshot
Date:   Fri, 18 Dec 2020 14:24:25 -0500
Message-Id: <a486f5158c3a8955b8320f483267efdf3e1ff20d.1608319304.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1608319304.git.josef@toxicpanda.com>
References: <cover.1608319304.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This was added in commit 361048f586f5 ("Btrfs: fix full backref problem
when inserting shared block reference") to address a problem where we
hit the following BUG_ON() in alloc_reserved_tree_block

        if (node->type == BTRFS_SHARED_BLOCK_REF_KEY) {
                BUG_ON(!(flags & BTRFS_BLOCK_FLAG_FULL_BACKREF));

However this BUG_ON() is bogus, and was removed by

  btrfs: remove bogus BUG_ON in alloc_reserved_tree_block

We no longer need to run delayed refs because of this, and can remove
this flushing here.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/transaction.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index 5738763c514b..b3c9da5833db 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -1750,12 +1750,6 @@ static noinline int create_pending_snapshot(struct btrfs_trans_handle *trans,
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

