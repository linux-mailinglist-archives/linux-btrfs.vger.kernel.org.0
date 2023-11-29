Return-Path: <linux-btrfs+bounces-443-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B5B27FE165
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 Nov 2023 21:54:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C71361F20EC6
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 Nov 2023 20:54:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C15BE61660;
	Wed, 29 Nov 2023 20:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=inwind.it header.i=@inwind.it header.b="frGhrCZ0"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from libero.it (smtp-16.italiaonline.it [213.209.10.16])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56856D67
	for <linux-btrfs@vger.kernel.org>; Wed, 29 Nov 2023 12:54:06 -0800 (PST)
Received: from [192.168.1.27] ([84.220.171.3])
	by smtp-16.iol.local with ESMTPA
	id 8RZKrscmSGKAA8RZKrQNYl; Wed, 29 Nov 2023 21:54:03 +0100
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=inwind.it; s=s2014;
	t=1701291243; bh=BYrHhL1udsCTYM68jx6rm+kOTW9bWUMGzIWj0CqCvOI=;
	h=From;
	b=frGhrCZ0HWhRYpB9cq3QVNE+DYLypjK7LT+x/8jGZ2rGUxPdvyRd9+bBy9dFjr/YH
	 IetE8rMTDSq7AjRbPnMKkP8tsuMx3aBq2Ye7b6PAKx0W8lrtSCmhs1HcA9Mdyvq0b+
	 Ib+G0wkqnKTlbfDJtfMz/NpWKKqon6AbHUnm4enNmAy0d6fynPWvXt9iXeoERCwsME
	 rqqdmfx59Ju+yKYw11RahvH/gUydUOIF1Bn4kLy7eu6xmqk7yCCgkCdxiccfTRzpY0
	 Une7PT0iVSBhABItEhBcnGDJQPsrj+Px2hVBvHqF1DOSHcHPksXYjtr0jd1/Vma3W6
	 /RJKYumf0D92Q==
X-CNFS-Analysis: v=2.4 cv=OoOJiQzt c=1 sm=1 tr=0 ts=6567a4eb cx=a_exe
 a=hciw9o01/L1eIHAASTHaSw==:117 a=hciw9o01/L1eIHAASTHaSw==:17
 a=IkcTkHD0fZMA:10 a=9huUNJadDlxizotPVVgA:9 a=QEXdDO2ut3YA:10
Message-ID: <183599a4-392d-443d-b914-7ac830b3c2d7@inwind.it>
Date: Wed, 29 Nov 2023 21:54:02 +0100
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: kreijack@inwind.it
Subject: Re: [PATCH RFC] btrfs: pick device with lowest devt for show_devname
Content-Language: en-US
To: Anand Jain <anand.jain@oracle.com>, dsterba@suse.cz
Cc: linux-btrfs@vger.kernel.org
References: <85226cf68d7a72a034f0c0895b96b2557169755b.1698917826.git.anand.jain@oracle.com>
 <20231124161906.GE18929@twin.jikos.cz>
 <36171811-ed49-4427-a647-e052ec70faa0@oracle.com>
 <589d8650-26e8-4c0e-a602-bdb5ce427ed5@oracle.com>
 <2248a4d7-bbd0-4bf3-992a-c1e13c8f2c20@libero.it>
 <336d54f8-3a27-a7e9-3482-781559fab709@oracle.com>
From: Goffredo Baroncelli <kreijack@inwind.it>
In-Reply-To: <336d54f8-3a27-a7e9-3482-781559fab709@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfApUDFBAoZMmtdDB+Sm/gTMhptjYu8jXgNdvkfIwHEgvZKLSCPaBzqNHvvUYG7Td0AFu87QEzXSXKEAjGECs/rVB5N8tXQQTdo0wtoVlVQ87NABxXg06
 oArC2NGvyl+50+sAIgSKcJuMCpMd0mENiH7BDssjjNbUJPPIeeCXbHhvNKfiCHRkLrLNFGsr5PqN35xdv9DZ1i35ahKeXGCSS8SaPC1m1JeuEylFYGtggVFj
 gWDvamWCJjRT7EJ7T1meOQ==

On 29/11/2023 00.28, Anand Jain wrote:
> 
> 
> On 28/11/2023 16:00, Goffredo Baroncelli wrote:
>> On 27/11/2023 12.48, Anand Jain wrote:
>>>
>>>
>>> On 11/25/23 09:09, Anand Jain wrote:
>> [...]
>>>> I am skeptical about whether we have a strong case to create a single
>>>> pseudo device per multi-device Btrfs filesystem, such as, for example
>>>> '/dev/btrfs/<fsid>-<random>/rootid=5' and which means pseudo device
>>>> will carry the btrfs-magic and the actual blk devices something else.
>>>>
>>>> OR for now, regarding the umount issue mentioned above, we just can
>>>> document it for the users to be aware of.
>>>>
>>>> Any feedback is greatly appreciated.
>>>>
>>>
>>> How about if we display the devices list in the options, so that
>>> user-land libs have something in the mount-table that tells all
>>> the devices part of the fsid?
>>>
>>> For example:
>>> $ cat /proc/self/mounts | grep btrfs
>>>
>>> /dev/sda1 /btrfs btrfs rw,relatime,space_cache=v2,subvolid=5,subvol=/,device=/dev/sda2,device=/dev/sdb3  0 0
>>>
>>
>> When I developed code to find a btrfs mount point from a disk, I had to
>> consider all the devices involved and check if one is in /proc/self/mounts.
>>
>> Putting the devices list as device=<xxx>,device=<yyy> doesn't change anything because
>> the code has to manage a btrfs filesistem as "special" in any case.
>> To get the map <btrfs-uuid> <-> <devices-list> I used libblkid.
[...]
> 
> Regarding libblkid for Btrfs device discovery, I m little confused what are you referring to, an example would be helpful.

I developed a little utility to build for each btrfs filesystem:
- all the devices involved
- all the mountpoint (if any) where the filesystem is mounted and the subvolume used as root.

It was nice because it got all these information only using:
- libblkid
- parsing /proc/self/mountinfo



> 
> Thanks.

-- 
gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5


