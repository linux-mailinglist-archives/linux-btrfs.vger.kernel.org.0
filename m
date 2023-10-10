Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E37907C4138
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Oct 2023 22:28:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343693AbjJJU2i (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 10 Oct 2023 16:28:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343548AbjJJU2g (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 10 Oct 2023 16:28:36 -0400
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 283E691
        for <linux-btrfs@vger.kernel.org>; Tue, 10 Oct 2023 13:28:35 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-5a7ac4c3666so22749487b3.3
        for <linux-btrfs@vger.kernel.org>; Tue, 10 Oct 2023 13:28:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1696969714; x=1697574514; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7JoAqvQEt6eH9DqcEa1Y5bx41bv20K2cSzoQx+Xkzm0=;
        b=tXniS0Iwgab0oaVCYe2r4vPKcZ+SK8D6cRqBgujIxvVhNuwoLXCbh8/A9Ui9eaHaIK
         gKzWbPRmzYIc9DX5evLHXWbJFEodgckNRZ2S/IP1aZA4TYYIm4FpnfsjYisweDCqhPxU
         IpWNhm/lxBjekopsSAf5AtOwV34KUnSunf4HULAowBtNFcwgfcFdGXhovJrghjSumrKd
         ZemYBTz+EvdIP/MQMyt+23eEynZ9jN1bebbG/U6CD4sUt7bNHmbhjIVxaRGBcUbYEjQ8
         kdY2/pZDgVfG3AGMXyZ8YZuAO/mShBamCE80q04bEpzVd42fagTKaVr64KETnRXTmEvW
         zLkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696969714; x=1697574514;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7JoAqvQEt6eH9DqcEa1Y5bx41bv20K2cSzoQx+Xkzm0=;
        b=iWWwt3CMGPTLvJcbGkZv0n9AikRzgSYzg1ggXuIWvaUF+Ztqo4VmW/w4UL4deo9Op0
         gQrtudrPofD/paPCPJpL+73/JJA8unjoiLlisEHt16LadqEoB/oq+7ooAvodGGKNSWfb
         m6MA5q8yY6sMJ96dpFuH9v47IURaA6f45JGPcNzIGfZeQUsDmJ9GdO7JaZrqpM+fqBxf
         KtcEBcQQJF8fl1MZgczuSp9i2gW8B+9KlXGzHiv4hcRurViavB7U5wKoNLLBV66sT6q8
         j8EE+QISsF7PRn2uBV+cczXKn11C0BbMX9S2XeO4jDfjhBUCahi9Ia7x/VJVZp5E9hJr
         qorQ==
X-Gm-Message-State: AOJu0Ywg/prnXmHrgCFLCO3MClx+3t+ddJAtqGDGGJpRKc1P+lOKkKkx
        iK1I7B7y12peRQm9wVvLuDjvhEFN7Ih6O0uBVItQ3g==
X-Google-Smtp-Source: AGHT+IFMJNpyPjuutYCWXJhQXe+nhGdrKqerW1hhVlRYpct9UOvDXz2j63jwLyzBY3s41HDDIROzMg==
X-Received: by 2002:a0d:d4d3:0:b0:5a7:be23:6a7c with SMTP id w202-20020a0dd4d3000000b005a7be236a7cmr3275971ywd.6.1696969714259;
        Tue, 10 Oct 2023 13:28:34 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id d1-20020a81ab41000000b0059511008958sm4555970ywk.76.2023.10.10.13.28.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 13:28:33 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Subject: [PATCH 4/8] btrfs-progs: add inode encryption contexts
Date:   Tue, 10 Oct 2023 16:28:21 -0400
Message-ID: <1a456b16da0ab1dbf643e62235954d8a7de5e61a.1696969632.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1696969632.git.josef@toxicpanda.com>
References: <cover.1696969632.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>

Recapitulates relevant parts of kernel change 'btrfs: add inode
encryption contexts'.

Signed-off-by: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
---
 kernel-shared/uapi/btrfs_tree.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel-shared/uapi/btrfs_tree.h b/kernel-shared/uapi/btrfs_tree.h
index f49ae534..37869fea 100644
--- a/kernel-shared/uapi/btrfs_tree.h
+++ b/kernel-shared/uapi/btrfs_tree.h
@@ -162,6 +162,8 @@
 #define BTRFS_VERITY_DESC_ITEM_KEY	36
 #define BTRFS_VERITY_MERKLE_ITEM_KEY	37
 
+#define BTRFS_FSCRYPT_CTXT_ITEM_KEY	41
+
 #define BTRFS_ORPHAN_ITEM_KEY		48
 /* reserve 2-15 close to the inode for later flexibility */
 
@@ -400,6 +402,7 @@ static inline __u8 btrfs_dir_flags_to_ftype(__u8 flags)
 #define BTRFS_INODE_NOATIME		(1U << 9)
 #define BTRFS_INODE_DIRSYNC		(1U << 10)
 #define BTRFS_INODE_COMPRESS		(1U << 11)
+#define BTRFS_INODE_ENCRYPT	(1U << 12)
 
 #define BTRFS_INODE_ROOT_ITEM_INIT	(1U << 31)
 
@@ -416,6 +419,7 @@ static inline __u8 btrfs_dir_flags_to_ftype(__u8 flags)
 	 BTRFS_INODE_NOATIME |						\
 	 BTRFS_INODE_DIRSYNC |						\
 	 BTRFS_INODE_COMPRESS |						\
+	 BTRFS_INODE_ENCRYPT |						\
 	 BTRFS_INODE_ROOT_ITEM_INIT)
 
 #define BTRFS_INODE_RO_VERITY		(1U << 0)
-- 
2.41.0

