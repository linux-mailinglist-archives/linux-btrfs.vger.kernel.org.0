Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2571E263ABE
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Sep 2020 04:44:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730021AbgIJCA5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 9 Sep 2020 22:00:57 -0400
Received: from mout.gmx.net ([212.227.15.15]:40805 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730093AbgIJBve (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 9 Sep 2020 21:51:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1599702690;
        bh=Pwk4iOyAXc5C7JN4ExztI0oVqxLGdHcmNcqYNdRrP44=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=SQQv5/drzxE4obGQwyKvDlPtq1hRgSF98UDxZ3POEjj0I4/DFiEZBlIoX8dLp+klB
         VIS2RiLMsSt/LvAwDZ+gt1TvsA7krdsPFqlwKhpJdMijQbNJN2aI0/HpTM2bYbLG2Z
         k0KpEnhtotyvBexB6Q+Htt4zvAdTj48I0/WJfdEY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MhU5R-1klOEr0c43-00egqk; Thu, 10
 Sep 2020 02:05:38 +0200
Subject: Re: [PATCH 14/17] btrfs: make btrfs_readpage_end_io_hook() follow
 sector size
To:     Goldwyn Rodrigues <rgoldwyn@suse.de>, Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
References: <20200908075230.86856-1-wqu@suse.com>
 <20200908075230.86856-15-wqu@suse.com>
 <20200909173457.e4gpsbwkcsxtdo4g@fiona>
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
Message-ID: <ba262153-9a5d-d940-59fc-a1e1f3337602@gmx.com>
Date:   Thu, 10 Sep 2020 08:05:34 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200909173457.e4gpsbwkcsxtdo4g@fiona>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="M0d0uDf0ynD2wObUyyiFxJ0OeW25rK4g3"
X-Provags-ID: V03:K1:D+Tt+1W1ioLlM8ByJ1fI9tFO806QX6IvLpQexR8/oOIp8Id9UXP
 pTYgEgw3S3wIdrIeIY3AcUFkakkBd5sZr7Sh1uItp8yKB2V869MUH8NvQhetQbUF9KhGrPB
 axNKspnVUWiN9NcC001XU+mC5C09eN6UZqCloF6SkwhlqzqpAzR03ZTP+w14IeFZ3XymOsU
 20K82Vnd9LA32BFPOGbqA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:/EjoegYkFjU=:2qVf+PijP0iDzTFzPfxJWG
 e4X48brGzDFT8UJGSNN7fatnmFvhMZGJpGLZfxF4vhmxCj6SecvTCQL83EA4tuZrgL4qIKP+a
 lBFJxqy7GRaoJ0oPFkTedy8iXGr5I+wmjMbTAn1SfiJRGv1uTESoFt6wto7TwaT90Yos3Lp5n
 mVRZFGFaQyPV1HBggsiY+yNyt+3Bqzh2o/vMHlOQhD9jazkxPpEamNtXvpTDbQb65REohCPAm
 /Pa4iEq3L2oMbzZIW4nn2P8KN5GpjbeJdlK/26XN50ZYQvqvEC/JTuK/BB4heKbhqDkcVd84G
 Xlx2b/XgbPmRptDaY5m3KTnMbURrbSeLMWZBfwlHfA+l7ym5NysTCxHQz326FPTao3aats8Gr
 JyMv54rzEEf5cSr79XuINYWUGPVf6wcXn5PHOHEnWcKuaNY5BExo9oE0gaPZJZrkrTUmh53r8
 /EH38OEDvC4hoStXnXPp2oRhY90ZEqctj+ShAJANQmY3zewxSP9dBAq0knTLriwiJxFXMs7CE
 gDyR3aX/KgzJ0oEZ/JGSLD9rs3sAGdE2CM02Ac2ZpF7oG4U7fW0KNNs1FMKTpf319UrcrFfsv
 hgdaKkmMWH9ebJTwa8k3zkoxIptG24WfNMz5c/wTUItTyZxM1Z02KNNhd7b7igpE8u9MLQkt+
 /ZFkqqYQ6IQoMN6za9Obrn5jTPGtOAA4yGqvsOObpborRViwdt5UOioeOMHKNwu5wervXbZJb
 wNE0qfEur+cvIk0sACKQ1c8VkRHTh7GlojvuIG8V8XOlv86drhVODEgblPX3yegS6mc/4QtSl
 /Vp9lJBBeXy/YAT9FN0OjKcnUKJ/qeOLyh49LAoet4QNDJHBGnbTgwm4pc/baJDQazKaiD1pM
 2QF9AndFB9dgwYENqghrHOW+lfGiWxqVI3DElIHcnP1V0Up6RhSMOkqV3x4qYhOoFt6CI/8z6
 bm1hZqir30rPumMjvVowZQ+G4iGgqDXNM1JozY0XLMbxNpz5IvjSF5E1+BM/Ypmk72T1h+DRU
 7UTOOyLRG3BtxtNjSnf7R1Kcv3CIed671HqNPL2JieCHxr9RNCcR/INiUPz26LCNSQUQzCDn4
 yyRK9jhE4MGTWX6kfgNN3kTTXWTMf0zQFJD23gDlTRUF+cMsngHTjOZb1R75d9T+WLofq+ssq
 kj+FWc/KxCt5tlDQ18Bavt/93M2iNGuub0gqtHMa7VtSk8GQx19x8EyBF4Lw49FTyOUkNDHG+
 MY7JGeMxlRKlrFWy+lpoMKQjkXC1tET87OA9sLQ==
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--M0d0uDf0ynD2wObUyyiFxJ0OeW25rK4g3
Content-Type: multipart/mixed; boundary="jGUHYH2rnCMnnG4CtLJLuYX84IsihURuQ"

--jGUHYH2rnCMnnG4CtLJLuYX84IsihURuQ
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/9/10 =E4=B8=8A=E5=8D=881:34, Goldwyn Rodrigues wrote:
> On 15:52 08/09, Qu Wenruo wrote:
>> Currently btrfs_readpage_end_io_hook() just pass the whole page to
>> check_data_csum(), which is fine since we only support sectorsize =3D=3D=

>> PAGE_SIZE.
>>
>> To support subpage RO support, we need to properly honor per-sector
>> checksum verification, just like what we did in dio read path.
>>
>> This patch will do the csum verification in a for loop, starts with
>> pg_off =3D=3D start - page_offset(page), with sectorsize increasement =
for
>> each loop.
>>
>> For sectorsize =3D=3D PAGE_SIZE case, the pg_off will always be 0, and=
 we
>> will only finish with just one loop.
>>
>> For subpage, we do the proper loop.
>>
>> Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>>  fs/btrfs/inode.c | 15 ++++++++++++++-
>>  1 file changed, 14 insertions(+), 1 deletion(-)
>>
>> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
>> index 078735aa0f68..8bd14dda2067 100644
>> --- a/fs/btrfs/inode.c
>> +++ b/fs/btrfs/inode.c
>> @@ -2851,9 +2851,12 @@ static int btrfs_readpage_end_io_hook(struct bt=
rfs_io_bio *io_bio,
>>  				      u64 start, u64 end, int mirror)
>>  {
>>  	size_t offset =3D start - page_offset(page);
>> +	size_t pg_off;
>>  	struct inode *inode =3D page->mapping->host;
>>  	struct extent_io_tree *io_tree =3D &BTRFS_I(inode)->io_tree;
>>  	struct btrfs_root *root =3D BTRFS_I(inode)->root;
>> +	u32 sectorsize =3D root->fs_info->sectorsize;
>> +	bool found_err =3D false;
>> =20
>>  	if (PageChecked(page)) {
>>  		ClearPageChecked(page);
>> @@ -2870,7 +2873,17 @@ static int btrfs_readpage_end_io_hook(struct bt=
rfs_io_bio *io_bio,
>>  	}
>> =20
>>  	phy_offset >>=3D inode->i_sb->s_blocksize_bits;
>> -	return check_data_csum(inode, io_bio, phy_offset, page, offset);
>> +	for (pg_off =3D offset; pg_off < end - page_offset(page);
>> +	     pg_off +=3D sectorsize, phy_offset++) {
>> +		int ret;
>> +
>> +		ret =3D check_data_csum(inode, io_bio, phy_offset, page, pg_off);
>> +		if (ret < 0)
>> +			found_err =3D true;
>> +	}
>> +	if (found_err)
>> +		return -EIO;
>> +	return 0;
>>  }
>=20
> We don't need found_err here. Just return ret when you encounter the
> first error.
>=20
But that means, the whole range will be marked error, while some sectors
may still contain good data and pass the csum checking.

Thanks,
Qu


--jGUHYH2rnCMnnG4CtLJLuYX84IsihURuQ--

--M0d0uDf0ynD2wObUyyiFxJ0OeW25rK4g3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl9Zbc4ACgkQwj2R86El
/qhlFQf/eu/JH0LSxsSQo5KyX+QSi5FKHS7zlkeApeApAxGXi8MK2hP5wz5pKacD
PppkpZoxieeF1bU3t+/RhPMriBjFAYTcKTkgSusXPK4VsFUBSgmt0TkCws0D/C1X
bqzRWyAEHRJpkIad/dQlM3VgHymgO8Sw94mG8U5X0Fx9kzakbCz1W0HC0sLxPT0v
Xlmj25kbSqen0OyboESgsxocA/SvqdV+8OL4N4vSMPP2ES/kF36W/SW4iNfT6NmT
WFWJNO5trjTxhMSlVKNX9PQCBzVyZonP81GfgfpW19S9QDcHPNfaWQw1v+xfMunr
pyTViXkztLxxIugWKrbwJ9GvRa7sYQ==
=4gVX
-----END PGP SIGNATURE-----

--M0d0uDf0ynD2wObUyyiFxJ0OeW25rK4g3--
