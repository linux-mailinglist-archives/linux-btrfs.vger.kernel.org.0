Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A924340B5C4
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Sep 2021 19:17:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231545AbhINRTK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 14 Sep 2021 13:19:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231523AbhINRTK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 14 Sep 2021 13:19:10 -0400
Received: from zaphod.cobb.me.uk (zaphod.cobb.me.uk [IPv6:2001:41c8:51:983::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F13AC061574
        for <linux-btrfs@vger.kernel.org>; Tue, 14 Sep 2021 10:17:52 -0700 (PDT)
Received: by zaphod.cobb.me.uk (Postfix, from userid 107)
        id DE30A9BA75; Tue, 14 Sep 2021 18:17:49 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cobb.uk.net;
        s=201703; t=1631639869;
        bh=gbClbZkd1bocUtYB1MMbkL7QJBU3VY8YIL09CRexZNA=;
        h=From:To:References:Subject:Date:In-Reply-To:From;
        b=Hr9LlGy0jfdDS2+6WXsCDf9D+MMsEcWDRlkSWQPO9tlb5vLpOeo5Gh4FnlTbRZoCR
         guJ3be8ABZvlar3FhAVhc3HRmhZnhnvlm6P5zyU9wtbdXTSb2yV7haJzTl3T2/b8vF
         9f7g9KTSWR0GTHawgiBBRXJmpYveKhIcw6i7Qh7PFDcCyaPvgFCkVHK4LTYEeWrdSz
         rdbTD9AgYDABrOjIdJA0va1RKmDVA0eS2bOs9hn1+3dHnU9pXx/fC8rUsarF481fCb
         mWIXDqdppNXcxYJw3UVZXyydl4WTgSfVAEYn1KGLiqFQuCNfLVkOulZ0GbadKpmvnw
         JsgOJC4ATPwfg==
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on zaphod.cobb.me.uk
X-Spam-Status: No, score=-6.9 required=12.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.2
X-Spam-Level: 
X-Spam-Bar: 
Received: from black.home.cobb.me.uk (unknown [192.168.0.205])
        by zaphod.cobb.me.uk (Postfix) with ESMTP id 6BCF09B846;
        Tue, 14 Sep 2021 18:17:28 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cobb.uk.net;
        s=201703; t=1631639848;
        bh=gbClbZkd1bocUtYB1MMbkL7QJBU3VY8YIL09CRexZNA=;
        h=From:To:References:Subject:Date:In-Reply-To:From;
        b=SEHBlB0thbRTgvAcYCLdNoVQBEV4RYXEXubTGtVddlClthWQUFOu7cJScPLmA3etx
         Hd+2V3AY421S73X/4yAtuFIDssobrSxgtgFtWDKeF77cXImsTAUlND0SvRX3T9KStm
         FlLGEsurdiAQrLgDtispDOTZWfRRWzQWpMpQeFtbXFONVKc6SzbeWY1yX6CRfGx110
         85VSIHKja11anwUO+e3if/hZVouBquo1LgNGJBNPUk2gvzP1fZZEfU0JJ1A3dNn3id
         uuJz2X10IPQ7VCr4KvDtz1lmvbsdQFkNnOtYnlrIL/9nX3r85jtumIV1QGRMiafpZ2
         /Yq8s/p23Tmmw==
Received: from [192.168.0.202] (ryzen.home.cobb.me.uk [192.168.0.202])
        by black.home.cobb.me.uk (Postfix) with ESMTP id 1817B296CFB;
        Tue, 14 Sep 2021 18:17:28 +0100 (BST)
From:   Graham Cobb <g.btrfs@cobb.uk.net>
To:     Dave T <davestechshop@gmail.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <CAGdWbB5z6sGbDSJRygvWOiNNSP6hNhzFP-eMDfTm6nGoBpehKQ@mail.gmail.com>
 <9617697d-36ee-ddcf-c38e-e46c3a04915c@cobb.uk.net>
 <CAGdWbB6nxeg5i0MsjHU4dyaHO9twOS7yn1iDcwBhj6DE9SN1YA@mail.gmail.com>
Subject: Re: btrbk question: Should I Prefer Fileserver-initiated Backups from
 Several Hosts (Instead of Each Host Sending to the Server)?
Message-ID: <95d4a8d0-1086-ddaf-43d7-06f63536516b@cobb.uk.net>
Date:   Tue, 14 Sep 2021 18:17:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <CAGdWbB6nxeg5i0MsjHU4dyaHO9twOS7yn1iDcwBhj6DE9SN1YA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 14/09/2021 17:17, Dave T wrote:
> On Tue, Sep 14, 2021 at 6:00 AM Graham Cobb <g.btrfs@cobb.uk.net> wrote:
>>
>> On 12/09/2021 18:40, Dave T wrote:
>>> Are btrbk-specific questions OK here?
>>>
>>> I have a small LAN with a fileserver that should store backups from
>>> each attached host on the LAN. What is the most efficient (performant)
>>> way to do this with btrbk?
>>
>> My main goal is not performance but safety - but I realise there is
>> always a tradeoff to be made! And security and data protection also feed
>> into the analysis (ransomware, personal data, etc etc).
>>
>>> Each host (laptops, desktops and a few other devices) does hourly
>>> local snapshots with btrbk. Once per day, I would like to send backups
>>> of each volume on each device to the local fileserver. This has to be
>>> done via SSH (as NFS isn't supported by btrfs send|receive, afaik).
>>
>> That is similar to my setup. But in my case the server is always in control.
>>
>>> The options I'm aware of from the btrbk readme
>>> (https://digint.ch/btrbk/doc/readme.html) are:
>>>
>>> 1. host-initiated backup to the fileserver from each host
>>>
>>> 2. fileserver-initiated backups from all hosts
>>>
>>> My guess is that the second option is preferred. Is that correct?
>>>
>>> Assuming I use the second option, do I need to be concerned about it
>>> initiating a backup on a host while that host is also performing a
>>> local hourly snapshot?
>>
>> I use the second option, but I rely on btrbk on the server to take the
>> local snapshots on the hosts as well. In other words, btrbk software is
>> installed on the host but I never run it there explicitly. btrbk on the
>> server controls making both host and server snapshots.
>>
>>> What are the disadvantages of the  fileserver-initiated approach?
>>
>> Laptops, and other intermittently connected hosts, don't even get local
>> backups done unless they are connected at the time the server tries to
>> do them. Not a big problem for me.
>>
>>> If one host is offline, will the backup procedure continue on with the
>>> other hosts it can reach at that time?
>>
>> I run separate cron jobs (with separate btrbk conf files) for each host.
> 
> That's a very interesting approach. How many hosts do you have?

It varies a bit as some are intermittently connected but there are
currently about 5.

>>> Since deleting snapshots can potentially be a costly operation (in
>>> terms of performance), should I split the process into two steps,
>>> where one step would pull the backups from each host without any
>>> deletions, and a second step would then prune the backups according to
>>> configured retention policies?
>>
>> I don't. I just let btrbk run through the process.
> 
> I will try it that way. I think I will try to keep my configuration as
> simple as possible, while still accomplishing my goals.
> 
>>
>>> How many backups (snapshots) can I safely retain for each host volume?
>>> I would like to keep as many as possible, but I know there is a
>>> threshold at which performance can become a problem.
>>
>> On the server I use a separate btrfs filesystem for snapshots (a mixture
>> of btrbk snapshots and rsnapshot snapshots). It is currently 18TB (data
>> single, metadata raid1 on two spinning disks, with LUKS and LVM), of
>> which about 15TB is in use. It has about 1300 btrbk subvolumes on it
>> (and about 50 rsnapshot subvolumes). The btrbk jobs run (mostly at
>> night) using cron so I don't pay any attention to how long they take but
>> it isn't excessive. It doesn't seem to slow the system down or cause any
>> problems.
>>
>> The only problem is that check (run monthly) takes a few days! I just
>> let it run in the background.
> 
> Do you run btrfs-check on the mounted or unmounted filesystems? What
> check options do you use?

DOH! I don't know why I wrote "check"! I meant "scrub". Must be losing it...

> 
>>
>> I don't keep many snapshots on the hosts - they take up disk space and
>> can cause unnecessary issues. Keep the main snapshots on the server,
>> with just a small number of recent ones on the host for easy access when
>> someone deletes the wrong file by mistake. For laptops you need to trade
>> off keeping more so older data can be accessed when on the move or fewer
>> so that deleted files don't hang around if the laptop is lost.
>>
>>>
>>> I mount btrfs volumes on the **hosts** with these mount options:
>>>
>>>     autodefrag,noatime,nodiratime,compress=lzo,space_cache=v2
>>
>> On the hosts I use nothing special. For example:
>>
>>     noatime,nodiratime,nossd
>>
>> On the server, I use:
>>
>>
>> noatime,nodiratime,compress-force=zstd:15,skip_balance,commit=15,space_cache=v2,x-systemd.mount-timeout=180s,nofail
> 
> 
> Why do you use the skip_balance mount option? I have never had any
> problem related to what this option seems intended to do. I'm curious
> if you use it due to encountering some problem that it solves for you.

I have been using btrfs for a long time (I first used it in the Meego
days IIRC, then with Mer & Sailfish). Back then balance sometimes got
very confused and did some nasty things so it was important to make sure
you could kill a balance by rebooting! I have never turned skip_balance
off but I don't think I have needed it for a long time.

> 
> Also, I can't find the documentation for the commit=15 mount option.
> I'm curious to know about it. Why do you use it?

It forces btrfs to commit the log every 15 seconds. I use it because
power is not massively reliable here so I wanted to reduce lost
transactions in a power failure. Note: btrfs is good at preserving
filesystem integrity on a power failure but the filesystem will revert
to the state at the last completed transaction.

Graham

> 
>>
>>>
>>> And I have the systemd fstrim.service enabled.
>>>
>>> The fileserver is a dedicated backup server, not a general-purpose
>>> fileserver. I plan to use most of those same mount options. Do I need
>>> the autodefrag option? Will autodefrag help or hurt performance in
>>> this use-case? The following message from this list caused me some
>>> confusion as I would have expected the opposite:
>>>
>>> [freezes during snapshot creation/deletion -- to be expected? November
>>> 2019, 00:21:18 CET]
>>
>> I don't use autodefrag or any other defrag. As these are backups I don't
>> see any need to improve read access, and I prefer to avoid the concern
>> over defrag breaking something.
> 
> That makes sense.
> 
>>
>>>> So just to follow up on this, reducing the total number of snapshots and  increasing the time between their creation from hourly to once every six hours  did help a *little* bit.  However, about a week ago I decided to try an  experiment and added the "autodefrag" mount option (which I don't usually do  on SSDs), and that helped *massively*.  Ever since, snapper-cleanup.service  runs without me noticing at all!.
>>>
>>> Are there any other recommendations?
>>
>> Don't use snapshots as your only backup. They are great for easy access
>> and for being bang up to date but I maintain more traditional backups as
>> well (using DAR, daily in my case, and encrypted and sent to a cloud
>> service). This is mainly in case some bug or disk problem caused me to
>> lose the btrfs filesystem structure of the snapshots filesystem, but it
>> also provides protection against a fire or similar.
>>
>> Graham
>>
>> P.S. Just fyi, here is an example of one of my btrbk conf files
> 
> Thank you for sharing this.
> 
> 
>> (for an intermittently connected laptop in this particular case, others are more
>> complex with multiple subvolumes but they are all similar):
>>
>> volume <REDACTED>:/mnt/rootdisk
>>  ssh_identity /root/.ssh/<REDACTED>
>>  snapshot_dir btrbk_snapshots
>>  snapshot_create onchange
>>  preserve_day_of_week monday
>>
>> # On the disk itself only keep recent snapshots
>>  snapshot_preserve_min  5d
>>  snapshot_preserve 5d 2w
>>  timestamp_format long-iso
>>
>> # On the backup disk keep historic monthlies
>>  target_preserve_min no
>>  target_preserve 30d 8w *m
>>
>> subvolume rootfs
>>  target send-receive    /snapshots/<REDACTED>_snapshots
>>
>>
>>

