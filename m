Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DB68343982
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Mar 2021 07:33:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229455AbhCVGcn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 22 Mar 2021 02:32:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229913AbhCVGcO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 22 Mar 2021 02:32:14 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3522CC061574
        for <linux-btrfs@vger.kernel.org>; Sun, 21 Mar 2021 23:32:14 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id i3so11952363oik.7
        for <linux-btrfs@vger.kernel.org>; Sun, 21 Mar 2021 23:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gm6U5UMNhlq9Z+H5yKli7wd6GcR1hTYNyfYLHhZi+/c=;
        b=pXMWBvY7BWPTq09m20k0tGZ2EQTscx1uc2QQwEN1u+O6e+TvjL33h+bUstITM+cbph
         M+xOG7Qy+ini5MAdQsRmtHltRSfIQNTH7BvlbW0GNUzhFPi2zYHIulZJ0aNW5eKxY53u
         0KubTUjkYL9JQSLh4UxHd5hwoTS/oOx3lumc4toi8NQwtTTjOvAEaY+AfnQKLODzAK66
         1hqEvCcSkN/um3B/F1g1wwpETRfcq8PfuJJlfZy+DcQ66G3lIlVRxwBBqkE6JuO9dAkB
         +OuTCDD7ZgxUhi1Q+JoOjBpzpMKRc6HupCtDpttgiMhVMYlT5lZMtPYk36tGLR2lOwaT
         8tsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gm6U5UMNhlq9Z+H5yKli7wd6GcR1hTYNyfYLHhZi+/c=;
        b=hahUapl3Uq/eEJ0ENZHYJpqEhAUOhQPGHqEfXyEs1Fqir4Sl1/6X1R+Dz6FhCI2oTO
         Dsl2XraMOaSS8ZC3/FYuuyPvzGYMEhvHKi3IUjqlin/Yig07BknyqpzX/7HfpkFU9Sx3
         b0Y4JA7R6ftw3xMm1GuooY2WnNpYcMfdT1NqSdF4nIxJZzo4ZMo4cf1VGfDlje24uYFn
         eTsG7fNo/P0ajlhNsphUA4yzZP59FxdW5oSKS/4bUiU4EO/tc4tfLD/CmaqvTgoZE/1J
         RHTJYE7LtyWYcps2yMeI85hi1O3qsAmOlwzDiqhaOVARFft/LqfOz+tMq2xwMglweRBP
         wDQw==
X-Gm-Message-State: AOAM533oOm1vD9par+ajPA/SG6gOl6g8Qc8/VVDl9TGrCTR8xbx+2VTq
        IaVKQMR4gAQFL0h5N4RmKbXH6nLxMRcBRltYPDs=
X-Google-Smtp-Source: ABdhPJzJm22xZbm+HI6b5AvxQaobTjaXKyHl5ZSlQyqnsmaRtJMDX7o+FLo0T5uQCT1XHxeANpqbH1dFphfGQFs8UoQ=
X-Received: by 2002:aca:dc87:: with SMTP id t129mr8964156oig.137.1616394733703;
 Sun, 21 Mar 2021 23:32:13 -0700 (PDT)
MIME-Version: 1.0
References: <CAGdWbB6JtU54uEOotj=H-DG_7oeUT5KZQG5uM-ibiC2YDbV5Nw@mail.gmail.com>
 <CAJCQCtSBc-Dmks2jdgr-Bcpdh_iLvVevtGOa4LdYgHc2eZE6Hg@mail.gmail.com>
 <CAGdWbB4dN45=4T_WbF7tXmm2UsmF0bh=Lb_z-H=QVQWaW=C=Bw@mail.gmail.com>
 <CAGdWbB61y3CXTbSxe9Rc7ijs9vsLg7qcX4JZ_WpW-73m_1-6_g@mail.gmail.com> <CAJCQCtRyhh6AY25+RwikJKk_HUW1xveVxYzGvPpFDdWq618KUg@mail.gmail.com>
In-Reply-To: <CAJCQCtRyhh6AY25+RwikJKk_HUW1xveVxYzGvPpFDdWq618KUg@mail.gmail.com>
From:   Dave T <davestechshop@gmail.com>
Date:   Mon, 22 Mar 2021 02:32:02 -0400
Message-ID: <CAGdWbB7kCM8DzbS5TzZg=DhsdjTE5nij1SuEnibi3B=OqPBRow@mail.gmail.com>
Subject: Re: parent transid verify failed / ERROR: could not setup extent tree
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Mar 21, 2021 at 2:03 PM Chris Murphy <lists@colorremedies.com> wrote:
>
> On Sat, Mar 20, 2021 at 11:54 PM Dave T <davestechshop@gmail.com> wrote:
> >
> > # btrfs check -r 2853787942912 /dev/mapper/xyz
> > Opening filesystem to check...
> > parent transid verify failed on 2853787942912 wanted 29436 found 29433
> > parent transid verify failed on 2853787942912 wanted 29436 found 29433
> > parent transid verify failed on 2853787942912 wanted 29436 found 29433
> > Ignoring transid failure
> > parent transid verify failed on 2853827723264 wanted 29433 found 29435
> > parent transid verify failed on 2853827723264 wanted 29433 found 29435
> > parent transid verify failed on 2853827723264 wanted 29433 found 29435
> > Ignoring transid failure
> > leaf parent key incorrect 2853827723264
> > ERROR: could not setup extent tree
> > ERROR: cannot open file system
>
> btrfs insp dump-t -t 2853827723264 /dev/

# btrfs insp dump-t -t 2853827723264 /dev/mapper/xzy
btrfs-progs v5.11
parent transid verify failed on 2853827608576 wanted 29436 found 29433
parent transid verify failed on 2853827608576 wanted 29436 found 29433
parent transid verify failed on 2853827608576 wanted 29436 found 29433
Ignoring transid failure
leaf parent key incorrect 2853827608576
WARNING: could not setup extent tree, skipping it
parent transid verify failed on 2853827608576 wanted 29436 found 29433
Ignoring transid failure
leaf parent key incorrect 2853827608576
Couldn't setup device tree
ERROR: unable to open /dev/mapper/xzy

# btrfs insp dump-t -t 2853787942912 /dev/mapper/xzy
btrfs-progs v5.11
parent transid verify failed on 2853827608576 wanted 29436 found 29433
parent transid verify failed on 2853827608576 wanted 29436 found 29433
parent transid verify failed on 2853827608576 wanted 29436 found 29433
Ignoring transid failure
leaf parent key incorrect 2853827608576
WARNING: could not setup extent tree, skipping it
parent transid verify failed on 2853827608576 wanted 29436 found 29433
Ignoring transid failure
leaf parent key incorrect 2853827608576
Couldn't setup device tree
ERROR: unable to open /dev/mapper/xzy

# btrfs insp dump-t -t 2853827608576 /dev/mapper/xzy
btrfs-progs v5.11
parent transid verify failed on 2853827608576 wanted 29436 found 29433
parent transid verify failed on 2853827608576 wanted 29436 found 29433
parent transid verify failed on 2853827608576 wanted 29436 found 29433
Ignoring transid failure
leaf parent key incorrect 2853827608576
WARNING: could not setup extent tree, skipping it
parent transid verify failed on 2853827608576 wanted 29436 found 29433
Ignoring transid failure
leaf parent key incorrect 2853827608576
Couldn't setup device tree
ERROR: unable to open /dev/mapper/xzy

>
> > It appears the backup root is already stale.
>
> I'm not sure. If you can post the contents of that leaf (I don't think
> it will contain filenames but double check) Qu might have an idea if
> it's safe to try a read-write mount with -o usebackuproot without
> causing problems later.
>
> > > What you eventually need to look at is what precipitated the transid
> > > failures, and avoid it.
> >
> > The USB drive was disconnected by the user (an accident). I have other
> > devices with the same hardware that have never experienced this issue.
> >
> > Do you have further ideas or suggestions I can try? Thank you for your
> > time and for sharing your expertise.
>
> The drive could be getting write ordering wrong all the time, and it
> only turns into a problem with a crash, power fail, or accidental
> disconnect.  More common is the write ordering is only sometimes
> wrong, and a crash or powerfail is usually survivable, but leads to a
> false sense of security about the drive.
>
> The simple theory of write order is data->metadata->sync->super->sync.
> It shouldn't ever be the case that a newer superblock generation is on
> stable media before the metadata it points to.
>

The drive is a Western Digital Elements 5TB. I searched a bit on write
order under Linux, but I did not find any helpful articles regarding
any configuration changes I could make. Is this purely a hardware
issue, or are there steps I can take to ensure the correct write
ordering?

Thank you!
