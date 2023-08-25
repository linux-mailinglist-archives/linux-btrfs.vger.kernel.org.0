Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B533E788FC2
	for <lists+linux-btrfs@lfdr.de>; Fri, 25 Aug 2023 22:20:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231156AbjHYUUP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 25 Aug 2023 16:20:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230513AbjHYUTv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 25 Aug 2023 16:19:51 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBEBD171A
        for <linux-btrfs@vger.kernel.org>; Fri, 25 Aug 2023 13:19:49 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id d75a77b69052e-4108f57db7fso6956161cf.1
        for <linux-btrfs@vger.kernel.org>; Fri, 25 Aug 2023 13:19:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20221208.gappssmtp.com; s=20221208; t=1692994789; x=1693599589;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DHBFOgE5uZyoUbpVEvQ3beNIaqF+ekj1i5xCHWJaTCQ=;
        b=SjJ48FfYJbg0j9PKJ2eIAqTKKi9RZ6VJf/2fZdoV5tfOBPNXIReSvhh7/OszgugNP3
         K0f7c2f0wT7ybGkH8wlrJLDmMK9290+S0XTxdSvKGAr+RXlR/kQg+PaNTuT+DJ1KmPvN
         +icnyGTSSJ6oU4FsunYsDiG+fwjmtMMzOj78+KTMcd7jA5d1CfZn+luHQrrn92x5ZSIW
         DP1d6OKlFy0P3d7thQ7t83wV58Dd54lDpW4A6+FQ0z8+87LyE9NcUpmk8rPeKN+GAX56
         9EUsiTy542qf5IUpbrBY5IP25BjwnGPm2bkVgBbkJIAJEHtK+rMqTtJw4SZ22u7dxyur
         PtCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692994789; x=1693599589;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DHBFOgE5uZyoUbpVEvQ3beNIaqF+ekj1i5xCHWJaTCQ=;
        b=az72C8PF2IrXQA624UOELu04cmuEhQGCwrkBEB4twHH5fM2ywzjicrym66bTWTi33L
         3euCOrpigHVAH/Fpsj7wFPk2D3B1nxlUf6/G/QXYUn5fr087n8T+Tc/8JaaqEfaENfrE
         jIZJfqpTj3CgemzJ0vdnO4W2tgdJrZ1atioCt4bmErErkuKOoe91Z23BQrU1MT3baDAx
         i/kWAMzSvrWPhHhegMHRgWLYEqE8V/3R72LHyj+3tqn3XaBm7UyhMIpf7AgW+xeYhwNs
         s44uaOcJv5Flnz6Vok80wnfGMcbQvGsBmuiJvQR6r4SD1+RDyG4E+LqkwR3gTO81tt+m
         kiMg==
X-Gm-Message-State: AOJu0YyH6n36Yy9q5qmlcyWoi4akIMpxUNjgeaYmChbxCGgCyre7qZ6q
        mtCGz/Kh+2PDTvo6onr/aND/C2TdMmRoiin+EQc=
X-Google-Smtp-Source: AGHT+IEfSKnkoBarjn1OvtHvQfUs5f5DrweY5F35vC2wR/oFnvN7C3KOoBRWO35c5U+Up/dtTHUBYA==
X-Received: by 2002:a05:622a:290:b0:410:9b45:d7f3 with SMTP id z16-20020a05622a029000b004109b45d7f3mr16183203qtw.36.1692994788939;
        Fri, 25 Aug 2023 13:19:48 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id c27-20020ac8009b000000b00407ffb2c24dsm733032qtg.63.2023.08.25.13.19.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Aug 2023 13:19:48 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 10/12] btrfs: include trace header in where necessary
Date:   Fri, 25 Aug 2023 16:19:28 -0400
Message-ID: <59f02409baa3a41239ff61c3cf4c62b2a26501b9.1692994620.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1692994620.git.josef@toxicpanda.com>
References: <cover.1692994620.git.josef@toxicpanda.com>
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

