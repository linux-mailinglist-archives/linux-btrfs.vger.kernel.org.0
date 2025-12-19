Return-Path: <linux-btrfs+bounces-19886-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BBA65CCEAD7
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Dec 2025 07:56:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D2935302D923
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Dec 2025 06:56:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 050732D73B1;
	Fri, 19 Dec 2025 06:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dd3nINGP"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DAD3192590
	for <linux-btrfs@vger.kernel.org>; Fri, 19 Dec 2025 06:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766127372; cv=none; b=TmW67bHhsYWprUzcBKiJbpkEc83qb77tLUrqRleU/My5lJ3uCg09rTvXdwQbcjhpMNaxReO5LvWvEluy+HLHe13yq3DS9A0GvGru3gWukqZ3hPBLh9peGUdh9zG1LBl13HNfwKoW+RKiJjtZR9Qjr1DJ+AzMIIOHUuPPqoRL/xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766127372; c=relaxed/simple;
	bh=rK2YSV2LQI36XGOcBtrahoUPHaJW1KtgnbjA4zRpGec=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nmGo5+tjzzTtvNc+qHHQUg+GnxQQecx599fb2QPFGtLrVFi918BAWxJOVPCDwe02sqNDbYVMiXmSfLNJLYaSNRfXpkHpjcHu4Um7tMEFXwcduDVkAW1HzmGiS/Il0unImR8wdrEx/OTGO0OTIgkQJABv5qj4vtm20yPMhRHyy2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dd3nINGP; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4775895d69cso5558875e9.0
        for <linux-btrfs@vger.kernel.org>; Thu, 18 Dec 2025 22:56:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1766127369; x=1766732169; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1uvUrNBTPpChg3H7Mj1KDqnB8rAwuiPMf9e+Kj7W0oA=;
        b=dd3nINGPUFNwXHcCDxx7rXO/W4jLghXh6FqJGrTPs8FGVTXifVcsxy10LP11xzrncf
         5HT3ZWVSnvprhUj032EvaMSJ4eKnETDsTBY/FEmmyhnN8x/oem7lzj5uyLh3L9gS03M9
         l2mfV74L7w30Xa9zPhrd8+/Pq7ckIaGxMBsiNrxBzTFDX8f9QEiCKMlWUR4fn9BG21/7
         HCcBmuWpfW3DRuy41r3Q7dxawH8nzPS38ecpScHQpYNImmB1mmwp8JvMCNVWYyQ3z8fH
         C20hiJxRpJhafDMwjCGyi+ro8U6IZJYVS5ZAHNvVa+cJhvbmmSE1kYhTsyCtUqScF+F3
         Hhrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766127369; x=1766732169;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1uvUrNBTPpChg3H7Mj1KDqnB8rAwuiPMf9e+Kj7W0oA=;
        b=MxqGIqfRv7gckqwucYfZyQibyWiuVjXQeB1owM6j4Wck8UexDgzMikHzMzezTLEMX/
         asIMGzPINE7nAt+Ig2ry3coYjQeLsllVWjU86p3xk9jmqFxvk2c8I4dMvWN3dUTI3QLI
         7hyIiH5tXEh9AdPin6WQqpC5p+vV9rvPqP25lPtyQ6qC0TRf6eJkgjKEgcsf1U8HfR7j
         dcJNjAUSUCJ0k9KOatQ0/8KUX15B31GvmQYvhzbnRHdsXOjQ0NFiRy7BB+EfVH25Da/7
         FLa0wy2RM9pJaotCgB0DtDBHg6nWRLVxHr0lJDScWkumQnLSmRW/TTQeG8f2ETP/Gkyh
         3L7A==
X-Forwarded-Encrypted: i=1; AJvYcCUFf2mHMdYEtxDpUTk6V56NzJne+cQFZnKcynOH7mP/bmrV9ATNLP1ijtvxgBe6vJIJ9+8ou01a23K0eg==@vger.kernel.org
X-Gm-Message-State: AOJu0YysDAmWvn3KErRAfozty7CuDCMb80G9rNcevgfZs1cUi4uMmDxI
	FKWkXYB1K3ddn3taYFNmvj1+jiqnRcVOG/lHRSsHcfHQiMd0UvHjvhLMatSJXMCBTzc=
X-Gm-Gg: AY/fxX5TuGcY0gQC1EArjMfC1iWpT+igDs0v80Iuv4jv09vlh0IlrvAWqG0BBNyC7yP
	nTwMepxvO7Fk2gfcjRO1Z97NfVC2Ej8nCSXdTBpkcOD1V1dassS2laQA49BBYbYdTFEMOGFwIS+
	RDG3CgEBTIo2gzZZwIq5JCVv56BGrja0bVko8+kuu4obaj5IPELv0U9lkJiwXN4crUeDtgBRl9B
	fBhsBmcB1hXuDnqOWH1SDXkrX/ahHh8FRc+fr49dmjqn8KLvqwUiDZeSguukw9jOA287NNJ9zkF
	rn69M5ozodg3+ltjsmkgfaUwPqzrnJ9iYRin6dX9m6wn5QejsICygIvXQ+F2rXJ78PUl1kBJpq4
	ME6wqYUfD1l2zIUmR4r9cRDC0vKeWZDnevS2uFXiiV0i4m9qHn6QSTYKmv4H3/m4GK+SeHUMzUV
	lRLb3WVcXfd2heSYD4
X-Google-Smtp-Source: AGHT+IETUnYjoqlX0nTA5YutvCCmQpud7Xc95qZZjrAyjw0urEK/i2B0DG8TW5LtsWwvJaxJadbpvQ==
X-Received: by 2002:a05:600c:45cf:b0:47a:7fdd:2906 with SMTP id 5b1f17b1804b1-47d1954a550mr12510385e9.12.1766127368714;
        Thu, 18 Dec 2025 22:56:08 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47be3a0fb5bsm30212905e9.1.2025.12.18.22.56.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Dec 2025 22:56:08 -0800 (PST)
Date: Fri, 19 Dec 2025 09:56:05 +0300
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
Message-ID: <aUT3BYAT1bLCk1w9@stanley.mountain>
References: <20251218-remove_wtype-limits-v1-0-735417536787@kernel.org>
 <20251218-remove_wtype-limits-v1-1-735417536787@kernel.org>
 <aURXpAwm-ITVlHMl@stanley.mountain>
 <480c3c06-7b3c-4150-b347-21057678f619@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <480c3c06-7b3c-4150-b347-21057678f619@kernel.org>

On Thu, Dec 18, 2025 at 11:31:40PM +0100, Vincent Mailhol wrote:
> Hi Dan,
> 
> On 18/12/2025 at 20:36, Dan Carpenter wrote:
> > On Thu, Dec 18, 2025 at 07:50:01PM +0100, Vincent Mailhol wrote:
> 
> (...)
> 
> >> With this, remove gcc's -Wtype-limits. People who still want to catch
> >> incorrect comparisons between unsigned integers and zero can now use
> >> sparse instead.
> >>
> >> On a side note, clang also has a -Wtype-limits warning but:
> >>
> >>   * it is not enabled in the kernel at the moment because, contrary to
> >>     gcc, clang did not include it under -Wextra.
> >>
> >>   * it does not warn if the code results from a macro expansion. So,
> >>     if activated, it would not cause as much spam as gcc does.
> >>
> >>   * -Wtype-limits is split into four sub-warnings [3] meaning that if
> >>     it were to be activated, we could select which one to keep.
> >>
> > 
> > Sounds good.  I like your Sparse check.
> 
> Does it mean I have your Reviewed-by?
> 
> > Maybe we should enable the Sparse checking as well because it sounds
> > like they are doing a lot of things right.
> 
> I am not sure to understand what do you mean by "enable the Sparse checking"?

I meant Clang...  Sorry.  Doh.

regards,
dan carpenter



