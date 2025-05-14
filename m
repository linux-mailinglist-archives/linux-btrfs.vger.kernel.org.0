Return-Path: <linux-btrfs+bounces-14001-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C04D7AB6908
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 May 2025 12:41:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E93973B068C
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 May 2025 10:41:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87484270EA6;
	Wed, 14 May 2025 10:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JMx4xfLJ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBD8726A0A4
	for <linux-btrfs@vger.kernel.org>; Wed, 14 May 2025 10:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747219302; cv=none; b=I5lTVNLmil6E6JMJ20ySHO4/rnfyd/a53/PvoCuXrqxn7/K6OXSzBy8aSo287PQh8v4p5xBMe14RtZeTA4rr5QycuMlWzqbUNW/p/PlCV7zy9Wu214IN5RpuMMJ3ZOCFLOMlYT1KbUL/dfsZKk/+KY+Oogm7omhzQQu4dPEOQQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747219302; c=relaxed/simple;
	bh=TRJ9/CCXUV4wJFppgBrbJLfXZYgWpkkzao/sWLlOlkM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rk9hcizvHuv4uSY0dr3PHhxQvtS3Ry3wOhrgzkfyJzBv7yDcT4VwlTMjxqkT2osSZhrxfGirQ6cAp8rFGjQWaFv+n8e7zRe2XRv7I/5VfQ9QTE/xehhJaIy+bPvWE9X1Zkev8WsXPEg99M9aSLxTPdwt7PDw/SJ+TrvjZPbH7mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JMx4xfLJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B11FC4CEEB
	for <linux-btrfs@vger.kernel.org>; Wed, 14 May 2025 10:41:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747219302;
	bh=TRJ9/CCXUV4wJFppgBrbJLfXZYgWpkkzao/sWLlOlkM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=JMx4xfLJba1pd0PrKWE0twLQkuvGWa5rpOAUxQwbP0g8AGpthUBMMlPA6PMABXDUJ
	 nsr90MP6Q1P2JeRIWoX5jOKibcB946VwZJI+Q6cPNOjGZGO+FzMbPSnPA9gmlbUtKz
	 8N7EjmKdUP+BUemu2CjmtGL31QZFaSei67xTlGi1YMqdteMU1Qc50HF6WLXNmiHaaD
	 fsjcRwg3GjKN9xVgmayyXpOIVtTnzbv5z6acJpIpUsMZypBruUMrPV7COLbKgrdMNl
	 HBHl3jcoKDn9VPciqX0o6EKGOGuFTXNDdKBvIC+Kgfj6hJM2Ej0Jg79vERa6PjeDHb
	 SGNstEn2ta+5g==
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5fbf52aad74so1563030a12.1
        for <linux-btrfs@vger.kernel.org>; Wed, 14 May 2025 03:41:42 -0700 (PDT)
X-Gm-Message-State: AOJu0Yxe+Fyn7bxNwDdFgPRG4PXzkqoV4wwhuLrykJct6dvGdsW7c8vB
	NCnnA3/lF8VumO/5bgU6irQ3P+cRbe1hSnciGsE9uMZdRW9gc/wDADWoY8RljjUHqQslhA9wViw
	dp0VH7jc9LJirkSrDK10GToiieBM=
X-Google-Smtp-Source: AGHT+IEwqPVFfS1eqzrhdDYTF9PR6AGB7IZ6w1gLp/QL918s5ynOvzpEYJAE57osG1UTVqfgmII2P2SDKEsweY98f7o=
X-Received: by 2002:a17:907:2ce4:b0:ad2:3c4e:2fc2 with SMTP id
 a640c23a62f3a-ad4d52be8e5mr709369266b.29.1747219300892; Wed, 14 May 2025
 03:41:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1747217722.git.fdmanana@suse.com> <79efbad28a262a6dbe07decd0f49b5a91a167c15.1747217722.git.fdmanana@suse.com>
 <fc07ef6d-fbec-4708-a0ca-10259530298a@suse.com>
In-Reply-To: <fc07ef6d-fbec-4708-a0ca-10259530298a@suse.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Wed, 14 May 2025 11:41:04 +0100
X-Gmail-Original-Message-ID: <CAL3q7H59vkvJXhzGypR557bjb2dtnAVUkivAjGWaz+oxybmhBg@mail.gmail.com>
X-Gm-Features: AX0GCFshMH5KQgfAGt56ftdfT3z_EgHvwx1tq8QQLtPo3aNqnH3xahjYS2wFaaU
Message-ID: <CAL3q7H59vkvJXhzGypR557bjb2dtnAVUkivAjGWaz+oxybmhBg@mail.gmail.com>
Subject: Re: [PATCH 1/3] btrfs: fix wrong start offset for delalloc space
 release during mmap write
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 14, 2025 at 11:38=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrote:
>
>
>
> =E5=9C=A8 2025/5/14 19:59, fdmanana@kernel.org =E5=86=99=E9=81=93:
> > From: Filipe Manana <fdmanana@suse.com>
> >
> > If we're doing a mmap write against a folio that has i_size somewhere i=
n
> > the middle and we have multiple sectors in the folio, we may have to
> > release excess space previously reserved, for the range going from the
> > rounded up (to sector size) i_size to the folio's end offset. We are
> > calculating the right amount to release and passing it to
> > btrfs_delalloc_release_space(), but we are passing the wrong start offs=
et
> > of that range - we're passing the folio's start offset instead of the
> > end offset, plus 1, of the range for which we keep the reservation. Thi=
s
> > may result in releasing more space then we should and eventually trigge=
r
> > an underflow of the data space_info's bytes_may_use counter.
> >
> > So fix this by passing the start offset as 'end + 1' instead of
> > 'page_start' to btrfs_delalloc_release_space().
> >
> > Fixes: d0b7da88f640 ("Btrfs: btrfs_page_mkwrite: Reserve space in secto=
rsized units")
> > Signed-off-by: Filipe Manana <fdmanana@suse.com>
>
> Reviewed-by: Qu Wenruo <wqu@suse.com>
>
> Just curious how did you spot this, by pure eyeballing or you have some
> tool exposing this?

Just eyeballing while working on other incoming changes to this function.

>
> Thanks,
> Qu> ---
> >   fs/btrfs/file.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
> > index 660a73b6af90..32aad1b02b01 100644
> > --- a/fs/btrfs/file.c
> > +++ b/fs/btrfs/file.c
> > @@ -1918,7 +1918,7 @@ static vm_fault_t btrfs_page_mkwrite(struct vm_fa=
ult *vmf)
> >               if (reserved_space < fsize) {
> >                       end =3D page_start + reserved_space - 1;
> >                       btrfs_delalloc_release_space(BTRFS_I(inode),
> > -                                     data_reserved, page_start,
> > +                                     data_reserved, end + 1,
> >                                       fsize - reserved_space, true);
> >               }
> >       }
>

