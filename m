Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92ED21AD220
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Apr 2020 23:47:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728439AbgDPVqi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 16 Apr 2020 17:46:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726456AbgDPVqh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 16 Apr 2020 17:46:37 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DDF6C061A0C
        for <linux-btrfs@vger.kernel.org>; Thu, 16 Apr 2020 14:46:36 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id k18so125426pll.6
        for <linux-btrfs@vger.kernel.org>; Thu, 16 Apr 2020 14:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=q/mzJgos1XgRNub/iLArtVT11nSXAVRo/sPPRfNFoYA=;
        b=ualXZmN2Hcfi4j39kglPHWtAfyGoA0sVV87C8mT3ys2zFkNbTnXyUQRkcjpTbRS53H
         becuxBTtd5k17XvGEf6cHmJyY2GL6v0fI66JDOn97bQijslyrNFJ7HFNODvTmd3yFX5o
         RONXgwtc9g/t8p+hx6G7OG4XfGx3fQkJ4S/l4X5rgcYZMrSczj7vxy6r2JoIFUlG8R52
         IXQlVpQXiNGtu7D73zYfFxKxslZN2fr5FG8SHYQRaS9u5DOPutD2Ah9OyS2RVUsPQxdL
         ODhDw5cxOoWuWVLHEjjI+z112WJKgdiMaSe+zQDH2QMYFgy8NwXzTN2MYkqvOgWFWxjy
         hIEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=q/mzJgos1XgRNub/iLArtVT11nSXAVRo/sPPRfNFoYA=;
        b=Y6tzMzXBd/PyF6MOJIhBXzoIKLmdyGASpyaKwMZXhT+QtFK0tcKlEssLa/jbpaVQ9p
         TlpsL5ary1AZVJLev4ftyJ9Vx7MzstYliaCvWcR392M90qaD3qYHe9RA9fkrRMN/Ntxo
         XvJH1EbKrkfUCNADGm3VtW99cB40QYpt04XzClB882VYqmbdCI/46APsGe8h1qedQU15
         NKWrTnr8jdqbz/k8ectPfrMuNVdpxOXIMH8S6tnE8aTKhZs29+oSNnSdyO15KgC1Gjrf
         LzO6LEyK2sa0RnP6PLXyVYTdwWex5kN2cWRK13PdaQrFHFhdZ6kCC8sZjRgKULRuIEgh
         ZzdA==
X-Gm-Message-State: AGi0PuaTKNzpnSydLCRezZ6LFQ9gXf3WXfhdpKBAj/vPpF0IpecNiBjd
        YzQjhNluk39HPi39t8Q65xapHp8xB1M=
X-Google-Smtp-Source: APiQypIglHbhRYwjv7Mtv4fDNsAxRWKr/WNnEOADkmjHUQ/lSGM4/zKRQCLumImlxPwNL/yk+n/TVA==
X-Received: by 2002:a17:90a:1f4b:: with SMTP id y11mr473243pjy.136.1587073595444;
        Thu, 16 Apr 2020 14:46:35 -0700 (PDT)
Received: from vader.tfbnw.net ([2620:10d:c090:400::5:844e])
        by smtp.gmail.com with ESMTPSA id 17sm12440228pgg.76.2020.04.16.14.46.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2020 14:46:34 -0700 (PDT)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-btrfs@vger.kernel.org
Cc:     kernel-team@fb.com, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v2 02/15] btrfs: fix error handling when submitting direct I/O bio
Date:   Thu, 16 Apr 2020 14:46:12 -0700
Message-Id: <6953c2afd9ba307568ca03604c76a767320d56ca.1587072977.git.osandov@fb.com>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <cover.1587072977.git.osandov@fb.com>
References: <cover.1587072977.git.osandov@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

In btrfs_submit_direct_hook(), if a direct I/O write doesn't span a RAID
stripe or chunk, we submit orig_bio without cloning it. In this case, we
don't increment pending_bios. Then, if btrfs_submit_dio_bio() fails, we
decrement pending_bios to -1, and we never complete orig_bio. Fix it by
initializing pending_bios to 1 instead of incrementing later.

Fixing this exposes another bug: we put orig_bio prematurely and then
put it again from end_io. Fix it by not putting orig_bio.

After this change, pending_bios is really more of a reference count, but
I'll leave that cleanup separate to keep the fix small.

Fixes: e65e15355429 ("btrfs: fix panic caused by direct IO")
Reviewed-by: Nikolay Borisov <nborisov@suse.com>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 fs/btrfs/inode.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 259239b33370..b628c319a5b6 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -7939,7 +7939,6 @@ static int btrfs_submit_direct_hook(struct btrfs_dio_private *dip)
 
 	/* bio split */
 	ASSERT(geom.len <= INT_MAX);
-	atomic_inc(&dip->pending_bios);
 	do {
 		clone_len = min_t(int, submit_len, geom.len);
 
@@ -7989,7 +7988,8 @@ static int btrfs_submit_direct_hook(struct btrfs_dio_private *dip)
 	if (!status)
 		return 0;
 
-	bio_put(bio);
+	if (bio != orig_bio)
+		bio_put(bio);
 out_err:
 	dip->errors = 1;
 	/*
@@ -8030,7 +8030,7 @@ static void btrfs_submit_direct(struct bio *dio_bio, struct inode *inode,
 	bio->bi_private = dip;
 	dip->orig_bio = bio;
 	dip->dio_bio = dio_bio;
-	atomic_set(&dip->pending_bios, 0);
+	atomic_set(&dip->pending_bios, 1);
 	io_bio = btrfs_io_bio(bio);
 	io_bio->logical = file_offset;
 
-- 
2.26.1

