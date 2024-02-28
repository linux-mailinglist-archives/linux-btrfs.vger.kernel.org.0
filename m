Return-Path: <linux-btrfs+bounces-2871-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 93C1586B4F2
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Feb 2024 17:30:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C5FD1F25145
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Feb 2024 16:30:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CBFE3FB96;
	Wed, 28 Feb 2024 16:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WjcpS2mh"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C431E6EEEC;
	Wed, 28 Feb 2024 16:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709137791; cv=none; b=byPwDRZ6nsJoIZRVvSYZMPnbkBbGNf/476f32P7zVtPZMlq9lslLVygJ1g/mKGNqDZZSw7q08RpbhIhE8gXNbyHYDifaonwGWMqrcEIemWwdpXCPOBzVf1y2IISB+NNGu/HqarlEhx1+ol3e56nRgz1I/TR7u7xmOeRf3bzThfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709137791; c=relaxed/simple;
	bh=wS3cg47EfvD5VkYCZNfgMA58P2hp2/4YIQrmVXFhguQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q7jjs88ODLoCB4d4FE3muc2aJZ9gK5egjHlIxd9hhnSDHUQ43wPa5s/QE5gQ4/Htx5YZjtfBRZJFj1/CAQSNonjrYiOycBUsfQ4oQfX0cGqnEhmRi3vT7gCtT7JUqIISZAH19ADlAEV1xWeRb7iqutjX7XQ0Cl1DXdxvoXlkmWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WjcpS2mh; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-607e54b6cf5so8351407b3.0;
        Wed, 28 Feb 2024 08:29:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709137789; x=1709742589; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kj3zQ1lBxACrFRnKWFxYbPf2tKrEF/iMipPYB2aWh/I=;
        b=WjcpS2mhLdIqYZhn5R6jyj2N3fEvr4qWjAx6/h+M/Ol62xHehBunCP+Jn+Mwe3xemO
         RbPQvXmBBH8s74lEweTfAxZbaXj1G7wYf2Pjxz7Es/G8FgG3fILUGUrN8xziniTBflVs
         lAfEv9CnSWSHVU/+/Vks8gl+/Bv9cvvqvp7n7KQS8mOlZveMW+aP4RbDDI8KPvg9pXz5
         S7VORQeCBfXF7IL7Jv7cqUshMavLfLDP/0LDhIo/UbrFjshZ+mknkbQKQmviNlhPxBOw
         odkh9l7y2cV8Kz39UYpLc/4J6CRRlSOTar+BlMJcTCcDUWMQhp5YOPIWD21z0dI2Uib8
         z3vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709137789; x=1709742589;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kj3zQ1lBxACrFRnKWFxYbPf2tKrEF/iMipPYB2aWh/I=;
        b=L6O4sMa0Ac9RKr/PGsFYHIyTN5xpwl9vrHOxBjhLcXPUaNKkDpRyfE9YbkQr19rBlG
         KUVOuDgJn0K8YFvX4WbiTjwA5BmTUvoDl2dr7KQeLSc2lQ58td3nV1ORIcuKyyQDO7kK
         aaeks+XS6i1T39vVALArjZtBPhFHgfMDyL3xITOnGxrUab6NCt6b6POHvmyZnITDwQtt
         BxIr7jW+wj5TB0T+kS5qqZvZXPT/S1mnZEqD3q81iF3MsK8QczUhBTUyHT84a+FG6EBw
         Y/R5kj+TR9qWLJodSxwvyUn1EDOaSAVBqdp/XUYYXyQfW2fRZdbVjE/BGUCu4R5acf2O
         8w4Q==
X-Forwarded-Encrypted: i=1; AJvYcCWALmRI18VbLUELXIGcB7Eqj2jpyUb2QY+wHXy8SEzfoduvXcqHme/U5bWTEEheZYjZAAmHwWUEQ6xK9o2bcIUpeXU7rnPQLO3j5bHTyMJXa+IPZUtCxsqhMV1p65Eu9pY/he2DtKse5P2ciN/KolI/QeAsMjizhroAFbc9dRrsudgSAKs+jEv8SRv8/GP893zuuXvh47DpBKNVezHx
X-Gm-Message-State: AOJu0YyIs8TnadnLtJqBST/GTcVNpD73i8TTBP7OJLdeT2QoTy71+NhC
	97G4vp6yecSTgqkTv3pgHF3wiWznKtMwcMmv9yT+XcLsjJhy5qGd
X-Google-Smtp-Source: AGHT+IGa1uVu1QGKwzBN/ugqWSb5R7kpDXIVH6fnycyAQSPeZdMmpMkJiKarLdELLKFo76CJJMn2/A==
X-Received: by 2002:a81:b284:0:b0:608:cc10:f4f4 with SMTP id q126-20020a81b284000000b00608cc10f4f4mr1884717ywh.16.1709137788712;
        Wed, 28 Feb 2024 08:29:48 -0800 (PST)
Received: from localhost ([2601:344:8301:57f0:2256:57ae:919c:373f])
        by smtp.gmail.com with ESMTPSA id i126-20020a0df884000000b00608a88ba3c7sm2471750ywf.79.2024.02.28.08.29.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 08:29:48 -0800 (PST)
Date: Wed, 28 Feb 2024 08:29:47 -0800
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
Subject: Re: [PATCH net-next v5 11/21] tools: move alignment-related macros
 to new <linux/align.h>
Message-ID: <Zd9fe8o9zkwoW8Cf@yury-ThinkPad>
References: <20240201122216.2634007-1-aleksander.lobakin@intel.com>
 <20240201122216.2634007-12-aleksander.lobakin@intel.com>
 <Zd9fLYP0uzqqwOdO@yury-ThinkPad>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zd9fLYP0uzqqwOdO@yury-ThinkPad>

On Wed, Feb 28, 2024 at 08:28:31AM -0800, Yury Norov wrote:
> On Thu, Feb 01, 2024 at 01:22:06PM +0100, Alexander Lobakin wrote:
> > Currently, tools have *ALIGN*() macros scattered across the unrelated
> > headers, as there are only 3 of them and they were added separately
> > each time on an as-needed basis.
> > Anyway, let's make it more consistent with the kernel headers and allow
> > using those macros outside of the mentioned headers. Create
> > <linux/align.h> inside the tools/ folder and include it where needed.
> > 
> > Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> 
> Reviewed-by: Yury Norov <yury.norov@gmail.com>

Sorry, please read this as: 

Signed-off-by: Yury Norov <yury.norov@gmail.com>

