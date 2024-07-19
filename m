Return-Path: <linux-btrfs+bounces-6618-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C0D6937D4A
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Jul 2024 22:32:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 702151C20C75
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Jul 2024 20:32:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAAB0147C82;
	Fri, 19 Jul 2024 20:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="qISdTdSA"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86DBB2BB05
	for <linux-btrfs@vger.kernel.org>; Fri, 19 Jul 2024 20:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721421128; cv=none; b=cr8ipyQsmbn+ne3BlHG6DdXzeUJIMIPhiZoTqpPbtLjVtN/70QT6bnykQ5EwKh7a6JuvoPJTErn3h2QHpW/NoH/8IQhnyCEK8Q5BcX/XKe4UCXqlT6CUqDONX/Lyv7M5IyRh/va4r2dvNJIX4BwIMWaI77m6tCAKtu0mfexKvyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721421128; c=relaxed/simple;
	bh=zLtYwLb3CiDIdyfr0MFu8nFxAnBM6NLOaAEGVyK3tT4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZPEsEWfig8RxL7T1GZpugz3LvZL/UmSLF/3HzawOpThWHv+7ZW3td6y/f1FGLobIGx6OZ7A5k7Ori7LPz1ovBGL2s3HoRG3JQSk8CJ7vBOOufVhVDp1G8WDzKOQK1Ulp1NiPKc5qZ4xieHfPy9GPrMTrNPAn2KyASUH7FRKiapI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=qISdTdSA; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3d9e13ef9aaso1347380b6e.1
        for <linux-btrfs@vger.kernel.org>; Fri, 19 Jul 2024 13:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1721421125; x=1722025925; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tZ7DFdBLGJ71rRfa4pAAhMlzo3hFxB0IoEEatIdlhcw=;
        b=qISdTdSAWIa5IjrklIdsyidAhzAccXtDv3o9/HlJt819/Uouov62n80J8xmmdBG8gD
         mXv11xxo6TnyvF7yRbd5yh3i6DBQ22hh+Zjlu+kBnm3dDjfNYyUo58KWkN0ifIjl+4SF
         oY4+QH4xK6iZFAVChFKzxsqDx3y+a2ksqPgaazb3e1ceQnRIHu5YDic8Ri6j5vqxK8Ha
         9iORwddhCMM2J69qzgjMu1OeDV+05hFKewr+JdqdWr1k4WWUVNyJEdMU6yOGb5G5drpT
         /OJMgqJhyzsXta9B23kow3el3N0mVIxXkivfv/vO1eHQI8PVEiWuinxg2FAbdsIDP80v
         XgXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721421125; x=1722025925;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tZ7DFdBLGJ71rRfa4pAAhMlzo3hFxB0IoEEatIdlhcw=;
        b=gGlj00GWC6+xPQvYmRrgT6PeSF4QkVheYNikf57P9RC6TZccVNThCFyCpNAyujZ7Xw
         zHI1C6mukBf1KzL+xxayzQOZHeJ80Tha+cj0ncM9nrr6cgbmYiXX4cUHeWGdhFFTRWyP
         5ir7pQVNSwcfgqn+H7RxyCo23/dAol/fqZU9fwIEwY7Rc6iz5TF9mV4WgFu8ARLKleug
         tGsIP3XjFuDMlB41ivHlYQ82QjbG9Ww2wNBDX/533vTqj+w4dD3bdhRj5ZqT0gCaowhF
         8yby7bk8mX7ka3nrsZSiL1/J/HgHzNAPV0KcvbpKAW5EVd6yJhufTHUM8Y71+iHLbRm0
         zRHg==
X-Gm-Message-State: AOJu0YyoiMDdm/+IZsiOvYsxt8nI4oavjD/WE4+9JNuTUymBG5vpoX4w
	HeHCLsuzUALug+ZldUp2ighcTJfr1M5O0frI7dtf0OEEVo06Lew7W8pdd9qs4+7mX+iAfuj8NDM
	H
X-Google-Smtp-Source: AGHT+IEpXRD3YJa6ocfjyVFPhfTbTfzFAnOTqfWULOrMpnIhJcHq61N7KQp58L6ioLP+CsPalhxeCg==
X-Received: by 2002:a05:6808:3099:b0:3d9:33e9:e339 with SMTP id 5614622812f47-3dad1f11f2fmr10443784b6e.9.1721421125561;
        Fri, 19 Jul 2024 13:32:05 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-44f9cd351a3sm11468301cf.53.2024.07.19.13.32.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jul 2024 13:32:05 -0700 (PDT)
Date: Fri, 19 Jul 2024 16:32:04 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: Mark Harmstone <maharmstone@fb.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs-progs: simplify mkfs_main cleanup
Message-ID: <20240719203204.GC2312632@perftesting>
References: <20240719154649.4127040-1-maharmstone@fb.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240719154649.4127040-1-maharmstone@fb.com>

On Fri, Jul 19, 2024 at 04:46:43PM +0100, Mark Harmstone wrote:
> mkfs_main is a main-like function, meaning that return and exit are
> equivalent. Deduplicate code by adding a new out2 label.
> 
> Signed-off-by: Mark Harmstone <maharmstone@fb.com>
> ---
>  mkfs/main.c | 14 +++++---------
>  1 file changed, 5 insertions(+), 9 deletions(-)
> 
> diff --git a/mkfs/main.c b/mkfs/main.c
> index a69aa24b..5705acb6 100644
> --- a/mkfs/main.c
> +++ b/mkfs/main.c
> @@ -1915,6 +1915,8 @@ out:
>  	}
>  
>  	btrfs_close_all_devices();
> +
> +out2:

Generally we don't like out2/out3 things, that makes it hard to figure out what
is going on, I'd rather it be like out_free.

However all error is doing here now is setting ret = 1 and going to out2.  At
this point you should just make sure ret is set in the places that call 'goto
error' and then move error to where out2 is.

If you're looking for even better cleanup semantics, I would do something like
the following

#define __free(func) __attribute__((cleanup(func)))

static inline void freep(void *ptr)
{
        void *real_ptr = *(void **)ptr;
        if (real_ptr == NULL)
                return;
        free(real_ptr);
}

to one of our common utils headers, and then do

pthread_t *t_prepare __free(freep) = NULL;
struct prepare_device_progress *prepare_ctx __free(freep) = NULL;
char *label __free(freep) = NULL;
char *source_dir __free(freep) = NULL;

and then you don't have to worry about the free stuff, and then you just have
the close part.

If you wanted to be even fancier you could also change how prepare_ctx is
allocated, so it has the number of devices in itself, and then the array of the
fd's, and you could add a custom cleanup function for that which would close all
the fd's and then free the memory.

But at the very least the out2 thing needs to be addressed.  The rest of these
thoughts are possible cleanup options that could be explored later.  Thanks,

Josef

