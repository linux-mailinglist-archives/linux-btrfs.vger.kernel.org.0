Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DAF16016FA
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Oct 2022 21:11:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230241AbiJQTJq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 17 Oct 2022 15:09:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230240AbiJQTJg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 17 Oct 2022 15:09:36 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F063BDF8E
        for <linux-btrfs@vger.kernel.org>; Mon, 17 Oct 2022 12:09:34 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id 8so7293587qka.1
        for <linux-btrfs@vger.kernel.org>; Mon, 17 Oct 2022 12:09:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JtUgopcDkHvTo1NXjHGR9JnQkK1tmEc96XQcBjeTX8o=;
        b=hgqizctPY9FfiZf6mtL39hBhnnTbSLfGgVmZurAgN5YkhSz9h8iTRn5tuRzvaqMnK9
         svRnYaX51nQdnlvN0/C7zi1QiYbLCmujyAliyb7S8SLZSLjN1uCZxwB+YrAAW4ORfwUg
         jj+Sop7lHQCAnOyfL1kVQ5PrSPAK7p9Bmpw3Y5hrNaD4n4ncLzdRyhaauT24H8x3uRKO
         My4Adi4xoE+lG/RnONhAGAC3YU0sQQlHsewA5jY7URf9CB468ZZQBos6g18TRyzxSeNH
         JrXPFMTKBAZxzFIKOwGaz5XLGk7eJeEgCasNz75qpHGIJs9jV6hZ+IdDL93D6nWJjHHJ
         t4Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JtUgopcDkHvTo1NXjHGR9JnQkK1tmEc96XQcBjeTX8o=;
        b=jXJtpEi6PvyiXj/8Kvh9PP83HKIjelnNvpPo7vhfwUzYVRsrMy6CK4gtiDnT1/uL5v
         EV8rKInVKO8GsabzgmDuqa7qq9WCji3GoFMpviiHCIx3G1wBtQjOf+cnyfFl8O5kDbG9
         8Be7c5rJsi4JhRj20DEeJC5YZc/Lcm7RsidZfiAKO0KnjNAeUBwvL8wZC2bwQ2NOTS1N
         m5LD9y5iam3z3BhTjUZBDJFqDtBVCYq4/+G2Yh31EaOGA/eE2ATECtkA5+b1YpaV1WOO
         kXrBzn8v/evnEF2C5JqgL0c9CS2LqYDAj003vsC1wmxeFgIvSiznq/R1oDNAaSxdQHT/
         sB9Q==
X-Gm-Message-State: ACrzQf0jb/dWNjkiy2u19N4ds0n97uQYIFRvvv6jAMTH7nN9cpIxPkBz
        XuME7xPAQ/eOsHzfWiQ3LM0EraUqd4dXeQ==
X-Google-Smtp-Source: AMsMyM7aXlxM/Ps4hDrukpLtXTXpAI+9kJYj5Esj8bMbKzMPiV3LiZdWOSTn9UeMHDOmi5p2MlCHRw==
X-Received: by 2002:a05:620a:40c7:b0:6ee:d279:d83d with SMTP id g7-20020a05620a40c700b006eed279d83dmr8668967qko.247.1666033773531;
        Mon, 17 Oct 2022 12:09:33 -0700 (PDT)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id bx14-20020a05622a090e00b0035ce8965045sm388297qtb.42.2022.10.17.12.09.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 12:09:33 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 13/16] btrfs: rename struct-funcs.c -> accessors.c
Date:   Mon, 17 Oct 2022 15:09:10 -0400
Message-Id: <aa4f89bf455622914df09a10f2264179c46a7c26.1666033501.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1666033501.git.josef@toxicpanda.com>
References: <cover.1666033501.git.josef@toxicpanda.com>
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

