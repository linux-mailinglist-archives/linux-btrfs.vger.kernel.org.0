Return-Path: <linux-btrfs+bounces-14637-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B97F7AD834B
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Jun 2025 08:43:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2FE537AD917
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Jun 2025 06:41:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1A5823183A;
	Fri, 13 Jun 2025 06:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="BJN9fGRL"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88A971B95B
	for <linux-btrfs@vger.kernel.org>; Fri, 13 Jun 2025 06:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749796973; cv=none; b=d6daNck8SYxW2Axj3lM5UZifL6iWHJDkPNafDJvzOmWY8+1rQybrFV7Ii/C1Jr39Zj2ABQKAZ3AI8HlOb805ztEO11g6R5qrLvRCoRYFgIixg4fTeF7FNy6HB1LMBM4IvThrGs73iPEHSxrkkH+6ABO7DE6hwhZ9SjNQawfnAOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749796973; c=relaxed/simple;
	bh=Raz6Z9n9C9XqqmCmJ81jUHUQgsTzXTP/R1l9cfjqypY=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:References:
	 From:In-Reply-To; b=f71/2C9oc7w4L+X2u7DOc+0vR5uMnfPrd5CMhdWXQLAavwFDG2AYbaOoXi7ZuR4fNS3b6jhvMBO5IFck8NzyHEH5ifSHI9FvMlERd/74UUpHfYJZI/Oir7Yur5BtfdPiKliQx0/voNEV9yQvVZpymi53fzpPa9B6A748X4V7CUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=BJN9fGRL; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-450d668c2a1so20108285e9.0
        for <linux-btrfs@vger.kernel.org>; Thu, 12 Jun 2025 23:42:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1749796969; x=1750401769; darn=vger.kernel.org;
        h=in-reply-to:autocrypt:from:content-language:references:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5TjWSctkOY+/IGVdwAo2CIwI2/0t7c6gp3UjgHR+xtE=;
        b=BJN9fGRLngAej85Asf5uvERgPl8HiZgwBLROFZIkiUnlEn1/8GmNewVx3mwVrzRlFe
         jE+iBxe0KXsfKAwW7s7YGe670u2EqAjzRNY61sUoj85wCQ14IuY3A4o/nQvnnDQnQgIa
         kog4XkFrgwAD/G8iwnuikhsaMoTLATUPgBK3giXMxfcJwwdFlwM+Awh7BFc2EKwy8EIX
         mnjMPQZz5zPTVG+XO4vdl5bRbVpsqCT1Qe7bJFWJZ424CtkI37jnEwfqqaQCi20TN/Yk
         FrtCCm0xwX2CSL8osCIL+qK/flGdMkalo2PZXQ03OKEQ71MBK+8uxyQUfVeVmg4ZA0dQ
         5gmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749796969; x=1750401769;
        h=in-reply-to:autocrypt:from:content-language:references:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5TjWSctkOY+/IGVdwAo2CIwI2/0t7c6gp3UjgHR+xtE=;
        b=Qe0a12HXRqDNEJTi/AOjK/rpap+cUv85mnYrJcUIiu2b0mqOew0ms9fiv+0zQvFY8m
         gcZ7qtZL7qsOae66xMePWmaYKS7FCXVuL/IeSS3MVSZF0mRppa1WlHjpR9G0Z33ygLyj
         5pHe6kEMVTjuBZDPS6WgJDcMFTopuQmsrGfkYp151f5FjEPfDXPRdlFhjZURc1BzLKeC
         ueSiXQdJK3om9JU7tSN+9wAIberKDUFfnIdxAikb3ZbqGw3GsPaMnbdkTJJoTnsdAnOI
         73hq5q98Ijouj02TI2DWJlOOSOVIZ2yir57DuSJtA7mGw793Ku8XnPXIaAVexXG963ZK
         DXnQ==
X-Forwarded-Encrypted: i=1; AJvYcCVx9Nl9JlZHwZl+B+7FKKeSwoIy4X/R6Vrs8ISLqAdrRg0LrU9i7SIHz7I+mOQ9+nEDOdEmDqKdk7gMDg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8XrXnD6wOBNboNxHuEe7lcpDUYpn5Mm1DNd5T/7fvxNbGoUD2
	BQRN75yOk/LK7A5FwvwizkinUaB7MD6uqgZ/cTATJpzi0ZotGwpzKI7RcJAsBs+Ag8U=
X-Gm-Gg: ASbGncuWnR4maHh9szfiut3PVwF7n+SrB70IbkQdjBlBq4ZgzipxMkDKq4DtucZED1+
	qQycRE4Ls2JaVj5wcBvfBBQsFGCCDX8m3+L7DxeXY4ZbP4KuylMO1qTNPi4f9Yfo3146ZqKnhmC
	ItvTT/R+eJKtcFXYSFDQIa1U86gOk0Xa0f1VweBJn8uHaTcgDlR87R4C2If4WfEN63PEGxsM4dd
	S7c+tiJ+xb1/8cEKTu+0Y4YOrP0XHVuF6xzosawx1Go3d35AwwxWXdw6o0Vq8RewjJk3eV65L2i
	HRSZ8nNO95/ZbNIREWFY42U49BSviBDY3jCYCbpjuQf+2dP/98qtzBxHEge6etZAP2xAjw/n8pA
	Uec7nDfRrr87ZhQ==
X-Google-Smtp-Source: AGHT+IEvJ61ewk2l399UBqG+h8H0qTqYFDpLxvWS8UG0Fpeib1wAS9mdyBqC/NmwT0Xre6H90Pr+6w==
X-Received: by 2002:a05:6000:23c4:b0:3a4:f722:a46b with SMTP id ffacd0b85a97d-3a56a2f8ac3mr672590f8f.15.1749796968438;
        Thu, 12 Jun 2025 23:42:48 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-748900cc047sm874940b3a.147.2025.06.12.23.42.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Jun 2025 23:42:47 -0700 (PDT)
Content-Type: multipart/mixed; boundary="------------iV0CQtFOi3kvK2cSqI3B4uC3"
Message-ID: <99814fd5-3f80-4d08-af7e-468f7c8885df@suse.com>
Date: Fri, 13 Jun 2025 16:12:44 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Stuck in CHANGING_BG_TREE state after interrupted btrfstune
 --convert-to-block-group-tree
To: Tine Mezgec <tine.mezgec@gmail.com>, linux-btrfs@vger.kernel.org
References: <a90b9418-48e8-47bf-8ec0-dd377a7c1f4e@gmail.com>
 <d57e673e-f894-48cc-8b34-c3754fa23b70@suse.com>
 <e264b3d7-1242-4470-8a5c-805e29911390@gmail.com>
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
In-Reply-To: <e264b3d7-1242-4470-8a5c-805e29911390@gmail.com>

This is a multi-part message in MIME format.
--------------iV0CQtFOi3kvK2cSqI3B4uC3
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/6/13 15:42, Tine Mezgec 写道:
> Hi Qu,
> 
> Thanks for taking a look at this.
> 
> Here are the three tree dumps you asked for:
> 
> http://144.76.28.172/btrfs/block-group.dump.gz
> http://144.76.28.172/btrfs/chunk.dump.gz
> http://144.76.28.172/btrfs/extent.dump.gz
> 
> Let me know if you need anything else

Thanks a lot.

The block-group dump shows that all block groups after 186298800275456 
(including that bytenr) are converted to block group tree.

At the same time, chunk tree dump shows that block groups 
186297726533632 is indeed the block group before the converted one.

Furthermore in side the extent tree dump, it shows there is indeed a 
block group item for 186297726533632 in the extent tree.

So the bug looks very likely inside the mount process which doesn't 
handle the last block group in the old tree correctly.


I crafted and attached a small patch, that will skip the the 
optimization to do a full extent tree search for old block groups.
I hope this will allow you to resume the conversion.

You'll need to compile btrfs-progs with this patch applied, then use the 
compiled btrfstune to resume the conversion.
(Better using the latest release of btrfs-progs)

This patch will cause a warning about an unused function but you can 
safely ignore it.

Thanks,
Qu

> 
> Thanks,
> -Tine
> 
> On 13/06/2025 00:29, Qu Wenruo wrote:
>>
>>
>> 在 2025/6/13 03:13, Tine Mezgec 写道:
>>> Hi,
>>>
>>> I have a Btrfs filesystem mounted at /media/storage with the 
>>> following setup, that took minutes to mount:
>>>
>> [...]
>>> btrfstune --convert-to-block-group-tree /dev/sdd
>>> (using btrfs-progs 6.6.3-1.1build2 from Ubuntu 24.04), but the system 
>>> lost power during the conversion.
>>
>> The progs is a little old, but I do not think there are bgt related 
>> fixes after that though.
>>
>>>
>>> After reboot, rerunning the command gives:
>>
>> Rerunning the command is the correct way to resume, but something 
>> doesn't seem correct here.
>>
>>
>>>
>>> ERROR: failed to find block group for bytenr 186297726533632
>>
>> Please provide the following dump:
>>
>> # btrfs ins dump-tree -t chunk <device>
>> # btrfs ins dump-tree -t extent <device>
>>    The above one is pretty large.
>>
>> # btrfs ins dump-tree -t block-group <device>
>>
>> I guess there is something wrong with the last converted bg checks, 
>> resulting btrfstune to trying to convert an already converted bg.
>>
>> Thanks,
>> Qu
>>
>>
>>> ERROR: failed to convert the filesystem to block group tree feature
>>> ERROR: btrfstune failed
>>>
>>> extent buffer leak: start 185256860958720 len 16384
>>>
>>> Trying with kernel 6.15.2 and btrfs-progs 6.14 gives the same result.
>>>
>>> The superblock flags now show:
>>>
>>> 0x4000000001 (WRITTEN | CHANGING_BG_TREE)
>>>
>>> Attempting to revert:
>>>
>>> btrfstune --convert-from-block-group-tree /dev/sdd
>>> fails with:
>>> ERROR: filesystem doesn't have block-group-tree feature
>>> ERROR: btrfstune failed
>>>
>>> So I'm stuck with a filesystem in a half-converted state — not fully 
>>> converted, but marked as changing.
>>>
>>> What’s the best way to either complete the conversion or revert/abort 
>>> it cleanly?
>>>
>>> Thanks,
>>> -Tine
>>>
>>
> 

--------------iV0CQtFOi3kvK2cSqI3B4uC3
Content-Type: text/x-patch; charset=UTF-8; name="read_all_bgs_from_old.diff"
Content-Disposition: attachment; filename="read_all_bgs_from_old.diff"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL2tlcm5lbC1zaGFyZWQvZXh0ZW50LXRyZWUuYyBiL2tlcm5lbC1zaGFy
ZWQvZXh0ZW50LXRyZWUuYwppbmRleCAyYjdhOTYyZjI5NGIuLmIwMmJiYTQ2MzBiNiAxMDA2
NDQKLS0tIGEva2VybmVsLXNoYXJlZC9leHRlbnQtdHJlZS5jCisrKyBiL2tlcm5lbC1zaGFy
ZWQvZXh0ZW50LXRyZWUuYwpAQCAtMjk4NCw3ICsyOTg0LDcgQEAgc3RhdGljIGludCByZWFk
X2NvbnZlcnRpbmdfYmxvY2tfZ3JvdXBzKHN0cnVjdCBidHJmc19mc19pbmZvICpmc19pbmZv
KQogCQlyZXR1cm4gcmV0OwogCX0KIAotCXJldCA9IHJlYWRfb2xkX2Jsb2NrX2dyb3Vwc19m
cm9tX3Jvb3QoZnNfaW5mbywgb2xkX3Jvb3QpOworCXJldCA9IHJlYWRfYmxvY2tfZ3JvdXBz
X2Zyb21fcm9vdChmc19pbmZvLCAgb2xkX3Jvb3QpOwogCWlmIChyZXQgPCAwKSB7CiAJCWVy
cm9yKCJmYWlsZWQgdG8gbG9hZCBibG9jayBncm91cHMgZnJvbSB0aGUgb2xkIHJvb3Q6ICVk
IiwgcmV0KTsKIAkJcmV0dXJuIHJldDsK

--------------iV0CQtFOi3kvK2cSqI3B4uC3--

