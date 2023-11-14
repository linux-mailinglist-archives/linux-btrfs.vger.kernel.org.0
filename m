Return-Path: <linux-btrfs+bounces-137-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 01E117EBFED
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Nov 2023 11:05:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C78028130A
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Nov 2023 10:05:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA51FD518;
	Wed, 15 Nov 2023 10:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-btrfs@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2C6F946F
	for <linux-btrfs@vger.kernel.org>; Wed, 15 Nov 2023 10:05:21 +0000 (UTC)
Received: from freki.datenkhaos.de (freki.datenkhaos.de [81.7.17.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F7AC101
	for <linux-btrfs@vger.kernel.org>; Wed, 15 Nov 2023 02:05:19 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
	by freki.datenkhaos.de (Postfix) with ESMTP id 1168D2746F7B;
	Wed, 15 Nov 2023 00:26:49 +0100 (CET)
Received: from freki.datenkhaos.de ([127.0.0.1])
	by localhost (freki.datenkhaos.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id EEqc99qnsq49; Wed, 15 Nov 2023 00:26:33 +0100 (CET)
Received: from [192.168.10.1] (unknown [89.14.91.255])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by freki.datenkhaos.de (Postfix) with ESMTPSA;
	Wed, 15 Nov 2023 00:26:33 +0100 (CET)
Message-ID: <73af45c5-b565-44b4-971c-c03b131907be@datenkhaos.de>
Date: Wed, 15 Nov 2023 00:26:25 +0100
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: checksum errors but files are readable and no disk errors
Content-Language: en-US
To: Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
References: <6b6aafe0-811e-4619-91c3-36700e387cec@datenkhaos.de>
 <6a87d788-5f4c-4cb0-8351-233ab924129c@gmx.com>
From: Johannes Hirte <johannes.hirte@datenkhaos.de>
In-Reply-To: <6a87d788-5f4c-4cb0-8351-233ab924129c@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 12.11.23 08:51, Qu Wenruo wrote:
>
>
> On 2023/11/11 04:30, Johannes Hirte wrote:
>> Hello,
>>
>> I have a server with two 2T-disks that were running in a Btrfs-RAID1
>> setup. Recently I was running into the bug of btrfs-progs-6.6, so the
>> system didn't boot anymore. Because I don't have physical access to the
>> system, the only option I've had was a hard reset  remotely. After this
>> I noticed several checksum errors during scrub on different files. I was
>> able to delete those files, but the checksum errors persisted, now
>> without any file associated. In the end, I removed one disk (sdb1) from
>> the RAID. Because relocation doesn't work with checksum errors, I've
>> overwritten the first 10M of the partition and mounted the remaining
>> disk (sda1) degraded. After this, I created a new filesystem on sdb1
>> andI synced the whole sda1 to sdb1 via rsync. This worked without any
>> problems, although sda1 still shows the checksum errors. I'm running the
>> system from the second disk now with the newly created filesystem. But
>> now this FS shows checksum errors again. Two files are affected, both
>> are images for virtual servers. I'm able to read both files, I can copy
>> via dd without any error. But scrub says, there are checksum errors:
>
> It can be some csum error in the non-referenced part of the file extents
> (caused by COW).
>
> In that case, you can try to defrag the offending file (and sync). As
> long as there no reflinked nor snapshot for that file, scrub should no
> longer report error for it.
>
> For the cause of the error, the most common one is page modification
> during writeback, which is super common doing DirectIO while modify the
> page half way.
> (Which I guess is common for some VM workload? As I have seen several
> reports like this)
>
>>
>> [52622.939071] BTRFS error (device sdb1): unable to fixup (regular)
>> error at logical 1673331802112 on dev /dev/sdb1 physical 1648107257856
>> [52622.939189] BTRFS warning (device sdb1): checksum error at logical
>> 1673331802112 on dev /dev/sdb1, physical 1648107257856, root 1117, inode
>> 832943, offset 566788096, length 4096, links 1 (path:
>> var/lib/libvirt/images/vserv03.img)
>> [54629.309530] BTRFS error (device sdb1): unable to fixup (regular)
>> error at logical 2209355464704 on dev /dev/sdb1 physical 1884523397120
>> [54629.309656] BTRFS warning (device sdb1): checksum error at logical
>> 2209355464704 on dev /dev/sdb1, physical 1884523397120, root 1117, inode
>> 832950, offset 9149956096, length 4096, links 1 (path:
>> var/lib/libvirt/images/vserv06.img)
>> [54629.309666] BTRFS error (device sdb1): unable to fixup (regular)
>> error at logical 2209355464704 on dev /dev/sdb1 physical 1884523397120
>> [54629.309719] BTRFS warning (device sdb1): checksum error at logical
>> 2209355464704 on dev /dev/sdb1, physical 1884523397120, root 1117, inode
>> 832950, offset 9149956096, length 4096, links 1 (path:
>> var/lib/libvirt/images/vserv06.img)
>> [54760.218254] BTRFS info (device sdb1): scrub: finished on devid 1 with
>> status: 0
>>
>> So what is going on here? I'm planning to recreate the RAID1, but with
>> with checksum errors I don't want to go on. System is running kernel
>> 6.5.11.
>
> Since you can read the file without problem, you are totally fine to
> ignore it.
>
> Despite the above defrag method, you can also copy the offending file to
> other locations (just do not use reflink), then delete the old offending
> file (from all snapshots and reflinks), and copy the new one back.
>
>
> BTW, it's recommended to check if your VM is using directIO for that
> file, which is known to lead to false csum mismatch alerts.

Yes, it seems that all affected images were configured to io="native". 
This means linux legacy aio was used.

But now I have another interesting situation:
I've disabled CoW for /var/lib/libvirt/images. After this, I've noticed 
another csum error there:

[441535.134445] BTRFS error (device sdb1): unable to fixup (regular) 
error at logical 1641807872 on dev /dev/sdb1 physical 2723938304
[441535.134563] BTRFS warning (device sdb1): checksum error at logical 
1641807872 on dev /dev/sdb1, physical 2723938304, root 1117, inode 
832940, offset 65449984, length 4096, links 1 (path: 
var/lib/libvirt/images/vserv02-storage1.img)

and tried defrag. Now I have a dangling csum error again:

[442824.777685] BTRFS info (device sdb1): scrub: started on devid 1
[442834.428949] BTRFS error (device sdb1): unable to fixup (regular) 
error at logical 1641807872 on dev /dev/sdb1 physical 2723938304

Same logical address, same physical address but now no file is 
associated. Looks similar to when I deleted files with csum errors. It 
looks like those csum errors get persisted.

regards,
   Johannes


