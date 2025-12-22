Return-Path: <linux-btrfs+bounces-19955-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 50C15CD6E70
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Dec 2025 19:39:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1B9C73028FCB
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Dec 2025 18:39:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BF0C33290B;
	Mon, 22 Dec 2025 18:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oqOlyYFf"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 623072BCF5;
	Mon, 22 Dec 2025 18:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766428760; cv=none; b=MZCQ8qp9vUoRDWvbpTYc+m1RLh8PE5Qlqeo5tVGg2eI3IUIXIBgjH6/XqpkQgy+nGHZbQ1EeCds13VbsYe32VkmYk5nltC0FYPLgXBpEd8XOxAG8ROjdY39M5e0OEmiNLhOp5H304hG/7VtME0wvoAv1g2ltU+8o40ZKIi5Bcq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766428760; c=relaxed/simple;
	bh=LkRq9kuAyuxgNdzcszCitFOsSMy7gibIDiS0A45NiQQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZwZXuMhvao/qOw194g55g7yn5RECTxYnqtarvkB4tPZ/6CWgulLpgh1AzVtMWYj2vxAByO9btz7Zd7B/dWM0S5VELs2BGUMNKbNVKOF+jfJYpyeeJyy8s/BVFSE/NBPmy5nN8HzscIxr9T9myXhsGqTdYD7yaslG/TFg4mQDRxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oqOlyYFf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A205C4CEF1;
	Mon, 22 Dec 2025 18:39:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766428759;
	bh=LkRq9kuAyuxgNdzcszCitFOsSMy7gibIDiS0A45NiQQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=oqOlyYFft6Wzt4wVJf4CDio7jFWhzYs8F8zDe+9CBb8s3RCxhgI6PmW3kHvQ71bQV
	 43WGiakXUGUL0wHaCv5l7RH49JKgfi7uqX22oJ43aelEyB8it6OFfs6ypfg6ayd9Dz
	 u7Uwamylo0DaqrM3acuyq3V/QDPbuqf6d3ek0OcYd6abh625xFAPKitkNqcYsRfwVU
	 AqNZkNHNAEKWrhxDjm3TzJ8RH/YhqH7uG3MNddMRbVAzIemILAJzzH1vrxeb6Psiji
	 2ES1Au69Qb6s/AAf4gXwEH3GPKfmvqzoXUatQAPleETTbB+tQLTABK6HSXLQrs7e9f
	 Z62wUQXT7lxSA==
Message-ID: <efa713c6-36f5-4475-ad75-ce51cdc6819d@kernel.org>
Date: Mon, 22 Dec 2025 19:39:11 +0100
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] overflow: Remove is_non_negative() and
 is_negative()
To: kernel test robot <lkp@intel.com>, Nathan Chancellor <nathan@kernel.org>,
 Nicolas Schier <nsc@kernel.org>,
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Chris Mason <chris.mason@fusionio.com>, David Sterba <dsterba@suse.com>,
 Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kbuild@vger.kernel.org,
 linux-sparse@vger.kernel.org, linux-kernel@vger.kernel.org,
 llvm@lists.linux.dev, dri-devel@lists.freedesktop.org,
 linux-btrfs@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20251220-remove_wtype-limits-v3-3-24b170af700e@kernel.org>
 <202512221735.mRV4BZqB-lkp@intel.com>
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
In-Reply-To: <202512221735.mRV4BZqB-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 22/12/2025 at 11:03, kernel test robot wrote:
> Hi Vincent,
> 
> kernel test robot noticed the following build warnings:
> 
> [auto build test WARNING on 3e7f562e20ee87a25e104ef4fce557d39d62fa85]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Vincent-Mailhol/kbuild-remove-gcc-s-Wtype-limits/20251220-190509
> base:   3e7f562e20ee87a25e104ef4fce557d39d62fa85
> patch link:    https://lore.kernel.org/r/20251220-remove_wtype-limits-v3-3-24b170af700e%40kernel.org
> patch subject: [PATCH v3 3/3] overflow: Remove is_non_negative() and is_negative()
> config: x86_64-randconfig-161-20251222 (https://download.01.org/0day-ci/archive/20251222/202512221735.mRV4BZqB-lkp@intel.com/config)
> compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202512221735.mRV4BZqB-lkp@intel.com/
> 
> smatch warnings:
> fs/libfs.c:1628 generic_check_addressable() warn: unsigned '*_d' is never less than zero.
> fs/libfs.c:1628 generic_check_addressable() warn: unsigned '_a' is never less than zero.
> mm/vmalloc.c:4708 remap_vmalloc_range_partial() warn: unsigned '*_d' is never less than zero.
> mm/vmalloc.c:4708 remap_vmalloc_range_partial() warn: unsigned '_a' is never less than zero.

So smatch is not able to distinguish when the comparison comes from
a macro expansion.

Can this warning be ignored? Or should I remove this 3rd patch from
the series (and go back to v1)?  My choice would be to ignore this
warning.


Yours sincerely,
Vincent Mailhol

