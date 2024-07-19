Return-Path: <linux-btrfs+bounces-6592-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4418B9376BC
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Jul 2024 12:44:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C337EB219D6
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Jul 2024 10:43:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E28E83CC7;
	Fri, 19 Jul 2024 10:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tQFIFYWP"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 941D31B86D0
	for <linux-btrfs@vger.kernel.org>; Fri, 19 Jul 2024 10:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721385832; cv=none; b=QxYXh1mzP0BqlbqmKgl7BU6Nm4whamMItxn581fVI0hHWsgs0w4Nx/sDz/57YatNMgFyHn51xD9bUKmNfYFFRXKJ7/ZGZKkbKw/VOhpDwvOYJnW1NCPdMu6SKUfdPXbnKhFTBOwbPYpm66Fsp0sej9ktXTZ6hOUraBObbccK9dY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721385832; c=relaxed/simple;
	bh=Y9t2stS96PXKBysdEK9d4MrA0MmK7mHDzg31l1npQ2U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JdmVTSTeuI/VKPZjspo/1vXmmJVcbUhKBat3mR1VTHuuhSBGSsfrBKnNGy1G+0rzoyB75pTyfp/gc97zxIjIIaRMKDX5Cr5QXiSe9wRCPevdueWC9Age445qO5Sa0mtO8BJz7PmXX3IJhQeXakBdYUMr1mFesdUQCEaZJ1YPMWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tQFIFYWP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F36EC32782;
	Fri, 19 Jul 2024 10:43:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721385832;
	bh=Y9t2stS96PXKBysdEK9d4MrA0MmK7mHDzg31l1npQ2U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tQFIFYWP+YGiwVc7+w5NBZ7pJkTvJ3hgam3A03IPs6cRJhdgISI70sxj7kFPbdlc3
	 tLEmP2L8NTYEygwK7Zu8fxiYvVUYj5jn5M40UtrNYqPSjhKq3vl8B8gcblPI8OO86/
	 0be8oXjBQeb7+NEhupGx+K+pxM3BpO+QKUgfSxUF/+f4rg2Q+tCz9aJ8QksuaBOPn/
	 Q0NOoj5POeJDV3Z/J3oELVb3ioOey5at+/OZCF9sYgI3IO+E3rtxgwTiY7G+4CTFnN
	 kkHjIucbxBhISjcup9J02L9o5AQ9UxiaYxDExC0RQfBkILqiQxPt01Jz78XxX9Cvtx
	 +0wAMsRSSF4Hw==
Date: Fri, 19 Jul 2024 12:43:49 +0200
From: Alejandro Colomar <alx@kernel.org>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, Sam James <sam@gentoo.org>
Subject: Re: [PATCH v2] btrfs: avoid using fixed char array size for tree
 names
Message-ID: <wm3ti466actdcytkumpnzn56ses7d5f2lngz6sx3nqdu7htp4r@ofj3qwguda3p>
References: <b6633fbd1110ce2b5ff03ff9605f59e508ff31d0.1721380874.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="e2ekweh4cwiyhld3"
Content-Disposition: inline
In-Reply-To: <b6633fbd1110ce2b5ff03ff9605f59e508ff31d0.1721380874.git.wqu@suse.com>


--e2ekweh4cwiyhld3
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, Sam James <sam@gentoo.org>
Subject: Re: [PATCH v2] btrfs: avoid using fixed char array size for tree
 names
References: <b6633fbd1110ce2b5ff03ff9605f59e508ff31d0.1721380874.git.wqu@suse.com>
MIME-Version: 1.0
In-Reply-To: <b6633fbd1110ce2b5ff03ff9605f59e508ff31d0.1721380874.git.wqu@suse.com>

Hi Qu,

On Fri, Jul 19, 2024 at 06:56:46PM GMT, Qu Wenruo wrote:
> [BUG]
> There is a bug report that using the latest trunk GCC, btrfs would cause
> unterminated-string-initialization warning:
>=20
>   linux-6.6/fs/btrfs/print-tree.c:29:49: error: initializer-string for ar=
ray of =E2=80=98char=E2=80=99 is too long [-Werror=3Dunterminated-string-in=
itialization]
>    29 |         { BTRFS_BLOCK_GROUP_TREE_OBJECTID,      "BLOCK_GROUP_TREE=
"      },
>       |
>       ^~~~~~~~~~~~~~~~~~
>=20
> [CAUSE]
> To print tree names we have an array of root_name_map structure, which
> uses "char name[16];" to store the name string of a tree.
>=20
> But the following trees have names exactly at 16 chars length:
> - "BLOCK_GROUP_TREE"
> - "RAID_STRIPE_TREE"
>=20
> This means we will have no space for the terminating '\0', and can lead
> to unexpected access when printing the name.
>=20
> [FIX]
> Instead of "char name[16];" use "const char *" instead.
>=20
> Since the name strings are all read-only data, and are all NULL
> terminated by default, there is not much need to bother the length at
> all.

LGTM.

> Fixes: edde81f1abf29 ("btrfs: add raid stripe tree pretty printer")
> Fixes: 9c54e80ddc6bd ("btrfs: add code to support the block group root")
> Reported-by: Sam James <sam@gentoo.org>
> Reported-by: Alejandro Colomar <alx@kernel.org>
> Suggested-by: Alejandro Colomar <alx@kernel.org>
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
> Changelog:
> v2:
> - Add all the needed tags
>   Especially for the two fixes tags.

Thanks.

>=20
>  fs/btrfs/print-tree.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/fs/btrfs/print-tree.c b/fs/btrfs/print-tree.c
> index 32dcea662da3..fc821aa446f0 100644
> --- a/fs/btrfs/print-tree.c
> +++ b/fs/btrfs/print-tree.c
> @@ -14,7 +14,7 @@
> =20
>  struct root_name_map {
>  	u64 id;
> -	char name[16];
> +	const char *name;
>  };
> =20
>  static const struct root_name_map root_map[] =3D {

LGTM.  Thanks!

I don't know the source enough to know if this affects anything else,
but at face value, I'd say:

Reviewed-by: Alejandro Colomar <alx@kernel.org>

Have a lovely day!
Alex

> --=20
> 2.45.2
>=20

--=20
<https://www.alejandro-colomar.es/>

--e2ekweh4cwiyhld3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE6jqH8KTroDDkXfJAnowa+77/2zIFAmaaQ18ACgkQnowa+77/
2zKTgRAAh4Mi8KhF7aoJbxDUp1i6ZmlHrQP7Ufx4CJrHV3o4hc9KV/JSrFVjtqX7
iiEkVyNueHBMcvKIGvwrZGl6rNGdxgxUsNO6YWcWCooQi/4ijKHak3ZeORvsp4Xz
Cj7EFFes4KJXY9PBfmkr5oEPL5FZlhSqqFL87SOedoagn4AThbfFfSawJEFJ5wKR
LikURD+1xGjc9I7ZBeHvYrO+9mqFbPYZlaxNn8lFoUzY55hbQgzzBQOR9oJMtCck
smAFB8M4jtDqzDngb3nE0Hpp3XTDot6AkDFHX2fiFeAC7Ey0QeLXSnwOza5WfxZp
GoQiGC12UPJQ3jy+ccTnwHiTR5i7Jtly/gV7/iNUOcXU2VKwTI+e08k535s+rIoa
/LWXRk1ejFLM6lzQeUo+KYTJoOTxbxvvxuji+lp5XhG0ihh1rCYgOD7Zgd5Gdm+0
QN1yXlc+n7uDC8gHHg9eovahGjB2YvA5iYgJMt8p0TH1z0GNchnnMfBrYy8n/vGC
WX3/sJYXi/Pmz2D4Cow1V4fLM6ferldMnwnrpfWkWtrnis25ITQ1LjfvcPa0Foju
Lu/qANizm4p/eCmM2r5incpOoc0YBbVYN7tbMsgM8mfO+MvMSFvK8y6SUklCq+UE
WYVUig5dbMfYYPGK4Rk4lQ63VBmOhAUocZM6bBDladd6ptDoJJY=
=Z56m
-----END PGP SIGNATURE-----

--e2ekweh4cwiyhld3--

