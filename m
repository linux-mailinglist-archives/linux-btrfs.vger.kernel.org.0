Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3D7853AF8A
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Jun 2022 00:51:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230415AbiFAU5r (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 1 Jun 2022 16:57:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230373AbiFAU5r (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 1 Jun 2022 16:57:47 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D011218A98
        for <linux-btrfs@vger.kernel.org>; Wed,  1 Jun 2022 13:57:46 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id y8so2990888iof.10
        for <linux-btrfs@vger.kernel.org>; Wed, 01 Jun 2022 13:57:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mlfovmyAkB7BA22E93XFTH2fe0hHHXDnbr/g0YhsaQA=;
        b=PhYBmfua4a3w0Rly/y+EwfhBQENIMt1RL4TRW8h1LSVowsD9dv5ih/wAM55ZLaLT1S
         XUAYWqFhh9B7+17YV2hCG3K/fRSfatMlVISqS5U/N6KKsL2HemG+5nyArPjKqZDCeuFe
         AFN00IMt+ywMCpU1d5jAE6CEEVg5vFSUnjo+c2z8SlXP3xYsjPcJIUFPcy05ZJ17LP3u
         vJrYf+zOqtJpO2dH7tK6ADiPmK09/PjRTS6juIFoN6EGtftGJOoLmZJTIa8sy1Kbjygv
         EgXko8rhjrGL29gt+uz2y9wbyYfw8FAJotxJ2GeM7VmwXYZqLgUWFpgkeUY/0xT1/oxK
         +1eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mlfovmyAkB7BA22E93XFTH2fe0hHHXDnbr/g0YhsaQA=;
        b=VdzNJy35JGGBLDaFDy+G1nFHVnaee6O5a/JTot4QgFFYxDghzyUhlQviSiBkp1aFY/
         +FDFTlMEAhaZZkfLrLSFKumnw1Wpi8kf1jFnvNSeNU8nD7JXNjAh83u2fyQ34oB/MU2b
         8aauinNIaMGmp0K6jUFAClKjDnvlBIpxAaD19tw8IUj0zJUp54Qsq+DDy2WHv87W+BDQ
         lKkip/zMZPjNAvjDhlhBIPfujE6nV5Z+gBvs9RPQzvz0axHFZ6ZiYzgYJ6oo0Bf7xy85
         DnQWsichCGF7negmO/UQXgnwIJ+g/RjQ1wFHFwZzZXxCWL/QClq5yK4aoJposZESFXaS
         YHDQ==
X-Gm-Message-State: AOAM530Jl9fvva0wEczhn6B5zFm+QLcJX24sm08jnoFH32GP4bLTNJap
        jGq3tdIM/VAcD59lDoCC2HZJi+c+52y2z9oyEEBHrtZ1a6w=
X-Google-Smtp-Source: ABdhPJwIO8q2rO8Jrh7d81NjHapEvFjuyshrvcFhE+NZ1CY5rmsxj4ZuHW0t3QH/O9PLs3dNaOusRp04GPKwEACNQbk=
X-Received: by 2002:a05:6638:379c:b0:32e:d7a6:b715 with SMTP id
 w28-20020a056638379c00b0032ed7a6b715mr1249415jal.102.1654117065457; Wed, 01
 Jun 2022 13:57:45 -0700 (PDT)
MIME-Version: 1.0
References: <20220601002552.GD22722@merlins.org> <CAEzrpqfkrD4aYA3vMToi+vfYeoyj=h4JAx+xnGQj836FP+pbjg@mail.gmail.com>
 <20220601012919.GE22722@merlins.org> <CAEzrpqc_sCu18+tfP9E1Z3+kj70ss7nH-YTnEu0Rw_QQxPWTUQ@mail.gmail.com>
 <20220601031536.GD1745079@merlins.org> <CAEzrpqfw85GnLUq8=vywej1Gb6vjcgKUYucLw9DgoSaWEbyZbg@mail.gmail.com>
 <20220601163924.GE1745079@merlins.org> <CAEzrpqd7=9JxgjC0pqikEo5o7RTsP9M-qLLcCps0Vx1RxRak-g@mail.gmail.com>
 <20220601180824.GF22722@merlins.org> <CAEzrpqc1cFHwb8fczUatznbwzDFi87j-kuXMMcUf2rmKWzu5Lw@mail.gmail.com>
 <20220601185027.GG22722@merlins.org> <CAEzrpqcY-F4WOiaJcDfHykok0LB=JEX1DnZj53+KvM7a6j+daQ@mail.gmail.com>
In-Reply-To: <CAEzrpqcY-F4WOiaJcDfHykok0LB=JEX1DnZj53+KvM7a6j+daQ@mail.gmail.com>
From:   Josef Bacik <josef@toxicpanda.com>
Date:   Wed, 1 Jun 2022 16:57:34 -0400
Message-ID: <CAEzrpqeTEuRzP_Nj1qoSerCObJLA4fJYDfR1u3XMatuG=RZf-g@mail.gmail.com>
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

On Wed, Jun 1, 2022 at 3:01 PM Josef Bacik <josef@toxicpanda.com> wrote:
>
> On Wed, Jun 1, 2022 at 2:50 PM Marc MERLIN <marc@merlins.org> wrote:
> >
> > On Wed, Jun 01, 2022 at 02:42:55PM -0400, Josef Bacik wrote:
> > > On Wed, Jun 1, 2022 at 2:08 PM Marc MERLIN <marc@merlins.org> wrote:
> > > >
> > > > On Wed, Jun 01, 2022 at 02:00:43PM -0400, Josef Bacik wrote:
> > > > > Ok perfect, now try btrfs rescue recover-chunks <device>, thanks,
> > > >
> > > > (gdb) run rescue recover-chunks /dev/mapper/dshelf1
> > > > Starting program: /var/local/src/btrfs-progs-josefbacik/btrfs rescue recover-chunks /dev/mapper/dshelf1
> > > > [Thread debugging using libthread_db enabled]
> > > > Using host libthread_db library "/lib/x86_64-linux-gnu/libthread_db.so.1".
> > > > FS_INFO IS 0x55555564fbc0
> > > > Invalid mapping for 15645202989056-15645203005440, got 15664345513984-15665419255808
> > > > Couldn't map the block 15645202989056
> > > > Couldn't map the block 15645202989056
> > > > bad tree block 15645202989056, bytenr mismatch, want=15645202989056, have=0
> > > > Couldn't read tree root
> > > > FS_INFO AFTER IS 0x55555564fbc0
> > > > Walking all our trees and pinning down the currently accessible blocks
> > >
> > > Ok you're ready to go.  Thanks,
> >
> > Indeed, good job:
> >
> > FS_INFO IS 0x55555564fbc0
> > Invalid mapping for 15645202989056-15645203005440, got 15664345513984-15665419255808
> > Couldn't map the block 15645202989056
> > Couldn't map the block 15645202989056
> > bad tree block 15645202989056, bytenr mismatch, want=15645202989056, have=0
> > Couldn't read tree root
> > FS_INFO AFTER IS 0x55555564fbc0
> > Walking all our trees and pinning down the currently accessible blocks
> > we would add a chunk at 14823605665792-14824679407616 type 0
> > we would add a chunk at 14824679407616-14825753149440 type 0
> > we would add a chunk at 14825753149440-14826826891264 type 0
> > (...)
> > we would add a chunk at 15772793438208-15773867180032 type 0
> > we would add a chunk at 15773867180032-15774940921856 type 0
> > we would add a chunk at 15774940921856-15776014663680 type 0
> > we would add a chunk at 15776014663680-15777088405504 type 0
> > we would add a chunk at 15777088405504-15778162147328 type 0
> > doing close???
> > Recover chunks succeeded, you can run check now
> > [Inferior 1 (process 696) exited normally]
> >
> > Which btrfs check do you want me to run?
> >
>
> Phew ok, I'm finding the right chunks, that's perfect.  I'm now going
> to write the code to fill in the missing chunks, give me a bit to do
> that.  Thanks,
>

Ok I've committed the code, but I forsee all sorts of wonky problems
since we don't have a tree root yet, there may be a variety of
segfaults I have to run down before it actually works.  So go ahead
and do

btrfs rescue recover-chunks <device>

if by some miracle it completes, you'll then want to run

btrfs rescue tree-recover <device>

and then we can go from there.  Thanks,

Josef
