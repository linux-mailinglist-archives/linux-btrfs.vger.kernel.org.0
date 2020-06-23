Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C908A206860
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Jun 2020 01:27:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387930AbgFWX1x (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 23 Jun 2020 19:27:53 -0400
Received: from mout.gmx.net ([212.227.17.21]:60391 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387783AbgFWX1w (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 23 Jun 2020 19:27:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1592954870;
        bh=RBGn7uNeHM7gOKLmt+IS0nBETd1cQz45dgHrr6HhuCM=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=O2b9qiuU94Rnx12pESjJ4tyRDdshlQ7PjPES1IGeR6toD49Ax4tYTo/xtOWTYX2f2
         aOMNwqQN0svkiCijib34/VOP+0s3T9TnwFNtoseLvdG6N4xC0HfpSCVXq9+5fb+fQd
         HosHRt7snJ0vfMrQeciIi8en7vXTpb3hGMXERrKU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MEFzx-1jgTnU1x9J-00AH6I; Wed, 24
 Jun 2020 01:27:50 +0200
Subject: Re: [PATCH] btrfs: start deprecation of mount option inode_cache
To:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <20200623185032.14983-1-dsterba@suse.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Autocrypt: addr=quwenruo.btrfs@gmx.com; prefer-encrypt=mutual; keydata=
 mQENBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAG0IlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT6JAVQEEwEIAD4CGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCWdWCnQUJCWYC
 bgAKCRDCPZHzoSX+qAR8B/94VAsSNygx1C6dhb1u1Wp1Jr/lfO7QIOK/nf1PF0VpYjTQ2au8
 ihf/RApTna31sVjBx3jzlmpy+lDoPdXwbI3Czx1PwDbdhAAjdRbvBmwM6cUWyqD+zjVm4RTG
 rFTPi3E7828YJ71Vpda2qghOYdnC45xCcjmHh8FwReLzsV2A6FtXsvd87bq6Iw2axOHVUax2
 FGSbardMsHrya1dC2jF2R6n0uxaIc1bWGweYsq0LXvLcvjWH+zDgzYCUB0cfb+6Ib/ipSCYp
 3i8BevMsTs62MOBmKz7til6Zdz0kkqDdSNOq8LgWGLOwUTqBh71+lqN2XBpTDu1eLZaNbxSI
 ilaVuQENBFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcga
 CbPEwhLj1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj
 /IrRUUka68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fN
 GSsRb+pKEKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0
 q1eW4Jrv0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEv
 ABEBAAGJATwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCXZw1rgUJCWpOfwAK
 CRDCPZHzoSX+qFcEB/95cs8cM1OQdE/GgOfCGxwgckMeWyzOR7bkAWW0lDVp2hpgJuxBW/gy
 fmtBnUaifnggx3EE3ev8HTysZU9q0h+TJwwJKGv6sUc8qcTGFDtavnnl+r6xDUY7A6GvXEsS
 oCEEynby72byGeSovfq/4AWGNPBG1L61Exl+gbqfvbECP3ziXnob009+z9I4qXodHSYINfAk
 ZkA523JGap12LndJeLk3gfWNZfXEWyGnuciRGbqESkhIRav8ootsCIops/SqXm0/k+Kcl4gG
 UO/iD/T5oagaDh0QtOd8RWSMwLxwn8uIhpH84Q4X1LadJ5NCgGa6xPP5qqRuiC+9gZqbq4Nj
Message-ID: <b8fe50cc-02ed-4170-c84c-d994fd489a98@gmx.com>
Date:   Wed, 24 Jun 2020 07:27:46 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200623185032.14983-1-dsterba@suse.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="d8PbfVFu88JR0qoDva0O9TyFLCfgOOMpa"
X-Provags-ID: V03:K1:oIoMFt11nCuxxxp0OhTNNHz5Qu3SFJicgYiNV+BIqteKUPA4YTZ
 m6m6+0vNDGfjc/BWNpi470c+ZI/uGrkzFbdm7gosNI9vWTnFDXQCcglRzxVDxz9HXizQPvS
 Eog2Tivn5PD2Lfgy1qjpUg9/9usbcx5mleNy5bm2Onw0r0iE5MkoHC60zIc3WPDHoGAxd7S
 Lw9q+lE88gAR+DnP66ALQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:ZuW1scwwLTo=:VE4d/C+xgTr1PGOBoVVZ64
 sDJQe28r99lcPUJcFuFwy2RSA2ea6i/o9ZZG/QPjxFa7gJe+h9dX82id9pvDk3Sk+UEr0e8kZ
 vCWmThrbyU8xm73xh5auOFvzRi+jyhuJPaCxF7yorjSiYD2LTQ+n9uPSECyuP2psw+0mfhNCs
 VpzYpz1zBBBGbP3NlifRJy7kx1MB90YtpUwMpY/p2k8tl33dMEVumc069cMAbsbQ6WXzAiyYm
 pT/k/+8ekd07wEgKccpPJeHK/SwFBu999jpk27buxxg831cHZS5/JaRrCMIr6TGiqR1iWWTyO
 1ufCIZCGUkSM1FWcsEoGRtCCHida8OAcWJHEg1h1nAfNXwN9oP6m8Jw6gUc2bauERa3EyzyDP
 Cf3yIPoh2G+BP8YTBnWPoOerNQu+kSjIvDYxoxg2SpJlkPoEdovg3GydxIuzhx+SfVCmPbWTu
 gpw0sinsgZH/KyMxeBXM9p8KiqB+YYzY9AZYUvG6orW9URgEinWEENA6flHmfq4Ca0bz+HKFP
 ky90pqcaB+6ccdPR0HZ92xRV+Mbk0jNreTdo9VgUCEDOq97OlRcfL2vG4gEyyOcngHlW2bEpT
 2l24QBQuBz+q9sxpFEIS7i9HTwQPKvCTpl7i8UeWq0G0fqju6KysAWB9y7J94HmCYUPrRTReR
 rgOMN56N+HDA7peRVsTtzIrJC1tEy/5U6+QFqzJAmXq9Klm4Vzps4Qz4/E3SF6uQ2FTwn/q/J
 RDAI3QRLs9CHkBqn3SBz41WvSf740XI+7FDNxmgNVgl3NEmzqdhSJs3K/xpkK7Z1jTWG6QgfZ
 aqwNgVehdUShoMzoODcB2LkvCslvP9NkER34TI1qCifZ+dh6J7hbLjLPLH1A9AA7dnKPxWa+q
 llUp0T4Blmwk+kjwxqLVNc6IzVz/IlVX6B5xiT8mTelNkM2XMwxhevSOyVECzhpFBGHWxPqYe
 FM922LIMUiVBBc9jtqNj3KS7rNdICjH12ktYvWIVUHT7C53HZselu9gQPDi40it8Tl3br0RAW
 g9ol1PBnR2IPLw7L0v8ljRH1OlV7afzd8Tb76po3nszzzJybQGdf9Tdigw0tQ3gcwd81xISuR
 6qGscbElFjSlUPyVKpKyQl4TwlbwNGTy9FDd54h1c1oAlRXuFhr88lEUGHnN2Un8bPvhkwn+3
 wVS2OSC+T6rESapxiH2t1uFGn01s5VZyh5gd3jknLQdyihKnHYon14wnaJ55+xuNllQvdxuDP
 t1/03DJSdJwqAteUO
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--d8PbfVFu88JR0qoDva0O9TyFLCfgOOMpa
Content-Type: multipart/mixed; boundary="RQFVDtSVn5c1CD98l6xqeEnAqiJN8D0Pu"

--RQFVDtSVn5c1CD98l6xqeEnAqiJN8D0Pu
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/6/24 =E4=B8=8A=E5=8D=882:50, David Sterba wrote:
> Estimated time of removal of the functionality is 5.11, the option will=

> be still parsed but not doing anything.

Great that we don't need to test for a mount option that no one really us=
es.

>=20
> Reasons for deprecation and removal:
>=20
> - very poor naming choice of the mount option, it's supposed to cache
>   and reuse the inode _numbers_, but it sounds a some generic cache for=

>   inodes
>=20
> - the only known usecase where this option would make sense is on a
>   32bit architecture where inode numbers in one subvolume would be
>   exhausted due to 32bit inode::i_ino
>=20
> - the cache is stored on disk, consumes space, needs to be loaded and
>   written back
>=20
> - new inode number allocation is slower due to lookups into the cache
>   (compared to a simple increment which is the default)
>=20
> - uses the free-space-cache code that is going to be deprecated as well=

>   in the future
>=20
> Known problems:
>=20
> - since 2011, returning EEXIST when there's not enough space in a page
>   to store all checksums, see commit 4b9465cb9e38 ("Btrfs: add mount -o=

>   inode_cache")
>=20
> Remaining issues:
>=20
> - if the option was enabled, new inodes created, the option disabled
>   again, the cache is still stored on the devices and there's currently=

>   no way to remove it

What about "btrfs rescue remove-deprecated-feature inode_cache"?
I really don't want kernel to do the hassle.

Thanks,
Qu

>=20
> Signed-off-by: David Sterba <dsterba@suse.com>
> ---
>  fs/btrfs/super.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
> index 98fe2a634c70..3f1abbeef66c 100644
> --- a/fs/btrfs/super.c
> +++ b/fs/btrfs/super.c
> @@ -827,6 +827,8 @@ int btrfs_parse_options(struct btrfs_fs_info *info,=
 char *options,
>  			}
>  			break;
>  		case Opt_inode_cache:
> +			btrfs_warn(info,
> +	"the 'inode_cache' option is deprecated and will be stop working in 5=
=2E11");
>  			btrfs_set_pending_and_info(info, INODE_MAP_CACHE,
>  					   "enabling inode map caching");
>  			break;
>=20


--RQFVDtSVn5c1CD98l6xqeEnAqiJN8D0Pu--

--d8PbfVFu88JR0qoDva0O9TyFLCfgOOMpa
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl7yj/IACgkQwj2R86El
/qjZSgf+KRTT1ZPoC6w1EbAoPvGmDntjXEOkEJxtdtMfFeZtPbqFayjtRuHLpkpg
YEGmb0/PEkGwNVHeeeFa2D9MsTae60dqL+FVwSEFBFPhXEry3308a+3UQ3/t0KJv
w6ZFD5jy+Sl1ShauQqNCmgaHAcAcUzpZTWn43yvAdhRhpJQfBsqVeg04ZGBkpfV+
MO3g689yXiOt5ZukorvCn2a54ZIdU5zyS7VY7lPNE9m/iiA2SqRtyFxwi+kM3szx
BpwZGMi0UwN9vO0O2jUlJfBhxtQgmcSfLsP8na01Dzw43tmDtOeDc3Rfz8Cg052H
56gvRKvYSL45p8qbfl/BOiiKvEwxNw==
=ysaq
-----END PGP SIGNATURE-----

--d8PbfVFu88JR0qoDva0O9TyFLCfgOOMpa--
