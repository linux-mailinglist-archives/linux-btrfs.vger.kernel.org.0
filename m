Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BF4322D1A7
	for <lists+linux-btrfs@lfdr.de>; Sat, 25 Jul 2020 00:09:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726692AbgGXWIz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 24 Jul 2020 18:08:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726552AbgGXWIz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 24 Jul 2020 18:08:55 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1A3EC0619D3
        for <linux-btrfs@vger.kernel.org>; Fri, 24 Jul 2020 15:08:54 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id f18so754351wmc.0
        for <linux-btrfs@vger.kernel.org>; Fri, 24 Jul 2020 15:08:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gHNaLOJiJ9CXhZLAR7lBBNeSD8Z+jPyR8h/KZvNCw44=;
        b=W+ldZ3yS3fPrniyczcI0uwteDCSfUTZmIdkiCCZpJ/IHwE8gu0uIe7h7f0+oxufk+1
         PNXvk8zQEvmx2ka+VoZkCsgRpSOOJhNPfrkNMMrgZf2tn/+muAylaZ/XQ34KQzSxqpbb
         xRetG2PonBVzJTz1v7MjokNAVDEN8rDCmJelWUSH/uCimeQuC65pD2SWqi/G6c1AmtFv
         9zKj++JBu2391w29kvlB+BElKmXxiFh4g/hadS1YANaFNqglWVBz0E+SxDFj4Z1wOUZ1
         I7OzDiz+wJYj61AZ8ZCPVcDOtYRs2dnDZzQSMVftkzLdwy/L5fSCl/vrZsEM2pRWjRu2
         9qng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gHNaLOJiJ9CXhZLAR7lBBNeSD8Z+jPyR8h/KZvNCw44=;
        b=kzJ4bGruGviwx/CFBZMGIEiZI5AMxQ0DN/lTB7vEmmau7YmixpmPByLZw5cDJCmNIO
         0GmzHusycKAoaifUWdxG67eVaguT3HehgnSYWZVBX9WJ16XukO2CWq0yc9FRAN/qFKg2
         UahDsqP5CS3i6Qdu/xH/dKs6AJSMEPyQh2Qv4qQ6UyWDB5BerCizTq3Ice5LCPuMLsiZ
         R6DoRVx7qD/tfkaEIea/1wr55JFgV/97ZQQidh2UtGv1eOOkrZLWa1Ns9FzQR/+v8Jb6
         qrutVJIe88g8JL79yOp5FUtxVM6D3T67amvruXQrVBVQHp5GQeldG9OIaBNXsAPKmsAV
         IciA==
X-Gm-Message-State: AOAM5319xwaTcVnp9zY+R7DXj7gEc9AzX5dvHTiOKDCs+BsP0Ufq50rB
        A5tItgjLslCB3Le75PtAVjG45hhVPwdEW3W6VVRkCw==
X-Google-Smtp-Source: ABdhPJx/knYUysQdDcphuRVTh+68HGLmXBy0fNWybdT4aMlPPlrJG8ciMOy6WPXDLInAB1KUqQ7KY6sz33+00z/o6Ic=
X-Received: by 2002:a1c:f317:: with SMTP id q23mr10890541wmq.182.1595628533253;
 Fri, 24 Jul 2020 15:08:53 -0700 (PDT)
MIME-Version: 1.0
References: <20200721203340.275921-1-kreijack@libero.it> <20200723215325.GB5890@hungrycats.org>
 <a4074100-b006-7d64-e22d-779ad15191c0@libero.it>
In-Reply-To: <a4074100-b006-7d64-e22d-779ad15191c0@libero.it>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Fri, 24 Jul 2020 16:08:37 -0600
Message-ID: <CAJCQCtRj+xhGqateq=0Qb8v0+zUeR3xdCrgGVH3QqJZoP6+djg@mail.gmail.com>
Subject: Re: [RFC] btrfs: strategy to perform a rollback at boot time
To:     Goffredo Baroncelli <kreijack@inwind.it>
Cc:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        Chris Murphy <lists@colorremedies.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jul 24, 2020 at 5:56 AM Goffredo Baroncelli <kreijack@libero.it> wrote:
>
> On 7/23/20 11:53 PM, Zygo Blaxell wrote:
> > On Tue, Jul 21, 2020 at 10:33:39PM +0200, Goffredo Baroncelli wrote:
> >>
> >> Hi all,
> >>
> >> this is an RFC to discuss a my idea to allow a simple rollback of the
> >> root filesystem at boot time.
> >>
> >> The problem that I want to solve is the following: DPKG is very slow on
> >> a BTRFS filesystem. The reason is that DPKG massively uses
> >> sync()/fsync() to guarantee that the filesystem is always coherent even
> >> in case of sudden shutdown.
> >>
> >> The same can be useful even to the RPM Linux based distribution (which however
> >> suffer less than DPKG).
> >>
> >> A way to avoid the sync()/fsync() calls without loosing the DPKG
> >> guarantees, is:
> >> 1) perform a snapshot of the root filesystem (the rollback one)
> >> 2) upgrade the filesystem without using sync/fsync
> >> 3) final (global) sync
> >> 4) destroy the rollback snapshot
> >
> > The idea sounds OK, but there are alternatives:
> >
> >       1) perform snapshot of root filesystem
> >       2) chroot snapshot eatmydata apt dist-upgrade (*)
> >       3) sync -f snapshot
> >       4) renameat2(..., snapshot, ..., root, RENAME_EXCHANGE)
> >       5) delete snapshot
> >
> > (*) OK you have to set up /dev, /proc, /sys, etc, probably a whole
> > namespace.
> >
> > This may not play well with maintainer scripts on some distros, but it
> > does mean you don't have a half-broken system _during_ the upgrade.
>
> Also Chris, suggested that. However I don't think that it is a viable solution:
> 1) as you pointed out, most of the maintainer pre/post install scripts assume that the system is "live". So I don't think that it would be possible without auditing and updating all the packages.

The FHS is distinctly unhelpful here. I'd go so far as to say it's a
problem. However...

If only 3-4 locations are excluded from the snapshot and rollback
regime: /home, /var/tmp, /var/lib/libvirt/images, /var/log - most
everything else can be locked from modifications while the update is
occurring prior to the reboot.

Also, users find having to reboot to deploy things, annoying. And this
would let them keep working while the update happens, and they can
reboot whenever they want - albeit with an administratively locked
system, until reboot happens and succeeds. Yanking binaries and
libraries out from under a running system is objectively worse UX and
risk.


> 2) what happens in case of unclean shutdown during step 4 ? To me it seems that we are performing two installations :-) The first one is at step 2 and the second one is at step 3. Moreover a move between two subvolumes is not allowed (it like a copy)

mv right now is an expensive copy unless the mv happens via a
subvolume in common to both locations, e.g. top-level. I don't know
what kernel changes are needed to figure this out automatically and
not require an explicit mount of that in-common subvol. But it surely
would be nice to have.


>
> Ok, this means that we have three possibility:
> 1) do this at bootloder level (eg grub)
> 2) do this at initramfs
> 3) do this at kernel level (see my patch)
>
> All these possibilities are a viable solution. However I find 1) and 2) the more "intrusive", and distro specific. My fear is that each distro will take a different choice, leading to a more fragmentation.
> I hoped that the solution nr 3, could help to find a unique solution....

I think (1) is straight out due to the lack of good a11y, and i18n
support in GRUB. Same for the initramfs. This is unfortunate, because
the snapshot discovery and read-only boot works in SUSE, but I don't
think many people want to spend more effort on things that don't
support localization and accessibility.

If there is some test that could be done automatically? Fedora has a
boot success test patch in its GRUB, used to allow the GRUB menu to be
invisible to the user unless there's a boot problem.

https://src.fedoraproject.org/rpms/grub2/blob/master/f/0131-Add-grub-set-bootflag-utility.patch

Other ideas and related work:
https://btrfs.wiki.kernel.org/index.php/Autosnap#Timeslider
https://github.com/coreos/rpm-ostree  (One item of interest that might
help with FHS madness is the logic it uses for merging /etc following
updates.)

I'm not convinced there is a role for the kernel in any of this,
beyond what functionality we've already got (and aforementioned
reflink copies without having to mount an in-common subvol).


-- 
Chris Murphy
