Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80D2D21027F
	for <lists+linux-btrfs@lfdr.de>; Wed,  1 Jul 2020 05:25:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725988AbgGADZj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 30 Jun 2020 23:25:39 -0400
Received: from mout.gmx.net ([212.227.17.21]:54997 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725868AbgGADZi (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 30 Jun 2020 23:25:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1593573931;
        bh=1i8gZD6GTP+ulRAD+DBWt0vuijccolJvNoImH7FF3OQ=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=ccn32nKeCk4RJUwNBV0tAMQzZlVpcx6vl+5pBqTiebGQMRnDfs8KRXaw5dfPIsmHC
         X69fOaMsX3YJ7Fo/6WSnuiJ+Y8onCz8HVTexpAnXK17F4DZ4NdeLnjkcX7H8FrsPhO
         x3SOGWcWhfKKmCfgEVqlHbV2n2n08P+mBuu8L+zg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N4QsY-1iqZPo24zW-011QRY; Wed, 01
 Jul 2020 05:25:31 +0200
Subject: Re: [PATCH 3/4] btrfs: preallocate anon_dev for subvolume and
 snapshot creation
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org, Greed Rong <greedrong@gmail.com>
References: <20200616021737.44617-1-wqu@suse.com>
 <20200616021737.44617-4-wqu@suse.com> <20200616151004.GE27795@twin.jikos.cz>
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
Message-ID: <f792151a-ebd5-2ac7-c9ac-0c274ea1ab8e@gmx.com>
Date:   Wed, 1 Jul 2020 11:25:27 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200616151004.GE27795@twin.jikos.cz>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="7ZlfnKkmoB8YI8PETMSAyTRaKmBM0YCDf"
X-Provags-ID: V03:K1:d/mdD0J+UK1r4czXPazI00mUqxR9Tol+nuZ5/GhlgjC4cDBRTRL
 0CEs92sszRwDeR5Q8fsANN5B/0S6Ui1T5Xab6nllOST3rWFtWwoAbGp5hsbNF4l7IfUX2r4
 kHunRZ13LQF61JqwHPBlxibm2pFj8ubm09p1wkxihPDjOWxiS7eR0zIEr2OSAOXW5IGPl9i
 ivlEW44Uqd3aQv6N31cpg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:U7+euBsm3vM=:GsQNclORG9fFYy3KuOaw9T
 yJwO442YyLQMY5M9Dgrdowdhl007i4gfAMt3vO99xF902pUxF0iqvaJGc73rSCBW59lkRMXsp
 oysCmpusf8gJIfQsZe2YC6MfFczf7YkoxKuC4uaI+utqdKim2Fi8Eu9z04+2q300sfDTRkwRc
 6agK7Dzi4YGj48RhN9Aas80iYOf6qUE5kDE6Xfes1IEXfB2UcyjzuofYV8QSPYFqHVge+bdi/
 xh1Spuj6WLpg0Xi367awJXxykz10LICTafsLbEh0KNOgdXGh91NCepl3uu/CWB6OlafJVwwjg
 2rstNxMNy/d+bWrjHVCPPxvv0BBC2Fn8aS1qYbkIuw5KaURAUW2b0MPG7ndcBwmq+wno5Utcw
 rwqXIWOGNJW+HPYQkPv5M1wb79/eE79UTitiD19jd+clDY+ksO/L1DBChYYM9qpkXVHrTQplo
 1mR88Nf6IlhdQBl5SLPxAz22Gn6wdJHoKKaxVDYS/eXuIdrVppl+ft58VFGcMld0HKeqCdXnP
 uxVUp5WYCVNfs+NwKD2jEQBc4hu8IVNWHkIxKI3UK53wiczkllE9G0CPha7LlAxdX+p5vkLs3
 RjlpaIy3fU88g24PEY59nZcaFWw9LklCONabWG0Dp6mp/Y+NVKh0dFl8BIQUpghSdf//n0y6k
 YXxJMB9850eUJg3cC+zDV1RBXfcSaAHbDi0pfAy9kiHea+qFinCHo8XWH7oyog2FWFcPx7S9k
 XQMQD/+C+6b2DVdFm86AVFdAFiadFnyyx2iHBL2mUIhR6xBD5SFyvD+Wqhb8T8LNElpacT9dg
 Cm4oiIoWwRQkK1sjkVPBdPvQiJn2LWou1s/tbc/iwQ7CWgzpOlswylD2K1ijuYh0D9v0O52YR
 yaPf1PEg9n06GPQrBzvf7fBTQOeHfvOqBRGMiU9iVnyAqr6me/e5SpCyKmGHy4VJ03UwLxCr2
 G2d/X6uyAYgRrm8JDf9ZGQzayWuOtCVMPT6u8zIluOrugG3yP2bmiDBrBiLRNQcgEsfosYIkq
 gETmykKA5GwieRr8mIT47Cs8z5ZZvUHDPj6CVTko6idT8SiTnLwAqjyeY0TwlY0cMZbyvlgkQ
 LowkyVY/JeBvrMyquTFoIm1yjEoihpQ74y5e/JI6a+3ws2f7dqeum1eD4mnLsX3aAKJ4LKH0g
 pPXaY8i1pHYQK/Sg1CvdGDC8DtJldrsyns8w6BW3qLHCw7rh2HhFbYJc7Ycfciz0iQYVR5xWY
 jMU+x29cCcdB0cbwZWEFBfz5DK+gK1hXVt+vH3g==
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--7ZlfnKkmoB8YI8PETMSAyTRaKmBM0YCDf
Content-Type: multipart/mixed; boundary="QIZYk2dhnX1ugHxGUGSNK7UoEHWbBjpka"

--QIZYk2dhnX1ugHxGUGSNK7UoEHWbBjpka
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/6/16 =E4=B8=8B=E5=8D=8811:10, David Sterba wrote:
> On Tue, Jun 16, 2020 at 10:17:36AM +0800, Qu Wenruo wrote:
>> [BUG]
>> When a lot of subvolumes are created, there is a user report about
>> transaction aborted:
>>
>>   ------------[ cut here ]------------
>>   BTRFS: Transaction aborted (error -24)
>>   WARNING: CPU: 17 PID: 17041 at fs/btrfs/transaction.c:1576 create_pe=
nding_snapshot+0xbc4/0xd10 [btrfs]
>>   RIP: 0010:create_pending_snapshot+0xbc4/0xd10 [btrfs]
>>   Call Trace:
>>    create_pending_snapshots+0x82/0xa0 [btrfs]
>>    btrfs_commit_transaction+0x275/0x8c0 [btrfs]
>>    btrfs_mksubvol+0x4b9/0x500 [btrfs]
>>    btrfs_ioctl_snap_create_transid+0x174/0x180 [btrfs]
>>    btrfs_ioctl_snap_create_v2+0x11c/0x180 [btrfs]
>>    btrfs_ioctl+0x11a4/0x2da0 [btrfs]
>>    do_vfs_ioctl+0xa9/0x640
>>    ksys_ioctl+0x67/0x90
>>    __x64_sys_ioctl+0x1a/0x20
>>    do_syscall_64+0x5a/0x110
>>    entry_SYSCALL_64_after_hwframe+0x44/0xa9
>>   ---[ end trace 33f2f83f3d5250e9 ]---
>>   BTRFS: error (device sda1) in create_pending_snapshot:1576: errno=3D=
-24 unknown
>>   BTRFS info (device sda1): forced readonly
>>   BTRFS warning (device sda1): Skipping commit of aborted transaction.=

>>   BTRFS: error (device sda1) in cleanup_transaction:1831: errno=3D-24 =
unknown
>>
>> [CAUSE]
>> When the global anonymous block device pool is exhausted, the followin=
g
>> call chain will fail, and lead to transaction abort:
>>
>>  btrfs_ioctl_snap_create_v2()
>>  |- btrfs_ioctl_snap_create_transid()
>>     |- btrfs_mksubvol()
>>        |- btrfs_commit_transaction()
>>           |- create_pending_snapshot()
>>              |- btrfs_get_fs_root()
>>                 |- btrfs_init_fs_root()
>>                    |- get_anon_bdev()
>>
>> [FIX]
>> Although we can't enlarge the anonymous block device pool, at least we=

>> can preallocate anon_dev for subvolume/snapshot creation.
>> So that when the pool is exhausted, user will get an error other than
>> aborting transaction later.
>>
>> Reported-by: Greed Rong <greedrong@gmail.com>
>> Link: https://lore.kernel.org/linux-btrfs/CA+UqX+NTrZ6boGnWHhSeZmEY5J7=
6CTqmYjO2S+=3DtHJX7nb9DPw@mail.gmail.com/
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>>  fs/btrfs/disk-io.c     | 51 ++++++++++++++++++++++++++++++++++++-----=
-
>>  fs/btrfs/disk-io.h     |  2 ++
>>  fs/btrfs/ioctl.c       | 21 ++++++++++++++++-
>>  fs/btrfs/transaction.c |  3 ++-
>>  fs/btrfs/transaction.h |  2 ++
>>  5 files changed, 70 insertions(+), 9 deletions(-)
>>
>> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
>> index cfc0ff288238..14fd69b71cb8 100644
>> --- a/fs/btrfs/disk-io.c
>> +++ b/fs/btrfs/disk-io.c
>> @@ -1395,7 +1395,7 @@ struct btrfs_root *btrfs_read_tree_root(struct b=
trfs_root *tree_root,
>>  	goto out;
>>  }
>> =20
>> -static int btrfs_init_fs_root(struct btrfs_root *root)
>> +static int btrfs_init_fs_root(struct btrfs_root *root, dev_t anon_dev=
)
>>  {
>>  	int ret;
>>  	unsigned int nofs_flag;
>> @@ -1435,9 +1435,13 @@ static int btrfs_init_fs_root(struct btrfs_root=
 *root)
>>  	 */
>>  	if (is_fstree(root->root_key.objectid) &&
>>  	    btrfs_root_refs(&root->root_item)) {
>> -		ret =3D get_anon_bdev(&root->anon_dev);
>> -		if (ret)
>> -			goto fail;
>> +		if (!anon_dev) {
>> +			ret =3D get_anon_bdev(&root->anon_dev);
>> +			if (ret)
>> +				goto fail;
>> +		} else {
>> +			root->anon_dev =3D anon_dev;
>> +		}
>>  	}
>> =20
>>  	mutex_lock(&root->objectid_mutex);
>> @@ -1542,8 +1546,27 @@ void btrfs_free_fs_info(struct btrfs_fs_info *f=
s_info)
>>  }
>> =20
>> =20
>> -struct btrfs_root *btrfs_get_fs_root(struct btrfs_fs_info *fs_info,
>> -				     u64 objectid, bool check_ref)
>> +/*
>> + * Get a fs root.
>> + *
>> + * For essential trees like root/extent tree, we grab it from fs_info=
 directly.
>> + * For subvolume trees, we check the cached fs roots first. If miss t=
hen
>> + * read it from disk and add it to cached fs roots.
>> + *
>> + * Caller should release the root by calling btrfs_put_root() after t=
he usage.
>> + *
>> + * NOTE: Reloc and log trees can't be read by this function as they s=
hare the
>> + *	 same root objectid.
>> + *
>> + * @objectid:	Root (subvolume) id
>> + * @anon_dev:	Preallocated anonymous block device number for new root=
s.
>> + * 		Pass 0 for automatic allocation.
>> + * @check_ref:	Whether to check root refs. If true, return -ENOENT fo=
r orphan
>> + * 		roots.
>> + */
>> +static struct btrfs_root *__get_fs_root(struct btrfs_fs_info *fs_info=
,
>> +					u64 objectid, dev_t anon_dev,
>> +					bool check_ref)
>=20
>=20
>> +struct btrfs_root *btrfs_get_fs_root(struct btrfs_fs_info *fs_info,
>> +				     u64 objectid, bool check_ref)
>> +{
>> +	return __get_fs_root(fs_info, objectid, 0, check_ref);
>> +}
>> +
>> +struct btrfs_root *btrfs_get_new_fs_root(struct btrfs_fs_info *fs_inf=
o,
>> +					 u64 objectid, dev_t anon_dev)
>> +{
>> +	return __get_fs_root(fs_info, objectid, anon_dev, true);
>> +}
>=20
> This does not look like a good API, we should keep btrfs_get_fs_root an=
d
> add the anon_bdev initialization to the callers, there are only a few.
>=20

A few =3D over 25?

I have switched to keep btrfs_get_fs_root(), but you won't like the summa=
ry:

Old:
 fs/btrfs/disk-io.h     |  2 ++
 fs/btrfs/ioctl.c       | 21 ++++++++++++++++-
 fs/btrfs/transaction.c |  3 ++-
 fs/btrfs/transaction.h |  2 ++
 5 files changed, 70 insertions(+), 9 deletions(-)

New:
 fs/btrfs/backref.c     |  4 ++--
 fs/btrfs/disk-io.c     | 42 ++++++++++++++++++++++++++++++++++--------
 fs/btrfs/disk-io.h     |  3 ++-
 fs/btrfs/export.c      |  2 +-
 fs/btrfs/file.c        |  2 +-
 fs/btrfs/inode.c       |  2 +-
 fs/btrfs/ioctl.c       | 31 +++++++++++++++++++++++++------
 fs/btrfs/relocation.c  | 11 ++++++-----
 fs/btrfs/root-tree.c   |  2 +-
 fs/btrfs/scrub.c       |  2 +-
 fs/btrfs/send.c        |  4 ++--
 fs/btrfs/super.c       |  2 +-
 fs/btrfs/transaction.c |  3 ++-
 fs/btrfs/transaction.h |  2 ++
 fs/btrfs/tree-log.c    |  2 +-
 fs/btrfs/uuid-tree.c   |  2 +-
 16 files changed, 83 insertions(+), 33 deletions(-)

Do we really go that direction?

Thanks,
Qu


--QIZYk2dhnX1ugHxGUGSNK7UoEHWbBjpka--

--7ZlfnKkmoB8YI8PETMSAyTRaKmBM0YCDf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl78AicACgkQwj2R86El
/qiHFgf/Y+BZxE+iNcPRZwChWALoQxhnJe8i0qIpU5DTm4CyjMXqHMOrrm/oMbgb
VAJNTNKnsIZxPbNcsSseTifD9sFLK1T9V0opc9idkHguxFSjBAIll3bZRheibb3w
/mG0y4IfDlokJpPECLGmHyQVCf+fahxuLgTGdyhM0S+9blm+rrOUOz/1RIUuv+5s
OpiLOjLF7+sRg2o4Nmvws/+RULdGoAmyOlHM/wTFXW1kXWrv6yF/77dUm6dVNFfD
rOOetB/xefiCR1qOZiEnZ5lE6znmwOozzFphL3YHZt/xXJJrts5bqXY8+/Rb2aqP
ZBbv7/IdYZ8dVM+ZkHljGLaiqrX8ew==
=f3+o
-----END PGP SIGNATURE-----

--7ZlfnKkmoB8YI8PETMSAyTRaKmBM0YCDf--
