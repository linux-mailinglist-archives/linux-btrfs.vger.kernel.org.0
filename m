Return-Path: <linux-btrfs+bounces-8541-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 279EB98FEE9
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Oct 2024 10:28:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 971221F2325B
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Oct 2024 08:28:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6D2E13D53A;
	Fri,  4 Oct 2024 08:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="LnrhfGBn"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE8B8211C
	for <linux-btrfs@vger.kernel.org>; Fri,  4 Oct 2024 08:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728030515; cv=none; b=HDPrIJ0XPpVqqR9SWgfTLEb56JxvO4+isEPLt/AI8cuReiFi5Ss7v3A3nH4Pa1zauJzD6JZuP15R9ukEVwrqRBhWlqI6EKkOyOKfjeqDrlDIADryuw6q8QR6EAfBkNlu/uBQDEgIHtczkqIqfdsprn+6ygG5LswCDRcRuUqxmWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728030515; c=relaxed/simple;
	bh=0fJbLoq9mIDXwTeh52ylb1L2LtadBsrsSTZQTW/zaEg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N0SDXEg2LkvMVuHaqugMiFydU43GXmiO8amKVo7DavviRSgmMlp0LOuUYzrNXdJfWektWuMyM+CLmt5BRHwURO98m6FmSISPHdZ/Y+gl30WCoMjdW4ZPAHl9ZAa5g07WsMVHFRBmGMfRP1fiW3gsYVx7e3sjFhCNJ+ktvz73bs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=LnrhfGBn; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2fabfc06c26so17863581fa.2
        for <linux-btrfs@vger.kernel.org>; Fri, 04 Oct 2024 01:28:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1728030511; x=1728635311; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=HzG5xPR5g81wDt/OTYNOXA+i/TCunKOk04bd7gMDF9c=;
        b=LnrhfGBn06wcaYb9aROlY5hit4xHQteGdBh/d5KdHDwA7loDXfIaA2BF+/P8U7y1e/
         SUWgu2af+DZViuS+ruMBcTvAsF+Tzhd5yjPimZwhgI9wDZ247DmGhGw8KaIxmWRR4uqT
         YeFk0fDB9Z6EMXM8w5acUfQRtgf3F3IW4CQ0hXsBMaQ+As9N+PCarrtQclp+ODvX6AQk
         s5fPfl36pGLtO2TRtDbcMx3z09HUZ+TeZvMrynqZiFcrRYvDfA4tqEsoAoxt7ig1khUZ
         2ZCMvS3RdF1E+on4jzo1XIHuobkpsdbnq4NetF8dnyHOMbrKAe6P4AfMsLxvpns50EA8
         3sdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728030511; x=1728635311;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HzG5xPR5g81wDt/OTYNOXA+i/TCunKOk04bd7gMDF9c=;
        b=pCcKIvhxxPYJB4tyNEDPeWJUFEWoXnn5oKrvk/z4TYS1o19iICLXmINZxRUhQ+4PKn
         HK3EiqyhXGHCh9OtNuhHEr3PdqXEhoxUp1ZpfV24GBWRNMaamww05DCmNVeRxJZrAoq9
         0AX1d3Yh/U1Mj01dLi0woK8SWFEN5oaTvm9mHQAjQuraQ+EVV7XhQn54hmW5xVN260Yi
         p2l4tDwl0lu/dWqQHwrCc61wILAATuooAFR0xkEO9iAiJnLzlnB9L5oHcxEznQ5KZ6Bn
         oYmP5o/wXwjQ/vDEgD4mZ03BeCmmVVPkvffBrwh2jWszJGTfogwZ/U7b1r+fyQN3fKY/
         U4pw==
X-Forwarded-Encrypted: i=1; AJvYcCXvogox7MC2DGSqU8MtMfN7yluJiu+zEokh4gV2ntoHUG/Wy3hcD9uVF3tZSXVXYkMolCx+c6crzj1Jvg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2K/PYzwocHcVew2//DNlVldg69UEy6Ad+dcA0KHxLTzZ6FjWc
	h2ybzvYTOCZYWNWdba//2k0pR5Jl342L8DKN7kE55nRmMCqmkYMCw3cbxYJyYKT5ue2oM5XvFRA
	V
X-Google-Smtp-Source: AGHT+IGuo49S6rGGjJxglyEn6F7W5saOMB4Zurt/ArLJijNivjoet37OdKsp3bhomnS7KKPhRzuwGg==
X-Received: by 2002:a2e:be90:0:b0:2f7:9d20:3882 with SMTP id 38308e7fff4ca-2faf3c63ec9mr10148771fa.22.1728030509028;
        Fri, 04 Oct 2024 01:28:29 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20beeca14bdsm19846505ad.64.2024.10.04.01.28.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Oct 2024 01:28:28 -0700 (PDT)
Message-ID: <84ddd011-9c58-4316-b9d5-c2f668fa354a@suse.com>
Date: Fri, 4 Oct 2024 17:58:24 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: BTRFS critical (device dm-0): corrupt node: root=256
 block=1035372494848 slot=364, bad key order, current (8796143471049 108 0)
 next (50450969 1 0)
To: Peter Volkov <peter.volkov@gmail.com>
Cc: dsterba@suse.cz, linux-btrfs@vger.kernel.org
References: <CAE+k_g+XFhkRBF0ErnRCBVaXAwUb3Tf9rm+Yny8u6aOLDQqihA@mail.gmail.com>
 <20241001150941.GB28777@twin.jikos.cz>
 <CAE+k_gJETiAtToyw9LoG3QWj-5Govupt9Shp9TFuqevSbt_RbA@mail.gmail.com>
 <094b3ff1-05f4-4557-80db-947a8224b671@suse.com>
 <CAE+k_gJcO=T=2amNoNWUEjq8hssmXxZw_KaOTUCqqJ_XvaBpYQ@mail.gmail.com>
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
In-Reply-To: <CAE+k_gJcO=T=2amNoNWUEjq8hssmXxZw_KaOTUCqqJ_XvaBpYQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/10/4 17:31, Peter Volkov 写道:
> On Wed, Oct 2, 2024 at 1:12 AM Qu Wenruo <wqu@suse.com> wrote:
>> 在 2024/10/2 02:40, Peter Volkov 写道:
>>> On Tue, Oct 1, 2024 at 3:09 PM David Sterba <dsterba@suse.cz> wrote:
>>>> On Tue, Oct 01, 2024 at 02:15:51PM +0000, Peter Volkov wrote:
>>>>> Hi! I've been using this system with this kernel (6.10.10) for a few
>>>>> months already and today out of nowhere btrfs broke with this error
>>>>> message:
>>>>>
>>>>> [53923.816740] page dumped because: eb page dump
>>>>> [53923.816743] BTRFS critical (device dm-0): corrupt node: root=256
>>>>> block=1035372494848 slot=364, bad key order, current (8796143471049
>>>>> 108 0) next (50450969 1 0)
>>>>
>>>> Quite obvious memory bitflip:
>>>>
>>>> 8796143471049 = 0x8000301c9c9
>>>>        50450969 = 0x301d219
>>>>
>>>> The first one should probably be 0x301c9c9, but it's impossible to tell
>>>> how many other data/metadata could have been hit by this or another
>>>> memory bitflip so check can detect the things but not fix.
>>>
>>> Thank you David! Is my understanding correct, that btrfs catches
>>> memory problems,
>>> so this bitflip most probably means that my drive is failing?
>>
>> In this particular case, it's your hardware memory, not the drive.
> 
> Thank you, guys! You are right. memtest showed memory errors.
> 
>> The error is happening at write time, so the metadata read from disk is
>> fine, thus not your driver returning some weird data.
>>
>> Furthermore, it's pretty hard that a simple bitflip can pass the
>> internal checksums of the storage device, thus it's very unlikely it's
>> your drive.
>>
>> So, please do a full memtest of your system before doing anything else.
>>
>> And considering your fsck result is already bad, it's no doubt that some
>> bitflip has already corrupted extent tree, and I believe the csum tree
>> is also corrupted.
> 
> So I have to start over from last backup. Or is it possible to fix
> some of this bitflips to read at least part of tree?

In theory, it's possible to fix the problem with complex manual 
intervention.

It will be an interesting adventure if you're a btrfs developer, 
otherwise it will be a weeks long communicating with some developers, 
and may still not fully repair everything.

I'd prefer to do a full restore onto a new fs, of course with all the 
hardware memory problem solved.

Thanks,
Qu
> 
> --
> Peter.


