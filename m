Return-Path: <linux-btrfs+bounces-10935-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52C5FA0B63A
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Jan 2025 13:01:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 762463A4A78
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Jan 2025 12:01:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 794051FDA65;
	Mon, 13 Jan 2025 12:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EUDosj7O"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9535B22CF2A;
	Mon, 13 Jan 2025 12:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736769663; cv=none; b=AC+mGZBhyZXC1LZRWQZf2KqSwBJeI+358WiqCjhLx+hQxjgouJxuTi2m7XcxRLL6RSwgNbQcRbEwTTGoeBTskDdgW5qYtRXiTa5WTmYQMpIAKNRYzfSmPEP15A1K/FOmpy/OsCXn79XncVfyn/cHnqQrDvMEIM47EtPGvxyyczM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736769663; c=relaxed/simple;
	bh=NSNpqsYesPWJFBbE5jTpjUv6TnMCPBw1pB+AFaj9ARA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QBuYgoKIxUUxdGNNDI4brNIepTrl1cMqtaXR4LRntW+NJgClMySK34OcR1Rm+8CuG1ViG+M1Q/kjCQ2w3IvdMgRtgmTo+kNspNnxPYOh6NeYzht1IBnE5AOvAm/GY3na/eH9ePn0arbGXGQ4+9tByC30q63vBi9n+wGas6dJQfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EUDosj7O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2337EC4CED6;
	Mon, 13 Jan 2025 12:01:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736769663;
	bh=NSNpqsYesPWJFBbE5jTpjUv6TnMCPBw1pB+AFaj9ARA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=EUDosj7ONvNv564n+JWqFCUDhvtbCLZIuq8P9oqE6Xh3D/vhghK92yGKaFpSyygsd
	 uyZDhZPJxRL7HAEgARL+qx9gQybzLV9MTNIcIS0qfmuj1lXmXDvhwje1f3y4bljcp2
	 j5hyzLnK1QjFA2CuXauhd5EjeleWGE77Q0Q+RsTJ9oiSP/Ygnf8bBrkGqF2COR1kjq
	 8Zk2Z1I0qIVP0eBLybiV34n6IaRwqQc0JnQIbiw8Zkaj41rGU0/+alQIoQlOlcdtMR
	 CAePVHIyRBzWxHy2PgRv7M3pgi/kS9F7eGjV55WUUB+c/VY8FP2Zv9awGMmhX1/Zhi
	 u2Hv3D+sdvryg==
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-aaeec07b705so682476066b.2;
        Mon, 13 Jan 2025 04:01:03 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUqfMKixho0AjcgfLrPatMdtTbb+GX47l2Ji6/4vceMZxUvjXcs7JdIWSYJJGQP7QY92R+8o4Qv@vger.kernel.org, AJvYcCXVxvm939sssZu2WIVsNT2QRWWsBO+54jAcnbxU5N7nutn39r6eOVVj44zazoEb0tTUlu0FfWY55csUe1E=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIBpVX92g9QEiqq0WSOKME6PyvJOtYEiZ+71m4vsQrqyuCQBNJ
	rumwmR+5CJcEB8mWbrFze4AnB9qKlPGXsZVC6LWwK7nHVtjhC0rJKcJ8JtpstzkCLUx5y5B7mmQ
	uQ1C2RooAEo3MiBerRfFWpqqWI6M=
X-Google-Smtp-Source: AGHT+IGCj/R0sXVc4sN+D6aV26Ivffl7rLF38xa6pYAZZp3TJSH0gS7jyQqaZ9IBz/neGBBM9tb9I1w6qPTZo7+VkQQ=
X-Received: by 2002:a17:906:f58e:b0:aa5:225f:47d9 with SMTP id
 a640c23a62f3a-ab2ab749f27mr1556422966b.29.1736769661696; Mon, 13 Jan 2025
 04:01:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <dca49a16a7aacdab831b8895bdecbbb52c0e609c.1733928765.git.fdmanana@suse.com>
 <Z2Ey4yQywOEYqEOI@infradead.org> <CAL3q7H4Age-k0ifGh+n4QwExC1vTgWGd3NROcX40vQXKRipBqw@mail.gmail.com>
 <20241217172223.GA6160@frogsfrogsfrogs> <db59d0b2-6542-41e1-abf7-0c38b91cdf4d@gmx.com>
 <20241218200927.GC6160@frogsfrogsfrogs> <d4c1334e-0275-453c-bdea-7878dc8c56f1@gmx.com>
In-Reply-To: <d4c1334e-0275-453c-bdea-7878dc8c56f1@gmx.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Mon, 13 Jan 2025 12:00:24 +0000
X-Gmail-Original-Message-ID: <CAL3q7H7gkd8w3mN4WV8OYMYDY_Be1SsCLcA0YezBA18U1cwkCA@mail.gmail.com>
X-Gm-Features: AbW1kvZqNsZ1VybzIUslAPxRw9oW1IHRlgLcIDxg11-sDP0gPLX0z5mf8WJgOIU
Message-ID: <CAL3q7H7gkd8w3mN4WV8OYMYDY_Be1SsCLcA0YezBA18U1cwkCA@mail.gmail.com>
Subject: Re: [PATCH] generic: test swap activation on file that used to have clones
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: "Darrick J. Wong" <djwong@kernel.org>, Christoph Hellwig <hch@infradead.org>, fstests@vger.kernel.org, 
	linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>, 
	Zorro Lang <zlang@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 18, 2024 at 8:19=E2=80=AFPM Qu Wenruo <quwenruo.btrfs@gmx.com> =
wrote:
>
>
>
> =E5=9C=A8 2024/12/19 06:39, Darrick J. Wong =E5=86=99=E9=81=93:
> > On Wed, Dec 18, 2024 at 09:07:26AM +1030, Qu Wenruo wrote:
> >>
> >>
> >> =E5=9C=A8 2024/12/18 03:52, Darrick J. Wong =E5=86=99=E9=81=93:
> >>> On Tue, Dec 17, 2024 at 08:26:33AM +0000, Filipe Manana wrote:
> >>>> On Tue, Dec 17, 2024 at 8:14=E2=80=AFAM Christoph Hellwig <hch@infra=
dead.org> wrote:
> >>>>>
> >>>>> On Wed, Dec 11, 2024 at 03:09:40PM +0000, fdmanana@kernel.org wrote=
:
> >>>>>> The test also fails sporadically on xfs and the bug was already re=
ported
> >>>>>> to the xfs mailing list:
> >>>>>>
> >>>>>>      https://lore.kernel.org/linux-xfs/CAL3q7H7cURmnkJfUUx44HM3q=
=3DxKmqHb80eRdisErD_x8rU4+0Q@mail.gmail.com/
> >>>>>>
> >>>>>
> >>>>> This version still doesn't seem to have the fs freeze/unfreeze that=
 Darrick
> >>>>> asked for in that thread.
> >>>>
> >>>> I don't get it, what's the freeze/unfreeze for? Where should they be=
 placed?
> >>>> Is it some way to get around the bug on xfs?
> >>>
> >>> freeze kicks the background inode gc thread so that the unlinked clon=
es
> >>> actually get freed before the swapon call.  A less bighammer idea mig=
ht
> >>> be to call XFS_IOC_FREE_EOFBLOCKS which also kicks the garbage
> >>> collectors.
> >>
> >> I'm wondering why this GC things can not be done inside XFS' swapon ca=
ll?
> >>
> >> So that we don't need some per-fs workaround in a generic test case.
> >
> > I suppose one could call xfs_inodegc_flush from within swapon with the
> > swap file's i_rwsem held, but now we're blocking swapon while we wait
> > for some unbounded number of probably unrelated unlinked inodes to be
> > freed on the off chance that one of them shared blocks.
> >
> > A better answer might be to run FALLOC_FL_UNSHARE on the file, but now
> > we're making swapon more complex and potentially issuing a lot of IO to
> > make that happen.  If you can convince the fsdevel/mm folks that swapon
> > is supposed to try to correct things it doesn't like in the file mappin=
g
> > (instead of returning EINVAL or whatever it does now) then we could add
> > that to the syscall definition.

So how do we proceed from here?

The btrfs fix was merged into Linus' tree sometime ago (v6.13-rc5),
and I would hate to lose test coverage in fstests.

Since the bug seems to be hard to fix on XFS, shall I make the test
_notun on xfs, or move it tests/btrfs?
Zorro?

Thanks.

>
> Sorry that I'm no familiar with XFS to provide any help, but the swapon
> call on btrfs is already very complex.
>
> It needs to verify every extent of that file is not shared, and block
> the subvolume from being snapshotted.
> (The extent shareness check iteslf may already cause quite some IO)
>
> So at least to me, a little more extra logic and IO shouldn't be a huge
> blockage, since we're already doing exactly that since the btrfs
> swapfile support.
>
> Thanks,
> Qu
> >
> > --D
> >
> >> Thanks,
> >> Qu
> >>>
> >>> --D
> >>>
> >>
> >>
> >
>

