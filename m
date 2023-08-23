Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9C8F7859D1
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Aug 2023 15:52:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236327AbjHWNwC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 23 Aug 2023 09:52:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236317AbjHWNwB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 23 Aug 2023 09:52:01 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80B7E19A
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Aug 2023 06:51:59 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-58d9ba95c78so63150037b3.1
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Aug 2023 06:51:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20221208.gappssmtp.com; s=20221208; t=1692798718; x=1693403518;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=elHUiU95JNtc+7/kD21797AHjWx8kuHextAOLQG/DnA=;
        b=LBTeAN2l3SSvtfK0YabZkc+f11QzD+pBGrTnhT0lRu4uCpAek2rgWrNgQn2gs5RMoJ
         lEJen6RRG66PNtBVC7DH1G8PDfULJAK/LnDCuGbXygji8P5ApEvzzaK0c3UBW4UMbpXO
         6h78+2+wJX7CDT74U9F6MxBY7Quq/rYOaRYDJ3Hg1nbSWocIen+A0AI0hX8zn3hRnntA
         dwahm8Tc95ujiLWll7XCXQuOnQrTDiRVIB3MefhO3/I+rmCEfk0T9e5KBkYfWWknNTVJ
         r0a9kydYFYI7YHLNgym7VuUMD8c3Neaov7xIGxbk7/tLXf5f4rOLTafODXcL4go2Z5om
         C28g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692798718; x=1693403518;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=elHUiU95JNtc+7/kD21797AHjWx8kuHextAOLQG/DnA=;
        b=Wsu7g/ImWr7OgMqOG4JJ1mxt8Ctrfjys0P4jig8mvbKY20ksP262SMGLMOIrJbBjJn
         /n3QNCqaawIOSZ7v02VEtYS1u7eDKwCBe9s1bhzfJczFowbjrRpJuIu/yj5k6SX9OajL
         1bEq4XJWBd6eTPtQO/kIGDrMxJhErfdiM8Rf8jMFKHZ/YJ180iqiU+ho/RNBTbLG6Z3L
         LqjnYrFnFep0WCA/zCwHoeIll18w7J27vShS5L9zZcW1tGMw836DOwsAyYRafgMCK6Ui
         Bqja213GAPPUH+6k9a/UoNoHx7RmhFIpk1xjb8DMlF/sBU/5e9oyKmaGK1r0FJ8h1wm2
         1knA==
X-Gm-Message-State: AOJu0YxQRRYBSl4WCBq91CtD4cxHlyAdq6Pl7BVtoEhdaNgQZMeaoXtn
        s1z/ma07vLxmu10i4Cl4Wp7QWSCIxB4dhsWCk/I=
X-Google-Smtp-Source: AGHT+IHR/QNHN95CAlsnt0Rt6K90JYVYz3uLl30DFD0QKUhOtT8N+ZVl2OdFW3hnGLH4KGNrYwoOfQ==
X-Received: by 2002:a0d:c641:0:b0:592:608b:b9f7 with SMTP id i62-20020a0dc641000000b00592608bb9f7mr1948303ywd.35.1692798718494;
        Wed, 23 Aug 2023 06:51:58 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id h126-20020a0dde84000000b0058038e6609csm3359237ywe.74.2023.08.23.06.51.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 06:51:58 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 11/11] btrfs: remove extraneous includes from ctree.h
Date:   Wed, 23 Aug 2023 09:51:37 -0400
Message-ID: <ed1caf5b26573e62547cb3b96031af66c0f082ca.1692798556.git.josef@toxicpanda.com>
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

We don't need any of these includes in the ctree.h header file for the
header file itself, remove them to clean up ctree.h a little bit.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/ctree.h | 28 ----------------------------
 1 file changed, 28 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 9c2e96b8711f..da9e07bf76ea 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -6,36 +6,8 @@
 #ifndef BTRFS_CTREE_H
 #define BTRFS_CTREE_H
 
-#include <linux/mm.h>
-#include <linux/sched/signal.h>
-#include <linux/highmem.h>
-#include <linux/fs.h>
-#include <linux/rwsem.h>
-#include <linux/semaphore.h>
-#include <linux/completion.h>
-#include <linux/backing-dev.h>
-#include <linux/wait.h>
-#include <linux/slab.h>
-#include <trace/events/btrfs.h>
-#include <asm/unaligned.h>
 #include <linux/pagemap.h>
-#include <linux/btrfs.h>
-#include <linux/btrfs_tree.h>
-#include <linux/workqueue.h>
-#include <linux/security.h>
-#include <linux/sizes.h>
-#include <linux/dynamic_debug.h>
-#include <linux/refcount.h>
-#include <linux/crc32c.h>
-#include <linux/iomap.h>
-#include <linux/fscrypt.h>
-#include "extent-io-tree.h"
-#include "extent_io.h"
-#include "extent_map.h"
-#include "async-thread.h"
-#include "block-rsv.h"
 #include "locking.h"
-#include "misc.h"
 #include "fs.h"
 
 struct btrfs_trans_handle;
-- 
2.41.0

