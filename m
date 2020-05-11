Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D34B91CD3F8
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 May 2020 10:31:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728544AbgEKIbl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 11 May 2020 04:31:41 -0400
Received: from mout.gmx.net ([212.227.15.18]:38359 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728454AbgEKIbl (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 11 May 2020 04:31:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1589185896;
        bh=c7xuO/iP+qbEKaGk7yBrRzRRcENFL+Fuvt7JXu6DB6M=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=D9AF/0kA0YohDP5U7wbJuLDE+6w0h39KrPGR3JTQjarvl3NGstWnajK62AF61NiRz
         2piyI+EoQp9YjevMPRLf2mzzoInUgTXBJQMJQ/N0jnDK0UGB8jtQpFTs70qsZpewx7
         TV7RBEVgyoM2XvA2bOtNa8cxQ0rqr3A9pR6HrHnQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MwfWa-1jAd7F347m-00yAwC; Mon, 11
 May 2020 10:31:36 +0200
Subject: Re: Balance loops: what we know so far
To:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
Cc:     linux-btrfs@vger.kernel.org
References: <20200411211414.GP13306@hungrycats.org>
 <b3e80e75-5d27-ec58-19af-11ba5a20e08c@gmx.com>
 <20200428045500.GA10769@hungrycats.org>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Autocrypt: addr=quwenruo.btrfs@gmx.com; prefer-encrypt=mutual; keydata=
 mQENBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAG0IlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT6JAU4EEwEIADgCGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCXZw1oQAKCRDC
 PZHzoSX+qCY6CACd+mWu3okGwRKXju6bou+7VkqCaHTdyXwWFTsr+/0ly5nUdDtT3yEVggPJ
 3VP70wjlrxUjNjFb6iIvGYxiPOrop1NGwGYvQktgRhaIhALG6rPoSSAhGNjwGVRw0km0PlIN
 D29BTj/lYEk+jVM1YL0QLgAE1AI3krihg/lp/fQT53wLhR8YZIF8ETXbClQG1vJ0cllPuEEv
 efKxRyiTSjB+PsozSvYWhXsPeJ+KKjFen7ebE5reQTPFzSHctCdPnoR/4jSPlnTlnEvLeqcD
 ZTuKfQe1gWrPeevQzgCtgBF/WjIOeJs41klnYzC3DymuQlmFubss0jShLOW8eSOOWhLRuQEN
 BFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcgaCbPEwhLj
 1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj/IrRUUka
 68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fNGSsRb+pK
 EKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0q1eW4Jrv
 0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEvABEBAAGJ
 ATwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCXZw1rgUJCWpOfwAKCRDCPZHz
 oSX+qFcEB/95cs8cM1OQdE/GgOfCGxwgckMeWyzOR7bkAWW0lDVp2hpgJuxBW/gyfmtBnUai
 fnggx3EE3ev8HTysZU9q0h+TJwwJKGv6sUc8qcTGFDtavnnl+r6xDUY7A6GvXEsSoCEEynby
 72byGeSovfq/4AWGNPBG1L61Exl+gbqfvbECP3ziXnob009+z9I4qXodHSYINfAkZkA523JG
 ap12LndJeLk3gfWNZfXEWyGnuciRGbqESkhIRav8ootsCIops/SqXm0/k+Kcl4gGUO/iD/T5
 oagaDh0QtOd8RWSMwLxwn8uIhpH84Q4X1LadJ5NCgGa6xPP5qqRuiC+9gZqbq4Nj
Message-ID: <4bebdd24-ccaa-1128-7870-b59b08086d83@gmx.com>
Date:   Mon, 11 May 2020 16:31:32 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200428045500.GA10769@hungrycats.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="e54LpEXcYfRDhQDI0LkERYIodLxX9d5RO"
X-Provags-ID: V03:K1:v+tQfZJIowoGHYHwv/6QtAUBdyvX1n07h1bEOm+ZmlXMI8D/1jJ
 RlozaGep3gAgmQLlrGKTVoeV14Zs7wxAFd5nh1XtP3jgba1r+4b3fv5W2DZj/ydZ1Mh47XE
 9g//P41F+jxwNOSRlxlOa8YyHfrA3lnblybI0xVmGnxXR/KrlUYzptIJxnx7tQzXJJy50WW
 ICaBfzxXZzgWm+m+h0aHQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:SIqu67wVkOo=:E2PZBuRsi8UDwxquJM4sFf
 XjumwKOdVqPMXtnNMRfWws0XyT5cH3juy2Pvih9/UghGB3AxQgmliQ1fBpRwLEWi2K+NkpEdU
 L79N5Px+mqX20IGPAzSrpRA2/Hr8bpWirHsu1PvpNXOTKniBBmtl8f+/dpDl+DJfmUJuAdsqt
 SuLxKKemcyf4CjcJRPNi2T+bHEr0/DFo4AzZQVoCMIzPPTjnOTZbosL8XHAQ3MnPQVSiKVFKy
 B6pfXzqj5LAbCzvqvz34YoyqcjJmtrgceyVWp0joYHt6tcitSkOKpGvhlhNDX8UaS2kwGXddM
 XS8nrmq/1iamMSnU/FPLHOYqO47OKduxt91jCnKFaiIzI7BSxgF4qN7QQzQHD+2XkGrxJeVCw
 ftdhKRZCm4posJEgDc2fGRC4VATZnbHgkIFPwnfyx5EmxHxMXODZKv8PLC3GO2tkfohV8kMc0
 EezoTu1amlO7cqbhIMkO4bR101Vz+pjhMYx2gzG4gTZjQiQ8YBXsyF3QeQ5DTcxDHtKuip15A
 UsFHyyrkJY0IxNx88zxMXDk+PPtLcHfGM30ntdrgDAhKYDxKCHV9gxGFMWlwwrBtt/DFCq3GS
 bxPrx/+49ScIJm9NP+/+eo1g8010BM2isB7zptGRxrejyxlUBbkce05Tc0wWzAQEyJFFrcJ+S
 oSrrYgEK2rOjDl9CkyitD0/+3W35CBk4yvZGSUNA+5zJWP5pQBxIOW6wxkTIo6Rhd6seH+LAT
 Nou4P1/aCnlthbRPhpuQs2iGWZ6hWyKJnDAy3vGfMpZDkTzowDCtkC9b1xBCN5Xd0VSOQcMGz
 PBLacUyh0FNNnwVk7Ysyx5KNqvgbT2My2qLWySVDKS3v0NNnDIZnXD3+j8UgBxldLEjqN9XQJ
 +Vi3FfBdQsQCGkr/hNE/bDIZoafkHqFLqbdT5iitzkrUyA05yt+bw3jYX6RaunGKT0WoKqmER
 XB9Z1GqO/x4t1ZJ/upNbBc8BXBnrIqWJOrBDJJzfznQrUlp9a/lIet7in8D9/M84TDRHE8eNT
 ooFNK8R68BCJ4pfKb8HQUgy+TlfkJhFQE8X7Yotw7iaYapk6wUDNciGsCQOrP5CwA8WFEW9dP
 SXoigVtR1h6bCN2UVrtmn05jU927UILWW25VLlO+8Es7o/sN749raQw7KuXBoZJsAXWoI4ZB+
 18D1tQ/SL1BtqilGPHoy9QccmRdV/D2N6Usjt73GR0wGbfWcpHGJGynQ0zMCFp4Zc4VCShZKp
 L574+tTgH2BV7F0R2
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--e54LpEXcYfRDhQDI0LkERYIodLxX9d5RO
Content-Type: multipart/mixed; boundary="kbCguj7jt229YqRk0cXvwtMojh6vKCtRg"

--kbCguj7jt229YqRk0cXvwtMojh6vKCtRg
Content-Type: multipart/mixed;
 boundary="------------EB6BFEAC4FE2D03EEA42E90C"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------EB6BFEAC4FE2D03EEA42E90C
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Zygo,

Would you like to test this diff?

Although I haven't find a solid reason yet, there is another report and
with the help from the reporter, it turns out that balance hangs at
relocating DATA_RELOC tree block.

After some more digging, DATA_RELOC tree doesn't need REF_COW bit at all
since we can't create snapshot for data reloc tree.

By removing the REF_COW bit, we could ensure that data reloc tree always
get cowed for relocation (just like extent tree), this would hugely
reduce the complexity for data reloc tree.

Not sure if this would help, but it passes my local balance run.

Thanks,
Qu

--------------EB6BFEAC4FE2D03EEA42E90C
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-btrfs-Remove-the-REF_COW-bit-for-data-reloc-tree.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename*0="0001-btrfs-Remove-the-REF_COW-bit-for-data-reloc-tree.patch"

=46rom 82f3b96a68561b2de9712262cb652192b8ea9b1b Mon Sep 17 00:00:00 2001
From: Qu Wenruo <wqu@suse.com>
Date: Mon, 11 May 2020 16:27:43 +0800
Subject: [PATCH] btrfs: Remove the REF_COW bit for data reloc tree

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/disk-io.c    | 9 ++++++++-
 fs/btrfs/inode.c      | 6 ++++--
 fs/btrfs/relocation.c | 3 ++-
 3 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 56675d3cd23a..cb90966a8aab 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -1418,9 +1418,16 @@ static int btrfs_init_fs_root(struct btrfs_root *r=
oot)
 	if (ret)
 		goto fail;
=20
-	if (root->root_key.objectid !=3D BTRFS_TREE_LOG_OBJECTID) {
+	if (root->root_key.objectid !=3D BTRFS_TREE_LOG_OBJECTID &&
+	    root->root_key.objectid !=3D BTRFS_DATA_RELOC_TREE_OBJECTID) {
 		set_bit(BTRFS_ROOT_REF_COWS, &root->state);
 		btrfs_check_and_init_root_item(&root->root_item);
+	} else if (root->root_key.objectid =3D=3D BTRFS_DATA_RELOC_TREE_OBJECTI=
D) {
+		/*
+		 * Data reloc tree won't be snapshotted, thus it's COW only
+		 * tree, it's needed to set TRACK_DIRTY bit for it.
+		 */
+		set_bit(BTRFS_ROOT_TRACK_DIRTY, &root->state);
 	}
=20
 	btrfs_init_free_ino_ctl(root);
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 5d567082f95a..71841535c7ca 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -4129,7 +4129,8 @@ int btrfs_truncate_inode_items(struct btrfs_trans_h=
andle *trans,
 	 * extent just the way it is.
 	 */
 	if (test_bit(BTRFS_ROOT_REF_COWS, &root->state) ||
-	    root =3D=3D fs_info->tree_root)
+	    root =3D=3D fs_info->tree_root ||
+	    root->root_key.objectid =3D=3D BTRFS_DATA_RELOC_TREE_OBJECTID)
 		btrfs_drop_extent_cache(BTRFS_I(inode), ALIGN(new_size,
 					fs_info->sectorsize),
 					(u64)-1, 0);
@@ -4334,7 +4335,8 @@ int btrfs_truncate_inode_items(struct btrfs_trans_h=
andle *trans,
=20
 		if (found_extent &&
 		    (test_bit(BTRFS_ROOT_REF_COWS, &root->state) ||
-		     root =3D=3D fs_info->tree_root)) {
+		     root =3D=3D fs_info->tree_root ||
+		     root->root_key.objectid =3D=3D BTRFS_DATA_RELOC_TREE_OBJECTID)) {=

 			struct btrfs_ref ref =3D { 0 };
=20
 			bytes_deleted +=3D extent_num_bytes;
diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index f25deca18a5d..a85dd5d465f6 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -1087,7 +1087,8 @@ int replace_file_extents(struct btrfs_trans_handle =
*trans,
 		 * if we are modifying block in fs tree, wait for readpage
 		 * to complete and drop the extent cache
 		 */
-		if (root->root_key.objectid !=3D BTRFS_TREE_RELOC_OBJECTID) {
+		if (root->root_key.objectid !=3D BTRFS_TREE_RELOC_OBJECTID &&
+		    root->root_key.objectid !=3D BTRFS_DATA_RELOC_TREE_OBJECTID) {
 			if (first) {
 				inode =3D find_next_inode(root, key.objectid);
 				first =3D 0;
--=20
2.26.2


--------------EB6BFEAC4FE2D03EEA42E90C--

--kbCguj7jt229YqRk0cXvwtMojh6vKCtRg--

--e54LpEXcYfRDhQDI0LkERYIodLxX9d5RO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl65DWQACgkQwj2R86El
/qhxDwf/bC/IU0Rqzto7QDEMf2NpGbbVBLVsC+yzdU4hi95wMJP1Ty75ticQC4tv
XzYNJrC0yWiLioWvPaBCssW8sDeU9lfbxr8C+nRP5VaRhPOS8Qhi0ox291rVopcX
ikdtYX6YZFWK6WrzImbH/BKqFRRTGDFfxP66UgZB0ltMt5TYMlhH5uQVg+UQF568
xt25aS194Izh/18gtj3/OBtaNTL1FGnLskxmh+XsT2/Q6BvPQDVxnylDOmjygZkr
2J+01+G55ZvDRft9rirpLl4BdFdwgbA/BCjqAVqRhM6lPPw/59mQewx1LKRGXv/O
wlmaeBUUpgv4M5e4VoMHjh8YrdjkAw==
=cMHt
-----END PGP SIGNATURE-----

--e54LpEXcYfRDhQDI0LkERYIodLxX9d5RO--
