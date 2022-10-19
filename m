Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 430E2604A31
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Oct 2022 16:59:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231420AbiJSO61 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 19 Oct 2022 10:58:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231829AbiJSO5k (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 19 Oct 2022 10:57:40 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0F23ACF55
        for <linux-btrfs@vger.kernel.org>; Wed, 19 Oct 2022 07:51:20 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id o22so10824642qkl.8
        for <linux-btrfs@vger.kernel.org>; Wed, 19 Oct 2022 07:51:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cYlcEecWd5Pjcul244Ku98NZULov2vpmpNCU/jU3SFI=;
        b=iRBeHdgZQ5bKk2mIhXJcCa9PXZq6UUrjtZvX1Jw1y1paLnroedtk+IsQtZmWbUlOV4
         Ckys9yKFUzkEinQsuq21Y0FjvegtQzg3/5q9NnwYiZVdpmsV44x/JlXVSdRM1pFcY8vG
         8jhkXrY5sxHvvexNGh2g8PNm/+EzRZ6qz5t5NVBhSqLuWgoFG6+g0VwXzBwJgH4sKyR6
         2Jw2XrC93ESYUFY6LCRPhbIRMWB6mX5e2fNPy1hyKMQzYrjRy58NeawJMSxVaNPT3uAx
         E2JYalVuPgeMJNCSNOt07zz9H/cEaIlgMEkc6scEcNua9+4vuOcu1rPl0tAclcb8EDO4
         Y/ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cYlcEecWd5Pjcul244Ku98NZULov2vpmpNCU/jU3SFI=;
        b=bK0gqudajVhhUPT7jzQnBqQxGUN4fsXdbrK50XPm5g10Z4clVfRmM9oJ1s6Gohgpqw
         hBItU8m4I2EcecW7intvGzJwn3BOBGaLtX+Oy0dDqen2UdnR0Tpwe99BfWv2mghZYzyL
         1w9jpkLydhs9QI38oAeTwc+BHCjEPtKA93pByoAiUYkBT9upnFUvMGKVSeWjJcnHHtNJ
         Rr0Mcv11dn4WoHlK6dkOok91X1IRQ8QJjUOF5c+jzTupFDUW8dJpOiQtCPfMa5mmpBlO
         hkR3yCeB2ISz7bGTv6rVNbTl2kPh1tzpggMvmRxF+PDjhgkFOo+DPYqhKWvgBS2XfugA
         BbXA==
X-Gm-Message-State: ACrzQf1J4zYRyX7xyoMQXTuqyJPOBUhsffMDCyQeQU10joipnXwAtMio
        4WhEMsYj23sijoba7KO0ZtoJ0oN4r2QUng==
X-Google-Smtp-Source: AMsMyM46829JsUnbXbtV/IA6oLDZtavxXWRqiHDtb629zgwxFYinx+rgN6Bmr1V9i8mFdyFDcvhf5Q==
X-Received: by 2002:a37:f701:0:b0:6ce:f09b:9065 with SMTP id q1-20020a37f701000000b006cef09b9065mr5850549qkj.268.1666191079627;
        Wed, 19 Oct 2022 07:51:19 -0700 (PDT)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id de38-20020a05620a372600b006ce30a5f892sm5272832qkb.102.2022.10.19.07.51.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Oct 2022 07:51:19 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v3 12/15] btrfs: rename struct-funcs.c -> accessors.c
Date:   Wed, 19 Oct 2022 10:50:58 -0400
Message-Id: <ee569c3a6fca1c6675d1acd47bdaced15f666cf1.1666190849.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1666190849.git.josef@toxicpanda.com>
References: <cover.1666190849.git.josef@toxicpanda.com>
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

Rename struct-funcs.c to accessors.c so we can move the item accessors
out of ctree.h. accessors.c is a better description of the code that is
contained in these files.

Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/Makefile                        | 2 +-
 fs/btrfs/{struct-funcs.c => accessors.c} | 0
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename fs/btrfs/{struct-funcs.c => accessors.c} (100%)

diff --git a/fs/btrfs/Makefile b/fs/btrfs/Makefile
index eebb45c06485..76f90dcfb14d 100644
--- a/fs/btrfs/Makefile
+++ b/fs/btrfs/Makefile
@@ -24,7 +24,7 @@ obj-$(CONFIG_BTRFS_FS) := btrfs.o
 btrfs-y += super.o ctree.o extent-tree.o print-tree.o root-tree.o dir-item.o \
 	   file-item.o inode-item.o disk-io.o \
 	   transaction.o inode.o file.o tree-defrag.o \
-	   extent_map.o sysfs.o struct-funcs.o xattr.o ordered-data.o \
+	   extent_map.o sysfs.o accessors.o xattr.o ordered-data.o \
 	   extent_io.o volumes.o async-thread.o ioctl.o locking.o orphan.o \
 	   export.o tree-log.o free-space-cache.o zlib.o lzo.o zstd.o \
 	   compression.o delayed-ref.o relocation.o delayed-inode.o scrub.o \
diff --git a/fs/btrfs/struct-funcs.c b/fs/btrfs/accessors.c
similarity index 100%
rename from fs/btrfs/struct-funcs.c
rename to fs/btrfs/accessors.c
-- 
2.26.3

