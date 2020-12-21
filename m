Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C7B72E0181
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Dec 2020 21:25:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725953AbgLUUY4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 21 Dec 2020 15:24:56 -0500
Received: from smtp-33.italiaonline.it ([213.209.10.33]:53946 "EHLO libero.it"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725780AbgLUUY4 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 21 Dec 2020 15:24:56 -0500
Received: from venice.bhome ([94.37.172.193])
        by smtp-33.iol.local with ESMTPA
        id rRj3kWCKOjQzorRj4kJrn4; Mon, 21 Dec 2020 21:24:14 +0100
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=libero.it; s=s2014;
        t=1608582254; bh=jHBND0z6xMiYK58nphwg5ivbsIGajSI/C7j4F+YMsUg=;
        h=From;
        b=Idm/VScUCg+J8c5yw8BY7c1dKWzLumEJkJh1XQvadlyLfLATWtVw6aDYSh4PE3lgh
         leezoZM/RLA0GyFgMHQG+qHRluqz0pyIBxPbVaQKefMTU/v/dNbLfyeS2LWJ0rl6wv
         RiNytYZ+BsSHGGpbOZRnaxC3VkSPHH9wg0Ho5g3OaeUxRqrWXqXuw8nQoLJojqZfwD
         +rsTWNBSc8yYQtB+rL2S712vHG4Zr+uPkN6pDdPefJCrwoQJfvEUQ+IuaS2PxetV8j
         JLloZUFLEEj88yvr/F3kKSdJUOys0weSojMXaQ1AUTYAEZ/SuKNKpY2jEmVMYE+rEA
         AUk0kwZih8uCQ==
X-CNFS-Analysis: v=2.4 cv=e6rD9Yl/ c=1 sm=1 tr=0 ts=5fe1046e cx=a_exe
 a=z1y4hvBwYU35dpVEhKc0WA==:117 a=z1y4hvBwYU35dpVEhKc0WA==:17
 a=IkcTkHD0fZMA:10 a=vMTNzZOhSSq_wz1HsbEA:9 a=QEXdDO2ut3YA:10
Reply-To: kreijack@inwind.it
Subject: Re: WG: How to properly setup for snapshots
To:     Andrei Borzenkov <arvidjaar@gmail.com>,
        Roman Mamedov <rm@romanrm.net>,
        Remi Gauvin <remi@georgianit.com>
Cc:     Claudius Ellsel <claudius.ellsel@live.de>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
References: <AM9P191MB165033908B55F8312178D90AE2CB0@AM9P191MB1650.EURP191.PROD.OUTLOOK.COM>
 <AM9P191MB1650A1159D554207CB5D738AE2C00@AM9P191MB1650.EURP191.PROD.OUTLOOK.COM>
 <a68cd516-d6a2-b7ee-744b-d1b0ee83c2df@georgianit.com>
 <20201221223701.0845e9ad@natsu>
 <3d45b062-a004-277e-db8b-6826c6b342bb@gmail.com>
From:   Goffredo Baroncelli <kreijack@libero.it>
Message-ID: <0d1a1fb0-f4c1-3207-cd04-b8f0cf97bddc@libero.it>
Date:   Mon, 21 Dec 2020 21:24:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <3d45b062-a004-277e-db8b-6826c6b342bb@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfIB7ir5U1ey9SW7Y1XzB13MhWHwHz8JatNfNwS+tptqC2EcDi0FjLXUmYa7YWgm4SeqN6DNC0XaQxEkMPUkzD3PebiWNum6Rj1vkMUSTDmw5jf5OoAyB
 z3yamNfBO/rPf8dtpXHS1Uw4sD5vW0nk1cQH8WZw9+DKYDOWga3P3ko2MveZ9GcKKH4U6UxZJFqhfTls/UgnV/MJkMbytAmAdK7HWKO7vXC2ySBAsskei+LS
 p54oBEMSdAGXAp0xVKrpiOM4qwHxCTxU6MUgchx/9nsyn+BjK2RZ1mxqL+BsM/FOznH8LrFFmhkJHIvVCoMulw==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 12/21/20 7:26 PM, Andrei Borzenkov wrote:
> 21.12.2020 20:37, Roman Mamedov пишет:
[...]
> Having dedicated subvolume containing snapshots makes it easy to switch
> your root between subvolumes (either for roll back or transactional
> updates or whatever) and retain access to snapshots by simply mounting
> containing subvolume. Having them in subdirectory of your (root)
> subvolume means you can no more remove this subvolume without also
> destroying snapshots before, so you are stuck with it.
> 
> So it makes all sort of sense to think in advance and prepare dedicated
> subvolume for this purpose.

There is an asymmetry of the '/' subvolume; it can't be deleted, so it is not easy and cheap to swap it with its snapshot.

In my setup, I uses the '/' subvolume as container of all the other subvolumes, one of these is the root of my filesystem. Then each subvolume is mounted where it is needed:

$ findmnt  | egrep sdg3
/                                     /dev/sdg3[/@rootfs]       btrfs       rw,noatime,nodiratime,nossd,space_cache,subvolid=448,subvol=/@rootfs
├─/boot                               /dev/sdg3[/@boot]         btrfs       rw,noatime,nodiratime,nossd,space_cache,subvolid=258,subvol=/@boot
├─/var/btrfs                          /dev/sdg3                 btrfs       rw,noatime,nodiratime,nossd,space_cache,subvolid=5,subvol=/
├─/var/lib/machines/vm-sqlserver      /dev/sdg3[/@vm-sqlserver] btrfs       rw,noatime,nodiratime,nossd,space_cache,subvolid=454,subvol=/@vm-sqlserver
├─/var/lib/portables                  /dev/sdg3[/@portables]    btrfs       rw,noatime,nodiratime,nossd,space_cache,subvolid=282,subvol=/@portables
├─/var/log                            /dev/sdg3[/@log]          btrfs       rw,noatime,nodiratime,nossd,space_cache,subvolid=447,subvol=/@log

I mount the '/' subvolume under /var/btrfs, where i manage the subvolume. With this setup is easy to snapshot the root filesystem (/dev/sdg3[/@rootfs]) and mount the snapshot instead the old root. The other part of the filesystem which are better to not involve in the snapshot-rollback process (like /boot, /var/log...) are in a separate subvolumes which are mounted at boot time using /etc/fstab

I tough quite often that mkfs.btrfs should allow to create a "default" subvolume inside the '/'. It would simplify the management of the root filesystem in case if the user want to srollback the system to a previous snapshot.

BR

> 
>> not much of the "inside". Might as well just create a regular directory for
>> that -- and with less potential for confusion.
>>
>> * - keep in mind that "snapshot" and "subvolume" mean the same thing in Btrfs,
>>      the only difference being that "snapshot"-subvolume started its life as
>>      being a full copy(-on-write) of some other subvolume.
>>
> 


-- 
gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5
