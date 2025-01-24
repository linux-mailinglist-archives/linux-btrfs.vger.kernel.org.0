Return-Path: <linux-btrfs+bounces-11054-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5682BA1B08C
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Jan 2025 07:57:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24FAC188B838
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Jan 2025 06:57:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2571B1DA2F6;
	Fri, 24 Jan 2025 06:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="AI0lT2Tw"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ej1-f67.google.com (mail-ej1-f67.google.com [209.85.218.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 931301D63DF
	for <linux-btrfs@vger.kernel.org>; Fri, 24 Jan 2025 06:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737701866; cv=none; b=eCmFemCCwb6GnzQpPCz7kZEfsWiALFNya6yvkdmxMxeFOk8x04UX/6L1S2ratacELwxYhcveRdI/bedqEGodshmh88Z83Z8O8FyeefTZTFKSnKOo5/LdwDsxAVGaI+BC8kLDvsyAfKDJ0XqFXEnGhUTL6Hy1G2B4NC5q6Q/fzEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737701866; c=relaxed/simple;
	bh=PgcRxBEr+KrPV1JpgiAsh/2jn6AqAOoGwKIj3gZFXQ0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=caqh+tZnJ89MenrCMDj++zOw+PtPKSYV9pubp/tz3pVYV/ZY+1uYk/WMFE3Otlxlq8r15PnYFfuXxGfHx7gXBn3QFx8u2/d1Ugy4lE2mWMD9LlPq+tZCnkDNWIv38qk6YcJG9fu/55jt9CJTvtLnsGvNeyfwonUY1uYVJfQUxK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=AI0lT2Tw; arc=none smtp.client-ip=209.85.218.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f67.google.com with SMTP id a640c23a62f3a-aa684b6d9c7so314482266b.2
        for <linux-btrfs@vger.kernel.org>; Thu, 23 Jan 2025 22:57:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1737701862; x=1738306662; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=SubiPuTWupgqLLZV6rbyBfVK1lGJu2yxKy9+6k+f0VQ=;
        b=AI0lT2TwI+dfh9uW/D+Ml0sC2QyA5aJGLyymlwUhro1nvTtJ9eNGDzP9Idq9mL9tZm
         Pcqd7twTumDZ2JI4kojnyNr/9a5FxLANAz+OT3/UT+FVBazxID8kzDyNMFgi2VzE1bAU
         BH5HCexSCKbb3scR9Bibdo2AM8ayA+VVVqjGRwqN9P2AQaW3Od7723yk5WqleH1MyPM2
         UI89IIq9wE73/fgNKC0kQqw7NURk9Kkqz+s0IGgYQMgEHBP0UCzt1nN1pMJfq+mUxX3H
         yu4Nr5TmTju7gyS4K15MfQhriwJ7jqjMJOpzfDt1+PyhN1NR8D9ftE430DSHQIp03HzC
         OC/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737701862; x=1738306662;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SubiPuTWupgqLLZV6rbyBfVK1lGJu2yxKy9+6k+f0VQ=;
        b=jPMq7Z0JPGvhfEPISTt7cdnwUkYz/OPDv0fXGngxgTSbdsAPHccbIlUjKSLanbrzVi
         g5WLXyKDvzVjZrqEc68BaelzZWlOfC0CpIVhKRhmuEGcLCqVCbbsVUnfxuS9xL7ZnUcg
         yCWQEUjobM7PHSBGmYMrcDF8/nBkitqUJVVOHt3S5EPkqcsWEjliP/0VBrZix9opw6yB
         Jmx+AVQq9jIjUtkJBLsYGMdUhlS+z249RDGjasep55qJTaN22nIplYKKMgjwa1xc+mQs
         e2T8DAdoKeI9a7PJBmgSViSfeFjjFe8hG40tNQBx+KlWBT8ZZxTTbRt5WO6PLmeX6CAU
         p2CQ==
X-Forwarded-Encrypted: i=1; AJvYcCX1tU0Kg7kr+8wph9lYJNB4faKbCeUp+i19JTp+chVY6MbI/0M2rmcSVQGG5Wbfg0hxgDmklFTXEasexg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwSpIPZ8qaEFK0dQxFktOHkgX+GV6azCfUBRgP8nil4ygWO3EC9
	yLzXK4lvbWhTsQdWEvYP9JuNG+lHzNmcIAWFhXsLuR4BkHIsLQkGtcgM2poduBnPbnGql5+bzX6
	3ka+pdQ==
X-Gm-Gg: ASbGnctTmUjfMgmFvbdmkT+yUnTTstJKSz4W6MKqGZw7glAYniutohmDkgDRxRgisLp
	2fN2T8KBlGvC2OlL0LcYE3bfU0rbEuL2yOJdniqEjOV2ePNmH0rG/EeSQqLe+dSFjekxnxG0u0x
	RgqoYM/PaLf6kCamIYiQriNzYnh4Ar2YjWn3WA09rC6TtOwsM6072sxjzN8E50Dbjn4kmyeXyb/
	iboXfZh19TNbhrOzZcl3emQ4U1l5zNBSlckIhRAbSYe0z+fIFwBEdpKAYGRmdNHBWIM0zGBZ+Bo
	eHMKXpCPC5h9zDeeHz7SS4X1KtMk3dPg
X-Google-Smtp-Source: AGHT+IHdkXDf3rchSxQlPxkbr5AXpk+7Q+wQO51oC7bsf1Ine483AVRHxsoH8djEjmAvQGkVfxbGdg==
X-Received: by 2002:a17:906:2cc4:b0:ab3:a3b4:f91c with SMTP id a640c23a62f3a-ab3a3b4f9b3mr2028644766b.34.1737701861366;
        Thu, 23 Jan 2025 22:57:41 -0800 (PST)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f7ffb194c0sm878320a91.43.2025.01.23.22.57.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jan 2025 22:57:40 -0800 (PST)
Message-ID: <d6142943-8db9-4569-8228-f0c09b65298f@suse.com>
Date: Fri, 24 Jan 2025 17:27:36 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Tree checker pre-write check finds corrupt leaf. drives now empty
To: =?UTF-8?Q?T=C3=A9o_Adams?= <ta@hexagon.cx>,
 "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <rvOGZGZ2KKMe7x59is0hpo4PXWgjMZ9wuj4H3byWhiAZnJfWC2OHOQ4b7LYuvlBKVz9giNM_qjh9TZaq0Aa7mcqa9uNF6fxdEeqnbLQ_tP0=@hexagon.cx>
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
In-Reply-To: <rvOGZGZ2KKMe7x59is0hpo4PXWgjMZ9wuj4H3byWhiAZnJfWC2OHOQ4b7LYuvlBKVz9giNM_qjh9TZaq0Aa7mcqa9uNF6fxdEeqnbLQ_tP0=@hexagon.cx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/1/24 12:56, Téo Adams 写道:
> Hello,
> 
> I just read on your https://btrfs.readthedocs.io/en/latest/Tree-checker.html page that you'd benefit from reports of corruption caught by tree checker. Obviously it would be great if you have advice on how to recover from my current situation, or avoid it in the future but regardless I hope the data I can provide will be helpful too you.
> 
> For context, possibly too much, I am running NixOS on a system with 3 different drives, all of which use BTRFS.
> Drive 1 (nvme) has two partitions: ESP for boot and a luks partition with 3 subvolumes that house /root, /nix (where the OS lives) and /home
> Drive 2 (nvme) has a single luks partition and subvol used for storing large media. It is not used very often.
> Drive 3 (ssd) has a single luks partition and subvol that houses my qemu vm images.
> 
> When the incident occurred I had a single VM running via libvirt and had the usual assortment of multiple terminals, neovim instances (all files being edited are on Drive 1), and browser windows. The only thing "using" Drive 3 was the libvirt and nothing was using Drive 2.
> 
> While attempting to write a neovim buffer I got an error about a database I don't recognize being read-only, my system began to stutter, and I noticed in a btop monitor that my RAM was pinned. While closing anything I didn't need and trying to save my work, my WM (hyprland/wayland) froze for about 20 seconds but recovered. from there the system was very unresponsive, I could change windows but couldn't kill anything. Eventually I had to reboot.
> 
> Later on I went to spin up the VM but it complained that the VM didn't exist. on further investigation I discovered that both Drive 2 and Drive 3 are completely empty. They are both unlocked (which is automated using a secondary unlock key used shortly after Drive 1 is unlocked), mounted, and I can cd into them but there is no content at all.

If it's write time tree-checker as described by the title, please run a 
memtest first, as that's the most common reason.

I do not think the incident is directly linked to the lost of files.
Unless the fs is already corrupted.

Especially for drive 2, since you're not touching it frequently, it 
needs a lot of work to delete those many files.

The same for drive 3.

Mind to check if the free/available space for drive 2/3?
Are they really empty or it's still taking space?

> 
> I'm completely at a loss to how this may have happened.  The clue that led me to this email came from the following kernel message in logs that occurred around the same time.
> 
> 
> Jan 22 19:03:10 ghost kernel: BTRFS critical (device dm-0): corrupt leaf: root=258 block=67236839424 slot=43, bad key order, prev (18446744073709551611 48 42564423) current (184467440737095>
> Jan 22 19:03:10 ghost kernel: BTRFS info (device dm-0): leaf 67236839424 gen 313844 total ptrs 77 free space 11791 owner 258
> Jan 22 19:03:10 ghost kernel:         item 0 key (42725548 108 0) itemoff 15251 itemsize 1032
> Jan 22 19:03:10 ghost kernel:                 inline extent data size 1011
> Jan 22 19:03:10 ghost kernel:         item 1 key (42725554 1 0) itemoff 15091 itemsize 160
> Jan 22 19:03:10 ghost kernel:                 inode generation 313844 size 23509 mode 100600
> Jan 22 19:03:10 ghost kernel:         item 2 key (42725554 12 75511) itemoff 15041 itemsize 50
> Jan 22 19:03:10 ghost kernel:         item 3 key (42725554 108 0) itemoff 14988 itemsize 53
> Jan 22 19:03:10 ghost kernel:                 extent data disk bytenr 5280100352 nr 8192
> Jan 22 19:03:10 ghost kernel:                 extent data offset 0 nr 24576 ram 24576

Full dmesg please.

The important leaf dump is long, and the digest is definitely not enough 
for us to figure out what's going wrong.

Thanks,
Qu
> 
> 
> Fortunately I do have backups of most of the content that is missing from the drives.
> If there's any additional info I can provide, please let me know.|
> 
> Kind regards,
> Teo
> 
> 
> 
> Sent with Proton Mail secure email.


