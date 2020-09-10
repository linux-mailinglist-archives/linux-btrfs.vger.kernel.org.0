Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C005A264FC9
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Sep 2020 21:51:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726662AbgIJTvl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 10 Sep 2020 15:51:41 -0400
Received: from mx2.suse.de ([195.135.220.15]:44912 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731231AbgIJPEW (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 10 Sep 2020 11:04:22 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 4671BAF33;
        Thu, 10 Sep 2020 14:27:02 +0000 (UTC)
Date:   Thu, 10 Sep 2020 09:26:43 -0500
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 14/17] btrfs: make btrfs_readpage_end_io_hook() follow
 sector size
Message-ID: <20200910142643.3atvvkuam76n7di2@fiona>
References: <20200908075230.86856-1-wqu@suse.com>
 <20200908075230.86856-15-wqu@suse.com>
 <20200909173457.e4gpsbwkcsxtdo4g@fiona>
 <ba262153-9a5d-d940-59fc-a1e1f3337602@gmx.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="az62lyfxpthoxxmv"
Content-Disposition: inline
In-Reply-To: <ba262153-9a5d-d940-59fc-a1e1f3337602@gmx.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


--az62lyfxpthoxxmv
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On  8:05 10/09, Qu Wenruo wrote:
>=20
>=20
> On 2020/9/10 =E4=B8=8A=E5=8D=881:34, Goldwyn Rodrigues wrote:
> > On 15:52 08/09, Qu Wenruo wrote:
> >> Currently btrfs_readpage_end_io_hook() just pass the whole page to
> >> check_data_csum(), which is fine since we only support sectorsize =3D=
=3D
> >> PAGE_SIZE.
> >>
> >> To support subpage RO support, we need to properly honor per-sector
> >> checksum verification, just like what we did in dio read path.
> >>
> >> This patch will do the csum verification in a for loop, starts with
> >> pg_off =3D=3D start - page_offset(page), with sectorsize increasement =
for
> >> each loop.
> >>
> >> For sectorsize =3D=3D PAGE_SIZE case, the pg_off will always be 0, and=
 we
> >> will only finish with just one loop.
> >>
> >> For subpage, we do the proper loop.
> >>
> >> Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
> >> Signed-off-by: Qu Wenruo <wqu@suse.com>
> >> ---
> >>  fs/btrfs/inode.c | 15 ++++++++++++++-
> >>  1 file changed, 14 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> >> index 078735aa0f68..8bd14dda2067 100644
> >> --- a/fs/btrfs/inode.c
> >> +++ b/fs/btrfs/inode.c
> >> @@ -2851,9 +2851,12 @@ static int btrfs_readpage_end_io_hook(struct bt=
rfs_io_bio *io_bio,
> >>  				      u64 start, u64 end, int mirror)
> >>  {
> >>  	size_t offset =3D start - page_offset(page);
> >> +	size_t pg_off;
> >>  	struct inode *inode =3D page->mapping->host;
> >>  	struct extent_io_tree *io_tree =3D &BTRFS_I(inode)->io_tree;
> >>  	struct btrfs_root *root =3D BTRFS_I(inode)->root;
> >> +	u32 sectorsize =3D root->fs_info->sectorsize;
> >> +	bool found_err =3D false;
> >> =20
> >>  	if (PageChecked(page)) {
> >>  		ClearPageChecked(page);
> >> @@ -2870,7 +2873,17 @@ static int btrfs_readpage_end_io_hook(struct bt=
rfs_io_bio *io_bio,
> >>  	}
> >> =20
> >>  	phy_offset >>=3D inode->i_sb->s_blocksize_bits;
> >> -	return check_data_csum(inode, io_bio, phy_offset, page, offset);
> >> +	for (pg_off =3D offset; pg_off < end - page_offset(page);
> >> +	     pg_off +=3D sectorsize, phy_offset++) {
> >> +		int ret;
> >> +
> >> +		ret =3D check_data_csum(inode, io_bio, phy_offset, page, pg_off);
> >> +		if (ret < 0)
> >> +			found_err =3D true;
> >> +	}
> >> +	if (found_err)
> >> +		return -EIO;
> >> +	return 0;
> >>  }
> >=20
> > We don't need found_err here. Just return ret when you encounter the
> > first error.
> >=20
> But that means, the whole range will be marked error, while some sectors
> may still contain good data and pass the csum checking.
>=20

It would have made sense if you are storing block-by-block value of the
validity of the page so it may be referenced later. The function is only
checking if the data read in the page is correct or not, whether a part
of the data is correct is of no consequence to the caller. The earlier it
returns on an error, the better.. rather than checking the whole range
just to return the same -EIO.

--=20
Goldwyn

--az62lyfxpthoxxmv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQTvlrIsQO1vhIr1p4dJubB2MCI4bAUCX1o3owAKCRBJubB2MCI4
bHLQAJ9ifWmsd5RuSCpXyGUXt+8JtexdwwCdG1lSZzmfb75ttrwXjkgT1WOKTDU=
=BagO
-----END PGP SIGNATURE-----

--az62lyfxpthoxxmv--
