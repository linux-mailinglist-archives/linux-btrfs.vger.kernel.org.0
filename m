Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDD837859CC
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Aug 2023 15:51:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236319AbjHWNv6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 23 Aug 2023 09:51:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234877AbjHWNv5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 23 Aug 2023 09:51:57 -0400
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25DD219A
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Aug 2023 06:51:53 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-58c92a2c52dso61309227b3.2
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Aug 2023 06:51:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20221208.gappssmtp.com; s=20221208; t=1692798712; x=1693403512;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sC8vKC1MdrtQTH/KdS7qPHtYBd4gWs5JdzeemEzBpyc=;
        b=lyZbpx4d6yDwETU2iyYvMdwbKeTJWGOe0P5dSC2lWDvzrHGl6Gji4xQbbnuDkrFFzn
         oUe6/SUqnUh94Mb0+mi5c7WbwfbgNs5WQNfv/J/jyALFHne45QMe2CqJRNrYTR6wWTlH
         qNU+yDsMPEqX2/lyabXJG1F+QXNcvHr+KOZsedNDhHEUiXnuCXiPOvZaZOJiq68D/wy0
         fOkY3QxvAymJlU3p0UlofyIUx/etpVVpEvLYK2BqggdoYIFA6x1fXdrr7hGrFypTyQhZ
         bi1EYuAn69JNFy1EVW6B+1voOGuawM4S4TRnld7Pa1EAEOJR6oBvLAvVXXq3GUAvRMju
         SJsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692798712; x=1693403512;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sC8vKC1MdrtQTH/KdS7qPHtYBd4gWs5JdzeemEzBpyc=;
        b=Sfc3JrAO3LLn1YSAM69YuSvy5QetDjQN+HV2JSAHQdGRXPH2ghB6KEJnsaxo5UinMn
         t/DoWTQ+ExApx0lVGPD0Jsxz/qZpxiCKYksRM8+gKnbCdvsXvrszhNH30VuObv7cuIc+
         PinZP/DXlPMS8o92mk6OnnjyEjNIe3VffiGzSPCpV4GxBNXgeUGWhXnH5j/+MfccPZDE
         buLF+mNP2fCRZjm/q5VkMGopfc8HBaJOCWMhvHJP8AmFQwwFV/3PqwBmzp2cnR4ntwfM
         n+XUtkym7zJBrhM2SJqt3bzB0TmBKEXG+5mcFq1R5IOPTI6mLuTRKzWmrR0TyA7DjXVG
         ZgTg==
X-Gm-Message-State: AOJu0YwuUm/CmOXmwBG8yHW6X0M1i1Xj4EPdGyKrWSbbJOeEpb5WAVwZ
        IOYGX2DQ6wdqvsZE1gs1x4m+L+VdxVbiE3P6GIs=
X-Google-Smtp-Source: AGHT+IFpBj8vuy/6TuNaHN+tJoAAIrr2CgysN0ypqFrRJLg9fBX5Hwr5FrIPgmSWujKRmiNahJOgeA==
X-Received: by 2002:a0d:ea95:0:b0:579:f163:dc2f with SMTP id t143-20020a0dea95000000b00579f163dc2fmr13207236ywe.3.1692798712244;
        Wed, 23 Aug 2023 06:51:52 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id g191-20020a8152c8000000b005840bd271c5sm3317325ywb.100.2023.08.23.06.51.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 06:51:51 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 06/11] btrfs: include linux/crc32c in dir-item and inode-item
Date:   Wed, 23 Aug 2023 09:51:32 -0400
Message-ID: <6dbf325458ee1c2fc45a66779fd5a277d4f39810.1692798556.git.josef@toxicpanda.com>
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

Now these are holding the crc32c wrappers, add the required include so
that we have our necessary dependencies.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/dir-item.h   | 2 ++
 fs/btrfs/inode-item.h | 1 +
 2 files changed, 3 insertions(+)

diff --git a/fs/btrfs/dir-item.h b/fs/btrfs/dir-item.h
index 951b4dda46fe..5db2ea0dfd76 100644
--- a/fs/btrfs/dir-item.h
+++ b/fs/btrfs/dir-item.h
@@ -3,6 +3,8 @@
 #ifndef BTRFS_DIR_ITEM_H
 #define BTRFS_DIR_ITEM_H
 
+#include <linux/crc32c.h>
+
 int btrfs_check_dir_item_collision(struct btrfs_root *root, u64 dir,
 			  const struct fscrypt_str *name);
 int btrfs_insert_dir_item(struct btrfs_trans_handle *trans,
diff --git a/fs/btrfs/inode-item.h b/fs/btrfs/inode-item.h
index 2ee425a08e63..63dfd227e7ce 100644
--- a/fs/btrfs/inode-item.h
+++ b/fs/btrfs/inode-item.h
@@ -4,6 +4,7 @@
 #define BTRFS_INODE_ITEM_H
 
 #include <linux/types.h>
+#include <linux/crc32c.h>
 
 struct btrfs_trans_handle;
 struct btrfs_root;
-- 
2.41.0

