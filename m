Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18F7540A5C1
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Sep 2021 07:11:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239316AbhINFMT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 14 Sep 2021 01:12:19 -0400
Received: from pio-pvt-msa2.bahnhof.se ([79.136.2.41]:56374 "EHLO
        pio-pvt-msa2.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232829AbhINFMS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 14 Sep 2021 01:12:18 -0400
Received: from localhost (localhost [127.0.0.1])
        by pio-pvt-msa2.bahnhof.se (Postfix) with ESMTP id 78AA03F834;
        Tue, 14 Sep 2021 07:11:00 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
X-Spam-Flag: NO
X-Spam-Score: -1.9
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 tagged_above=-999 required=6.31
        tests=[BAYES_00=-1.9, NICE_REPLY_A=-0.001, URIBL_BLOCKED=0.001]
        autolearn=ham autolearn_force=no
Received: from pio-pvt-msa2.bahnhof.se ([127.0.0.1])
        by localhost (pio-pvt-msa2.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Ja9ps9TrRURf; Tue, 14 Sep 2021 07:10:59 +0200 (CEST)
Received: by pio-pvt-msa2.bahnhof.se (Postfix) with ESMTPA id 2C0673F4C3;
        Tue, 14 Sep 2021 07:10:58 +0200 (CEST)
Received: from [192.168.0.10] (port=64307)
        by tnonline.net with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <forza@tnonline.net>)
        id 1mQ0ig-00078k-BB; Tue, 14 Sep 2021 07:10:58 +0200
Subject: Re: btrbk question: Should I Prefer Fileserver-initiated Backups from
 Several Hosts (Instead of Each Host Sending to the Server)?
To:     Joshua <joshua@mailmag.net>, Dave T <davestechshop@gmail.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <CAGdWbB5z6sGbDSJRygvWOiNNSP6hNhzFP-eMDfTm6nGoBpehKQ@mail.gmail.com>
 <fc2fbb950e825676988f425773c2bde5@mailmag.net>
From:   Forza <forza@tnonline.net>
Message-ID: <b9c53808-0ec2-559d-e41f-75ff1e3da275@tnonline.net>
Date:   Tue, 14 Sep 2021 07:10:58 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <fc2fbb950e825676988f425773c2bde5@mailmag.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021-09-14 03:49, Joshua wrote:
> September 12, 2021 10:42 AM, "Dave T" <davestechshop@gmail.com> wrote:
> 
>> Are btrbk-specific questions OK here?

There is also #btrbk on libera.chat

>>
>> I have a small LAN with a fileserver that should store backups from
>> each attached host on the LAN. What is the most efficient (performant)
>> way to do this with btrbk?
>>
>> Each host (laptops, desktops and a few other devices) does hourly
>> local snapshots with btrbk. Once per day, I would like to send backups
>> of each volume on each device to the local fileserver. This has to be
>> done via SSH (as NFS isn't supported by btrfs send|receive, afaik).
>>
>> The options I'm aware of from the btrbk readme
>> (https://digint.ch/btrbk/doc/readme.html) are:
>>
>> 1. host-initiated backup to the fileserver from each host
>>
>> 2. fileserver-initiated backups from all hosts
>>
>> My guess is that the second option is preferred. Is that correct?
> 
> I personally prefer it, yes.

It might also be easier to manage load on the server if you can backup 
each client serially instead of in parallel.

> 
> I can manage all my retention in one place, and my backups are isolated. If a client is
> compromised, the backups on the server cannot be deleted by an attacker, since my clients have no
> access to the server, rather the server has access to the clients.
> 
>> Assuming I use the second option, do I need to be concerned about it
>> initiating a backup on a host while that host is also performing a
>> local hourly snapshot?
> 
> I don't think so.  Hopefully someone will correct me if so.

No. I believe the only caveats are if you were running old versions of 
"bees" on the clients. Bees is an advanced deduplication tool.

> 
>> What are the disadvantages of the fileserver-initiated approach?
> 
> If a client is offline, it will not be backed up at that time.
> 
> There's probably other disadvantages, but that's the main one I can think of.
> 
>> If one host is offline, will the backup procedure continue on with the
>> other hosts it can reach at that time?
> 
> It should, but I don't know 100%
> 
>> Since deleting snapshots can potentially be a costly operation (in
>> terms of performance), should I split the process into two steps,
>> where one step would pull the backups from each host without any
>> deletions, and a second step would then prune the backups according to
>> configured retention policies?

As far as I know, Btrbk transfers all backups before attempting pruning. 
All sources would have to be in the same btrbk.conf though.

> 
> If it's important that the backup process complete as soon as possible, perhaps this would be a
> good idea.
> 
> If that's not important, I don't see why it would matter.
> 
>> How many backups (snapshots) can I safely retain for each host volume?
>> I would like to keep as many as possible, but I know there is a
>> threshold at which performance can become a problem.
> 
> I would think the limits would be relatively high, but I personally only run dailies for a week,
> then weeklies for a month, then monthlies for a year.
> 
>> I mount btrfs volumes on the **hosts** with these mount options:
>>
>> autodefrag,noatime,nodiratime,compress=lzo,space_cache=v2

autodefrag can break reflinks between snapshots which can lead to 
somewhat higher disk usage. In my experience it has been a little hit or 
miss if autodefrag helps. If it does help, it is great, otherwise just 
disable it.

These days I prefer zstd:1 over lzo for compression. Zstd allows for 
different compression efforts to be set. It generally has better 
compression ratios than LZO and is only a little slower, unless you use 
a high compression level. Default zstd level is zstd:3.

https://btrfs.wiki.kernel.org/index.php/Compression
https://wiki.tnonline.net/w/Btrfs/Compression

> 
> Just FYI, noatime implies nodiratime. Source: https://lwn.net/Articles/245002
> 
>> And I have the systemd fstrim.service enabled.
>>
>> The fileserver is a dedicated backup server, not a general-purpose
>> fileserver. I plan to use most of those same mount options. Do I need
>> the autodefrag option? Will autodefrag help or hurt performance in
>> this use-case? The following message from this list caused me some
>> confusion as I would have expected the opposite:
> 
> Sorry, I honestly don't know what impact this might have.
> I personally run autodefrag on my clients, and not on my backup server.
> 
>> [freezes during snapshot creation/deletion -- to be expected? November
>> 2019, 00:21:18 CET]
>>
>>> So just to follow up on this, reducing the total number of snapshots and increasing the time
>>> between their creation from hourly to once every six hours did help a *little* bit. However, about
>>> a week ago I decided to try an experiment and added the "autodefrag" mount option (which I don't
>>> usually do on SSDs), and that helped *massively*. Ever since, snapper-cleanup.service runs without
>>> me noticing at all!.
>>
>> Are there any other recommendations?

Is your backup server SSD only? If you add HDD's, avoid SMR drives. It 
also a good idea to mix different ages or models of drives to reduce the 
chance that multiple drives fails at the same time.

Don't use raid56 profiles at the moment.

Monitor your disk usage with "btrfs filesystem usage -T /mnt" to make 
sure you don't run out of space for metadata allocation.

Run manual fstrim on off-hours.

Do a full scrub every now and then.

