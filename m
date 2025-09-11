Return-Path: <linux-btrfs+bounces-16795-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56B53B52FEA
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Sep 2025 13:18:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1AD924851C9
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Sep 2025 11:18:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F8F52E9EA3;
	Thu, 11 Sep 2025 11:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rXzu6yr5"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 920B924678D
	for <linux-btrfs@vger.kernel.org>; Thu, 11 Sep 2025 11:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757589444; cv=none; b=TfRJzL8FXxUDpKDsQdKo6/1FXWmkHH0eH/HBggFS6KmpAJrCDxx21druSrLrmcgeybJ7FNOm75ofwlwXL4NrClArpn3SZeSqBc/ZicDOqdeLUsHrAvzK5Gh54nIkqnQyUbLMycP7HnMrAhK/2EctPbiTAeHDeDJd+Kj6We67ddI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757589444; c=relaxed/simple;
	bh=caBZZ5V6aU6czhtu95kp4+j+ZnbrR5PNDkxQ6IqQX8g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fo8KP9jpqizLcWTxK244CiEyrIdOgYQ4uFou5VFjc3Xyma21idia3JmOSNvh6ECX0gaaxF3OfPJktA5XianwXMrsfGsVBSKFDdWBLrLSch2REJjhyI3RCcFYEQPQ2dcQlQtvuypGBy02FN8o+IoZzdXYedTo7LiqYL1PjoMrgPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rXzu6yr5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F423C4CEF0
	for <linux-btrfs@vger.kernel.org>; Thu, 11 Sep 2025 11:17:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757589444;
	bh=caBZZ5V6aU6czhtu95kp4+j+ZnbrR5PNDkxQ6IqQX8g=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=rXzu6yr5owwbsO4GWvcQRtHnFKGuohMDQaV/EQTl7GL9HRakgiKIwjB5wfnR5i2R2
	 HL9Fvh/AVMuMotPPKP2OLi2SzVl8qgyHAnA+rGaOPDiWQuWpDvYKMI8lnWwTzrLEuL
	 AsHEM0vwUg0/w1DzoktF+lGrNngDX2JY+o2d/RqmaA7aQ12isvve9GNv/TnuDRC+qd
	 89S+nAJc5tZjSErpOCABJ45RqohQANsD+IUKisE4maqhfut6wn7xmQ8j3SeEvx2LsQ
	 +OhOiZlQudqn+Af6Du86nC8AXHJUyjjY8gm9e1wqoRJ6Dfnv1oOQjzroQvuXS8keM3
	 AjmXc1KTcLYNw==
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b042eb09948so119934266b.3
        for <linux-btrfs@vger.kernel.org>; Thu, 11 Sep 2025 04:17:23 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUimQDnGMDsVod14DcDqHkTaYC90zSZJkjXYl7uf4Mov5BdoQQOyN8krI8QEiHRYOcsgYWzr4IAWABlhA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzxAJJUp0/Apy9mV2ECxSZpWhjx3dqwguN+yMf7s+frivGfDnTl
	tTVGmlRMiH+ALWrSf+1sL64+oKO6QUdqh3TC4PgjOQeo93VyPOJAomw+ROUchCe9Pvh0/pQwsdD
	O142g7wbRLnFGeSAAZEByTsnAuqJLlQE=
X-Google-Smtp-Source: AGHT+IFW3qkH/ItiTMszVfetZh5YajNDrn76kJR1G/K0VMV2MFsITQzp7e8voBstllW+n8zCrSJPh9RlLRdC0GxlBUc=
X-Received: by 2002:a17:907:2d2c:b0:b04:3629:b00e with SMTP id
 a640c23a62f3a-b04b14afccamr1878631566b.29.1757589442591; Thu, 11 Sep 2025
 04:17:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250911060629.1885670-1-austinchang@synology.com> <CAL3q7H7-sDMfYUzNP4HkTCUdrNSo14JkhkkHWL2DuCCasHFLRw@mail.gmail.com>
In-Reply-To: <CAL3q7H7-sDMfYUzNP4HkTCUdrNSo14JkhkkHWL2DuCCasHFLRw@mail.gmail.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Thu, 11 Sep 2025 12:16:45 +0100
X-Gmail-Original-Message-ID: <CAL3q7H69DDTL5e_BdWZ8J-54bzi_umUNC9voRBXFPSoPE9jSLQ@mail.gmail.com>
X-Gm-Features: Ac12FXzvUQzQOTF4sSLhNtGJARXh7NWQf9JDTSbPlfAJ6gOYnuyOV4oPWoRdxZE
Message-ID: <CAL3q7H69DDTL5e_BdWZ8J-54bzi_umUNC9voRBXFPSoPE9jSLQ@mail.gmail.com>
Subject: Re: [PATCH v2] btrfs: init file_extent_tree after i_mode has been set
To: austinchang <austinchang@synology.com>
Cc: dsterba@suse.com, linux-btrfs@vger.kernel.org, robbieko@synology.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 11, 2025 at 12:07=E2=80=AFPM Filipe Manana <fdmanana@kernel.org=
> wrote:
>
> On Thu, Sep 11, 2025 at 7:07=E2=80=AFAM austinchang <austinchang@synology=
.com> wrote:
> >
> > btrfs_init_file_extent_tree() uses S_ISREG() to determine if the file i=
s
> > a regular file. In the beginning of btrfs_read_locked_inode(), the i_mo=
de
> > hasn't been read from inode item, then file_extent_tree won't be used a=
t
> > all in volumes without NO_HOLES.
> >
> > Fix this by calling btrfs_init_file_extent_tree() after i_mode is
> > initialized in btrfs_read_locked_inode().
> >
> > Signed-off-by: austinchang <austinchang@synology.com>
> > ---
> > Changelog:
> > v2: move the call to btrfs_init_file_extent_tree() under cache_index
> > label so that inodes from both delayed and regular inode read path
> > get file_extent_tree initialized.
> > ---
> >  fs/btrfs/delayed-inode.c |  2 --
> >  fs/btrfs/inode.c         | 12 ++++++------
> >  2 files changed, 6 insertions(+), 8 deletions(-)
> >
> > diff --git a/fs/btrfs/delayed-inode.c b/fs/btrfs/delayed-inode.c
> > index 0f8d8e275..d953f7af7 100644
> > --- a/fs/btrfs/delayed-inode.c
> > +++ b/fs/btrfs/delayed-inode.c
> > @@ -1864,8 +1864,6 @@ int btrfs_fill_inode(struct btrfs_inode *inode, u=
32 *rdev)
> >         i_uid_write(vfs_inode, btrfs_stack_inode_uid(inode_item));
> >         i_gid_write(vfs_inode, btrfs_stack_inode_gid(inode_item));
> >         btrfs_i_size_write(inode, btrfs_stack_inode_size(inode_item));
> > -       btrfs_inode_set_file_extent_range(inode, 0,
> > -                       round_up(i_size_read(vfs_inode), fs_info->secto=
rsize));
> >         vfs_inode->i_mode =3D btrfs_stack_inode_mode(inode_item);
> >         set_nlink(vfs_inode, btrfs_stack_inode_nlink(inode_item));
> >         inode_set_bytes(vfs_inode, btrfs_stack_inode_nbytes(inode_item)=
);
> > diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> > index 9e4aec733..652c409ee 100644
> > --- a/fs/btrfs/inode.c
> > +++ b/fs/btrfs/inode.c
> > @@ -3885,10 +3885,6 @@ static int btrfs_read_locked_inode(struct btrfs_=
inode *inode, struct btrfs_path
> >         bool filled =3D false;
> >         int first_xattr_slot;
> >
> > -       ret =3D btrfs_init_file_extent_tree(inode);
> > -       if (ret)
> > -               goto out;
> > -
> >         ret =3D btrfs_fill_inode(inode, &rdev);
> >         if (!ret)
> >                 filled =3D true;
> > @@ -3919,9 +3915,8 @@ static int btrfs_read_locked_inode(struct btrfs_i=
node *inode, struct btrfs_path
> >         set_nlink(vfs_inode, btrfs_inode_nlink(leaf, inode_item));
> >         i_uid_write(vfs_inode, btrfs_inode_uid(leaf, inode_item));
> >         i_gid_write(vfs_inode, btrfs_inode_gid(leaf, inode_item));
> > +
>
> Stray and unrelated new line.
>
> Reviewed-by: Filipe Manana <fdmanana@suse.com>
>
> I've removed this new line and added back the Fixes tag in the for-next b=
ranch.

I've also fixed a compilation warning about a no longer used variable
after this change:

fs/btrfs/delayed-inode.c: In function =E2=80=98btrfs_fill_inode=E2=80=99:
fs/btrfs/delayed-inode.c:1895:31: warning: unused variable =E2=80=98fs_info=
=E2=80=99
[-Wunused-variable]
 1895 |         struct btrfs_fs_info *fs_info =3D inode->root->fs_info;
      |                               ^~~~~~~

>
> Thanks.
>
>
> >         btrfs_i_size_write(inode, btrfs_inode_size(leaf, inode_item));
> > -       btrfs_inode_set_file_extent_range(inode, 0,
> > -                       round_up(i_size_read(vfs_inode), fs_info->secto=
rsize));
> >
> >         inode_set_atime(vfs_inode, btrfs_timespec_sec(leaf, &inode_item=
->atime),
> >                         btrfs_timespec_nsec(leaf, &inode_item->atime));
> > @@ -3953,6 +3948,11 @@ static int btrfs_read_locked_inode(struct btrfs_=
inode *inode, struct btrfs_path
> >         btrfs_set_inode_mapping_order(inode);
> >
> >  cache_index:
> > +       ret =3D btrfs_init_file_extent_tree(inode);
> > +       if (ret)
> > +               goto out;
> > +       btrfs_inode_set_file_extent_range(inode, 0,
> > +                       round_up(i_size_read(vfs_inode), fs_info->secto=
rsize));
> >         /*
> >          * If we were modified in the current generation and evicted fr=
om memory
> >          * and then re-read we need to do a full sync since we don't ha=
ve any
> > --
> > 2.34.1
> >
> >
> > Disclaimer: The contents of this e-mail message and any attachments are=
 confidential and are intended solely for addressee. The information may al=
so be legally privileged. This transmission is sent in trust, for the sole =
purpose of delivery to the intended recipient. If you have received this tr=
ansmission in error, any use, reproduction or dissemination of this transmi=
ssion is strictly prohibited. If you are not the intended recipient, please=
 immediately notify the sender by reply e-mail or phone and delete this mes=
sage and its attachments, if any.
> >

