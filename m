Return-Path: <linux-btrfs+bounces-9981-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A9DB9DEEF8
	for <lists+linux-btrfs@lfdr.de>; Sat, 30 Nov 2024 05:37:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 83E1CB21688
	for <lists+linux-btrfs@lfdr.de>; Sat, 30 Nov 2024 04:37:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A2B0137930;
	Sat, 30 Nov 2024 04:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Olk4NC8H"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D79923FC2
	for <linux-btrfs@vger.kernel.org>; Sat, 30 Nov 2024 04:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732941467; cv=none; b=jS9q2iVCn7xgUpaZ6hTii7F6qM+4JgImVfBam21AbihdEGPJbNY1yOKb3m9oZqXi1Ric3BE9r5Y7TWu652c9BmZcZgevusdkhErsAbhExDaqz8yMf2UxfnQcXxITe1gffkZr/ilBSv0/W6Rfei7jmgVbhlMrSKrSDPKGPb+yXaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732941467; c=relaxed/simple;
	bh=avRm1YsSbDQ3uNdqg4XIyNQjQzx+Wkd519gQbC+kuxE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mkQpk9AoL7OO9HaTsiqpgZ/SA8sQqEALySxEpPJvKiRUFLQ6YRwanKbDgdcKhDOdrKo+AKSLlEQfHSjuC4bENS6zYs3UGUetkTVWYyCY23tuxjNqKvdBVUEKuq8B7Uz48l7F+kL1zzDUTO+pkSAgge9jqCrID9inJY2x4VQY0aU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Olk4NC8H; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-434aa222d96so28121995e9.0
        for <linux-btrfs@vger.kernel.org>; Fri, 29 Nov 2024 20:37:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1732941463; x=1733546263; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=a1WSwHkqHUyOi2IoL+DAQ0pEGLCRVT+XMDuYnMpQK5k=;
        b=Olk4NC8HJYGe+Q4NchMubfmoZL5rgUBsKWe4za2ZTNy91usT5oCyTPxPRO9TsUJC4G
         6cRoEcmoNxHWcEVskiYYkzPRDWonIiAMBCl81nzIxSWnK6WZ5K09fIv8oxTIk5u4mZDD
         s97Ey8U1RlVN7EQsn8/uPxTMgiLxE2Pth/A5iHXJHM0wxYG3eeBtfhmX4pNdSQD4KzLU
         EvXXvACsO8cOCaC0NIHj7ZHhCcdsYsb75fpusyaRKa8tQ0DPCkCZ5V3KGuuW52Shyd/Q
         5fpI9gV5Xmt9qiWSJ6QZw6wTfD47nA3h7aHJxrXQ1sqhLNuTd84rbct+sjZ+sGnAznYV
         x3TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732941463; x=1733546263;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a1WSwHkqHUyOi2IoL+DAQ0pEGLCRVT+XMDuYnMpQK5k=;
        b=pjIEX/kjbglw8oqxQgjBm5d8KVYf17dPHex8DpRCKK+7xwEU1kEdk1z2izGVnL9xVj
         RoV7ZEFe/lIYVwY0Sbnx3ETmYpgtHXoaN2DMx6ufP4Ba3yAij7SFAzADJrv3bs8lThUR
         Vnqal+2cZn4vefq5rFP3WRoyQk/kh7m2UGu0tX/zm+4Yh52FUUmEE1kGwlf8dik6g5RR
         h4Q4oToEzJ2tAv2baPNYbHUhBXVUuneDNckLjholgFU+HGU4o+g+ZceAOZGrxrFHq4EJ
         dgiBJLjq8qrXwOPvdAAB0eroYh9EhOvuhpn3IpAVjqsFe04gjklbKRhTLdzEyZk1DYrD
         Bj1Q==
X-Gm-Message-State: AOJu0YwZT08XjMCbbv/o1a7WN8rbHcsj2d4FbprIPa+pUhjwuHdyNvBE
	w+6M68KGXM00NNumupmjn9c9WWqFgUypAJiSoG4RSPdZnS8gTf+yZQZvXiLcZJk=
X-Gm-Gg: ASbGnctOfA0SeDt1c4VC8ysbdfNMLDLhh1ZxBMg3OPl/Jkk23q+h1g29C4jU//t14JD
	L7wkiq5NxkPpea74Cs7go1XLa867Yt9iiRrdUHj48qizLRMAOj4SNswr6BJeGsBN0QpXiWSh1qJ
	0iI+bXSLxMUMLPGligWIBbdl5bkwzuvxWvD1K3E3e61QTkwWhIswniCv8CMD/zWLWF5/qSwc5WV
	wxvLfEQM3ZtTvCFMOvzIAymrZ8hxH+1c5vzfEJpjs66PUiEpxgPSBGXReTIcSEOXFwNfYo6/MXM
	3A==
X-Google-Smtp-Source: AGHT+IFIFnS2IIJTS8EpnAWbTCc26yxI7XMfQx/E7MI2oKGRndfgdmEp6XPIUBjCJQwJL1eAXGfT7Q==
X-Received: by 2002:a05:600c:4e8a:b0:431:562a:54be with SMTP id 5b1f17b1804b1-434a9dc36c1mr153933135e9.9.1732941462136;
        Fri, 29 Nov 2024 20:37:42 -0800 (PST)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7254176fe28sm4331148b3a.72.2024.11.29.20.37.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Nov 2024 20:37:41 -0800 (PST)
Message-ID: <f409d283-88c0-45d7-b8df-e4d1ec227117@suse.com>
Date: Sat, 30 Nov 2024 15:07:37 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: corrupt leaf, invalid data ref objectid value, read time tree
 block corruption detected Inbox
To: Nicholas D Steeves <sten@debian.org>, Qu Wenruo <quwenruo.btrfs@gmx.com>,
 Brett Dikeman <brett.dikeman@gmail.com>
Cc: linux-btrfs@vger.kernel.org
References: <CAFiC_bz7QpCE_bf0VdhV1x4NvQbgnxPDrtD=XOupPKA=N7-yZA@mail.gmail.com>
 <1748c8ff-30a6-4583-bdbb-b3513bc3d860@gmx.com>
 <CAFiC_bzov3zete3VabFQQMQ3rUS-TdHikNqRMUW_xggFmrtoNw@mail.gmail.com>
 <cfc9177b-ab53-40c2-b627-0045e9348938@gmx.com>
 <87h67pmspi.fsf@digitalmercury.freeddns.org>
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
In-Reply-To: <87h67pmspi.fsf@digitalmercury.freeddns.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/11/30 11:41, Nicholas D Steeves 写道:
> Qu Wenruo <quwenruo.btrfs@gmx.com> writes:
> 
>> 在 2024/11/27 09:39, Brett Dikeman 写道:
>>> On Tue, Nov 26, 2024 at 4:30 PM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>>>
>>>> Inode cache is what you need to clear.
>>>
>>> Brilliant! Thank you, Qu. It did mount cleanly. Shame Debian's
>>> toolchain is so out-of-date. I pinged the maintainer asking if they
>>> could pull 6.11.
>>>
>>> Is there anything I could have done that would have caused the
>>> corrupted inode cache?
>>
>> It's not corrupted, but us deprecating that feature quite some time ago.
>> And then a recently enhanced sanity check just treat such long
>> deprecated feature as an error, thus rejecting those tree blocks.
>>
>>>
>>> 'btrfs check' thought the second drive was busy after unmounting, but
>>> a reboot cured that.
>>>
>>> check found the following; Is the fix for this to clear the free space cache?
>>
>> I'd recommend to go v2 cache directly.
>>
>> You may not want to hear, but we're going to deprecate v1 cache too.
>>
>> V2 cache has way better crash handling, I have not yet seen a corrupted
>> v2 cache yet.
> 
> Let's avoid a "btrfs is the only fs that ate my data" storm.  Would it
> be sufficient to provide free space cache v2 migration instructions in
> our release notes?

So far when we deprecate the v1 cache, it should require no user 
interruption.

We will silently delete v1 cache and rebuild v2 cache on the next rw 
mount, at least that's my plan.

Unlike the offending inode cache feature, v1 cache is a very common 
feature, thus I believe we won't hit the same situation again, until v1 
cache is fully deprecated for years if not decades.

>  If not, would you be willing to write something?

I believe the current man page is showing it good enough:

   If v2 is enabled, and v1 space cache will be cleared (at the first
   mount) and kernels without v2 support will only be able to mount the
   filesystem in read-only mode.

And since v2 cache is supported since 4.5, we have no need to bother any 
compatibility problem either.

> Alternatively, should this be automatic, and in-kernel?  Debian users
> tend to have long-running installations and don't tend to reinstall.  I
> think you'll agree we ought to get ahead of the thousands of users who
> have v1 cache and who ran mkfs with btrfs-progs as early as 4.4 or 4.9.
> 
> Most users will migrate from a recent 6.1.x (close to kernel.org's)
> directly to 6.12.x (what seems to be the most likely LTS).  Many have
> also tracked the stable mainline or have recently upgraded to 6.11.
> 
> Beyond that, I'm not aware of any format chances (other than some new
> experimental raid56 stuff), but it might also be nice to know if there's
> a threshold where it would be better to reformat an "aged" filesystem.

There is no recommendation to format an "aged" fs at all.

All our new features (v2 cache, no_holes, block-group-tree, even new 
checksums) have a way to migrate the existing fs to the new format.

The only difference is, some will be done automatically by the kernel 
(v2 cache), some needs to be done with unmounted fs and btrfstune tool 
(bg tree, new checksums format).

The offline migration is not ideal for end users, but at least that's 
what we have for now.

> 
> 
> Kind regards,
> Nicholas
> 
> P.S. We'll fix the ancient btrfs-progs problem before the new year.  The
> current issue is where "strong package ownership" processes slow things
> down.

I'd recommend to provide something like PPA repo for a newer/latest 
btrfs-progs static build for end users who do not want to build 
btrfs-progs by themselves, and still want a latest prog no matter the 
Debian version.

But the inode cache cleanup code is really an exception, where the 
feature is so rare that we do not even have proper test coverage for it 
at all.

Until we hit the situation where inode cache cleanup is definitely needed...

Thanks,
Qu

