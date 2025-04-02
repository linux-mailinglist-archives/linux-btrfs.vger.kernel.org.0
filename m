Return-Path: <linux-btrfs+bounces-12748-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08EEDA78A2E
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Apr 2025 10:39:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A98353AFEFA
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Apr 2025 08:38:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57334236434;
	Wed,  2 Apr 2025 08:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="VDsWAyZW"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D832235C1D
	for <linux-btrfs@vger.kernel.org>; Wed,  2 Apr 2025 08:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743583083; cv=none; b=jdM7D5Jg4NBLBiigPdeWxQaE8r8gJV7NtxhmoVSGV1JF83dHPJbMzX+gbn5mz1pEVpgPbH/UFzT0K8QpZkL8alVzXpUdEFdbYUYDr6ipRju+kPcCrnNL9fwmrQzUExEflszq1Pc5MWWHGlV+dVm2hsr/zLRTCf41fH78oIRel3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743583083; c=relaxed/simple;
	bh=KpLcYbrHVfCU5lpqyLtXrasc+74ajQ6IUD1JAcxOssI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=egtg/5PhtLz1a1Njl/tERO7aaWkSo0GXRG/NuN+sKG/R/bIAfF40U+qHNytY3Xfj6Ad19YFp+nSDFUnkdsI95ssivpRQ6+KNlXF0ZlW38nKWZWQ6EyNz4xVq7RBK5aHrfo6df9CGHN7bg9RrW14jZfqoHJ0D3tSqURdGot3QLgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=VDsWAyZW; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-ab771575040so120615766b.1
        for <linux-btrfs@vger.kernel.org>; Wed, 02 Apr 2025 01:38:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1743583079; x=1744187879; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ewjxji6IY/5vNR6ri48+Aciv3sy2R06Z/j3CAF5o8hg=;
        b=VDsWAyZWa8oGdeKEyrcuV7inTTvGPSC0WG1Wsox+VALJdx+v1ieNDjD0u3j76/HUbT
         kaj0xw9FiZj/ZaaFpqGeFS+n2MZUDihy2SmDaYN0ElgjjbC5WfNK4ZxunwUBHPHQxzhn
         kuZrC2smFs4QT/b4ZIOxiiO97DKyETJDUHeCzwZQkd3tk/isLpYORuCHAVFZta5lysgZ
         msrWT+RK8yXLkA44Bb92gsknVXIEL8aDSpLJTLis4x5iIpJJRHcNicsCIq+BNbJufAuX
         b1QtslmlyM0MpLdtyo4JwydDWfv6RWyMVCqSf+uJO1rFfOsKwv9CCGeCsV1SKXxpeTrf
         nHVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743583079; x=1744187879;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ewjxji6IY/5vNR6ri48+Aciv3sy2R06Z/j3CAF5o8hg=;
        b=NrrwXB29tLmszW6aWWZVx/XydLV3g/WGugey4EmH8Lthda91+WwjJjijSZ1bmc0NZA
         pAgajtcX5DUtvMbwVwWElKIcrZ2vCSNowy/MdikQqJ5GbMhtedoOxJWRBEUs1DXIe/DE
         WmPfX+UU/3Nzdk3ILeTcdfdHcLIuWfMKlbjesYHWCd8Vs8ZizYmqN70yUgmSe06ksWz3
         rj5RXJ3tgnq2fM+CmirNLE2Ai0njXNDiqOWqzunHITg+knG9TFUY9oILQZjvOcnOtwDw
         PrPLstjWu+q88CGPXmFN4fs90BHQAxr/nmyKExMQXnVVzn+b8ium74mQYnUn5QbTVBGa
         Zffg==
X-Forwarded-Encrypted: i=1; AJvYcCW9UCmBTVbzqjusWZvg4dFCXXh+pJNtsFshU+YIMcVgJOAC9j4D9z8XnZnGZaKthZw12mRNFYh3tCucyA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yykff3VBBtKnCSM1wcW6KkLTWHkKuG9rBWuW1pGvHGYbPyu2K68
	sv5owqp75dTgL1G9AzxPTpgt+nY7vN1hEs1kCHN5foatFgAHsPyxcJip7NETQonx9C4BzZotwoW
	t5lJInFDqZEQ9UeF+55lyuHFewt/7xvVUn4kAAA==
X-Gm-Gg: ASbGncvCliXNGggPzFCCMNPsY6AqKTlq5rMhr7UWPOzHiA+0FLeRjqiNNb0SvMqHBe2
	WIPQXVtt11jctETNPfnmH5jkOOhkNMlK86gLe6U6cw+l25EirGqznZruV+r6Ah7kJ6d6t9uDgDe
	d8XNAnlYERKPsNWWivHwbcrxSf
X-Google-Smtp-Source: AGHT+IH0pZQXPIsyshZNcJikLUSgvoN+xfTfjXFKehtu6edO0p2rSXRH03DqtByAaVQ7BKiVGBgd3Q7D/uaupNVEq/E=
X-Received: by 2002:a17:907:3f29:b0:ac3:ef17:f6f0 with SMTP id
 a640c23a62f3a-ac7a5a670ebmr93213666b.5.1743583079476; Wed, 02 Apr 2025
 01:37:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250331082347.1407151-1-neelx@suse.com> <2a759601-aebf-4d28-8649-ca4b1b3e755c@suse.com>
 <CAPjX3Fdru3v6vezwzgSgkBcQ28uYvjsEquWHBHPFGNFOE8arjQ@mail.gmail.com>
 <b1437d32-8c85-4e5d-9c68-76938dcf6573@gmx.com> <20250331225705.GN32661@twin.jikos.cz>
In-Reply-To: <20250331225705.GN32661@twin.jikos.cz>
From: Daniel Vacek <neelx@suse.com>
Date: Wed, 2 Apr 2025 10:37:47 +0200
X-Gm-Features: AQ5f1Jqo0iwFCHxqBfuK--cN0_u5G5hQolFpGNc8fxZ9Qu7JV6qFHZhlP6qRpV8
Message-ID: <CAPjX3Ff2nTrF6K+6Uk707WBfvgKOsDcmbSfXLeRyzWbqN7-xQw@mail.gmail.com>
Subject: Re: [PATCH] btrfs: zstd: add `zstd-fast` alias mount option for fast modes
To: dsterba@suse.cz
Cc: Qu Wenruo <quwenruo.btrfs@gmx.com>, Qu Wenruo <wqu@suse.com>, Chris Mason <clm@fb.com>, 
	Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>, Nick Terrell <terrelln@fb.com>, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 1 Apr 2025 at 00:57, David Sterba <dsterba@suse.cz> wrote:
>
> On Tue, Apr 01, 2025 at 07:44:01AM +1030, Qu Wenruo wrote:
> >
> >
> > =E5=9C=A8 2025/3/31 20:36, Daniel Vacek =E5=86=99=E9=81=93:
> > [...]
> > >>>                        btrfs_set_opt(ctx->mount_opt, COMPRESS);
> > >>>                        btrfs_clear_opt(ctx->mount_opt, NODATACOW);
> > >>>                        btrfs_clear_opt(ctx->mount_opt, NODATASUM);
> > >>> +             } else if (strncmp(param->string, "zstd-fast", 9) =3D=
=3D 0) {
> > >>> +                     ctx->compress_type =3D BTRFS_COMPRESS_ZSTD;
> > >>> +                     ctx->compress_level =3D
> > >>> +                             -btrfs_compress_str2level(BTRFS_COMPR=
ESS_ZSTD,
> > >>> +                                                       param->stri=
ng + 9
> > >>
> > >> Can we just use some temporary variable to save the return value of
> > >> btrfs_compress_str2level()?
> > >
> > > I don't see any added value. Isn't `ctx->compress_level` temporary
> > > enough at this point? Note that the FS is not mounted yet so there's
> > > no other consumer of `ctx`.
> > >
> > > Or did you mean just for readability?
> >
> > Doing all the same checks and flipping the sign of ctx->compress_level
> > is already cursed to me.
> >
> > Isn't something like this easier to understand?
> >
> >       level =3D btrfs_compress_str2level();
> >       if (level > 0)
> >               ctx->compress_level =3D -level;
> >       else
> >               ctx->compress_level =3D level;
> >
> > >
> > >> );
> > >>> +                     if (ctx->compress_level > 0)
> > >>> +                             ctx->compress_level =3D -ctx->compres=
s_level;
> > >>
> > >> This also means, if we pass something like "compress=3Dzstd-fast:-9"=
, it
> > >> will still set the level to the correct -9.
> > >>
> > >> Not some weird double negative, which is good.
> > >>
> > >> But I'm also wondering, should we even allow minus value for "zstd-f=
ast".
> > >
> > > It was meant as a safety in a sense that `s/zstd:-/zstd-fast:-/` stil=
l
> > > works the same. Hence it defines that "fast level -3 <=3D=3D=3D> fast=
 level
> > > 3" (which is still level -3 in internal zstd representation).
> > > So if you mounted `compress=3Dzstd-fast:-9` it's understood you actua=
lly
> > > meant `compress=3Dzstd-fast:9` in the same way as if you did
> > > `compress=3Dzstd:-9`.
> > >
> > > I thought this was solid. Or would you rather bail out with -EINVAL?
> >
> > I prefer to bail out with -EINVAL, but it's only my personal choice.
>
> I tend to agree with you, the idea for the alias was based on feedback
> that upstream zstd calls the levels fast, not by the negative numbers.
> So I think we stick to the zstd: and zstd-fast: prefixes followed only
> by the positive numbers.

Hmm, so for zlib and zstd if the level is out of range, it's just
clipped and not failed as invalid. I guess zstd-fast should also do
the same to be consistent.

> We can make this change before 6.15 final so it's not in any released
> kernel and we don't have to deal with compatibility.

