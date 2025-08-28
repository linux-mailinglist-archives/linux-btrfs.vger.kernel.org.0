Return-Path: <linux-btrfs+bounces-16503-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 710FFB3ACB0
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Aug 2025 23:22:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0AE1668838E
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Aug 2025 21:22:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFD1A2C0F60;
	Thu, 28 Aug 2025 21:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b="R2xnPuDW"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62DC12848BB
	for <linux-btrfs@vger.kernel.org>; Thu, 28 Aug 2025 21:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756416130; cv=none; b=pl0Xm4nZqNTlACtuLAkQj5wj3AXinVeIJozYh01Zvjd6zlYOxjyVqggK1XehDZAc6xQwsZP5yC3YOhIoI49jdU0m7qiRcFnCljRYNCh7zhwpMYkXuvjl9DMcbcGheUZd7FNjw4f6zmUosgRBSxXndtvvQi9hJD7Kn8iPidzUTuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756416130; c=relaxed/simple;
	bh=aJVTJp1Yl8+vhV4hPswj4DUIjr7rT/uJiOu13fSpVZo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VSt6sCT4Ab0F1DW2T7voLUw12d+Q+63Bb/shEL1wzOsn1ZqoXp0EtZpdNoalNGFE/oYN2WGaZt8d4vJr99ExlNlCw0SU7vBjjF1fwamsT30rOWYdZmmNaSlE1Nhwc2cF7gqhY5GIisZjBReB9h0uOlbPLx0p4G6Zps+bKH4FN2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=pass smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b=R2xnPuDW; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e970e624b7cso542664276.0
        for <linux-btrfs@vger.kernel.org>; Thu, 28 Aug 2025 14:22:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1756416127; x=1757020927; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=t3LkVCQ8kVOnnmDS8grT1/qlSRphyhJmLNB0qej4dbA=;
        b=R2xnPuDWF/75jFkeuckMdZk6lBdTcyoplNsE7ZX05OI7npgHio71mlIiN3ggzglFPc
         ftA4kHUXniRGnDg4TvSPwDTCnOrNVQQsbH4JsTeB06gSYkSQaBTLgQo6TX8nRWlFsh0q
         GjKaUA5lBMhN2reL5l1TGXJ8WDTdIUz+0ofIYtrQfByHwygXGidvbEjeQe0Xn+bODbTJ
         Cedj7Ky8LWwF9h3bB18TgeVDdoQecI3zxqE0AI/4vmZm/OcuemprOUAbADdg7EspEt6o
         3VhicqvvSg+4GuV8IoqhVYfPUwnnW64MIuPMCvfLFmCMIdNKIdsdycBWIEAw3opqSi1r
         PdpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756416127; x=1757020927;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t3LkVCQ8kVOnnmDS8grT1/qlSRphyhJmLNB0qej4dbA=;
        b=f/leukx3AQz0V8/11Exw5G4rIzbAn2WIJHgLyG2aKtJOYG6fJS9MJakepPQunUZpED
         pU9398aJ3yrJ8yi75fnmki8bonYEW2yTcu5u2kdBoZ2uBV1dVo8ywLQzOITLhcAn5P2j
         2IgXKU5Z44UHVBycLtgwgMqBaIn5sN0Qjqfrk+ftjis63a0TgmYzd+ZpbFiXaxjFsZk8
         IE8pU17FJWGyqyQGLClMyt58Icp2RCd94QNf+vXDRHl1nU65Uu4CHyVyVEQZIHfTo0Zq
         TWP5EjEIstp2oz2zwOfsQYNSMSCCYpQkPzE5jDj6CIP7HFGAp+VSIdL4wyU3LmPGjvRl
         4i5A==
X-Forwarded-Encrypted: i=1; AJvYcCXNtelWki2BIw6MbDFPDnOSDTGylUaDugpWvsakdcqTF9xBgw7l3kyOokhbwSf2FXrFdy+qdO6SN0eaFg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyAdeQ/dUzV3VVWZjXOFv9on5QJLB+tsO6w0YJZJK7U3n5bUB0W
	8KGqZWtZxqTh/ppuPJslPT7/FT2OXlL9sLqePtmlmN/+XWb4CYLz1GPtAqZePw0RWbo=
X-Gm-Gg: ASbGncsWczpC1EwQDZGy21srqlXnazQF9ku3EeWY/k3iu69gDInTsXn3ypwes28KMvD
	qUiK+NjhajqiPjDvoYijwL08qwbQbYtHf2BvAhgSAFhsA2PJQRjGsZd6QNt0QCDb7oycwGX1JmT
	wRlgOVxND/XxoyJtb8dUwpoFexaS3aIRDIxzrY14yEmYZ/O/pb00mAcDR1pnaXEQCUjtShBrcOe
	WR4mR/9jywKAHsGiYiQC9hNCwhfQ2D/AkEyjhYU1N2VR+uD3Nqb9RGHktjw+8OtJgXSJ+j//Q6S
	EaQBRyJwZzjP1xHs8G96uzFl08d9zMQG+L03URN3Ng/VwqiFvMnrlMl4JE+I32HCGjYn+hRWxhq
	HJ9CV17+AQwzp6S7335zJSNrXAwBmjfbJSZQVCGizMBJn9NTtdxIjrfQTo9Y=
X-Google-Smtp-Source: AGHT+IFOrMBYSYojc1UQ/EpVD1LfbmNEfeG8jgLFeXE187SLAD9S1Hu+9phZyJ9UxwGExOFza3VkQQ==
X-Received: by 2002:a05:690c:64c2:b0:71f:9a36:d332 with SMTP id 00721157ae682-72132cd7798mr125819147b3.27.1756416127280;
        Thu, 28 Aug 2025 14:22:07 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-721c630b9c5sm2339097b3.9.2025.08.28.14.22.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 14:22:06 -0700 (PDT)
Date: Thu, 28 Aug 2025 17:22:05 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
	kernel-team@fb.com, linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org, viro@zeniv.linux.org.uk,
	amir73il@gmail.com
Subject: Re: [PATCH v2 00/54] fs: rework inode reference counting
Message-ID: <20250828212205.GA2851550@perftesting>
References: <cover.1756222464.git.josef@toxicpanda.com>
 <20250828-hygiene-erfinden-81433fd05596@brauner>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250828-hygiene-erfinden-81433fd05596@brauner>

On Thu, Aug 28, 2025 at 02:51:23PM +0200, Christian Brauner wrote:
> On Tue, Aug 26, 2025 at 11:39:00AM -0400, Josef Bacik wrote:
> > v1: https://lore.kernel.org/linux-fsdevel/cover.1755806649.git.josef@toxicpanda.com/
> > 
> > v1->v2:
> 
> I've been through the series apart from the Documentation so far (I'll
> read that later to see how it matches my own understanding.). To me this
> all looks pretty great. The death of all these flags is amazing and if
> we can experiment with the icache removal next that would be very nice.
> 
> So I wait for some more comments and maybe a final resend but I'm quite
> happy. I'm sure I've missed subtleties but testing will hopefully also
> shake out a few additional bugs.

Perfect, I've been fixing things as I've gone along. I'm going to wait to see if
Dave has any other thoughts while I'm asleep, and then I'll resend tomorrow.
Thanks,

Josef

