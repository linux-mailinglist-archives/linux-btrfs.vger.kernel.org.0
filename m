Return-Path: <linux-btrfs+bounces-19863-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 90E5DCCD68F
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Dec 2025 20:36:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B9F5B3035D09
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Dec 2025 19:36:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46DE7339B51;
	Thu, 18 Dec 2025 19:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MR2wAHPE"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7CCE3128AD
	for <linux-btrfs@vger.kernel.org>; Thu, 18 Dec 2025 19:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766086572; cv=none; b=MJWuxrJNF5OUqZLC4p68tm+Y5bExld3yAo2SLTP9/fRw/Lko956xSChqzEZqgC5NfM+S/+/Pu5pHqc9cAIepUwCm3Qe/UPfPuTqjvB+pdCsEbV03gG57A4+QVSI7RMYG3xlx764j89vhI7dlFYYFLFtqcPmV9CFeCB0euX7v/2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766086572; c=relaxed/simple;
	bh=gtsgVIH7cjnvnUoQ9+ZBM3YPEjvKI+7T+Jy5w4IfORE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MJiIckLdaYRr/ZS4RpWGY726I8jHMh5JWGjgNcJVx/vt8tYK4z1h+9HoHII34oXF+0VpGvFoSI7IsPnvRI5JpmXQutFK3s+nkuC09ONmAWcQfAfovnLM0y5u4qiQoVVAi+7VyUPMMFemVw4ov9CRcn/YVjMDIUaTwrmTupBJoYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MR2wAHPE; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-47aa03d3326so6357475e9.3
        for <linux-btrfs@vger.kernel.org>; Thu, 18 Dec 2025 11:36:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1766086569; x=1766691369; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cxp4Ie+boIejqpFbsPiC20+/Xw7M9cKxZsjEWRRRwds=;
        b=MR2wAHPESpzG1WVzeKpUXuNnViiKpPJZeLXZp6/Ec23mJPUMkg3r6Ee12G9uu3LJaZ
         mKlV+Spy1pY/j7KSIgydvkBbSx3UtVWFq1A2DzzUu/NBVkr7zpV1/cpbBlv2rs4SunGv
         sSWaLwgI+oWTH8g3V9yV+Y6uD+NHaFLTyEPhKj1A1uKqKjC2YDWnvom/q9IF8DwkPGpO
         2GHDQQXd4yuTJSqHAKTVvw2HkatYtbdk8kyeGyj4k23tmRRJgprljSGehXm+4QI8uNz1
         Ex+QI6IiS4HtALGV6cIjcVmds6ENOkQBaaapHYdNvJ9S395L02KV28KUBTRO3xRVDTlF
         M8Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766086569; x=1766691369;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cxp4Ie+boIejqpFbsPiC20+/Xw7M9cKxZsjEWRRRwds=;
        b=S4R1i9E0vc7hOAr3AmMPhY4GPQVa5GXjK5EDJ62Oh60+DPA7O9dtu/3m07T1GSlwiJ
         8gi2sYWqioV6BYMR9z+24HsYbDQJvBpIeRvoJnS10EGsif/VaswpfysJxzpC1IVXJOQx
         aOdTdzxGasn3zxx0jp7+pMGJd9rAKNO6eGYuDp7xPkxsRRvB/OhOjzq1QQVT5IAuSbel
         zRcwXTlZGEPB3eaFFc4yfoi+j2Y8HoWY2nrsqs+lCml3+QvT3R5H1vFp85nhKUcp0DdO
         NnCnJ/75VBIRzM21UI3Paz8Vyyyg0sc44tc6IsMSSD4DEJRlY7XWAy27P3O2PLZwtwEe
         6EYg==
X-Forwarded-Encrypted: i=1; AJvYcCUkWl4hpGaoknRPSWCB+yrCNgPS9mV2dfHy+qzd6oLL3oV8t1b8WIv1cwRU6+4P3Da3eqEiz9/POC+0HQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YybMnlW5Z6n+eaGo499Dn4cn5FEBORAS2JgwHvK4K7dNv9ZngTF
	PC0/A+VMsJsxWCfA/PZRk6oZfPaFBoZTV024yu+gfWt8142/aycaXyiLbVYfaIR8SCo=
X-Gm-Gg: AY/fxX4jFN6HFbZwrjso7+aN1wIiryPxf2re1kX320vVmHyWbNbq/xO5L+lk2+ewUay
	jTDwB11nqoKPewhVeTzkINlYr8gxX1sJvsaGaUr5Bl3utIV2DKdEtKB0s6Jp+hf/cV4tIrjn6XR
	4y0shWDolAyaxMrYxQfhwLNHk5ypWh8EdQO9h/t3NeLsTwj/BnQDmOZTi74H7jk4i0roN8JbDib
	wJjTD0w/UdqcOv0y3bdIJeMD0rYBVHjTTJvc0zM7MkgWPSzBEoO+yq0CIfJ3VCBv70AawcBA3j2
	jOFIPHa/A3X+xJjOOETEF1prXXdwIIhbro3obIVQgsNZlFTb2Nbwf9yZOMft4kf1NqZNfw9fXgi
	5g8HXZ/9Ijl5yi3Ys4FTQsa0gTqpQ/NXRKc0w4kYhowtOIRJZZnsOvMoKvdDUXmbTNEANU2jl+V
	eG8awqC0QhwNc/iK8HF21qd77IrKQ=
X-Google-Smtp-Source: AGHT+IEWnJ+smox+Awq4YY2u+tYf4kZjFoSNBjl69Zus1TVDvNF1T4vaSgqJeTV4pQlOkjzV9gYE1A==
X-Received: by 2002:a05:600c:818f:b0:477:7b16:5f77 with SMTP id 5b1f17b1804b1-47d19538725mr2627515e9.3.1766086568848;
        Thu, 18 Dec 2025 11:36:08 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4324eaa64cesm552594f8f.35.2025.12.18.11.36.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Dec 2025 11:36:08 -0800 (PST)
Date: Thu, 18 Dec 2025 22:36:04 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Vincent Mailhol <mailhol@kernel.org>
Cc: Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-kbuild@vger.kernel.org, linux-sparse@vger.kernel.org,
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
	dri-devel@lists.freedesktop.org, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 1/2] kbuild: remove gcc's -Wtype-limits
Message-ID: <aURXpAwm-ITVlHMl@stanley.mountain>
References: <20251218-remove_wtype-limits-v1-0-735417536787@kernel.org>
 <20251218-remove_wtype-limits-v1-1-735417536787@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251218-remove_wtype-limits-v1-1-735417536787@kernel.org>

On Thu, Dec 18, 2025 at 07:50:01PM +0100, Vincent Mailhol wrote:
> W=2 builds are heavily polluted by the -Wtype-limits warning.
> 
> Here are some W=12 statistics on Linux v6.19-rc1 for an x86_64
> defconfig (with just CONFIG_WERROR set to "n") using gcc 14.3.1:
> 
> 	 Warning name			count	percent
> 	-------------------------------------------------
> 	 -Wlogical-op			    2	  0.00 %
> 	 -Wmaybe-uninitialized		  138	  0.20 %
> 	 -Wunused-macros		  869	  1.24 %
> 	 -Wmissing-field-initializers	 1418	  2.02 %
> 	 -Wshadow			 2234	  3.19 %
> 	 -Wtype-limits			65378	 93.35 %
> 	-------------------------------------------------
> 	 Total				70039	100.00 %
> 
> As we can see, -Wtype-limits represents the vast majority of all
> warnings. The reason behind this is that these warnings appear in
> some common header files, meaning that some unique warnings are
> repeated tens of thousands of times (once per header inclusion).
> 
> Add to this the fact that each warning is coupled with a dozen lines
> detailing some macro expansion. The end result is that the W=2 output
> is just too bloated and painful to use.
> 
> Three years ago, I proposed in [1] modifying one such header to
> silence that noise. Because the code was not faulty, Linus rejected
> the idea and instead suggested simply removing that warning.
> 
> At that time, I could not bring myself to send such a patch because,
> despite its problems, -Wtype-limits would still catch the below bug:
> 
> 	unsigned int ret;
> 
> 	ret = check();
> 	if (ret < 0)
> 		error();
> 
> Meanwhile, based on another suggestion from Linus, I added a new check
> to sparse [2] that would catch the above bug without the useless spam.
> 
> With this, remove gcc's -Wtype-limits. People who still want to catch
> incorrect comparisons between unsigned integers and zero can now use
> sparse instead.
> 
> On a side note, clang also has a -Wtype-limits warning but:
> 
>   * it is not enabled in the kernel at the moment because, contrary to
>     gcc, clang did not include it under -Wextra.
> 
>   * it does not warn if the code results from a macro expansion. So,
>     if activated, it would not cause as much spam as gcc does.
> 
>   * -Wtype-limits is split into four sub-warnings [3] meaning that if
>     it were to be activated, we could select which one to keep.
> 

Sounds good.  I like your Sparse check.

Maybe we should enable the Sparse checking as well because it sounds
like they are doing a lot of things right.  I think Smatch catches the
same bugs that Clang would but it would be good to have multiple
implementations.  The -Wtautological-unsigned-enum-zero-compare trips
people up because they aren't necessarily expecting enums to be
unsigned.

regards,
dan carpenter



