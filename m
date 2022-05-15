Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E811452786D
	for <lists+linux-btrfs@lfdr.de>; Sun, 15 May 2022 17:26:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234933AbiEOPYu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 15 May 2022 11:24:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234855AbiEOPYs (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 15 May 2022 11:24:48 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A532864FE
        for <linux-btrfs@vger.kernel.org>; Sun, 15 May 2022 08:24:46 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id r27so13657607iot.1
        for <linux-btrfs@vger.kernel.org>; Sun, 15 May 2022 08:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7lyHRcLQ7xrlwEeJLAaUMx4DO+ZjFx30aG7ikj2NXsg=;
        b=bMoW5V1DD6H1PMclHWor80ktz9/se3x04NEZWEPVcGiRfvZrmZVV2D1/bgpBptHS0p
         bQ61gAnNHYj7jIXD3Jeh3PgrGITMhpUNe48NKkplbD6IskzC/faysYqSBoVfmaJqUEOw
         UaOIX3kaaZn7XavxOjyDfRcSev+cnD44OLlVUr5clnqQaFerRIhjDYN9oufEZsdtV9s3
         BsYEOCIYa3jPoS0+z60N1s5vB3xb6ujEoE27DMimSuiBsxFl5HAGhdsEsc/Tgq46ZPu3
         SxOdpjYe7CNcBTiIrDKmO3MU7zMUkD6pe4/gBZfr4HtJo3Y/I/RJqwWu60Byzfo9uLOr
         WoTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7lyHRcLQ7xrlwEeJLAaUMx4DO+ZjFx30aG7ikj2NXsg=;
        b=U8obSA+R6me4FW6baM0HsjSaBnMBNS4USa02ZgpSyMHWOEF5tWytZNLpIFxrCL3wsc
         kaATTWmEw4Tlg0IYXAwRQMaIRvaUQhuGKhjmfMcDQ6VT7rwRCEZfHPmausYumNOO1R/G
         /M6SQ5EfbuEDF8zNCTQQC6SPcda+aatnQX+QIwCgTtCWl17KQLCq/XleYdu8r0OS3Qat
         YtFxvyUt3A+6vqsDoHXQiV87jCtUW7/PLH6Tpyl2w0VeHAxCJQvpl8M3jyGko9ZGiPXM
         P1nq+7DISnGFVgaSrDcrp3aY/CZGYl5bmC8lcLpF7x1BzgptRB7lUt/w9IZXp2EL+6RH
         lFZA==
X-Gm-Message-State: AOAM530b9gT+KUb6afHiTpyc5Kk6rnXmKNJGemxoaZzOHJnBQlXcj76r
        M0ZQ/QRt2G6cE9pjz2SLfVKa1a8kz0lU9CT3b322R5rpsmM=
X-Google-Smtp-Source: ABdhPJwKi9boCIu4kzAtm4VSxh98UIx+9EwlXYkJqfHfORKj/h/yBuR6BhlCx0lhE2va9QFNIjx2IAOF5lcmSSPZyak=
X-Received: by 2002:a05:6638:37aa:b0:32e:1b24:ab83 with SMTP id
 w42-20020a05663837aa00b0032e1b24ab83mr2628538jal.102.1652628285873; Sun, 15
 May 2022 08:24:45 -0700 (PDT)
MIME-Version: 1.0
References: <20220511014827.GL12542@merlins.org> <CAEzrpqfzXn0sZNVDud4UfysxvF4mgbq_a_ToJioDFz2wE-d3Rw@mail.gmail.com>
 <20220511150319.GM29107@merlins.org> <CAEzrpqcT0fObDa8XFWtvzeqCKom42t5o+xE9atmFjWyHCHmb=g@mail.gmail.com>
 <20220511160009.GN12542@merlins.org> <CAEzrpqdO4FX0A1b9xYycJQuMsvzUegSLcze4hpkMOD9dn2F-pQ@mail.gmail.com>
 <20220513144113.GA16501@merlins.org> <CAEzrpqfYg=Zf_GYjyvc+WZsnoCjiPTAS-08C_rB=gey74DGUqA@mail.gmail.com>
 <20220515025703.GA13006@merlins.org> <CAEzrpqfpXVBoWdAzXEYG+RdhOMZFUbWBf6GKcQ6AwL77Mtzjgg@mail.gmail.com>
 <20220515144145.GB13006@merlins.org>
In-Reply-To: <20220515144145.GB13006@merlins.org>
From:   Josef Bacik <josef@toxicpanda.com>
Date:   Sun, 15 May 2022 11:24:34 -0400
Message-ID: <CAEzrpqcVRJFS6HN4L7=tu0Z8SA+E2GsLJzWEADRK3iJvdVy4EA@mail.gmail.com>
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

On Sun, May 15, 2022 at 10:41 AM Marc MERLIN <marc@merlins.org> wrote:
>
> On Sun, May 15, 2022 at 10:02:10AM -0400, Josef Bacik wrote:
> > On Sat, May 14, 2022 at 10:57 PM Marc MERLIN <marc@merlins.org> wrote:
> > >
> > > On Fri, May 13, 2022 at 12:16:02PM -0400, Josef Bacik wrote:
> > > > Once Sarah is asleep I'll look at the code, we can probably make this
> > > > go faster, but you've got a lot of data so I expect it's going to take
> > > > some time.  Thanks,
> > >
> > > It's still running on my side, almost 4 days. Is there any way to know
> > > whether I'm close to 100%, or not really?
> >
> > The fs based refill isn't snapshot aware, so it's going to search
> > everything constantly which is annoying.  I've got some time this
> > morning, I'll write up something different.  THanks,
>
> Ah, in that case I have around 20 snapshots, so yeah if it's going to be
> 20 times faster, I'll take that, especially if it ends up being one day
> instead of 3 weeks :)
>

Ok I pushed something new, but completely untested as I'm sitting at a
park with the kids and my kdevops thing is broken on my laptop.  You
should be able to do

btrfs rescue init-csum-tree <device>

and it'll rebuild the csum tree.  It'll give you a progress bar as
well.  I expect the normal amount of back and forth before it actually
works, but it should work faster for you.  Thanks,

Josef
