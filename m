Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34460389206
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 May 2021 16:52:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354922AbhESOyO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 19 May 2021 10:54:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354919AbhESOyN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 19 May 2021 10:54:13 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C95AC06175F
        for <linux-btrfs@vger.kernel.org>; Wed, 19 May 2021 07:52:53 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id x8so12985938qkl.2
        for <linux-btrfs@vger.kernel.org>; Wed, 19 May 2021 07:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=e7h/2S5r6QzNwehWTB6k9viMcjH7oBK7i7DxsvIuWTg=;
        b=WWsTudwdaWtQpUDuS7+Ludh/2PbFD9AGdVMEGj4xB2DQuezuJi/nVPSHF7nsSNh2El
         3XzmceaeV49q3S+C5+uH/BwNjoozYzgGMac/G2/Ss/+zdRUp0y8zsW9CuM65ZW7mhhoA
         pnF30iZ759k6VJrHWzsyBJ5SJK7UqPjWqd5uopZTx8kM00tMxyC63KBLZtJJG7Pw7CsI
         J8HdKDIssxkQlvDsaHoSxP6jdAL7rlMgEniRDrviaVix+wJqzRFK/qjOfkvo0Wk4ez0Z
         gh5Mh8y5JCRGM1SyORpGwoqnjorLL5fjdV//6hIz24Lc9ytwwd1F6pfsf7XGAOFto3lI
         4Gxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=e7h/2S5r6QzNwehWTB6k9viMcjH7oBK7i7DxsvIuWTg=;
        b=FBOI9ICQfByUasitV6df62Ave5gTppdngTn7Zkp3Xu4EM2ZMK38+kRVbwXtedqvirQ
         ogLXOKTnC5iUpH/ibF72e8EbhzvcsD8STnVqkUX2enG3OmYa3+jUIAczR2R9JnHLq5yi
         JPJgKJlfwjDQLKSEv5CpFSi/edImRNl8NXcUlh8qX04/b9tRhNmwDSTM5akcbvLh8bG8
         EIb1Omkoh5HVpBxaoqT+VEPUyyeSjVrMexUzOb91vJni3pRHeaa2+lGPHmAJ3d7nbgt6
         MXVFU4qATO9HKh4JJe6O5W7y765zmuMwfFe+5TgpiLANxEzm6mSRBp3KZyzGI9jzdq/X
         jMGQ==
X-Gm-Message-State: AOAM531b8e4bUSUJq90tj8MT9WhNgpWHmw5D5FiDBga22aAumRWUKGGC
        KQitgJYH5m5dgRcmK1nW2XpRMJpIK8jKUQ==
X-Google-Smtp-Source: ABdhPJy4AJxFeg8nO8Ld3cAZ0trblhDbYtTS6Cz8e8AFIXizdOrkplfSESvO8IDd2r1ZbSfD3kV2xw==
X-Received: by 2002:ae9:eb83:: with SMTP id b125mr3850451qkg.266.1621435972162;
        Wed, 19 May 2021 07:52:52 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id q13sm15224444qkn.10.2021.05.19.07.52.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 May 2021 07:52:51 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 2/2] btrfs: return errors from btrfs_del_csums in cleanup_ref_head
Date:   Wed, 19 May 2021 10:52:46 -0400
Message-Id: <73314ceb4a87c4a6fc559834235e63f7aae79570.1621435862.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1621435862.git.josef@toxicpanda.com>
References: <cover.1621435862.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We are unconditionally returning 0 in cleanup_ref_head, despite the fact
that btrfs_del_csums could fail.  We need to return the error so the
transaction gets aborted properly, fix this by returning ret from
btrfs_del_csums in cleanup_ref_head.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/extent-tree.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index b84bbc24ff57..790de24576ac 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -1826,7 +1826,7 @@ static int cleanup_ref_head(struct btrfs_trans_handle *trans,
 
 	struct btrfs_fs_info *fs_info = trans->fs_info;
 	struct btrfs_delayed_ref_root *delayed_refs;
-	int ret;
+	int ret = 0;
 
 	delayed_refs = &trans->transaction->delayed_refs;
 
@@ -1868,7 +1868,7 @@ static int cleanup_ref_head(struct btrfs_trans_handle *trans,
 	trace_run_delayed_ref_head(fs_info, head, 0);
 	btrfs_delayed_ref_unlock(head);
 	btrfs_put_delayed_ref_head(head);
-	return 0;
+	return ret;
 }
 
 static struct btrfs_delayed_ref_head *btrfs_obtain_ref_head(
-- 
2.26.3

