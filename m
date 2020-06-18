Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 699691FEB7C
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Jun 2020 08:35:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726964AbgFRGfX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 18 Jun 2020 02:35:23 -0400
Received: from mout.gmx.net ([212.227.15.19]:49427 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725953AbgFRGfX (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 18 Jun 2020 02:35:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1592462117;
        bh=hphcJnGxlnrluAEYeKhidxqHWJCJ1zp8CvlmwnAVWVw=;
        h=X-UI-Sender-Class:Subject:From:To:References:Date:In-Reply-To;
        b=VZssbv4ybqOjtoGXcbgd2NLJVuppaypBF1ZdIGoSwWc5FoUxZn+J3bryoV+Wbe3PV
         5TgJr4xUrX7KXt4CMsHO7ZEjd1UUKvIUrovmhiBn4P2eBjRD+7/KHVwyxu5v7SFnaB
         pt1o55SLys4RmsCSFGIzFZpEniLDqYFQxbMi/N/I=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MEFvj-1jds2r1FKP-00AD22; Thu, 18
 Jun 2020 08:35:16 +0200
Subject: Re: [PATCH 4/4] Btrfs: fix RWF_NOWAIT writes blocking on extent locks
 and waiting for IO
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
To:     fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <20200615174939.15004-1-fdmanana@kernel.org>
 <b6bca409-be73-8df1-f4cd-5411ba2da0f2@gmx.com>
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
Message-ID: <2d1f6cde-6b48-1b60-853c-425c01e88305@gmx.com>
Date:   Thu, 18 Jun 2020 14:35:13 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <b6bca409-be73-8df1-f4cd-5411ba2da0f2@gmx.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="tZOV6WG3K889JTmocmbK2qInyRW9UcDLK"
X-Provags-ID: V03:K1:62wkTcYu4KegL/Ct/QdPkpk4iT/JU0pPk1bV0gyEWYePGY5uw5q
 n1rcs0yQeqJcn43T7QDMMDwMr28tcD97BohRgXa3uWu3LL4VNbiu4udnggWPzCCGzcz/Dmt
 4D6FJoezFZ9XR94MzPd8P1H2f7If1GNZ88zVYIxKxFaLY7TN3KHpIoKdPzVmArJl+mV2u2s
 CDd2DbkwRvpWp89laXMDg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:SyDpJOtI100=:wBmyflbbzac5DvmAIflU8Z
 Zlfx88VLwpA3E/srQB/htB3rxFcgR01XQmUFrHTB6778mkKtGnmIOz7ETgt4Sz++e7R8U33fQ
 c3iQYSJEJ4ggiS8lFJzZIeE2kz5IDRVRT/3zkodAzaYGbyVIdRNAijU1v0BWcS1ZB2PaoQvu3
 J1h2M+bq5N21Yhi4uQyUqQ0sdbzMpzMB6WU/ZjHE3sfxPU338oFUUMQilBJq5d/8SB5vXJtkg
 CrrYlDfwGSMTdyWgFd1kl2sw95aCAt19igB7NoRmLp3d71XuiNAn3IhnQ+/zGnuBYZUfvEaba
 JLxHXjZPwI5RyhdgoLGhv6/ddQduIJzaXYA3SNpbQ3EZrOxqF/wYHIDCQNQVNMFPZOIISccRV
 9Sl1DEM/F63zaw8L9+XFtRqmpisZPngQWxxG1qacN0KdHljTHRtosOtKIdrrfm57+alSC/3kV
 hDio4CjP9hdAk+f52L0rZqugLf4m3btLF4T3OESb56uJ2dkRHwWfLbnsDUfo40MPgkonT/yVX
 qiUMjOv/JDCaIvHiDJcnB6DXlUOMMh1QsKWWi79oBtB2uImHAtMpDzxQfwO8JrGaOIzPzUN1O
 7zncGv5H2eTTqP4yf3joVv/zZym0RZ0yUKB2F10aZEq1pxjsLLP0xsBBJIzmKlwTRor3DEw1S
 0Ekv2K74hcxlCpOLrwa6ihxYiOdZ2WfM5GQ2tShn65c4TnfIryxN/jqDfUGWq+0m4Ya9oFa4/
 8Fojnzb1WI36MrnfFho84VuOr9CrymeADhrFkG4bhWp2m3ecqYy/iLDIC8GspfOAY7hrDD5mF
 gFiOklTPioLn+pERGqMrnMweWnxd1hLs33OtejVEqCr0BvT/6iV/TLD3nGZNgOTUE0GvHU64d
 f/A5Im0bn/je86vTfjz+IAQczMUCD/GRUR785NhD0jCg/FMUWjWMDGaRJnexAR4GFdlOH8B0r
 q79MACZCpG9gwtDFD1ak2JvlfiVZUF5ppsHVqqtg+5T2//6kAWWIa7UyhI3kNI6amfaY+R3Cz
 93mmz3ylNA1mpGgzVA9epRy2RyYB+f3glQFPOCebEVSoft08xdMhE5Qlg090YqdixaSvBgTIn
 rDKKT2GCk70pZ2nN2YztBaCb175nbySQv6Qeov/kQ5EqmG4ddPp8wZacsOSrtl7VXyuppQjDb
 mM1fauHXrxC3smIGHqqnlGqSz195evwEo+0QTv5dYZuur2rm2O8y7jPh8a2ZNBWL+yPpr3mTT
 zs3w6mAp3e81fY+dK
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--tZOV6WG3K889JTmocmbK2qInyRW9UcDLK
Content-Type: multipart/mixed; boundary="gdDJfNb5aDUuwuvMRQHAVir6GDPZ0Hg0x"

--gdDJfNb5aDUuwuvMRQHAVir6GDPZ0Hg0x
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/6/18 =E4=B8=8B=E5=8D=881:57, Qu Wenruo wrote:
>=20
>=20
> On 2020/6/16 =E4=B8=8A=E5=8D=881:49, fdmanana@kernel.org wrote:
>> From: Filipe Manana <fdmanana@suse.com>
>>
>> A RWF_NOWAIT write is not supposed to wait on filesystem locks that ca=
n be
>> held for a long time or for ongoing IO to complete.
>>
>> However when calling check_can_nocow(), if the inode has prealloc exte=
nts
>> or has the NOCOW flag set, we can block on extent (file range) locks
>> through the call to btrfs_lock_and_flush_ordered_range(). Such lock ca=
n
>> take a significant amount of time to be available. For example, a fiem=
ap
>> task may be running, and iterating through the entire file range check=
ing
>> all extents and doing backref walking to determine if they are shared,=

>> or a readpage operation may be in progress.
>>
>> Also at btrfs_lock_and_flush_ordered_range(), called by check_can_noco=
w(),
>> after locking the file range we wait for any existing ordered extent t=
hat
>> is in progress to complete. Another operation that can take a signific=
ant
>> amount of time and defeat the purpose of RWF_NOWAIT.
>>
>> So fix this by trying to lock the file range and if it's currently loc=
ked
>> return -EAGAIN to user space. If we are able to lock the file range wi=
thout
>> waiting and there is an ordered extent in the range, return -EAGAIN as=

>> well, instead of waiting for it to complete. Finally, don't bother try=
ing
>> to lock the snapshot lock of the root when attempting a RWF_NOWAIT wri=
te,
>> as that is only important for buffered writes.
>>
>> Fixes: edf064e7c6fec3 ("btrfs: nowait aio support")
>> Signed-off-by: Filipe Manana <fdmanana@suse.com>
>> ---
>>  fs/btrfs/file.c | 37 ++++++++++++++++++++++++++-----------
>>  1 file changed, 26 insertions(+), 11 deletions(-)
>>
>> diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
>> index 78481d1e5e6e..e5da2508f002 100644
>> --- a/fs/btrfs/file.c
>> +++ b/fs/btrfs/file.c
>> @@ -1533,7 +1533,7 @@ lock_and_cleanup_extent_if_need(struct btrfs_ino=
de *inode, struct page **pages,
>>  }
>> =20
>>  static noinline int check_can_nocow(struct btrfs_inode *inode, loff_t=
 pos,
>> -				    size_t *write_bytes)
>> +				    size_t *write_bytes, bool nowait)
>>  {
>>  	struct btrfs_fs_info *fs_info =3D inode->root->fs_info;
>>  	struct btrfs_root *root =3D inode->root;
>> @@ -1541,27 +1541,43 @@ static noinline int check_can_nocow(struct btr=
fs_inode *inode, loff_t pos,
>>  	u64 num_bytes;
>>  	int ret;
>> =20
>> -	if (!btrfs_drew_try_write_lock(&root->snapshot_lock))
>> +	if (!nowait && !btrfs_drew_try_write_lock(&root->snapshot_lock))
>=20
> Did I read it incorrectly or something is not correct here?
>=20
> This means if nowait =3D=3D true, we won't try to take the snapshot_loc=
k at
> all, and continue.

Ah, you don't want to grab that snapshot_lock at all, as it only bothers
for buffered write.
So that's expected.

Please ignore the noise.

Thanks,
Qu
>=20
> While if nowait =3D=3D false (which means we need to wait), and we can'=
t
> grab the lock, we return -EAGAIN.
>=20
> This doesn't look correct to me.
> To me, that @nowait shouldn't affect the btrfs_drew_try_write_lock()
> call anyway, since that call is won't sleep.
>=20
> Thanks,
> Qu
>=20
>>  		return -EAGAIN;
>> =20
>>  	lockstart =3D round_down(pos, fs_info->sectorsize);
>>  	lockend =3D round_up(pos + *write_bytes,
>>  			   fs_info->sectorsize) - 1;
>> +	num_bytes =3D lockend - lockstart + 1;
>> =20
>> -	btrfs_lock_and_flush_ordered_range(inode, lockstart,
>> -					   lockend, NULL);
>> +	if (nowait) {
>> +		struct btrfs_ordered_extent *ordered;
>> +
>> +		if (!try_lock_extent(&inode->io_tree, lockstart, lockend))
>> +			return -EAGAIN;
>> +
>> +		ordered =3D btrfs_lookup_ordered_range(inode, lockstart,
>> +						     num_bytes);
>> +		if (ordered) {
>> +			btrfs_put_ordered_extent(ordered);
>> +			ret =3D -EAGAIN;
>> +			goto out_unlock;
>> +		}
>> +	} else {
>> +		btrfs_lock_and_flush_ordered_range(inode, lockstart,
>> +						   lockend, NULL);
>> +	}
>> =20
>> -	num_bytes =3D lockend - lockstart + 1;
>>  	ret =3D can_nocow_extent(&inode->vfs_inode, lockstart, &num_bytes,
>>  			NULL, NULL, NULL);
>>  	if (ret <=3D 0) {
>>  		ret =3D 0;
>> -		btrfs_drew_write_unlock(&root->snapshot_lock);
>> +		if (!nowait)
>> +			btrfs_drew_write_unlock(&root->snapshot_lock);
>>  	} else {
>>  		*write_bytes =3D min_t(size_t, *write_bytes ,
>>  				     num_bytes - pos + lockstart);
>>  	}
>> -
>> +out_unlock:
>>  	unlock_extent(&inode->io_tree, lockstart, lockend);
>> =20
>>  	return ret;
>> @@ -1633,7 +1649,7 @@ static noinline ssize_t btrfs_buffered_write(str=
uct kiocb *iocb,
>>  			if ((BTRFS_I(inode)->flags & (BTRFS_INODE_NODATACOW |
>>  						      BTRFS_INODE_PREALLOC)) &&
>>  			    check_can_nocow(BTRFS_I(inode), pos,
>> -					&write_bytes) > 0) {
>> +					    &write_bytes, false) > 0) {
>>  				/*
>>  				 * For nodata cow case, no need to reserve
>>  				 * data space.
>> @@ -1911,12 +1927,11 @@ static ssize_t btrfs_file_write_iter(struct ki=
ocb *iocb,
>>  		 */
>>  		if (!(BTRFS_I(inode)->flags & (BTRFS_INODE_NODATACOW |
>>  					      BTRFS_INODE_PREALLOC)) ||
>> -		    check_can_nocow(BTRFS_I(inode), pos, &nocow_bytes) <=3D 0) {
>> +		    check_can_nocow(BTRFS_I(inode), pos, &nocow_bytes,
>> +				    true) <=3D 0) {
>>  			inode_unlock(inode);
>>  			return -EAGAIN;
>>  		}
>> -		/* check_can_nocow() locks the snapshot lock on success */
>> -		btrfs_drew_write_unlock(&root->snapshot_lock);
>>  		/*
>>  		 * There are holes in the range or parts of the range that must
>>  		 * be COWed (shared extents, RO block groups, etc), so just bail
>>
>=20


--gdDJfNb5aDUuwuvMRQHAVir6GDPZ0Hg0x--

--tZOV6WG3K889JTmocmbK2qInyRW9UcDLK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl7rCyEACgkQwj2R86El
/qic8Qf9GZd+5mH73STkYy3lThpFPm2iLbqDkLXG3O6IxLHnRs2mWNNG1CRgnFjL
dVZw+3bsS724zXEtyEI04xuvudjzgWAhB0tPnNPsR5MmacbfioXz/2SiyX6YYjmp
wu/usLaepdt42dx8Dmrjswj89fSBu2r0ypUfmZT9IAaQkQgu0FAYtUKd4tOC8fzJ
+KigqnaskjIetLG8FlXCg1nW1FoCbeAdlu0mo/8yun8ZkZyNyoj8bnZdT/9wwN9G
XGgW+JGl08YM7CbE+Xzn8y69GqZQg+dgb9+89f5D1txq10V8poFMYPEkNcLicHwm
T3tKkd2OiZvlosBe4TfM9XsU3AbzrQ==
=QT2S
-----END PGP SIGNATURE-----

--tZOV6WG3K889JTmocmbK2qInyRW9UcDLK--
