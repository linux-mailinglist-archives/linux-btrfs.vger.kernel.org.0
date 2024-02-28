Return-Path: <linux-btrfs+bounces-2867-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ACF186B4C4
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Feb 2024 17:25:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 119A728C0D8
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Feb 2024 16:25:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F4673FB91;
	Wed, 28 Feb 2024 16:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QQzZf/by"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBB5B6EF08;
	Wed, 28 Feb 2024 16:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709137486; cv=none; b=mbIorVO+cvdL21G3db+b3KB+1z3NH+7adn2S0DJQMrBiW0OI2EQbtqas0rC0jaNfCTQD2lFTdTDGT4JHUqML4ZElqPX4CGx33KAbbMoF2HjI7+gvIZPcJPsxcU7fFukt0pcHlKAxv8YgMlrjDXBnNGXE6glEbEnV9DFN6JRXeH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709137486; c=relaxed/simple;
	bh=vKUF/IwoOUPHwhneZ5hpyMp0Qy1d0T7jwb6stGL3VXY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YzKtEWTroH2B9xiVgoNYZQuPCdg1sV4G5aJEwbQWP9XDe/8BNuKFNOEXcy0BviiiJDp9ojan7sIpc8+enOl2mA7VYmwwgLOzC63MrHD+eFOyuVWmrP5Cn1kV4uxbEdduu1p6QNTxQTCe5E2oAb/CtPdo+Fr3MhnJn9FAWfBI5bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QQzZf/by; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-dc6d8bd618eso5967043276.3;
        Wed, 28 Feb 2024 08:24:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709137484; x=1709742284; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6yiyiSurF95Yilk417AKvUkFM0dsA83koDFik74Ewi4=;
        b=QQzZf/by3O68oh7fq094Sp+a0l6isHtSWzC2QTezrC18b4dJIpZRTZbsvvmSmx6HwO
         Aqfw+UGef2cRQBy7csWmZcDE8bF+H2tGj806aCX/pP9/DQzqKNzO4o409Ulh+QQXxTPe
         w4XpIh9UUe9Our0R0w9MyTwc99FcvRfmCKDBgmYf7jvH+Ptk1jU4M2MzzWmJ4SDkeUiM
         ArItkLku0pkhIijeeCB+sYFZ0WK1us0UzhGrINv+fgw6Zp9ZXClUu3IUXsZhQE1ERANe
         8+0VS+iMig4KxLkDdFpqJw0SCU7SZfeXKsvHb19kgIysARCfGjA0MBHgXOphZ1y3aeAt
         vXyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709137484; x=1709742284;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6yiyiSurF95Yilk417AKvUkFM0dsA83koDFik74Ewi4=;
        b=cDwRjD7hyfPlWa6/j9VZvk+7nNZv750O66Vbkb0ng7i74/08ZMBcU62f1BZDyGJ2Gi
         VXLUMKOr/vGUhZOJ5Dxp6ysOs9fcB/+1i6upQHuUJPA2deM0oeQahWAKSLzxAGL8MARs
         t56aRBF9Suc4SU/1PZ39JpZA6faY4EmYjX52shU+8GN9NsyWitex0ICdrtobyzpLVofB
         4knukTefBb0sizbFF+01LRhtORDcChLrMql6vtjWgNcgff24RMCIX0Ek92kRupU+t9su
         gBRYh/iYyhghibXnlMEol51zOuRHuEfVgbFmLmqTu7kk3WN6quuznwYt5LIdSFxI3yBd
         IPcw==
X-Forwarded-Encrypted: i=1; AJvYcCXbAqtgEEQ4JmCEMlnC9ArVexWQVh3adivd4UB9Ee3M0eqe1PbV6GtAkAj1gaIEPkRmSuKzIIXv1fUnL/V25s57PX0WQSKEqsJ2D72ccWwBw1n+iAfl5oE+HGxTZUAYK1WbrJ4yzoT+LNXAk/CyXLhD26//mzb6I3PqwKGMmmdXgl14Ht9Km/vK6SDl2N2A9rqgsNLMgQz26jDdKPUr
X-Gm-Message-State: AOJu0YzjwmbFeUwk0Fyu5kgZhVMgfsYPyjmdz7jsylRLZBm18vNO7/YO
	BtpeVR2Gr1BxLUkHnfbybFADwTH210V+GQN2ueWrk/B85qn2uK2T
X-Google-Smtp-Source: AGHT+IE97AzDCtBDNO2Sn49xrnDEk1v4Xi/j9mx5F7dqZo00YL4uAX4pijipgcc3CcWP0xNp3S6Muw==
X-Received: by 2002:a5b:c0b:0:b0:dcf:2cfe:c82e with SMTP id f11-20020a5b0c0b000000b00dcf2cfec82emr2516397ybq.55.1709137483760;
        Wed, 28 Feb 2024 08:24:43 -0800 (PST)
Received: from localhost ([2601:344:8301:57f0:2256:57ae:919c:373f])
        by smtp.gmail.com with ESMTPSA id z1-20020a25a101000000b00dcc234241c4sm2063668ybh.55.2024.02.28.08.24.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 08:24:43 -0800 (PST)
Date: Wed, 28 Feb 2024 08:24:42 -0800
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
Subject: Re: [PATCH net-next v5 07/21] linkmode: convert
 linkmode_{test,set,clear,mod}_bit() to macros
Message-ID: <Zd9eStoaYFlz/ck6@yury-ThinkPad>
References: <20240201122216.2634007-1-aleksander.lobakin@intel.com>
 <20240201122216.2634007-8-aleksander.lobakin@intel.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240201122216.2634007-8-aleksander.lobakin@intel.com>

On Thu, Feb 01, 2024 at 01:22:02PM +0100, Alexander Lobakin wrote:
> Since commit b03fc1173c0c ("bitops: let optimize out non-atomic bitops
> on compile-time constants"), the non-atomic bitops are macros which can
> be expanded by the compilers into compile-time expressions, which will
> result in better optimized object code. Unfortunately, turned out that
> passing `volatile` to those macros discards any possibility of
> optimization, as the compilers then don't even try to look whether
> the passed bitmap is known at compilation time. In addition to that,
> the mentioned linkmode helpers are marked with `inline`, not
> `__always_inline`, meaning that it's not guaranteed some compiler won't
> uninline them for no reason, which will also effectively prevent them
> from being optimized (it's a well-known thing the compilers sometimes
> uninline `2 + 2`).
> Convert linkmode_*_bit() from inlines to macros. Their calling
> convention are 1:1 with the corresponding bitops, so that it's not even
> needed to enumerate and map the arguments, only the names. No changes in
> vmlinux' object code (compiled by LLVM for x86_64) whatsoever, but that
> doesn't necessarily means the change is meaningless.
> 
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Acked-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>

Acked-by: Yury Norov <yury.norov@gmail.com>

