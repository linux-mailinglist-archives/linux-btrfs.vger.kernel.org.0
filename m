Return-Path: <linux-btrfs+bounces-2651-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 547C98603B4
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Feb 2024 21:34:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2FBDAB2326C
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Feb 2024 20:34:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71A0A6E602;
	Thu, 22 Feb 2024 20:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="DJR5J9Gh"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 374A710A05
	for <linux-btrfs@vger.kernel.org>; Thu, 22 Feb 2024 20:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708634048; cv=none; b=BDHAKsHNHbbNbneqsG/19pq1HQOvnLG6Qh0xtsmjyIHNYaOr7wDH7f0DVFYiyfq3tIpSVjJHm5Vi5s/Ub9tyGVp7lHHXACriQ//KpoxedWCnrJx7QwLk/Vey5TI+klzV9Ze+SWKCvwtIVFvqxj3RfFDYFnWKTK1tPwd8Tvhl0v0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708634048; c=relaxed/simple;
	bh=rcH5ippQxZg14dfHlQ4UtSa+EHGd1Kzc4OuTGH+X6lc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bzBPjxwiJf/6LQB9zGw0r3w1nPpE2xuqfwylS1uWfPv2c9mKFLAY3quCNty0TBC4aXhIxqmfnWK9TsmfWtCfy77Wb7fwsg0Ya9tNChp75zTNM2EYXQHOvJxRllciIho36kH9H2pS2rVa40y6wYe37Pxzh3jJVWRqSqGmbw3fDcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=DJR5J9Gh; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2d180d6bd32so2730831fa.1
        for <linux-btrfs@vger.kernel.org>; Thu, 22 Feb 2024 12:34:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1708634044; x=1709238844; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nybO0QDsvP8znZ+cHOr0WHOhMbopeKUPUyqzg12JGkc=;
        b=DJR5J9Gh+jes+Dd4rHPxSDV+YJeC9uXgTO0eitajuRzbcLxcEkV5heIW08F0JHZaaa
         JNxyXQlLEd0MmjImuzLialF9DfCzqcJWBWM+JVsSqEIfV2Hj5JW4f+NbWEF+iOyl9qcc
         E2ugQxju1JvveNcMcNaFMfoqq3fdzg1BSSMZhpn22KKd33bUN+oEvUS90mvy0CPSt44I
         zato3EDu/Uys2ScRIAIaxJtf+bG/EczXPqdBgdxMTx5hVhbkM+7k93fs2T6APe0gpX9w
         KJ10UqR68dqcS2ZaGRYbVMAHpWi6kZAsC75UDGbd0DNO7quYn+HV3Gw32kyTqNhWQQTv
         3xmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708634044; x=1709238844;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nybO0QDsvP8znZ+cHOr0WHOhMbopeKUPUyqzg12JGkc=;
        b=Ww0gjwZHMlPnFSAuD+TwEseW5MfumRHyFkbZXTNU5ZKAEZk1rBJpC6LhKQ46fHyQjd
         HUSQlEZegvAJGs5hBT2x5oB0OTV8+oDoc+SSbz/49eFfrEMddsH7K4hR2qr4txJt/vAk
         EfZt5upwheu4wbNla+SwfBqdPVpsOyemrwUqo4Fc0aIWUDks01jZQk9FCoqL9ZgNpJWt
         JKARr/LQIl/iE4cxiBd4hcUgmBRH+Z22NO7P/Vz4fB7wsCQEcizH2Ca3+9GEBWK6MOta
         UkV1E/Jolh/FxWtjDkmuUAn9SJ0aSfx3bt2tGWt+H0Hf75+Ot1ekAoCfXcI3bsEPOFis
         Vu6g==
X-Gm-Message-State: AOJu0YwRwaT3kaaLTUxedO5H9lzguXZ2NXBOwNWVhZI2saA9EKi0hjMm
	DoUOX8WqCQMzzWKlL39vgLwUYOZq/KUF0geAi8/tqWWuI8FHcVZI4m4xcEU0OGY=
X-Google-Smtp-Source: AGHT+IHc9oM5gAaIgZl7k2uY2gPH+eBn0mNHwC/8o8As3I8GDyKA/JrT98UQYtIxF9ebwSbrg3v79A==
X-Received: by 2002:a05:651c:b1f:b0:2d2:3758:8c30 with SMTP id b31-20020a05651c0b1f00b002d237588c30mr83637ljr.43.1708634044264;
        Thu, 22 Feb 2024 12:34:04 -0800 (PST)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id u5-20020a170902e20500b001dc1088357asm5925350plb.1.2024.02.22.12.34.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Feb 2024 12:34:03 -0800 (PST)
Message-ID: <dbda7023-97f7-4635-a913-7032f350d36b@suse.com>
Date: Fri, 23 Feb 2024 07:04:02 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] btrfs: make subpage reader/writer counter to be
 sector aware
Content-Language: en-US
To: dsterba@suse.cz
Cc: linux-btrfs@vger.kernel.org
References: <cover.1708151123.git.wqu@suse.com>
 <20240222115406.GN355@twin.jikos.cz>
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
In-Reply-To: <20240222115406.GN355@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/2/22 22:24, David Sterba 写道:
> On Sat, Feb 17, 2024 at 04:59:47PM +1030, Qu Wenruo wrote:
>> [CHANGELOG]
>> v2:
>> - Add btrfs_subpage_dump_bitmap() support for locked bitmap
>>
>> - Add spinlock to protect the bitmap and locked bitmap operation
>>    In theory, this opeartion should always be single threaded, since the
>>    page is locked.
>>    But to keep the behavior consistent, use spin lock to protect bitmap
>>    and atomic reader/write updates.
>>
>> This can be fetched from github, and the branch would be utilized for
>> all newer subpage delalloc update to support full sector sized
>> compression and zoned:
>> https://github.com/adam900710/linux/tree/subpage_delalloc
>>
>> Currently we just trace subpage reader/writer counter using an atomic.
>>
>> It's fine for the current subpage usage, but for the future, we want to
>> be aware of which subpage sector is locked inside a page, for proper
>> compression (we only support full page compression for now) and zoned support.
>>
>> So here we introduce a new bitmap, called locked bitmap, to trace which
>> sector is locked for read/write.
>>
>> And since reader/writer are both exclusive (to each other and to the same
>> type of lock), we can safely use the same bitmap for both reader and
>> writer.
>>
>> In theory we can use the bitmap (the weight of the locked bitmap) to
>> indicate how many bytes are under reader/write lock, but it's not
>> possible yet:
>>
>> - No weight support for bitmap range
>>    The bitmap API only provides bitmap_weight(), which always starts at
>>    bit 0.
>>
>> - Need to distinguish read/write lock
>>
>> Thus we still keep the reader/writer atomic counter.
>>
>> Qu Wenruo (3):
>>    btrfs: unexport btrfs_subpage_start_writer() and
>>      btrfs_subpage_end_and_test_writer()
>>    btrfs: subpage: make reader lock to utilize bitmap
>>    btrfs: subpage: make writer lock to utilize bitmap
> 
> So this is preparatory work and looks safe to me, only adding the
> bitmaps to counters, you can add it to for-next.

Got it.

BTW, this series is only stable enough after testing the whole series 
(so that no new extra changes required by later subpage delalloc behavior),
which ran fine locally at least.

