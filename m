Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C64786F2639
	for <lists+linux-btrfs@lfdr.de>; Sat, 29 Apr 2023 22:08:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbjD2UHy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 29 Apr 2023 16:07:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230339AbjD2UHt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 29 Apr 2023 16:07:49 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 194F32D4A
        for <linux-btrfs@vger.kernel.org>; Sat, 29 Apr 2023 13:07:44 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-54fae5e9ec7so16365147b3.1
        for <linux-btrfs@vger.kernel.org>; Sat, 29 Apr 2023 13:07:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20221208.gappssmtp.com; s=20221208; t=1682798863; x=1685390863;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KSVauplUhZYm8oUuM5vJbwvjgaLq98k2j6wOoRptDDc=;
        b=XsMAzZpoNBt9cs4zLIpuH1QPAN1x1/3y6+ZKi3h5MEv7j50vyhMdcMGkL14obSNK3y
         jNWbRBaeLfL2PSFkEdbwu5WWUUdRWblSqZTyIyKEYFPbdeHWz9zedRK7BrAoz8FCSdZE
         uUXB6VG7ksySMrvO1iSBSZ2vQUsMuXy0fVZDER1XH7rDJyhFMglG32Baash8JoCPHpjQ
         DcjTGh5zVqdyb4qp4g89eRDocHsety5OTl60N+PzZWXiELntSACUg1rcSfEO79Ff4tAc
         ze5g71e3zMCxNFWkYtnosFAGoAlHMezi5dR5ibdKQXrS//dvL7oJoJ9iaMui9jSsjOF8
         wNxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682798863; x=1685390863;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KSVauplUhZYm8oUuM5vJbwvjgaLq98k2j6wOoRptDDc=;
        b=Hwn3wDMZu92fnsZuxUSWkyVAsfendb/YFqALzbM9FowDCB97iFOAeSqxFO1b7f2q+m
         DwTDVqxmE7/9dwqZA0BcS463nTTriB3hGrjKd4slijIF8qDXUztZs4fBXWasJAyuDL2t
         dxjB5KB8hxTwDKY9+v1Q74pj8kv2QdLUrKxP3aO1zA0cA45Gy0oIVi4xdU0BiVmzHffB
         782AhKuBKaoE72PGigv7NgJDQf4MPQ2pTgFBHFjCFu8cTnbsb3nWeoVcQQCUC4m1l7+F
         CU8B8ekT4ci5HP7Ty58coeUPaBIamDccupFF23TB39wvjn3ohAYzCgUt9Jtisvwselew
         95aQ==
X-Gm-Message-State: AC+VfDz0hHnZoJD6UWno+LAmMEs+EqYKnABC9iL/6AgYtFeHnMGK2BAM
        uIKz5f6v+2q2OPOP6VIYdrPpJ308yO7Q3ADPAso8Tw==
X-Google-Smtp-Source: ACHHUZ6vq/YvhHLybG9aeTKWntcjaCG5GINKZLgJzYmiLHZfT+I/OgzU0PT1zUKeH7bN1rr3IXSudQ==
X-Received: by 2002:a81:75d4:0:b0:55a:10e9:2ce6 with SMTP id q203-20020a8175d4000000b0055a10e92ce6mr439369ywc.50.1682798862728;
        Sat, 29 Apr 2023 13:07:42 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id f5-20020a0dc305000000b00545c373f7c0sm6307857ywd.139.2023.04.29.13.07.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Apr 2023 13:07:42 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 11/12] btrfs: add a btrfs_csum_type_size helper
Date:   Sat, 29 Apr 2023 16:07:20 -0400
Message-Id: <2627fbc83e4c07215bf831d6625b193d6491a750.1682798736.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <cover.1682798736.git.josef@toxicpanda.com>
References: <cover.1682798736.git.josef@toxicpanda.com>
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

This is needed in btrfs-progs for the tools that convert the checksum
types for file systems and a few other things.  We don't have it in the
kernel as we just want to get the size for the super blocks type.
However I don't want to have to manually add this every time we sync
ctree.c into btrfs-progs, so add the helper in the kernel with a note so
it doesn't get removed by a later cleanup.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/ctree.c | 8 +++++++-
 fs/btrfs/ctree.h | 1 +
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index 7071f90c23e3..c95c62baef3e 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -150,13 +150,19 @@ static inline void copy_leaf_items(const struct extent_buffer *dst,
 			      nr_items * sizeof(struct btrfs_item));
 }
 
+/* This exists for btrfs-progs usages. */
+u16 btrfs_csum_type_size(u16 type)
+{
+	return btrfs_csums[type].size;
+}
+
 int btrfs_super_csum_size(const struct btrfs_super_block *s)
 {
 	u16 t = btrfs_super_csum_type(s);
 	/*
 	 * csum type is validated at mount time
 	 */
-	return btrfs_csums[t].size;
+	return btrfs_csum_type_size(t);
 }
 
 const char *btrfs_super_csum_name(u16 csum_type)
diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 4c1986cd5bed..221e230787e3 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -702,6 +702,7 @@ static inline bool btrfs_is_data_reloc_root(const struct btrfs_root *root)
 	return root->root_key.objectid == BTRFS_DATA_RELOC_TREE_OBJECTID;
 }
 
+u16 btrfs_csum_type_size(u16 type);
 int btrfs_super_csum_size(const struct btrfs_super_block *s);
 const char *btrfs_super_csum_name(u16 csum_type);
 const char *btrfs_super_csum_driver(u16 csum_type);
-- 
2.40.0

