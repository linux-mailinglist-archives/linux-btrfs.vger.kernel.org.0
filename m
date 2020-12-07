Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 353BD2D12C7
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Dec 2020 14:59:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726912AbgLGN7X (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Dec 2020 08:59:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726890AbgLGN7W (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 7 Dec 2020 08:59:22 -0500
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36722C08C5F2
        for <linux-btrfs@vger.kernel.org>; Mon,  7 Dec 2020 05:58:12 -0800 (PST)
Received: by mail-qt1-x844.google.com with SMTP id f14so837389qto.12
        for <linux-btrfs@vger.kernel.org>; Mon, 07 Dec 2020 05:58:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mJb3v8YrDM6oIBLA+rQC8rdqGFp2dm7825IM173Exrw=;
        b=TcMAyosHPft+AhMxnosbAYvKzSO0KXPiyq1cqEE4HG6+bBMuf+R4xIgEj+LDj+yCHl
         w+IKFJ1HkY9/e89XKT4jAmfzs6ZnnIU7uC+rAEVPq+8nIv0QSDQA/0zjJP4sNARDwMud
         cf8B8l3+FSaeuJ982AiAG5ngmE6gn1SzmBtDPljtXiVSaW90u0ViiqT4e+ESv0c199oF
         QcC433QsQCM2yuSERz+4gQn034bHWyqAEIotT/NjSUyVFw5uZVYQGnFhKF+ThORgm6RD
         LLMUTf8HjP7we6Mu+uOV1ZLnrjtS3nG8/EATSCcH5kAHevCR2En5WQh1ZDjW/U8Td6GF
         p5Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mJb3v8YrDM6oIBLA+rQC8rdqGFp2dm7825IM173Exrw=;
        b=hieE5bks6U6nRbD2AY3bhOSwkU+lvfmSrAaHSOPNi+IErdNCjRL0QaPnFKtiwPI/fC
         bf0CMWrucLrKvSknAHamX+5nTtQtJ8PhxxyS8cMAbyrtmddHRqekzMQsY2HOX6tT913o
         qfqVixfe7eOGN6kFeaH3LyJeIcHY6YvHOULsz70zVxTHAuLXgFn+eCfe0loC54NKeF+y
         U0NMiWZ7+n1iLxLcDmSwSgAM3tYJzZeCfRMxNZ+YztJwfCCkCU5Vw1SNcsNTqg9DPdFH
         yhDZwQSvIcOcIuS5FshFyBipEqoH7fr+c/axEOTVbFRPO7fMHkPMiM/+uVUuTLSxjLK8
         VqwQ==
X-Gm-Message-State: AOAM532ucJRzD2siCbfULJFRmLQRgSwggokovnkNktcdJmUwL1J1LodS
        E06XIH2DPb+mTZ3IDj0uNK3/6QT8GtCdv3V8
X-Google-Smtp-Source: ABdhPJxmwiXoMiREliJDv71hua1c0RFVVTyJ2OB5VQwyH9GOWrxIOu5tlOQBxNXnokkD6inD79cufQ==
X-Received: by 2002:ac8:5b94:: with SMTP id a20mr24189501qta.223.1607349491041;
        Mon, 07 Dec 2020 05:58:11 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id x124sm11657126qkc.25.2020.12.07.05.58.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Dec 2020 05:58:10 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Qu Wenruo <wqu@suse.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v5 12/52] btrfs: return an error from btrfs_record_root_in_trans
Date:   Mon,  7 Dec 2020 08:57:04 -0500
Message-Id: <322279ec35b1f95d9ac5f0e6c6e358295db0dd0f.1607349282.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1607349281.git.josef@toxicpanda.com>
References: <cover.1607349281.git.josef@toxicpanda.com>
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

