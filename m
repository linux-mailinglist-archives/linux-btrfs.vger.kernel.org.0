Return-Path: <linux-btrfs+bounces-20094-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E088FCF052F
	for <lists+linux-btrfs@lfdr.de>; Sat, 03 Jan 2026 20:40:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3F33F30024C4
	for <lists+linux-btrfs@lfdr.de>; Sat,  3 Jan 2026 19:40:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDDD4270EDF;
	Sat,  3 Jan 2026 19:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ptk8Eq01"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ADDB3A1E72;
	Sat,  3 Jan 2026 19:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767469227; cv=none; b=HUA9Eou3UAaI4eDAGwUfzJVdiRIgiO2VDvSnayp0yi1f1t2C5dTJ9PMpmNWHS8J+RRl+X5AMxM+irx4qafSEk3uwtdW/cOh6iUq3PaonCBqRYsH5YsqkE8jdyRFw/vLUvDo1r2VfXd4jpBSJ9ItMJ8OuJ/F6zhMuMiDr1fXaI+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767469227; c=relaxed/simple;
	bh=tkpnTK4Qj656t1SjViYdrojmOrUb4VMdsQ1vCgGZFaM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JpB80xk6phQC6rXRixGV7d+rD3udH77sco7mA11vQGDtVs4ghgVA/6Mm9RQshnxjK/QkA4FfoyNjpW+v0l4oqgRSXdsP+8lC26XzaDi7SwjKvQoEHA/Y+It/aXWOHOIuEzGs68vThqbOIo7T0qL/FhmzS/DF/EiGXG0EFXENyP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ptk8Eq01; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2700C113D0;
	Sat,  3 Jan 2026 19:40:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767469226;
	bh=tkpnTK4Qj656t1SjViYdrojmOrUb4VMdsQ1vCgGZFaM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ptk8Eq017hq7LXx1dg/UvM82Pt2sJPL5TWUcNecJF4hcdqsylreXB1vc6LxpYKW/R
	 9BFtTUrUfQ6lI82kt6wwlhqf7M65pT8tHi9NtuTo7kfe+tZuRamjzVaBj8o2/xOmMS
	 LaoevR3U2LqszzHyshrbiae4H/vyhmY377Eo5dqooqKzC+noeELYMVY4t02yU2o+5C
	 qtYwbFBsNY0o0tndQO1CLdFe7U5Ma1IxgGojOEUmf4U6vKfryh1yieUj4B5oJplZ5N
	 grGmU4u6Dmx9hrkVInJgl38oRemDeRkyJojpy+NB09Tc3smQe+7xN7WuoL6oL+li+0
	 Drx6RpyJAa6UQ==
Message-ID: <e66bd09b-9879-4562-a71e-a1e1a964f3f2@kernel.org>
Date: Sat, 3 Jan 2026 20:40:17 +0100
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] overflow: Update is_non_negative() and is_negative()
 comment
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Randy Dunlap <rdunlap@infradead.org>,
 Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
 Nicolas Schier <nicolas@fjasle.eu>, Nathan Chancellor <nathan@kernel.org>,
 Nicolas Schier <nsc@kernel.org>,
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
 Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 linux-kbuild@vger.kernel.org, linux-sparse@vger.kernel.org,
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
 dri-devel@lists.freedesktop.org, linux-btrfs@vger.kernel.org,
 linux-hardening@vger.kernel.org, kernel test robot <lkp@intel.com>
References: <20251220-remove_wtype-limits-v3-0-24b170af700e@kernel.org>
 <20251220-remove_wtype-limits-v3-3-24b170af700e@kernel.org>
 <acdd84b2-e893-419c-8a46-da55d695dda2@kernel.org>
 <20260101-futuristic-petrel-of-ecstasy-23db5f@lindesnes>
 <CANiq72=jRT+6+2PBgshsK-TpxPiRK70H-+3D6sYaN-fdfC83qw@mail.gmail.com>
 <b549e430-5623-4c60-acb1-4b5e095ae870@kernel.org>
 <b6b35138-2c37-4b82-894e-59e897ec7d58@kernel.org>
 <903ba91b-f052-4b1c-827d-6292965026c5@moroto.mountain>
 <c84557e6-aa92-42e9-8768-e246676ec1e9@kernel.org>
 <aVlKTculhgJzuZJy@stanley.mountain>
From: Vincent Mailhol <mailhol@kernel.org>
Content-Language: en-US
Autocrypt: addr=mailhol@kernel.org; keydata=
 xjMEZluomRYJKwYBBAHaRw8BAQdAf+/PnQvy9LCWNSJLbhc+AOUsR2cNVonvxhDk/KcW7FvN
 JFZpbmNlbnQgTWFpbGhvbCA8bWFpbGhvbEBrZXJuZWwub3JnPsKZBBMWCgBBFiEE7Y9wBXTm
 fyDldOjiq1/riG27mcIFAmdfB/kCGwMFCQp/CJcFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcC
 F4AACgkQq1/riG27mcKBHgEAygbvORJOfMHGlq5lQhZkDnaUXbpZhxirxkAHwTypHr4A/joI
 2wLjgTCm5I2Z3zB8hqJu+OeFPXZFWGTuk0e2wT4JzjgEZx4y8xIKKwYBBAGXVQEFAQEHQJrb
 YZzu0JG5w8gxE6EtQe6LmxKMqP6EyR33sA+BR9pLAwEIB8J+BBgWCgAmFiEE7Y9wBXTmfyDl
 dOjiq1/riG27mcIFAmceMvMCGwwFCQPCZwAACgkQq1/riG27mcJU7QEA+LmpFhfQ1aij/L8V
 zsZwr/S44HCzcz5+jkxnVVQ5LZ4BANOCpYEY+CYrld5XZvM8h2EntNnzxHHuhjfDOQ3MAkEK
In-Reply-To: <aVlKTculhgJzuZJy@stanley.mountain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 03/01/2026 at 17:56, Dan Carpenter wrote:
> On Sat, Jan 03, 2026 at 12:10:45PM +0100, Vincent Mailhol wrote:
>> On 03/01/2026 at 11:02, Dan Carpenter wrote:
>>> Thanks Randy, for sending this to me.  I'm on the sparse list, but
>>> I've been on vacation and haven't caught up with my email. 
>>
>> Welcome back, hope you enjoyed your holidays!
>>
>>> I can easily silence this in Smatch.
>>
>> Thanks. I ran this locally, I can confirm that this silences the
>> warning. So:
>>
>> Tested-by: Vincent Mailhol <mailhol@kernel.org>
>>
>>> diff --git a/check_unsigned_lt_zero.c b/check_unsigned_lt_zero.c
>>> index bfeb3261f91d..ac3e650704ce 100644
>>> --- a/check_unsigned_lt_zero.c
>>> +++ b/check_unsigned_lt_zero.c
>>> @@ -105,7 +105,8 @@ static bool is_allowed_zero(struct expression *expr)
>>>  	    strcmp(macro, "STRTO_H") == 0 ||
>>>  	    strcmp(macro, "SUB_EXTEND_USTAT") == 0 ||
>>>  	    strcmp(macro, "TEST_CASTABLE_TO_TYPE_VAR") == 0 ||
>>> -	    strcmp(macro, "TEST_ONE_SHIFT") == 0)
>>> +	    strcmp(macro, "TEST_ONE_SHIFT") == 0 ||
>>> +	    strcmp(macro, "check_shl_overflow") == 0)
>>
>> But, for the long term, wouldn't it better to just ignore all the code
>> coming from macro extensions instead of maintaining this allow-list?
>>
> 
> Of course, that idea occured to me, but so far the allow list is not
> very burdensome to maintain.

Indeed, but my concern was more on how people would treat such smatch
warnings coming from the kernel test robot. It is very uncommon to have
an allow-list hard coded into the static analyzer. Actually, this is the
first time I see this. My fear here is that people will just uglify the
code rather than sending a patch to extend the allow list in smatch.

> I maybe should disable it for all macros unless the --spammy option is used...

IMHO, that would be an even better approach. That said, I am happy
enough with your previous patch which resolves my issue and which is way
better than updating the is_non_negative() and is_negative() comments as
I did in my patch!


Yours sincerely,
Vincent Mailhol


