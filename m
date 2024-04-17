Return-Path: <linux-btrfs+bounces-4383-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C3F8D8A8D6C
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Apr 2024 23:01:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E572281FE7
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Apr 2024 21:01:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8911F481BB;
	Wed, 17 Apr 2024 21:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="0aCAlSXD"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1BD811CA0
	for <linux-btrfs@vger.kernel.org>; Wed, 17 Apr 2024 21:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713387675; cv=none; b=r73m+NnD1SVRxUzD3igwZGaORgIhz+4VtyBp66RHrexqPoAzqu4uqY9sYB9LEr8DszUKKRTIEoFkZvIebFnyH1QTi+qSGvucQ6f/H+JeKkED+R68BP5ahLlHCfoRUfnKEmfZ8m46D6l9PEALfbO1lGJ6rXwYZVTF+VFbTnMxFNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713387675; c=relaxed/simple;
	bh=ttuod5gkUnAPHDyHrdhDWeZ+Hxk+/WPkp5IDltCJtQ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=spwMwJk7WDWg9Ynr+ukrJrOyhzlHcXBA3Kh6Yo+Xd7XzNxhrdVeshSdNovsz3sg5EcsmL+R3qe2E2LNSbL+wYKJFSHx1+nwjdhSImYAOruu6K1Vto2OgKFpiye/jT0I+uvWSyCuk9PQbh5sDrE/x+klsbCU1PkE/4oHRAheZFhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=0aCAlSXD; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4376157292fso566991cf.0
        for <linux-btrfs@vger.kernel.org>; Wed, 17 Apr 2024 14:01:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1713387673; x=1713992473; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4stgttynmSif2czMbNz9LViFxBGMlZDo7t/6iNHzftc=;
        b=0aCAlSXD5QwJp/Ayvwfa5FJkb1wEcwOEUCRFiRHt93fSnb+j8R/+tEaglgORTw6o2x
         Zb7bozLmZnMDRJKSjFKkNUlsQF/g3SPayPs8PnXzLTWE04NHGPeY1ciQsXMvSl8heNEz
         3J4Z1mLMyphdT0Z88TEkL8KyOmMDaiMGjEH8g7h49NWVeIqcFaQbuIr5GYrcApXVdeBv
         /g6lvEN5tfAkFloat56jDm6h+NO3QZZIRbbFPESu73gUna6swG5Mde2n3RgCPu7p+8zC
         eY4hDmEa2gw0HzGFrnNSdNCijb5O7oMp/4HiDnT+8aWgXIyi3lsW/DqbDfHXzFh66NDP
         PI5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713387673; x=1713992473;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4stgttynmSif2czMbNz9LViFxBGMlZDo7t/6iNHzftc=;
        b=X+CE/81DqvAYOE3aX0a/D3h45BkcT46NjzdJAPOmiEJXi9eSitepkIe0uojeW8VBgi
         Evqmsg6DqiKykUlyn6ndWV3bhUm1sw3pAhSdQfd3UfkCWf2+TSgwpHb3tl9HbL0bkfLz
         T/4n9Q8Kl2dbkjHEqwM6jfh0z4u/3sSpN4A+IzN6JV7uT2soA5g/idD/hjaWYI+oaOjX
         Kfpowe+eTAKLlToIdBEFTW6l4pYK5uS+2gIjV7h4ipSl8DdJwDWgoCB9GULLVqJ/RxAb
         TqmIa39219UQJdJfjlLN53b4RnYl4fYxui2eix9R4Tf4642lvXwK6VXJMA5o4RkrzOH4
         bt3w==
X-Gm-Message-State: AOJu0YyeEyWOQFfY1XZTWugikDg5zG1a6ecJPLypLd6RkEA/eu/P9dXL
	DbblsxR+aylKx6MbOQraYj+CZKvTEDXXNlGMCM6tg1sGMPKbFOtdk4tVZyLKyBfoS/MM7z2ZR0C
	Y
X-Google-Smtp-Source: AGHT+IEuQyD4SKKoKVEDZvlYhjYSWmttZgybo39fMUTtjUJWJG+L3dPUeYO4JsgOPM0F+n2pBhcgxw==
X-Received: by 2002:a05:622a:548:b0:432:b95c:8cd9 with SMTP id m8-20020a05622a054800b00432b95c8cd9mr652511qtx.32.1713387672674;
        Wed, 17 Apr 2024 14:01:12 -0700 (PDT)
Received: from localhost ([76.182.20.124])
        by smtp.gmail.com with ESMTPSA id m6-20020ac807c6000000b00434fd7d6d00sm9434qth.2.2024.04.17.14.01.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Apr 2024 14:01:11 -0700 (PDT)
Date: Wed, 17 Apr 2024 17:01:10 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: fdmanana@kernel.org
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: initialize delayed inodes xarray without
 GFP_ATOMIC
Message-ID: <20240417210110.GA2250277@perftesting>
References: <b1eaf444091755ac133e26f44fb2836bb5280132.1713367002.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b1eaf444091755ac133e26f44fb2836bb5280132.1713367002.git.fdmanana@suse.com>

On Wed, Apr 17, 2024 at 04:18:12PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> There's no need to initialize the delayed inodes xarray with a GFP_ATOMIC
> flag because that actually does nothing on the xarray operations. That was
> needed for radix trees (before their internals were updated to use xarray)
> but for xarrays the allocation flags are passed as the last argument to
> xa_store() (which we are using correctly).
> 
> So initialize the delayed inodes xarray with a simple xa_init().
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef

