Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 304B761487
	for <lists+linux-btrfs@lfdr.de>; Sun,  7 Jul 2019 11:12:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727242AbfGGJMt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 7 Jul 2019 05:12:49 -0400
Received: from mx2.suse.de ([195.135.220.15]:41560 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725822AbfGGJMt (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 7 Jul 2019 05:12:49 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 0D06AACAE;
        Sun,  7 Jul 2019 09:12:48 +0000 (UTC)
Subject: Re: find snapshot parent?
To:     Andrei Borzenkov <arvidjaar@gmail.com>, linux-btrfs@vger.kernel.org
References: <20190706155353.GA13656@tik.uni-stuttgart.de>
 <1e70c50e-54d7-0507-60ad-9c486e3517a9@suse.com>
 <20190706204339.GB13656@tik.uni-stuttgart.de>
 <774d3e3d-bf1a-a3a1-b21c-45a3a353e5bc@suse.com>
 <ffa57dd3-51c8-66f8-a53e-be28df79e0d3@gmail.com>
From:   Nikolay Borisov <nborisov@suse.com>
Openpgp: preference=signencrypt
Autocrypt: addr=nborisov@suse.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <8bc57b91-fc13-979b-a25a-b7a16094d09a@suse.com>
Date:   Sun, 7 Jul 2019 12:12:47 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <ffa57dd3-51c8-66f8-a53e-be28df79e0d3@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 7.07.19 г. 10:37 ч., Andrei Borzenkov wrote:
> 07.07.2019 9:43, Nikolay Borisov пишет:
>>
>>
>> On 6.07.19 г. 23:43 ч., Ulli Horlacher wrote:
>>> On Sat 2019-07-06 (19:57), Nikolay Borisov wrote:
>>>
>>>>> And how can I see whether /test/tmp/xx/ss1 is a snapshot at all?
>>>>> Do all snapshots have a "Parent UUID" and regular subvolumes not?
>>>>
>>>> Indeed, only snapshots have a Parent UUID.
>>>
>>> Not all:
>>>
>>> root@xerus:/test# btrfs subvolume snapshot -r /test /test/ss1
>>> Create a readonly snapshot of '/test' in '/test/ss1'
>>>
>>> root@xerus:/test# btrfs subvolume show /test/ss1
>>> /test/ss1
>>>         Name:                   ss1
>>>         UUID:                   02bd07bc-0bab-3442-96be-40790e1ba9be
>>>         Parent UUID:            -
>>>         Received UUID:          -
>>>         Creation time:          2019-07-06 22:37:37 +0200
>>>         Subvolume ID:           1036
>>>         Generation:             9824
>>>         Gen at creation:        9824
>>>         Parent ID:              5
>>>         Top level ID:           5
>>>         Flags:                  readonly
>>>         Snapshot(s):
>>>
>>> root@xerus:/test# btrfs subvolume show /test
>>> /test is toplevel subvolume
>>
>> This is really odd, looking at create_pending_snapshot the codes : 
>>
>> memcpy(new_root_item->parent_uuid, root->root_item.uuid,                                      
>>                         BTRFS_UUID_SIZE);  
>>
>> And that's not conditional on whether the snapshot is read only or not. 
>> So everytime we creata a snapshot it ought to be receiving the parent's 
>> subvolume UUID in its parent_uuid field.
> 
> Does top level subvolume of btrfs have subvolume UUID at all? How can
> one display it? None of "btrfs subvolume" commands show it.
> 
>> And indeed testing with latest misc-next kernel: 
>>
>> root@ubuntu-virtual:~# btrfs subvol create /media/scratch/subvol10 
>> Create subvolume '/media/scratch/subvol10'
>>
>> root@ubuntu-virtual:~# btrfs subvol snapshot /media/scratch/subvol10/ /media/scratch/snap-subvol10
>> Create a snapshot of '/media/scratch/subvol10/' in '/media/scratch/snap-subvol10'
>>
> 
> /media/scratch/subvol10 is not top level subvolume.

root@ubuntu-virtual:~# mkfs.btrfs /dev/vdc 

root@ubuntu-virtual:~# mount /dev/vdc /media/scratch/

root@ubuntu-virtual:~# btrfs subvolume snapshot  /media/scratch/ /media/scratch/snap1
Create a snapshot of '/media/scratch/' in '/media/scratch/snap1'

root@ubuntu-virtual:~# btrfs subvolume snapshot  -r /media/scratch/ /media/scratch/snap-ro
Create a readonly snapshot of '/media/scratch/' in '/media/scratch/snap-ro'



root@ubuntu-virtual:~# btrfs subvol show /media/scratch/      
/
	Name: 			<FS_TREE>
	UUID: 			80633e8d-fa8a-4922-ac0c-b46d7b2e2d81
	Parent UUID: 		-
	Received UUID: 		-
	Creation time: 		2019-07-07 09:09:15 +0000
	Subvolume ID: 		5
	Generation: 		8
	Gen at creation: 	0
	Parent ID: 		0
	Top level ID: 		0
	Flags: 			-
	Snapshot(s):
				snap1
				snap-ro

root@ubuntu-virtual:~# btrfs subvol show /media/scratch/snap1/
snap1
	Name: 			snap1
	UUID: 			df861e02-5f54-a74c-a560-dfa66a80b528
	Parent UUID: 		80633e8d-fa8a-4922-ac0c-b46d7b2e2d81
	Received UUID: 		-
	Creation time: 		2019-07-07 09:09:38 +0000
	Subvolume ID: 		257
	Generation: 		6
	Gen at creation: 	6
	Parent ID: 		5
	Top level ID: 		5
	Flags: 			-
	Snapshot(s):

root@ubuntu-virtual:~# btrfs subvol show /media/scratch/snap-ro/
snap-ro
	Name: 			snap-ro
	UUID: 			f9c1a467-2d8a-2343-9011-a4ad07e701b7
	Parent UUID: 		80633e8d-fa8a-4922-ac0c-b46d7b2e2d81
	Received UUID: 		-
	Creation time: 		2019-07-07 09:11:34 +0000
	Subvolume ID: 		258
	Generation: 		8
	Gen at creation: 	8
	Parent ID: 		5
	Top level ID: 		5
	Flags: 			readonly
	Snapshot(s):




> 
