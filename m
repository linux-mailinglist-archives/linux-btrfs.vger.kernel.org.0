Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F9D13FEA5A
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Sep 2021 10:04:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243772AbhIBIFX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Sep 2021 04:05:23 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:60908 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233362AbhIBIFV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 2 Sep 2021 04:05:21 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 230801FF79;
        Thu,  2 Sep 2021 08:04:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1630569856; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KEUFu9BwEsLbmt2puPFgt6m0lQnmkG2ngQNrpzAUME0=;
        b=CeOS01Vm8cAK2aSh9HclGvbGwvd6yJEt2wGGutMxLwc7swGjkAxeNkv5m2UiaPxOS+zV5y
        ImfsNHYpceXA7JBPM3O0r4NFhcbVSdIQ1A5n3l9eZxW/WP8zXYXxkJg3y8okZO74ki/SpW
        9N9RE0wwikJRcZezAYxrL5ZLAd//afg=
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id AE80213A75;
        Thu,  2 Sep 2021 08:04:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id yVJnJ3+FMGFiQwAAGKfGzw
        (envelope-from <nborisov@suse.com>); Thu, 02 Sep 2021 08:04:15 +0000
Subject: Re: how to replace a failed drive?
To:     Andrei Borzenkov <arvidjaar@gmail.com>,
        Anand Jain <anand.jain@oracle.com>,
        Tomasz Chmielewski <mangoo@wpkg.org>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <b0bda3d5dba746c48bb264bea8ebc1cc@virtall.com>
 <70615a2e-bf3e-c56b-d536-48bd9cfdfb8c@oracle.com>
 <3d2ca50d-3f86-4b8d-ea42-2d7ca0135c52@gmail.com>
From:   Nikolay Borisov <nborisov@suse.com>
Message-ID: <167aa65f-ed1e-dced-5a53-a1e14fca0da9@suse.com>
Date:   Thu, 2 Sep 2021 11:04:15 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <3d2ca50d-3f86-4b8d-ea42-2d7ca0135c52@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2.09.21 г. 11:00, Andrei Borzenkov wrote:
> On 02.09.2021 10:45, Anand Jain wrote:
>> On 02/09/2021 06:07, Tomasz Chmielewski wrote:
>>> I'm trying to follow
>>> https://btrfs.wiki.kernel.org/index.php/Using_Btrfs_with_Multiple_Devices#Replacing_failed_devices
>>> to replace a failed drive. But it seems to be written by a person who
>>> never attempted to replace a failed drive in btrfs filesystem, and who
>>> never used mdadm RAID (to see how good RAID experience should look like).
>>>
>>> What I have:
>>>
>>> - RAID-10 over 4 devices (/dev/sd[a-d]2)
>>> - 1 disk (/dev/sdb2) crashed and was no longer seen by the operating
>>> system
>>> - it was replaced using hot-swapping - new drive registered itself as
>>> /dev/sde
>>> - I've partitioned /dev/sde, so that /dev/sde2 matches the size of
>>> other btrfs devices
>>> - because I couldn't remove the faulty device (it wouldn't go below my
>>> current number of devices) I've added the new device to btrfs filesystem:
>>>
>>
>>
>>> btrfs device add /dev/sde2 /data/lxd
>>
>>  Wiki is correct.
>>
>>  $ btrfs replace start 7 /dev/sdf1 /mnt
>>
> 
> Where exactly user is supposed to find out the correct number of missing
> device? Because
> ...
> 
>>>
>>> # btrfs filesystem show /data/lxd
>>> Label: 'lxd5'  uuid: 2b77b498-a644-430b-9dd9-2ad3d381448a
>>>          Total devices 5 FS bytes used 2.84TiB
>>>          devid    1 size 1.73TiB used 1.60TiB path /dev/sda2
>>>          devid    3 size 1.73TiB used 1.60TiB path /dev/sdd2
>>>          devid    4 size 1.73TiB used 1.60TiB path /dev/sdc2
>>>          devid    6 size 1.73TiB used 0.00B path /dev/sde2
>>>          *** Some devices missing
>>>
> 
> It only shows existing devices. "Some devices missing" is not exactly
> helping. More useful would be "devid 7 missing".

Device missing is generally written in dmesg:

[168454.469038] BTRFS warning (device loop1): devid 3 uuid
5e73af15-91d4-416e-bafb-068801d8e561 is missing


But you are right this is definitely not very user friendly. I'll look
into trying to see if it's possible to have the missing device printed
by progs.

> 
