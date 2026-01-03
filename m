Return-Path: <linux-btrfs+bounces-20093-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F401CF030E
	for <lists+linux-btrfs@lfdr.de>; Sat, 03 Jan 2026 18:02:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D0AE530222FC
	for <lists+linux-btrfs@lfdr.de>; Sat,  3 Jan 2026 17:01:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FAE430C60A;
	Sat,  3 Jan 2026 17:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="O9Cget1S"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B14508C1F
	for <linux-btrfs@vger.kernel.org>; Sat,  3 Jan 2026 17:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767459712; cv=none; b=Vd4pYsysiHfkB8W8fSr//kWXtaUMIPDaWviK6SyQjXGlgR6eXSyi2ZjK2+bC5umzibdOxwUri+KMiLqMQQRPhVIByav8uxQKUfoni49w9gApBs6Oy2Ko63wpXSBHsMrp7dCCQORuDURhJ1FA9OfUAxuFLUgPTsrv7EWa2dyJDms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767459712; c=relaxed/simple;
	bh=KQXl8jGs3GODk15tB6KTtrgOeAb6Hys26tY1ny9AYdM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o6lnvnSv747GInzqMrtaJoXXArbGRDZXIHnxpGqZy1vywvQrc65mxsbUX57xXzyYy1qy0G1IW0BlWMuAUM8raGE4EMRtR+zLJnL9m1tiGlyTr1mvcGBYI9tIbGweRO4EAPPT8Ob70NchOxSsPrzPoVLZD66ZFp6v4oQJTZLfKdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=O9Cget1S; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-477770019e4so108256875e9.3
        for <linux-btrfs@vger.kernel.org>; Sat, 03 Jan 2026 09:01:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1767459709; x=1768064509; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yHSQMnJBQHG3fEabcx1jHr7yPb3RERixhfZ5sKkWzqY=;
        b=O9Cget1SxzflOyoG1iBj4tgeldJE8YEv+KCX/Po0HJ5CjxayvO5ZpmNW3teQ0qYoGp
         Mhgzx7wb53SdYQTHxLiyCXeRNd9TCYn/BtVvHVIQx9kaCd49JhuG0ztiudTYv7QjEGN1
         CgpT1i8bIeNPIoj9zDuMftOMgJ5UFx1oiZWH1c9LC2kqI1kQnURHDQPAPCBrwX5bTHkm
         vXEkYDhDCsCZ1ArZTs+a0y4gY2BYAMifW5QJUP9q3eoVRY6y3aDljX3v9JxK7S6LlLnS
         agYbSMbNTXAlpQnMn9yGLzIenQjT0k9MCqA8g5+hiOJLFtfHVa2hjin0LA9KmHsvp+ZX
         qqIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767459709; x=1768064509;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yHSQMnJBQHG3fEabcx1jHr7yPb3RERixhfZ5sKkWzqY=;
        b=Emlm4uOracSCGObHNfdvrlJm/R/Sg2BrwExwypNWRnnCclhqCpjHPChnnzZhDOtgkS
         eB0UkI/fZsycVb/haLy/5h9SW7nLFA4HQ/kJrorahkj8J5gXKqVlvzKQ/wb3AfJ/JyQd
         rxNoprBwZacYccYJQAitLI1Asbzz4viubGKKQmUyZFd2b/QsfvzRwfi0XYnXkviNusva
         NJKuuph/SX/zaSLGaXLmssR+flWS0xeb7CmRpRSV7if+mvovqx+NVTL/bNvU/OPEqF4V
         OTxPRS69xyHQADgx8bCE6t/5JfyuNLBCoy7JnJkrWsZDDoO62c35HkLnrsJywbGefChW
         jR7w==
X-Forwarded-Encrypted: i=1; AJvYcCU/lrKk6N1REmVums9XwH6Yh/wjhAUEF/Yb7YjBPBvXof9b6KcYX7nHCATExtgZyIk9BZuthAvwhylljA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwT3tDYg8dqKSzJgTe4IhBaq9Es5SkJyzo9h0XjkWU5aANX/VVI
	qArmHXEU52XyDLLCWNMnGMBIPDSIPJHpznsRptwfMNNjKx/gPBJQh6D9GCAqyR+9E5E=
X-Gm-Gg: AY/fxX66Bl1qFECdzv2z1mK8Xfy7M8Ogq8LmHbPLJdosI/giTOp7Ipgz8W0750WMo1G
	aDxRw4ffxTubzwpNgh9zi+V5XfQ0q9dFXs/xU1MUb4nrzERn8re1wRB7v/y/FHRw7Vnsf4Vlcj2
	QwEyTFdyG4SLBaxZIjypUDNdNc//r5VSF0rCP9wNbasHgPLBJZA0gEi2uRVk1qfJxVM/DUxTLCn
	UgJFdv+Ry8eL77REVzbCUKqKJbG5mjj343EYob/0XD1VA7W4soBpdkF2tvo4PC7iBSXT/lFIKBn
	qmsSeJCPFI1WFopo+qEECFR+yofr9e+D0U+YqM6ZjTiPSqlD/XrMzzr2laceAGYrDh/uNOjg6Fv
	nFcATRCce9rnmz6pTIqOfsln3Rtv3Gd2E15heNjvPO2utA1fLTdXuhIfZOZ9iOUTWuaCIqqpk0s
	smKObMLmcDB710qgCe
X-Google-Smtp-Source: AGHT+IH76r9upX5LgpHZ/fOST6gsEDX5p5oGk436/qE1kT4SAaRLVvV1SuOGoIs6C86iZ8FylfCo5w==
X-Received: by 2002:a05:6000:2c0f:b0:431:54c:6f0 with SMTP id ffacd0b85a97d-4324e4c739emr61327273f8f.4.1767459708384;
        Sat, 03 Jan 2026 09:01:48 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4325b6bfe88sm82459187f8f.19.2026.01.03.08.56.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Jan 2026 09:01:47 -0800 (PST)
Date: Sat, 3 Jan 2026 19:56:45 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Vincent Mailhol <mailhol@kernel.org>
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	Nicolas Schier <nicolas@fjasle.eu>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nsc@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-kbuild@vger.kernel.org, linux-sparse@vger.kernel.org,
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
	dri-devel@lists.freedesktop.org, linux-btrfs@vger.kernel.org,
	linux-hardening@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] overflow: Update is_non_negative() and is_negative()
 comment
Message-ID: <aVlKTculhgJzuZJy@stanley.mountain>
References: <20251220-remove_wtype-limits-v3-0-24b170af700e@kernel.org>
 <20251220-remove_wtype-limits-v3-3-24b170af700e@kernel.org>
 <acdd84b2-e893-419c-8a46-da55d695dda2@kernel.org>
 <20260101-futuristic-petrel-of-ecstasy-23db5f@lindesnes>
 <CANiq72=jRT+6+2PBgshsK-TpxPiRK70H-+3D6sYaN-fdfC83qw@mail.gmail.com>
 <b549e430-5623-4c60-acb1-4b5e095ae870@kernel.org>
 <b6b35138-2c37-4b82-894e-59e897ec7d58@kernel.org>
 <903ba91b-f052-4b1c-827d-6292965026c5@moroto.mountain>
 <c84557e6-aa92-42e9-8768-e246676ec1e9@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c84557e6-aa92-42e9-8768-e246676ec1e9@kernel.org>

On Sat, Jan 03, 2026 at 12:10:45PM +0100, Vincent Mailhol wrote:
> On 03/01/2026 at 11:02, Dan Carpenter wrote:
> > Thanks Randy, for sending this to me.  I'm on the sparse list, but
> > I've been on vacation and haven't caught up with my email. 
> 
> Welcome back, hope you enjoyed your holidays!
> 
> >I can easily silence this in Smatch.
> 
> Thanks. I ran this locally, I can confirm that this silences the
> warning. So:
> 
> Tested-by: Vincent Mailhol <mailhol@kernel.org>
> 
> > diff --git a/check_unsigned_lt_zero.c b/check_unsigned_lt_zero.c
> > index bfeb3261f91d..ac3e650704ce 100644
> > --- a/check_unsigned_lt_zero.c
> > +++ b/check_unsigned_lt_zero.c
> > @@ -105,7 +105,8 @@ static bool is_allowed_zero(struct expression *expr)
> >  	    strcmp(macro, "STRTO_H") == 0 ||
> >  	    strcmp(macro, "SUB_EXTEND_USTAT") == 0 ||
> >  	    strcmp(macro, "TEST_CASTABLE_TO_TYPE_VAR") == 0 ||
> > -	    strcmp(macro, "TEST_ONE_SHIFT") == 0)
> > +	    strcmp(macro, "TEST_ONE_SHIFT") == 0 ||
> > +	    strcmp(macro, "check_shl_overflow") == 0)
> 
> But, for the long term, wouldn't it better to just ignore all the code
> coming from macro extensions instead of maintaining this allow-list?
> 

Of course, that idea occured to me, but so far the allow list is not
very burdensome to maintain.  I maybe should disable it for all
macros unless the --spammy option is used...

regards,
dan carpenter


