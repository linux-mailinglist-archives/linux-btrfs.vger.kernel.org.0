Return-Path: <linux-btrfs+bounces-10584-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B69AE9F6EC3
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Dec 2024 21:13:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86DF61884BAC
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Dec 2024 20:13:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B389B1FC0FF;
	Wed, 18 Dec 2024 20:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="c3qBfZTV"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81D9A158520
	for <linux-btrfs@vger.kernel.org>; Wed, 18 Dec 2024 20:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734552827; cv=none; b=LlPQZHLjYs9Hf5qW4772qz4zjGcLgQh4khUuXzKznuaUFPLp+rFonVE+4PI9y/ZVmOIWg3LoBFy6hdb4VKRoOXDCc5g9QZxhYX1xISLriKis66jkyzDiRcAVUixRb220HRLfLY++W0AnS+0fZwNvAfdANvOCvuIx4vDzRQI9+vA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734552827; c=relaxed/simple;
	bh=18zlWux7TZ05eSDLQ/OcyNEbMZgVTMfbuAxEpqctPvo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rqxLU1bYmixhPkY9EoT4v+PmXUrEm3DRQScyFVZKlnKIC1F26YHi5qQJRMzANi32DIem9cCXI/EfqxTo7xknxB7cqLsOzqXZWNq+LLAnvxJ1ig5KPVBhhzyUcd0RAJDIDh8qN2R97mf8Jz5d5sfD3MjT0iOkyWokmYTUygWsYZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=c3qBfZTV; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-388cae9eb9fso43751f8f.3
        for <linux-btrfs@vger.kernel.org>; Wed, 18 Dec 2024 12:13:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1734552824; x=1735157624; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=KlnERgTQTnp9GQRwEn36PTJNVywfM83QEB836WRSVRU=;
        b=c3qBfZTVu7BkVJHM7t1OtimdEgqi5r/fTvkRJA2b1EX3DvDaplRCtDsLIx9c/mTbiD
         SpKHH6ibmEsx63X6tZ/dNNxc0RQhiy4vbilZ1qFINyTt+Oj+3iOrqXa7+IEt86QZwLW/
         /19Ih24cCzaaHrCPsSsONugbyQnu/LUgPMGZta1jit2tJLuwPaw81YyidCLRl/pifOwS
         MytRmENyZsUA+G9b0ALiRYXiy8R35gYzzjyn9gJKW4FM0t7qJ97VDSg/fOAjPiT0Y8Or
         qSOrpl504eDfeJmWWuOXbOU76LfVwjYTNC+4oO9CBu4aZ/SiU81ryB8eQhD2lHRC4Tbd
         lSZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734552824; x=1735157624;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KlnERgTQTnp9GQRwEn36PTJNVywfM83QEB836WRSVRU=;
        b=shE6T3kU40sQTNyT1MpOlN6xvk2JQAM/9yh0RCHNn0jvzG+38TMnBBwhB5DxN8A379
         IumbOmXrnRBK0JbvVnJ7zC/6Ivp0Ne1bFFaXtWp/FTv/OqiF47nlv0oXy1qRg4h58NBT
         F7TIKGi2zOVGFp63DzuHe6MJ7cUiqyy6QprMX8+xs1g8LSLOLxtOov3555nopMa318MV
         vr7HRQVq+1YyADodPdJIVarQse7URGdMDcMSX8chHJcZg8LAK9QnlVm0YFbSczILe/QD
         RWt0JYiuoCUU1iqeQ05Yi6/beBdpZLnW+3/Q/blZzliNCUmFXnRFRJKxpOkgF540dSma
         qtRw==
X-Gm-Message-State: AOJu0YwxrDDcEQ+8Eo9ooO3e2a7SB9GOwqzF5IV9gUPKGejbpGWVaF1j
	NUze3rbenrR0G8Ctx0gWKYuaD9wZ06POzVgjwExWnkd5jsW6r6NZVkwHv4bRxeI=
X-Gm-Gg: ASbGnctpxSucs08IdXwiHsp1i3WOaBAHzkHf3VMu6qSj43DGg4at3CF33VW3/inUdR9
	tbFAKn/olqv0eYEDJAJL6wok8omJJ+uLxcJp/zHXYhuIsVdQx8tLqRoCRQM8bJLUltg4D5B6h73
	Uf+2jqILnJbnyAF0MbHdxC8fCdNB0k7iVprOY83NEUm1c11thOFd+f6iRjb360dnqMZ3DoDovtB
	cWGSV1Qdua1u0jnOjbFDr8BrkNH4seEBRbQ6BLj5yF4IhV7ZXG9FhJzlls7rTpYShocCrnxweCS
	kbVPLIR4
X-Google-Smtp-Source: AGHT+IGn5oJTe14YSPt5kcskFPh8BDJLZxAtjIF11JVDnWsknLrXWMn0ZiQM0dKyGeQsvkLXFCvCcA==
X-Received: by 2002:a5d:64e9:0:b0:386:2bac:139 with SMTP id ffacd0b85a97d-38a19b4890fmr936699f8f.54.1734552823452;
        Wed, 18 Dec 2024 12:13:43 -0800 (PST)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-218a1dcc486sm79857475ad.67.2024.12.18.12.13.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Dec 2024 12:13:42 -0800 (PST)
Message-ID: <73f9e7d0-9954-4507-a48a-2759cf3a2f2f@suse.com>
Date: Thu, 19 Dec 2024 06:43:38 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/18] btrfs: migrate to "block size" to describe the
To: dsterba@suse.cz
Cc: linux-btrfs@vger.kernel.org
References: <cover.1734514696.git.wqu@suse.com>
 <20241218183155.GE31418@twin.jikos.cz>
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
In-Reply-To: <20241218183155.GE31418@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/12/19 05:01, David Sterba 写道:
> On Wed, Dec 18, 2024 at 08:11:16PM +1030, Qu Wenruo wrote:
>> [IMPEMENTATION]
>> To reduce the confusion, this patchset will do such a huge migration in
>> different steps:
> 
> With some many changes everywhere this is going to make backports even
> more tedious. I think it would be best to do the conversion gradually or
> selectively to code that does not change so often. As you've split it to
> files we can first pick a few obvious ones (like file-item.c) or gather
> stats from stable.git.

For the backports, we can put the btrfs_fs_info union to older kernels 
and call it a day without the remaining part.

So that both newer and older terminology can co-exist without any conflicts.

Although backport conflicts will still happen in the context.

> 
> A quick and rough estimate for all 6.x.y releases counting file
> backports in the individual patches in the list below. This is period of
> 2 years, 104 weeks (roughly matching number of releases). So if there
> are 88 patches touching inode.c that's quite likely a conflict in every
> backport.
> 
> This should be also correlated agains number of 'sectorsize' per file,
> so it many not be that bad, for example in ioctl.c there are only 4
> occurences so that's fine. The point is we can't do the renames without
> some sensibility and respect to backports.

But at least, when a backport fails, we can easily fix the conflict.
It will always be sectorsize -> blocksize, either in the context or the 
modified lines.

Thanks,
Qu
> 
>       88 inode.c
>       62 disk-io.c
>       61 volumes.c
>       57 extent_io.c
>       57 block-group.c
>       56 ioctl.c
>       52 extent-tree.c
>       49 zoned.c
>       49 qgroup.c
>       37 send.c
>       36 super.c
>       33 ctree.c
>       30 transaction.c
>       29 file.c
>       28 tree-log.c
>       28 free-space-cache.c
>       26 scrub.c
>       24 ctree.h
>       22 relocation.c
>       19 delayed-inode.c
>       17 tree-checker.c
>       17 backref.c
>       15 space-info.c
>       14 extent_map.c
>       12 free-space-tree.c
>       12 disk-io.h
>       11 block-group.h
>       11 bio.c
>       10 ordered-data.c
>       10 block-rsv.c
>        9 ref-verify.c
>        9 file-item.c
>        9 btrfs_inode.h
>        8 include/uapi/linux/btrfs.h
>        8 fs.h
>        8 delayed-ref.c
>        8 delalloc-space.c
>        7 root-tree.c
>        7 print-tree.c
>        7 dir-item.c
>        7 dev-replace.c
>        7 block-rsv.h
>        6 sysfs.c
>        6 extent_io.h
>        6 defrag.c
>        6 compression.c
>        5 volumes.h
>        5 transaction.h
>        5 qgroup.h
>        5 export.c
>        4 zoned.h
>        4 space-info.h
>        4 reflink.c
>        4 inode-item.c
>        4 include/trace/events/btrfs.h
>        4 discard.c
>        4 delayed-ref.h
>        3 tree-log.h
>        3 tree-defrag.c
>        3 subpage.c
>        3 raid56.c
>        3 free-space-tree.h
>        3 extent-io-tree.c
>        3 extent-io-tests.c
>        3 backref.h
>        2 zlib.c
>        2 xattr.c
>        2 uuid-tree.c
>        2 tree-mod-log.c
>        2 tests/inode-tests.c
>        2 tests/extent-map-tests.c
>        2 tests/extent-buffer-tests.c
>        2 root-tree.h
>        2 relocation.h
>        2 rcu-string.h
>        2 qgroup-tests.c
>        2 lzo.c
>        2 locking.c
>        2 inode-item.h
>        2 free-space-cache.h
>        2 extent-tree.h
>        2 delayed-inode.h
>        1 tree-checker.h
>        1 tests/free-space-tree-tests.c
>        1 sysfs.h
>        1 props.c
>        1 ordered-data.h
>        1 messages.h
>        1 messages.c
>        1 include/uapi/linux/btrfs_tree.h
>        1 fs.c
>        1 file-item.h
>        1 extent_map.h
>        1 export.h
>        1 compression.h
>        1 btrfs-tests.c
>        1 btrfs.h
>        1 bio.h


