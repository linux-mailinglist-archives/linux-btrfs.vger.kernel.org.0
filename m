Return-Path: <linux-btrfs+bounces-21908-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iJTDEHTFnmkuXQQAu9opvQ
	(envelope-from <linux-btrfs+bounces-21908-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Feb 2026 10:48:36 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 65DB4195468
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Feb 2026 10:48:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 816B4301C582
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Feb 2026 09:38:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC7FF38F23A;
	Wed, 25 Feb 2026 09:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="D9ahMMhn"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 354BD38F22F
	for <linux-btrfs@vger.kernel.org>; Wed, 25 Feb 2026 09:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772012285; cv=none; b=qp1VzmpjtPJ4eQDuO7Bm6EnNuQ65V0L21z17jgWLJcIDPwmsosgqy+EMaslwpoqzLA2cyn3E0ZOMOn98E9kvH1mcx24NcokMRxFTh3/0pkh064ffMY3XbEsTblH2Z8IwhR1qsV7hzCmKpHUdkcnL3Gb+OLhz7bfFCmUVeoI2vng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772012285; c=relaxed/simple;
	bh=s+s+ZYXZVDWV77hLQf0LLQr4Hzq6EdxrkIl3O4GNywY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=JktCIXU2v7OXkCP7pnkskF5OFfLk2elc/3dr0rq6ZzuCWVlPBT5ysUXtQWyE+gcXRnhj/w/AM0yqhvc9+gb/NnqFlS+TJWwRAICQtZiiZYG/yVxjg9KFl0YmbJi2j0JaBEzYBUbneqGJ+JY5NZQMGB95nvKlGX4jbUmprFokuBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=D9ahMMhn; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4836f363d0dso53911325e9.3
        for <linux-btrfs@vger.kernel.org>; Wed, 25 Feb 2026 01:38:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1772012281; x=1772617081; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=FXnsd+o6Acs6h6Nb3HQ7qFzRxTWCwyytbs0zeqOHieA=;
        b=D9ahMMhnEsf8g3+vU9zkYQEEw+hrqJHtK2rql9lPc8SNdkCrb4iRBg2f+L21qg5HNE
         FfYO6tRPZysLwBtxaeA2WVBqRoXSY/DM3MdLZgYHjsRHmhcmerQsEDjBTcRms0wrQZtL
         C8rGLQyrdoI6sLCh53MhSZmPZwz9QK8/+WdKFBd53AwGLyIKSApC1ihl95k5Fs/NN2Hp
         gq+7F+XqTY3AIk1mbhkaYZtYheIAlsMvMzwthG1o2UdpPA3lMGwcFtR0xNkeP6x7axzt
         DyZOVP8VGzJ4V0eEjmU4v0F0wZ8zJX11PV+Ch+UtuKpfi1py03u3haEu1T+mCeYWfiq8
         WtSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772012281; x=1772617081;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FXnsd+o6Acs6h6Nb3HQ7qFzRxTWCwyytbs0zeqOHieA=;
        b=eRz/VAuZI1i+f118lWv0KH521mP0z4ThoxBHEFNgljUyPSjif6Y6QjUPCK0+qPnWm0
         2zgZg+X+R7pl7ljTGuQe622Y4p7f9f7tbED+hOWXbd3pcP2I2Cok0RBdv7fe0aSBBXWU
         6EOoOFiZOjdalttDAZnYXCeUaFhEMd1sbpNKQmkQAESQBLsWb17LkU4S2Rmidw/piiE/
         DlBZmVUENmeUJtX5+3rNsVWM8U6PdBab7A8mYJlQzohdABjmJQINY6Wuf0H4+CPUeFA2
         lbIcyybFwpuBQIQWF5Nl55kZ3i+C6CLsjxoGRGbFHlXGCTVMEjJFbS8IHsXIeng6E/fr
         t8FA==
X-Forwarded-Encrypted: i=1; AJvYcCVUZS25q7dV4NjFwISJqWkfquQWhvXr2FAHXvrDA38X0+qz0lKaJxZTnJE7qm9BOYLXncXH9I/U1itp8g==@vger.kernel.org
X-Gm-Message-State: AOJu0YwgwN2vljimsCXLLAqs1epJzJ9XSsiXWADZ4XF4+TgJSoOCnayr
	DK6kc4/TpRwwvVjTWIBoUDc9scgOD5VXJ3y0yHSZ6iApnQ6IjLNT9FygzMYgwTGKN4E=
X-Gm-Gg: ATEYQzxkZ8vot4tArOrDgRHTBW6qAKanei+8vvgD8N+LZsFRacLZ+Tqcuh6h11EPDPS
	aQJ1iRwg7oXu54jFxY7qps9UJpXS04xbIxyZ/FntYqOJQ8f7aQ5sGOexyDYgc+YmaoxtyQa03lm
	4ViLiR8ruK7+E7Tlis/LZo5wfF9uI1QgQqd7Cfmtm8sjpa/+dIJufGW0grv24ZLGRysvxtaR0I9
	ZXbSqOK7AU2e5otl/xlkpR3QeWlD1Hms8+184UIWc/PFnzYnS+MXRmbyIEP80c/w4xEyaKfWreS
	vDaAVGxj+51CfSLDGODdAVYYV737v9S/o9r2dRPJpzJf/ssIx9WByanzHRUmqRDkpCULZNGcZ4H
	FrUd5SIQoUshWLIwfmGMWzKg4gy+dYu4JJlVHtKnpYAksoFaAIYScEBYB14Br2sflNrNkMOoMwc
	dtTiA3iusWlTu02Q4fqZXuITMd72ROTDJ7Xn1OqKElWocTf7tlOH8=
X-Received: by 2002:a05:600c:1c22:b0:480:1c85:88bf with SMTP id 5b1f17b1804b1-483bef5c76dmr30949575e9.27.1772012281401;
        Wed, 25 Feb 2026 01:38:01 -0800 (PST)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c70b71a7ac6sm12923681a12.10.2026.02.25.01.37.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Feb 2026 01:38:00 -0800 (PST)
Message-ID: <b05f77cb-200c-4a68-8184-d5965490278a@suse.com>
Date: Wed, 25 Feb 2026 20:07:54 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Stuck on a BTRFS problem
To: Phako <phako@free.fr>, linux-btrfs@vger.kernel.org
References: <77535c20-da3e-4dfb-b3d7-9426c25b5da3@free.fr>
 <0211658c-8d28-46d1-8e41-21dc02cab276@suse.com>
 <b1c1247f-df00-4045-a508-fb9a5666114a@free.fr>
 <cb183999-6a95-456a-80f4-f703da298d74@suse.com>
 <deb56ee2-b5d6-4beb-9554-05da125dde54@free.fr>
 <51597107-5a23-4f15-9481-b4d58e18bbe1@suse.com>
 <2f7fe549-676d-45fb-b97a-82096027c89c@free.fr>
 <72eece35-d5f3-476a-ae0f-5fbd99cb2d60@free.fr>
 <fa9cfd2f-1e9d-4713-9e2b-9399076f8aba@free.fr>
Content-Language: en-US
From: Qu Wenruo <wqu@suse.com>
Autocrypt: addr=wqu@suse.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNGFF1IFdlbnJ1byA8d3F1QHN1c2UuY29tPsLAlAQTAQgAPgIbAwULCQgHAgYVCAkKCwIE
 FgIDAQIeAQIXgBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJnEXVgBQkQ/lqxAAoJEMI9kfOh
 Jf6o+jIH/2KhFmyOw4XWAYbnnijuYqb/obGae8HhcJO2KIGcxbsinK+KQFTSZnkFxnbsQ+VY
 fvtWBHGt8WfHcNmfjdejmy9si2jyy8smQV2jiB60a8iqQXGmsrkuR+AM2V360oEbMF3gVvim
 2VSX2IiW9KERuhifjseNV1HLk0SHw5NnXiWh1THTqtvFFY+CwnLN2GqiMaSLF6gATW05/sEd
 V17MdI1z4+WSk7D57FlLjp50F3ow2WJtXwG8yG8d6S40dytZpH9iFuk12Sbg7lrtQxPPOIEU
 rpmZLfCNJJoZj603613w/M8EiZw6MohzikTWcFc55RLYJPBWQ+9puZtx1DopW2jOwE0EWdWB
 rwEIAKpT62HgSzL9zwGe+WIUCMB+nOEjXAfvoUPUwk+YCEDcOdfkkM5FyBoJs8TCEuPXGXBO
 Cl5P5B8OYYnkHkGWutAVlUTV8KESOIm/KJIA7jJA+Ss9VhMjtePfgWexw+P8itFRSRrrwyUf
 E+0WcAevblUi45LjWWZgpg3A80tHP0iToOZ5MbdYk7YFBE29cDSleskfV80ZKxFv6koQocq0
 vXzTfHvXNDELAuH7Ms/WJcdUzmPyBf3Oq6mKBBH8J6XZc9LjjNZwNbyvsHSrV5bgmu/THX2n
 g/3be+iqf6OggCiy3I1NSMJ5KtR0q2H2Nx2Vqb1fYPOID8McMV9Ll6rh8S8AEQEAAcLAfAQY
 AQgAJgIbDBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJnEXWBBQkQ/lrSAAoJEMI9kfOhJf6o
 cakH+QHwDszsoYvmrNq36MFGgvAHRjdlrHRBa4A1V1kzd4kOUokongcrOOgHY9yfglcvZqlJ
 qfa4l+1oxs1BvCi29psteQTtw+memmcGruKi+YHD7793zNCMtAtYidDmQ2pWaLfqSaryjlzR
 /3tBWMyvIeWZKURnZbBzWRREB7iWxEbZ014B3gICqZPDRwwitHpH8Om3eZr7ygZck6bBa4MU
 o1XgbZcspyCGqu1xF/bMAY2iCDcq6ULKQceuKkbeQ8qxvt9hVxJC2W3lHq8dlK1pkHPDg9wO
 JoAXek8MF37R8gpLoGWl41FIUb3hFiu3zhDDvslYM4BmzI18QgQTQnotJH8=
In-Reply-To: <fa9cfd2f-1e9d-4713-9e2b-9399076f8aba@free.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21908-lists,linux-btrfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FREEMAIL_TO(0.00)[free.fr,vger.kernel.org];
	DKIM_TRACE(0.00)[suse.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wqu@suse.com,linux-btrfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-btrfs];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,suse.com:mid,suse.com:dkim]
X-Rspamd-Queue-Id: 65DB4195468
X-Rspamd-Action: no action



在 2026/2/25 20:03, Phako 写道:
> Le 24/02/2026 à 18:08, Phako a écrit :
>> Le 24/02/2026 à 16:53, Phako a écrit :
>>> Le 23/02/2026 à 22:35, Qu Wenruo a écrit :
>>>>
>>>>
>>>> 在 2026/2/24 02:11, Phako 写道:
>>>>> Le 23/02/2026 à 08:32, Qu Wenruo a écrit :
>>>> [...]
>>>>>
>>>>> I get that you might think this issue is not BTRFS related, but I'm 
>>>>> still not 100% sure of what is the cause of the error. So I'm still 
>>>>> having a couple of questions to rule out wrong hypothesis or direct 
>>>>> me on the right track:
>>>>>
>>>>> Do you think that if I copy a good copy of file_B.mp4 over the 
>>>>> corrupt file_B.mp4 (eg: cat b.mp4 > b_corrupt.mp4) it will 
>>>>> overwrite the metadata and the same physical LBAs?
>>>>
>>>> The metadata is not involved. It's fully the data part (and its 
>>>> checksum).
>>>>
>>>> And unfortunately, a full over-write doesn't not guarantee the new 
>>>> data will be written into the same the location.
>>>>
>>>>> Are there any btrfs commands I could run before and/or after to 
>>>>> check if it worked, and to map this reported corrupt logical blocks 
>>>>> with actual LBAs?
>>>>
>>>> But if you have the correct original file, you can try to manually 
>>>> over- write the data, using "btrfs-map-logical" command to calculate 
>>>> the on- disk physical LBA, then using whatever tool (dd for example) 
>>>> to directly write the content into that physical address.
>>>>
>>>> Using your previous scrub dmesg as an example:
>>>>
>>>>  > Feb 09 16:18:02 soleil kernel: BTRFS warning (device sda3): csum 
>>>> failed
>>>>  > root 257 ino 40442 off 46100480 csum 0xc9e01f9a expected csum 
>>>> 0xb20f9f0e
>>>>  > mirror 1
>>>>
>>>>
>>>> The first line of "csum failed" shows exactly where the corruption 
>>>> is in the file (subvolume 257, inode number 40442, file offset 
>>>> 46100480).
>>>>
>>>> Then you can use fiemap to map the file offset to the btrfs logical 
>>>> address:
>>>>
>>>>   $ xfs_io -c "fiemap 46100480 4096" <path_to_the_file>
>>>>
>>>> It would show something like this (just an example, not matching 
>>>> your output):
>>>>
>>>> Filesystem type is: 9123683e
>>>> File size of /mnt/btrfs/foobar is 1048576 (256 blocks of 4096 bytes)
>>>>   ext:     logical_offset:        physical_offset: length: expected: 
>>>> flags:
>>>>     0:        0..     255:       3328..      3583:    256: last,eof
>>>> /mnt/btrfs/foobar: 1 extent found
>>>>
>>>> The "logical_offset" part is the offset inside the file, the 
>>>> "physical_offset" is the logical address inside btrfs.
>>>> The unit is a block (4096 bytes shown after the filesystem type line).
>>>>
>>>> The range should cover your 46100480 file offset.
>>>>
>>>> You need to grab the btrfs logical address by converting the number.
>>>>
>>>> Then with the logical bytenr, you can convert it to the physical 
>>>> address by using "btrfs-map-logical"
>>>>
>>>>   $ btrfs-map-logical -l <logical> <device>
>>>>
>>>> It will output something like this:
>>>>
>>>>   $ btrfs-map-logical -l 13635584 test.img
>>>>   mirror 1 logical 13631488 physical 13635584 device test.img
>>>>
>>>> The number 13631488 is 3329 * 4096, corresponding to the file offset 
>>>> 4K of my previous example.
>>>>
>>>>
>>>> The resulted physical bytenr and device is where you should write 
>>>> the data into.
>>>>
>>>>
>>>> This can be very complex, so please paste the output of "$ xfs_io -c 
>>>> "fiemap 46100480 4096" <path_to_the_file>" first, then we can figure 
>>>> the exact command to use in the next step.
>>>
>>> The output I get is quite different, more terse:
>>> $ xfs_io -c "fiemap 31494144 4096" 'file_B.mp4'
>>> file_B.mp4:
>>>          0: [0..87103]: 6658490256..6658577359
>>>
>>> And when I do 6658490257*4096=27273176092672
>>> I get an error.
>>> $ btrfs-map-logical -l 27273176092672 /dev/sda3
>>> ERROR: failed to find any extent at [27273176092672,27273176109056)
>>>
>>>
>>>
>>>
>>
>> I just found a way to dump one corrupt block and to compare it the 
>> same block on the good file_B.mp4
>> I just did 3409178460160-31449088+31494144 = 3409178505216 (it's a 
>> pity that all the info are not in the same place, the first two 
>> numbers are in the scrub result and the other is in the error log with 
>> the bad checksum info when we try to read the corrupt file)
>> I then run that to dump the corrupted block
>> $ btrfs-map-logical -l 3409178505216 -o 31494144.bin -b 4096 /dev/sda3$
>>
>> and when I compare it the good file, the blocks are the same until the 
>> 3585 byte when random (no bit flip) and zeroed bytes are mixed until 
>> the end of the block.
> 
> I have now copied 31494144-good.bin on sda3 at the right offset with:
> $ dd if=31494144-good.bin of=/dev/sda3 seek=144184827 bs=4096 count=1
> 
> and now the checksum error
> "BTRFS warning (device sda3): csum failed root 257 ino 230235 off 
> 31494144 csum 0x6741cf10 expected csum 0xca5f6f32 mirror 1"
> disappered and only the next corrupt block appear in the log.
> "BTRFS warning (device sda3): csum failed root 257 ino 262773 off 
> 31498240 csum 0x8941f998 expected csum 0xee146cb6 mirror 1"
> I notice that the ino number is not the same, maybe that happened when I 
> renamed the corrupt file_B.mp4.
> 
> Very strange behavior, I really don't get how the last 512 bytes of the 
> 31494144 block wasn't written correctly.
> And I still don't have any I/O error in the logs, by the way.
> 
> Thanks again for the help, I succeeded in doing what I wanted to do but 
> nonetheless I still have no idea of what is the cause of this problem.

In this particular case, since the checksum matches with the correct 
data, it shows at least btrfs is seeing the correct data just before 
submitting it to the RAID controller.

So I'd say there may be something weird inside that RAID controller.


If possible, please try a btrfs RAID1 without that RAID controller to 
rule that out.

Thanks,
Qu

