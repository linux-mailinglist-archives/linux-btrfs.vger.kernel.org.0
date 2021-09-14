Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7889940B357
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Sep 2021 17:42:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234879AbhINPny (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 14 Sep 2021 11:43:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234826AbhINPnw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 14 Sep 2021 11:43:52 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B795C061574
        for <linux-btrfs@vger.kernel.org>; Tue, 14 Sep 2021 08:42:35 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id c79so19584022oib.11
        for <linux-btrfs@vger.kernel.org>; Tue, 14 Sep 2021 08:42:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nBIPu/N9VfJTE2zWgdFMghk4WeavoB2NcSlZ51WvIvM=;
        b=UjZ4xsqr/Yq8BeTrHtNLakyi81x4BFX9i2VnfyKaWAxqnRhj9btWYHAvIOodRNIjvZ
         IldYzZ7MyVvBKHy3TeFMhipmC/nI+JPthz1CQ5/bbbiwtsA2VbkcXjcE1W4HJDY1s/MZ
         XEabxoEqm6kNPQxj0Etoass6tzsLofXKXacfLx779lBz0RfhQO7tcvYuyrScKijgmOSB
         sszNrUIAviFlQ/ELd81NHWbQ8bq4U6T9nyV6SQX4GIqWHpIdGVksT80qvRBQ7lsjj5zH
         voA07mhbROHteZq2GkYIPZ8CNNdYTQ4TDbPFxuJMjUmWvWunuWW8oAwngQBUlShNCFBS
         KzFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nBIPu/N9VfJTE2zWgdFMghk4WeavoB2NcSlZ51WvIvM=;
        b=KRYskzLtEmUuz5opKSzt8rCKCms60MW/aUGbEXmFrhL7HyF+Oi+shqkPTogDDqAyc6
         x5arMvRo6vLJWzTMPZSAOR8PyEQiH427v3kAydFW3qhC7BvH6dyfGKN9odEUx511i0hw
         RQeE8flGmzE2apWHdk7pfFvQFeGX5gr9cJNu2AzNHig4/hgQzH0bLyTgBeivNQqUiqls
         qzjW7qD163UZelEXOsn1ql2QFmJAHSeB8pr5YADyrdk77XAJrbR0FrBRe8HpacHuyq/u
         Cuy/QnwRRZBn7G8KPj0wPiLeFGCtvQ7cDNSJE/qiVTTSiUFyyUfsu1xT9VBsYYJ47rgv
         oIvA==
X-Gm-Message-State: AOAM532a+ELGH7aYo45WobxvXkHS5Sg/rVTlyc74g1/QcqpqwlD36Ndr
        +RKLc62qgijrYLPvl+a8KVEcQHE32AMWyBsW2Stoj44r
X-Google-Smtp-Source: ABdhPJx5JbvuYPN9f36JF4wwAPzF8ReIyBVqnl7T5ssY6CgE5sIggLEjkXyy7LtDH2YKLeIS0uySkneFyI97Y1MWhaU=
X-Received: by 2002:aca:241a:: with SMTP id n26mr1887617oic.137.1631634154498;
 Tue, 14 Sep 2021 08:42:34 -0700 (PDT)
MIME-Version: 1.0
References: <CAGdWbB5z6sGbDSJRygvWOiNNSP6hNhzFP-eMDfTm6nGoBpehKQ@mail.gmail.com>
 <fc2fbb950e825676988f425773c2bde5@mailmag.net> <b9c53808-0ec2-559d-e41f-75ff1e3da275@tnonline.net>
In-Reply-To: <b9c53808-0ec2-559d-e41f-75ff1e3da275@tnonline.net>
From:   Dave T <davestechshop@gmail.com>
Date:   Tue, 14 Sep 2021 11:42:23 -0400
Message-ID: <CAGdWbB4p1r0DsKv54P=Hp6uYwhBa+WzsmkHy1X53fc9VZaxPeA@mail.gmail.com>
Subject: Re: btrbk question: Should I Prefer Fileserver-initiated Backups from
 Several Hosts (Instead of Each Host Sending to the Server)?
To:     Forza <forza@tnonline.net>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Cc:     Joshua <joshua@mailmag.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Sep 14, 2021 at 1:11 AM Forza <forza@tnonline.net> wrote:
>
>
>
> On 2021-09-14 03:49, Joshua wrote:
> > September 12, 2021 10:42 AM, "Dave T" <davestechshop@gmail.com> wrote:
> >
> >> Are btrbk-specific questions OK here?
>
> There is also #btrbk on libera.chat
>
> >>
> >> I have a small LAN with a fileserver that should store backups from
> >> each attached host on the LAN. What is the most efficient (performant)
> >> way to do this with btrbk?
> >>
> >> Each host (laptops, desktops and a few other devices) does hourly
> >> local snapshots with btrbk. Once per day, I would like to send backups
> >> of each volume on each device to the local fileserver. This has to be
> >> done via SSH (as NFS isn't supported by btrfs send|receive, afaik).
> >>
> >> The options I'm aware of from the btrbk readme
> >> (https://digint.ch/btrbk/doc/readme.html) are:
> >>
> >> 1. host-initiated backup to the fileserver from each host
> >>
> >> 2. fileserver-initiated backups from all hosts
> >>
> >> My guess is that the second option is preferred. Is that correct?
> >
> > I personally prefer it, yes.
>
> It might also be easier to manage load on the server if you can backup
> each client serially instead of in parallel.
>
> >
> > I can manage all my retention in one place, and my backups are isolated. If a client is
> > compromised, the backups on the server cannot be deleted by an attacker, since my clients have no
> > access to the server, rather the server has access to the clients.
> >
> >> Assuming I use the second option, do I need to be concerned about it
> >> initiating a backup on a host while that host is also performing a
> >> local hourly snapshot?
> >
> > I don't think so.  Hopefully someone will correct me if so.
>
> No. I believe the only caveats are if you were running old versions of
> "bees" on the clients. Bees is an advanced deduplication tool.
>
> >
> >> What are the disadvantages of the fileserver-initiated approach?
> >
> > If a client is offline, it will not be backed up at that time.
> >
> > There's probably other disadvantages, but that's the main one I can think of.
> >
> >> If one host is offline, will the backup procedure continue on with the
> >> other hosts it can reach at that time?
> >
> > It should, but I don't know 100%
> >
> >> Since deleting snapshots can potentially be a costly operation (in
> >> terms of performance), should I split the process into two steps,
> >> where one step would pull the backups from each host without any
> >> deletions, and a second step would then prune the backups according to
> >> configured retention policies?
>
> As far as I know, Btrbk transfers all backups before attempting pruning.
> All sources would have to be in the same btrbk.conf though.
>
> >
> > If it's important that the backup process complete as soon as possible, perhaps this would be a
> > good idea.
> >
> > If that's not important, I don't see why it would matter.
> >
> >> How many backups (snapshots) can I safely retain for each host volume?
> >> I would like to keep as many as possible, but I know there is a
> >> threshold at which performance can become a problem.
> >
> > I would think the limits would be relatively high, but I personally only run dailies for a week,
> > then weeklies for a month, then monthlies for a year.
> >
> >> I mount btrfs volumes on the **hosts** with these mount options:
> >>
> >> autodefrag,noatime,nodiratime,compress=lzo,space_cache=v2
>
> autodefrag can break reflinks between snapshots which can lead to
> somewhat higher disk usage. In my experience it has been a little hit or
> miss if autodefrag helps. If it does help, it is great, otherwise just
> disable it.

I will remove autodefrag.

>
> These days I prefer zstd:1 over lzo for compression. Zstd allows for
> different compression efforts to be set. It generally has better
> compression ratios than LZO and is only a little slower, unless you use
> a high compression level. Default zstd level is zstd:3.
>
> https://btrfs.wiki.kernel.org/index.php/Compression
> https://wiki.tnonline.net/w/Btrfs/Compression

I will probably switch to zstd too, but not until I have the entire
backup implementation working the way I expect it to work.

>
> >
> > Just FYI, noatime implies nodiratime. Source: https://lwn.net/Articles/245002
> >
> >> And I have the systemd fstrim.service enabled.
> >>
> >> The fileserver is a dedicated backup server, not a general-purpose
> >> fileserver. I plan to use most of those same mount options. Do I need
> >> the autodefrag option? Will autodefrag help or hurt performance in
> >> this use-case? The following message from this list caused me some
> >> confusion as I would have expected the opposite:
> >
> > Sorry, I honestly don't know what impact this might have.
> > I personally run autodefrag on my clients, and not on my backup server.
> >
> >> [freezes during snapshot creation/deletion -- to be expected? November
> >> 2019, 00:21:18 CET]
> >>
> >>> So just to follow up on this, reducing the total number of snapshots and increasing the time
> >>> between their creation from hourly to once every six hours did help a *little* bit. However, about
> >>> a week ago I decided to try an experiment and added the "autodefrag" mount option (which I don't
> >>> usually do on SSDs), and that helped *massively*. Ever since, snapper-cleanup.service runs without
> >>> me noticing at all!.
> >>
> >> Are there any other recommendations?
>
> Is your backup server SSD only?

No, my backup server uses only hard disks.

> If you add HDD's, avoid SMR drives.

Thanks for the tip. I had to look up "SMR". I do have a couple Seagate
"archive" hard drives in some other systems, but fortunately I do not
have any of that type in this server.


> It also a good idea to mix different ages or models of drives to reduce the
> chance that multiple drives fails at the same time.
>
> Don't use raid56 profiles at the moment.
>
> Monitor your disk usage with "btrfs filesystem usage -T /mnt" to make
> sure you don't run out of space for metadata allocation.
>
> Run manual fstrim on off-hours.
>
> Do a full scrub every now and then.
>
