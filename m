Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A9DD5A6B56
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Sep 2019 16:24:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729525AbfICOYd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 3 Sep 2019 10:24:33 -0400
Received: from mout.gmx.net ([212.227.15.18]:53573 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727005AbfICOYd (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 3 Sep 2019 10:24:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1567520670;
        bh=BAAM1wemEGh68n3MKw13DBo1eA1Ix5beu8S4K9A20ss=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=k3/zBYcuP1M+MEX+B6dx9LBkCXpo6SqYkUmhN6kEqCG1xzGYCo/F9sc4aT4qbIk5B
         BPORcOdK7JrFL1lu/qngASG9AXsvO/B/Njbyi+PCznUpeVKCF5WBUO/WXN+DBSXH3D
         GXhbX2rLjxIX7c0iUfNxrg8QamIxgJsLGAdfCViY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([13.231.109.76]) by mail.gmx.com (mrgmx001
 [212.227.17.184]) with ESMTPSA (Nemesis) id 0M8NBi-1iQead1WxG-00vvNK; Tue, 03
 Sep 2019 16:24:30 +0200
Subject: Re: btrfs and checksum
To:     Jorge Fernandez Monteagudo <jorgefm@cirsa.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <AM6PR10MB3399F9236E61F0AB7CAF4BC8A1B90@AM6PR10MB3399.EURPRD10.PROD.OUTLOOK.COM>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Openpgp: preference=signencrypt
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
 ABEBAAGJATwEGAEIACYWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCWdWBrwIbDAUJA8JnAAAK
 CRDCPZHzoSX+qA3xB/4zS8zYh3Cbm3FllKz7+RKBw/ETBibFSKedQkbJzRlZhBc+XRwF61mi
 f0SXSdqKMbM1a98fEg8H5kV6GTo62BzvynVrf/FyT+zWbIVEuuZttMk2gWLIvbmWNyrQnzPl
 mnjK4AEvZGIt1pk+3+N/CMEfAZH5Aqnp0PaoytRZ/1vtMXNgMxlfNnb96giC3KMR6U0E+siA
 4V7biIoyNoaN33t8m5FwEwd2FQDG9dAXWhG13zcm9gnk63BN3wyCQR+X5+jsfBaS4dvNzvQv
 h8Uq/YGjCoV1ofKYh3WKMY8avjq25nlrhzD/Nto9jHp8niwr21K//pXVA81R2qaXqGbql+zo
Message-ID: <3930ddc8-f4e9-1db4-dc6a-d8945cda0e10@gmx.com>
Date:   Tue, 3 Sep 2019 22:24:25 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <AM6PR10MB3399F9236E61F0AB7CAF4BC8A1B90@AM6PR10MB3399.EURPRD10.PROD.OUTLOOK.COM>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="eZlStbhfZgzqTxyrIwc9BT5c8HOjkgMns"
X-Provags-ID: V03:K1:/UrsnNHeWs3LXGVz6mKOJnp77XEkUNAKTFCiiWVbLIJfuxw301E
 jVVCOB8abz+LtRUJtYtL459KsVZOYYf/ngtS6jnJ54pDB0MmSD/HMxXptgALbXZCz5lqB17
 RwuoR0wVTWj6a0yL9UADbM+oiajpK1WayGQYVcux8GGq8G/4Nv4ounsbP0ASM6h9Nma4ums
 KS74yUrD1OvCcsLDKkldw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:DZdRnwk7ljU=:SDU8+oWFqVMY/TILs3iCtQ
 fXbJDDSo5VjB4Ftxt3HaW11EVlEO2icmrLEf/y6Vlne8FXWNV9TPefWwrOnVauwNfjWsMI7OH
 haJvDIQhwEGVFeuOr9tKLOdU6GgBAs4SToWRBbQznxHDeoRmYOtkb2bX6FFbV6lMeLerpLwGJ
 qBVS3olPAGU40Dx1nHcaqBWdc4rPdA5XGHG5gZ0VtFXCRadqHpY6xXuP+tJp9SaU6oq6xvt08
 NjCQxfqFl0kummdBQkkB0B1Q7E1b6KVE+kcJwWaKa894J1j8KsMoare421dDg0+FYwEvOJgnA
 E+J/rpB9vOyMU7bJeM3uPWePwP5p1EchsqYLjjy7UcL6ZXVPVjNVAG30M6m2AYLud/f0eZSX7
 M1+YCnCQ5KyUUVLjtBPj2+Pc5Bh1metnmyxDEw10JLHxfR3T5dcsLkoS2vXV7jp+wCMYq1Xay
 /92+iqQEj2OHMCwY7NeAf6WxUBrQKsn5RhkqlSauDCTouN46JxBnvmAkqecJjDrXpneCU0oJa
 XTtTYbx/ZtjNDLhWfFl2QDyyF1QrIKeMRpWZpOK5cngM1vGUBD6rVpwMKTi1JBikdPpN1tp2H
 ywRV35/Xn0nqJ7hh8+eaKG4e6+nHFy7zKcRWVwj0ctT0lJ/kh8Obcbkgs4o3RYaSnErHbcXPY
 cgYiFckfuTOxwiJrHbungS2UcY0RzO4jbv8KWoprIgsXbDy0j9Va4qDYs2h+z8FZlI6HVB1nC
 Zwg4k5SgwIcbFTDrvbTzEB47IUFsGyO0AMGQpGAT3sztKORwfMbLSXnMQt0AX9tWOoOhvVx5R
 mJDq+UKI3UVqjHdW4GvOnl2u4Zj0zTYibuCrHROYTLtTYsTuNOgnwi++JFgweGvnzj0L6yuJ8
 /nYSM7Ep3HEEY1Lw5FSb0bW3aAtsuJVIyn/m1ugZpsInX59YmRVVoWrHcqKUX5MjuOxcDhCv9
 I60YJOVIZzBO4eqZHpnIGJZLbR4xI7GZa7vVPZ7ZSX7XnmNoizAb5BFPk/w6qWjKAJxp/0zUc
 w/lo6x+4BvJz2QAs+c1IB1d0Hd0ByiMhOX9B1sFcjs/ZrfHZkvJ1VmqBDB2i2UiUx51yQkMOG
 ye1qJx+sdhN8gIluE4RImGDDylRSESiI1gTmIoyKYFrs5jpM0hWlyNp4A/qebUM7ZUBN1xN5W
 +M1p7oSMj9+AYljhC9HWJ4oja6mURR7O4nHWgHPbFwM9oOwPg5ricPvyRwTwb1Fx2jMEEMy2F
 4G3kvGy4EvKUDgQr9
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--eZlStbhfZgzqTxyrIwc9BT5c8HOjkgMns
Content-Type: multipart/mixed; boundary="QMQpIBV1zVGCVA9og8kvX22cIttmKtvGl";
 protected-headers="v1"
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
To: Jorge Fernandez Monteagudo <jorgefm@cirsa.com>,
 "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Message-ID: <3930ddc8-f4e9-1db4-dc6a-d8945cda0e10@gmx.com>
Subject: Re: btrfs and checksum
References: <AM6PR10MB3399F9236E61F0AB7CAF4BC8A1B90@AM6PR10MB3399.EURPRD10.PROD.OUTLOOK.COM>
In-Reply-To: <AM6PR10MB3399F9236E61F0AB7CAF4BC8A1B90@AM6PR10MB3399.EURPRD10.PROD.OUTLOOK.COM>

--QMQpIBV1zVGCVA9og8kvX22cIttmKtvGl
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/9/3 =E4=B8=8B=E5=8D=889:50, Jorge Fernandez Monteagudo wrote:
>  Hi all,
>=20
> This is my first message in this list. I'm looking for advice because I=
 have a weird silent data corruption and maybe with btrfs and the checksu=
m capability this could be, at least, notified to the system, and detecte=
d using some btrfs-utils tool or dmesg.
>=20
> Imagine you have an SSD with an EXT4 partition in READ ONLY mode and in=
side several files.

RO of the ext4, and still get corruption? Definitely looks like a
hardware problem to me.

> Every file is an ISO filesystem crypted with cryptsetup. Then first, th=
e EXT4 partition in mounted then every file is mounted using losetup and =
crytpsetup. We have found, sometimes reading a PNG or WAV file from any o=
f the ISO filesystems mounted, we get an error because the data is incorr=
ect. Flushing caches and trying again don't solve the error. Maybe we hav=
e a faulty disk controller and changing the filesystem could be useful, o=
r a RAM with some error...

For btrfs, as long as you're using data csum (default), btrfs can detect
such corruption.

For v5.2 kernel, btrfs can even detects some easy to expose memory
corruption.

But please keep in mind that, due to the fact btrfs (at least least
version) is very picky about corrupted on-disk data or memory, if you
find something wrong, you need to check dmesg to see what's going wrong.

Furthermore, if your ssd is not reliable, especially when it lies about
FLUSH/FUA, btrfs can be easier to be corrupted, as btrfs completely
relies on FLUSH/FUA and metadata COW to ensure its safety against
powerloss, it's way easier to get corrupted if FLUSH/FUA is not
implemented corrected.

(On the other hand, btrfs is more robust against data corruption, so as
long as your SSD is OK, you may find a better experience using btrfs)

Thanks,
Qu

>=20
> Changing the EXT4 to btrfs is enough to enable the checksum property or=
 we have to change every ISO file to btrfs to enable the checksum?
>=20
> Thanks!
> Jorge
>=20


--QMQpIBV1zVGCVA9og8kvX22cIttmKtvGl--

--eZlStbhfZgzqTxyrIwc9BT5c8HOjkgMns
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl1ud5kACgkQwj2R86El
/qhJTgf9H0bSAO4DizmQcbCITRP92F1i4JV4MW57nxjizTU2XDMULTmbgIc+aD+e
51RBRbFzka5ble2YQPz3QdyAsfrKRU4CQAT8Bt7h/vxCVfW34WeWE68WjLQD/opQ
AU13PqkX/8rmDOoTvf7MF6KPUGqJO6TGgmf1/WObOSQjDruhyU9Fq5dRA8HjB+l7
czUqHSxInh3NOxP76Kj2/khSAFzaXTPPsjjGlYfsraO7nGUStODBX9ga18t4mv/T
HPLxdRX45Be3LfuOkQLjnIXuMlacNuxuk/nSNwdInJDEmTWOUzN/R2FfZj9b3P0+
dwaetqehydNOWnECSk+8E2MoNCwk/w==
=Po4V
-----END PGP SIGNATURE-----

--eZlStbhfZgzqTxyrIwc9BT5c8HOjkgMns--
