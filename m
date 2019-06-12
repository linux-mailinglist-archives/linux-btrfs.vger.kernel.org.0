Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 57B5741AE7
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Jun 2019 06:04:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726585AbfFLEEG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 12 Jun 2019 00:04:06 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46849 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725280AbfFLEEF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 12 Jun 2019 00:04:05 -0400
Received: by mail-wr1-f66.google.com with SMTP id n4so15182988wrw.13
        for <linux-btrfs@vger.kernel.org>; Tue, 11 Jun 2019 21:04:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dl5L/NpuoxAoGZqRRlMiJ9aL22KsZ0egO4M+Py5QceA=;
        b=iytgooO7YwFQ19z8dSyiQdgnWuf8F62dElf8U/q7lgKTofvf441FHpxEROdIvBEuFp
         kcOX05dXSZGB69qpr8oEy+gORmFqDOim7aRbvrYSyGoU5I4s4fIB5lgk7uHAI6V+aKEW
         o36shfXCnNyQLODxGAL7wKfoBJg47GA7BdRaVqMIh0rz5P4FZhFFNpmnU6A1uOtsbJli
         JNfmFU3/2bMA6Cxv844bYctmHXew+3Jw5lewpyzah2lK38zn4YGE3aRkDqSRNFRN7mYG
         IL3uJygMo6FncWsHvaK8+4eBuCWCv2BNHvKBkxcWDeYML3EdF/eaFOG1ADoySc3Wjl9S
         WsSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dl5L/NpuoxAoGZqRRlMiJ9aL22KsZ0egO4M+Py5QceA=;
        b=tA0N0TPdDQIH5XCgff/sI/M/hVVF5I9ybnT7wSgBJyscTeCNq0cTybdExLmoJF6sT2
         d2uZQVfGjH3euMak/Ia0hcQTLj21tTgEoekT6en9WhHopzj2YxOGTo/UK8KnNCiaaHlH
         RewdU3oM/ioqpEEuKFr6rNZJDoAQkFTrJtnRNU7NSDBXyo0KOScBHPR87yMqaqRpYJKE
         Ca5qu0eAON/oL1HoTu6GoEBdx/Mie89eol65tBxacMylLJ2tZVluhwOxxJJM3xxrcnK8
         C9PGDSFVOoMR+4K0Mpwwt2QV5RqoyJ0ajTZJGSU1+8GVyF59KcVuEa57OLD5S5bDmPjG
         2Fxw==
X-Gm-Message-State: APjAAAWpqH8RINVe+I5jLFiq9dlf3PivnkNCU7A4+5a5TSNeh6HstxOG
        Z93SuWJva3hBux6MybVIbACgEtDbZ05T1+OdqcUJlVRYm6c=
X-Google-Smtp-Source: APXvYqya+azEyfTrlXEeqvXISbETn+nG4p+JBUOtFPsWlAhV71E7tq/Y8uqHQd+ZOYt9eRMT1frGKMKx0blfUz7rLV0=
X-Received: by 2002:a05:6000:4b:: with SMTP id k11mr1402519wrx.82.1560312243082;
 Tue, 11 Jun 2019 21:04:03 -0700 (PDT)
MIME-Version: 1.0
References: <CAEg-Je9XTvEtg=Mpb1xKkO6Lzd3-yzSK7GcfbKH13uuf-u-wTA@mail.gmail.com>
In-Reply-To: <CAEg-Je9XTvEtg=Mpb1xKkO6Lzd3-yzSK7GcfbKH13uuf-u-wTA@mail.gmail.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Tue, 11 Jun 2019 22:03:51 -0600
Message-ID: <CAJCQCtSPZwcg5y-d+mOhmyCdvq1dpzLUg05kPUg7CYhZp6Oz_Q@mail.gmail.com>
Subject: Re: APFS improvements (e.g. firm links, volume w/ subvols
 replication) as ideas for Btrfs?
To:     Neal Gompa <ngompa13@gmail.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        Chris Murphy <lists@colorremedies.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jun 11, 2019 at 12:31 PM Neal Gompa <ngompa13@gmail.com> wrote:
>
> Hey,
>
> So Apple held its WWDC event last week, and among other things, they
> talked about improvements they've made to filesystems in macOS[1].
>
> Among other things, one of the things introduced was a concept of
> "firm links", which is something like NTFS' directory junctions,
> except they can cross (sub)volumes.

My understanding is it's a work around for the lack of APFS supporting
directory hardlinks. Btrfs does support directory hardlinks but a
hardlink points to a particular inode within a particular subvolume
(files tree) so it's not possible to have a hard link that crosses
subvolumes. A reflink can already do this, but it's really just an
efficient copy, the resulting directory is independent. A directory
symlink can mirror a directory across subvolumes, but like any symlink
it must have a fixed path available to always find the real deal.

I think a firm link like thing on Btrfs would require a format change,
but I'm not certain. My best guess of what it'd be, is a dir/file
object that gets its own inode but contains a hard reference (not
independent object) to a subvolid+inode.


>This concept makes it easier to
> handle uglier layouts. While bind mounts work kind of okay for this
> with simpler configurations, it requires operating system awareness,
> rather than being setup automatically as the volume is mounted. This
> is less brittle and works better for recovery environments, and help
> make easier to do read-only system volumes while supported read-write
> sections in a more flexible way.

There are a couple of things going on. One is something between VFS
and Btrfs does this goofy assumption that bind mounts are subvolumes,
which is definitely not true. I bring this up here:
https://lore.kernel.org/linux-btrfs/CAJCQCtT=-YoFJgEo=BFqfiPdtMoJCYR3dJPSekf+HQ22GYGztw@mail.gmail.com/

Near as I can tell, Btrfs kernel code just needs to be smarter about
distinguishing between bind mounts of directories versus the behind
the scene bind mount used for subvolumes mounted using -o subvol= or
-o subvolid= ; I don't think that's difficult. It's just someone needs
to work through the logic and set aside the resources to do it.

Second, the FHS is a PITA anyway, but it really shows its unhelpful
ways when it comes to read-only, recoverable/resettable systems. Just
see the massively complicated subvolume carveouts opensuse has to do
when installed on Btrfs, and the even more complicated gymnastics
libostree is doing on the various rpm-ostree variants including Fedora
Silverblue.

Apple, a long long time ago said, fuck that insanity, we're burying
the FHS so mortal users can't see that shit. And we're going to have a
plain language set of directories for, you know, actual people who
need to get work done.

So definitely consider me in the camp of the FHS making life harder, not easier.

>
> For example, this would be useful if a volume has two subvolumes: OS
> and data. OS would have /usr and data would have /var and /home. But,
> importantly, a couple of system data things need to be part of the OS
> that are on /var: /var/lib/rpm and /var/lib/alternatives. These two
> belong with the OS, and it's incredibly difficult to move it around
> due to all kinds of ecosystem knock-on effects. (If you want to know
> more about that, just ask the SUSE kiwi team... it's the gift that
> keeps on giving...). Both /var/lib/rpm and /var/lib/alternatives are
> part of the OS, but they're in /var. It'd be great to stitch that in
> from the read-only OS volume into the /var subvolume so that it's
> actually part of the OS volume even though it looks like it's in the
> data one. It's completely transparent to everything. Supporting atomic
> updates (with something like a dnf plugin) becomes much easier because
> we can trigger snapshot and subvolume mounts with preserving enough
> structure to make things work. In this circumstance, we can flip the
> properties so that the new location has a rw OS and ro data volume
> mount for doing only software updates (or leave data volume rw during
> this transaction and merge the changes back into the OS). We could
> also do creative things with /etc if we so wish...

Is it really best to do this in Btrfs proper, rather than in VFS?


> Another thing that APFS seems to support now is creating linked
> snapshots (snapshots of multiple subvolumes that are paired together
> as single snapshot) for full system replication. Obviously, with firm
> links, it makes sense to be able to do such a thing so that full
> system replication works properly. As far as I know, it shouldn't be a
> difficult concept to implement in Btrfs, but I guess it wouldn't be
> really necessary if we don't have firm links...

Right now a subvolume is really just a files tree. It's not as
separate as it might seem from the pool, compared to what a ZFS
dataset is, or I guess it's called a volume is in APFS. To do this on
Btrfs probably is another disk format change. My guess is something
based on seed-sprout feature, but without the mandatory 2nd block
device for the spout. i.e. freeze all the trees.

--
Chris Murphy
