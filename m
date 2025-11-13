Return-Path: <linux-btrfs+bounces-18930-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 60550C56266
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Nov 2025 09:04:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9568D34E297
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Nov 2025 08:02:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01526330D22;
	Thu, 13 Nov 2025 08:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foxido.dev header.i=@foxido.dev header.b="qzPyreZY";
	dkim=permerror (0-bit key) header.d=foxido.dev header.i=@foxido.dev header.b="0wdO3dBu"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from m.foxido.dev (m.foxido.dev [81.177.217.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D3F5289811;
	Thu, 13 Nov 2025 08:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.177.217.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763020889; cv=none; b=NwrjwckUPir4NVrRziyJLI55+hSVeTJFonjKv6WeuVwY7YnudUCf65nta2hZWHQ1v7T+Ac5d7S+Fr3qLs4wCCBohT/1s3e+cpEGdZvlj7IhYW9A2KzeYxkkeantUMvaslb6+w6LDkMvvqQA+NPpApypepPdVEkGRUxI8jSS/CGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763020889; c=relaxed/simple;
	bh=g2LbOhUwqSwiWbQJrtcUdsYDcEz2zE/fSkGL/O1Hg9Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WqVoyDBK4C9EiYfMtkQzUt8cU4pW9JMmkCrZDvi0jV5KSzfDSPK5Rail+J6VthvmBGRydRBAgEW+f8eGy9qKKkyoJwYKhIi+HpIeVjzWBwFhTVk+ex9eNAcavaKv7yUq7KGFjlpV9pUZk0WdaWg+KINaOvdh0UBKCcfErm1CKMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=foxido.dev; spf=pass smtp.mailfrom=foxido.dev; dkim=pass (2048-bit key) header.d=foxido.dev header.i=@foxido.dev header.b=qzPyreZY; dkim=permerror (0-bit key) header.d=foxido.dev header.i=@foxido.dev header.b=0wdO3dBu; arc=none smtp.client-ip=81.177.217.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=foxido.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxido.dev
DKIM-Signature: v=1; a=rsa-sha256; s=202508r; d=foxido.dev; c=relaxed/relaxed;
	h=From:To:Subject:Date:Message-ID; t=1763020876; bh=VrikCNq8J0aRng6bbkTwcBM
	z+jW/3xa7sTs49VEz1TQ=; b=qzPyreZYsrW8NYj4n4Lps/fgTLam7kROMN2plVj12KW9Hs0wq7
	7ooTCBecPO/7gGKhB5nYVHsxxxmq+WFCksknhYJgkrqGVwTHYp9ZvU4LWn7Rw5pXSnERTnrqKP+
	rbPhjFXZYx/K431r1vdUQdPGRzBcoeKHW7HOzUtL8M/CK2m6v+RqZGK7DBKhW//nC3NGqyNqFJQ
	ResY+36gGb7DOJfKS9sOADbw1HIrkJdMy9uQkRHnHulVUJtQkE5G9kOwODinC16b/076QGcLlp9
	LaMPkF82ZsE+JTvZkTsQP40U22ChZksk0yx/Iv8U7O1dxbtNuKiEwjNBq08XjzAz+sA==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202508e; d=foxido.dev; c=relaxed/relaxed;
	h=From:To:Subject:Date:Message-ID; t=1763020876; bh=VrikCNq8J0aRng6bbkTwcBM
	z+jW/3xa7sTs49VEz1TQ=; b=0wdO3dBuZSkx51yX6hO3dWfhQ4VqFi3mgfjZriSZKYEXpdfYK9
	ct96VVu39MUTH4Ombz6RIZWyjR5Ji+3ltpAg==;
Message-ID: <39aedcbd-aca9-4963-8131-a3cdb7a4289a@foxido.dev>
Date: Thu, 13 Nov 2025 11:01:16 +0300
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/8] use cleanup.h in btrfs
To: Qu Wenruo <wqu@suse.com>
Cc: Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
 linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1762972845.git.foxido@foxido.dev>
 <31b5e88c-0979-44cc-9e7a-1cb3320caf39@suse.com>
Content-Language: en-US
From: Gladyshev Ilya <foxido@foxido.dev>
In-Reply-To: <31b5e88c-0979-44cc-9e7a-1cb3320caf39@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/12/25 23:55, Qu Wenruo wrote:
> 在 2025/11/13 05:19, Gladyshev Ilya 写道:
>> This series represents my experimentation with refactoring with
>> cleanup guards. In my opinion, RAII-style locking improves readability
>> in most cases and also improves code robustness for future code changes,
>> so I tried to refactor simple cases that really benefits from lock 
>> guards.
> 
> Although I totally agree with the guard usages, it's not yet determined 
> we will fully embrace guard usages.
> 
>>
>> However readability is a subjective concept, so you can freely disagree
>> and reject any of those changes, I won't insist on any. Please note that
>> patches 1-3 can be useful even without lock guards.
>>
>> I didn't know how to split this series, mostly because it's just a lot of
>> small changes... so I tried to split it by types of transformation:
> 
> And even if we're determined to go guard path, I doubt if it should be 
> done in such a rushed way.
> 
> There are already some cases where scope based auto-cleanup conversion 
> led to some regressions, no matter how trivial they seem.
> Thankfully they are all caught early, but we have to ask one critical 
> question:
> 
>    Have you run the full fstest test cases?
> 
> If not, please run it first. Such huge change is not really that easy to 
> review.

No, because it's RFC only [however I tried to verify that no locking 
semantics/scopes changed and I tried not to touch any really complex 
scenarios.]
> Although I love the new scope based auto cleanup, I still tend to be 
> more cautious doing the conversion.
> 
> Thus my recommendation on the conversion would be:
> 
> - Up to the author/expert on the involved field
>    E.g. if Filipe wants to use guards for send, he is 100% fine to
>    send out dedicated patches to do the conversion.
> 
>    This also ensures reviewablity, as such change will only involve one
>    functionality.
> 
> - During other refactors of the code
>    This is pretty much the same for any code-style fixups.
>    We do not accept dedicated patches just fixing up whitespace/code-
>    style errors.
>    But if one is refactoring some code, it's recommended to fix any code-
>    style related problems near the touched part.

Personally I don't like this approach for correctness-sensitive 
refactoring. When it's something dedicated and standalone, it's easier 
to focus and verify that all changes are valid

> So I'm afraid we're not yet at the stage to accept huge conversions yet.

I would be surprised if such patchset would be accepted as one thing, 
honestly) For now, it's only purpose is to show how code _can_ be 
refactored in theory [not _should_]. And then, for example, if there is 
positive feedback on scoped guards, but not on full-function guards, I 
will send smaller, fully tested patch with only approved approaches.

Probably I should've been more clear on that in the cover letter, sorry...

