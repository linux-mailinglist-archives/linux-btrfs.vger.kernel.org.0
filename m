Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8C70043B3C
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Jun 2019 17:27:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728195AbfFMP1P (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 13 Jun 2019 11:27:15 -0400
Received: from mail-io1-f53.google.com ([209.85.166.53]:45416 "EHLO
        mail-io1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729037AbfFMLhT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 13 Jun 2019 07:37:19 -0400
Received: by mail-io1-f53.google.com with SMTP id e3so16060488ioc.12
        for <linux-btrfs@vger.kernel.org>; Thu, 13 Jun 2019 04:37:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3UqIUAkvVULPGcJAjpBr0ZaHKJkntUa36w/vNXszc7A=;
        b=fOv+Gtz4pVq3JQDnMi6KdVf25OQ9NKoJPRb6IhC1BY1H3QWzfO9qRhFkZCWTk8z5qn
         ysfdKTIk4YHgOn9PneXuIPcfWMbcrtO79i4sBfeT7uAMxucgY+9fAi6RMruwUI+7FsS0
         valtSSz/Xhqwk1SZaflODrCfoXYprQ42nY9CDWcxyscAVx+E7Z9s4q+eP+oRrJItcuOb
         XOAEkhuBcPvumeUIYj22L+AJYqZ9nr0JXIG/BWqUp4VANxzeqKVJrCb6atSzFu1iD8SV
         zo5BLxWjzDLlG5Y+OPp/iI5ZpWG0g2nde8EkblbYNSE5oUhC9MGds2WokYrem6aQdiQ0
         Of/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3UqIUAkvVULPGcJAjpBr0ZaHKJkntUa36w/vNXszc7A=;
        b=DmSqZgw/aUm+4uUpCN+6WbslRme6hI9btrEE+Kiqtl0ByfY8HoOd+nH6oe1RAGmesP
         EpO3/TOMcQTMPMfaaq1TzPrK7RL0dcQbrwfLgeULsFK1/35hV1rqu+IyCYJ/7bAJISaO
         NAGyDdIoqkoQtlwYgTxbzslVV+kkrAq3dKqSrKyqumpt4o+vd+W9BK76NhYt2Dt6HXTK
         spN80+gUD8kTHtkNDlUuA8un1z5a5gaLZ0z0L372af0+YAj44GnlaTJ8WHRL8gyeo+SE
         xS7BrPTowtE4kXlYX+BFTYTUOC2NZz+R/dodtlq4xnBiTPiTtBlgFC8Y9TNpoYPws3UC
         QZKg==
X-Gm-Message-State: APjAAAVi4d9lIqYvhM3cvNhpVIZv1lVtb4hhOOqPr+TWtcWZAzrjNEWv
        xQ2V/yUr61jmLZxfaFInWOw=
X-Google-Smtp-Source: APXvYqw9/hO3O1QnY/mrrQKYO0e8EHKSEfKP3pMhBcM9ZXsciTEVwiUYFD4EA8a52Qa8E3QbsUvt8g==
X-Received: by 2002:a02:9567:: with SMTP id y94mr60442994jah.28.1560425838329;
        Thu, 13 Jun 2019 04:37:18 -0700 (PDT)
Received: from [191.9.209.46] (rrcs-70-62-41-24.central.biz.rr.com. [70.62.41.24])
        by smtp.gmail.com with ESMTPSA id t4sm941311ioj.26.2019.06.13.04.37.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Jun 2019 04:37:17 -0700 (PDT)
Subject: Re: APFS improvements (e.g. firm links, volume w/ subvols
 replication) as ideas for Btrfs?
To:     Chris Murphy <lists@colorremedies.com>,
        Neal Gompa <ngompa13@gmail.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
References: <CAEg-Je9XTvEtg=Mpb1xKkO6Lzd3-yzSK7GcfbKH13uuf-u-wTA@mail.gmail.com>
 <CAJCQCtSPZwcg5y-d+mOhmyCdvq1dpzLUg05kPUg7CYhZp6Oz_Q@mail.gmail.com>
 <CAEg-Je8envHfMm5znrqDvW_U-RO8cOa3KF0+BmuGOB-3eC0k4A@mail.gmail.com>
 <CAJCQCtTeFOCuCaqvRg4e68OA2kAYRLQgk2DL4wnPi_xgiG3anw@mail.gmail.com>
From:   "Austin S. Hemmelgarn" <ahferroin7@gmail.com>
Message-ID: <82503321-6ad1-a6d0-fa87-d00bb85b705c@gmail.com>
Date:   Thu, 13 Jun 2019 07:37:14 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <CAJCQCtTeFOCuCaqvRg4e68OA2kAYRLQgk2DL4wnPi_xgiG3anw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2019-06-12 16:02, Chris Murphy wrote:
> On Wed, Jun 12, 2019 at 2:07 AM Neal Gompa <ngompa13@gmail.com> wrote:
>> I mean, yes... FHS is definitely unhelpful, but Apple conforms to FHS
>> pretty well, even though it's not obvious that it does. Apple just has
>> the benefit of being able to shuffle things around without people
>> noticing, whereas no Linux distribution has that.
> 
> The vast majority of macOS is located outside the FHS in Applications,
> Library, System, and Users. And in fact I don't even see the FHS
> structure in the GUI where 99.9% of macOS users interact. So the FHS
> is really incidental to macOS and macOS users.
> 
> My Mac looks like this:
> 
>   14G    Applications
> 3.7G    Library
>    0B    Network
> 9.1G    System
> 4.0K    TMVersion.ini
>   11G    Users
> 226G    Volumes
> 2.6M    bin
>    0B    cores
> 4.5K    dev
>    0B    etc
> 1.0K    home
> 504M    macOS Install Data
> 1.0K    net
> 6.2G    private
> 1.2M    sbin
>    0B    tmp
> 473M    usr
>    0B    var
> 
> The vast majority of private is a 4G hibernation image file, and a 2G
> dyld cache. I'm not really sure how Apple is going to leverage APFS
> for moving things around behind the scenes, it doesn't strike me as
> having been a problem in search of a solution (or even vice versa).
> 
> But I can see why they'd like to have a "clean" system snapshot to
> reset to, without resetting /User (use data files). To date, they have
> no reset/refresh like Windows has had for some time, and software
> updates are not safe and do not rollback either automatically or
> manually. Their primary troubleshooting step is the "clean install" or
> really the "clean reinstall". It's expected that the user has a backup
> (preferably Time Machine) because it's a reformat, point and shoot
> installer with no separate partition for user data.
> 
> 
>>>> For example, this would be useful if a volume has two subvolumes: OS
>>>> and data. OS would have /usr and data would have /var and /home. But,
>>>> importantly, a couple of system data things need to be part of the OS
>>>> that are on /var: /var/lib/rpm and /var/lib/alternatives. These two
>>>> belong with the OS, and it's incredibly difficult to move it around
>>>> due to all kinds of ecosystem knock-on effects.
> 
> I'd say to achieve functionally what you're after with Btrfs as it
> exists today, is possible. But it would require two "views" - the
> dirty realty that the updating system manages. And the kind unreality
> for the user.
> 
> On Btrfs you can have a /var/lib/rpm and /var/lib/alternatives
> read-write subvolume, just snapshot it, as either ro or rw (your
> choice) and at the time the snapshot is created, have it created in
> the OS "area" (rather than calling it a subvolume). A snapshot is just
> a pre-populated subvolume, otherwise they are the same thing.
> 
> Subvolumes can also be moved just like directories if they're rw. If
> they're ro, they can be renamed but not moved within the hierarchy.
> It's also possible to change the ro property on any subvolume.
> 
> Of course this means there is a time delay. Your updating system would
> update the "data" version of /var/lib/rpm and /var/lib/alternatives,
> and then once the out of band update is finished, it would snapshot
> them into the "OS" hierarchy, replacing its now stale versions of
> /var/lib/rpm and /var/lib/alternatives.
> 
> Also, subvolumes can act as a barrier to snapshots. That's a big part
> of how (open)SUSE is using Btrfs subvolumes, to delimit the
> snapshotting. i.e. they use a grub subvolume instead of a regular
> directory so that when /boot is snapshot, the changing state of the
> bootloader is NOT snapshot. Same for /etc/ and parts of /var
> 
> I understand what you don't have on Btrfs, that it sounds like you'd
> like to have, is a kind of wormhole between two whatevers (be they
> directories or subvolumes or wormvolumes) where they are always
> containing identical things. But they can independently be made ro or
> rw. They can both be rw. They can both be ro. Or one can be rw and the
> other ro, which would mean one of them "sends" data into the otherone,
> live.
> 
> You could fake that today. But you'd need two perspectives, where 99%
> of user space is aware of the fabricated perspective; and the 1% of
> user space that is your OS updates and switcheroo system would need to
> be aware of both perspectives and be the domain owner of managing both
> perspectives.
> 
> 
>> (If you want to know
>>>> more about that, just ask the SUSE kiwi team... it's the gift that
>>>> keeps on giving...). Both /var/lib/rpm and /var/lib/alternatives are
>>>> part of the OS, but they're in /var. It'd be great to stitch that in
>>>> from the read-only OS volume into the /var subvolume so that it's
>>>> actually part of the OS volume even though it looks like it's in the
>>>> data one. It's completely transparent to everything.
> 
> I'm having a hard time visualizing what Apple is doing or going to do.
> I expect like most things there will be some daemon that understands
> all the new ioctls and does the actual work of changing the storage
> hierarchy states. It's transparent to 99% of the OS and user space,
> but this one daemon must understand the real deal in order to "fake"
> it with the creation of firm links and whatever else they do.
> Something in user space must know about firm links in order to
> leverage firm links.
> 
>> Supporting atomic
>>>> updates (with something like a dnf plugin) becomes much easier because
>>>> we can trigger snapshot and subvolume mounts with preserving enough
>>>> structure to make things work. In this circumstance, we can flip the
>>>> properties so that the new location has a rw OS and ro data volume
>>>> mount for doing only software updates (or leave data volume rw during
>>>> this transaction and merge the changes back into the OS). We could
>>>> also do creative things with /etc if we so wish...
> 
> I've done out of band software updates with dnf already myself, this
> is a quick and dirty example:
> 
> # btrfs sub snap root.20190610 root.20190612
> # mount -o subvol=root.20190612 /mnt/updates
> # mount -B ## all the dev proc run sys stuff to /mnt/updates
> # chroot /mnt/updates
> # dnf update -y
> # exit
> # vi /mnt/updates/etc/fstab ##point the root to root.20190612
> # umount --resursive ## tear it down
> # grub2-editenv - set kernelopts= ##change rootflags to use the new subvol
> 
> Reboot. Now the last step is janky and does not take advantage of any
> fallback we now have in GRUB at least in Fedora land. To do that I
> need to so a bit more surgery manually to create new BLS snippets to
> make an explicit "former" "current" boot menu entry that causes the
> correct subvolume to become root.
> 
> But anyway, point is, I can do out of band updates, the currently
> active OS doesn't get confused as the update process is yanking out
> updates from underneath it all, and I don't have to mount /home in
> that process at all. That chroot (or it can be done with bwrap or
> nspawn or whatever) environment does not have my home in it. The
> update process can't hurt it. And if the update fails, just delete the
> bad subvolume, no harm done.
> 
> And libostree actually does a very close variation on that.
And there are other people doing essentially the same thing too.  Where 
I work, we do something similar to implement fast rollback of failed 
updates, and I've been working intermittently on a wrapper for emerge 
(Gentoo's package manger) to do the same type of thing.
> 
>>>
>>> Is it really best to do this in Btrfs proper, rather than in VFS?
>>>
>>
>> If we can handle it in VFS where things like firm links drag linked
>> subvolumes to be automatically mounted together at their individually
>> set snapshot level, then yeah. But best as I understand it, the VFS
>> layer is not capable of this level of granularity.
> 
> Yeah I kinda need pretty pictures and animations and things to
> understand this better, I'm not really completely understanding the
> problem. I'm very aware of Apple's severe limitations with updates and
> rollbacks, and why they want a way out of that. But I'm not clear on
> why Btrfs should mimick that particular behavior and solution for
> their problem, seeing as only one distro defaults to Btrfs yet doesn't
> require it, and Fedoraland is pretty much completely over Btrfs, while
> Red Hat is building a whole new userland file system which for sure is
> not going to have wormhold dirs between its fully independent volumes
> - it'd really need something done in VFS or if it can't be done in VFS
> then possibly leverage overlayfs for some of this.
Put simply, firm links are essentially hard links for subvolumes that 
can have differing VFS-level metadata.

Also, you can achieve the same outcome WRT updates just using regular 
OverlayFS and snapshots.  Make your root filesystem an overlay mount 
with the user data subvolume as the upper writable layer, and the OS 
subvolume as the lower read-only layer.  When you go to update, you 
create a writable snapshot of the OS subvolume, run the updates on the 
snapshot, update the configuration to use the snapshot as the lower 
layer on reboot, then reboot.  The only hard part is handling the 
OverlayFS configuration.
> 
> 
>>
>> This is probably one issue with Btrfs that ZFS gets to avoid, since
>> ZFS can't use VFS and thus implements everything at its level. I'm not
>> suggesting Btrfs do it for everything, but the filesystem needs some
>> intelligence about subvolume handling that it doesn't have now.
> 
> ZFS is way more limited in this regard than Btrfs. Snapshots are
> always children of datasets, they are always read only. You can clone
> a snapshot into a dataset. I don't think (?) there is such a thing as
> nested datasets or snapshots. Datasets can't be deleted until all
> children (snapshots) are deleted first. In many ways ZFS limitations
> keep users from doing things like many nested subvolumes like we see
> on Btrfs and then it turns into logical problems for users and
> developers alike.
There is hierarchical nesting of datasets, but it's 100% independent of 
the mount hierarchy as far as ZFS itself is concerned, it only gets used 
for things like quota management and property inheritance.
> 
> So a non-Btrfs solution is going to need higher level advancements
> anyway, either VFS over overlayfs or some combination of the two.
