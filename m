Return-Path: <linux-btrfs+bounces-20381-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DBD5ED0FD27
	for <lists+linux-btrfs@lfdr.de>; Sun, 11 Jan 2026 21:43:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BBC473051AD0
	for <lists+linux-btrfs@lfdr.de>; Sun, 11 Jan 2026 20:43:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 066E625A34F;
	Sun, 11 Jan 2026 20:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="d/UXT4ZY"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9960242D91
	for <linux-btrfs@vger.kernel.org>; Sun, 11 Jan 2026 20:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768164190; cv=none; b=mzJCZPYI/0vRmIAlxy4Kd5ZrI4rVZY7Z0V+J6JV3UJTfpH4/KiZT86XKCO10YbaAafQb7woPFyAyAYBgp8HbWxLyW+yIUig9MftapfxxNjFPuRNhFxsLT6RBf3jsJqi3Yb5GFrEmr1WV7BqGpW4MILn+F55ez8JeeoDLc6Hz4hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768164190; c=relaxed/simple;
	bh=osqFqgw8Q0siQVzzKG+YfRRHkEzH9EYHuDYziNyQIOQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KWVo1Sjrb/OsOlum9S39QkQL4KQ4WjlLueeA/6kN7NKDRypBpCOgddGoR/p6oZcOEyuAxPwm6smNSedcLY5iNYOFxJ0/sRUJmQlbE9NjaQM9kSouQzrVKW1CXx9OjGbR11kLRV6VI3VI28y0mB1wQ9Kwq4JU+f41k0w9RYC4qXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=d/UXT4ZY; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-477632b0621so36016155e9.2
        for <linux-btrfs@vger.kernel.org>; Sun, 11 Jan 2026 12:43:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1768164187; x=1768768987; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=53oN1TSK/l4MFeOdB7XYlHhixizXzSPzzFcTia74Pdk=;
        b=d/UXT4ZYd3OuHpqK92YajI3wTI50j1ODkilhpZCh7iAHd6pjNqUjL2lMBq+/mrb8oQ
         I1hDzR9WMAWjNAZUY/ahRfFmYqbtpHl26b7O0+Oxa6R6MMQ5Iv3cIfgSuOmfSGQQJpVB
         wudreHqtr3AlZvS7Hs15sVw8eEzgQwI/xRxYXV+iOI8pEwrC+fsKXFRs6Eu6N6Sy/gEY
         yt3fKy9cpkIPWuroup8NZg63Pf1WMC+iN8eJ05H314CWcwXtLCjfqM9QMQKO16eNTtYQ
         GMxWwZlL1RSla3Ol7nyusRIU9MLT6UNPx9q19gX3y6rlvwg4yJ0AwQAU/+G8zvy/onws
         ssAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768164187; x=1768768987;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=53oN1TSK/l4MFeOdB7XYlHhixizXzSPzzFcTia74Pdk=;
        b=B3bimJO32t7vcxsT3ZemwSlajTPFydMoUVkb2tTYKD2Sj6cBq9Ynk37ssnqZns608E
         BGX0dJhfokrBL7ceps/RSHcYPtZbpkAP8alCQSaHRBKPmc7RquFw0wLY4SW2ZqaeXYFh
         JQs4gfCpq/b1wRIsgpv8mqcvkCm7qTcqWnyxDgk4Xi7xCFl9qxMwvIu+N3TFXlp7q8jU
         ObLciGtlyqjKrr/O2YsySaMferKTBwZmNQRc6U8fCGJ7JFcerchb8mkIcCEnOVexbu9F
         uAJ1lvbGlgSU2+0llR/8g44EOo7vn/9dtLJdnGcuQdsv4oj8k7oVDCqe3C3BTV1tVUCK
         nOZg==
X-Forwarded-Encrypted: i=1; AJvYcCXla6Tf1I7nRRbIGYR+7wI2qyMEUnMuYXF41r7mC1+llgMBys3/tSRJFc0Npg8sIYl0DbhJ3u3PXV5EGg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyrPOS09eOzlPkjBa9WgnNUeMaBkModmDJGcuMmjA2G2aJPgwxr
	MlqMA2BnuzGb+2LfZS+5xqHzAmpRFD4SxaSJrzyg3p+zNSTJuedFhTxLSbaUqhqby9jiDUC8Rvo
	jI8XKu+U=
X-Gm-Gg: AY/fxX5lonL/iPhNEQZRcpoRXeS5KdB4grl2YSig+FYPEVWJ+kZRuWqnS9K49i49faS
	bx77CMLsCAzbfMIuu36Xh1oOr8BfcAl9CBuMUSjugOdC+LpxfsqYRYwmLIoHXXCvDH/Ta31/xIQ
	I2OfKqArdFJCi2+0u+gbiCWon+/DBiNwURvTjoDjlVRd0qTQiJx+mmlhPjCLbx4YaUeacvubbtd
	wYe8wf52i/6Fe1lQDjVyAADbUJcxuHNFh7/YBkybK70sjAUBg9OP2P4BYWU/lxmPh8iB9OlasCq
	+dgBwudnv/ir5gSLE/eqw8bggq4IY4RHzgVgka7N+gRAQEpuizVCZU3DoXnIGvJRda6sfj9x5rm
	BBAEtX4nRC6DrBKZgfsWCtSD/walY54l9n+3NPvJOI+MjJcDcfCBpzHBHvzkn0oMsSfYSZ0PWJt
	Ibm0CRCu8oAFE22LlpurOAG8hnxfWRDHOd2kYshcI=
X-Google-Smtp-Source: AGHT+IFLrYD5J37aa0mNOK3B75I/XOy07IbjSUvf1/RlxWmhgYC55jTWw72ygkcm6bXLdLD8Ohf8Ig==
X-Received: by 2002:a05:600c:8b58:b0:47a:975b:e3e6 with SMTP id 5b1f17b1804b1-47d84b34764mr146630855e9.18.1768164186936;
        Sun, 11 Jan 2026 12:43:06 -0800 (PST)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a3e3c3a204sm153389895ad.1.2026.01.11.12.43.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 11 Jan 2026 12:43:06 -0800 (PST)
Message-ID: <20c3ba51-fbf1-4de2-b88f-5edf817a24d6@suse.com>
Date: Mon, 12 Jan 2026 07:12:59 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] VirtualBox VM crashes (BSOD) during Windows
 installation on btrfs with kernels 6.18+ (works on 6.12 LTS)
To: jollycar <jollycar@proton.me>
Cc: "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
 "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <sT06uA3Gtv1kgeL80ZRMshbw6whJNUom-UxnS06H6eVrB4AqGWuzo0P23AhwOn3WsnAq9QfhFYciSAWK3eBeGaKjNJG1oSQLyclv4d2E0L4=@proton.me>
 <5b466d2f-80ad-4b45-a643-ab64bf2b252d@suse.com>
 <LCM3zm3y1s51pkWBZg6NU-4R6f89SVYSAxtNqq0gM5IlDFZfFjwSqvl-8yAvYcl7VizHjXIENm1vf6b7z2e25YQce7IQCr3Ms-w6vKkOKfY=@proton.me>
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
In-Reply-To: <LCM3zm3y1s51pkWBZg6NU-4R6f89SVYSAxtNqq0gM5IlDFZfFjwSqvl-8yAvYcl7VizHjXIENm1vf6b7z2e25YQce7IQCr3Ms-w6vKkOKfY=@proton.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2026/1/11 21:39, jollycar 写道:
> Storage configuration details:
> 
> Storage format: VDI (VirtualBox Disk Image)
> Storage location: /data/virtual-os/ (btrfs subvolume with COW disabled, verified with lsattr)

OK, this means it's not related to the direct IO changes in newer kernels.

When COW is disabled, data checksum is also disables, thus direct IO is 
still doing the true zero-copy behavior.

This ruled out the btrfs direct io change, but this means I have no clue 
what is going wrong at all now.

> Controller: IntelAhci (SATA)
> Default configuration: hostiocache on, mtype normal
> 
> Cache and media type testing on kernel 6.18.3:
> - Default (hostiocache on, mtype normal): BSOD within 1 minute during installation
> - mtype writethrough: Gets much further, BSOD occurs on first VM reboot
> - hostiocache off (mtype normal): Gets much further, BSOD occurs on first VM reboot
> 
> None of the configurations provide a working solution - they only delay the crash.
> 
> On kernel 6.12.63 with default settings (hostiocache on, mtype normal), Windows installation completes successfully without any crashes.
> 
> I have not yet tested with qemu/libvirt. Should I proceed with that test?

Yes please. Libvirt/qemu is a more common solution among developers.
If you can reproduce it using libvirt/qemu, more btrfs developers can 
try to reproduce it and look into it.

And if not, the cause may shift towards vbox other than btrfs.

Thanks,
Qu

> 
> 
> On Sunday, January 11th, 2026 at 10:15 AM, Qu Wenruo <wqu@suse.com> wrote:
> 
>>
>>
>>
>>
>> 在 2026/1/11 20:33, jollycar 写道:
>>
>>> #regzbot introduced: v6.12..v6.18
>>>
>>> [1.] One line summary of the problem:
>>> VirtualBox VM crashes with BSOD during Windows installation on kernels 6.18+ (works fine on 6.12 LTS)
>>>
>>> [2.] Full description of the problem:
>>> Windows 10 and Windows 11 installation inside VirtualBox consistently crashes with BSOD within 1-3 minutes on Linux kernels 6.18.3 and 6.19-rc3. The same VirtualBox configuration and VM image work perfectly on kernel 6.12 LTS. The BSOD errors vary each time (most recent: 0x80070470 - "file may be corrupt or missing"). The host system remains completely stable with no logged errors.
>>>
>>> [3] Kernel & Hardware:
>>> - Kernel versions tested:
>>> * Working: 6.12.63-1
>>> * Broken: 6.18.3-2, 6.19.0-rc3-1
>>> - Distribution: Manjaro Linux
>>> - Architecture: x86_64
>>> - VirtualBox: 7.2.4 r170995 (vboxdrv vermagic: 6.18.3-2-MANJARO SMP preempt mod_unload)
>>>
>>> [4.] Filesystem and storage:
>>> - Root filesystem: btrfs on LUKS encryption
>>> - Mount options: zstd compression level 3, SSD optimizations, async discard, free space tree
>>> - VM storage: separate btrfs subvolume
>>
>>
>> What's the storage file configuration? Like what's the cache mode setting?
>> I don't know VBox at all, but there may be something similar to
>> libvirt's cache mode (none/unsafe/writethrough etc).
>>
>> More importantly, will tweaking the cache mode change fix the broken
>> kernels?
>> If so it may point to direct IO related behavior changes.
>>
>>
>> And what's the storage file format? QCOW2? RAW? Or whatever format
>> provided by Vbox?
>>
>>
>> And one final question, have you tried qemu (or libvirt + qemu) and can
>> it still be reproduced with qemu?
>> As I'm wondering if the direct IO related change will even affects qemu
>>
>> Thanks,
>> Qu
>>
>>> - btrfs device stats: all zeros (no errors)
>>>
>>> [5.] Reproduction:
>>> - Boot kernel 6.18.3-2 or 6.19.0-rc3
>>> - Start VirtualBox 7.2.4 r170995
>>> - Create new Windows 10 or Windows 11 VM
>>> - Begin OS installation
>>> - BSOD occurs within 1-3 minutes with varying errors (latest: 0x80070470)
>>> - Issue is 100% reproducible on 6.18+, never occurs on 6.12
>>>
>>> Additional context:
>>> - Host system remains completely stable during VM crashes
>>> - No btrfs errors in dmesg or device stats (all zero)
>>> - Issue persists across multiple 6.18/6.19 releases over one month
>>> - VirtualBox 7.2.4 modules load successfully on all kernel versions
>>>
>>> Regards,
>>> Jollycar


