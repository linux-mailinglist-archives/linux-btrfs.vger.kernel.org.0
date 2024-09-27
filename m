Return-Path: <linux-btrfs+bounces-8297-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DC4898829C
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Sep 2024 12:36:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 301C01C20C6B
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Sep 2024 10:36:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF5D91891A1;
	Fri, 27 Sep 2024 10:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kTTJLX/3"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 194B513698F
	for <linux-btrfs@vger.kernel.org>; Fri, 27 Sep 2024 10:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727433401; cv=none; b=HTbuTA7KtNIa6GUiz1ejMQ3EOKz68K3QCHzxpJHFhoLEPT0OSj5n99mlI2kLM+65wE7Qj08idWtjUSAktgoYMabguJIuuT3O9UjrmbzGcekMltZFe49R4//HkLX6VXUn99nEdvKfnGW+1hPJRK9g/BZwSihplB+W2Iwo/EIRGUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727433401; c=relaxed/simple;
	bh=7SFetp61qQH3Ic3a+o00D5vtCyN9+WUILt1lVDCsUns=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ob74E2U5TeoQoim8ALPYuExqLXA2+4G0lgL8LA3yi9Gx8ViJQxCSxlTb9nwgi4rE3oBt/i9LFqEBCoSAXf4X709K8ux5Ryg7vNDlN02SKrj9JdgXp3EcqNh6waxTHfZhigqWScHzeF1jUZVmCNt/5XFyiBsevAPDH+tNLabHeOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kTTJLX/3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FD34C4CEC4
	for <linux-btrfs@vger.kernel.org>; Fri, 27 Sep 2024 10:36:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727433400;
	bh=7SFetp61qQH3Ic3a+o00D5vtCyN9+WUILt1lVDCsUns=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=kTTJLX/3a4056QxSYzcAKgYjxMnroxzSdSLnCsbIANUe+/Jl9STZA9N7IF6dixsa7
	 CBY/s3HepjSSICRF/e496CYaowT7VPy621yh28N0G8tMNFPSqh48MVBLULK75OmqPy
	 V7kGUVWcxSxwr+YGZO887rP3tG555v5pHo1twuRSEfwmfpjHGtOOAbFui9GWImWuB6
	 Szle0Ufv8Spq7FpSnifI6B2qkUXLGSM8u7ro/u6x0AikpA066JwaQJ8jlZ2rWvgxTc
	 U3MTRNykiwEumFtVttFYd5snDVodq1btsNn3UdeKrfsfFfIW4fxUKoXYMUyv+MzONy
	 YtqDfKfOTqGUQ==
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a8d2b24b7a8so569889666b.1
        for <linux-btrfs@vger.kernel.org>; Fri, 27 Sep 2024 03:36:40 -0700 (PDT)
X-Gm-Message-State: AOJu0YxD1gY06NowlFJ/c2EcruWcdhuVf09UcqFH9VmcUjslIbG+dpyR
	V9QKwtxNOcUbOJ2x/XReX2qhjX/CJ9DUtj7Z7jWbkEJ932IrCvy8VKOOJBGgOCeAEGJluOOa1g1
	BhiEtVMURHL2rHDmzkR8fA53pbkU=
X-Google-Smtp-Source: AGHT+IG0jPcB1VfRGicuk7D0xq3KRFlUjPiIldM8ZJl49BAih3eTone9e5Isr9uYISxpr898dnRM1AxZ1C8KGUk8eFw=
X-Received: by 2002:a17:907:1c20:b0:a8d:2bc7:6331 with SMTP id
 a640c23a62f3a-a93b1677b10mr745269666b.27.1727433399098; Fri, 27 Sep 2024
 03:36:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <5a406a607fcccec01684056ab011ff0742f06439.1727432566.git.fdmanana@suse.com>
 <ac929d10-d263-46b1-9584-fd00a38e6189@gmx.com>
In-Reply-To: <ac929d10-d263-46b1-9584-fd00a38e6189@gmx.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Fri, 27 Sep 2024 11:36:02 +0100
X-Gmail-Original-Message-ID: <CAL3q7H6vr1sDHR9DwdE7xqgr6uL=meyoGAYJz2AygtuisR1DyQ@mail.gmail.com>
Message-ID: <CAL3q7H6vr1sDHR9DwdE7xqgr6uL=meyoGAYJz2AygtuisR1DyQ@mail.gmail.com>
Subject: Re: [PATCH] btrfs: send: fix invalid clone operation for file that
 got its size decreased
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 27, 2024 at 11:34=E2=80=AFAM Qu Wenruo <quwenruo.btrfs@gmx.com>=
 wrote:
>
>
>
> =E5=9C=A8 2024/9/27 19:55, fdmanana@kernel.org =E5=86=99=E9=81=93:
> > From: Filipe Manana <fdmanana@suse.com>
> >
> > During an incremental send we may end up sending an invalid clone
> > operation, for the last extent of a file which ends at an unaligned off=
set
> > that matches the final i_size of the file in the send snapshot, in case
> > the file had its initial size (the size in the parent snapshot) decreas=
ed
> > in the send snapshot. In this case the destination will fail to apply t=
he
> > clone operation because its end offset is not sector size aligned and i=
t
> > ends before the current size of the file.
> >
> > Sending the truncate operation always happens when we finish processing=
 an
> > inode, after we process all its extents (and xattrs, names, etc). So fi=
x
> > this by ensuring the file has the correct size before we send a clone
> > operation for an unaligned extent that ends at the final i_size of the =
file.
> >
> > The following test reproduces the issue:
> >
> >    $ cat test.sh
> >    #!/bin/bash
> >
> >    DEV=3D/dev/sdi
> >    MNT=3D/mnt/sdi
> >
> >    mkfs.btrfs -f $DEV
> >    mount $DEV $MNT
> >
> >    # Create a file with a size of 256K + 5 bytes, having two extents, o=
ne
> >    # with a size of 128K and another one with a size of 128K + 5 bytes.
> >    last_ext_size=3D$((128 * 1024 + 5))
> >    xfs_io -f -d -c "pwrite -S 0xab -b 128K 0 128K" \
> >           -c "pwrite -S 0xcd -b $last_ext_size 128K $last_ext_size" \
> >           $MNT/foo
> >
> >    # Another file which we will later clone foo into, but initially wit=
h
> >    # a larger size than foo.
> >    xfs_io -f -c "pwrite -S 0xef 0 1M" $MNT/bar
> >
> >    btrfs subvolume snapshot -r $MNT/ $MNT/snap1
> >
> >    # Now resize bar and clone foo into it.
> >    xfs_io -c "truncate 0" \
> >           -c "reflink $MNT/foo" $MNT/bar
> >
> >    btrfs subvolume snapshot -r $MNT/ $MNT/snap2
> >
> >    rm -f /tmp/send-full /tmp/send-inc
> >    btrfs send -f /tmp/send-full $MNT/snap1
> >    btrfs send -p $MNT/snap1 -f /tmp/send-inc $MNT/snap2
> >
> >    umount $MNT
> >    mkfs.btrfs -f $DEV
> >    mount $DEV $MNT
> >
> >    btrfs receive -f /tmp/send-full $MNT
> >    btrfs receive -f /tmp/send-inc $MNT
> >
> >    umount $MNT
> >
> > Running it before this patch:
> >
> >    $ ./test.sh
> >    (...)
> >    At subvol snap1
> >    At snapshot snap2
> >    ERROR: failed to clone extents to bar: Invalid argument
> >
> > A test case for fstests will be sent soon.
> >
> > Reported-by: Ben Millwood <thebenmachine@gmail.com>
> > Link: https://lore.kernel.org/linux-btrfs/CAJhrHS2z+WViO2h=3DojYvBPDLsA=
TwLbg+7JaNCyYomv0fUxEpQQ@mail.gmail.com/
> > Fixes: 46a6e10a1ab1 ("btrfs: send: allow cloning non-aligned extent if =
it ends at i_size")
> > Signed-off-by: Filipe Manana <fdmanana@suse.com>
>
> Reviewed-by: Qu Wenruo <wqu@suse.com>
>
> Just a small nitpick inlined below.
> > ---
> >   fs/btrfs/send.c | 19 ++++++++++++++++++-
> >   1 file changed, 18 insertions(+), 1 deletion(-)
> >
> > diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
> > index 5871ca845b0e..3ee27840a95a 100644
> > --- a/fs/btrfs/send.c
> > +++ b/fs/btrfs/send.c
> > @@ -6189,8 +6189,25 @@ static int send_write_or_clone(struct send_ctx *=
sctx,
> >       if (ret < 0)
> >               return ret;
> >
> > -     if (clone_root->offset + num_bytes =3D=3D info.size)
> > +     if (clone_root->offset + num_bytes =3D=3D info.size) {
> > +             /*
> > +              * The final size of our file matches the end offset, but=
 it may
> > +              * be that its current size is larger, so we have to trun=
cate it
> > +              * to that size (or to the start offset of the extent) ot=
herwise
> > +              * the clone operation is invalid because it's unaligned =
and it
> > +              * ends before the current EOF.
> > +              * We do this truncate when we finish processing the inod=
e, but
> > +              * it's too late by then, so we must do it now.
> > +              */
> > +             if (sctx->parent_root !=3D NULL) {
> > +                     ret =3D send_truncate(sctx, sctx->cur_ino,
> > +                                         sctx->cur_inode_gen,
> > +                                         sctx->cur_inode_size);
>
> I know this is a little overkilled, but can we just truncate the inode
> size to round_down(cur_inode_size, secotrsize)?
>
> As the truncate will still dirty the last sector, and later clone() will
> writeback the range covering the last sector, causing unnecessary IO for
> the sector we are going to drop immediately.

For that it's more logical to truncate to the start offset which is
always aligned.
I'll do that.

Thanks.

>
> Thanks,
> Qu
>
> > +                     if (ret < 0)
> > +                             return ret;
> > +             }
> >               goto clone_data;
> > +     }
> >
> >   write_data:
> >       ret =3D send_extent_data(sctx, path, offset, num_bytes);
>

