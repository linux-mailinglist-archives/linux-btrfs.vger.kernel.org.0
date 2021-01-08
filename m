Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51B9E2EF676
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Jan 2021 18:32:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728320AbhAHRbh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 8 Jan 2021 12:31:37 -0500
Received: from smtp-33.italiaonline.it ([213.209.10.33]:51979 "EHLO libero.it"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726011AbhAHRbh (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 8 Jan 2021 12:31:37 -0500
Received: from venice.bhome ([94.37.172.193])
        by smtp-33.iol.local with ESMTPA
        id xvb7kAIwU11DDxvb7kajpn; Fri, 08 Jan 2021 18:30:52 +0100
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=libero.it; s=s2014;
        t=1610127052; bh=244NzZgPPkZoHuqhvnfbHKOHJ3BUWjaLyB5DPGiGs+k=;
        h=From;
        b=falyYF1uHwdLsNEo813y4z7fW6GjDVN1+hW0zvx5pteXt6LxycLEGYnRYkgxioDWi
         wtIL43bS3W4DoUQnX1SLeQDyMDvu2mViEaVJgaEvFogZlDXXqKJoYWtkE9EZGFCd/r
         8urZNRruIfPM/sTDakxL/IRwn2FipECLAETrBDV8gQ7WmUH8G9VEA2av2hhnQx0D9k
         FSfAeEe0tto2yIuDJ8USmTN7j7zcNGdPSpZZ6jAvLkjqgB3xBDLUoszXH+vcbMD4+F
         ZPLodEvdYF8ch1+h93RrmB/xMPzrkYJGbsKTxrejnXb2Q09Dr2jpEXZte7FTBK+/YJ
         wm/iYpH6E5JPg==
X-CNFS-Analysis: v=2.4 cv=ba6u7MDB c=1 sm=1 tr=0 ts=5ff896cc cx=a_exe
 a=z1y4hvBwYU35dpVEhKc0WA==:117 a=z1y4hvBwYU35dpVEhKc0WA==:17
 a=IkcTkHD0fZMA:10 a=Z8ypfj2TKPnZjWwUGZkA:9 a=QEXdDO2ut3YA:10
Reply-To: kreijack@inwind.it
Subject: Re: [RFC][PATCH V4] btrfs: preferred_metadata: preferred device for
 metadata
To:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
Cc:     linux-btrfs@vger.kernel.org, Michael <mclaud@roznica.com.ua>,
        Hugo Mills <hugo@carfax.org.uk>,
        Martin Svec <martin.svec@zoner.cz>,
        Wang Yugui <wangyugui@e16-tech.com>,
        Paul Jones <paul@pauljones.id.au>,
        Adam Borowski <kilobyte@angband.pl>
References: <20200528183451.16654-1-kreijack@libero.it>
 <20210108010511.GZ31381@hungrycats.org>
From:   Goffredo Baroncelli <kreijack@libero.it>
Message-ID: <bc7d874f-3f8b-7eff-6d18-f9613e7c6972@libero.it>
Date:   Fri, 8 Jan 2021 18:30:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210108010511.GZ31381@hungrycats.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfJr7zD23OBCo0qqxyxKi/t3hildpug4HBEqDiRP5ei6ndhjW8bonuoWArxE/5V8YLUDGIvOcHpeLvDEYGCdpkK0Xb211Rbp2FT2nvIRyQpuCrIQugAHG
 13lQzXcjnUT+JqfwmM3VPEVeB6wFhnCBaIeKG4eA+6+ayjDW00T8fHt6XGhHyLkqtjh10ElWZxdiF/WwvEiMzEPLnSlhp41fh1AD/Y0xWIxCArZZBfYK2ZfU
 G++KGhHm3blUFlDY4ZjtYVewJQYnlBrWAQ3ebLcZOwpk6Zu2o1vuiFFWJMJqqZSk315Xd5bIMxAtao6liKdH2HrGV4+X9uF6RawZV+XUw+estzju2ywWnZQ1
 FII0ulfvXg9RjnBVm/QWGTZbAtQmqPgoNsELvlGtD42StOIosn6m8qS7qy2iLs+l780V73X/+kl1H3QJ0pVyOi7QDvgwDQ==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 1/8/21 2:05 AM, Zygo Blaxell wrote:
> On Thu, May 28, 2020 at 08:34:47PM +0200, Goffredo Baroncelli wrote:
>>
[...]
> 
> I've been testing these patches for a while now.  They enable an
> interesting use case that can't otherwise be done safely, sanely or
> cheaply with btrfs.

Thanks Zygo for this feedback. As usual you are source of very interesting considerations.
> 
> Normally if we have an array of, say, 10 spinning disks, and we want to
> implement a writeback cache layer with SSD, we would need 10 distinct SSD
> devices to avoid reducing btrfs's ability to recover from drive failures.
> The writeback cache will be modified on both reads and writes, data and
> metadata, so we need high endurance SSDs if we want them to make it to
> the end of their warranty.  The SSD firmware has to not have crippling
> performance bugs while under heavy write load, which means we are now
> restricted to an expensive subset of high endurance SSDs targeted at
> the enterprise/NAS/video production markets...and we need 10 of them!
> 
> NVME has fairly draconian restrictions on drive count, and getting
> anything close to 10 of them into a btrfs filesystem can be an expensive
> challenge.  (I'm not counting solutions that use USB-to-NVME bridges
> because those don't count as "sane" or "safe").
> 
> We can share the cache between disks, but not safely in writeback mode,
> because a failure in one SSD could affect multiple logical btrfs disks.
> Strictly speaking we can't do it safely in any cache mode, but at least
> with a writethrough cache we can recover the btrfs by throwing the SSDs
> away.

I will replay in a separate thread, because I found your consideration very
interesting but OT.

> 
> In the current btrfs raid5 and dm-cache implementations, a scrub through a
> SSD/HDD cache pair triggers an _astronomical_ number of SSD cache writes
> (enough to burn through a low-end SSD's TBW in a weekend).  That can
> presumably be fixed one day, but it's definitely unusable today.

Again, this is another point to discuss...

> 
> If we have only 2 NVME drives, with this patch, we can put them to work
> storing metadata, leave the data on the spinning rust, and keep all
> the btrfs self-repair features working, and get most of the performance
> gain of SSD caching at significantly lower cost.  The write loads are
> reasonable (metadata only, no data, no reads) so we don't need a high
> endurance SSD.  With raid1/10/c3/c4 redundancy, btrfs can fix silent
> metadata corruption, so we can even use cheap SSDs as long as they
> don't hang when they fail.  We can use btrfs raid5/6 for data since
> preferred_metadata avoids the bugs that kill the SSD when we run a scrub.
> 
> Now all we have to do is keep porting these patches to new kernels until
> some equivalent feature lands in mainline.  :-P

Ok, this would be doable.
> 
> I do have some comments about these particular patches:
> 
> I dropped the "preferred_metadata" mount option very early in testing.
> Apart from the merge conflicts with later kernels, the option is
> redundant, since we could just as easily change all the drive type
> properties back to 0 to get the same effect.  Adding an incompatible
> mount option (and potentially removing it again after a failed test)
> was a comparatively onerous requirement.

Could you clarify this point ? I understood that you removed some pieces
of the patch #4, but the other parts are still needed.

Anyway I have some doubt about removing entirely this options.
The options allows the new policy. The disk property instead marks the
disk as eligible as preferred storage for metadata. Are two concept
very different and I prefer to take them separates.

The behavior that you suggested is something like:
- if a "preferred metadata" properties is set on any disks, the
"preferred metadata" behavior is enabled.

My main concern is that setting this disk flag is not atomic, when
the mount option is. Would help the maintenance of the filesystem
when the user are replacing (dropping) the disks ?

Anyway I am open to ear other opinions.

> 
> The fallback to the other allocation mode when all disks of one type
> are full is not always a feature.  When an array gets full, sometimes
> data gets on SSDs, or metadata gets on spinners, and we quickly lose
> the benefit of separating them.  Balances in either direction to fix
> this after it happens are time-consuming and waste SSD lifetime TBW.
> 
> I'd like an easy way to make the preference strict, i.e. if there are
> two types of disks in the filesystem, and one type fills up, and we're
> not in a weird state like degraded mode or deleting the last drive of
> one type, then go directly to ENOSPC.  That requires a more complex
> patch since we'd have to change the way free space is calculated for
> 'df' to exclude the metadata devices, and track whether there are two
> types of device present or just one.
> 

I fear another issue: what happens when you filled the metadata disks ?
Does BTRFS allow to update the "preferred metadata" properties on a
filled disks ? I would say yes, but I am not sure what happens when
BTRFS force the filesystem RO.

Frankly speaking, I think that a slower filesystem is far better than a
locked one. A better way would be add a warning to btrfs-progs which
say: "WARNING: your preferred metadata disks are filled !!!"


>> Below I collected some data to highlight the performance increment.
>>
>> Test setup:
>> I performed as test a "dist-upgrade" of a Debian from stretch to buster.
>> The test consisted in an image of a Debian stretch[1]  with the packages
>> needed under /var/cache/apt/archives/ (so no networking was involved).
>> For each test I formatted the filesystem from scratch, un-tar-red the
>> image and the ran "apt-get dist-upgrade" [2]. For each disk(s)/filesystem
>> combination I measured the time of apt dist-upgrade with and
>> without the flag "force-unsafe-io" which reduce the using of sync(2) and
>> flush(2). The ssd was 20GB big, the hdd was 230GB big,
>>
>> I considered the following scenarios:
>> - btrfs over ssd
>> - btrfs over ssd + hdd with my patch enabled
>> - btrfs over bcache over hdd+ssd
>> - btrfs over hdd (very, very slow....)
>> - ext4 over ssd
>> - ext4 over hdd
>>
>> The test machine was an "AMD A6-6400K" with 4GB of ram, where 3GB was used
>> as cache/buff.
>>
>> Data analysis:
>>
>> Of course btrfs is slower than ext4 when a lot of sync/flush are involved. Using
>> apt on a rotational was a dramatic experience. And IMHO  this should be replaced
>> by using the btrfs snapshot capabilities. But this is another (not easy) story.
>>
>> Unsurprising bcache performs better than my patch. But this is an expected
>> result because it can cache also the data chunk (the read can goes directly to
>> the ssd). bcache perform about +60% slower when there are a lot of sync/flush
>> and only +20% in the other case.
>>
>> Regarding the test with force-unsafe-io (fewer sync/flush), my patch reduce the
>> time from +256% to +113%  than the hdd-only . Which I consider a good
>> results considering how small is the patch.
>>
>>
>> Raw data:
>> The data below is the "real" time (as return by the time command) consumed by
>> apt
>>
>>
>> Test description         real (mmm:ss)	Delta %
>> --------------------     -------------  -------
>> btrfs hdd w/sync	   142:38	+533%
>> btrfs ssd+hdd w/sync        81:04	+260%
>> ext4 hdd w/sync	            52:39	+134%
>> btrfs bcache w/sync	    35:59	 +60%
>> btrfs ssd w/sync	    22:31	reference
>> ext4 ssd w/sync	            12:19	 -45%
>>
>>
>>
>> Test description         real (mmm:ss)	Delta %
>> --------------------     -------------  -------
>> btrfs hdd	             56:2	+256%
>> ext4 hdd	            51:32	+228%
>> btrfs ssd+hdd	            33:30	+113%
>> btrfs bcache	            18:57	 +20%
>> btrfs ssd	            15:44	reference
>> ext4 ssd	            11:49	 -25%
>>
>>
>> [1] I created the image, using "debootrap stretch", then I installed a set
>> of packages using the commands:
>>
>>    # debootstrap stretch test/
>>    # chroot test/
>>    # mount -t proc proc proc
>>    # mount -t sysfs sys sys
>>    # apt --option=Dpkg::Options::=--force-confold \
>>          --option=Dpkg::options::=--force-unsafe-io \
>> 	install mate-desktop-environment* xserver-xorg vim \
>>          task-kde-desktop task-gnome-desktop
>>
>> Then updated the release from stretch to buster changing the file /etc/apt/source.list
>> Then I download the packages for the dist upgrade:
>>
>>    # apt-get update
>>    # apt-get --download-only dist-upgrade
>>
>> Then I create a tar of this image.
>> Before the dist upgrading the space used was about 7GB of space with 2281
>> packages. After the dist-upgrade, the space used was 9GB with 2870 packages.
>> The upgrade installed/updated about 2251 packages.
>>
>>
>> [2] The command was a bit more complex, to avoid an interactive session
>>
>>    # mkfs.btrfs -m single -d single /dev/sdX
>>    # mount /dev/sdX test/
>>    # cd test
>>    # time tar xzf ../image.tgz
>>    # chroot .
>>    # mount -t proc proc proc
>>    # mount -t sysfs sys sys
>>    # export DEBIAN_FRONTEND=noninteractive
>>    # time apt-get -y --option=Dpkg::Options::=--force-confold \
>> 	--option=Dpkg::options::=--force-unsafe-io dist-upgrade
>>
>>
>> BR
>> G.Baroncelli
>>
>> -- 
>> gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
>> Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5
>>
>>
>>
>>
>>


-- 
gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5
