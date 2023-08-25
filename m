Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93852788FB8
	for <lists+linux-btrfs@lfdr.de>; Fri, 25 Aug 2023 22:20:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231132AbjHYUUK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 25 Aug 2023 16:20:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230395AbjHYUTn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 25 Aug 2023 16:19:43 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 637D4199E
        for <linux-btrfs@vger.kernel.org>; Fri, 25 Aug 2023 13:19:41 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id d75a77b69052e-4107e6fb0e8so7756311cf.3
        for <linux-btrfs@vger.kernel.org>; Fri, 25 Aug 2023 13:19:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20221208.gappssmtp.com; s=20221208; t=1692994780; x=1693599580;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gDWUkrG4DZaGLhaxDYtKpgkyNYU+vRB0+Q/6VSj1VwU=;
        b=rvyi480zBfpOzdMcrVgRAnt2rDXS+QEQOKb3keMCu44o8EiTTB9/mpQ+zycVOjFOn9
         6mIJHOj1SxjSfVwGeAkg/APYn4fPJuRxxFVGUyotb5px0zTUOZdI53A15T8EDp8misMt
         bw5JkQra4qeUAXOj4iT07EoaD/tQbFZvVTDIRqm/x75KxGI9BVcj9uvR3ZKDSUExJznq
         gKfyj8pyFfYjTB0yffo/byimIO+YYr4SHQfKl+9ZPPuEz5aB6NwmPRO1wFJRuNuMo8LO
         7HSJzeUgKlWn+V91wuvA3hM1hSo29gL2CBWYb9I5OmtxNJ4pLHHc/si6XawKrYVNYKga
         6vNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692994780; x=1693599580;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gDWUkrG4DZaGLhaxDYtKpgkyNYU+vRB0+Q/6VSj1VwU=;
        b=gf1zQ5zYVt12b7jgr+EPJfUdR18IQKupEa74X/gXGU2utZzjAwd7f2XgcnSFVyhx3K
         52wtjPN0FI3FipuatNggP3J0wyQYDcJ0GmSq0GsqrcThwNrNt0S2k/5m7gVKY4uYqs9L
         wTjyev/wxPZFZuect9XwdXbWMPMeGKGHTLJFB1q41bQgqfTej4Gr9nlPvNfzkvB4mt8C
         qJ4J9iWLsku4beQLyrGRqiriBfeWstwBUqKu69ckIYGopk0PByT04tqkL46xI7c4HI2G
         T/HkO7fTljPzKWQri61sWWIKdbYLM8cCEJwFNyqYYT1jEGU2eiew5LMpPSF4O7Gpv7jW
         v4KA==
X-Gm-Message-State: AOJu0YwrFNX4KAKJ47x3CGCt8MSk4i724P267iODqcWfmbGoPtx/YcZ4
        Ke6Klr19bm/Pk/3EAZZAT32HiLyMPx1HX7197wE=
X-Google-Smtp-Source: AGHT+IFfpujU1vtboQm7UAUqOzlNVGG/nL+ZM/Uj3xcrAYKyJTZDgwfQVFl44zyzSvLeN0+KPwrO6A==
X-Received: by 2002:a05:622a:1001:b0:410:af94:6838 with SMTP id d1-20020a05622a100100b00410af946838mr9548818qte.2.1692994780428;
        Fri, 25 Aug 2023 13:19:40 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id c11-20020ac84e0b000000b004108d49f391sm734250qtw.48.2023.08.25.13.19.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Aug 2023 13:19:40 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 03/12] btrfs: move btrfs_extref_hash into inode-item.h
Date:   Fri, 25 Aug 2023 16:19:21 -0400
Message-ID: <cbc6dcc234fc794de58b8786351b24f1bc5f4f9e.1692994620.git.josef@toxicpanda.com>
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

Ideally this would be un-inlined, but that is a cleanup for later.  For
now move this into inode-item.h, which is where the extref code lives.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/ctree.h      | 9 ---------
 fs/btrfs/inode-item.h | 9 +++++++++
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index bffee2ab5783..7b8e52fd6d99 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -475,15 +475,6 @@ static inline u64 btrfs_name_hash(const char *name, int len)
        return crc32c((u32)~1, name, len);
 }
 
-/*
- * Figure the key offset of an extended inode ref
- */
-static inline u64 btrfs_extref_hash(u64 parent_objectid, const char *name,
-                                   int len)
-{
-       return (u64) crc32c(parent_objectid, name, len);
-}
-
 static inline gfp_t btrfs_alloc_write_mask(struct address_space *mapping)
 {
 	return mapping_gfp_constraint(mapping, ~__GFP_FS);
diff --git a/fs/btrfs/inode-item.h b/fs/btrfs/inode-item.h
index ede43b6c6559..2ee425a08e63 100644
--- a/fs/btrfs/inode-item.h
+++ b/fs/btrfs/inode-item.h
@@ -107,4 +107,13 @@ struct btrfs_inode_extref *btrfs_find_name_in_ext_backref(
 		struct extent_buffer *leaf, int slot, u64 ref_objectid,
 		const struct fscrypt_str *name);
 
+/*
+ * Figure the key offset of an extended inode ref
+ */
+static inline u64 btrfs_extref_hash(u64 parent_objectid, const char *name,
+                                   int len)
+{
+       return (u64) crc32c(parent_objectid, name, len);
+}
+
 #endif
-- 
2.41.0

