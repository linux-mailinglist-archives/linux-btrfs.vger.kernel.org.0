Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C12F21FF39B
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Jun 2020 15:46:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730376AbgFRNqg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 18 Jun 2020 09:46:36 -0400
Received: from mout.gmx.net ([212.227.17.21]:38947 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728159AbgFRNqf (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 18 Jun 2020 09:46:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1592487992;
        bh=+boDT2ZUqaUq8G34yL0b+Oa+hu9DGwNNC40Aj0Iv4YU=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=elpBd/JActYzHX+z9c2LlfidHG+JFHEZW+B/m0uGpMEou5PrDt/4wxR1VdLy+jaeM
         Us2GVTV85IpmCnQzwapjRHiC+9jHY57e3REkp9dYyTUv/JcETMmeuq3tHbCxeGpmzu
         3NDa6tOB2V0b3LpR6dU/Z7k9ymHRzy9NJnZdK4vk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mqs0X-1j88CF0k41-00muyT; Thu, 18
 Jun 2020 15:46:32 +0200
Subject: Re: Physical address offset of the inline extent
To:     "Rebraca Dejan (BSOT/PJ-ES1-Bg)" <Dejan.Rebraca@rs.bosch.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <31850f19929b40e4ade80a264c1af97d@rs.bosch.com>
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
Message-ID: <02fcfb22-6b2b-6f99-99c8-b132ee511530@gmx.com>
Date:   Thu, 18 Jun 2020 21:46:27 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <31850f19929b40e4ade80a264c1af97d@rs.bosch.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="hTYFfdXsyEu88MjwNhn6WmyyAF67K3YZY"
X-Provags-ID: V03:K1:iVXSnxOXI5/nlmeXsZ0dTWKjPCB+W+c5IEWqXu7XQxohs1oj5a4
 CrgCMq2IwZZBWw3MHsb6TdZ8mXeSjCoIW7N/JjORlNSDzzv3NJUgRwAYItbnvNwGDhgMqG8
 McBlTxepE8gfs6oVENdCXSjuSCuQ4sXzyeEF5equMXt1JdmHydamXiR55WZfQk7WqgBIaJn
 /0HYyQ6OkYsDnG2JnNCJw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:f1XgLR3c838=:6NdXhLyWFL6Xzl9QuBqHSQ
 VxDrGI8dily6GoCgw8sPCxHXYtgdmnhHOyogL1DChArIAvb1E9q7B//9eBknWpGD48B3dzB4I
 0KTzaChuMvOsuJ8NbrTr95m8RLwsqEtHZiyYOaFLLvgS1hjdCj5TSDX2TNaevkB0d6GQRQAaE
 EsORwseT9QDF96qJVM14+7IfIhkfOlaQtdZWJJLm1STp2TAVmF2VYutSElX/3+zkGDhsTZOHn
 +3Q1KSS1/SGsISzsh847lS7Ygz9vKct0qGjXt67r3nEHvcbjcKn3DqYB3hjcwZYCJVv0JTccV
 STVRAqDnRHjhnEaQBztzXbyoM1awOYNHBmxTrYypBzewGlMTrhywHExdkEJmXuYJnln6nSoOy
 3R05dAKY8TmCPQOl/AaifTbIInaHuvXoQ/GN6cDy2AygrTQuu39Oy5NsfNZdTS+7a6mC1CEdQ
 xrTCGfdcrhV2AZjRDA1AAN4IbY/GiG4sb1ngGB4I3E9Sfp2kltjSCtt8+Mey4kFeehkuOaVVD
 T5SzAXunrVMl7a2iN3Aoq4L0o2CD6YEd3wnRUKe6NDKD489t2Zk05KYK18/xI8eJNNMBhFqAt
 PXUAkbZTKxuUTMK1w9cCYHN6nvz9s+xIv1qMTmh+qSgsJA0o8eyqIUkxka9S4dWiPfmZjZvoQ
 JXd6PlTSGSmJwfFnZHrjN7YXhKAPxhzUdXgQQKgdb3tH+f+nYubUNt9dAS2sljPPJ71r3DOl2
 EQo8WxBn3fr35pVLS89W7ZEJ8T70OZhF7gWARiCrO/FA0QC7F/WYcuZU/xD7+mJjMT+S5M1C5
 S6S+I68NcLp+fdBGKFuSHUeDng8GrFw362JCfrJAxYXt8GHSJ5Gep67Hvyeo8Un0qXHxTV0y+
 k5cxGszRK9f5XhRg6lWsU5KHR1/y5kNY55pKeH9zeI1YqO2WIGWv4W4AXGrkSwdF66fRkIzmD
 XdPQgouSGLgWWGcs3Ho8ge90sjIZcVt6JYKFMC2sjbKrCyaDF7iM1/xFBkfqlhJwcOih+A8ji
 x5TmZvS9b1hc97CMy1ys8j5e7fPjZ1MlvrqmV9hq0L3jc+IvtUh+C9izhRYgXzew/26JyEzgB
 znCEEWaJovu+6VG3CCo+EvjfRxhx/hc/Yq/2SGlQlHFBAVv/8DluxHnrjxHuooK4wNLPW5dPR
 6MlWeOtDHrPDRDpH0fShh9W/zJx+CQEDmgJP91rtNsEuUGS1J040gdhPjg3b/lOGWZpJsvPIU
 h1A+16EXL87hl0HIq
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--hTYFfdXsyEu88MjwNhn6WmyyAF67K3YZY
Content-Type: multipart/mixed; boundary="kNKWNLHLkmCA5QDDHVSZfZhoh56CfqtTA"

--kNKWNLHLkmCA5QDDHVSZfZhoh56CfqtTA
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/6/18 =E4=B8=8B=E5=8D=889:21, Rebraca Dejan (BSOT/PJ-ES1-Bg) wrote=
:
> Hi,
>=20
> Does anybody know how to get an address offset of the file data inline =
extent?

Since it's inline, it's inlined into metadata (tree block), thus makes
no sense to get the "address".

The address will be inside a tree block anyway.

If you really want the address, you can check it with dump-tree.

$ btrfs ins dump-tree -t 5 /dev/nvme/btrfs
fs tree key (FS_TREE ROOT_ITEM 0)
leaf 5324800 items 7 free space 13619 generation 6 owner FS_TREE
leaf 5324800 flags 0x1(WRITTEN) backref revision 1
     ^^^^^^^ Tree block bytenr
=2E..
        item 6 key (257 EXTENT_DATA 0) itemoff 13794 itemsize 2069
                generation 6 type 0 (inline)
                inline extent data size 2048 ram_bytes 2048 compression
0 (none)

You need to use extent_buffer to grab the inline file extent item, and
use the btrfs_file_extent_inline_start() to get the inline file extent
offset inside the leaf.

Anyway, you need a solid understanding of btrfs on-disk format to grasp
the above dump.

> Kernel returns 0 trough FS_IOC_FIEMAP ioctl, but I would really like to=
 get real physical offset if possible, most probably meaning:
>=20
> In FS tree - on-disk address of the extent data item for the relevant f=
ile object + the offset within that item (0x15).
>=20
> I was hoping that the key.objectid of key.type =3D EXTENT_ITEM would gi=
ve me such an information, but apparently this is not the case.

Key.objectid of EXTENT_ITEM only means the inode number.
Key.offset of EXTENT_ITEM means the file offset, for inline file extent
it's always 0.

So it looks like you're not familiar with btrfs on-disk format, thus I
doubt the usefulness of known the inline file extent offset inside the
tree block.

Thanks,
Qu

>=20
> Thanks very much,
>=20
> Dejan
>=20
>=20
>=20


--kNKWNLHLkmCA5QDDHVSZfZhoh56CfqtTA--

--hTYFfdXsyEu88MjwNhn6WmyyAF67K3YZY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl7rcDMACgkQwj2R86El
/qg+TAf+POeLdaLhMCWSu/PMLK2S6yG3BOZzd09lq2sleHb5QENI0zoEv8V2Y4uL
NcP7gS7thFD67uxBR/lNtoLkbbZWKKKV9KIo2Tv4pIatuuB5dVE1NErEV7ukpptz
UNadpd7g42sC0uzxDVPgiURmkZy58cP5kdkvrneh+D7dQ6H41XHHWPLYa6HM4GDE
yRxBYtP0dsXPqQ0+fQ/Clf0mthKVylNuFmObZ03fGtNr/lqSuzzzh7e9aPWottDL
G3lrt9pmSTRkt6nUureIYoHtUIF9hud3n/2Uba5OGNv9T5CJetlk4tZizmNPxmCD
xx/+QnV/VTlcbBHlrjQ8Gpe+wCpb5A==
=gBB4
-----END PGP SIGNATURE-----

--hTYFfdXsyEu88MjwNhn6WmyyAF67K3YZY--
