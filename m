Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A76A553985B
	for <lists+linux-btrfs@lfdr.de>; Tue, 31 May 2022 22:57:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242689AbiEaU5g (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 31 May 2022 16:57:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344273AbiEaU5a (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 31 May 2022 16:57:30 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC586255A5
        for <linux-btrfs@vger.kernel.org>; Tue, 31 May 2022 13:57:28 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id a15so10475380ilq.12
        for <linux-btrfs@vger.kernel.org>; Tue, 31 May 2022 13:57:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5+iQyY98NUiAltIYocTaxtV01GIQkuPofAenkk+OstI=;
        b=wpBE1GGnXxgNPxNrzkONglVxhwYwQ/mP/iBhZDF7euAC5cXGVI12nWiqbVZV+J7bzg
         JWWQmrB0iezMMOCo4gge9qvb+rUyeL6wSowIuYHSKefEX8R+WwJNYyXJYGkLOCKm9K4K
         9+ld7d+Fk0Zhw6OXU231o+dXnQGFUstmXVo+iTVpqtTlyCBv5jSjuweVFV0xOpq1sxXC
         LJ2ut9irg6JWxjUvWSSP7ZdeLocOk60K6VNmeEo6ft+vIQ4LGaZcHVIfhQN2agNpY/+T
         hE4Jz3K7IQ1/11Jpv/zm81PXuKhYxoS7Ht/kRUAe3eVYcuQ72L2lqzZSK+YkMUrNcLVb
         SpDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5+iQyY98NUiAltIYocTaxtV01GIQkuPofAenkk+OstI=;
        b=jJ5f2OzPewVZuJzCw8vaVprpiJ3PBF/gWPLscCxyXgB2LloxEmXjOAgqdw75DJE3K7
         lrMhzlFlRViXZgLuorD4fQqmMZHZGEHke7kgH2YTD2T9HV/qqF1zN4loprlals4kWxgS
         bDSrv8gcSFJrzzW11xo8FkLcZwlqa7dgsX48UJLMXmrASxvHREtAsa/RwJrePA5rEaJ3
         W7A36e0OhvWLUN/nL88i19ACj0riP1eWtzCsBf4MRu5Yfgdo+yH7h3t7FP5JLdnPh8Tw
         eF8vXbal/luOt4lciknXalf8rUSUcJ601c/RlSNNo0zYzZpQaWU5gikn/sqxWpJVi7Qf
         ZHSg==
X-Gm-Message-State: AOAM531cPvvg9dzblzR0W/3+qH74iquDvdoQSn5xWnhtLOcovGUwQ7fu
        JWPOovFAcs9317Zdv2Qwc12Ks+qRrbjimvMCxJW9wOnCRzE=
X-Google-Smtp-Source: ABdhPJxUTW2NZ9GehEJGF3Wp/P8TJZWSsU7JfTSJNhK7j8yrZ6F7pckxyOeusgSgCmsKySLaudIDuT6ZH0Cg6Z8pXbs=
X-Received: by 2002:a05:6e02:216a:b0:2d1:71a0:c2b8 with SMTP id
 s10-20020a056e02216a00b002d171a0c2b8mr31221950ilv.6.1654030648140; Tue, 31
 May 2022 13:57:28 -0700 (PDT)
MIME-Version: 1.0
References: <20220529180510.GG24951@merlins.org> <CAEzrpqfqD8jkznVQR1SL-YpF0ALx7Pbg+ptz7dVgRecOXeDtPg@mail.gmail.com>
 <20220529194235.GH24951@merlins.org> <CAEzrpqfd2jPWxUayfqyYRDN25-etc4_jgzcHmZ3LhGkb4e7Tsw@mail.gmail.com>
 <20220529200415.GI24951@merlins.org> <CAEzrpqdpvnbzaH1gxWnvWLMWEKtOAdYsH25mBWhkF-urf7Zw3g@mail.gmail.com>
 <20220530003701.GJ24951@merlins.org> <CAEzrpqcPirk3AOi1vy+N_V3VY49mvUCiwYL4A_0XoT_jxjgOrg@mail.gmail.com>
 <20220530191834.GK24951@merlins.org> <CAEzrpqdRV8nYFshj85Cahj4VMQ+F0n6WOQ6Y8g7=Kq7X_1xMgw@mail.gmail.com>
 <20220531011224.GA1745079@merlins.org>
In-Reply-To: <20220531011224.GA1745079@merlins.org>
From:   Josef Bacik <josef@toxicpanda.com>
Date:   Tue, 31 May 2022 16:57:17 -0400
Message-ID: <CAEzrpqco_RyUBK=dngrv54u8WE2uhSGrJaB9aRY5nUmKNzN32Q@mail.gmail.com>
Subject: Re: Rebuilding 24TB Raid5 array (was btrfs corruption: parent transid
 verify failed + open_ctree failed)
To:     Marc MERLIN <marc@merlins.org>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, May 30, 2022 at 9:12 PM Marc MERLIN <marc@merlins.org> wrote:
>
> On Mon, May 30, 2022 at 04:53:13PM -0400, Josef Bacik wrote:
> > On Mon, May 30, 2022 at 3:18 PM Marc MERLIN <marc@merlins.org> wrote:
> > >
> > > On Sun, May 29, 2022 at 09:14:23PM -0400, Josef Bacik wrote:
> > > > Ah ok that makes sense, fixed it, sorry about that.  Thanks,
> > >
> > > Same?
> >
> > Bah my bad, we fail earlier than I realized, should work now.  Thanks,
>
> gargamel:/var/local/src/btrfs-progs-josefbacik# ./btrfs rescue tree-recover /dev/mapper/dshelf1
> WARNING: cannot read chunk root, continue anyway
> none of our backups was sufficient, scanning for a root
> scanning, best has 0 found 1 bad
> ret is 0 offset 20971520 len 8388608
> ret is -2 offset 20971520 len 8388608
> checking block 22495232 generation 1572124 fs info generation 2582703
> trying bytenr 22495232 got 1 blocks 0 bad
> checking block 22462464 generation 1479229 fs info generation 2582703
> trying bytenr 22462464 got 1 blocks 0 bad
> checking block 22528000 generation 1572115 fs info generation 2582703
> trying bytenr 22528000 got 1 blocks 0 bad
> checking block 22446080 generation 1571791 fs info generation 2582703
> trying bytenr 22446080 got 1 blocks 0 bad
> checking block 22544384 generation 1556078 fs info generation 2582703
> trying bytenr 22544384 got 1 blocks 0 bad
> checking block 22511616 generation 1555799 fs info generation 2582703
> trying bytenr 22511616 got 1 blocks 0 bad
> checking block 22577152 generation 1586277 fs info generation 2582703
> trying bytenr 22577152 got 1 blocks 0 bad
> checking block 22478848 generation 1561557 fs info generation 2582703
> trying bytenr 22478848 got 1 blocks 0 bad
> checking block 22593536 generation 1590219 fs info generation 2582703
> trying bytenr 22593536 got 1 blocks 0 bad
> checking block 22609920 generation 1551635 fs info generation 2582703
> trying bytenr 22609920 got 1 blocks 0 bad
> checking block 22560768 generation 1590217 fs info generation 2582703
> trying bytenr 22560768 got 1 blocks 0 bad
> No mapping for 15645202989056-15645203005440
> Couldn't map the block 15645202989056
> Couldn't map the block 15645202989056
> No mapping for 15645202907136-15645202923520
> Couldn't map the block 15645202907136
> Couldn't map the block 15645202907136
> No mapping for 15645202989056-15645203005440
> Couldn't map the block 15645202989056
> Couldn't map the block 15645202989056
> No mapping for 15645202989056-15645203005440
> Couldn't map the block 15645202989056
> Couldn't map the block 15645202989056
> No mapping for 15645202907136-15645202923520
> Couldn't map the block 15645202907136
> Couldn't map the block 15645202907136
> none of our backups was sufficient, scanning for a root
> scanning, best has 0 found 1 bad
> ERROR: Couldn't find a valid root block for 1, we're going to clear it and hope for the best
> Tree recover failed

I hate myself so much.  It looks like it recovered the chunk tree, so
you should be able to run

btrfs rescue recover-chunks <device>

to see if it can find the mapping's we're missing.  If it does then
I'll wire up the code to insert them, and then we can go about finding
the other roots and getting this thing fixed.  Thanks,

Josef
