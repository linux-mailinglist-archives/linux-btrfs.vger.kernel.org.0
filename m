Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC9C440B45A
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Sep 2021 18:18:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229497AbhINQTV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 14 Sep 2021 12:19:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbhINQTU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 14 Sep 2021 12:19:20 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D06BCC061574
        for <linux-btrfs@vger.kernel.org>; Tue, 14 Sep 2021 09:18:02 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id c79so19745579oib.11
        for <linux-btrfs@vger.kernel.org>; Tue, 14 Sep 2021 09:18:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=N8trxLVxSz+UizvbfD4L2QNLLQyvhy7E3FboZK4F+oM=;
        b=Mqf0BrIiIuVm3yYMwouzMqX5993S5ApvdrXoZHVVorcEBQouO6jxdPIW3TuyY9sNmc
         /xvaiGnYp7kQUVomtzCmoAhXLFYlTy20sCgf+UlH9fqALG4rGcfwDs789pKWK7CGtDej
         ijLexQyaIXVMzqnJ5PB8w6DFTP+q264FHfi2zbl9y0gqFApWXZcJ+gfog7Hc6z1Yu5hd
         tULea6ZEp0o4/cQ1ourNup7Nj6l/HPIdBOIgunCq1agwUHuXsmJicvlzDKrMAty+FBbJ
         y/YZS1o/yGhpRu6RTOAnIU+q8OHnRDnP45NvM7Q/5IirP71Wt60q1f1/4aF5A2PA1OUs
         zSvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=N8trxLVxSz+UizvbfD4L2QNLLQyvhy7E3FboZK4F+oM=;
        b=ElTkOv4uYMeXohh/mCF21ww+rX/mGj5U9DnOV9d1ncIKRDaiWu+7Q+oKCKlDV+rYCu
         qJbPuG/v5B5yOwrimvUnyvxuHE/m5GBsi7Rvv4wseIsvj451WZp1//TSC0RPzigGYP1t
         qG+tkr6dWgJTfC/W3F3APlosAEg4kpZL1Vr3M1s4n42NMVWU+EjPRm3kB/1vuDiTXk4A
         9LNENe+8dIqqi7IxjKE2nMVhK8jsSEG06EQvDJtLUDVFYF668YzXEGFVBuoBMWXJzqlS
         QNL10iYHlwepm01cpUan7BZE8gooNUFFf8Of9bPLDz6mtp2Gp9RltakfBz9vfCt8uch8
         M4bQ==
X-Gm-Message-State: AOAM530BAah0lwDy/0rLy6ONPvPKK7YC+dN/H/xyrXsBAWZiHoPYGyS3
        6vIRCcp1QqSEOCiGNKZrIf2EFi0aA0CSHD2LEfPdBJLkKb0=
X-Google-Smtp-Source: ABdhPJwu9x3Bl1q/chgj9BRA4QkKsKXk7vvE4/4mHKnC/zmXm8uR3E8m8oUbj9EIgjigOC+X69U2JV8CmJ3KlyE4G+8=
X-Received: by 2002:a05:6808:3099:: with SMTP id bl25mr2107286oib.44.1631636282112;
 Tue, 14 Sep 2021 09:18:02 -0700 (PDT)
MIME-Version: 1.0
References: <CAGdWbB5z6sGbDSJRygvWOiNNSP6hNhzFP-eMDfTm6nGoBpehKQ@mail.gmail.com>
 <9617697d-36ee-ddcf-c38e-e46c3a04915c@cobb.uk.net>
In-Reply-To: <9617697d-36ee-ddcf-c38e-e46c3a04915c@cobb.uk.net>
From:   Dave T <davestechshop@gmail.com>
Date:   Tue, 14 Sep 2021 12:17:50 -0400
Message-ID: <CAGdWbB6nxeg5i0MsjHU4dyaHO9twOS7yn1iDcwBhj6DE9SN1YA@mail.gmail.com>
Subject: Re: btrbk question: Should I Prefer Fileserver-initiated Backups from
 Several Hosts (Instead of Each Host Sending to the Server)?
To:     Graham Cobb <g.btrfs@cobb.uk.net>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Sep 14, 2021 at 6:00 AM Graham Cobb <g.btrfs@cobb.uk.net> wrote:
>
> On 12/09/2021 18:40, Dave T wrote:
> > Are btrbk-specific questions OK here?
> >
> > I have a small LAN with a fileserver that should store backups from
> > each attached host on the LAN. What is the most efficient (performant)
> > way to do this with btrbk?
>
> My main goal is not performance but safety - but I realise there is
> always a tradeoff to be made! And security and data protection also feed
> into the analysis (ransomware, personal data, etc etc).
>
> > Each host (laptops, desktops and a few other devices) does hourly
> > local snapshots with btrbk. Once per day, I would like to send backups
> > of each volume on each device to the local fileserver. This has to be
> > done via SSH (as NFS isn't supported by btrfs send|receive, afaik).
>
> That is similar to my setup. But in my case the server is always in contr=
ol.
>
> > The options I'm aware of from the btrbk readme
> > (https://digint.ch/btrbk/doc/readme.html) are:
> >
> > 1. host-initiated backup to the fileserver from each host
> >
> > 2. fileserver-initiated backups from all hosts
> >
> > My guess is that the second option is preferred. Is that correct?
> >
> > Assuming I use the second option, do I need to be concerned about it
> > initiating a backup on a host while that host is also performing a
> > local hourly snapshot?
>
> I use the second option, but I rely on btrbk on the server to take the
> local snapshots on the hosts as well. In other words, btrbk software is
> installed on the host but I never run it there explicitly. btrbk on the
> server controls making both host and server snapshots.
>
> > What are the disadvantages of the  fileserver-initiated approach?
>
> Laptops, and other intermittently connected hosts, don't even get local
> backups done unless they are connected at the time the server tries to
> do them. Not a big problem for me.
>
> > If one host is offline, will the backup procedure continue on with the
> > other hosts it can reach at that time?
>
> I run separate cron jobs (with separate btrbk conf files) for each host.

That's a very interesting approach. How many hosts do you have?

>
> > Since deleting snapshots can potentially be a costly operation (in
> > terms of performance), should I split the process into two steps,
> > where one step would pull the backups from each host without any
> > deletions, and a second step would then prune the backups according to
> > configured retention policies?
>
> I don't. I just let btrbk run through the process.

I will try it that way. I think I will try to keep my configuration as
simple as possible, while still accomplishing my goals.

>
> > How many backups (snapshots) can I safely retain for each host volume?
> > I would like to keep as many as possible, but I know there is a
> > threshold at which performance can become a problem.
>
> On the server I use a separate btrfs filesystem for snapshots (a mixture
> of btrbk snapshots and rsnapshot snapshots). It is currently 18TB (data
> single, metadata raid1 on two spinning disks, with LUKS and LVM), of
> which about 15TB is in use. It has about 1300 btrbk subvolumes on it
> (and about 50 rsnapshot subvolumes). The btrbk jobs run (mostly at
> night) using cron so I don't pay any attention to how long they take but
> it isn't excessive. It doesn't seem to slow the system down or cause any
> problems.
>
> The only problem is that check (run monthly) takes a few days! I just
> let it run in the background.

Do you run btrfs-check on the mounted or unmounted filesystems? What
check options do you use?

>
> I don't keep many snapshots on the hosts - they take up disk space and
> can cause unnecessary issues. Keep the main snapshots on the server,
> with just a small number of recent ones on the host for easy access when
> someone deletes the wrong file by mistake. For laptops you need to trade
> off keeping more so older data can be accessed when on the move or fewer
> so that deleted files don't hang around if the laptop is lost.
>
> >
> > I mount btrfs volumes on the **hosts** with these mount options:
> >
> >     autodefrag,noatime,nodiratime,compress=3Dlzo,space_cache=3Dv2
>
> On the hosts I use nothing special. For example:
>
>     noatime,nodiratime,nossd
>
> On the server, I use:
>
>
> noatime,nodiratime,compress-force=3Dzstd:15,skip_balance,commit=3D15,spac=
e_cache=3Dv2,x-systemd.mount-timeout=3D180s,nofail


Why do you use the skip_balance mount option? I have never had any
problem related to what this option seems intended to do. I'm curious
if you use it due to encountering some problem that it solves for you.

Also, I can't find the documentation for the commit=3D15 mount option.
I'm curious to know about it. Why do you use it?

>
> >
> > And I have the systemd fstrim.service enabled.
> >
> > The fileserver is a dedicated backup server, not a general-purpose
> > fileserver. I plan to use most of those same mount options. Do I need
> > the autodefrag option? Will autodefrag help or hurt performance in
> > this use-case? The following message from this list caused me some
> > confusion as I would have expected the opposite:
> >
> > [freezes during snapshot creation/deletion -- to be expected? November
> > 2019, 00:21:18 CET]
>
> I don't use autodefrag or any other defrag. As these are backups I don't
> see any need to improve read access, and I prefer to avoid the concern
> over defrag breaking something.

That makes sense.

>
> >> So just to follow up on this, reducing the total number of snapshots a=
nd  increasing the time between their creation from hourly to once every si=
x hours  did help a *little* bit.  However, about a week ago I decided to t=
ry an  experiment and added the "autodefrag" mount option (which I don't us=
ually do  on SSDs), and that helped *massively*.  Ever since, snapper-clean=
up.service  runs without me noticing at all!.
> >
> > Are there any other recommendations?
>
> Don't use snapshots as your only backup. They are great for easy access
> and for being bang up to date but I maintain more traditional backups as
> well (using DAR, daily in my case, and encrypted and sent to a cloud
> service). This is mainly in case some bug or disk problem caused me to
> lose the btrfs filesystem structure of the snapshots filesystem, but it
> also provides protection against a fire or similar.
>
> Graham
>
> P.S. Just fyi, here is an example of one of my btrbk conf files

Thank you for sharing this.


> (for an intermittently connected laptop in this particular case, others a=
re more
> complex with multiple subvolumes but they are all similar):
>
> volume <REDACTED>:/mnt/rootdisk
>  ssh_identity /root/.ssh/<REDACTED>
>  snapshot_dir btrbk_snapshots
>  snapshot_create onchange
>  preserve_day_of_week monday
>
> # On the disk itself only keep recent snapshots
>  snapshot_preserve_min  5d
>  snapshot_preserve 5d 2w
>  timestamp_format long-iso
>
> # On the backup disk keep historic monthlies
>  target_preserve_min no
>  target_preserve 30d 8w *m
>
> subvolume rootfs
>  target send-receive    /snapshots/<REDACTED>_snapshots
>
>
>
