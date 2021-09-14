Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD0DD40AB48
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Sep 2021 11:59:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230146AbhINKBD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 14 Sep 2021 06:01:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229969AbhINKBB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 14 Sep 2021 06:01:01 -0400
Received: from zaphod.cobb.me.uk (zaphod.cobb.me.uk [IPv6:2001:41c8:51:983::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40241C061574
        for <linux-btrfs@vger.kernel.org>; Tue, 14 Sep 2021 02:59:44 -0700 (PDT)
Received: by zaphod.cobb.me.uk (Postfix, from userid 107)
        id 5B2C99BA75; Tue, 14 Sep 2021 10:59:42 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cobb.uk.net;
        s=201703; t=1631613582;
        bh=X2HkvmsyObbd/FApTQlcpayBuYJPql1aTGF904MgGNw=;
        h=From:To:References:Subject:Date:In-Reply-To:From;
        b=GkTIxcsva5RlhhFdsVt3b44EUj0DVRMh6QCaxu1Fdtlrf+1CX8GUY8l99GCOOd93c
         1+YwtvAYszdv8ERpWwVQ8rfXqm7k//KLGiHce3cXpq1/rhG5Q6/MQno8+t48XHLvWZ
         fsuaATLstSwRhdRfU0SktWuoM84BaAOg2tr2CtTBsDZz7/MbqAlDdVAMWggwwKxfV5
         rMr9Ajbwk7kOgI5mNaHIITFYUVRuW9VO5mmzBdDtv72ZMYPIDlkZ30KLFsTlwz9C1X
         QPForIdjQWz4VUJLCiUZA6YGI0zWlYbX0yKp8D2/okY9IJwiscZl06SZE7NtKw0VH1
         itPe058Gvil2A==
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on zaphod.cobb.me.uk
X-Spam-Status: No, score=-6.9 required=12.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.2
X-Spam-Level: 
X-Spam-Bar: 
Received: from black.home.cobb.me.uk (unknown [192.168.0.205])
        by zaphod.cobb.me.uk (Postfix) with ESMTP id 512609B846;
        Tue, 14 Sep 2021 10:59:21 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cobb.uk.net;
        s=201703; t=1631613562;
        bh=X2HkvmsyObbd/FApTQlcpayBuYJPql1aTGF904MgGNw=;
        h=From:To:References:Subject:Date:In-Reply-To:From;
        b=OQxe+oI6doRCJWjXIdvqe+4F6PCjeyfZSOCIgE68X3FqdEVk/SS4JCLrP06/y2C8P
         AoAQnSeiYuCgLmOandXTfEGWC8Yq8jUjA/ZXX7H/bqOGSJx6JTMYLiDS/mT+nLoBeA
         HVttXYw/2Q6SYIUsuVWwYJS/mJgWV2U9JxVJsP8amdclAI/16+w1GIrnQtfL2nOb4h
         TfWCYANU1s4Bb04Hu3YPjOkp0937E8rgls3BQNvhvVUq31IjU9sQab2uvuT4qX6GD7
         Om+C8hBYnDXpvhC0ADBJ6mcLyaAAm4ii79H8lUnww0W19L3nC2QGMsOUhgRg22ogqT
         Lyh0uniYq9aeg==
Received: from [192.168.0.202] (ryzen.home.cobb.me.uk [192.168.0.202])
        by black.home.cobb.me.uk (Postfix) with ESMTP id 19860296B5F;
        Tue, 14 Sep 2021 10:59:20 +0100 (BST)
From:   Graham Cobb <g.btrfs@cobb.uk.net>
To:     Dave T <davestechshop@gmail.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <CAGdWbB5z6sGbDSJRygvWOiNNSP6hNhzFP-eMDfTm6nGoBpehKQ@mail.gmail.com>
Subject: Re: btrbk question: Should I Prefer Fileserver-initiated Backups from
 Several Hosts (Instead of Each Host Sending to the Server)?
Message-ID: <9617697d-36ee-ddcf-c38e-e46c3a04915c@cobb.uk.net>
Date:   Tue, 14 Sep 2021 10:59:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <CAGdWbB5z6sGbDSJRygvWOiNNSP6hNhzFP-eMDfTm6nGoBpehKQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 12/09/2021 18:40, Dave T wrote:
> Are btrbk-specific questions OK here?
> 
> I have a small LAN with a fileserver that should store backups from
> each attached host on the LAN. What is the most efficient (performant)
> way to do this with btrbk?

My main goal is not performance but safety - but I realise there is
always a tradeoff to be made! And security and data protection also feed
into the analysis (ransomware, personal data, etc etc).

> Each host (laptops, desktops and a few other devices) does hourly
> local snapshots with btrbk. Once per day, I would like to send backups
> of each volume on each device to the local fileserver. This has to be
> done via SSH (as NFS isn't supported by btrfs send|receive, afaik).

That is similar to my setup. But in my case the server is always in control.

> The options I'm aware of from the btrbk readme
> (https://digint.ch/btrbk/doc/readme.html) are:
> 
> 1. host-initiated backup to the fileserver from each host
> 
> 2. fileserver-initiated backups from all hosts
> 
> My guess is that the second option is preferred. Is that correct?
> 
> Assuming I use the second option, do I need to be concerned about it
> initiating a backup on a host while that host is also performing a
> local hourly snapshot?

I use the second option, but I rely on btrbk on the server to take the
local snapshots on the hosts as well. In other words, btrbk software is
installed on the host but I never run it there explicitly. btrbk on the
server controls making both host and server snapshots.

> What are the disadvantages of the  fileserver-initiated approach?

Laptops, and other intermittently connected hosts, don't even get local
backups done unless they are connected at the time the server tries to
do them. Not a big problem for me.

> If one host is offline, will the backup procedure continue on with the
> other hosts it can reach at that time?

I run separate cron jobs (with separate btrbk conf files) for each host.

> Since deleting snapshots can potentially be a costly operation (in
> terms of performance), should I split the process into two steps,
> where one step would pull the backups from each host without any
> deletions, and a second step would then prune the backups according to
> configured retention policies?

I don't. I just let btrbk run through the process.

> How many backups (snapshots) can I safely retain for each host volume?
> I would like to keep as many as possible, but I know there is a
> threshold at which performance can become a problem.

On the server I use a separate btrfs filesystem for snapshots (a mixture
of btrbk snapshots and rsnapshot snapshots). It is currently 18TB (data
single, metadata raid1 on two spinning disks, with LUKS and LVM), of
which about 15TB is in use. It has about 1300 btrbk subvolumes on it
(and about 50 rsnapshot subvolumes). The btrbk jobs run (mostly at
night) using cron so I don't pay any attention to how long they take but
it isn't excessive. It doesn't seem to slow the system down or cause any
problems.

The only problem is that check (run monthly) takes a few days! I just
let it run in the background.

I don't keep many snapshots on the hosts - they take up disk space and
can cause unnecessary issues. Keep the main snapshots on the server,
with just a small number of recent ones on the host for easy access when
someone deletes the wrong file by mistake. For laptops you need to trade
off keeping more so older data can be accessed when on the move or fewer
so that deleted files don't hang around if the laptop is lost.

> 
> I mount btrfs volumes on the **hosts** with these mount options:
> 
>     autodefrag,noatime,nodiratime,compress=lzo,space_cache=v2

On the hosts I use nothing special. For example:

    noatime,nodiratime,nossd

On the server, I use:


noatime,nodiratime,compress-force=zstd:15,skip_balance,commit=15,space_cache=v2,x-systemd.mount-timeout=180s,nofail

> 
> And I have the systemd fstrim.service enabled.
> 
> The fileserver is a dedicated backup server, not a general-purpose
> fileserver. I plan to use most of those same mount options. Do I need
> the autodefrag option? Will autodefrag help or hurt performance in
> this use-case? The following message from this list caused me some
> confusion as I would have expected the opposite:
> 
> [freezes during snapshot creation/deletion -- to be expected? November
> 2019, 00:21:18 CET]

I don't use autodefrag or any other defrag. As these are backups I don't
see any need to improve read access, and I prefer to avoid the concern
over defrag breaking something.

>> So just to follow up on this, reducing the total number of snapshots and  increasing the time between their creation from hourly to once every six hours  did help a *little* bit.  However, about a week ago I decided to try an  experiment and added the "autodefrag" mount option (which I don't usually do  on SSDs), and that helped *massively*.  Ever since, snapper-cleanup.service  runs without me noticing at all!.
> 
> Are there any other recommendations?

Don't use snapshots as your only backup. They are great for easy access
and for being bang up to date but I maintain more traditional backups as
well (using DAR, daily in my case, and encrypted and sent to a cloud
service). This is mainly in case some bug or disk problem caused me to
lose the btrfs filesystem structure of the snapshots filesystem, but it
also provides protection against a fire or similar.

Graham

P.S. Just fyi, here is an example of one of my btrbk conf files (for an
intermittently connected laptop in this particular case, others are more
complex with multiple subvolumes but they are all similar):

volume <REDACTED>:/mnt/rootdisk
 ssh_identity /root/.ssh/<REDACTED>
 snapshot_dir btrbk_snapshots
 snapshot_create onchange
 preserve_day_of_week monday

# On the disk itself only keep recent snapshots
 snapshot_preserve_min  5d
 snapshot_preserve 5d 2w
 timestamp_format long-iso

# On the backup disk keep historic monthlies
 target_preserve_min no
 target_preserve 30d 8w *m

subvolume rootfs
 target send-receive    /snapshots/<REDACTED>_snapshots



