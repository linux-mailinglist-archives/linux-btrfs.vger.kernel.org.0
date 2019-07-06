Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3D37660E3A
	for <lists+linux-btrfs@lfdr.de>; Sat,  6 Jul 2019 02:06:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726722AbfGFAFs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 5 Jul 2019 20:05:48 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:35989 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726698AbfGFAFs (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 5 Jul 2019 20:05:48 -0400
Received: by mail-wm1-f65.google.com with SMTP id g67so4937710wme.1
        for <linux-btrfs@vger.kernel.org>; Fri, 05 Jul 2019 17:05:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SIgJK/SxjsmKLkKeZhBfy9FBoataudn6yMnZ9gruO0I=;
        b=pdssjBRI5tE7aoh57CNv3tl4BDS26+XxH8SuRs+xQbjTEvxQ2GqDUSDR3tNGjYt6t0
         cAio3j1DG9TjuewqMgSMrif/UuCADGE4a8zIcEi4kKtLb0QDeWfeN0aIvmbFmd3nglR4
         /PcTq5j4wJHFZ9FsVfROCCTcinjylUbEP9Fmc2ggTg9t9EXKfoje1vdiAW2nYQ380Bud
         ihXzyJIp+ohkx3sBLds0OlUKkYxqc7kXcV90rJv62F3uPcwu5R0YNp6DjjCWNvDRJKJR
         IbMe7Axn/rvUuBSl90l+Wqj/XugSrkPn8FIX5OoxGnNRrfZSF46Li7uhhLBG19WGZ/BI
         c0Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=SIgJK/SxjsmKLkKeZhBfy9FBoataudn6yMnZ9gruO0I=;
        b=aymcEM/heJ+vwstA/g+Nz/zvjnzZW5URIDu7k6kNH9c/OtiF0HCUIF13K8DnqVKUTm
         /7H2USPtAWmaj6cRmLD0iGmeMvtWUpdLL4WZP1nq1uq9yjbTX3T2hHX76ZKpU7Os5rLq
         6MvgqOru9VHDFtef+YWY/odjxcRBkzSLMzidMpcx0lckKoYJ+sVMc5LkkEmKR/jH8qgQ
         K7gyiNHwnknCv620Wjh3AACEf+8eFM6TDaPMymtsCSPlmBTpQmA4eur1P0nn9WDogHQt
         8eo7IgOxFPpbXnN1TTS74lIlKv+dHu/mYhbJy0LfN0ycQoQcWhpSUhY7S42zHw6d5vsf
         fLGw==
X-Gm-Message-State: APjAAAV1MsNFonuuzBa2ze6yf9Zqm4F1URXrCc6g2fLQjqcARUz3nQAj
        WI5XN10WWeUOcAPVqS5a0K6y0l/dPaU=
X-Google-Smtp-Source: APXvYqwrPHx6GsoJxpD1L/WjtmWkHmlugxbTQyvN26Fui88Sa9wapcWuLR4IeLjiDyyS/hmW4Srfvw==
X-Received: by 2002:a7b:ce83:: with SMTP id q3mr5147144wmj.116.1562371544415;
        Fri, 05 Jul 2019 17:05:44 -0700 (PDT)
Received: from home.thecybershadow.net ([89.28.117.31])
        by smtp.gmail.com with ESMTPSA id p3sm6610218wmg.15.2019.07.05.17.05.43
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Jul 2019 17:05:43 -0700 (PDT)
Subject: Re: "kernel BUG" and segmentation fault with "device delete"
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <966f5562-1993-2a4f-0d6d-5cea69d6e1c6@gmail.com>
 <CAJCQCtRhXukLGrWTK1D5TLRhxwF6e31oewOSNDg2TAxSanavMA@mail.gmail.com>
From:   Vladimir Panteleev <thecybershadow@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=thecybershadow@gmail.com; prefer-encrypt=mutual; keydata=
 mQENBFar2yQBCADWo1C5Ir1smytf7+vWGCEoZgb/4XKkxrp+GUO7eJO8iYCWHTmCPZpi6p/z
 y6eh+NYcDQSRzKA99ffgdN+aT8/L6d63pYdsgtDmX/yrFWyLOVgW62LQpC/To4MTJAIgY/Rg
 /VjdifOJtYFvr+BKJwFCTfcviy4EQjsfHLnyJjvL9BiCXfSBXASc/Gn9WOTL5ZNpk4TStGXO
 +/2PIKeg228LtJ5vc/vemBo4hcjJv9ttX7dCebpSAbNo7GgOs8XNgJU2mEcra3IMT15dGk0/
 KpGMx7bMinTIlxx/BAGt5M5w8OnNi4p2AcKzvH18OTE7Lssn5ub8Ains32hbUFf18hJbABEB
 AAG0K1ZsYWRpbWlyIFBhbnRlbGVldiA8Z3BnQHRoZWN5YmVyc2hhZG93Lm5ldD6JAVEEEwEI
 ADsCGwMFCwkIBwIGFQgJCgsCBBYCAwECHgECF4AWIQS77RsIjO1/lYkX++hQBPD60FFXbQUC
 WJ9eKQIZAQAKCRBQBPD60FFXbX0yB/9PEcY3H9mEZtU1UVqxLzPMVXUX5Khk6RD3Jt8/V7aA
 vu8VO4qwmnhadRPHXxVwnnVotao9d5U1zHw0gDhvJWelGRm52mKAPtyPwtBy4y3oXzymLfOM
 RIZxwxMY5RkbqdgWNEY7tCplABnWmaUMm5qDIjzkbEabpiqGySMy2gy6lQHUdRHcgFqO+ceZ
 R7IOPEh2fnVuQc5t1V56OHHRQZMQLgGupInST+svryv2sfr5+ZJqtwWL3nn8aFER6eIWzDDu
 m9y2RZnykbfwd56c81bpY6qqZtHkyt0hImkOwOiBj3UWtJvgZ95WnJ8NBPHPcttgL3vQTsXu
 BRYEjQZln81tuQENBFar2yQBCADFGh8NqHMtBT8F4m/UzQx0QAMDyPQN3CjKn67gW//8gd5v
 TmZCws2TwjaGlrJmwhGseUkZ368dth5vZLPu95MVSo2TBGf+XIVPsGzX6cuIRNtvQOT5YSUz
 uOghU0wh5gjw7evg7d0qfZRTZ2/JAuWmeTvPl66dasUoqKxVrq5o2MXdYkI6KoSxTsal3/36
 ii5cl2GfzE+bVAj3MB8B0ktdIZCHAJT8n+8h10/5TD5oEkWjhWdATeWMrC2bZwFykgSKjY/3
 jUvmfeyJp56sw5w3evZLQdQCo+NWoFGHdHBm0onyZbgbWS+2DEQI+ee0t6q6/iR1tf8VPX2U
 LY0jjiZ7ABEBAAGJAR8EGAEIAAkFAlar2yQCGwwACgkQUATw+tBRV200GQf8CaQxTy7OhWQ5
 O47G3+yKuBxDnYoP9h+T/sKcWsOUgy7i/vbqfkJvrqME8rRiO9YB/1/no1KqXm+gq0rSeZjy
 DA3mk9pNKvreHX9VO1md4r/vZF6jTwxNI7K97T34hZJGUQqsGzd8kMAvrgP199tXGG2+NOXv
 ih44I0of/VFFklNmO87y/Vn5F8OfNzwiHLNleBXZ1bMp/QBMd3HtahZVk7xRMNAKYqkyvI/C
 z0kgoHYP9wKpSmbPXJ5Qq0ndAJ7KIRcIwwDcbh3/F9Icj/N3v0SpxuJO7l0KlXQIWQ7TSpaO
 liYT2ARnGHHYcE2OhA0ixGV3Y3suUhk+GQaRQoiytw==
Message-ID: <a4920d21-3c90-9a96-9b44-f90d7b5eed3a@gmail.com>
Date:   Sat, 6 Jul 2019 00:05:42 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <CAJCQCtRhXukLGrWTK1D5TLRhxwF6e31oewOSNDg2TAxSanavMA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi Chris,

First, thank you very much for taking the time to reply. I greatly 
appreciate it.

On 05/07/2019 21.43, Chris Murphy wrote:
> There's no parity on either raid10 or raid1.

Right, thank you for the correction. Of course, I meant the duplicate 
copies of the RAID1 data.

> But I can't tell from the
> above exactly when each drive was disconnected. In this scenario you
> need to convert to raid1 first, wait for that to complete successfully
> before you can do a device remove. That's clear.  Also clear is you
> must use 'btrfs device remove' and it must complete before that device
> is disconnected.

Unfortunately as mentioned before that wasn't an option. I was 
performing this operation on a DM snapshot target backed by a file that 
certainly could not fit the result of a RAID10-to-RAID1 rebalance.

> What I've never tried, but the man page implies, is you can specify
> two devices at one time for 'btrfs device remove' if the profile and
> the number of devices permits it.

What I found surprising, was that "btrfs device delete missing" deletes 
exactly one device, instead of all missing devices. But, that might be 
simply because a device with RAID10 blocks should not have been 
mountable rw with two missing drives in the first place.

>> After stubbing out btrfs_check_rw_degradable (because btrfs currently
>> can't realize when it has all drives needed for RAID10),
> 
> Uhh? This implies it was still raid10 when you disconnected two drives
> of a four drive raid10. That's definitely data loss territory.
> However, your 'btrfs fi us' command suggests only raid1 chunks. What
> I'm suspicious of is this:
> 
>>> Data,RAID1: Size:2.66TiB, Used:2.66TiB
>>>   /dev/sdd1   2.66TiB
>>>   /dev/sdf1   2.66TiB
> 
> All data block groups are only on sdf1 and sdd1.
> 
>>> Metadata,RAID1: Size:57.00GiB, Used:52.58GiB
>>>    /dev/sdd1  57.00GiB
>>>   /dev/sdf1  37.00GiB
>>>    missing  20.00GiB
> 
> There's metadata still on one of the missing devices. You need to
> physically reconnect this device. The device removal did not complete
> before this device was physically disconnected.
> 
>>> System,RAID1: Size:8.00MiB, Used:416.00KiB
>>>    /dev/sdd1   8.00MiB
>>>    missing   8.00MiB
> 
> This is actually worse, potentially because it means there's only one
> copy of the system chunk on sdd1. It has not been replicated to sdf1,
> but is on the missing device.

I'm sorry, but that's not right. As I mentioned in my second email, if I 
use btrfs device replace, then it successfully rebuilds all missing 
data. So, there is no lost data with no remaining copies; btrfs is 
simply having some trouble moving it off of that device.

Here is the filesystem info with a loop device replacing the missing drive:

https://dump.thecybershadow.net/9a0c88c3720c55bcf7fee98630c2a8e1/00%3A02%3A17-upload.txt

> Depending on degraded operation for this task is the wrong strategy.
> You needed to 'btrfs device delete/remove' before physically
> disconnecting these drives.
> 
> OK you definitely did this incorrectly if you're expecting to
> disconnect two devices at the same time, and then "btrfs device delete
> missing" instead of explicitly deleting drives by ID before you
> physically disconnect them.

I don't disagree in general, however, I did make sure that all data was 
accessible with two devices before proceeding with this endeavor.

> It sounds to me like you had a successful conversion from 4 disk
> raid10 to a 4 disk raid1. But then you're assuming there are
> sufficient copies of all data and metadata on each drive. That is not
> the case with Btrfs. The drives are not mirrored. The block groups are
> mirrored. Btrfs raid1 tolerates exactly 1 device loss. Not two.

Whether it was through dumb luck or just due to the series of steps I've 
happened to have taken, it doesn't look like I've lost any data so far. 
But thank you for the correction regarding how RAID1 works in btrfs, 
I've indeed been misunderstanding it.

>> We need to see a list of commands issued in order, along with the
>> physical connected state of each drive. I thought I understood what
>> you did from the previous email, but this paragraph contradicts my
>> understanding, especially when you say "correct approach would be
>> first to convert all RAID 10 to RAID1 and then remove devices but that
>> wasn't an option"
>>
>> OK so what did you do, in order, each command, interleaving the
>> physical device removals.

Well, at this point, I'm still quite confident that the BTRFS kernel bug 
is unrelated to this entire RAID10 thing, but I'll do so if you like. 
Unfortunately I do not have an exact record of this, but I can do my 
best to reconstruct it from memory.

The reason I'm doing this in the first place is that I'm trying to split 
a 4-drive RAID10 array that was getting full. The goal was to move some 
data off of it to a new array, then delete it from its original 
location. I couldn't use rsync because most of the data was in 
snapshots, and I couldn't use btrfs send/receive because it bugs out 
with the old "chown oXXX-XXXXXXX-0 failed: No such file or directory" 
bug. So, my idea was:

1. Use device mapper to create a COW copy of all four devices, and 
operate on those (make the SATA devices read-only to ensure they're not 
touched)
2. Use btrfs-tune to change the UUID of the new filesystem
3. Delete 75%-ish of data off of the COW copy
4. Somehow convert the 4-disk RAID10 to 2-disk RAID1 without incurring a 
ton of writes to the COW copies
5. dd the contents of the COW copies to two new real disks
6. After ensuring the remaining data is safe on the new disks, delete it 
from the original array.

For steps 2 and 3, I needed to specify the exact devices to work with. 
It's possible to specify the device list when mounting with -o device=, 
but for btrfstune, I had to bind-mount a fake partitions file over 
/proc/partitions. I can share the scripts I used for all this if you like.

Anyway, step 4 is the one I was having trouble with. After a few failed 
approaches, what I did was:
1. Find a pair of disks that had a copy of all data (there was no 
guarantee that this was possible, but it did happen to be for me)
2. dd them to real disks
3. mount them as rw+degraded with a kernel patch
4. btrfs balance start -dconvert=raid1 -mconvert=raid1 /mnt/a
5. sudo btrfs device delete missing /mnt/a
6. sudo btrfs device delete missing /mnt/a

and that's when the kernel bug happens.

> To put a really fine point on this, in my estimation the data on sdf
> and sdd are hanging by a thread. It's likely you have partial data
> loss because clearly some Btrfs metadata is missing and there are no
> other copies of it. For sure you do not want to try to repair the file
> system, or do anything that will cause any writes to happen. Any
> changes to the file system now will almost certainly make problems
> worse, and the chance of recovery will be reduced.

Thank you for the concern. As mentioned above, I'm pretty sure all the 
data is safe and accessible. Also, I have a copy of all data of the 
filesystem still.

Have you had a chance to look at the kernel stack trace yet? It looks 
like it's running out of temporary space to perform a relocation. I 
think that is where we should be concentrating on.

-- 
Best regards,
  Vladimir
