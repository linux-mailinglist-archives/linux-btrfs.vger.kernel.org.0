Return-Path: <linux-btrfs+bounces-14944-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 20EAFAE8065
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Jun 2025 12:57:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2DACB16C7B0
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Jun 2025 10:56:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FC6329E10D;
	Wed, 25 Jun 2025 10:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SfbaPW4x"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75DA12BCF66
	for <linux-btrfs@vger.kernel.org>; Wed, 25 Jun 2025 10:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750848912; cv=none; b=uPyQ/dKbPSNzq74HP0BXnGwq0akP3k7toqLyoE7QzhBs6Ua28qDxgxlEClNOz5QfNpYWZ5nxmjvHpfffpk8nEu25ZcFM3Czw7iskgIxba5yygzHcZ3m0IYxhZtSXQIv/irg4N6ybKjwlVmdRWqesiJMUo+qPtWfM6AyVpqag2oM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750848912; c=relaxed/simple;
	bh=x13+z6udPET8xfe647Mpsz14xqQk2ySDyatNUEKx3ZM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EuYvuznfF9cZJj8CHXk/ooW8VaVhEMT7QijY6NogOdPNODOMMXyKUTb6W+q6XEoA1L1sVHpZnSH3gVRLZU6vBfgTXROuL4VFRkc5/a5Wr6CU2ixEPPPl46mlHqY7eQXa/CThKG2gRdBTznigc0RVOnThmZ6Sh2JFrCScKOqY8l0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SfbaPW4x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0690CC4CEF0
	for <linux-btrfs@vger.kernel.org>; Wed, 25 Jun 2025 10:55:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750848911;
	bh=x13+z6udPET8xfe647Mpsz14xqQk2ySDyatNUEKx3ZM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=SfbaPW4xBLoCRpF/pLnnlTYSjC98FPYPlxQativCR0eaZ5lqHoVkKgIUHvG9d6Cl+
	 ez4H7eo2Q0hpLH3v2tnLTs17Hz892PuBBk4TdSiLFzMMMU9maiNagpoohA2hAvi5WZ
	 avNYBaLgYeeC2AU/jJ5t4+cl+5stZhAIwStoOiB8eBk6FMgBr+E31yLGlaZD32HeGY
	 PV8qv846/wp8qlCZ7rtiWaXVEvwO3xr5SghRZ/bcgokoNXKtq5FfjDnzcM6yXxAlV/
	 iox+QkrfKsSGVByisxD1NqMrMiOwLT+vWck8e1Fddjt61ua5H+lfj0+n6tsLYCMZiH
	 ArauTNgxh8DTw==
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-ad883afdf0cso272998066b.0
        for <linux-btrfs@vger.kernel.org>; Wed, 25 Jun 2025 03:55:10 -0700 (PDT)
X-Gm-Message-State: AOJu0YzWkt3ROOBdOhJRbDyIMxGkx2GMNKbpbCS6jp9FjlHJ+KMpYsDz
	ORjqmG5S5cqrUwNzAu0t/8c3syShY55EMZr/dUSFChlyH8lU3I+LTIXxx0G69Yk/2wkYuHLdGxf
	IvQvLank/TXe45Nbm7kcewPbq0onHKqM=
X-Google-Smtp-Source: AGHT+IE4o0ZV1B0hYpUcmV2zS4Mizxq4mtFvWNHpSkVLl7ge3D3iUkl8REKxPqvPGT9EzyaRsW04AVi8egYKuNo/zDY=
X-Received: by 2002:a17:907:3cd6:b0:ae0:5fbf:7de0 with SMTP id
 a640c23a62f3a-ae0be9da16fmr229772866b.36.1750848909561; Wed, 25 Jun 2025
 03:55:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1750709410.git.fdmanana@suse.com> <e1789e1dbfdb73b930d74d6eae8b728d8241cabd.1750709411.git.fdmanana@suse.com>
 <788c44b8-2299-4ef5-871c-ab28eac99c80@wdc.com>
In-Reply-To: <788c44b8-2299-4ef5-871c-ab28eac99c80@wdc.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Wed, 25 Jun 2025 11:54:32 +0100
X-Gmail-Original-Message-ID: <CAL3q7H51QsvK+z41LscG7=UmzaNjETWbHLxNP_seb7VCRab2Wg@mail.gmail.com>
X-Gm-Features: Ac12FXx3YdstdpnZe_qyIH6AosXXSkpADmITJnjTa5YWKspQqf3LD1WMyl4zFJ8
Message-ID: <CAL3q7H51QsvK+z41LscG7=UmzaNjETWbHLxNP_seb7VCRab2Wg@mail.gmail.com>
Subject: Re: [PATCH 07/12] btrfs: use inode already stored in local variable
 at btrfs_rmdir()
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 25, 2025 at 11:52=E2=80=AFAM Johannes Thumshirn
<Johannes.Thumshirn@wdc.com> wrote:
>
> On 24.06.25 16:55, fdmanana@kernel.org wrote:
> > From: Filipe Manana <fdmanana@suse.com>
> >
> > There's no need to call d_inode(dentry) when calling btrfs_unlink_inode=
()
> > since we have already stored that in a local inode variable. So just us=
e
> > the local variable to make the code less verbose.
> >
> > Signed-off-by: Filipe Manana <fdmanana@suse.com>
> > ---
> >   fs/btrfs/inode.c | 3 +--
> >   1 file changed, 1 insertion(+), 2 deletions(-)
> >
> > diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> > index 12141348236d..f8e4651fe60b 100644
> > --- a/fs/btrfs/inode.c
> > +++ b/fs/btrfs/inode.c
> > @@ -4759,8 +4759,7 @@ static int btrfs_rmdir(struct inode *dir, struct =
dentry *dentry)
> >               goto out;
> >
> >       /* now the directory is empty */
> > -     ret =3D btrfs_unlink_inode(trans, BTRFS_I(dir), BTRFS_I(d_inode(d=
entry)),
> > -                              &fname.disk_name);
> > +     ret =3D btrfs_unlink_inode(trans, BTRFS_I(dir), BTRFS_I(inode), &=
fname.disk_name);
> >       if (!ret)
> >               btrfs_i_size_write(BTRFS_I(inode), 0);
> >   out:
>
>
> I'd personally add a local
> 'struct btrfs_inode *binode =3D BTRFS_I(inode);'
> to the function as it can be used multiple time, this sparing us
> multiple calls to BTRFS_I() (which is cheap I know) and improves code
> readability.

Which is what one of the next patches does...

