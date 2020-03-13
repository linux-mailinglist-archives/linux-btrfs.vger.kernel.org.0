Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3323F1850AC
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Mar 2020 22:12:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726997AbgCMVMa (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 13 Mar 2020 17:12:30 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:39162 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726949AbgCMVMa (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 13 Mar 2020 17:12:30 -0400
Received: by mail-qt1-f196.google.com with SMTP id f17so7563736qtq.6
        for <linux-btrfs@vger.kernel.org>; Fri, 13 Mar 2020 14:12:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=qCserTp80rvB2Bi8vGiT1vIT1nts70WQVBnCdz8vq+c=;
        b=sKlCUY1jq+Hn6vQyYDpT/NKBYqCyNhv3CFngEYotQCGJ6aGLWEMHrP/k71+pY0m6PJ
         dxVF8YOa8VU1+Xls1GarOEvjEsx3ZDKUqHHSTHRxJouxhzZiBat4Ix51w3VKZQaOT76b
         btzo/0e8g+g8Ahh0Gp5oYGlNFiXJ2/7nRKPcsU3kz4Ys7BSIkhsLeiDB6hVsYzOsak8f
         XgyEL12czNe9talrq83VLeqm5rG7XS/OL8MxiAtfoO2kDG1uZImpHMzjek7S0zXtR/Ra
         X4b5ExZ9shO1Ldkvz1FqTZ1HV6lxWlBe1l9B4KtnT7b57qdsJlxj7I8ze/KckSrdyKTI
         iRBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qCserTp80rvB2Bi8vGiT1vIT1nts70WQVBnCdz8vq+c=;
        b=COhhvCG9jxWvk9lgkEwIKUCrtSL1UX9m81fgUnirIRvjsnXUK1yRL4thNNMnOJBSB2
         qbZsLHse6PhzoqJGW0EE1Pnxq8KNjg/QptrrBB8/KpyKIVtDe5fDTf3Y9qgTuruYGscJ
         8SFymGfbj7Gpucdz/d4untXOoFujx5BzTWaN148RPrcLcqnFHv49DvQror7/a2mBmnt4
         0WW/pVkq5yi5RMB5YWH6Fk6+QBWKqx6AkCDzMov0eZJ7YIncj/GQouDem9BwcflzoNDJ
         Y3QzlDrdgWrB8g7AaBrVyw/x3BRWQB5SKTFfZdvbiXIPCg4SvbTbjXz7r1ibPKhOhizF
         syXg==
X-Gm-Message-State: ANhLgQ1Rjup/gqmqq5Lks80ljXwIf5e65iV0s92lKB3n4EkJQJeXWhab
        zgAMu4y1MRyFxPB9JOfixUlOJg/NWs7O3g==
X-Google-Smtp-Source: ADFU+vvt3fjAodiVp/m7qTJEJBe1K2Tca3rNGBOkMuOftCRCcTcUIFCiZk5yZb2U8zrMvj1Pd9LAqg==
X-Received: by 2002:aed:38ea:: with SMTP id k97mr14511564qte.327.1584133948652;
        Fri, 13 Mar 2020 14:12:28 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id x74sm11590811qkb.40.2020.03.13.14.12.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2020 14:12:28 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 3/5] btrfs: only run delayed refs once before committing
Date:   Fri, 13 Mar 2020 17:12:18 -0400
Message-Id: <20200313211220.148772-4-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200313211220.148772-1-josef@toxicpanda.com>
References: <20200313211220.148772-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We try to pre-flush the delayed refs when committing, because we want to
do as little work as possible in the critical section of the transaction
commit.

However doing this twice can lead to very long transaction commit delays
as other threads are allowed to continue to generate more delayed refs,
which potentially delays the commit by multiple minutes in very extreme
cases.

So simply stick to one pre-flush, and then continue the rest of the
transaction commit.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/transaction.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index cff767722a75..3e7fd8a934c1 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -2057,12 +2057,6 @@ int btrfs_commit_transaction(struct btrfs_trans_handle *trans)
 
 	btrfs_create_pending_block_groups(trans);
 
-	ret = btrfs_run_delayed_refs(trans, 0);
-	if (ret) {
-		btrfs_end_transaction(trans);
-		return ret;
-	}
-
 	if (!test_bit(BTRFS_TRANS_DIRTY_BG_RUN, &cur_trans->flags)) {
 		int run_it = 0;
 
-- 
2.24.1

