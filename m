Return-Path: <linux-btrfs+bounces-19435-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 47D13C97CE7
	for <lists+linux-btrfs@lfdr.de>; Mon, 01 Dec 2025 15:16:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 410AA341CD9
	for <lists+linux-btrfs@lfdr.de>; Mon,  1 Dec 2025 14:16:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 105BD3191C4;
	Mon,  1 Dec 2025 14:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lucidpixels.com header.i=@lucidpixels.com header.b="W8LTkwh7"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF93730F944
	for <linux-btrfs@vger.kernel.org>; Mon,  1 Dec 2025 14:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764598592; cv=none; b=d2nqBiuueseucfqlNwzVGM9sUJBBJEHlKbaofONIlPFmCshY0cAn3t3ORlEpa4Z5QSFGOuCjzj/KljXr3sIOwDMPkUTLbY50J/sCqPOklQ8OO1mjH/iFmxhJx71xmAx0/N8Ze7UNCC49fxN0IvqniQdGruWaTpXVu/Gx5Xk67rU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764598592; c=relaxed/simple;
	bh=futfLwuxMfN8o8RRQI0MN9ZW0WeatznJgAbhjLgO++g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EBRhapGyonrNbRNrwz05G5QznzSc+PSipn/+LdAHY+FhzB1AQ/894m26Cy/fv68L2FuGogV4j9dzfouTiBqCcVZPmHT3s3dkOQJm5uYF4jHsQAZsw58LGe4knJSEilR5EigKhS4tqOvVeV+lkmTxP4AY9YwNwqNOYpLJdo4NcQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lucidpixels.com; spf=pass smtp.mailfrom=lucidpixels.com; dkim=pass (1024-bit key) header.d=lucidpixels.com header.i=@lucidpixels.com header.b=W8LTkwh7; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lucidpixels.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lucidpixels.com
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-656bb297e31so553726eaf.0
        for <linux-btrfs@vger.kernel.org>; Mon, 01 Dec 2025 06:16:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lucidpixels.com; s=google; t=1764598590; x=1765203390; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=futfLwuxMfN8o8RRQI0MN9ZW0WeatznJgAbhjLgO++g=;
        b=W8LTkwh7VQU3M/7GvKxD2RZClKvnTUIBpJrK9qa7d2B4EbcBFdn+32uZiptzuPPa8P
         ZGHLHFYRw3ewWLsxMlyoe5/EsNMtHZ7+Fr148CKIhHAQijphirQ0NyRsQkr8COMGPEk9
         /8LDn3c+RrxV5PwAjkOBjSkLTS1j9v9AxcCeI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764598590; x=1765203390;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=futfLwuxMfN8o8RRQI0MN9ZW0WeatznJgAbhjLgO++g=;
        b=p7f9/y3vrFOKql8/b3fbiyYuycZYEN/zOyczPzrb/uV5TILgfOtvdBv3gVb5ZsF1JY
         Ec+Ep3A4+bL5w2H8Ksr5gf1SWuuxUHKsmu/bd6Ptwn9n0Lxd5EyOBOThqjU1Bj/izh1a
         qSyxglPTtw39eOWXy8kc8JpN+ySOFou0olqNjOnCqcGlwLQ00cgYb4VEEYomGlJGkWuQ
         SCnszThDllwXrltD9ddZp2HfBnDTaZT0Grdp2HvmE9+kMB8tOq02hBsjzn+lrgofkyIk
         z4cTQMzDmfZVOVezlBXlEaGO60eimhHWcIFVV3xwBhHNVVKGaEuLro6DdBSbLWh7QY5U
         Tcgg==
X-Forwarded-Encrypted: i=1; AJvYcCXDns+dT5Gm2oTgmsLhx+WCQ9UZrcVPnhW7VGMKukbrAWx4n8UntEQm9rQi0AJF1GM+2mbUMtLfQbEwTg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yys50WG8KOJcch5ykziFt9pjw1lWOxZmp+fbQPjDrxrEA+7XskV
	kTxfsAnyFgb3vQ96Vwl9k8z/JDVPJiOXjt0BbTIDUVDjbQhgdlUrG/hkoh3iQWKFyZONr0kxxh4
	DQ2U9Dup/zjtspMS+rhRI2dD3f9HMbs5Fv+mr4JOaxQ==
X-Gm-Gg: ASbGncvktZuA7BLY8OHGuQuMJth2Q1PGXhCSJFu4Q9/WWx8jboBYo0X85clH9GDQobm
	VyQdYwYNIo/w33UtkP8h6ivqJZrLx0HfXzFuX66RU+nCESnoyxMDzUvfDawDvL0XI0oksMEfONJ
	iDeI8zfJJfJIzeF328AqGUYdPTo2A5HOAfflF6kQP7EQcUx8h1eAb7tNm7yJPjqUBrl9QuugkaX
	r+z1RHT7yWkvN8QH0P8SC26YZVrjGbqA0z+iZ1ZDd4hMVC2ikWvQy4LHSMNO+HjeH+k00SSGLSZ
	5sIe2Q4qnAGbLTdrDTXx0D/Ke0qYvue28fJ84jKpvYPUIHKaRFlMiw8t/q5yPNw=
X-Google-Smtp-Source: AGHT+IETd4D+lPkgqKBaD9OLW1UljeD0G2Ftcrq1oe00FJeXYsJTNA4CJ9fq8Mfi18rJWJ9VbmrP27VCz3fdAcbVd24=
X-Received: by 2002:a05:6820:81d4:b0:657:6678:1b48 with SMTP id
 006d021491bc7-65790b69644mr13368876eaf.3.1764598589905; Mon, 01 Dec 2025
 06:16:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAO9zADxCYgQVOD9A1WYoS4JcLgvsNtGGr4xEZm9CMFHXsTV8ww@mail.gmail.com>
 <07500979-eca8-4159-b2a5-3052e9958c84@youngman.org.uk>
In-Reply-To: <07500979-eca8-4159-b2a5-3052e9958c84@youngman.org.uk>
From: Justin Piszcz <jpiszcz@lucidpixels.com>
Date: Mon, 1 Dec 2025 09:16:18 -0500
X-Gm-Features: AWmQ_blOCs9kCWQUm9Pt8F4AtMcgJ0EybOhWkrFmmWIYSdJj1aJZLOPXaOfTHoI
Message-ID: <CAO9zADyyQPjtRNy136=WNQnS4siVSd_N4wXqMjB+pRzQVOqrxQ@mail.gmail.com>
Subject: Re: WD Red SN700 4000GB, F/W: 11C120WD (Device not ready; aborting
 reset, CSTS=0x1)
To: Wol <antlists@youngman.org.uk>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-nvme@lists.infradead.org, 
	linux-raid@vger.kernel.org, Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 25, 2025 at 1:24=E2=80=AFPM Wol <antlists@youngman.org.uk> wrot=
e:
>
> Probably not the problem, but how old are the drives? About 2020, WD
> started shingling the Red line (you had to move to Red Pro to get
> conventional drives). Shingled is bad news for linux raid, but the fact
> your drives tend to drop out when idling makes it unlikely this is the
> problem.

For awareness and tracking purposes the drives are a little over a
year old but this issue has been occurring since they were put into
production/use.

