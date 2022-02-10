Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30B324B18B3
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Feb 2022 23:46:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345162AbiBJWoi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 10 Feb 2022 17:44:38 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345198AbiBJWof (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 10 Feb 2022 17:44:35 -0500
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7011A2737
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Feb 2022 14:44:34 -0800 (PST)
Received: by mail-qt1-x82a.google.com with SMTP id j12so7132084qtr.2
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Feb 2022 14:44:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=EA5mfNUjdjK0chFu34L2p4uPFMElL7aC30PGVfOy65c=;
        b=kmb43fWZ23Rs9sLYYCqi6JBTmRDL46thHllg7LNULIpVct/fX/PWQPqgDd8esAQFmG
         o58IBy10Zt9mfaid/EsLRWaaF317CDAEQUpjQ6m+k0nRmHD5jlvcBHPbnxwjix+HIB34
         MvNY2ahWzTS8PlvDRKcqFHtrhXLOINOY6NkdwI2qGSt/l88Sov0CrzRWF+Pas/rc+w9H
         +6wE2IOjFPWLlK3Mnn+ZCpmwR4W1mQA52rl0N9wn8rWf3BT1+jiEX5mxZMFyxg6TsSBn
         FMj8VYspSYfabzZOZkXZEzjtEhGZwvzn3htKaVh+p2AbDPyfLWmLqZo6NJV2B7OEiLn9
         /9Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EA5mfNUjdjK0chFu34L2p4uPFMElL7aC30PGVfOy65c=;
        b=T5HwQxzEkm1njJui+mLrOcfF25A6fKzbqw6pWpwbaQrD2Q1BEgS2EIrXsH9/KJEf40
         l/gTs0KFMa9ajwzYxtA0Z/ZlKOwYh7sDW6rCdi1B0GoQ2qJqs1RVTHxh/f+ihsqSkJ0o
         OEAsIE0F0kUmudJvWspp9nQYZhJhtoj5vGlr0mZxNapYbhkoKoZvQc72nrIht89kPFpt
         xNeTHflozIOxbpQRk85vr2umJjRQRCkaOGztqi2hoBoAG3Ts82CFALD1dv+Vaz5FWkGc
         emGIq1BV1hyYFsDh6pMtygdd8PK7olOkwa2etKuURG67yOduK9B5mo/2Qxx1yuwHY7Kr
         u5Hw==
X-Gm-Message-State: AOAM533Ql00LQRGyU3aU2W8Z7K/PJt/SqiH42l/5BlzwLtdCXD0DlsZA
        PRB2nYQBdOyjT55jxClw5y3+pb8KMiY9AMah
X-Google-Smtp-Source: ABdhPJwBKBDKIENFSJcquA0uFh/gC0BjrAMlpoEFUJ5NdYK4HhoKy/Li3YECPoOZDFVjZfr5YVrQUg==
X-Received: by 2002:a05:622a:354:: with SMTP id r20mr6450736qtw.0.1644533073373;
        Thu, 10 Feb 2022 14:44:33 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id o19sm11622844qta.19.2022.02.10.14.44.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Feb 2022 14:44:33 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 4/8] btrfs: remove the bio argument from finish_compressed_bio_read
Date:   Thu, 10 Feb 2022 17:44:22 -0500
Message-Id: <a0c1fa4b70e7cfc5d22afbc8695ce72e336a8f0a.1644532798.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1644532798.git.josef@toxicpanda.com>
References: <cover.1644532798.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This bio is usually one of the compressed bio's, and we don't actually
need it in this function, so remove the argument and stop passing it
around.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/compression.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index a9d458305a08..0112fba345d4 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -234,7 +234,7 @@ static bool dec_and_test_compressed_bio(struct compressed_bio *cb, struct bio *b
 	return last_io;
 }
 
-static void finish_compressed_bio_read(struct compressed_bio *cb, struct bio *bio)
+static void finish_compressed_bio_read(struct compressed_bio *cb)
 {
 	unsigned int index;
 	struct page *page;
@@ -253,8 +253,6 @@ static void finish_compressed_bio_read(struct compressed_bio *cb, struct bio *bi
 		struct bio_vec *bvec;
 		struct bvec_iter_all iter_all;
 
-		ASSERT(bio);
-		ASSERT(!bio->bi_status);
 		/*
 		 * We have verified the checksum already, set page checked so
 		 * the end_io handlers know about it
@@ -325,7 +323,7 @@ static void end_compressed_bio_read(struct bio *bio)
 csum_failed:
 	if (ret)
 		cb->errors = 1;
-	finish_compressed_bio_read(cb, bio);
+	finish_compressed_bio_read(cb);
 out:
 	bio_put(bio);
 }
@@ -970,7 +968,7 @@ blk_status_t btrfs_submit_compressed_read(struct inode *inode, struct bio *bio,
 	 */
 	ASSERT(refcount_read(&cb->pending_sectors));
 	/* Now we are the only one referring @cb, can finish it safely. */
-	finish_compressed_bio_read(cb, NULL);
+	finish_compressed_bio_read(cb);
 	return ret;
 }
 
-- 
2.26.3

