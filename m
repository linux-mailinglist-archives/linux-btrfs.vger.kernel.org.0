Return-Path: <linux-btrfs+bounces-16528-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A645B3C42C
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 Aug 2025 23:15:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 473351798D6
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 Aug 2025 21:15:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30A6F20013A;
	Fri, 29 Aug 2025 21:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="DGhmXIbW"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB49B200C2
	for <linux-btrfs@vger.kernel.org>; Fri, 29 Aug 2025 21:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756502124; cv=none; b=ZXXYCnSahlb8Ah2oJTuwrZvyCc50OumMkd96FMqsVRVSkW/YSKHtrByoRfOq/xybVqYea5at9Qm5lbCVWUJ44WxQviOym38mviC7OHNcBAJ46Eof/mqaf6Qdfxuxjk9Vep/RYyExnlk2VG/J/wE3tno4RNB5gboHbksycGc3zT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756502124; c=relaxed/simple;
	bh=vPveS00Nf4k58e4b12hxydW2PFatdIpXdkgDWfyi4IM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=nydBH25zcL/u6C8dSgFXSsPROrA3Ls2RcE91WNc3LQ94b5c7D9yXU1ZpEUOjglhrq5az/hzZhEPK0gedZPvbbOCh2wNBv9Bs+w9Z1Mwzfib2GtbfQHiRelGY5Iw+/KSNiF1C9G27NbYfUZbXZJNDEIBy7t8m7gcX/5t+6uzxHuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=DGhmXIbW; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-45a1b0cbbbaso21177265e9.3
        for <linux-btrfs@vger.kernel.org>; Fri, 29 Aug 2025 14:15:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1756502120; x=1757106920; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=T0IWB+VhHC6HJe8AYPBlCVwtNzceHydq/uZEVSiGz6k=;
        b=DGhmXIbWRtMx+9cBVUmfzjErp6zE//W7blRnWUzRa4bj9X3izDJv5keMNkeXQINTmG
         uLYa8lM9vBU0s0B0PBDQr6iSGnBW76zvzOupVZGzCZ+iPhFOhmL/NPdEVYF2FsxxOvuS
         UR+CRQs0CS4loQ54A4sRCCmZQihBVu1xova4zlZqPL9d3GYJkocVZuExL57mQ45RNj5r
         ql1tQV1i/DxRNgbBbo97XJpnNhfpqCR7usiKcEbxYuvmzCARughGNg1HBcyf/STQQYb7
         UYrs8j9qjzX5+wOR4hXnhN1N0R6ZhlxN3UukexMcwcIlKCtrXGeMNcbJLHo9Owk2IY68
         ZhPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756502120; x=1757106920;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T0IWB+VhHC6HJe8AYPBlCVwtNzceHydq/uZEVSiGz6k=;
        b=OsQPoyYfjxXxXe5we3YihTl8BEnRNz7iI3/xi+08YrksZR/gE1b4plqZrtUai+nBpS
         8lunp2mJAIlDpLl2QBo+qg0VKBXKaqYB2OVVpG2FID9nNwoX6DZbO7AW0UNB+iqFJn3Q
         GU6Oxphsz8LmR96xNA2b4DJ+UoRk0BkJhMMtIuicCZiZsZNvDxpKmrae0gHTVOQr8wCy
         gJOqOoCWclb8mxM6z6vZwN7nUF8U6ElUg+4ewREmt+6BTVcRtn51Vg4Belq5pympUYOb
         kE9MAL5vmpiJFoRDmTYPGBRUlRr5Hy4XyRbADqKg8TlwgV9wGP6+1z3vI0oTaHSbCTFZ
         PhFg==
X-Forwarded-Encrypted: i=1; AJvYcCUcRl+FqL9PMrQzgBJ5EQ5YUp0W9c6k84NpP+GWYwjQTSUnFgSgdsn02SCs6RpMfSQEWuGVYJrIKuA0rg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxsiJ5xKUHdPt8/MF6rXOcU2k2+ehj0b5IthPqi9xYSFoK3YvQy
	87zWYqLsiykb1ZlAv7cdb2RwLHJuXeVRBaW8Z9xsB1PnBOiMg+YgS8/hbl68JrB3ytbNrOv+IhL
	OoPsc
X-Gm-Gg: ASbGncvc4wbBz9w53wDELlhlWte/8Y5tFDf+84LUtrx+e/imXPzWk0ZitzmHLWgEwP2
	1KA1/vGxHe/6CSy/KrWJLX0wNXlPD/1EZWynQ03k11+rS4Q8Cfd5K1YgPyFYlGmfoMLnbeu0SML
	etD4ImOQzuCQixm+2vNfcFc7Kw+RVasNAZv1XEVkfmfo03yPQ2GkN4BbbzTjes4vp1AYX0ZPSHb
	a0Tr1yohOEvZbBo4hDjchtxzhTDSOJTEnDrpXriln8YCSUQXFMyUBACal9E6c/dNoZEZeA8e+Gi
	GEeCsmrucUyPpdwVQzrkV1qSjzTJCXMSqHv2rlL9tQv0OzRgSc9dm1hPjpjM5ui8sugjSkmwgJc
	rtdsciI67Sh7jq1If+zYU9SxMrsoT5Br2Y7G5u2NJ2xzjyiXwiAnAND+zzMbJHw==
X-Google-Smtp-Source: AGHT+IGiG2mATVXOGdRZhFEWgDMv3g3PAR2eLNtwRJH8bUz8fRpZ4wxltGm4txkRCb7I9A+y50s2cw==
X-Received: by 2002:a05:6000:178d:b0:3b7:925b:571d with SMTP id ffacd0b85a97d-3d1dd146e12mr28282f8f.26.1756502119898;
        Fri, 29 Aug 2025 14:15:19 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-249066e0326sm33879625ad.143.2025.08.29.14.15.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Aug 2025 14:15:19 -0700 (PDT)
Message-ID: <a48ac216-38f1-4a69-970e-f2ddee2ae8f2@suse.com>
Date: Sat, 30 Aug 2025 06:45:15 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Mysterious disappearing corruption and how to diagnose
To: Andy Smith <andy@strugglers.net>, linux-btrfs@vger.kernel.org
References: <aLIRfvDUohR/2mnv@mail.bitfolk.com>
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
In-Reply-To: <aLIRfvDUohR/2mnv@mail.bitfolk.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/8/30 06:15, Andy Smith 写道:
> Hi,
> 
> I have a btrfs filesystem with 7 devices. Needing a little more
> capacity, I decided to replace two of the smaller devices with larger
> ones. I ordered two identical 4TB SSDs and used a "btrfs replace …" for
> the first and then a "btrfs device remove …" plus "btrfs device add …"
> for the second to get them both in there.
> 
> After the second of the new SSDs was added in I started receiving logs
> about corruption on the newest added device (sdh):


Is this during dev replace/add/remove?
Would it be possible to provide more context/full dmesg for the incident?

And what's the raid profile?

> 2025-08-25T04:52:36.719565+00:00 strangebrew kernel: [15861945.864876] BTRFS error (device sdh): bad tree block start, mirror 1 want 18526171987968 have 0
> 2025-08-25T04:52:36.719578+00:00 strangebrew kernel: [15861945.867728] BTRFS info (device sdh): read error corrected: ino 0 off 18526171987968 (dev /dev/sdh sector 238168896)
> 2025-08-25T05:44:42.139479+00:00 strangebrew kernel: [15865071.325433] BTRFS error (device sdh): bad tree block start, mirror 1 want 18526179364864 have 0

This mostly means the metadata is not there (all zero), thus btrfs went 
with other good copy and re-write the good one back.

> 2025-08-25T05:44:42.139493+00:00 strangebrew kernel: [15865071.328345] BTRFS info (device sdh): read error corrected: ino 0 off 18526179364864 (dev /dev/sdh sector 238183304)
> 
> These messages were seen 19,207 times with sector numbers ranging from
> 2093128 to 556538024.
> 
> Upon seeing this I did a "btrfs device remove …" for sdh, shuffled
> things about so I could attach an extra device, added back one of the
> older SSDs and used "btrfs device add" to add that one back in. So at
> this point the filesystem still has 7 devices, sdh is still in the
> machine but not part of the filesystem and the filesystem just has
> slightly less capacity than it could have.
> 
> I did a scrub of the filesystem. This came back clean, as expected (all
> of the error logs said errors were corrected).
> 
> A "long" SMART self-test of sdh came back clean, which wasn't surprising
> because at no point has there been an actual I/O error, only notices of
> corruption.
> 
> I put an ext4 filesystem on sdh, mounted it and did a run of stress-ng:
> 
> $ sudo stress-ng --hdd 32 \
>    --hdd-opts wr-seq,rd-rnd \
>    --hdd-write-size 8k \
>    --hdd-bytes 30g \
>    --temp-path /mnt/stress --verify -t 6h
> 
> After more than an hour this hadn't detected a single problem so I
> aborted it.
> 
> I put a btrfs filesystem on sdh and did stress-ng again. No issues
> reported.
> 
> As mentioned, this was a pair of new SSDs and the other one is already
> part of the filesystem and not giving me any cause for concern. They are
> Crucial model CT4000BX500SSD1 (4TB SATA SSD).
> 
> It may be difficult to get a replacement or refund if I can't
> reproduce broken behaviour.

So I believe this is related to certain raid profile handling.

And I hope it's not RAID56. As it's known to have write hole problems.

> 
> The shuffling of devices that I had to do can only be temporary, so I
> need to decide what I am going to do. The smaller device I had intended
> to remove (but now had to add back in for capacity reasons) is 1.7T and
> is currently /dev/sdg. I could "btrfs replace /dev/sdg /dev/sdh …" and
> assuming no errors seen do a scrub, but if errors were seen I'd want to
> remove sdh again quickly. replace then wouldn't be an option since sdg
> is smaller than sdh. "btrfs remove sdh …" takes a really long time.
> 
> Maybe I should make a partition on sdh that is only 1.7T of the device
> and replace that in, so I could still replace it out if errors are seen?
> Though if it behaves I am then going to want to replace it out anyway in
> order to replace the full device back in!
> 
> Basically I'm totally confused as to how this device was misbehaving
> but now apparently isn't. I had thought just maybe it could be the slot
> on the backplane that had gone bad but it's still in that slot and I
> can't reproduce the problem now.
> 
> Any ideas?
> 
> Debian 12, kernel 6.1.0-38-amd64, btrfs-progs v6.2 (all from Debian
> packages).

And the kernel version is not that ideal, it's still supported and 
receiving backports, but I'm not really sure how many big 
refactor/rework/fixes are missing on that LTS kernel.

Thanks,
Qu

> 
> Thanks,
> Andy
> 


