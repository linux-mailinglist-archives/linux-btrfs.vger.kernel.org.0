Return-Path: <linux-btrfs+bounces-19558-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 63339CAC7D8
	for <lists+linux-btrfs@lfdr.de>; Mon, 08 Dec 2025 09:24:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8D04D3032708
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Dec 2025 08:24:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F9BA2D8379;
	Mon,  8 Dec 2025 08:24:24 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19D092459C9
	for <linux-btrfs@vger.kernel.org>; Mon,  8 Dec 2025 08:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765182263; cv=none; b=T0jOOHfv+0N/IJ2KDTbkhaqYBX4TTQPwF5YPAETNNIoYHaBUS8K8pMeBtH3VNAX6LFg/CJkWyYU4PUq+avFttDuMKHhN5azNUCA+VbMBfHBv+UT4JhdKI36SkMGiD/lhU3Vx1ccZNOwOl0ZnUwhuOxtTK86qME/nWWVGujXXZ3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765182263; c=relaxed/simple;
	bh=sYVG81Yc/kijPXyx1VLzjW+amc2ZlDOqTdKjEg4w0UI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Hz1/hrDerb03pwJDG+S2wjywRIZ7sX1JK2kkNYj1Tp+AQ76N65s/UOPq+Pj2ZEVSx2x1C79kriXazUzeCRaXbthWNHkJFM7yhcyYTUP1i0EdXSzkK9cE4q2NkgQQHlfed+pORZCOaIylqhillrGFn6bn5Qwg/WRFyTiHHwa5/cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gompa.dev; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gompa.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-647a44f6dcaso5673689a12.3
        for <linux-btrfs@vger.kernel.org>; Mon, 08 Dec 2025 00:24:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765182260; x=1765787060;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=y+zuDqk7xbXGBGHjEwR7xSIynYrQtmrDcpaC4ys4ia4=;
        b=hx1nL3maRt2fjyKZezIIWr9FyaN85x32DpCWq9ckUcVy3D9yLGTWVXcafS2pVWE1Iw
         j9CHKlagsWTYeS6+/q1fnSXOOoeYbo9BzyPZV/fBi2q6Tzh9OCJiRXn6U9+ITYFR22pE
         7CiMNQ00im8k3Wk7IrtM3lJK9ESha774EOyoKoi3XWEAO6AjnpPQxuath80JuE9N2lrP
         AqhMc/27mTITtiEM7J+asw+Rtfv+NRwlqDI07Lm+Nx3Rwv3cwsvB6xlxMoYbBOqOGzR8
         yp/AguIwW1/GF/sAn8lZFM/Sk2LXFk3RuHeqCJi5hg3lgdYB4KZQU/Upe3oTFoJAkacH
         NsKQ==
X-Gm-Message-State: AOJu0YzbrAN6m1+TTgECEjzkfsJVEfNPKKuer8TlNKSR3n639gIN5ArC
	wy9e6c6WKzkHsyvEB6fvfRZwicHFl1zATYlMx8eHieYFAMy2yjQ3xkLDND2xprGT
X-Gm-Gg: ASbGncuXO3QTmclTXFYik6IN9FJ4yqRueYH3f+Kanfyc2VICrAicYgREKDpmS8aT4Tc
	2P9+rSYqLISYxRnNXLvmRQYg98ssc71lyoEUy8xLCl0WYtJ86bfO7dO1WxFTToireNTj6YBor8r
	XLcgThx6Um+nSm/bfEiEhGebSADj5Am7FZ/Cc+Y7u7vUmcc73BeUJ+0weTT/nwZMEfJSb8vaEvs
	3n9w6/DFEcpnWWNpc6wAHV9lhe9KJdkIc6TzJ97bhGH8tMpbopkoutLc1uljI/L6NtTZyRg6bSk
	SgbV8eOZQk2MVOWe8JLQIVapGfTw+dUln17mCIOvtn+uHWPomAnOR5dGRiwZUWrsIzS3YnRa90P
	JpVWi8qDj0BrjFKEv8i35jm0TmRiF7dnzDa8TTsQREwMpfE3e0MNlJDN0Llh/YbqETJEZsU5kmH
	rrzZ50rrIc1KoQ/WpKNHGn9icJ8Yg9qzUzu6T56UZ9uVJuvG6JldAr1BNlnsiFpi3nEgVia0xE
X-Google-Smtp-Source: AGHT+IFbhMKKqWMsc0gnvc9dlCtG8dCVQOjCP84wPETyf36crU5C2j0V9MbHPF9FjkOJpB9WO9gQNQ==
X-Received: by 2002:a05:6402:50ce:b0:641:8d6b:88cb with SMTP id 4fb4d7f45d1cf-6491a90f889mr6201947a12.28.1765182254908;
        Mon, 08 Dec 2025 00:24:14 -0800 (PST)
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com. [209.85.218.49])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-647b4121f07sm10523388a12.28.2025.12.08.00.24.08
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Dec 2025 00:24:09 -0800 (PST)
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b7697e8b01aso513926266b.2
        for <linux-btrfs@vger.kernel.org>; Mon, 08 Dec 2025 00:24:08 -0800 (PST)
X-Received: by 2002:a17:907:3da9:b0:b76:c498:d40f with SMTP id
 a640c23a62f3a-b7a242cfdf0mr623086166b.4.1765182248817; Mon, 08 Dec 2025
 00:24:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <8490cf1099fa677bc3817257663c7abd85d46f2c.1765141954.git.wqu@suse.com>
In-Reply-To: <8490cf1099fa677bc3817257663c7abd85d46f2c.1765141954.git.wqu@suse.com>
From: Neal Gompa <neal@gompa.dev>
Date: Mon, 8 Dec 2025 03:23:29 -0500
X-Gmail-Original-Message-ID: <CAEg-Je92SvCGRqyipGqP6u5n3Ly=ZtAtQoxvadwruWSM18ModA@mail.gmail.com>
X-Gm-Features: AQt7F2qbD97M4HupQgy0EDyD3juw513oZ23tZJPywvN0TlbhRjjesmzhWS93eXQ
Message-ID: <CAEg-Je92SvCGRqyipGqP6u5n3Ly=ZtAtQoxvadwruWSM18ModA@mail.gmail.com>
Subject: Re: [PATCH] btrfs: enable direct IO for bs > ps cases
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 7, 2025 at 4:14=E2=80=AFPM Qu Wenruo <wqu@suse.com> wrote:
>
> Previously direct IO was disabled if the fs block size is larger than
> the page size, the reasons are:
>
> - Iomap direct IO can split the range ignoring the fs block alignment
>   Which could trigger the bio size check from btrfs_submit_bio().
>
> - The buffer is only ensured to be contiguous in user space memory
>   The underlying physical memory is not ensured to be contiguous, and
>   that can cause problems for the checksum generation/verification and
>   RAID56 handling.
>
> However above problems are solved by the following upstream commits:
>
> - 001397f5ef49 ("iomap: add IOMAP_DIO_FSBLOCK_ALIGNED flag")
>   Which added an extra flag that can be utilized by the fs to ensure
>   the bio submitted by iomap is always aligned to fs block size.
>
> - ec20799064c8 ("btrfs: enable encoded read/write/send for bs > ps cases"=
)
> - 8870dbeedcf9 ("btrfs: raid56: enable bs > ps support")
>   Which makes btrfs to handle bios that are not backed by large folios
>   but still are aligned to fs block size.
>
> With above commits already in upstream, we can enable direct IO support
> for bs > ps cases.
>
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
> This is based on upstream kernel which relies on the commit from iomap
> tree, which is not yet reflected in our for-next tree.
> ---
>  fs/btrfs/direct-io.c | 17 ++---------------
>  1 file changed, 2 insertions(+), 15 deletions(-)
>

This is awesome. :)

Reviewed-by: Neal Gompa <neal@gompa.dev>


--=20
=E7=9C=9F=E5=AE=9F=E3=81=AF=E3=81=84=E3=81=A4=E3=82=82=E4=B8=80=E3=81=A4=EF=
=BC=81/ Always, there's only one truth!

