Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AD4C476121
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Dec 2021 19:54:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344048AbhLOSxp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 15 Dec 2021 13:53:45 -0500
Received: from smtp-31-wd.italiaonline.it ([213.209.13.31]:58332 "EHLO
        libero.it" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1344044AbhLOSxo (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 15 Dec 2021 13:53:44 -0500
Received: from [192.168.1.27] ([78.12.25.242])
        by smtp-31.iol.local with ESMTPA
        id xZPImoczROKKIxZPIm7vIa; Wed, 15 Dec 2021 19:53:42 +0100
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=libero.it; s=s2021;
        t=1639594422; bh=GQ+6OI5DDW0F5WVFX6yi0PQWdAvUEP5330CDCk1USyM=;
        h=From;
        b=IKb28FNxoaS62cjnJvFbrVacpuvTxEmt1sewctS7tbX6ooycY4na/JoaC/1JBy0CA
         7Qe1Ku3Omd96hNJxp/4fDgKbc4b6yiHnnrcuyexb+bgG4llX+rc5uxXnzOjdnSNoAk
         CA6khb8YG8LcC4lz+1cY612ay4lk8zpCHVQx+10w3iQlTmOYq2ZFL4vjBZRZFQ1ozE
         SykQ/G7fVtg8zhNTYEjmRG1pn5/ZbBjntDvh7CEwLWaEg79FLWagJJ3TMbqDI03eyb
         sfWzoWLHA47ofimnQ/gD0o3AA9WYauTfI2lFbbyPIoTF6YDz853UMZ83VkQ2EgFuZr
         /LeSMy8H/aGnw==
X-CNFS-Analysis: v=2.4 cv=QuabYX+d c=1 sm=1 tr=0 ts=61ba39b6 cx=a_exe
 a=IXMPufAKhGEaWfwa3qtiyQ==:117 a=IXMPufAKhGEaWfwa3qtiyQ==:17
 a=IkcTkHD0fZMA:10 a=TtYj0HvxvMiuLhkx3OIA:9 a=QEXdDO2ut3YA:10
Message-ID: <633ccf8f-3118-1dda-69d2-0398ef3ffdb7@libero.it>
Date:   Wed, 15 Dec 2021 19:53:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Reply-To: kreijack@inwind.it
Subject: Re: [RFC][V8][PATCH 0/5] btrfs: allocation_hint mode
Content-Language: en-US
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        David Sterba <dsterba@suse.cz>,
        Sinnamohideen Shafeeq <shafeeqs@panasas.com>,
        Paul Jones <paul@pauljones.id.au>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <cover.1635089352.git.kreijack@inwind.it>
 <SYXPR01MB1918689AF49BE6E6E031C8B69E749@SYXPR01MB1918.ausprd01.prod.outlook.com>
 <1d725df7-b435-4acf-4d17-26c2bd171c1a@libero.it>
 <Ybe34gfrxl8O89PZ@localhost.localdomain> <YbfN8gXHsZ6KZuil@hungrycats.org>
 <71e523dc-2854-ca9b-9eee-e36b0bd5c2cb@libero.it>
 <Ybj40IuxdaAy75Ue@hungrycats.org> <Ybj/0ITsCQTBLkQF@localhost.localdomain>
 <be4e6028-7d1d-6ba9-d16f-f5f38a79866f@libero.it>
 <Ybn0aq548kQsQu+z@localhost.localdomain>
From:   Goffredo Baroncelli <kreijack@libero.it>
In-Reply-To: <Ybn0aq548kQsQu+z@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfJ8eVPsVDlRPbRISuwf0XJY1kANVMpVbPgHepIoNVXODMszLn0W5elu9QPNkWytoRmFo4ySBh9Te4SlXBrUO4zU8WWBDUTGQA7neMSRd1K3Y7OvsE9FP
 41pYpzB8DXTTdhBpDqIeLLZJ1UY5Qvs2/44jVFk5/qyKGWyvdzqY+R+HtF2Jvcjhd5Rv+eF8cCDS2+m4Cty9qGywhAzCY2Iib9ZgJkHTJKMq0uToCUAbhww2
 NsAdFNhMmdKCK3BoK/fXzlYcRlGjhQTunYA1v2ow6E8lXFi3BGDnNjLOLdsmtYmk6v5w/ewDYmReOvcWOOUXQgRQLze8jYg1ckMe0GS2g5cIozUr1398bPwQ
 gXq7lxBy
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 12/15/21 14:58, Josef Bacik wrote:
> On Tue, Dec 14, 2021 at 09:41:21PM +0100, Goffredo Baroncelli wrote:
>> On 12/14/21 21:34, Josef Bacik wrote:
>>> On Tue, Dec 14, 2021 at 03:04:32PM -0500, Zygo Blaxell wrote:
>>>> On Tue, Dec 14, 2021 at 08:03:45PM +0100, Goffredo Baroncelli wrote:
>>
>>>>
>>>> I don't have a strong preference for either sysfs or ioctl, nor am I
>>>> opposed to simply implementing both.  I'll let someone who does have
>>>> such a preference make their case.
>>>
>>> I think echo'ing a name into sysfs is better than bits for sure.  However I want
>>> the ability to set the device properties via a btrfs-progs command offline so I
>>> can setup the storage and then mount the file system.  I want
>>>
>>> 1) The sysfs interface so you can change things on the fly.  This stays
>>>      persistent of course, so the way it works is perfect.
>>>
>>> 2) The btrfs-progs command sets it on offline devices.  If you point it at a
>>>      live mounted fs it can simply use the sysfs thing to do it live.
>>
>> #2 is currently not implemented. However I think that we should do.
>>
>> The problem is that we need to update both:
>>
>> - the superblock		(simple)
>> - the dev_item item		(not so simple...)
>>
>> What about using only bits from the superblock to store this property ?
> 
> I'm looking at the patches and you only are updating the dev_item, am I missing
> something for the super block?

When btrfs write the superblocks (see write_all_supers() in disk-io.c), it copies
the dev_item fields (contained in fs_info->fs_devices->devices lists) in each
superblock before updating it.

> 
> For offline all you would need to do is do the normal open_ctree,
> btrfs_search_slot to the item and update the device item type, that's
> straightforward.
> 
> For online if you use btrfs prop you can see if the fs is mounted and just find
> the sysfs file to modify and do it that way.
> 
> But this also brings up another point, we're going to want a compat bit for
> this.  It doesn't make the fs unusable for old kernels, so just a normal
> BTRFS_FS_COMPAT_<whatever> flag is fine.  If the setting gets set you set the
> compat flag.

Why we need a "compact" bit ? The new kernels know how treat the dev_item_type field.
The old kernels ignore it. The worst thing is that a filesystem may require a balance
before reaching a good shape (i.e. the metadata on ssd and the data on a spinning disk)
  



> You'll also need to modify the tree checker to check the dev item allocation
> hints to make sure they're valid, via check_dev_item.  Thanks,

Ok

> 
> Josef


-- 
gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5
