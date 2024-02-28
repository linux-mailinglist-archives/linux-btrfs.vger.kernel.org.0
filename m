Return-Path: <linux-btrfs+bounces-2865-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B324E86B4A5
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Feb 2024 17:21:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB6A31C220C4
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Feb 2024 16:21:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C3F86EF0E;
	Wed, 28 Feb 2024 16:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MKTPSRUm"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 953CB6EEE0;
	Wed, 28 Feb 2024 16:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709137254; cv=none; b=JAwqOBj4FLRl8BRQW5jn2MwaDVJD8RLTY2WNBJF9rZmqxbMQ1J70Mtcfc5jBl64RFzpjHk8irc3ry0UObIFZsVvFjVs6ZA6xtKEV0rq7MZXJR4wV73sgsKXytGJUYRhw/Qs98jcCy6WUMPXnj98gEGP84sDy2WfJwcc1PNuWIYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709137254; c=relaxed/simple;
	bh=P/cOkDLDSSyk4DgZbvtQrFoF7aMyarAs6VHUkE+AZ9o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Uql1XxUk29Sm1IUO9mxO3+BLr7BT9yCHV8b1KBOsd186ZlLRl0TYwbo5ZSUqrJtBPi/fX9NFmwpMKdpQkbksgbmTjgk+JD9kGQ2+2ReFK6WSBZzGS95R7TpgGG5Phb/kTQco1gWdeoOshkA551fqZzJhHp7iKZq2aQKpRMui0+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MKTPSRUm; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-6095dfcb461so448747b3.2;
        Wed, 28 Feb 2024 08:20:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709137250; x=1709742050; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mdo+WCwYssTHA5Y/xcZDi9YAkmpmO4mLfP1Bdut2TaY=;
        b=MKTPSRUmGu/7nNdbXvU9YmTV4SuB6ddMkTgLHhTjaivzKhkNZ0hASkZLCw+Bftb+UF
         nRKTCqxAW59UWet0ert6rIU3Sb0ckjofcjiNGca6BWgGZPZ3ZfupYKQI1PJcIT0TCWC+
         TVgrTyadB2j0nR/QX2X+uQN4Q6d1YuD6jma653VEYJwWRU9grUw0pJxSpVsHB9tnnpVW
         5Lz7Dnj/tiSWXFYufj/AP3eJkiVWsGAqc8b1vnV67EbhKNvpTiJzEOrUDKaKRCm1oEVt
         Gv7b/dJTFqnKEFjrjACUYQIw/HytZczHNi+evhgWMLLFa/iBSV4LmG8ABtzl5KFu7mmo
         NUxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709137250; x=1709742050;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mdo+WCwYssTHA5Y/xcZDi9YAkmpmO4mLfP1Bdut2TaY=;
        b=UXQuSSV6FRkV3NqufVPWTnMyRKjh4SgD7IpSdhPqDWXUD1FoZds6TLtQbVSaGx1P1P
         3Q4LYs8tTw7k7UZ0tdf2fXngAY6LC3qoi4VXT1ojf7xsBnUqSMwyGLhy19uvGS5KIfRS
         3MBgkiS/vguVjmK9VCQzDB3rYCT97gQlZe1PN7i0WiruJRzY2/F9pqf2OswHhz24a3vT
         A8rFAJlRPxVcZ7oBxFZYWF2WN68uKYk9fjKcy7t/Yl/gKyt7Eq58Wy3eGcG0fcSuYPfm
         MDYjOuMtjTihfyeegeaWKJqSjkMuw1XvPssvHe46OMRan3Gjmi+fcdn8hDOnSoADcZ2c
         0v1Q==
X-Forwarded-Encrypted: i=1; AJvYcCXXqa+DUpG1a4cMEWQF1B4gfWQyZerbW03sP7wKabeBVQXIsRE9UvYkgQpdRIWqf2MeZmsYSJ/cIr/1z4ukrah3VLq5LRSKQg642NBVGNGqAMqo6AoCWlHNPVaW4Z0FJTFg4GOpL0NzRUpzAsMqzBrXMg83y8ynwnz/PaampE6Eg1DGK+CFh8eBxORudEahB5GvbiAmo5WruZM7UORH
X-Gm-Message-State: AOJu0YzXEtgpB6u+AcwLE6f83RNU28+dWvd+VHdjebWzq3t6A/Ujzm1B
	P0C6vKIQSLLd3Ps9L+5DdiyA3hEKLISa84aGHWs37E/h98WOy3uR
X-Google-Smtp-Source: AGHT+IFog7Zlb1nyvjIUA4ujLfkoca4T12KmwBu9waTIaa8SAH+ATAMvMCHoJTwS61raA1yWNAPR4A==
X-Received: by 2002:a81:e349:0:b0:608:d188:6fd9 with SMTP id w9-20020a81e349000000b00608d1886fd9mr5510309ywl.33.1709137250415;
        Wed, 28 Feb 2024 08:20:50 -0800 (PST)
Received: from localhost ([2601:344:8301:57f0:2256:57ae:919c:373f])
        by smtp.gmail.com with ESMTPSA id v1-20020a81a541000000b005fff0d150adsm2393743ywg.122.2024.02.28.08.20.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 08:20:50 -0800 (PST)
Date: Wed, 28 Feb 2024 08:20:49 -0800
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
Subject: Re: [PATCH net-next v5 05/21] bitops: make BYTES_TO_BITS()
 treewide-available
Message-ID: <Zd9dYVolWW/kyngn@yury-ThinkPad>
References: <20240201122216.2634007-1-aleksander.lobakin@intel.com>
 <20240201122216.2634007-6-aleksander.lobakin@intel.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240201122216.2634007-6-aleksander.lobakin@intel.com>

On Thu, Feb 01, 2024 at 01:22:00PM +0100, Alexander Lobakin wrote:
> Avoid open-coding that simple expression each time by moving
> BYTES_TO_BITS() from the probes code to <linux/bitops.h> to export
> it to the rest of the kernel.
> Simplify the macro while at it. `BITS_PER_LONG / sizeof(long)` always
> equals to %BITS_PER_BYTE, regardless of the target architecture.
> Do the same for the tools ecosystem as well (incl. its version of
> bitops.h). The previous implementation had its implicit type of long,
> while the new one is int, so adjust the format literal accordingly in
> the perf code.
> 
> Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>

Acked-by: Yury Norov <yury.norov@gmail.com>

