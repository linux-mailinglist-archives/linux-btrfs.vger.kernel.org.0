Return-Path: <linux-btrfs+bounces-3505-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 973A588642D
	for <lists+linux-btrfs@lfdr.de>; Fri, 22 Mar 2024 00:59:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40FDC1F21567
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Mar 2024 23:59:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 937A931A8F;
	Thu, 21 Mar 2024 23:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="AbzPVFtv"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EF683232
	for <linux-btrfs@vger.kernel.org>; Thu, 21 Mar 2024 23:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711065571; cv=none; b=teVXPlxUizMbEifWXdAg6SiUxwgLmKjoHLXTsJCgrNN3HTCUXHH2Txzr9Fsv05yne+4rUpaTSV3AnMUETjwDmzdH/RoOuzY2mihZDZqcH9K7GcTPJIYP4m0uUAVhCgxXfusw4WKpN+LQXSKj3O/Q2RqmN3X7AkWq3um+vhmXeZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711065571; c=relaxed/simple;
	bh=Lz3oc5PuPFAVKQW4nJxXCCzdELjce/C/PMvHdazaWI8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Kly4csnLyPYqeBLy7SsLtb3Bnjbx/UmPFdvPBimuitGT8L20p8xy6Kphy69vwZqlbIHPu0dQXv+2dr2/Y+otNJzxvgTG4fW8L5bntohvi1eouhu5g2eHYI1VhXumIwG4tAKVqO5Pn6gPlH/iEme5JoaA0gKd1k1HeXkTULamxtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=AbzPVFtv; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2d094bc2244so22187341fa.1
        for <linux-btrfs@vger.kernel.org>; Thu, 21 Mar 2024 16:59:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1711065566; x=1711670366; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/VzTlGd8NCvOViYJGspvmltYNuzNPZSemHZyxJhYluM=;
        b=AbzPVFtvFrjf5DbmmU7U+jxMAWkUBJnSrDbIIvNhIRBdBVBvvsR5teo/H/J9BmQRt0
         TyesRq4uKQD7ER0/kccMDiQNHJ2DJ50HEmGkcbhQK7SnKLUb3kTLMVUMIJzZ1B4QB9BP
         Z6LF08XieqbHnIuXUWFSCwCRBXoxuvi1RRz9RQ4Vzn/P7go3g5pyeQT/K46DJa0cm8YG
         2AYfy9pddWTvwVLphYFdqSXv1nilr22WxAYiKL+t4ZtbEcgZlw/U7Dr0c+5u5TlZcOk2
         PHeEgZLkhVeAj8S7mYETShY6WCVZGdTpg2TEj6gfLvEirXCh5TqA6f+W2LZ1HZI3dji6
         RaMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711065566; x=1711670366;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/VzTlGd8NCvOViYJGspvmltYNuzNPZSemHZyxJhYluM=;
        b=XuM+BUULTPPy57QNg5i61nTWVwRrGMSBrlWu5lYuAYT8mkAbLB/wORSbW7ZUmDFY2a
         Qs8hOZP8J3FAXVpBMr0ChHjOeG/2S9WhkIKmRd1dmte4FzB1eYwANz04vcA/xX7f1J85
         YKvW5x5P6abF0uyrhMz//qCdm3hUW94kAYgMw5CabItArpYqc23cjAneguQ9IUc/rHuB
         ZcPUAiPLT0EMEqWV/soNub2/x1M/Lrl5uQ+a2u8AaMi20hMEKyOVRjotKUk8pGPFlVkS
         cLwk/i7o95mH+idHGoNPq1UfUHzjAkghA7QryyuKCKPSyI6iCtXNzMMW35Ek1KCKyMBY
         fDDQ==
X-Gm-Message-State: AOJu0YzrM6EXRddPQ5liJu0iLMJ4O3iQhc3otwCp3Hp0wHVfldP+QTi4
	vbaJPyJos06n4qxsEuOAjzAPLzBPXfGvrcEVn41GIDlciJ3UrABJBV53ctsvvuUIUckKaFHxj+N
	8
X-Google-Smtp-Source: AGHT+IF0wx/D6BGXtaN7O3N+r15mFpHL5+nGsDvaxLqFSGZfzeP3dOxqFPmChCkeU9nXESMaPpBN1Q==
X-Received: by 2002:a05:651c:1058:b0:2d4:49f5:2ae1 with SMTP id x24-20020a05651c105800b002d449f52ae1mr599120ljm.41.1711065566259;
        Thu, 21 Mar 2024 16:59:26 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id fa26-20020a056a002d1a00b006ea80e5090csm320465pfb.109.2024.03.21.16.59.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Mar 2024 16:59:25 -0700 (PDT)
Message-ID: <0ed44a68-ec4e-437d-9d0b-a89ccff3d60f@suse.com>
Date: Fri, 22 Mar 2024 10:29:21 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] btrfs: reflink: disable cross-subvolume clone/dedupe
 for simple quota
Content-Language: en-US
To: Boris Burkov <boris@bur.io>, Josef Bacik <josef@toxicpanda.com>
Cc: linux-btrfs@vger.kernel.org
References: <74730c411b0fd87484c8d894878c5cd8bac1d434.1710992258.git.wqu@suse.com>
 <20240321185135.GB3186943@perftesting>
 <20240321190857.GA107915@zen.localdomain>
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
In-Reply-To: <20240321190857.GA107915@zen.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/3/22 05:38, Boris Burkov 写道:
> On Thu, Mar 21, 2024 at 02:51:35PM -0400, Josef Bacik wrote:
>> On Thu, Mar 21, 2024 at 02:09:38PM +1030, Qu Wenruo wrote:
>>> Unlike the full qgroup, simple quota no longer makes backref walk to
>>> properly make accurate accounting for each subvolume.
>>>
>>> Instead it goes a much faster and much simpler way, anything modified by
>>> the subvolume would be accounted to that subvolume.
>>>
>>> Although it brings some small accuracy problem, mostly related to shared
>>> extents between different subvolumes, the reduced overhead is more than
>>> good enough.
>>>
>>> Considering there are only 2 ways to share extents between subvolumes:
>>>
>>> - Snapshotting
>>> - Cross-subvolume clone/dedupe
>>>
>>> And since snapshotting is the core functionality of btrfs, we will never
>>> disable that.
>>>
>>> But on the other hand, cross-subvolume snapshotting is not so critical,
>>> and disabling that for simple quota would improve the accuracy of it,
>>> I'd say it's worthy to do that.
>>>
>>
>> We did this on purpose, and absolutely want to leave this functionality in
>> place.  Boris made sure to document this behavior explicitly, because we are
>> absolutely taking advantage of this internally by having the package management
>> subvolume managed under a different quota, and then reflinking those packages
>> into their containers volume.  This is the price of squotas, you aren't getting
>> full tracking, but you're getting limits and speed.  Thanks,
>>
>> Josef
> 
> For a little extra context, if we hadn't wanted to support reflinking,
> then squotas would have been yet simplER,

I guess that's why my initial impression on squota, which can be even 
simpler without the extra extent tree change.

> and wouldn't have needed the
> new inline owner refs. For better or worse, we decided it was in fact
> quite important, so we added the owner refs. Now that we did the hard
> work and committed to the incompat change, I certainly think it makes
> sense to leave the support.

Considering you guys have the real world usage and have already 
committed so much to this feature, it's definitely worthy keeping.

The patch would be dropped.

Thanks,
Qu

> 
> Boris

