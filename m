Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10E135B8E06
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Sep 2022 19:19:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230026AbiINRS4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 14 Sep 2022 13:18:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229888AbiINRSp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 14 Sep 2022 13:18:45 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 049D78169E
        for <linux-btrfs@vger.kernel.org>; Wed, 14 Sep 2022 10:18:44 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id z18so11696835qts.7
        for <linux-btrfs@vger.kernel.org>; Wed, 14 Sep 2022 10:18:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date;
        bh=FjTRAJYUKehcKRyHFAd9W+ipGTySroTPbIikUpxBg/s=;
        b=4g0bne9w93EluopYfcsMKIS+cujJDE3ekWHSPtZHrqs4PVuNnqxpmoeNQv7D1A7OqV
         OSSwGusot1qK7sp5LH/+jk5vhx+F+FCCpvtBSyUfrzOKL9dckDI6HqE3tbFzY5ewNb9c
         TCXgdzkv7S2WUFRunNQZVsw0XdrBKPcvMumfeZcsiXmYjAoi0G/qw/5Twc2puj4Dtjkg
         DNlUQ/G/a7B8/f8L1Uzb0gpUzU1OHDV2ObjHo191ceRoh7/+7A9j0/9kblDvRTAiH9Ae
         /6omGa7aNRoPNYJZznSChqB/+4m5FNKmhNpUorGbVtN+P8P7605qPtG2Fo8NB7++orQ0
         0rPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=FjTRAJYUKehcKRyHFAd9W+ipGTySroTPbIikUpxBg/s=;
        b=JIKPIdEhZT+FvOrc2sar40eruLHOaRyWsLISwJ6agA5Y+35AYJsPY6rhvjFEb37rcz
         Qop8TrY288iNO5Ncc+pwiFRX1GeX0urKPenlK523Fclsd7T3ZmkiuJOmqxWJqYGP3NLw
         Vu3mbrB9fo57ZGU2J/WjdAbavFkqA98ym8W2rLI6mxuO0NW3L+aaHv2hosziOLIJgkRK
         aztmVkiM9q9N4dwoFSiYPlpRXzuzT1DPUaMwfztMIJu/WZMiNoQ57IBg6VpJmeqTfmc+
         enl4yCW+uSqnrq5zyeeF3x9liYEJrncEGvj+h4a/1WKpsT1gALZ+2KPkrCNm2KQ3HZkP
         im0Q==
X-Gm-Message-State: ACgBeo2N8wDfK56Ec9PXeUq3POOHoGrUjolV0jdN/Bi2OmBkCHJcFGaQ
        dGZmhgrxIWkoUldHSQU8YBYWImEMVW5Dkw==
X-Google-Smtp-Source: AA6agR4Kext3qg0ZzfKFhYqHTv1SXEWO6vVDG+d25DGxVLvqc1vo8r1v96uMnr4DyHGGhkZ+D8WfUA==
X-Received: by 2002:ac8:5793:0:b0:35b:bbc9:c638 with SMTP id v19-20020ac85793000000b0035bbbc9c638mr10154108qta.403.1663175922701;
        Wed, 14 Sep 2022 10:18:42 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id bm6-20020a05620a198600b006ce60f5d8e4sm2074566qkb.130.2022.09.14.10.18.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Sep 2022 10:18:42 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 14/16] btrfs: rename struct-funcs.c -> item-accessors.c
Date:   Wed, 14 Sep 2022 13:18:19 -0400
Message-Id: <3f6da9cb8ecff030e1a3a4c9815d5d8604f1cd19.1663175597.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1663175597.git.josef@toxicpanda.com>
References: <cover.1663175597.git.josef@toxicpanda.com>
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

Rename struct-funcs.c to item-accessors.c so we can move the item
accessors out of ctree.h.  item-accessors.c is a better description of
the code that is contained in these files.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/Makefile                             | 2 +-
 fs/btrfs/{struct-funcs.c => item-accessors.c} | 0
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename fs/btrfs/{struct-funcs.c => item-accessors.c} (100%)

diff --git a/fs/btrfs/Makefile b/fs/btrfs/Makefile
index eebb45c06485..5a5906e7231d 100644
--- a/fs/btrfs/Makefile
+++ b/fs/btrfs/Makefile
@@ -24,7 +24,7 @@ obj-$(CONFIG_BTRFS_FS) := btrfs.o
 btrfs-y += super.o ctree.o extent-tree.o print-tree.o root-tree.o dir-item.o \
 	   file-item.o inode-item.o disk-io.o \
 	   transaction.o inode.o file.o tree-defrag.o \
-	   extent_map.o sysfs.o struct-funcs.o xattr.o ordered-data.o \
+	   extent_map.o sysfs.o item-accessors.o xattr.o ordered-data.o \
 	   extent_io.o volumes.o async-thread.o ioctl.o locking.o orphan.o \
 	   export.o tree-log.o free-space-cache.o zlib.o lzo.o zstd.o \
 	   compression.o delayed-ref.o relocation.o delayed-inode.o scrub.o \
diff --git a/fs/btrfs/struct-funcs.c b/fs/btrfs/item-accessors.c
similarity index 100%
rename from fs/btrfs/struct-funcs.c
rename to fs/btrfs/item-accessors.c
-- 
2.26.3

