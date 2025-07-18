Return-Path: <linux-btrfs+bounces-15564-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3964EB0AC4C
	for <lists+linux-btrfs@lfdr.de>; Sat, 19 Jul 2025 00:51:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 651967B9E1C
	for <lists+linux-btrfs@lfdr.de>; Fri, 18 Jul 2025 22:49:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 030A5221FA1;
	Fri, 18 Jul 2025 22:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jse-io.20230601.gappssmtp.com header.i=@jse-io.20230601.gappssmtp.com header.b="gZfRHZkf"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60FAA21B9E0
	for <linux-btrfs@vger.kernel.org>; Fri, 18 Jul 2025 22:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752879061; cv=none; b=qim/N4stw24eTJYkC17hHlOYza47vVrJJXM9O0ThA2YokSBuavP+WnZJE/IJtPSx54vBYkEe7KUEHlF6qtPSdFUjyWqhaZEDYV21VTo63rj46GKW6R7doLd6TSlJGKnnE2Qlbl3pgus0mdWPUPCjlOy3Kf0P+48d+8XDwtIxjwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752879061; c=relaxed/simple;
	bh=53KcxeVE6XRHdMgqX1N7MV7UlLZRJsnYnsHOmSHuTXQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U1qlbF5q8gTU2ONzT/roo7UeGzPnbtBZFui7FfFZa54dxGAgljjsJWbsm/kqHaOKw+9yeJ/hPvRBvzCA9GR7mOGcHHfXzQCMoO08fziVDDv/MsQi65YbHUww3oreQeGZc+bMHMGjYvYvy0P25celKmylN1ME3aKrWD4HOK5vtJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=jse.io; spf=pass smtp.mailfrom=jse.io; dkim=pass (2048-bit key) header.d=jse-io.20230601.gappssmtp.com header.i=@jse-io.20230601.gappssmtp.com header.b=gZfRHZkf; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=jse.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jse.io
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-712e7aceb0fso3915427b3.0
        for <linux-btrfs@vger.kernel.org>; Fri, 18 Jul 2025 15:50:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jse-io.20230601.gappssmtp.com; s=20230601; t=1752879058; x=1753483858; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wRNcXVYj/KXmBCaJV6u+liCG9IK3EvUV2ZQoddIFYRE=;
        b=gZfRHZkfv9ZpOxlafxT7KVdz3CGO6v9yKBozK0R4MZ1h7EgrfftVdkL2uMLHPCw0Cj
         XSzkQBl7/wnS8BKOU8bKmlDp4X71y5uJ+gr/LQXBM//x2MNj75B37dooEQMleQZKwVE2
         D6WJDoSrduT1K++nagkMrobABIP6RTRIRL/YbCpBGCikPBgdfFNUaYtWoGtr/hVQlqXu
         PkpBMKRHfkZc9XIKJom1wscDHc4v8WCeQwndMMFkzcgkNLC2h8URpPYt2/8LOGrYQPsI
         IsUIR40DcKpJg69TNC+kEczmXpzZL/MpAvExbDGc1ExNq1DYIdozAz/O9sdYDL5ebgHr
         oTxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752879058; x=1753483858;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wRNcXVYj/KXmBCaJV6u+liCG9IK3EvUV2ZQoddIFYRE=;
        b=Bg590hXoDWS5X3jr0FBxkfQmppUK9fmtECQiksh/1dgLOrHX+TZXBJvPOJUFfSwDSW
         s9TIQFOTXTdls2YLCgh1QyrdSWYyRERiOGFyfyQ0iMBeMiPkKOtt0Wip5pR6IQlqRXUp
         DLWtJZZnrQEru+F/kVyQ9asbZ4SAL4PM6poi6MQq8Ruo1PG68HfoxVb3N/ltmyPShS/p
         Pw64tKQxmAVqSAbIyDdfvz+AJM/8pQ/dUSVLkqiAv4oBAZQte02e+OMhqY8CWvUs7y6v
         yB3M7bPgcn3q/TkwBCjsBtj6iFa5EnesXaX5mq9wvZbEOYqeTuzPiIkG/Un5gqjXRS//
         O33Q==
X-Forwarded-Encrypted: i=1; AJvYcCUnJxx/xO4lPa2Ix4gb4CeI+kxsJyNvf1pM66m+Tb3C2aeRB2Gj1sYGOBiu/OkVWXdvphXj5rIIvwkQ2w==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxy0LtfB8DzW2bh4EX9R09s5qwMkTIlwdt4rxtZItdi5QTsVZy4
	MVSGXkW2nsiJRSuxWLdGCz6zEqlM3OyJWVKQOUY0DBEeiXdx3a0IBqlveU/Lj3ZamOdUVsNi5X/
	nwbqX+SLJGa6EqFwX7vNLGfbptbK1ZfCtm8yb/atZxw==
X-Gm-Gg: ASbGncvzSc3CaJNtx5FO/lDbLtXEUS0dyAc6+fDXfDeMvmX2d2zjY9/UrwHxOmS7OBg
	rhmXHCCCjArAA97YkgoB3TOKPypKFngVRNjwB6iXRKnpNilLTcsLY48QbwcFmq7JPNDRdFXOeFf
	/jhhMIDIBfSKEdHeT9pDKQLD8ncLrI6GUKqkFxRMEITUqPzS+9Zb/IaVIXysqpBvCFJ4mlZFera
	EC1lh56
X-Google-Smtp-Source: AGHT+IHTrMi4FCvq2ckF3waDwnqjpvhTMsR0By5x/RFONQNUVesPLDlE5D4V4JotRwty53NFu/NMJ0UFvPQSN62SyeU=
X-Received: by 2002:a05:690c:6b8a:b0:711:908e:37a1 with SMTP id
 00721157ae682-7183514e176mr85880877b3.4.1752879057738; Fri, 18 Jul 2025
 15:50:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <227dfa8b9395cd21c186fe4122582bdbeff8d2a2.1752841473.git.fdmanana@suse.com>
 <45b28eee-c05a-4030-a4ac-a3543646be11@gmx.com>
In-Reply-To: <45b28eee-c05a-4030-a4ac-a3543646be11@gmx.com>
From: Jonah Sabean <jonah@jse.io>
Date: Fri, 18 Jul 2025 19:50:22 -0300
X-Gm-Features: Ac12FXzakwSbCFtpC3COC_EzqsnGBaCGmb0EBQCdM4_12A4AIPB-yuSznsH18Po
Message-ID: <CAFMvigc+GEc-Vim10Z_Z7n==EJ3i8qr8r8LeZSGHBxqbnZm_QA@mail.gmail.com>
Subject: Re: [PATCH] btrfs: send: use fallocate for hole punching with send
 stream v2
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: fdmanana@kernel.org, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

How does this affect zoned mode? Isn't fallocated not supported?

On Fri, Jul 18, 2025 at 6:42=E2=80=AFPM Qu Wenruo <quwenruo.btrfs@gmx.com> =
wrote:
>
>
>
> =E5=9C=A8 2025/7/18 21:58, fdmanana@kernel.org =E5=86=99=E9=81=93:
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
> >     subvolume and do a full send. The range [2M, 3M) stays as a hole at
> >     the receiver since we skip sending write commands full of zeroes;
> >
> > 2) We punch a hole for the range [3M, 4M) in our file, so that now it
> >     has a 2M hole in the range [2M, 4M), and snapshot the subvolume.
> >     Now if we do an incremental send, we will send write commands full
> >     of zeroes for the range [2M, 4M), removing the hole for [2M, 3M) at
> >     the receiver.
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
> Reviewed-by: Qu Wenruo <wqu@suse.com>
>
> Thanks,
> Qu
>
> > ---
> >   fs/btrfs/send.c | 33 +++++++++++++++++++++++++++++++++
> >   1 file changed, 33 insertions(+)
> >
> > diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
> > index 09822e766e41..7664025a5af4 100644
> > --- a/fs/btrfs/send.c
> > +++ b/fs/btrfs/send.c
> > @@ -4,6 +4,7 @@
> >    */
> >
> >   #include <linux/bsearch.h>
> > +#include <linux/falloc.h>
> >   #include <linux/fs.h>
> >   #include <linux/file.h>
> >   #include <linux/sort.h>
> > @@ -5405,6 +5406,30 @@ static int send_update_extent(struct send_ctx *s=
ctx,
> >       return ret;
> >   }
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
> >   static int send_hole(struct send_ctx *sctx, u64 end)
> >   {
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
>

