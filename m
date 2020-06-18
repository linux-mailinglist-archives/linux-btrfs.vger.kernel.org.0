Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 736591FEB2F
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Jun 2020 07:58:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727788AbgFRF6C (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 18 Jun 2020 01:58:02 -0400
Received: from mout.gmx.net ([212.227.17.20]:57063 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725837AbgFRF6A (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 18 Jun 2020 01:58:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1592459873;
        bh=fgGHp05OBxWaPNjyk0rWok0CUHsv76tbq2osoUjrb98=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=Waowoe8ZT0LBoutcktWAjbMbzI8mIjBZeS52O+B1GsjqCyQocwnYRlOEtopAKwKsS
         2KYaQsuWTh0cu5tTemyh9NLvjVi8MTHrzBZLNHoNvLRGljKyoC42gC0f1llLBk+AKq
         UgupfZr7aC6djhT2MDKtU4jpK85y3YT7uCcEfWSw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MwfWU-1iwsjj0Byc-00y7Qn; Thu, 18
 Jun 2020 07:57:53 +0200
Subject: Re: [PATCH 4/4] Btrfs: fix RWF_NOWAIT writes blocking on extent locks
 and waiting for IO
To:     fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <20200615174939.15004-1-fdmanana@kernel.org>
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
Message-ID: <b6bca409-be73-8df1-f4cd-5411ba2da0f2@gmx.com>
Date:   Thu, 18 Jun 2020 13:57:49 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200615174939.15004-1-fdmanana@kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="XMEyZ3Yri8LHZgWbOXvTTdqOyoCgfhJW1"
X-Provags-ID: V03:K1:9PDbAndUrnGGx1WoqrkeSDsS5uI64BjtoHH4EcYCw7Yg1TwWzPe
 kEf74kbwwico/oDJJbX52BeKQmn0tntMCNpS0R2j/Bn3MqWn1nuQPACYH+bpxXXDCG8sGWc
 Wx0Rm3KikLFy7LKsuN/VbgKSS+T0alPbJBz6m6bN3/SaVOJifXk0+sjmppF8MoPrxFTE9sh
 fEFlee7K2MHevV6oRWsYA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:SHmmyftrACg=:bK4rRtSi5p5Pyl96w6dQ57
 ZrYYlocvbnIClZE3jdYIskxVrmK5PXmh63FTUKogATlOeFhg10nkZAxJJhV/bLHpnybWyBx43
 Km3N1uvnKdnuLbtDOAz9KJHLDDkz6Vn9lK4/ghSFoa8bgItZ4p3NZPYYnW9co6e2lBb9IALcp
 fKD+Z8ynHBsPEyUQMODQz84SHQFGnQVnuKFye8iRuPFjrQdDS7YTn4P63ZbTMEOzmf8eECtvD
 y/XjzSUpUNwGCVHm3AAsLW+M62PUKVmq7lNSgAOWs60cOvgCX/pWBAQVGjYkQiQpL9Mqkb9D0
 NtEDEBdG7b65IxCdHfa8u0DmNB7C63V5aYmrBXVEGfYcRedOFBWdHBbYqPcBQSIzHG9+s7r62
 5DpnPbk4gDbdFkHMJzaZ2PG+DW+yLT0q64BmQULeYVxZAcWLIpYI2fbK11GcjwJ+SDZAgKeYN
 N6xsVeUdZLgKhhysEh4UGRlbDCd/jZDaUwxyK+s3jNSPHRoTOFjdpDEALNpmw4+DgR3zMJSUB
 3CCbi041lOmfVIHTBGWkRkDWxwb6LEosANM1OwYPGkpZyQlBB3HEpkddfdg1HR0c23HVL/9wb
 LVrhyERPJwasFVIR7J3LKkZYjgZZxDlsDi/FcUUK7esbvDvOO+Ox3iAgGBdVB3j6TAeMFXS3e
 UzNaNH84RzXBdZzM++/3Ef2wxmuqX8CzSYweoG8XqovdqutnqyGxFwasQXIRubQk9rfJ/zlON
 ZpjTcQpqAYe9kprewBiHbb3O/syDulAajXGbyhGkotseLAmPwXlazqAiXYoCpIe/towpbN53K
 sm8if3WPs3lk1A+4rciwzxbUFoO5nqL62FLJfQ1SRf4Wgr5ZY++vK3IEiGJWOzIYIcSWjQcO5
 tkPRp3o5lF7asB6MQdSNYc3kO6K9LI466IGkbv5LBGrLNJ8cZzMP/pDHL9xhEiwmMzvckV+GT
 8L5EuTcw3LmzORrLfdKlK15Keg7sAzYzoBrtkIs5EH4rGb5xjI6wMRjaPjU/4zv+OR8uDorTh
 u+ItS1KVKYKJ/LgIiaQ2C7KsjptiYGv/Gt8n0Mx1swx07piwKiiHshwVHZhgWs1Akgy9JCfxw
 JH8kiA65yAxkQiTFb2NhlgDeD+djM0cikPdhkcDXINoxK4SDYl66JryjrT8CQWC8bzleWR5Ry
 /aCh3gCwpETNBiiEwOmVeNz39wVWsMBzvNBSJr2dzXOK6jVc0eyWdwphnW7m+RSx3tXUvDUJL
 gAjrFMlAJOCpxOHmd
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--XMEyZ3Yri8LHZgWbOXvTTdqOyoCgfhJW1
Content-Type: multipart/mixed; boundary="cLyipAH4p7GCq4ET7laAR0NEIhLSLRphV"

--cLyipAH4p7GCq4ET7laAR0NEIhLSLRphV
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/6/16 =E4=B8=8A=E5=8D=881:49, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
>=20
> A RWF_NOWAIT write is not supposed to wait on filesystem locks that can=
 be
> held for a long time or for ongoing IO to complete.
>=20
> However when calling check_can_nocow(), if the inode has prealloc exten=
ts
> or has the NOCOW flag set, we can block on extent (file range) locks
> through the call to btrfs_lock_and_flush_ordered_range(). Such lock can=

> take a significant amount of time to be available. For example, a fiema=
p
> task may be running, and iterating through the entire file range checki=
ng
> all extents and doing backref walking to determine if they are shared,
> or a readpage operation may be in progress.
>=20
> Also at btrfs_lock_and_flush_ordered_range(), called by check_can_nocow=
(),
> after locking the file range we wait for any existing ordered extent th=
at
> is in progress to complete. Another operation that can take a significa=
nt
> amount of time and defeat the purpose of RWF_NOWAIT.
>=20
> So fix this by trying to lock the file range and if it's currently lock=
ed
> return -EAGAIN to user space. If we are able to lock the file range wit=
hout
> waiting and there is an ordered extent in the range, return -EAGAIN as
> well, instead of waiting for it to complete. Finally, don't bother tryi=
ng
> to lock the snapshot lock of the root when attempting a RWF_NOWAIT writ=
e,
> as that is only important for buffered writes.
>=20
> Fixes: edf064e7c6fec3 ("btrfs: nowait aio support")
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> ---
>  fs/btrfs/file.c | 37 ++++++++++++++++++++++++++-----------
>  1 file changed, 26 insertions(+), 11 deletions(-)
>=20
> diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
> index 78481d1e5e6e..e5da2508f002 100644
> --- a/fs/btrfs/file.c
> +++ b/fs/btrfs/file.c
> @@ -1533,7 +1533,7 @@ lock_and_cleanup_extent_if_need(struct btrfs_inod=
e *inode, struct page **pages,
>  }
> =20
>  static noinline int check_can_nocow(struct btrfs_inode *inode, loff_t =
pos,
> -				    size_t *write_bytes)
> +				    size_t *write_bytes, bool nowait)
>  {
>  	struct btrfs_fs_info *fs_info =3D inode->root->fs_info;
>  	struct btrfs_root *root =3D inode->root;
> @@ -1541,27 +1541,43 @@ static noinline int check_can_nocow(struct btrf=
s_inode *inode, loff_t pos,
>  	u64 num_bytes;
>  	int ret;
> =20
> -	if (!btrfs_drew_try_write_lock(&root->snapshot_lock))
> +	if (!nowait && !btrfs_drew_try_write_lock(&root->snapshot_lock))

Did I read it incorrectly or something is not correct here?

This means if nowait =3D=3D true, we won't try to take the snapshot_lock =
at
all, and continue.

While if nowait =3D=3D false (which means we need to wait), and we can't
grab the lock, we return -EAGAIN.

This doesn't look correct to me.
To me, that @nowait shouldn't affect the btrfs_drew_try_write_lock()
call anyway, since that call is won't sleep.

Thanks,
Qu

>  		return -EAGAIN;
> =20
>  	lockstart =3D round_down(pos, fs_info->sectorsize);
>  	lockend =3D round_up(pos + *write_bytes,
>  			   fs_info->sectorsize) - 1;
> +	num_bytes =3D lockend - lockstart + 1;
> =20
> -	btrfs_lock_and_flush_ordered_range(inode, lockstart,
> -					   lockend, NULL);
> +	if (nowait) {
> +		struct btrfs_ordered_extent *ordered;
> +
> +		if (!try_lock_extent(&inode->io_tree, lockstart, lockend))
> +			return -EAGAIN;
> +
> +		ordered =3D btrfs_lookup_ordered_range(inode, lockstart,
> +						     num_bytes);
> +		if (ordered) {
> +			btrfs_put_ordered_extent(ordered);
> +			ret =3D -EAGAIN;
> +			goto out_unlock;
> +		}
> +	} else {
> +		btrfs_lock_and_flush_ordered_range(inode, lockstart,
> +						   lockend, NULL);
> +	}
> =20
> -	num_bytes =3D lockend - lockstart + 1;
>  	ret =3D can_nocow_extent(&inode->vfs_inode, lockstart, &num_bytes,
>  			NULL, NULL, NULL);
>  	if (ret <=3D 0) {
>  		ret =3D 0;
> -		btrfs_drew_write_unlock(&root->snapshot_lock);
> +		if (!nowait)
> +			btrfs_drew_write_unlock(&root->snapshot_lock);
>  	} else {
>  		*write_bytes =3D min_t(size_t, *write_bytes ,
>  				     num_bytes - pos + lockstart);
>  	}
> -
> +out_unlock:
>  	unlock_extent(&inode->io_tree, lockstart, lockend);
> =20
>  	return ret;
> @@ -1633,7 +1649,7 @@ static noinline ssize_t btrfs_buffered_write(stru=
ct kiocb *iocb,
>  			if ((BTRFS_I(inode)->flags & (BTRFS_INODE_NODATACOW |
>  						      BTRFS_INODE_PREALLOC)) &&
>  			    check_can_nocow(BTRFS_I(inode), pos,
> -					&write_bytes) > 0) {
> +					    &write_bytes, false) > 0) {
>  				/*
>  				 * For nodata cow case, no need to reserve
>  				 * data space.
> @@ -1911,12 +1927,11 @@ static ssize_t btrfs_file_write_iter(struct kio=
cb *iocb,
>  		 */
>  		if (!(BTRFS_I(inode)->flags & (BTRFS_INODE_NODATACOW |
>  					      BTRFS_INODE_PREALLOC)) ||
> -		    check_can_nocow(BTRFS_I(inode), pos, &nocow_bytes) <=3D 0) {
> +		    check_can_nocow(BTRFS_I(inode), pos, &nocow_bytes,
> +				    true) <=3D 0) {
>  			inode_unlock(inode);
>  			return -EAGAIN;
>  		}
> -		/* check_can_nocow() locks the snapshot lock on success */
> -		btrfs_drew_write_unlock(&root->snapshot_lock);
>  		/*
>  		 * There are holes in the range or parts of the range that must
>  		 * be COWed (shared extents, RO block groups, etc), so just bail
>=20


--cLyipAH4p7GCq4ET7laAR0NEIhLSLRphV--

--XMEyZ3Yri8LHZgWbOXvTTdqOyoCgfhJW1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl7rAl0ACgkQwj2R86El
/qjUQwf/ZKjGohPx32zbV82Q6Ef65AjBP6m0Tdolvq7HP/5uXXncnRJFNHXOpl4a
CVL4pFFF4upd5T5w7HQyjr0iaupHVPsgdj70zIIjG0nn6FEgyyVHS9NnjNtqfu6e
EVge0WOLUxAud9sVFmScjfihbvy0uT2eabf5VNwJfEBcGvEYOC8OusGgIn/X/ytd
59SCHmywxPSkPBF2YXEEYL1YbaSebRHqtpcY2JUYLyknQ0LsHwzskmqFlM+/yvec
zd34+hp/0wF5ME1VxckESM29j//fCV7wpMEEJxYuaa8EN/YWpEECe68FNLc7QqBX
+7zMrVL0dCtq6DmqjnX5TgNMuFpfNA==
=BHFV
-----END PGP SIGNATURE-----

--XMEyZ3Yri8LHZgWbOXvTTdqOyoCgfhJW1--
