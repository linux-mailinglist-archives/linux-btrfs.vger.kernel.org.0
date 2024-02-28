Return-Path: <linux-btrfs+bounces-2874-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3310F86B50F
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Feb 2024 17:33:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5FBF1F2296A
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Feb 2024 16:33:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34264208D1;
	Wed, 28 Feb 2024 16:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NsEDV237"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA7656EF0F;
	Wed, 28 Feb 2024 16:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709137958; cv=none; b=KGCuNDzerL/EIgQbNjsUiHTdiRfA0WS30bivoiLiu+FZrmZ/D/Vk+MDdsKM6jHDGljZDA+6Y7Xnh11XBg2LIJn/ZiANJIZ6IZ7QV9f0Gcir3MEmWPEd+ZCMgQ2YdzQrqnLmfNob9/u4MZWTmEnzpozYRErUIUzn8vrWRUW2m6bA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709137958; c=relaxed/simple;
	bh=d3rBt9ZoE8GZdyPyKzBUGndsZ5i3T4Yv6JMjZVtygx0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=upTXDqhW4W2qoTDe7bu1VO0ZbvudCHVF97hJSzyWaRgEZb1/j0DbPjbAb2Iv9/6PbAujYODXH3lpyxYC66h6PjpMVmQ8/NxV5mUz9wf+6JaZq+3gz54iND4+cQLHMqEsFUSASy4LVQa0bsvS2vxrOIucGDmLomZiK3CBWuOiTag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NsEDV237; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-607dec82853so60023047b3.3;
        Wed, 28 Feb 2024 08:32:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709137956; x=1709742756; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QhE1MQsKvhB9REC+482u9v2wKLir8r1v7/0zkgMeFU8=;
        b=NsEDV237y0cDLgmEBNmAnOe6HdD1lCWyZnmcfxmIIDBGGukvv16QArr8HIPB+Sf7IK
         Y1DKvs1QHvElqpQUz+IOMCgijWfsHTvG5r0Q97bYWF0ZInsgYQD8lPUPykSURokUgBQx
         jE4N2vf+vs0ASrL03FzJ75uf7bhWCTpIkO36xb0Tad7m+R2QwnG7X6I5PZmxxHl0Iwvs
         wWMiS/5phXJKESdp8hQuV9V9QJD+KclzhRpqGEGRcUSC6GX0r9QWCrocfMoRdSrpVkiR
         Z8C7qJ0iK2cxb7XjGYwjbljtxq06mrx4WDPsF0ijiHrI7jiaTxiRLEA/weuMlS6imreT
         PdIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709137956; x=1709742756;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QhE1MQsKvhB9REC+482u9v2wKLir8r1v7/0zkgMeFU8=;
        b=jt3xVtbNatqatAemPgtCA3gTsiggLnpBwoVF/q8D8/X1a8kNq+q8fgimdTKpL49flm
         lQhZX0h0nP89EBPq50nbm/p1Mdc9f3LzBFQw7wPeXORvffXGW54tTZ3CQAVHCGHY28Rm
         L72Y3vzgI/Ti/XqCQUs3podjOEfzx+fiEheU+iTI9nQww1Dd2rNdngJL0zu3PbXwirds
         NFB93Tc8F4kOWp9MLvJPTS7+dsrM0LJGAa5+7wfk94MSMfOC7f3ry7Hd6V7XoA/vEaDF
         t0Lb2zT34NOdybBRf7S2yJOtwIX7NZWnCr3egEePb82/q0VxHkfnaj0Ct+pAXVQur+v7
         9vTA==
X-Forwarded-Encrypted: i=1; AJvYcCWDfPUkAygEd/11NIzLK3CoHONu966F2GIqm+Onsd67g6b/BdaqXm6NdYMZzgAZZ1l0Sf2VViGUxM+dVLiNAayw8xAdcQTVtIluqRg/rPYIBQuWj9UM+sr5efYzeUeJ6XoZINPuBVyOW6upwEFA4SfXRlFrMwE1DeUoBFFSbt7NiDO7hOIK+rnUYUJ3JLd+GJD/qOfTuK1mjU6pWOif
X-Gm-Message-State: AOJu0Yx/tmmPZ2Ux+3P9TCxu7PK0i3kGp3hQzbNWCoz3/WzQHwUuxXym
	EPy78rXWtUcnP9C0zjFS6iS6X9qi9bDPkvJK4q/5E3IRA1tQk3cs
X-Google-Smtp-Source: AGHT+IF7y727lGvQC58bwkZEZGqk/V3taxdRWZKAkhTKPUp2zVZ/V5NrHMWuRoL1mydS8eaxnJgy/g==
X-Received: by 2002:a81:9a43:0:b0:607:7dcf:7a94 with SMTP id r64-20020a819a43000000b006077dcf7a94mr5535918ywg.6.1709137955942;
        Wed, 28 Feb 2024 08:32:35 -0800 (PST)
Received: from localhost ([2601:344:8301:57f0:2256:57ae:919c:373f])
        by smtp.gmail.com with ESMTPSA id l141-20020a0de293000000b00607f8df2097sm2421611ywe.104.2024.02.28.08.32.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 08:32:35 -0800 (PST)
Date: Wed, 28 Feb 2024 08:32:34 -0800
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
Subject: Re: [PATCH net-next v5 14/21] lib/bitmap: add compile-time test for
 __assign_bit() optimization
Message-ID: <Zd9gIj9qcrAJVw5u@yury-ThinkPad>
References: <20240201122216.2634007-1-aleksander.lobakin@intel.com>
 <20240201122216.2634007-15-aleksander.lobakin@intel.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240201122216.2634007-15-aleksander.lobakin@intel.com>

On Thu, Feb 01, 2024 at 01:22:09PM +0100, Alexander Lobakin wrote:
> Commit dc34d5036692 ("lib: test_bitmap: add compile-time
> optimization/evaluations assertions") initially missed __assign_bit(),
> which led to that quite a time passed before I realized it doesn't get
> optimized at compilation time. Now that it does, add test for that just
> to make sure nothing will break one day.
> To make things more interesting, use bitmap_complement() and
> bitmap_full(), thus checking their compile-time evaluation as well. And
> remove the misleading comment mentioning the workaround removed recently
> in favor of adding the whole file to GCov exceptions.
> 
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>

Signed-off-by: Yury Norov <yury.norov@gmail.com>

