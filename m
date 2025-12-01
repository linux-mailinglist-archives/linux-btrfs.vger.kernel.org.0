Return-Path: <linux-btrfs+bounces-19434-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CEFBC97CA8
	for <lists+linux-btrfs@lfdr.de>; Mon, 01 Dec 2025 15:13:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 604953A3CCE
	for <lists+linux-btrfs@lfdr.de>; Mon,  1 Dec 2025 14:13:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC9D531B817;
	Mon,  1 Dec 2025 14:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lucidpixels.com header.i=@lucidpixels.com header.b="gNalMFU2"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3C0B31770E
	for <linux-btrfs@vger.kernel.org>; Mon,  1 Dec 2025 14:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764598395; cv=none; b=DdGLbspFOJPJ4EaVQ+2GBiZMJUvBBNZ/iyeTAq2pcakz9SAeCHXP/0TZq7QWWQnKzd+76DOjyAuIH9fb18sK2OuJlXYUVlsftsS0cso/lFvpOE+oHWyxD+ew0NfU3wbu0gnex7Ac0lTMqJ71KiKZhEfHfOLaVhhdVRtsMmo8zR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764598395; c=relaxed/simple;
	bh=CRXxibKS5o3QXS3SaBQ2sZAVP47i3yD1ZCTFJscAjgI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YD6Lraso8HpAtpc01ye1ypIW6mONd984ILrYLXriudQs6v/xIHLKcgUwK9u/61SjjHoYUxqr/OqcdRybcayOVrgiws6jC3ol+9R4vA6QSe8EA92lI+UD5Jf5sXW0npt9L2czm1ol03bWMNI5hvn+oxIMuyqCbEKVzGhBUizIMIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lucidpixels.com; spf=pass smtp.mailfrom=lucidpixels.com; dkim=pass (1024-bit key) header.d=lucidpixels.com header.i=@lucidpixels.com header.b=gNalMFU2; arc=none smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lucidpixels.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lucidpixels.com
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-657230e45e8so1767855eaf.1
        for <linux-btrfs@vger.kernel.org>; Mon, 01 Dec 2025 06:13:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lucidpixels.com; s=google; t=1764598393; x=1765203193; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1Ht3XFr7/7WOcNzTNEuT0DuzzCseuuyaUOrQvdMSUmw=;
        b=gNalMFU2qL6eRv1t25i/kxuxAXVu7Tkx0sZT22nI0ZP8+UopokH7d7X9fybriPlmIk
         e/eH8a4rQJlJqIuXLJwEL9w/Y3KH3UTxWmBi3ak8H3x/V5hj76pKMCpDYIZmOnDxFmor
         3P7yWORdIGtzZw+HvEOGSRvbx7mEkWvA7S9p4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764598393; x=1765203193;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1Ht3XFr7/7WOcNzTNEuT0DuzzCseuuyaUOrQvdMSUmw=;
        b=s5klVBkyRkhf4LXxZCDyqUYYckHYTlnuu/Az74r9ykp4pLAi/dlpKOwBt8GWeEKV3G
         pozrCcGb/2sYLX8wyJzarRFsQnJhmXThCUvJ1ds9TaYKjHO+GDtWwbhei8waClcnGoU+
         T4DJs0iSkZqvQ6BolMTc2c7yt17bKCod8Kj9//d9Ca+XYD9fgkQZ5cebj2YLTAfb6yae
         TERsxFdsFrTMU/iE2TWWOYYrwpod0XyVmfDxwvwZg0I13o4L3fxZlbWHqZVTLj0bvVwb
         ARUDQsgyL9LHYMG/0j8ZyUq7pCDGQvZsL8HXTIOG8tUFboGN2PQKypwwH5ARLLeVcpvh
         mE8Q==
X-Forwarded-Encrypted: i=1; AJvYcCWm3br7AwjEFyDgFTmDmISjYqnhVFKKf3h9BbLT3V+X3k1ANTrvWmXz4VXOLQYj1zWuvyFgazbjWD1UbQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzcqWf4Vv8IFsk0ZXJ416t58Bj1S73YiB2BDFiyO55YFUEvxBEv
	yBSot+CyevNM1GG0jN5Ypu2M1Tc5kZPcsMcPzc2f5vHh64q3BF+OMKk+d+3Yn+KLzpesP6dCF53
	Q6kMgclC9rhuDX+ANCRn3A0iumj2g9wb880bqiQz6bKuxXr8HISnn
X-Gm-Gg: ASbGncsovQTfJ6QKt01VgbFaUSkZIVl1W3OIsi8grhfoRi/Y1ZwpYSZPElvEqh+/fS9
	OROnWLHMqQpMmFz3Wq/GsRiB8q/ps/uh84h82ujjHSaEoljIw+fnGWj4vcFeqO71lgDOSvDWyXv
	Md4HVpcQRllXYueTBvfLDSXfVLUiqFiXtB5V2wVcipcUSPg+kpEB9Z53wcropLbDgo12LXR/Ar4
	8AUiM9d1JbvcVBi0aoFtG+sAjh6/RRTBkR8J8aIOqGrDIQvhw/pTKMyKS6bVgnFwXX8qaHEKGYR
	acLZNqtFCNWZrzMhu+pccLUmad99hGW2M+IkVxZO1COqr388tYltl/nCBGjxygg=
X-Google-Smtp-Source: AGHT+IHBbgc8lB9i54rXSqzF6P8AJv0GIEgsiuXhi6WtMVciJYCjym2BMgYs+T9pSsyV1Wq14+HPqiEfCQEl0yeRACc=
X-Received: by 2002:a05:6820:1524:b0:657:432e:a820 with SMTP id
 006d021491bc7-65790eb8958mr14276460eaf.1.1764598392784; Mon, 01 Dec 2025
 06:13:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAO9zADxCYgQVOD9A1WYoS4JcLgvsNtGGr4xEZm9CMFHXsTV8ww@mail.gmail.com>
 <aSXDnfU_K0YxE07f@kbusch-mbp>
In-Reply-To: <aSXDnfU_K0YxE07f@kbusch-mbp>
From: Justin Piszcz <jpiszcz@lucidpixels.com>
Date: Mon, 1 Dec 2025 09:13:01 -0500
X-Gm-Features: AWmQ_bk3d93SsGZafRPWCihS1bzPTNFEpmuf6SICcoksQ9XfTkFEcuzxLZZu8X0
Message-ID: <CAO9zADzUZYzM=xkvHPXepQP_+6V0f4__yroPNV6feyPB27Ju=Q@mail.gmail.com>
Subject: Re: WD Red SN700 4000GB, F/W: 11C120WD (Device not ready; aborting
 reset, CSTS=0x1)
To: Keith Busch <kbusch@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-nvme@lists.infradead.org, 
	linux-raid@vger.kernel.org, Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 25, 2025 at 9:56=E2=80=AFAM Keith Busch <kbusch@kernel.org> wro=
te:
>
> On Tue, Nov 25, 2025 at 09:42:11AM -0500, Justin Piszcz wrote:
> > I am using the latest Asus ADM/OS which uses the 6.6.x kernel:
>
> It may be a long shot, but there is an update in 6.17 that attempts to
> restart the device after a pci function level reset when we detect it's
> stuck in nvme level reset. For some devices, that's sufficient to get it
> operational again, but it doesn't always work.

Nice, I was not aware of this, thanks!  As this issue appears to
affect different consumer-level NVME drives, any efforts to address
the quirks in various NVME drives to restart the device while keeping
the volume intact would be awesome if it is possible to- get that
point in the future.

