Return-Path: <linux-btrfs+bounces-19904-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B11FACD213F
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Dec 2025 23:06:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1DCB5301DE03
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Dec 2025 22:06:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 281EE313295;
	Fri, 19 Dec 2025 22:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JtoU2D4g"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 506D4261B70;
	Fri, 19 Dec 2025 22:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766181973; cv=none; b=eQnJqS0f9et6mpaGkWGV3QyKGgd7jskiPbEIuaFeuwhVLfErxdHcnfsCfRhLBQFMbLQ8plHS0UgtvFdxMdhmpw71pbeGjMtp/ER4rm9qno1dZDcrAak93nW4N2rGCbJqaW02roB4CpSZ/Ge0nR9N1H5X9X3QH1dpL4KO+MVhtyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766181973; c=relaxed/simple;
	bh=BfYzM2JynWv2bbyWkcttr2tIQERUv3zybRmV4VkrM2c=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=oFmQCaLuGJuak/hC6uM/eGh85I0+ZzHbO+Rcvcv6ZVxV75OxkH+NqGtbzRI4XouS63HoyvRigGPzD2tMyC8PnOotrP0zddv+Dwl/iSMxG/wrF7z1pF1Q7FHlv1QepRCQjJaL/+PqKnKEGypQ/NaevSFWHGjGF1OXrFo87Od9njo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JtoU2D4g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DC61C4CEF1;
	Fri, 19 Dec 2025 22:06:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766181972;
	bh=BfYzM2JynWv2bbyWkcttr2tIQERUv3zybRmV4VkrM2c=;
	h=Date:Subject:To:References:Cc:From:In-Reply-To:From;
	b=JtoU2D4gRoV6n6Fh3aCObG1kFuEuVqvxYWS/tN4GUY3aETqv2xDpytaCrciBdKNf6
	 v+DpLpdtZoiBhvufNBvNjPUjFET+1HdhCNt7s7pmxqt6pmhzIIKFKOVOdWKgeMqQEw
	 zQSInC+jOddp1AvqzAgXgrsy0q4xM7nDbtPLx6x063J81K51hXUlKwUEJOJXtAKK6d
	 RSLjM9wiOlEGBLWeDYX1JUriTuTJKs5wtBLd3m+wlMioHyRs6wwyS3bBx3d1ia3LnE
	 grZY0N2Bqjch5ycS16pLRBUejHrulMCQWH/U/UtnAhd2ruw5V2nItWFUyFS3MpnfNY
	 625DGhDY6maoA==
Message-ID: <8c9f2a57-9541-427e-b5ac-aade03f85f65@kernel.org>
Date: Fri, 19 Dec 2025 23:06:05 +0100
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] kbuild: remove gcc's -Wtype-limits
To: Nathan Chancellor <nathan@kernel.org>
References: <20251218-remove_wtype-limits-v1-0-735417536787@kernel.org>
 <aUT_yWin_xslnOFh@derry.ads.avm.de>
Content-Language: en-US
Cc: Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 linux-kbuild@vger.kernel.org, linux-sparse@vger.kernel.org,
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
 dri-devel@lists.freedesktop.org, linux-btrfs@vger.kernel.org
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
In-Reply-To: <aUT_yWin_xslnOFh@derry.ads.avm.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 19/12/2025 at 08:33, Nicolas Schier wrote:
> On Thu, Dec 18, 2025 at 07:50:00PM +0100, Vincent Mailhol wrote:

(...)

> Thanks for the effort!  (This allows to revert commit dc7fe518b049
> ("overflow: Fix -Wtype-limits compilation warnings").)

Ack. I will send a v2 with more patches to cleanup some -Wtype-limits workarounds.

> Reviewed-by: Nicolas Schier <nsc@kernel.org>

Thanks!

Yours sincerely,
Vincent Mailhol


