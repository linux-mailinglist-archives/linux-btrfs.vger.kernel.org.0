Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10ED25371E8
	for <lists+linux-btrfs@lfdr.de>; Sun, 29 May 2022 19:33:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231377AbiE2RdC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 29 May 2022 13:33:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231364AbiE2RdA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 29 May 2022 13:33:00 -0400
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED588120A9
        for <linux-btrfs@vger.kernel.org>; Sun, 29 May 2022 10:32:59 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id y16so1270805ili.13
        for <linux-btrfs@vger.kernel.org>; Sun, 29 May 2022 10:32:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GppdCWLBA4WZBZ7bYJoj6RCpChMky4/XfHyd1X3t/Z8=;
        b=TRiYwneQfIzEUhp1Cjot2Wmo2NfJ20D3Hv5bpgn7IHMz5zXgEBkf+zoeeNcDaMMFPm
         9uzcjpmO+4QIiIxu4DWHYIac4ccg++TxbaXVGKhrTqDiu2c16Vaj6n8WAgLYeyn2aoJ7
         S2u77JrYdWsdHMx451w1Y1fxlwi8jDhUwpN7tAdasll5kTMqPLlseqJfUoJKqhYYbY7T
         9D2pRcM0dPFht2o1K304GDnROL9v3l6Uduewlea7tx4yLzqslGBViARwfCq2MxiUMnvj
         keLUZruNuydrCF8opC/E+htcmkcbR9RZ1igULIB3k+3jBjmEdYVxsU4rzS3Ugb4aoW5m
         quJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GppdCWLBA4WZBZ7bYJoj6RCpChMky4/XfHyd1X3t/Z8=;
        b=G2j9YKaypURo1VQWspZHCocq63NOezpos6Fi2Xseq4LjF682TUPHn452wSLvQpZbyy
         B9HTiExphGCUtFPF00ynsi0Dvrm1pdh5hzXxh0N1k9CebvBkdN2cKF6V9vNTSPC8fKYR
         z9Q86Kt/EZPKrI4CBTyI1oeMKr+JM38TVQgw1fsTll8bRuMpLyTqwX++H7pVzyP8kgpH
         S3NSZYgssAW2JVGu1aUHQCc7gxfpS4GcHcUsEVT1xqNFfK8RIPrPttzgVRoCex+pH5yJ
         0Qq6EH6JX2clWEwFIrIL6z1j9uIihtspDvmwZ4/yUF+1yVEyzwt4Dd7fapRz6sAA7O5C
         +KKQ==
X-Gm-Message-State: AOAM533Rg4dmyr8hYU0pJkuRiarYGO1mn0ckGtgQF6MK1PUCt6pQS9+L
        MIjIhUcFp9Fq2lVwgKENkLzc+9vPYkYdd/0gRF+bhsybr+c=
X-Google-Smtp-Source: ABdhPJxFBTam8HpX9kbUV5bf7LIJPrw/52FHYb0q99FZ0xvVBIrWVlUKJ07WYLas9IOe9wROZYnuBgQjrCYVrtkwuGc=
X-Received: by 2002:a92:ca49:0:b0:2d3:9e94:1af8 with SMTP id
 q9-20020a92ca49000000b002d39e941af8mr2007680ilo.127.1653845579274; Sun, 29
 May 2022 10:32:59 -0700 (PDT)
MIME-Version: 1.0
References: <20220526213924.GB2414966@merlins.org> <20220527011622.GA24951@merlins.org>
 <CAEzrpqdbuQGwwuCfYyVdiDtGDsPb=3FWmKrTEA5Xukk1ex514g@mail.gmail.com>
 <20220527232604.GA22722@merlins.org> <CAEzrpqeJyupr02nUJkBBVCah46FN+znVczm-RtfBFauvJW9O6w@mail.gmail.com>
 <CAEzrpqfAYRUYttOAMmdth4mfi4e7MTM++s5WOQ+KAzg2Kv0Nsw@mail.gmail.com>
 <20220528225601.GD24951@merlins.org> <CAEzrpqcG+9evRPKixVwGnAS_k2tb7o16jQgORtm1cw7hW_KsAw@mail.gmail.com>
 <20220529035139.GE24951@merlins.org> <CAEzrpqcKeVNkXa3txx0nyDnKUCp06msmd97d1fBedTzbmR5KcA@mail.gmail.com>
 <20220529153312.GF24951@merlins.org>
In-Reply-To: <20220529153312.GF24951@merlins.org>
From:   Josef Bacik <josef@toxicpanda.com>
Date:   Sun, 29 May 2022 13:32:48 -0400
Message-ID: <CAEzrpqdEk-j2bMfBLEdkhHcq1hWLmHv_Nx-0mj1vh0yJgZuCZQ@mail.gmail.com>
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

On Sun, May 29, 2022 at 11:33 AM Marc MERLIN <marc@merlins.org> wrote:
>
> On Sun, May 29, 2022 at 11:00:35AM -0400, Josef Bacik wrote:
> > > gargamel:/var/local/src/btrfs-progs-josefbacik# ./btrfs rescue tree-recover /dev/mapper/dshelf1
> > > ERROR: cannot read chunk root
> > > WTF???
> > > ERROR: open ctree failed
> > > Tree recover failed
> >
> > Sorry, thought I fixed this before pushing yesterday, try again please.  Thanks,
>
> Resynced but it's the same:
>
> gargamel:/var/local/src/btrfs-progs-josefbacik# ./btrfs rescue tree-recover /dev/mapper/dshelf1
> WARNING: cannot read chunk root, continue anyway
> ERROR: Failed to read root block
> Tree recover failed

Oh huh, apparently I only scan for a root if we didn't find a good fit
in the beginning, not if I couldn't read any roots.  Fixed that up,
please try again.  Thanks,

Josef
