Return-Path: <linux-btrfs+bounces-14498-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC4E9ACF4E5
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Jun 2025 19:03:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21C553AD5F4
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Jun 2025 17:03:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B0AE275119;
	Thu,  5 Jun 2025 17:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="inuCChpa"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E203272E66
	for <linux-btrfs@vger.kernel.org>; Thu,  5 Jun 2025 17:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749143012; cv=none; b=dh+a9cK7hrP8Dm6vWeHl/EIXj3PrpoZZbyre+DjafbR3VBDF8PWmZI1hPwR2C4+8IiVW/gw5+TTveC6WOawVgyvuyt8ldqD7S46/p0kvEophP8OXUGGoO0r5f/AqjIspylm2wxMio0iqeIvWMEZJkhmFasAE7Ic6CfuC1fNx1kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749143012; c=relaxed/simple;
	bh=uub5yAAUxua20JUrxMi+jZKpy1Tr98Zf23w32+mTc9k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q2Bg5mVsWOjcFHOSPVO79P9opg5sMrNy3KhQw0VxOWpaJy4euPdN5C/SJ+uxuUrdykfJ4TgjluRYGBXWjHNMol9dCrON7Ipw2t7Q9h89lNp9BTDkqmIzE5PVe2hJvxl6zBp+QdM0PHKMFiuNZpF4GyqKSw4r8asCy0+jDL35Ohg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=inuCChpa; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749143010;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Sjmn9AcgUBT/6b0VbQZa8X06zBbschQpRkWsCTXTpE4=;
	b=inuCChpaSKgqs6fN5UcI59X4fzl5n1pv8+SH23DTSel8o8XAWpxodPkqWV6yWAb1Fy7ZYg
	VCkiSJ8aWEk5gOIwZJGP54MtipQ2KJTyGzKQ4a0EVpSTjZunM1fBSxn7l9ryaD/8Oe3yPp
	QdLm4AKCtkT/hKr39B2CNlDJ1rUIrho=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-158-Q4Oy6YuHNU6CAxm1A92y6A-1; Thu, 05 Jun 2025 13:03:27 -0400
X-MC-Unique: Q4Oy6YuHNU6CAxm1A92y6A-1
X-Mimecast-MFC-AGG-ID: Q4Oy6YuHNU6CAxm1A92y6A_1749143007
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-b2ede156ec4so1391903a12.0
        for <linux-btrfs@vger.kernel.org>; Thu, 05 Jun 2025 10:03:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749143006; x=1749747806;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sjmn9AcgUBT/6b0VbQZa8X06zBbschQpRkWsCTXTpE4=;
        b=CqXmRniPJbfdJMzolnlY8Xxa7qFCx55PRxLFXPHr1zZQGh4EWhLFJdANgv9fBM6t0P
         /W+FP7mqvGq8pzuUS3PHfRjrgBmZyZuLc8yGlcFw7riqGRO+SyENJBXoJdFB0tyuD5vh
         1IR/wE/rir1o+UNLjVCpPT+9mlrk/FwybwSybx4HKLo1D/aVwjn09sow/S1Cmn5kxOWS
         Qi12ssN5XL5rpstVZMZUFvaIh12AMA1EuUxBVS8jmSsdGVDSmCMT3Vjfpd0NtUCAShuI
         dL3kbne/KQTpVCOf6H+QbsS9Xml2qy9LVRKirSOYhkVqiEKojNP7gw7OpXJ6KNPsCGSQ
         IN+g==
X-Forwarded-Encrypted: i=1; AJvYcCUTg0/jBiQyV2BB9q1Wa5jeTm4/LnXvSZlGJojFTQF2uv2YHLOgToRsohJ/DMmU+PXJHmEdwueXv7QEBQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyr3cdeDA5Ql1L9nDRjTtdiUtom6W+Wp7Et+hMy+R49ZSRDOIRU
	TrVdEyEIVTOaXlPrgfXCc0wuIlhiR5mM9z42aO7bkDJ9l1Nx1n9gD18FS8shZrNGNSFWIVk9rIQ
	vTnlm6dSa5pzEpmhCuHu62wppTE+IYyNrlveAJfvFtPii4i7wurfFrqcRao6KYmyv
X-Gm-Gg: ASbGncsxCfD4SGyt8G0JR91zESwn6EdN7o+MhEZV0ykdP1cVNpeFYMFEO3eH9fWJm2z
	vSke8QGfkUQAUPF5k1aKo35Hd6buC5tRVk5IazHcpSISZnT4AzN7mZw7f7/n+DHrPoRm+TtlVPM
	lbf0a07RiihCE3bkW/RGx/rEDr6xJsXIoIkPpADeBURONEJorLXLeurRjhCYL/Lfwet/G7Y7Ijf
	bUjikfR4hwKlhZXGLu0FelQC3IiAA2Uu9dwJRWskAwH5sbTqfbaix8WOwR+mmQrPGcl+LDvyqzx
	7nMzxf0JHVUClyWgHyIWgQwXBZ6rB8DeGandhd0o6iwrhQgkw11g
X-Received: by 2002:a05:6a20:7484:b0:201:b65:81ab with SMTP id adf61e73a8af0-21d22bb59f7mr11309821637.23.1749143006520;
        Thu, 05 Jun 2025 10:03:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFEHSR5XCjojLivT4QhhlMa+stNM64sElBlP0EwbjudYFFqwstpJBrLf5TyjQ8nmuYMkB35jg==
X-Received: by 2002:a05:6a20:7484:b0:201:b65:81ab with SMTP id adf61e73a8af0-21d22bb59f7mr11309798637.23.1749143006196;
        Thu, 05 Jun 2025 10:03:26 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-747affafa42sm13460251b3a.92.2025.06.05.10.03.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jun 2025 10:03:25 -0700 (PDT)
Date: Fri, 6 Jun 2025 01:03:22 +0800
From: Zorro Lang <zlang@redhat.com>
To: fdmanana@kernel.org
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
	Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH] fsstress: print syncfs() return value in verbose mode
Message-ID: <20250605170322.a2dforp6mfxypwgu@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <ef67a4bf8d93109a0493155252c9a3c903478388.1748020773.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ef67a4bf8d93109a0493155252c9a3c903478388.1748020773.git.fdmanana@suse.com>

On Fri, May 23, 2025 at 06:20:50PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> We aren't logging the syncfs() return value in case we are running in
> verbose mode, which is useful and it would help me immediately figuring
> out it was failing in a problem I was debugging with btrfs.
> 
> So log its return value, just like we do for every other fsstress command.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> ---
>  ltp/fsstress.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/ltp/fsstress.c b/ltp/fsstress.c
> index ed9d5fa1..8dbfb81f 100644
> --- a/ltp/fsstress.c
> +++ b/ltp/fsstress.c
> @@ -5326,14 +5326,15 @@ void
>  sync_f(opnum_t opno, long r)
>  {
>  	int	fd;
> +	int	e;
>  
>  	fd = open(homedir, O_RDONLY|O_DIRECTORY);
>  	if (fd < 0)
>  		goto use_sync;
> -	syncfs(fd);
> +	e = syncfs(fd) < 0 ? errno : 0;
>  	close(fd);
>  	if (verbose)
> -		printf("%d/%lld: syncfs\n", procid, opno);
> +		printf("%d/%lld: syncfs %d\n", procid, opno, e);

OK, no objection from me,

Reviewed-by: Zorro Lang <zlang@redhat.com>

>  	return;
>  
>  use_sync:
> -- 
> 2.47.2
> 
> 


