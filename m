Return-Path: <linux-btrfs+bounces-18936-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A13BDC56C57
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Nov 2025 11:11:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EEF1B3BBEE3
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Nov 2025 10:07:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B0E42E54A8;
	Thu, 13 Nov 2025 10:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foxido.dev header.i=@foxido.dev header.b="X24lwnAJ";
	dkim=permerror (0-bit key) header.d=foxido.dev header.i=@foxido.dev header.b="UFLgDhOn"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from m.foxido.dev (m.foxido.dev [81.177.217.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FD912E0934;
	Thu, 13 Nov 2025 10:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.177.217.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763028416; cv=none; b=joODGepGxRciYuMhwmytc4twfq9bT8y/LlxCn1ecA9MSN0q84wNcxUOrQFaWRYJcwkzwGXYzUhM3fc1Gte5LTb9CS4J3kbD2yBOcShOaii1o4FJl7BzOmv1dP8bBK4KP/MjEL23pdNk9CBjFulaxPZJ/EymR7tilDMgEvLObhnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763028416; c=relaxed/simple;
	bh=kgZ6/MxvLoUUt2gbJft/I2L5JSuzumUYFb2SvCE27Ck=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QxfvdPu6aSMnvBzBHN4c1ALDD6IOk6E8eDQGqGAOYKJfUu1tPtoVBqen2KgY4krUO4ZaCLoJlK8HmfMVI86lFjwWaueLq6ZHydqQfl4seT1G9AR5YGMQLPIMVyg+Pj3Mxw9b6WgWZgpnXaH7u5O3skqaHaLKcWFnttdxZRBAqj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=foxido.dev; spf=pass smtp.mailfrom=foxido.dev; dkim=pass (2048-bit key) header.d=foxido.dev header.i=@foxido.dev header.b=X24lwnAJ; dkim=permerror (0-bit key) header.d=foxido.dev header.i=@foxido.dev header.b=UFLgDhOn; arc=none smtp.client-ip=81.177.217.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=foxido.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxido.dev
DKIM-Signature: v=1; a=rsa-sha256; s=202508r; d=foxido.dev; c=relaxed/relaxed;
	h=From:To:Subject:Date:Message-ID; t=1763028402; bh=C90rv1D0a8JsgNQkGSdEEhi
	dsm5BQboxDJ3dNubvO2E=; b=X24lwnAJ59M8qdtvILr/ExGWxMUiLTfMDhXxU4UG/q3i+U2DTP
	3sJ5ZwS9J18EgVSuNAIZ2Q0EZo8RuYQemjZefuA/CxMj7g9cIMdVZhj9nG59AhfSPZLE59hwGCj
	Au2Vsi1GddYGQxKurqhgLsg1Cfjcv6kcCN/gbIhwqCInQfl4Uga3nYn8mrz0SRJjtsW4/3/pBhU
	hyIxeT/VIjFTmJIpAg8TFj2tP4E4XljGr2ZMLGz94WpeSn/zuz1E0d3/RI+zl2Uua6vJjYMMx+d
	D17kAGYoGgKAJHkSHTNW7AZPr5bfUNDsXgW0CFfImKlAXQQYPMmO431Y6PoDkDI1PuQ==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202508e; d=foxido.dev; c=relaxed/relaxed;
	h=From:To:Subject:Date:Message-ID; t=1763028402; bh=C90rv1D0a8JsgNQkGSdEEhi
	dsm5BQboxDJ3dNubvO2E=; b=UFLgDhOnCkoUl0wur1s6ijqLwOSvRaaruXgSQ3HkbKNprfWzog
	1+Z9NKmV9m2AJBnQcON3nHzlc8/0d5RodEDg==;
Message-ID: <35e1977e-7cca-4ea3-9df8-0a2b43bc0f85@foxido.dev>
Date: Thu, 13 Nov 2025 13:06:42 +0300
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 4/8] btrfs: simplify function protections with guards
To: dsterba@suse.cz
Cc: Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
 linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1762972845.git.foxido@foxido.dev>
 <c7abcfeb7e549bf5ad9861044c97b9a111d64370.1762972845.git.foxido@foxido.dev>
 <20251113084323.GG13846@twin.jikos.cz>
Content-Language: en-US
From: Gladyshev Ilya <foxido@foxido.dev>
In-Reply-To: <20251113084323.GG13846@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/13/25 11:43, David Sterba wrote:
> On Wed, Nov 12, 2025 at 09:49:40PM +0300, Gladyshev Ilya wrote:
>> Replaces cases like
>>
>> void foo() {
>>      spin_lock(&lock);
>>      ... some code ...
>>      spin_unlock(&lock)
>> }
>>
>> with
>>
>> void foo() {
>>      guard(spinlock)(&lock);
>>      ... some code ...
>> }
>>
>> While it doesn't has any measurable impact,
> 
> There is impact, as Daniel mentioned elsewhere, this also adds the
> variable on stack. It's measuable on the stack meter, one variable is
> "nothing" but combined wherever the guards are used can add up. We don't
> mind adding variables where needed, occasional cleanups and stack
> reduction is done. Here it's a systematic stack use increase, not a
> reason to reject the guards but still something I cannot just brush off
I thought it would be optimized out by the compiler in the end, I will 
probably recheck this

>> it makes clear that whole
>> function body is protected under lock and removes future errors with
>> additional cleanup paths.
> 
> The pattern above is the one I find problematic the most, namely in
> longer functions or evolved code. Using your example as starting point
> a followup change adds code outside of the locked section:
> 
> void foo() {
>      spin_lock(&lock);
>      ... some code ...
>      spin_unlock(&lock)
> 
>      new code;
> }
> 
> with
> 
> void foo() {
>      guard(spinlock)(&lock);
>      ... some code ...
> 
>      new code;
> }
> 
> This will lead to longer critical sections or even incorrect code
> regarding locking when new code must not run under lock.
> 
> The fix is to convert it to scoped locking, with indentation and code
> churn to unrelated code to the new one.
> 
> Suggestions like refactoring to make minimal helpers and functions is
> another unecessary churn and breaks code reading flow.

What if something like C++ unique_lock existed? So code like this would 
be possible:

void foo() {
   GUARD = unique_lock(&spin);

   if (a)
     // No unlocking required -> it will be done automatically
     return;

   unlock(GUARD);

   ... unlocked code ...

   // Guard undestands that it's unlocked and does nothing
   return;
}

It has similar semantics to scoped_guard [however it has weaker 
protection -- goto from locked section can bypass `unlock` and hold lock 
until return], but it doesn't introduce diff noise correlated with 
indentations.

Another approach is allowing scoped_guards to have different indentation 
codestyle to avoid indentation of internal block [like goto labels for 
example].

However both of this approaches has their own downsides and are pure 
proposals

