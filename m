Return-Path: <linux-btrfs+bounces-18251-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DF8AC04E96
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Oct 2025 10:01:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BE0D84E1DF4
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Oct 2025 08:01:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6B892FC00C;
	Fri, 24 Oct 2025 08:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NaBC9QUS"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 013182F99B8
	for <linux-btrfs@vger.kernel.org>; Fri, 24 Oct 2025 08:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761292858; cv=none; b=ptPuRm/GvSUnFwtj+GRD0xYmozsqukIHMbAsnJRZ+sPWuKDBXLR5D6GADzKAy9LR0psDo4d2Z4ABQ/+JVrmTjHQUjc4foe2IcLVx/zGpq71X7lkvvLg8wlNcFrxRDRaWMWNAJ0hmNu6888zfiu+CgGgE2QX8rG88O/CK2SdlTe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761292858; c=relaxed/simple;
	bh=qF/E4naE8uSLXNtPfdTyxwwsaiwS8Em8CUHnAym92Rg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f7r5KLQ2TACFN70//boxsLdgxcg7RKN9Fw2121jAkv/SFiTuTEy/M11UwbNKcyirqSD3tTFWMaCbwnudhN39MeAtaDWbPXtmIu8Z6L6D/RD7xNJLeKDcBelvgho0Bbjm8rjLdNxqCw3eJsn+hueIgA264cEXOIwgzdk1qVIEN5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NaBC9QUS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78B89C4CEF1
	for <linux-btrfs@vger.kernel.org>; Fri, 24 Oct 2025 08:00:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761292857;
	bh=qF/E4naE8uSLXNtPfdTyxwwsaiwS8Em8CUHnAym92Rg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=NaBC9QUS6YScvUDSnAo7fUxRiMz+xIO978FAZiOz+gosdLJsU8ngZilLxV4AZJcI5
	 UmDDjLIo4G/Z5qrOKSopuxER9RW6OcCISjC4n2yzR400Boj8ku+g9TjgNTk9JEHtW3
	 PgLIzxult9DSzsaKq4e2vpH8Pd9QcO0T3Wx2gJ5VZguZbSdWeHIb93G4bbn2jMhe1G
	 pkzv7l39az/mnHfPQ+ZoS/JCAO7GJQSZJN9WoEVQyu2Mrie27ZkfoUHFSVgv+VxUas
	 ltwUDlcXB1iuw8P9PjCGPJBub+E8dYoxluvDRuCi/gruuLwC7Xa3dzcjUcjblxb3A1
	 Ep/nGylyRuMNg==
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b3f5e0e2bf7so391064866b.3
        for <linux-btrfs@vger.kernel.org>; Fri, 24 Oct 2025 01:00:57 -0700 (PDT)
X-Gm-Message-State: AOJu0YxjddXi/RTspMp+hndlMH+jyM10bgiDZxwiJBL8kwwAf93Dc3p1
	IQkTdTpE5EAyw0KSpgxu5vlBLehQKtelOTr4OJ59eNGvqQ4et3eaIfk3SJ5wnUeiwdTwMf1grua
	Oid9g2Sfil+573pFkfawdujkfm6i7F14=
X-Google-Smtp-Source: AGHT+IFY7ki57PiMyCOAj5flWMB9oJjE7kul9hM4nFOH9jHXMXBMVz9qDzlG5swxGqQHHZMd9e1m1EHwWzOx/e+jRHw=
X-Received: by 2002:a17:907:3e24:b0:b3b:b839:577b with SMTP id
 a640c23a62f3a-b6472b5fe70mr3594673466b.12.1761292855977; Fri, 24 Oct 2025
 01:00:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1761234580.git.fdmanana@suse.com> <1a4d2fa8f7da7b88e3b6b3aeabdcee25245b51ea.1761234581.git.fdmanana@suse.com>
 <94881d3f-64de-4ca6-be15-38b6dddb3119@wdc.com>
In-Reply-To: <94881d3f-64de-4ca6-be15-38b6dddb3119@wdc.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Fri, 24 Oct 2025 09:00:19 +0100
X-Gmail-Original-Message-ID: <CAL3q7H56dVwa1ACoZCn0xAjufDuMRchNefOC9Qh-MXaZJqUr0Q@mail.gmail.com>
X-Gm-Features: AS18NWD31VRT11knnl0J9D5ei0waDXwGI5dv15UOZp9NuE5up2MgZ1ezlvpkEX8
Message-ID: <CAL3q7H56dVwa1ACoZCn0xAjufDuMRchNefOC9Qh-MXaZJqUr0Q@mail.gmail.com>
Subject: Re: [PATCH 18/28] btrfs: reduce block group critical section in do_trimming()
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 24, 2025 at 8:19=E2=80=AFAM Johannes Thumshirn
<Johannes.Thumshirn@wdc.com> wrote:
>
> On 10/23/25 6:01 PM, fdmanana@kernel.org wrote:
> >       spin_lock(&space_info->lock);
> >       spin_lock(&block_group->lock);
> > -     if (!block_group->ro) {
> > +     bg_ro =3D block_group->ro;
> > +     if (!bg_ro) {
> >               block_group->reserved +=3D reserved_bytes;
> > +             spin_unlock(&block_group->lock);
> >               space_info->bytes_reserved +=3D reserved_bytes;
> > -             update =3D 1;
> > +     } else {
> > +             spin_unlock(&block_group->lock);
> >       }
> > -     spin_unlock(&block_group->lock);
> >       spin_unlock(&space_info->lock);
>
> Hmm maybe something like:
>
> spin_lock(&block_group->lock);
>
> bg_ro =3D block_group->ro;
>
> if (!bg_ro)
>
>      block_group->reserved +=3D reserved_bytes;
>
> spin_unlock(&block_group->lock);
>
> spin_lock(&space_info->lock);
>
> space_info->bytes_reserved +=3D reserved_bytes;
>
> update =3D 1;
> spin_unlock(&space_info->lock);
>
> This will not only get rid of the else path but also the nested locking

No, that's not ok.
The block group must be updated not just under the block group's lock
but also under the space_info's lock. We have many places that depend
on that.

Thanks.
>

