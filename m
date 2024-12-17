Return-Path: <linux-btrfs+bounces-10449-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D25D29F432B
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Dec 2024 06:50:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2F63188DACF
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Dec 2024 05:50:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 859F015624D;
	Tue, 17 Dec 2024 05:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="dti91PRG"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73C2514A60C
	for <linux-btrfs@vger.kernel.org>; Tue, 17 Dec 2024 05:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734414621; cv=none; b=BKmV0+OKeRU0kF6Qn0d3E7gciEgYIiT27cNqopWaHo7CTKLlDuoCdBdkSdF4PCw9yzwU2P6XTIYBcaryB8+FdI/1uhjILiMrSEv02Rn6FICtgaao2SUCDgYvppbZ9QnMCOPEgePGABNXnL5mQ2N3ErzMl6b+69809XmZAnFui6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734414621; c=relaxed/simple;
	bh=X/zMYM+yUjhC/t8luTsrZZihGTVcWfrO4uXyrRjlBzk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e7pQcAErFjMHDbNVK+Se0fPF0ubA+BqMslYkpfse7yB8ntIg1YNrVTkJgCtEryUdGmmNN5fXtBXXDK3e5BiESB+oz02KQ78qCezHJviFlJ1abAqYqgpUWKiI+/OCsIdqG2E1GZDUNUom8hSz/brgzOo3f548knDK3z1k0ZkgJNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=dti91PRG; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-38632b8ae71so3615770f8f.0
        for <linux-btrfs@vger.kernel.org>; Mon, 16 Dec 2024 21:50:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1734414618; x=1735019418; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=B0nuXgUysFMRvOby+t8tb7xVBSc7Gd+mLg6MM03P6Ww=;
        b=dti91PRGB522esWVQVj9rPvzX8NDKcY8aKtsK9O95/cU1qe4o3EcJRfZv3sozcYyRk
         73GFFY00Fs7q23eI5MMmpiyvVmgkBNycK2e4pNA63CBv9MRIhDBorUs7+TmfTl7IbQ99
         +x54AyxsxRZbFR3pvgmBT4W4xeC+zDj783U6vFalWmXehvMZTOz2fGiAieiKcXkF+5Ni
         8nI2zV+WgMSl1iSGYCmir1QZ2T16AYs3FxYRpn3LTKYQmNXw0VslDufC80IfWXFP0CmM
         m3uj0J/cmf5113AIh+SaV0JBqGu7ZanL2fyf7yLSQf2XHmpREViTZqPY34C3LoSzlZRi
         ++Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734414618; x=1735019418;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B0nuXgUysFMRvOby+t8tb7xVBSc7Gd+mLg6MM03P6Ww=;
        b=aMse+nEiS/BJHPO7ZYSDnUOcz54Kq8QnAVLWSH41N6PI5JH/UUOlcg7SOKjVuZ4KXw
         YCbakAdqYD1heKm2ZdSCKR/NJiJEchyL7PUOZL2Rr0JNHC4YotGO1AJDU8TuXayWcP1k
         VjPyqMGGmIFPtMZRI4Al+wGg3mHngJwouojcALkmHe0z9//hWm92KWlUhUc7jW28ymB7
         lKjkxGnaPKWASa3rkmaJN3zSpjqPHRQ/WAKspHqgTghDYDsa5pFuOWh26sIQ+yZfsbTs
         Qn5o5W0U4btWyC/DZ1ZE6SYt6qZN5n7fTcCWgHaedq7yZ/WXEJ954oFRm8IfmHYWiKh+
         emtQ==
X-Gm-Message-State: AOJu0YwrCBEcBChBsuj7KtzW0nS1lWWas+PMs6W+44oWqI4rTqC7zYHI
	UoEIQZtfHIDg8j5nsxgRjv2yzfD7qq8/vFt/dFKg5hYQGBSGH98Zx87CwV/a0AmSV+JFvzA6eXd
	0
X-Gm-Gg: ASbGnctw+etwUflfOxImhoVays810tcHh1Ci/O8Wmq/sOHCt0y9VB8W7eYYHBulmsFd
	0oggCdYJk6dPgZve1lPWNdrGt+bMGBR/2MBZe7X2GGAIyb6FybFnm+mVWy39FXzVwyz6HJfTH29
	xenck+SJmhbZnKllJZRoVElvAjWaB9KWwpWWq1Suonc301Q+kgvLjJ/hjtaKCxgyg1tZrjqUSop
	4FJxXXxRH2X0IALzLsL/CmcJTFMg61c/t2Pd95500vXfO4mVLo78OzaSuF+G0LWJobJt6P52p6y
	wxNyobdK
X-Google-Smtp-Source: AGHT+IH6KwkjZNpjw90PGza8rRuAH1uVm1qCMDHE46CgsdxNs2Uz4i6OjQxYuYIaMKBQkhmGBVi4xw==
X-Received: by 2002:adf:ae51:0:b0:388:da2a:12fa with SMTP id ffacd0b85a97d-388da2a1312mr1379108f8f.52.1734414617263;
        Mon, 16 Dec 2024 21:50:17 -0800 (PST)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72918ac7789sm5764728b3a.12.2024.12.16.21.50.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Dec 2024 21:50:16 -0800 (PST)
Message-ID: <2e3d5a0b-4cc5-48e7-80a6-7cc5454d54e3@suse.com>
Date: Tue, 17 Dec 2024 16:20:12 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: clear space cache v1 fails with Unable to find block group for 0
To: j4nn <j4nn.xda@gmail.com>, Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: linux-btrfs@vger.kernel.org
References: <CADhu7iD1LOT=93o1DhFYBeDHTKW9SuYdSmz8VXvsE4vf285tDg@mail.gmail.com>
 <c5ec9e5e-9113-490d-84c3-82ded6baa793@gmx.com>
 <CADhu7iBFDmRvBwWxxa4KszyZpyTq5JetB+a13jxGj4YBjaYWKQ@mail.gmail.com>
 <561aab35-007d-48d5-bf61-8cfc159cba28@gmx.com>
 <CADhu7iCYRjcQ2kHWqvaZYTnwVUY-qFaBSaDyZA_OL2MEpr6EYg@mail.gmail.com>
 <61140354-83ce-43cb-8bb6-fc7b5ecaa1f1@gmx.com>
 <CADhu7iBR-i9bOHRDN-adtWkoF8R9v=kvFhAySV_Fbfk_v8iFXg@mail.gmail.com>
 <CADhu7iBQf_vE3hSoDH7L=eCPzq9LZQyr1R8xDhF-OEXHENkD1w@mail.gmail.com>
 <CADhu7iD+kKsvxZtnX9q94tuJzS6z=zs3B7Xc9Bb4G+mnQ6_UhQ@mail.gmail.com>
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
In-Reply-To: <CADhu7iD+kKsvxZtnX9q94tuJzS6z=zs3B7Xc9Bb4G+mnQ6_UhQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/12/17 16:01, j4nn 写道:
> On Mon, 16 Dec 2024 at 19:52, j4nn <j4nn.xda@gmail.com> wrote:
>>
>> This is unrelated, but as you have been interested in the hung task
>> backtrace, I got two more when using "btrfs send ... | btrfs receive
>> ..." to copy 7TB of data from one btrfs disk to another one (still in
>> progress, both rotational hard drives):
>> [81837.347137] INFO: task btrfs-transacti:29385 blocked for more than
>> 122 seconds.
>> [81837.347144]       Tainted: G        W  O       6.12.3-gentoo-x86_64 #1
>> [81837.347147] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
>> disables this message.
>> [81837.347149] task:btrfs-transacti state:D stack:0     pid:29385
>> tgid:29385 ppid:2      flags:0x00004000
>> [81837.347154] Call Trace:
>> [81837.347156]  <TASK>
>> [81837.347161]  __schedule+0x3f0/0xbd0
>> [81837.347170]  schedule+0x27/0xf0
>> [81837.347174]  io_schedule+0x46/0x70
>> [81837.347177]  folio_wait_bit_common+0x123/0x340
>> [81837.347184]  ? __pfx_wake_page_function+0x10/0x10
>> [81837.347189]  folio_wait_writeback+0x2b/0x80
>> [81837.347193]  __filemap_fdatawait_range+0x7d/0xd0
>> [81837.347201]  filemap_fdatawait_range+0x12/0x20
>> [81837.347206]  __btrfs_wait_marked_extents.isra.0+0xb8/0xf0 [btrfs]

This is from the metadata writeback.

My guess is, since you're transfering a lot of data, the metadata also 
go very large very fast.

And the default commit interval is 30s, and considering your hardware, 
your hardware memory may also be pretty large (at least 32G I believe?).

That means we can have several giga bytes of metadata waiting to be 
written back.

What makes things worse may be the fact that, metadata writeback 
nowadays are always in nodesize, no merging at all.

Furthermore since your storage device is HDD, the low IOPS performance 
is making it even worse.


Combining all those things together, we're writing several giga bytes of 
metadata, all in 16K nodesize no merging, resulting a very bad write 
performance on rotating disks...

IIRC there are some ways to limit how many bytes can be utilized by page 
cache (btrfs metadata is also utilizing page cache), thus it may improve 
the situation by not writing too much metadata in one go.

[...]
> 
> The destination btrfs filesystem has been freshly created (single
> device, no raid) and thus empty before starting the transfer.
> This is output of destination 'btrfs filesystem df' after the transfer:
> Data, single: total=7.10TiB, used=7.06TiB
> System, DUP: total=8.00MiB, used=768.00KiB
> Metadata, DUP: total=8.00GiB, used=7.53GiB
> GlobalReserve, single: total=512.00MiB, used=0.00B
> 
> The btrfs is on a luks device (cryptsetup -h sha512 -c aes-xts-plain64
> -s 256), but cpu has been idle the whole time (ryzen 5950x).


Considering the transfer finished, and you can unmount the fs, it should 
really be a false alert, mind to share how large your RAM is?
32G or even 64G?

Thanks,
Qu
> 
> Hope that helps.
> Thank you.
> 


