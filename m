Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66E9E23C1F7
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Aug 2020 00:49:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726396AbgHDWtP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 4 Aug 2020 18:49:15 -0400
Received: from mout.gmx.net ([212.227.15.19]:55917 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726222AbgHDWtP (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 4 Aug 2020 18:49:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1596581343;
        bh=/ovMs63+qOyE4GQ3AClGgkE5wpFoZFrVQzOLpgSqZTk=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=EKpvHREt7YJP+cNl9I/t2PaXlyyAvtRJz77j/7w7nGqD2UfrD6UrPmjl5q7+Nxrlj
         Rpkb3r2h8ytYyuoFzS15Z//bs5zRU6q8+M9Rag9IV3C0hueBAi5WTIZeVeghCxlx7k
         AF9Kx9NJnsxdl1BK2yqp36FTHZznwG4YNlBEYESI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([45.77.180.217]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MgNcz-1kfkTB1oBr-00hsol; Wed, 05
 Aug 2020 00:49:03 +0200
Subject: Re: [PATCH RFC] btrfs: change commit txn to end txn in
 subvol_setflags ioctl
To:     Boris Burkov <boris@bur.io>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <20200804175516.2511704-1-boris@bur.io>
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
Message-ID: <86c25213-e961-790e-dc27-8c2a9aa118c1@gmx.com>
Date:   Wed, 5 Aug 2020 06:48:57 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200804175516.2511704-1-boris@bur.io>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="3xMaZ1wQqPS1cRqThGzGmJ7rPZLgRf8X4"
X-Provags-ID: V03:K1:DPZ39V6Fj3TdI+oTVeOSwp07AhrjSsow9L3DT/lELK9b2IqYEbQ
 pL42x/BBP0orMQpxZs42qpeIdCDRGGlVxqkNn9xAo+MXjo869JhrYZO+gfCey0oyaOxh5dq
 JBh0f3aIilKkMLtTGTcx25EFxhdCscLXb3ggz1JrGxPmTh5MitRhGteCvYasLhO6WY0JDPT
 bacbW6tIml3zE9y/WP2mA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:DxN3Xow9t1c=:vzUvWW7icAaRIP7YGANB+Z
 xfNKxmESiwT6tA1BrwpFGoTJvHfpSOumdYZsX4i3IZpBaqGESQbY/rA3NcVT2CsjrtL4YCxZ5
 o0JrSsCJje9mRuG1P7bKgrs/O5DA41mHDyHA5vcPrPfSgxgE1MFYLsycQcTe1gbcyjxWpss+s
 UM7T3ts8oBsvogmLB5ZmvNOKbleLPpzxlpQsuV/+CdvJN4XuVsJ1RH7IbTg3RcV3v40/4ma0p
 c8hbxWo4BGSg5AOduLAB3y04ChejRvyfVZ7D0cqFXciaFExVfA5ZHXaYkPKNCSo9wXvWCICub
 IIN7jJapMXuvrjHZwDUR7bNrC260DwhMM3ozvE5uVVU23KzY+hIYsPyPy464HiVM9Q3rVNlAJ
 OeExICF8cAsG79JO4Ljao7CRVIzgK2VOf8ud8c0jAJvUstm8uTa6xha8ZDE8KTUmUkopclazy
 l+D5HottmxT/axSype8JVpkjCincwmRdtb92dT+gyEOBrQGSSgqugBlCWgORky1V+36OZ8He+
 orIyZVxpHaFN/A0og6saVCj0qxDsbpJzIEUn2WIpi5TD9zJdXi63DDmS/OFlUD1Ua1S6ZaCGW
 p8P8QH9p8iEQU5mIqtvSnKhLvi+glTKjidDXWj0djtRNtYZoqgbIYJDhFmKPsaJgqjlkLo0vp
 Aj/9uiGz+Q067Kdv5l+swwfKMRtICRxi63Sklx3BQRSzK7qWKZrQXUdWE7ojXOgWV7AU4jWun
 /QLhKwg5zOrBIt4rQIVhdubHnyvu8iYlfkwQZwp1SBSlESIiEyKozzh7sL1TsC4kpcPv0MRfF
 GiaguDX0XES238nLHGUKkM94k2RmMURZCfKJ9vccS/fsi7mqQgaVAbaxQy7ON+aPhZZ2KlhMx
 47rHvHfUSbSR9WLavpAdxAH3rC0kIvKNs2BLj0Z9TnMD70AosWaV9jpECIbcyHANcI8H4gmUO
 vNsoVvkojNehsHXPcVvpGN99CCwObVq9lrpHx9sdcZCv0ZF936X+2jeVuDO4pDBLteYqy7H/u
 0XpqEXQ4xXYhNXac5ssNcQmA8Mx49rVwlFxUduD6zXP3W30mIoA4TYD/yx1ofMIhfKsInJf/l
 vdgb4Kzs3BWUuyMElGueQvKdqRDxsaws+4ngMeWiFBvoQPrYr9dLoNh2LGpkor7PGbQUR4y1M
 a5X+JTqhUFSQhTGkIzrRM52odxNRraYV+FCx+KPtrfXHAPqvGAcysMbXhMQ70UWUhOCPXj0vV
 xDcVWqQFNABacWOFTZ7JSHXbiJWOd9D+f4lfWbg==
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--3xMaZ1wQqPS1cRqThGzGmJ7rPZLgRf8X4
Content-Type: multipart/mixed; boundary="0ugru8qLSjZqIe6w9yYW93KblfJNcPj6h"

--0ugru8qLSjZqIe6w9yYW93KblfJNcPj6h
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/8/5 =E4=B8=8A=E5=8D=881:55, Boris Burkov wrote:
> Currently, btrfs_ioctl_subvol_setflags forces a btrfs_commit_transactio=
n
> while holding subvol_sem. As a result, we have seen workloads where
> calling `btrfs property set -ts <subvol> ro false` hangs waiting for a
> legitimately slow commit. This gets even worse if the workload tries to=

> set flags on multiple subvolumes and the ioctls pile up on subvol_sem.
>=20
> Change the commit to a btrfs_end_transaction so that the ioctl can
> return in a timely fashion and piggy back on a later commit.
>=20
> Signed-off-by: Boris Burkov <boris@bur.io>
> ---
>  fs/btrfs/ioctl.c       | 2 +-
>  fs/btrfs/transaction.c | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> index bd3511c5ca81..3ae484768ce7 100644
> --- a/fs/btrfs/ioctl.c
> +++ b/fs/btrfs/ioctl.c
> @@ -1985,7 +1985,7 @@ static noinline int btrfs_ioctl_subvol_setflags(s=
truct file *file,
>  		goto out_reset;
>  	}
> =20
> -	ret =3D btrfs_commit_transaction(trans);
> +	ret =3D btrfs_end_transaction(trans);

This means the setflag is not committed to disk, and if a powerloss
happens before a transaction commit, then the setflag operation just get
lost.

This means, previously if this ioctl returns, users can expect that the
flag is always set no matter what, but now there is no guarantee.

Personally I'm not sure if we really want that operation to be committed
to disk.
Maybe that transaction commit can be initialized in user space, so for
multiple setflags, we only commit once, thus saves a lot of time.

Thanks,
Qu

> =20
>  out_reset:
>  	if (ret)
> diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
> index 20c6ac1a5de7..1dc44209c2ae 100644
> --- a/fs/btrfs/transaction.c
> +++ b/fs/btrfs/transaction.c
> @@ -47,7 +47,7 @@
>   * | Will wait for previous running transaction to completely finish i=
f there
>   * | is one
>   * |
> - * | Then one of the following happes:
> + * | Then one of the following happens:
>   * | - Wait for all other trans handle holders to release.
>   * |   The btrfs_commit_transaction() caller will do the commit work.
>   * | - Wait for current transaction to be committed by others.
> @@ -60,7 +60,7 @@
>   * |
>   * | To next stage:
>   * |  Caller is chosen to commit transaction N, and all other trans ha=
ndle
> - * |  haven been released.
> + * |  have been released.
>   * V
>   * Transaction N [[TRANS_STATE_COMMIT_DOING]]
>   * |
>=20


--0ugru8qLSjZqIe6w9yYW93KblfJNcPj6h--

--3xMaZ1wQqPS1cRqThGzGmJ7rPZLgRf8X4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl8p5dkACgkQwj2R86El
/qhuWwgAjyDMYYBaB3XyodIls9C5bmFlMTsv9jGKljrNL1QdYDIo8gpH6VcWc0+B
lrxMdf7gbnTW3UG+bLisjMvkLUwRsAgHqIewkT5ymSOv8fG8eC7AjoEKMeG7eBTu
pXDp4DRIFP7h8nMNd+x3RdJ4dOjUlaklirWeSW8MxyzlT2u5ybmvKfNDxhnFZCIC
eSsHkxrCzE/ktFIgqWGEdwQkpnO++U8SKMReVIbd4dIqN19i6pYKujwJMYMtcXMD
iuNnx9sGDTdOZnzLCiJxsj1OkuGAXLgburu4m8+t/VmF5OELcoyVNRExwa7HWYOY
o0o7R1LAh7ahz3qLB0vSIfR23t3lHA==
=htYs
-----END PGP SIGNATURE-----

--3xMaZ1wQqPS1cRqThGzGmJ7rPZLgRf8X4--
