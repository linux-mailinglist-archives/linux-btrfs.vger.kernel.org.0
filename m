Return-Path: <linux-btrfs+bounces-7049-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 607EB94BC68
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 Aug 2024 13:40:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D4FE4B20E79
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 Aug 2024 11:40:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA6B818B475;
	Thu,  8 Aug 2024 11:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u+IN+mMF"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2335A12C7FD
	for <linux-btrfs@vger.kernel.org>; Thu,  8 Aug 2024 11:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723117214; cv=none; b=SFC98xtsviz1jXIlpUTbXLvDhv2lAaSTGoktzKB82HGjhMK7lULzTTo0IFb8BCg3MdXhFYfdW9snTC7lcGZTCLLbL0FwxmpoJV1ow+i/L9VoxsIxM8MK0nRrPV+RsMxqRxx/3nhXEV6r9jY4bx/YkFgdeWrZGBPtjbQLM79RA60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723117214; c=relaxed/simple;
	bh=G4NC0gIXdmIBVMHfqLxLanDvvGJyIZ4ov6Fs/t7FoHk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cxRuR4+bDjkCvU+Ax/SDEUuCHbongVRmoUM/4nWWcsNbEDauV8Olz1M7o9OmspZTH04TZb+PMeyFcq8YMP7hIlxYhXcFHwbAqPfnUujV4LehC1+pdOjM8CVKQN1d0JiG+8+u8d6YwezGQkVomNTLtRsoqp8Jn2Q9J1ZABDM1u1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u+IN+mMF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99BEFC4AF09
	for <linux-btrfs@vger.kernel.org>; Thu,  8 Aug 2024 11:40:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723117213;
	bh=G4NC0gIXdmIBVMHfqLxLanDvvGJyIZ4ov6Fs/t7FoHk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=u+IN+mMFf5urLh8QlcrwLctBQjt2eW3l0pymtq05dWsWO9AO2menoTJ62G423UBsU
	 Dl/0K7s97qMJS1fKzMice5OzgX6xwlevSacDgxny3hyfCn1pJtq2M1spXjl0evehFs
	 HnvSRtxtUMJU9pv9n7VLfiTHhsF+imj9182DyZoKO0AL/D5ntSfXtdmA0f9uTogthO
	 XnBGCT1gPOGImJxLuvV/FFRxRam3023Nwx628TGOZEba9W555PCa0JHYjoTeMTZ5qh
	 JpkTeBOjfcYBa1AjeRx9GPzdhgt9PKCvilBYRnw0sgaSIjAU4Orb0FwcR4OkF70886
	 /ikgP/z5p7xxg==
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5b391c8abd7so975564a12.2
        for <linux-btrfs@vger.kernel.org>; Thu, 08 Aug 2024 04:40:13 -0700 (PDT)
X-Gm-Message-State: AOJu0Yz49FQD9xcrTMAiY+3n3J74jYzt0f0OHqaseEEzkR4x5jE7HA+i
	M0JqJTGKG7vxQxjMIBkVBapGGvt5R//6uxt1muV1wya9sp8l1YZrDbNSWqwtNCoeylmZr0Rjoue
	YYFwYkaGgdxOQgKgz5e+XdEf299o=
X-Google-Smtp-Source: AGHT+IH2NFORrTixai1mnBtyiSSljEnx9qNTKNqy3ioqKu8pK8HNNM081k2JpIN8SqxfYieafYrpKerCbZKdss6JlBU=
X-Received: by 2002:a17:907:da0:b0:a7a:c106:3647 with SMTP id
 a640c23a62f3a-a8090f04205mr153728366b.58.1723117212190; Thu, 08 Aug 2024
 04:40:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1723096922.git.wqu@suse.com> <f1232d0ffc8ae7389206d4cc9210afc77cfcacac.1723096922.git.wqu@suse.com>
In-Reply-To: <f1232d0ffc8ae7389206d4cc9210afc77cfcacac.1723096922.git.wqu@suse.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Thu, 8 Aug 2024 12:39:35 +0100
X-Gmail-Original-Message-ID: <CAL3q7H5CmFUegQqEY0BZU79tBQoJFkX46vDenrCVKu3rmNDQrw@mail.gmail.com>
Message-ID: <CAL3q7H5CmFUegQqEY0BZU79tBQoJFkX46vDenrCVKu3rmNDQrw@mail.gmail.com>
Subject: Re: [PATCH 2/2] btrfs: utilize cached extent map for data writeback
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 8, 2024 at 7:06=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrote:
>
> Unlike data read, we never really utilize the cached extent_map for data
> write.
>
> This means we will do the costly extent map lookup for each sector we
> need to write back.
>
> Change it to utilize the same function, __get_extent_map(), just like
> the data read path, to reduce the overhead of extent map lookup.
>
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/extent_io.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index d4ad98488c03..9492cd9d4f04 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -1357,7 +1357,8 @@ static int submit_one_sector(struct btrfs_inode *in=
ode,
>         /* @filepos >=3D i_size case should be handled by the caller. */
>         ASSERT(filepos < i_size);
>
> -       em =3D btrfs_get_extent(inode, NULL, filepos, sectorsize);
> +       em =3D __get_extent_map(&inode->vfs_inode, NULL, filepos, sectors=
ize,
> +                             &bio_ctrl->em_cached);
>         if (IS_ERR(em))
>                 return PTR_ERR_OR_ZERO(em);
>
> @@ -2320,6 +2321,7 @@ void extent_write_locked_range(struct inode *inode,=
 const struct folio *locked_f
>                 cur =3D cur_end + 1;
>         }
>
> +       free_extent_map(bio_ctrl.em_cached);
>         submit_write_bio(&bio_ctrl, found_error ? ret : 0);
>  }
>
> @@ -2338,6 +2340,7 @@ int btrfs_writepages(struct address_space *mapping,=
 struct writeback_control *wb
>          */
>         btrfs_zoned_data_reloc_lock(BTRFS_I(inode));
>         ret =3D extent_write_cache_pages(mapping, &bio_ctrl);
> +       free_extent_map(bio_ctrl.em_cached);
>         submit_write_bio(&bio_ctrl, ret);

Same comment as in the first patch, instead of duplicating
free_extent_map() calls before submit_write_bio() calls, just move the
free_extent_map() to inside of submit_write_bio() and
then also set ->em_cached to NULL after the free. This helps avoid
use-after-free issues and someone forgetting a free call in the
future.

Thanks.

>         btrfs_zoned_data_reloc_unlock(BTRFS_I(inode));
>         return ret;
> --
> 2.45.2
>
>

