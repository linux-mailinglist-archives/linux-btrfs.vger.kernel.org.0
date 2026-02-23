Return-Path: <linux-btrfs+bounces-21830-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AGAXOJQCnGn6+wMAu9opvQ
	(envelope-from <linux-btrfs+bounces-21830-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Feb 2026 08:32:36 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 532D9172B57
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Feb 2026 08:32:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B176330164A9
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Feb 2026 07:32:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10FA720E334;
	Mon, 23 Feb 2026 07:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="J/DDNgQq"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5599F4F1
	for <linux-btrfs@vger.kernel.org>; Mon, 23 Feb 2026 07:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771831948; cv=none; b=gYX/f7vjOmbwYb7DKmqGixs47gUbuIkAoUG86Q8jkkVqdyy5sycyWBd+3q9zY7bZaxT5yDGf1Gj0a2xiBrbI9T+9VqYhR+jLFWtnVZwUbN6Xs7xYHThwei9ynZejDqJvptd0Rp5fR8jTx7EFtbIKjNo8mjTK/768arcgvPCmavA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771831948; c=relaxed/simple;
	bh=OF9be7X2c+CrSHWkGImTLVOe+XhERGkt4RcFEGP1TVc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=h88qEgpYdNkKN0/AlNrXTP6MJLCNfi7nHg3t1mut7NF5pebKskEUk/7wJmudKQUyrBTgNWp5DV4TsvtOeb6Q7UJh8s8nJ3S52QCTzkIxfos/29QACKK7Ltvblg9/RGseAV+xAVAi5Y0stRoX9YFCbRp8RkNXEMEj16u6mK5B15k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=J/DDNgQq; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-480706554beso48264405e9.1
        for <linux-btrfs@vger.kernel.org>; Sun, 22 Feb 2026 23:32:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1771831945; x=1772436745; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=WTodfvk8epRCZVtWlExpXnS0Y5jqD9vde00LAiwiQwE=;
        b=J/DDNgQqA2zVK1tN+zctESTbe6hfvnjhXvb4TD+YJDqtu5u/dkKf/8PkUl5stNTC4T
         AQ8jixD5SlWyzHnkG+dNN3RkPYAbpozcwY4b9M1xnpaOfxA1dAdBiMbTq8w4AtuIOqam
         UupVN1T4EZlX1VsUsFGskLkFYKh6aWX9Zg7op243GgWNRRUjHoPdqlN/QBVMJ1LiF/yu
         PrdYbKYV6aPiyvOFsZcy5IUowaa7FqJrbFoLr3HfUaPck7Kss0tYpo7RQ6bU2DIOdrq2
         DaNIOT7ZI1S5TGP+QlKkGs13AbvTalEZuvtn/roUeOtP+ll0znpVXDisgPipSnEnshbf
         EJpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771831945; x=1772436745;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WTodfvk8epRCZVtWlExpXnS0Y5jqD9vde00LAiwiQwE=;
        b=grX4/BWmiNY+Zuo5W63VgjPVbOHPcSLpTUP1TdoEmnBKuU80hxCLGjfHSE7+Pw8x2A
         b3uh7LmPVTutEMbMJuv5mquN6Nj8/fUNMY6t/qP1l17gi21OvPgQDgPG5vFwVT8gD7EP
         iHeYgZEQnLwAy9TADS7HQ2U4vxFaGEXSX+2YrFdqWmbtoN4mtDsGoAGyH/CrYhcFLy4Q
         c5ahsPbvkdBXZ1W60cWgx8xtLPjZA5j/Ip+V8Ot2X3QZeC/8+pjZGNu+lMoX8fpQGa0U
         qOwpYIqSbLqJSX4JeKdnDInvr4O1d3o6+Q4/nOv89YALjw000XFods5QzlkYC6xpnrGE
         cgQA==
X-Forwarded-Encrypted: i=1; AJvYcCUk5h33jqDdL3+aSNjUXNqR9zbu/+vCxfhSNzHP3nG2gLe5AE2Ky2/m83a9qJi4JTKmSZI9FYig+R6vHQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzQ3CeahEjUJxb0afuKUJjeg/M3yNLA5bI4wAuq1G7wlvzD5/d+
	6L6O92DUrmwIIcLCCnY6RVekLuJlBgyKLis/EbBfhFZ2Ikj3jQBaGIsZgo7q4j/I7DrylI4mvjI
	A1qZU/x0=
X-Gm-Gg: AZuq6aLgLSRXquhqz6v7b9kr8YeSc33uG0bbQXmLqSGtPJdD3b7cwi37+C5MJcUWMR1
	EIAk62tGRUB4YZFOpQaBz1qc1mxv2GmB6HS6xPDh+xm3xN6fI26JAN4nbDoAgIJ0RRWGiIF1u7Y
	iJMuqbxZDndPkimpgug3ir2B5/jaz5+egAvMDBZzuv70eyX07imBI5t6qqtOd2aiBh0LfGmaXHP
	IKrHAqnRAmOmI09ZqpJdLQrj89eMUGjHkDBzrOdnEO23LFvyj0Dc4YhExdiIZZkTHH9p+PTJohH
	CruE5A0PUnlwlHNrcFJvBseH5fHSz58mb5A1rxXNpvl3C1T5rXTzFPYqGbOSSiFJS87rWLqxezp
	a3RlqBF3sR/k7m3beJ11qRmDFnBSNWQEJVfrsh11hraBGkTVV8k/Q8qiWPZcotMHf4tfZpiix1p
	Qv/9blB4h1MN+pk5YacO4EBTtl3I8J0MGBJEmbrHe24B0/WJOiu2s=
X-Received: by 2002:a05:600c:3b10:b0:46e:4b79:551 with SMTP id 5b1f17b1804b1-483a963d233mr128757675e9.31.1771831944783;
        Sun, 22 Feb 2026 23:32:24 -0800 (PST)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ad750586e3sm67720425ad.90.2026.02.22.23.32.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Feb 2026 23:32:24 -0800 (PST)
Message-ID: <cb183999-6a95-456a-80f4-f703da298d74@suse.com>
Date: Mon, 23 Feb 2026 18:02:20 +1030
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
In-Reply-To: <b1c1247f-df00-4045-a508-fb9a5666114a@free.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21830-lists,linux-btrfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[linux-btrfs];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,suse.com:mid,suse.com:dkim]
X-Rspamd-Queue-Id: 532D9172B57
X-Rspamd-Action: no action



在 2026/2/23 17:17, Phako 写道:
> Le 22/02/2026 à 22:36, Qu Wenruo a écrit :
>>
>>
>> 在 2026/2/22 23:33, Phako 写道:
>>> Hello
>>>
>>> I recently changed the 2x2TB disks I had on my NAS (hardware RAID) 
>>> with 2x16TB, after the migration (moved the data on an external HDD, 
>>> then moved them back on the new system)
>>> The actual configuration is a /dev/sda3 with a root and home subvolume.
>>>
>>> The OS is a Debian 13 stable with running the 6.12.73+deb13-amd64 kernel
>>>
>>> 2 days after the migration I noticed that one disk of the RAID array 
>>> had a enormous number of UDMA CRC errors (93976 errors), I then clean 
>>> the connection of the cables and HDDs and the CRC errors stopped 
>>> increasing.
>>> But a couple of day later, when I ran a btrfs scrub I get 5 csum 
>>> error on 1 file.
>>> I blamed the very bad cabling problem during the sync of the array 
>>> and the transfert of the data back and deleted the corrupted file and 
>>> copy it back from the external HDD.
>>> But 2 weeks later after another scrub a new file with 5 csum errors 
>>> is detected, and it's on the same physical address (590581006336) but 
>>> with a different logical address than the first one, but smart and 
>>> the RAID controller don't report physical error.
>>
>> Please provide the scrub dmesg, to make sure we're talking about the 
>> same "physical address".
>>
>> The reason I'm asking is, you later used "btrfs ins dump-tree" and 
>> passing the bytenr 590581006336.
>>
>> But if it's really physical address, passing it to "btrfs ins dump- 
>> tree" makes no sense, as that tool only accepts logical address.
>>
>> In that case, the csum mismatch is completely expected, as it may not 
>> even belongs to a metadata block group.
>>
>> Thanks,
>> Qu
> 
> 
> Here is the scrub error output concerning the corrupted file_A.mp4 (now 
> deleted)

So it's really physical address, and your "btrfs ins dump-tree" call on 
whatever bytenr doesn't make any sense.

No matter if you're using logical nor physical bytenr, there is no 
metadata block group for them, thus csum mismatch is expected.

I have already submitted a patch to prevent end users passing wrong 
numbers into "btrfs ins dump-tree":

https://lore.kernel.org/linux-btrfs/56d383400ae8a0ff20b5141baa1ab4068c5603ef.1771798449.git.wqu@suse.com/


Now let's go back to the original problem.

Firstly according to your kernel version, it looks like upstream v6.12 
doesn't have the upstream commit 968f19c5b1b7 ("btrfs: always fallback 
to buffered write if the inode requires checksum") backported.

That means if your nas has some direct IO workload and the program 
doesn't properly wait for the direct IO to finish before updating the 
buffer in user space, it can lead to such data checksum mismatch.

This is a long known problem and finally worked around upstream, but 
unfortunately not backported to v6.12 yet.
I'll need to submit it for backport soon.


If that's not the case, and you always hit the same corruption at the 
same physical address, it may really be the HDD.


Back to your forcing over-write question, the answer is unfortunately 
no. Especially when data checksum is enabled, we have no way but COW new 
writes.

You can try to delete the file, and hopes new file will be allocated 
into the same location, but all you can do is only to hope.


If you have a spare HDD, I'd recommend to remove involved files first, 
making sure scrub passes.

Then add the HDD to the existing fs, re-balance all data to RAID1, do 
some extra writes, and wait to see if the problem happens again.

If the problem happens that both copies have data checksum mismatch thus 
unable to repair, it will be more like the direct IO bug.

If only sda3 keeps throwing out errors but the other one is totally fine 
(and btrfs can automatically use the correct copy to over-write the bad 
one on sda3), then we know it's sda3 to blame.

Thanks,
Qu

> 
> 
> Feb 09 15:51:16 nas01 kernel: BTRFS error (device sda3): unable to fixup 
> (regular) error at logical 589498875904 on dev /dev/sda3 physical 
> 590581006336
> Feb 09 15:51:16 nas01 kernel: BTRFS warning (device sda3): checksum 
> error at logical 589498875904 on dev /dev/sda3, physical 590581006336, 
> root 257, inode 40442, offset 46055424, length 4096>
> Feb 09 15:51:16 nas01 kernel: BTRFS error (device sda3): unable to fixup 
> (regular) error at logical 589498875904 on dev /dev/sda3 physical 
> 590581006336
> Feb 09 15:51:16 nas01 kernel: BTRFS warning (device sda3): checksum 
> error at logical 589498875904 on dev /dev/sda3, physical 590581006336, 
> root 257, inode 40442, offset 46055424, length 4096>
> Feb 09 15:51:16 nas01 kernel: BTRFS error (device sda3): unable to fixup 
> (regular) error at logical 589498875904 on dev /dev/sda3 physical 
> 590581006336
> Feb 09 15:51:16 nas01 kernel: BTRFS warning (device sda3): checksum 
> error at logical 589498875904 on dev /dev/sda3, physical 590581006336, 
> root 257, inode 40442, offset 46055424, length 4096>
> Feb 09 15:51:16 nas01 kernel: BTRFS error (device sda3): unable to fixup 
> (regular) error at logical 589498875904 on dev /dev/sda3 physical 
> 590581006336
> Feb 09 15:51:16 nas01 kernel: BTRFS warning (device sda3): checksum 
> error at logical 589498875904 on dev /dev/sda3, physical 590581006336, 
> root 257, inode 40442, offset 46055424, length 4096>
> Feb 09 15:51:16 nas01 kernel: BTRFS error (device sda3): unable to fixup 
> (regular) error at logical 589498875904 on dev /dev/sda3 physical 
> 590581006336
> Feb 09 15:51:16 nas01 kernel: BTRFS warning (device sda3): checksum 
> error at logical 589498875904 on dev /dev/sda3, physical 590581006336, 
> root 257, inode 40442, offset 46055424, length 4096>
> Feb 09 15:51:16 nas01 kernel: BTRFS error (device sda3): bdev /dev/sda3 
> errs: wr 0, rd 0, flush 0, corrupt 1, gen 0
> Feb 09 15:51:16 nas01 kernel: BTRFS error (device sda3): bdev /dev/sda3 
> errs: wr 0, rd 0, flush 0, corrupt 2, gen 0
> Feb 09 15:51:16 nas01 kernel: BTRFS error (device sda3): bdev /dev/sda3 
> errs: wr 0, rd 0, flush 0, corrupt 3, gen 0
> Feb 09 15:51:16 nas01 kernel: BTRFS error (device sda3): bdev /dev/sda3 
> errs: wr 0, rd 0, flush 0, corrupt 4, gen 0
> Feb 09 15:51:16 nas01 kernel: BTRFS error (device sda3): bdev /dev/sda3 
> errs: wr 0, rd 0, flush 0, corrupt 5, gen 0
> 
> 
> And days later, the scrub for the file_B.mp4 :
> 
> Feb 21 21:34:53 nas01 kernel: BTRFS error (device sda3): unable to fixup 
> (regular) error at logical 3409178460160 on dev /dev/sda3 physical 
> 590581006336
> Feb 21 21:34:53 nas01 kernel: BTRFS warning (device sda3): checksum 
> error at logical 3409178460160 on dev /dev/sda3, physical 590581006336, 
> root 257, inode 230235, offset 31449088, length 4096>
> Feb 21 21:34:53 nas01 kernel: BTRFS error (device sda3): unable to fixup 
> (regular) error at logical 3409178460160 on dev /dev/sda3 physical 
> 590581006336
> Feb 21 21:34:53 nas01 kernel: BTRFS warning (device sda3): checksum 
> error at logical 3409178460160 on dev /dev/sda3, physical 590581006336, 
> root 257, inode 230235, offset 31449088, length 4096>
> Feb 21 21:34:53 nas01 kernel: BTRFS error (device sda3): unable to fixup 
> (regular) error at logical 3409178460160 on dev /dev/sda3 physical 
> 590581006336
> Feb 21 21:34:53 nas01 kernel: BTRFS warning (device sda3): checksum 
> error at logical 3409178460160 on dev /dev/sda3, physical 590581006336, 
> root 257, inode 230235, offset 31449088, length 4096>
> Feb 21 21:34:53 nas01 kernel: BTRFS error (device sda3): unable to fixup 
> (regular) error at logical 3409178460160 on dev /dev/sda3 physical 
> 590581006336
> Feb 21 21:34:53 nas01 kernel: BTRFS warning (device sda3): checksum 
> error at logical 3409178460160 on dev /dev/sda3, physical 590581006336, 
> root 257, inode 230235, offset 31449088, length 4096>
> Feb 21 21:34:53 nas01 kernel: BTRFS error (device sda3): unable to fixup 
> (regular) error at logical 3409178460160 on dev /dev/sda3 physical 
> 590581006336
> Feb 21 21:34:53 nas01 kernel: BTRFS warning (device sda3): checksum 
> error at logical 3409178460160 on dev /dev/sda3, physical 590581006336, 
> root 257, inode 230235, offset 31449088, length 4096>
> Feb 21 21:34:53 nas01 kernel: BTRFS error (device sda3): bdev /dev/sda3 
> errs: wr 0, rd 0, flush 0, corrupt 41, gen 0
> Feb 21 21:34:53 nas01 kernel: BTRFS error (device sda3): bdev /dev/sda3 
> errs: wr 0, rd 0, flush 0, corrupt 42, gen 0
> Feb 21 21:34:53 nas01 kernel: BTRFS error (device sda3): bdev /dev/sda3 
> errs: wr 0, rd 0, flush 0, corrupt 43, gen 0
> Feb 21 21:34:53 nas01 kernel: BTRFS error (device sda3): bdev /dev/sda3 
> errs: wr 0, rd 0, flush 0, corrupt 44, gen 0
> Feb 21 21:34:53 nas01 kernel: BTRFS error (device sda3): bdev /dev/sda3 
> errs: wr 0, rd 0, flush 0, corrupt 45, gen 0


