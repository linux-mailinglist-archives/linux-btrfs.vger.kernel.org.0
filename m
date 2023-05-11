Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 809CF6FEC64
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 May 2023 09:09:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237123AbjEKHJp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 11 May 2023 03:09:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237221AbjEKHJa (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 11 May 2023 03:09:30 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E55B883DA
        for <linux-btrfs@vger.kernel.org>; Thu, 11 May 2023 00:09:26 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-3f315712406so272281225e9.0
        for <linux-btrfs@vger.kernel.org>; Thu, 11 May 2023 00:09:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683788965; x=1686380965;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ltm6Uq9UM+OESdkX9WPMa1q0k282KwGCL6b6LTBCfY4=;
        b=pTlxvVP3iybrMcqtUiNE2Q7awUWSFkbUZ2uXZyfLafK9py9ZDzzooelgfVqMyQKrr4
         z0m+BEzenByCog0BOSngU5ElTS2/Ni6U+yY7IaMEusMXApC2CHkPYT96GAFcZR+tN0Vl
         zCRBLE6TlQYwQ5m1AKGdZIpsSDDBz9sGfPKzFdAQ+aI8wieBiES+IdKBP6uIiZr+W/xx
         AvqSYLs5YqB7PLIk631dq+BVA3E4iMYL/zmK+EtAEfJW1NqBcz0G/kTJEJu2sWXvmePK
         CmhGi1E9kbMtzyAVIdexOJzul7jth+im0SYr0CGf0OOCUh6aMcSGIQkT48pyllMllWmb
         GkcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683788965; x=1686380965;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ltm6Uq9UM+OESdkX9WPMa1q0k282KwGCL6b6LTBCfY4=;
        b=iF7cXen3KJTwPLjAittpvaf1/xLrQDViBM7HNwOatMbPs7jeiPKrQGg4fe/YwctnLr
         3ztIIgG/N2pmg7t8fmZxyPIAMyqP9tQOd0FSSQY3Hhm6EfdiEFBLvbFLpTN+YbfGWLin
         Fddig/8Fug06Xb0IjLkZMfuf0PSu/Th94YwPxO4U1qDx2q0SSZvQ0Pft9iSOicsz0eHt
         2T555reIlzHrpyPhQfCCSVKfyZWeTAFlDH54kcXXCR8wUPrZqsWrmmmjIwkqu32L/y7h
         RCUga9myxNecVEpq1oowYCD7zQUKfmRl68ITHjl4P1qtdFo+zKDjZwiICwaZ3/zNXcN0
         rlxg==
X-Gm-Message-State: AC+VfDxjwrc8l4RVcPNskwkum97C83Jt0K681LcaqK2MiS7GG7KDZDC7
        mGSkS3MtQjdpOAvtiApwoE9KOgqD9iMHLrV0NnU=
X-Google-Smtp-Source: ACHHUZ5sAvIqg/o78I+ymrvO/p41PUp3x4xWy4kJmlw43+Lv4ZwSj6h/NksifXwEac8MSgPfEIMSfQ==
X-Received: by 2002:a5d:6144:0:b0:307:c6b2:4f0b with SMTP id y4-20020a5d6144000000b00307c6b24f0bmr897554wrt.29.1683788965341;
        Thu, 11 May 2023 00:09:25 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id q15-20020adff94f000000b003078b3e2845sm15242381wrr.31.2023.05.11.00.09.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 May 2023 00:09:22 -0700 (PDT)
Date:   Thu, 11 May 2023 10:09:14 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     wqu@suse.com
Cc:     linux-btrfs@vger.kernel.org
Subject: [bug report] btrfs: output affected files when relocation fails
Message-ID: <18dc983b-cd00-4846-b820-d71d5bf6b8a2@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello Qu Wenruo,

The patch 3093caaa4d16: "btrfs: output affected files when relocation
fails" from May 3, 2023, leads to the following Smatch static checker
warning:

	fs/btrfs/inode.c:283 print_data_reloc_error()
	error: uninitialized symbol 'ref_level'.

fs/btrfs/inode.c
    274         if (flags & BTRFS_EXTENT_FLAG_TREE_BLOCK) {
    275                 unsigned long ptr = 0;
    276                 u64 ref_root;
    277                 u8 ref_level;
    278 
    279                 do {
    280                         ret = tree_backref_for_extent(&ptr, eb, &found_key, ei,
    281                                                       item_size, &ref_root,
    282                                                       &ref_level);

It's weird that we don't check "ret" before printing an error.

Also ref_level is not initialized on the first return (error path) or
the second return 1 path.

--> 283                         btrfs_warn_rl(fs_info,
    284 "csum error at logical %llu mirror %u: metadata %s (level %d) in tree %llu",
    285                                 logical, mirror_num,
    286                                 (ref_level ? "node" : "leaf"),
                                         ^^^^^^^^^


    287                                 (ret < 0 ? -1 : ref_level),
    288                                 (ret < 0 ? -1 : ref_root));
    289                 } while (ret != 1);
    290                 btrfs_release_path(&path);
    291         } else {
    292                 struct btrfs_backref_walk_ctx ctx = { 0 };
    293                 struct data_reloc_warn reloc_warn = { 0 };
    294 

regards,
dan carpenter
