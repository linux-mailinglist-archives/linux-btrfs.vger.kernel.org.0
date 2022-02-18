Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52FD84BBBCA
	for <lists+linux-btrfs@lfdr.de>; Fri, 18 Feb 2022 16:05:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235866AbiBRPD4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 18 Feb 2022 10:03:56 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235188AbiBRPDy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 18 Feb 2022 10:03:54 -0500
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2D562B2FEE
        for <linux-btrfs@vger.kernel.org>; Fri, 18 Feb 2022 07:03:37 -0800 (PST)
Received: by mail-qk1-x72e.google.com with SMTP id g24so8247604qkl.3
        for <linux-btrfs@vger.kernel.org>; Fri, 18 Feb 2022 07:03:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SIlpy/ig3sAvgrd+KjI0DD2pnY3K7jXpvB9GCmDBNY0=;
        b=XrDyCwMYbSXBQ/CXW81kM4oo9wGU7Cb8EgapBV9nRzwFc+h161OsaKlaC/SUUmwZQ6
         dCP5HJoKRhh+D0HbjZRrdosixzJPhZBO2Uz/z9LVTgVij8mAwPiuc2yUkcv/ar1xMJj7
         NbQC/+/ZyCCy5R6qOSjKGXySVorktErdW4cN5VqCDzsDXOVc7hWbBAHxRx3yLKASzj93
         tGAjv1B24yJVvXK6eLsdY4op3mXPLhbl00ai5LW+l8pQt/hboBlsjy12FB7LuR+UsPQe
         v6le2jLtZAIGOosvuizPNQnn4JTtdIdUawDm+3r6FUXh79nRlleoSAeMYcHkod96q5do
         au8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SIlpy/ig3sAvgrd+KjI0DD2pnY3K7jXpvB9GCmDBNY0=;
        b=Gr+uEVBc1azt7xT7rIQbPpi8pmBnrGAWS4GeZ9sYoobeISn/Y5K9MEvMkV18qPmVnK
         DZC17weevNNfT7/FjMQG+1ZCG74oOPkxgbXaRkbHi18ARxHWYnMFLXSWBecZUxbwrhMv
         ksGuBW4dv1TCVCzz8yFcRhB/RBUwE2RW3IqUzpW3QhP04+lr6rhQh3ILI+1kGpMFVMvN
         rm1X+QyFLYkYooN0h2MfJQ4PsYfAV4O29PUfgaXHqrHaZQ7Mfc7M3hZ2v5tvx2ljCnca
         T60Gwz7CUGilSaNJOgZ92oqPHNfVWdkSUiY+/CBRbFgMglI9L+vmB6p1LEjGlxmiPWZg
         EGDw==
X-Gm-Message-State: AOAM531a7peoC8sAatjQ/EbyhEgzupj8pXMCCK/6cytfn8OHBL4krxvr
        FbZ1lZ3u9sWI8fKWO1tXDKs181fKuXKPsUpb
X-Google-Smtp-Source: ABdhPJwsNKQBDrCFK5m52Kao5OxdnujFeFNDVYYQCyCHtK8jDNwKFJXB4HmYYIRmS/jK7v3GiwWTxA==
X-Received: by 2002:a37:ae05:0:b0:60d:274b:520c with SMTP id x5-20020a37ae05000000b0060d274b520cmr4845110qke.777.1645196616597;
        Fri, 18 Feb 2022 07:03:36 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id q12sm25824464qtx.51.2022.02.18.07.03.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Feb 2022 07:03:36 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v2 4/8] btrfs: remove the bio argument from finish_compressed_bio_read
Date:   Fri, 18 Feb 2022 10:03:25 -0500
Message-Id: <c8772b7e9fabc7a63f941a1885a6622583488620.1645196493.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1645196493.git.josef@toxicpanda.com>
References: <cover.1645196493.git.josef@toxicpanda.com>
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

Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
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

