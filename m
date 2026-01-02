Return-Path: <linux-btrfs+bounces-20079-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 196C7CEF6BB
	for <lists+linux-btrfs@lfdr.de>; Fri, 02 Jan 2026 23:27:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6AE5F301A70F
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 Jan 2026 22:26:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E8E43064AA;
	Fri,  2 Jan 2026 22:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rob5AMor"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 476EB2D249B;
	Fri,  2 Jan 2026 22:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767392804; cv=none; b=dScFi8sY4WxpCdYO+HzcRHldxLcK4Wqv5OgAdfXS1MNaRiPEntBEm7k4ofvuKXOgmPqE1rIxSMzzckUBxl+2TFUADBB7pfldFZnOlJj2guCvpxfhcVhqVkz3cUk+z6R/Z0NJhe++a0YQbaNWVuduTF1yatIJ/LaEkvDRO2PjvgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767392804; c=relaxed/simple;
	bh=J/sL983X/0vBalHqoLpr7GXM37hk7msCvf822DzhzBE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f29KG+PCFh8sNSbRDbLBxNiUq+zgJWF8C3ErYFG1tjcDiEhEfQh+N8aO6xAvDhAWrHkX2FiPdBcbksQTiDN5Ff37ZuovgaI4VIF8KrH8JhXHO95CeXnH0DFaJ/d5Z0RTtOBWuF/gbRYesRge1iqdqKGc2yRnMxsPUI+gvr1ksWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rob5AMor; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58FD7C116B1;
	Fri,  2 Jan 2026 22:26:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767392803;
	bh=J/sL983X/0vBalHqoLpr7GXM37hk7msCvf822DzhzBE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Rob5AMorNzzOXqHUHII4Eyuge1d9SSvjvsr1PigXkpLA3u3daGl+zwPd5eRYpkfMM
	 qxcXQuHapVnsY/MNlmHqO3J45yfuJ2uskTZopAbvXRDab5WKoYb8Vdxpl4kP1gGpIs
	 t5qyDYOBHx0gObQUbMOzeeYMees/7+WTSl1RAz6u+OfblFw7ldAfF3kn1Ol4Komx+J
	 sqQnM5QCl0MeoLIz6jKIby6MbErRLjEF/8nQrO2WDNEtNw2NspsiGOrjvZx/h7sNAe
	 d8elRWFf7R7C76OcZEAtJG983L4Od8KN9YCyaqQvWT2BTlKLjed4tfxm/0QciNGLGl
	 oQKeKE+ukejeA==
Message-ID: <b549e430-5623-4c60-acb1-4b5e095ae870@kernel.org>
Date: Fri, 2 Jan 2026 23:26:35 +0100
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] overflow: Remove is_non_negative() and
 is_negative()
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
 Nicolas Schier <nicolas@fjasle.eu>
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
 linux-hardening@vger.kernel.org, kernel test robot <lkp@intel.com>
References: <20251220-remove_wtype-limits-v3-0-24b170af700e@kernel.org>
 <20251220-remove_wtype-limits-v3-3-24b170af700e@kernel.org>
 <acdd84b2-e893-419c-8a46-da55d695dda2@kernel.org>
 <20260101-futuristic-petrel-of-ecstasy-23db5f@lindesnes>
 <CANiq72=jRT+6+2PBgshsK-TpxPiRK70H-+3D6sYaN-fdfC83qw@mail.gmail.com>
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
In-Reply-To: <CANiq72=jRT+6+2PBgshsK-TpxPiRK70H-+3D6sYaN-fdfC83qw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 02/01/2026 at 12:04, Miguel Ojeda wrote:
> On Thu, Jan 1, 2026 at 9:13 PM Nicolas Schier <nicolas@fjasle.eu> wrote:
>>
>> thanks!  I think it's a bit sad to keep code only to make some checker
>> tooling happy, but for now it seems to be the right thing to do.
> 
> Perhaps a patch to add a comment explaining Vincent's findings would
> be a good outcome, i.e. explaining the reason it needs to remain in
> place for the moment 

OK. But I will send this as a separate patch as a reply to this thread
so that this can be discussed separately without having to respin the
main series again and again. I will add it back to the main series only
if it get a decent level of Acked-by tags.

> (even a link to lore.kernel.org to this thread would help).

It is rather uncommon to add lore.kernel.org links in the code comment.
But I am not against. I will do as you suggested so and see what people
think of it.


Yours sincerely,
Vincent Mailhol


