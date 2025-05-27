Return-Path: <linux-btrfs+bounces-14250-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7240AC4CA8
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 May 2025 13:01:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9711A3A6F94
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 May 2025 11:01:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31196253F3C;
	Tue, 27 May 2025 11:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="e/YsT7ZA"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B7073C30
	for <linux-btrfs@vger.kernel.org>; Tue, 27 May 2025 11:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748343682; cv=none; b=taIxnrA2N3QuAPJk++B+YBCd6Y63ZcMeZ0c03r6Dfll7Cyo4qaZG9wiVzWB4ocMJAzlw1S2xK9Q7PJ+kCapy5AzIOJBNXKg09p2+syuWprt7Igj8itgDGuUE5dZrugr6R6I3tgcf686Yurb6GIuOwOsxdNwpiASuspb6qc3n8WE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748343682; c=relaxed/simple;
	bh=yG9G1NVIUkE7WY+sOopneYVOALUylqCudfbjBsryg0g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PdKbHXLhDF3Vp/sVKS1N+phbnvwSseYN7EIx0XR7Sk/lWH6/m3KCwnVMXX60GlCAOCpFI4YxxkRN5YYvxQeFAz8nGITdbnA/C8OAGDj9Ilfoce3HiOf+G3cmTHdjAHz6tH+7wJEfawU7Ofn9YBzqpCgtpUdEd/nY/skQ86qLG0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=e/YsT7ZA; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-ad1b94382b8so538693566b.0
        for <linux-btrfs@vger.kernel.org>; Tue, 27 May 2025 04:01:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1748343678; x=1748948478; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3GFTsL9bjzYW+mnHPHJAxUKFqlAoARIgNuCLkThTvhA=;
        b=e/YsT7ZAijDz+idQk3jVju9x1uTg0ySRQee92kXruXHdr/COicAAdf1tT6h5KKmN1s
         C0sn7VKZN74WVSUygcsgkoiGJsq8gA4KtgR4L3PHv88YjijsX/+IcDkCATdWD5u6fSqU
         LNlU/kuC9FKhQStA2nnv8quix5Z4gzbi72iSb27r4ZN3LSdgOwdMAUBOuNiZnGj/i0u4
         BuoUNKkNfINt23W5JkmzziUmyl9GClpzsaeuYZRx8WDtNdnPPY6ylPVll1WyhwwlwzBX
         0zxDSDLovV+j/VW5QJhgyATKqDKOEvyKSluNYfAY0ZUcN+hu6DbPe7t36Rve1YrubX95
         6ogw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748343678; x=1748948478;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3GFTsL9bjzYW+mnHPHJAxUKFqlAoARIgNuCLkThTvhA=;
        b=FuMqqjRWN++Ts/Vs0Qptdo1zHbhELpuCSy59D5n5mkKf7CoCiqArlXNSXjCZVxuL1c
         esx0CKqq3xzh6kIqoB8Mbuv+3Qz6kK5/7BCxxb8SMc+axT7dxXFj1+BnzPMwK1AlAkFb
         EIwoRtrf66L21Spj8Oem80HVw6SfpA5mf8F/2o2pU8Bb4ZRFuL901Z930qWtKfrjYE4F
         JF4XteSaFaX/zpdTCqzla+xwNEiixW5bFOcxEFF4cC/gbJLdYRnIxHLpVIf6Kc8fEjsJ
         f3yfFClIRcy/cihxLlsf68oQn9F2/sVl6iOGeAZWWm3c5qy/ybuyIkdAY5hUuHebKtm1
         dSPQ==
X-Gm-Message-State: AOJu0YymSpEwB/IwckUK6ZZSNJG16WJY7tDxM0J+IRxq47XpDGpGBHw6
	liZYDCT5hEwWzF55U7P4r3MqrfTm7OYMhh38JzFCdXS8TTOXwRDJJex2otYzyijpDoVlpOrJTgD
	0My94pHM3Vbkk2vQK9CapWY5QAf5W4a5emL0TuACzRQ==
X-Gm-Gg: ASbGnctvVfspsOgv/PPmBVNEEw3SMnfX++BwQ7KpBGy/JKROk5c43gcogRAPFKBBqmx
	ZP6SlRqlrInsUIfGeMaoJUKk2zhKL1TYl9dnuKySjrv0nxeiCO3n75doUSW5ErZtrwEp0xmDoPD
	sT1y1H4R0INle4y236Z7lAHdwJ8dyKdHw=
X-Google-Smtp-Source: AGHT+IFmZYKWVQMIdVNeErE4cu1G/ogdHbX30KuxlUDn2ATXTXg3NiTunejwzRoE7R1ZnfBn0uk2QdkIswaD7ZrOKyM=
X-Received: by 2002:a17:906:c314:b0:ad8:8478:6eb8 with SMTP id
 a640c23a62f3a-ad88478834bmr270445266b.9.1748343678480; Tue, 27 May 2025
 04:01:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1747649462.git.fdmanana@suse.com>
In-Reply-To: <cover.1747649462.git.fdmanana@suse.com>
From: Daniel Vacek <neelx@suse.com>
Date: Tue, 27 May 2025 13:01:07 +0200
X-Gm-Features: AX0GCFspV_AshAksFAID8HQhGtx8i7psV91rdDYv8XC3zlgaFry_h0aqREvy_us
Message-ID: <CAPjX3Ff8Pf0JgRyxiz=pFUtKsD6XMG4t2DwtSnBHoAiGhek9bw@mail.gmail.com>
Subject: Re: [PATCH 0/2] btrfs: some cleanups for btrfs_copy_root()
To: fdmanana@kernel.org
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 19 May 2025 at 12:42, <fdmanana@kernel.org> wrote:
>
> From: Filipe Manana <fdmanana@suse.com>
>
> A couple simple cleanups, details in the change logs.
>
> Filipe Manana (2):
>   btrfs: unfold transaction abort at btrfs_copy_root()
>   btrfs: abort transaction on unexpected eb generation at btrfs_copy_root()
>
>  fs/btrfs/ctree.c | 19 +++++++++++++++----
>  1 file changed, 15 insertions(+), 4 deletions(-)

Looks good to me.

Reviewed-by: Daniel Vacek <neelx@suse.com>

> --
> 2.47.2
>
>

