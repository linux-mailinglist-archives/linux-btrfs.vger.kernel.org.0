Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D99C7859CA
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Aug 2023 15:51:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236312AbjHWNvw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 23 Aug 2023 09:51:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234877AbjHWNvw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 23 Aug 2023 09:51:52 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80BE319A
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Aug 2023 06:51:50 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-58d40c2debeso61766857b3.2
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Aug 2023 06:51:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20221208.gappssmtp.com; s=20221208; t=1692798709; x=1693403509;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fMEeV/ktXkiABS8UCZO8ADnW+e6o4cXxjPtsuMt8T9w=;
        b=oHEZ+/3FN51e9k+1d8gQGx60W4spyOGTmsBOWRCU3l0C1Ud160+5gJv5LS7UUNKHRj
         OGIIJ+IPauV7xRjjW2VkeSg+93HVVivJWscaUVPzjdck1i3eYkNv9pzHkkkzMBAqnJYB
         yCBuGQvyonrIf3+o3xzzVbG68PVS2vL9qRo1F1yg7/AxMJDYWt0x0iEjJJe20v8h7lG+
         sIQxVDhQhDeVjnEl/7mQUliTjTldMhRpacxi+xTUGpgB1v3IvSmP61Jr3XVOA6OoyjV3
         TU+MgFmZA0BZpHJ7H9Ga8ZzXTNX4ZNZjA0DZibzeu6rn6RiBE5ijCrDpRA8qP2Y/0bkh
         hIvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692798709; x=1693403509;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fMEeV/ktXkiABS8UCZO8ADnW+e6o4cXxjPtsuMt8T9w=;
        b=NtBWa8XtmsWG91n21+F1Jxo0uGgDhIwIKHyGQOyuxC27ig+rb4RxRD3C0uxHTq+vZa
         rOmLO5PoV51FizsRgHIEl7vS15dse49OhGYbrDSCUm2u6KiCB1PpZU3w4IdTWCb/IucK
         1+uEI6gacaqA/37ghL/M6RahUgs7ZPAv7+nkXATl3fye4FnE4OdD37fxgTUMyuXE12KJ
         PpQ3TptcN611402KzTHpQAnwL0LLlS1jC4I8ToyGLepAemteIEKjx5thaTdd/JF0noEL
         PNtjSMeMc1F9VEIZLWhdW1NKT/k81UaHwqlTn3ZTvUVUfSQpr661gqf/m+PLgZa0Nk1Y
         WW5A==
X-Gm-Message-State: AOJu0YxeXNbasGqoX3hMB7EZnoLdnpFFQ9JMoKsKk1ZbnZCkfpK68SUA
        I2DBbrPFpmFeBl/1+AWDwtNrSn+RyHBhEGfJskk=
X-Google-Smtp-Source: AGHT+IHsYx1OgKjLzDt19MYn/Lawe0xmjSldzChdKLCNKNNRATbZm8xHqtbFo+e+xoFOeYwPQI1Hlg==
X-Received: by 2002:a81:6ed6:0:b0:589:8b56:15f with SMTP id j205-20020a816ed6000000b005898b56015fmr13063587ywc.24.1692798709627;
        Wed, 23 Aug 2023 06:51:49 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id t123-20020a818381000000b0058e430889d5sm3365249ywf.10.2023.08.23.06.51.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 06:51:49 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 04/11] btrfs: move btrfs_name_hash to dir-item.h
Date:   Wed, 23 Aug 2023 09:51:30 -0400
Message-ID: <0739f7926fe01f0861a0f69da55f080fd7f464e4.1692798556.git.josef@toxicpanda.com>
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

