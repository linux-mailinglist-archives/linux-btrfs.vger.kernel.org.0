Return-Path: <linux-btrfs+bounces-4905-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E4588C2C9A
	for <lists+linux-btrfs@lfdr.de>; Sat, 11 May 2024 00:27:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3F139B23C04
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 May 2024 22:27:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BC9E13D254;
	Fri, 10 May 2024 22:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="HHM4WQa1"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 447464F897
	for <linux-btrfs@vger.kernel.org>; Fri, 10 May 2024 22:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715380028; cv=none; b=M0UWCWxsB49zqOjkjhYLaa2mbuMEHPaZAdPAMcBDUX+RJjMznKt6mLhnhv1C14hcC125kCoiT2jHir/NCIUrxhV0kjtDCj9f3c+XucjDqxA9O1LS7v+LBH41UzvJ70jDsvgYEg+6yK9kn0TxoEBhemyeLWfQo3zn1ihgcVxi8e4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715380028; c=relaxed/simple;
	bh=HqBe3I9gvLAajUCJaYZF4k8kJr4ujtRq7xpcsoBfglM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W90p5Z7MUzmSnxKvF99PD7C6CfbT/AlOsQwzLBUo+m+kSXk/WHJdnrVtXCVnttLYeTfW9RpYl/dfpN7a2UQ0ZtCvi0aPV2v64CUvhn+6BMuuzqdpuNOxHXy+FtpeEFTcI/B/O79mFear9ZRnXlY4quojN/Id4BZaBfQBFmbR2mU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=HHM4WQa1; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2e09138a2b1so30356011fa.3
        for <linux-btrfs@vger.kernel.org>; Fri, 10 May 2024 15:27:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1715380024; x=1715984824; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Qa1A4+tUxT75LFZiThMg56cRmvo2br33B2iviRFrASY=;
        b=HHM4WQa1ecYwzyp1HulX9sJIc8mCFCarDrRf2K3h8yK/NteYkC3eaVXMIPNg2gSE4b
         l6m45h05dO6Ez7DVSP2fJk0Bt7oPMEfy0vLnYsuCizHycTaVnMAOWcQoW9xGcgHU22ze
         IDZP5l2jegI3KwMLZelzIclxOsIRZxEFsTQ3XmcB+4VMGgS4kElCycYSj/oO8mkX7NTf
         saW+4Gy6zdLZkF6MoE3p3UYGb5QpBWv1fJ7QfC8Fcyj6mlqxwbxer5hhh+0VTiyCwA/w
         wOn3mVEjBjgzckBLJtJmyjpickr5yiK32mMuLX+Vf/q0s0tywYojOdzNlmkcK4aOgF3z
         DukQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715380024; x=1715984824;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qa1A4+tUxT75LFZiThMg56cRmvo2br33B2iviRFrASY=;
        b=IhOHlGhhGIgMJ0MrVBiJZm6Gnfh2tVOtCVHSm+tRvqgdrQqhHMKRF65WvskJG5Am6D
         eTrBRCH19zSjGtlmLPLb85yS4247ZAf3gJcWE7TZEa9QQkxLssJMIuUCdL6BHnbgLZ73
         HKBOig1SCwMq/pZ1Gq3NJcQIXlZrS5bP/OHccXSiF96ty01sDGxpIBN3vFQfEujLa0lE
         JJTE98iBaqQlQfdL8QV4/SAvwMVcFbCKLf8HmX+tWHrr6e4jXCe3sdLq9zk7G1XmjGST
         JSitcSyaqr++MUi0EhsLcvnPrAH8BYJFiQV5NBLqVr7CwWVGW6e0MzdZ/bm3ADZxObd8
         i1+g==
X-Gm-Message-State: AOJu0YywNnyaka5bWNer/cc09w3j48bf8m2eoZSi2DqiyQP5HYXB7FJU
	ypXnvNXrJsLGf00x3+KkJk1h+pwfk5QL5QripDXl5ZLAhzNUmSA/XBOpJaldvTM=
X-Google-Smtp-Source: AGHT+IEm7eqrZscm8GSkZRqT/EokQlOv6x7WGuqhZCDJuU5doRIStpCzmTilWl0GjQodYhdE70xhGg==
X-Received: by 2002:a2e:7a0b:0:b0:2e2:72a7:843c with SMTP id 38308e7fff4ca-2e5204ccdc2mr25291881fa.36.1715380024298;
        Fri, 10 May 2024 15:27:04 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-6340a449f4csm3566039a12.4.2024.05.10.15.27.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 May 2024 15:27:03 -0700 (PDT)
Message-ID: <f545d678-3494-4185-a8b1-384df1b9b8ae@suse.com>
Date: Sat, 11 May 2024 07:56:57 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/11] btrfs: introduce new members for extent_map
To: Filipe Manana <fdmanana@kernel.org>, Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
References: <cover.1714707707.git.wqu@suse.com>
 <f0be8547f0df8d8a4578c5e4d9b560c053dab8db.1714707707.git.wqu@suse.com>
 <CAL3q7H7uWw=LnWYXZnZV+kYKho+F4iBcBgZ5GziWeTofVPLDYw@mail.gmail.com>
 <1fe28d75-a4a3-4304-9998-a88a5fee4919@gmx.com>
 <CAL3q7H6rz9Z8xCbsjvqaEQC34m7uiM_FH1ecW+PQC5kARWKxrA@mail.gmail.com>
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
In-Reply-To: <CAL3q7H6rz9Z8xCbsjvqaEQC34m7uiM_FH1ecW+PQC5kARWKxrA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/5/10 20:56, Filipe Manana 写道:
[...]
>>
>> Check case 1).
>>
>> Both file extents are referring to the same data extent.
>>
>> Like this:
>>
>> FE 1, file pos 0, num_bytes 4K, disk_bytenr X, disk_num_bytes 16K,
>> offset 0, ram_bytes 16K, compression none
>>
>> FE 2, file pos 4k, num_bytes 4K, disk_bytenr X, disk_num_bytes 16K,
>> offset 4k, ram_bytes 16K, compression none.
>>
>> In that case we should not just sum up the disk_num_bytes at all.
>> Remember disk_num_bytes are for the data extent.
> 
> Yes, but for cases where they refer to different file extent items
> that are contiguous on disk, the max is confusing, and a sum is what
> makes sense. Example:
> 
> FE 1, file pos 0, num_bytes 4K, disk_bytenr X, disk_num_bytes 4K,
> offset 0, ram_bytes 4K, no compression
> 
> FE 2, file pos 4K, num_bytes 4K, disk_bytenr X + 4K, disk_num_bytes
> 4K, offset 0, ram_bytes 4K, no compression
> 
> When merging the corresponding extent maps it's natural to think
> disk_num_bytes is 8K and not 4K.

The max based solution is based on their end bytenr, not disk_num_bytes.

So the merged one would have:

disk_bytenr = min(X, X + 4K) = X
disk_num_bytes = max(X + 4K, X + 4K + 4K) - disk_bytenr = 8K.

So I didn't see why it's not natural.

Furthermore, the max/min based solution can handle both case 1) (same 
data extent, different parts) and case 2) (different data extents) well.

> 
> But as I mentioned before, after merging we really don't use
> disk_num_bytes anywhere.
> It's only used during extent logging, which only happens for extents
> maps that were not merged and can not be before they are logged.
> 
> Before this patchset, when disk_num_bytes was named orig_block_len,
> that was never updated during merging, exactly because we don't use
> cases for it.

But since we want everything to match the definition of the same-named 
member, no matter if they get merged or not, we need to change the values.

If they do not get used, that's still fine.

Thanks,
Qu

