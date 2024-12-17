Return-Path: <linux-btrfs+bounces-10469-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CC65B9F46AD
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Dec 2024 09:59:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B31C188BFA3
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Dec 2024 08:58:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D1A7148314;
	Tue, 17 Dec 2024 08:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="snZLV2Db"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40ADB1DDC2A
	for <linux-btrfs@vger.kernel.org>; Tue, 17 Dec 2024 08:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734425909; cv=none; b=pcbbs88DScXMwIyrAdVqzDgTFH1lIGv0ZLJ9p5c010/WmOTPwgzJgxlc+1AiiAXEBNvovYrkVy30lfOtz31QPqqqV9b7uOEA0YtfzRmQtmFBV2IJjoB+8CeegGqUdL7qaOjikT8aQVS+23YCBAD2EWKUE23U0R6z4R0VAV80M7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734425909; c=relaxed/simple;
	bh=0kBBJQQoeylBp4h+5FRYsySoYnXVsbl/YtLMf08JZeU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X0E+NkMBSkHEfA3q0FlrqFJIvs9V8EeUd9Ca9UcGBjPrsKDlI7EbGW+k0Dqj3gvB0bQ8W/aQHDE2RLyvdXItDM8sbMXgVkEsuu459r6OLyOgc6jlT3pWG7o4XaaeUJSMgzqMFZS6gnJDyNwTRnEcxMi0jbVxBfzGyFPCQDD3kUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=snZLV2Db; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2BB5C4CED7
	for <linux-btrfs@vger.kernel.org>; Tue, 17 Dec 2024 08:58:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734425908;
	bh=0kBBJQQoeylBp4h+5FRYsySoYnXVsbl/YtLMf08JZeU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=snZLV2DbiiE1KzP6Kw4WAqgAkZBorSbHlGZGc1bRJEvm8xZsY0ygM2B24YEsYx6Ig
	 NTHhYvfsV1fwhNOR6rB2WtHTmQG7nP3GCZdmjMYJQTPUS+v5Q7E3htY0KheuqDPe4n
	 WnUKcWSS7R2eB2d3DYamfyCdJLmnWtJSfUWGvZbaqbhe8DlLq+/gDpTxI6Yapc4ilR
	 osqfNllZuWvJHYjdinlnXDogV5T5YlwRuojMWQ0Sicebkaj9UZfwfslRYHnY8uCwJT
	 jhO+JOGeU1gVdJmCO/b6WxM4mohAfUHf070l0pd6HY1GnBArZt6G3DHPtOxniOfTpA
	 rg56ks55rjMsA==
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-aa679ad4265so1120750066b.0
        for <linux-btrfs@vger.kernel.org>; Tue, 17 Dec 2024 00:58:28 -0800 (PST)
X-Gm-Message-State: AOJu0YxywWvCmwq0skOCocK0gbiLj7tnVOL3NDkFyKHJEXYmTBWSXeVV
	WI4AQjZvbAQH0pcxIBcd2a+wwbzsrlSP4CIKfwNbIBkz3fuumeCL8bEnuh8idMDsOnfRREXtVGi
	cJUnLGBXc+EJPu+ScLCDXSoCUojM=
X-Google-Smtp-Source: AGHT+IE7M1+BKWreR90rbf1/OeUVU+uX68sJmGTeF5Ba7kSVHhh6OzCoD8+hcEtV0xKRBw+GDgTvKxnjSJpKWSGmWt0=
X-Received: by 2002:a17:907:d8e:b0:aa6:8764:8738 with SMTP id
 a640c23a62f3a-aabdc963abdmr211260766b.23.1734425907387; Tue, 17 Dec 2024
 00:58:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1734368270.git.fdmanana@suse.com> <7aef21820a6bad0e41699f18660038546adbbc9c.1734368270.git.fdmanana@suse.com>
 <785dadec-8352-46d2-864d-3df93d979db1@gmx.com>
In-Reply-To: <785dadec-8352-46d2-864d-3df93d979db1@gmx.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Tue, 17 Dec 2024 08:57:50 +0000
X-Gmail-Original-Message-ID: <CAL3q7H6dPzBe0M564RrWUnsa-UxvHV2Ud4GqQuBXcrN_rY_igg@mail.gmail.com>
Message-ID: <CAL3q7H6dPzBe0M564RrWUnsa-UxvHV2Ud4GqQuBXcrN_rY_igg@mail.gmail.com>
Subject: Re: [PATCH 4/9] btrfs: move btrfs_is_empty_uuid() from ioctl.c into fs.c
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 17, 2024 at 12:31=E2=80=AFAM Qu Wenruo <quwenruo.btrfs@gmx.com>=
 wrote:
>
>
>
> =E5=9C=A8 2024/12/17 03:47, fdmanana@kernel.org =E5=86=99=E9=81=93:
> > From: Filipe Manana <fdmanana@suse.com>
> >
> > It's a generic helper not specific to ioctls and used in several places=
,
> > so move it out from ioctl.c and into fs.c. While at it change its retur=
n
> > type from int to bool and declare the loop variable in the loop itself.
> >
> > This also slightly reduces the module's size.
> >
> > Before this change:
> >
> >    $ size fs/btrfs/btrfs.ko
> >       text       data     bss     dec     hex filename
> >    1781492     161037   16920 1959449  1de619 fs/btrfs/btrfs.ko
> >
> > After this change:
> >
> >    $ size fs/btrfs/btrfs.ko
> >       text       data     bss     dec     hex filename
> >    1781340     161037   16920 1959297  1de581 fs/btrfs/btrfs.ko
> >
> > Signed-off-by: Filipe Manana <fdmanana@suse.com>
> > ---
> >   fs/btrfs/fs.c    |  9 +++++++++
> >   fs/btrfs/fs.h    |  2 ++
> >   fs/btrfs/ioctl.c | 11 -----------
> >   fs/btrfs/ioctl.h |  1 -
> >   4 files changed, 11 insertions(+), 12 deletions(-)
> >
> > diff --git a/fs/btrfs/fs.c b/fs/btrfs/fs.c
> > index 09cfb43580cb..06a863252a85 100644
> > --- a/fs/btrfs/fs.c
> > +++ b/fs/btrfs/fs.c
> > @@ -55,6 +55,15 @@ size_t __attribute_const__ btrfs_get_num_csums(void)
> >       return ARRAY_SIZE(btrfs_csums);
> >   }
> >
> > +bool __pure btrfs_is_empty_uuid(const u8 *uuid)
> > +{
> > +     for (int i =3D 0; i < BTRFS_UUID_SIZE; i++) {
> > +             if (uuid[i] !=3D 0)
> > +                     return false;
> > +     }
>
> Since we're here, would it be possible to go with
> mem_is_zero()/memchr_inv() which contains some extra optimization.
>
> And if we go calling mem_is_zero()/memchr_inv(), can we change this to
> an inline?

I'll send that as a separate change, using uuid_is_null() as Johannes
suggested, on top of this.
The goal here was just to move code around and not change the
implementation while doing it.

Thanks.

>
> Otherwise looks good to me.
>
> Thanks,
> Qu
> > +     return true;
> > +}
> > +
> >   /*
> >    * Start exclusive operation @type, return true on success.
> >    */
> > diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
> > index b05f2af97140..15c26c6f4d6e 100644
> > --- a/fs/btrfs/fs.h
> > +++ b/fs/btrfs/fs.h
> > @@ -988,6 +988,8 @@ const char *btrfs_super_csum_name(u16 csum_type);
> >   const char *btrfs_super_csum_driver(u16 csum_type);
> >   size_t __attribute_const__ btrfs_get_num_csums(void);
> >
> > +bool __pure btrfs_is_empty_uuid(const u8 *uuid);
> > +
> >   /* Compatibility and incompatibility defines */
> >   void __btrfs_set_fs_incompat(struct btrfs_fs_info *fs_info, u64 flag,
> >                            const char *name);
> > diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> > index 0ede6a5524c2..7872de140489 100644
> > --- a/fs/btrfs/ioctl.c
> > +++ b/fs/btrfs/ioctl.c
> > @@ -471,17 +471,6 @@ static noinline int btrfs_ioctl_fitrim(struct btrf=
s_fs_info *fs_info,
> >       return ret;
> >   }
> >
> > -int __pure btrfs_is_empty_uuid(const u8 *uuid)
> > -{
> > -     int i;
> > -
> > -     for (i =3D 0; i < BTRFS_UUID_SIZE; i++) {
> > -             if (uuid[i])
> > -                     return 0;
> > -     }
> > -     return 1;
> > -}
> > -
> >   /*
> >    * Calculate the number of transaction items to reserve for creating =
a subvolume
> >    * or snapshot, not including the inode, directory entries, or parent=
 directory.
> > diff --git a/fs/btrfs/ioctl.h b/fs/btrfs/ioctl.h
> > index 2b760c8778f8..ce915fcda43b 100644
> > --- a/fs/btrfs/ioctl.h
> > +++ b/fs/btrfs/ioctl.h
> > @@ -19,7 +19,6 @@ int btrfs_fileattr_set(struct mnt_idmap *idmap,
> >                      struct dentry *dentry, struct fileattr *fa);
> >   int btrfs_ioctl_get_supported_features(void __user *arg);
> >   void btrfs_sync_inode_flags_to_i_flags(struct inode *inode);
> > -int __pure btrfs_is_empty_uuid(const u8 *uuid);
> >   void btrfs_update_ioctl_balance_args(struct btrfs_fs_info *fs_info,
> >                                    struct btrfs_ioctl_balance_args *bar=
gs);
> >   int btrfs_uring_cmd(struct io_uring_cmd *cmd, unsigned int issue_flag=
s);
>

