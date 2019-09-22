Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BA5ADBA1B3
	for <lists+linux-btrfs@lfdr.de>; Sun, 22 Sep 2019 12:06:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728102AbfIVJvE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 22 Sep 2019 05:51:04 -0400
Received: from mout.gmx.net ([212.227.17.22]:43443 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727492AbfIVJvD (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 22 Sep 2019 05:51:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1569145862;
        bh=VoY7ge3+bjLqT58gG6YJhKQLaYr7uDaYrYtm4K1Vgqk=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=j5jOpmAYWZEjas3RoZ6rALeRa+tXn8IHfhZ8iEnhXkA/LIP88sVSJXSMfIN+XpARm
         zlf6VvYNCx6COjZTakIpDDsAOyuIVbOUbl3kYLPJ7O81jmX0dLCa/QCTSrKAdNa/xd
         MFSVsPEPSM2ZnDR+RQpDTHwM0eH8e/Fn5r2vhvFM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([13.231.109.76]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N0X8u-1hxl5d1RIK-00wYa2; Sun, 22
 Sep 2019 11:51:02 +0200
Subject: Re: help needed with unmountable btrfs-filesystem
To:     Felix Koop <fdp@fkoop.de>, linux-btrfs@vger.kernel.org
References: <57e3a3a2c40fe7ea33ff85aec59ffaefdd20f3e6.camel@fkoop.de>
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
 ABEBAAGJATwEGAEIACYWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCWdWBrwIbDAUJA8JnAAAK
 CRDCPZHzoSX+qA3xB/4zS8zYh3Cbm3FllKz7+RKBw/ETBibFSKedQkbJzRlZhBc+XRwF61mi
 f0SXSdqKMbM1a98fEg8H5kV6GTo62BzvynVrf/FyT+zWbIVEuuZttMk2gWLIvbmWNyrQnzPl
 mnjK4AEvZGIt1pk+3+N/CMEfAZH5Aqnp0PaoytRZ/1vtMXNgMxlfNnb96giC3KMR6U0E+siA
 4V7biIoyNoaN33t8m5FwEwd2FQDG9dAXWhG13zcm9gnk63BN3wyCQR+X5+jsfBaS4dvNzvQv
 h8Uq/YGjCoV1ofKYh3WKMY8avjq25nlrhzD/Nto9jHp8niwr21K//pXVA81R2qaXqGbql+zo
Message-ID: <1af945c1-0e58-a6e0-477f-59e0900a0e6f@gmx.com>
Date:   Sun, 22 Sep 2019 17:50:55 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <57e3a3a2c40fe7ea33ff85aec59ffaefdd20f3e6.camel@fkoop.de>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="xRyZI2dVeqVrDw7iUPVOLS3JkspHeICqN"
X-Provags-ID: V03:K1:U9JgPqzbXiKyHIvrvUVIFsej+Slw+vB8iYAyVItvVQIcppsSPYA
 84EazI4gxUgXQizQmZH7MllHEzXpr4j9kcGkYVGqPZQ5lq0FVnzPDjrsr8Pmx+8o8gZTDZI
 L0KOn3BNAJDCmsYPRw0bCsobghT1fCQgVz46unbcsKDYiPDtKfs0eYVoq/F1EwJ1RXPjwdi
 ZA2de6fGJ874BgnL2zLIQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:YkC04OYX/CY=:Y0P62WwooKY/u8AtM8fDy3
 y3Pwe4I7ChyBwuKgeSZfKAdRc01k26nm8xkekczRbzf5uhx5p0YvEka1LtlugtOw9MlU+uXIk
 ZozLWYvbTAsKkxd6bUnNNEhwmSDX4PBjiNIEoYoOWxDZe1vzOp+FWirqKplBZX0jrtwTCeGu4
 IiB5hlClT5IF48G+ftPzBv8XUKcQ/HIts+PXOc/8h76uxccvZHAfDp+itnxBUnVlC9DizMlQc
 //vZo1C4EW6JVUajsuKJnAyfTE+dmpXCVbHWVGf98VUiaRspwJaPqcr4+mcmONbYsOInw1dNn
 HacDC24qGmrECWYyMugvomPtCnlmMYtAC9YruV9YsyIXQhCvcyHItOwyCPZRM6yvEsAAmk8tL
 S+uKN0Ux4Yb+PM3z+Ul0aReeseNBl6vEYBgHyrlfOVaZAZZYjQd/YmYyOF2JOJHJPC5VieFHc
 alRovV9P+mXcbjw5i0W05H0MBhLpn3gZY4uD+e5zWEX6id8NS8gVzWVTs92ZfFY0TU0ZVIdFt
 TvDKd8z/6OdILvWyTD2Wh0GWyq60NpWQdtadR13FzjpVYEWHb/00MTNCwPnZdow1w0cfgnT2f
 SY4GxvX3Vr7zw8MOBNWn1gCW+K7lXUvieYlkF34tpYZS4TpuzUHru/IXsZ7Qm9kntlyB/xq6F
 sXkq0rOQrgEw+RbxLhbi10mQ2s2OuD5XrsqipFRwsIYDCoLTlldF8LfKELtY9KTnLfpWBl6NI
 GqTF7kMI+z+GzACfYcDo2EmewhRxlC11iCZZViZ8RfnnUn+R1kc+oxI3Dw4sRM50fggBqiBic
 8vSScNZERTZ8F/7WyjOrjRqI2RXDUXcKn1acOpAVlP/Tfr7zU8FaAni4DFrZDaXLsoA/QNYIw
 2WvpNtJDm/fsnH2jGpD9uHMKpSfsja06BSLXp3MS8wagv3zGq1oxMzEit7Kvmqa9OV/HZ7SUi
 mL/gf24pz/IFKzwWd8UBjbOirPIajQ3q0tA+hvBgqQtIVPMfZJ2KCmpNA5fO1ulPvfZNRjDuu
 Pyaw/6lsA1ZFxAbnSh+7QivSrVtgp9AJs/kcQLPdawLmMV5wztGR/EJFQtd7fd+YjDILbgoAh
 9Pkrbe9HGqK+6SboW9aWBHOHaya86l64IvrUJIolsEMaIzgu0NZ3DpN943tPN8WENJmnPc/f9
 R0EMRxP3Y3ix1BcxYHJqmGtdZDu3guGTQVOn3Pa4+hDKQPmFm0QJfhSlJgFE9eb+xj5NksDUq
 SfnpNsLNIkMd4BLjKc466T8t7KmuyUNLwwNPxEv9njV5vhCmGLtVmLntD4Zw=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--xRyZI2dVeqVrDw7iUPVOLS3JkspHeICqN
Content-Type: multipart/mixed; boundary="QLSK1ktdhby202hZBssqXOZqYyLbYviTV"

--QLSK1ktdhby202hZBssqXOZqYyLbYviTV
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/9/22 =E4=B8=8B=E5=8D=882:34, Felix Koop wrote:
> Hello,
>=20
> I need help accessing a btrfs-filesystem. When I try to mount the fs, I=

> get the following error:
>=20
> # mount -t btrfs /dev/md/1 /mnt
> mount: /mnt: wrong fs type, bad option, bad superblock on /dev/md1,
> missing codepage or helper program, or other error.

dmesg please.

>=20
> When I then try to check the fs, this is what I get:
>=20
> # btrfs check /dev/md/1
> Opening filesystem to check...
> No valid Btrfs found on /dev/md/1
> ERROR: cannot open file system

As it said, it can't find the primary superblock.

Please provide the following output.

# btrfs ins dump-super -fFa /dev/md/1

And kernel and btrfs-progs version please.

Thanks,
Qu
>=20
> Can anybody help me how to recover my data?
>=20
>=20


--QLSK1ktdhby202hZBssqXOZqYyLbYviTV--

--xRyZI2dVeqVrDw7iUPVOLS3JkspHeICqN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl2HQ/8ACgkQwj2R86El
/qi5TAgAhU6TQFsKhixKLO9mjXeMgtjVUMxViFbizu8xNne4/YHI/Qv+I3MFySuE
XESuORCqJNCnFKnvPMvoTo8Cfp1o9QvPEDmDNkxJNxnaxNLLE/NG9YYtEQLFvkv9
5y8qxDKAP1CnB1oTQ+FyfV8EO5Fy2SSsC6L3qOwaWSfU6UHUny+8S4mEtvPcOY3k
0dSiCODL8IM4i+JuhyeKG+GMjsOtjNezu6wIgFTLr9ygQ/LcrCNDZkotv1e0vak8
f1fpZKD6A18Q0o39U0DPe5mgZoMZ+jmiMEsuAyHcnS5NDqvivD7VwUTZ0F8A6e5n
vY07QxmstdjhEjRQE6cAVfewMqv7og==
=AmOP
-----END PGP SIGNATURE-----

--xRyZI2dVeqVrDw7iUPVOLS3JkspHeICqN--
