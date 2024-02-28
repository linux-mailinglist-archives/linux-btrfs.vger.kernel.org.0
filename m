Return-Path: <linux-btrfs+bounces-2872-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C66CA86B506
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Feb 2024 17:32:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 69ECFB23B90
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Feb 2024 16:31:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96E6A3BBC5;
	Wed, 28 Feb 2024 16:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iSqyQXVJ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B5B8208A8;
	Wed, 28 Feb 2024 16:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709137886; cv=none; b=XGJhEPbH7u0bgWQkiIVk40kCuTtUD995n+4rjdf9RmEPjvICG+n54WFvyuMrSHjKyaUPuKSiFw2cq0Pdm4UnBDXAFVp1ks7O9hP1DBxsACGgmHzJrDBHw8aZn+IMr5VH5RV86yN4JealPXGYdW8udgK6cTSqfNxGfZKUHLB7Rc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709137886; c=relaxed/simple;
	bh=q0uUPGn9pVGPThc41lrMHBtz9PnPfJz4KxXuUrJDVag=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ja+1oxJjVKkizNo8upLPmpzRj6WK6tDNw4DULiE+e/y6JNhjiLf4k6mfimTRPsOb6nsfm3LBPmNnMycWLiPk3vPKnZHrLKOUzd6osTmNFwnPKOZBXrJe6bvLp45lgJ04i3QwyHVKWaTQOQuqeKslUEBpChUY0tX8BdVOc4AlLSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iSqyQXVJ; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-608959cfcbfso61199327b3.3;
        Wed, 28 Feb 2024 08:31:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709137883; x=1709742683; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4Np5Q1IFAeL3gVqFgXL9N6s1o+4P8nHvPzIDBSXAmlk=;
        b=iSqyQXVJ4UWA9En6DDPjFsmyE8ww4xSa+S6EuttqYBXtAee3wTf57wxmB0DU72ADwW
         ZWpoZW4kd8YC3M4YR+I6cq9jycCPbUp02/WMNOKcumFxorg6EiwLbKXpAcG1L3bndPB7
         Su2AWgchf9G3P8IBzBO3CzHhJr0jrZF+Upd1mokoD1JULhZgZ88p1LeTFpqJ/0K0+bK3
         SH0Pn3YHiDccKm+UX8i0vmWGAhtp75c/r19rUqUtsh/eoqyfAP4LK9uNxLOGY8kQF+7j
         h8mgYNrFI428qwf/n5jF8uPWuZgJGKgeDK+wQSNfoSNj6qHJHL0G9kd/7v/FL6On9PPR
         andA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709137883; x=1709742683;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4Np5Q1IFAeL3gVqFgXL9N6s1o+4P8nHvPzIDBSXAmlk=;
        b=sY2ySkbgR2ppeJHpAsLhOtA3SDAWze+E75wfowly9DIVpjh8cj8dl16nIIBC5xEk1D
         fm7yx1vvGLx3b4jiYVlT/1mC08pV+aSaHZxsxZXPvT8qmgQKDb7YnOHBzBPH+NfOcy8I
         /rfta7VnMiPO0hcErFTneaT5fB6JHstvjv/+kPTkedKa+qnmk3updiKZkmRiFg/RsC0Q
         p/8YnDynOXLKhGqv0P8flR8TlhXIdV4wbmiUMAVhtFt1XsmUO2Jn38/oeISkzAB5gtEK
         4/LCibwu165h8VHAUcMS3M9APuweov4zIVODFTMTLPg6SAHssCoYNwL7XqdxH+/nTbkh
         gusQ==
X-Forwarded-Encrypted: i=1; AJvYcCW9CapEmgfhgmjYbhgsKr3JqIt4kgq23KlqE9D8CSY82lNe7P3z20oW+D5t9s719/YXBiy/opO/V8reub1WlN8LPZ/nUrUGK0aT+u0u9mIYzXzids7kM10rmiAV8cR6U2tlkEgYQ4jq1a2GX9ch5uFNpzazj0uorC55E7a9f0aeExmjHB6yCCwdnwifrcxc2yk5Aj8jTjHi8tR6Q9l7
X-Gm-Message-State: AOJu0YxFFT7bE8O/ZDeSR4toXYB65GZMm7HHB7s4ZmsavhXrTgl28WIZ
	xzH421oftTw4vg7OfTNdJF1nPDPSgTSXpxz69J8cbOqQHTgnvcv+
X-Google-Smtp-Source: AGHT+IFpCUevzcdQnQRe5EFnA5eHKX981GcyRjFfNB3wwk2XmTFNTIpuoyEb4u6yxTYV7RM/GNdFHw==
X-Received: by 2002:a05:690c:fc5:b0:607:bfa6:7434 with SMTP id dg5-20020a05690c0fc500b00607bfa67434mr6942257ywb.20.1709137881926;
        Wed, 28 Feb 2024 08:31:21 -0800 (PST)
Received: from localhost ([2601:344:8301:57f0:2256:57ae:919c:373f])
        by smtp.gmail.com with ESMTPSA id i184-20020a0dc6c1000000b00607e72b478csm2477866ywd.133.2024.02.28.08.31.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 08:31:21 -0800 (PST)
Date: Wed, 28 Feb 2024 08:31:20 -0800
From: Yury Norov <yury.norov@gmail.com>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Marcin Szycik <marcin.szycik@linux.intel.com>,
	Wojciech Drewek <wojciech.drewek@intel.com>,
	Andy Shevchenko <andy@kernel.org>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Alexander Potapenko <glider@google.com>,
	Jiri Pirko <jiri@resnulli.us>, Ido Schimmel <idosch@nvidia.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Simon Horman <horms@kernel.org>, linux-btrfs@vger.kernel.org,
	dm-devel@redhat.com, ntfs3@lists.linux.dev,
	linux-s390@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v5 12/21] bitmap: introduce generic optimized
 bitmap_size()
Message-ID: <Zd9f2D6uhr3HgKt4@yury-ThinkPad>
References: <20240201122216.2634007-1-aleksander.lobakin@intel.com>
 <20240201122216.2634007-13-aleksander.lobakin@intel.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240201122216.2634007-13-aleksander.lobakin@intel.com>

On Thu, Feb 01, 2024 at 01:22:07PM +0100, Alexander Lobakin wrote:
> The number of times yet another open coded
> `BITS_TO_LONGS(nbits) * sizeof(long)` can be spotted is huge.
> Some generic helper is long overdue.
> 
> Add one, bitmap_size(), but with one detail.
> BITS_TO_LONGS() uses DIV_ROUND_UP(). The latter works well when both
> divident and divisor are compile-time constants or when the divisor
> is not a pow-of-2. When it is however, the compilers sometimes tend
> to generate suboptimal code (GCC 13):
> 
> 48 83 c0 3f          	add    $0x3f,%rax
> 48 c1 e8 06          	shr    $0x6,%rax
> 48 8d 14 c5 00 00 00 00	lea    0x0(,%rax,8),%rdx
> 
> %BITS_PER_LONG is always a pow-2 (either 32 or 64), but GCC still does
> full division of `nbits + 63` by it and then multiplication by 8.
> Instead of BITS_TO_LONGS(), use ALIGN() and then divide by 8. GCC:
> 
> 8d 50 3f             	lea    0x3f(%rax),%edx
> c1 ea 03             	shr    $0x3,%edx
> 81 e2 f8 ff ff 1f    	and    $0x1ffffff8,%edx
> 
> Now it shifts `nbits + 63` by 3 positions (IOW performs fast division
> by 8) and then masks bits[2:0]. bloat-o-meter:
> 
> add/remove: 0/0 grow/shrink: 20/133 up/down: 156/-773 (-617)
> 
> Clang does it better and generates the same code before/after starting
> from -O1, except that with the ALIGN() approach it uses %edx and thus
> still saves some bytes:
> 
> add/remove: 0/0 grow/shrink: 9/133 up/down: 18/-538 (-520)
> 
> Note that we can't expand DIV_ROUND_UP() by adding a check and using
> this approach there, as it's used in array declarations where
> expressions are not allowed.
> Add this helper to tools/ as well.
> 
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Acked-by: Yury Norov <yury.norov@gmail.com>
> Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>

Signed-off-by: Yury Norov <yury.norov@gmail.com>

