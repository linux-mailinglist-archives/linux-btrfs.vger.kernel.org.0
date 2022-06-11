Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 300BB5475DA
	for <lists+linux-btrfs@lfdr.de>; Sat, 11 Jun 2022 16:59:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234101AbiFKO7f (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 11 Jun 2022 10:59:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236853AbiFKO7c (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 11 Jun 2022 10:59:32 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9CAF2CDE4
        for <linux-btrfs@vger.kernel.org>; Sat, 11 Jun 2022 07:59:26 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id s1so1328940ilj.0
        for <linux-btrfs@vger.kernel.org>; Sat, 11 Jun 2022 07:59:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dNs2ZU/p3kDi1q6uff6E2qNKFNtg5VUoQn9JDGR07Vc=;
        b=k6CWD2mSZaFJqVPIHFs6bs5++GuzIX/8wEBFmx4z2sqDD/104R+rIQTDKdrFYruK5s
         OdoY24CU/vHrE6NXHLNGxFKfBuhnw74T1kH9p1kJYcw96y6YC3JpSQ9nQm6dw00XbcL3
         oL3Heokge25uxOesBsMZFOuVgRLdcCr/P4gDaEYN2Wyzne2vtAKh386ntyuqa68gfut6
         opN2HhHGXoEqk1v2vcwxI+U8dndJCITGpnOgQAISWEYfXzrlgIap9qrIrTgGjHpHSsZh
         j6Ur5t7Tgmo9Xh6D/tnHbCBXFQhMj8J30Co1ld2qeik7HX44vd8VA9PtF1pziXk0X3vG
         55FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dNs2ZU/p3kDi1q6uff6E2qNKFNtg5VUoQn9JDGR07Vc=;
        b=Q0R5GshuLLsIirF9CjqMQwdt/d+qvj4iagyU5Sj5UgQeG/d4yNbzLubs3MrcdBFbr6
         l3pLi3cpafm0HSG9x5Vk84nkkY/FwzsOlqtGWMIdEN8xlPh/n6FXVlvQ/goPFXuOoFt1
         kNqIlrbV/st6+oLc03eIZfQ0UxJv5sfwtSUmcWOArejLsP8BK+Q/jBWa4uTRMG4RFAsj
         tUrGwwARIDvYAN300q6Csv9is7LPB9VgdveZH9MSdhZb983ug5YmgWnbtJSh4ogIYJ/v
         9gHvetweOeh9H5L/m69vre9Wwazoyda1I3GdQMvvQtoO5Q7p3cJLRrM+7DlxX/6fc+cE
         tx/w==
X-Gm-Message-State: AOAM533cJApquYTR7mjcHOXXeyEra7p6avTCLQAOIjF4kPTXOhSjy4xM
        ld+Fowj0bVn6ai1zDeMKtABmM3/pYTT8I9SgvbHoEJagLSw=
X-Google-Smtp-Source: ABdhPJzsAVQaWqNyd0vm9aTuT3NE1RNPSBlKbOKa9HwewAc+aq2rLmoYW5E93C0Cn2YBBUoj6CfuFxq7xC4BKFftimA=
X-Received: by 2002:a92:d1c6:0:b0:2d3:96da:426e with SMTP id
 u6-20020a92d1c6000000b002d396da426emr29130155ilg.152.1654959565880; Sat, 11
 Jun 2022 07:59:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220608213030.GG22722@merlins.org> <CAEzrpqdxCycEEAVqu-hykG-qdoEyBBFuc5buKS631XDciVrs7A@mail.gmail.com>
 <20220608213845.GH22722@merlins.org> <CAEzrpqejNj3qTtTJ7Godb0VMsxKt094vMw+iT4XR1B9aayO7Nw@mail.gmail.com>
 <20220609030128.GJ22722@merlins.org> <CAEzrpqfy-sf_xGMohK1EVgtP58tLTso6e7s9iyd3t5XnM3zjCg@mail.gmail.com>
 <20220609211511.GW1745079@merlins.org> <CAEzrpqfhUMDjkaJaa4ZugSuKOWpLyTVJ8nLu9nep5n_qzo-PiA@mail.gmail.com>
 <20220610191156.GB1664812@merlins.org> <CAEzrpqfEj3c5wodYzibBXg34NxtXmQCB60=MtD+Nic2PN8i5bQ@mail.gmail.com>
 <20220611001404.GM22722@merlins.org>
In-Reply-To: <20220611001404.GM22722@merlins.org>
From:   Josef Bacik <josef@toxicpanda.com>
Date:   Sat, 11 Jun 2022 10:59:15 -0400
Message-ID: <CAEzrpqda3=rDV8eLPsSDHbvmbyTnceecNkQUNA6mfOMmik=xDw@mail.gmail.com>
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

On Fri, Jun 10, 2022 at 8:14 PM Marc MERLIN <marc@merlins.org> wrote:
>
> On Fri, Jun 10, 2022 at 03:55:09PM -0400, Josef Bacik wrote:
> > Soooooo I've fixed my idiocy and moved the code around.  Unfortunately
> > my last fix deleted the stripes from the sys array, so we need to get
> > those back.  So once again run
>
> Thanks for looking into this
>
> > btrfs rescue recover-chunks <device>
> > btrfs rescue init-extent-tree <device>
> > btrfs check --repair <device>
>
> Let's go for another round :)
>
> gargamel:/var/local/src/btrfs-progs-josefbacik# ./btrfs rescue recover-chunks /dev/mapper/dshelf1
> FS_INFO IS 0x559bd17b9bc0
> Couldn't find the last root for 8
> FS_INFO AFTER IS 0x559bd17b9bc0
> Walking all our trees and pinning down the currently accessible blocks
> Found missing chunk in super block 20971520-29360128 type 34
> adding bg for 20971520 8388608
> kernel-shared/extent-tree.c:2829: btrfs_add_block_group: BUG_ON `ret` triggered, value -17
> ./btrfs(+0x29f27)[0x559bd01a8f27]
> ./btrfs(btrfs_add_block_group+0x1e0)[0x559bd01ad700]
> ./btrfs(btrfs_find_recover_chunks+0x4fe)[0x559bd020fc44]
> ./btrfs(+0x848ce)[0x559bd02038ce]
> ./btrfs(handle_command_group+0x49)[0x559bd019717b]
> ./btrfs(main+0x94)[0x559bd0197275]
> /lib/x86_64-linux-gnu/libc.so.6(__libc_start_main+0xcd)[0x7fe20f24a7fd]
> ./btrfs(_start+0x2a)[0x559bd0196e1a]
> Aborted

Oops, sorry about that, fixed it up.  My wife is travelling this week
so I'm going to be a little slower than normal, but hopefully we're
getting close to the end here.  Thanks,

Josef
