Return-Path: <linux-btrfs+bounces-10590-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AFBBD9F6F04
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Dec 2024 21:46:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0CB1716BD04
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Dec 2024 20:46:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2544C1FC0E9;
	Wed, 18 Dec 2024 20:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CF3YK9yW"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C216F50F
	for <linux-btrfs@vger.kernel.org>; Wed, 18 Dec 2024 20:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734554772; cv=none; b=fyrKtvOkUay3Ha+R91l0UgfSHbzFuz+6aKkKgU+jz6Mj3ghftU4c0X3Ztd8slHbStX3iAtgKK2YFZUT769r3qZMdjSTgSsGvCNRWiHkO4n4//3dTAEbD1tBcIGqBMjIJCcWE1fQVYgZvhAhjEcPUpuNTtKpzFgZ0RTRy5eYafXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734554772; c=relaxed/simple;
	bh=WGmtpwvpiTqASZcSc2+nr7tVFwLFLb6JCf31y/LIPls=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J5xWLRH7J0vUyCFiTkEsoLbVMSLx44q3vnQ7mvoufZ3CKLMC6JYKEBb0v1uo7c5d5263QKk3hV2a3NiBjbKhUPHLvy4AP6n3PxAQKiDwEwycUICU074yPIeeVNQB9GK/fWPpEif6gyS5EutAXeus+j/o+yip2H3cMJRMaz+rjMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CF3YK9yW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAE77C4CED7
	for <linux-btrfs@vger.kernel.org>; Wed, 18 Dec 2024 20:46:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734554771;
	bh=WGmtpwvpiTqASZcSc2+nr7tVFwLFLb6JCf31y/LIPls=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=CF3YK9yWb0HWUz2TcYQpktQnp1mCCyVSvLNVkmGxLrs6FKRapsLGpPveDKRcPyy9L
	 tt9Bwgy8a6F99rDhx7xa8A1i5lJnwLERda3rJC2YsYEYYbPf/9gqk70WjwY4pkb+0m
	 HitrEQT4PUEwoGxrk4YWC5EL76IrSbMPPtVIrbTynltZgHl2l9SUKkf93pxPu9RddO
	 3mqMRmfTCJ1c4l+Ofqzha7EdMaoW7ie8Mw0oGsfNB20/NmeptbfnXkNvzlo+B6d9rp
	 UWjoI7Oe3lm2DPEGDsl9ZHe+s3Cbj9idzoLYMdQT6v9fIm0HT3nH8SQ0DmegcUIXyX
	 C3AC0qvIdMnBQ==
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a9a0ef5179dso10224066b.1
        for <linux-btrfs@vger.kernel.org>; Wed, 18 Dec 2024 12:46:11 -0800 (PST)
X-Gm-Message-State: AOJu0YzyMvd19mrE4lOU/9iY1orB1O1xFSJGfEFps2w4hW3byRwqHjWk
	RGQY59sawASqVAjKm1WXAyNnV/ao3yFkn4Jwgq4kd/lk56t1a0hCwQmIWqi9FY0FoPj9lgH+HTx
	IM2dB/BH5LkG2x0MPDnBa0qF/5tw=
X-Google-Smtp-Source: AGHT+IGl5WlaJihNnm0l4lnYjO+4mExdfDdmU4S1ShUoeXoffnrYG+hFmj5iRbwBDnliHdHFFae2amv9jZQN2JQLfCc=
X-Received: by 2002:a17:907:724f:b0:aa6:6276:fe5a with SMTP id
 a640c23a62f3a-aabf4907ed0mr388465166b.43.1734554770269; Wed, 18 Dec 2024
 12:46:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1734368270.git.fdmanana@suse.com> <ca35ce34f64fc203266a7336390d82745d82ed5f.1734368270.git.fdmanana@suse.com>
 <20241218202117.GG31418@twin.jikos.cz>
In-Reply-To: <20241218202117.GG31418@twin.jikos.cz>
From: Filipe Manana <fdmanana@kernel.org>
Date: Wed, 18 Dec 2024 20:45:33 +0000
X-Gmail-Original-Message-ID: <CAL3q7H5ScfeKwWXndwWP6DjhxC5MvqTKxyikQMCcmEUyfF9Gpg@mail.gmail.com>
Message-ID: <CAL3q7H5ScfeKwWXndwWP6DjhxC5MvqTKxyikQMCcmEUyfF9Gpg@mail.gmail.com>
Subject: Re: [PATCH 2/9] btrfs: move csum related functions from ctree.c into fs.c
To: dsterba@suse.cz
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 18, 2024 at 8:21=E2=80=AFPM David Sterba <dsterba@suse.cz> wrot=
e:
>
> On Mon, Dec 16, 2024 at 05:17:17PM +0000, fdmanana@kernel.org wrote:
> > From: Filipe Manana <fdmanana@suse.com>
> >
> > The ctree module is about the implementation of the btree data structur=
e
> > and not a place holder for generic filesystem things like the csum
> > algorithm details. Move the functions related to the csum algorithm
> > details away from ctree.c and into fs.c, which is a far better place fo=
r
> > them. Also fix missing punctuation in comments and change one multiline
> > comment to a single line comment since everything fits in under 80
> > characters.
> >
> > For some reason this also sligthly reduces the module's size.
> >
> > Before this change:
> >
> >   $ size fs/btrfs/btrfs.ko
> >      text        data     bss     dec     hex filename
> >   1782126      161045   16920 1960091  1de89b fs/btrfs/btrfs.ko
> >
> > After this change:
> >
> >   $ size fs/btrfs/btrfs.ko
> >      text        data     bss     dec     hex filename
> >   1782094      161045   16920 1960059  1de87b fs/btrfs/btrfs.ko
> >
> > Signed-off-by: Filipe Manana <fdmanana@suse.com>
> > ---
> >  fs/btrfs/ctree.c | 51 ------------------------------------------------
> >  fs/btrfs/ctree.h |  6 ------
> >  fs/btrfs/fs.c    | 49 ++++++++++++++++++++++++++++++++++++++++++++++
> >  fs/btrfs/fs.h    |  6 ++++++
>
> Can you please create a new file for checksums? Moving everything to
> fs.c looks like we're going to have another ctree.c.

Is it really worth it? After this patchset fs.c is only 229 lines and
the csum related functions are just a few and very short.
My idea would be to do such a thing either when fs.c gets a lot larger
or we get more csum functions (and/or they get larger).

But sure, why not, I can do that on top or send a new version of this patch=
.

Thanks.

