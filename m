Return-Path: <linux-btrfs+bounces-21536-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0DCtJOaviWndAgUAu9opvQ
	(envelope-from <linux-btrfs+bounces-21536-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Mon, 09 Feb 2026 10:59:02 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 26ECB10DE1A
	for <lists+linux-btrfs@lfdr.de>; Mon, 09 Feb 2026 10:59:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BD111303A26B
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Feb 2026 09:56:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C040C366040;
	Mon,  9 Feb 2026 09:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="MMmkjs+0"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF16A3659E6
	for <linux-btrfs@vger.kernel.org>; Mon,  9 Feb 2026 09:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770630974; cv=none; b=hjBxiL7svmnXZi+4CJ8nTTy1d4GqNv1ulM8abXnLBoGUv/ZVe67O83mYFElqXqRl7HtHpOP+odwP6Klq+8t96nuFcAYvI1sfxEq7nZFoRzP1cvHhJ7/Js9xudvfsEY2ppzlR28rsu7swmjCoMw4N7oUXVSMZ8fClNkFvtWYJZmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770630974; c=relaxed/simple;
	bh=wnjXUSotQzCam9p5WGykfw4nArhBVG675aWmynxI9RQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OjKPJDxL4ff7YT7jK1aUFhsPjuZhT1xrzf0/GaTZpkMu2UKswyhV+NWElPgVGsVBwXg7bIkyqD3xP7hlkMcpYAKdXkABkRFd9M0+zdzSE+mHP1Eia+rVFWJjKZv4wyMueg5OOo4HKkaCaVXw8YWwpd1CPFFba95IEwYnWtOUT+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=MMmkjs+0; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-480142406b3so32196035e9.1
        for <linux-btrfs@vger.kernel.org>; Mon, 09 Feb 2026 01:56:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1770630972; x=1771235772; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Wy0F50xaaJVJTrrGGznzGV1HVjFueaLtRMJGHXPsuJc=;
        b=MMmkjs+0F92nb2xQHgjSFRpsP6+ngo3dmwtUwFkZwv9FcagRttPT0E9h7hevY9AbrT
         oyDcDBycuohwkWTb/R55MbmrlflbdyOj4s7jAqRZ6BuLpBrjSS33QFCmbULDY2HqKu1s
         jMJADpG2SGKyw7JnB96olesYhtjOth6TGlKWmfsEg6le6n9e9iAdsXBval9dw9oVjxr4
         fhnXlSbZaQsaxGpXoyCLnzJzKvB3D1BWUnQ16k6/S7BmNuiDKbcVGQg6BUIvaOlcNdUK
         6TEKf5/eJg34fHHK5k9teY4IJwZqnpej7qYoEf8F7O654WN+6jN2f+I3VhfbyrIQYZKZ
         kAGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770630972; x=1771235772;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wy0F50xaaJVJTrrGGznzGV1HVjFueaLtRMJGHXPsuJc=;
        b=peGUUfaULRSU1k6J1DyJw1YHNA/AvYIJvTMmerFBEhFlk6y0iAKob0OZro7w3HHH5X
         nyNseV8FhJ6tHTILvoRBspmHvXWHjhMvzurmll5iMCdRtZ5tpwM46eOCDvCW6Wvr9nAL
         8GB91cC4mGufJx3yIUE/7TBO35YEyKQ6Csn3QsqGCax+v0BJ09j2/9Ml2DJhVCju3Owu
         H+/jSw5TXNryDjHPlZRl46Uz59hkFlcohsgRpcV2gdjU7C5IwYYcujH6l30LXTGiWf6d
         V8dG1dKQ6bukTOL9qYJZG8wT904865rl9Masiqr0IvJwyllv5lb2URWbE30Li7KU1XG1
         WnSA==
X-Gm-Message-State: AOJu0YyjykHfA84toudNPEVcap8jwuwsY+pj+JtuanY1HfqyRJv4NCJi
	DsmAvvF54ObUDVpeJDlaYjb/GLrIN6odUXt1N7lklVBJ8TZ3Hdzq/qCKUxyhbNXq7M4=
X-Gm-Gg: AZuq6aJ2Zu9uFY5iqgxSW7E6Urehr3g68ZDZUX8AUtzz4VB7NRzLL/jGYpwrhurlvY2
	aXSDIg5+rDbA9ZuCYFU4v4nZZ3Wp0eTYqgId/MqUJvo8o5941ISsRfjB/EN4ZLus5m81C0VTM80
	8ZTwFpc7zecMLYEgSlaOYzk9eYRfsspP0AIU6LY3HJXtjNqHW5F1Zi0UrBd0oz9uKCvW/nJz/1S
	zhdzsIvrkScnhkz7WEohppTgUNI+uhYDnfjmRCtZxwUCmUuM2GWeHBJd+Fko0Zn3SirBdGNW/BQ
	Fbeu1w75gx2+3EkCr2gEp4u+2SDAV6fMJJ7nOaGE5+EXKhE7Dhztw6OMMoNQoCPBown5jAa54Sh
	t7wb5AluQYk9/3D5BwDGQfm+sfEncX+sRwAs9R5a/KS65VvtBMzvQcQiDeDyEEyb7gpQucshB5Q
	JowqaCORbkV6rBLfA8+yN9fSQk2noeLZjnaxGH9V0=
X-Received: by 2002:a05:600c:8b22:b0:477:b642:9dc9 with SMTP id 5b1f17b1804b1-4832021d9ccmr142589095e9.28.1770630972075;
        Mon, 09 Feb 2026 01:56:12 -0800 (PST)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c6dcb5eccbdsm8659108a12.19.2026.02.09.01.56.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Feb 2026 01:56:11 -0800 (PST)
Message-ID: <22b559fc-b3ec-4584-b19c-9f892ba9a32e@suse.com>
Date: Mon, 9 Feb 2026 20:26:07 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] fstests: btrfs: add a regression test for incorrect
 inode incompressible flag
To: Filipe Manana <fdmanana@kernel.org>
Cc: linux-btrfs@vger.kernel.org, fstests@vger.kernel.org,
 Filipe Manana <fdmanana@suse.com>
References: <20260209095020.128806-1-wqu@suse.com>
 <CAL3q7H4_pRExfW6U67YfMK7hXouXspAXXJHPWM2t3yGC3AY0CQ@mail.gmail.com>
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
In-Reply-To: <CAL3q7H4_pRExfW6U67YfMK7hXouXspAXXJHPWM2t3yGC3AY0CQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[suse.com:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21536-lists,linux-btrfs=lfdr.de];
	RCPT_COUNT_THREE(0.00)[4];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:dkim,suse.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 26ECB10DE1A
X-Rspamd-Action: no action



在 2026/2/9 20:24, Filipe Manana 写道:
> On Mon, Feb 9, 2026 at 9:50 AM Qu Wenruo <wqu@suse.com> wrote:
>>
>> [BUG]
>> Since kernel commit 59615e2c1f63 ("btrfs: reject single block sized
>> compression early"), a single block write at file offset 0, which can
>> not be inlined due the inode size, will mark the inode incompressible.
>>
>> [REGRESSION TEST]
>> The new regression test will do:
>>
>> - Create and mount the fs with compression,max_inline=2k
>>
>> - Do the following operations:
>>    * Truncate the inode to 2 * blocksize
>>      This will rule out any future inlined writes.
>>
>>    * Buffered write [0, 2K)
>>      Which will not be inlined.
>>
>>    * Sync
>>      For affected kernels, this will set the inode with NOCOMPRESS
>>      and reject all future compression on that inode.
>>
>>    * Buffered write [1M, 2M)
>>      For affected kernels, the range will not be compressed due
>>      to the NOCOMPRESS inode flag.
>>
>> - Unmount the fs
>>
>> - Make sure that:
>>    * The inode has no NOCOMPRESS flag
>>    * File extent at file offset 1M is being compressed
>>
>> Reviewed-by: Filipe Manana <fdmanana@suse.com>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>> Changelog:
>> v2:
>> - Remove an unnessary sentence
>>    Which is confusing because I missed the "and" to connect the two
>>    sentences, and it's not needed after the first paragraph anyway.
>>
>> - Use full "btrfs inspect-internal" group name instead
>>
>> - Add missing punctures
>> ---
>>   tests/btrfs/343     | 47 +++++++++++++++++++++++++++++++++++++++++++++
>>   tests/btrfs/343.out |  2 ++
>>   2 files changed, 49 insertions(+)
>>   create mode 100755 tests/btrfs/343
>>   create mode 100644 tests/btrfs/343.out
>>
>> diff --git a/tests/btrfs/343 b/tests/btrfs/343
>> new file mode 100755
>> index 00000000..78079eff
>> --- /dev/null
>> +++ b/tests/btrfs/343
>> @@ -0,0 +1,47 @@
>> +#! /bin/bash
>> +# SPDX-License-Identifier: GPL-2.0
>> +# Copyright (c) 2026 SUSE S.A.  All Rights Reserved.
>> +#
>> +# FS QA Test 343
>> +#
>> +# A regression test to make sure a single-block write at file offset 0 won't
>> +# incorrectly mark the inode incompressible.
>> +#
>> +. ./common/preamble
>> +_begin_fstest auto quick compress
>> +
>> +_require_scratch
> 
> Still missing a:
> 
> _require_btrfs_command inspect-internal dump-tree
> 
> As noted in the review of the first version.
> Otherwise it looks good, thanks.

Facepalm, I forgot to commit...

