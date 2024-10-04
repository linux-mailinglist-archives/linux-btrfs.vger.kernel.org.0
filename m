Return-Path: <linux-btrfs+bounces-8555-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 94B069901D4
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Oct 2024 13:09:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 494CB1F2378F
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Oct 2024 11:09:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C766156F57;
	Fri,  4 Oct 2024 11:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NZCVKWpS"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 677771553A3;
	Fri,  4 Oct 2024 11:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728040153; cv=none; b=OIVdb8uQMoMbjdzwRz/Z9uBCHEZ1Xy5UCiA7s/G5fABeptfZa9kROPTUClQv184JUeiPnTbYiDvPcVZEO2OYCzYrfzbXOKk/7ptrW06RnUfjZMnq8WrLqr8gHwo4E4anrtOaA7UnFHqi3wV7dxNpXwyQXMBQVLyUJXMsJ6cFupw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728040153; c=relaxed/simple;
	bh=5dobc/ppI/GY4fjwxBSWrqeHqEpC0NCOBHNV47QAtuM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iibd3EdejzZ3vOrWETU7U4jNJpR4Qr9yMg9ngKvdvtDxRA9reBBTB29rmvAFrJgJMVwdaxJ+jhQ+io/y54tAFNcbCrwOD+etvmysGJjDeea/K/gNWQa5qtD/cw3IYY9uU9dCTv3zLZ5UShBypASgB5E92V/F8o1OJQH245HckwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NZCVKWpS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05517C4CECF;
	Fri,  4 Oct 2024 11:09:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728040153;
	bh=5dobc/ppI/GY4fjwxBSWrqeHqEpC0NCOBHNV47QAtuM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=NZCVKWpSDYHcm1wtW94b5oCB/ho8uqizVZGqtnkZh4W7h8J2Srx39qVi5y6SvmtOB
	 giiRO90Fx3K2OcmUpcITOgYQG34OrKdlNhqPWGmgvINeR1O44ExExh0LmC7JyCsdYp
	 vmxHnU4ngPY8Q2h0tPQCn7VKCOsWGBjdc5WyVEIw9XmaQ2HCv1/wWWiDIdH5JkHGCW
	 9rVbiQkkbiJTNGpwLkYEIB6VwVYF3injZZklRNnm7R4teus/TJjtYjL978doOJ99T9
	 xD/IvhhZcc6r4jpAK+Q52lYBXG77BLq6bbWRTlzbCu48p5tLS8z6LoJqD6lPkpsZvS
	 Ka2eaqogDvPIQ==
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5c88e4a7c53so2176372a12.0;
        Fri, 04 Oct 2024 04:09:12 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVDGWeIeGPUtrD5R+wSPGpTn8TAY4W/xxvcWi9D2qnh4lX15bUXR7pECHcMVNLecaZ9Q1zy21OtbKn1bSZW@vger.kernel.org, AJvYcCVam7K9Fe+Ctv5bBcQuzfzvDpyk0rOu/wjxMVcvnVEY6AQiAYgum7ak2WxUvRaO32+aRXphHKaKLhHLJQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzmiVNpnZ+xXiloroD9c06LY/FUv1n2J9e0rWE6gf5IkyYkIl3D
	TJYdwtsRAOjXX5/PkoFLqReQE3QdH+8djgbE9niKgdzv7+EjDDafnqUkKrVMT9+6MaYA9D3jgiz
	VdvkEJAfSR/0eiAm7odSME0flFSk=
X-Google-Smtp-Source: AGHT+IF2gktiypMt1MSg0qcwWQompkJIKptsfPY2AM5dPRFfG9SRpi5mqScOBaEbBVOUB/J9GuJ0ZTjGRV6HIRZodeA=
X-Received: by 2002:a17:907:f153:b0:a8a:8c04:ce95 with SMTP id
 a640c23a62f3a-a991bdbffa4mr227548666b.43.1728040151461; Fri, 04 Oct 2024
 04:09:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241004105333.15266-1-jth@kernel.org>
In-Reply-To: <20241004105333.15266-1-jth@kernel.org>
From: Filipe Manana <fdmanana@kernel.org>
Date: Fri, 4 Oct 2024 12:08:34 +0100
X-Gmail-Original-Message-ID: <CAL3q7H48ntW+Fi-=FrZyCgxSBv25KAyh-H5tDGwLFQsOnWmXAQ@mail.gmail.com>
Message-ID: <CAL3q7H48ntW+Fi-=FrZyCgxSBv25KAyh-H5tDGwLFQsOnWmXAQ@mail.gmail.com>
Subject: Re: [PATCH v2] btrfs: don't BUG_ON() NOCOW ordered-extents with
 checksum list
To: Johannes Thumshirn <jth@kernel.org>
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>, 
	"open list:BTRFS FILE SYSTEM" <linux-btrfs@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	Qu Wenruo <wqu@suse.com>, Johannes Thumshirn <johannes.thumshirn@wdc.com>, 
	Filipe Manana <fdmanana@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 4, 2024 at 11:53=E2=80=AFAM Johannes Thumshirn <jth@kernel.org>=
 wrote:
>
> From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
>
> Currently we BUG_ON() in btrfs_finish_one_ordered() if we finishing an
> ordered-extent that is flagged as NOCOW, but it's checsum list is non-emp=
ty.
>
> This is clearly a logic error which we can recover from by aborting the
> transaction.
>
> For developer builds which enable CONFIG_BTRFS_ASSERT, also ASSERT() that=
 the
> list is empty.
>
> Suggested-by: Filipe Manana <fdmanana@suse.com>
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---
> Changes to v1:
> * Fixup if () and ASSERT() (Qu)
> * Fix spelling of 'Currently'
> ---
>  fs/btrfs/inode.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 103ec917ca9d..e57b73943ab8 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -3088,7 +3088,10 @@ int btrfs_finish_one_ordered(struct btrfs_ordered_=
extent *ordered_extent)
>
>         if (test_bit(BTRFS_ORDERED_NOCOW, &ordered_extent->flags)) {
>                 /* Logic error */
> -               BUG_ON(!list_empty(&ordered_extent->list));
> +               if (!list_empty(&ordered_extent->list)) {
> +                       ASSERT(list_empty(&ordered_extent->list));

I find this confusing and not so easy to grasp immediately. It's the
same as older places where we have:

if (unexpected condition) {
   ASSERT(0);
   (...)
}

I find it more natural and less confusing to just do:

ASSERT(list_empty(&ordered_extent->list));
if (unlikely(!list_empty(&ordered_extent->list))) {
    ret =3D -EINVAL;
    btrfs_abort_transaction(trans, ret);
    goto out;
}

> +                       btrfs_abort_transaction(trans, -EINVAL);
> +               }

This also misses setting 'ret' to the error and the goto into the
label 'out', as I've placed in the example above.

Thanks.

>
>                 btrfs_inode_safe_disk_i_size_write(inode, 0);
>                 ret =3D btrfs_update_inode_fallback(trans, inode);
> --
> 2.43.0
>
>

