Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 76ADBDDE86
	for <lists+linux-btrfs@lfdr.de>; Sun, 20 Oct 2019 15:04:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726307AbfJTNEc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 20 Oct 2019 09:04:32 -0400
Received: from mailfilter03-out31.webhostingserver.nl ([141.138.168.202]:13372
        "EHLO mailfilter03-out31.webhostingserver.nl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726298AbfJTNEc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 20 Oct 2019 09:04:32 -0400
X-Halon-ID: 139ed88f-f33a-11e9-ba6d-001a4a4cb9a5
Received: from s198.webhostingserver.nl (unknown [195.211.72.171])
        by mailfilter03.webhostingserver.nl (Halon) with ESMTPSA
        id 139ed88f-f33a-11e9-ba6d-001a4a4cb9a5;
        Sun, 20 Oct 2019 13:03:57 +0000 (UTC)
Received: from cust-178-250-146-69.breedbanddelft.nl ([178.250.146.69] helo=[10.8.0.10])
        by s198.webhostingserver.nl with esmtpa (Exim 4.92.3)
        (envelope-from <fntoth@gmail.com>)
        id 1iMAsl-003Sq0-Ol; Sun, 20 Oct 2019 15:04:27 +0200
Subject: Re: [PATCH 0/3] btrfs-progs: Add check and repair for invalid inode
 generation
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, Qu WenRuo <wqu@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <20190924081120.6283-1-wqu@suse.com>
 <36d45e31-f125-4b21-a68e-428f807180f7@gmail.com>
 <b1c32c4b-734f-0f4e-44d1-cb4ef69b7fe1@suse.com>
 <796be1b6-1f1d-7946-e53e-9b85610c7c65@gmail.com>
 <c56c880f-22c9-4200-87e5-81e61a1ada0b@gmx.com>
 <5315fc1e-f0e6-68ca-8938-33bc0dbce07d@gmx.com>
From:   Ferry Toth <fntoth@gmail.com>
Message-ID: <df807dde-ecdf-9bc9-cb7d-1bf1cc9c27c1@gmail.com>
Date:   Sun, 20 Oct 2019 15:04:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <5315fc1e-f0e6-68ca-8938-33bc0dbce07d@gmx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-SendingUser: hidden
X-SendingServer: hidden
X-Antivirus-Scanner: Clean mail though you should still use an Antivirus
X-Authenticated-Id: hidden
X-SendingUser: hidden
X-SendingServer: hidden
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Op 20-10-2019 om 02:51 schreef Qu Wenruo:
> 
> 
> On 2019/10/20 上午8:26, Qu Wenruo wrote:
>>
>>
>> On 2019/10/20 上午12:24, Ferry Toth wrote:
>>> Hi,
>>>
>>> Op 19-10-2019 om 01:50 schreef Qu WenRuo:
>>>>
>>>>
>>>> On 2019/10/19 上午4:32, Ferry Toth wrote:
>>>>> Op 24-09-2019 om 10:11 schreef Qu Wenruo:
>>>>>> We have at least two user reports about bad inode generation makes
>>>>>> kernel reject the fs.
>>>>>
>>>>> May I add my report? I just upgraded Ubuntu from 19.04 -> 19.10 so
>>>>> kernel went from 5.0 -> 5.3 (but I was using 4.15 too).
>>>>>
>>>>> Booting 5.3 leaves me in initramfs as I have /boot on @boot and / on /@
>>>>>
>>>>> In initramfs I can try to mount but get something like
>>>>> btrfs critical corrupt leaf invalid inode generation open_ctree failed
>>>>>
>>>>> Booting old kernel works just as before, no errors.
>>>>>
>>>>>> According to the creation time, the inode is created by some 2014
>>>>>> kernel.
>>>>>
>>>>> How do I get the creation time?
>>>>
>>>> # btrfs ins dump-tree -b <the bytenr reported by kernel> <your device>
>>>
>>> I just went back to the office to reboot to 5.3 and check the creation
>>> times and found they were 2013 - 2014.
>>>
>>>>>
>>>>>> And the generation member of INODE_ITEM is not updated (unlike the
>>>>>> transid member) so the error persists until latest tree-checker
>>>>>> detects.
>>>>>>
>>>>>> Even the situation can be fixed by reverting back to older kernel and
>>>>>> copying the offending dir/file to another inode and delete the
>>>>>> offending
>>>>>> one, it still should be done by btrfs-progs.
>>>>>>
>>>>> How to find the offending dir/file from the command line manually?
>>>>
>>>> # find <mount point> -inum <inode number>
>>>
>>> This works, thanks.
>>>
>>> But appears unpractical. After fix 2 files and reboot, I found 4 more,
>>> then 16, then I gave up.
> 
> Another solution is use "find" to locate the files with creation time
> before 2015, and copy them to a new file, then replace the old file with
> the new file.

Hmm. But how do I "find" by creation time (otime)? Do you have a 
suggestion for this?

> It would be much safer than btrfs check --repair.
> 
> Thanks,
> Qu
> 
> 
>>>
>>>> Thanks,
>>>> Qu
>>>>
>>>>>
>>>>>> This patchset adds such check and repair ability to btrfs-check, with a
>>>>>> simple test image.
>>>>>>
>>>>>> Qu Wenruo (3):
>>>>>>      btrfs-progs: check/lowmem: Add check and repair for invalid inode
>>>>>>        generation
>>>>>>      btrfs-progs: check/original: Add check and repair for invalid inode
>>>>>>        generation
>>>>>>      btrfs-progs: fsck-tests: Add test image for invalid inode
>>>>>> generation
>>>>>>        repair
>>>>>>
>>>>>>     check/main.c                                  |  50 +++++++++++-
>>>>>>     check/mode-lowmem.c                           |  76
>>>>>> ++++++++++++++++++
>>>>>>     check/mode-original.h                         |   1 +
>>>>>>     .../.lowmem_repairable                        |   0
>>>>>>     .../bad_inode_geneartion.img.xz               | Bin 0 -> 2012 bytes
>>>>>>     5 files changed, 126 insertions(+), 1 deletion(-)
>>>>>>     create mode 100644
>>>>>> tests/fsck-tests/043-bad-inode-generation/.lowmem_repairable
>>>>>>     create mode 100644
>>>>>> tests/fsck-tests/043-bad-inode-generation/bad_inode_geneartion.img.xz
>>>>>>
>>>>>
>>>
>>> I checked out and built v5.3-rc1 of btrfs-progs. Then ran it on my
>>> mounted rootfs with linux 5.0 and captured the log (~1800 lines 209
>>> errors).
>>
>> It's really not recommended to run btrfs check, especially repair on the
>> mounted fs, unless it's RO.
>>
>> A new transaction from kernel can easily screw up the repaired fs.
>>>
>>> I'm not sure if using the v5.0 kernel and/or checking mounted distorts
>>> the results? Else I'm going to need a live usb with a v5.3 kernel and
>>> v5.3 btrfs-progs.
>>>
>>> If you like I can share the log. Let me know.
>>>
>>> This issue can potentially cause a lot of grief. Our company server runs
>>> Ubuntu LTS (18.04.02) with a 4.15 kernel on a btrfs boot/rootfs with
>>> ~100 snapshots. I guess the problematic inodes need to be fixed on each
>>> snapshot prior to upgrading to 20.04 LTS (which might be on kernel ~5.6)?
>>
>> Yes.
>>
>>>
>>> Do I understand correctly that this FTB is caused by more strict
>>> checking of the fs by the kernel, while the tools to fix the detected
>>> corruptions are not yet released?
>>
>> Yes.
>>
>> Thanks,
>> Qu
>>
> 

