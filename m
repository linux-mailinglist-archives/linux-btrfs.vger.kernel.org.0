Return-Path: <linux-btrfs+bounces-15018-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 44D0CAEAE9D
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Jun 2025 08:00:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F2D5D7B14A1
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Jun 2025 05:58:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5E611E5702;
	Fri, 27 Jun 2025 06:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c5kElflW"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33B5B1DF27D
	for <linux-btrfs@vger.kernel.org>; Fri, 27 Jun 2025 05:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751004001; cv=none; b=pqUpJSBgww/o64pesRwH90n3cvCP04envlN66hoxN0+/snhCdXLqCfw/x1UCFspjG214YX2m6gKnYVWVtP8fgJvb+rNHP0L15eiXxlaoz9n10Htsb//VYvs30qEZ3QsJuklHtquxSnsLBkdsi8wZraTkhRRz7Tmf3Yq9K8eqmeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751004001; c=relaxed/simple;
	bh=Gfmxm4HGMtRq+3JCdASqJdxdWSv3EODt8AN8pcaLWQI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iFDxixyUknJG9IzhzdBoPz7pF73M0pRsV7czcbY7M6obf3WqSYnF/44V4Bv5LUFeFy1nnUGZv24a7T89UBsKPrRO082FYJ3PY6sSymPFDeCTFKXSeSlo1Mco0gteR6bb5mfI8uRwlnuc6qL6E299cdScGuZz4mpmoWD71o5Qdhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c5kElflW; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-6097b404f58so3019430a12.3
        for <linux-btrfs@vger.kernel.org>; Thu, 26 Jun 2025 22:59:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751003996; x=1751608796; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pIRWLQP/u0re5wz9atRHCgVboiQlukjt7ZbWYafBCK8=;
        b=c5kElflWnJIAfjUdaDvLKCNZkQ24Ujip9pfZPU23X2nG+ZTQbZQthrwA6mF5y0dO5h
         0UeoSzDFYGFlryIsXMQVtfKhizEmEMqUyPYhYtmt8IX47dD/rf2cdepC7ELrISNv44re
         wjJINlWNimCLExnFmGBEWj74CzkUxtvdBKAdNAsRriBZzTP3mofx6Mcezp8QGTuVBuyw
         Nc1oC++LOEvmxBs5o0hAPfm045rqM51Px7iZdGR0aFYF35AkNHsADEhBS7izQNMIyh+q
         dYmAO3hPmn6xIQFYNzpcGAjJhxGXz+U6/MDvQQ8wIzf9rXRi645qjBofZFEs3agcUchS
         vzKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751003996; x=1751608796;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pIRWLQP/u0re5wz9atRHCgVboiQlukjt7ZbWYafBCK8=;
        b=lGg6djrylczq+mae/v1pstYLml9RICoVJH6iEGyjwcVfs+75k/Ie70NM/+gHqp2WI5
         OgGGyNx4zAsURGtzVl8Ztxa62MPBA7/HVBK2Ru/bl6u43MmUBQ1nSpMP/fW2bJhTr44X
         k9skQ/h1re2VelEiHF3BLGpXnRU2VubYrPMPGjjfJaHNHCXdCG96aW3Us+vG3Uxq6sDo
         kHoC785QEmqku/YpeT1BiX0AA4bKLJtU773hhd83xvOB1CE88EZZDEIqfhrsP/0GJTBX
         rRcOCKZxOKbGVsemcE9WwMg6NaM+FLUMCN6pQO/DEsRVpiSINPReuBehesU1dKbaJJ7m
         pKBA==
X-Gm-Message-State: AOJu0Yw8pYWmBhs46cMeu3HzBKd7AmZySUyjwy1Wr6soYi0IwTFYvGHS
	+7JTnwNL+rFH6LCw+A6dw2Akavr71sbw/ioEGNtMu96BHU5cGtoozzTtTzXd236DjTHpjp9NBFc
	D9KvPDH5+36y1IP5x6JKD81Akw2iBPIZbbbju8tC6CYxd
X-Gm-Gg: ASbGnctyoPyHlRK4d7NCvb08OpO3QI+kyU6JyJ/CW8YrsnE2MtIXYJ0zNAUNLLf4rga
	I4FICspggEQ+nUjE4++30a+lbCyaKm/sKpodIFbyuFVnE3iANUF4u13xIfvpz20npqu7vrdmSfq
	3c8PB9G/ew7LiaXZfEqopLPWPUMN6m/NfN6zbtRfGw3Jsa9KjnYDsa0Cvx
X-Google-Smtp-Source: AGHT+IGmPaM3qmAP5K4/jHzBRwGFwDLR5QVJWBYtT4veQEmCSuUHKtVuSm7G4SBQ6OF2tLRjiwfvZjO6FRNlaB0OIco=
X-Received: by 2002:a05:6402:3586:b0:608:66a3:fec with SMTP id
 4fb4d7f45d1cf-60c88b3453bmr1506314a12.2.1751003996356; Thu, 26 Jun 2025
 22:59:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250605162345.2561026-1-maharmstone@fb.com> <0e60acd0-8a20-49cb-8029-5dbf90b426db@harmstone.com>
In-Reply-To: <0e60acd0-8a20-49cb-8029-5dbf90b426db@harmstone.com>
From: Neal Gompa <ngompa13@gmail.com>
Date: Fri, 27 Jun 2025 07:59:19 +0200
X-Gm-Features: Ac12FXyAYXj6I2LeVBzz2CXpkj7Bk61E509oxLHDA7XrEUBLGQb7iwkCSDLqSnQ
Message-ID: <CAEg-Je_uE8eYj0vBrbsGvLsque34Fcr8qCCSjXq9ZF2ryeSb_A@mail.gmail.com>
Subject: Re: [PATCH 00/12] btrfs: remap tree
To: Mark Harmstone <mark@harmstone.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 27, 2025 at 12:09=E2=80=AFAM Mark Harmstone <mark@harmstone.com=
> wrote:
>
> Some performance figures for this.
>
> There's a statistically insignificant slowdown doing I/O after a balance:
>
>         Compiling kernel after balance (5 times)
>         925s    without remap-tree
>         926s    with remap-tree
>
> Doing I/O with a balance looping in the background is slightly quicker:
>
>         Compiling kernel while balancing
>         209s    without remap-tree
>         207s    with remap-tree
>
> Doing a data balance with a 10MB file snapshotted 100,000 times is far,
> far quicker:
>
>         Balancing with 100,000 snapshots
>         29.4s   without remap-tree
>         0.089s  with remap-tree
>
> I can provide the exact scripts for any of this if anybody's interested.
>

I would be interested in this!


--=20
=E7=9C=9F=E5=AE=9F=E3=81=AF=E3=81=84=E3=81=A4=E3=82=82=E4=B8=80=E3=81=A4=EF=
=BC=81/ Always, there's only one truth!

