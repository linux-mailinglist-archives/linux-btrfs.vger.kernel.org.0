Return-Path: <linux-btrfs+bounces-10270-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D0709ED919
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Dec 2024 22:54:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 421E6282D4C
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Dec 2024 21:54:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CEBA1EC4CA;
	Wed, 11 Dec 2024 21:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V3KZ4lA6"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 486631D63CA
	for <linux-btrfs@vger.kernel.org>; Wed, 11 Dec 2024 21:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733954070; cv=none; b=mdNBhmYcORc0gpj+tMUi2nUG6+wJZb4So0PBnnRPKvUTAXPhy8P6A5SwTJ34fh8A7BB4TJ1KjZRh3AM5YCiIlhfuOyI1zp2j/8j63FY+la6k62hYHdzhxw7A3234hG2KmFJJQKaFn4YNbEZhmZg+YAirELxIRej8//XT8StPYgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733954070; c=relaxed/simple;
	bh=j8CwCNSeIN5lAqVYAqeaCq9x3xiAcbl0BkCxjpfNIBA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lbBMyh2WSudAu2tikXa9b4v9O/qgRU1eiNE1htyUMC4HYpMtWAwlJ43WJYIFfVr1pi2OR2KP3ppZAMvqJjss/6taCyOWlOkDQl0OkHIaQC3SxlhAW3T805GKZfLb5TW6uiISOR3VeRU1aQWDQFuiqfNkqgIYlzdegouMjFGLJZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V3KZ4lA6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF8DEC4CED3
	for <linux-btrfs@vger.kernel.org>; Wed, 11 Dec 2024 21:54:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733954069;
	bh=j8CwCNSeIN5lAqVYAqeaCq9x3xiAcbl0BkCxjpfNIBA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=V3KZ4lA6tzsB3Ou1YtDPA/51RdUDdju2AHDdUSJ6/DC9AmbhSDgLelbj65b0dur5Z
	 guEwyyRrjLoi3wjQfnEflDpQtg6gbWQNKbfUvrFBkhq1LYIoG7viMRMeLxs+B/rVyw
	 SYp6U8jl/zbl123L7DqZ0P/i2MTPpa837UvFbly9+gbpN1ENu/UP2GsBbo8ngm0ibk
	 c7QCO5IVdySxyrJKVCVmDl4zTwmjTuWcjSvqPgqKIcP5iq9USE+IYhBQ/JsDc4O/SM
	 nrW6dT33VM7jZex9b1T2Khq8SRFUg3Q0fxX4gc1jsCVFipP7bNAqAR2ihdBuM8mWAZ
	 ZPYoG67hsZ2Cg==
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-aa6c0dbce1fso78512066b.2
        for <linux-btrfs@vger.kernel.org>; Wed, 11 Dec 2024 13:54:29 -0800 (PST)
X-Gm-Message-State: AOJu0YzKRicFj2l9hZSZI78E3U5XCEEdwX3J5OwTYii0QVGX7pSA7zWY
	Tvb84UN9N4jb7Sri3oB5Zibyx27lTe6eXBciJVowdDM3roHFhlhyUpuMAGZqT//HT9cm1KEjhO4
	e3pN1I1xHMCnBb71auXtQWIHCkjQ=
X-Google-Smtp-Source: AGHT+IE7AFjoSzpJ0ipuMrXiNf5cCCswfOLi8JC2LEE4zctXjoziC7p82ijx0XLdOF888gyoXHdUTBDjAwL/dr1JM60=
X-Received: by 2002:a05:6402:3595:b0:5d0:c7a7:ac13 with SMTP id
 4fb4d7f45d1cf-5d4331655d1mr10256935a12.34.1733954068345; Wed, 11 Dec 2024
 13:54:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <8e502fc69ea68d1647707d947e0e4625f0dd1af0.1733934886.git.fdmanana@suse.com>
 <9d90c662-993b-4a36-80f3-154f81fb06a7@suse.com>
In-Reply-To: <9d90c662-993b-4a36-80f3-154f81fb06a7@suse.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Wed, 11 Dec 2024 21:53:51 +0000
X-Gmail-Original-Message-ID: <CAL3q7H7PtVH=3g5Ov3GsmK8_ObHhL8atcO-2q3bEs7y6=SOGJA@mail.gmail.com>
Message-ID: <CAL3q7H7PtVH=3g5Ov3GsmK8_ObHhL8atcO-2q3bEs7y6=SOGJA@mail.gmail.com>
Subject: Re: [PATCH] btrfs: fix use-after-free when COWing tree bock and
 tracing is enabled
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 11, 2024 at 8:18=E2=80=AFPM Qu Wenruo <wqu@suse.com> wrote:
>
>
>
> =E5=9C=A8 2024/12/12 03:11, fdmanana@kernel.org =E5=86=99=E9=81=93:
> > From: Filipe Manana <fdmanana@suse.com>
> >
> > When a COWing a tree block, at btrfs_cow_block(), and we have the
> > tracepoint trace_btrfs_cow_block() enabled and preemption is also enabl=
ed
> > (CONFIG_PREEMPT=3Dy), we can trigger a use-after-free in the COWed exte=
nt
> > buffer while inside the tracepoint code. This is because in some paths
> > that call btrfs_cow_block(), such as btrfs_search_slot(), we are holdin=
g
> > the last reference on the extent buffer @buf so btrfs_force_cow_block()
> > drops the last reference on the @buf extent buffer when it calls
> > free_extent_buffer_stale(buf), which schedules the release of the exten=
t
> > buffer with RCU. This means that if we are on a kernel with preemption,
> > the current task may be preempted before calling trace_btrfs_cow_block(=
)
> > and the extent buffer already released by the time trace_btrfs_cow_bloc=
k()
> > is called, resulting in a use-after-free.
> >
> > Fix this by grabbing an extra reference on the extent buffer before
> > calling btrfs_force_cow_block() at btrfs_cow_block(), and then dropping
> > it after calling the tracepoint.
> >
> > Reported-by: syzbot+8517da8635307182c8a5@syzkaller.appspotmail.com
> > Link: https://lore.kernel.org/linux-btrfs/6759a9b9.050a0220.1ac542.000d=
.GAE@google.com/
> > Signed-off-by: Filipe Manana <fdmanana@suse.com>
>
> Thanks for pinning down the error.
>
> Although considering there is really only one caller of
> trace_btrfs_cow_block(), can we just move this only caller into
> btrfs_force_cow_block() before freeing @buf?

That's actually simpler and more efficient, yes.
Done in v2.

Thanks.

>
> Thanks,
> Qu
>
> > ---
> >   fs/btrfs/ctree.c | 11 +++++++++++
> >   1 file changed, 11 insertions(+)
> >
> > diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
> > index 693dc27ffb89..3a28e77b6d72 100644
> > --- a/fs/btrfs/ctree.c
> > +++ b/fs/btrfs/ctree.c
> > @@ -751,10 +751,21 @@ int btrfs_cow_block(struct btrfs_trans_handle *tr=
ans,
> >        * Also We don't care about the error, as it's handled internally=
.
> >        */
> >       btrfs_qgroup_trace_subtree_after_cow(trans, root, buf);
> > +     /*
> > +      * When we are called from btrfs_search_slot() for example, we ar=
e
> > +      * not holding an extra reference on @buf so btrfs_force_cow_bloc=
k()
> > +      * does a free_extent_buffer_stale() on the last reference and sc=
hedules
> > +      * the extent buffer release with RCU, so we can trigger a
> > +      * use-after-free in the trace_btrfs_cow_block() call below in ca=
se
> > +      * preemption is enabled (CONFIG_PREEMPT=3Dy). So grab an extra r=
eference
> > +      * to prevent that.
> > +      */
> > +     atomic_inc(&buf->refs);
> >       ret =3D btrfs_force_cow_block(trans, root, buf, parent, parent_sl=
ot,
> >                                   cow_ret, search_start, 0, nest);
> >
> >       trace_btrfs_cow_block(root, buf, *cow_ret);
> > +     free_extent_buffer_stale(buf);
> >
> >       return ret;
> >   }
>

