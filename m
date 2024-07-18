Return-Path: <linux-btrfs+bounces-6556-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D6BC0937098
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Jul 2024 00:26:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56ACA1F22817
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Jul 2024 22:26:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58DAD145FFC;
	Thu, 18 Jul 2024 22:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F+t7Q5j1"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7802E8286A
	for <linux-btrfs@vger.kernel.org>; Thu, 18 Jul 2024 22:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721341607; cv=none; b=PSV23Xpi3xHSZUlYS5HXmIbmaZvIQsq4xoXHhXrut3EFEN5J9I/rpQD6fjrd+Y0eJRAjVIoyWWuhdjNNW+zpfoduJoatcfGoHuCb4WPuN+5RtwfGEiwZtALGBykfdVu/IVagO+vdXRoV8F2MaD5O97TPKunCJRrZquwv2uhyBaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721341607; c=relaxed/simple;
	bh=F6pfvz1eCTAJtZWMsvGSje8/gF/G/PUxhOGWqJ5Mj/M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dzt5uErKhSP+6IEmZMAejthj9u7CjMk/C0gBS0RaHqLoPv5a4IS5x5s9RADN5O7UhtQ1Mf2UXXxz2e+wlYLKcWxsIQ/dX4GMRlpPXEaT+RGIMxw9Eri6US3CgoDNF424G3gOmlsaItlSYMtZH3v+V9svWpKwiA+kid2JgLgmvf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F+t7Q5j1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 542FFC116B1;
	Thu, 18 Jul 2024 22:26:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721341607;
	bh=F6pfvz1eCTAJtZWMsvGSje8/gF/G/PUxhOGWqJ5Mj/M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=F+t7Q5j1J4JmnTNvU3kqX2o1A/lAOS48ZoRL6nfFXcQNJ0ktpJsoAmAsZ8dPvrehd
	 YwOnghVF6dWUkjcB2+vjuC3PNzoCpjc6djEw1Hz0IGxSbkpzi88oU7kIXeo2Vvj6D/
	 6xQ87jbEZqD7sY0dGkSMgpju0HYMTB6Wdoip5x39kmXorIzMOrKCR+xxqdbUgFgpiU
	 d/sKhTvwCS4ItWumNh5gGODH/JP5W/CFbTquT3ExHUCyWXiky4dKmE6aYO+XFiFLiI
	 MYJwUc6eQa4x+X2b2gmyDZ9uGKtV0BZd2f6R/ToQ3pt0wE4uCJClBvpVS1t3kxP+pB
	 KSgmEBI2fQM/A==
Date: Fri, 19 Jul 2024 00:26:44 +0200
From: Alejandro Colomar <alx@kernel.org>
To: Sam James <sam@gentoo.org>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: Build failure with trunk GCC 15 in fs/btrfs/print-tree.c
 (-Wunterminated-string-initialization)
Message-ID: <5mnphkdvheudccjtiatrbjbkqtw54s2wkpeqevj3rqthdqlwyw@sjvn4wn52qki>
References: <87ttgmz7q7.fsf@gentoo.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="rlynzdzr5pnebt4b"
Content-Disposition: inline
In-Reply-To: <87ttgmz7q7.fsf@gentoo.org>


--rlynzdzr5pnebt4b
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: Sam James <sam@gentoo.org>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: Build failure with trunk GCC 15 in fs/btrfs/print-tree.c
 (-Wunterminated-string-initialization)
References: <87ttgmz7q7.fsf@gentoo.org>
MIME-Version: 1.0
In-Reply-To: <87ttgmz7q7.fsf@gentoo.org>

Hi Sam!

On Thu, Jul 18, 2024 at 10:54:40PM GMT, Sam James wrote:
> GCC 15 introduces a new warning -Wunterminated-string-initialization
> which causes, with the kernel's -Werror=3D..., the following:
> ```
> /var/tmp/portage/sys-kernel/gentoo-kernel-6.6.41/work/linux-6.6/fs/btrfs/=
print-tree.c:29:49: error: initializer-string for array of =E2=80=98char=E2=
=80=99 is too long [-Werror=3Dunterminated-string-initialization]
>    29 |         { BTRFS_BLOCK_GROUP_TREE_OBJECTID,      "BLOCK_GROUP_TREE=
"      },
>       |
>       ^~~~~~~~~~~~~~~~~~
> ```
>=20
> It was introduced in https://gcc.gnu.org/PR115185. I don't have time
> today to check the case to see what the best fix is, but CCing Alex who
> wrote the warning implementation in case he has a chance.

Thanks for forwarding the report.  It looks like a legit diagnostic.  It
seems like a bug.

	$ sed -n 15,34p fs/btrfs/print-tree.c;
	struct root_name_map {
		u64 id;
		char name[16];
	};

	static const struct root_name_map root_map[] =3D {
		{ BTRFS_ROOT_TREE_OBJECTID,		"ROOT_TREE"		},
		{ BTRFS_EXTENT_TREE_OBJECTID,		"EXTENT_TREE"		},
		{ BTRFS_CHUNK_TREE_OBJECTID,		"CHUNK_TREE"		},
		{ BTRFS_DEV_TREE_OBJECTID,		"DEV_TREE"		},
		{ BTRFS_FS_TREE_OBJECTID,		"FS_TREE"		},
		{ BTRFS_CSUM_TREE_OBJECTID,		"CSUM_TREE"		},
		{ BTRFS_TREE_LOG_OBJECTID,		"TREE_LOG"		},
		{ BTRFS_QUOTA_TREE_OBJECTID,		"QUOTA_TREE"		},
		{ BTRFS_UUID_TREE_OBJECTID,		"UUID_TREE"		},
		{ BTRFS_FREE_SPACE_TREE_OBJECTID,	"FREE_SPACE_TREE"	},
		{ BTRFS_BLOCK_GROUP_TREE_OBJECTID,	"BLOCK_GROUP_TREE"	},
		{ BTRFS_DATA_RELOC_TREE_OBJECTID,	"DATA_RELOC_TREE"	},
		{ BTRFS_RAID_STRIPE_TREE_OBJECTID,	"RAID_STRIPE_TREE"	},
	};

The non-string is stored in 'root_map'.  It seems only used in one
function:

	$ grepc -tu root_map fs/btrfs/print-tree.c;
	fs/btrfs/print-tree.c:const char *btrfs_root_name(const struct btrfs_key *=
key, char *buf)
	{
		int i;

		if (key->objectid =3D=3D BTRFS_TREE_RELOC_OBJECTID) {
			snprintf(buf, BTRFS_ROOT_NAME_BUF_LEN,
				 "TREE_RELOC offset=3D%llu", key->offset);
			return buf;
		}

		for (i =3D 0; i < ARRAY_SIZE(root_map); i++) {
			if (root_map[i].id =3D=3D key->objectid)
				return root_map[i].name;
		}

		snprintf(buf, BTRFS_ROOT_NAME_BUF_LEN, "%llu", key->objectid);
		return buf;
	}

That function returns the non-string, and also seems to be used exactly
in one place:

	$ find * -type f \
	| grep '\.[hc]$' \
	| xargs grepc -tu btrfs_root_name;
	fs/btrfs/disk-io.c:void btrfs_check_leaked_roots(struct btrfs_fs_info *fs_=
info)
	{
	#ifdef CONFIG_BTRFS_DEBUG
		struct btrfs_root *root;

		while (!list_empty(&fs_info->allocated_roots)) {
			char buf[BTRFS_ROOT_NAME_BUF_LEN];

			root =3D list_first_entry(&fs_info->allocated_roots,
						struct btrfs_root, leak_list);
			btrfs_err(fs_info, "leaked root %s refcount %d",
				  btrfs_root_name(&root->root_key, buf),
				  refcount_read(&root->refs));
			WARN_ON_ONCE(1);
			while (refcount_read(&root->refs) > 1)
				btrfs_put_root(root);
			btrfs_put_root(root);
		}
	#endif
	}

This caller is using the non-string in a "%s" in btrfs_err(), which
itself is a wrapper around btrfs_printk(), which I won't follow too
much, but I expect to treat "%s" the same as printf(3) does.

The fix would be to add at least one byte to that array size.  Possibly
make it 32 for alignment.  But I don't know if that array size is fixed
by any ABI, so the maintainer will be better placed to find the suitable
fix.

The only alternatives I see are

-  Use a larger number of elements for that array (1 would be enough).
-  Use a shorter string so that it fits the 16 bytes.

Have a lovely night!
Alex

--=20
<https://www.alejandro-colomar.es/>

--rlynzdzr5pnebt4b
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE6jqH8KTroDDkXfJAnowa+77/2zIFAmaZlp4ACgkQnowa+77/
2zJjxA/+MQ15TIASCmW4qdwPV6EqrqwVo7X/SFeJGqlWilADGAXErrXXgHmtxClY
bg0JTDycXsj924NMcVe4dZsj5kUenvehAsr2z6deBzUZZ5+wx1CYQzX+TR2wiNcV
6Y+ubyWh4C4mmF016VJCTTOhNf2bvGJrFUZnrj/VlOBAoTpaJ6KPW0N2XebMorJc
9qJrgz4A34nvJJukc/VvyhRHXkBa/kLW/Is1KnHwt4RloH0XpeX6uGKu3dAXNAdk
DdowZiVXOwxxAsshUFLA/qQ1gBQ2wTjBTRNpdl0sBowNYLuca76zMcgfa/G5l1Py
XKiS3sZkMNzYrGm55NowXSNRMYhMqLnzfIeqGZmuYPxJKFUflDcVBGLxgQwcUAuq
J+jXiM/05bewnCydKokbRRKIvF4OmnlC5YGR3K5YUoP2WIMu0yqy0qyg489q5Xxs
qHtx2SlSNuvodfDJwq9OK/mFK99dxi0f9JOSGcSrJpJ1WEcN4Ze2blUboFpAc1gt
I7B07LzAb5ddpbecP1SNkPsZkzDwV8gSRxRt966GhlveR/T8RamQ8kxU38jDj/C9
kqxXHApjaptxrqMAw/CI9dMNQagwF4mjraKf5y7X8NbjUGPocSAdMmAnE1Vkgtqs
QCtqqWVnsi/DICVtMMAEloy4ZhEklrdKiXcZCvHhIQHfKxwd2Jk=
=AnM0
-----END PGP SIGNATURE-----

--rlynzdzr5pnebt4b--

