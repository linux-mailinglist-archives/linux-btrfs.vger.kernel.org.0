Return-Path: <linux-btrfs+bounces-21822-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kOUqLfh2m2mzzwMAu9opvQ
	(envelope-from <linux-btrfs+bounces-21822-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Sun, 22 Feb 2026 22:36:56 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E30717075E
	for <lists+linux-btrfs@lfdr.de>; Sun, 22 Feb 2026 22:36:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A3E23302711B
	for <lists+linux-btrfs@lfdr.de>; Sun, 22 Feb 2026 21:36:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA20935BDC2;
	Sun, 22 Feb 2026 21:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="QU1LEqmF"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A7FD1DF26E
	for <linux-btrfs@vger.kernel.org>; Sun, 22 Feb 2026 21:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771796180; cv=none; b=Apiq++IdZEiHwrlxu8nFkdzM1u9qjQZAB0eXmgT/cAkXjNTZvwhS3bd5Pvoh+kG4bc1p8SjfJlzt4IsEGdHFsJdkrVxTz3/GLGLpPix5Mchkq+HvK4WNB0Mu40U0JWr0IwnfquVRYvzWinl84PQZgKww/OksL62xbejrUlQ22lY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771796180; c=relaxed/simple;
	bh=9e63pmJP59xALlAByIlnAXN5SuR1zDHWceUqW3i2+PM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=XcGEXRPl3cchQrxRRTkMT47/394kpd/HJBBUQjqEf8F2jrf7yCqBRW3onJfh+4mzQnI1hRURlA10y7Q/M7ZbbUga9JiTR2yL+KPYvWzQZJtRHHhRgFmV65t9V/+jzJh7UEK/unClTbM+tP0kpT3eIG4/M7GSwIInu0F7JdgJtlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=QU1LEqmF; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-483a2338616so22788085e9.0
        for <linux-btrfs@vger.kernel.org>; Sun, 22 Feb 2026 13:36:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1771796177; x=1772400977; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=BfTPKOOWJIDutNkT+sB5TmjHtQ9kddokXLKTd2BIBFs=;
        b=QU1LEqmFw2TqHrIIzg3R53rrIvMARYzSx0wXPZy2zGL7YLJRcYDUrylSKTnYhWA8ch
         HcQfNjXK7u2DB1obHg/5Y1G70M8NFW0+SNMt6iYWdb8dIPZ6Q8nsqbOYsnja8YS7vtQu
         PRkNzuc265NQ2IQl75UE2NyeGrphQYf6gi+Cz3Jqaw6AFZic23b7AaaumdAVfw7onbFv
         l77LnvdOqp0g4Ko2CJ+GljSNbO1tewBEqA8mDco4zN8r0hYjRUfN+BaXkswzUGPMS0T8
         ZGXwqmJGNuTARDu+PzzaP+6elpQM6V6BVvUA2vyg6+xnSVnWRTPE5PxgqrR0Lm9r/sAe
         v6Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771796177; x=1772400977;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BfTPKOOWJIDutNkT+sB5TmjHtQ9kddokXLKTd2BIBFs=;
        b=MIeTXKrkQTFQYPj3luf/sCYjqcNxdqE+Ujxyf9gj3UjMqW+cg+znDnaHCIMTa9vwav
         9yIA8t2yCSUSoxMSR1yfPzJ/6gvKT0ook8uzEVH4AOY4t7tenb9Ez6ZkE00f94OoyVFl
         ReXN5ftSK9LGATjV8NPYN2O46bN5aOXXcqGvR0EZbVQnrmQHWItVzYb1S1s0kZ2fsq4T
         eKsKo5AmpA8Eg/2v3WSH2Avr0EPze7EP5NGijM3AxipiglmHJS5fyiEELxSTy9FEsBL3
         bKozYZYQScJvxMtYqPwgW3CjuRub9I+cqmPAXYJPk6QsgHG6i2nTtEyhUmzaGummjHz9
         qDAA==
X-Forwarded-Encrypted: i=1; AJvYcCVxkTG2xaObmPkFyVW3tTymJ+wC4JvgHrE7iErh9n2K9M2FvOYq8ilb5jh0g/5EBSEHLlvvg1KJt3PRsg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzFXeqboYnHIrvaOPpcgnzKGNLmEVJT5pWgcAcizP1mV8Uw+GFk
	qB14awjXVXokIsdDBWCnB25BDbY1THeDtB7g+y/siq7JgfO1qM4TLOpkP+N8fJPbOXc=
X-Gm-Gg: AZuq6aLD5SbwHct2dFy7PLDLlQq1LrUtbnJ6ayekD+EryyikvzLCMybMwjcq4L0yvJ0
	5H86ejWpGuoAhy0aX15HO9JCFZcuShKHYdbun2PMhlR4gWtzwyDG25qmD6797i/5oH+HPvaPAAh
	a6lc81MHn5Ry49UKVV9zQh1rJV30jQWX4nQgawUx19RJPkFeuDbiCc+ekD9pc4KjK40rOrDmBIl
	zxMPubkM2NwqQ4KMB7mFapwnajzINjd2j/mM9098uOEPSeme3A6maf/Fu9MNZ/Pa066y7b/V28f
	Cl3QaxDs3OX8LKKszefPRr/InXxs8DKjye0OfRYEy+gRY8z3NjS4JSdptX05MtmTejSkfH0P1ck
	UQ9CEoE+QjeNytw6efq5wA1KwhVbGFVsEZXmFvN134/re0ZXihWU+yXyKkslej4Um/ItkQj3m0L
	JHpu4LkLvsU/DlUr6BY0/W8J5FKtCNo4Mp3PMVlAPcTf7UbVSvvvg=
X-Received: by 2002:a05:600c:4f94:b0:482:eec4:74c with SMTP id 5b1f17b1804b1-483a95e9562mr94260295e9.22.1771796176704;
        Sun, 22 Feb 2026 13:36:16 -0800 (PST)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-358a2afcd72sm3879128a91.7.2026.02.22.13.36.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Feb 2026 13:36:15 -0800 (PST)
Message-ID: <0211658c-8d28-46d1-8e41-21dc02cab276@suse.com>
Date: Mon, 23 Feb 2026 08:06:09 +1030
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
In-Reply-To: <77535c20-da3e-4dfb-b3d7-9426c25b5da3@free.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21822-lists,linux-btrfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[linux-btrfs];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.com:mid,suse.com:dkim]
X-Rspamd-Queue-Id: 5E30717075E
X-Rspamd-Action: no action



在 2026/2/22 23:33, Phako 写道:
> Hello
> 
> I recently changed the 2x2TB disks I had on my NAS (hardware RAID) with 
> 2x16TB, after the migration (moved the data on an external HDD, then 
> moved them back on the new system)
> The actual configuration is a /dev/sda3 with a root and home subvolume.
> 
> The OS is a Debian 13 stable with running the 6.12.73+deb13-amd64 kernel
> 
> 2 days after the migration I noticed that one disk of the RAID array had 
> a enormous number of UDMA CRC errors (93976 errors), I then clean the 
> connection of the cables and HDDs and the CRC errors stopped increasing.
> But a couple of day later, when I ran a btrfs scrub I get 5 csum error 
> on 1 file.
> I blamed the very bad cabling problem during the sync of the array and 
> the transfert of the data back and deleted the corrupted file and copy 
> it back from the external HDD.
> But 2 weeks later after another scrub a new file with 5 csum errors is 
> detected, and it's on the same physical address (590581006336) but with 
> a different logical address than the first one, but smart and the RAID 
> controller don't report physical error.

Please provide the scrub dmesg, to make sure we're talking about the 
same "physical address".

The reason I'm asking is, you later used "btrfs ins dump-tree" and 
passing the bytenr 590581006336.

But if it's really physical address, passing it to "btrfs ins dump-tree" 
makes no sense, as that tool only accepts logical address.

In that case, the csum mismatch is completely expected, as it may not 
even belongs to a metadata block group.

Thanks,
Qu

> I launched a full smart test (1 day long) on each disk to see if that 
> trigger some error.
> But for now I have a couple of question to try to go deeper to find the 
> cause of the problem.
> I deleted the file concerned by this last csum errors but when I run :
> 
> btrfs inspect-internal dump-tree --follow -b590581006336 /dev/sda3
> btrfs-progs v6.14
> checksum verify failed on 590581006336 wanted 0x2424c600 found 0x0456148c
> ERROR: failed to read tree block 590581006336
> 
> Is there a way to ignore the csum error with the dump-tree function,
> 
> I guess that "590581006336" is the address of the block in bytes on 
> sda3, right?
> 
> Is someone have an idea on how I could force BTRFS to rewrite this block 
> or stop allocating it to data until I found the problem?
> 
> 


