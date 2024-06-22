Return-Path: <linux-btrfs+bounces-5901-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF4189132CF
	for <lists+linux-btrfs@lfdr.de>; Sat, 22 Jun 2024 10:51:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C8F42846BA
	for <lists+linux-btrfs@lfdr.de>; Sat, 22 Jun 2024 08:51:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD53414C585;
	Sat, 22 Jun 2024 08:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bouton.name header.i=@bouton.name header.b="fLQZuHDf"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail.bouton.name (ns.bouton.name [109.74.195.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09B538BF7
	for <linux-btrfs@vger.kernel.org>; Sat, 22 Jun 2024 08:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.74.195.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719046291; cv=none; b=K2MligWuac0HJj+oV/q2q1++ZfsmAPw6iyMAdxgylPr3dcq1jvK94jlHIFR6av83kN+W1r7kaa40jUFjFGh7qAPJs6i5Zulsl2hD62xf/L2vx19qG2EQh2lj2vXXazRddztq2Qz4/P0GtxvdbMqdAj/ydCKFPq8P206PswRSfJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719046291; c=relaxed/simple;
	bh=CL83poRtemmoHEZaqqWkKNBIF0zXkKsiNHTgbxaYICI=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=WVcfKot8uAjqqaHwGCkUAdLaiVMUZ2Tw2kQl8CymerEV0/YJ8B6QEtQPZVE7fMHNhiaR8mKeTrjeDDS7tDWhj7iMCewH8IEqnXlW1UQjcikmFu6436n7/1zpG0xwFFrkhOo29jFb/sXPxFCG7oGuo4+Hg/26jUE+dptnGkjs1jI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bouton.name; spf=pass smtp.mailfrom=bouton.name; dkim=pass (1024-bit key) header.d=bouton.name header.i=@bouton.name header.b=fLQZuHDf; arc=none smtp.client-ip=109.74.195.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bouton.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bouton.name
Received: from [192.168.10.102] (052559474.box.freepro.com [82.96.130.55])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.bouton.name (Postfix) with ESMTPSA id 87B65C840;
	Sat, 22 Jun 2024 10:51:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bouton.name;
	s=default; t=1719046267;
	bh=jzp5iFww/1PviZK5YW8g1JaF0+sKOz9ybq6SCkWMFZ4=;
	h=Date:Subject:From:To:References:In-Reply-To;
	b=fLQZuHDfiqbGACWzdIkzncpnCRyeLzcBEV/DUS3H6ThOnAE+HDqUFBck6RpplHsvT
	 hCLhUVvzHsMeCRjIaMWHEjaBBCW6MLjpGHbkyXVB5gHciEgB9XUriWSlwRzAqdfw2B
	 sh7Am27eIAsZME1zj6NYG3rIuCKsFrOzdDEI1yJA=
Message-ID: <ae6aab7d-029d-4e33-ace7-e8f0b0a2fa36@bouton.name>
Date: Sat, 22 Jun 2024 10:51:04 +0200
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: BUG: scrub reports uncorrectable csum errors linked to readable
 file (data: single)
From: Lionel Bouton <lionel-subscription@bouton.name>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
References: <c2fa6c37-d2a8-4d77-b095-e04e3db35ef0@bouton.name>
 <4525e502-c209-4672-ae32-68296436d204@gmx.com>
 <1df4ce53-8cf9-40b1-aa43-bf443947c833@bouton.name>
 <80456d11-9859-402c-a77c-5c3b98b755a5@gmx.com>
 <05fc8552-1b6f-4b6c-82b2-0cf716cc8e6b@bouton.name>
Content-Language: en-US
In-Reply-To: <05fc8552-1b6f-4b6c-82b2-0cf716cc8e6b@bouton.name>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 18/06/2024 à 23:45, Lionel Bouton a écrit :
> Le 07/06/2024 à 01:30, Qu Wenruo a écrit :
>>
>>
>> 在 2024/6/7 08:51, Lionel Bouton 写道:
>>> Hi,
>>>
>>> Le 07/06/2024 à 01:05, Qu Wenruo a écrit :
>>>>
>>>>
>>>> 在 2024/6/4 23:42, Lionel Bouton 写道:
>>>>> Hi,
>>>>>
>>>>> It seems one of our system hit an (harmless ?) bug while scrubbing.
>>>>>
>>>>> Kernel: 6.6.30 with Gentoo patches (sys-kernel/gentoo-sources-6.6.30
>>>>> ebuild).
>>>>> btrfs-progs: 6.8.1
>>>>> The system is a VM using QEMU/KVM.
>>>>> The affected filesystem is directly on top of a single virtio-scsi 
>>>>> block
>>>>> device (no partition, no LVM, ...) with a Ceph RBD backend.
>>>>> Profiles for metadata: dup, data: single.
>>>>>
>>>>> The scrub process is ongoing but it logged uncorrectable errors :
>>>>>
>>>>> # btrfs scrub status /mnt/store
>>>>> UUID:             <our_uuid>
>>>>> Scrub started:    Mon Jun  3 09:35:28 2024
>>>>> Status:           running
>>>>> Duration:         26:12:07
>>>>> Time left:        114:45:38
>>>>> ETA:              Sun Jun  9 06:33:13 2024
>>>>> Total to scrub:   18.84TiB
>>>>> Bytes scrubbed:   3.50TiB  (18.59%)
>>>>> Rate:             38.92MiB/s
>>>>> Error summary:    csum=61
>>>>>    Corrected:      0
>>>>>    Uncorrectable:  61
>>>>>    Unverified:     0
>>>>>
>>>>> According to the logs all errors are linked to a single file 
>>>>> (renamed to
>>>>> <file> in the attached log) and happened within a couple of seconds.
>>>>> Most errors are duplicates as there are many snapshots of the 
>>>>> subvolume
>>>>> it is in. This system is mainly used as a backup server, storing 
>>>>> copies
>>>>> of data for other servers and creating snapshots of them.
>>>>>
>>>>> I was about to overwrite the file to correct the problem by 
>>>>> fetching it
>>>>> from its source but I didn't get an error trying to read it (cat 
>>>>> <file>
>>>>>  > /dev/null)). I used diff and md5sum to double check: the file is
>>>>> fine.
>>>>>
>>>>> Result of stat <file> on the subvolume used as base for the 
>>>>> snapshots:
>>>>>    File: <file>
>>>>>    Size: 1799195         Blocks: 3520       IO Block: 4096 regular 
>>>>> file
>>>>> Device: 0,36    Inode: 6676106     Links: 1
>>>>> Access: (0644/-rw-r--r--)  Uid: ( 1000/<uid>)   Gid: ( 1000/<gid>)
>>>>> Access: 2018-02-15 05:22:38.506204046 +0100
>>>>> Modify: 2018-02-15 05:21:35.612914799 +0100
>>>>> Change: 2018-02-15 05:22:38.506204046 +0100
>>>>>   Birth: 2018-02-15 05:22:38.486203934 +0100
>>>>>
>>>>> AFAIK the kernel logged a warning for nearly each snapshot of the 
>>>>> same
>>>>> subvolume (they were all created after the file), the subvolume from
>>>>> which snapshots are created is root 257 in the logs. What seems
>>>>> interesting to me and might help diagnose this is the pattern for
>>>>> offsets in the warnings.
>>>>> - There are 3 offsets appearing: 20480, 86016, 151552 (exactly 64k
>>>>> between them).
>>>>> - Most snapshots seem to report a warning for each of them.
>>>>
>>>> This is how btrfs reports a corrupted data sector, it would go through
>>>> all inodes (including ones in different subvolumes) and report the 
>>>> error.
>>>>
>>>> So it really means if you want to delete the file, you need to remove
>>>> all the inodes from all different snapshots.
>>>>
>>>> So if you got a correct copy matching the csum, you can do a more
>>>> dangerous but more straight forward way to fix, by directly 
>>>> overwriting
>>>> the contents on disk.
>>>
>>> I briefly considered doing just that... but then I found out that the
>>> scrub errors were themselves in error and the on disk data was matching
>>> the checksums. When I tried to read the file not only didn't the
>>> filesystem report an IO error (if I'm not mistaken it should if the 
>>> csum
>>> doesn't match) but the file content matched the original file fetched
>>> from its source.
>>
>> Got it, this is really weird now.
>>
>> What scrub doing is read the data from disk (without bothering page
>> cache), and verify against checksums.
>>
>> Would it be possible to run "btrfs check --check-data-csum" on the
>> unmounted/RO mounted fs?
>>
>> That would output the error for each corrupted sector (without
>> ratelimit), so that you can record them all.
>> And try to do logical-resolve to find each corrupted location?
>>
>> If btrfs check reports no error, it's 100% sure scrub is to blamce.
>
> The results are in, no error reported by btrfs check:
>
> # btrfs check --check-data-csum /dev/sdb
> [1/7] checking root items
> [2/7] checking extents
> [3/7] checking free space tree
> [4/7] checking fs roots
> [5/7] checking csums against data
> [6/7] checking root refs
> [7/7] checking quota groups skipped (not enabled on this FS)
> Opening filesystem to check...
> Checking filesystem on /dev/sdb
> UUID: 61e86d80-d6e4-4f9e-a312-885194c5e690
> found 20626845626377 bytes used, no error found
> total csum bytes: 19548745528
> total tree bytes: 83019579392
> total fs tree bytes: 47937191936
> total extent tree bytes: 8051245056
> btree space waste bytes: 18589648011
> file data blocks allocated: 22539270656000
>  referenced 21661227479040
>
> I'll mount the filesystem and run a scrub again to see if I can 
> reproduce the problem. It should be noticeably quicker, we made 
> updates to the Ceph cluster and should get approximately 2x the I/O 
> bandwidth.
> I plan to keep the disk snapshot for at least several weeks so if you 
> want to test something else just say so.


The scrub is finished, here are the results :

UUID: 61e86d80-d6e4-4f9e-a312-885194c5e690
Scrub started:    Wed Jun 19 00:01:59 2024
Status:           finished
Duration:         81:04:21
Total to scrub:   18.83TiB
Rate:             67.67MiB/s
Error summary:    no errors found

So the scrub error isn't deterministic. I'll shut down the test VM for 
now and keep the disk snapshot it uses for at least a couple of week if 
it is needed for further tests.
The original filesystem is scrubbed monthly, I'll reply to this message 
if another error shows up.

>
> Best regards,
> Lionel
>
>>
>> If btrfs check reports error, and logical-resolve failed to locate the
>> file and its position, it means the corruption is in bookend exntets.
>>
>> If btrfs check reports error and logical-resolve can locate the file and
>> position, it's a different problem then.
>>
>> Thanks,
>> Qu
>>
>>>
>>> The stats output show that this file was not modified since its 
>>> creation
>>> more than 6 years ago. This is what led me to report a bug in scrub.
>>>
>>>
>>>>
>>>>> - Some including the original subvolume have only logged 2 
>>>>> warnings and
>>>>> one (root 151335) logged only one warning.
>>>>> - All of the snapshots reported a warning for offset 20480.
>>>>> - When several offsets are logged their order seems random.
>>>>
>>>> One problem of scrub is, it may ratelimit the output, thus we can not
>>>> just rely on dmesg to know the damage.
>>>
>>> I wondered about this: I've read other threads where ratelimiting is
>>> mentioned but I was not sure if it could apply here. Thanks for 
>>> clarifying.
>>>
>>>>
>>>>>
>>>>> I'm attaching kernel logs beginning with the scrub start and 
>>>>> ending with
>>>>> the last error. As of now there are no new errors/warnings even 
>>>>> though
>>>>> the scrub is still ongoing, 15 hours after the last error. I didn't
>>>>> clean the log frombalance logs linked to the same filesystem.
>>>>>
>>>>> Side-note for the curious or in the unlikely case it could be 
>>>>> linked to
>>>>> the problem:
>>>>> Historically this filesystem was mounted with ssd_spread without any
>>>>> issue (I guess several years ago it made sense to me reading the
>>>>> documentation and given the IO latencies I saw on the Ceph 
>>>>> cluster). A
>>>>> recent kernel filled the whole available space with nearly empty 
>>>>> block
>>>>> groups which seemed to re-appear each time we mounted with 
>>>>> ssd_spread.
>>>>> We switched to "ssd" since then and there is a mostly daily 90mn 
>>>>> balance
>>>>> to reach back the previous stateprogressively (this is the reason 
>>>>> behind
>>>>> the balance related logs). Having some space available for new block
>>>>> groups seems to be a good idea but additionally as we use Ceph 
>>>>> RBD, we
>>>>> want it to be able to deallocate unused space: having many nearly 
>>>>> empty
>>>>> block groups could waste resources (especially if the used space in
>>>>> these groups is in <4MB continuous chunks which is the default RBD
>>>>> object size).
>>>>>
>>>>>
>>>>> More information :
>>>>> The scrub is run monthly. This is the first time an error was ever
>>>>> reported. The previous scrub was run successfully at the beginning of
>>>>> May with a 6.6.13 kernel.
>>>>>
>>>>> There is a continuous defragmentation process running (it 
>>>>> processes the
>>>>> whole filesystem slowly ignoring snapshots and defragments file by 
>>>>> file
>>>>> based on a fragmentation estimation using filefrag -v). All
>>>>> defragmentations are logged and I can confirm the file for which this
>>>>> error was reported was not defragmented for at least a year (I 
>>>>> checked
>>>>> because I wanted to rule out a possible race condition between
>>>>> defragmentation and scrub).
>>>>
>>>> I'm wondering if there is any direct IO conflicting with
>>>> buffered/defrag IO.
>>>>
>>>> It's known that conflicting buffered/direct IO can lead to contents
>>>> change halfway, and lead to btrfs csum mismatch.
>>>> So far that's the only thing leading to known btrfs csum mismatch I 
>>>> can
>>>> think of.
>>>
>>> But here it seems there isn't an actual mismatch as reading the file is
>>> possible and gives the data which was written in it 6 years ago. Tthis
>>> seems an error in scrub (or a neutrino flipping a bit somewhere during
>>> the scrub). The VM runs on a server with ECC RAM so it is unlikely 
>>> to be
>>> a simple bitflip but when everything likely has been ruled out...
>>>
>>> Thanks for your feedback,
>>> Lionel
>>>
>>>>
>>>> But 6.x kernel should all log a warning message for it.
>>>>
>>>> Thanks,
>>>> Qu
>>>>>
>>>>> In addition to the above, among the notable IO are :
>>>>> - a moderately IO intensive PostgreSQL replication subscriber,
>>>>> - ponctual large synchronisations using Syncthing,
>>>>> - snapshot creations/removals occur approximately every 80 
>>>>> minutes. The
>>>>> last snapshot operation was logged 31 minutes before the errors 
>>>>> (removal
>>>>> occur asynchronously but where was no unusual load at this time that
>>>>> could point to a particularly long snapshot cleanup process).
>>>>>
>>>>> To sum up, there are many processes accessing the filesystem but
>>>>> historically it saw far higher IO load during scrubs than what was
>>>>> occurring here.
>>>>>
>>>>>
>>>>> Reproducing this might be difficult: the whole scrub can take a week
>>>>> depending on load. That said I can easily prepare a kernel and/or new
>>>>> btrfs-progs binaries to launch scrubs or other non-destructive 
>>>>> tasks the
>>>>> week-end or at the end of the day (UTC+2 timezone).
>>>>>
>>>>> Best regards,
>>>>>
>>>>> Lionel Bouton
>>>>
>>>
>


