Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E6441E8E3D
	for <lists+linux-btrfs@lfdr.de>; Sat, 30 May 2020 08:48:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728293AbgE3GsK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 30 May 2020 02:48:10 -0400
Received: from smtp-34.italiaonline.it ([213.209.10.34]:55828 "EHLO libero.it"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725929AbgE3GsK (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 30 May 2020 02:48:10 -0400
Received: from venice.bhome ([78.12.136.199])
        by smtp-34.iol.local with ESMTPA
        id evHoj0KO2trlwevHojV7Tn; Sat, 30 May 2020 08:48:07 +0200
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=libero.it; s=s2014;
        t=1590821287; bh=OTqUC0tRnTTpEeab89dpQ9ukJgenAjMHqyMVgEyhfXw=;
        h=From;
        b=MFaJTyGEQvZ5y+rSzjIFe3f1kOYRTSufPsoSTWxd4tF+lOl0V6Fd1uoYQl2VICl//
         cHU592QDfVozMCVQ0omLlzrSyPDtzh8hXLXzjqioWjsIgo6ag36UpeBT1+QazKny6i
         k0nsggWC79xfYhSjcLmEq/vyfIN1X2SN0RCBiriM4CTO/AEvgIM2B7yyzmSJOW9beF
         SYUyTEyTYANc679PqKnbgztvDeBLoazjU5K5T7kojD6iGNK26l2v5oK2G2xsLyZI+M
         z6Oe81qFZALwkwXsp0zhoOT127qxD8ncjdU5OjtQkomu/4zdRIZS3ANcTpDn7/iImE
         KycnN8TW49lpw==
X-CNFS-Analysis: v=2.3 cv=TOE7tGta c=1 sm=1 tr=0
 a=kx39m2EDZI1V9vDwKCQCcA==:117 a=kx39m2EDZI1V9vDwKCQCcA==:17
 a=IkcTkHD0fZMA:10 a=673-CtQb5l0XeYXCTkMA:9 a=QEXdDO2ut3YA:10
Reply-To: kreijack@inwind.it
Subject: Re: [RFC][PATCH V3] btrfs: ssd_metadata: storing metadata on SSD
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
Cc:     Michael <mclaud@roznica.com.ua>, Hugo Mills <hugo@carfax.org.uk>,
        Martin Svec <martin.svec@zoner.cz>,
        Wang Yugui <wangyugui@e16-tech.com>
References: <20200405082636.18016-1-kreijack@libero.it>
 <69939407-de18-e455-6c85-cd10683894be@gmx.com>
From:   Goffredo Baroncelli <kreijack@libero.it>
Message-ID: <de7c16c4-9424-8ccf-16bb-0d3b9d56b6b6@libero.it>
Date:   Sat, 30 May 2020 08:48:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <69939407-de18-e455-6c85-cd10683894be@gmx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfOgIlEfNXrXD8NlVEKcQ1gZkOYZW8ikt0LikPzJUGsafO7amX6fm4jMvTb3z+zchNsk2eQVD8POZwoMqq8dQ5h84l7KGEmt8Wg4mgylOBqQjc3yFJ1oH
 irfhF/khxKmSdx6GuPi6vKVWmuIxf1AA4kf+QjlTqOU/l1VBXACg3rWWqejIhIJAtEergTYItaShk0ucSa8UxvqSfk1Zy8riUoTk54Z2iykLKlil8jZBfGMK
 Z87X/p71krYxneCu3DmrkdopDXOA2jbFGBb3A0i/qdhcXhnf2Q3fj/F2lvSbWhU5p2x5QXyTO0/td1qfv+hs5Jl3m21L+NKFRhW06HRnmQM=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 5/30/20 6:59 AM, Qu Wenruo wrote:
[...]
>> This new mode is enabled passing the option ssd_metadata at mount time.
>> This policy of allocation is the "preferred" one. If this doesn't permit
>> a chunk allocation, the "classic" one is used.
> 
> One thing to improve here, in fact we can use existing members to
> restore the device related info:
> - btrfs_dev_item::seek_speed
> - btrfs_dev_item::bandwidth (I tend to rename it to IOPS)

Hi Qu,

this path was an older version,the current one (sent 2 days ago) store the setting
of which disks has to be considered as "preferred_metadata".
> 
> In fact, what you're trying to do is to provide a policy to allocate
> chunks based on each device performance characteristics.
> 
> I believe it would be super awesome, but to get it upstream, I guess we
> would prefer a more flex framework, thus it would be pretty slow to merge.

I agree. And considering that in the near future the SSD will become more
widespread, I don't know if the effort (and the time required) are worth.

> 
> But still, thanks for your awesome idea.
> 
> Thanks,
> Qu
> 
> 
>>
>> Some examples: (/dev/sd[abc] are ssd, and /dev/sd[ef] are rotational)
>>
>> Non striped profile: metadata->raid1, data->raid1
>> The data is stored on /dev/sd[ef], metadata is stored on /dev/sd[abc].
>> When /dev/sd[ef] are full, then the data chunk is allocated also on
>> /dev/sd[abc].
>>
>> Striped profile: metadata->raid6, data->raid6
>> raid6 requires 3 disks at minimum, so /dev/sd[ef] are not enough for a
>> data profile raid6. To allow a data chunk allocation, the data profile raid6
>> will be stored on all the disks /dev/sd[abcdef].
>> Instead the metadata profile raid6 will be allocated on /dev/sd[abc],
>> because these are enough to host this chunk.
>>
>> Changelog:
>> v1: - first issue
>> v2: - rebased to v5.6.2
>>      - correct the comparison about the rotational disks (>= instead of >)
>>      - add the flag rotational to the struct btrfs_device_info to
>>        simplify the comparison function (btrfs_cmp_device_info*() )
>> v3: - correct the collision between BTRFS_MOUNT_DISCARD_ASYNC and
>>        BTRFS_MOUNT_SSD_METADATA.
>>
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


-- 
gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5
