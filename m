Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A0D960BB48
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Oct 2022 22:54:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232081AbiJXUyd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 24 Oct 2022 16:54:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235298AbiJXUxy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 24 Oct 2022 16:53:54 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A72C5164BC0
        for <linux-btrfs@vger.kernel.org>; Mon, 24 Oct 2022 12:00:23 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id b79so8516851iof.5
        for <linux-btrfs@vger.kernel.org>; Mon, 24 Oct 2022 12:00:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0zXRVoBX+n1xYOTRs4597KMebVGphLRv5r1qi0Lrc0M=;
        b=Ki0RPYK49DoXrWR/M7w5fOY4ewGns4lFPj+cAnJ5MDkMjvVgvivIZ5O64zhd7A4VPI
         9Y0bv+z5WAKBC4T75DXdjbvVFQJNy9dnlr1+ucVItVFKoXvYKvpbtIXZvETQI015VBYE
         WD8A0yDLqunJveqMdEcJ+XiVUniVSc27e7JWWuOvAPtiyIDsAgN6BYUegCK+ZClvHUV3
         84c5lwXATtAqki8yevu6eFnRzV36MKpuCcF6kI0uaTL/QAxZpWx3QbzRDSMHxkUlJ6c+
         +dk9pCotFumPrLCujdNIToUVCT5JadQ58UHw1mS6DR587p/jTyClUL+bMKGeatfOi2XM
         dLIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0zXRVoBX+n1xYOTRs4597KMebVGphLRv5r1qi0Lrc0M=;
        b=XxG1Cj4Na9VqnRArh4VFRipuPFGKVpJyE/IRcMhWZes04nnvled/jx/peemobFiqlM
         VCiskWrzsCcAHsQIliS799cnX8GNuxuBO+PHxJB+z7p45Vk2YKeZniOfN6V/RhUGtqyY
         +c9FCW/FJEHzRnJ4ttx0IMjjy41NQkQ48AfAJb5jnR7+rQvpubLSBQwdT8fRugQHUtdi
         q/LzVgERB3M0aGu1oLkV2VNKCcQtc0NHOqqSSfPdQl8hHnK3NE+2yyYySEjCN4hw3475
         VGllazhU+zN37QIeMlKEm5amalRbe4tHfqXJJ8gg7rswKcK888ghxKgFxooIyEpANsu0
         K0zg==
X-Gm-Message-State: ACrzQf3BviwtbfDx52xvucVPQSJRDaqNOkISS61xBe8q4gNkqZXRYZkc
        D4Gfo+lobcEk1gXC0tBb4dSZW0LONNiv5A==
X-Google-Smtp-Source: AMsMyM4LSuqSM8onRpY3SQpzuv5CqkPLdZRp0YtsVb2RFJSr8sEBpIRqjD5/5jJKT6plC7ZWqT+6aw==
X-Received: by 2002:ac8:580c:0:b0:39c:e5fe:63b9 with SMTP id g12-20020ac8580c000000b0039ce5fe63b9mr29103139qtg.314.1666637227487;
        Mon, 24 Oct 2022 11:47:07 -0700 (PDT)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id x29-20020ac84d5d000000b0039913d588fbsm339997qtv.48.2022.10.24.11.47.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Oct 2022 11:47:06 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 3/9] btrfs: minor whitespace in ctree.h
Date:   Mon, 24 Oct 2022 14:46:54 -0400
Message-Id: <20d239472ab08f41ee880f2c8091a5179b6c650d.1666637013.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1666637013.git.josef@toxicpanda.com>
References: <cover.1666637013.git.josef@toxicpanda.com>
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

We've accumulated some whitespace problems in ctree.h, clean these up.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/ctree.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index df60aa960ce0..805c36f1bc2d 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -426,10 +426,8 @@ struct btrfs_file_private {
 	void *filldir_buf;
 };
 
-
 static inline u32 BTRFS_LEAF_DATA_SIZE(const struct btrfs_fs_info *info)
 {
-
 	return info->nodesize - sizeof(struct btrfs_header);
 }
 
-- 
2.26.3

