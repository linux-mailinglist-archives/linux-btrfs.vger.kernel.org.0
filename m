Return-Path: <linux-btrfs+bounces-17806-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A90ABDC718
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Oct 2025 06:18:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 477721921A4A
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Oct 2025 04:19:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76C542F60D5;
	Wed, 15 Oct 2025 04:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="VEaU2K83"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E18E9272E4E
	for <linux-btrfs@vger.kernel.org>; Wed, 15 Oct 2025 04:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760501915; cv=none; b=Ja9A7jtNGLVZMFQpyd7xc33KU2P0Zx49fuvePx0Wh9pUll2FotVPXztCc6JfidYYe67ERd/E9I2V+1GwnNFPMPbGmSuH2L6+GSYJe8Yxkeik+GiJI4pCbvb8Ytnp8R1byWgLeNEATC+1Hgo0Vf1xV1SutXBUH4T1Jg3Jr+TOIkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760501915; c=relaxed/simple;
	bh=nS2Ut62x4b4Mqe67yKdtcu+ie4wvdW5JLXg3jbEHFRs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mighybXbvFM6lSynVVIEjjxVKkQm5BCbsvDuC3A15CSTAOfwgyXVz8t4HV7Ps+B2yAJOG3P3iAOi8QBak23wEtBlluAbUxCaouIlEUJQorHMxZReVsTUs9Bwa9CJARCqeGC/q0jG4G1tatQ0x2Nuiw7bkfhm0xX7Zv/Sd9gKwTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=VEaU2K83; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3ee15505cdeso433652f8f.0
        for <linux-btrfs@vger.kernel.org>; Tue, 14 Oct 2025 21:18:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1760501911; x=1761106711; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=cm3TzlS0OZaACmDeRCIm+f6uq6+u46txD6gTkH0cYOE=;
        b=VEaU2K83wuEIXmGt/3dfN1aCkI6J+KRzZIwTRQSId0KjJbZ9yEhCbQAlGiX2cnnLy6
         j+XU3Ct+JkNBK1ETSGuaHvRKzFrU2pEFLOz9neKbRSHa96AJy9LQeVQWQTrRhLffNUV7
         YtYWv0JbQd+YMJe4fVV9Befw/KM9vVoYBIzKIjOwq1FOTZ31f4xdtWa+OrlABs1vurBO
         MfZ6LUXMuF391rEXwO8zHwlZiL6feTRmJc8DD31cF28VdddJSnt14e7DGO1BciwkGrsC
         Lbv0rOyER8BOAwRAjIyhqzXkE17ighe6hBtYtykbMolJE1jbOnZ99L/Wg768kLPgqC+z
         5Dyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760501911; x=1761106711;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cm3TzlS0OZaACmDeRCIm+f6uq6+u46txD6gTkH0cYOE=;
        b=UNkZ0oDxBKgkqd9fZOcC4Ny5lW45ZlIsZgXNY6Yo/Gq0/pvc1Kx5Ei6FOzvle6MVZ6
         BBG8hMII6Ey/cVFymyHa3ruPl7mFUsEOj5fnxqcsvMxFBjUrmj7Ttsym9MeMhrQQl5mS
         bX5JKfb/uBylvpaL9doc9v/gREWVEPmrEgg1/TzfBCDoiWco4SLz5+y9xjriR0YONXHg
         QRF2w21HgA82hcAILxPFZp95FE48e7pVTJmsQRQFthcguzIW1YJXK4yf/+Qx7H1qWAZ0
         t4WIwD/6VRy9PToLgdsTf3iHUsOFhVubEkT7FmtlzjRW8jkVvp5pjHqaFALVPGPs2J6o
         YPmg==
X-Forwarded-Encrypted: i=1; AJvYcCVHtYASBqGs3WJKAGOxfPFGo6sxBJvOLwk6S6s0YLhd5W1maLDGzUqNceKdhe10dnpgoSwhLDWg7UZmog==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9D7/KBfW0Bu5JD+ViGm19CqwxlVqCs0iUj9Yv2g8uJreRJ/Ce
	0BRzKle3Q1/Q8Azr39lV160Oc14c6czRWVPtV4u56L4aYtJu8RZhFp6owgH8CKeZED0=
X-Gm-Gg: ASbGnctsUs91qLwZQslLqUiWwecbV/DkjaGGyxx7Nqgb2bc98TtLHvNK1ppgbwHmni4
	+zYMHaVSaY20KmeoJr2GyO/UpMaUKsQyfHLtCKrk+e4AVkpgRGzgqvkANLGrPKVWHfh0GI+peOt
	9yk2TYcYx5QlQcmJsBMyA4yslYfSsVtpKIsCZdAOXhKias8Djce1Xkf45vDlugWB8sxh+EUZvzK
	YsBywy39V7QV2MyEwo4tBAn6P7G98h7sVSvrwcueoSAC5CEe8R7BGVr2+A0/2zUvBpHY1G2BoQp
	fa/+4r5zkPSdils7bPLGvE8M+wf+t9KRrs43ws3EK/uyfZ2nYoHA/f/M09ZtyyTiQG8f989Kig8
	PqYQDAbvCuQaIJBZXlhth39TWKF4UEVnDzhjavTGyrMNeO3y3wTmlobV2/YGgLOs7yxocKK3tha
	+kXMs6
X-Google-Smtp-Source: AGHT+IEiuX7kenvFJN3yTgBkBSq3R1S5piuReZRy93wNagabNuWUYEEsmKyQiTUMz1qALWjnA0s6gg==
X-Received: by 2002:a05:6000:4009:b0:425:86d1:bcc7 with SMTP id ffacd0b85a97d-42586d1c0cdmr17259284f8f.23.1760501911127;
        Tue, 14 Oct 2025 21:18:31 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7992d0c349csm16959651b3a.50.2025.10.14.21.18.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Oct 2025 21:18:30 -0700 (PDT)
Message-ID: <1de12f07-c7ab-4a8f-8fb4-00cb29145178@suse.com>
Date: Wed, 15 Oct 2025 14:48:23 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/1] ovl: brtfs' temp_fsid doesn't work with ovl
 index=on
To: Anand Jain <anajain.sg@gmail.com>, dsterba@suse.cz,
 =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Cc: linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org,
 linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 kernel-dev@igalia.com, Miklos Szeredi <miklos@szeredi.hu>,
 Amir Goldstein <amir73il@gmail.com>, Chris Mason <clm@fb.com>,
 David Sterba <dsterba@suse.com>, Anand Jain <anand.jain@oracle.com>,
 "Guilherme G . Piccoli" <gpiccoli@igalia.com>
References: <20251014015707.129013-1-andrealmeid@igalia.com>
 <20251014182414.GD13776@twin.jikos.cz>
 <6982bc0a-bb12-458a-bb8c-890c363ba807@suse.com>
 <0791edfb-6985-45d7-bb3e-08ab7a341dab@gmail.com>
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
In-Reply-To: <0791edfb-6985-45d7-bb3e-08ab7a341dab@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/10/15 10:35, Anand Jain 写道:
> On 15-Oct-25 5:08 AM, Qu Wenruo wrote:
>>
>>
>> 在 2025/10/15 04:54, David Sterba 写道:
>>> On Mon, Oct 13, 2025 at 10:57:06PM -0300, André Almeida wrote:
>>>> Hi everyone,
>>>>
>>>> When using overlayfs with the mount option index=on, the first time 
>>>> a directory is
>>>> used as upper dir, overlayfs stores in a xattr "overlay.origin" the 
>>>> UUID of the
>>>> filesystem being used in the layers. If the upper dir is reused, 
>>>> overlayfs
>>>> refuses to mount for a different filesystem, by comparing the UUID 
>>>> with what's
>>>> stored at overlay.origin, and it fails with "failed to verify upper 
>>>> root origin"
>>>> on dmesg. Remounting with the very same fs is supported and works fine.
>>>>
>>>> However, btrfs mounts may have volatiles UUIDs. When mounting the 
>>>> exact same
>>>> disk image with btrfs, a random UUID is assigned for the following 
>>>> disks each
>>>> time they are mounted, stored at temp_fsid and used across the 
>>>> kernel as the
>>>> disk UUID. `btrfs filesystem show` presents that. Calling statfs() 
>>>> however shows
>>>> the original (and duplicated) UUID for all disks.
>>>>
>>>> This feature doesn't work well with overlayfs with index=on, as when 
>>>> the image
>>>> is mounted a second time, will get a different UUID and ovl will 
>>>> refuse to
>>>> mount, breaking the user expectation that using the same image 
>>>> should work. A
>>>> small script can be find in the end of this cover letter that 
>>>> illustrates this.
>>>>
>>>> >From this, I can think of some options:
>>>>
>>>> - Use statfs() internally to always get the fsid, that is 
>>>> persistent. The patch
>>>> here illustrates that approach, but doesn't fully implement it.
>>>> - Create a new sb op, called get_uuid() so the filesystem returns 
>>>> what's
>>>> appropriated.
>>>> - Have a workaround in ovl for btrfs.
>>>> - Document this as unsupported, and userland needs to erase 
>>>> overlay.origin each
>>>> time it wants to remount.
>>>> - If ovl detects that temp_fsid and index are being used at the same 
>>>> time,
>>>> refuses to mount.
>>>>
>>>> I'm not sure which one would be better here, so I would like to hear 
>>>> some ideas
>>>> on this.
>>>
>>> I haven't looked deeper if there's a workable solution, but the feature
>>> combination should be refused. I don't think this will affect many
>>> users.
>>>
>>
>> I believe the root problem is that we're not fully implementing the 
>> proper handling just like other single-device fses.
>>
>> We do not use on-disk flags which means at least one fsid is 
>> registered into btrfs, thus we have to use different temp-fsid.
>>
>> If fully single-device feature flag is properly implemented, we should 
>> be able to return the same uuid without extra hacks thus solve the 
>> problem.
> 
> I had looked into this some time ago. Some libs, like libblkid,
> don't handle multi-device filesystems or cloned devices with
> temp FSIDs very well. I'm aware of it.
> 
> I've been making some progress on fixing those cases, but it's
> a bit extensive since we first need enough test coverage,
> and recent reappear-device inline with that.
> 
> Let's see how we can support use cases with identical devices
> (where changing the UUID isn't an option) and keep things
> compatible with systemd and library tools.
> 

My current idea is to introduce a new ro compat flag, so that mounting 
that device will not go through the fsid lookup procedure completely.

But go through the common get_tree_bdev() routine, which will check if 
the fs is already mounted using bdev holder.
(And of course, no fsid recorded inside btrfs module)

This will make single device btrfs with that special flag to behave 
exactly like all the other filesystems.

