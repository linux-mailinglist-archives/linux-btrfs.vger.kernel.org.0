Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5788E2DC4A0
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Dec 2020 17:51:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726854AbgLPQui (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 16 Dec 2020 11:50:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726786AbgLPQui (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 16 Dec 2020 11:50:38 -0500
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C26CC06138C
        for <linux-btrfs@vger.kernel.org>; Wed, 16 Dec 2020 08:49:46 -0800 (PST)
Received: by mail-qk1-x730.google.com with SMTP id p14so14027501qke.6
        for <linux-btrfs@vger.kernel.org>; Wed, 16 Dec 2020 08:49:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dVXO8pW/I15AKnv0A8Q8X6v1okWxT+hR89oXARRUey8=;
        b=e3aFwPO+g2BFM03R2174BIVWvLzaB88bIwZHQ6AQ4JspXMUNjBVN96Tx7aZShCx/f7
         e+qLaH2v1WsrHFXOJb+Za/dy3DVB4TzUSb5L6hySVwJfKmRanwUoqUsriWY7PCsr8CUO
         +THtRqTEsrahKv488ty6zL6fDc2Pc5DvOL+XhJo8sZ+jGAE5SQ/M67zRfpMgl2N4f+2k
         xHpgFQ5PRe6SE3wNToWTYxy5NhvrF7CJPRYE5CuRb7pzhFlstPZ39LlOMCjCG6Grj56H
         m1UcTcM9zI5uoTrhCtyq9RXIph+H7xwp0KPzloLciLBLb1alkNF+yIctiiTWK6HwjIFf
         kFBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dVXO8pW/I15AKnv0A8Q8X6v1okWxT+hR89oXARRUey8=;
        b=T2YKWC7dwFijPlV1QbM1EXnqgPgcHrFDWaxc6VDSwpLuS3v8rqwSTsrQu6ihFk2kLP
         CZ47eFt6ZM2DEQ7WtGeUpMjLG4KQeDK7nQ3I2EuLSkcTJqbwliNrkvfS+CFnsx/OQR8U
         4mnt9Xuocal+gco5IMRsA3XrGay4rtlTuSWOiIFUAAqk9MatRfryFnHSJKQcQ9Gwdtm8
         xe6fU0E2vRLHe3fjL20HbGQbxSq34fT+xNuVHg3WwZqjE1y309xYQPSPenD88fwIyLVv
         uRQfIC2Pxjen5VGLXKXaNPWiHL03R3jPNAY73zeqob8s0R1o8KpyyP+bgAC/7gwXLBmq
         smZw==
X-Gm-Message-State: AOAM53171sZ1LJ0tQ4vx1BPUy0wj+aOT3bhUutEbKS+amH1EMM4CwTWC
        UgRFsrgHAFsZG5LQGPlQmIQlqsAUoiNuKpWB
X-Google-Smtp-Source: ABdhPJxxmm3X+ueVHykRirqK28g85jo4q4PC6iaf98JokzYaDRrk8FtqEoNYpLEW+FEOsEX+wskveA==
X-Received: by 2002:ae9:ddc3:: with SMTP id r186mr45215354qkf.452.1608137384473;
        Wed, 16 Dec 2020 08:49:44 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id v5sm1424130qkv.64.2020.12.16.08.49.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Dec 2020 08:49:43 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH v3 4/6] btrfs: only run delayed refs once before committing
Date:   Wed, 16 Dec 2020 11:49:32 -0500
Message-Id: <bd305ff3a1c0e917401ef76ac792b86757d5e903.1608137316.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1608137316.git.josef@toxicpanda.com>
References: <cover.1608137316.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Reviewed-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/transaction.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index 9c39b5c3f0fc..349e42300d2d 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -2063,12 +2063,6 @@ int btrfs_commit_transaction(struct btrfs_trans_handle *trans)
 
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
2.26.2

