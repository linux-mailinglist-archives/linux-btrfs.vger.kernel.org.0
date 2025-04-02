Return-Path: <linux-btrfs+bounces-12750-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D829A78C61
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Apr 2025 12:30:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D42017047E
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Apr 2025 10:30:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95157236458;
	Wed,  2 Apr 2025 10:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="JqncWQHg"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF4DF235BF4
	for <linux-btrfs@vger.kernel.org>; Wed,  2 Apr 2025 10:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743589813; cv=none; b=unUrkmWZQhqxjaRkqo/5dBryGIAsb0BDlfPoChAvmy8Y1phEe3+H8r12HEiy7d0f8190RpZp2K6T6WSyMrs6R+IcHhIAVoD1+3QrXnftZQPnzV0FnlhUNXCCTS+WtAp0gU/6jxRSv1yPg80kODie583eAdbujO8qJIzsT7VOFcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743589813; c=relaxed/simple;
	bh=If0B7uUV6NX2+WqaXenFUnwPJoOh/uZsu2Z2/sdyBtM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N+9oTr8LeckJRLO075/lm6Bo/9PUs0huyWmYe554TmPnU1rGRVKkYvqz/YEc2cwbLDSOjqtcSxzIzoXuCSRTKbE9wfNUPREej7TlewUoSkb+mSOm7+A+KB1/cu8VhXiT1gbceNi+AyI+oC8yT3f0PI4bgu3kKVIUjPqnEYnoV/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=JqncWQHg; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-abec8b750ebso1009178566b.0
        for <linux-btrfs@vger.kernel.org>; Wed, 02 Apr 2025 03:30:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1743589810; x=1744194610; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=If0B7uUV6NX2+WqaXenFUnwPJoOh/uZsu2Z2/sdyBtM=;
        b=JqncWQHg5gTg5dzhmg0MBRSzwb/834GhVmDO4iMhgfAOSzOKtfnB1RH8AkymCrcr1p
         oOkTuMHmRmGjvMMTF9/Xub4ZqsmUN53nl6ERsizjAd7AloYzFKWXWr1Y7JDCLxerknnr
         2D/Pt+1Q4zippXItDkWm33bsvqZmZOjGgfWZY93cs3mCfa0jtSeDqcA5Tb2UlYgfMzZu
         rqngZLTohqN5/t8gp4tzs7cgufGR4PiR6Wpmyi7fRC9SPq3wY/fAuTieqRVWK/E5G1Vu
         BOM+kJHiOOA7n8TcxLLglojyVTPyqyNzaW2loI/P8rNtmlOXHBx1yKcaAtNShvLcqnoY
         7tCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743589810; x=1744194610;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=If0B7uUV6NX2+WqaXenFUnwPJoOh/uZsu2Z2/sdyBtM=;
        b=l68Zu7baAZdD1mo7tjNl3hAQZ0ZAVYZZcBt9rtRZAmE1pGlP/yzQdEf81YAcXZiuKB
         7aGw/Nk4K6Zn1ZvIety7vmI8RK2bymiepD+iV/r9H5RwATUS7HJc/5+l17MBx9c0hpjo
         y7D11EvrOwNMwsqdp02Uj9sakPHrRiIu4cadAID7GLE2iJVZAL+7Tg5mP7NUgKW1Ymgg
         Li6urbjM6Owmw8X3FYIXZTrs7S8i6W5Wc6yRGqqNeyiaJQzzpExb2LzOCMxPyUFw5fWN
         XauYZ1zj27EDocBnRQ4fFAUCUNqojiHKuLH20aI8OtvATOcTFibAAeTjVMg8CWP2u2Om
         gPTQ==
X-Forwarded-Encrypted: i=1; AJvYcCW/NdqwxSUAuPbM0DUS6XpQz06ZevDzqsi1bpFtPAFV1uGUIhBmAPbyADe2R78UR0VvZia7E5lbPUvh7g==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzj/9TR8EjDwSEcSLB8NHmrflBzTO+hfpFWRxmBbmdew8hX5eJL
	IaCvczAsqnRkP90JSTusXAMvoawbZUKmrJ8bqQhUvK+Vm1+SqoEZyQLajTpLgydCYWR2i8R5dm6
	8EELtl1LhLDZYicd4iVuGaWO0UL2y72s0lKXy8A==
X-Gm-Gg: ASbGncsjY97u8qM2tWiqJ/D0Sl2UjMU6ElW+eXSne0j/smb59BxSrdbJpkYw2aCsOkN
	uxMBn5/Fl6WLyDbVAIpJmdZgd0a47Yj5tdsqrGGrCNBo4p8yf98hsIQD/df+M3RkrOHsIUewhHl
	YZo3mfePMPfwrMa4g2SvBSH6apF5PpOgIcJOs=
X-Google-Smtp-Source: AGHT+IEGnKNW72QdyCMjxaZ8GC6ePZQX6srGbLVObmGu9ZfiPq7G7S7fypK4kUkDy1p8fLfAnnEY3sauYvadR4VHGns=
X-Received: by 2002:a17:907:3e26:b0:ac2:9e1a:bf81 with SMTP id
 a640c23a62f3a-ac7a171665amr149027366b.21.1743589809964; Wed, 02 Apr 2025
 03:30:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250331082347.1407151-1-neelx@suse.com> <2a759601-aebf-4d28-8649-ca4b1b3e755c@suse.com>
 <CAPjX3Fdru3v6vezwzgSgkBcQ28uYvjsEquWHBHPFGNFOE8arjQ@mail.gmail.com>
 <b1437d32-8c85-4e5d-9c68-76938dcf6573@gmx.com> <20250331225705.GN32661@twin.jikos.cz>
 <CAPjX3Ff2nTrF6K+6Uk707WBfvgKOsDcmbSfXLeRyzWbqN7-xQw@mail.gmail.com> <e3e5f96a-8b46-4e61-a66b-253d2dbe6aa4@gmx.com>
In-Reply-To: <e3e5f96a-8b46-4e61-a66b-253d2dbe6aa4@gmx.com>
From: Daniel Vacek <neelx@suse.com>
Date: Wed, 2 Apr 2025 12:29:58 +0200
X-Gm-Features: AQ5f1Jqvfxd2WBoECRKSnpbiM4SoVxH_a_gJi6NOEtLCNGoWC8ifqXlcsPXQRPI
Message-ID: <CAPjX3Fetm8jmPoaP84PC9ck_XtRch9TPny6tKcn2EJL6ZPaXug@mail.gmail.com>
Subject: Re: [PATCH] btrfs: zstd: add `zstd-fast` alias mount option for fast modes
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>, Chris Mason <clm@fb.com>, 
	Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>, Nick Terrell <terrelln@fb.com>, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2 Apr 2025 at 11:08, Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
> =E5=9C=A8 2025/4/2 19:07, Daniel Vacek =E5=86=99=E9=81=93:
> > On Tue, 1 Apr 2025 at 00:57, David Sterba <dsterba@suse.cz> wrote:
> [...]
> >>>> I thought this was solid. Or would you rather bail out with -EINVAL?
> >>>
> >>> I prefer to bail out with -EINVAL, but it's only my personal choice.
> >>
> >> I tend to agree with you, the idea for the alias was based on feedback
> >> that upstream zstd calls the levels fast, not by the negative numbers.
> >> So I think we stick to the zstd: and zstd-fast: prefixes followed only
> >> by the positive numbers.
> >
> > Hmm, so for zlib and zstd if the level is out of range, it's just
> > clipped and not failed as invalid. I guess zstd-fast should also do
> > the same to be consistent.
>
> Or we can change the zlib/zstd level checks so that it can return
> -EINVAL when invalid levels are provided.
>
> But to avoid huge surprise, I'd recommend to add warning/error messages
> first.
>
> I'm not a huge fan when invalid values are silently clamped, even it's
> just an optional level parameter.

I agree. Well, one by one. Let's nail the `zstd-fast` first and clean
up in subsequent patches.

I already plan to fix another issue I noticed. For example
`compress=3Dzlibfoo` is still accepted as zlib, etc.

> Thanks,
> Qu
>
> >
> >> We can make this change before 6.15 final so it's not in any released
> >> kernel and we don't have to deal with compatibility.
> >
>

