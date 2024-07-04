Return-Path: <linux-btrfs+bounces-6195-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 394769275D9
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Jul 2024 14:22:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBDCC285429
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Jul 2024 12:22:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFAE21AE0BA;
	Thu,  4 Jul 2024 12:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bouton.name header.i=@bouton.name header.b="vJLGv3Fi"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail.bouton.name (ns.bouton.name [109.74.195.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E3CA25779
	for <linux-btrfs@vger.kernel.org>; Thu,  4 Jul 2024 12:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.74.195.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720095684; cv=none; b=mlzR3Tj5yMp2j7O49sRFXT8xyiMPoXF9BWstn9x27OlYaTUL6Q+6s8DRBr3aQkP3sOWgC62RiaSm+75I6KXQK8+47D6vXzGMLRLsQkcziB2HOJJsm3F8MUXGPeMRr9UOaqYKmvgzlTzJ9thsGjjfscVyA3dLqgmpQDI62DPgFs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720095684; c=relaxed/simple;
	bh=S1u4caR+BRuI2VAz+Ctn3qBDt4jFLZp0LbtgaSE8uVQ=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=fw8PGrDSdeaF6UBm5+JLMLdKaMp1ghK04rMTof+FO7zRPoMhss7RJODCqzAYvVDg9TXZYZ4jqUSlIAEtbKGCdWyeYW4uDG13a85/vx8gDI9sid+eiOonWQwx1dF1bNcoxjguupzrYne9Bfnk2/iOKcZNrak3iycStmZDfH9BPi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bouton.name; spf=pass smtp.mailfrom=bouton.name; dkim=pass (1024-bit key) header.d=bouton.name header.i=@bouton.name header.b=vJLGv3Fi; arc=none smtp.client-ip=109.74.195.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bouton.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bouton.name
Received: from [192.168.10.101] (052559474.box.freepro.com [82.96.130.55])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.bouton.name (Postfix) with ESMTPSA id D2300CD8C;
	Thu,  4 Jul 2024 14:21:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bouton.name;
	s=default; t=1720095664;
	bh=AT9pXNe5zWgnIUZm938/dd4C4b40Zyp2f3qtQ0S9Oh0=;
	h=Date:Subject:From:To:References:In-Reply-To;
	b=vJLGv3FiS/q9F6WIRU+limc36Gbr5tHotdGQFbq1JLYE7/JQ7BU0wsdDWs8+amKFH
	 GKJ68xgCDWZQycVJ7pj849SisrwBIANX72tRY1kib+jCobJyfWJi9G8JbrrMCgCHhx
	 fNGmrDmkxpfFRbNeBk0s9KvOKvZt2F4pRRVshfpg=
Message-ID: <1fe1927e-356d-4181-8c5e-34f73b8b201d@bouton.name>
Date: Thu, 4 Jul 2024 14:21:01 +0200
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
 <ae6aab7d-029d-4e33-ace7-e8f0b0a2fa36@bouton.name>
 <08774378-624a-4586-9f24-c108f1ffeebb@gmx.com>
 <c24180e5-b0dc-47e5-91b0-7935e85ccc4b@bouton.name>
Content-Language: en-US
In-Reply-To: <c24180e5-b0dc-47e5-91b0-7935e85ccc4b@bouton.name>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 30/06/2024 à 12:59, Lionel Bouton a écrit :
> Le 22/06/2024 à 11:41, Qu Wenruo a écrit :
>>
>>
>> 在 2024/6/22 18:21, Lionel Bouton 写道:
>> [...]
>>>>
>>>> I'll mount the filesystem and run a scrub again to see if I can
>>>> reproduce the problem. It should be noticeably quicker, we made
>>>> updates to the Ceph cluster and should get approximately 2x the I/O
>>>> bandwidth.
>>>> I plan to keep the disk snapshot for at least several weeks so if you
>>>> want to test something else just say so.
>>>
>>>
>>> The scrub is finished, here are the results :
>>>
>>> UUID: 61e86d80-d6e4-4f9e-a312-885194c5e690
>>> Scrub started:    Wed Jun 19 00:01:59 2024
>>> Status:           finished
>>> Duration:         81:04:21
>>> Total to scrub:   18.83TiB
>>> Rate:             67.67MiB/s
>>> Error summary:    no errors found
>>>
>>> So the scrub error isn't deterministic. I'll shut down the test VM for
>>> now and keep the disk snapshot it uses for at least a couple of week if
>>> it is needed for further tests.
>>> The original filesystem is scrubbed monthly, I'll reply to this message
>>> if another error shows up.
>>
>> I briefly remembered that there was a bug related to scrub that can
>> report false alerts:
>>
>> f546c4282673 ("btrfs: scrub: avoid use-after-free when chunk length is
>> not 64K aligned")
>>
>> But that should be automatically backported, and in that case it should
>> have some errors like "unable to find chunk map" error messages in the
>> kernel log.
>>
>> Otherwise, I have no extra clues.
>>
>> Have you tried kernels like v6.8/6.9 and can you reproduce the bug in
>> those newer kernels?
>
> I've just upgraded the kernel to 6.9.7 (and btrfs-progs to 6.9.2) and 
> monthly scrubs with it will start next week. That said the last 
> filesystem scrub with 6.6.30 ran without errors so it might be hard to 
> reproduce.
> One difference with the last scrub vs the previous one which reported 
> checksum errors is the underlying device speed : it is getting faster 
> as we replace HDDs with SSDs on the Ceph cluster (it might be a cause 
> if there's a race condition somewhere). Other than that there's 
> nothing I can think of.
>
> In fact the only 2 major changes before the scrub checksum errors where :
> - a noticeable increase in constant I/O load,
> - an upgrade to the 6.6 kernel.
>
> As nobody else reported the same behavior I'm not ruling out an 
> hardware glitch either.
> I'll reply to this thread if a future scrub reports a non reproducible 
> checksum error again.

I didn't expect to have something to report so soon...
Another virtual machine running on another physical server but using the 
same Ceph cluster just reported csum errors that aren't reproducible.
This was with kernel 6.6.13 and btrfs-progs 6.8.2.
Fortunately this filesystem is small and can be scrubbed in 2 minutes : 
I just ran the scrub again (less than 5 hours after the one that 
reported errors) and no error are reported this time.

I'll upgrade this VM to 6.9.7+ too. If 6.6 has indeed a scrub bug and 
not 6.9 it might be easier to verify than I anticipated : most of our 
VMs have migrated or are in the process of migrating to 6.6 which is the 
latest LTS. If the problem manifest itself on a small filesystem too I 
expect other systems to fail scrubs sooner or later if 6.6 is affected 
by a scrub bug.

Like I wrote last time I'll reply here if other scrubs report non 
reproducible csum errors.

>
> Lionel
>
>>
>> Thanks,
>> Qu
>>>
>>>>
>>>> Best regards,
>>>> Lionel
>>>>
>>>>>
>>>>> If btrfs check reports error, and logical-resolve failed to locate 
>>>>> the
>>>>> file and its position, it means the corruption is in bookend exntets.
>>>>>
>>>>> If btrfs check reports error and logical-resolve can locate the 
>>>>> file and
>>>>> position, it's a different problem then.
>>>>>
>>>>> Thanks,
>>>>> Qu
>>>>>
>>>>>>
>>>>>> The stats output show that this file was not modified since its
>>>>>> creation
>>>>>> more than 6 years ago. This is what led me to report a bug in scrub.
>>>>>>
>>>>>>
>>>>>>>
>>>>>>>> - Some including the original subvolume have only logged 2
>>>>>>>> warnings and
>>>>>>>> one (root 151335) logged only one warning.
>>>>>>>> - All of the snapshots reported a warning for offset 20480.
>>>>>>>> - When several offsets are logged their order seems random.
>>>>>>>
>>>>>>> One problem of scrub is, it may ratelimit the output, thus we 
>>>>>>> can not
>>>>>>> just rely on dmesg to know the damage.
>>>>>>
>>>>>> I wondered about this: I've read other threads where ratelimiting is
>>>>>> mentioned but I was not sure if it could apply here. Thanks for
>>>>>> clarifying.
>>>>>>
>>>>>>>
>>>>>>>>
>>>>>>>> I'm attaching kernel logs beginning with the scrub start and
>>>>>>>> ending with
>>>>>>>> the last error. As of now there are no new errors/warnings even
>>>>>>>> though
>>>>>>>> the scrub is still ongoing, 15 hours after the last error. I 
>>>>>>>> didn't
>>>>>>>> clean the log frombalance logs linked to the same filesystem.
>>>>>>>>
>>>>>>>> Side-note for the curious or in the unlikely case it could be
>>>>>>>> linked to
>>>>>>>> the problem:
>>>>>>>> Historically this filesystem was mounted with ssd_spread 
>>>>>>>> without any
>>>>>>>> issue (I guess several years ago it made sense to me reading the
>>>>>>>> documentation and given the IO latencies I saw on the Ceph
>>>>>>>> cluster). A
>>>>>>>> recent kernel filled the whole available space with nearly empty
>>>>>>>> block
>>>>>>>> groups which seemed to re-appear each time we mounted with
>>>>>>>> ssd_spread.
>>>>>>>> We switched to "ssd" since then and there is a mostly daily 90mn
>>>>>>>> balance
>>>>>>>> to reach back the previous stateprogressively (this is the reason
>>>>>>>> behind
>>>>>>>> the balance related logs). Having some space available for new 
>>>>>>>> block
>>>>>>>> groups seems to be a good idea but additionally as we use Ceph
>>>>>>>> RBD, we
>>>>>>>> want it to be able to deallocate unused space: having many nearly
>>>>>>>> empty
>>>>>>>> block groups could waste resources (especially if the used 
>>>>>>>> space in
>>>>>>>> these groups is in <4MB continuous chunks which is the default RBD
>>>>>>>> object size).
>>>>>>>>
>>>>>>>>
>>>>>>>> More information :
>>>>>>>> The scrub is run monthly. This is the first time an error was ever
>>>>>>>> reported. The previous scrub was run successfully at the 
>>>>>>>> beginning of
>>>>>>>> May with a 6.6.13 kernel.
>>>>>>>>
>>>>>>>> There is a continuous defragmentation process running (it
>>>>>>>> processes the
>>>>>>>> whole filesystem slowly ignoring snapshots and defragments file by
>>>>>>>> file
>>>>>>>> based on a fragmentation estimation using filefrag -v). All
>>>>>>>> defragmentations are logged and I can confirm the file for 
>>>>>>>> which this
>>>>>>>> error was reported was not defragmented for at least a year (I
>>>>>>>> checked
>>>>>>>> because I wanted to rule out a possible race condition between
>>>>>>>> defragmentation and scrub).
>>>>>>>
>>>>>>> I'm wondering if there is any direct IO conflicting with
>>>>>>> buffered/defrag IO.
>>>>>>>
>>>>>>> It's known that conflicting buffered/direct IO can lead to contents
>>>>>>> change halfway, and lead to btrfs csum mismatch.
>>>>>>> So far that's the only thing leading to known btrfs csum mismatch I
>>>>>>> can
>>>>>>> think of.
>>>>>>
>>>>>> But here it seems there isn't an actual mismatch as reading the 
>>>>>> file is
>>>>>> possible and gives the data which was written in it 6 years ago. 
>>>>>> Tthis
>>>>>> seems an error in scrub (or a neutrino flipping a bit somewhere 
>>>>>> during
>>>>>> the scrub). The VM runs on a server with ECC RAM so it is unlikely
>>>>>> to be
>>>>>> a simple bitflip but when everything likely has been ruled out...
>>>>>>
>>>>>> Thanks for your feedback,
>>>>>> Lionel
>>>>>>
>>>>>>>
>>>>>>> But 6.x kernel should all log a warning message for it.
>>>>>>>
>>>>>>> Thanks,
>>>>>>> Qu
>>>>>>>>
>>>>>>>> In addition to the above, among the notable IO are :
>>>>>>>> - a moderately IO intensive PostgreSQL replication subscriber,
>>>>>>>> - ponctual large synchronisations using Syncthing,
>>>>>>>> - snapshot creations/removals occur approximately every 80
>>>>>>>> minutes. The
>>>>>>>> last snapshot operation was logged 31 minutes before the errors
>>>>>>>> (removal
>>>>>>>> occur asynchronously but where was no unusual load at this time 
>>>>>>>> that
>>>>>>>> could point to a particularly long snapshot cleanup process).
>>>>>>>>
>>>>>>>> To sum up, there are many processes accessing the filesystem but
>>>>>>>> historically it saw far higher IO load during scrubs than what was
>>>>>>>> occurring here.
>>>>>>>>
>>>>>>>>
>>>>>>>> Reproducing this might be difficult: the whole scrub can take a 
>>>>>>>> week
>>>>>>>> depending on load. That said I can easily prepare a kernel 
>>>>>>>> and/or new
>>>>>>>> btrfs-progs binaries to launch scrubs or other non-destructive
>>>>>>>> tasks the
>>>>>>>> week-end or at the end of the day (UTC+2 timezone).
>>>>>>>>
>>>>>>>> Best regards,
>>>>>>>>
>>>>>>>> Lionel Bouton
>>>>>>>
>>>>>>
>>>>
>>>
>>>
>


