Return-Path: <linux-btrfs+bounces-10439-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2A049F3DAA
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Dec 2024 23:40:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C68847A274D
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Dec 2024 22:40:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 962281D90AD;
	Mon, 16 Dec 2024 22:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="gkGi2tN5"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BB4A1D5AC6
	for <linux-btrfs@vger.kernel.org>; Mon, 16 Dec 2024 22:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734388825; cv=none; b=s1TtaTPtsTOCuDkN4Qx3XOnVjzHnoYbPJYwukPX8SrV1hQ1a6oit1jHYldJegVkpcJxfPuGBgliREgcnmHIofNYUNcMrqPstqDAf7lXmnVJ2QkxYGxaWLRw2SsxltXY/427Ba+vrQrXKY2asO6dTKVd0M7YT9XwHBZ2dIvRSML0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734388825; c=relaxed/simple;
	bh=LPxqO5sruL5wAnnS8nh07GZAAYVtACCopS9IRmn6dy0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SdMdgXDUMHCia7EnkuGReimxJMGbPcdLEddn6MylGTGYu/N/OdlYhjoIzqJYnhHv9T67lrnCbY/Ns7eaRwB13m6meiH7UTsPN5C2nTSCYcIKiVe4Mzv05n/ea0R6hb3z1mBY26OX9wqn1Mdchfz9MCG1RnntHOQFDjaO3he65Fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=gkGi2tN5; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4361fe642ddso49222255e9.2
        for <linux-btrfs@vger.kernel.org>; Mon, 16 Dec 2024 14:40:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1734388821; x=1734993621; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=j4vHnKJxyZLqrZlZyIcpuJLCtn/KyIuO/X8nFh1d78Q=;
        b=gkGi2tN5/ER5A3fl46+m4JcCcUoIRDvtND8rcENXKxhPVWY+phHmZMEQslvuAX4/w+
         Uq7OBBIogN1tREGefktKuplsJDcxlxinahmZSrvJs0aqlqbH8QM6y7GtGSaOSEfe46aX
         3fbLYHZztqv8uCE2T0PKDjTRy23F0NnS0ShI83AfioxJx/EwdUf1WXv84ksnqAoTBPNX
         KK22jXUUu1IMPL+oSDU/zxSib8Jq5iWQphjKFUCo80HiYmXlZ/Loch0wHarZN7iOFXEm
         GWT2pDOALX03F+GLjMG0H35oZ4addf+xezLDcs1Fh8RnsmzCjyv493A18IwjNvRqaLgf
         olvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734388821; x=1734993621;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j4vHnKJxyZLqrZlZyIcpuJLCtn/KyIuO/X8nFh1d78Q=;
        b=wTTU+YL/NEIa8vPNkmTqtmKo0/aNZc4uSFwEQw2EpQvrUyvn+1+P9d7lgYOI8Urm7V
         a06/ArxYeSo3owwa+nqFwfS5IZKiRGxE8fy3DoqoR5fJRAqI77z9tR/LpXntovZS2AE/
         8qVevBUNu8oyyO599JH6SJWmnli+3/+MtP6m71BC/2VTJQ0jU1J7580feIfekoDd8wXc
         y57X+/QKJsYh/GcKOCu5UnWAdwrnYd9gvJaEK6/ZIsPoWxgjKDLGEjO9/exxK2zF4i+M
         D9XUVmqruhtJsIWmXaZZHSKe6kTeieyZqXZGYy72WY5RCxX1ME+mLviNTcw+ALlai3yk
         s+qw==
X-Forwarded-Encrypted: i=1; AJvYcCXr99bqh/z2AuZ1aM0hC2CBCgDVd8MXqfDvVfHQLkMfgtAqegMzgiw2mZ4pPZVm5jH6VeeJrXfNjMg6bA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3rWtERht/TR7k10+YU3y4P8F4kyVy3xWmxqdPkfgzB1wzD4nM
	ljGW/VA8E5CWcjzqvVSKB12WWEe/0N7KaGcjgdw+i4jR/JahmO4pLt53spd3S2U=
X-Gm-Gg: ASbGncvzmsbwJD5WXzp6Lj20i9NHMooi74bNwbFrQ6aqsqfSJg5UUTWCfLaN3RZ5OCJ
	x1IhBS5VKNNzJoT8o5EDitA5px47lwT0VK/esZPTxwkrM6lOE8pEYqRcWDP3pBU+4hbN7p3XrRX
	YCBADQdVpr3aFDeOsBvMpi7WZ0+dcfUv5i3SmiXfeyr25/1Geg/qtY+Emidoyb/ZJBWSWnyD10p
	tshZHvg7VoqIaQ1bPCcoIP9xUllXYglCEPxPdOtQeDEnTowpopPfITsjpNff02ltGHRxR+f4wFz
	7gTXwtJs
X-Google-Smtp-Source: AGHT+IEIwbbtteuEEUgdXkZoDBEWRsa6tuS4jIAHkiUX1OwkeXYELGkuqROwTiXRzGLuwnFDtA/GFw==
X-Received: by 2002:a5d:5f88:0:b0:385:e37a:2a58 with SMTP id ffacd0b85a97d-38880ac2841mr13330177f8f.1.1734388820426;
        Mon, 16 Dec 2024 14:40:20 -0800 (PST)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72918b78f42sm5462100b3a.108.2024.12.16.14.40.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Dec 2024 14:40:19 -0800 (PST)
Message-ID: <25ab4458-06a4-46a3-b42b-a7dc52d44b1e@suse.com>
Date: Tue, 17 Dec 2024 09:10:14 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] rbtree: add rb_find_add_cached() to rbtree.h
To: Peter Zijlstra <peterz@infradead.org>, Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: "Roger L. Beckermeyer III" <beckerlee3@gmail.com>, dsterba@suse.cz,
 oleg@redhat.com, mhiramat@kernel.org, linux-kernel@vger.kernel.org,
 josef@toxicpanda.com, linux-btrfs@vger.kernel.org, lkp@intel.com
References: <cover.1733850317.git.beckerlee3@gmail.com>
 <4768e17a808c754748ac9264b5de9e8f00f22380.1733850317.git.beckerlee3@gmail.com>
 <20241213090613.GC21636@noisy.programming.kicks-ass.net>
 <ad36347a-14a5-41d4-82d5-f557a0a7f08c@gmx.com>
 <20241216222225.GF9803@noisy.programming.kicks-ass.net>
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
In-Reply-To: <20241216222225.GF9803@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/12/17 08:52, Peter Zijlstra 写道:
> On Tue, Dec 17, 2024 at 08:43:26AM +1030, Qu Wenruo wrote:
>>
>>
>> 在 2024/12/13 19:36, Peter Zijlstra 写道:
>>> On Thu, Dec 12, 2024 at 10:46:18AM -0600, Roger L. Beckermeyer III wrote:
>>>> Adds rb_find_add_cached() as a helper function for use with
>>>> red-black trees. Used in btrfs to reduce boilerplate code.
>>>>
>>>> Suggested-by: Josef Bacik <josef@toxicpanda.com>
>>>> Signed-off-by: Roger L. Beckermeyer III <beckerlee3@gmail.com>
>>>
>>> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
>>
>> I guess it's fine to merge this change through btrfs tree?
> 
> Yeah, I think so. I don't think there's anything else pending for this
> file -- its not touched much.
> 
>>
>> Just curious about the existing cmp() and less() functions, as they only
>> accept the exist node as const.
>>
>> I'm wondering if this is intentional to allow the less/cmp() functions
>> to modify the new node if needed.
>> As I normally assume such cmp()/less() should never touch any node nor
>> its entries.
> 
> Oh yeah, they probably should not. I think it's just because the
> callchain as a whole does not have const on the new node (for obvious
> raisins), and I failed to put it on for the comparators.
> 
> You could add it (and fix up the whole tree) and see if anything comes
> apart.
> 
Thanks for confirming this.

I'll make the cmp() for the new helper to accept all const parameter, 
and give a try to do a tree-wide cleanup to make existing cmp/less() to 
accept all const parameters. (pretty sure a lot of things will fall 
apart though).

Thanks,
Qu

