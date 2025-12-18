Return-Path: <linux-btrfs+bounces-19866-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D1848CCD860
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Dec 2025 21:27:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A21F6301BEB8
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Dec 2025 20:26:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D84C2D2387;
	Thu, 18 Dec 2025 20:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A4oOR5St"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7A3D29DB61
	for <linux-btrfs@vger.kernel.org>; Thu, 18 Dec 2025 20:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766089610; cv=none; b=Si/bNJAQMRspWNuRK+3TPrBa5pYwEpSdaInErNc6EXDtO9kATOtLWu93IbZu9Ft8eE1zhhre7QrEGoUhdttz5Wpe0Zo1Qz8uNlzFSJGYguJiwHiwS4PTQWpkMoAe9vi0FhnG+lM5yzIpfaP3kACLW9bIzH+9RupRY7MCKv7Is9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766089610; c=relaxed/simple;
	bh=v5r1UHjsCj16c8Aasp3mvbgbCLuKmbAvogVL8SAdBfo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=US/xMmfBV0HNH5tD26GOf7kUm6i0fOURMPM0gkTKdPTP/Sd2P00iBmn5onl6d0n8iEWgp9RvTcSHYoQxuc65ENB7ROeabVFzEcjVfJZREy+k1VnjEXIEO91XolRgePjxxQq4vEpRWbHXrz0Lw1MMz6iGHxU25Djh8mGqmNfoJ04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A4oOR5St; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-47796a837c7so8292435e9.0
        for <linux-btrfs@vger.kernel.org>; Thu, 18 Dec 2025 12:26:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766089607; x=1766694407; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vgQxtQzmfa6dtQc2HKAnCJeJmQcolaeO4Fk6tR2yJow=;
        b=A4oOR5Stdx3432l8u0TFufSmg3nigHFbi0j4qVcs5l8+J2e16idgnkEp8v24X2Za2R
         UaDr9dn0rxN41opN86iQIo2EaHonZEh7rqZ1GQZ90yuYaDVQZsEcxOf1ScUp7+H66Edi
         bZQq2r3ZygQLznT5rXGwpHqeoTdxD2B54ry4urWEtcmsmUVNYFi+FJLxHeJ24A4ZVY2e
         0P+5d4Dscix0f4qwIn02b0NV540/JkZbM6hQ10DqfdbIniYY9JcXRKyQraT+fIzTyLbF
         6SIvnw2RkuoEgr38NPkpxeqHPZZDfQnCqomiKutpplGsdLYruWq49tmLzWthCQ+JCj45
         H7XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766089607; x=1766694407;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vgQxtQzmfa6dtQc2HKAnCJeJmQcolaeO4Fk6tR2yJow=;
        b=GdlLXAWWB0gHlU7u25U14+N7IO12kp875GlnLxDPjn+WfWE3s0HWOy6Crugqc3Zt9P
         r1pZJ4ISVEKAMkGNscjjrMfe/mJ06j6O6rqMDtn+eYBI+o5i7ERgfxom/04jAHN2uvmo
         lq9D04crSN5YvZx8pjciEqjsP28E6OANQQY52XLaE73pQyd1RPAmgJJpPGTHYItjxcp+
         0J+stZqbdWu93n/LDty8Q49QwUAxBCbu5Jt41nJ9kStZUXUenfcLAPtey4O8Ra9jBWVJ
         ihECngQjmIiErnYyt+mBPU9yikwRFRNEOCCFwxYYopghn6yNUdRS8pRM7uwXJE12J185
         ZLyA==
X-Forwarded-Encrypted: i=1; AJvYcCVs47d54eoKaWsiXMRG6htWJOQb+vHmn/uxxjOrwHL2CPTD4vgHW2oaFs105RHdojn2L5XQlfdtGA3PpQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyzqtETvaq8DXT0sR/P9GNYmLevBAlLwiv2oe5LePyfk0i93RdO
	5k0vUxSYci16myT1n+nM7bJNUsWp9CbVLPa6K5LYxLiMwcxJju/X7as2
X-Gm-Gg: AY/fxX7jQZhkxzNdquM9/NTixSfU5JP1kqA/TyPeoWM6Pp4BEyiUv0AhA71WMQOVfZF
	ru4OX9vS95VtBxpnfYxVljb42V8wTGyCcbOYNSYb1XmUT7gYTdRtNB9vGUr7v+9MIfRyvT/29pT
	Oq9d5m7GJyZy/p6H4L9yQKvCjkdSc1YMiu3VpEWNrVdsEHUsTKH2GXh1/NcvMZ15Yt5o261kenQ
	PeUeIjxVn/CGHNTqBj0PcwX/H6RIUq4oAOzShd8gaEGojEs/ExbcnEzW5RKnQsj9tx4ldVt7tC6
	wja0h5JXnoq2bUGiPIUkdTTClswmplyB6LQFb+UmtpjlO2UNPTC7I1808CbZXYABNzfmb2afL8E
	wGZwbFJ9a5hbYANmRB7ZZaQk6EMMxsmUyZIbfnwCio5ZH1tDQGhLSV9mpkugKxjyPS0hAg/qpx9
	AmrwaCCwEWvAFCBKpUsV9zTI3o7jmgKF7lw8iNELRcZ1lcBIgb5oiD
X-Google-Smtp-Source: AGHT+IFDrnuciBUHAt5nZOA+oA3L3vvumVlk/WEBkRVYYRodfFUMiH6N2Ng/k7jEFXB9WnpS2Kxx5w==
X-Received: by 2002:a05:600c:46cb:b0:477:7f4a:44b4 with SMTP id 5b1f17b1804b1-47d1953b78cmr4635005e9.1.1766089606918;
        Thu, 18 Dec 2025 12:26:46 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4324eaa08d9sm872464f8f.30.2025.12.18.12.26.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Dec 2025 12:26:46 -0800 (PST)
Date: Thu, 18 Dec 2025 20:26:44 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Vincent Mailhol <mailhol@kernel.org>
Cc: Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>,
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill Wendling
 <morbo@google.com>, Justin Stitt <justinstitt@google.com>, Maarten
 Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Chris Mason
 <clm@fb.com>, David Sterba <dsterba@suse.com>, Linus Torvalds
 <torvalds@linux-foundation.org>, linux-kbuild@vger.kernel.org,
 linux-sparse@vger.kernel.org, linux-kernel@vger.kernel.org,
 llvm@lists.linux.dev, dri-devel@lists.freedesktop.org,
 linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/2] kbuild: remove gcc's -Wtype-limits
Message-ID: <20251218202644.0bd24aa8@pumpkin>
In-Reply-To: <20251218-remove_wtype-limits-v1-0-735417536787@kernel.org>
References: <20251218-remove_wtype-limits-v1-0-735417536787@kernel.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 18 Dec 2025 19:50:00 +0100
Vincent Mailhol <mailhol@kernel.org> wrote:

> I often read on the mailing list people saying "who cares about W=2
> builds anyway?". At least I do. Not that I want to fix all of them,
> but on some occasions, such as new driver submissions, I have often
> found a couple valid diagnostics in the W=2 output.
> 
> That said, the annoying thing is that W=2 is heavily polluted by one
> warning: -Wtype-limits. Try a gcc W=2 build on any file and see the
> results for yourself. I suspect this to be the reason why so few
> people are using W=2.

One possibility is to conditionally add _Pragma() inside #defines to
turn off the warning for the main false positives (I guess all the
BUILD_BUG_xxxx and statically_true are the main ones).
But don't 'bloat' the #define expansions for normal builds.

	David

