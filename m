Return-Path: <linux-btrfs+bounces-16563-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7B40B3E79E
	for <lists+linux-btrfs@lfdr.de>; Mon,  1 Sep 2025 16:47:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00BEA3AF5D4
	for <lists+linux-btrfs@lfdr.de>; Mon,  1 Sep 2025 14:46:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE6A93451D5;
	Mon,  1 Sep 2025 14:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a9x/hsH4"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06B713451C8
	for <linux-btrfs@vger.kernel.org>; Mon,  1 Sep 2025 14:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756737899; cv=none; b=LIr412RBKqOcm1BNWIMvIWj6y9ZcWzorSspr/WQcslpEoZ5j5fifCvPOT0SF83LZ3Vbcv/U2F6aWlZW6xOfC00G1707UECrY/N4U/hFVkJmLz7MJXy7aaicei5IoZPEe6BURlk+5twm4ucUntpOwWlelyJC9qbU6wTHIw/Og9uM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756737899; c=relaxed/simple;
	bh=i0HCcLdvLrLyZgDYkj/sk4Ygbcf47ahXIa+UucXEUxs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AIz6jDPPMod2uNQ1ALAc1BlRw1cw8wM7g1Lc7gCWqk4YWSOWnfSa610M4W2NZLuKBTiz4eiTgLocHUBsL2sOdNbO/d+GSg2gKLdef7b483FzQ6xy+UnCr8adFueig1sdaYLSICZGnDXife2UFEyj5R71Zt+t0eaJ3fvU/nmfLHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a9x/hsH4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66BCFC4CEF0
	for <linux-btrfs@vger.kernel.org>; Mon,  1 Sep 2025 14:44:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756737898;
	bh=i0HCcLdvLrLyZgDYkj/sk4Ygbcf47ahXIa+UucXEUxs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=a9x/hsH44GjaoDqgTo4WbHtM90FYaqKrwDnRrgZ6GBzmqUffGPvU+mNeGIv7lOoNS
	 zJmz23F2JcG/Z8AMI5+Y2WdvpnC4KiUztk+3EPcBqZyz95hUIYTiOJs+PepiHlC5dM
	 PqI//0THfOMMCDsVQTDsosaLRUoPS/tMTB0FME3TB954gqJGGqNdXZefCDZzMO9+Qm
	 sUs+f0q5XD9yvnjxkUXbwmdwW2LklKhOc1BWtwNw4YBdfxXQicL2N0TC4Xt49UDP4x
	 u1ZJy5GxMy/cxQ+I+yDhsqk6jZVeptSx7GmF+bJuhboS/XICUSN0p6C7p3/XU1rFhO
	 oz9jX0C3iDCvA==
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b04163fe08dso254471966b.3
        for <linux-btrfs@vger.kernel.org>; Mon, 01 Sep 2025 07:44:58 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVvZXMEK3TA9Y8/p+rOv25Bh7fSJdOc3WE6IkNSoPADwi4HjNJjxn0O5181SGDE1eBa9rr3MWQpdjy+Fg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyFborACOHoIcEc7b9nTIwNmI5hRJXVJyWTetY0gKODPZZtmg7M
	TELNGiQiBcpzeTu+U44yDn83pHqj+nCfPHFmStuyh/FhGTwCNKOE4qMcbjeLypcaFUpyL+ioBab
	examKFZOF8efILLFuEFZHhI0cgob8LS4=
X-Google-Smtp-Source: AGHT+IFqqIQROTiQdNrH6eBi/0E6bhLoBhWvgb4dirMQNEgXMfecq++zQq8xWJ3xjKZ6+nzGgAeeUD4iHudJ3RFsfH0=
X-Received: by 2002:a17:907:5c1:b0:afe:d2e1:9018 with SMTP id
 a640c23a62f3a-b01d8c86721mr834031866b.25.1756737896974; Mon, 01 Sep 2025
 07:44:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <5923969.DvuYhMxLoT@saltykitkat> <2386271.ElGaqSPkdT@saltykitkat>
In-Reply-To: <2386271.ElGaqSPkdT@saltykitkat>
From: Filipe Manana <fdmanana@kernel.org>
Date: Mon, 1 Sep 2025 15:44:20 +0100
X-Gmail-Original-Message-ID: <CAL3q7H4-2xpzaWGNsAcrY9xY=DwH96X05ENTaUMDwZt4YcObiQ@mail.gmail.com>
X-Gm-Features: Ac12FXylVoa1qBOgW8HWbgWkTSKt5gkGXoatR09pq6l2Y5gO6o44sHWqtyk3h_Y
Message-ID: <CAL3q7H4-2xpzaWGNsAcrY9xY=DwH96X05ENTaUMDwZt4YcObiQ@mail.gmail.com>
Subject: Re: [PATCH v3] btrfs: more trivial BTRFS_PATH_AUTO_FREE conversions
To: Sun YangKai <sunk67188@gmail.com>
Cc: quwenruo.btrfs@gmx.com, dsterba@suse.cz, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 1, 2025 at 8:55=E2=80=AFAM Sun YangKai <sunk67188@gmail.com> wr=
ote:
>
> > My bad.
> >
> > I mistakenly removed some cleanup code without converting it to use
> > BTRFS_PATH_AUTO_FREE. Thanks a lot for catching this.
>
> Given the number of code lines, it's difficult to identify exactly what w=
as
> missing, so I wrote a Python script to help verify the patch. Hopefully, =
we
> haven't missed anything this time.

Suggestion: test your patches with fstests - it would have avoided
this problem as well as the previous one with the send change reported
by the test robot [1].

Thanks.

[1] https://lore.kernel.org/linux-btrfs/202508291655.c99c34a4-lkp@intel.com=
/

>
> Here are the missing parts:
>
> diff --git a/fs/btrfs/root-tree.c b/fs/btrfs/root-tree.c
> index c7f7c55b7c28..d1f5f6c42ef3 100644
> --- a/fs/btrfs/root-tree.c
> +++ b/fs/btrfs/root-tree.c
> @@ -130,7 +130,7 @@ int btrfs_update_root(struct btrfs_trans_handle *tran=
s,
> struct btrfs_root
>                       *item)
>  {
>         struct btrfs_fs_info *fs_info =3D root->fs_info;
> -       struct btrfs_path *path;
> +       BTRFS_PATH_AUTO_FREE(path);
>         struct extent_buffer *l;
>         int ret;
>         int slot;
> diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
> index b32e2f2e5436..06d45890df85 100644
> --- a/fs/btrfs/tree-log.c
> +++ b/fs/btrfs/tree-log.c
> @@ -1717,7 +1717,7 @@ static noinline int fixup_inode_link_count(struct
> btrfs_trans_handle *trans,
>                                            struct btrfs_inode *inode)
>  {
>         struct btrfs_root *root =3D inode->root;
> -       struct btrfs_path *path;
> +       BTRFS_PATH_AUTO_FREE(path);
>         int ret;
>         u64 nlink =3D 0;
>         const u64 ino =3D btrfs_ino(inode);
>
>
>
>
>

