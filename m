Return-Path: <linux-btrfs+bounces-2861-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B922B86B44F
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Feb 2024 17:11:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC7C81C223E2
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Feb 2024 16:11:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B86A15E5DD;
	Wed, 28 Feb 2024 16:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aR5LDzrK"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7BDC15DBBA;
	Wed, 28 Feb 2024 16:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709136663; cv=none; b=SItcfcQoqFm+7xWaCSabs7fQoLTJ6MhBqg97Tw+iWcP/R2CGs7xhuFWvkX/1UsVbtva9K8eIBEra8bsatlQX5oxmcQvk8uemwvtSVxZxCdWVFOtRKiqgkJ5sUwTXwZtBjqHcekzNIukvj64PkyZ8ZuKMSlep+dzhiKey9m7gUuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709136663; c=relaxed/simple;
	bh=x4cppwy5kuHxn1Xdw/R0WLbMpw8zlt+UyW3XE5G3RSw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PeGYpb9bXkn9VdRpZbL4gxt65nXRH3hS7uIATzhvdhtOBTDlVpLsoEPhzUlpwI6YiYF6794gqOgBrmwi86vFwtOZ8vNEqHhIfB79Xid9R07nZuEnRoor1tAyZY8KOBRBashH/ZlJkLrLoxmQEN1t8mbqCQLavyBVfEOzjLzdpcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aR5LDzrK; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-5a0a19c9bb7so1914960eaf.3;
        Wed, 28 Feb 2024 08:11:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709136661; x=1709741461; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=UM7fB83xrY7g3CIrUJgpt+5lWVhOTXwWDbWvr1lXm3o=;
        b=aR5LDzrKBVpQoLw5bR2v3dc+uWVkN5IFLzc7kb/OWdpF9k67QbUSzCkjLX7gDlG11o
         gP6smNiQXiqCW3rvqs4aQoOjwF7pM4TuFbPbi/Tav6ML7ak9NY0bYOV218axG683V4vV
         VAag+pv81zLuB7O3YAfkK1eWgm2TYZ84omougYKbYOOt39QmM+SpG03B0ZSeiPyAhSV9
         zCYulM3PAnvcGLb7Ap/90w/OouC+Z8tVN2cN//3PXh6x2U2x0kKx+SeBXKu6CvUgRLtP
         4Why03SmMW6geYuZvb4ztjhT7Bht+rNUXcIkb5czeyeHJMihcOxRe5IEaacIThVxtgb1
         aX2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709136661; x=1709741461;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UM7fB83xrY7g3CIrUJgpt+5lWVhOTXwWDbWvr1lXm3o=;
        b=G+9kmGSHVdh+qj3gTGdsWeraTgFODlHWGqfLr8FQxs5sk3m7WqMXjXbko3h6XSgC1m
         9VqvV6CMFL8qAPEkBELJcjDCA+1G00V1umKJ3gN3u7DOkJB4c4OIknNzN9281M7LTHsr
         K6noDvlOKOI6IfqDzQZT88yDdhHTgDVYK47RTqrCkBdVXXNZLmwL3EzOLrg70fFPO5XV
         AcS/6v6bz03UO7/OrU4eB6IEabJo1j1LxxnHjxdEqnljbjrpJIQjlxMifjxoEDWt9+UB
         UWE17yM5ADcbhrVkaBoz4EZazc62JtancXwa/lwn4UE2MFBXCtOa7ZvNoAEejTUdT1xu
         6AAw==
X-Forwarded-Encrypted: i=1; AJvYcCW2lXB9q/oa/FB+pBjxjnyyU3hvxR4Ev8dPdx5x6FOpo95I2uNMqE/GHxpmGqZCeXLFqiZuoOTkkyK2F9aSaekmoVluKvA0m6/rEZuUkhVGihBcvZQ15rF5W32rKX3qXtJFeLuuOW/i/oE57tqWIX98ol0iUoYUVi1BODnobCwAYE7eyFb9NSmR7XFg+M7XsrBHr4hs1Qr4r4hBTKCH
X-Gm-Message-State: AOJu0YzcUMAUheJpb5q2PrywtTKcxaSE1VujbR5NqIJd31f0Gc1xxMqB
	efk1DXtH81WvN2HQDdkashMbFtfI9Maj67AL7xDRO12XK4eXC39z
X-Google-Smtp-Source: AGHT+IHVqmXgCjjpeT3Ayfgm29V7pLwkYccA07WjeKQIvCijKqteNCHyaFrBaReNdiJYMkPFdwfJlQ==
X-Received: by 2002:a05:6359:4c0f:b0:178:94bc:72ef with SMTP id kj15-20020a0563594c0f00b0017894bc72efmr17459234rwc.25.1709136660774;
        Wed, 28 Feb 2024 08:11:00 -0800 (PST)
Received: from localhost ([2601:344:8301:57f0:2256:57ae:919c:373f])
        by smtp.gmail.com with ESMTPSA id h8-20020a255f48000000b00dcda5ddeccasm1939107ybm.30.2024.02.28.08.10.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 08:11:00 -0800 (PST)
Date: Wed, 28 Feb 2024 08:10:59 -0800
From: Yury Norov <yury.norov@gmail.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Alexander Potapenko <glider@google.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Marcin Szycik <marcin.szycik@linux.intel.com>,
	Wojciech Drewek <wojciech.drewek@intel.com>,
	Andy Shevchenko <andy@kernel.org>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Jiri Pirko <jiri@resnulli.us>, Ido Schimmel <idosch@nvidia.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Simon Horman <horms@kernel.org>, linux-btrfs@vger.kernel.org,
	dm-devel@redhat.com, ntfs3@lists.linux.dev,
	linux-s390@vger.kernel.org,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	Netdev <netdev@vger.kernel.org>, linux-kernel@vger.kernel.org,
	Syed Nayyar Waris <syednwaris@gmail.com>,
	William Breathitt Gray <william.gray@linaro.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH net-next v5 01/21] lib/bitmap: add bitmap_{read,write}()
Message-ID: <Zd9bE0Z3djvj3+As@yury-ThinkPad>
References: <20240201122216.2634007-1-aleksander.lobakin@intel.com>
 <20240201122216.2634007-2-aleksander.lobakin@intel.com>
 <3f6df876-4b25-4dc8-bbac-ce678c428d86@app.fastmail.com>
 <CAG_fn=Wb81V+axD2eLLiE9SfdbJ8yncrkhuyw8b+6OBJJ_M9Sw@mail.gmail.com>
 <b4309c85-026c-4fc9-8c26-61689ac38fa1@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b4309c85-026c-4fc9-8c26-61689ac38fa1@app.fastmail.com>

On Thu, Feb 01, 2024 at 03:02:50PM +0100, Arnd Bergmann wrote:
> On Thu, Feb 1, 2024, at 14:45, Alexander Potapenko wrote:
> > On Thu, Feb 1, 2024 at 2:23 PM Arnd Bergmann <arnd@arndb.de> wrote:
> >> On Thu, Feb 1, 2024, at 13:21, Alexander Lobakin wrote:
> >>
> >> As far as I can tell, the header ends up being included
> >> indirectly almost everywhere, so just parsing these functions
> >> likey adds not just dependencies but also compile time.
> >>
> >
> > Removing particular functions from a header to reduce compilation time
> > does not really scale.
> > Do we know this case has a noticeable impact on the compilation time?
> > If yes, maybe we need to tackle this problem in a different way (e.g.
> > reduce the number of dependencies on it)?
> 
> Cleaning up the header dependencies is definitely possible in
> theory, and there are other places we could start this, but
> it's also a multi-year effort that several people have tried
> without much success.
> 
> All I'm asking here is to not make it worse by adding this
> one without need. If the function is not normally inlined
> anyway, there is no benefit to having it in the header.
> 
>       Arnd

Hi Arnd,

I think Alexander has shown that the functions are normally inlined.
If for some target that doesn't hold, we'd use __always_inline.

They are very lightweight by nature - one or at max two word fetches
followed by some shifting. We spent quite some cycles making sure
that the generated code looks efficient, at least not worse than the
existing bitmap_{get,set}_value8(), which is a special case of the
bitmap_{read,write}.

I agree that bitmap header is overwhelmed (like many other kernel
headers), and I'm working on unloading it.

I checked allyesconfig build time before and after this patch, and
I found no difference for me. So if you're concerned about compilation
time, this patch doesn't make things worse in this department.

With all that, Alexander, can you please double-check that the
functions get inlined, and if so:

Signed-off-by: Yury Norov <yury.norov@gmail.com>

