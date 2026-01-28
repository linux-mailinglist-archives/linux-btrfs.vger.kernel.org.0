Return-Path: <linux-btrfs+bounces-21161-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sO68IRXMeWmOzgEAu9opvQ
	(envelope-from <linux-btrfs+bounces-21161-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Jan 2026 09:43:01 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FF789E4E4
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Jan 2026 09:43:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3F362300DE1E
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Jan 2026 08:42:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6493932E732;
	Wed, 28 Jan 2026 08:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=pj.world@gmx.com header.b="i/4SnGar"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75DC230FC39
	for <linux-btrfs@vger.kernel.org>; Wed, 28 Jan 2026 08:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769589769; cv=none; b=G8co6osvL0a+On4dlMszSreT7EkMS9VF+dfR8DWa++CXzuO3bhq1q0tyHM0DaZfSL0UG+fRhJATkDrOMY1s67EzHLVaQbRqrFsuZXEDDtKy/ah8jwgs3o7UHlDq15vuY0820u3bS6y9LPGLkejHhjvCzhAoOVXX8cIyBF4qcsRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769589769; c=relaxed/simple;
	bh=sdcyCsf4lMwnoJbR/9xKhXKT5StpGSoEsclGBq5q2fc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=PKnmEEOjDapUlGhWt+1G8g7VYnnAflNTShGL7cDCnazFuDXNHjYffdgK++5bpcWMy7UNHHvxwTpWwyH5vTteSJ5IeNfmpn64sYSz347rl1+3nu+Mt/q2LAnBZG7B8pHywG8WJY6VeZT/I9d1sbdeVkYfqXdmocvYeR0lfWnFf3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=pj.world@gmx.com header.b=i/4SnGar; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1769589765; x=1770194565; i=pj.world@gmx.com;
	bh=sdcyCsf4lMwnoJbR/9xKhXKT5StpGSoEsclGBq5q2fc=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=i/4SnGarx54mcyHnFaX0lALdCXQtShOmfLHZAfJ5gpeQWWa8c8tWBPNRaTH0nVj4
	 sAy8YQ9nouobrJC8+D/jWb0HTNyCfHbMROpw9zvgRA6qg20uJm/CA2ss5TmHKOEJI
	 WrwDU5zcytnA2gxQ38dzIIYMElLB4mQTuZ1mgwsluFCqtBTiUr3bg0Q2JHtN6cYTd
	 vxusICfzxW93B7XM+F79YAUNSdBRHR4mhJjPIx/jjFNBKjp86muxk0egESN1YFC9K
	 Xl9jfnOAyfzikTMIZDoLEIIqdBEbNJPc+LQ7lZi9qnpaCIS9mR8GSATpstsfnrigs
	 KA7GznIu01A62jW/eQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.11] ([65.128.142.149]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MpUUw-1w5olt0Wc8-00mYxP; Wed, 28
 Jan 2026 09:42:45 +0100
Message-ID: <121b0011-8076-4a0b-baff-384b6ec62986@gmx.com>
Date: Wed, 28 Jan 2026 02:42:43 -0600
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Stuck subvolume removal:
To: Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
References: <1c371732-db4f-49ad-bc00-876b3be0fe98@gmx.com>
 <4b4fc981-912d-40cd-945b-d4acf14198e1@gmx.com>
 <01f8b560-fb57-4861-8382-141c39655478@gmx.com>
 <0ed6fdf0-842a-4641-90e4-5239b5049e4b@gmx.com>
Content-Language: en-US
From: Paul Graff <pj.world@gmx.com>
In-Reply-To: <0ed6fdf0-842a-4641-90e4-5239b5049e4b@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:AqWvL5uBkWFwMw68lZqvnmq9UbTDlVRR/K8Vivjtv7WrYlPXjnr
 i8YCqkYlEeSH4X3hjxeCMddlaS4FOK7B+B9skM6z10qxJdNRtCG/BVfv8L7ZgHcFifXsFLn
 935XVl1SIf2AxhjBW0Y95lYaUSjhWFgrk6KousA+mlTv+i8IChIOx2rM+HhIgIp9Yi5Satf
 VERurho4kcrtsWzMBKt1A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:3cbTcmwhZq4=;arKKFbwTU/3rYM1IysQMEqpVBaO
 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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmx.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmx.com:s=s31663417];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmx.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-21161-lists,linux-btrfs=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmx.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pj.world@gmx.com,linux-btrfs@vger.kernel.org];
	DKIM_TRACE(0.00)[gmx.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-btrfs];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,gmx.com:mid,gmx.com:dkim]
X-Rspamd-Queue-Id: 2FF789E4E4
X-Rspamd-Action: no action


On 11/14/25 1:55 PM, Qu Wenruo wrote:
>
>
> =E5=9C=A8 2025/11/15 06:08, Paul Graff =E5=86=99=E9=81=93:
>>
>>
>> On 11/13/25 4:54 PM, Qu Wenruo wrote:
>>>
>>>
>>> =E5=9C=A8 2025/11/14 09:10, Paul Graff =E5=86=99=E9=81=93:
>>>> Hi, currently there is a dropped subvolume error when running a=20
>>>> full balance on a single SSD.
>>>>
>>>> |:~> sudo btrfs balance start / WARNING: Full balance without=20
>>>> filters requested. This operation is very intense and takes=20
>>>> potentially very long. It is recommended to use the balance filters=
=20
>>>> to narrow down the scope of balance. Use 'btrfs balance start=20
>>>> --full-balance' option to skip this warning. The operation will=20
>>>> start in 10 seconds. Use Ctrl-C to stop it. 10 9 8 7 6 5 4 3 2 1=20
>>>> Starting balance without any filters. ERROR: error during balancing=
=20
>>>> '/': Structure needs cleaning There may be more info in syslog -=20
>>>> try dmesg | tail hightower- i5-6600k:~> dmesg | tail [38576.407681]=
=20
>>>> [ T29728] BTRFS info (device dm-2): found 37170 extents, stage:=20
>>>> update data pointers [38584.873805] [ T29728] BTRFS info (device=20
>>>> dm-2): relocating block group 64891125760 flags data [38607.693519]=
=20
>>>> [ T29728] BTRFS info (device dm-2): found 33194 extents, stage:=20
>>>> move data extents [38641.574032] [ T29728] BTRFS info (device=20
>>>> dm-2): found 33194 extents, stage: update data pointers=20
>>>> [38649.812477] [ T29728] BTRFS info (device dm-2): relocating block=
=20
>>>> group 62710087680 flags data [38662.710999] [ T29728] BTRFS info=20
>>>> (device dm-2): found 43884 extents, stage: move data extents=20
>>>> [38696.292982] [ T29728] BTRFS info (device dm-2): found 43884=20
>>>> extents, stage: update data pointers [38708.587669] [ T29728] BTRFS=
=20
>>>> info (device dm-2): relocating block group 60294168576 flags=20
>>>> metadata|dup [38714.889735] [ T29728] BTRFS error (device dm-2):=20
>>>> cannot relocate partially dropped subvolume 490, drop progress key=20
>>>> (853588 108 0) [38723.736887] [ T29728] BTRFS info (device dm-2):=20
>>>> balance: ended with status: -117 hightower-i5-6600k:~>|
>>>
>>> The format is a mess.
>> My apologies for the disastrous output format above.
>>> Please provide a proper formatted dmesg instead.
>>
>> :~> sudo dmesg | tail
>>
>> [sudo] password for root:
>>
>> [44928.672213] [ T96240] BTRFS info (device dm-2): found 55680=20
>> extents, stage: update data pointers
>>
>> [44937.810972] [ T96240] BTRFS info (device dm-2): found 4 extents,=20
>> stage: update data pointers
>>
>> [44938.590658] [ T96240] BTRFS info (device dm-2): relocating block=20
>> group 60294168576 flags metadata|dup
>>
>> [44945.516661] [ T96240] BTRFS error (device dm-2): cannot relocate=20
>> partially dropped subvolume 490, drop progress key (853588 108 0)
>>
>> [44955.995468] [ T96240] BTRFS info (device dm-2): balance: ended=20
>> with status: -117
>>
>> :~>
>>
>>
>>>
>>> Along with the kernel version.
>> Most current openSUSE Rescue system CD used for btrfs check, uname -a=
=20
>> > 6.17.7-1
>>>
>>> The relocation is rejected because there is a half-dropped=20
>>> subvolume, which is not that common.
>>> It maybe a problem with the fs that there are some ghost subvolumes=20
>>> that are never dropped.
>>>
>>> There used to be kernel bug that can lead to such ghost subvolumes,=20
>>> IIRC the latest btrfs check can detect it.
>>>
>>> So please also provide the output of "btrfs check --readonly" of the=
=20
>>> unmounted fs.
>>
>> :~ # btrfs check --readonly --progress /dev/mapper/system-root
>>
>> Opening filesystem to check...
>>
>> Checking filesystem on /dev/mapper/system-root
>>
>> UUID: 605560ad-fe93-4d09-8760-df0725b43ee1
>>
>> [1/8] checking log skipped (none written)
>>
>> [1/7] checking root items (0:00:14 elapsed, 5328460 items checked)
>>
>> [2/7] checking extents (0:01:01 elapsed, 984830 items checked)
>>
>> [3/7] checking free space cache (0:00:12 elapsed, 471 items checked)
>>
>> [4/7] checking fs roots (0:04:32 elapsed, 910644 items checked)
>>
>> [5/7] checking csums (without verifying data) (0:00:12 elapsed,=20
>> 895024 items checked)
>>
>> fs tree 490 missing orphan item (0:00:00 elapsed, 94 items checked)
>
> So indeed your fs has a half dropped ghost subvolume, most likely=20
> caused by some older kernels.
>
> Unfortunately btrfs-progs doesn't have the ability to repair it yet,=20
> I'll craft a branch of btrfs-progs with the repair ability soon.
>
> Meanwhile please prepare an environment to compile btrfs-progs.
>
> Thanks,
> Qu

Hi, I would like to ask if there is a solution to the "dropped ghost=20
subvolume" the filesystem on machine here exhibits as of yet?

-Thanks

Paul Graff

>
>>
>> [6/7] checking root refs (0:00:01 elapsed, 94 items checked)
>>
>> ERROR: errors found in root refs
>>
>> found 496776130741 bytes used, error(s) found
>>
>> total csum bytes: 465839608
>>
>> total tree bytes: 16133832704
>>
>> total fs tree bytes: 14983905280
>>
>> total extent tree bytes: 624771072
>>
>> btree space waste bytes: 3613129770
>>
>> file data blocks allocated: 1062495817728
>>
>> referenced 976540409856
>>
>> :~ #
>>
>>
>>>
>>> Thanks,
>>> Qu
>>>
>> -Greatest Hopes
>> Paul
>>>>
>>>> After passing,
>>>>
>>>> |:~> sudo btrfs subvolume sync / [sudo] password for root:=20
>>>> hightower- i5-6600k:~> |
>>>>
>>>> the command returned to prompt very, very quickly.
>>>>
>>>> A second balance attempt results with the following output:
>>>>
>>>> |:~> sudo btrfs balance start / WARNING: Full balance without=20
>>>> filters requested. This operation is very intense and takes=20
>>>> potentially very long. It is recommended to use the balance filters=
=20
>>>> to narrow down the scope of balance. Use 'btrfs balance start=20
>>>> --full-balance' option to skip this warning. The operation will=20
>>>> start in 10 seconds. Use Ctrl-C to stop it. 10 9 8 7 6 5 4 3 2 1=20
>>>> Starting balance without any filters. ERROR: error during balancing=
=20
>>>> '/': Structure needs cleaning There may be more info in syslog -=20
>>>> try dmesg | tail hightower- i5-6600k:~> |
>>>>
>>>> |:~> dmesg | tail [93689.781162] [ T69656] BTRFS info (device=20
>>>> dm-2): found 16 extents, stage: update data pointers [93690.667290]=
=20
>>>> [ T69656] BTRFS info (device dm-2): relocating block group=20
>>>> 1495819878400 flags data [93703.323923] [ T69656] BTRFS info=20
>>>> (device dm-2): found 33 extents, stage: move data extents=20
>>>> [93705.575991] [ T69656] BTRFS info (device dm-2): found 33=20
>>>> extents, stage: update data pointers [93706.769453] [ T69656] BTRFS=
=20
>>>> info (device dm-2): relocating block group 1494746136576 flags data=
=20
>>>> [93725.570642] [ T69656] BTRFS info (device dm-2): found 39=20
>>>> extents, stage: move data extents [93727.449779] [ T69656] BTRFS=20
>>>> info (device dm-2): found 39 extents, stage: update data pointers=20
>>>> [93728.465650] [ T69656] BTRFS info (device dm-2): relocating block=
=20
>>>> group 60294168576 flags metadata|dup [93736.722689] [ T69656] BTRFS=
=20
>>>> error (device dm-2): cannot relocate partially dropped subvolume=20
>>>> 490, drop progress key (853588 108 0) [93750.594559] [ T69656]=20
>>>> BTRFS info (device dm-2): balance: ended with status: -117=20
>>>> hightower- i5-6600k:~> |
>>>>
>>>> Please see the following referenced, prior posting for stuck=20
>>>> subvolume removal similarity. https://lore.kernel.org/linux-=20
>>>> btrfs/9f936d59- d782-1f48-bbb7-dd1c8dae2615@gmail.com/
>>>>
>>>> Is there a patch for btrfsprogs? If so can the patch be merged?|
>>>> |
>>>>
>>>> What are your thoughts on this?
>>>>
>>>>
>>>>
>>>>
>>>>
>>>
>>
>

