Return-Path: <linux-btrfs+bounces-128-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 094F77EB509
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Nov 2023 17:40:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7D302812D2
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Nov 2023 16:40:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3AE93FE2A;
	Tue, 14 Nov 2023 16:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-btrfs@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CB983D3B4
	for <linux-btrfs@vger.kernel.org>; Tue, 14 Nov 2023 16:40:43 +0000 (UTC)
Received: from freki.datenkhaos.de (freki.datenkhaos.de [81.7.17.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 115A9116
	for <linux-btrfs@vger.kernel.org>; Tue, 14 Nov 2023 08:40:40 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
	by freki.datenkhaos.de (Postfix) with ESMTP id DE6722746EA3;
	Tue, 14 Nov 2023 17:40:37 +0100 (CET)
Received: from freki.datenkhaos.de ([127.0.0.1])
	by localhost (freki.datenkhaos.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id aMI-SpStk95P; Tue, 14 Nov 2023 17:40:37 +0100 (CET)
Received: from [192.168.10.6] (dynamic-089-014-091-255.89.14.pool.telefonica.de [89.14.91.255])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by freki.datenkhaos.de (Postfix) with ESMTPSA;
	Tue, 14 Nov 2023 17:40:37 +0100 (CET)
Message-ID: <47f08d62-3fa2-4baf-9425-17d1f119ef8d@datenkhaos.de>
Date: Tue, 14 Nov 2023 17:40:28 +0100
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: checksum errors but files are readable and no disk errors
To: Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
References: <6b6aafe0-811e-4619-91c3-36700e387cec@datenkhaos.de>
 <6a87d788-5f4c-4cb0-8351-233ab924129c@gmx.com>
Content-Language: en-US
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
You're right, and interestingly defrag of one file fixed the other too.
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

On the original RAID1 I've had errors on other files too, e.g. kernel 
source files. Deleting those didn't got rid of the errors. They stayed 
without associated files. I'll check if qemu is using directIO. I 
haven't configured this but it could be a default setting now. How 
useful is it to deactivate CoW for those files?

regards,
   Johannes


