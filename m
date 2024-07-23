Return-Path: <linux-btrfs+bounces-6660-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CBD093A3D5
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Jul 2024 17:40:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C67251F24454
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Jul 2024 15:40:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 861D015746B;
	Tue, 23 Jul 2024 15:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="SbVxl3U8"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93E6B156F2B
	for <linux-btrfs@vger.kernel.org>; Tue, 23 Jul 2024 15:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721749235; cv=none; b=Py9+l8mgK7jMX6IqKy2ET9roeYVyOSrsIIdR6D2DBu94xdMdfAZj+LTXvACvk4OJ7p3t6ucUfb4zpG7MJa4kvl7liN4oF/KLAWYhhwAjKSQVkOueg8viJWgRe0f5uMiva/nX+8IoA4CpIb/A+UvmnFMiqMsypkGO+ceOjaE4wKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721749235; c=relaxed/simple;
	bh=gr7Vnm6flU1UqLmjyLke1EedKp665F/hv6Az5XRE0vY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L755CISLiN7A6uDQubYbUDU/XghoMzFYhwcTX2Kpjn6vmI24cdrek9ZAwd1YXO5n0lwunoFs0QDyre+ZLYqU4HTQbOzC0OJGKx3X+SL6ptGKt1+b2DZUjcmz6VViqvhuvI2ggw3qYTvJhKaqGVQXXBrOHb1U4uadGcYFxT2B9u0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=SbVxl3U8; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-79f1be45ca8so331292085a.3
        for <linux-btrfs@vger.kernel.org>; Tue, 23 Jul 2024 08:40:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1721749232; x=1722354032; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=20QqK1TyZ5iUdfW9GVF202TTO8+a1Qf5YVbYAJ8KHak=;
        b=SbVxl3U8sWGAUCotVDSMI4I5U08rKBSaNcGfrJeS7o6LZ1h+fxcJD7k0gACckus/m0
         66szPJfTZ+KxhO+O/UR2LBtE7AMu5K25UbhrLspcshINSf42g3Cy8uHZmnSADpH4UijZ
         uSCTg18sql7cL70vpJ5rkdSTJu5B55yWb2rGRCCD9Ymh5svQhHXqLS2CMSWpbGDirOnC
         xoTc0z5DFZ5Q5xYRycCAZ85Utz3+eMOOt8dXPx474ZuydztNWsQNaGTUE2Omgfb7lvUq
         zjJtgZ585EHsyECOEVXcfAUvHFZzeZxx6w3KGYld8w6L0zXKC0QI36DICMwixzg0pVc/
         odoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721749232; x=1722354032;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=20QqK1TyZ5iUdfW9GVF202TTO8+a1Qf5YVbYAJ8KHak=;
        b=q4Yl5WQnerD/wyfZMVi6agxm/9JaszBIlMDnkEo+c+zVdktMTV0KKxJR1P8A7JmsXO
         DsGODAcAvVI+iu8iR8JOmVa2YpWfRe8mHLNRJXZqqgmiw8IqjngDvHE5r8AWbAnTuxAC
         LgWEi0u/472JHfEUfWrMq8iUsDv6BVQuU+pY2ed/urV3NjWmJPC0w8nJG9VlwMIqwH9n
         1uVEL0r9gkvzAvE7TISzyWwiTL5eEFFQ3DipSTSH+o+uqAz1KWrGkPFui/tevooYyv1f
         csowKEnrgIuHDf7G6RXMsVTx/bBMUo6IoBG1FNM0hkmatGnI42DFSxy+NhKBboQ02h9I
         ALwg==
X-Gm-Message-State: AOJu0YwYA7O24yvfE5JSge6IPz70HtHCoCKEsCQH32mX1AWsINH3tn8A
	ICPblbP1Ayorv4XC8tyQUkX3rweOxp/WrTFKmiXUjwT/vCjtpkoUWKJRIHxHgZ09H2ZjeERuNaa
	9
X-Google-Smtp-Source: AGHT+IFYu+q/DPGC1eVjL9MuxlxpWUCe82lnHbOn1z+hwl8hiOphP1ztE1yu9PV6TmGfAuSfAvSf6A==
X-Received: by 2002:a05:620a:319e:b0:79f:17db:6597 with SMTP id af79cd13be357-7a1a654ff49mr1241460085a.43.1721749232357;
        Tue, 23 Jul 2024 08:40:32 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a198fba3c4sm492661685a.35.2024.07.23.08.40.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jul 2024 08:40:31 -0700 (PDT)
Date: Tue, 23 Jul 2024 11:40:30 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: fdmanana@kernel.org
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: reduce size and overhead of extent_map_block_end()
Message-ID: <20240723154030.GA2414183@perftesting>
References: <9003408d1f29de77deef59c6ed6e5bf1d98b91ab.1721746528.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9003408d1f29de77deef59c6ed6e5bf1d98b91ab.1721746528.git.fdmanana@suse.com>

On Tue, Jul 23, 2024 at 04:16:03PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> At extent_map_block_end() we are calling the inline functions
> extent_map_block_start() and extent_map_block_len() multiple times, which
> results in expanding their code multiple times, increasing the compiled
> code size and repeating the computations those functions do.
> 
> Improve this by caching their results in local variables.
> 
> The size of the module before this change:
> 
>    $ size fs/btrfs/btrfs.ko
>       text	   data	    bss	    dec	    hex	filename
>    1755770	 163800	  16920	1936490	 1d8c6a	fs/btrfs/btrfs.ko
> 
> And after this change:
> 
>    $ size fs/btrfs/btrfs.ko
>       text	   data	    bss	    dec	    hex	filename
>    1755656	 163800	  16920	1936376	 1d8bf8	fs/btrfs/btrfs.ko
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> ---

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef

