Return-Path: <linux-btrfs+bounces-19916-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 70CA1CD2D87
	for <lists+linux-btrfs@lfdr.de>; Sat, 20 Dec 2025 11:53:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B25D330133C0
	for <lists+linux-btrfs@lfdr.de>; Sat, 20 Dec 2025 10:53:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0655309EE4;
	Sat, 20 Dec 2025 10:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sUQqJ2DM"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 028446F2F2;
	Sat, 20 Dec 2025 10:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766228018; cv=none; b=C3kIxCMOGtI+XkOj6cP2dzMpfO61QjZEhOi0JrrxRZT2atvIiPbeH6enEsSseV66j8YaumZzPMAZVj7a62YGcqacSErFAZG0EpV317pr9NjgzBoSj9ir5BZjPziGFpraGaWWlolnpp+D8479sOMK8RDKumhBxT7yZTNt+4pUFlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766228018; c=relaxed/simple;
	bh=Ss+5mPbbvjNJrIiYt7RXl5Z1m8teePuyHXVfel8E4lg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S/uYW13MRYQp10mSWSqM9xXRB30zer6l6/5ihCBfuMtLtnGyOnK2c/oR9DV9+f/wGdDDwC7cd56nJ8Eq7E0jKg1xgSGOqDJFEMj6h1THDhpaXoVeAZme24eL93ujuUXLwGa70Vg/PrA/SjHh1Yrw3ZLd85aSOjn32kF4ee0Zn84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sUQqJ2DM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E6F1C4CEF5;
	Sat, 20 Dec 2025 10:53:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766228017;
	bh=Ss+5mPbbvjNJrIiYt7RXl5Z1m8teePuyHXVfel8E4lg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=sUQqJ2DMXCQGvBYpTFsCz+lVwp89q5mD+kr5YtSb1BDT1mRNpq4yBLKP1kzXksGzE
	 y16Zw9x+sijodaJ85I+BU9EoTi/nklmVGfzgKq1to9vEAoHiyC+uE1ZP2wflv1E1vl
	 fut49dnupEBu4g+yYMDspGkjtzNcN0W0TYPNHN2e9sc4n90gqcG3asqLn33dHKmvYU
	 QMVQohYcWE6+iRMvIZn1XUdHXSJBUOjVlKneP94iAesOJ3rHdQcch/uc0zaRfSOue2
	 KxfvWdaaFbSvBDXALXq43h6Iw7UCE5dVEhzTq94zGCe5Q2wcBl7/6whFX2WyuPSWzy
	 rrMr5eYSmOyrA==
Message-ID: <664613c5-eee7-4130-8b21-0e47e7024636@kernel.org>
Date: Sat, 20 Dec 2025 11:53:29 +0100
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] minmax: remove useless cast in __is_nonneg()
To: David Laight <david.laight.linux@gmail.com>
Cc: Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>,
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
 linux-hardening@vger.kernel.org
References: <20251219-remove_wtype-limits-v2-0-2e92b3f566c5@kernel.org>
 <20251219-remove_wtype-limits-v2-4-2e92b3f566c5@kernel.org>
 <20251220100201.26d9b0db@pumpkin>
Content-Language: en-US
From: Vincent Mailhol <mailhol@kernel.org>
Autocrypt: addr=mailhol@kernel.org; keydata=
 xjMEZluomRYJKwYBBAHaRw8BAQdAf+/PnQvy9LCWNSJLbhc+AOUsR2cNVonvxhDk/KcW7FvN
 JFZpbmNlbnQgTWFpbGhvbCA8bWFpbGhvbEBrZXJuZWwub3JnPsKZBBMWCgBBFiEE7Y9wBXTm
 fyDldOjiq1/riG27mcIFAmdfB/kCGwMFCQp/CJcFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcC
 F4AACgkQq1/riG27mcKBHgEAygbvORJOfMHGlq5lQhZkDnaUXbpZhxirxkAHwTypHr4A/joI
 2wLjgTCm5I2Z3zB8hqJu+OeFPXZFWGTuk0e2wT4JzjgEZx4y8xIKKwYBBAGXVQEFAQEHQJrb
 YZzu0JG5w8gxE6EtQe6LmxKMqP6EyR33sA+BR9pLAwEIB8J+BBgWCgAmFiEE7Y9wBXTmfyDl
 dOjiq1/riG27mcIFAmceMvMCGwwFCQPCZwAACgkQq1/riG27mcJU7QEA+LmpFhfQ1aij/L8V
 zsZwr/S44HCzcz5+jkxnVVQ5LZ4BANOCpYEY+CYrld5XZvM8h2EntNnzxHHuhjfDOQ3MAkEK
In-Reply-To: <20251220100201.26d9b0db@pumpkin>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 20/12/2025 at 11:02, David Laight wrote:
> On Fri, 19 Dec 2025 23:39:48 +0100
> Vincent Mailhol <mailhol@kernel.org> wrote:
> 
>> The function like macro __is_nonneg() casts its argument to (long long)
>> in an attempt to silence -Wtype-limits warnings on unsigned values.
> 
> nak.
> 
> The cast is needed for pointer types, not for -Wtype-limits.
> which is why the '#if __SIZEOF_POINTER__ == __SIZEOF_LONG_LONG__'
> test is there.

OK. I will remove that fourth patch in v3.


Yours sincerely,
Vincent Mailhol


