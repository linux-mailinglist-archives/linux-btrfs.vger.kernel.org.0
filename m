Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 937B5785ABC
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Aug 2023 16:33:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236540AbjHWOd5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 23 Aug 2023 10:33:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236530AbjHWOdz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 23 Aug 2023 10:33:55 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 798F1E69
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Aug 2023 07:33:53 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-58fb8963617so45853407b3.3
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Aug 2023 07:33:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20221208.gappssmtp.com; s=20221208; t=1692801232; x=1693406032;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+6V3il9/GDZstvmbz60811i4zmplZ2RotmVA2GKZD/Y=;
        b=bLaEIVHnL1oiPZA073MeQp8Lk1tTXDfxcN6xWB/mvIPdcPyXAbic/vxNqdeRkEkTQ6
         FDdgxKUn2n15Ce6E0fy+V8egeUAiBsqnxRQh+vU0yYU5QmrFUhpXLo1gPmMT0b0lh1uy
         Q4K0jPNhkZu0MUX7wjC79M0BcIxry23qoADy0juTjR8YsptjNbnY5LxMkdCpmsY2+l5i
         qWJtNX2n1cer+YSJQKvZWOT9xZvdFg9x+T5FhU6/UWo18DhthIx5OOerBhjsatfSqLPH
         5zoUGOYgGvJIQei0QiGJIg10KyqJG/4BlI2YN3fNMDQGrJxkU2d/i9LiKWfkdAc3yYLs
         3PDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692801232; x=1693406032;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+6V3il9/GDZstvmbz60811i4zmplZ2RotmVA2GKZD/Y=;
        b=JOnhyD+KnzkN6Y8XRsz+PhhNHHx3r7M1PNOHa/LV3CnFJsHczC9guZviC5M5oVB6SS
         vpqoJhb7F6GcHgTxWrOnJQ8qglNJS5Chknj+9F/X/3pZTk7rzWRQJQgQuqx8BE/kMHnz
         /tu1x0+nu+Q2Yr8Rf9JlaVzgXAdrVzl7tJmCBpyQs7rmTcC/YpRC6CqEOjYN7pV2SZUx
         r+dmJEq38slCvgtniI9I8Askv5kdINYmBvPMHV823fvFl851IutjODR8jfQg0EaVZWR7
         CMtzlaPK3Oqc6JXBh/6oGYY3csguEOEr4F/rOjrzoqDBy9Zei44Fdq2lI7lJqwTFCrtN
         qM/g==
X-Gm-Message-State: AOJu0Yw2MwKos0G1vTJd31r1lwh1LfkAqqXAX2b3BimD8qbproJFi3L3
        D9wFKoVb2fSr8qr/Zf2MjV/hBXBnU26lyjFfoew=
X-Google-Smtp-Source: AGHT+IEhEw0tApMAbRepQ/vm95wuKxvA/9HBjXl/WgqKN0MiwfQjKFMUMVzq1qteMVl/FPyTYwIlmQ==
X-Received: by 2002:a0d:f243:0:b0:56d:3b91:7e78 with SMTP id b64-20020a0df243000000b0056d3b917e78mr13757346ywf.20.1692801232634;
        Wed, 23 Aug 2023 07:33:52 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id z128-20020a818986000000b00583cf4ed41esm3347616ywf.2.2023.08.23.07.33.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 07:33:52 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 37/38] btrfs-progs: update btrfs_split_item to match the in-kernel definition
Date:   Wed, 23 Aug 2023 10:33:03 -0400
Message-ID: <6da1aebd175ed8c37ac9d9f6cff58b37a37b7865.1692800904.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1692800904.git.josef@toxicpanda.com>
References: <cover.1692800904.git.josef@toxicpanda.com>
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

In the kernel new_key is const, update the definition in btrfs-progs to
match the in-kernel definition.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 kernel-shared/ctree.c | 2 +-
 kernel-shared/ctree.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel-shared/ctree.c b/kernel-shared/ctree.c
index 0bfebdc2..866a748f 100644
--- a/kernel-shared/ctree.c
+++ b/kernel-shared/ctree.c
@@ -2322,7 +2322,7 @@ again:
 int btrfs_split_item(struct btrfs_trans_handle *trans,
 		     struct btrfs_root *root,
 		     struct btrfs_path *path,
-		     struct btrfs_key *new_key,
+		     const struct btrfs_key *new_key,
 		     unsigned long split_offset)
 {
 	u32 item_size;
diff --git a/kernel-shared/ctree.h b/kernel-shared/ctree.h
index 7ffef9fa..fbdf3aef 100644
--- a/kernel-shared/ctree.h
+++ b/kernel-shared/ctree.h
@@ -980,7 +980,7 @@ void btrfs_truncate_item(struct btrfs_path *path, u32 new_size, int from_end);
 int btrfs_split_item(struct btrfs_trans_handle *trans,
 		     struct btrfs_root *root,
 		     struct btrfs_path *path,
-		     struct btrfs_key *new_key,
+		     const struct btrfs_key *new_key,
 		     unsigned long split_offset);
 int btrfs_search_slot(struct btrfs_trans_handle *trans,
 		struct btrfs_root *root, const struct btrfs_key *key,
-- 
2.41.0

