Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47A787859C6
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Aug 2023 15:51:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236302AbjHWNvt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 23 Aug 2023 09:51:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236308AbjHWNvs (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 23 Aug 2023 09:51:48 -0400
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE767CFE
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Aug 2023 06:51:46 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-58fa51a0d97so48836497b3.3
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Aug 2023 06:51:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20221208.gappssmtp.com; s=20221208; t=1692798706; x=1693403506;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xEXFUFmf3inW/LN0OTx/vLWSMp4bAzU+io4MxvgVyuE=;
        b=yZRa1VExldTyg8Z3mUGmajHa0NzgI2RmO7/mSgUrK82FpwdfmaRWj3/4y1aDe7D9+Y
         5H/sxOjIAlurKUz2onVyRVSaW2xtP8/VesChRYvLg65zTPerT58YF/HqHTOHWPf0hvjE
         g1NHGG17KsCCiXmpAJx9cKJkzYcKH9jDOaJSJ5e5Sz4ksIftKunRdErNMum6NmwqjwUd
         8lHFFunl3XUPWn4av/kL3822N5yh9HKFB1EAkrEbyoOgGLRIfJlxNvv5OWFTa2XfA11w
         xkRcQle/bq2rZFfSZ8Fkt+oXoHNo011gt2q6W+TH1grC+8Y7Iyi3HCi35M/2NEGQ8goq
         p6OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692798706; x=1693403506;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xEXFUFmf3inW/LN0OTx/vLWSMp4bAzU+io4MxvgVyuE=;
        b=Z6KBwD5fcSB6uQER5NK5pXKLQbVVdqcAGAcwlYfKqWRHco9+QScHs4L7KuVadsy5Dt
         D9qntLZFsxj0UHeLdrwg0nFvp1CDCj7T+oJSNQa/sjJBhcB056erPo8FGwCfyqWFzgW5
         eBE9YKtI/N7vEjtWvlPgZyht8heKI74QSUFa9SbiX5utnVQeI7xVcjTCI53MOejkhNao
         UdLsjBqf3FT22oWNvyqxkVaFuWY+WvB+05QJHr5ZFPvK9Kkc3sIzWkCVe970OmV/trYS
         p0wGV/2XephEpnUtUEUd0UNAZuZ50hMXYKkSqdyusisukANsUGl5KxdHs+AgLBZykJ8x
         VlOA==
X-Gm-Message-State: AOJu0YwJDQoDGAGrbqZrWfvSA/wo8vnEFT3BLpUPgCH9ljXB+LrFgCEA
        600ptGjI2b7qcro8CiRBaB4o5EISoX/rT3drXfY=
X-Google-Smtp-Source: AGHT+IHe22YdhvwYZIkGI8Y57uT5nSnz4FTvXF4pifOLgr2mKEtEOkh+FV6JnxikH+jM5paRGOg/Kg==
X-Received: by 2002:a81:4e12:0:b0:586:a627:da2d with SMTP id c18-20020a814e12000000b00586a627da2dmr13065665ywb.9.1692798705918;
        Wed, 23 Aug 2023 06:51:45 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id l68-20020a0dc947000000b005772fc5912dsm3328063ywd.91.2023.08.23.06.51.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 06:51:45 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 01/11] btrfs: move btrfs_crc32c_final into free-space-cache.c
Date:   Wed, 23 Aug 2023 09:51:27 -0400
Message-ID: <c86c72428b7356d2a983d6943818bd9c1c40e1fb.1692798556.git.josef@toxicpanda.com>
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

This is the only place this helper is used, take it out of ctree.h and
move it into free-space-cache.c.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/ctree.h            | 5 -----
 fs/btrfs/free-space-cache.c | 5 +++++
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 9419f4e37a58..c80d9879d931 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -475,11 +475,6 @@ static inline u32 btrfs_crc32c(u32 crc, const void *address, unsigned length)
 	return crc32c(crc, address, length);
 }
 
-static inline void btrfs_crc32c_final(u32 crc, u8 *result)
-{
-	put_unaligned_le32(~crc, result);
-}
-
 static inline u64 btrfs_name_hash(const char *name, int len)
 {
        return crc32c((u32)~1, name, len);
diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index 27fad70451aa..759b92db35d7 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -57,6 +57,11 @@ static void bitmap_clear_bits(struct btrfs_free_space_ctl *ctl,
 			      struct btrfs_free_space *info, u64 offset,
 			      u64 bytes, bool update_stats);
 
+static inline void btrfs_crc32c_final(u32 crc, u8 *result)
+{
+	put_unaligned_le32(~crc, result);
+}
+
 static void __btrfs_remove_free_space_cache(struct btrfs_free_space_ctl *ctl)
 {
 	struct btrfs_free_space *info;
-- 
2.41.0

