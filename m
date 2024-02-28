Return-Path: <linux-btrfs+bounces-2862-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D1D7986B472
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Feb 2024 17:16:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86D1628A83F
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Feb 2024 16:16:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2C6615E5CD;
	Wed, 28 Feb 2024 16:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HTzp+Jyr"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AC4E15E5A1;
	Wed, 28 Feb 2024 16:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709136844; cv=none; b=EU+yE2IWuOUK2mKLNV/hQHey6eOjSrvE6QyD/OJ72jRs3sU1an3Ojn2/jpQpxAgimi6YX2xOLCb0LGD7lS1R4Typv3tVfG99Gb2bG7UO/MZQP1HM+vnE349RjyYHFnwavqnAFGxSSAD8Ogm4Q4SH2SOH8ijTe++FL1WhJOlMFks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709136844; c=relaxed/simple;
	bh=vBML+da3ru4k4fY41n9a1rUchj8BCGb3zQ7x/xQtZ0Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kAiFd2aIiIx1gy5xr4ycOWDOUoGVLMZKLFf2aC3m+5Fla5JIYNPPQic/0IlSZAJj3ylsUbBsh5XNzKjqN0apq4uCzpc2wvwCyxbwni3IBVgnc1RbgSyGmjzgGSIBcVCZ1hR2LTcgYoUcIHITgbWuS10hVL/5MinZR7QBH5BEe9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HTzp+Jyr; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-60908e5fb9eso36549777b3.2;
        Wed, 28 Feb 2024 08:14:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709136840; x=1709741640; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=45YCxhrvUCz1KlVt7J4vAlQKroPfuxlv6s5YsGgz7tQ=;
        b=HTzp+Jyrv473OuIH9pU7Gx+/7SFLLjOLbrjmqXxctyy+I7ITxYrSegxiKDG7iVDbIE
         ytjHXuj3YktcVMHGSnU0m2bQzyFZAA/7Pg+UMBOtTm4erCoO62O2V3iDuX1WN1LZX0on
         9BU2lk6SZ3tLpQ95YY4SmEfQ1j7T0ltrcQIZEW6sSlU0SfSCxlwdLaAAXqkl1D9FYwng
         vzCCGHXdncKGOT/OmNk1gheuBPekrZoPfRRGlZcmU1Yd/thrgd6r4ftTKsFNSKB5B14V
         nyzk1/LtaDFW8GdfKWMlI/m/vEDzK/WuvgK/XizSbJKPpJlkFT5olF56H56hjHwquIRt
         lV5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709136840; x=1709741640;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=45YCxhrvUCz1KlVt7J4vAlQKroPfuxlv6s5YsGgz7tQ=;
        b=s3tPY4t/n+jBFXPqdwdTP5AOZ1+Ba0ZkLMogw2RKwiAgnXIlkpHbnpIlnlQEGk9wdF
         PH6ZqnOVYdcKcX5CmJB0VOMWx8mhDZW/SiHVa+3Iam49/OQS75HJmh71BMLy4uZRAkFR
         vTtGV6HchZmcwhIIM0HPOhee/PksgE6MZHQFOIm2KLGHNcEc6lOLWYEwjtEwAwiEeR76
         EBtwlyWNVvk9Kuz3RRghAaIY6uUEzs6mg+LR2ZJtpC32LOR4B6vuChFSWAfWgB+hRO14
         erBScPtI6uMLq0PfIA6LSk+YXAsdLcqBFMUsoQSm4Dif6xNHLRXQuSvVi4BDDqzAiWG7
         /2Wg==
X-Forwarded-Encrypted: i=1; AJvYcCVWtc6kQJXE1rfu+HmUA4GzIcbr/vU9uFNwdD0574bmEyP3fCSEM0a2jt4G4czJRrrbLZVu9HC9wjOokKYMqHG7zlL23RDBLz/ol3xSQ6P4H69jVwTV5LBKP3VBHGJo0eBJGh2k1dCnY6M9JBOICjvsEF4/H4kxiEAbHKBYMiRGGiHbG5A8gkOtMyFzpxeHPaKvi//G5uJcDlZdpFip
X-Gm-Message-State: AOJu0Yzb14e9KOzgZ2KuG4PXNC9JrzOW+GOj67TqhB3HlYWv26gEynJo
	L9SXTRB7xssP/Y7B9cWKFURoRjKkBSVpijXXOglswFYmclee3q4x
X-Google-Smtp-Source: AGHT+IF/XdTViG4nS4Tgw4GzisgwWwhJcP/ftilWPL2A7fbswfOIesX+rYdfS2+pLR0JyM0z6TybVg==
X-Received: by 2002:a81:f903:0:b0:608:e694:ffcd with SMTP id x3-20020a81f903000000b00608e694ffcdmr4873054ywm.43.1709136840492;
        Wed, 28 Feb 2024 08:14:00 -0800 (PST)
Received: from localhost ([2601:344:8301:57f0:2256:57ae:919c:373f])
        by smtp.gmail.com with ESMTPSA id w65-20020a817b44000000b00604198c3cafsm2438101ywc.61.2024.02.28.08.13.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 08:14:00 -0800 (PST)
Date: Wed, 28 Feb 2024 08:13:59 -0800
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
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH net-next v5 02/21] lib/test_bitmap: add tests for
 bitmap_{read,write}()
Message-ID: <Zd9bxxRQboZI98KX@yury-ThinkPad>
References: <20240201122216.2634007-1-aleksander.lobakin@intel.com>
 <20240201122216.2634007-3-aleksander.lobakin@intel.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240201122216.2634007-3-aleksander.lobakin@intel.com>

On Thu, Feb 01, 2024 at 01:21:57PM +0100, Alexander Lobakin wrote:
> From: Alexander Potapenko <glider@google.com>
> 
> Add basic tests ensuring that values can be added at arbitrary positions
> of the bitmap, including those spanning into the adjacent unsigned
> longs.
> 
> Two new performance tests, test_bitmap_read_perf() and
> test_bitmap_write_perf(), can be used to assess future performance
> improvements of bitmap_read() and bitmap_write():
> 
> [    0.431119][    T1] test_bitmap: Time spent in test_bitmap_read_perf:	615253
> [    0.433197][    T1] test_bitmap: Time spent in test_bitmap_write_perf:	916313
> 
> (numbers from a Intel(R) Xeon(R) Gold 6154 CPU @ 3.00GHz machine running
> QEMU).
> 
> Signed-off-by: Alexander Potapenko <glider@google.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Acked-by: Yury Norov <yury.norov@gmail.com>
> Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>

Signed-off-by: Yury Norov <yury.norov@gmail.com>

