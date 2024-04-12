Return-Path: <linux-btrfs+bounces-4182-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE9068A2CC6
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Apr 2024 12:45:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 16D6FB24D18
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Apr 2024 10:45:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3583F4436E;
	Fri, 12 Apr 2024 10:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="SI5U4Gzd"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06B8F3CF79
	for <linux-btrfs@vger.kernel.org>; Fri, 12 Apr 2024 10:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712918737; cv=none; b=hpqFQWvdyXBFq+WFTOpED5BreYpF1IJ29Og5pcIMxWLAksKdoiNxtoakgs86CgR3xn8aHganfq8i5kRU2wr04psVf47qmKYw1wYHbVEtW0bjbdaZWvAkTKzQbbVnqG4FWfS4pgQJolrv/tLxFs4URLhp5kcd1cSg8PY0G29NUOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712918737; c=relaxed/simple;
	bh=lp8PZYGj++jlCn9NZ+HClEYCWy2Wqdq7gXTeuknAZ/o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bFp2v0LIhlYLz26DgdjaacEwXuXJwdFc1f4A2Orqw+QKBVYtw7A2cGkyOpSXc2/wnA2I7XOfU0+Ws5Xdm9oDkDhujdSlZecdH1uCT2/3hpkbY5HwayM3Ba9NOvV9n334RQPcJqyJDivm5ePNEdTYG++ZWdogm7vzzA3Uugo53J4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=SI5U4Gzd; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2d8b4778f5fso6132791fa.3
        for <linux-btrfs@vger.kernel.org>; Fri, 12 Apr 2024 03:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1712918733; x=1713523533; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=sDnSdYikqn0KM9V+ejmXtdl3J7iT9/SYB4inrVUmIWE=;
        b=SI5U4GzdGf3KhjGFmNMiki5wi/mvcMDAuSD8lS0eLedzkgcMFbdI2TyNDZNcax11Px
         DsHrYeZ+TxgLuPnZs3Fiq5XC89OjFAuA06FceJV/18DdzFaiqX38ol8Q6CfrNzz94R7m
         VOpXYyiAaxwgJm695PpUyK9R3PHuA4uNTwmqtAdBTiNhypWAoWotKVs+fI91PGEGcPZz
         ohtyZvIQwkKMWbz8/83yY4TAubjXJNxRQmBNqAGCsUdvy5jzCxnqltwUxaDLEoZg6tNq
         hsWEwABUCYduoHHmEOZxgIR5UOCNYDd6qlrXBo43gDgd5X8pQ+1X/hQZ7RpxgE7qJuiI
         kNMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712918733; x=1713523533;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sDnSdYikqn0KM9V+ejmXtdl3J7iT9/SYB4inrVUmIWE=;
        b=MTgMR38M0Mo05SGg5+hDs26AsA7UxXvuz2DeSuT8OmVYNhhdW1xliLkpGy/TMA9O6u
         xz1oRh7n0UD7mL6RRZpL/HZW/ibFPBq6z9DOwGqgVLehVH2aQ0CZP6H8hkufumJgq++Q
         hOYX/5c/l2qtkEMfL8DArX+38h1xX8rXmZG0+lbDX+flHHM696xDs+V6MHu6momXfvvj
         9Ilm+/5kPMzVza9HeBrnCFrXfrkopmu7ffVLkgGfh8RcoZx36eNIheRed2bO3J7lNeKj
         lJasaRgpxBQPPISBcXAoRoNVVy1Zhcfl1ijVTh5CRcd83U6KdN1WTcvwU9Mfq+RFHCPA
         KUxA==
X-Gm-Message-State: AOJu0YxfovGkyK8zahHYhBpU7yGAlCqLUjQoRjn4otz9VQAEaKwanrJn
	f0MAVa+/T07acqz8hHr32qY+FM1Typ4OlSgX6NrxDfmsbr8lmTYkFki/fM09YSP94aeZTEHzkNr
	O
X-Google-Smtp-Source: AGHT+IFNu2IzPNnn1ncWaLaqIf72e+EeWs3i6zB5///MSLkFuKO6qZ0GY4b9Y1QAqbGlfxDlq6ZRLw==
X-Received: by 2002:a2e:a0d5:0:b0:2d8:6ca0:3290 with SMTP id f21-20020a2ea0d5000000b002d86ca03290mr1776740ljm.29.1712918733053;
        Fri, 12 Apr 2024 03:45:33 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id e9-20020a17090301c900b001e27c404922sm2688047plh.130.2024.04.12.03.45.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Apr 2024 03:45:32 -0700 (PDT)
Message-ID: <2a688a2e-a956-4bec-a231-372ec7134003@suse.com>
Date: Fri, 12 Apr 2024 20:15:28 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/3] btrfs: more explaination on extent_map members
To: Filipe Manana <fdmanana@kernel.org>
Cc: linux-btrfs@vger.kernel.org
References: <cover.1712875458.git.wqu@suse.com>
 <CAL3q7H7smJkLMYnSP0akpsc_nORFN4bLp_Wp4VxA2nytxp8Few@mail.gmail.com>
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
In-Reply-To: <CAL3q7H7smJkLMYnSP0akpsc_nORFN4bLp_Wp4VxA2nytxp8Few@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/4/12 20:01, Filipe Manana 写道:
> On Thu, Apr 11, 2024 at 11:48 PM Qu Wenruo <wqu@suse.com> wrote:
>>
>> [REPO]
>> https://github.com/adam900710/linux.git/ em_cleanup
>>
>> The first 3 patches only. As later patches are the huge rename part.
>>
>> [CHANGELOG]
>> v4:
>> - Add extra comments for the extent map merging
>>    Since extent maps can be merged, the members are only matching
>>    on-disk file extent items before merging.
>>    This also means users of extent_map should not rely on it for
>>    a reliable file extent item member.
>>    (That's also why we use ordered_extent not extent_maps, to update
>>     file extent items)
> 
> So this isn't true.
> We use information from the ordered extent to create the file extent
> item, when finishing the ordered extent, because the ordered extent is
> immediately accessible.
> We could also use the extent map, we would just have to do a tree search for it.
> The extent map created when starting delalloc or at the beginning of a
> DIO write is pinned and in the list of modified extents, so it can't
> be merged and it represents exactly one file extent item - the one
> going to be inserted the inode's subvolume tree when finishing the
> ordered extent.

If you're doing COW writes, extent map is fine, as it's always new 
extents and they are all pinned thus won't be merged.

For pure NOCOW, it's also fine because there would be no extent map 
inserted, nor updating file extent items.

But for PREALLOC writes (NOCOW into preallocated writes), it's not the 
case as the target extent maps can be merged already.

Thus that's why for NOCOW we go with a subvolume tree search to grab the 
correct original disk_bytenr/disk_num_bytes/offset to go.

If you use extent map instead of search subvolume tree, the following 
layout can screw up everything:

Filepos 0:
disk_bytenr X, disk_num_bytes 64K
num_bytes 64K, offset 0, ram_bytes 64K

Filepos 64K
disk_bytenr X+64K, disk_num_bytes 64K
num_bytes 64K, offset 0, ram_bytes 64K.

The extent map would be (after merge):

filepos 0, len 128K block_start X, block len 128K, orig_start 0.

Even with my new disk_bytenr it would be no difference, the disk_bytenr 
would still be X, and disk_num_bytes would be merged 128K.

So the merging behavior is affecting PREALLOC writes, and we're already 
avoiding the only pitfall.

Thanks,
Qu

> 
>>
>> v3:
>> - Rebased to latest for-next branch
>> - Further comments polishment
>> - Coding style update to follow the guideline
>>
>> v2:
>> - Add Filipe's cleanup on mod_start/mod_len
>>    These two members are no longer utilized, saving me quite some time on
>>    digging into their usage.
>>
>> - Update the comments of the extent_map structure
>>    To make them more readable and less confusing.
>>
>> - Further cleanup for inline extent_map reading
>>
>> - A new patch to do extra sanity checks for create_io_em()
>>    Firstly pure NOCOW writes should not call create_io_em(), secondly
>>    with the new knowledge of extent_map, it's easier to do extra sanity
>>    checks for the already pretty long parameter list.
>>
>> Btrfs uses extent_map to represent a in-memory file extent.
>>
>> There are severam members that are 1:1 mappe in on-disk file extent
>> items and extent maps:
>>
>> - extent_map::start     ==      key.offset
>> - extent_map::len       ==      file_extent_num_bytes
>> - extent_map::ram_bytes ==      file_extent_ram_bytes
>>
>> But that's all, the remaining are pretty different:
>>
>> - Use block_start to indicate holes/inline extents
>>    Meanwhile btrfs on-disk file extent items go with a dedicated type for
>>    inline extents, and disk_bytenr 0 for holes.
>>
>> - Weird block_start/orig_block_len/orig_start
>>    In theory we can directly go with the same file_extent_disk_bytenr,
>>    file_extent_disk_num_bytes and file_extent_offset to calculate the
>>    remaining members (block_start/orig_start/orig_block_len/block_len).
>>
>>    But for whatever reason, we didn't go that path and have a hell of
>>    weird and inconsistent calculation for them.
>>
>> Qu Wenruo (3):
>>    btrfs: add extra comments on extent_map members
>>    btrfs: simplify the inline extent map creation
>>    btrfs: add extra sanity checks for create_io_em()
>>
>>   fs/btrfs/extent_map.h | 58 ++++++++++++++++++++++++++++++++++++++++++-
>>   fs/btrfs/file-item.c  | 20 +++++++--------
>>   fs/btrfs/inode.c      | 40 ++++++++++++++++++++++++++++-
>>   3 files changed, 106 insertions(+), 12 deletions(-)
>>
>> --
>> 2.44.0
>>
>>

