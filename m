Return-Path: <linux-btrfs+bounces-20080-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EEF8CEF6DC
	for <lists+linux-btrfs@lfdr.de>; Fri, 02 Jan 2026 23:29:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 052D0301A1C7
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 Jan 2026 22:29:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABA4E314A86;
	Fri,  2 Jan 2026 22:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k6xLlHJf"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9A3D2586C2;
	Fri,  2 Jan 2026 22:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767392974; cv=none; b=k3lgJOVvV03swZFhYftdG5mRd7hyfuKv0220/qHPHOxcysbKHKSb34ohgvNiY+xxZq9jwQs7Xclkk4ViDNdS6lAlW9Vw+7gvTyKlQ+y0gPlTi2qMD7qiVvUx8a/Xw2dBteCZ65ZF7MvQ4lC9nYqHvsT1bnihPl95RP5Kl5w/K8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767392974; c=relaxed/simple;
	bh=wi+zGA27YppCjQQtK+30G05+hgFYfWmU162gQdX9VIc=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=TibCgME42uPX1ZEHF3v1hhfKurHu05t9YDG9GFuHLbofs3k+obr2pAz6XRIHb6DmThkCj/fpdH2Ji9W0uupkNSBy83kpH89HrzUgZZOFF11zk+rYAZNWA1psQvwgvqXbNtGAYiBMRoyDdqv9GoG6thc2unf1jEr+yP83D10Bwro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k6xLlHJf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 103E9C116B1;
	Fri,  2 Jan 2026 22:29:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767392973;
	bh=wi+zGA27YppCjQQtK+30G05+hgFYfWmU162gQdX9VIc=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=k6xLlHJfFRCChTKp+B5AYlpXseY4uf2Hlg1cFksKenkPt/OihX+c8AQ5bispHZo/J
	 y9/YDyyESH9iGb5KkzAP1+KkW5Qaaz0h1Og6++sqskN2etK3bB7b47yxEeR+T5l7x5
	 V9Exgs8Dn+yVof+XpyP1Bt9NtGgFnHEt8kW564V8LPEVJuiodMBABT0M5C9hnHa55G
	 feyuKfgjRr9ekIKi+eHb7erZGDotRTIxQJmvm5dBnYx7LBMhiiHYg4QNnqTvYkJNRp
	 RDm1H53jcgogjaxWNzlS8WFUWhC1rzXzyruEA3pn0jT9w5GnZlCEFiRa1XvHTYoVwh
	 tGLPBlsMc398A==
Message-ID: <b6b35138-2c37-4b82-894e-59e897ec7d58@kernel.org>
Date: Fri, 2 Jan 2026 23:29:23 +0100
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH] overflow: Update is_non_negative() and is_negative() comment
From: Vincent Mailhol <mailhol@kernel.org>
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
 <b549e430-5623-4c60-acb1-4b5e095ae870@kernel.org>
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
In-Reply-To: <b549e430-5623-4c60-acb1-4b5e095ae870@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The is_non_negative() and is_negative() function-like macros initially
exist as a workaround to silence the -Wtype-limits warning. Now that
this warning is disabled, those two macros have lost their raison
d'être. Or so we thought.

In reality, smatch still produces a similar warning and so, it is
unfortunately still too early to undo this workaround.

Update the comment to point to smatch instead of GCC's -Wtype-limits.
Add a link to the thread in which this was discovered.

Suggested-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Link: https://lore.kernel.org/all/CANiq72=jRT+6+2PBgshsK-TpxPiRK70H-+3D6sYaN-fdfC83qw@mail.gmail.com/
Signed-off-by: Vincent Mailhol <mailhol@kernel.org>
---
 include/linux/overflow.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/overflow.h b/include/linux/overflow.h
index 736f633b2d5f..d84194fc783b 100644
--- a/include/linux/overflow.h
+++ b/include/linux/overflow.h
@@ -37,8 +37,8 @@
 #define type_min(t)	__type_min(typeof(t))
 
 /*
- * Avoids triggering -Wtype-limits compilation warning,
- * while using unsigned data types to check a < 0.
+ * Avoids triggering "unsigned 'a' is never less than zero" smatch warning,
+ * Link: https://lore.kernel.org/all/acdd84b2-e893-419c-8a46-da55d695dda2@kernel.org
  */
 #define is_non_negative(a) ((a) > 0 || (a) == 0)
 #define is_negative(a) (!(is_non_negative(a)))
-- 
2.52.0

