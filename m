Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85CB9788FBB
	for <lists+linux-btrfs@lfdr.de>; Fri, 25 Aug 2023 22:20:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231137AbjHYUUL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 25 Aug 2023 16:20:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230427AbjHYUTo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 25 Aug 2023 16:19:44 -0400
Received: from mail-vs1-xe34.google.com (mail-vs1-xe34.google.com [IPv6:2607:f8b0:4864:20::e34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A548D171A
        for <linux-btrfs@vger.kernel.org>; Fri, 25 Aug 2023 13:19:42 -0700 (PDT)
Received: by mail-vs1-xe34.google.com with SMTP id ada2fe7eead31-44d38d91885so612367137.1
        for <linux-btrfs@vger.kernel.org>; Fri, 25 Aug 2023 13:19:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20221208.gappssmtp.com; s=20221208; t=1692994781; x=1693599581;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fMEeV/ktXkiABS8UCZO8ADnW+e6o4cXxjPtsuMt8T9w=;
        b=XZgkPpmjZfAqodNBWMinx9/VklwYLiurpotkHGvqKMLl60TK9ulYZ3WrxCYZT+bAFJ
         goaKxqVwAnVmK8Gh29le2F9P4GBTxMT8nLuMQIRp+auXGEjIMQSyD9YRE5MnhTf0T9RA
         bRlgc+SMZKPcZGdydBc017frWJ05+DdqZ+i7XEoav/JIBNhsOAINhAk/lo948UMklVLd
         cZrN/nMV/pJoIL9/wBmpuYzpkKSfFnCmcOTm6CSCWkJSii7ydhY5vIBpNqh3nvXY4EDB
         BLNTcHFU1itwWf1XFtTNGEmY9U1rvTKROkTgOS703qbnoBfjj3laO/s06EL8o6QyDCN+
         1pFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692994781; x=1693599581;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fMEeV/ktXkiABS8UCZO8ADnW+e6o4cXxjPtsuMt8T9w=;
        b=K4zfmmSSTk2WYWFsA41P3lJrGhMmhnVWQ0tdmwRJIXKhacYnk0SnFu/1FQA2Zlb/Ea
         NWaXJiO0X0wmZLdb1DEATywIGX0bOg/G7Z4gMiuoSS9aaq9a2yC5O/rd0CN7vHhRNSYb
         KMKlD0afGBYLt1ZUx1IuDbCNNW1ODeXcDVZjQ9c29HQlSIE5XzgMzs2fxMTwz4tqw8TJ
         1M6DqHk/oJXBqCuoIAohXiAldSmB+MANfjcdBkNdz1C65Ka93/7O5zSslincp2VSwPCv
         E9gof6blfFRHtX89TBqpd6B9ny4lv8ZSLOPa/wh/7PtTjaiqPAQ8rmqqVkjyLIO4ljrA
         NBBQ==
X-Gm-Message-State: AOJu0YzTU2ENIo/SoWSUt1atPKGX8NwCcw3dQ3uxuUxgFCGbaUWH4YKl
        eWsYLECcgVqiXqGTQkXYPsLsHbT8bpFa5g+GePo=
X-Google-Smtp-Source: AGHT+IGK/DBacyXeoPVRsEyJEvjYN3desmWGvlCJGUtqB/YvCcD0EIWKPoNto8OPRLVe8mfgg562Vg==
X-Received: by 2002:a05:6102:22d9:b0:44e:afcb:ef96 with SMTP id a25-20020a05610222d900b0044eafcbef96mr1563758vsh.13.1692994781673;
        Fri, 25 Aug 2023 13:19:41 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id m24-20020ae9e718000000b0076d4bb714afsm738648qka.50.2023.08.25.13.19.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Aug 2023 13:19:41 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 04/12] btrfs: move btrfs_name_hash to dir-item.h
Date:   Fri, 25 Aug 2023 16:19:22 -0400
Message-ID: <0739f7926fe01f0861a0f69da55f080fd7f464e4.1692994620.git.josef@toxicpanda.com>
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

This is related to the name hashing for dir items, move it into
dir-item.h.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/ctree.h        | 5 -----
 fs/btrfs/dir-item.h     | 5 +++++
 fs/btrfs/props.c        | 1 +
 fs/btrfs/tree-checker.c | 1 +
 4 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 7b8e52fd6d99..9c2e96b8711f 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -470,11 +470,6 @@ static inline u32 BTRFS_MAX_XATTR_SIZE(const struct btrfs_fs_info *info)
 #define BTRFS_BYTES_TO_BLKS(fs_info, bytes) \
 				((bytes) >> (fs_info)->sectorsize_bits)
 
-static inline u64 btrfs_name_hash(const char *name, int len)
-{
-       return crc32c((u32)~1, name, len);
-}
-
 static inline gfp_t btrfs_alloc_write_mask(struct address_space *mapping)
 {
 	return mapping_gfp_constraint(mapping, ~__GFP_FS);
diff --git a/fs/btrfs/dir-item.h b/fs/btrfs/dir-item.h
index aab4b7cc7fa0..951b4dda46fe 100644
--- a/fs/btrfs/dir-item.h
+++ b/fs/btrfs/dir-item.h
@@ -39,4 +39,9 @@ struct btrfs_dir_item *btrfs_match_dir_item_name(struct btrfs_fs_info *fs_info,
 						 const char *name,
 						 int name_len);
 
+static inline u64 btrfs_name_hash(const char *name, int len)
+{
+       return crc32c((u32)~1, name, len);
+}
+
 #endif
diff --git a/fs/btrfs/props.c b/fs/btrfs/props.c
index 0755af0e53e3..f9bf591a0718 100644
--- a/fs/btrfs/props.c
+++ b/fs/btrfs/props.c
@@ -15,6 +15,7 @@
 #include "fs.h"
 #include "accessors.h"
 #include "super.h"
+#include "dir-item.h"
 
 #define BTRFS_PROP_HANDLERS_HT_BITS 8
 static DEFINE_HASHTABLE(prop_handlers_ht, BTRFS_PROP_HANDLERS_HT_BITS);
diff --git a/fs/btrfs/tree-checker.c b/fs/btrfs/tree-checker.c
index ab08a0b01311..8ad92aa43924 100644
--- a/fs/btrfs/tree-checker.c
+++ b/fs/btrfs/tree-checker.c
@@ -29,6 +29,7 @@
 #include "accessors.h"
 #include "file-item.h"
 #include "inode-item.h"
+#include "dir-item.h"
 
 /*
  * Error message should follow the following format:
-- 
2.41.0

