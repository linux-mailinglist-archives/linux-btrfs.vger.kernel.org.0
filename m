Return-Path: <linux-btrfs+bounces-10500-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 187529F5519
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Dec 2024 18:54:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBC4516129C
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Dec 2024 17:49:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50AD11F8923;
	Tue, 17 Dec 2024 17:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rFW/q8j4"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73BEA1F868D;
	Tue, 17 Dec 2024 17:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734457342; cv=none; b=H4l/kcX8oRcZEz9/sk8nHD1LT2aYmwBr6k49wgjwV7GdjIScvbXLlvhXAoh5qjJhxx9LYlCvXGNfp+07Z0ZQqOakSaDT03a3MTMnrPSW1ECxMR8bXEbrIpfeQilNp8DrIRU37kp2onxBkt42FPFhU3lO9fjvnJM6imiD3iG9ihU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734457342; c=relaxed/simple;
	bh=XLRCIIMlqlDK7J0Suq4Ni53xmoAUSya31QbffKzXrTE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bzfNK4Kuw2QwzFcU28rSfPHvZguYw4XUvDqUTuY4Egtz4R0/p9M9kHmAtdp2SXLQiaDvi/GhUGxIrneBVRjOzDCv1O1ZC0aM2Je4Wlv9FovEcGEVkI2X8z9tXILuiQbGokOjZ+g7oN2DBbihLJdn5XMO6w/ttCvcAEfB8hSR5Z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rFW/q8j4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF046C4CED7;
	Tue, 17 Dec 2024 17:42:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734457342;
	bh=XLRCIIMlqlDK7J0Suq4Ni53xmoAUSya31QbffKzXrTE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=rFW/q8j4/HuK4jEGwdBUz7JGJXkXQakG4HO2zJSs9T1Z9ymXGJuRqm6O/dEGk2pqM
	 +64NX1mW+D5bN3wwO84kWx5pFE9ZkyPoYjyVKnBPXyv2oONDrgsRi3kcMFL4RbRxhQ
	 9zthlELJlxQUF88awXaJfQIRjzQvyi+RFh8My7aL0ZhqRfwVMq7Qs2JwXcFWskkdjy
	 aLD/pzkiSkUqfFFTOMc5dGO/KRY8esyeWbn7aITJCBpAfWp3E8qNiWdAuMzmbY0nNI
	 3orWQDaIXLeSNeQeQGjITYvlCx0zM2WJxww14l+WzWvJqcYscG1hLyjmg4c0WT7x9c
	 4NXHxN7kFQyTw==
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-aab9e281bc0so562525866b.3;
        Tue, 17 Dec 2024 09:42:21 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWp6iu0n3qtyp9JFGrAoXOhjXfvMJNXe2mV0z90fC0xX2lhziraqHyZ7EJzTNzhxWDGaITdum1iqVjiSHg=@vger.kernel.org, AJvYcCXM8nrPlN7jJ3k3Olzh4tjotiMMTWetjd61qZqWfNFaySBbY7O0OBYsZN7JDs6MUOCAW9jcP5kD@vger.kernel.org
X-Gm-Message-State: AOJu0YzufSaYpOhsdFwcGJYP9hgdLzy2UJB0xvmSmhS9tFUJlRzMmHWY
	A1FSf/fZM6jo1o99NDNN7OUh2mFtGh08a0RNjhPAdrnbDfwvtnoduEzoZzaO/uXRxEgvOOqm3Z2
	fEAR1ep8eY4doRl00Mijd+Rc3Zv8=
X-Google-Smtp-Source: AGHT+IGWWTQS/2+nNv9RXWKaAPC/CRzy9pTUytxWKQCBBZ4JSkWcPGKHYwu2tnsSbY42R63BWh9Kycx7YIotBU1a1Ik=
X-Received: by 2002:a17:907:c22:b0:aa6:85d0:1492 with SMTP id
 a640c23a62f3a-aab77e97095mr1503697466b.37.1734457340564; Tue, 17 Dec 2024
 09:42:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <dca49a16a7aacdab831b8895bdecbbb52c0e609c.1733928765.git.fdmanana@suse.com>
 <Z2Ey4yQywOEYqEOI@infradead.org> <CAL3q7H4Age-k0ifGh+n4QwExC1vTgWGd3NROcX40vQXKRipBqw@mail.gmail.com>
 <20241217172223.GA6160@frogsfrogsfrogs>
In-Reply-To: <20241217172223.GA6160@frogsfrogsfrogs>
From: Filipe Manana <fdmanana@kernel.org>
Date: Tue, 17 Dec 2024 17:41:43 +0000
X-Gmail-Original-Message-ID: <CAL3q7H5s6sXBNZRQVNMydODJX8AokP4wozby4ohhHF-BoHwD6Q@mail.gmail.com>
Message-ID: <CAL3q7H5s6sXBNZRQVNMydODJX8AokP4wozby4ohhHF-BoHwD6Q@mail.gmail.com>
Subject: Re: [PATCH] generic: test swap activation on file that used to have clones
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, fstests@vger.kernel.org, linux-btrfs@vger.kernel.org, 
	Filipe Manana <fdmanana@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 17, 2024 at 5:22=E2=80=AFPM Darrick J. Wong <djwong@kernel.org>=
 wrote:
>
> On Tue, Dec 17, 2024 at 08:26:33AM +0000, Filipe Manana wrote:
> > On Tue, Dec 17, 2024 at 8:14=E2=80=AFAM Christoph Hellwig <hch@infradea=
d.org> wrote:
> > >
> > > On Wed, Dec 11, 2024 at 03:09:40PM +0000, fdmanana@kernel.org wrote:
> > > > The test also fails sporadically on xfs and the bug was already rep=
orted
> > > > to the xfs mailing list:
> > > >
> > > >    https://lore.kernel.org/linux-xfs/CAL3q7H7cURmnkJfUUx44HM3q=3DxK=
mqHb80eRdisErD_x8rU4+0Q@mail.gmail.com/
> > > >
> > >
> > > This version still doesn't seem to have the fs freeze/unfreeze that D=
arrick
> > > asked for in that thread.
> >
> > I don't get it, what's the freeze/unfreeze for? Where should they be pl=
aced?
> > Is it some way to get around the bug on xfs?
>
> freeze kicks the background inode gc thread so that the unlinked clones
> actually get freed before the swapon call.  A less bighammer idea might
> be to call XFS_IOC_FREE_EOFBLOCKS which also kicks the garbage
> collectors.

No matter the technical details that make the bug not so easy to fix
on xfs, adding calls to freeze/unfreeze, XFS_IOC_FREE_EOFBLOCKS, or
whatever else, is just a way to hide the bug on xfs, isn't it?
If the file has no more shared extents, swap activation should work.

Thanks.

>
> --D

