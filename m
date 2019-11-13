Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 206B1FB013
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Nov 2019 12:58:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725996AbfKML6U (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 13 Nov 2019 06:58:20 -0500
Received: from mout.gmx.net ([212.227.15.18]:43955 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725939AbfKML6T (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 13 Nov 2019 06:58:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1573646210;
        bh=G0W0k78MqccC3E3Rr6ixiXFFPcBYtEc6ZSzOd3hDSb8=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=ZA8/dz9n3B3tobxqh1fEZK/HqjNfZo2xZeHP3GfeL0BnBItRTwn4q6SKhj5gtvZQ1
         CUj8et0luRuFd2V2vY3/0zyyD8WCA+QC8PYbN+knjVN/HgqG3l1466ek7Zx1fji9rr
         sTCFA+dp7ZomB/LwAMBzgIfMJzEvUiLCj18Y/y2c=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([13.231.109.76]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1N2mFi-1hlVWO40nk-0135K6; Wed, 13
 Nov 2019 12:56:50 +0100
Subject: Re: [PATCH v2 0/7] remove BUG_ON()s in btrfs_close_one_device()
To:     Johannes Thumshirn <jthumshirn@suse.de>,
        David Sterba <dsterba@suse.com>
Cc:     Qu Wenru <wqu@suse.com>,
        Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>
References: <20191113102728.8835-1-jthumshirn@suse.de>
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
Message-ID: <a5761843-3079-a93a-5aa9-bb4f9b9b570a@gmx.com>
Date:   Wed, 13 Nov 2019 19:56:38 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191113102728.8835-1-jthumshirn@suse.de>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="PGe7o0WhAXEbWhRJXhr7S141anCXfyCtt"
X-Provags-ID: V03:K1:BKsq50Nmc0K4T8zk25PGkelQO4Mksx1aiDpcrTC6Qs0yS6Jzz0p
 0GjezmdBoVyw7HwAsahKy4oXuAcEoBlTTdOhzicpkuPwObt42ik6XGtFoiHaCYbmtY3pZN5
 la/ylN4SVFLr2BmcuHi+RZE7K3DeBEHx5PRqvgNpRUuq0Lbgp+pepal3ZySc5XZoCU+2amI
 9baQXjxzzfYTTmtqrNKJA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:lHpN6PFNz0g=:/0Gz9DXfqJtkJpaL+x87bC
 uec7nuWgz568joH1tRFSsWoEnSFdKma9dnI0eEnRKLGYiuNYahBEV9h0VWoDyy8yXro2/o9lT
 ThSg+57pVdzBFZ6NtnUMBOmm6nlx4WI3P91oqrZ+T3X2j+Kw4tCmy0vxl6QIccjQTRSsod45u
 uYzrGz/wWo9zmRngCfVGClL4Rv6vwtO6tIjkzv8Mi0pIlkTol6fI84aQsuIMAeL2B9s8hy/+s
 xQkkREmMC9uztzMfHa/huiB/Pb8Q3Z8RyQXNQuF1REPocu74E8/fiDzRmiw1zF+Jy//QWOGaB
 hC22LDRmWbofkTWqZQorjMjEW7xgDhM4Y74W+VjVtciv8lvPzoi/bLjq/GWzkMJvWO7x6GwaI
 fqbpxAjgcSfR49SwW3Yqd8y+vsFyvnLK8YeuPCJuWowKw/7glvAX4blAgZltUAWfePAq/nZlu
 4J+G7eWg1gdSo7h5xyrYbz7xNdrZA7zItZLUoYWvAsJDwWr7S45vf+rOnk0dR/q45sjilDixd
 UduoWgV1Q5X9DtmRrw5zp5xJu7ybu/9FkY6XnTaLo59DdugPt37qt6XliA1mOJWwa1gGl1RZV
 Bgq81Gt5Wh/9vyUR0YAtGsC8rokx5FIvLG4rSbrAwPcm1c2Upg3+OMBh61zJECpGZapwDvfci
 HrIFkQaqvGt/Og3OAM76yKPj7s3XH/4ElJ63f1StiyYYlSgtkCtkORw0obRK2aYEKjo7x7vT3
 jS4F1gj2uaR9ba7rNdS1mMdKe4ZihPjkMfy95t/Bmf2tnPgehYBpGwQJCQ1hxDj5W2tHWq9qM
 IJ1NtLPI+8qsq+po8pig5Ng8Mke3D1nybgPHoVQ/L8Rss/0xsMtQyJ/UVDKnqavXIwcHwDEBq
 m9890Xd/kCO6vxRGnLcNDL10yF8Vm3UwwQecV6M7CN5jc13MNxbxRgsk+LBuok1h9NW+NdthO
 rVvlqWZ26HXlaOTXBIZs2+1e8bOrcv03rDPrsw9cDLyLd1ePYKnecvNcdU1EFwH1X1H/ajBo8
 skxg2G6fwTUfZ4SjLY0M2AIlTWc7tEDYirSxhrJndVBHbMJyELfR46Lx0gEhQjHGzVz+guKYp
 3sYJROJNAepKyYZ9FR0L4/6N4Ij5a/hVJxIgwgnILbk7guE7SNBVsuPzonr0k0GviLYvy3zu6
 4my06FykgJBC1TLET9clznXnZeMyrXmeTpaNM/aixGZi0/CZ5kHVaNaVDycHK1+evKuL6kXfT
 4MS+ostt6SvQwIFy+NAsl3lBv8x2Ty+rDDoH1QMr+D7RYYMJJJ19PMm6wn8w=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--PGe7o0WhAXEbWhRJXhr7S141anCXfyCtt
Content-Type: multipart/mixed; boundary="5EJggnWZPpVsHhGGgvP68qAhp49s9cAM6"

--5EJggnWZPpVsHhGGgvP68qAhp49s9cAM6
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/11/13 =E4=B8=8B=E5=8D=886:27, Johannes Thumshirn wrote:
> This series attempts to remove the BUG_ON()s in btrfs_close_one_device(=
).
> Therefore some reorganization of btrfs_close_one_device() and
> close_fs_devices() was needed.
>=20
> Forthermore a new BUG_ON() had to be temporarily introduced but is remo=
ved
> again in the last patch of theis series.
>=20
> Although it is generally legal to return -ENOMEM on umount(2), the erro=
r
> handling up until close_ctree() as neither close_ctree() nor btrfs_put_=
super()
> would be able to handle the error.
>=20
> This series has passed fstests without any deviation from the baseline =
and
> also the new error handling was tested via error injection using this s=
nippet:
>=20
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index 7c55169c0613..c58802c9c39c 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -1069,6 +1069,9 @@ static int btrfs_close_one_device(struct btrfs_de=
vice *device)
> =20
>  	new_device =3D btrfs_alloc_device(NULL, &device->devid,
>  					device->uuid);
> +	btrfs_free_device(new_device);
> +	pr_err("%s() INJECTING -ENOMEM\n", __func__);
> +	new_device =3D ERR_PTR(-ENOMEM);
>  	if (IS_ERR(new_device))
>  		return PTR_ERR(new_device);
>=20
> Changes to v1:
>=20
> Fixed the decremt of btrfs_fs_devices::seeding.
>=20
> In addition to this, I've added two patches changing btrfs_fs_devices::=
seeding
> and btrfs_fs_devices::rotating to bool, as they are in fact used as boo=
leans.

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

>=20
> Johannes Thumshirn (7):
>   btrfs: decrement number of open devices after closing the device not
>     before
>   btrfs: handle device allocation failure in btrfs_close_one_device()
>   btrfs: handle allocation failure in strdup
>   btrfs: handle error return of close_fs_devices()
>   btrfs: remove final BUG_ON() in close_fs_devices()
>   btrfs: change btrfs_fs_devices::seeing to bool
>   btrfs: change btrfs_fs_devices::rotating to bool
>=20
>  fs/btrfs/volumes.c | 81 ++++++++++++++++++++++++++++++++++++----------=
--------
>  fs/btrfs/volumes.h |  4 +--
>  2 files changed, 56 insertions(+), 29 deletions(-)
>=20


--5EJggnWZPpVsHhGGgvP68qAhp49s9cAM6--

--PGe7o0WhAXEbWhRJXhr7S141anCXfyCtt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl3L73YACgkQwj2R86El
/qjnAwf8CSiuxoJBdpf9mD4vFd3seCgMCOxAkR7lPe8OxmUh74bMJ4xug3Z1YmUq
fkFfel5DOOgtpP1Ej7MbPPCfcm8HSY9xiLKDaAtnryXd2FhSF05jp5wHlt5gUqfT
TMMoxFWnxW3PS6hcZ3pL1W89fQ0GbyiNhD7M+so/3erLeoeY85D/Oly4pohLgnxk
0La8CNX6xtSIE9UwPBFiA/e4S6RiRqqs+F6qEQmd4cIVCNa0LAXyEM6hXVU/BnsN
zh+5KZ7yVvSVMJaf6lU+sRLhaelkl+PVW0zaUKG7kMGo2ywyPWqtmMli7Bf+MuOr
0vng7UHntg3gLjs8qNvschVtIhDeaw==
=Y7Hw
-----END PGP SIGNATURE-----

--PGe7o0WhAXEbWhRJXhr7S141anCXfyCtt--
