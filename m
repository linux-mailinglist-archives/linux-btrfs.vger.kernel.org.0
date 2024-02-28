Return-Path: <linux-btrfs+bounces-2868-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A84BC86B4D2
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Feb 2024 17:27:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5161E1F26647
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Feb 2024 16:27:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D2F13FB81;
	Wed, 28 Feb 2024 16:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MqQpyYuF"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C12A6EF02;
	Wed, 28 Feb 2024 16:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709137608; cv=none; b=sR8u1EnUI7y9rqqrJeRvLJ5sPpxBfc+fyawLwj07xOnjmA7GvxIQTMIcGIflpAlYa3uQ1+k0mxMx0vfrGJVzUBiIlbrIFocdSz2ptddcYFLFAXz4JaaIjZmlMVmBOMpva++9TEtzLX1KvazKfm70+j0uvvMp9FhXmOtqNsWd1Ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709137608; c=relaxed/simple;
	bh=cX0mbhq0/BEYvXkOM7RWyssC+Bf7DhBCperd504OjNA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OyFePebAodLKkfITlpLPC7/P/0FopQ9SX7HbqvsX2v+tR7dPE0bWLCIB1BSPhV83aJmYVJfEm9NhIP/kILNMxr9LQ51wzZk8hDmIDhVRc5SCJT4Shrufeuruk50ob5nQvFEwuPRHQAd+ntSSdr/4mn8JzDk21LGKGtbgP1ul3Q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MqQpyYuF; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-dc6d24737d7so5184274276.0;
        Wed, 28 Feb 2024 08:26:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709137606; x=1709742406; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jKTyKBoJ+zqx71icHaiIJXRtovwN+h+pKT79UfPo2co=;
        b=MqQpyYuFnbCOlGmRNbh/QSk7cYJl6W5gYFYTb16H2t6X9Yil5lWRX+J/UvpESS0bBX
         aZC9udLC+9bznVKxZJ/8okYEonOdXddLtihmeiJHMrWT8AjJM680P9eIfN+iE1tdBuUF
         KlCXDI6fqK/g6r/q4oEfJvDGL8uGeO2f/CgczTW1ew1+0+huTjubOlTrEOoYW5Lrk34N
         cCGnWSk/FUH2gI3QFyNs552u2oylH+8b/Q4VIM6j01lQoprzBNEluwgkQqLCGSHOWi4F
         6w40MXgMS5C8hqMrZCr8IWqR61kVA4qr5KR9fHkVkHfIZA4dJ8bdhBfmvPwq5IE/fwtl
         E1VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709137606; x=1709742406;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jKTyKBoJ+zqx71icHaiIJXRtovwN+h+pKT79UfPo2co=;
        b=kSPfSEMAeYHwB1prHIgsntA5X7Wke03t7hA2sRhvHdOvspoWyWtoVqS2mSE2mtb+3M
         4VyBFJn8CQzKLPP8SUUbGd86I02kEL/6b8rv37dWiTOhP53tBjmwWOo+9Ixof77l3cCT
         u6Kvqk5IFoHfefLZ3gMC/GAxRlC/KXen2pP7zWfBHhRWeRQ06Qg0fRgvci27t03XhCQr
         RS8K69k9zULC4+aI/fFYBzTd885KVvgmIlcYBT2cntXKk1GG8xjZRAMgyx1zO0JyzLMp
         AMBSdDw9N3xKR+wKAlDx0fjFiar6ACnaBiWu66yVPgoK4TZl387jh12V3+RH1SoffLbH
         4wKg==
X-Forwarded-Encrypted: i=1; AJvYcCVMPWE7oREciuCBlgPta/tKZ/uXiHVhjuqn9fcR/DeMgW2qzI8HYNzR5kx3npZv5v36AXYzAheHpSFZxZrxMTv3IOQfnHk9J3OpVJ5EYZG6FfjG0PFdoGm42Gz517fizogRtPI7wT6OfpsRMT7Ync/3U5/0LwIRqoW9Djw/LIgk/tRQovFTcO7f1rqKHAW2MbsixM7zuOzC3OAlPxD0
X-Gm-Message-State: AOJu0YxCb6micPftnuNlr36+8qxHjsfhMcx6UyLE/qpJi/gWoPofXDVa
	GqsDp0At4o4PJKgSrXsaYCVD4PSS/NFbJnInS11hqwBGMBqTZCDq
X-Google-Smtp-Source: AGHT+IEzDdshAZPifjikVHSc+ExEKZEbNWC8tYDB1UrSX7QHB04ABcGjvuz4tLQbulb0mZqEO3cKSg==
X-Received: by 2002:a25:c5ca:0:b0:dc2:2f4f:757 with SMTP id v193-20020a25c5ca000000b00dc22f4f0757mr2619998ybe.7.1709137606029;
        Wed, 28 Feb 2024 08:26:46 -0800 (PST)
Received: from localhost ([2601:344:8301:57f0:2256:57ae:919c:373f])
        by smtp.gmail.com with ESMTPSA id x11-20020a25accb000000b00dc6d6dc9771sm2072223ybd.8.2024.02.28.08.26.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 08:26:45 -0800 (PST)
Date: Wed, 28 Feb 2024 08:26:44 -0800
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
Subject: Re: [PATCH net-next v5 09/21] fs/ntfs3: add prefix to bitmap_size()
 and use BITS_TO_U64()
Message-ID: <Zd9exCzbAnOxAY50@yury-ThinkPad>
References: <20240201122216.2634007-1-aleksander.lobakin@intel.com>
 <20240201122216.2634007-10-aleksander.lobakin@intel.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240201122216.2634007-10-aleksander.lobakin@intel.com>

On Thu, Feb 01, 2024 at 01:22:04PM +0100, Alexander Lobakin wrote:
> bitmap_size() is a pretty generic name and one may want to use it for
> a generic bitmap API function. At the same time, its logic is
> NTFS-specific, as it aligns to the sizeof(u64), not the sizeof(long)
> (although it uses ideologically right ALIGN() instead of division).
> Add the prefix 'ntfs3_' used for that FS (not just 'ntfs_' to not mix
> it with the legacy module) and use generic BITS_TO_U64() while at it.
> 
> Suggested-by: Yury Norov <yury.norov@gmail.com> # BITS_TO_U64()
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>

Reviewed-by: Yury Norov <yury.norov@gmail.com>

