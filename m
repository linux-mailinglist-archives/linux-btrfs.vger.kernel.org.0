Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFD074EE554
	for <lists+linux-btrfs@lfdr.de>; Fri,  1 Apr 2022 02:25:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243517AbiDAA0p (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 31 Mar 2022 20:26:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243495AbiDAA0o (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 31 Mar 2022 20:26:44 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9157723FF00
        for <linux-btrfs@vger.kernel.org>; Thu, 31 Mar 2022 17:24:56 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id j13so1051620plj.8
        for <linux-btrfs@vger.kernel.org>; Thu, 31 Mar 2022 17:24:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=X8aP+vvO408qrIrZk64bMjoeSSZaQeVKT22UTG5G1hw=;
        b=O+wMHxOeeJjWDghJXr5sWCDzaWlpQ4QeISRnGzvN8toFtDcC2ziHBj7rM6AKNLZrty
         Vf20vfhp91TPPRf44K12cUQzpbzMa29ahC9wApXlydq8AY5pvFp7PVRa4euccJfNni49
         9qMk3y5zAmAcXxYB8F9r6TEWcBe4eSQZCpWcOTujwAEpBkwMYUoqeQO7bHFSP5m+a8li
         5wnTdtwgiLdjdOW8+QrCGab5ZyF3qoGso3wfWBTsDAiUYpVpEeiYb/y2YcQUknFDFUJf
         w2ZKpPAC80GcV+WW1dwaCwgCtSl8t+9WXWZsuYpAGvWFaz5VuY6DpmsbrVKsa9PL9/qh
         gOjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=X8aP+vvO408qrIrZk64bMjoeSSZaQeVKT22UTG5G1hw=;
        b=fl0pYqybM66zyzyBxpERhJC2kGGbts7WWkEy3uaQ3TVe5K822ERir40R6u3Jsqeve0
         rvmZ1NjyRmmHvTJLg3FX2y6Ij16ddv2XDbpfY0HQJXJWByebQXRHwGzoLcKC5fgAlpyd
         RgIYv3vv0L2jaDvt7M2c6VftXZZQjYN1BdHPHH3IEa03+g72ipgRAOPLko1OhL1ezlW4
         CatEiU01XEeMJsb4xhatbVQ14qRNs7CPjI1mR71aRYTsZidH97517wyq/GtpnzObcmca
         jhiEEDsEpdh7Ix2GMXLzUPr9YfqE6QZFETJBlWnYRl//WFBrzP/tv+wdnZDcsP+bdYtJ
         GP1g==
X-Gm-Message-State: AOAM53227tGVp98jOMRqF6Orj5q4wN0hoAb2vIzsANcDBYOOQnFF/o1e
        nEa50AnFI44egutsQwfiLN/wlDAZOxuCTEo0TRa5UDDySsM=
X-Google-Smtp-Source: ABdhPJyEaXzI2iHClwqsdcjjgC4T3/gyQk5NxmmuyV6XnD3Uw7S5YV2AP2/nNIqDEjdusWl4QlDHHgtc6MPQJZRPkDY=
X-Received: by 2002:a17:902:7b8c:b0:156:c33:53a2 with SMTP id
 w12-20020a1709027b8c00b001560c3353a2mr7520236pll.126.1648772696024; Thu, 31
 Mar 2022 17:24:56 -0700 (PDT)
MIME-Version: 1.0
References: <CAKxU2N-FKf-RsbA4S7hrYJXHUe7wJUrRyHGKjzKGgBmNcE1sCA@mail.gmail.com>
 <562b797f-49b6-80a0-4a1e-7dafa1975e86@gmx.com>
In-Reply-To: <562b797f-49b6-80a0-4a1e-7dafa1975e86@gmx.com>
From:   Rosen Penev <rosenp@gmail.com>
Date:   Thu, 31 Mar 2022 17:24:49 -0700
Message-ID: <CAKxU2N9bzKpt94i53vzKgYKaDEGZ7tAj_nE-KFm-71qK3yXDjw@mail.gmail.com>
Subject: Re: btrfs volume can't see files in folder
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Mar 31, 2022 at 4:40 PM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>
>
>
> On 2022/4/1 03:29, Rosen Penev wrote:
> > A specific folder has files in it. Directly accessing the path works
> > but ls in the directory returns empty.
> >
> > Any way to fix this issue? I believe it happened after a btrfs
> > replace(failed drive in RAID5) + btrfs balance.
>
> Btrfs check please.
btrfs check --force /dev/sda
Opening filesystem to check...
Checking filesystem on /dev/sda
UUID: bfa267c0-df2c-45a6-ad88-9d76b3844326
[1/7] checking root items
[2/7] checking extents
[3/7] checking free space cache
btrfs: space cache generation (1084391) does not match inode (1084389)
failed to load free space cache for block group 139616845824
btrfs: space cache generation (1084391) does not match inode (1084389)
failed to load free space cache for block group 146059296768
btrfs: space cache generation (1084391) does not match inode (1084389)
failed to load free space cache for block group 3183842689024
btrfs: space cache generation (1084391) does not match inode (1084389)
failed to load free space cache for block group 3184916430848
btrfs: space cache generation (1084391) does not match inode (1084389)
failed to load free space cache for block group 3185990172672
btrfs: space cache generation (1084391) does not match inode (1084389)
failed to load free space cache for block group 3187063914496
btrfs: space cache generation (1084391) does not match inode (1084389)
failed to load free space cache for block group 3190318694400
block group 4885757034496 has wrong amount of free space, free space
cache has 286720 block group has 290816
failed to load free space cache for block group 4885757034496
block group 4898641936384 has wrong amount of free space, free space
cache has 36864 block group has 53248
failed to load free space cache for block group 4898641936384
block group 4953402769408 has wrong amount of free space, free space
cache has 262144 block group has 274432
failed to load free space cache for block group 4953402769408
block group 5478462521344 has wrong amount of free space, free space
cache has 716800 block group has 729088
failed to load free space cache for block group 5478462521344
block group 5484904972288 has wrong amount of free space, free space
cache has 811008 block group has 819200
failed to load free space cache for block group 5484904972288
[4/7] checking fs roots

It's currently stuck on that last one.

>
> It looks like an DIR_ITEM/DIR_INDEX corruption.
>
> Thanks,
> Qu
