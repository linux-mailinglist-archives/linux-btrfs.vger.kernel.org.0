Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDE2B22B6F7
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 Jul 2020 21:53:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726455AbgGWTxC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 23 Jul 2020 15:53:02 -0400
Received: from smtp-32.italiaonline.it ([213.209.10.32]:56051 "EHLO libero.it"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725894AbgGWTxC (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 23 Jul 2020 15:53:02 -0400
Received: from venice.bhome ([78.12.13.37])
        by smtp-32.iol.local with ESMTPA
        id yhH1jcZOjzS33yhH1jvuj5; Thu, 23 Jul 2020 21:52:59 +0200
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=libero.it; s=s2014;
        t=1595533979; bh=Z8O+iCzpBkjQYE18m+10HiynJRFOtM/iLbEHHXOvbeE=;
        h=From;
        b=S6ENXFrGHG2uyIyjIu/LMVeKn007sHzDV59cBMU9S3j/AbrWSXn5x/XW85kyd8Z4r
         kUBSh/3M5dx8Jot1MLKC7+E7Qg/Y6gR4BfMU7+f0wXGTu6ANuxtxXizSyAEzwpkUj1
         yr0mrweyAQIn23unzkPoCrQBwJ6BrY4F5wREp4exAn7P52kZ4+2FxOvNl2wA4XDxng
         qOKjdfmyGojVCC1M0j74ki/eouynlt6CdaoFFdXEaMTi4pyFXlxvcfvaoVicBH9kBk
         Tfb4ThQ6aRW+8qSVZ/HI5Wkgm07dx52UHLq8OR+z6dkBuZyXHmqOy0B32+ZyeP4qpm
         EOrz0lxDIIVSg==
X-CNFS-Analysis: v=2.3 cv=PLVxBsiC c=1 sm=1 tr=0
 a=XJAbuhTEZzHZh8gzL9OeLg==:117 a=XJAbuhTEZzHZh8gzL9OeLg==:17
 a=IkcTkHD0fZMA:10 a=OBBw11hQ-LK4APZSOAAA:9 a=QEXdDO2ut3YA:10
Reply-To: kreijack@inwind.it
Subject: Re: [RFC] btrfs: strategy to perform a rollback at boot time
To:     Steven Davies <btrfs-list@steev.me.uk>, linux-btrfs@vger.kernel.org
References: <20200721203340.275921-1-kreijack@libero.it>
 <1e058a3e-a563-152b-b6df-57fa18b13df8@steev.me.uk>
From:   Goffredo Baroncelli <kreijack@libero.it>
Message-ID: <56ad93b8-01c5-251e-58d6-1d3a7abdce80@libero.it>
Date:   Thu, 23 Jul 2020 21:52:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1e058a3e-a563-152b-b6df-57fa18b13df8@steev.me.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfCo8utIm+3FF9LDcNpwgIOKYt/2vQJJabr2J6Z6UMBt93P5RBO1KFwt/1XYfHcOraXEq+fckvTzZlCQmxQo1G5nUZbj6/Y8k1IQMuzWtCdzGm3UDjZjg
 XzfFJZksXpB/E8zWaDcrT4LmaGzmusHUAwOptrwV3+vnt+Ag5NLBHsZJmfkNlpyzFdwL5m9qoxEjEyOXygtK/kloUJeP8Cc0EtE=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 7/21/20 10:55 PM, Steven Davies wrote:
> On 21/07/2020 21:33, Goffredo Baroncelli wrote:
>>
>> Hi all,
>>
>> this is an RFC to discuss a my idea to allow a simple rollback of the
>> root filesystem at boot time.
>>
>> The problem that I want to solve is the following: DPKG is very slow on
>> a BTRFS filesystem. The reason is that DPKG massively uses
>> sync()/fsync() to guarantee that the filesystem is always coherent even
>> in case of sudden shutdown.
>>
>> The same can be useful even to the RPM Linux based distribution (which however
>> suffer less than DPKG).
>>
>> A way to avoid the sync()/fsync() calls without loosing the DPKG
>> guarantees, is:
>> 1) perform a snapshot of the root filesystem (the rollback one)
>> 2) upgrade the filesystem without using sync/fsync
>> 3) final (global) sync
>> 4) destroy the rollback snapshot
>>
>> If an unclean shutdown happens between 1) and 4), two subvolume exists:
>> the 'main' one and the 'rollback' one (which is the snapshot before the
>> update). In this case the system at boot time should mount the "rollback"
>> subvolume instead of the "main" one. Otherwise in case of a "clean" boot, the
>> "rollback" subvolume doesn't exist and only the "main" one can be
>> mounted.
>>
>> In [1] I discussed a way to implement the steps 1 to 4. (ok, I missed
>> the point 3) ).
>>
>> The part that was missed until now, is an automatic way to mount the rollback
>> subvolume at boot time when it is present.
>>
>> My idea is to allow more 'subvol=' option. In this case BTRFS tries all the
>> passed subvolumes until the first succeed. So invoking the kernel as:
>>
>>    linux root=UUID=xxxx rootflags=subvol=rollback,subvol=main ro
>>
>> First, the kernel tries to mount the 'rollback' subvolume. If the rollback
>> subvolume doesn't exist then it mounts the 'main' subvolume.
>>
>> Of course after the mount, the system should perform a cleanup of the
>> subvolumes: i.e. if a rollback subvolume exists, the system should destroy
>> the "main" one (which contains garbage) and rename "rollback" to "main".
>> To be more precise:
>>
>>     if test -d "rollback"; then
>>         if test -d "old"; then
>>             btrfs sub del "old"
>>         fi
>>         if test -d "main"; then
>>             mv "main" "old"
>>         fi
>>         mv "rollback" "main"
>>         btrfs sub del "old"
>>     fi
>>
>> Comments are welcome
> 
> I like this idea. Do we have an easy way of detecting which subvolume has been mounted (through sysfs or similar), or would you expect to always be testing this based on the existence of certain subvolumes/directories?

You can use findmnt or cat /proc/self/mountinfo

$  findmnt  | egrep btrfs
/                                     /dev/sde3[/debian] btrfs       rw,noatime,nodiratime,nossd,space_cache,subvolid=257,subvol=/debian
├─/boot                               /dev/sde3[/boot]   btrfs       rw,noatime,nodiratime,nossd,space_cache,subvolid=258,subvol=/boot
├─/var/btrfs                          /dev/sde3          btrfs       rw,noatime,nodiratime,nossd,space_cache,subvolid=5,subvol=/
└─/mnt/btrfs-raid1                    /dev/sdd2          btrfs       rw,noatime,nodiratime,space_cache,subvolid=5,subvol=/


$ cat /proc/self/mountinfo  | egrep btrfs
26 1 0:22 /debian / rw,noatime,nodiratime shared:1 - btrfs /dev/sde3 rw,nossd,space_cache,subvolid=257,subvol=/debian
113 26 0:22 / /var/btrfs rw,noatime,nodiratime shared:61 - btrfs /dev/sde3 rw,nossd,space_cache,subvolid=5,subvol=/
112 26 0:22 /boot /boot rw,noatime,nodiratime shared:63 - btrfs /dev/sde3 rw,nossd,space_cache,subvolid=258,subvol=/boot
127 26 0:46 / /mnt/btrfs-raid1 rw,noatime,nodiratime shared:71 - btrfs /dev/sdd2 rw,space_cache,subvolid=5,subvol=/
> 


-- 
gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5
