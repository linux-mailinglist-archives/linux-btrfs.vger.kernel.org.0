Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EE068430B9
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Jun 2019 22:03:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387846AbfFLUCd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 12 Jun 2019 16:02:33 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:53739 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728064AbfFLUCd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 12 Jun 2019 16:02:33 -0400
Received: by mail-wm1-f66.google.com with SMTP id x15so7808776wmj.3
        for <linux-btrfs@vger.kernel.org>; Wed, 12 Jun 2019 13:02:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9oDPZGu+rzVg9LpxBYF6pyOMV3T9fAwwwdMlfVWZUqE=;
        b=t28J15wLdnv6L8NMlJsRcq1W/ztaYAROtWs9/3NMxpMpuNyr6VEnBn7FCVynMSjzOI
         ZbfufPx+Ux0ipBV6na5uX4pwVRfQ/M2ywHTIQeSU6nok7H/1Fp093orzlKllY5foj8G8
         9dG3juk5N9JaCfjFT4+Eif/H9xHG3NBv6lbEWTpvjoRc8ePLBbbnmP6R1snr+ESOcF17
         wzDVrEF53a6ZjGEoc7cL5CJ7ZgFrwbnAQ9xIQoYKocnQsMBA3pKsWtsXBIxjMpHlYj1M
         AMhV1L6marD6dL6sGBcZa/vd12S4cM1jUkhc37ModthgccvOCN0pYUiqJtUIz4cpfW+A
         MCtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9oDPZGu+rzVg9LpxBYF6pyOMV3T9fAwwwdMlfVWZUqE=;
        b=JgqeTYCVr4kJpduFm5RiMbZzqCEuph79d0E0+Kdpknhb1+sYC/JqEDuTBXv6BKyC6d
         PpPX0E3sjFcojXx3U1bh3XvhAda3ycfLoyABsHIrBkGkbwvcDc577SrwrQBSKDrnJePe
         5JbRg6TWBflgcBIjGvpWI39lZ3wTxKZHdEZQ+qXNinUnx7xez9R0zA+LywiuRWsvQzvB
         9Klk82jGNtwHBtCa6bWbEYQBkdmk9ePnagjik1kFkh6KuMXZvbIMRq/y//gR6fA1ZJPh
         AtFn5bClyZx7cYjEc0sBIZfOGchhBkgxVFVfmchG49nPFwZcxAh8UP5RfqO8VApk/1TN
         fZAg==
X-Gm-Message-State: APjAAAV1tUKKs2m7r5OHxAd6jB+aL3oubF6JekCzsmmfIMkpv7EOp3qq
        tkx3F/mFsBg/7xGb4m3iVBZbBjXKhvb7XfvslQq41XKG8UE=
X-Google-Smtp-Source: APXvYqyeEmLvEf5XYb+6dlC1vgU4tcd6dPUquPPTYpaJyJWtFfbk4WcASoZCAChGc2msZ9zUwMgNkZmHq9GIx+KMqak=
X-Received: by 2002:a1c:b684:: with SMTP id g126mr606371wmf.176.1560369750260;
 Wed, 12 Jun 2019 13:02:30 -0700 (PDT)
MIME-Version: 1.0
References: <CAEg-Je9XTvEtg=Mpb1xKkO6Lzd3-yzSK7GcfbKH13uuf-u-wTA@mail.gmail.com>
 <CAJCQCtSPZwcg5y-d+mOhmyCdvq1dpzLUg05kPUg7CYhZp6Oz_Q@mail.gmail.com> <CAEg-Je8envHfMm5znrqDvW_U-RO8cOa3KF0+BmuGOB-3eC0k4A@mail.gmail.com>
In-Reply-To: <CAEg-Je8envHfMm5znrqDvW_U-RO8cOa3KF0+BmuGOB-3eC0k4A@mail.gmail.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Wed, 12 Jun 2019 14:02:19 -0600
Message-ID: <CAJCQCtTeFOCuCaqvRg4e68OA2kAYRLQgk2DL4wnPi_xgiG3anw@mail.gmail.com>
Subject: Re: APFS improvements (e.g. firm links, volume w/ subvols
 replication) as ideas for Btrfs?
To:     Neal Gompa <ngompa13@gmail.com>
Cc:     Chris Murphy <lists@colorremedies.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jun 12, 2019 at 2:07 AM Neal Gompa <ngompa13@gmail.com> wrote:
> I mean, yes... FHS is definitely unhelpful, but Apple conforms to FHS
> pretty well, even though it's not obvious that it does. Apple just has
> the benefit of being able to shuffle things around without people
> noticing, whereas no Linux distribution has that.

The vast majority of macOS is located outside the FHS in Applications,
Library, System, and Users. And in fact I don't even see the FHS
structure in the GUI where 99.9% of macOS users interact. So the FHS
is really incidental to macOS and macOS users.

My Mac looks like this:

 14G    Applications
3.7G    Library
  0B    Network
9.1G    System
4.0K    TMVersion.ini
 11G    Users
226G    Volumes
2.6M    bin
  0B    cores
4.5K    dev
  0B    etc
1.0K    home
504M    macOS Install Data
1.0K    net
6.2G    private
1.2M    sbin
  0B    tmp
473M    usr
  0B    var

The vast majority of private is a 4G hibernation image file, and a 2G
dyld cache. I'm not really sure how Apple is going to leverage APFS
for moving things around behind the scenes, it doesn't strike me as
having been a problem in search of a solution (or even vice versa).

But I can see why they'd like to have a "clean" system snapshot to
reset to, without resetting /User (use data files). To date, they have
no reset/refresh like Windows has had for some time, and software
updates are not safe and do not rollback either automatically or
manually. Their primary troubleshooting step is the "clean install" or
really the "clean reinstall". It's expected that the user has a backup
(preferably Time Machine) because it's a reformat, point and shoot
installer with no separate partition for user data.


> > > For example, this would be useful if a volume has two subvolumes: OS
> > > and data. OS would have /usr and data would have /var and /home. But,
> > > importantly, a couple of system data things need to be part of the OS
> > > that are on /var: /var/lib/rpm and /var/lib/alternatives. These two
> > > belong with the OS, and it's incredibly difficult to move it around
> > > due to all kinds of ecosystem knock-on effects.

I'd say to achieve functionally what you're after with Btrfs as it
exists today, is possible. But it would require two "views" - the
dirty realty that the updating system manages. And the kind unreality
for the user.

On Btrfs you can have a /var/lib/rpm and /var/lib/alternatives
read-write subvolume, just snapshot it, as either ro or rw (your
choice) and at the time the snapshot is created, have it created in
the OS "area" (rather than calling it a subvolume). A snapshot is just
a pre-populated subvolume, otherwise they are the same thing.

Subvolumes can also be moved just like directories if they're rw. If
they're ro, they can be renamed but not moved within the hierarchy.
It's also possible to change the ro property on any subvolume.

Of course this means there is a time delay. Your updating system would
update the "data" version of /var/lib/rpm and /var/lib/alternatives,
and then once the out of band update is finished, it would snapshot
them into the "OS" hierarchy, replacing its now stale versions of
/var/lib/rpm and /var/lib/alternatives.

Also, subvolumes can act as a barrier to snapshots. That's a big part
of how (open)SUSE is using Btrfs subvolumes, to delimit the
snapshotting. i.e. they use a grub subvolume instead of a regular
directory so that when /boot is snapshot, the changing state of the
bootloader is NOT snapshot. Same for /etc/ and parts of /var

I understand what you don't have on Btrfs, that it sounds like you'd
like to have, is a kind of wormhole between two whatevers (be they
directories or subvolumes or wormvolumes) where they are always
containing identical things. But they can independently be made ro or
rw. They can both be rw. They can both be ro. Or one can be rw and the
other ro, which would mean one of them "sends" data into the otherone,
live.

You could fake that today. But you'd need two perspectives, where 99%
of user space is aware of the fabricated perspective; and the 1% of
user space that is your OS updates and switcheroo system would need to
be aware of both perspectives and be the domain owner of managing both
perspectives.


> (If you want to know
> > > more about that, just ask the SUSE kiwi team... it's the gift that
> > > keeps on giving...). Both /var/lib/rpm and /var/lib/alternatives are
> > > part of the OS, but they're in /var. It'd be great to stitch that in
> > > from the read-only OS volume into the /var subvolume so that it's
> > > actually part of the OS volume even though it looks like it's in the
> > > data one. It's completely transparent to everything.

I'm having a hard time visualizing what Apple is doing or going to do.
I expect like most things there will be some daemon that understands
all the new ioctls and does the actual work of changing the storage
hierarchy states. It's transparent to 99% of the OS and user space,
but this one daemon must understand the real deal in order to "fake"
it with the creation of firm links and whatever else they do.
Something in user space must know about firm links in order to
leverage firm links.

> Supporting atomic
> > > updates (with something like a dnf plugin) becomes much easier because
> > > we can trigger snapshot and subvolume mounts with preserving enough
> > > structure to make things work. In this circumstance, we can flip the
> > > properties so that the new location has a rw OS and ro data volume
> > > mount for doing only software updates (or leave data volume rw during
> > > this transaction and merge the changes back into the OS). We could
> > > also do creative things with /etc if we so wish...

I've done out of band software updates with dnf already myself, this
is a quick and dirty example:

# btrfs sub snap root.20190610 root.20190612
# mount -o subvol=root.20190612 /mnt/updates
# mount -B ## all the dev proc run sys stuff to /mnt/updates
# chroot /mnt/updates
# dnf update -y
# exit
# vi /mnt/updates/etc/fstab ##point the root to root.20190612
# umount --resursive ## tear it down
# grub2-editenv - set kernelopts= ##change rootflags to use the new subvol

Reboot. Now the last step is janky and does not take advantage of any
fallback we now have in GRUB at least in Fedora land. To do that I
need to so a bit more surgery manually to create new BLS snippets to
make an explicit "former" "current" boot menu entry that causes the
correct subvolume to become root.

But anyway, point is, I can do out of band updates, the currently
active OS doesn't get confused as the update process is yanking out
updates from underneath it all, and I don't have to mount /home in
that process at all. That chroot (or it can be done with bwrap or
nspawn or whatever) environment does not have my home in it. The
update process can't hurt it. And if the update fails, just delete the
bad subvolume, no harm done.

And libostree actually does a very close variation on that.

> >
> > Is it really best to do this in Btrfs proper, rather than in VFS?
> >
>
> If we can handle it in VFS where things like firm links drag linked
> subvolumes to be automatically mounted together at their individually
> set snapshot level, then yeah. But best as I understand it, the VFS
> layer is not capable of this level of granularity.

Yeah I kinda need pretty pictures and animations and things to
understand this better, I'm not really completely understanding the
problem. I'm very aware of Apple's severe limitations with updates and
rollbacks, and why they want a way out of that. But I'm not clear on
why Btrfs should mimick that particular behavior and solution for
their problem, seeing as only one distro defaults to Btrfs yet doesn't
require it, and Fedoraland is pretty much completely over Btrfs, while
Red Hat is building a whole new userland file system which for sure is
not going to have wormhold dirs between its fully independent volumes
- it'd really need something done in VFS or if it can't be done in VFS
then possibly leverage overlayfs for some of this.


>
> This is probably one issue with Btrfs that ZFS gets to avoid, since
> ZFS can't use VFS and thus implements everything at its level. I'm not
> suggesting Btrfs do it for everything, but the filesystem needs some
> intelligence about subvolume handling that it doesn't have now.

ZFS is way more limited in this regard than Btrfs. Snapshots are
always children of datasets, they are always read only. You can clone
a snapshot into a dataset. I don't think (?) there is such a thing as
nested datasets or snapshots. Datasets can't be deleted until all
children (snapshots) are deleted first. In many ways ZFS limitations
keep users from doing things like many nested subvolumes like we see
on Btrfs and then it turns into logical problems for users and
developers alike.

So a non-Btrfs solution is going to need higher level advancements
anyway, either VFS over overlayfs or some combination of the two.

--
Chris Murphy
