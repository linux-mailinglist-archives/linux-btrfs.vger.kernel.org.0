Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4667D407F0C
	for <lists+linux-btrfs@lfdr.de>; Sun, 12 Sep 2021 19:47:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229784AbhILRsu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 12 Sep 2021 13:48:50 -0400
Received: from pio-pvt-msa1.bahnhof.se ([79.136.2.40]:59840 "EHLO
        pio-pvt-msa1.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbhILRst (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 12 Sep 2021 13:48:49 -0400
Received: from localhost (localhost [127.0.0.1])
        by pio-pvt-msa1.bahnhof.se (Postfix) with ESMTP id B81BF3F524;
        Sun, 12 Sep 2021 19:47:33 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
X-Spam-Flag: NO
X-Spam-Score: -1.9
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 tagged_above=-999 required=6.31
        tests=[BAYES_00=-1.9, NICE_REPLY_A=-0.001, URIBL_BLOCKED=0.001]
        autolearn=ham autolearn_force=no
Received: from pio-pvt-msa1.bahnhof.se ([127.0.0.1])
        by localhost (pio-pvt-msa1.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id vK7WQuxfudYw; Sun, 12 Sep 2021 19:47:32 +0200 (CEST)
Received: by pio-pvt-msa1.bahnhof.se (Postfix) with ESMTPA id A43BC3F3DD;
        Sun, 12 Sep 2021 19:47:32 +0200 (CEST)
Received: from [192.168.0.10] (port=59451)
        by tnonline.net with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <forza@tnonline.net>)
        id 1mPTZj-000B3Q-TL; Sun, 12 Sep 2021 19:47:31 +0200
From:   Forza <forza@tnonline.net>
Subject: Re: seeking advice for a backup server (accepting btrfs receive
 streams via SSH)
To:     Dave T <davestechshop@gmail.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <CAGdWbB5i2QumFah3aCxC7Zwg1TPGMS-_7nsPxeuJu+JZ-bGYew@mail.gmail.com>
 <CAGdWbB57aE9fmuS3ZU1oBxK3Gqd+7YMRL2oGYzwhvT3=s=45MQ@mail.gmail.com>
 <f041b06.ddfa8457.17bd6e185d0@tnonline.net>
 <CAGdWbB5-uN57GF90K06yE8bw5O-S4Le+YZ-aNx3-BUSoa6hWbQ@mail.gmail.com>
Message-ID: <68ab63fd-5981-5b8c-cad1-f11b22a33169@tnonline.net>
Date:   Sun, 12 Sep 2021 19:47:31 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <CAGdWbB5-uN57GF90K06yE8bw5O-S4Le+YZ-aNx3-BUSoa6hWbQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021-09-12 00:22, Dave T wrote:
> On Sat, Sep 11, 2021 at 6:01 PM Forza <forza@tnonline.net> wrote:
>>
>>
>>
>> ---- From: Dave T <davestechshop@gmail.com> -- Sent: 2021-09-11 - 22:41 ----
>>
>>> Hello. I have a server on a LAN that will act as a backup target for
>>> clients that use btrbk to send snapshots via SSH.
>>>
>>> After my initial attempt, the backup server became extremely slow. I
>>> don't know the cause yet, and I'm starting to investigate.
>>>
>>> The first thing I would like to know from this group is whether there
>>> are special considerations for configuring or managing a server that
>>> will receive many btrfs snapshots from other devices.
>>>
>>> For example, do the general rules about limiting the number of
>>> snapshots on a volume still apply in this case?
>>>
>>> Thanks for any input.
>>
>>
>> It's hard to say much without more detailed information about your set up, such as hardware configuration, filesystem setup, etc.
> 
> I can offer any additional info needed. Rather than guess at what
> anyone wants to see, I will respond with the info upon request.

For example what kinds of disks do you use (make and model)? SMR drives 
can have really poor performance on lots of metadata IO.

And show output of "btrfs filesystem usage -T /mnt/"

> 
>> What do you consider slow?
> 
> The connected clients will freeze for several minutes, up to 15
> minutes or more sometimes. It was not just "normal slow" it was
> unusable. These periods of extreme slowness did not correspond, as far
> as I could tell, to the moments when clients were running any btrbk
> operations. It seemed random.
> 
> I started over with a "new" (i.e., repurposed) server and so far it
> seems OK in testing with just a few clients. But before I go too far
> down this path I want to make sure the general idea is workable,
> assuming I have adequate hardware.

This sounds like it is connected to snapshot deletions. They can cause 
long stalls while btrfs is in transaction. I am using btrfs myself like 
this for backups and I have not noticed it myself, however I have heard 
from users in the IRC forum #btrfs (https://web.libera.chat/#btrfs) that 
it can happen. Mostly, I think, those systems are heavily loaded.

> 
>> Some pointers to look at may be
> 
> Thank you for offering these pointers.
> 
>> * deleting snapshots can cause increased I/O.
> 
> Under what circumstances? Do you mean that when there are a lot of
> snapshots, deleting some may cause increased I/O? Deletions are
> managed per client by the btrbk config running on that client. btrbk
> sends snapshot diffs (incremental backups) to the backup server
> according to the schedule on each client, and it removes existing
> backups that exceed the allotted qty.

It would be some time after someone (btrbk) issue a "btrfs subvolume 
delete".

An alternative can be to to "rm -rf", which itself is slower, but can 
have less of an overall impact.

> 
>> * atimes can affect snapshots as they mean cow of metadata. Mount as noatime.
> 
> I am already doing that.
> 
>> * exclude snapshots from mlocate/updatedb and other indexing services. I forgot once and ended up with several gb database... :D
> 
> I am not aware of these services (mlocate/updatedb and other indexing
> services). Do you have tips for finding any such running services or
> what some of the others might be?
> 
> # which mlocate
> which: no mlocate in
> (/usr/local/sbin:/usr/local/bin:/usr/bin:/usr/lib/jvm/default/bin:/usr/bin/site_perl:/usr/bin/vendor_perl:/usr/bin/core_perl)
> # man mlocate
> No manual entry for mlocate
> 
> The mlocate package is not installed by my package manager.
> 
> I got similar results for updatedb.

This was just a guess based on my own experience.

> 
>> * space_cache=v2 can be helpful, but it increases metadata usage a little.
> 
> I am using space_cache=v2 on the main volumes, which includes where
> these "backups" are saved. The root (os) volume itself hasn't been
> converted from space_cache v1 yet (b/c I haven't had time to read up
> on that).
> 
>> * monitor disk usage allocation with 'btrfs filesystem usage /mnt'
> 
> That's a very vague recommendation. I'm already doing regular balance,
> scrub and making sure the disks are not out of space.

What I mean here is to avoid running close to full as that is not good 
for a COW filesystem.

>>
>> Good luck.
>>
> Thank you for replying. Can I assume that it is generally OK to use a
> backup server in this way where it will receive (over time) hundreds
> or thousands of backups (incremental usually) via btrbk running on
> different clients?
> 

I would say it is generally OK!


