Return-Path: <linux-btrfs+bounces-19872-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FD50CCDC5E
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Dec 2025 23:19:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 14E49302C455
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Dec 2025 22:19:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A6A92E7160;
	Thu, 18 Dec 2025 22:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ZwZtLpv4"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D99E1F4606
	for <linux-btrfs@vger.kernel.org>; Thu, 18 Dec 2025 22:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766096377; cv=none; b=Lx0igAnzQud5u8mr/36bouT8eG4bSA5IE4RmUDWpJ/K67YjgWwNopF804V3JotZp3ps7ynuRukMa5KJRBwi1A+aAc9f6eyDp7pzCL0JQBxn/00NwMVGrCUsxV8bO+Pkf2FjpHKxRszZpWkiHNfmNJwSurc3hwIPNu+RKc/jJ07w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766096377; c=relaxed/simple;
	bh=8pSoe1Bmi+W4NijU12aYw3XcputPGwR7O6GNCXc/aeM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lAYMpeiFY6GuJzpaE2HrJyXM7SHkR4bR5bZ8pf1b2US0x1h/sjHQrAxtqT2gJuy5GBBzahT3QpkzcsuDrtSWCFolcLZkP3JCvkFDogJWLT+ZoSIKiWPFTe4+aJ96IdFsLGreZmxexqK56LJI9R5J9VVmXmdk0v/V+7/MlufjClg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=ZwZtLpv4; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b725ead5800so164678966b.1
        for <linux-btrfs@vger.kernel.org>; Thu, 18 Dec 2025 14:19:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1766096373; x=1766701173; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Jndt3SqYxM2jZAywVtZf3yYDl10GUxyvdAXQWbglW60=;
        b=ZwZtLpv496T8ZsKzK98v5OSTqJ+2OR6/8V4sq9jvyvs32ekGxwJipxbLSee4SDWDgL
         e0IrB6nxmuc0/GcdUSa6MUqthiN91oGWIPLU8V49Cuu4XJAyQDP20CYR0qDQeyhzraF6
         wB0oEr5+IqOwH8Yrrc9ORQCPmyGafp2ck94Is=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766096373; x=1766701173;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jndt3SqYxM2jZAywVtZf3yYDl10GUxyvdAXQWbglW60=;
        b=Y7ku4oQgwrzFQRwIFcFJapx48J6Oql+8RghZB1NipdwnAd+xtbrpPH4LNZjrW6zMDv
         qlLstpsOI4V5IDf4+ZKTKdcjF7E1imElcSt+hQKp1gcLn+RT2y6R59vpFUuoNP0jSyyL
         1b+hfQwQkAzg+j6qbkXc3xvnYD477ViOz4uxSAdAyYkO5T4cG99L1p30WQcQ3Ev6ufQb
         8DOhAGvdTnnN+hSHK6MMYLDkbVkFqqNFoOLkshZ582XPtNmkxwdMrwmuAkfEUAOtkvnK
         X0USzFOZ/hhGbpRK+9H7+uYxV82++Jbi5XxfsnXUye7uJ3GD0xlueiYez27aBfc0rlEG
         ga6w==
X-Forwarded-Encrypted: i=1; AJvYcCVBXpQRFX/Pi/0Kx7JwgP+gi4onZM+ml1ImxNW6wA4kdl9pw8DDLLSEPcWixhwjW6I6teb9W+A3SlO5yw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzPe7W0Mi+sYqDmEQW4PCm5JoJXrN5NaB+mUkG5jxMO9oXPUfr1
	0pJ7Vp7vKoP62AapU5x38mS3M9WaKVMFzjCiqTCMoA7VX3ISvheZw6qA7XD2dgnpcEH1SVjMULg
	blvgOJm3s6g==
X-Gm-Gg: AY/fxX59EUyBVxlcOO80WsenqYOhVhHWTW5FUp9TL80LCAb+CgF7ZYz5fLm9LZcj+7/
	RUYAfHYiSFC9HHx8Q2NpUiYtCa35Ax6yhsCyVPlMqyw78nfpabv5vTUhEzhsiuNt+12wvv+XBna
	gDyxkS4B4hbwzxNSw6z9TxPSczMYf+q6hhQpPDFjLAUyAS5UcVSqH6nLxwQWbkErag9VENmBySF
	e76suSh+q8U/G9iyP087Fx2RUtvOQtmk8qDFBY9LFzkXQBCAjjOygrCNTDaQcGXcVr9eZ+hBpYC
	cRlZ1c/aFZdAOFJ9pT+n7P7wo9G9RpRwGz/5wNIOMcNh31PANLAOSXb7HZlFMNO+waVA2Jr1GHi
	N35lcLD/K0v64lqQFbWMTzRAEKPyaMT/MxJF6rkS8+6oGBYZ38bqyy8nNg4QJGgH8KjDbZobqpA
	0p3PsQtkjViuSGkeEl9WN+f3lx8LHaZ4q2ZU+AzRD5rTbF+gnt2ZSZ6EIbtF75
X-Google-Smtp-Source: AGHT+IHYDCFM+p1+YsLpfYr710BobiNkY8/h4H6fRWtBS9zFG+JJhBtiPsi+2ilMdxUstwnZi+MKbA==
X-Received: by 2002:a17:907:6ea4:b0:b80:f2e:6e1 with SMTP id a640c23a62f3a-b803722a7demr84073966b.43.1766096373235;
        Thu, 18 Dec 2025 14:19:33 -0800 (PST)
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com. [209.85.218.48])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8037ab4f0dsm56497766b.15.2025.12.18.14.19.32
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Dec 2025 14:19:32 -0800 (PST)
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b7a6e56193cso203344566b.3
        for <linux-btrfs@vger.kernel.org>; Thu, 18 Dec 2025 14:19:32 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUXwrqTBkv1Z0SfSG6VHC3RZi5B0FyrsuAGoASloLJNHQp5PjSTW2r+EFI9JxFzdCEnSH5gb5k6VSgxhA==@vger.kernel.org
X-Received: by 2002:a17:906:4fd0:b0:b77:1b05:a081 with SMTP id
 a640c23a62f3a-b8036fade7bmr90274566b.27.1766096371748; Thu, 18 Dec 2025
 14:19:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251218-remove_wtype-limits-v1-0-735417536787@kernel.org>
 <20251218202644.0bd24aa8@pumpkin> <CAHk-=wjrNyuMfkU2RHs28TbFGSORk45mkjtzqeB7uhYJx33Vuw@mail.gmail.com>
 <20251218220651.5cdde06f@pumpkin>
In-Reply-To: <20251218220651.5cdde06f@pumpkin>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 19 Dec 2025 10:19:15 +1200
X-Gmail-Original-Message-ID: <CAHk-=wjMVfu-aiQ8aNHcgsh6hYwbZCoX1B4ps2scibokO8EZ+A@mail.gmail.com>
X-Gm-Features: AQt7F2rQbkmjgbTYE3I0u5o-OP0XOCVU9BjhcXCAu035ycTBeAxGxqvP-3yEHoo
Message-ID: <CAHk-=wjMVfu-aiQ8aNHcgsh6hYwbZCoX1B4ps2scibokO8EZ+A@mail.gmail.com>
Subject: Re: [PATCH 0/2] kbuild: remove gcc's -Wtype-limits
To: David Laight <david.laight.linux@gmail.com>
Cc: Vincent Mailhol <mailhol@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nicolas Schier <nsc@kernel.org>, Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>, linux-kbuild@vger.kernel.org, 
	linux-sparse@vger.kernel.org, linux-kernel@vger.kernel.org, 
	llvm@lists.linux.dev, dri-devel@lists.freedesktop.org, 
	linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 19 Dec 2025 at 10:06, David Laight <david.laight.linux@gmail.com> wrote:
>
> True - especially for code like:
>         if (x < 0 || x > limit)
>                 return ...

Exactly.

And yes, sometimes the type of 'x' is obvious, and having the range
check for zero can be seen as redundant for unsigned types, but even
in that "obviously redundant" case the code is *clearer* with both the
lower and upper range checked.

And apart from being clearer, it's also then safe when somebody does
change the type for whatever reason.

And lots of types do *not* have obvious signedness. They might be
typedefs, or have other much subtler issues. Something as simple as
"char" has subtle sign behavior, and when it comes to things like
enums the signedness can also be very non-obvious.

So having both sides of a range check is *always* a good idea, even if
one side _may_ be redundant for some type-range reasons.

And there really is absolutely _no_ sane way to get rid of that broken
warning except to just disable the warning itself. All other
alternatives are actively broken - adding a Pragma only makes the code
worse and illegible, and removing the lower bounds check again only
makes the code worse.

So this is a compiler warning that actively encourages worse code. It
needs to *die*. It doesn't fix anything.

And the people who point out that it can show bugs - absolutely *ANY*
warning can do that. That doesn't make a warning good. Any code can
have bugs in it.

The sparse warning I outlined (and that Vincent wrote up and tested
and made into a proper patch) was actually showing interesting issues
in a much better way.

And that sparse warning could certainly be improved on too - I think
that one too would be better if it noticed "oh, it's a pure range
check, so let's not warn even when the code otherwise looks dodgy".

But at least it didn't warn for obviously good code like the horrid
broken type-range warning does.

                  Linus

