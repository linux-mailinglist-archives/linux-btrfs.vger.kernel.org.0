Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 637DA57D0C3
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Jul 2022 18:10:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231416AbiGUQKV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 21 Jul 2022 12:10:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230367AbiGUQKT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 21 Jul 2022 12:10:19 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9128FF58F
        for <linux-btrfs@vger.kernel.org>; Thu, 21 Jul 2022 09:10:17 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id t7so1517418qvz.6
        for <linux-btrfs@vger.kernel.org>; Thu, 21 Jul 2022 09:10:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Hj8zqMXD0hVvD/X+nMAtMAh/nfRF8Z/KjlprK8JedQs=;
        b=k3OOG/9hpsCKpYh4OpbtRFnrIzYXXjGeAT0BICKVNVqe6OLjj0aKO2VwfRG3g2sIsA
         J964Mfn+9UbZrYPdgBPHd3bAkLyW7Opc+gWBbuDA2gHyLOFbpE8YqKxLj1PjmGhuo3Hq
         qnJeoDS+lhdVkZb3R9QQnODV86/rvMiDKIQaic//NpVQaEEH1/WOrp/xxWtR4DZ2GX19
         Er8yp+kNHV1abjDZloL6zih3lWz710w1k1c6b+f5Kfcq+QS3laesy8nsMi8drdYpr/3y
         WaOk1xYAEKHREhuPbJj27D5dlfk5EqVGblHh3v7afa290Lj6tVz5HcMRWfwqTFr0X2+r
         PTpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Hj8zqMXD0hVvD/X+nMAtMAh/nfRF8Z/KjlprK8JedQs=;
        b=gPKk5YnLLRm3/g64yX3/wCTymCZGQfjD0QQQ05Ue3N+pT3bghGfEUOjDYegAeqFgrq
         aHQVIJmHHPTAbrac6rd3UfsflqdQRL0Cfop2krZ7xlmIHuSi8d4l3n5lQ5N1oWyXvlHv
         uPmuGqM0DO7PyMZ3y8I/g4hBxTAJmkQPFq8cu92Lxww905l4AK3TkaSlCTl+y7i1DTEI
         V9HMbyewFF6gXoenrnsbjFjNoTG5rj1SECA1UP5hAraPS/Lb+6mGJhLNAHbDx9/kq1uK
         LT9h+/VahIbZKM9B5+PG5iTpBLQ4AZjGpLCNyMhJdpiG12vB2R+gobAYsqwVCp04OQ+7
         eXRQ==
X-Gm-Message-State: AJIora8lIrVlE1DkJ8Otadpm5HxTvHdgy9BRTXXB396NYYfDidesIS9J
        zayiNv7wLhcOE8iw4FKgdgSwvzEsVOVMaw==
X-Google-Smtp-Source: AGRyM1s0MgzWGVXA1ihOI3LB0PANIAz5+pF4VJ8xAQg6JwoLrh9HQAXNpV2TlqyXfxHF0/h0twEC8w==
X-Received: by 2002:a0c:b2d0:0:b0:473:2c19:f1ee with SMTP id d16-20020a0cb2d0000000b004732c19f1eemr34705404qvf.130.1658419816243;
        Thu, 21 Jul 2022 09:10:16 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id r3-20020ae9d603000000b006b5f371a19esm1555717qkk.111.2022.07.21.09.10.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jul 2022 09:10:15 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH] btrfs: fix infinite loop with dio faulting
Date:   Thu, 21 Jul 2022 12:10:14 -0400
Message-Id: <27a36e2b4cf30de8f7a04e718ba47bb9e98ddb85.1658419807.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Filipe removed the check for the case where we are constantly trying to
fault in the buffer from user space for DIO reads.  He left it for
writes, but for reads you can end up in this infinite loop trying to
fault in a page that won't fault in.  This is the patch I applied ontop
of his patch, without this I was able to get generic/475 to get stuck
infinite looping.

This patch is currently staged so we can probably just fold this into
his actual patch.

Fixes: 5ad7531dbe67 ("btrfs: fault in pages for direct io reads/writes in a more controlled way")
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/file.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 1876072dee9d..79f866e36368 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -3806,20 +3806,21 @@ static ssize_t btrfs_direct_read(struct kiocb *iocb, struct iov_iter *to)
 		read = ret;
 
 	if (iov_iter_count(to) > 0 && (ret == -EFAULT || ret > 0)) {
-		if (iter_is_iovec(to)) {
-			const size_t left = iov_iter_count(to);
-			const size_t size = dio_fault_in_size(iocb, to, prev_left);
+		const size_t left = iov_iter_count(to);
 
-			fault_in_iov_iter_writeable(to, size);
-			prev_left = left;
-			goto again;
-		} else {
+		if (left == prev_left) {
 			/*
 			 * fault_in_iov_iter_writeable() only works for iovecs,
 			 * return with a partial read and fallback to buffered
 			 * IO for the rest of the range.
 			 */
 			ret = read;
+		} else {
+			const size_t size = dio_fault_in_size(iocb, to, prev_left);
+
+			fault_in_iov_iter_writeable(to, size);
+			prev_left = left;
+			goto again;
 		}
 	}
 	btrfs_inode_unlock(inode, BTRFS_ILOCK_SHARED);
-- 
2.26.3

