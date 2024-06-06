Return-Path: <linux-btrfs+bounces-5485-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D292C8FDBA7
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Jun 2024 02:52:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2FB00B241CB
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Jun 2024 00:52:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5FDCD528;
	Thu,  6 Jun 2024 00:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="UmmuUhe7"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5868D4A2D
	for <linux-btrfs@vger.kernel.org>; Thu,  6 Jun 2024 00:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717635153; cv=none; b=Oxe/uRTWRo9GVFqvjr7JasnHF3dJ6eQ7p2Dp3gc7lwH5aYLM64xhcIKTXGK0vfbKSSM5bcPu4IpxxHLgq1IJShwkCHPJYLtpnVGc6BxgHLeB1kxw+rN31o2Z6tKqNdL9pcn3YdDtjrhvc24S0EVprBdloCZOjjb88qTRkfjD1OA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717635153; c=relaxed/simple;
	bh=rxSpp/ON8c6/M83VGwNZlLYp2VJZ6QbdJ6ajnnF/ZPU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nQ2rFI+pXm91VDMzxikFGw4k9Zq+uP5HeHPoimXOQJ0iDmGJ5ELs7a4bVh//YOU9YJ2gRFHYQ8zmh1wQRuU4Z0IYpvhzsLLPkCI1JQUNUpXP+aTQ/Ym7d52zrDv2Hynxq+/JA0kWlU56RcYdSIZQ9k9lqgdMf96pHhb9mD3GYNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=UmmuUhe7; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2eaac465915so4007581fa.1
        for <linux-btrfs@vger.kernel.org>; Wed, 05 Jun 2024 17:52:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1717635148; x=1718239948; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=vKGSEOhWkNFl8t7yYyxDkJgWOTkS06Q3smFUsaQGEOo=;
        b=UmmuUhe7fjO6NDZ9cuUrw3yN5actTKezRhvFVSqR4YatQXdRZAm5opAvY1V1g2i7it
         6Mq6AtDxKgNU33cCoow//lCphMb1DLdpdS6547x7Ml6OU/fCJ9BB0uc7geRUu9BVG6Oe
         a614RvXoOTrVgaG8um2vSt+WfCA4PuYl1IwSsGEeIflWYXFhJ7JCG6fch/u+vv90w2FP
         69fXsVdIo07+c5qLi6fjn5rjCKOA0jKAgh5X6Wutk5ozOrtBazPg9i34XWBHlg1Bkrdf
         8oc6caIBQPNw/Moh8WNfC2YdbFfqmESa+iLXpAnwVb3V73c6renPT5aOxybTqYDhDkrf
         WGGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717635148; x=1718239948;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vKGSEOhWkNFl8t7yYyxDkJgWOTkS06Q3smFUsaQGEOo=;
        b=Ambmid1fx7Aquk63LlHlM7wiVjlLitAW6TJtPev2oUNWdCpAfZA5T4FU4hXHr9dJNb
         HnG4XgE8tt7fATPeWz2HVCwJsrBhAZnAAiUv4kqyq/X+o8hZ+9xJPhl8jv5B3UZWYw6J
         j0P0iafcJANgsJKuWduiS+8ogJCj3PE3qL/hMYyjnNfdzuBHbUCDspd6rNG6NMfieipi
         RapNNDCS1m4IcjuIstmxU5OoLML+Hey51/00gAOIOgeW4WrNo8vcNu4LbRddnQJBnXwm
         tLZjuO70mIho6fgrf95GwuB8o/Xtx2IyXtitV5HMeaYIUmMeXF6jw0Sync5hBREnIX+S
         cvvg==
X-Forwarded-Encrypted: i=1; AJvYcCXcSJbBX6NBKS4H0G+DxT4MeZqamL+UF7atKBGJcaGL9HksqNw/VH3ZWdSAzfyfzwN3nHvyJ69V2nMlhdi+pdpfJQGGa7zJCHWaEVg=
X-Gm-Message-State: AOJu0YwStkbdZLpEEOzrKoQqqHeypVe6Qy4sSgLjd4OGBCV8qGz8dFa/
	WjBK94/NuMaAilwURrltYtijme/M630PWZnio8TFpJIoJvlCadHIxBo3hwz4/80=
X-Google-Smtp-Source: AGHT+IEW/31+bBKHSdmq5v/9iPEb49sLARWUK7SIkbWS8MQ1kiTT9VhuxypGyQwlV19DyFqjgKHZgg==
X-Received: by 2002:a2e:8941:0:b0:2e9:87bb:1ce8 with SMTP id 38308e7fff4ca-2eac7a4c834mr23799831fa.35.1717635148385;
        Wed, 05 Jun 2024 17:52:28 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-703fd52b794sm100730b3a.209.2024.06.05.17.52.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Jun 2024 17:52:27 -0700 (PDT)
Message-ID: <c9e54af5-4370-4d45-a8ed-4098b06b2629@suse.com>
Date: Thu, 6 Jun 2024 10:22:21 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs/280: run defrag after creating file to get expected
 extent layout
To: Filipe Manana <fdmanana@kernel.org>, Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
 Filipe Manana <fdmanana@suse.com>
References: <837d97d52fee15653d1dac216d1d75a14bb1916d.1717586749.git.fdmanana@suse.com>
 <8e44aa93-895c-438f-b4ad-9887a0c95b0b@gmx.com>
 <CAL3q7H59sLUyGuC0_K-rG6zE_LDUB6kA1S24rUskxJ1ZgC7muw@mail.gmail.com>
Content-Language: en-US
From: Qu Wenruo <wqu@suse.com>
Autocrypt: addr=wqu@suse.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNGFF1IFdlbnJ1byA8d3F1QHN1c2UuY29tPsLAlAQTAQgAPgIbAwULCQgHAgYVCAkKCwIE
 FgIDAQIeAQIXgBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJjTSJVBQkNOgemAAoJEMI9kfOh
 Jf6oapEH/3r/xcalNXMvyRODoprkDraOPbCnULLPNwwp4wLP0/nKXvAlhvRbDpyx1+Ht/3gW
 p+Klw+S9zBQemxu+6v5nX8zny8l7Q6nAM5InkLaD7U5OLRgJ0O1MNr/UTODIEVx3uzD2X6MR
 ECMigQxu9c3XKSELXVjTJYgRrEo8o2qb7xoInk4mlleji2rRrqBh1rS0pEexImWphJi+Xgp3
 dxRGHsNGEbJ5+9yK9Nc5r67EYG4bwm+06yVT8aQS58ZI22C/UeJpPwcsYrdABcisd7dddj4Q
 RhWiO4Iy5MTGUD7PdfIkQ40iRcQzVEL1BeidP8v8C4LVGmk4vD1wF6xTjQRKfXHOwE0EWdWB
 rwEIAKpT62HgSzL9zwGe+WIUCMB+nOEjXAfvoUPUwk+YCEDcOdfkkM5FyBoJs8TCEuPXGXBO
 Cl5P5B8OYYnkHkGWutAVlUTV8KESOIm/KJIA7jJA+Ss9VhMjtePfgWexw+P8itFRSRrrwyUf
 E+0WcAevblUi45LjWWZgpg3A80tHP0iToOZ5MbdYk7YFBE29cDSleskfV80ZKxFv6koQocq0
 vXzTfHvXNDELAuH7Ms/WJcdUzmPyBf3Oq6mKBBH8J6XZc9LjjNZwNbyvsHSrV5bgmu/THX2n
 g/3be+iqf6OggCiy3I1NSMJ5KtR0q2H2Nx2Vqb1fYPOID8McMV9Ll6rh8S8AEQEAAcLAfAQY
 AQgAJgIbDBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJjTSJuBQkNOge/AAoJEMI9kfOhJf6o
 rq8H/3LJmWxL6KO2y/BgOMYDZaFWE3TtdrlIEG8YIDJzIYbNIyQ4lw61RR+0P4APKstsu5VJ
 9E3WR7vfxSiOmHCRIWPi32xwbkD5TwaA5m2uVg6xjb5wbdHm+OhdSBcw/fsg19aHQpsmh1/Q
 bjzGi56yfTxxt9R2WmFIxe6MIDzLlNw3JG42/ark2LOXywqFRnOHgFqxygoMKEG7OcGy5wJM
 AavA+Abj+6XoedYTwOKkwq+RX2hvXElLZbhYlE+npB1WsFYn1wJ22lHoZsuJCLba5lehI+//
 ShSsZT5Tlfgi92e9P7y+I/OzMvnBezAll+p/Ly2YczznKM5tV0gboCWeusM=
In-Reply-To: <CAL3q7H59sLUyGuC0_K-rG6zE_LDUB6kA1S24rUskxJ1ZgC7muw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/6/6 08:47, Filipe Manana 写道:
> On Wed, Jun 5, 2024 at 11:30 PM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>>
>>
>>
>> 在 2024/6/5 20:56, fdmanana@kernel.org 写道:
>>> From: Filipe Manana <fdmanana@suse.com>
>>>
>>> The test writes a 128M file and expects to end up with 1024 extents, each
>>> with a size of 128K, which is the maximum size for compressed extents.
>>> Generally this is what happens, but often it's possibly for writeback to
>>> kick in while creating the file (due to memory pressure, or something
>>> calling sync in parallel, etc) which may result in creating more and
>>> smaller extents, which makes the test fail since its golden output
>>> expects exactly 1024 extents with a size of 128K each.
>>>
>>> So to work around run defrag after creating the file, which will ensure
>>> we get only 128K extents in the file.
>>
>> But defrag is not much different than reading the page and set it dirty
>> for writeback again.
>>
>> It can be affected by the same memory pressure things to get split.
> 
> Defrag locks the range, the pages, then dirties the pages and then
> unlocks the pages. So any writeback attempt happening in parallel will
> wait for the pages
> to be unlocked. So we shouldn't get extents smaller than 128K. Did I
> miss anything?
> 

You're right, I forgot the page is also locked, and the defrag cluster 
size is 256K, exactly aligned with compression extent size.

So it's completely fine.

>>
>> I guess you choose compressed file extents is to bump up the subvolume
>> tree meanwhile also compatible for all sector sizes.
> 
> Yes, and to be fast and use very little space.
> 
>>
>> In that case, what about doing DIO using sectorsize of the fs?
>> So that each dio write would result one file extent item, meanwhile
>> since it's a single sector/page, memory pressure will never be able to
>> writeback that sector halfway.
> 
> I thought about DIO, but would have to leave holes between every
> extent (and for that I would rather use buffered IO for simplicity and
> probably faster).
> Otherwise fiemap merges all adjacent extents, you get one 8M extent
> reported, covering the range of the odd single profile data block group created
> by mkfs, and another one for the remaining of the file - it's just
> ugly and hard to reason about, plus that could break one day if we
> ever get rid of that 8M data block group.

Yep, fiemap merging is another problem.

So this looks totally fine now.

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> 
> 
> 
>>
>> Thanks,
>> Qu
>>>
>>> Signed-off-by: Filipe Manana <fdmanana@suse.com>
>>> ---
>>>    tests/btrfs/280 | 10 +++++++++-
>>>    1 file changed, 9 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/tests/btrfs/280 b/tests/btrfs/280
>>> index d4f613ce..0f7f8a37 100755
>>> --- a/tests/btrfs/280
>>> +++ b/tests/btrfs/280
>>> @@ -13,7 +13,7 @@
>>>    # the backref walking code, used by fiemap to determine if an extent is shared.
>>>    #
>>>    . ./common/preamble
>>> -_begin_fstest auto quick compress snapshot fiemap
>>> +_begin_fstest auto quick compress snapshot fiemap defrag
>>>
>>>    . ./common/filter
>>>    . ./common/punch # for _filter_fiemap_flags
>>> @@ -36,6 +36,14 @@ _scratch_mount -o compress
>>>    # extent tree (if the root was a leaf, we would have only data references).
>>>    $XFS_IO_PROG -f -c "pwrite -b 1M 0 128M" $SCRATCH_MNT/foo | _filter_xfs_io
>>>
>>> +# While writing the file it's possible, but rare, that writeback kicked in due
>>> +# to memory pressure or a concurrent sync call for example, so we may end up
>>> +# with extents smaller than 128K (the maximum size for compressed extents) and
>>> +# therefore make the test expectations fail because we get more extents than
>>> +# what the golden output expects. So run defrag to make sure we get exactly
>>> +# the expected number of 128K extents (1024 extents).
>>> +$BTRFS_UTIL_PROG filesystem defrag "$SCRATCH_MNT/foo" >> $seqres.full
>>> +
>>>    # Create a RW snapshot of the default subvolume.
>>>    _btrfs subvolume snapshot $SCRATCH_MNT $SCRATCH_MNT/snap
>>>
> 

