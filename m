Return-Path: <linux-btrfs+bounces-10480-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2B029F4C7E
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Dec 2024 14:38:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73AD2170CCF
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Dec 2024 13:32:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80A921F3D5D;
	Tue, 17 Dec 2024 13:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KKe99A+i"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6DA53E49D
	for <linux-btrfs@vger.kernel.org>; Tue, 17 Dec 2024 13:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734442301; cv=none; b=FkCZSq+M7ynBPnM3BB0bU/8nKFba9JLbTBSaNaX4xOgu0GEwqwF3ZAjBD88GhmlMBSVZj4oc4dvDIJo9m74lB/fGNjj6Efo9CwpCqIWB0B/59Dcs48XKBvCbMesfVprtIgBNouCtMJ5JPswM3beITk+9Ze1RG45y2iS/iPwdTJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734442301; c=relaxed/simple;
	bh=l4NFRbHOt8/MrsOgJywiR8T9jEEQR0CKN7924Ynnifg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VmjGP4icdD5SAgCEX53jfroGK9MQX+Lk/G8Pp55LRj0vrEKow1NKAThwBKsakbfYhZyFm69pPzHKuYygtyj+k70kzXEY/qCkcNUumQE4x4enZ/F2umuIAQtoGBFytDwGAuebgpwDD4iw97pqif8jqNFxsU7/9wGFjNdWkaDIa+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KKe99A+i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83CAEC4CED3
	for <linux-btrfs@vger.kernel.org>; Tue, 17 Dec 2024 13:31:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734442301;
	bh=l4NFRbHOt8/MrsOgJywiR8T9jEEQR0CKN7924Ynnifg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=KKe99A+iGZV2oWAFm0+u+s3WkqhL7+xL2KJc9G0SiUlFR5ZXL0mYQ8Ve0JQVPwgw5
	 Wn8/xutVkRbn148SQCXY2jtNKvejS5NoLi28JuZbSAQHUNX0wcqAQ3yXdgKZEXJCK7
	 /ClPUo7qmBRHzVvCbiCcngt95rCx5D4Ohxzki8YSv3nvB9LThW+Mg/u8PZ0EUGJMig
	 qTFgNuEpTfo1kU57ihKuc8rkD/PjiHLr7K2V/ShsiukB4Nzb37usfBkK+n0iw4nxzP
	 ei1LBokgfE8juCOOXkyBupJq+tLZgzPrJ+59nUMxY4NuR+NNhH3och8mznND4xVSLh
	 5nWh9RCAC5qEw==
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-aa6997f33e4so820021166b.3
        for <linux-btrfs@vger.kernel.org>; Tue, 17 Dec 2024 05:31:41 -0800 (PST)
X-Gm-Message-State: AOJu0Yw3xZ+aXIdVkW4og3bgGe+qOPnzuOiurRyI66CHAxnx2kOPjopk
	CaN5xIdCzUHKULjZwl9JCrR8wyceXiCbARpyO7JXyfrmdf896UbKK3+8cSXrFVWB2AnbdxcCZjs
	E2F1rwoK1rMqfNbGMYiL2N88e4X8=
X-Google-Smtp-Source: AGHT+IE5O7xvHiNmW3HpGbsa/omwiScf5/Xah+VT/27HLZt5q/gAwKDrysuRDefRAIa/lrnCPofwRRW5KrgCh/35owE=
X-Received: by 2002:a17:907:d92:b0:aa6:af4b:7c89 with SMTP id
 a640c23a62f3a-aabdb921633mr437448666b.61.1734442300146; Tue, 17 Dec 2024
 05:31:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <60c0e07d871249ed86b53087c75a1013233da355.1734437595.git.fdmanana@suse.com>
 <6b6ee2a2-882b-4df8-982b-157c15b07da0@wdc.com>
In-Reply-To: <6b6ee2a2-882b-4df8-982b-157c15b07da0@wdc.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Tue, 17 Dec 2024 13:31:02 +0000
X-Gmail-Original-Message-ID: <CAL3q7H5pm_cr-11LJHxUGEFCL=nVQBQ08owsxfP-N0P3oX_gJw@mail.gmail.com>
Message-ID: <CAL3q7H5pm_cr-11LJHxUGEFCL=nVQBQ08owsxfP-N0P3oX_gJw@mail.gmail.com>
Subject: Re: [PATCH] btrfs: use uuid_is_null() to verify if an uuid is empty
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 17, 2024 at 1:27=E2=80=AFPM Johannes Thumshirn
<Johannes.Thumshirn@wdc.com> wrote:
>
> On 17.12.24 13:14, fdmanana@kernel.org wrote:
> > From: Filipe Manana <fdmanana@suse.com>
> >
> > At btrfs_is_empty_uuid() we have our custom code to check if an uuid is
> > empty, however there a kernel uuid library that has a function named
> > uuid_is_null() which does the same and probably more efficient.
> >
> > So change btrfs_is_empty_uuid() to use uuid_is_null(), which is almost
> > a directy replacement, it just wraps the necessary casting since our
>      ^~ directly

Pushed to for-next with the typo fixed.
Thanks.

>
>
> Other than that,
> Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

