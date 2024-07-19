Return-Path: <linux-btrfs+bounces-6571-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B33C9373E9
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Jul 2024 08:09:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD32E1C237EB
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Jul 2024 06:09:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05C471C32;
	Fri, 19 Jul 2024 06:09:02 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34E6140862
	for <linux-btrfs@vger.kernel.org>; Fri, 19 Jul 2024 06:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721369341; cv=none; b=Io0cSTAmDPpD6xOrh9oE6kJ67j+qUGpOkyfOBe/7LGdIGj4ONXo72FpvUFx/2AO653ryFjhV1UbmtiOkYlcd9vRIdePhfYxG+N0dqLH+gleq8/+OSrcZBNjiCIJB09xHQLn+BpzRV4WI3FSlmYy+4T1aFKwsPOEjLOGTXpU+KVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721369341; c=relaxed/simple;
	bh=DvCZ/PlWWniebqfQQaTWrF675eE4iEgKHyZHZCyH+Ak=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=aKed2U4z6Rsglv6cyojkdH0g/K1FEQA05DE6upv+FQUNZmaWmkyazk9KZL0/QL4NVWYIFDpXXPCGkGRlciZxOKlEQ7k8jNKkx5mUf5U+cIhJu+WzLcMj2tsHlisf4ljCjXFKrUIHh3M77VYZsryJfhkBqYYrWU3JHVIuqqhBvXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
From: Sam James <sam@gentoo.org>
To: Alejandro Colomar <alx@kernel.org>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: Build failure with trunk GCC 15 in fs/btrfs/print-tree.c
 (-Wunterminated-string-initialization)
In-Reply-To: <5mnphkdvheudccjtiatrbjbkqtw54s2wkpeqevj3rqthdqlwyw@sjvn4wn52qki>
	(Alejandro Colomar's message of "Fri, 19 Jul 2024 00:26:44 +0200")
Organization: Gentoo
References: <87ttgmz7q7.fsf@gentoo.org>
	<5mnphkdvheudccjtiatrbjbkqtw54s2wkpeqevj3rqthdqlwyw@sjvn4wn52qki>
Date: Fri, 19 Jul 2024 07:08:55 +0100
Message-ID: <87y15xykug.fsf@gentoo.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Alejandro Colomar <alx@kernel.org> writes:

> Hi Sam!
>
> On Thu, Jul 18, 2024 at 10:54:40PM GMT, Sam James wrote:
>> GCC 15 introduces a new warning -Wunterminated-string-initialization
>> which causes, with the kernel's -Werror=3D..., the following:
>> ```
>> /var/tmp/portage/sys-kernel/gentoo-kernel-6.6.41/work/linux-6.6/fs/btrfs=
/print-tree.c:29:49: error: initializer-string for array of =E2=80=98char=
=E2=80=99 is too long [-Werror=3Dunterminated-string-initialization]
>>    29 |         { BTRFS_BLOCK_GROUP_TREE_OBJECTID,      "BLOCK_GROUP_TRE=
E"      },
>>       |
>>       ^~~~~~~~~~~~~~~~~~
>> ```
>>=20
>> It was introduced in https://gcc.gnu.org/PR115185. I don't have time
>> today to check the case to see what the best fix is, but CCing Alex who
>> wrote the warning implementation in case he has a chance.
>
> Thanks for forwarding the report.  It looks like a legit diagnostic.  It
> seems like a bug.

Thank you for analysing it so quickly! I normally try to for bug reports
but I'd already hit an unrelated kernel issue I was debugging so I
didn't want to worry about it for now.

> [...]

> The fix would be to add at least one byte to that array size.  Possibly
> make it 32 for alignment.  But I don't know if that array size is fixed
> by any ABI, so the maintainer will be better placed to find the suitable
> fix.
>
> The only alternatives I see are
>
> -  Use a larger number of elements for that array (1 would be enough).
> -  Use a shorter string so that it fits the 16 bytes.
>
> Have a lovely night!

You too :)

It might be worth making a list of "real bugs the warning found" as
stuff gets ported over the next few months.

> Alex

thanks,
sam

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iOUEARYKAI0WIQQlpruI3Zt2TGtVQcJzhAn1IN+RkAUCZpoC+F8UgAAAAAAuAChp
c3N1ZXItZnByQG5vdGF0aW9ucy5vcGVucGdwLmZpZnRoaG9yc2VtYW4ubmV0MjVB
NkJCODhERDlCNzY0QzZCNTU0MUMyNzM4NDA5RjUyMERGOTE5MA8cc2FtQGdlbnRv
by5vcmcACgkQc4QJ9SDfkZDXxQD9Euuj9qLQJqHz1kzhnlfWBLs61Mle18P10d9c
tAdzBU0BAJUKhJWdMSa1lJzG9dZv24gHwekyF9jRh/D+JTt55UkG
=yOu4
-----END PGP SIGNATURE-----
--=-=-=--

