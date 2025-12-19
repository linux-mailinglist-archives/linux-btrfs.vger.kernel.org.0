Return-Path: <linux-btrfs+bounces-19905-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 86826CD2187
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Dec 2025 23:22:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 53C703064DEE
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Dec 2025 22:22:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DB6223ABA1;
	Fri, 19 Dec 2025 22:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BfZlARGA"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13509199949;
	Fri, 19 Dec 2025 22:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766182919; cv=none; b=Cp8Yd9XJKpeXAyxpkO4KWfqCUdJanAg/vqXPEc2/b5n2wtrSZJ9Ze5nn7fakuCJUaXwQ62u8AE/2DUa5XYJFM+cyYIK8lpKavgS1HyekwzwgeDVZwzBLb3KzoirURtUkpLuR+PnLGa2M7239k4s2r5DELoBjt9D4EdYM9FjGAos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766182919; c=relaxed/simple;
	bh=FsqeszlxIHiTohzZngxRkVyLF51Apt1E+JyyqMd1yFE=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=O18e0Ga7b9TI6a5ZxoJW5vqFRP5MwwfpgwKiTUAMj15URLZMXVWaa5JCZPSoYNbiSJrH8FW1ybe4SePz3ZqPSF+GBiwGcKo2JEdJjsHzLKOk6nallygORBFvww1UfscOBqhLhDNQOCNiLyxfzOWDNhERJxjDTJn/kyfeBcO1F/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BfZlARGA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BCD1C4CEF1;
	Fri, 19 Dec 2025 22:21:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766182918;
	bh=FsqeszlxIHiTohzZngxRkVyLF51Apt1E+JyyqMd1yFE=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=BfZlARGAHPN0qekSR8SbUYz5e5FGLDRFtWswsHunHgQUq76yZFStl0MKmmdaSBSbb
	 8j226H6+xgy54SqzvUCjzQ3bc+FMExKfSsBhpulCtCH3kzm3VOSL9YNdz4lTDl9sTP
	 L0sqHNN+t0KTZRZEPsTCSfmI7CGvgktbhizWhLHw1o/nENDULPNP5fvpA+rbyL9Zgf
	 JA0ZyoElHuvQRTghyYXwn6c68bK4wsm/gPcNvIHfdNcKd4WV2B/gG9pARAekDvJnsi
	 co7TGJx7jUtnMxenfUxYDVFTpQnqrWSwjInLioJJXDYRAPXSxmn/xlgnvarAC8m1+W
	 dLOpywftaZLvQ==
Message-ID: <3ead6685-a5d4-4113-923d-84bf8aee49b3@kernel.org>
Date: Fri, 19 Dec 2025 23:21:51 +0100
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] kbuild: remove gcc's -Wtype-limits
From: Vincent Mailhol <mailhol@kernel.org>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>,
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 linux-kbuild@vger.kernel.org, linux-sparse@vger.kernel.org,
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
 dri-devel@lists.freedesktop.org, linux-btrfs@vger.kernel.org
References: <20251218-remove_wtype-limits-v1-0-735417536787@kernel.org>
 <20251218-remove_wtype-limits-v1-1-735417536787@kernel.org>
 <aURXpAwm-ITVlHMl@stanley.mountain>
 <480c3c06-7b3c-4150-b347-21057678f619@kernel.org>
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
In-Reply-To: <480c3c06-7b3c-4150-b347-21057678f619@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 18/12/2025 at 23:31, Vincent Mailhol wrote:

(...)

> Concerning clang, here are the statistics:
> 
> 	$ make -s LLVM=1 CFLAGS_KERNEL="-Wtype-limits" 2>&1 | grep -o '\[-W\S*\]' | sort | uniq -c
> 	      2 [-Wtautological-type-limit-compare]
> 	     15 [-Wtautological-unsigned-enum-zero-compare]$ make -s LLVM=1 CFLAGS_KERNEL="-Wtype-limits"
> 
> (done on a linux v6.19-rc1 defconfig with clang v20.1.8)
> 
> Not so many warnings, at least, less than what I would have thought!
> 
> -Wtautological-unsigned-char-zero-compare and
> -Wtautological-unsigned-zero-compare gave zero findings. So those two
> can be enabled, I guess? I am still surprised that
> -Wtautological-unsigned-zero-compare gives nothing. I would have
> expected some kind of false positives on that one. No sure if I missed
> something here.

I was a bit worried of that -Wtautological-unsigned-zero-compare got
zero findings so I reran a build but this time on an allyesconfig
(minus CONFIG_WERROR):

	$ make -j8 -s LLVM=1 CFLAGS_KERNEL="-Wtype-limits" 2>&1 | grep -o '\[-W\S*\]' | sort | uniq -c
	     29 [-Wtautological-type-limit-compare]
	     55 [-Wtautological-unsigned-enum-zero-compare]
	     76 [-Wtautological-unsigned-zero-compare]

This is closer than expected. And looking at the findings,
-Wtautological-unsigned-zero-compare also warns on some sane code
which is just doing some range checks.

(...)

> In conclusion, I agree that we could enable three of clang's
> -Wtype-limits sub-warning. But this is not the scope of that series. I
> would rather prefer to have this as a separate series.

With this, I want to amend my conclusion. both
-Wtautological-unsigned-enum-zero-compare and
-Wtautological-unsigned-zero-compare should be kept disabled. The only
candidates are -Wtautological-type-limit-compare and
-Wtautological-unsigned-char-zero-compare.

-Wtautological-unsigned-char-zero-compare would need another study. It
seems that this warning is only triggered on platforms where char is
unsigned which explains why I did not see it when building on x86_64.

Well, I think I will stop this clang's -Wtype-limits study for the
moment. If anyone wants to continue the work please go ahead.


Yours sincerely,
Vincent Mailhol

