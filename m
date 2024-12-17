Return-Path: <linux-btrfs+bounces-10466-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E958C9F4608
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Dec 2024 09:27:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A7841639F7
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Dec 2024 08:27:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA30E1DB92E;
	Tue, 17 Dec 2024 08:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h+AWah+R"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B78981DA113;
	Tue, 17 Dec 2024 08:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734424031; cv=none; b=DG21H9YFDNbmorXpJ+3plEs6kFrlnyeWTWDKjkZgk6YaXFyNbnSwto7p82BsYT2qMU87onPj7cCkRtk1a9jVYjAYef8M2F0PhSX6Q2HxAUiyzsRHuHhV8a5c9DBp+sG0uZug0vCzdq0h1KOqyTU7LC3H7biusJyxPCGEav4mcu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734424031; c=relaxed/simple;
	bh=2ZkLz4bLPodpJotnMIlk7i2OXoqFAmVe7IAVUf27egk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QhgVvBZUBycf666SEfMZeSMHl6WgqYnMYGbm1Dn5HC3RKw7lDx70HNGk55TcHYRoIT8lvjTfueh/sQ6LHwPZjU9zRn75kLr48XIRWJsQ0Z5Iy6b9UCSDDd++UOO8wMAzPrfliB/VDrV11NDah0UYEgcWF/UaY4L5xxJ217dnvc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h+AWah+R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 460CBC4CED3;
	Tue, 17 Dec 2024 08:27:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734424031;
	bh=2ZkLz4bLPodpJotnMIlk7i2OXoqFAmVe7IAVUf27egk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=h+AWah+RAfsVSHGN0KXxUeqAhu47oO4U2fCEMK71OH5zo+qHjiuAImQkLmYB1Tlv2
	 HIO3MpyiTdvuIlybhkQJJJpjXRBQcgePEocpIvt6JpfxfwxbGCtLwkAUTlRJzX3nQG
	 VmC5YvZVcNoD/Vh7M/8CUyI7SooZ9CziuR+LJqrq9BIwE7B+ZI36zL30pdUg3ILYNX
	 GV4JYdqlFtGGMTaNZOY7LwdZq4ExrtQl9p4uSrAfczdeldmhkWzvZRHrZ2L8HX4ZiT
	 mt75nZQYs4ofmoBJQDMbmA5GrH46xQfycQQEK48cPAMZ8/ZUW0IXJbfEqPLzSMxry8
	 7VL4hGjrtaK2Q==
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a9f1c590ecdso863973266b.1;
        Tue, 17 Dec 2024 00:27:11 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUznGDkhfpEteMNo2aKZdSi0z5l7enPd/hYy1VxUmccyAxsmhem35F3JqUhHuQ2bdLnAppZ644nV4UcIA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzzKC9NIXAwWpXUdaDXLqrvFEfHOS878RVp6YEASeuUqJCALVhQ
	/AXdpUeSMhj1XmpFEPd9Y8szls/lGh76pCBf2K1HTaHV1aGaEjSz0bpY87XC3wrrww974ZagwjH
	/inkk39lmDPJKPeO83BrKS95m53w=
X-Google-Smtp-Source: AGHT+IFcpvjP4UsIzG/pVkrpzRvc9YV+XbDxfVaSMoVSQC0KjpIyhJo2jXFBT61X+DW0c3j0sh0sU/LduQAGYnVaNLc=
X-Received: by 2002:a17:907:3ea1:b0:aa6:a8da:7ba3 with SMTP id
 a640c23a62f3a-aab779b04camr1637289166b.27.1734424029900; Tue, 17 Dec 2024
 00:27:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <dca49a16a7aacdab831b8895bdecbbb52c0e609c.1733928765.git.fdmanana@suse.com>
 <Z2Ey4yQywOEYqEOI@infradead.org>
In-Reply-To: <Z2Ey4yQywOEYqEOI@infradead.org>
From: Filipe Manana <fdmanana@kernel.org>
Date: Tue, 17 Dec 2024 08:26:33 +0000
X-Gmail-Original-Message-ID: <CAL3q7H4Age-k0ifGh+n4QwExC1vTgWGd3NROcX40vQXKRipBqw@mail.gmail.com>
Message-ID: <CAL3q7H4Age-k0ifGh+n4QwExC1vTgWGd3NROcX40vQXKRipBqw@mail.gmail.com>
Subject: Re: [PATCH] generic: test swap activation on file that used to have clones
To: Christoph Hellwig <hch@infradead.org>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org, 
	Filipe Manana <fdmanana@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 17, 2024 at 8:14=E2=80=AFAM Christoph Hellwig <hch@infradead.or=
g> wrote:
>
> On Wed, Dec 11, 2024 at 03:09:40PM +0000, fdmanana@kernel.org wrote:
> > The test also fails sporadically on xfs and the bug was already reporte=
d
> > to the xfs mailing list:
> >
> >    https://lore.kernel.org/linux-xfs/CAL3q7H7cURmnkJfUUx44HM3q=3DxKmqHb=
80eRdisErD_x8rU4+0Q@mail.gmail.com/
> >
>
> This version still doesn't seem to have the fs freeze/unfreeze that Darri=
ck
> asked for in that thread.

I don't get it, what's the freeze/unfreeze for? Where should they be placed=
?
Is it some way to get around the bug on xfs?

>

