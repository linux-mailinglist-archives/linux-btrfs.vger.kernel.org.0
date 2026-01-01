Return-Path: <linux-btrfs+bounces-20066-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E8805CED18A
	for <lists+linux-btrfs@lfdr.de>; Thu, 01 Jan 2026 16:11:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A7FA9300EE62
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 Jan 2026 15:10:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BCD52D46BB;
	Thu,  1 Jan 2026 15:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qPtWOjyC"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 144342D0607;
	Thu,  1 Jan 2026 15:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767280245; cv=none; b=M3yQ5+MRD7swcLQ8s+V2thOGVHoEO9O9w5oTaZ83oi5j8J2QgVbwx9pPW/XTTUBcaMRbPdAXeqfLF2Yi1dhjRS0G7Olq+3vICVPT0kAcdmppVtXRj+hRyIM3lXgW7Av+xhmPXgSeAyOMwS+p/DmwqBpu9Tz57CqeN5e9ByVzRDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767280245; c=relaxed/simple;
	bh=Hsig7qMqvEeHA2BrqJU8yUjptGfEzJylfzi+6cxd0ug=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UAhNo7V/rG0WLtdds9TziWGsIBNfm26Du0BEaHk95s+qRD0vbLhfKhKrUO741IFoYWS9J9h7hc+3lFlyQBGLEyqVGO4KWruzjqPyw6/3ubyQiQfkLwyynhzi4G+2jIVzJwqDHM4tRY/cj+zCuNHxVbKZZovK7Dbl02mRvZGILJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qPtWOjyC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79F6FC4CEF7;
	Thu,  1 Jan 2026 15:10:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767280244;
	bh=Hsig7qMqvEeHA2BrqJU8yUjptGfEzJylfzi+6cxd0ug=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=qPtWOjyCCVoSbrgS2By+iC+tj/ZvF1ekBhMhWNic+UdxunQzjzXupcVisCiQw0WRF
	 NfSFKZz3L6tMfm8jaTLqv9GRWlQOL6xHpYie5zd8kkt+JMjfhzXY1jmpw/Q4DpBLlP
	 LExnq3NxIvOMw1FV0XWjOJzHC+6/SZimsEdhk6znVGM2FLupF4/j+R3Zfb/gRIGx6m
	 cHTfRSzxvhQlZZ/JDvl7RU+A01rNwqRhEzPduJideLi32KeSMEyc6JOB+VeSwoe2GU
	 cORzzmAL15U743KQLWeY8vsDe6JTTeSrK8tHZY16Q/5hg8/0vTkrOJyxvGwfccZQqF
	 Qyd0UTVRBtdog==
Message-ID: <acdd84b2-e893-419c-8a46-da55d695dda2@kernel.org>
Date: Thu, 1 Jan 2026 16:10:36 +0100
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] overflow: Remove is_non_negative() and
 is_negative()
To: Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>,
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
 Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 linux-kbuild@vger.kernel.org, linux-sparse@vger.kernel.org,
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
 dri-devel@lists.freedesktop.org, linux-btrfs@vger.kernel.org,
 linux-hardening@vger.kernel.org, kernel test robot <lkp@intel.com>
References: <20251220-remove_wtype-limits-v3-0-24b170af700e@kernel.org>
 <20251220-remove_wtype-limits-v3-3-24b170af700e@kernel.org>
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
In-Reply-To: <20251220-remove_wtype-limits-v3-3-24b170af700e@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 20/12/2025 at 12:02, Vincent Mailhol wrote:
> The is_non_negative() and is_negative() function-like macros just
> exist as a workaround to silence the -Wtype-limits warning. Now that
> this warning is disabled, those two macros have lost their raison
> d'être. Remove them.
> 
> This reverts commit dc7fe518b049 ("overflow: Fix -Wtype-limits
> compilation warnings").
> 
> Suggested-by: Nicolas Schier <nsc@kernel.org>
> Link: https://lore.kernel.org/all/aUT_yWin_xslnOFh@derry.ads.avm.de
> Signed-off-by: Vincent Mailhol <mailhol@kernel.org>

So at the end, this patch got five kernel test robot reports:

  https://lore.kernel.org/all/202512221735.mRV4BZqB-lkp@intel.com/
  https://lore.kernel.org/all/202512230342.Lgha2HGH-lkp@intel.com/
  https://lore.kernel.org/all/202512251340.UApIFw9R-lkp@intel.com/
  https://lore.kernel.org/all/202512271618.33YepxDC-lkp@intel.com/
  https://lore.kernel.org/all/202512280906.wt7UNpya-lkp@intel.com/

All these are the same smatch warning just triggered from a different
place. I think it is still too early to undo that workaround in
include/linux/overflow.h, otherwise developers would be getting that
smatch report too often.

I will send a v4 in which I will drop this patch. This basically means
that the v4 is a revert to v1...

> ---
> Changelog:
> 
>   v1 -> v2: new patch
> ---
>  include/linux/overflow.h | 10 ++--------
>  1 file changed, 2 insertions(+), 8 deletions(-)
> 
> diff --git a/include/linux/overflow.h b/include/linux/overflow.h
> index 736f633b2d5f..ab142d60c6b5 100644
> --- a/include/linux/overflow.h
> +++ b/include/linux/overflow.h
> @@ -36,12 +36,6 @@
>  #define __type_min(T) ((T)((T)-type_max(T)-(T)1))
>  #define type_min(t)	__type_min(typeof(t))
>  
> -/*
> - * Avoids triggering -Wtype-limits compilation warning,
> - * while using unsigned data types to check a < 0.
> - */
> -#define is_non_negative(a) ((a) > 0 || (a) == 0)
> -#define is_negative(a) (!(is_non_negative(a)))
>  
>  /*
>   * Allows for effectively applying __must_check to a macro so we can have
> @@ -201,9 +195,9 @@ static inline bool __must_check __must_check_overflow(bool overflow)
>  	typeof(d) _d = d;						\
>  	unsigned long long _a_full = _a;				\
>  	unsigned int _to_shift =					\
> -		is_non_negative(_s) && _s < 8 * sizeof(*d) ? _s : 0;	\
> +		_s >= 0 && _s < 8 * sizeof(*d) ? _s : 0;		\
>  	*_d = (_a_full << _to_shift);					\
> -	(_to_shift != _s || is_negative(*_d) || is_negative(_a) ||	\
> +	(_to_shift != _s || *_d < 0 || _a < 0 ||			\
>  	(*_d >> _to_shift) != _a);					\
>  }))
>  
> 

Yours sincerely,
Vincent Mailhol


