Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20DA35B8B59
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Sep 2022 17:07:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229704AbiINPHN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 14 Sep 2022 11:07:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiINPHA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 14 Sep 2022 11:07:00 -0400
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2422E76970
        for <linux-btrfs@vger.kernel.org>; Wed, 14 Sep 2022 08:06:59 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id z9so482999qvn.9
        for <linux-btrfs@vger.kernel.org>; Wed, 14 Sep 2022 08:06:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date;
        bh=YJGd43YBCsJcN2dMM+DJC3daD+h0HkWsEG+Qle5OZJg=;
        b=uSgsDPvesF6iIMIVvaFlAAGe4AkGk2jxUHEOxx5xy8BxA7iW3n7w3TdLI6Nk6C1Nls
         9ZowDPjeH2tx7X7BmOiGOYKAMVgfQLsxyO8HsRwXYdEE5ibxTq59GG9ZF2jt+bq/dEt8
         Iv5G53QE/GhQUIZAtJyPoTruEBHc9Cg2CpgG8PWQ9G3ESlnJysEu7sbVFmc6hIByzUnV
         04+5Jo+ePZgF9B4qCuHyeaDSwlLJhLzVlr0LJvIu6/9KBueM6/HKkP7534W3igmNn4QU
         1uphQ+1eW8hO+CfTbPcpgURZFm6sqdb1QKLwDDNs8ZUrH5Aa6bk8iaJYiszxptdINQ+4
         fdOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=YJGd43YBCsJcN2dMM+DJC3daD+h0HkWsEG+Qle5OZJg=;
        b=34zigGPKZRUELr/U7oORSBYz3E5eD0AGMvggkt8y0JllCM7UTcbRrhGwxkJMBeNUma
         oHEQgT4KkXK7WtvkR58xWU+29k43SSi7hW+DtU7l2f/TLA3d2QuN8gVJUssWcZqw2m35
         bdxJIz2A9McZpHFwIhalu2utJDmKJMi2/GYciLVezfC3TUNJ+psd2h2gDTFO8UkX6xm6
         nAg61L9EpHaaCDcZzyLX8eANcmaapDJ6XD8griKVF3Yom6PvQsfQqZz3uFPl5DCgdNVg
         b+mCnU8STJCmvEvl+Dn38tfQdznMeyFpvDNmW7mVe8C0eKyNxpXcvt+3jOLoerLg2JlQ
         Buwg==
X-Gm-Message-State: ACgBeo0SkrVCPy4fWzX3u5G2G2oBtSdO3TFoC0vTpVNy3Ts1/8Ty2S5H
        HuQxFf5rgTRNtJkEIyqiyVbJwx++p+KRFQ==
X-Google-Smtp-Source: AA6agR5FR9dgNHNIa/Md/hl9JoTEvV5TccXPvblDTmp9X34OonS8JeMlpbA166HAh6i8OTh2StmMUA==
X-Received: by 2002:a05:6214:c29:b0:4aa:b050:5ed7 with SMTP id a9-20020a0562140c2900b004aab0505ed7mr31380519qvd.15.1663168017804;
        Wed, 14 Sep 2022 08:06:57 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id l11-20020ac8148b000000b0035a691cec8esm1602042qtj.29.2022.09.14.08.06.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Sep 2022 08:06:57 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 10/17] btrfs: move btrfs_should_fragment_free_space into block-group.c
Date:   Wed, 14 Sep 2022 11:06:34 -0400
Message-Id: <50ba0e87399977ef84a5d3787666fc6ce6c5cf3a.1663167823.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1663167823.git.josef@toxicpanda.com>
References: <cover.1663167823.git.josef@toxicpanda.com>
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

This function uses functions that are not defined in block-group.h, move
it into block-group.c in order to keep the header clean.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/block-group.c | 12 ++++++++++++
 fs/btrfs/block-group.h | 11 +----------
 2 files changed, 13 insertions(+), 10 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index c52b6e245b9a..c91f47a45b06 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -18,6 +18,18 @@
 #include "raid56.h"
 #include "zoned.h"
 
+#ifdef CONFIG_BTRFS_DEBUG
+int btrfs_should_fragment_free_space(struct btrfs_block_group *block_group)
+{
+	struct btrfs_fs_info *fs_info = block_group->fs_info;
+
+	return (btrfs_test_opt(fs_info, FRAGMENT_METADATA) &&
+		block_group->flags & BTRFS_BLOCK_GROUP_METADATA) ||
+	       (btrfs_test_opt(fs_info, FRAGMENT_DATA) &&
+		block_group->flags &  BTRFS_BLOCK_GROUP_DATA);
+}
+#endif
+
 /*
  * Return target flags in extended format or 0 if restripe for this chunk_type
  * is not in progress
diff --git a/fs/btrfs/block-group.h b/fs/btrfs/block-group.h
index 4d4d2e1f137b..e34cb80ffb25 100644
--- a/fs/btrfs/block-group.h
+++ b/fs/btrfs/block-group.h
@@ -242,16 +242,7 @@ static inline bool btrfs_is_block_group_data_only(
 }
 
 #ifdef CONFIG_BTRFS_DEBUG
-static inline int btrfs_should_fragment_free_space(
-		struct btrfs_block_group *block_group)
-{
-	struct btrfs_fs_info *fs_info = block_group->fs_info;
-
-	return (btrfs_test_opt(fs_info, FRAGMENT_METADATA) &&
-		block_group->flags & BTRFS_BLOCK_GROUP_METADATA) ||
-	       (btrfs_test_opt(fs_info, FRAGMENT_DATA) &&
-		block_group->flags &  BTRFS_BLOCK_GROUP_DATA);
-}
+int btrfs_should_fragment_free_space(struct btrfs_block_group *block_group);
 #endif
 
 struct btrfs_block_group *btrfs_lookup_first_block_group(
-- 
2.26.3

