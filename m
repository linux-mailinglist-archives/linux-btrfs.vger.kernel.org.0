Return-Path: <linux-btrfs+bounces-402-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 600CA7FB36B
	for <lists+linux-btrfs@lfdr.de>; Tue, 28 Nov 2023 09:00:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E67EAB20F68
	for <lists+linux-btrfs@lfdr.de>; Tue, 28 Nov 2023 08:00:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D953E14AAE;
	Tue, 28 Nov 2023 08:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=libero.it header.i=@libero.it header.b="Jjtowm6d"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from libero.it (smtp-18.italiaonline.it [213.209.10.18])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56F2098
	for <linux-btrfs@vger.kernel.org>; Tue, 28 Nov 2023 00:00:08 -0800 (PST)
Received: from [192.168.1.27] ([84.220.171.3])
	by smtp-18.iol.local with ESMTPA
	id 7t0orxUYFEwsU7t0orfDOV; Tue, 28 Nov 2023 09:00:06 +0100
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=libero.it; s=s2021;
	t=1701158406; bh=KzuS4NnVSW82FE5kJ/7HbPKFhvhaOZajAh+xDuFSPWw=;
	h=From;
	b=Jjtowm6d1Si1pO4UVsS69aE6KL04Qs7wlUcT8rEHuru+Gx4j5UXzt0Z/XCuJbRal4
	 NyOjAZPNaicPmDupE8i37J2+k4rYEL2+u5OtCEQKSzeLQqkfZyVDUYoCJsWqtn2zaS
	 hMucQwtHpz8hSoDjV7Vsv4bh4YB9+dVIuAVJDMmAuQ9qZVaXg71Y9QQbUlyzmYoYpp
	 0VBI+yth9j+brzkOt5U1fCe+RdeB+hNDFqowHScBXU2IbaB+3s7ikyfOpg5JoPhj7O
	 KVleVbskbaHQmDBkXQ6k7Aj/DrqO7LFeEjQJeB60ywsuN0qUKJU/rjvHdf8m8+LYNE
	 wUEUNaWj4LLUg==
X-CNFS-Analysis: v=2.4 cv=N6vvVUxB c=1 sm=1 tr=0 ts=65659e06 cx=a_exe
 a=hciw9o01/L1eIHAASTHaSw==:117 a=hciw9o01/L1eIHAASTHaSw==:17
 a=IkcTkHD0fZMA:10 a=3T79VapDeQJY0rWtCmsA:9 a=l4mWaurpklBE37-4:21
 a=QEXdDO2ut3YA:10
Message-ID: <2248a4d7-bbd0-4bf3-992a-c1e13c8f2c20@libero.it>
Date: Tue, 28 Nov 2023 09:00:06 +0100
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
From: Goffredo Baroncelli <kreijack@libero.it>
In-Reply-To: <589d8650-26e8-4c0e-a602-bdb5ce427ed5@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfNehpItlY/DcABM7zZPzp9yLg8wgFQKF8z6C8NpuCeqGxIugkxT/JFkyPy9sFqMNJN8OijoGbjBUwFoah0oLOlE8/URKfPFc0ZoUK7bFaFqO70rcSN1g
 4uKp/HQecXnOFGivwurD4OC6Nm543nsG5HVwylsqxejk9fdjl3qIf4OvuJCdcmrxBcKx5FAraZt1YaHvzlGGJc5VC2kp9XfrlrqRW5uPyOTLiAiOWr2sW20t
 SFhnrZkpqH3Qkx3IVR/P2g==

On 27/11/2023 12.48, Anand Jain wrote:
> 
> 
> On 11/25/23 09:09, Anand Jain wrote:
[...]
>> I am skeptical about whether we have a strong case to create a single
>> pseudo device per multi-device Btrfs filesystem, such as, for example
>> '/dev/btrfs/<fsid>-<random>/rootid=5' and which means pseudo device
>> will carry the btrfs-magic and the actual blk devices something else.
>>
>> OR for now, regarding the umount issue mentioned above, we just can
>> document it for the users to be aware of.
>>
>> Any feedback is greatly appreciated.
>>
> 
> How about if we display the devices list in the options, so that
> user-land libs have something in the mount-table that tells all
> the devices part of the fsid?
> 
> For example:
> $ cat /proc/self/mounts | grep btrfs
> 
> /dev/sda1 /btrfs btrfs rw,relatime,space_cache=v2,subvolid=5,subvol=/,device=/dev/sda2,device=/dev/sdb3  0 0
> 

When I developed code to find a btrfs mount point from a disk, I had to
consider all the devices involved and check if one is in /proc/self/mounts.

Putting the devices list as device=<xxx>,device=<yyy> doesn't change anything because
the code has to manage a btrfs filesistem as "special" in any case.
To get the map <btrfs-uuid> <-> <devices-list> I used libblkid.

I think that a "saner" way to manage this issue, is to patch "mount" to
consider the special needing of btrfs.

Pay attention to consider also events like, removing a device, adding a device:
after these events how /dev/disk/by-uuid/ would be updated ?

What about bcachefs ? Does it have the same issue ? If yes this may be
a further reason to patch "mount" instead relying to a rule (pick the
lowest devt) spread for all the projects (systemd, mount...).

> Thanks.
> 

-- 
gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5


