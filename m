Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AD4953AF9B
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Jun 2022 00:51:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231266AbiFAVID (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 1 Jun 2022 17:08:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231261AbiFAVIC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 1 Jun 2022 17:08:02 -0400
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AB6C4BB8F
        for <linux-btrfs@vger.kernel.org>; Wed,  1 Jun 2022 14:08:01 -0700 (PDT)
Received: by mail-il1-x129.google.com with SMTP id s1so2223326ilj.0
        for <linux-btrfs@vger.kernel.org>; Wed, 01 Jun 2022 14:08:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NqlDioD1S+IccUO4nm6ntfNlhEi7mnJaDG7f0XBePWY=;
        b=QEuF3bdUNBKnlUQDtYgeyfwAs0Ijl7yqGsp8lgIYefJe4s5Hqm51SJMTUOS3Y3Dyf5
         kRpDZutphP4s2BUgqxqakkzuAH58KVbszep0WGlQM+Mc46gYuDDxoKrX5o3i6HcXQUAu
         XTLKr7h5hwaa4oxyELUa3/exHT0iM/dA6p0fBw/i1ovgOFYVOmx7vYSOcH+mthQcJqCf
         zC6hD+4nB3cUzG/X1rid8eD+ZJV//QEbO2AKiLB47ZoXH8IiSObvygILfZA/NJ8y7duq
         earVgmb0otoba9QbflqURWQNA4OIbFlZRkrYhpKwM4WEnxrsTutQTDkCRyVYCg5reYSZ
         FwfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NqlDioD1S+IccUO4nm6ntfNlhEi7mnJaDG7f0XBePWY=;
        b=4xFhPj737NEQqxisGgaKMLxw/wKOMhU0wGAvcAx26goEG528TgK4Svq2L3jYY2+97W
         GHcT1Zl8V5qwa5vBhr4Ki3UfzcFSOXJ//fIxdw2sPsYF6cYOWhIIohYM4RXmg2WIPr6/
         jhKoeP0zyO2qc0L1OtOfr0mZo7AHWdtaRWO7IFgzsBBsg10NaSKhvDa2b/9hRxAGhShs
         b+5JZ6xqQiqJMWT9up8ofbfKmuG8KeKtqyc2nD1uwXYJuCWEBowDGeGSyfld3nfh8aDm
         vzHtZ8bpycqoFWXh/zAwkmhnnqnhiQ/5aQttTXsN7Sa8nzy0HmmBxu9DXk5sxvB162v9
         fzNw==
X-Gm-Message-State: AOAM5316MBCApiDVUq35g6eTYhnhTMTe0Ko6+R0n22nbf1q5ZWocKusY
        QQLJu6VHMHf/GvI8N4rhk0Axq++YDCLSM68ctfdRJNbYxxg=
X-Google-Smtp-Source: ABdhPJymQxXPYfCciqOr/6wTklBFGeISrGABwyoKDjIsRaNTXZV8U6XZHehEKSllCEQDI6M5AGj1s/LkFKTE7C1o5qU=
X-Received: by 2002:a05:6602:29ca:b0:649:558a:f003 with SMTP id
 z10-20020a05660229ca00b00649558af003mr793079ioq.160.1654110089962; Wed, 01
 Jun 2022 12:01:29 -0700 (PDT)
MIME-Version: 1.0
References: <20220601002552.GD22722@merlins.org> <CAEzrpqfkrD4aYA3vMToi+vfYeoyj=h4JAx+xnGQj836FP+pbjg@mail.gmail.com>
 <20220601012919.GE22722@merlins.org> <CAEzrpqc_sCu18+tfP9E1Z3+kj70ss7nH-YTnEu0Rw_QQxPWTUQ@mail.gmail.com>
 <20220601031536.GD1745079@merlins.org> <CAEzrpqfw85GnLUq8=vywej1Gb6vjcgKUYucLw9DgoSaWEbyZbg@mail.gmail.com>
 <20220601163924.GE1745079@merlins.org> <CAEzrpqd7=9JxgjC0pqikEo5o7RTsP9M-qLLcCps0Vx1RxRak-g@mail.gmail.com>
 <20220601180824.GF22722@merlins.org> <CAEzrpqc1cFHwb8fczUatznbwzDFi87j-kuXMMcUf2rmKWzu5Lw@mail.gmail.com>
 <20220601185027.GG22722@merlins.org>
In-Reply-To: <20220601185027.GG22722@merlins.org>
From:   Josef Bacik <josef@toxicpanda.com>
Date:   Wed, 1 Jun 2022 15:01:19 -0400
Message-ID: <CAEzrpqcY-F4WOiaJcDfHykok0LB=JEX1DnZj53+KvM7a6j+daQ@mail.gmail.com>
Subject: Re: Rebuilding 24TB Raid5 array (was btrfs corruption: parent transid
 verify failed + open_ctree failed)
To:     Marc MERLIN <marc@merlins.org>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jun 1, 2022 at 2:50 PM Marc MERLIN <marc@merlins.org> wrote:
>
> On Wed, Jun 01, 2022 at 02:42:55PM -0400, Josef Bacik wrote:
> > On Wed, Jun 1, 2022 at 2:08 PM Marc MERLIN <marc@merlins.org> wrote:
> > >
> > > On Wed, Jun 01, 2022 at 02:00:43PM -0400, Josef Bacik wrote:
> > > > Ok perfect, now try btrfs rescue recover-chunks <device>, thanks,
> > >
> > > (gdb) run rescue recover-chunks /dev/mapper/dshelf1
> > > Starting program: /var/local/src/btrfs-progs-josefbacik/btrfs rescue recover-chunks /dev/mapper/dshelf1
> > > [Thread debugging using libthread_db enabled]
> > > Using host libthread_db library "/lib/x86_64-linux-gnu/libthread_db.so.1".
> > > FS_INFO IS 0x55555564fbc0
> > > Invalid mapping for 15645202989056-15645203005440, got 15664345513984-15665419255808
> > > Couldn't map the block 15645202989056
> > > Couldn't map the block 15645202989056
> > > bad tree block 15645202989056, bytenr mismatch, want=15645202989056, have=0
> > > Couldn't read tree root
> > > FS_INFO AFTER IS 0x55555564fbc0
> > > Walking all our trees and pinning down the currently accessible blocks
> >
> > Ok you're ready to go.  Thanks,
>
> Indeed, good job:
>
> FS_INFO IS 0x55555564fbc0
> Invalid mapping for 15645202989056-15645203005440, got 15664345513984-15665419255808
> Couldn't map the block 15645202989056
> Couldn't map the block 15645202989056
> bad tree block 15645202989056, bytenr mismatch, want=15645202989056, have=0
> Couldn't read tree root
> FS_INFO AFTER IS 0x55555564fbc0
> Walking all our trees and pinning down the currently accessible blocks
> we would add a chunk at 14823605665792-14824679407616 type 0
> we would add a chunk at 14824679407616-14825753149440 type 0
> we would add a chunk at 14825753149440-14826826891264 type 0
> (...)
> we would add a chunk at 15772793438208-15773867180032 type 0
> we would add a chunk at 15773867180032-15774940921856 type 0
> we would add a chunk at 15774940921856-15776014663680 type 0
> we would add a chunk at 15776014663680-15777088405504 type 0
> we would add a chunk at 15777088405504-15778162147328 type 0
> doing close???
> Recover chunks succeeded, you can run check now
> [Inferior 1 (process 696) exited normally]
>
> Which btrfs check do you want me to run?
>

Phew ok, I'm finding the right chunks, that's perfect.  I'm now going
to write the code to fill in the missing chunks, give me a bit to do
that.  Thanks,

Josef
