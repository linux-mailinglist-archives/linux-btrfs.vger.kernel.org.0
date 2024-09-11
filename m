Return-Path: <linux-btrfs+bounces-7929-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5655974DA8
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Sep 2024 10:57:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA9F01C20CFE
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Sep 2024 08:57:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2795714D6EE;
	Wed, 11 Sep 2024 08:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="QMtyxkaB"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A4CC183CC1
	for <linux-btrfs@vger.kernel.org>; Wed, 11 Sep 2024 08:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726044949; cv=none; b=FK5sHBun60vNlwRxEiscTCTfrln0p7U0hyd0LU+fUF7xrKyLyXgvZJkEy7Db6ULxDNfbUCsSMXvbEEDbZSKEsdELCLmLVsW7xdCTcaJY2fGz1eNSn6n4PoqMq3i6lXlkJoa6ccUjtC94zWg2LFlENmoHt7TbKjBow1YcJhj92V0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726044949; c=relaxed/simple;
	bh=a52YmpjZLhKh2CDtVCg9drub6VsMlj0ssdQd6jleFRk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DSFYA+eoTtYgheKCLxYQb9idbo3u1jXrlH3a4Bvia7djEf0zWSAc0gNwrvmVFrM20Ul1Q0al8RyUTiXI77+8i6SlV8R01IkkslJJZ4/XQFsCXErSxTCYc2mHkJY9sNB7X/P4898mTzh8MqAJWI8MfKcwmVmuXs1K6wL/ElrxzEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=QMtyxkaB; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2f759688444so43910181fa.1
        for <linux-btrfs@vger.kernel.org>; Wed, 11 Sep 2024 01:55:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1726044945; x=1726649745; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=wKCXMkigjveGuiJResBBCH+JbVHfirQIpwQemi5EIYk=;
        b=QMtyxkaBoyxhe/znVg03uYFNDHsUyxR0h9nfF0KtyFZeTM68D4h+bNPvVu7AsffSV/
         H7BgsjoMiqQ/R6xzd9E/38CYwhVnl3ar2YcP2WmbMJfbWdHM50ctZFhcMjl3Lf82WTIn
         IZSBOZ5fECija3+Q4vHUe5IcjLowTkbd06QTRPwOdb+EwbFRbOjhNUKMVAK4RVSXZngn
         ra1NAzk1LibRvxHXHKnzUt5Z53K3HSNTIJlZCj5IRDKEbOWWxhvJWw2bmmhZcIfcyWez
         BuAHZZgZM9fA3WWmiBlgSreDVcnDmUYCotxQimbuuyXPcWWzZ1VtshFnNrQHVYNcBWUg
         l9/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726044945; x=1726649745;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wKCXMkigjveGuiJResBBCH+JbVHfirQIpwQemi5EIYk=;
        b=rJbqD3maPYN7XgnNjblJrYngfagBR4V7eundDnD6Oq/qEt4D97xx2Dh1rmf768slg3
         ZE/K979YnypQPwRVVOYGGRWpEF2JzJBNGQc2pqmEdA4+c99SaxJRjN5/k+jAP09cMD03
         mPx4ad7kLVQu0LB+yuwQHbFNI8ZsUehANK91AkXD4O29DwePSHGar6Rvi+lJm4yOtC9E
         8oP7sEGReOaJVTofuBbhlwVG01QsUaFAFPQGR1k1ZjMrFwWp0zuuaRfJeDwpkd8tZDRI
         2N7SbmuLkAeSSsvEBFXQ4rBdc6Ey7aH4s6PTc+pRWiTEY8v767/SUl+W22Nf8LmTRdIQ
         S8jw==
X-Gm-Message-State: AOJu0YyYKLGaMdH6xM2W/vY7tePhxNTBdUjre3XCFGG3ZaiG5czkLdJ6
	wTnRT3+DH/jWkCTarr80Yv4VBkTZJjSeeeot4/I44CDEK15LWdv9BFdnH/g6/Bw=
X-Google-Smtp-Source: AGHT+IFsgJH2k0H8AxKgo1cPjnYGlBKVWaD7erQXH2urhKh6k/6iVXSLFOTe87rGfcR0EwDfpB/ObA==
X-Received: by 2002:a2e:b8c7:0:b0:2ef:22ad:77b5 with SMTP id 38308e7fff4ca-2f751f69abcmr129789501fa.29.1726044944500;
        Wed, 11 Sep 2024 01:55:44 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-719090920adsm2544719b3a.135.2024.09.11.01.55.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Sep 2024 01:55:43 -0700 (PDT)
Message-ID: <d0a1012f-7485-4e34-9f6a-b03a1164f53f@suse.com>
Date: Wed, 11 Sep 2024 18:25:40 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Tree corruption
To: Neil Parton <njparton@gmail.com>, Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: linux-btrfs@vger.kernel.org
References: <CAAYHqBbrrgmh6UmW3ANbysJX9qG9Pbg3ZwnKsV=5mOpv_qix_Q@mail.gmail.com>
 <89131a4f-5362-4002-9a55-d1a24428ef05@gmx.com>
 <CAAYHqBZ+-3GbDmQFGxMcYs3HpO-DUQA4pCG0xqWMZW+sbw-KJg@mail.gmail.com>
 <331b4034-7a6c-4fa8-a10d-6fa87b801d21@gmx.com>
 <CAAYHqBaEEq8_AWKtMv9RtH4ZNtTEheCjAZzBstkrECt775UzJA@mail.gmail.com>
 <72315446-3ad4-40d1-8cff-1ec25ae207bd@gmx.com>
 <CAAYHqBYKQVNOyNbVBw=Xg2K2rXK0KTT7XDx3Ayn=SbNHtf53Lw@mail.gmail.com>
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
In-Reply-To: <CAAYHqBYKQVNOyNbVBw=Xg2K2rXK0KTT7XDx3Ayn=SbNHtf53Lw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/9/11 17:43, Neil Parton 写道:
> Is it safe to run 'btrfs rescue clear-ino-cache' on all 4 drives in
> the array?

Run it on any device of the fs.

Most "btrfs rescue" sub-commands applies to a fs, not a device.

And you must run the command with the fs unmounted.

>  Reason I ask is when this first occurred it was one
> particular drive reporting errors and now after switching out cables
> and to a different hard drive controller it's a different drive
> reporting errors.
> 
> It's also worth noting that this array was originally created on a
> Debian system some 6-8 years ago and I've gradually upgraded the
> drives over time to increase capacity, I'm up to drive ID 16 now to
> give you an idea.  Does that mean there are other gremlins potentially
> lurking behind the scenes?

Nope, this is really limited to that inode_cache mount option.
I guess you mounted it once with inode_cache, but kernel never cleans 
that up, and until that feature is fully deprecated, and newer 
tree-checker consider it invalid, and trigger the problem.

Thanks,
Qu

> 
> On Wed, 11 Sept 2024 at 09:04, Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>>
>>
>>
>> 在 2024/9/11 17:24, Neil Parton 写道:
>>> btrfs check --readonly /dev/sda gives the following, I will run a
>>> lowmem command next and report back once finished (takes a while)
>>>
>>> Opening filesystem to check...
>>> Checking filesystem on /dev/sda
>>> UUID: 75c9efec-6867-4c02-be5c-8d106b352286
>>> [1/7] checking root items
>>> [2/7] checking extents
>>> [3/7] checking free space tree
>>> [4/7] checking fs roots
>>> [5/7] checking only csums items (without verifying data)
>>> [6/7] checking root refs
>>> [7/7] checking quota groups skipped (not enabled on this FS)
>>> found 24251238731776 bytes used, no error found
>>> total csum bytes: 23630850888
>>> total tree bytes: 25387204608
>>> total fs tree bytes: 586088448
>>> total extent tree bytes: 446742528
>>> btree space waste bytes: 751229234
>>> file data blocks allocated: 132265579855872
>>>    referenced 23958365622272
>>>
>>> When the error first occurred I didn't manage to capture what was in
>>> dmesg, but far more info seemed to be printed to the screen when I
>>> check on subsequent tries, I have some photos of these messages but no
>>> text output, but can try again with some mount commands after the
>>> check has completed.
>>>
>>> dump as requested:
>>>
>> [...]
>>>                   refs 1 gen 12567531 flags DATA
>>>                   (178 0x674d52ffce820576) extent data backref root 2543
>>> objectid 18446744073709551604 offset 0 count 1
>>
>> This is the cause of the tree-checker.
>>
>> The objectid is -12, used to be the FREE_INO_OBJECTID for inode cache.
>>
>> Unfortunately that feature is no longer supported, thus being rejected.
>>
>> I'm very surprised that someone has even used that feature.
>>
>> For now, it can be cleared by the following command:
>>
>>    # btrfs rescue clear-ino-cache /dev/sda
>>
>> Then kernel will no longer rejects it anymore.
>>
>> Thanks,
>> Qu
> 

