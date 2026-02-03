Return-Path: <linux-btrfs+bounces-21340-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iJ8WMA5/gmnAVQMAu9opvQ
	(envelope-from <linux-btrfs+bounces-21340-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Wed, 04 Feb 2026 00:04:46 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 382DCDF880
	for <lists+linux-btrfs@lfdr.de>; Wed, 04 Feb 2026 00:04:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 300D730A2890
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Feb 2026 23:04:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 353022D191C;
	Tue,  3 Feb 2026 23:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="E9ZQD/WS"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8559B256C8B
	for <linux-btrfs@vger.kernel.org>; Tue,  3 Feb 2026 23:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770159883; cv=none; b=EM8d91WHnTZE3Hsgs69S0pHzoq7bS9VTl4nGST51rmg5a1B9iVxl1+QJLUVfdCSrkV+sBoOXNXFju628UrDDNhdq/gwO1ohsvMPPZ5w/oKPgcFsrUjAm8crAhlb2NAEJIBtpYbVxrEvKO9dztBxm8SV/yh21Cz6L+IQdfeslqXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770159883; c=relaxed/simple;
	bh=TvXYT48BEgRcQ14GiANHx3PcuDeSmyrox/lJwjJU618=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ohM+K+N4I+17e5OJUZGaAivTXIZaNnCb/MdT7iO02To2EUprYKD7CSVxiUaBZ3s83TGXRSn1gHgamiLk3GbILVg9FVsEykRGKWjwbmt59Tbtabb+T7Mcyd4w/Hg0vPV6ZfTWjRlnz0EJ6cdTmttkFld/7lqFQvcWlILuIMfAGHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=E9ZQD/WS; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-480706554beso66822095e9.1
        for <linux-btrfs@vger.kernel.org>; Tue, 03 Feb 2026 15:04:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1770159880; x=1770764680; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=2ruEio9XKDWf4osIeUJnffyeIG7rRyCdDvf0g48rkcE=;
        b=E9ZQD/WSr7+S6AiZBn46YBcMfTniMxMEplurBQ5s/X3rFrPH2C+vtjsM56liFNhUYI
         7Uk7//I488babvpOVfHRga2dvJfdN5wPoVECAGuGnRTEDRiowEzF+iRAo2GpDU42nqgc
         RglHQMatOOO0IWTuy0g0qRaf3pDKNUHrgmFXUYZEc946VAFeLMq1EvuCmOEZxKquyBfg
         hzacpRGA7s4s9t2ZqCjREhTR4GsWfax2X9xn32i9ifyRfn7ECIbVr7pmspNJuRJAjCqD
         BRMDFWW7bczgYfwN1PPYOk8HPoESEnyESmufzJPNN2xUt8HF3mvbt2GA/PdLHdLcpfdL
         41iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770159880; x=1770764680;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2ruEio9XKDWf4osIeUJnffyeIG7rRyCdDvf0g48rkcE=;
        b=iWRzEUFvCJyu8c+P7Vh5AGeP3FbKYz/KkYSlT7ugvxojCW+r+nW7jBgpRAM0UErEW0
         iwRlnj/z2U2rgJpL7kCTjs8R1AwsNejti66PiFzxfVb/DgI8jxgM77+8s31OUswEH/+j
         a1yckpaTtMxNGz4esyQdDyzwPJVUo5SbO+zSzXW/6MLI6z0wBQL9PkxLFof8+CEmgNKo
         ECrR8VMfcJjDgBb/Be4MdqUcmOkAcoepc/N6H0gPA0qvoPTKrs72/0kjOj4II+Qp42be
         JMndQjXspGqEXSXuz8C2X5/GhNe+/ZwD+SVObzeAh5v77mNMEC8rxDsePxU419RqCPY1
         Y27g==
X-Gm-Message-State: AOJu0YwVpFU1jNMCwwqOwZhBok7891K1p9Ojx9rblr8kNSoerIPp3UHM
	kwLd2pZq5OMXULXlmpkPF5xyYAj1CkZx/sBeCkiEYbXaLFmvFETGA0QltNicRRgnzUL/idfmPVF
	lesYS
X-Gm-Gg: AZuq6aJpAOylnyTFWpMAGhqnirznSnFjs+xbpGRnV5nz930oaw13EB/4+/yxCR5tOfJ
	PEQJY5L/ks5Ji7H5xtS1q9ASNlykHCatfxhfhuL/aI678Y/hbnt9yOLVALQFAJR7Je/tN6wpTWk
	qMNvA/x4p55OyzB3neBUo2kCVcxQKTTc6JMaLYSzU1JJHpAGNy/NaEhsso/uiZxme0dXQI7pvNb
	HpUyLETAMCgH1rXIe+v3FMCGXwiSNz7QgU059BPMS6iQ191ydmmCsv4Xe1hwW6zge6xT3o014TO
	tn3GewH5cuzybrOMsZE4jI9Jy2fCWBgpZHyq99nTyzz2QGhbYrtbEZ32cbQXkJjUU5aBxnCmsm4
	b0tL16xpYNc+Hi7Ur4Ukpkxz80+nN2yMUteFIcWy3eKiUaXgITSifSF/87Tj7U4UKXLqnigs3Zm
	mLc77wBBx61fKKHiRyCF2pXog1zu9P+STklhAegOs=
X-Received: by 2002:a05:600c:1daa:b0:47a:9560:5944 with SMTP id 5b1f17b1804b1-4830e98ad5fmr15379045e9.34.1770159879581;
        Tue, 03 Feb 2026 15:04:39 -0800 (PST)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a9338b71acsm5121375ad.45.2026.02.03.15.04.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Feb 2026 15:04:39 -0800 (PST)
Message-ID: <5885e640-76b1-4f07-a4c6-0460f823c56b@suse.com>
Date: Wed, 4 Feb 2026 09:34:31 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] btrfs: be less agressive with metadata overcommit
 when we can do full flushing
To: Filipe Manana <fdmanana@kernel.org>
Cc: linux-btrfs@vger.kernel.org
References: <cover.1770123544.git.fdmanana@suse.com>
 <213736b4ab22e6ecdd6a10513eaed5d85b4053bc.1770123545.git.fdmanana@suse.com>
 <a3b63027-9e17-41b3-bc7f-477d1e59381a@suse.com>
 <CAL3q7H5_Q=na-W+uPm88yWAtPxYFd_t3kP1WK-9YhnFMr8uoZA@mail.gmail.com>
 <395eab87-29b9-4a70-82a4-2bf3dd8f3078@suse.com>
 <CAL3q7H61vZ3_+eqJ1A9po2WcgNJJjUu9MJQoYB2oDSAAecHaug@mail.gmail.com>
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
In-Reply-To: <CAL3q7H61vZ3_+eqJ1A9po2WcgNJJjUu9MJQoYB2oDSAAecHaug@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-21340-lists,linux-btrfs=lfdr.de];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wqu@suse.com,linux-btrfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-btrfs];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 382DCDF880
X-Rspamd-Action: no action



在 2026/2/4 09:25, Filipe Manana 写道:
> On Tue, Feb 3, 2026 at 9:59 PM Qu Wenruo <wqu@suse.com> wrote:
>>
>>
>>
>> 在 2026/2/4 08:16, Filipe Manana 写道:
>> [...]
>>>
>>> We can allocate when we attempt to allocate a metadata extent.
>>> However here it fails because we really have no space:
>>>
>>> at calc_available_free_space() we subtract the data chunk size, and
>>> that leaves us at around 300M, which is not enough to allocate a
>>> metadata chunk in DUP profile (256M * 2 = 512M).
>>>
>>
>> For 1GB sized fs, 300MiB is enough for us to allocate a new metadata bg.
>> As the chunk size will be no larger than 10% of the fs.
>>
>> In fact I just tried to for a 1GB btrfs to create a metadata bg by
>> filling up the initial 51MiB metadata bg.
>>
>> The resulted bg chunk size is 112MiB:
>>
>>          item 0 key (DEV_ITEMS DEV_ITEM 1) itemoff 16185 itemsize 98
>>                  devid 1 total_bytes 1073741824 bytes_used 367394816
>>                                       ^^^ 1GiB
>>
>>          item 1 key (FIRST_CHUNK_TREE CHUNK_ITEM 13631488) itemoff 16105 itemsize 80
>>                  length 8388608 owner 2 stripe_len 65536 type DATA|single
>>          item 2 key (FIRST_CHUNK_TREE CHUNK_ITEM 22020096) itemoff 15993
>> itemsize 112
>>                  length 8388608 owner 2 stripe_len 65536 type SYSTEM|DUP
>>          item 3 key (FIRST_CHUNK_TREE CHUNK_ITEM 30408704) itemoff 15881
>> itemsize 112
>>                  length 53673984 owner 2 stripe_len 65536 type METADATA|DUP
>>                          ^^^ The one from mkfs
>>          item 4 key (FIRST_CHUNK_TREE CHUNK_ITEM 84082688) itemoff 15769
>> itemsize 112
>>                  length 117440512 owner 2 stripe_len 65536 type METADATA|DUP
>>                          ^^^ The new one, 112MiB.
>>
>> Mind to explain where the 256MiB requirement comes from?
> 
> So I was looking at an old trace before.
> 
> We fail to allocate a chunk because there's effectively no unallocated
> space at some point.
> 
> We have a bunch of data chunks allocated by dbench++ and we reach a
> point where a metadata chunk allocation fails.
> During the first metadata chunk allocation attempt,
> gather_device_info() finds no available space due to a bunch of
> pending chunks for data block groups (each with a size of 117440512
> bytes, except for the last two).
> 
> The tracing:
> 
>             mount-1793735 [011] ...1. 28877.261096:
> btrfs_add_bg_to_space_info: added bg offset 13631488 length 8388608
> flags 1 to space_info->flags 1 total_bytes 8388608 bytes_used 0
> bytes_may_use 0
>             mount-1793735 [011] ...1. 28877.261098:
> btrfs_add_bg_to_space_info: added bg offset 22020096 length 8388608
> flags 34 to space_info->flags 2 total_bytes 8388608 bytes_used 16384
> bytes_may_use 0
>             mount-1793735 [011] ...1. 28877.261100:
> btrfs_add_bg_to_space_info: added bg offset 30408704 length 53673984
> flags 36 to space_info->flags 4 total_bytes 53673984 bytes_used 131072
> bytes_may_use 0
> 
> These are from loading the block groups created by mkfs during mount.
> 
> Then when bonnie++ starts doing its thing:
> 
>     kworker/u48:5-1792004 [011] ..... 28886.122050: btrfs_create_chunk:
> gather_device_info 1 ctl->dev_extent_min = 65536 dev_extent_want
> 1073741824
>     kworker/u48:5-1792004 [011] ..... 28886.122053: btrfs_create_chunk:
> gather_device_info 2 ctl->dev_extent_min = 65536 dev_extent_want
> 1073741824 max_avail 927596544
>     kworker/u48:5-1792004 [011] ..... 28886.122055:
> btrfs_make_block_group: make bg offset 84082688 size 117440512 type 1
>     kworker/u48:5-1792004 [011] ...1. 28886.122064:
> btrfs_add_bg_to_space_info: added bg offset 84082688 length 117440512
> flags 1 to space_info->flags 1 total_bytes 125829120 bytes_used 0
> bytes_may_use 5251072
> 
> First allocation of a data block group of 112M.
> 
>     kworker/u48:5-1792004 [011] ..... 28886.192408: btrfs_create_chunk:
> gather_device_info 1 ctl->dev_extent_min = 65536 dev_extent_want
> 1073741824
>     kworker/u48:5-1792004 [011] ..... 28886.192413: btrfs_create_chunk:
> gather_device_info 2 ctl->dev_extent_min = 65536 dev_extent_want
> 1073741824 max_avail 810156032
>     kworker/u48:5-1792004 [011] ..... 28886.192415:
> btrfs_make_block_group: make bg offset 201523200 size 117440512 type 1
>     kworker/u48:5-1792004 [011] ...1. 28886.192425:
> btrfs_add_bg_to_space_info: added bg offset 201523200 length 117440512
> flags 1 to space_info->flags 1 total_bytes 243269632 bytes_used 0
> bytes_may_use 122691584
> 
> Another 112M data block group allocated.
> 
>     kworker/u48:5-1792004 [011] ..... 28886.260935: btrfs_create_chunk:
> gather_device_info 1 ctl->dev_extent_min = 65536 dev_extent_want
> 1073741824
>     kworker/u48:5-1792004 [011] ..... 28886.260941: btrfs_create_chunk:
> gather_device_info 2 ctl->dev_extent_min = 65536 dev_extent_want
> 1073741824 max_avail 692715520
>     kworker/u48:5-1792004 [011] ..... 28886.260943:
> btrfs_make_block_group: make bg offset 318963712 size 117440512 type 1
>     kworker/u48:5-1792004 [011] ...1. 28886.260954:
> btrfs_add_bg_to_space_info: added bg offset 318963712 length 117440512
> flags 1 to space_info->flags 1 total_bytes 360710144 bytes_used 0
> bytes_may_use 240132096
> 
> Yet another one.
> 
>          bonnie++-1793755 [010] ..... 28886.280407: btrfs_create_chunk:
> gather_device_info 1 ctl->dev_extent_min = 65536 dev_extent_want
> 1073741824
>          bonnie++-1793755 [010] ..... 28886.280412: btrfs_create_chunk:
> gather_device_info 2 ctl->dev_extent_min = 65536 dev_extent_want
> 1073741824 max_avail 575275008
>          bonnie++-1793755 [010] ..... 28886.280414:
> btrfs_make_block_group: make bg offset 436404224 size 117440512 type 1
>          bonnie++-1793755 [010] ...1. 28886.280419:
> btrfs_add_bg_to_space_info: added bg offset 436404224 length 117440512
> flags 1 to space_info->flags 1 total_bytes 478150656 bytes_used 0
> bytes_may_use 268435456
> 
> One more.
> 
>     kworker/u48:5-1792004 [011] ..... 28886.566233: btrfs_create_chunk:
> gather_device_info 1 ctl->dev_extent_min = 65536 dev_extent_want
> 1073741824
>     kworker/u48:5-1792004 [011] ..... 28886.566238: btrfs_create_chunk:
> gather_device_info 2 ctl->dev_extent_min = 65536 dev_extent_want
> 1073741824 max_avail 457834496
>     kworker/u48:5-1792004 [011] ..... 28886.566241:
> btrfs_make_block_group: make bg offset 553844736 size 117440512 type 1
>     kworker/u48:5-1792004 [011] ...1. 28886.566250:
> btrfs_add_bg_to_space_info: added bg offset 553844736 length 117440512
> flags 1 to space_info->flags 1 total_bytes 595591168 bytes_used
> 268435456 bytes_may_use 2
> 09723392
> 
> Another one.
> 
>          bonnie++-1793755 [009] ..... 28886.613446: btrfs_create_chunk:
> gather_device_info 1 ctl->dev_extent_min = 65536 dev_extent_want
> 1073741824
>          bonnie++-1793755 [009] ..... 28886.613451: btrfs_create_chunk:
> gather_device_info 2 ctl->dev_extent_min = 65536 dev_extent_want
> 1073741824 max_avail 340393984
>          bonnie++-1793755 [009] ..... 28886.613453:
> btrfs_make_block_group: make bg offset 671285248 size 117440512 type 1
>          bonnie++-1793755 [009] ...1. 28886.613458:
> btrfs_add_bg_to_space_info: added bg offset 671285248 length 117440512
> flags 1 to space_info->flags 1 total_bytes 713031680 bytes_used
> 268435456 bytes_may_use 2
> 68435456
> 
> Another one.
> 
>          bonnie++-1793755 [009] ..... 28886.674953: btrfs_create_chunk:
> gather_device_info 1 ctl->dev_extent_min = 65536 dev_extent_want
> 1073741824
>          bonnie++-1793755 [009] ..... 28886.674957: btrfs_create_chunk:
> gather_device_info 2 ctl->dev_extent_min = 65536 dev_extent_want
> 1073741824 max_avail 222953472
>          bonnie++-1793755 [009] ..... 28886.674959:
> btrfs_make_block_group: make bg offset 788725760 size 117440512 type 1
>          bonnie++-1793755 [009] ...1. 28886.674963:
> btrfs_add_bg_to_space_info: added bg offset 788725760 length 117440512
> flags 1 to space_info->flags 1 total_bytes 830472192 bytes_used
> 268435456 bytes_may_use 1
> 34217728
> 
> Another one.
> 
>          bonnie++-1793755 [009] ..... 28886.674981: btrfs_create_chunk:
> gather_device_info 1 ctl->dev_extent_min = 65536 dev_extent_want
> 1073741824
>          bonnie++-1793755 [009] ..... 28886.674982: btrfs_create_chunk:
> gather_device_info 2 ctl->dev_extent_min = 65536 dev_extent_want
> 1073741824 max_avail 105512960
>          bonnie++-1793755 [009] ..... 28886.674983:
> btrfs_make_block_group: make bg offset 906166272 size 105512960 type 1
>          bonnie++-1793755 [009] ...1. 28886.674984:
> btrfs_add_bg_to_space_info: added bg offset 906166272 length 105512960
> flags 1 to space_info->flags 1 total_bytes 935985152 bytes_used
> 268435456 bytes_may_use 67108864
> 
> Another one, this time a bit smaller, ~100.6M, since we now have less space.
> 
>          bonnie++-1793758 [009] ..... 28891.962096: btrfs_create_chunk:
> gather_device_info 1 ctl->dev_extent_min = 65536 dev_extent_want
> 1073741824
>          bonnie++-1793758 [009] ..... 28891.962103: btrfs_create_chunk:
> gather_device_info 2 ctl->dev_extent_min = 65536 dev_extent_want
> 1073741824 max_avail 12582912
>          bonnie++-1793758 [009] ..... 28891.962105:
> btrfs_make_block_group: make bg offset 1011679232 size 12582912 type 1
>          bonnie++-1793758 [009] ...1. 28891.962114:
> btrfs_add_bg_to_space_info: added bg offset 1011679232 length 12582912
> flags 1 to space_info->flags 1 total_bytes 948568064 bytes_used
> 268435456 bytes_may_use 8192
> 
> Another one, this one even smaller, 12M.
> 
>     kworker/u48:5-1792004 [011] ..... 28892.112802: btrfs_chunk_alloc:
> enter metadata chunk alloc
>     kworker/u48:5-1792004 [011] ..... 28892.112805: btrfs_create_chunk:
> gather_device_info 1 ctl->dev_extent_min = 131072 dev_extent_want
> 536870912
>     kworker/u48:5-1792004 [011] ..... 28892.112806: btrfs_create_chunk:
> gather_device_info 2 ctl->dev_extent_min = 131072 dev_extent_want
> 536870912 max_avail 0
> 
> 536870912 is 512M, the 256M * 2 (DUP) thing.
> max_avail is what find_free_dev_extent() returns to us in gather_device_info().
> 
> As a result it sets ctl->ndevs to 0, making decide_stripe_size() fail
> with -ENOSPC, and therefore metadata chunk allocation fails.
> 
>     kworker/u48:5-1792004 [011] ..... 28892.112807: btrfs_create_chunk:
> decide_stripe_size fail -ENOSPC
> 
> 
> Yes, what dmesg shows after the transaction abort does not include all
> those allocations.

Thanks a lot! This indeed solves my question on why the space dump is 
always so small.

So it's indeed lack of unallocated space, just the dump doesn't include 
those pending bgs.

> My guess on that is that after the transaction aborts, pending block
> groups are gone and it's influencing the dump. But that's another
> thing to investigate.
> 
> But if we add a call to btrfs_dump_space_info_for_trans_abort() to
> decide_stripe_size() when it returns -ENOSPC, before we have a
> transaction abort:
> 
> [29972.409295] BTRFS info (device nullb0): dumping space info:
> [29972.409300] BTRFS info (device nullb0): space_info DATA (sub-group
> id 0) has 673341440 free, is not full
> [29972.409303] BTRFS info (device nullb0): space_info total=948568064,
> used=0, pinned=275226624, reserved=0, may_use=0, readonly=0
> zone_unusable=0
> [29972.409305] BTRFS info (device nullb0): space_info METADATA
> (sub-group id 0) has 3915776 free, is not full
> [29972.409306] BTRFS info (device nullb0): space_info total=53673984,
> used=163840, pinned=42827776, reserved=147456, may_use=6553600,
> readonly=65536 zone_unusable=0

This is way better than the existing dump.

Definitely something we can improve.

> [29972.409308] BTRFS info (device nullb0): space_info SYSTEM
> (sub-group id 0) has 7979008 free, is not full
> [29972.409310] BTRFS info (device nullb0): space_info total=8388608,
> used=16384, pinned=0, reserved=0, may_use=393216, readonly=0
> zone_unusable=0
> [29972.409311] BTRFS info (device nullb0): global_block_rsv: size
> 5767168 reserved 5767168
> [29972.409313] BTRFS info (device nullb0): trans_block_rsv: size 0 reserved 0
> [29972.409314] BTRFS info (device nullb0): chunk_block_rsv: size
> 393216 reserved 393216
> [29972.409315] BTRFS info (device nullb0): remap_block_rsv: size 0 reserved 0
> [29972.409316] BTRFS info (device nullb0): delayed_block_rsv: size 0 reserved 0
> 
> So here we see there's over 900M of data space.
> 
> So lowering the metadata overcommit limit when we can flush, helps
> getting rid of a ton of pinned space.

Yep, now this explains the fix now.

Maybe you can update the commit message to include this version of space 
info dump.

Otherwise looks good to me.

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

> 
>>
>> Thanks,
>> Qu


