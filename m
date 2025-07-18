Return-Path: <linux-btrfs+bounces-15554-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 55BB0B0AA20
	for <lists+linux-btrfs@lfdr.de>; Fri, 18 Jul 2025 20:27:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B5B6B1AA4CE8
	for <lists+linux-btrfs@lfdr.de>; Fri, 18 Jul 2025 18:27:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 846712E8896;
	Fri, 18 Jul 2025 18:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gLwXiIU/"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB2602E888A
	for <linux-btrfs@vger.kernel.org>; Fri, 18 Jul 2025 18:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752863202; cv=none; b=Nq4NlOM7nGWk1LnqgpBRaqYRnam8piU8f1qgpVvBrBB57LpffD0cXnRcjuIRs/+5bRS3mm1E1Pffk0foclHt9yf0EYEu0PXAYiVIipD4OCHZkxFpeFwZwGEqgfBpSJGed+9GbT4QscEArdSpUXkM3DGV0Vn0vEuiG4e7acvHmDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752863202; c=relaxed/simple;
	bh=co6heSo+0SJ5pClxVhTPq5QKrhUeaehIIEQie2VZAmY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oABlJJ1VN926Zp4gSwCfn5YU08hTBYp3S25z2PpjeT0ItxC8Ag4dnfkvA47tBe25vwbLP+/ezLJWbgsA5mrl3aYTAxOtxiSIaESwcppNPppDBaobqcq+MpuwLsTvnfJpB8G27Sgj35rbQe1zhgSC4IW75XACPoChkt/loJ5QJRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gLwXiIU/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69BFAC4CEEB
	for <linux-btrfs@vger.kernel.org>; Fri, 18 Jul 2025 18:26:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752863202;
	bh=co6heSo+0SJ5pClxVhTPq5QKrhUeaehIIEQie2VZAmY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=gLwXiIU/TKyujbjIYG+HN2bCilefzPWzgusOLJJM8WXTOTLIxmYlM0vpVy5QF4mBY
	 9JKn+071nJJy20ItXXVfXN8gDCci8YzXvd+zLkqQ9JRfEM7sKylsjxZ8/OettqpW7L
	 ZuQFdBQD/J1pNeDwaakdJk81jOzGQBTGm7EqSA4WKmKxKYWtSrLyRrV6YkdPKSRFqF
	 IhjWc7XhXFK9hOWOC68eWguNgyctE0aSxjwQHgSK+C7vsvDifrb3DsDqHDEa1ccL4I
	 LHTgSxVbSLUDU8QUuoZNUaIlX40umDPUh+wnvAfr6N2V+dTp+MWnDpfUojuc/g6I5o
	 YIKZqgbazbJFQ==
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-606b58241c9so3757621a12.3
        for <linux-btrfs@vger.kernel.org>; Fri, 18 Jul 2025 11:26:42 -0700 (PDT)
X-Gm-Message-State: AOJu0YykzVdEoCmpnV6wD7MQtDgOSgLtkXPtj9Rce8f/nVBAihAC2EDJ
	UuYYIpUbvNn6y1rHqCAkksvfvAxVxfKtxxk7KUQ/1FWbAgcqY9Fe2I/jVDp1OtHHFy0AH5b7Nc0
	lNPEALuWK5zKT7i5Xd2G3uVrYK7WfDz8=
X-Google-Smtp-Source: AGHT+IHBzSUtU6W5hVAAR7vG9/CbjwloDJTsh+ZbdCBEGrlOxT2c5zwaC4W8wQsxDabQVkXWfJ/vIkFMjWQB3gW0ngg=
X-Received: by 2002:a17:906:3454:b0:ae3:24c:6a21 with SMTP id
 a640c23a62f3a-ae9cde54306mr928299666b.26.1752863200958; Fri, 18 Jul 2025
 11:26:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <227dfa8b9395cd21c186fe4122582bdbeff8d2a2.1752841473.git.fdmanana@suse.com>
 <20250718181624.GA4060971@zen.localdomain>
In-Reply-To: <20250718181624.GA4060971@zen.localdomain>
From: Filipe Manana <fdmanana@kernel.org>
Date: Fri, 18 Jul 2025 19:26:04 +0100
X-Gmail-Original-Message-ID: <CAL3q7H4AMZe=GTkxQ-QC9+ub5X8ER7zMHUbEwjMeCPVcnBcSUw@mail.gmail.com>
X-Gm-Features: Ac12FXw-NVMyKeatzJWIZihT25VvDb-yKet_VOXO7Qg94Cgw0QE_eNpeGK8Fn-c
Message-ID: <CAL3q7H4AMZe=GTkxQ-QC9+ub5X8ER7zMHUbEwjMeCPVcnBcSUw@mail.gmail.com>
Subject: Re: [PATCH] btrfs: send: use fallocate for hole punching with send
 stream v2
To: Boris Burkov <boris@bur.io>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 18, 2025 at 7:15=E2=80=AFPM Boris Burkov <boris@bur.io> wrote:
>
> On Fri, Jul 18, 2025 at 01:28:46PM +0100, fdmanana@kernel.org wrote:
> > From: Filipe Manana <fdmanana@suse.com>
> >
> > Currently holes are sent as writes full of zeroes, which results in
> > unnecessarily using disk space at the receiving end and increasing the
> > stream size.
> >
> > In some cases we avoid sending writes of zeroes, like during a full
> > send operation where we just skip writes for holes.
> >
> > But for some cases we fill previous holes with writes of zeroes too, li=
ke
> > in this scenario:
> >
> > 1) We have a file with a hole in the range [2M, 3M), we snapshot the
> >    subvolume and do a full send. The range [2M, 3M) stays as a hole at
> >    the receiver since we skip sending write commands full of zeroes;
> >
> > 2) We punch a hole for the range [3M, 4M) in our file, so that now it
> >    has a 2M hole in the range [2M, 4M), and snapshot the subvolume.
> >    Now if we do an incremental send, we will send write commands full
> >    of zeroes for the range [2M, 4M), removing the hole for [2M, 3M) at
> >    the receiver.
> >
> > We could improve cases such as this last one by doing additional
> > comparisons of file extent items (or their absence) between the parent
> > and send snapshots, but that's a lot of code to add plus additional CPU
> > and IO costs.
> >
> > Since the send stream v2 already has a fallocate command and btrfs-prog=
s
> > implements a callback to execute fallocate since the send stream v2
> > support was added to it, update the kernel to use fallocate for punchin=
g
> > holes for V2+ streams.
> >
> > Test coverage is provided by btrfs/284 which is a version of btrfs/007
> > that exercises send stream v2 instead of v1, using fsstress with random
> > operations and fssum to verify file contents.
> >
> > Link: https://github.com/kdave/btrfs-progs/issues/1001
> > Signed-off-by: Filipe Manana <fdmanana@suse.com>
>
> Reviewed-by: Boris Burkov <boris@bur.io>
>
> > ---
> >  fs/btrfs/send.c | 33 +++++++++++++++++++++++++++++++++
> >  1 file changed, 33 insertions(+)
> >
> > diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
> > index 09822e766e41..7664025a5af4 100644
> > --- a/fs/btrfs/send.c
> > +++ b/fs/btrfs/send.c
> > @@ -4,6 +4,7 @@
> >   */
> >
> >  #include <linux/bsearch.h>
> > +#include <linux/falloc.h>
> >  #include <linux/fs.h>
> >  #include <linux/file.h>
> >  #include <linux/sort.h>
> > @@ -5405,6 +5406,30 @@ static int send_update_extent(struct send_ctx *s=
ctx,
> >       return ret;
> >  }
> >
> > +static int send_fallocate(struct send_ctx *sctx, u32 mode, u64 offset,=
 u64 len)
> > +{
> > +     struct fs_path *path;
> > +     int ret;
> > +
> > +     path =3D get_cur_inode_path(sctx);
> > +     if (IS_ERR(path))
> > +             return PTR_ERR(path);
> > +
> > +     ret =3D begin_cmd(sctx, BTRFS_SEND_C_FALLOCATE);
> > +     if (ret < 0)
> > +             return ret;
> > +
> > +     TLV_PUT_PATH(sctx, BTRFS_SEND_A_PATH, path);
> > +     TLV_PUT_U32(sctx, BTRFS_SEND_A_FALLOCATE_MODE, mode);
> > +     TLV_PUT_U64(sctx, BTRFS_SEND_A_FILE_OFFSET, offset);
> > +     TLV_PUT_U64(sctx, BTRFS_SEND_A_SIZE, len);
> > +
> > +     ret =3D send_cmd(sctx);
> > +
> > +tlv_put_failure:
> > +     return ret;
> > +}
> > +
> >  static int send_hole(struct send_ctx *sctx, u64 end)
> >  {
> >       struct fs_path *p =3D NULL;
> > @@ -5412,6 +5437,14 @@ static int send_hole(struct send_ctx *sctx, u64 =
end)
> >       u64 offset =3D sctx->cur_inode_last_extent;
> >       int ret =3D 0;
> >
> > +     /*
> > +      * Starting with send stream v2 we have fallocate and can use it =
to
> > +      * punch holes instead of sending writes full of zeroes.
> > +      */
> > +     if (proto_cmd_ok(sctx, BTRFS_SEND_C_FALLOCATE))
> > +             return send_fallocate(sctx, FALLOC_FL_PUNCH_HOLE | FALLOC=
_FL_KEEP_SIZE,
> > +                                   offset, end - offset);
> > +
> >       /*
> >        * A hole that starts at EOF or beyond it. Since we do not yet su=
pport
> >        * fallocate (for extent preallocation and hole punching), sendin=
g a
>
> I think this comment is out of date, now that we support fallocate :)

It's still true for v1 streams. The new code above makes us return
before this point in case we have a v2+ stream, that's why I left it.

Thanks.

>
> > --
> > 2.47.2
> >

