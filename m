Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BB455B90D7
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Sep 2022 01:08:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229832AbiINXIC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 14 Sep 2022 19:08:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbiINXIB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 14 Sep 2022 19:08:01 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E64F88DF6
        for <linux-btrfs@vger.kernel.org>; Wed, 14 Sep 2022 16:07:58 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id w2so8747139qtv.9
        for <linux-btrfs@vger.kernel.org>; Wed, 14 Sep 2022 16:07:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date;
        bh=6JrsQeBhWMZTS5cFS5BZe+GUQzsKrqLxavip0LbAT3E=;
        b=ujrQfnmRMUKH7nGqSjdS+QUXsQxGibTyRW+cuTBGLZn2+QVUS8wpWS5yinCxrEuGKH
         Ybp5LRdsSpMVyg2FLIvSQnojC1uVJpSRgRVXIKJordKj8rlzoAWCbi9oQlMdRfhGtxMM
         kXKuxg+6qHkF6qNIaoC64usuGKYD63RkLdVqXLmVanazmx8989KtO7sw7yjjmF6rqLGa
         6SrwaI/hVF5EdSvG0Ym+vIEDpJ/f6UkJwb/Uk5ZCk3t2CkJV9myOj78JLOkh1nZ7Ibnk
         sVWjWNqcnYC2TgaGyNY5BgjCZzMVX6/vbGAhIaSEPXnQYWpXaKlWb/WfHBqk15CMD6in
         RwOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=6JrsQeBhWMZTS5cFS5BZe+GUQzsKrqLxavip0LbAT3E=;
        b=lIoNFGiyVEw4sHI3rJoeoN2ylrZYsLaJHtCSH8wdTPMJLA2AaSvgHs9MlVwi09nr2m
         QXD68MMLFx018i5QedpJgwq8cLsJ8q/pENrPwkzsux9IEWQQice3tp9uRuPlYKuPx4+n
         kbBKxSY2hFChdFT22HXN225xM8hYds/k/UWvyUr1X2xOtXk6eDigvXj/MfPpia0TtETb
         jjombz5ASqf/BGQEm0Yu9TRZBAdo2jCi4okhRXRHUx4ezSLQXpE5YxZ0kSQGDxitfHrD
         8c9+iNIXphRaUKb/huO7w8E+eFsGIDW2A9bKmbyOcIWwRItudzfq4Y8F+4HoHh7Q870I
         Wjrg==
X-Gm-Message-State: ACgBeo0ogRPBjGBzOyeUOLfGkWCP/SkrU0+A4uDxch2wMjIbzt2UIEha
        nM7WhITHmbsOntNs09PXH3lzvOKaADo1bA==
X-Google-Smtp-Source: AA6agR4LQKpNU9I5cVQswXdHlZTbz+CEAdk9B3XLWO4uhLHfEmHU0DNNB4eK9xEWiVeMzXUyoqslGQ==
X-Received: by 2002:ac8:5ac7:0:b0:35b:b658:4b6c with SMTP id d7-20020ac85ac7000000b0035bb6584b6cmr13969978qtd.207.1663196876940;
        Wed, 14 Sep 2022 16:07:56 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id fw8-20020a05622a4a8800b00338ae1f5421sm2425078qtb.0.2022.09.14.16.07.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Sep 2022 16:07:56 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 04/10] btrfs: move btrfs_check_super_location into scrub.c
Date:   Wed, 14 Sep 2022 19:07:44 -0400
Message-Id: <32978def2ae6a480ad5734ce4d1c5661db0206c0.1663196746.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1663196746.git.josef@toxicpanda.com>
References: <cover.1663196746.git.josef@toxicpanda.com>
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

This helper is only used in scrub.c, move it out of zoned.h locally to
scrub.c to avoid using code that isn't defined in zoned.h.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/scrub.c | 9 +++++++++
 fs/btrfs/zoned.h | 9 ---------
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index d5c23faceb8e..927431217131 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -4140,6 +4140,15 @@ int scrub_enumerate_chunks(struct scrub_ctx *sctx,
 	return ret;
 }
 
+static inline bool btrfs_check_super_location(struct btrfs_device *device, u64 pos)
+{
+	/*
+	 * On a non-zoned device, any address is OK. On a zoned device,
+	 * non-SEQUENTIAL WRITE REQUIRED zones are capable.
+	 */
+	return device->zone_info == NULL || !btrfs_dev_is_sequential(device, pos);
+}
+
 static noinline_for_stack int scrub_supers(struct scrub_ctx *sctx,
 					   struct btrfs_device *scrub_dev)
 {
diff --git a/fs/btrfs/zoned.h b/fs/btrfs/zoned.h
index aabdd364e889..0a1298afa049 100644
--- a/fs/btrfs/zoned.h
+++ b/fs/btrfs/zoned.h
@@ -311,15 +311,6 @@ static inline void btrfs_dev_clear_zone_empty(struct btrfs_device *device, u64 p
 	btrfs_dev_set_empty_zone_bit(device, pos, false);
 }
 
-static inline bool btrfs_check_super_location(struct btrfs_device *device, u64 pos)
-{
-	/*
-	 * On a non-zoned device, any address is OK. On a zoned device,
-	 * non-SEQUENTIAL WRITE REQUIRED zones are capable.
-	 */
-	return device->zone_info == NULL || !btrfs_dev_is_sequential(device, pos);
-}
-
 static inline void btrfs_zoned_meta_io_lock(struct btrfs_fs_info *fs_info)
 {
 	if (!btrfs_is_zoned(fs_info))
-- 
2.26.3

