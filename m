Return-Path: <linux-btrfs+bounces-21907-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QAP+DqLEnmkuXQQAu9opvQ
	(envelope-from <linux-btrfs+bounces-21907-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Feb 2026 10:45:06 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D7AB19538D
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Feb 2026 10:45:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 86C9F305D2B7
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Feb 2026 09:34:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DCA738E5D7;
	Wed, 25 Feb 2026 09:33:59 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp4-g21.free.fr (smtp4-g21.free.fr [212.27.42.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4054A33CE86
	for <linux-btrfs@vger.kernel.org>; Wed, 25 Feb 2026 09:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772012038; cv=none; b=ZPQ1GFe+TByXpzDluGaUd+nzTR2AL/ExeEMeLJPlfHjoXEMQXjIJINSvwboG+FDcQqSac/KfLjQxDMJ2+DORKZOA+MF/B1eR79mAG9mLbxLO+4d1J9zVwSdgQAdGKv8HOnsePFmDG+F24SBcbZ3pA1ZpgOLbxm+bbU/zD4U6G/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772012038; c=relaxed/simple;
	bh=jyHQj4K3BnsywX9TKsZpaBAXeiUzPETJdoLDCyHR0pY=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=hB+8nvReV4AQZu5GablbNeq7EYdmfZRWdcJUR9uNuCu94NWWCaY1u7A4lp4ovWM4NbDmcAPsEs64F3ce/T9J7UC8SHzVOGUcpmNCQWxWkzmZpdR3PNHpqAGlWfHYeZcYglbJfyOBRJRjI+HWs+SO+mdUEFlykm4eFEYLx8MhsG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr; spf=pass smtp.mailfrom=free.fr; arc=none smtp.client-ip=212.27.42.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Received: from [IPV6:2a01:e0a:156:6850:7018:89ff:fecb:6f21] (unknown [IPv6:2a01:e0a:156:6850:7018:89ff:fecb:6f21])
	by smtp4-g21.free.fr (Postfix) with ESMTP id 1650019F57E;
	Wed, 25 Feb 2026 10:33:53 +0100 (CET)
Message-ID: <fa9cfd2f-1e9d-4713-9e2b-9399076f8aba@free.fr>
Date: Wed, 25 Feb 2026 10:33:52 +0100
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Stuck on a BTRFS problem
From: Phako <phako@free.fr>
To: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <77535c20-da3e-4dfb-b3d7-9426c25b5da3@free.fr>
 <0211658c-8d28-46d1-8e41-21dc02cab276@suse.com>
 <b1c1247f-df00-4045-a508-fb9a5666114a@free.fr>
 <cb183999-6a95-456a-80f4-f703da298d74@suse.com>
 <deb56ee2-b5d6-4beb-9554-05da125dde54@free.fr>
 <51597107-5a23-4f15-9481-b4d58e18bbe1@suse.com>
 <2f7fe549-676d-45fb-b97a-82096027c89c@free.fr>
 <72eece35-d5f3-476a-ae0f-5fbd99cb2d60@free.fr>
Content-Language: en-US, fr
In-Reply-To: <72eece35-d5f3-476a-ae0f-5fbd99cb2d60@free.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	DMARC_POLICY_QUARANTINE(1.50)[free.fr : SPF not aligned (relaxed), No valid DKIM,quarantine];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21907-lists,linux-btrfs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[free.fr];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[phako@free.fr,linux-btrfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5D7AB19538D
X-Rspamd-Action: no action

Le 24/02/2026 à 18:08, Phako a écrit :
> Le 24/02/2026 à 16:53, Phako a écrit :
>> Le 23/02/2026 à 22:35, Qu Wenruo a écrit :
>>>
>>>
>>> 在 2026/2/24 02:11, Phako 写道:
>>>> Le 23/02/2026 à 08:32, Qu Wenruo a écrit :
>>> [...]
>>>>
>>>> I get that you might think this issue is not BTRFS related, but I'm 
>>>> still not 100% sure of what is the cause of the error. So I'm still 
>>>> having a couple of questions to rule out wrong hypothesis or direct 
>>>> me on the right track:
>>>>
>>>> Do you think that if I copy a good copy of file_B.mp4 over the 
>>>> corrupt file_B.mp4 (eg: cat b.mp4 > b_corrupt.mp4) it will overwrite 
>>>> the metadata and the same physical LBAs?
>>>
>>> The metadata is not involved. It's fully the data part (and its 
>>> checksum).
>>>
>>> And unfortunately, a full over-write doesn't not guarantee the new 
>>> data will be written into the same the location.
>>>
>>>> Are there any btrfs commands I could run before and/or after to 
>>>> check if it worked, and to map this reported corrupt logical blocks 
>>>> with actual LBAs?
>>>
>>> But if you have the correct original file, you can try to manually 
>>> over- write the data, using "btrfs-map-logical" command to calculate 
>>> the on- disk physical LBA, then using whatever tool (dd for example) 
>>> to directly write the content into that physical address.
>>>
>>> Using your previous scrub dmesg as an example:
>>>
>>>  > Feb 09 16:18:02 soleil kernel: BTRFS warning (device sda3): csum 
>>> failed
>>>  > root 257 ino 40442 off 46100480 csum 0xc9e01f9a expected csum 
>>> 0xb20f9f0e
>>>  > mirror 1
>>>
>>>
>>> The first line of "csum failed" shows exactly where the corruption is 
>>> in the file (subvolume 257, inode number 40442, file offset 46100480).
>>>
>>> Then you can use fiemap to map the file offset to the btrfs logical 
>>> address:
>>>
>>>   $ xfs_io -c "fiemap 46100480 4096" <path_to_the_file>
>>>
>>> It would show something like this (just an example, not matching your 
>>> output):
>>>
>>> Filesystem type is: 9123683e
>>> File size of /mnt/btrfs/foobar is 1048576 (256 blocks of 4096 bytes)
>>>   ext:     logical_offset:        physical_offset: length:   
>>> expected: flags:
>>>     0:        0..     255:       3328..      3583:    256: last,eof
>>> /mnt/btrfs/foobar: 1 extent found
>>>
>>> The "logical_offset" part is the offset inside the file, the 
>>> "physical_offset" is the logical address inside btrfs.
>>> The unit is a block (4096 bytes shown after the filesystem type line).
>>>
>>> The range should cover your 46100480 file offset.
>>>
>>> You need to grab the btrfs logical address by converting the number.
>>>
>>> Then with the logical bytenr, you can convert it to the physical 
>>> address by using "btrfs-map-logical"
>>>
>>>   $ btrfs-map-logical -l <logical> <device>
>>>
>>> It will output something like this:
>>>
>>>   $ btrfs-map-logical -l 13635584 test.img
>>>   mirror 1 logical 13631488 physical 13635584 device test.img
>>>
>>> The number 13631488 is 3329 * 4096, corresponding to the file offset 
>>> 4K of my previous example.
>>>
>>>
>>> The resulted physical bytenr and device is where you should write the 
>>> data into.
>>>
>>>
>>> This can be very complex, so please paste the output of "$ xfs_io -c 
>>> "fiemap 46100480 4096" <path_to_the_file>" first, then we can figure 
>>> the exact command to use in the next step.
>>
>> The output I get is quite different, more terse:
>> $ xfs_io -c "fiemap 31494144 4096" 'file_B.mp4'
>> file_B.mp4:
>>          0: [0..87103]: 6658490256..6658577359
>>
>> And when I do 6658490257*4096=27273176092672
>> I get an error.
>> $ btrfs-map-logical -l 27273176092672 /dev/sda3
>> ERROR: failed to find any extent at [27273176092672,27273176109056)
>>
>>
>>
>>
> 
> I just found a way to dump one corrupt block and to compare it the same 
> block on the good file_B.mp4
> I just did 3409178460160-31449088+31494144 = 3409178505216 (it's a pity 
> that all the info are not in the same place, the first two numbers are 
> in the scrub result and the other is in the error log with the bad 
> checksum info when we try to read the corrupt file)
> I then run that to dump the corrupted block
> $ btrfs-map-logical -l 3409178505216 -o 31494144.bin -b 4096 /dev/sda3$
> 
> and when I compare it the good file, the blocks are the same until the 
> 3585 byte when random (no bit flip) and zeroed bytes are mixed until the 
> end of the block.

I have now copied 31494144-good.bin on sda3 at the right offset with:
$ dd if=31494144-good.bin of=/dev/sda3 seek=144184827 bs=4096 count=1

and now the checksum error
"BTRFS warning (device sda3): csum failed root 257 ino 230235 off 
31494144 csum 0x6741cf10 expected csum 0xca5f6f32 mirror 1"
disappered and only the next corrupt block appear in the log.
"BTRFS warning (device sda3): csum failed root 257 ino 262773 off 
31498240 csum 0x8941f998 expected csum 0xee146cb6 mirror 1"
I notice that the ino number is not the same, maybe that happened when I 
renamed the corrupt file_B.mp4.

Very strange behavior, I really don't get how the last 512 bytes of the 
31494144 block wasn't written correctly.
And I still don't have any I/O error in the logs, by the way.

Thanks again for the help, I succeeded in doing what I wanted to do but 
nonetheless I still have no idea of what is the cause of this problem.



