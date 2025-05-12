Return-Path: <linux-btrfs+bounces-13874-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B3775AB30C5
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 May 2025 09:51:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23D633A3CCC
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 May 2025 07:50:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCDC8256C89;
	Mon, 12 May 2025 07:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="D/sO9SUi"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4887F3D984
	for <linux-btrfs@vger.kernel.org>; Mon, 12 May 2025 07:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747036263; cv=none; b=XkyJ95qWwmPQdLgqxRhiHeBMci3lnv733w+MripjQ6aoqWrhtLZOZa8DvgfdhIiAdv4b82S3prY/rmuPgwwgznSg0t26D1B4D2Zz2219wVkIihNbK2EO2QUGLhvKeZGmuH+K4K1tYBeBSlrvNm+S//FP3X/yv3NI0biyCJ/VWpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747036263; c=relaxed/simple;
	bh=LoBGweeCRihhLbT87E8n0vng6oQCw63PRQDrQHTGgJk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=odJiu9NniuRXGzbmuU10L/t7lOGIRhSpBmhQWN4tV++++amFc8BY8a0me4v/ICGWl9dZxxyYc6pqGbc4fg5hH/eKV8lkyljcRpDZh/r3rlX8v9g4DQ1RsVZq5z9xiuzMvQJbHiV3esoo/+nsNfMR3jblexqqnMfufR4klQq7eFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=D/sO9SUi; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3a1c85e77d7so2179931f8f.0
        for <linux-btrfs@vger.kernel.org>; Mon, 12 May 2025 00:50:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1747036258; x=1747641058; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=zxB1WLpx9nqvldAmF2fmYyqMp23jnRQd3Wxs1y2cVn8=;
        b=D/sO9SUimVX2xT47mQF2mlHLZ3cto3bLsVHdDklu98uHxi4kNAmISatJR0H06TqrA8
         T8Zib3uuEMpYxtS9nf7cKgcgvXbCQDodkOrpFibfCb/8KahKPwX/lSbX3tRAYriRnibS
         tacjhXctYdYv/WPT22sbKKt77NIh4OOhHIjzP1yOGHW42RD/VymGlpj/vNP4ehwZaybD
         0grMsI6KLTj/W+ZR/6ZgTf+sYHj/It9JYBH47vMZYcK0NiqtPoNpbOoO9AhjJJ7W/RgM
         mfos+v382F2chtEn7fjX+SFeu0Q/9fdqRQWNCSTVy42CGZXROHSZv/7THyxWlj+JxYQ+
         CZ/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747036258; x=1747641058;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zxB1WLpx9nqvldAmF2fmYyqMp23jnRQd3Wxs1y2cVn8=;
        b=r9gFioBp4/5ZfDT5YlXV8IUjhvdN0fNJh0X5GVxocN9Sh4oM1XV3QEb8chmIGlpm0/
         tptHsr3bOtQWo6YjdHJlRhQvAVSG1o2b4QUgarhx32SGAgHuFivOae1tuVD0Fcf8YpZr
         8vtUoq3WKGkI7siC8iPGp1jCqwllrdgFqLfyeHF5jYLSgtngMKUjMsDG/ZHUL5HUudUY
         hMg5RbjIuTH4vid/unRL8tRx2fNxvQ0BlHPgq50NJLgqnMIYsHX1s8bvhKs59XFmWOzu
         Z276rq7xCDyTti6vBawNh4W0miKLiwE7IZZN2JE28eCsM5OH75u0SkeFof9zpS3ipSUR
         DqRQ==
X-Gm-Message-State: AOJu0YxqCXkxp5g928cQ/4lYYq9KZi4E5r39bHRE2jB3ZDchKhIYOusT
	sxfLIx0pFaNopg9y226YbFX1T3LQ86EaCtZLkAE6I2iefgGyQG8QFcDFkjnLbaw=
X-Gm-Gg: ASbGncvmWLQFKUEU8qYOLZDYl9LmHopYJBBjv+vAP8TQ/qHzzXs5qewP6riZuX4rfoz
	rE3jCzcLY6Mp9kdvN0Z+TgBtLzY2NHNtzROedGouEwYNaSzym5gY+2+Hx9ldox9IwREJM+31/KJ
	Fs6bZacahmhwZiWFtsfXp8AbM4F8uvpSHDYdesf/iHpRz0ero/DgqyzhcXSYgNWvsIvTroQRlme
	9w5X0nXWrNPqYPXns7ss+OCUaxPKLiGDhNIBVq+JOjIFr8RjmELVKiuvZC1N5LmPwdUWEa6J0FQ
	6bAoKLJCnYMqroVDL306FaKyxnTMF92EjPAUg4KlpMvepdWgO2UKJSy163iH6HIPpml+Yv32I+l
	p18Kv1dSUTct7BA==
X-Google-Smtp-Source: AGHT+IG5cTCfxCazkZb0GDigK8Hmk6QTb9vDefbmMh9SM8KbflakLBCdDZDXkqoT8+Vg14QdlXMBpg==
X-Received: by 2002:a5d:648d:0:b0:3a0:b84d:892e with SMTP id ffacd0b85a97d-3a1f64f17b9mr8722315f8f.54.1747036258325;
        Mon, 12 May 2025 00:50:58 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b2351b7a87dsm4356550a12.70.2025.05.12.00.50.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 May 2025 00:50:57 -0700 (PDT)
Message-ID: <c119cf23-3165-42fd-85f8-e2240eb9b7df@suse.com>
Date: Mon, 12 May 2025 17:20:48 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fstests: btrfs: a new test case to verify scrub and
 rescue=idatacsums
To: Filipe Manana <fdmanana@kernel.org>
Cc: linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
References: <20250512052551.236243-1-wqu@suse.com>
 <CAL3q7H7cqfhVNwEJ6dgXgZSmfUbOrSNZuua3MPWTs0LJ43BQXQ@mail.gmail.com>
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
In-Reply-To: <CAL3q7H7cqfhVNwEJ6dgXgZSmfUbOrSNZuua3MPWTs0LJ43BQXQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/5/12 17:14, Filipe Manana 写道:
> On Mon, May 12, 2025 at 6:26 AM Qu Wenruo <wqu@suse.com> wrote:
>>
>> There is a kernel bug report that scrub will trigger a NULL pointer
>> dereference when rescue=idatacsums mount option is provided.
>>
>> Add a test case for such situation, to verify kernel can gracefully
>> reject scrub when  there is no csum tree.
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>>   tests/btrfs/336     | 32 ++++++++++++++++++++++++++++++++
>>   tests/btrfs/336.out |  2 ++
>>   2 files changed, 34 insertions(+)
>>   create mode 100755 tests/btrfs/336
>>   create mode 100644 tests/btrfs/336.out
>>
>> diff --git a/tests/btrfs/336 b/tests/btrfs/336
>> new file mode 100755
>> index 00000000..f76a8e21
>> --- /dev/null
>> +++ b/tests/btrfs/336
>> @@ -0,0 +1,32 @@
>> +#! /bin/bash
>> +# SPDX-License-Identifier: GPL-2.0
>> +# Copyright (C) 2025 SUSE Linux Products GmbH. All Rights Reserved.
>> +#
>> +# FS QA Test 336
>> +#
>> +# Make sure read-only scrub won't cause NULL pointer dereference with
>> +# rescue=idatacsums mount option
>> +#
>> +. ./common/preamble
>> +_begin_fstest auto scrub quick
>> +
>> +_fixed_by_kernel_commit 6aecd91a5c5b \
>> +       "btrfs: avoid NULL pointer dereference if no valid extent tree"
>> +
>> +_require_scratch
>> +_scratch_mkfs >> $seqres.full
>> +
>> +_try_scratch_mount "-o ro,rescue=ignoredatacsums" > /dev/null 2>&1 ||
>> +       _notrun "rescue=ignoredatacsums mount option not supported"
>> +
>> +# For unpatched kernel this will cause NULL pointer dereference and crash the kernel.
>> +# For patched kernel scrub will be gracefully rejected.
>> +$BTRFS_UTIL_PROG scrub start -Br $SCRATCH_MNT >> $seqres.full 2>&1
> 
> If the scrub is supposed to fail, as the comment says, then we should
> check that it fails.
> Right now we're ignoring whether it succeeds or fails.

Currently it indeed fails for patched kernel, but I'm not sure if it 
will keep so in the future.

E.g. we can still properly scrub metadata chunks, and for data chunks we 
may even delayed the csum tree lookup so that if we got an empty data 
block group, we just do an early exit.

Or should I do the failure check, and update the test case when the 
kernel behavior changes in the future?

Thanks,
Qu


> 
> Otherwise it looks fine, thanks.
> 


