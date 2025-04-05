Return-Path: <linux-btrfs+bounces-12815-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36B04A7CB1F
	for <lists+linux-btrfs@lfdr.de>; Sat,  5 Apr 2025 19:55:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F13893B9B7B
	for <lists+linux-btrfs@lfdr.de>; Sat,  5 Apr 2025 17:55:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A7FD199FD0;
	Sat,  5 Apr 2025 17:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HOcva5X1"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C66170838
	for <linux-btrfs@vger.kernel.org>; Sat,  5 Apr 2025 17:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743875728; cv=none; b=DdLHKD9hkNwON+L+tBo0NYLCybwE5UXDeGeOYGPOAMfkbn4JVsTf2oh5ibnjuNa0v2kfSToxx1Z94DSdBB4WqGMECjB0lErEVk6H95dljW0Nud+s2pnTuHLN/RijmpBxDEbD5I118IBYQl1OkZHDmApY1K3AfIbM5QsEuwlpMu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743875728; c=relaxed/simple;
	bh=I3t1u5pUqChkSVcD+ZHvFqbfclxCvJ/VZSEOzaQyBaY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pI+Tfh2eEmEQW1d4QmAmJR6FtFZAKTDxzHYncvG50EeKwURxVi+XMW/SEV0w7PTQBBiuU8Ykp39TGTT9PV9OtMHPky3JGLL8qulLzGp7Vz3viVmxxgO3nU6VNxNi5wVrOBJtd4qSKFCY6z5OaWg81pviwcXPC0K4bgSPmgChJ6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HOcva5X1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D31A2C4CEE5
	for <linux-btrfs@vger.kernel.org>; Sat,  5 Apr 2025 17:55:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743875727;
	bh=I3t1u5pUqChkSVcD+ZHvFqbfclxCvJ/VZSEOzaQyBaY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=HOcva5X1clz9wPhn0Rc6ycNBUdfFyxZzXa4USkEjeE0s3Q99CAxA+Fiz0oR91mNmu
	 o2n8DYRD1tS4tirHcIIBwwP4l92oAnnpw/dDCdwssyAJqR6m3APgKLb8NHPr591z9y
	 9BMQmR4lemYZ/tyU6LmOYZ1iZkTqx3TAokojwDjgjTycdwqcqr+5C7CSNcK4QRWaFM
	 +q99PKiwZRfb1CWOn504WsXA/qIEodOdhVFisOgnB1waT5p4yuiLEjnZa1HDkrsI/v
	 GrhyzWv6vIqnI/h8Y6ukCvvgWwwtH6Rba5EY6KvvADaW0d7MBnKeHzcZNJci1udM0p
	 jpGAkYp5lOcQQ==
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-ac7bd86f637so527892366b.1
        for <linux-btrfs@vger.kernel.org>; Sat, 05 Apr 2025 10:55:27 -0700 (PDT)
X-Gm-Message-State: AOJu0YzLMV3pLmArklO+vng41pqeQg3GqjRoGlPQ+51qOCwWTbbsXRUj
	+TeJR55b4AZ/kxfe5zSI3Ci6ocdOiIykgm4T4kUBW6Q83+IO+JPbWVmvC+ZIYJymBPjRcTRpAjF
	5wTsLTKgW49f+tW8B9QodVYuKKvY=
X-Google-Smtp-Source: AGHT+IE9ZuNn8XbdgFKSdGyF2WGXBnx6Tdm1yy4tlQmyo2XmSDLGgJgXqqXEPGSPVspe93nKETeJPCJMoWtrZw72CIk=
X-Received: by 2002:a17:907:7e8b:b0:ac4:3d0:8bca with SMTP id
 a640c23a62f3a-ac7d303b8b1mr708146666b.29.1743875726408; Sat, 05 Apr 2025
 10:55:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1743731232.git.wqu@suse.com> <39d3966f896f04c3003eb9a954ce84ff33d51345.1743731232.git.wqu@suse.com>
 <CAL3q7H5vSyG3zpCZ5hbPT8aR2-xODazLwcKhWGhJYUUMLTus1w@mail.gmail.com> <dc2618d9-0ff8-40f1-b5e7-93644fbbe17c@suse.com>
In-Reply-To: <dc2618d9-0ff8-40f1-b5e7-93644fbbe17c@suse.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Sat, 5 Apr 2025 17:54:49 +0000
X-Gmail-Original-Message-ID: <CAL3q7H6bXsyK0Yhmo4yzULdunyoMJFmTxwPmR947uvWsnSCzwg@mail.gmail.com>
X-Gm-Features: ATxdqUFUd-yHfAJCG-_VHyQe_8AHYX_w-fQGJO4Om69wmDv6IVLWwYLz-587wNY
Message-ID: <CAL3q7H6bXsyK0Yhmo4yzULdunyoMJFmTxwPmR947uvWsnSCzwg@mail.gmail.com>
Subject: Re: [PATCH 1/3] btrfs: remove unnecessary early exits in delalloc
 folio lock and unlock
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 4, 2025 at 10:44=E2=80=AFPM Qu Wenruo <wqu@suse.com> wrote:
>
>
>
> =E5=9C=A8 2025/4/5 02:34, Filipe Manana =E5=86=99=E9=81=93:
> > On Fri, Apr 4, 2025 at 2:48=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrote:
> >>
> >> Inside function unlock_delalloc_folio() and lock_delalloc_folios(), we
> >
> > function -> functions
> >
> >> have the following early exist:
> >
> > exist -> exit
> >
> >>
> >>          if (index =3D=3D locked_folio->index && end_index =3D=3D inde=
x)
> >>                  return;
> >>
> >> This allows us to exist early if the range are inside the same locked
> >
> > exist -> exit
> > the range are inside -> the range is inside
> >
> >> folio.
> >>
> >> But even without the above early check, the existing code can handle i=
t
> >> well, as both __process_folios_contig() and lock_delalloc_folios() wil=
l
> >> skip any folio page lock/unlock if it's on the locked folio.
> >>
> >> Just remove those unnecessary early exits.
> >
> > It looks good to me from a functional point of view.
> >
> > But without this early exits there's a bit of work done, from function
> > calls to initializing and releasing folio batches, calling
> > filemap_get_folios_contig()  which
> > will search the mapping's xarray and always grab one folio and add it
> > to the batch, etc.
> >
> > It's not uncommon to do IO on a range not spanning more than one
> > folio, especially when supporting large folios, which will be more
> > likely.
> > I understand the goal here is to remove some code, but this code is
> > cheaper compared to all that unnecessary overhead.
> >
> > Have you considered that?
>
> Yes, but the main reason here is the usage of (folio->index =3D=3D index)=
 check.
>
> With  large folios, such check is no longer reliable anyway, and
> initially I thought to just change it to folio_contains(), but it turns
> out that is not really needed either.
>
> So that's the main reason to get rid this of these early exits.

Ok.

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Thanks.

>
> Thanks,
> Qu
>
> >
> > Thanks.
> >
> >>
> >> Signed-off-by: Qu Wenruo <wqu@suse.com>
> >> ---
> >>   fs/btrfs/extent_io.c | 8 --------
> >>   1 file changed, 8 deletions(-)
> >>
> >> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> >> index 8b29eeac3884..013268f70621 100644
> >> --- a/fs/btrfs/extent_io.c
> >> +++ b/fs/btrfs/extent_io.c
> >> @@ -224,12 +224,7 @@ static noinline void unlock_delalloc_folio(const =
struct inode *inode,
> >>                                             const struct folio *locked=
_folio,
> >>                                             u64 start, u64 end)
> >>   {
> >> -       unsigned long index =3D start >> PAGE_SHIFT;
> >> -       unsigned long end_index =3D end >> PAGE_SHIFT;
> >> -
> >>          ASSERT(locked_folio);
> >> -       if (index =3D=3D locked_folio->index && end_index =3D=3D index=
)
> >> -               return;
> >>
> >>          __process_folios_contig(inode->i_mapping, locked_folio, start=
, end,
> >>                                  PAGE_UNLOCK);
> >> @@ -246,9 +241,6 @@ static noinline int lock_delalloc_folios(struct in=
ode *inode,
> >>          u64 processed_end =3D start;
> >>          struct folio_batch fbatch;
> >>
> >> -       if (index =3D=3D locked_folio->index && index =3D=3D end_index=
)
> >> -               return 0;
> >> -
> >>          folio_batch_init(&fbatch);
> >>          while (index <=3D end_index) {
> >>                  unsigned int found_folios, i;
> >> --
> >> 2.49.0
> >>
> >>
>

