Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FD7323A1CE
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Aug 2020 11:36:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726125AbgHCJfL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 3 Aug 2020 05:35:11 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:54180 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725933AbgHCJfL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 3 Aug 2020 05:35:11 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 5D4331C0BD4; Mon,  3 Aug 2020 11:35:08 +0200 (CEST)
Date:   Mon, 3 Aug 2020 11:35:06 +0200
From:   Pavel Machek <pavel@denx.de>
To:     clm@fb.com, jbacik@fb.com, dsterba@suse.com, sashal@kernel.org,
        wqu@suse.com, nborisov@suse.com, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, jungyeon@gatech.edu,
        stable@kernel.org
Subject: [PATCH] btrfs: fix error value in btrfs_get_extent
Message-ID: <20200803093506.GA19472@amd>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="HcAYCG3uE/tztfnV"
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


--HcAYCG3uE/tztfnV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

btrfs_get_extent() sets variable ret, but out: error path expect error
to be in variable err. Fix that.

Signed-off-by: Pavel Machek (CIP) <pavel@denx.de>

---

Notice that patch introducing this problem is on its way to 4.19.137-stable.

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 7befb7c12bd3..4aaa01540f89 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -7012,7 +7012,7 @@ struct extent_map *btrfs_get_extent(struct btrfs_inod=
e *inode,
 	    found_type =3D=3D BTRFS_FILE_EXTENT_PREALLOC) {
 		/* Only regular file could have regular/prealloc extent */
 		if (!S_ISREG(inode->vfs_inode.i_mode)) {
-			ret =3D -EUCLEAN;
+			err =3D -EUCLEAN;
 			btrfs_crit(fs_info,
 		"regular/prealloc extent found for non-regular inode %llu",
 				   btrfs_ino(inode));

--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--HcAYCG3uE/tztfnV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl8n2koACgkQMOfwapXb+vL5pACgh6F0buh2LZN4PQ6G1CTLMVga
FFcAoJZ6SUZZopdgsJehwPuHA2MO3TIi
=+F+S
-----END PGP SIGNATURE-----

--HcAYCG3uE/tztfnV--
