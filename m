Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAFE47AF461
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Sep 2023 21:47:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232101AbjIZTrk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 26 Sep 2023 15:47:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233435AbjIZTrj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 26 Sep 2023 15:47:39 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B47511D
        for <linux-btrfs@vger.kernel.org>; Tue, 26 Sep 2023 12:47:33 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id 6a1803df08f44-65afd746330so31476146d6.3
        for <linux-btrfs@vger.kernel.org>; Tue, 26 Sep 2023 12:47:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1695757652; x=1696362452; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ognZb5N4XgQMFE+Y9YTtvsozqHDPydsdjzcRyfczn+w=;
        b=odDrocbMnp2FaIgC0ZfcA5W0WOu8S0nTTsf73/NUP2S3l4RKmMaB7cuZl7ylqQPvt/
         eHYvp1134/QTRxyg8/OmWuM5cwyGtYsxch0AvS3+G38uEelFSdIREx+/u7EnOLh/1VEd
         iCotRbBioScLLCUoA6AQMzn9VnfgZcSXlV8io1GATboVZhpO5iRjDBNQuZSich1ThgeF
         tPPcEAAitlMOA0OjcNbu+x1FuN+mNJbxss0zz2Z75MepA9cWIP+z/RgXejO2Binfsxz3
         fLGMMYd70X763PFQzQ2kvPIpYjzAvhORDPYyjhuN04c4ZcHY1Eg2kFwcBrfB5qRLPXV5
         i/9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695757652; x=1696362452;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ognZb5N4XgQMFE+Y9YTtvsozqHDPydsdjzcRyfczn+w=;
        b=j7gwoaw7MGxQooapNuonMf8877Cs2OdCTIcoUrpmfr+v1Zv8HtvQ6xNN6YZ6y6Yr2S
         5N0bsIGRw8trt+LS1bLG/MQwokdVUj4e4SziUdmQdoRJuiEuhM3MCmmD7hNWv5ZCBCMg
         RQMaaANec8SPq/m0WBsTP0dqvSKn561yiTcnl1ZbLtGq65hXqd+PeC3b46ofUth0ksOl
         X8JeCtjwoFosiruS18lBqsxSrSuzNXkPUo91pKPkz6QWK9vmio/2yCM37EhLupMCLyYH
         Zxp67IAC7qKk3hYjkduGnExd0vWhtNT5MQWTSDMiUQaJtsKzzy7WupnDN8zebPuIjay0
         VxQg==
X-Gm-Message-State: AOJu0YzYCvA91x9AqrV7K3wt2JFtVfplDn08yeXR99qwFdQrCB1c24k7
        tvrG9K75OvhSgKKt6k6dny8MLPr7ZSVqTtlebK01XQ==
X-Google-Smtp-Source: AGHT+IGX3rp2mjPZpckCa5nNAaMSAoa4bEaoS79mn1euV4/S6XJPdKV5Ol32Z9FQrDN9N/LlBjZ76g==
X-Received: by 2002:a05:6214:1949:b0:659:e547:ca72 with SMTP id q9-20020a056214194900b00659e547ca72mr15374656qvk.40.1695757652091;
        Tue, 26 Sep 2023 12:47:32 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id ow10-20020a05620a820a00b0076d9df37949sm4992828qkn.36.2023.09.26.12.47.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Sep 2023 12:47:31 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Jens Axboe <axboe@kernel.dk>
Subject: [PATCH] btrfs: fix some maybe uninitialized warnings in ioctl.c
Date:   Tue, 26 Sep 2023 15:47:27 -0400
Message-ID: <0e16cb17a51ba2542986de951a61bd1362360eb9.1695757597.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Jens reported the following warnings from -Wmaybe-uninitialized recent
linus.

In file included from ./include/asm-generic/rwonce.h:26,
                 from ./arch/arm64/include/asm/rwonce.h:71,
                 from ./include/linux/compiler.h:246,
                 from ./include/linux/export.h:5,
                 from ./include/linux/linkage.h:7,
                 from ./include/linux/kernel.h:17,
                 from fs/btrfs/ioctl.c:6:
In function ‘instrument_copy_from_user_before’,
    inlined from ‘_copy_from_user’ at ./include/linux/uaccess.h:148:3,
    inlined from ‘copy_from_user’ at ./include/linux/uaccess.h:183:7,
    inlined from ‘btrfs_ioctl_space_info’ at fs/btrfs/ioctl.c:2999:6,
    inlined from ‘btrfs_ioctl’ at fs/btrfs/ioctl.c:4616:10:
./include/linux/kasan-checks.h:38:27: warning: ‘space_args’ may be used
uninitialized [-Wmaybe-uninitialized]
   38 | #define kasan_check_write __kasan_check_write
./include/linux/instrumented.h:129:9: note: in expansion of macro
‘kasan_check_write’
  129 |         kasan_check_write(to, n);
      |         ^~~~~~~~~~~~~~~~~
./include/linux/kasan-checks.h: In function ‘btrfs_ioctl’:
./include/linux/kasan-checks.h:20:6: note: by argument 1 of type ‘const
volatile void *’ to ‘__kasan_check_write’ declared here
   20 | bool __kasan_check_write(const volatile void *p, unsigned int
      size);
      |      ^~~~~~~~~~~~~~~~~~~
fs/btrfs/ioctl.c:2981:39: note: ‘space_args’ declared here
 2981 |         struct btrfs_ioctl_space_args space_args;
      |                                       ^~~~~~~~~~
In function ‘instrument_copy_from_user_before’,
    inlined from ‘_copy_from_user’ at ./include/linux/uaccess.h:148:3,
    inlined from ‘copy_from_user’ at ./include/linux/uaccess.h:183:7,
    inlined from ‘_btrfs_ioctl_send’ at fs/btrfs/ioctl.c:4343:9,
    inlined from ‘btrfs_ioctl’ at fs/btrfs/ioctl.c:4658:10:
./include/linux/kasan-checks.h:38:27: warning: ‘args32’ may be used
uninitialized [-Wmaybe-uninitialized]
   38 | #define kasan_check_write __kasan_check_write
./include/linux/instrumented.h:129:9: note: in expansion of macro
‘kasan_check_write’
  129 |         kasan_check_write(to, n);
      |         ^~~~~~~~~~~~~~~~~
./include/linux/kasan-checks.h: In function ‘btrfs_ioctl’:
./include/linux/kasan-checks.h:20:6: note: by argument 1 of type ‘const
volatile void *’ to ‘__kasan_check_write’ declared here
   20 | bool __kasan_check_write(const volatile void *p, unsigned int
      size);
      |      ^~~~~~~~~~~~~~~~~~~
fs/btrfs/ioctl.c:4341:49: note: ‘args32’ declared here
 4341 |                 struct btrfs_ioctl_send_args_32 args32;
      |                                                 ^~~~~~

This was due to his config options and having KASAN turned on,
which adds some extra checks around copy_from_user(), which then
triggered the -Wmaybe-uninitialized checker for these cases.

Fix the warnings by initializing the different structs we're copying
into.

Reported-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/ioctl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 75ab766fe156..8e7d03bc1b56 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -2978,7 +2978,7 @@ static void get_block_group_info(struct list_head *groups_list,
 static long btrfs_ioctl_space_info(struct btrfs_fs_info *fs_info,
 				   void __user *arg)
 {
-	struct btrfs_ioctl_space_args space_args;
+	struct btrfs_ioctl_space_args space_args = { 0 };
 	struct btrfs_ioctl_space_info space;
 	struct btrfs_ioctl_space_info *dest;
 	struct btrfs_ioctl_space_info *dest_orig;
@@ -4338,7 +4338,7 @@ static int _btrfs_ioctl_send(struct inode *inode, void __user *argp, bool compat
 
 	if (compat) {
 #if defined(CONFIG_64BIT) && defined(CONFIG_COMPAT)
-		struct btrfs_ioctl_send_args_32 args32;
+		struct btrfs_ioctl_send_args_32 args32 = { 0 };
 
 		ret = copy_from_user(&args32, argp, sizeof(args32));
 		if (ret)
-- 
2.41.0

