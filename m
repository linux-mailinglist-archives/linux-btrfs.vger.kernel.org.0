Return-Path: <linux-btrfs+bounces-6539-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC061934A78
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Jul 2024 10:52:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6ED3D1C20E4D
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Jul 2024 08:52:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC7B77F486;
	Thu, 18 Jul 2024 08:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="IZ4BCXLE"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 188613A28D
	for <linux-btrfs@vger.kernel.org>; Thu, 18 Jul 2024 08:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721292742; cv=none; b=WFNCX8NXmwxIvcDTPUwDnGwg7+PoyeTtr976xacEP99eI7PPvjb7geV4jggpb6JPaqLuKCEFtAl1kMX7+gMEgJVDejj/EnIc0khUKexTV1db4G0KFyDtbU1HgQUCH7Ywo+R0VzeHfN+TdfKQ1p4Luzy30y7GhNp3vx6n7dsiwWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721292742; c=relaxed/simple;
	bh=uwjjWYP/71jmyV3gFRtZOWLZT+kVDTnc5cS+hTap2+Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z8uT0RiLmKZ7CGch85jSj9YOwnsy5ZsPUTi8zuOBG9GXDYXff8ZQfvV0fAEr4dXoW108wRAA0z8TWcUv6n0vZ9l02uRNRNEH6oqVkXKwlHO7+h1LtNowDLbbOqBKCtvJdtegl8di1kF7CKnrpFRILFY7HVtUM7irrexraEMdknE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=IZ4BCXLE; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2eee083c044so6381351fa.3
        for <linux-btrfs@vger.kernel.org>; Thu, 18 Jul 2024 01:52:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1721292738; x=1721897538; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=kTiPZ+z60DtKJfcnwPuELD+MHjU1hcMmacIvAZVTSps=;
        b=IZ4BCXLE4VMz2dqUL/HAb71e+luDo8FTd4F5lvk3KbyZXAggriWuEAghhDnP0LjGey
         7vuDQB0elF5CEnLXCwukV/Jb8Wh1tQenA1SSGPj04QlCwvg64xgz0QR7qb/qAbu8Ji51
         Puoq5owZeRZZVVeOPcOCKhZOUdBJkWN4+9M/+JaG6i1Y2sDO34v/YfIiKZcYhBqegIxY
         MlijCERKvsduq//K4yav4A5oaLKYDl0yrRTjDGZEGn1P+NswNlmEbaXeDCFCLxzurj13
         aDpW1WHzbddOl2B1alOvdTk1Eq2UnYKUeqznXrApxN+ungFAn3dsoR5u0JTtX9OZ9eae
         pFzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721292738; x=1721897538;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kTiPZ+z60DtKJfcnwPuELD+MHjU1hcMmacIvAZVTSps=;
        b=i9WPkrCKi5sQrYA79YXnPaLf5ZhDjc+7f8k36u3/OnY6QnSryb0pNfjxAbDMlr0wLg
         WRhJmanjBGg29X2CJ1nAwTyPRu31qnkvPDZ8ARgjheX+qGVSsfCld5hnrvUYIxKVc0ZN
         mekP6JD71vtMeLyXeWR8SSH0vvnxxekCUR085THFINcHDxlhrQ+MAy9md8bzkA3EFGIg
         1RLgcGKKRnM1pQUeK1Cw/AfeoQAfsL0SM+I6qc2zDXYQBJN9p/vtJmQDT/vNZFNcg/mL
         NvsBvb/C4IIGjqnksOYYM9KMezC/hXfu1rldKKtoysMLVgCKJNrOx8NP2iqVZ2R5+0xq
         VuEQ==
X-Forwarded-Encrypted: i=1; AJvYcCVZ8UAa4ozPTgwOfQIZ2c/QV3YyW13rjybNj+OX2e1S0cC7XHF0UUl+9hd3b9o2QdXid9CJDfx2AgRlC1DBmUYxX/Od9Le7Tuoowys=
X-Gm-Message-State: AOJu0Yz2BOPb0L7oddv5weDZwKkX3pJg59NWWjxKtWzKtzNPbHTLNEyJ
	baT17NV0lwVaxBuq0stMRCskPuh3uPtRA2pI4eQKra5Qe9KIjK5I5A6+9yxpnDw=
X-Google-Smtp-Source: AGHT+IEKoEibRJdMaexuXPAxzHxwsv3/AhpoOjO3TsAbh/uEeOkHfPag6XFMXpu7pQMRDCuN9B2huw==
X-Received: by 2002:a2e:a541:0:b0:2ee:7dfe:d99c with SMTP id 38308e7fff4ca-2ef05d2ed3fmr14146781fa.31.1721292738013;
        Thu, 18 Jul 2024 01:52:18 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fc5ef02826sm9172165ad.67.2024.07.18.01.52.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jul 2024 01:52:17 -0700 (PDT)
Message-ID: <da00aadb-e686-4c47-80fe-cb26f928cf32@suse.com>
Date: Thu, 18 Jul 2024 18:22:11 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] mm: skip memcg for certain address space
To: Michal Hocko <mhocko@suse.com>
Cc: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>,
 Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org,
 linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
 Johannes Weiner <hannes@cmpxchg.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>,
 Cgroups <cgroups@vger.kernel.org>, Matthew Wilcox <willy@infradead.org>
References: <cover.1720572937.git.wqu@suse.com>
 <8faa191c-a216-4da0-a92c-2456521dcf08@kernel.org>
 <Zpft2A_gzfAYBFfZ@tiehlicka> <9c0d7ce7-b17d-4d41-b98a-c50fd0c2c562@gmx.com>
 <9572fc2b-12b0-41a3-82dc-bb273bfdd51d@kernel.org>
 <ZpjDeSrZ40El5ALW@tiehlicka> <304fdaa9-81d8-40ae-adde-d1e91b47b4c0@suse.com>
 <ZpjNuWpzH9NC5ni6@tiehlicka>
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
In-Reply-To: <ZpjNuWpzH9NC5ni6@tiehlicka>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/7/18 17:39, Michal Hocko 写道:
> On Thu 18-07-24 17:27:05, Qu Wenruo wrote:
>>
>>
>> 在 2024/7/18 16:55, Michal Hocko 写道:
>>> On Thu 18-07-24 09:17:42, Vlastimil Babka (SUSE) wrote:
>>>> On 7/18/24 12:38 AM, Qu Wenruo wrote:
>>> [...]
>>>>> Does the folio order has anything related to the problem or just a
>>>>> higher order makes it more possible?
>>>>
>>>> I didn't spot anything in the memcg charge path that would depend on the
>>>> order directly, hm. Also what kernel version was showing these soft lockups?
>>>
>>> Correct. Order just defines the number of charges to be reclaimed.
>>> Unlike the page allocator path we do not have any specific requirements
>>> on the memory to be released.
>>
>> So I guess the higher folio order just brings more pressure to trigger the
>> problem?
> 
> It increases the reclaim target (in number of pages to reclaim). That
> might contribute but we are cond_resched-ing in shrink_node_memcgs and
> also down the path in shrink_lruvec etc. So higher target shouldn't
> cause soft lockups unless we have a bug there - e.g. not triggering any
> of those paths with empty LRUs and looping somewhere. Not sure about
> MGLRU state of things TBH.
>   
>>>>> And finally, even without the hang problem, does it make any sense to
>>>>> skip all the possible memcg charge completely, either to reduce latency
>>>>> or just to reduce GFP_NOFAIL usage, for those user inaccessible inodes?
>>>
>>> Let me just add to the pile of questions. Who does own this memory?
>>
>> A special inode inside btrfs, we call it btree_inode, which is not
>> accessible out of the btrfs module, and its lifespan is the same as the
>> mounted btrfs filesystem.
> 
> But the memory charge is attributed to the caller unless you tell
> otherwise.

By the caller, did you mean the user space program who triggered the 
filesystem operations?

Then it's too hard to determine. Almost all operations of btrfs involves 
its metadata, from the basic read/write, even to some endio functions 
(delayed into workqueue, like verify the data against its csum).


> So if this is really an internal use and you use a shared
> infrastructure which expects the current task to be owner of the charged
> memory then you need to wrap the initialization into set_active_memcg
> scope.
> 

And for root cgroup I guess it means we will have no memory limits or 
whatever, and filemap_add_folio() should always success (except real 
-ENOMEM situations or -EEXIST error btrfs would handle)?

Then it looks like a good solution at least from the respective of btrfs.

Thanks,
Qu

