Return-Path: <linux-btrfs+bounces-7112-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 790AE94E7E9
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Aug 2024 09:35:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3091A2812F8
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Aug 2024 07:35:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E08E315886B;
	Mon, 12 Aug 2024 07:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Mr+Tmc35"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA259154C02
	for <linux-btrfs@vger.kernel.org>; Mon, 12 Aug 2024 07:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723448129; cv=none; b=rSCPprAepi5KqfTmeF7SqgjApwGfoccj6mIukD92bU4nmZN4kbu64WZpYxUVc5jTG19ELIPDzvyuCsVKVlHjk5ffruWqJNyf/ob+NF0TTMCZo2pzx97Xum/kdKa5WQ9LlNXA0PE7FwWA9QVXa6GxAdJrscg4QZOTBdjSJ5mhLm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723448129; c=relaxed/simple;
	bh=8RhYgHBo01v/JNAjaW3ra1yrcqwXLXWo/tFqIoQJKFo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gGfnsI3AFZpzuQdkPVNy6lxNkUWLvH3mXJViQCZL+GeqjbGkC8UCPqq8F9vdEj+d/IfdA+0mAh/QtrK4HtQT+Ont1G3BUnj9Flq9yYXZSBkl1SxhStpLJ3BtWmS3ERWNlBqbPTP5SRL0nI1XJcyeVtQp6B0VpS4yMrxgeQq0Oxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Mr+Tmc35; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-52f024f468bso4650959e87.1
        for <linux-btrfs@vger.kernel.org>; Mon, 12 Aug 2024 00:35:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1723448125; x=1724052925; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=89UBBiMa2YQMEe2sa9f2Bkio6hJrlCTCKOfqYcbzq7M=;
        b=Mr+Tmc35EEYm+XEONt9EwYy1jCdpMhGyV4EkHrI7QfVQNa52fej+y2cmFn6kAgO0Li
         2GvW/TRaHeQ+NBLubT0jcBlcUuKVcgJw9nJMspqfAbzz9aJgbSmtOlbezeMCvz5aSycf
         qCZKgokiwm4HeVBOSMyRMcG0TAFUx6uJidat8Q1KXOzv6lJHTQX8WyVqth7cYinQBC0u
         0KVyJlsIGuosiGARtK+MK4bLspALS7i6pcq9+Pguv+49c6sX8zx4nDdhXK9OF7htOpmW
         Pjxa8czUrld+kA35YetNlnlkgsH9NN/yruLpZvT2YLFWXutbhREFUuva6YTDlUubLK2Q
         CHLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723448125; x=1724052925;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=89UBBiMa2YQMEe2sa9f2Bkio6hJrlCTCKOfqYcbzq7M=;
        b=iEE76q1Tq8QojCMRpJze6obFyEARpA2cO8EFqrsSDYR8LLIoEQcZDjG7ztyXNQUyoj
         59PDd8FuQfkZG1jsrcx6UtA3FyWGbUuS/vkFPEtjyRMCzXSLNV29UWmbMeS1gZP92ZJk
         glPXxYa3b7lFwgcCcrkIxNt4gBwGbJq3s/rhpBIMzkFMF5C+e1cBTVQCgUJEYvFArPEV
         8MuS/3Y9PMiwIq1g+ZJWWUCf0B6ZnclAWVXUqOPelj9bSnZGoVW5X98ti15/2B6xnLZZ
         D3xBUXNamO7/Ne8H0l5F/3iPFZFab6qUHURwSl1jWvmjkLW4BKImdxQtZ9rP2QhJj3pJ
         K5Mg==
X-Gm-Message-State: AOJu0YzjIMJ0xnPP6wU1F02LoXn1v1iLWEbnTa9IlxRoYXr1pD72dpvy
	r1Z2j0+Bt7dIQl511YeB9NlegARMMatHIeZGoGXUDGiRsNdh7W6vGjTgR7es8u4=
X-Google-Smtp-Source: AGHT+IEc7kV2rDilaRJFbWfqK4+DNePfj9WECBgjk3oCawU375TmzwYzsL4cJ1iLmXmeHFknKhgWZw==
X-Received: by 2002:a05:6512:3d0d:b0:52e:9ba5:9853 with SMTP id 2adb3069b0e04-530ee9be11bmr6623062e87.24.1723448124223;
        Mon, 12 Aug 2024 00:35:24 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-200bb7eedc6sm32155405ad.13.2024.08.12.00.35.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Aug 2024 00:35:23 -0700 (PDT)
Message-ID: <7bc8aa3b-f5c1-4db5-b588-4332af4bdda6@suse.com>
Date: Mon, 12 Aug 2024 17:05:19 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Help! Unmountable due to dev extent overlap
To: Stefan N <stefannnau@gmail.com>, Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: linux-btrfs@vger.kernel.org
References: <CA+W5K0rSO3koYTo=nzxxTm1-Pdu1HYgVxEpgJ=aGc7d=E8mGEg@mail.gmail.com>
 <ac2ff9ae-b2fa-49df-9ce3-fc32ddd3c222@gmx.com>
 <CA+W5K0qUAXYSZFxJv+vVM+knFkXm+VK61zOb2qF6TXmW156LOA@mail.gmail.com>
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
In-Reply-To: <CA+W5K0qUAXYSZFxJv+vVM+knFkXm+VK61zOb2qF6TXmW156LOA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/8/12 16:30, Stefan N 写道:
[...]
> dumptrees stdout is 50mb bzipped for all devices (no output to
> stderr), so have uploaded to https://filebin.net/92cnqpr9xx9565oe
>  From this output, sda (devid 4) and sdm (devid 13) are the two that
> btrfs check is complaining about

Oh, forgot to mention, dump-tree output is always per-fs, no need to do 
it for each device, as the result will be the same.

[...]
> 
> # btrfs check --mode lowmem /dev/sdb
> [1/7] checking root items
> [2/7] checking extents
> ERROR: dev extent devid 4 offset 14263979671552 len 6488064 overlap
> with previous dev extent end 14263980982272
> ERROR: dev extent devid 13 offset 2257707008000 len 6488064 overlap
> with previous dev extent end 2257707270144
> ERROR: errors found in extent allocation tree or chunk allocation

This matches the result from the tree dump.

Only device extents are overlapping, but still matches the corresponding 
chunk items.

For the devid 4's result, there is no direct bitflip indication.

But for the devid 13's, it's a bitflip, and I guess the bitflip happens 
during the free extent lookup routine:

hex(2257707270144) = 0x20da9d70000
hex(2257707008000) = 0x20da9d30000
diff               = 0x00000040000

So my guess is, at least for dev 13, during a dev-extent lookup routine 
called for chunk creation, bitflip happened for the lookup of the last 
dev-extent's end (should be 0x20da9d70000, but one bit flipped from 1 to 
0), causing btrfs to use the corrupted value for the new device extent.

> [3/7] checking free space tree
> [4/7] checking fs roots
> [5/7] checking only csums items (without verifying data)
> [6/7] checking root refs done with fs roots in lowmem mode, skipping
> [7/7] checking quota groups skipped (not enabled on this FS)
> Opening filesystem to check...
> Checking filesystem on /dev/sdb
> UUID: 3cde0d85-f53e-4db6-ac2c-a0e6528c5ced
> found 104088092352512 bytes used, error(s) found
> total csum bytes: 101533362472
> total tree bytes: 117929181184
> total fs tree bytes: 1742323712
> total extent tree bytes: 1548320768
> btree space waste bytes: 11865883351
> file data blocks allocated: 139229426343936
>   referenced 139218099167232
> 
>>> # uname -a
>>> Linux mynas.x.y.z 6.8.0-39-generic #39-Ubuntu SMP PREEMPT_DYNAMIC Fri
>>> Jul  5 21:49:14 UTC 2024 x86_64 x86_64 x86_64 GNU/Linux
>>
>> I guess your NAS is running this newer kernel even before the first
>> warning? Or is there any older kernel involved?
> 
> last reports that this 6.8.0-39 kernel (Ubuntu noble) was active from
> 30 Jul, I recall I did a release upgrade a few days after the replace,
> so yes the errors all occurred while running this kernel. Prior to
> this, it appears to have been running 6.5.0-44-generic and earlier 6.5
> releases for 9 months (Ubuntu mantic).

OK we can rule out older kernels.

> 
>> A quick glance into the tree-checker shows that we do not have any
>> checks on dev extent items.
>> And I guess that's why we didn't detect the corruption in the first and
>> let the corruption sneak in and written the corrupted one onto disk.
>>
>> But my current guess is, it looks possible some kind of bitflip sneaks in.
>>
>> Just to be sure, after taking the dumps, please run a memtest just in case.
> 
> I've got memtest86+ running now to confirm, will confirm the output
> next response

Waiting for your result, and I bet it will find something.

And I have already submitted a patch to detect the corruption and 
prevent it from corrupting the on-disk data in the future.


Unfortunately I have no idea how to fix your fs at all...

The overlapping can indeed lead to data corruption (since the 
overlapping dev-extents will be overwritten eventually from two 
different data chunks).

And since their chunk items are completely valid, I can not simply craft 
a dirty fix to modify the value of that dev-extent, as that will cause 
problems for dev-extent verification against chunks.

And if I need to modify the chunk items, it's going to cause a chain 
reaction to modify all the other dev-extents and dev items and superblocks.

So I can only recommend to backing up your data (may hit EIO if unlucky 
enough), and rebuild the whole fs.

At least your sacrifice will be remembered in the kernel git log forever...

Thanks,
Qu
> 
>> Thanks,
>> Qu
> 

