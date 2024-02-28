Return-Path: <linux-btrfs+bounces-2869-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CE01686B4E5
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Feb 2024 17:28:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A98D28DAA4
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Feb 2024 16:28:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C8643FB87;
	Wed, 28 Feb 2024 16:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dNYKXt9z"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10FB26EEFC;
	Wed, 28 Feb 2024 16:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709137658; cv=none; b=UCPIZ5VRTetQqrmT61nXQMs4rLZ46XEONLAKhCF946Uu06oFnAmEr5+CcCvaWQqV5/pVM/8qc63dD0fLO/GqQv1BKZEO6vbnNmQwkIVcp6XvNiD5EgycSRYcEGfFCxifhGx2/04yxSHmQsVS0Q2swRoLzEFAODeBFaHIFkdItXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709137658; c=relaxed/simple;
	bh=XsYfI28aCpKhqEa677qx/0xf73cpFk22FTtXQK4wgpI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FUAWOvZGxMEreV1WI+sa/Ox2EKE8UagQ/NLg/FMgz0i8NTFoyH8/OPuLC10p8wYc/AdHDDOw+/yBAVYJ9grlL4fxwbRTnuQRZWpl7qbNFtxdYuPts69aIsqwF5qoTGFVI21UTxYdoO2XmGd0UKHmHX85hTBHTc6dekMBJv/eVSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dNYKXt9z; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-dcbf82cdf05so5805340276.2;
        Wed, 28 Feb 2024 08:27:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709137656; x=1709742456; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hWtL7++GjICFukUAoP4h+KhEWcLjTOAu9lMF7xAGsyw=;
        b=dNYKXt9zA7SXwNI3Hz5/tmwGULpsXm/cceD7uMJEYVGkqwPSdk+LEBbFRK8qOFhlmB
         zPcUxAFOww6Jx0oNcWLbGlFuU6UAilb4Fb+KrKUI2BuEF3MGiC6G41V3q9Vwk38mvlgl
         X54ws/YbYNCNC4dup0YxVADuhjfVYPd3a0B0vN8xnr546XcjvOmqvxUksfSnexH4qupB
         mEd3+sk6M2tybeTTOzbpz/6bE+qkzoVZTz+c+5WTWII6VT4xd0YIGXAubVHT17pk8zN8
         tmN+RWy9ICQvcNa05v3qDwO4aKQLbY900n0H3Q20B5n6Ct5MErcWM5teOcUmY0QsGUhP
         WDpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709137656; x=1709742456;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hWtL7++GjICFukUAoP4h+KhEWcLjTOAu9lMF7xAGsyw=;
        b=DNEkzb0vbgxZ4P1wsQvO57dPqfXG54v5L/zg5ptyga2vSHu+velYQVQCAvDxE9/wIb
         pvjIxVFwb5yjy1iOBANWewlCwQfr4K8sJATGarQX1sK2OsOirGhYKaUP4G+6XwPNIPSG
         H+59x5Mg+6GaVXzlzDSFaO5wJWfB4jSAF52kLFEQmvGDkBasrlsZVeUC6/hh9qyRb2Rj
         Pwj7jzf5rU4gz2xRdAQQ4jh9XVarrQxpTiY+fCVgcN6wT/U7TFnrY9Er+N8G2DkD+nQB
         7wAIbaxU1s97EVCEhsgihwrVB8mzYVi8G+oYPMGaeA459tThLk4u+tkorEu9yQb35qp8
         SHPg==
X-Forwarded-Encrypted: i=1; AJvYcCWFcCVzrfSqaVo9evkHBG9r4CScRk1JlFa0yATX5nvKEYDBTZrXJShdKMCwGdU27jgz9hj+3zQNs5XWTofuxaROV5edFf7Tj6k0UtsYdUlFWaeVWeupib3QQ1VhqSvnaNOxVnex8wNHAgJhbJbnxBk/i3sHdtC6WvF320c2A2jINT1mIfhWP1jhn3CtvOFw0ftNtI8/FckB9oa7sY30
X-Gm-Message-State: AOJu0Yxh09/U8offsmf0OXxKrKcuSNv2GHGsNLdl6IkOyr0mWd28g1Rd
	0JbeWRwBYkFs3F0Z4P2mh8cqMwlMmid3gmynEdSuB8qwpP5WbnZZ
X-Google-Smtp-Source: AGHT+IGgZ4Kkae23Sonz0Wy+ywJ8k8WbRQHuZh38JY+GnbqJ6cshhsv99aWcYpDQ6qckCPnCgMPxgg==
X-Received: by 2002:a25:e04e:0:b0:dcb:cdce:3902 with SMTP id x75-20020a25e04e000000b00dcbcdce3902mr2751167ybg.55.1709137655985;
        Wed, 28 Feb 2024 08:27:35 -0800 (PST)
Received: from localhost ([2601:344:8301:57f0:2256:57ae:919c:373f])
        by smtp.gmail.com with ESMTPSA id s17-20020a5b0751000000b00dcc3c85f6a1sm1956317ybq.6.2024.02.28.08.27.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 08:27:35 -0800 (PST)
Date: Wed, 28 Feb 2024 08:27:34 -0800
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
	David Sterba <dsterba@suse.com>
Subject: Re: [PATCH net-next v5 10/21] btrfs: rename bitmap_set_bits() ->
 btrfs_bitmap_set_bits()
Message-ID: <Zd9e9i6FQzGWfHBq@yury-ThinkPad>
References: <20240201122216.2634007-1-aleksander.lobakin@intel.com>
 <20240201122216.2634007-11-aleksander.lobakin@intel.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240201122216.2634007-11-aleksander.lobakin@intel.com>

On Thu, Feb 01, 2024 at 01:22:05PM +0100, Alexander Lobakin wrote:
> bitmap_set_bits() does not start with the FS' prefix and may collide
> with a new generic helper one day. It operates with the FS-specific
> types, so there's no change those two could do the same thing.
> Just add the prefix to exclude such possible conflict.
> 
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Acked-by: David Sterba <dsterba@suse.com>
> Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>

Reviewed-by: Yury Norov <yury.norov@gmail.com>

