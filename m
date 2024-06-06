Return-Path: <linux-btrfs+bounces-5516-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 24F718FF80F
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 Jun 2024 01:22:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8C30287CF2
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Jun 2024 23:22:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6034113E041;
	Thu,  6 Jun 2024 23:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bouton.name header.i=@bouton.name header.b="bJnNMfTW"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail.bouton.name (ns.bouton.name [109.74.195.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1005A17C68
	for <linux-btrfs@vger.kernel.org>; Thu,  6 Jun 2024 23:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.74.195.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717716122; cv=none; b=BzWDkhK82N3uXJVerY4OfWm5MRwBeh4nhUfJ0eUY8+IHD/088RmXFy9AzktNnKqPZRCfWxqZ9/1xdFVVqIjehr4CGQFTNRDjP/zdwPkbz8tRzAmOMx8H5P1zJjR/j5024oH3xRvBQJUVl0o04wHitI/cznFmDJpL9VgnVDMlCv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717716122; c=relaxed/simple;
	bh=9y3qsnAKru1pkgSDilMOXs2WhSeVXCLKKWLH7LBMrbo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=R5GE46PsWyYEDX8gg/TNP3tJCiXFlZKnk2qquWP5k4Dof2CkbrKAitYSgqWEcU2D44TlqqNpFVoWAiu9JCE7sWacXpsTe2wyXNv5TEWIIN6zULkW+04EIwWJBAmpLah0CUuUBEh+BUdS62pk0pkclqM/RLDk2APBdT9w17jszwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bouton.name; spf=pass smtp.mailfrom=bouton.name; dkim=pass (1024-bit key) header.d=bouton.name header.i=@bouton.name header.b=bJnNMfTW; arc=none smtp.client-ip=109.74.195.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bouton.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bouton.name
Received: from [192.168.10.100] (052559474.box.freepro.com [82.96.130.55])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.bouton.name (Postfix) with ESMTPSA id 2393DC3B7;
	Fri,  7 Jun 2024 01:21:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bouton.name;
	s=default; t=1717716116;
	bh=E4jpthP0R+StuQIDo/1of3qP9j1YpxFfxyc9LmhVyDQ=;
	h=Date:Subject:To:References:From:In-Reply-To;
	b=bJnNMfTWbEhKjoj5EaVwpHo5ja35GENYkzK1hCTavwmcC+GywkXFqhcEYxeAGQPcD
	 wOBks1hioq2QQONO8jp7E5lSr3AZOKFkGC4iitWUQcWDpEx7QXPFI1qnQHgUxMELhR
	 qSy84MIYW2xa61wCjT8ia9Zddpg7AXReNF0f5Thw=
Message-ID: <1df4ce53-8cf9-40b1-aa43-bf443947c833@bouton.name>
Date: Fri, 7 Jun 2024 01:21:52 +0200
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: BUG: scrub reports uncorrectable csum errors linked to readable
 file (data: single)
To: Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
References: <c2fa6c37-d2a8-4d77-b095-e04e3db35ef0@bouton.name>
 <4525e502-c209-4672-ae32-68296436d204@gmx.com>
From: Lionel Bouton <lionel-subscription@bouton.name>
Content-Language: en-US
In-Reply-To: <4525e502-c209-4672-ae32-68296436d204@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

Le 07/06/2024 à 01:05, Qu Wenruo a écrit :
>
>
> 在 2024/6/4 23:42, Lionel Bouton 写道:
>> Hi,
>>
>> It seems one of our system hit an (harmless ?) bug while scrubbing.
>>
>> Kernel: 6.6.30 with Gentoo patches (sys-kernel/gentoo-sources-6.6.30
>> ebuild).
>> btrfs-progs: 6.8.1
>> The system is a VM using QEMU/KVM.
>> The affected filesystem is directly on top of a single virtio-scsi block
>> device (no partition, no LVM, ...) with a Ceph RBD backend.
>> Profiles for metadata: dup, data: single.
>>
>> The scrub process is ongoing but it logged uncorrectable errors :
>>
>> # btrfs scrub status /mnt/store
>> UUID:             <our_uuid>
>> Scrub started:    Mon Jun  3 09:35:28 2024
>> Status:           running
>> Duration:         26:12:07
>> Time left:        114:45:38
>> ETA:              Sun Jun  9 06:33:13 2024
>> Total to scrub:   18.84TiB
>> Bytes scrubbed:   3.50TiB  (18.59%)
>> Rate:             38.92MiB/s
>> Error summary:    csum=61
>>    Corrected:      0
>>    Uncorrectable:  61
>>    Unverified:     0
>>
>> According to the logs all errors are linked to a single file (renamed to
>> <file> in the attached log) and happened within a couple of seconds.
>> Most errors are duplicates as there are many snapshots of the subvolume
>> it is in. This system is mainly used as a backup server, storing copies
>> of data for other servers and creating snapshots of them.
>>
>> I was about to overwrite the file to correct the problem by fetching it
>> from its source but I didn't get an error trying to read it (cat <file>
>>  > /dev/null)). I used diff and md5sum to double check: the file is 
>> fine.
>>
>> Result of stat <file> on the subvolume used as base for the snapshots:
>>    File: <file>
>>    Size: 1799195         Blocks: 3520       IO Block: 4096 regular file
>> Device: 0,36    Inode: 6676106     Links: 1
>> Access: (0644/-rw-r--r--)  Uid: ( 1000/<uid>)   Gid: ( 1000/<gid>)
>> Access: 2018-02-15 05:22:38.506204046 +0100
>> Modify: 2018-02-15 05:21:35.612914799 +0100
>> Change: 2018-02-15 05:22:38.506204046 +0100
>>   Birth: 2018-02-15 05:22:38.486203934 +0100
>>
>> AFAIK the kernel logged a warning for nearly each snapshot of the same
>> subvolume (they were all created after the file), the subvolume from
>> which snapshots are created is root 257 in the logs. What seems
>> interesting to me and might help diagnose this is the pattern for
>> offsets in the warnings.
>> - There are 3 offsets appearing: 20480, 86016, 151552 (exactly 64k
>> between them).
>> - Most snapshots seem to report a warning for each of them.
>
> This is how btrfs reports a corrupted data sector, it would go through
> all inodes (including ones in different subvolumes) and report the error.
>
> So it really means if you want to delete the file, you need to remove
> all the inodes from all different snapshots.
>
> So if you got a correct copy matching the csum, you can do a more
> dangerous but more straight forward way to fix, by directly overwriting
> the contents on disk.

I briefly considered doing just that... but then I found out that the 
scrub errors were themselves in error and the on disk data was matching 
the checksums. When I tried to read the file not only didn't the 
filesystem report an IO error (if I'm not mistaken it should if the csum 
doesn't match) but the file content matched the original file fetched 
from its source.

The stats output show that this file was not modified since its creation 
more than 6 years ago. This is what led me to report a bug in scrub.


>
>> - Some including the original subvolume have only logged 2 warnings and
>> one (root 151335) logged only one warning.
>> - All of the snapshots reported a warning for offset 20480.
>> - When several offsets are logged their order seems random.
>
> One problem of scrub is, it may ratelimit the output, thus we can not
> just rely on dmesg to know the damage.

I wondered about this: I've read other threads where ratelimiting is 
mentioned but I was not sure if it could apply here. Thanks for clarifying.

>
>>
>> I'm attaching kernel logs beginning with the scrub start and ending with
>> the last error. As of now there are no new errors/warnings even though
>> the scrub is still ongoing, 15 hours after the last error. I didn't
>> clean the log frombalance logs linked to the same filesystem.
>>
>> Side-note for the curious or in the unlikely case it could be linked to
>> the problem:
>> Historically this filesystem was mounted with ssd_spread without any
>> issue (I guess several years ago it made sense to me reading the
>> documentation and given the IO latencies I saw on the Ceph cluster). A
>> recent kernel filled the whole available space with nearly empty block
>> groups which seemed to re-appear each time we mounted with ssd_spread.
>> We switched to "ssd" since then and there is a mostly daily 90mn balance
>> to reach back the previous stateprogressively (this is the reason behind
>> the balance related logs). Having some space available for new block
>> groups seems to be a good idea but additionally as we use Ceph RBD, we
>> want it to be able to deallocate unused space: having many nearly empty
>> block groups could waste resources (especially if the used space in
>> these groups is in <4MB continuous chunks which is the default RBD
>> object size).
>>
>>
>> More information :
>> The scrub is run monthly. This is the first time an error was ever
>> reported. The previous scrub was run successfully at the beginning of
>> May with a 6.6.13 kernel.
>>
>> There is a continuous defragmentation process running (it processes the
>> whole filesystem slowly ignoring snapshots and defragments file by file
>> based on a fragmentation estimation using filefrag -v). All
>> defragmentations are logged and I can confirm the file for which this
>> error was reported was not defragmented for at least a year (I checked
>> because I wanted to rule out a possible race condition between
>> defragmentation and scrub).
>
> I'm wondering if there is any direct IO conflicting with 
> buffered/defrag IO.
>
> It's known that conflicting buffered/direct IO can lead to contents
> change halfway, and lead to btrfs csum mismatch.
> So far that's the only thing leading to known btrfs csum mismatch I can
> think of.

But here it seems there isn't an actual mismatch as reading the file is 
possible and gives the data which was written in it 6 years ago. Tthis 
seems an error in scrub (or a neutrino flipping a bit somewhere during 
the scrub). The VM runs on a server with ECC RAM so it is unlikely to be 
a simple bitflip but when everything likely has been ruled out...

Thanks for your feedback,
Lionel

>
> But 6.x kernel should all log a warning message for it.
>
> Thanks,
> Qu
>>
>> In addition to the above, among the notable IO are :
>> - a moderately IO intensive PostgreSQL replication subscriber,
>> - ponctual large synchronisations using Syncthing,
>> - snapshot creations/removals occur approximately every 80 minutes. The
>> last snapshot operation was logged 31 minutes before the errors (removal
>> occur asynchronously but where was no unusual load at this time that
>> could point to a particularly long snapshot cleanup process).
>>
>> To sum up, there are many processes accessing the filesystem but
>> historically it saw far higher IO load during scrubs than what was
>> occurring here.
>>
>>
>> Reproducing this might be difficult: the whole scrub can take a week
>> depending on load. That said I can easily prepare a kernel and/or new
>> btrfs-progs binaries to launch scrubs or other non-destructive tasks the
>> week-end or at the end of the day (UTC+2 timezone).
>>
>> Best regards,
>>
>> Lionel Bouton
>


