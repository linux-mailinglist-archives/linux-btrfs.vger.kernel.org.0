Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BD20788FC1
	for <lists+linux-btrfs@lfdr.de>; Fri, 25 Aug 2023 22:20:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231163AbjHYUUQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 25 Aug 2023 16:20:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231124AbjHYUTy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 25 Aug 2023 16:19:54 -0400
Received: from mail-vk1-xa31.google.com (mail-vk1-xa31.google.com [IPv6:2607:f8b0:4864:20::a31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DE19171A
        for <linux-btrfs@vger.kernel.org>; Fri, 25 Aug 2023 13:19:52 -0700 (PDT)
Received: by mail-vk1-xa31.google.com with SMTP id 71dfb90a1353d-48d10c504a8so522861e0c.2
        for <linux-btrfs@vger.kernel.org>; Fri, 25 Aug 2023 13:19:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20221208.gappssmtp.com; s=20221208; t=1692994791; x=1693599591;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=elHUiU95JNtc+7/kD21797AHjWx8kuHextAOLQG/DnA=;
        b=iApJHq1X16IoMR29reArgkRWv4VMMU7P8c6N5tmK54s4RzvygXhg2Af2Wl7ll/zH9P
         OAiCN3aCwsEIaC2CtnjXqKCz6Bf/HNWr7x6K9O+2CLx7OdFYkCtHxKFn5acsBBbp2S7p
         6gfcNAFqaGLuFzc4EQvUf/IhwcHTiUiUWyIT7+LzPWhozTbyFe6+UD/4S9ouUCWrlJgv
         4ZINPV4+mzAddBmWpcQwyPfLq5XQEaZ3AC9bjAMhdOIZC47GyDLr/Fe2dnYahf9Zzyt3
         m14l1deVgvoF0mSq3Uzl7w+cLFDe/MHfRg9mPo55d4HFj/PEEEzEgeorsrhWlhm+aMaT
         Qjrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692994791; x=1693599591;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=elHUiU95JNtc+7/kD21797AHjWx8kuHextAOLQG/DnA=;
        b=CoLs52Hj5NUQNQWocDTYBp3kApcS53v1XqhJKi4VuE5CW2fIWN7eE6FImGgoyoAVe+
         71Q7zgeU6B+beNNkc/KFbPSIjpints8fdN+fWibk412qu8NvBqPRBYNnE12f51fY6o7A
         H8SReYc7IvvQnXhy6l7Gx5jw8lBztIFc8HIEtA8Mqon7chCxzyFrKm2Mkn9gySI503CC
         +/0UOwpk4boXz+kAXSK3fWH+TCsTasj1CT+09FaU31PMUcuDT/M1QRWXPS8lxIjpIsHP
         gkD5Z5imSJoGEXgkmS0dPLyeUZ2/YhGHEeKXqLCOJjHTGY+4eMEZ05gw3qZKzCiwz2Je
         FHMg==
X-Gm-Message-State: AOJu0YxVfBJ2F4yLdLWFCoGgrFRW4iLruV4b8sYHwnTQbcpvvDVwj4CZ
        sVjd5nQWIPPU0M/+Sh3pojIRsVm4d7Kfl+fJCC0=
X-Google-Smtp-Source: AGHT+IFMtYCB1E6T2HFFKQKWD7X3KpSEO2qbBvq/I3//I0Oo2SClk0fzqxgjZP/OyUZHea0c+vAOaA==
X-Received: by 2002:a1f:c741:0:b0:48d:659:1029 with SMTP id x62-20020a1fc741000000b0048d06591029mr16547491vkf.3.1692994791370;
        Fri, 25 Aug 2023 13:19:51 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id f23-20020a05620a12f700b0076ef0fb5050sm744301qkl.31.2023.08.25.13.19.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Aug 2023 13:19:51 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 12/12] btrfs: remove extraneous includes from ctree.h
Date:   Fri, 25 Aug 2023 16:19:30 -0400
Message-ID: <15d63abd06cb64b7edc83d033e65ca00a2bae3ba.1692994620.git.josef@toxicpanda.com>
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

