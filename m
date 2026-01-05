Return-Path: <linux-btrfs+bounces-20096-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 78503CF23A2
	for <lists+linux-btrfs@lfdr.de>; Mon, 05 Jan 2026 08:31:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 87C9D305A2F5
	for <lists+linux-btrfs@lfdr.de>; Mon,  5 Jan 2026 07:26:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E215E2DA762;
	Mon,  5 Jan 2026 07:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="e5wBrHfr"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D5BD2737F8
	for <linux-btrfs@vger.kernel.org>; Mon,  5 Jan 2026 07:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767597978; cv=none; b=BZpJfVJ+5DWoLkNYITgRson5rWCFjAeleLT7GZYG/dkuYpuQhK8nkCIemuKip8w0Mw/fij0NGXs6OBVrpnJmKHkUXZ3/Uj8a1ERrBvRNLkJ+9YBdV8Ht/so7jBFYZbfXpmbc9CqdNSkuWHbM8QDVHyNWxC81EfIRCF6l7RmccIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767597978; c=relaxed/simple;
	bh=J+0zgzblPWcILdaJe+sS8PZ3YqSBzV7Z4n11YbyV75A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f1665CRAtZcksTo2g9CfdsSVuI0fAPwnd+73VRmOCoARbdUuW/O9n9/60bctnCQZ9PXS788n5kBcIJQ0wTNq4HqSHZpffUUT7GVEjv4QVQl+ZBRjR3Xn3hPXeoeIP6v200oFpbV2nohYBPegebtyp1mCiTdoK0GbuAfEX7ntuzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=e5wBrHfr; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-47796a837c7so88311195e9.0
        for <linux-btrfs@vger.kernel.org>; Sun, 04 Jan 2026 23:26:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1767597971; x=1768202771; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tqXPGRlmqIR2c73hehXqAT4WnRWsCFlwnXSzbZ1gZgI=;
        b=e5wBrHfr2i2YxmjC/xSZl8aZSdU/c0xU0A0qfCMbcYd6VYpTU+XKBer8Ge7syUWmu/
         KyD6yBdkixqrcBJPL+OMgoZfI2M3afqS+wO8+88CAbNgPgR1iLJsVjvSGVdQQmIQ5ESx
         0ElZAULoxYK7l2f+9R9btlhNco1OYiU0JmT33Hc0QNQIC1KTOxe8FHD4MXi1MLXWTgFP
         98Zzs77itmNp3mMSfKDl7UfEkX0nljzsflDfQ/cCojXoA4hvX9safE2PuEsku50tGmXe
         GaIaJ2HPYfi1wYIDpU2eNdTLx6g+gZNK1bGT4YR7siJL6ElJ873WKWdBI2neDTYYXHfz
         LH0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767597971; x=1768202771;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tqXPGRlmqIR2c73hehXqAT4WnRWsCFlwnXSzbZ1gZgI=;
        b=S7/f/6QYrqdQS1yz2eZ4W90i3RWyjhq+NSGxjobsc2wP8orQg/tSZrFOZLzDVTMul/
         J7bZtC7nDiNij8Wjfl5tpbTX9bP+6U/ibmdBBTS8KZo493GL7UJBq9bMVn0srdJwjxwD
         MNpMD7ioaV2vtbmdkdX/vWqq++rOPX2gZNk9I7czr+xqHIpUXng8t/uVTgyltYehlcT+
         jbkxxSP6nADsUFT0GPYF64v2xK/1hamO3E567usZ3nwmhRgYPJF4vxmxn9V8ppgR7QEl
         H+e1NlzpvxqO/cyd6wNxbfcsF+VpDh0LmwJ8TnKsFdJHD8qoElfNAd3YAAgj6d/9hDNq
         zGyg==
X-Forwarded-Encrypted: i=1; AJvYcCV7PIbvqtfwv25RDadZPxJpaWvUydun4li3RySk1S+bP6H5TCcNHawJKO8y/qDeZkLQJAQLXUrafVPsUQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxT0/oS2CSS8YuVS3v2aSRBkJEnBhFMpPNcjW9mgIxagTBUKdFl
	Q+LBMdrpverHGt68ejdk0fjF5RgZaIo4bbyhocalptfBwEqxRtmgdjAdEmP0Wr6fQKw=
X-Gm-Gg: AY/fxX7C8P7lgNBJ1t90viw/fPjC2bNdrjuYwF/sfQqQPU4H6JjMqVubkzkqy66za2S
	+p1uk7PkNyDqLnwU4lrphdP5sbN1yI9XkFKs9mEpnXKPXO9y81/a2duMJ8pz4y6/9QaeFPdcghc
	qgq/Yjo2zieB4fq0ZHm41qRBIGtju6ID1et1hNlQgL4rxD2TqcMG+mB9HRr6cjFh7u2DGCBfYal
	eF/U/OIBATBM94PX2tBHouyJulzKdIdNZuWjiwplTX/oeY4ACj2wdPLPY6FU2ehoVp6eJNVC5tD
	gQSh68R6L0jywzuSsp3bNBC1gkaadTq15FxIrRqCWZWHwzQUV3y8SSclaOtU+k3m0nRgWrkWNXx
	q09+3sT7Aj37+LDsNJmHUUzx+QYo1afzqCA2pkktuB0w3ucn++K3qq10PHIug4JRrbq5ZDIIzdm
	OZRVQGpQ+HwXc/GiR+
X-Google-Smtp-Source: AGHT+IFrdZFxzxTrmRZMpsP27Ztfl7Uoc6pbDtE/T7BSP5JYGzpyq/KpLAX/yGG7sIYcOpNE6ZVEuA==
X-Received: by 2002:a05:600c:1d1d:b0:477:8ba7:fe0a with SMTP id 5b1f17b1804b1-47d1957da90mr604728865e9.24.1767597970515;
        Sun, 04 Jan 2026 23:26:10 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d6d45bb57sm148423745e9.14.2026.01.04.23.26.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Jan 2026 23:26:09 -0800 (PST)
Date: Mon, 5 Jan 2026 10:26:06 +0300
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
Message-ID: <aVtnjgJOjMp9cMDn@stanley.mountain>
References: <20251220-remove_wtype-limits-v3-3-24b170af700e@kernel.org>
 <acdd84b2-e893-419c-8a46-da55d695dda2@kernel.org>
 <20260101-futuristic-petrel-of-ecstasy-23db5f@lindesnes>
 <CANiq72=jRT+6+2PBgshsK-TpxPiRK70H-+3D6sYaN-fdfC83qw@mail.gmail.com>
 <b549e430-5623-4c60-acb1-4b5e095ae870@kernel.org>
 <b6b35138-2c37-4b82-894e-59e897ec7d58@kernel.org>
 <903ba91b-f052-4b1c-827d-6292965026c5@moroto.mountain>
 <c84557e6-aa92-42e9-8768-e246676ec1e9@kernel.org>
 <aVlKTculhgJzuZJy@stanley.mountain>
 <e66bd09b-9879-4562-a71e-a1e1a964f3f2@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e66bd09b-9879-4562-a71e-a1e1a964f3f2@kernel.org>

On Sat, Jan 03, 2026 at 08:40:17PM +0100, Vincent Mailhol wrote:
> On 03/01/2026 at 17:56, Dan Carpenter wrote:
> > On Sat, Jan 03, 2026 at 12:10:45PM +0100, Vincent Mailhol wrote:
> >> On 03/01/2026 at 11:02, Dan Carpenter wrote:
> >>> Thanks Randy, for sending this to me.  I'm on the sparse list, but
> >>> I've been on vacation and haven't caught up with my email. 
> >>
> >> Welcome back, hope you enjoyed your holidays!
> >>
> >>> I can easily silence this in Smatch.
> >>
> >> Thanks. I ran this locally, I can confirm that this silences the
> >> warning. So:
> >>
> >> Tested-by: Vincent Mailhol <mailhol@kernel.org>
> >>
> >>> diff --git a/check_unsigned_lt_zero.c b/check_unsigned_lt_zero.c
> >>> index bfeb3261f91d..ac3e650704ce 100644
> >>> --- a/check_unsigned_lt_zero.c
> >>> +++ b/check_unsigned_lt_zero.c
> >>> @@ -105,7 +105,8 @@ static bool is_allowed_zero(struct expression *expr)
> >>>  	    strcmp(macro, "STRTO_H") == 0 ||
> >>>  	    strcmp(macro, "SUB_EXTEND_USTAT") == 0 ||
> >>>  	    strcmp(macro, "TEST_CASTABLE_TO_TYPE_VAR") == 0 ||
> >>> -	    strcmp(macro, "TEST_ONE_SHIFT") == 0)
> >>> +	    strcmp(macro, "TEST_ONE_SHIFT") == 0 ||
> >>> +	    strcmp(macro, "check_shl_overflow") == 0)
> >>
> >> But, for the long term, wouldn't it better to just ignore all the code
> >> coming from macro extensions instead of maintaining this allow-list?
> >>
> > 
> > Of course, that idea occured to me, but so far the allow list is not
> > very burdensome to maintain.
> 
> Indeed, but my concern was more on how people would treat such smatch
> warnings coming from the kernel test robot. It is very uncommon to have
> an allow-list hard coded into the static analyzer. Actually, this is the
> first time I see this. My fear here is that people will just uglify the
> code rather than sending a patch to extend the allow list in smatch.
> 

People need to learn to ignore false positives.  The zero day bot sends
a one time email and if you just delete it, then it's gone forever.
Forget about it.

It's really limitting to try be totally static checker clean.  Things
like passing a zero to ERR_PTR() for example.  It's a perfectly valid way
to return NULL and the fs/ subsystem uses this a lot.  But 80% when you
see it in new code, then it's a bug where they returned the wrong
variable or something.  It's a high quality warning.  The solution is to
look at it one time, when the code is fresh and then never look at it
again.

In this case when I disable the unsigned < 0 checking for macros then it
means that if someone does if (WARN_ON(u32_var < 0)) { it's silenced.  I
don't want that.

I could create a much better way to silence false positives like this
if I passed an expression pointer to the sm_warning()...  It's a bit of
a re-work.

regards,
dan carpenter












It's really limitting
if we can only check 

> > I maybe should disable it for all macros unless the --spammy option is used...
> 
> IMHO, that would be an even better approach. That said, I am happy
> enough with your previous patch which resolves my issue and which is way
> better than updating the is_non_negative() and is_negative() comments as
> I did in my patch!
> 
> 
> Yours sincerely,
> Vincent Mailhol

