Return-Path: <linux-btrfs+bounces-17178-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 420D9B9EEFD
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 Sep 2025 13:36:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F02C04C2AC3
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 Sep 2025 11:36:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36D312FB63E;
	Thu, 25 Sep 2025 11:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CQwUdXLF"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A5A9288C2D
	for <linux-btrfs@vger.kernel.org>; Thu, 25 Sep 2025 11:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758800196; cv=none; b=dNMAOp6VnKvo0MvNPJnlTnGVshz7b0YAf1By+b2APRUs283fqaKKP6X57jasMcCPYEHqN0XrnaoscroCVPjJFg1c0PtZ0OduAz8nga3jvdstE+Khk3JO3QQtMjfNk+FDtf1Mh5nqnctt/rOUVNP+h1DK/SeaASx5lKyXF6O0oC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758800196; c=relaxed/simple;
	bh=arIuKDEdL9GUfeBJ5T07cmMhE8mRrwPF4wygDxxAH88=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Jpgj9hkyZR4Z8okqstu5/JPza3jglSnmVp+/X3KplH89bZCrztN5+Lod99e/3EAK0oWEl88oItPYd8281hcpWZL1keT8S3lFaP93HBphZ9ZeyOfjdQQGJduWzZZ56hgg+9ixx9VGp1lxBciD40UyVwf0bKn2+dFzi9SwYfPxUtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CQwUdXLF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CB78C4CEF5
	for <linux-btrfs@vger.kernel.org>; Thu, 25 Sep 2025 11:36:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758800196;
	bh=arIuKDEdL9GUfeBJ5T07cmMhE8mRrwPF4wygDxxAH88=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=CQwUdXLFupsL61oPZtwhTMcfo4JHON9QvT/821ZUsP3MHC6S2YYTcPNKMUsicfQQv
	 gWwczcXejzMEKbC1KQNWXivmtqS95uGItfLnudb7wLWjFOaig3v9BoeVmHgVDkjgsp
	 lIE3fxnlBwHvtMKiF7bFnJBu8PZZi8l427vAUa1MjuLv5zOtSYy4cQvTJEnsqVFL5X
	 tb4cgPRVj/PVMYuMULeJhUHq2Gvemi3yHyhBoyeIzCAu4nyABzfOS//cXRe0yjF//O
	 PgwKpCDgCrq0JwM4WxHWr2N0GPifKUOa+cz29QS7uho1DPRVmp3LoPP6e57aBGv6tk
	 caBImoSjbuuTg==
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-62f24b7be4fso1735415a12.0
        for <linux-btrfs@vger.kernel.org>; Thu, 25 Sep 2025 04:36:36 -0700 (PDT)
X-Gm-Message-State: AOJu0Yy7Q3GKGtRAD1iCPbOFLxCjyjbS7vk5fjhOuxOJGzw/A5zYBRuW
	OfcZ0WdolEQ9iFqyuQHRO2hdrgIIisft8CGC6s9oHPRzqSnSiB8MPfiT4CpjiKasJsThcIm83Bq
	Zm6CtfViTuG6miyEirYU+yNEpz9CzYLA=
X-Google-Smtp-Source: AGHT+IHcFVJux2FFedqLuMQsDNG/xhBaa1463cfpIadQKxayT9PTpkv1ZjCm3wifdLCNGsDz+4+gJ5Hd+Ux6KAfoIoY=
X-Received: by 2002:a17:906:d85:b0:af9:a5f8:2f0c with SMTP id
 a640c23a62f3a-b34df804039mr262600366b.28.1758800194845; Thu, 25 Sep 2025
 04:36:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1758732655.git.fdmanana@suse.com> <ae43088c97c0423deee961c58e9eca4c4aff2e88.1758732655.git.fdmanana@suse.com>
 <eeed482d-6290-4877-992a-2abe1f9a0e35@wdc.com>
In-Reply-To: <eeed482d-6290-4877-992a-2abe1f9a0e35@wdc.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Thu, 25 Sep 2025 12:35:57 +0100
X-Gmail-Original-Message-ID: <CAL3q7H6Wr=G2qpuTv9vvhtZSXj6vWPdNxc_=gzw6h_7x5c02KA@mail.gmail.com>
X-Gm-Features: AS18NWDrj1xhTUs4kd9FCjdDsy_F-Z3sisyFsIQFXEyNFT9Mf8HRKMCwS3FH2q4
Message-ID: <CAL3q7H6Wr=G2qpuTv9vvhtZSXj6vWPdNxc_=gzw6h_7x5c02KA@mail.gmail.com>
Subject: Re: [PATCH 1/2] btrfs: fix clearing of BTRFS_FS_RELOC_RUNNING if
 relocation already running
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 25, 2025 at 6:54=E2=80=AFAM Johannes Thumshirn
<Johannes.Thumshirn@wdc.com> wrote:
>
> On 9/24/25 6:55 PM, fdmanana@kernel.org wrote:
> > diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
> > index 8dd8de6b9fb8..acce4d813153 100644
> > --- a/fs/btrfs/relocation.c
> > +++ b/fs/btrfs/relocation.c
> > @@ -3780,6 +3780,7 @@ static noinline_for_stack struct inode *create_re=
loc_inode(
> >   /*
> >    * Mark start of chunk relocation that is cancellable. Check if the c=
ancellation
> >    * has been requested meanwhile and don't start in that case.
> > + * NOTE: if this returns an error, reloc_chunk_end() must not be calle=
d.
> >    *
> >    * Return:
> >    *   0             success
> > @@ -3796,10 +3797,8 @@ static int reloc_chunk_start(struct btrfs_fs_inf=
o *fs_info)
> >
> >       if (atomic_read(&fs_info->reloc_cancel_req) > 0) {
> >               btrfs_info(fs_info, "chunk relocation canceled on start")=
;
> > -             /*
> > -              * On cancel, clear all requests but let the caller mark
> > -              * the end after cleanup operations.
> > -              */
> > +             /* On cancel, clear all requests. */
> > +             clear_and_wake_up_bit(BTRFS_FS_RELOC_RUNNING, &fs_info->f=
lags);
> >               atomic_set(&fs_info->reloc_cancel_req, 0);
> >               return -ECANCELED;
>
> Would it make sense to add an ASSERT(test_bit(BRTFS_FS_RELOC_RUNNING,
> &fs_info->flags)); in reloc_chunk_end()?

Yes, that's good to have.
I've added it and pushed it to for-next.

Thanks.

