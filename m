Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D64C214CA5
	for <lists+linux-btrfs@lfdr.de>; Sun,  5 Jul 2020 15:16:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727842AbgGENNm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 5 Jul 2020 09:13:42 -0400
Received: from mout.gmx.net ([212.227.17.21]:47437 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727062AbgGENNm (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 5 Jul 2020 09:13:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1593954819;
        bh=5LBT52pPuA6evP3bWw58hrw8ZVSCyPvb6UjcDWrLaKM=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=PZTbQ1AP1/IC/DQm6m4Vcei2243r87BRB+r3J408FF+C0OE1LTuHnFi2Lgrj7eAFL
         YHO12h+EamXT/pJ/Omdunxgt58FeGZn4lqD4KJ980OT+qKWpDW2uuEt28vFGlvbt4P
         tQuqsLR98kml1iP9CSgmskV3F1mCXmRDx6bD1xGM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mnpnm-1kh6Xw2WHi-00pKj3; Sun, 05
 Jul 2020 15:13:39 +0200
Subject: Re: Balance + Ctrl-C = forced readonly
To:     Hans van Kranenburg <hans@knorrie.org>, linux-btrfs@vger.kernel.org
References: <42c9515d-7913-e768-84b1-d5222a0ca17d@knorrie.org>
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
Message-ID: <131421c2-1c2a-4b1b-8885-a8700992a77d@gmx.com>
Date:   Sun, 5 Jul 2020 21:13:34 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <42c9515d-7913-e768-84b1-d5222a0ca17d@knorrie.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="2jhxaXWb6m3DejvaxqD78y5o9C9X5KjUW"
X-Provags-ID: V03:K1:z4KXCC/0coMbWIDm3wKhXoZ/c0UUJ6vh1qII18kqCfHCLpz8MzT
 zx+oVpAUksmZF3MGPfvKDgecjN1qQkYvti9spjiPlVuPpXEpiV5ghWj8yQiSsTU+bI4XIhT
 xqffHDD+6cE5lp7zar8vwbgJMBsonS3RFOyHLFsXGxDT7M0Oto+qIPftdjX/uHk7DGI4kK5
 ia4VKbFhrzDZYTeB3nDCA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:PB2AGinU6HE=:rjBL1orpXN8Q+JhL31fpMo
 SuVSYIIeachxlfGyQexiITvJ79fmq58I1L/Il9doIiQWRtCGdJdNq1dnq8HrocPRpSub6tLao
 4Gn2TliONIpMR/rV4xYSSe+aS68wWdBE6Mq2USPgkDEE2eviKziCpoA6BI7VEEmDJm/cAl0Po
 9EKB1MAimR+czi3f5hwSqZO3yXNP6rmvnqDPe6N2DhenhfwWFovygc+ryQYNe/B7rOK4Q7yD/
 J552nhHlJKvzDz4DwDC2kGtM6q3p1hAtkaxUspRACe16I19xuWHkWXvWGnVF8H5J0f5Y36U7x
 CJYl/Y33DUS99lntokbyf4YrdHj/rE5oHxwTsCpoIF2aqsfCKoN444xoxXzV8kqkTVDmOvd/Y
 mbIvHC3bHUkXV+hK9GNCJF621vhyzLdJ6t7if/gZ+UtlUQKUacNa8IBUDd3LWcJFzQRTZ6+V7
 AhBF2KFB5OV1jH4aNAFBD/y9QZnWIX52J6JuSoCdvkPTnTRhKMrel1nyATfxeib4LyH2fIQ+N
 lvhTW7dE8Q/wXc7ckPsXDWhDl9pjnvV5VrPmmJ766PZoUe+GNoMn61t2WukM9gqFYMKy7VXVn
 kvYmU6auUx0ARx/zwN0CQftRawmFy9WfQLZK0Q9jcCjCrekkYUVc1F4vQNqzZmlajzqs/WWl5
 40EyC+nON/SO1hcgiiN/cTRjytTSfx7pFYhAChXSt06Zl9hBSLz2ntF2LIUPG8ouA43JGYEsF
 W9mlIx6akoyh5ObtyPtUf9GUzpR8zIk8q1a3V7odD6HD5NCq2ylNFsSSIccBAv7maIIf8S+Tz
 en15O5oQ9RYCBJmN6h1hfEvaUlROci+UMEBxV1iDJSWVOOXTWQ+LPy1dZu1bANPccBzT2/Trz
 82Gowy2MrmLHJJzpU4TXzGcA0W5XrWBQZtW+XpwaVhzwuwjgAwbRQVziDRuCywHnsyJh1FjpS
 A1YMask0HsVI0vdPLx0DsEIdCg6PcjG3buQ/+qFfxdzAzlP364lcmC337ItMptinxABVF0D04
 Iq8cFsK1O3OP6FdbRvj2TN9g7Zg5a+0gN/K0peCO+GB/Wy5Yv/QoHg+r5jw6GH/qHuaQOhaT5
 T9XKyHUXJp1/BWXiogmJw1KuMtiAN8xCZo8OJi3spA681vVTADXEpqiPytJ4aOkDDNgTycMmV
 luYTRViJu8NDhhV3ESdxAnfpN9mC7pPZzD1e0RY6FWKKvx+c4ZaYJTYeVZhKgd8QKn4H3jX/6
 or10Xu7yeCNyzATGmDBoxoUf223oEwDzL0vM4KA==
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--2jhxaXWb6m3DejvaxqD78y5o9C9X5KjUW
Content-Type: multipart/mixed; boundary="zmIwmiZ9R1yv800nTQFhofIWsaevF14da"

--zmIwmiZ9R1yv800nTQFhofIWsaevF14da
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/7/5 =E4=B8=8B=E5=8D=888:49, Hans van Kranenburg wrote:
> Hi,
>=20
> This is Linux kernel 5.7.6 (the Debian package, 5.7.6-1).
>=20
> So, I wanted to try out this new quicker balance interrupt thing, and
> the result was that I could crash the fs at my very first try using it,=

> which was simply doing balance, and then pressing Ctrl-C.
>=20
> Recipe to reproduce: Start balance, wait a few seconds, then press
> Ctrl-C. For me here, ~ 5 out of 10 times, it ends up exploding:
>=20
> -# btrfs balance start --full /btrfs/
> ^C
>=20
> [41190.572977] BTRFS info (device xvdb): balance: start -d -m -s
> [41190.573035] BTRFS info (device xvdb): relocating block group
> 73001861120 flags metadata
> [41205.409600] BTRFS info (device xvdb): found 12236 extents, stage:
> move data extents
> [41205.509316] BTRFS info (device xvdb): relocating block group
> 71928119296 flags data
> [41205.695319] BTRFS info (device xvdb): found 3 extents, stage: move
> data extents
> [41205.723009] BTRFS info (device xvdb): found 3 extents, stage: update=

> data pointers
> [41205.750590] BTRFS info (device xvdb): relocating block group
> 60922265600 flags metadata
> [41208.183424] BTRFS: error (device xvdb) in btrfs_drop_snapshot:5505:
> errno=3D-4 unknown

-4 means -EINTR.

It means during btrfs balance, signal could interrupt code running in
kernel space??!!

I thought when we fall into the balance ioctl, we're unable to
receive/handle signal, as we are in the kernel space, while signal
handling are all handled in user space.

Or is there some config or out-of-tree patches make it possible? Is this
specific to Debian kernels?
At least I tried several times with upstream kernel, unable to reproduce
it yet (maybe my fs is too small?)

If it's config related, then we must re-consider a lot of error handling.=


Thanks,
Qu
> [41208.183450] BTRFS info (device xvdb): forced readonly
> [41208.183469] BTRFS info (device xvdb): balance: ended with status: -4=

>=20
> Boom, readonly FS.
>=20
> Hans
>=20


--zmIwmiZ9R1yv800nTQFhofIWsaevF14da--

--2jhxaXWb6m3DejvaxqD78y5o9C9X5KjUW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl8B0f4ACgkQwj2R86El
/qhAvwgAkb906pRhnK0Ob57DFleMo+jV3gvdL1xsLP2cm9ScLvDIZNJp7S7KHrf8
GudHcN8fWMbEh+FK/i8NTiUYF0vJamlziaoEVUbCyi2S/impFU/IVZTzV6Kkmsf/
2yZPAcfZSPrPH1VFJAQzsE37EBkJdGV8SyIRlcrb3rdZkoULRKECdnX+Tt/yoa5M
nxEo4h2x3BYznex5jbO2EVKUktZ2l3YVdEHQp0CldqfGuBSFurO+vgsftP2+dfgL
sY7if7gwUJPabQoIcYrLZN1y3a+p4WWYVTouyTxwp7wzW9cFjH0IapprqD2atKMP
jU0OuEJg+NgRthGuJs86Xm3OF6ZInQ==
=zFyF
-----END PGP SIGNATURE-----

--2jhxaXWb6m3DejvaxqD78y5o9C9X5KjUW--
