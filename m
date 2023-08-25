Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5096788FB6
	for <lists+linux-btrfs@lfdr.de>; Fri, 25 Aug 2023 22:20:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231130AbjHYUUK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 25 Aug 2023 16:20:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230382AbjHYUTk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 25 Aug 2023 16:19:40 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20BDB1736
        for <linux-btrfs@vger.kernel.org>; Fri, 25 Aug 2023 13:19:39 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id d75a77b69052e-4109c8ece5aso7899041cf.1
        for <linux-btrfs@vger.kernel.org>; Fri, 25 Aug 2023 13:19:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20221208.gappssmtp.com; s=20221208; t=1692994778; x=1693599578;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xEXFUFmf3inW/LN0OTx/vLWSMp4bAzU+io4MxvgVyuE=;
        b=ZY6AYuDpmtd1RXXfKTk7foBgKGaRyQrXGf3h/WA8S1BPL23UYscX7WKfcQchgLQ7ST
         tifgKHOWX5rhOs3NX3ysnEvJzaNwo5F4QgkXlLAt5JCWGCHSM8uek67l2hiQ7VGmpLTK
         8ehoDuzqTHSo48BCEQgA/RJSCp9VCsxHo93bz8RJOiyt2PP1hTQ3b72HdVaEZ+NVzvzs
         JDb2SBFka7Cta15NGGXJOLGxf7PZC5CHK3DcoLVUflTe+ZAGEQkgmtFpqdGSD/3Mqmig
         J3DPyjlCCPBLdAOL2BerSzV9dEu6nOWL1eWV1ouOn7GUAnu/8RZbx2tHrIpUq2MMek1Q
         gyeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692994778; x=1693599578;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xEXFUFmf3inW/LN0OTx/vLWSMp4bAzU+io4MxvgVyuE=;
        b=Z3+P2zd6Ljh5ZXXQ+mNifsTKVvw/GKYF9uncmcRTih10es+6A9ooOEfxuQn0qUbOKQ
         b2iXZntque5J6/5hmB2mNFw4X+DQ8hF93Ij7fvyXzUbETqapxeq2yRTiqAX4jP/sV1vq
         g7CiW1PnLkLK30pV/jrgCeMY0YwQyhnEYWRyrgRHmTEAQP7n1xL814yrtDvedQaXw3ue
         2piPDLxYItsIAngT6YbeND8+zsHNoKU9R569My+PQp+xAitfgE7Frbe3oqpZ54W1waGK
         VJ+9yHLhjYIEvIYcufb30jYLZfz3zwugjecY7kUuVz7mjmz3IIR1e8ZkFACBUhq9h5dN
         mecw==
X-Gm-Message-State: AOJu0YxVSOjzSWXnV4FdwPITPKaBMY53ikpAvMPq4edU/7eHI5actEyV
        dROxgQIFvXkfocqQsJn5gD9UIiQ7E5mOsjk/MVw=
X-Google-Smtp-Source: AGHT+IF8gSFrDa7vl2J5bMd1kMJ15NwfSjy4U+3Dq1di8uR/VhBvF7aUogosHoPqgFSmvt/qzXj8JA==
X-Received: by 2002:a05:622a:1046:b0:410:8fcb:e966 with SMTP id f6-20020a05622a104600b004108fcbe966mr21579736qte.32.1692994778148;
        Fri, 25 Aug 2023 13:19:38 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id bp37-20020a05622a1ba500b004100c132990sm738694qtb.44.2023.08.25.13.19.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Aug 2023 13:19:37 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 01/12] btrfs: move btrfs_crc32c_final into free-space-cache.c
Date:   Fri, 25 Aug 2023 16:19:19 -0400
Message-ID: <c86c72428b7356d2a983d6943818bd9c1c40e1fb.1692994620.git.josef@toxicpanda.com>
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

