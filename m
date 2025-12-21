Return-Path: <linux-btrfs+bounces-19946-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A1C8CD4245
	for <lists+linux-btrfs@lfdr.de>; Sun, 21 Dec 2025 16:40:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CA3C7300CBAF
	for <lists+linux-btrfs@lfdr.de>; Sun, 21 Dec 2025 15:40:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16CBA2F99BD;
	Sun, 21 Dec 2025 15:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fttG2Je7";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="XM/GWV4t"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9521F2FE071
	for <linux-btrfs@vger.kernel.org>; Sun, 21 Dec 2025 15:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766331604; cv=none; b=qDIAmGCVsXrQ7eH/qMjae1JsGa2R1l9jV7l4XpTJakvDSZMYX+r7gRfDDmUBlMyIjwqdevzYttiqs/eGuXHhoV0fOjwc9R1CpmQ8IexLPAyjywjZ2029ZT99wLKawkIvGc2QfvvlIztG5t5uycAlsntF2zQMZw39MPV6rwPce7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766331604; c=relaxed/simple;
	bh=mnZjXNK0u+HP/XUiaDYnE60D1RSlqmCcOGyEHMy6J80=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OYE7KsDIo+kEgiME61oaCiV1yHB5CLFH3134r7fUzFB8/v0/l28rHjlAgpN2u1ZXo5wKUl1G5BNdKcuRT47mWPISnFPzMIk+8wOE6nAlDrmOmkWVGRyDvmvTFiYP1b3v0XpIjgS8NqXIUnwcx/D/N/2sfmOx0w1XPRV9+aC9W8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fttG2Je7; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=XM/GWV4t; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766331601;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+KE66w4YWw6ndgVPN9WJoeENuvGjofTuSeoIQ9xGNDM=;
	b=fttG2Je7tdPOfLijYFhXFq3PE3AKCw6AQNJoJS1mI71qQq+TxQDEPYBBt6SS1Dp57w5qD7
	UYCri/YFtUkTv2MRs6daOTYs5v2OUv8HvFYCcr7jN0dEfgATrZwVtAhZ4MNRg0LCX20bjY
	xUoPIgUQDJrr+9L+UnTYemEK8FkcUxw=
Received: from mail-yx1-f71.google.com (mail-yx1-f71.google.com
 [74.125.224.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-288-oQ5rSrGmNaapmWOjpbtduQ-1; Sun, 21 Dec 2025 10:39:59 -0500
X-MC-Unique: oQ5rSrGmNaapmWOjpbtduQ-1
X-Mimecast-MFC-AGG-ID: oQ5rSrGmNaapmWOjpbtduQ_1766331599
Received: by mail-yx1-f71.google.com with SMTP id 956f58d0204a3-63e0c5c5faeso4239762d50.0
        for <linux-btrfs@vger.kernel.org>; Sun, 21 Dec 2025 07:39:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1766331599; x=1766936399; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+KE66w4YWw6ndgVPN9WJoeENuvGjofTuSeoIQ9xGNDM=;
        b=XM/GWV4t5bhW/CXc1eTGegsHWhcSygiHGujZphzwTqn5/6LDn4ODMGWBYqzamq5ksp
         vC3eM6pul+UOVPqUTrkprLC8tf9JkXHTl7Kdn3U1GBr6YzfjaZfniBfGrZWa/k0vHVrF
         uN54aE+u+CAKKRVzWMPs692lPFF9Q6IMJ/LfE0fUhlo5vMqLo4/WPVwe/7QgKcIBTwE5
         ocq07T0xOWTLN4Zj90RAMWllVGvDaVmUEKQ5FPnjZ8bL3kEVaVlG5kj/3Bhu+tuooAMr
         wnKx5Flea13rb/gex/sDWE2cTe1ndirBUbbjZB3V4niqLfmun25MAvNuJyxvlHOTXozO
         4rcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766331599; x=1766936399;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+KE66w4YWw6ndgVPN9WJoeENuvGjofTuSeoIQ9xGNDM=;
        b=HQp7L4GchjqxWvFYJ+2+LK7UtP+bezt+esgvdMCxo5Av02IxR8+Zt0nKzdkA3vWYSn
         bNEvixcja6t0ouhKIt6lEANF87QLESC5fb7VWF4YEQBkEmjAePgKpuoiJL07vnwF2gPe
         ogVjUYs/Syd3FQI8FtOQ3UpghjRWQX9ahhEZRsx3FOt/oBE5LwMJB5+LMoVqBZyYKMW8
         b/Zb1kXmK4l/CBMSAzB/QBxtFzSjsuDTCBHIbNYLQwHdBporX4+9B5xkWLBm5vRExjTf
         H6ZDA+JRpr0eYTJk3CPu1BEcuOaG02K6gXV0r7ArDYtsQ+y+EabXBA+2ZKMPie0sbLCh
         dVjw==
X-Forwarded-Encrypted: i=1; AJvYcCVduC2yQA0S1wOdKTOATqiPKHFI7y4/MGcMvf6f7BBt3+iprgNOJXetuqmwe/48nZgxb7cVROZDZPNXEw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwTdQHF/yOW2aHLaRp0lOU4bEHCyhYKyCvVoc+mGZ490hGwJSd0
	VpYSQBNYdHF8fyntSo5vbSRyBSYLrKXlpc1Ske0b2F7JyY2U6vUc8FE4R2S+XhBuzbv5AyV49FW
	QkIvQSOGcdL5FSUCdA04UjXVIEty/X4Wg0IGphky+HWxbN6VvpQNMGk0QaedwUc8CA5gMNXaMgB
	f0HmU+EdV3h/RpJj/aKem9fJ1hnQXM1bzWcW87hwZ8whTtMt+5HA==
X-Gm-Gg: AY/fxX5xCF1IWvY2UWr6uY+GoLAyYFRbSvFg+xdkMZfekpl0uAVHrxICrgaov0eH5Zl
	bEKviIRIAbM2/16QshHUji5BTNuivlU+a72lU3Fk9DBug9IKetgJoQM8OfKIQplzyL25QDTN5qL
	g67avlEMU5WNMblg4y0WSjm4vhZXCqtAxGD8EMeD57GnoF+C9r66aHuSDvFpYZj7to6pz98EzeO
	GrBzp5mNscHxnh3eQNFxHsFZ7tHegbn1BRwLEwr4YLopG/pCWs6PQ==
X-Received: by 2002:a05:690e:1284:b0:644:60d9:866c with SMTP id 956f58d0204a3-6466a92dc91mr6656839d50.93.1766331599149;
        Sun, 21 Dec 2025 07:39:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFC7mRAlf3U3160pFy0QO4PEVMCEcrUcemZaiGKUncjGrA9BOh5VcTiZvbH4/xJJSP0FWrca5aMSKuDJG3O3Q8=
X-Received: by 2002:a05:690e:1284:b0:644:60d9:866c with SMTP id
 956f58d0204a3-6466a92dc91mr6656830d50.93.1766331598821; Sun, 21 Dec 2025
 07:39:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251221025233.87087-1-agruenba@redhat.com> <20251221025233.87087-2-agruenba@redhat.com>
In-Reply-To: <20251221025233.87087-2-agruenba@redhat.com>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Sun, 21 Dec 2025 16:39:47 +0100
X-Gm-Features: AQt7F2o4CmeFGTIojqbpS0PVmjVAd-d4HUDEVdSFp54dsbxM3ZckXV6-nNPzQZs
Message-ID: <CAHc6FU6vAokT9ugX1DA8iQLbeu7=Eixr9bq6z0o77_Nq+PyXvw@mail.gmail.com>
Subject: Re: [RFC v2 01/17] xfs: don't clobber bi_status in xfs_zone_alloc_and_submit
To: Christoph Hellwig <hch@infradead.org>, Jens Axboe <axboe@kernel.dk>, Chris Mason <clm@fb.com>, 
	David Sterba <dsterba@suse.com>
Cc: linux-block@vger.kernel.org, linux-btrfs@vger.kernel.org, 
	linux-raid@vger.kernel.org, dm-devel@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 21, 2025 at 3:52=E2=80=AFAM Andreas Gruenbacher <agruenba@redha=
t.com> wrote:
> Function xfs_zone_alloc_and_submit() sets bio->bi_status and then it
> calls bio_io_error(), which overwrites that value again.  Fix that by
> completing the bio separately after setting bio->bi_status.

By the way, this bug makes me wonder if we shouldn't just get rid of
bio_io_error() in favour of bio_endio_status(bio, BLK_STS_IOERR). The
latter would be a lot more obvious.

Andreas

> Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
> ---
>  fs/xfs/xfs_zone_alloc.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/fs/xfs/xfs_zone_alloc.c b/fs/xfs/xfs_zone_alloc.c
> index ef7a931ebde5..bd6f3ef095cb 100644
> --- a/fs/xfs/xfs_zone_alloc.c
> +++ b/fs/xfs/xfs_zone_alloc.c
> @@ -897,6 +897,9 @@ xfs_zone_alloc_and_submit(
>
>  out_split_error:
>         ioend->io_bio.bi_status =3D errno_to_blk_status(PTR_ERR(split));
> +       bio_endio(&ioend->io_bio);
> +       return;
> +
>  out_error:
>         bio_io_error(&ioend->io_bio);
>  }
> --
> 2.52.0
>


