Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5954F12F6A6
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Jan 2020 11:15:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727313AbgACKPS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 3 Jan 2020 05:15:18 -0500
Received: from mout.gmx.net ([212.227.17.20]:45541 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725972AbgACKPS (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 3 Jan 2020 05:15:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1578046509;
        bh=p86r/wwOrMuNWTpHk4MPQXMwoUl1EmFOlblOCUo+xNc=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=HHVFrUJcpPfMPoNYn1Nzak87R5xu7OCW/uicReviBq1kIsKwHPoPMB0wJM4+9mGm/
         I1geQ9gWDGY7Vycel4FMbnhOBdKweIUw67+vn5QADDeYw1hcvsSIDuucqsN/hUKZmG
         ez1YBC77Dtgchfl/7OucRkYY1+KxvmRyVTgI8+/o=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1My36N-1jeaf5167T-00zWns; Fri, 03
 Jan 2020 11:15:08 +0100
Subject: Re: [PATCH] btrfs: add extra ending condition for indirect data
 backref resolution
To:     ethanwu <ethanwu@synology.com>, linux-btrfs@vger.kernel.org
References: <1578044681-25562-1-git-send-email-ethanwu@synology.com>
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
Message-ID: <ff4f41f1-b0f0-a787-a9c4-73fbb5893fa4@gmx.com>
Date:   Fri, 3 Jan 2020 18:15:04 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <1578044681-25562-1-git-send-email-ethanwu@synology.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="7oQYT6kk7MU9yAW2N8oI8dNelcjHBQXtk"
X-Provags-ID: V03:K1:d4xgZXQq2glp1DslE3d0KMtu2BN2COld58abycRva0rjZG2tuOQ
 GCl8BWf7hWa0wpZsaItmJCSbSNW++ZX6kqRSHR+K3fI2bsjAWB0Fx7d7vCF5i/hcGm+wx2Y
 YrKT/dPpxzl0PexwwI+RyC/1F6Z2W0Q4iKdeB8Fx+5OTGnrWxS2WW4tC+WfuG8Gv3v7BIwu
 K9jJjxhE0tGIenQSYaqhA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:6paR2Aw1oEQ=:XWC9rR3WQNASjI461ka+0L
 qTSneP1dxJJbHdlq/WGtuOhrBe//2c733xkmc/baXY52zgF0FQ08eJ/LqaHAL1VH2cO6fdgFI
 9Tuk2AZe69SBvqZaE1A9fpARITFhgoZuxVC8ppMZTN2c4yu/GX0fXjAo9l2Au0nbPb7nNS+XW
 dhw/YubPsYwLPP37ve5R1KNOzblwePEG7AftJwVktTdDBoziwGQqJ7uzk1QbnvsmFVHW+pavU
 KIp7wzcLS0Swfh1b0XKWklEle0tGsOyfSvVul1EjG7QNGoJCFWca8k/GqrilQwXaVpHsjRp61
 ZcpJ5exhRQgTIVfZq7FQhmAnqWRj8+wvrfNNsVgRnTIgUeS8/3uOngwLg2Zi+636FFOuZp08L
 uenLzg4kBfGqdW5bp1A0QBWLBpN+4naFidxKGjdLmeBKqolodpfr3E1tEdmeweq5gTN9ep9Z9
 lES4u2mdbN/QoEVOBYXZd8C1rPZQ1Un3oFTPTcMnhYqravtW+Ny0kinJk6DWux+iK1Yxp0ofd
 51Ly8c2tqlP1jwd+PV9TIwgD4cdGi4UhrGQxpXlQpArml8eRMNokWTggFJ8JmbKAemvCQ74+q
 5e508ZSxwYy3u74z88BrHHa5KSQTYnHXb4FqQsR29vIvWyskNrRkOKisfzr+XcHBsXv0ZbwIJ
 FGLqNr5flhDhMqtV+AsAbs3Eey10ND8MN2PG0Ha1SS7KR0BKZ79Ao33RkrMF705RefJfJIkHn
 AfXbEPsVLBYe5n537qC5CMbbiJ5MogpxbSbyatL7ndVLKWTlZ4kL4OUncWP+m91X1sBXmkl1b
 k0jC9udRQJxrNLfe/Cfx/cTecBY2p02dt5IaRkKrqfFPOmlsd63AjwiT7dCH7r1lpImASIptS
 DeDUTA92dUm6WStjAcpzhp13zb/DltV1XRjNxjgbqVrM/B5Brxh3r8s+8VcVLRjiEEVq6GJi+
 efS8D2rpSMxrS3LwFx55M3fART90GDygO57z2Vay1jsagtxAIBCq9PesBmCRiVslF1XJf2jjR
 chhrq+gW+g77tkpLnB42Ozjir0d82OjVu8SRl+o57mplQdXkuOWm3A7hlvVDLiH2boJHEAsw2
 M/6l99ILD63xDoNQwIIj0XFGBLxzj7FqV2gjtg3m6xv+iO1x+T2mC7IBjKaxmZARZaYyuOjNr
 ePQrxDRwwNclXPcnxhJzlQYT+u0/vediFPHyrCZDfbF3Vtorr6j8dx3aQdtgqrBJ3aEvcsp0O
 su+5qFbyauuEUcQVikGatyFHONP65JUeLXAkVV3ht3F7W06M4SAhR5F8Lrtc=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--7oQYT6kk7MU9yAW2N8oI8dNelcjHBQXtk
Content-Type: multipart/mixed; boundary="cMG6eZYwjXH7TIRfSWCrweLs79Pe5f8Wr"

--cMG6eZYwjXH7TIRfSWCrweLs79Pe5f8Wr
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/1/3 =E4=B8=8B=E5=8D=885:44, ethanwu wrote:
> Btrfs has two types of data backref.
> For BTRFS_EXTENT_DATA_REF_KEY type of backref, we don't have the
> exact block number. Therefore, we need to call resolve_indirect_refs
> which uses btrfs_search_slot to locate the leaf block. After that,
> we need to walk through the leafs to search for the EXTENT_DATA items
> that have disk bytenr matching the extent item(add_all_parents).
>=20
> The only conditions we'll stop searching are
> 1. We find different object id or type is not EXTENT_DATA
> 2. We've already got all the refs we want(total_refs)
>=20
> Take the following EXTENT_ITEM as example:
> item 11 key (40831553536 EXTENT_ITEM 4194304) itemoff 15460 itemsize 95=

>     extent refs 24 gen 7302 flags DATA
>     extent data backref root 257 objectid 260 offset 65536 count 5 #bac=
kref entry 1
>     extent data backref root 258 objectid 265 offset 0 count 9 #backref=
 entry 2
>     shared data backref parent 394985472 count 10 #backref entry 3
>=20
> If we want to search for backref entry 1, total_refs here would be 24 r=
ather
> than its count 5.
>=20
> The reason to use 24 is because some EXTENT_DATA in backref entry 3 blo=
ck
> 394985472 also points to EXTENT_ITEM 40831553536, if this block also be=
longs to
> root 257 and lies between these 5 items of backref entry 1,
> and we use total_refs =3D 5, we'll end up missing some refs from backre=
f
> entry 1.

Indeed looks like a problem.

>=20
> But using total_refs=3D24 is not accurate. We'll never find extent data=
 keys in
> backref entry 2, since we searched root 257 not 258. We'll never reach =
block
> 394985472 either if this block is not a leaf in root 257.
> As a result, the loop keeps on going until we reach the end of that ino=
de.
>=20
> Since we're searching for parent block of this backref entry 1,
> we're 100% sure we'll never find any EXTENT_DATA beyond (65536 + 419430=
4) that
> matching this entry.

Backref offset is always a bug-prone member, thus I hope to double check
on this.

What if the backref offset already underflows?
Like this:
  item 10 key (13631488 EXTENT_ITEM 1048576) itemoff 15860 itemsize 111
       refs 3 gen 6 flags DATA
       extent data backref root FS_TREE objectid 259 offset
18446744073709547520 count 1 <<<
       extent data backref root FS_TREE objectid 257 offset 0 count 1
       extent data backref root FS_TREE objectid 258 offset 4096 count 1


Since backref offset is not file offset, but file_extent_item::offset -
file_offset, it can be a super large number for reflinked extents.


Current kernel handles this by a very ugly but working hack: resetting
key_for_search.offset to 0 in add_prelim_ref() if it detects such case.

Then this would screw up your check, causing unexpected early exit.

I guess we have to find a new method to solve the problem then.

Thanks,
Qu

> If there's any EXTENT_DATA with offset beyond this range
> using this extent item, its backref must be stored at different backref=
 entry.
> That EXTENT_DATA will be handled when we process that backref entry.
>=20
> Fix this by breaking from loop if we reach offset + (size of EXTENT_ITE=
M).
>=20
> btrfs send use backref to search for clone candidate.
> Without this patch, performance drops when running following script.
> This script creates a 10G file with all of its extent size 64K.
> Then it generates shared backref for each data extent, and
> those backrefs could not be found when doing btrfs_resolve_indirect_ref=
s.
>=20
> item 87 key (11843469312 EXTENT_ITEM 65536) itemoff 10475 itemsize 66
>     refs 3 gen 74 flags DATA
>     extent data backref root 256 objectid 260 offset 10289152 count 2
>     # This shared backref couldn't be found when resolving
>     # indirect ref from snapshot of sub 256
>     shared data backref parent 2303049728 count 1
>=20
> btrfs subvolume create /volume1/sub1
> for i in `seq 1 163840`; do dd if=3D/dev/zero of=3D/volume1/sub1/file b=
s=3D64K count=3D1 seek=3D$((i-1)) conv=3Dnotrunc oflag=3Ddirect 2>/dev/nu=
ll; done
> btrfs subvolume snapshot /volume1/sub1 /volume1/sub2
> for i in `seq 1 163840`; do dd if=3D/dev/zero of=3D/volume1/sub1/file b=
s=3D4K count=3D1 seek=3D$(((i-1)*16+10)) conv=3Dnotrunc oflag=3Ddirect 2>=
/dev/null; done
> btrfs subvolume snapshot -r /volume1/sub1 /volume1/snap1
> time btrfs send /volume1/snap1 | btrfs receive /volume2
>=20
> without this patch
> real 69m48.124s
> user 0m50.199s
> sys  70m15.600s
>=20
> with this patch
> real 1m31.498s
> user 0m35.858s
> sys  2m55.544s
>=20
> Signed-off-by: ethanwu <ethanwu@synology.com>
> ---
>  fs/btrfs/backref.c | 21 +++++++++++++++------
>  1 file changed, 15 insertions(+), 6 deletions(-)
>=20
> diff --git a/fs/btrfs/backref.c b/fs/btrfs/backref.c
> index e5d8531..ae64995 100644
> --- a/fs/btrfs/backref.c
> +++ b/fs/btrfs/backref.c
> @@ -412,7 +412,7 @@ static int add_indirect_ref(const struct btrfs_fs_i=
nfo *fs_info,
>  static int add_all_parents(struct btrfs_root *root, struct btrfs_path =
*path,
>  			   struct ulist *parents, struct prelim_ref *ref,
>  			   int level, u64 time_seq, const u64 *extent_item_pos,
> -			   u64 total_refs, bool ignore_offset)
> +			   u64 total_refs, bool ignore_offset, u64 num_bytes)
>  {
>  	int ret =3D 0;
>  	int slot;
> @@ -458,6 +458,9 @@ static int add_all_parents(struct btrfs_root *root,=
 struct btrfs_path *path,
>  		fi =3D btrfs_item_ptr(eb, slot, struct btrfs_file_extent_item);
>  		disk_byte =3D btrfs_file_extent_disk_bytenr(eb, fi);
> =20
> +		if (key_for_search->type =3D=3D BTRFS_EXTENT_DATA_KEY &&
> +		    key.offset >=3D key_for_search->offset + num_bytes)
> +		       break;
>  		if (disk_byte =3D=3D wanted_disk_byte) {
>  			eie =3D NULL;
>  			old =3D NULL;
> @@ -504,7 +507,7 @@ static int resolve_indirect_ref(struct btrfs_fs_inf=
o *fs_info,
>  				struct btrfs_path *path, u64 time_seq,
>  				struct prelim_ref *ref, struct ulist *parents,
>  				const u64 *extent_item_pos, u64 total_refs,
> -				bool ignore_offset)
> +				bool ignore_offset, u64 num_bytes)
>  {
>  	struct btrfs_root *root;
>  	struct btrfs_key root_key;
> @@ -575,7 +578,8 @@ static int resolve_indirect_ref(struct btrfs_fs_inf=
o *fs_info,
>  	}
> =20
>  	ret =3D add_all_parents(root, path, parents, ref, level, time_seq,
> -			      extent_item_pos, total_refs, ignore_offset);
> +			      extent_item_pos, total_refs, ignore_offset,
> +			      num_bytes);
>  out:
>  	path->lowest_level =3D 0;
>  	btrfs_release_path(path);
> @@ -610,7 +614,8 @@ static int resolve_indirect_refs(struct btrfs_fs_in=
fo *fs_info,
>  				 struct btrfs_path *path, u64 time_seq,
>  				 struct preftrees *preftrees,
>  				 const u64 *extent_item_pos, u64 total_refs,
> -				 struct share_check *sc, bool ignore_offset)
> +				 struct share_check *sc, bool ignore_offset,
> +				 u64 num_bytes)
>  {
>  	int err;
>  	int ret =3D 0;
> @@ -655,7 +660,7 @@ static int resolve_indirect_refs(struct btrfs_fs_in=
fo *fs_info,
>  		}
>  		err =3D resolve_indirect_ref(fs_info, path, time_seq, ref,
>  					   parents, extent_item_pos,
> -					   total_refs, ignore_offset);
> +					   total_refs, ignore_offset, num_bytes);
>  		/*
>  		 * we can only tolerate ENOENT,otherwise,we should catch error
>  		 * and return directly.
> @@ -1127,6 +1132,7 @@ static int find_parent_nodes(struct btrfs_trans_h=
andle *trans,
>  	struct extent_inode_elem *eie =3D NULL;
>  	/* total of both direct AND indirect refs! */
>  	u64 total_refs =3D 0;
> +	u64 num_bytes =3D SZ_256M;
>  	struct preftrees preftrees =3D {
>  		.direct =3D PREFTREE_INIT,
>  		.indirect =3D PREFTREE_INIT,
> @@ -1194,6 +1200,7 @@ static int find_parent_nodes(struct btrfs_trans_h=
andle *trans,
>  				goto again;
>  			}
>  			spin_unlock(&delayed_refs->lock);
> +			num_bytes =3D head->num_bytes;
>  			ret =3D add_delayed_refs(fs_info, head, time_seq,
>  					       &preftrees, &total_refs, sc);
>  			mutex_unlock(&head->mutex);
> @@ -1215,6 +1222,7 @@ static int find_parent_nodes(struct btrfs_trans_h=
andle *trans,
>  		if (key.objectid =3D=3D bytenr &&
>  		    (key.type =3D=3D BTRFS_EXTENT_ITEM_KEY ||
>  		     key.type =3D=3D BTRFS_METADATA_ITEM_KEY)) {
> +			num_bytes =3D key.offset;
>  			ret =3D add_inline_refs(fs_info, path, bytenr,
>  					      &info_level, &preftrees,
>  					      &total_refs, sc);
> @@ -1236,7 +1244,8 @@ static int find_parent_nodes(struct btrfs_trans_h=
andle *trans,
>  	WARN_ON(!RB_EMPTY_ROOT(&preftrees.indirect_missing_keys.root.rb_root)=
);
> =20
>  	ret =3D resolve_indirect_refs(fs_info, path, time_seq, &preftrees,
> -				    extent_item_pos, total_refs, sc, ignore_offset);
> +				    extent_item_pos, total_refs, sc, ignore_offset,
> +				    num_bytes);
>  	if (ret)
>  		goto out;
> =20
>=20


--cMG6eZYwjXH7TIRfSWCrweLs79Pe5f8Wr--

--7oQYT6kk7MU9yAW2N8oI8dNelcjHBQXtk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl4PFCgACgkQwj2R86El
/qjGRwf+ONVz2BlNUPMa66EAnsSxbRJx14ixLq3Ma7uyZ29GC4W31BWxP7VlBVPD
rdrx3ixjcOUph0d2H7HU/Jj5uyv+1Flv7wIkNFMIinOiYgV9olZWjyncqcEggJDJ
oHiWV9JE4g7dk5LauRUdrXVOAaqFdCd+4ScGmtd0lKd05yzvOnzxsvBhifYaHoHZ
Tjlak4FSUchWj67fZHQ9gK677b+A1clOOMdHuAYuyhygvP0WOV0nmAbcmrcpwvH/
RD/KR9aLCBnGgG2d7BtQOp/Hde++U+t64ybuUuEF3ce8szPssY7svC7WEh7PCy+O
2EnCgMWNVY1C9/lPwRgajrpgGFkZOQ==
=Qs/Y
-----END PGP SIGNATURE-----

--7oQYT6kk7MU9yAW2N8oI8dNelcjHBQXtk--
