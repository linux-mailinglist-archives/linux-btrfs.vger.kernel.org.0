Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2E11D41EA3
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Jun 2019 10:07:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436750AbfFLIHV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 12 Jun 2019 04:07:21 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:46002 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726716AbfFLIHV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 12 Jun 2019 04:07:21 -0400
Received: by mail-qk1-f195.google.com with SMTP id s22so9485493qkj.12
        for <linux-btrfs@vger.kernel.org>; Wed, 12 Jun 2019 01:07:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=2RLI1Ux9Wo+tKtYma1gE2z43SXRRSIspmODHozALDrQ=;
        b=HBykwv/BsQxoeiteLTd6yeNsmDfTIK/UZHtpmlGnvCuNvt5g9sIBY7U/ta0UL4oRpa
         Zv+q7PsLba1QiU6vL4lDArYKmbXiPjtvFHPjAzWSHOBDzUP0hiEZc2AVwzyetxkp5XAT
         qdmyUBVxU6cf7gaygp+NF0FzSgvvdxHK0bdWbKGx151KDAy46CQxVlYzE0QIEtMw+2f0
         jON8F/6C1+7k5pnm+NYMKxXuyDyyUZWOrPfu0GPHOiX1yux7Bwi57FJTcR9argmP6AhA
         Lq+yQ42z9qZ/qLGemAiD4ze0uW4FDVQ5zJC6lYKZ/l6Q/7s/dMPJ6VTlko+GsckFBDt4
         D8SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=2RLI1Ux9Wo+tKtYma1gE2z43SXRRSIspmODHozALDrQ=;
        b=Zw1i8H9Qg9Fp8tOn2/fuTiU/fCckKQhKTLtKU5HmymVurISaYqCZI2dDphO0zPxh9O
         gULfWt7R9uXOUAsfCbTQjlpTIbW4pycTpuNzuK+qfnROUBoMBqIRKFGYLz//KG9h+6OO
         PGOmI828F7nwMQ5yUp63ySP2uqS1CUN1sC7MXTaPWlggGXQ/FehmczK/UvZMlUGPKjI7
         qFpaYCzx/u7vcFSWJwAi19U76nGMIm6h0XPqYrFY1UXz3AjIWtSbUaiuOZZc+4crq24/
         Sr5pXf5y+c7f7IP0yj+hYk2FtY+gYj5BOne5pY7LLUS+Yp3c1ThirTlbcRegTdVBU+lo
         rkGQ==
X-Gm-Message-State: APjAAAW+XOPCpsKej9EzQJpHbDpDHZWx0wfd2q2x4gGuushAVrtXUxQv
        wtPAVxqDcRX0XaJBvvZuj8awwndazGTjm8zqxKdHiyTJ
X-Google-Smtp-Source: APXvYqxIPz7yifnycfYr6yiqvWSjfSi2cURLxozMM6vvKEDOzXbl5VvL+c+7LSJmJKUxTAwYpCZW17D3evky4E3aMUw=
X-Received: by 2002:a05:620a:12db:: with SMTP id e27mr53340200qkl.352.1560326839584;
 Wed, 12 Jun 2019 01:07:19 -0700 (PDT)
MIME-Version: 1.0
References: <CAEg-Je9XTvEtg=Mpb1xKkO6Lzd3-yzSK7GcfbKH13uuf-u-wTA@mail.gmail.com>
 <CAJCQCtSPZwcg5y-d+mOhmyCdvq1dpzLUg05kPUg7CYhZp6Oz_Q@mail.gmail.com>
In-Reply-To: <CAJCQCtSPZwcg5y-d+mOhmyCdvq1dpzLUg05kPUg7CYhZp6Oz_Q@mail.gmail.com>
From:   Neal Gompa <ngompa13@gmail.com>
Date:   Wed, 12 Jun 2019 04:06:41 -0400
Message-ID: <CAEg-Je8envHfMm5znrqDvW_U-RO8cOa3KF0+BmuGOB-3eC0k4A@mail.gmail.com>
Subject: Re: APFS improvements (e.g. firm links, volume w/ subvols
 replication) as ideas for Btrfs?
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jun 12, 2019 at 12:04 AM Chris Murphy <lists@colorremedies.com> wro=
te:
>
> On Tue, Jun 11, 2019 at 12:31 PM Neal Gompa <ngompa13@gmail.com> wrote:
> >
> > Hey,
> >
> > So Apple held its WWDC event last week, and among other things, they
> > talked about improvements they've made to filesystems in macOS[1].
> >
> > Among other things, one of the things introduced was a concept of
> > "firm links", which is something like NTFS' directory junctions,
> > except they can cross (sub)volumes.
>
> My understanding is it's a work around for the lack of APFS supporting
> directory hardlinks. Btrfs does support directory hardlinks but a
> hardlink points to a particular inode within a particular subvolume
> (files tree) so it's not possible to have a hard link that crosses
> subvolumes. A reflink can already do this, but it's really just an
> efficient copy, the resulting directory is independent. A directory
> symlink can mirror a directory across subvolumes, but like any symlink
> it must have a fixed path available to always find the real deal.
>
> I think a firm link like thing on Btrfs would require a format change,
> but I'm not certain. My best guess of what it'd be, is a dir/file
> object that gets its own inode but contains a hard reference (not
> independent object) to a subvolid+inode.
>
>
> >This concept makes it easier to
> > handle uglier layouts. While bind mounts work kind of okay for this
> > with simpler configurations, it requires operating system awareness,
> > rather than being setup automatically as the volume is mounted. This
> > is less brittle and works better for recovery environments, and help
> > make easier to do read-only system volumes while supported read-write
> > sections in a more flexible way.
>
> There are a couple of things going on. One is something between VFS
> and Btrfs does this goofy assumption that bind mounts are subvolumes,
> which is definitely not true. I bring this up here:
> https://lore.kernel.org/linux-btrfs/CAJCQCtT=3D-YoFJgEo=3DBFqfiPdtMoJCYR3=
dJPSekf+HQ22GYGztw@mail.gmail.com/
>
> Near as I can tell, Btrfs kernel code just needs to be smarter about
> distinguishing between bind mounts of directories versus the behind
> the scene bind mount used for subvolumes mounted using -o subvol=3D or
> -o subvolid=3D ; I don't think that's difficult. It's just someone needs
> to work through the logic and set aside the resources to do it.
>
> Second, the FHS is a PITA anyway, but it really shows its unhelpful
> ways when it comes to read-only, recoverable/resettable systems. Just
> see the massively complicated subvolume carveouts opensuse has to do
> when installed on Btrfs, and the even more complicated gymnastics
> libostree is doing on the various rpm-ostree variants including Fedora
> Silverblue.
>
> Apple, a long long time ago said, fuck that insanity, we're burying
> the FHS so mortal users can't see that shit. And we're going to have a
> plain language set of directories for, you know, actual people who
> need to get work done.
>
> So definitely consider me in the camp of the FHS making life harder, not =
easier.
>

I mean, yes... FHS is definitely unhelpful, but Apple conforms to FHS
pretty well, even though it's not obvious that it does. Apple just has
the benefit of being able to shuffle things around without people
noticing, whereas no Linux distribution has that.

> >
> > For example, this would be useful if a volume has two subvolumes: OS
> > and data. OS would have /usr and data would have /var and /home. But,
> > importantly, a couple of system data things need to be part of the OS
> > that are on /var: /var/lib/rpm and /var/lib/alternatives. These two
> > belong with the OS, and it's incredibly difficult to move it around
> > due to all kinds of ecosystem knock-on effects. (If you want to know
> > more about that, just ask the SUSE kiwi team... it's the gift that
> > keeps on giving...). Both /var/lib/rpm and /var/lib/alternatives are
> > part of the OS, but they're in /var. It'd be great to stitch that in
> > from the read-only OS volume into the /var subvolume so that it's
> > actually part of the OS volume even though it looks like it's in the
> > data one. It's completely transparent to everything. Supporting atomic
> > updates (with something like a dnf plugin) becomes much easier because
> > we can trigger snapshot and subvolume mounts with preserving enough
> > structure to make things work. In this circumstance, we can flip the
> > properties so that the new location has a rw OS and ro data volume
> > mount for doing only software updates (or leave data volume rw during
> > this transaction and merge the changes back into the OS). We could
> > also do creative things with /etc if we so wish...
>
> Is it really best to do this in Btrfs proper, rather than in VFS?
>

If we can handle it in VFS where things like firm links drag linked
subvolumes to be automatically mounted together at their individually
set snapshot level, then yeah. But best as I understand it, the VFS
layer is not capable of this level of granularity.

This is probably one issue with Btrfs that ZFS gets to avoid, since
ZFS can't use VFS and thus implements everything at its level. I'm not
suggesting Btrfs do it for everything, but the filesystem needs some
intelligence about subvolume handling that it doesn't have now.

>
> > Another thing that APFS seems to support now is creating linked
> > snapshots (snapshots of multiple subvolumes that are paired together
> > as single snapshot) for full system replication. Obviously, with firm
> > links, it makes sense to be able to do such a thing so that full
> > system replication works properly. As far as I know, it shouldn't be a
> > difficult concept to implement in Btrfs, but I guess it wouldn't be
> > really necessary if we don't have firm links...
>
> Right now a subvolume is really just a files tree. It's not as
> separate as it might seem from the pool, compared to what a ZFS
> dataset is, or I guess it's called a volume is in APFS. To do this on
> Btrfs probably is another disk format change. My guess is something
> based on seed-sprout feature, but without the mandatory 2nd block
> device for the spout. i.e. freeze all the trees.
>

Hmm... That makes sense. I think it would be good to have it for the
cases I've mentioned...


--=20
=E7=9C=9F=E5=AE=9F=E3=81=AF=E3=81=84=E3=81=A4=E3=82=82=E4=B8=80=E3=81=A4=EF=
=BC=81/ Always, there's only one truth!
