Return-Path: <linux-btrfs+bounces-11293-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAA5AA289D0
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Feb 2025 13:01:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 552E616551D
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Feb 2025 12:01:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFA5B22C35F;
	Wed,  5 Feb 2025 12:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PupUByZy"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 227EF22B8DB
	for <linux-btrfs@vger.kernel.org>; Wed,  5 Feb 2025 12:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738756877; cv=none; b=mIpjQG/OLIwehTrx09VBvQpFt2ZCCqZhX09Fbcp3E4H2XID1EnrwoSHaCx9eHnL6JpcAh6YvyB2ospVvX7rzb08Chy4ED1gsXyJP0+gt2M6ehX4olslyVh1j0h9XFsRmbWhyDLglyZJqJD13RBGKkJUYLB393dEpTFIvxgAP3Qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738756877; c=relaxed/simple;
	bh=orLT0DAGfIBiWn6Jr5fRxppbyI5LerqbdHlTb/DLOMc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dPg+aIsD19vCoKm1dp6IXCevaqu9cy2dLphozCdtFex5av4VY4tvrkZADViP5W+vaaBnu3UVHz2P5YV0aIJ0f6Y6HyMxzUusipOnGQfPQ4MHVVq3DnDFzgmDUVp/uOuGSA8mQEDu/pm0E5Eb6iKQYzQi9gseaAUR+iZ6xBuRvec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PupUByZy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A25BC4CEE2
	for <linux-btrfs@vger.kernel.org>; Wed,  5 Feb 2025 12:01:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738756876;
	bh=orLT0DAGfIBiWn6Jr5fRxppbyI5LerqbdHlTb/DLOMc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=PupUByZywBba/4ZUuo2BEKjV0VH02Vfuk9bV/HEAJYYMAYxl42tSRCcolY3J2AB2N
	 lCr9FCSWIKoPkO1FaZF7KycokSzA0Vn9yZjuX/+u5LTmiq+b+CZkwAeEIbIqNEezJ4
	 FpfSf2+9HlS+z4v+e6DDmjp9av4yGYIaXtYjPCPbG2sF921MIlOkSZRpBJUsc45TYG
	 R7GwDSugdjKYiMvhPPQH9mkBNWqNaFvPD9FD8sOlQe8lyIaw8pd+XxzCxIAZkGzw1J
	 ZDTPGV9wVaoSYiS8V+sBDiRJS+eLIXGMEvfuEK49aU6+xod4yeBQjeeo7hmEKqfF1V
	 37PsbqLf2e3ig==
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-ab6fb1851d4so142944766b.0
        for <linux-btrfs@vger.kernel.org>; Wed, 05 Feb 2025 04:01:16 -0800 (PST)
X-Gm-Message-State: AOJu0YxJgTS5XIb3aB3wpAa2ckAWMv9oIdz0wY87ZCL7x+E9qWFxm5SV
	ApthZEHxehNpy7IZxQ3DwQPY46sV4pnHqNL6SU4GHltzaBxTyEPaReQ46UeE5X88pnQGSQmNkMj
	RpR2nusb3laaMPgmjAfZvVBv1MWQ=
X-Google-Smtp-Source: AGHT+IGuvmDCOKH+ZjX64bzpeUJZSbTCjqUFYqO7KWnQkjYwAOnNB6/6rZ1xnN2dlfRKD2ExiAv14GsKdkb7GRK5x3o=
X-Received: by 2002:a17:907:97c8:b0:ab7:462d:77a5 with SMTP id
 a640c23a62f3a-ab7483f9eecmr715887366b.7.1738756875056; Wed, 05 Feb 2025
 04:01:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <87182120501efa8c878a65196fd6225481cab7c1.1738755264.git.fdmanana@suse.com>
 <651d1f9e-c7b6-4e7c-b151-ff29adb27047@wdc.com>
In-Reply-To: <651d1f9e-c7b6-4e7c-b151-ff29adb27047@wdc.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Wed, 5 Feb 2025 12:00:38 +0000
X-Gmail-Original-Message-ID: <CAL3q7H7S-r2Rfx6_bRjWTBRJziObfOY=Z6_CXcm0iaWCVo9DsQ@mail.gmail.com>
X-Gm-Features: AWEUYZnZjqGFg7Ksn7d6vAfmtufy1MxUqnm9bmglFOGqwzrzt1NqjzEH1jECBtk
Message-ID: <CAL3q7H7S-r2Rfx6_bRjWTBRJziObfOY=Z6_CXcm0iaWCVo9DsQ@mail.gmail.com>
Subject: Re: [PATCH] btrfs: avoid assigning twice to block_start at btrfs_do_readpage()
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 5, 2025 at 11:48=E2=80=AFAM Johannes Thumshirn
<Johannes.Thumshirn@wdc.com> wrote:
>
> On 05.02.25 12:36, fdmanana@kernel.org wrote:
> > From: Filipe Manana <fdmanana@suse.com>
> >
> > At btrfs_do_readpage() if we get an extent map for a prealloc extent we
> > end up assigning twice to the 'block_start' variable, first the value
> > returned by extent_map_block_start() and then EXTENT_MAP_HOLE. This is
> > pointless so make it more clear by using an if-else statement and doing
> > only one assignment.
>
> I think you could also move the declaration of block_start into the
> while() loop, as it's not used outside of it, while you're at it.
> But that's not a big issue.

Sure, I can do that at commit time.
Thanks.

>
> Anyways,
> Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

