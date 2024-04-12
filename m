Return-Path: <linux-btrfs+bounces-4201-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 943678A3879
	for <lists+linux-btrfs@lfdr.de>; Sat, 13 Apr 2024 00:13:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ECE24B2307A
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Apr 2024 22:13:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DC5C152195;
	Fri, 12 Apr 2024 22:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="QEQ1cIer"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC83914F9EE
	for <linux-btrfs@vger.kernel.org>; Fri, 12 Apr 2024 22:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712959976; cv=none; b=NW4yAxBmLLzYQcw2Wf9XFkzg8ZbVDw8cGiMV3QrVUqLni69FGn2wNBng7N6T3JGCslUT+zkbHQzTPw3K+/amiZy767NBN6w9D//TiFDw3+WkNmuXMWZfDeEH3J1LtEPeB2eLlBymF4e9wCZjGpX+UvI5e3xU2PDfsacwkxvS7kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712959976; c=relaxed/simple;
	bh=6SCgWjYluT5E76dYvy/CQgIkhaaaVEmvibz6F+faGBY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IZOXW2zyYXY8gOHTnscg8awQ6BsDhgv/Sp0kq77ca6DIQrzO6D04eurvD02IapGW7MIQQXodso+u2zwO6Miwfan0++K6XhJKppUzj6ZRGIY3p5tl8aSeE2AogqPe3aBsUlXbklpGdH5fyJGwKZRoFuZWsy6+3c6Yj5MTr/2bmMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=QEQ1cIer; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2da0b3f7ad3so12769641fa.1
        for <linux-btrfs@vger.kernel.org>; Fri, 12 Apr 2024 15:12:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1712959972; x=1713564772; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=KeA3pnG4iCfJgCGuSSolahJUOqeSrAEhWO4xbi3GGxw=;
        b=QEQ1cIerHsygEdyTWGjc7fGvBtFkq2kNtJpn0yedGXl9cz+74l9skSqmfEvj+AY91d
         fFqGsWpqz8KqNcLXTn/WHff0MMQz4f4Uer6cYPpX7owKi3ESfc8tIefhI0kTRX2ZQ4DU
         suDW0dR1v9tBw//aSFzN82aHuHZULieTAZBAA0mLymrpcohmuHFh07xFDWfLgQpzCHWd
         M3xVgXCb7v1qjMtOac1hd/xDzGHHrNrkrkSXMdnwE52QgFoEa3OE9jcxEEF2AO4lMfjZ
         2RmnEV3Zbqb8A3qJUxIaDYckmY1VTUyVNwN+CAggYgBq6c6wx2IwK9DivHNX8rbM4ZRt
         GBkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712959972; x=1713564772;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KeA3pnG4iCfJgCGuSSolahJUOqeSrAEhWO4xbi3GGxw=;
        b=TN1bz+uW4qk5ZeRJn50IkS9+i5fk06o28Z2AehICcuuOimghgmE4lEIFaGcrmCgUPX
         +AbDmWo3vSUsxH6jFcwnXuUqjnJr3wBp148W2rLphYQJJUFxMZSMYqwANqnthsxLBYTJ
         E/pra9ElVSY9sysks34TOLl8pPF2Lx7ty45E0sz58ihkKMwCsf7VGYNwygBFGXhlfoec
         vd2RaYiF3rLC6LtC5huXdUZNbk2PAUj2P7pR4buJeUr3P7RmiIq1UluesJFLfJWyY5wh
         QWK1eAWLiKUNE23QIRjGnYvJKktbfmB52tbUMGrOxwUyjQIl7SEm+/uMZExXaJYGnJ2D
         tJ/A==
X-Gm-Message-State: AOJu0YxMmBbz8vMy3hw7NSclVWRV+pX3TaNQ9ARXjmqLFv7RcmKbhA+h
	7ZLuSY/t5gBx4lDJSPaRonhGBHcJqzUEQk91Og/g1lmkW+e3iiBVFzIx01t1iVQ=
X-Google-Smtp-Source: AGHT+IGQq+B3/d79Hwd/cllLclBH3qx7SJGBPj7KmiEZS3QhkQO63kjWn0gCHDMky2MvoTi62NnMDA==
X-Received: by 2002:a05:651c:d5:b0:2d7:8152:1ee5 with SMTP id 21-20020a05651c00d500b002d781521ee5mr2271632ljr.31.1712959972019;
        Fri, 12 Apr 2024 15:12:52 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id w14-20020a170902e88e00b001e0af9928casm3460889plg.55.2024.04.12.15.12.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Apr 2024 15:12:51 -0700 (PDT)
Message-ID: <adb96734-6521-4c13-ae86-f70a5f8848fe@suse.com>
Date: Sat, 13 Apr 2024 07:42:44 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 2/8] btrfs: rename members of
 can_nocow_file_extent_args
To: Qu Wenruo <quwenruo.btrfs@gmx.com>, Filipe Manana <fdmanana@kernel.org>
Cc: linux-btrfs@vger.kernel.org
References: <cover.1712614770.git.wqu@suse.com>
 <5780c450b3b5a642773bf3981bcfd49d1a6080b0.1712614770.git.wqu@suse.com>
 <CAL3q7H77oYtaf4_M3mWYsdSucwi-gTu+wgpEsJhft1vQjwajig@mail.gmail.com>
 <65a7c2b6-9700-4d52-bd5e-9bfc2e32327d@gmx.com>
 <CAL3q7H7U087v0t3N_fpdsqCBXJGm9dr5oFft5m6jaGEhS1b=5w@mail.gmail.com>
 <766b8e1e-0c04-4fdb-ae76-b92cd8f85bc3@gmx.com>
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
In-Reply-To: <766b8e1e-0c04-4fdb-ae76-b92cd8f85bc3@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/4/13 07:30, Qu Wenruo 写道:
> 
> 
> 在 2024/4/12 22:51, Filipe Manana 写道:
>> On Thu, Apr 11, 2024 at 11:03 PM Qu Wenruo <quwenruo.btrfs@gmx.com> 
>> wrote:
> [...]
>>>
>>> Well, the new @block_start matches the old extent_map::block_start.
>>
>> So it becomes a single exception, different from everywhere else.
>> Doesn't seem like a good thing in general.
> 
> OK, I can get rid of the @block_start name.
> 
>>
>>>
>>> I have to say, we do not have a solid definition on "disk_bytenr" in the
>>> first place.
>>
>> Well I find the name clear, it is a disk location measured by a byte 
>> address.
>> block_start is not so clear for anyone not familiar with btrfs'
>> internals, it makes me think of a block number and wonder what's the
>> block size, etc.
>>
>>>
>>> Should it always match ondisk file_extent_item::disk_bytenr, or should
>>> it act like "block_start" of the old extent_map?
>>
>> It's always about a range of a file extent item, be it the whole range
>> or just a part of it.
>> I don't see why it's confusing to use disk_bytenr, etc.
>> I find it more confusing to use something else, or at least what's
>> being proposed in this patch.
> 
> Well, IMHO since we take the name @disk_bytenr from btrfs file extent
> item, and btrfs file extent uses @disk_bytenr to uniquely locate a data
> extent, then we should also follow it to use @disk_bytenr for the same
> purpose.
> 
> So that every time we see the name @disk_bytenr, we know it can be used
> to locate a data extent, without any need for weird offset calculation.
> 
> That's why I'm strongly against adding any offset into @disk_bytenr.
> And I believe that's the biggest difference in our points of view.
> 
> Although in this particular case, I can use some extra prefixs like
> "orig_" or "fe_" (for file extent), so that those members can be later
> directly passed to create_io_em() without extra offset calculation.
> 
> Would that be a acceptable trade-off?
> 
> 
> Another solution would be just drop this patch, and do extra calulation
> resulting something like this:
> 
>      create_io_em(...,
>               disk_bytenr - whatever_offset, /* disk_bytenr */
>               offset - whatever_offset, /* offset */
>               PREALLOC, ...);
> 
> At least that does not sound sane to me, and can be bug prune.
> You won't believe how many different crashes I hit just due to the weird
> disk_bytenr calculation here, and that's the biggest reason I have

the extra sanity checks.

> 
> Thanks,
> Qu
> 


