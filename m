Return-Path: <linux-btrfs+bounces-9798-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BA0D9D43E5
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 Nov 2024 23:23:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E530728334A
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 Nov 2024 22:23:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 739E61BBBE8;
	Wed, 20 Nov 2024 22:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=atmark-techno.com header.i=@atmark-techno.com header.b="ceuE+MrF"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from gw2.atmark-techno.com (gw2.atmark-techno.com [35.74.137.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04BF62F2A
	for <linux-btrfs@vger.kernel.org>; Wed, 20 Nov 2024 22:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.74.137.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732141411; cv=none; b=pzi2OrW99LbyDsg0j9Vps5KWDRsP5+k5dyj3B2wgf+h/DfQdptGzz3+Y210eDpKGMu//YEoeY1hcqRLjPfPwhXHYXBOVLqPZGzi0DisbdPSAYDgR0egotfLN2IeZrGPwUY3ncsQzghfTaPtth1fv6ohTA1avC8bkk1ETClVks8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732141411; c=relaxed/simple;
	bh=F3TL01q3W/kLNMiyds9fPHngq6RnHQ6vCEgxj74YBg8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pi6Z7QgWpZXYLJgaE00IU/BEfksOU3nDfLsoUZC8bOopteje50VNBFyAc9TNhbfQiGluG0w6s14gvJs7NmezXXc53kW9VPcoxtQZHzsnynu2jGIrjCsscjOa/MIV7n2I1DvUd/VgYQj1deYQiMySvW+zg7lBAXW2BN9+vw26aAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=atmark-techno.com; spf=pass smtp.mailfrom=atmark-techno.com; dkim=pass (2048-bit key) header.d=atmark-techno.com header.i=@atmark-techno.com header.b=ceuE+MrF; arc=none smtp.client-ip=35.74.137.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=atmark-techno.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atmark-techno.com
Authentication-Results: gw2.atmark-techno.com;
	dkim=pass (2048-bit key; unprotected) header.d=atmark-techno.com header.i=@atmark-techno.com header.a=rsa-sha256 header.s=google header.b=ceuE+MrF;
	dkim-atps=neutral
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by gw2.atmark-techno.com (Postfix) with ESMTPS id D9B1A376
	for <linux-btrfs@vger.kernel.org>; Thu, 21 Nov 2024 07:23:22 +0900 (JST)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2120c443728so2050815ad.2
        for <linux-btrfs@vger.kernel.org>; Wed, 20 Nov 2024 14:23:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atmark-techno.com; s=google; t=1732141402; x=1732746202; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5hKknO2Dc/7N8CoZJDGOTQxjWTIBBUE+CfnTvDM9udA=;
        b=ceuE+MrFh7KnHIKepgVL1J1perZDywWBbQdMGkG7dnT69cyr0DyvUZBiiWfdvsnsVw
         kRF3NKGWiQHJc/GabtQGtS/TaT+DRUNwLiMh3GAYpqLkSVmAGAo5bxcxD3vpB2Lq1CfL
         UHrzvsBiIcy/ac/yZhcE5c+/6VmlxNo0UEkUdDY8+Whc4Kret/QTw8XDMGwCBNCPDPmS
         GyUbeFUG9vGYSqx9mE7UMPYLL+vZJgDQe5jVaL/vhzOtrHlHLxwuI2oeN3gThQuofR8X
         coFrRz5btA5KhsTCwmDQ9ACtmZqnjYT2E9RPMwYzPJDYrnDMCyzczxe8hEHBQSnyPw1c
         q84w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732141402; x=1732746202;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5hKknO2Dc/7N8CoZJDGOTQxjWTIBBUE+CfnTvDM9udA=;
        b=wvUC+4DvXE2bf751WofP94CDcCQPjPpNhcftVrcMg2IykIN1Z1Cve27M5BkLVm5y1c
         hZTTbeLzxZ/Twg2kbpLooHbWXiWjg8G+yzZHecjqvKofvNO/p7eXx3y508gqDXM0h4sp
         2YcH8LWHG+moYHtvw9OM8eVLtaG9lJygnrDADz5osUBe0zC7TxK2CaSYCA18NdCi2Z1L
         F73tHU3C+4x330wSSXaaRhuGmVRy7J27fRM+urdUeIlcsHylERDl/814KWgRwoELEy/o
         rRbVn/auWSnv8jY5YGWXu20yZD7I+X2EExwj5ye2ID+/LvvjuyVloqTMCZJZMMcwqm8e
         yxTw==
X-Gm-Message-State: AOJu0Yzmy8JKP6hhBhpySAA8ZC5/GLRc2gw8MbdIsTM5XpchrhPVGwK1
	jZMH7lKKqELsIIX6EJnxe436T1ExKLAZOiB3xwHZb1TmrK2O1zZqK0uKZQVyzwubsdcT/gWigKn
	O0nvc8mvQKDo8qElo0sW1UIUFj3EVDhx1GcFHyom1Gyb91PoquXH5KZy9FdijeWnzQGe1nw==
X-Received: by 2002:a17:903:646:b0:20c:b9ca:c12d with SMTP id d9443c01a7336-2126cb209demr38552715ad.38.1732141401955;
        Wed, 20 Nov 2024 14:23:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEHX4gHxvEUKjKdKwmkqqodxTitPsaksC9HSHzWof4Nr4QxIZSVijDE0k0bi8RtfplA5WV04Q==
X-Received: by 2002:a17:903:646:b0:20c:b9ca:c12d with SMTP id d9443c01a7336-2126cb209demr38552635ad.38.1732141401684;
        Wed, 20 Nov 2024 14:23:21 -0800 (PST)
Received: from localhost (76.125.194.35.bc.googleusercontent.com. [35.194.125.76])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-212882d0ca3sm541615ad.172.2024.11.20.14.23.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Nov 2024 14:23:21 -0800 (PST)
Date: Thu, 21 Nov 2024 07:23:09 +0900
From: Dominique Martinet <dominique.martinet@atmark-techno.com>
To: David Sterba <dsterba@suse.cz>
Cc: linux-btrfs@vger.kernel.org, wqu@suse.com
Subject: Re: [PATCH] btrfs-progs: device-utils: include libgen.h for musl
Message-ID: <Zz5hTSPUCurvevGd@atmark-techno.com>
References: <20241119014326.3639742-1-dominique.martinet@atmark-techno.com>
 <20241120200505.GX31418@twin.jikos.cz>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241120200505.GX31418@twin.jikos.cz>

David Sterba wrote on Wed, Nov 20, 2024 at 09:05:06PM +0100:
> > +#include <libgen.h>
> 
> Please don't add libgen.h anywhere, this causes problems so the solution
> we ended up was a one place with correct includes, which is
> path-utils.c. Then path_basename() needs to be used instead of plain
> basename() calls.

Argh, sorry.
I'm not sure what I built the other day that produced this warning,
master has been fixed for a while.. Please forget about this patch.

> For reference:
> 
> - issue 778
> - commit 884a609a77a6ddb7f0e0ba8789e0f0fc0e899dab
> - commit d95a14949d80c7c7d6bb081d812ddcd39ba4b24d

Thanks for the references, I'll go drop the patch from alpine so others
don't make the same mistake.

-- 
Dominique

