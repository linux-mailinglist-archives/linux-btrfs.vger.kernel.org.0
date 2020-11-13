Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3FE82B2040
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Nov 2020 17:25:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727107AbgKMQYP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 13 Nov 2020 11:24:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726775AbgKMQYP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 13 Nov 2020 11:24:15 -0500
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F2EAC0613D1
        for <linux-btrfs@vger.kernel.org>; Fri, 13 Nov 2020 08:24:15 -0800 (PST)
Received: by mail-qk1-x744.google.com with SMTP id q22so9287565qkq.6
        for <linux-btrfs@vger.kernel.org>; Fri, 13 Nov 2020 08:24:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=ELUfvyaVK/LRozlQRSi0aFck4mWpejW5fcG6RnbeZkg=;
        b=pwg3bYWDyGC8Lo7csqZnooH8PhtTPqPMAtFGc8obPdn55C6xHH1DL40XL14muoY6rL
         AmhE8bHmk1F6hB4GQEfZP1ykkg3WEKGfOHIrqJ+WRP5uqqPree+P+r32yE5V3MJ3eDwG
         V4mjL6tAsM2NDUVwTCxEUP+Ma1gsCEYBB/vAJ1dgLx6mnO+TLj8e1Gt1llMworTneeAp
         ssZU6U98rridnBso/kIaBmGN+cQKy8Oz231AyDuhCPA4HSYV6Z6b7J2bIF7qLs92A8yG
         PPYYiFLVZ0sm3SRPF+2DrnASmp0KtOUUX57tDlDuZigMN+hasmdUQGbqkdMriVtg3uyC
         xMLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ELUfvyaVK/LRozlQRSi0aFck4mWpejW5fcG6RnbeZkg=;
        b=iSz7FJa48W6Wk0qvHA7AUg6JRh3oPIQeY8P0MbiHQZBMi8mEiS9x1Fhm/jusvv2+q6
         nTtw767TphkWjoPMrNJaVWV8Nq3EJnas69k+dRvI5DZ1hYMVRpph0ozuGTZEvrYaXjCm
         XxGxipldrKUU673T/XM1fbS/yCPdp9Q9nWgxRxn756QfIaV7Zk6EcsHmVHWCmICbMKvn
         UCYPeCUFgoro4MM70vQMgI6hY/Y/7Q8dlktiU/s5uSYeMaouzg8aEQDI4NcK9VfMFx8A
         j2Gua/eH1fh21eBJ2aVTLCj2GUSMK4gTtBA/zLW7J3v8FEElAOqcYZTVCZKIGfvn7/yl
         153A==
X-Gm-Message-State: AOAM533RhkYgntHHu5Kny+ASBpoDhQePCxBmZBpF5Qv/J5PHqBHJDVhD
        LlHw8zny0Nvwc6aZVk71+je6DVCM/5Ofuw==
X-Google-Smtp-Source: ABdhPJzt9kHv9EQGQEQQF6LH4ZMX0/pRkvqQXIUaVMKOkhZ2V+QlC40kgFB5n1Ce0ZNQxUXP2MOxQg==
X-Received: by 2002:a37:9747:: with SMTP id z68mr2652055qkd.424.1605284648544;
        Fri, 13 Nov 2020 08:24:08 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id 199sm7046575qkm.62.2020.11.13.08.24.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2020 08:24:07 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 18/42] btrfs: handle record_root_in_trans failure in btrfs_record_root_in_trans
Date:   Fri, 13 Nov 2020 11:23:08 -0500
Message-Id: <5ffd1c40a0027d2ef32f884afecc86f4099a3ea3.1605284383.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1605284383.git.josef@toxicpanda.com>
References: <cover.1605284383.git.josef@toxicpanda.com>
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
index ad12a13d0412..d0f130172622 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -483,6 +483,7 @@ int btrfs_record_root_in_trans(struct btrfs_trans_handle *trans,
 			       struct btrfs_root *root)
 {
 	struct btrfs_fs_info *fs_info = root->fs_info;
+	int ret;
 
 	if (!test_bit(BTRFS_ROOT_SHAREABLE, &root->state))
 		return 0;
@@ -497,10 +498,10 @@ int btrfs_record_root_in_trans(struct btrfs_trans_handle *trans,
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

