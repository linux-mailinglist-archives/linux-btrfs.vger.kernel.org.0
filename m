Return-Path: <linux-btrfs+bounces-6570-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5FE69373E8
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Jul 2024 08:08:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 031011C23889
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Jul 2024 06:08:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 912174AEEA;
	Fri, 19 Jul 2024 06:07:44 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97D354A9B0
	for <linux-btrfs@vger.kernel.org>; Fri, 19 Jul 2024 06:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721369264; cv=none; b=j84I0l8t9iviywXB+iWSYJxQUIodhxeD9b+2Ncq0bnjGjMGgbZlEceDmoyrOAOME/1A53Bw7K1be+XnenhZvEgUSmoMCQ38xmI2+/ABH3SJy+McaSifil9+nOpcE4ceJA3oFzn3yV+M3IY4pfk60Lk0QjmZyMmrbn4aLI4yXReI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721369264; c=relaxed/simple;
	bh=KY7a0ZNkOutm5Vog6efE3v6GtgXfMSPnjOkYLo+C02Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=reGkqnW0ufXQtmzsQAPUVKIz8xYXj/51HFM+kAgmQRH8kMpdsMYAvLcIEK03y51onEeWlXDVD7YrhfDqdhdUCzhSt+hCbkEYLl1tio8g9L+CPsCQpKikGWm38gAYS23Hg5N/GoD9iHup/NxINQsxYZCJgeyjpKJIiD1Rxctbr04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
From: Sam James <sam@gentoo.org>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: avoid using fixed char array size for tree names
In-Reply-To: <09fa6dc7de3c7033d92ec7d320a75038f8a94c89.1721364593.git.wqu@suse.com>
	(Qu Wenruo's message of "Fri, 19 Jul 2024 14:20:39 +0930")
Organization: Gentoo
References: <09fa6dc7de3c7033d92ec7d320a75038f8a94c89.1721364593.git.wqu@suse.com>
Date: Fri, 19 Jul 2024 07:07:37 +0100
Message-ID: <874j8lzzh2.fsf@gentoo.org>
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

Qu Wenruo <wqu@suse.com> writes:

> [BUG]
> There is a bug report that using the latest trunk GCC, btrfs would cause
> unterminated-string-initialization warning:
>
>   linux-6.6/fs/btrfs/print-tree.c:29:49: error: initializer-string for ar=
ray of =E2=80=98char=E2=80=99 is too long [-Werror=3Dunterminated-string-in=
itialization]
>    29 |         { BTRFS_BLOCK_GROUP_TREE_OBJECTID,      "BLOCK_GROUP_TREE=
"      },
>       |
>       ^~~~~~~~~~~~~~~~~~
>
> [CAUSE]
> To print tree names we have an array of root_name_map structure, which
> uses "char name[16];" to store the name string of a tree.
>
> But the following trees have names exactly at 16 chars length:
> - "BLOCK_GROUP_TREE"
> - "RAID_STRIPE_TREE"
>
> This means we will have no space for the terminating '\0', and can lead
> to unexpected access when printing the name.
>
> [FIX]
> Instead of "char name[16];" use "const char *" instead.
>
> Since the name strings are all read-only data, and are all NULL
> terminated by default, there is not much need to bother the length at
> all.
>
> Reported-by: Sam James <sam@gentoo.org>
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Thank you for the quick fix! I agree that this seems like the cleanest
change.

Tested-by: Sam James <sam@gentoo.org>

> ---
>  fs/btrfs/print-tree.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/btrfs/print-tree.c b/fs/btrfs/print-tree.c
> index 32dcea662da3..fc821aa446f0 100644
> --- a/fs/btrfs/print-tree.c
> +++ b/fs/btrfs/print-tree.c
> @@ -14,7 +14,7 @@
>=20=20
>  struct root_name_map {
>  	u64 id;
> -	char name[16];
> +	const char *name;
>  };
>=20=20
>  static const struct root_name_map root_map[] =3D {

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iOUEARYKAI0WIQQlpruI3Zt2TGtVQcJzhAn1IN+RkAUCZpoCql8UgAAAAAAuAChp
c3N1ZXItZnByQG5vdGF0aW9ucy5vcGVucGdwLmZpZnRoaG9yc2VtYW4ubmV0MjVB
NkJCODhERDlCNzY0QzZCNTU0MUMyNzM4NDA5RjUyMERGOTE5MA8cc2FtQGdlbnRv
by5vcmcACgkQc4QJ9SDfkZD+ygD+NuAf6seF1oTRB4ys+wH04baEypqRSKlcd7zd
6aWqHDQBALBp5UxWsNCYLwC383FQAOwtBBNlx66s6vJoY3yu+G4M
=Hz3l
-----END PGP SIGNATURE-----
--=-=-=--

