Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C05CB2D2F75
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Dec 2020 17:26:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730321AbgLHQZa (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 8 Dec 2020 11:25:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730311AbgLHQZa (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 8 Dec 2020 11:25:30 -0500
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39629C0611CB
        for <linux-btrfs@vger.kernel.org>; Tue,  8 Dec 2020 08:24:30 -0800 (PST)
Received: by mail-qk1-x742.google.com with SMTP id q22so16437842qkq.6
        for <linux-btrfs@vger.kernel.org>; Tue, 08 Dec 2020 08:24:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3dyOAnzBCzfv8RtBEClH5V06XMnw7y3H299tlnVJ1FM=;
        b=MFc8XKwlJrI61AQo2Fh2J0CdPhQSKJjg16TkJx7QedW1/NjLnDJ/BvAl/lkedHsQ0J
         H3DuA+dnq9xPiMUusDO8gr1qClfQkTxnRKvyFnWfLB2yKb62YUiCxcECyO4IjPVVJawV
         NkXdX9jY9HbW12wFADAoBVKc/hSpcy2eH25Q6iTaVzYTpHWDZj4hDvh1uqqXuaGmefmA
         7KXH+7ZkHM8Ffyz1QLrMt/esPnn4HYjFVHv+7rw0ygHmwoTyhMK6YnUxiU0625TrtVbP
         R84zIsM7oL9awNGXBugAF6epCQP0YDSsST7aI4iMIHdO1h5eH3seW5EsdBXw9Uq5tFry
         O6/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3dyOAnzBCzfv8RtBEClH5V06XMnw7y3H299tlnVJ1FM=;
        b=OUNh1kHtvDmZPKVbFV6R1FhRW1R7zip6jnfebxnxKfrTD+Q90keow1SJWwkOtbK65V
         rkv8FqpOxNxCFAy83gcmkqVc1yjUCHNwqkDDu2AtyLYpx4TCUdYJAopjF8luKDaqWdG0
         Hj6XiA7ebV652rnJ9VVUdsmvFP45EgxXFuPLNOBTH0SlE18I2DAP6ew+RUl1u3Jl2aXQ
         M7DWrkBjQwCGkLZtRHl7axWLMS3SKXVCNYLq8xuSUC1n91meImblIacsuApNogI9apkp
         7eQ+QmBCF00Lsn/J2CKCwh4tp2EQLuVi0O7kCjUEyK5gXhMRI+Sps1frTBjb6ozFJuOG
         B5gA==
X-Gm-Message-State: AOAM533RSZW5GvLAzVECQQfkQQo/GN/msH9TN0/mxFTfITCAbPoQbcHu
        Jjw8pBHtYZ3+I8HEL/Y9TLh3PiRFPutJLunW
X-Google-Smtp-Source: ABdhPJzBUTPu+xhD2RKt0u3qvIeiDBeFjg9mJwRJabc1ZAekseA+luKHpJzxhaJv2DKMo/DnpIRuwA==
X-Received: by 2002:a37:dcc3:: with SMTP id v186mr31155339qki.446.1607444667950;
        Tue, 08 Dec 2020 08:24:27 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id i7sm13795763qkl.94.2020.12.08.08.24.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Dec 2020 08:24:27 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Qu Wenruo <wqu@suse.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v6 12/52] btrfs: return an error from btrfs_record_root_in_trans
Date:   Tue,  8 Dec 2020 11:23:19 -0500
Message-Id: <a9672a7a55175ae407607eb2f9b99321e7f670a0.1607444471.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1607444471.git.josef@toxicpanda.com>
References: <cover.1607444471.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We can create a reloc root when we record the root in the trans, which
can fail for all sorts of different reasons.  Propagate this error up
the chain of callers.  Future patches will fix the callers of
btrfs_record_root_in_trans() to handle the error.

Reviewed-by: Qu Wenruo <wqu@suse.com>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/transaction.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index e51ff63c8408..5cc368fede19 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -400,6 +400,7 @@ static int record_root_in_trans(struct btrfs_trans_handle *trans,
 			       int force)
 {
 	struct btrfs_fs_info *fs_info = root->fs_info;
+	int ret = 0;
 
 	if ((test_bit(BTRFS_ROOT_SHAREABLE, &root->state) &&
 	    root->last_trans < trans->transid) || force) {
@@ -448,11 +449,11 @@ static int record_root_in_trans(struct btrfs_trans_handle *trans,
 		 * lock.  smp_wmb() makes sure that all the writes above are
 		 * done before we pop in the zero below
 		 */
-		btrfs_init_reloc_root(trans, root);
+		ret = btrfs_init_reloc_root(trans, root);
 		smp_mb__before_atomic();
 		clear_bit(BTRFS_ROOT_IN_TRANS_SETUP, &root->state);
 	}
-	return 0;
+	return ret;
 }
 
 
-- 
2.26.2

