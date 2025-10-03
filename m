Return-Path: <linux-btrfs+bounces-17378-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 101AFBB6823
	for <lists+linux-btrfs@lfdr.de>; Fri, 03 Oct 2025 13:03:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B91C119E4453
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Oct 2025 11:03:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD6C0283680;
	Fri,  3 Oct 2025 11:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maxchernoff.ca header.i=@maxchernoff.ca header.b="CC1wunBg"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B8EA19C556
	for <linux-btrfs@vger.kernel.org>; Fri,  3 Oct 2025 11:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759489375; cv=none; b=fNbgXx/kc4ELSzXFB5AsOCaL2VrYIngXDb4Ys/xQjF51gx27tDY+pQBMQmuOe2Q40BdOmtU9fHC+zG+bNPwl70sFrEZOylGbze1LodgMWl1YQwGgwW5/c3BsaI5y8U0Uoz/Wx5ArYuafwNWprjpdDKDdT/0f51/hS8EadcBFsvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759489375; c=relaxed/simple;
	bh=rMjqMZq8P2pK3tWqTRwhZc4wdpNaJqpr7mPLai1lm48=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nBme+ZqjGOMEGBQJ6Dyo03e5roGtb8l394VDiu4n63nbRfuq0ay8Jpb/Z3XGlgfoPi++g5/82dvuOSJfOSJLSB/SmJiR6aHHnrhle6MhX4DSGWHJSVYwjXQu4iqfLWV175f7x3WvrSbjFnDDqIopX3YTwjlalVI6g4XtGD4R5i8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maxchernoff.ca; spf=pass smtp.mailfrom=maxchernoff.ca; dkim=pass (2048-bit key) header.d=maxchernoff.ca header.i=@maxchernoff.ca header.b=CC1wunBg; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maxchernoff.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maxchernoff.ca
Message-ID: <96454206ee3ee7f8dd873cfe3989b974e7408cd7.camel@maxchernoff.ca>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maxchernoff.ca;
	s=key1; t=1759489366;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ha0pu2+PXSnA13pLHK6I1STJDywJ3CUYwZrZlE6obYg=;
	b=CC1wunBgPkJtnICBtoZUn2Hdhf45ykndjZ9PSIJPXAYx81cF9BnPNt5gAz6bKitFbKNdfz
	6SxjE0kVVmpTW1AMP9fKxU97nU+zVebwP8Kx14S03mHwAEu/MP/qByoDvil7zjuUPn4uY7
	s/r/d6JY5Tu+eLYfp5W+XFXlUVd2ve+ZwRUgR+2IPDghevJwK1ADXErgSCOZ5dSp9e1Q5I
	CVUCxuTzEiSHwnIfpOHks19NeCXUMZmp1qM7IwYGORskKgq4L/wNG8yUm5ZqAvNUKzvwZF
	3RDQ10tonCyrBHJY8T7l8Nlquz8aYXhF5v/WBQm4MZUhqdszDTkDKv80vmRcTQ==
Subject: Re: [PATCH] btrfs: fix incorrect readahead expansion length
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Max Chernoff <git@maxchernoff.ca>
To: Boris Burkov <boris@bur.io>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com
Date: Fri, 03 Oct 2025 05:02:43 -0600
In-Reply-To: <763f1e5a6d9611638977e24aeead5c9a266da678.1759337413.git.boris@bur.io>
References: 
	<763f1e5a6d9611638977e24aeead5c9a266da678.1759337413.git.boris@bur.io>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Migadu-Flow: FLOW_OUT

Hi Boris,

On Wed, 2025-10-01 at 09:50 -0700, Boris Burkov wrote:
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index dfda8f6da194..3a8681566fc5 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -972,7 +972,7 @@ static void btrfs_readahead_expand(struct readahead_c=
ontrol *ractl,
>  {
>  	const u64 ra_pos =3D readahead_pos(ractl);
>  	const u64 ra_end =3D ra_pos + readahead_length(ractl);
> -	const u64 em_end =3D em->start + em->ram_bytes;
> +	const u64 em_end =3D em->start + em->len;
>
>  	/* No expansion for holes and inline extents. */
>  	if (em->disk_bytenr > EXTENT_MAP_LAST_BYTE)

I've tested this patch on top of 6.16.8 with the minimal disk image, and
on top of 6.16.9 on the machine where I originally encountered the
errors, and can confirm that it fixed the problem in both cases.

Thanks again for all your help,
-- Max

