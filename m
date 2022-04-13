Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D3304FFA5D
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Apr 2022 17:36:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235441AbiDMPjD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 13 Apr 2022 11:39:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231842AbiDMPjD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 13 Apr 2022 11:39:03 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5E8764713
        for <linux-btrfs@vger.kernel.org>; Wed, 13 Apr 2022 08:36:41 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id d10so2937800edj.0
        for <linux-btrfs@vger.kernel.org>; Wed, 13 Apr 2022 08:36:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=giaSEO4GbWIJdilGguCNBeXfJ9dwtuysAewBfgwwGjA=;
        b=dJhj33BTmuKAOic1C62vC/Sl9EBP8O8meL/NED0uShCkg1pZV27M5KrqOymDZJOAqE
         20iUTexAwYSjCz9LsZoR5OzLV2J07boMejat7LWypvXMxslvy2CcS9GCxavbh0Fqz29U
         Lex65cNABU9Ud85QLLpVQdxjz5aB7FHSbtfAQtE7xr9ARmYeL7s/Dc57ULy6IlUzMY1+
         hwBG1UUIOwSFtUHMJ8YIl6HVCC2uYhYvSdoUQufbueulxEYeCvtw8b9oBbPvOZkCbUFY
         zb/ryZlkaeS7PQiQ3NhEbFJF3RT5qgVK8JoFlkkmhRkjYWSBgZC0ho10Q8BNBgrWKYFr
         JBCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=giaSEO4GbWIJdilGguCNBeXfJ9dwtuysAewBfgwwGjA=;
        b=4hFaZhsb2VcU+MtVCfbgcX1a6te3tSYdpUoGz0Fx9q1J0G2cmrOQCtfKNel16k07Fd
         +0gH3X+vdoCGJQqp6fscY55erLcTmXSEMhXpRxdcuCY81kTbPUbS/spC3m52gCybg7Gs
         apgQs6ys1aCPZyt/o7/rVXYqCTXE+FC+VTeRfGIx1oJXS3O6obMaAUkjGx8qowSCiE5/
         Iz1PLBphMMrggpHJODbRymIWGRSM84GP+HkLv8Qg0dPkKbV7WgP+cX+7lP9KsW6sedRP
         O61djeUxNUgmPEQOvO8xOpuxFC0xLTLw2/q0dwgYgxb6X3Xs1s+8Tf8CQitC+QVZxzCW
         CPAw==
X-Gm-Message-State: AOAM531OJk8EzWl1HDcU+Tdhtva2MzRQ/yLn0oPhD/rfzMfDQKXmF8Dp
        ArSPXWZ9f0fx7hvykk3Yecbqi00c4z0bkHbG6VU=
X-Google-Smtp-Source: ABdhPJw8lq+2Gt7PmjpcKOd6pig/a6lndbblHJ9iI6C1yRqA8XjvK+MKOx6wjfcuZS5qIWO+fDUyhIy5OK1zWdy2z3s=
X-Received: by 2002:a50:fb0b:0:b0:41d:8cd4:659f with SMTP id
 d11-20020a50fb0b000000b0041d8cd4659fmr10501062edq.10.1649864200205; Wed, 13
 Apr 2022 08:36:40 -0700 (PDT)
MIME-Version: 1.0
References: <20220409043432.1244773-1-cccheng@synology.com> <CAL3q7H77p6yFhHMu-1kpgh+J5jv_dKeqqwga8mJMRXY6r0wAvg@mail.gmail.com>
In-Reply-To: <CAL3q7H77p6yFhHMu-1kpgh+J5jv_dKeqqwga8mJMRXY6r0wAvg@mail.gmail.com>
From:   Chung-Chiang Cheng <shepjeng@gmail.com>
Date:   Wed, 13 Apr 2022 23:36:29 +0800
Message-ID: <CAHuHWt=LB9WvAuEmQe9nM8ZQpUBz6LG4Asr6ss+f2C_G3LNW2w@mail.gmail.com>
Subject: Re: [PATCH] btrfs: do not allow compression on nocow files
To:     Filipe Manana <fdmanana@kernel.org>,
        David Sterba <dsterba@suse.com>
Cc:     Chung-Chiang Cheng <cccheng@synology.com>,
        Josef Bacik <josef@toxicpanda.com>, Chris Mason <clm@fb.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>, kernel@cccheng.net,
        Jayce Lin <jaycelin@synology.com>
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

> > +       if (!inode || BTRFS_I(inode)->flags & BTRFS_INODE_NODATACOW)
>
> How can inode ever be NULL?
> Unless I missed something, it can't be NULL.
>
> We should also get a test case for fstests, to help prevent
> regressions in the future.
>
> Otherwise it looks fine.

Thanks for your comments. I will send a v2 patch and a fstest item
later. And as David mentioned, inode_can_compress() can be reused to
reduce duplication.

Thanks.
