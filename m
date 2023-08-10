Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BF8A777835
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Aug 2023 14:24:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233729AbjHJMYD convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Thu, 10 Aug 2023 08:24:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230240AbjHJMYC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 10 Aug 2023 08:24:02 -0400
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CE88211F
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Aug 2023 05:24:01 -0700 (PDT)
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-51bece5d935so1080626a12.1
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Aug 2023 05:24:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691670239; x=1692275039;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8m3MmDmKHBwNJi0AfRsBTHvaaYqZKByh2kTZ2strhaE=;
        b=HhUwovGGWww3RMwIlqpb+3J0+CkmwPyawxEJ4+UASECACI6wTqBDj1/Yqgmn6rmWJB
         L4P13UVzDGCpuBbLr+ICNzRoRP+MaXPdRmGzcmdqYd8HHwrsg4byrH6nepFKWnjxwnTu
         /g7aaRmt8qcFAVAt+oqpMkhLMaK5ULsfgX4jgyuu/eE6iyq4wVHpUG42ZdPbJy5Bv+51
         0wC+6kAZv8LTJrxTJCu3ovv279tdR0XO1feo054tHkDl1q6WkpXYrOE+BDiwm4Ahg+2p
         UU1Ei8fV5YYv1Cpga+bC3Y22cyZaawy5LgTLFkxOHQOpA9QsT/ZBflxwB2L26hMGJMpI
         ErJg==
X-Gm-Message-State: AOJu0YyMag5CSTp3Yvf6rdUbWr8a/RavO94lGeTqn2/dth4SxDlWhysM
        zsDZzwdi6H9a53n+CJ6ALyH4KYSC8uVyQQ==
X-Google-Smtp-Source: AGHT+IGYTQytG/Wi4na2GKEJFlIIEgwvwarjUPmPq7LDRBl1kLew/ZVElgpwRkaUK/6SIlzqtQ0JZg==
X-Received: by 2002:a05:6402:14c4:b0:522:2f8c:8953 with SMTP id f4-20020a05640214c400b005222f8c8953mr1753378edx.39.1691670239656;
        Thu, 10 Aug 2023 05:23:59 -0700 (PDT)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com. [209.85.208.54])
        by smtp.gmail.com with ESMTPSA id n19-20020aa7c453000000b0052328d4268asm733725edr.81.2023.08.10.05.23.59
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Aug 2023 05:23:59 -0700 (PDT)
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5231f439968so1090764a12.0
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Aug 2023 05:23:59 -0700 (PDT)
X-Received: by 2002:a17:906:20d5:b0:99b:ebf9:90f2 with SMTP id
 c21-20020a17090620d500b0099bebf990f2mr2107399ejc.45.1691670238908; Thu, 10
 Aug 2023 05:23:58 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1691520000.git.sweettea-kernel@dorminy.me>
In-Reply-To: <cover.1691520000.git.sweettea-kernel@dorminy.me>
From:   Neal Gompa <neal@gompa.dev>
Date:   Thu, 10 Aug 2023 08:23:22 -0400
X-Gmail-Original-Message-ID: <CAEg-Je-Ha4yMi83Aq+wUA_G-wZKXAeuEFuike2cqS=y8MbMHrw@mail.gmail.com>
Message-ID: <CAEg-Je-Ha4yMi83Aq+wUA_G-wZKXAeuEFuike2cqS=y8MbMHrw@mail.gmail.com>
Subject: Re: [PATCH v2 0/8] btrfs-progs: add encryption support
To:     Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Cc:     linux-btrfs@vger.kernel.org, ebiggers@google.com,
        kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Aug 8, 2023 at 2:42 PM Sweet Tea Dorminy
<sweettea-kernel@dorminy.me> wrote:
>
> This is the progs side of the encryption feature [1]. The first four
> changes are attempts to replicate the relevant kernel changes precisely
> to the equivalents in kernel-shared; the next four add support to check
> and dump-tree.
>
> [1] https://lore.kernel.org/linux-btrfs/cover.1691510179.git.sweettea-kernel@dorminy.me/
>
> Changelog:
> v2:
> - updated to match new extent context format
>
> v1:
> - https://lore.kernel.org/linux-btrfs/cover.1688068420.git.sweettea-kernel@dorminy.me/
>
> Sweet Tea Dorminy (8):
>   btrfs-progs: add new FEATURE_INCOMPAT_ENCRYPT flag
>   btrfs-progs: start tracking extent encryption context info
>   btrfs-progs: add inode encryption contexts
>   btrfs-progs: save and load fscrypt extent contexts
>   btrfs-progs: interpret encrypted file extents.
>   btrfs-progs: handle fscrypt context items
>   btrfs-progs: escape unprintable characters in names
>   btrfs-progs: check: update inline extent length checking
>
>  check/main.c                    | 29 ++++++++-------
>  kernel-shared/accessors.h       |  2 ++
>  kernel-shared/ctree.h           |  3 +-
>  kernel-shared/fscrypt.h         | 25 +++++++++++++
>  kernel-shared/print-tree.c      | 64 +++++++++++++++++++++++++++++++--
>  kernel-shared/tree-checker.c    | 37 ++++++++++++++-----
>  kernel-shared/uapi/btrfs.h      |  1 +
>  kernel-shared/uapi/btrfs_tree.h | 16 ++++++++-
>  8 files changed, 151 insertions(+), 26 deletions(-)
>  create mode 100644 kernel-shared/fscrypt.h
>
>
> base-commit: 9a7c1226664ab3145f7382ffeae80770bd2d8d3a
> --
> 2.41.0
>

This patch set series looks reasonable to me.

Reviewed-by: Neal Gompa <neal@gompa.dev>


-- 
真実はいつも一つ！/ Always, there's only one truth!
