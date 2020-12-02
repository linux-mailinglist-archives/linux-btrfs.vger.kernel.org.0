Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA1342CC710
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Dec 2020 20:53:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388305AbgLBTwn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 2 Dec 2020 14:52:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388222AbgLBTwn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 2 Dec 2020 14:52:43 -0500
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E96FDC061A4D
        for <linux-btrfs@vger.kernel.org>; Wed,  2 Dec 2020 11:51:35 -0800 (PST)
Received: by mail-qv1-xf41.google.com with SMTP id y11so1300336qvu.10
        for <linux-btrfs@vger.kernel.org>; Wed, 02 Dec 2020 11:51:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=Zpd71/joKfYkB8QIfmjU1qjvBCKr5JiQEFJJNbaPbtM=;
        b=BsA1BOr4C5Xgth7c+PLzTSjLShGuEAojig+gFtl9YTRy8j4/LpgaoHBjgBzh36gV2s
         FPWAEZwn0VhuRs6cI19nl3Wf7H2AbkIs+HIJHKf0KdFkdXt1Ww97qnMnd7pDGxfitnUe
         IfpKSxgg4MKV2anpFW4TY6NEjTTusmBcVVYhrvHjg+LBjcW5WrCX6+legq8yFB/UQP39
         VIvuVr1TrLpk3bvk8+oUh9vjJbH/sqfHaHv6AM4Sf7K8gwyVldOAKFM65fyFSLY03cmd
         Zegybh5WyTIkATUhicY6MnX1D8jarzv/3gYR7rGmZ5U4GT8ctyiVGcWH4Y9LKaNFvb0k
         30wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Zpd71/joKfYkB8QIfmjU1qjvBCKr5JiQEFJJNbaPbtM=;
        b=XEKnhSCR+lstTLZcWEHlOBe9izgo8DUhYSfqOO4MdbbB8vbk2OULkLL1+nEHCVBSY3
         L/kRGiZrDDd0BTfJwW9Ai8yXc+jTDxd0ksJcg26XvIpjd43X3jHS2T7zuGx5V4WnNRnT
         8S5eYHoHjxU/hQiJUSezUUCY3XrxcoZhUlUvwb9JoPngxm30gRM2OYlGAii726E5Ra5Y
         0UlZxJBXMvZXWOadaJ8OVTx+5XMES4VWv5ukN2+RnhCiLjRMJDDy8JFZdJuxXhZ1DdHz
         cUq9kBPStqAjYma8INoyXuPet7OCvpgl3gbYgsfib5zHv2PY6ARwfT3fJeto1jfX52DP
         KPBQ==
X-Gm-Message-State: AOAM532tBILVv7Z6i7wJUSQKX7VWfmSQspwZoLfLZcIjq6tCJOYB9ZIx
        qFOkkvQYi0W9Pa0HE8LpoZ0lrkLJnD6W4w==
X-Google-Smtp-Source: ABdhPJzOETZXtJXR6z+cBmNaXJNK85JdRr/Yenh8DnhhSvkqwyayswf9xi9vg8CGzC6SqR4/4Dj1Dw==
X-Received: by 2002:a0c:bf44:: with SMTP id b4mr4515620qvj.30.1606938694809;
        Wed, 02 Dec 2020 11:51:34 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id g63sm2893448qkf.80.2020.12.02.11.51.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Dec 2020 11:51:34 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v3 12/54] btrfs: return an error from btrfs_record_root_in_trans
Date:   Wed,  2 Dec 2020 14:50:30 -0500
Message-Id: <a11d1c323a74b1c452da3e4544019754b95bfaf4.1606938211.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1606938211.git.josef@toxicpanda.com>
References: <cover.1606938211.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We can create a reloc root when we record the root in the trans, which
can fail for all sorts of different reasons.  Propagate this error up
the chain of callers.  Future patches will fix the callers of
btrfs_record_root_in_trans() to handle the error.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/transaction.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index a614f7699ce4..28e7a7464b60 100644
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

