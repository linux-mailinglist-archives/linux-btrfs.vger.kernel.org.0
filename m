Return-Path: <linux-btrfs+bounces-6578-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C6ED1937559
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Jul 2024 10:48:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03FE51C217FB
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Jul 2024 08:48:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ADE97D412;
	Fri, 19 Jul 2024 08:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f7ohIBzV"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B901D79B96
	for <linux-btrfs@vger.kernel.org>; Fri, 19 Jul 2024 08:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721378872; cv=none; b=pLEnVh885MQDqzHpf3o5gS4/LM2tRG3hV9MqA9VY7mYQRo9gN52tdqmzHDRiONJKhC3BagivdD9RSUkzm8dU+q66UpJ3xE2BFOlQwI6mjHERwiXdU70R8RfLiSpyzMC4Aw8tmV8JLJjY2MUQV1z6C7nA7d5J5yDq5jxsomBZ4Pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721378872; c=relaxed/simple;
	bh=hFyjVcT03+ebBO1PgWw/TREH7OBH90otOl/MtpHB928=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J34DxkkAu91EfbeXxWpzpKWqEXvrtXK2F4l2PCvjj6q5cVCr86NBQcU0aUx4+ZvVgCyamJEGdI+sASmbpQ90PDiZb6dSD1QRAbMPOQIOz2yD46ZUbCw3Pi2uiOpXU1R/BXycmFfCyZjL9swo1Ac144mjq/4zrkEcqBmq0jPY1Ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f7ohIBzV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 704BFC4AF0A;
	Fri, 19 Jul 2024 08:47:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721378872;
	bh=hFyjVcT03+ebBO1PgWw/TREH7OBH90otOl/MtpHB928=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=f7ohIBzVHr1fFCAJioBKW83o51PxhYFP548lGNXGiDstTsmX/1p6A9OlEjK2v1d9s
	 Q0EzAdp9TnqmxwHR4FxpoWfN/FVFZD2mdLfPRvHQVoe2YA/LetaGAWbEiH5wLBIm5Y
	 AuR2JYRqAFW9x61XKD+KmGdbNn+ps3IwBMu2V0uVSJqlqL7nRdWlouT0KTcECuQS8B
	 a3JHfwXd2CnEnbS4vLmMkcnXMEqpu8O3xi0HvgZzPSucCkMS0IsbBKtTSCP21OKWs0
	 v+QNKY8gouP79GCXOuLtw1XwjEHi3SpjVqF5u5TQa6C6hkzoz0uaP8T4Sz2J1c+oQd
	 RWC5BOTX2T6rA==
Date: Fri, 19 Jul 2024 10:47:49 +0200
From: Alejandro Colomar <alx@kernel.org>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: Sam James <sam@gentoo.org>, linux-btrfs@vger.kernel.org
Subject: Re: Build failure with trunk GCC 15 in fs/btrfs/print-tree.c
 (-Wunterminated-string-initialization)
Message-ID: <lwwiyeum2xhztlpwi4yuihz5rd4gyzf3k6c7zz5j6ynjq6ai6q@ior3lopynhdz>
References: <87ttgmz7q7.fsf@gentoo.org>
 <5mnphkdvheudccjtiatrbjbkqtw54s2wkpeqevj3rqthdqlwyw@sjvn4wn52qki>
 <8d7e4d19-bded-4a59-aeb9-cc7d93706ac8@gmx.com>
 <uhthjbiihonjjpqjkod7ao2kopeppbdgzhmdfuetu4c2tdzm6s@gevodksq2kku>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="yujyxdcegzo5rcd5"
Content-Disposition: inline
In-Reply-To: <uhthjbiihonjjpqjkod7ao2kopeppbdgzhmdfuetu4c2tdzm6s@gevodksq2kku>


--yujyxdcegzo5rcd5
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: Sam James <sam@gentoo.org>, linux-btrfs@vger.kernel.org
Subject: Re: Build failure with trunk GCC 15 in fs/btrfs/print-tree.c
 (-Wunterminated-string-initialization)
References: <87ttgmz7q7.fsf@gentoo.org>
 <5mnphkdvheudccjtiatrbjbkqtw54s2wkpeqevj3rqthdqlwyw@sjvn4wn52qki>
 <8d7e4d19-bded-4a59-aeb9-cc7d93706ac8@gmx.com>
 <uhthjbiihonjjpqjkod7ao2kopeppbdgzhmdfuetu4c2tdzm6s@gevodksq2kku>
MIME-Version: 1.0
In-Reply-To: <uhthjbiihonjjpqjkod7ao2kopeppbdgzhmdfuetu4c2tdzm6s@gevodksq2kku>

On Fri, Jul 19, 2024 at 10:39:06AM GMT, Alejandro Colomar wrote:
> Hi Qu,
>=20
> On Fri, Jul 19, 2024 at 10:49:09AM GMT, Qu Wenruo wrote:
> >=20
> >=20
> > =E5=9C=A8 2024/7/19 07:56, Alejandro Colomar =E5=86=99=E9=81=93:
> > > Hi Sam!
> > >=20
> > > On Thu, Jul 18, 2024 at 10:54:40PM GMT, Sam James wrote:
> > > > GCC 15 introduces a new warning -Wunterminated-string-initialization
> > > > which causes, with the kernel's -Werror=3D..., the following:
> > > > ```
> > > > /var/tmp/portage/sys-kernel/gentoo-kernel-6.6.41/work/linux-6.6/fs/=
btrfs/print-tree.c:29:49: error: initializer-string for array of =E2=80=98c=
har=E2=80=99 is too long [-Werror=3Dunterminated-string-initialization]
> > > >     29 |         { BTRFS_BLOCK_GROUP_TREE_OBJECTID,      "BLOCK_GRO=
UP_TREE"      },
> > > >        |
> > > >        ^~~~~~~~~~~~~~~~~~
> > > > ```
> >=20
> > Great new GCC feature!
>=20
> Thanks!!  It's a pleasure to see it working.  :-)
>=20
> > And it's indeed too long, not only for the block group tree, but also
> > for the future RAID_STRIPE_TREE too.
>=20
> Yep, there are two entries too long.
>=20
> > I believe we can just enlarge the string to 32 bytes for now.
> > I'll send out a fix soon.

Please add:

Fixes: 9c54e80ddc6b ("btrfs: add code to support the block group root")
Reported-by: Sam James <sam@gentoo.org>
Reported-by: Alejandro Colomar <alx@kernel.org>
Suggested-by: Alejandro Colomar <alx@kernel.org>

And this will be useful:

$ git describe --contains 9c54e80ddc6bd89596a4046d451908700476fd14
v5.18-rc1~172^2~64

Cheers,
Alex


--=20
<https://www.alejandro-colomar.es/>

--yujyxdcegzo5rcd5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE6jqH8KTroDDkXfJAnowa+77/2zIFAmaaKDUACgkQnowa+77/
2zJoyA//dW4hmsDG2/zrjtczXcmEFmNCbYWl6D+LgUQ94rYZH8TjAkMR4zVrQk2X
SJpMX1EoPT+Dkwa2sU7x6XI4f2wHSimiEnXKp2AlL+uluKfA07SL/1bzUuFpMSro
c3U+btcNMwqEe9cX/sgmfWVSTHeanaGdKyQPlCTj+CnD1NWy5ySioR3GaJdRzUXP
UwBKI1UYFDrCU3A1d71qLkPmGEGOHVgjQkUjO3J2+n7iyySOWhLvCYPBiN5AV4qI
2m5fzH5vtdP0FqZHTFqYyE6ZxjVfwBLRmt+D6Dhcr8ruwDSxDfRhCXRJyA+kwf2S
GRb1LO6aUAry4O8NyhA9voP+1gRA2jz0iwsado20W3HvfVxDBne65Zl+6xtnpEFr
Pc6CyU+xCsnSvyNNCYxjeh/Z6utfNmwJA8+sD2UIX+SrbhwcxHjjyc1Sotb3OrLA
OnuCvIPrBzdTLsxHkQtmK4tGUQStoJwvB1MBR3Bht/MsQFCXy1jdGa+ffZZ9ndJN
9ipc+/TqN1/Be3phNY3T+y630KEuZ6iz1Oe9rN6Y68FPo91Zf8iJVGCz3FeEeS62
T4rJc5RmXj7N1lu6HWyEZyzc61HhmR99jAPEZ+Tlg1lwzCk/1gNuL9fJOqeO8tg4
amTvNEjL6yI2sk0QoodvKRLOV9UkGygdLVkxv2iuLU6YWIm3hYE=
=K8fT
-----END PGP SIGNATURE-----

--yujyxdcegzo5rcd5--

