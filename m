Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 607077859D0
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Aug 2023 15:52:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236326AbjHWNwB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 23 Aug 2023 09:52:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236320AbjHWNv7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 23 Aug 2023 09:51:59 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C51019A
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Aug 2023 06:51:58 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id 3f1490d57ef6-d45caf42d73so5399542276.2
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Aug 2023 06:51:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20221208.gappssmtp.com; s=20221208; t=1692798717; x=1693403517;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DHBFOgE5uZyoUbpVEvQ3beNIaqF+ekj1i5xCHWJaTCQ=;
        b=yY6fbcHPAJwP2KBDDlb40/F4wRBOunxF8XTnWtDYy4SzaUKRCdSrRgiArkRFzDAnYR
         OXsptHxjUjhiqGL+Oq4LlMTUHsqapVB19k7P7Kti4m87/51G+SZDrzejH+MEGepYE775
         RJxN57LJdTaq5+YytjeVLpYTl0nMywwhbCCdhxlkDNCRlVZwr3DgNFwODArc3OeMVhi9
         IBsu/IWCnL8cct3e8yi9vfh9hkfC//in8isu2u8PaKqx7vbwY3DryhJDHypeRbSQxgY+
         ZOkbtNwndixBbrXpIclVdJkqMdOijIlLZV1y6wTly3xJnmY2OXvmjoW8B7QmxR82vJk6
         hVHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692798717; x=1693403517;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DHBFOgE5uZyoUbpVEvQ3beNIaqF+ekj1i5xCHWJaTCQ=;
        b=B5Zej1WsWa4vZLDuDQoNhBYjSlxN/KitCy02/9wljwimqB/dyBYIC6DdbQGpmXJCYx
         hgdT35mvfeBF/ipSA3QikImEWOZytnHcVw0evEJBL6p+6Cw71aBE9RFvKHgM6HiVfvIr
         7H2zoPdku8ciHYJhB1wWVp3FO/wX3zogZ01xDFGm/i6dIHECImoyjr4x3IhZLsHqKBn1
         GzRzFbILAfbmz+6XD3TIGTXAkXvZfzujSd0lSeTSOL8bkaluZguJjCX1zab4vhGzr/k4
         UXBZBTPqDVjhG2Z/pnu4d0OnnRBCK0SuCSLpcqtIvwvrNs8ztAe1YQkOUXDYBw78+Ja/
         nkaw==
X-Gm-Message-State: AOJu0YyVxJidG84EyPaTSIgP4lDtVT7Wafq24NIJXGwGNu40nj6K10+a
        G3RGtADFQ6n9+4UOVpVt/ljjkcHKiWV+ITawEbg=
X-Google-Smtp-Source: AGHT+IGDDN2u/VWlhjSowVDGOI804YpMd/e1Pczn/NhgMjXos/JwrxE5iYMDW8DbjShEicUs2FIFLQ==
X-Received: by 2002:a25:d752:0:b0:d77:d6e5:410a with SMTP id o79-20020a25d752000000b00d77d6e5410amr1179451ybg.51.1692798717232;
        Wed, 23 Aug 2023 06:51:57 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 203-20020a2501d4000000b00d4fc4132653sm2835226ybb.11.2023.08.23.06.51.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 06:51:56 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 10/11] btrfs: include trace header in where necessary
Date:   Wed, 23 Aug 2023 09:51:36 -0400
Message-ID: <59f02409baa3a41239ff61c3cf4c62b2a26501b9.1692798556.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1692798556.git.josef@toxicpanda.com>
References: <cover.1692798556.git.josef@toxicpanda.com>
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

If we no longer include the tracepoints from ctree.h we fail to compile
because we have the dependency in some of the header files and source
files.  Add the include where we have these dependencies to allow us to
remove the include from ctree.h.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/async-thread.c | 1 +
 fs/btrfs/btrfs_inode.h  | 1 +
 fs/btrfs/locking.c      | 1 +
 fs/btrfs/space-info.h   | 1 +
 4 files changed, 4 insertions(+)

diff --git a/fs/btrfs/async-thread.c b/fs/btrfs/async-thread.c
index ce083e99ef68..714ca74b66bf 100644
--- a/fs/btrfs/async-thread.c
+++ b/fs/btrfs/async-thread.c
@@ -9,6 +9,7 @@
 #include <linux/list.h>
 #include <linux/spinlock.h>
 #include <linux/freezer.h>
+#include <trace/events/btrfs.h>
 #include "async-thread.h"
 #include "ctree.h"
 
diff --git a/fs/btrfs/btrfs_inode.h b/fs/btrfs/btrfs_inode.h
index bca97a6bb246..b675dc09845d 100644
--- a/fs/btrfs/btrfs_inode.h
+++ b/fs/btrfs/btrfs_inode.h
@@ -9,6 +9,7 @@
 #include <linux/hash.h>
 #include <linux/refcount.h>
 #include <linux/fscrypt.h>
+#include <trace/events/btrfs.h>
 #include "extent_map.h"
 #include "extent_io.h"
 #include "ordered-data.h"
diff --git a/fs/btrfs/locking.c b/fs/btrfs/locking.c
index 7979449a58d6..79a125c0f4a2 100644
--- a/fs/btrfs/locking.c
+++ b/fs/btrfs/locking.c
@@ -8,6 +8,7 @@
 #include <linux/spinlock.h>
 #include <linux/page-flags.h>
 #include <asm/bug.h>
+#include <trace/events/btrfs.h>
 #include "misc.h"
 #include "ctree.h"
 #include "extent_io.h"
diff --git a/fs/btrfs/space-info.h b/fs/btrfs/space-info.h
index 0bb9d14e60a8..ac0ce83f1477 100644
--- a/fs/btrfs/space-info.h
+++ b/fs/btrfs/space-info.h
@@ -3,6 +3,7 @@
 #ifndef BTRFS_SPACE_INFO_H
 #define BTRFS_SPACE_INFO_H
 
+#include <trace/events/btrfs.h>
 #include "volumes.h"
 
 /*
-- 
2.41.0

