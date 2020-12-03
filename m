Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B46A82CDD63
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Dec 2020 19:28:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389336AbgLCSYk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 3 Dec 2020 13:24:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389281AbgLCSYj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 3 Dec 2020 13:24:39 -0500
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94233C08E863
        for <linux-btrfs@vger.kernel.org>; Thu,  3 Dec 2020 10:23:25 -0800 (PST)
Received: by mail-qt1-x843.google.com with SMTP id d5so2071892qtn.0
        for <linux-btrfs@vger.kernel.org>; Thu, 03 Dec 2020 10:23:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mJb3v8YrDM6oIBLA+rQC8rdqGFp2dm7825IM173Exrw=;
        b=G1WXBzVhRkL/PqolStGFw0ua1W2Re/PdKo7GUjMp/7E76BS0uX1ICQrxOeXPvYslmA
         1OgkJkr5frjOL3DBiPKTrd7OFI4OYIcvXEBx1WbqByQ/HdnaLdKvN7PKuB6/qZNvFi1N
         NWFvUI8t9/Pp2gJKM2/irO0f9ASHJkEuOGrWTTe43TFrv0B3tq03fRcViE9zdyQS+C+X
         FIK9BTl3QET7Sjfkk0bvPZCfhn8bGIkxqICnkAczIs+sW9cjW5nefNiJaMR7+PZBhbU6
         DOBA72pPrhPvMxP7Eo7maDtpQ6FZxBTc0ezzFTWaXxJr2O5qOVP6LLyZgdTSRrdG1EGj
         t8ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mJb3v8YrDM6oIBLA+rQC8rdqGFp2dm7825IM173Exrw=;
        b=eypx01ed7udojD/O/KzvykJqFJlfwxZd+JjKHnMbrWMtG4+nr/mpW98lv+KGy4a3bx
         66eBCnMCTRZ17AyrLlt0k3EPIgaK7MapJrx3nan25PseF0KsoreNNLyF2ZPhuXck8Psx
         +yMXJzorC1Hyq4wZEiMgEnKsOFVxCrFCuQqotEz37CpbcZQ68IzmsWgfTrRISOJ1Zuek
         Z6QUQIhLSSQnsNyMkZTpolgWzddN+LZMq539F239BEkAGFEORt9JyyVKKc6zKzbSJyyD
         qqUVBP8yh4C2XuBb0WlaSjXGQa06Ny9JxcE1qhYSnRF5AIAhApg9h7/g5hWhf8gQ79r0
         S7Dw==
X-Gm-Message-State: AOAM533mIiAxZ2f6kOOfB/eR+jfMYhypgDwPCbVtiwGOOrGGYL1GjdgG
        5kmDVzLYZWLgGXdxIsMbnj0bMVL42b2Fen8J
X-Google-Smtp-Source: ABdhPJzQPy+EnGA9hnp9h3Z9CK7m1ggmr7EiJ8Bz5vrlcPheWO1+5wDe2uR7pRePXWQBvUbIpffZvg==
X-Received: by 2002:ac8:1010:: with SMTP id z16mr4433015qti.48.1607019804541;
        Thu, 03 Dec 2020 10:23:24 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id a6sm1926090qkg.136.2020.12.03.10.23.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Dec 2020 10:23:23 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Qu Wenruo <wqu@suse.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v4 13/53] btrfs: return an error from btrfs_record_root_in_trans
Date:   Thu,  3 Dec 2020 13:22:19 -0500
Message-Id: <df2348310bf81eab58d6312bbc4ef72570865fc9.1607019557.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1607019557.git.josef@toxicpanda.com>
References: <cover.1607019557.git.josef@toxicpanda.com>
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

