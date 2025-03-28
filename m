Return-Path: <linux-btrfs+bounces-12667-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2207FA7521F
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Mar 2025 22:36:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD9FF3A956C
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Mar 2025 21:36:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 844BA1EB5F6;
	Fri, 28 Mar 2025 21:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="c0OrRQ0H"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 743111A0BF1
	for <linux-btrfs@vger.kernel.org>; Fri, 28 Mar 2025 21:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743197780; cv=none; b=YlKS3BKYDY2RgQ2U3IkY4JJdGqn3N2PEWJ0tyUXFPgH9uj+Pc09d1rtFTuR5aest7ClyQ3GHwY/oKF03anlJUq743KmcOoziac2/IhZLD+BaYejFmb9rvZakB3imEasDhlWRI4gL5cNu680Vt9HNlxje1g89FKcpIEfeAedPH4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743197780; c=relaxed/simple;
	bh=3DpJ3dssCTXfYvgrnii/pIwPJ5KSPKHbZYWYN3BntpQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jLdHrYfiHm4yoVHWZjSYZAiVzNddkUYaYJz0K0vpeVOUw9WykXXsc6dDpyAB3iCLAdVWKyTF0B8IPqiEZIK0br56Rb6uxjlB8OZNjPkwY+Dti2tTlUv6hLEM2UJuweK0+00uDfZLrqdNmvDbgLJQVL6DmXMmGpgYsztKMUAqj/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=c0OrRQ0H; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-39149bccb69so2338566f8f.2
        for <linux-btrfs@vger.kernel.org>; Fri, 28 Mar 2025 14:36:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1743197777; x=1743802577; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=nmevhfTNDzBM/ZC/adn0T62gDZSW4C9orc1wYIF5bns=;
        b=c0OrRQ0HqsUDZdOfS4BvdO/j1lGBrfLvqBvG1WO8oiBZiFcVP23CeaZ2JKYRqx3yzG
         z/PK3HIYOx7qpilBX547LualjONTzmEuxXaLGp4hCwbryeDdBquB180APl98vfoQ6uiM
         7wTaowFArjziiJfin6KCWOGLR/zTTorMsr/M8cpOBI7ZJ1C0M7GW6q29I0GstEwE8+CO
         wjdpW4/Wl+LB4jEkMhxvz6mGffcrOEydH6zaqNsbSe61dTUW2aJYmYBNodfXNHCv7ZHL
         greU/X33LNt8eIbzDVcYOt485paVh2wndOyXgIQHEDKNtDefkqYmio0ju6kWyEJ4rrV6
         5pCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743197777; x=1743802577;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nmevhfTNDzBM/ZC/adn0T62gDZSW4C9orc1wYIF5bns=;
        b=bYj6VzcZs92NbQBc3KyA3rWznjMZzxkw3rSuF8HB1qfj9EJeOKJdP+4tBGzf02KTI1
         LfeyeToNi+ZAtwrdWRx5GNhEWY71guwOe/K14yvJYiZgJRD42MYrNI4OEjf4jse1wPTy
         +7952hxoDCp4g+dI/C5Av8XyhVrH9Jbg5ZmZwBLYPDHoyN3csxYXcItVPCRRuuqZ9P/U
         6i6Hg0VbQu5NIlgp00sJyc1eqlm49Rg7cuhf/XostwRD+erFP3CMF2El3x7OI4HUOE+V
         IpUuxl2OUIO8IDNWj4qooK/F1NaBoAc2ML0XpTWxhzF797/er2IFWrYcCBLjLZbbd+5S
         2HxQ==
X-Forwarded-Encrypted: i=1; AJvYcCU7OHogU5yaJPEREJG8P5Rfn0ivbKau3af7UDLx23VopeMcJo1cwQv0sAce9uH6xX7MCXIy+JYuczr8LQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzWmPxo4qwIk7RYdTGIvNAGAjNUg1zPB5bffobIdy2BOefNyZYd
	facleJL05mmwMjuuG0iYKZx49gAvCK4JDRARm/P+oDyiS60Holo6NHzeNqFjYDA=
X-Gm-Gg: ASbGnctLT1HcfkFbb5dE5YLGMvPq3fNtysKfL7PzVx4aYkAyXOUSdQwaHhM58FXoJBo
	eoWHP7r6MukIu6gYZwKO5R0u7+KLmi60tuTm9+4c1RpO6SZtGh2RWLLHzh1OjoiJ/tSlX8l04Mi
	bmNevLTI5Ulx7fHI9putpWMJUX86JeIk1aC3Oe/V+/Sc0Y30zZ0Q4fH+qWcrLyqxz830g2Z5RsX
	SGO55eMrFEKSxzZCCuCdeFyICxWMwohyUO+F8eWRTrmW92lQR7sdKcIJnSIDmkdW/PzzS8l+kvQ
	SgmAoHHB4uhTR1yOHXNL/HU8DFE16a/T47Db5VwEb5fWgbmvGtBi6FhSnb1iCDHXp0rLss8B
X-Google-Smtp-Source: AGHT+IHlRHbwRz2wWRwkaFwXutCTVQ4Wvm+6MXtxeruh9Y/k2nLySUcvuEJ4RfXN3lnsJ3xQtNWLJA==
X-Received: by 2002:a5d:6d04:0:b0:39a:c9cb:8296 with SMTP id ffacd0b85a97d-39c120e3b2amr588826f8f.22.1743197776449;
        Fri, 28 Mar 2025 14:36:16 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2291eedc988sm23840665ad.59.2025.03.28.14.36.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Mar 2025 14:36:15 -0700 (PDT)
Message-ID: <bdb78088-9986-4995-aac6-6f26dc56f0a7@suse.com>
Date: Sat, 29 Mar 2025 08:06:11 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] Btrfs updates for 6.15
To: Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.cz>
Cc: David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1742834133.git.dsterba@suse.com>
 <20250328132751.GA1379678@perftesting> <20250328173644.GG32661@twin.jikos.cz>
 <20250328193927.GA1393046@perftesting>
Content-Language: en-US
From: Qu Wenruo <wqu@suse.com>
Autocrypt: addr=wqu@suse.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNGFF1IFdlbnJ1byA8d3F1QHN1c2UuY29tPsLAlAQTAQgAPgIbAwULCQgHAgYVCAkKCwIE
 FgIDAQIeAQIXgBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJnEXVgBQkQ/lqxAAoJEMI9kfOh
 Jf6o+jIH/2KhFmyOw4XWAYbnnijuYqb/obGae8HhcJO2KIGcxbsinK+KQFTSZnkFxnbsQ+VY
 fvtWBHGt8WfHcNmfjdejmy9si2jyy8smQV2jiB60a8iqQXGmsrkuR+AM2V360oEbMF3gVvim
 2VSX2IiW9KERuhifjseNV1HLk0SHw5NnXiWh1THTqtvFFY+CwnLN2GqiMaSLF6gATW05/sEd
 V17MdI1z4+WSk7D57FlLjp50F3ow2WJtXwG8yG8d6S40dytZpH9iFuk12Sbg7lrtQxPPOIEU
 rpmZLfCNJJoZj603613w/M8EiZw6MohzikTWcFc55RLYJPBWQ+9puZtx1DopW2jOwE0EWdWB
 rwEIAKpT62HgSzL9zwGe+WIUCMB+nOEjXAfvoUPUwk+YCEDcOdfkkM5FyBoJs8TCEuPXGXBO
 Cl5P5B8OYYnkHkGWutAVlUTV8KESOIm/KJIA7jJA+Ss9VhMjtePfgWexw+P8itFRSRrrwyUf
 E+0WcAevblUi45LjWWZgpg3A80tHP0iToOZ5MbdYk7YFBE29cDSleskfV80ZKxFv6koQocq0
 vXzTfHvXNDELAuH7Ms/WJcdUzmPyBf3Oq6mKBBH8J6XZc9LjjNZwNbyvsHSrV5bgmu/THX2n
 g/3be+iqf6OggCiy3I1NSMJ5KtR0q2H2Nx2Vqb1fYPOID8McMV9Ll6rh8S8AEQEAAcLAfAQY
 AQgAJgIbDBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJnEXWBBQkQ/lrSAAoJEMI9kfOhJf6o
 cakH+QHwDszsoYvmrNq36MFGgvAHRjdlrHRBa4A1V1kzd4kOUokongcrOOgHY9yfglcvZqlJ
 qfa4l+1oxs1BvCi29psteQTtw+memmcGruKi+YHD7793zNCMtAtYidDmQ2pWaLfqSaryjlzR
 /3tBWMyvIeWZKURnZbBzWRREB7iWxEbZ014B3gICqZPDRwwitHpH8Om3eZr7ygZck6bBa4MU
 o1XgbZcspyCGqu1xF/bMAY2iCDcq6ULKQceuKkbeQ8qxvt9hVxJC2W3lHq8dlK1pkHPDg9wO
 JoAXek8MF37R8gpLoGWl41FIUb3hFiu3zhDDvslYM4BmzI18QgQTQnotJH8=
In-Reply-To: <20250328193927.GA1393046@perftesting>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/3/29 06:09, Josef Bacik 写道:
> On Fri, Mar 28, 2025 at 06:36:44PM +0100, David Sterba wrote:
>> On Fri, Mar 28, 2025 at 09:27:51AM -0400, Josef Bacik wrote:
>>> On Mon, Mar 24, 2025 at 05:37:51PM +0100, David Sterba wrote:
>>>> Hi,
>>>>
>>>> please pull the following btrfs updates, thanks.
>>>>
>>>> User visible changes:
>>>>
>>>> - fall back to buffered write if direct io is done on a file that requires
>>>>    checksums
>>>
>>> <trimming the everybody linux-btrfs from the cc list>
>>>
>>> What?  We use this constantly in a bunch of places to avoid page cache overhead,
>>> it's perfectly legitimate to do DIO to a file that requires checksums.  Does the
>>> vm case mess this up?  Absolutely, but that's why we say use NOCOW for that
>>> case.  We've always had this behavior, we've always been clear that if you break
>>> it you buy it.  This is a huge regression for a pretty significant use case.

BTW, it's not clear, it's not in the documents (until recently, along 
with this change), and no one is really explaining that to end users 
until now.

If you're a experienced fs/mm developer, sure it's obvious, but most 
users (millions of VM users who choose to use none cache mode) are not 
so experienced.

Future more, a lot of such VM users are just trying to reduce page cache 
memory usage, not so about the zero-copy performance.
And the buffered fallback should still make a lot of sense for them, and 
still allow working data checksum (which they may care more than the 
performance).

>>
>> The patch has been up for like 2 months and you could have said "don't
>> because reasons" any time before the pull request. Now we're left with a
>> revert, or other alternatives making the use cases working.
> 
> Boris told me about this and I forgot.  I took everybody off the CC list because
> I don't want to revert it, in fact generally speaking I'd love to never have
> these style of bug reports again.
> 
> But it is a pretty significant change.  Are we ok going forward saying you don't
> get O_DIRECT unless you want NOCOW?

Despite NOCOW, there are still other things (like alignment) can make 
O_DIRECT to fall back buffered, without even letting the users know.

And it is always fs specific on whether it choose to fall buffered or 
return -EINVAL.

So in the first place there is never any guarantee that O_DIRECT always 
results in zero-copy writes.

> Should we maybe allow for users to indicate
> they're not dumb and can be trusted to do O_DIRECT properly? I just think this
> opens us up to a lot more uncomfortable conversations than the other behavior.

For whatever reason, no matter dumb users or not, all operations through 
a fs should not lead to data/metadata corruption, no matter if it's real 
corruption or just false csum mismatch.
(Not to mention it's not easy to fix the csum mismatch either)

If dumb programs can still corrupt the fs, then it's a bug in the fs.

To me, this is very straightforward, and the priority should be obvious.

> 
> I personally think this is better, if it's been sitting there for 2 months then
> hooray we're in agreement. But I'm also worried it'll come back to bite us.

I'd say, let it bite.

If it's some performance critical use cases, I believe the developer 
should be reasonable enough to be persuaded (either choose perf and go 
NODATASUM, or choose datacsum and accept the perf drop).

If it's newbie level usages, they shouldn't even notice any difference, 
except the fact btrfs no longer corrupts their files.

Even if it really bites in the future, I doubt it will be any worse.

On the other hand, the data csum mismatch for VM images are already 
biting us for too long, and it's really damaging the reputation of Btrfs.

Thanks,
Qu

> Thanks,
> 
> Josef


