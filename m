Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7482D230B50
	for <lists+linux-btrfs@lfdr.de>; Tue, 28 Jul 2020 15:20:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730064AbgG1NUH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 28 Jul 2020 09:20:07 -0400
Received: from mout.gmx.net ([212.227.17.21]:51453 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730058AbgG1NUH (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 28 Jul 2020 09:20:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1595942402;
        bh=sDMiPD/oKPvD+uJ6Z0d0cfmjN0BFHSgIA2ndvAMyyAc=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=bdYmgpqYIo7R1OsLTASzKAiRSJtIZqKnZjtb9LVpX8AlL41g1UiHkTAHVooguFabJ
         r6XuC4kc0Qn5vU3BFgi7ihW8iwzvSroPoRoEan2ckEiRAqkUgNy5RdJGD6C0kU8gHy
         HaTMzmHKBQCHAs5DQS31rFARJCFPGbiGEOdtuO10=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MAfUe-1jtmlF2COu-00B43i; Tue, 28
 Jul 2020 15:20:02 +0200
Subject: Re: [PATCH 1/2] btrfs-progs: convert: Prevent bit overflow for
 cctx->total_bytes
To:     Neal Gompa <ngompa13@gmail.com>
Cc:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        Christian Zangl <coralllama@gmail.com>
References: <20200720125109.93970-1-wqu@suse.com>
 <20200720160945.GH3703@twin.jikos.cz>
 <cf6386e1-a13b-e7cf-a365-db33a3afe2a9@gmx.com>
 <20200721095826.GJ3703@twin.jikos.cz>
 <0d3eb6c1-f88a-e7cd-7d12-92bce0f2025c@suse.com>
 <20200721135533.GL3703@twin.jikos.cz>
 <cccdcdc8-db5a-779d-7b99-346ef14133e5@gmx.com>
 <20200722113220.GR3703@twin.jikos.cz>
 <CAEg-Je-QVTWQeFg1gJMSXcBHzniSjMNxSXiN2L++_YVeTwZH_g@mail.gmail.com>
 <493ab1f9-9f58-6d8e-647a-9092e1e0480f@gmx.com>
 <CAEg-Je-VLKs1XO+PocCDVPb8mQPFbXZxYmC7CRnCqkSxVk1EBw@mail.gmail.com>
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
Message-ID: <b49639fb-20c4-6944-1109-57c7a19c8039@gmx.com>
Date:   Tue, 28 Jul 2020 21:19:52 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAEg-Je-VLKs1XO+PocCDVPb8mQPFbXZxYmC7CRnCqkSxVk1EBw@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="fo0EL0ME9uW02CQrDUinZ8b81oyVyfW9t"
X-Provags-ID: V03:K1:kpaCzAfUlYuQ/f7zlNzm+kLahjWhZCBG36ukWXzDL/YcCojvku2
 aQm7/GOgNIzfV5PtMGVs8t4+6j8kB754UY+AmsYbuH8rHtK0oc5AaJqkheQvgWPJ20DlqJh
 EoVKVGVXTUwSAfGHn3Dhtyoq6llqP5NzU8Saqq98vmiS8LNMjEEfGa6CzKUcM+dd5IGFnmL
 THCIls/Wld1C7HJnLyWKg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:503nZm36hHk=:ZahgUx0hCTxyKIdYZ9Uvqh
 njZWYufrP1UpM+lO1uoMl+bi8WN4vLwhq9y76FQxgZoUVbh41CJc10iRZhCE1PNcciIcFJslW
 kkvYn2OVJoYVOxdTwqPvQC2amw4yfDbrnCOzFgBcOpq845+jew1RdJ0xeAgQ5hycCRveXwDEG
 iSNbIkP2o2IhacDUAuCKRuDFBkeuBIJFN4zwx7gQhv6mxZt4W6G//aa39H94rRoXD3Hn94CRY
 +LTHAwUWR0zx4tOMXO2e1HMQ8wI6CStFGSABNeWpnFVX5LSiAy05zBDDCSsEDnt7FUKQzNhKH
 bp3aMNb9EWsJXubT/ZZL6luwB6vuHQtkX8PGEDmSt6ODa9p7SGtMc7eF8tOX65A2IMQ6U6g23
 Ph0sFjyMNmMc2UXeZzdwCoy/BPSqEN9otGxo8ZC9fdcl6IXlFloVsSoimuIh/wuyzdn7d8M1p
 4QCELbzU2JXBwQS2f5NQGhs2PYVfztf8bQ+rZo0iR1ATqUkzYpRapKF2Bsy38A6Ml3j8Tu+cM
 wxjgoB+Cy99Lg3ilswu2c1H9cEgN447n16IBF47/zFhtVjTAKm1l8SbWeCQrSO065nTohV1tB
 8S3ARJIF6u1fXyGq6660ZqqBtzCRTR0MWrSzHdqXSx4an7WQyw+2mI6OdHAiycZlePJFR4wH2
 02m+XVvF5fXCPaJ//pLl15zD0RPY248GB5CAbRTcT8G9hzk7+Tsnn9h09hJoqK+ZdJZCrnqNP
 4nydWx4tpgf95jt58ODABPEBy5hzTjYEJ0ESgI83qwv4ZEaJK83nYjbk1tXPlk2xhJDmw5Lp6
 gYPfyF9ZMsSrcZLS1KkuBQJVdac9QULoe37z1q92spWYB2WMi3kYJ55Nb31FVGHZET8/+IvL8
 M2td2ll7sMbY6e1pK3swLggpduafHOwfXwz2QuO1wVPxqF+CbUKsHnMGhw5FuotilCELQNNYS
 S0j9c6PWQJi5tfAYfQSdGbou47iPPEJJ1P8E9EzyO5obdUZe8UmOosrGK8Lz7BQzKwxe/mNf2
 bvk+Wo9jH2VPHvW+bBKqaTPKr0dj2tRdZZ2F766wjwUUIt2dbP/hkIjot/kwEZW4Wpwd18lyt
 UpZtcYw6Mc1rAyD2SB1oWopZWUSuxUMZgk2AyG6V4qCJv0JmvF6MaWwu9LJrAu3AMMQi8fMlS
 cVqCQB15si/WPB2cip9H2vpRbSr65DZFpSloYlsxuzyhG6stX3yGXMBNcIGM49T6pNw6cGlDR
 +bQ2HH4z9I8pCfb9dbCya/kMfOg/icXJfxAG7Cg==
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--fo0EL0ME9uW02CQrDUinZ8b81oyVyfW9t
Content-Type: multipart/mixed; boundary="CEVFy4T1IPo61rmgWF5Sw1rqlKfD5q9Hb"

--CEVFy4T1IPo61rmgWF5Sw1rqlKfD5q9Hb
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/7/28 =E4=B8=8B=E5=8D=889:14, Neal Gompa wrote:
> On Thu, Jul 23, 2020 at 8:02 PM Qu Wenruo <quwenruo.btrfs@gmx.com> wrot=
e:
>>
>>
>>
>> On 2020/7/23 =E4=B8=8B=E5=8D=889:31, Neal Gompa wrote:
>>> On Wed, Jul 22, 2020 at 7:33 AM David Sterba <dsterba@suse.cz> wrote:=

>>>>
>>>> On Wed, Jul 22, 2020 at 06:58:39AM +0800, Qu Wenruo wrote:
>>>>>>> Thus casting both would definitely be right, without the need to =
refer
>>>>>>> to the complex rule book, thus save the reviewer several minutes.=

>>>>>>
>>>>>> The opposite, if you send me code that's not following known schem=
es or
>>>>>> idiomatic schemes I'll be highly suspicious and looking for the re=
asons
>>>>>> why it's that way and making sure it's correct costs way more time=
=2E
>>>>>>
>>>>> OK, then would you please remove one casting at merge time, or do I=
 need
>>>>> to resend?
>>>>
>>>> Yeah, I fix such things routinely no need to resend.
>>>
>>> I have a report[1] that seems to look like this patch solves it, is
>>> that correct?
>>>
>>> [1]: https://bugzilla.redhat.com/show_bug.cgi?id=3D1851674#c7
>>>
>> Yep, looks like the same bug.
>>
>=20
> So I backported this fix into btrfs-progs-5.7-4.fc32[1], and the
> reporter is still seeing issues[2].
>=20
> Pasting from the bug comment[2]:
>=20
> [liveuser@localhost-live ~]$ sudo btrfs-convert /dev/sda2
> create btrfs filesystem:
>     blocksize: 4096
>     nodesize:  16384
>     features:  extref, skinny-metadata (default)
>     checksum:  crc32c
> creating ext2 image file
> creating btrfs metadata
> convert/source-ext2.c:845: ext2_copy_inodes: BUG_ON `ret` triggered, va=
lue -28

This means we have no space left.

We don't know if it's the fs already exhausted (little space left for
EXT*), or it's btrfs' extent allocator not working.

Would it possible to update the image?

BTW, even btrfs-convert crashed, the fs should be completely fine, just
as nothing happened to it (from the point of view of ext*)

Thanks,
Qu

> btrfs-convert(+0x13589)[0x558cfe4a6589]
> btrfs-convert(+0x14549)[0x558cfe4a7549]
> btrfs-convert(main+0xfc0)[0x558cfe4a22b0]
> /lib64/libc.so.6(__libc_start_main+0xf2)[0x7fd2c6666042]
> btrfs-convert(_start+0x2e)[0x558cfe4a35ce]
> Aborted
>=20
> Any idea what's going on here?
>=20
>=20
> [1]: https://src.fedoraproject.org/rpms/btrfs-progs/c/e4a3d39e87313954c=
b3e8214e28ee0ba50bee874
> [2]: https://bugzilla.redhat.com/show_bug.cgi?id=3D1851674#c13
>=20


--CEVFy4T1IPo61rmgWF5Sw1rqlKfD5q9Hb--

--fo0EL0ME9uW02CQrDUinZ8b81oyVyfW9t
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl8gJfgACgkQwj2R86El
/qjtVAgAo00uKeADSbnA2lsIKpr5tdtncIGDkKhVc+WqnpWYz9FWNhoOrjApFn9G
cl6T9E3bVTctxYWtEQn8CBG2G87l1sP3PDlVL+xzZoWwRDK2WAkeLAuavKfH6LQm
tP1VaLjJataqVlOkPHzlDLQU4/BYTqctMHRSKAHP2wHWyoD3CnX1muF9pdKmg7H8
qOFa3K9349wxbklaNPPeyS76pIjVS3qG81D0QVUc9M7yzWFziyp5AGSq1WdLY70x
/YIWUQ5Ci85LhQ2ik3em0zMRpJ4kM8gliER8md7Ar2hYmgvH7+ZXFTTd18CL044K
2sYieCGt8LenLi2gqKx43HMrI1kS0Q==
=kZSt
-----END PGP SIGNATURE-----

--fo0EL0ME9uW02CQrDUinZ8b81oyVyfW9t--
