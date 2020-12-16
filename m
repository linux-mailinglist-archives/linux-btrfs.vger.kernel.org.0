Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8F022DC420
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Dec 2020 17:28:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726715AbgLPQ1l (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 16 Dec 2020 11:27:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726708AbgLPQ1k (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 16 Dec 2020 11:27:40 -0500
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 618DFC0617A6
        for <linux-btrfs@vger.kernel.org>; Wed, 16 Dec 2020 08:27:00 -0800 (PST)
Received: by mail-qv1-xf2c.google.com with SMTP id d11so11605690qvo.11
        for <linux-btrfs@vger.kernel.org>; Wed, 16 Dec 2020 08:27:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2Tc7UX3QkyM4l8FuzTGvqDpXQ+G7Xq2NkIAj1kVTTYI=;
        b=2N2QuP2INskalegcFzTMHk33hocqrw0wkJRVOdkQ9K5R5qH58f4n5qWMuKhoYr0mSF
         t26gJc2P3D31Cpo6Gz0/izgGzxqKmxCfTrfJBADseP2fLAzTGO7g3kXRIpLZ3QSzXK35
         JMWp8SuYx1kG3bzPWb0/gWw+Ff7jrxyQXwdvq1rAN6UzHviFDbvRj8yvQXB/cxYQj7YC
         cr5FVwTFgjSKgltvGE9IFy0mRnczrM/SgbXJLwQnfwgQ/e7c02xnNANHcUYz7g7lq5cZ
         xYl8jrloVP95UHxcvpvxA6q3iuKIizLq2OfSY1Y0K5BBv71XuCRww3gIJF3JGFcUwwLX
         VMqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2Tc7UX3QkyM4l8FuzTGvqDpXQ+G7Xq2NkIAj1kVTTYI=;
        b=WaW2GBsY5zKWBMX042hHNT0qStNJqpqZeHFOT9jSAfhjIF/t2a6qHIARr5saEWk7GW
         hF7Yi5oHDSVZvcPSI1hYk2R48okfEMPNkFUiAU5bP8GCx7YCjDrUmPej3pddYK1s/u0K
         YqCZZpYICAyKqvOAp1nngTzqLuZs0OzKoT8dBQ0XnlZ7+wUtArypauB5A7RWJRndxvCx
         YMQHy/rWM1+JRASTtXeVtaz/Ruge7ex2OVAYJ7FQ5wNvrHstr1fO5LWMirRKtdswI/0T
         XqcDDLuScFen7CrV8kkEf11D+oBfFApCyPPHSbLXEEuzh5nqABJEXaSS9i6UONinGzRv
         18MQ==
X-Gm-Message-State: AOAM530NeEbx1/WaP6O3oyszj9rkQVy2tHnUUkGFWbLHV2oUVFpP3xmc
        lU6bMuo6QysedO0bOHyLEq+75r3RvZ16B5ck
X-Google-Smtp-Source: ABdhPJx1SwrwXVikHYC9BEP1G5lr21SHuL7VHZ5FQDjt6r7TtdnPSGnrxUidOBJhV33iHMCvhPYGEg==
X-Received: by 2002:ad4:5904:: with SMTP id ez4mr18554293qvb.30.1608136019396;
        Wed, 16 Dec 2020 08:26:59 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id u26sm1330421qkm.69.2020.12.16.08.26.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Dec 2020 08:26:58 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Qu Wenruo <wqu@suse.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v7 02/38] btrfs: return an error from btrfs_record_root_in_trans
Date:   Wed, 16 Dec 2020 11:26:18 -0500
Message-Id: <0b7c322b530735e98a2c6e9db4fc024c9e137546.1608135849.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1608135849.git.josef@toxicpanda.com>
References: <cover.1608135849.git.josef@toxicpanda.com>
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
index f51f9e39bcee..eba48578159e 100644
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

