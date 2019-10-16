Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7ACB6D859D
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Oct 2019 03:52:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729970AbfJPBwK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 15 Oct 2019 21:52:10 -0400
Received: from mout.gmx.net ([212.227.17.20]:48579 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728338AbfJPBwJ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 15 Oct 2019 21:52:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1571190726;
        bh=zAkKmodHeUy8966JOwp8PwnP2z0fvMqaB/Ui3mH2iE8=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=W1GYCOotftl1FMymGG14zKjusPSLfzvQI7vNPs1IrIkfzsmoWc6YsZ8WplSTVvfb7
         RQMlYjbM5IouuyORZVlqgq+306eQmj4cYP+5UHU5wcW2X9jChjJpEJ1gYyBYtU/fKl
         yxRe+BL2CM9ggDfc4+csnZXgy4m3yp6RtBP/belI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([13.231.109.76]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MwQXN-1i2C5A2nbR-00sKT2; Wed, 16
 Oct 2019 03:52:06 +0200
Subject: Re: bad tree block start, want #### have 0
To:     DrYak <doktor.yak@gmail.com>, linux-btrfs@vger.kernel.org
References: <3bd5b254-f3e4-1b81-da75-7a15cd49fc43@gmail.com>
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
Message-ID: <64330b7d-d3eb-adbc-3b59-ff6dea8d1430@gmx.com>
Date:   Wed, 16 Oct 2019 09:52:01 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <3bd5b254-f3e4-1b81-da75-7a15cd49fc43@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="vg3dwxhdHslQOs9vw8yI9enaEdVixP5GX"
X-Provags-ID: V03:K1:d0sQ++K1fZXQBoxsz8+nFtZ6K1Vztp7tyg0gpzMwAtFJ0pT7Xzc
 pnVQFTakmtunJz1a+P950CNi8qYEZNSmS7iWkfA+CovfqDTr4ZqNsuoR1gs2L7p0dPmnZLg
 9YyB1I0ajo/r0KxPXv3cH6e3C5JKMzMLTC/HsKF7/A31OgXWD/6qN2ldlGxVD3LH5DgULrj
 dq3E6t0mvBQYGcWqraj6A==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:+Nn6DstAWWo=:O+MudGcjjQ/33H/qm1wFr2
 qpkwjbv/VE00ltMowToT9WGzukh17w2k6Pzj952IHnJ9vhiGf1WaRCNL2h/p3pJ0tF8B+uKb9
 IZO1q82E7yU+O7aLqtpQ87Yjk2/IXMCgSZJ/LP/9DnfsbuXD2tO919jOgFPwfLh/CLLM0l+JK
 etQHa6FP164KqAkIh5XO7WRJCWq1bTGOEOR5FhPd0b/mLMoBN01iVWIlbFVPzTSaVvY0m9dL8
 TGj/f5iZ8cBZqrtv34tKcnh9fcVmd+2ercB70GFP8i19eNB8Q5RGiw3Bfeb0EbR/4FoYExrrE
 /ETspJP0057h2qlHY4iQTV7AzBNQgYeAiLhV0KiOfZlhgyfMwvOzSjzPtkGC+SLzNado8Bu6y
 pWEvZGJWwhzbZcPTYhmUQuYpvkA3nFElhEYMiaH7kyEyy7gZLkYNUnYx7LyUbUncmOXVWvTds
 8U5LhsNNnRQ7b5+GFKVy9q4TVYfQiBroMa4MntNNsaIJslMu4jiIXIWY/ZikkvwcPU+Whr8cZ
 WBHVMwPbTIDn7Z4zl+vzV0k7u07X4GKHwyAD70Kjo8de5ExdJ1eGsp+Zxf61WQqXp9oc1x1l1
 MSlfd4+C2peJS3AuR2KU6nxcJuMGHBb0wgKXuzCIOPzEdKzdB7PQEVsFpCdcXjcrLiMK8cyXA
 e67nFA/W/wD7q/KpbO1gUA309U48e4zkOtcSKdtt0lD5Es5m3iSuAecbUugXzJ/Yf2dseaH2i
 9WZQbjJLwiQdswHLw42K4HhcoIxp11cQg4xIWAgAFPnG0sI8d3nu8eCThji8IumAvsCvFGa0F
 UYM/bdoGebZqa5k+J/3a32yDAj26EZOVLGpWyp6UgFWFoZvuM4uk9yG7yy/1FrCfNf1rddZ6a
 7+CCxDxNE7AYYB9oOUGl9Lu6xCz/f+Wb/c9RYCRY49U6ydz2mAYxnV13Rpy6hROlET0N7kawA
 nx2zyCWyRQWJUjlQiiNStGOa2eTKzRJzcShVeDemZNVT5wAaN5ViU+H+Hnwhz0a1pkfpwuEep
 dDRhn728sx329gtoEQ4zNLF69yKSQL5Jma03U5IgsS7m1/GSvq1eVpU+/JM2f4KY93BG3nXJH
 2HRbwC5rS9bsZZG9HegBJeLO8hdNe3ntvzr8LB3eUItSMByDJBMxYE/6QaRfmZ7YoA7xvcfa5
 kn1RD0XxcGF43N/JOGPU+i3o72fItxPr0iF4+eqIrpYbX01ffaZt8O05P+JETue30TINp8oAB
 ckDhtgPQXFDXSPY+3rCSiZddbXNClJlhTxsrg6naXwYSs3EqgeLo8w6/feyo=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--vg3dwxhdHslQOs9vw8yI9enaEdVixP5GX
Content-Type: multipart/mixed; boundary="BNDRUpxe3aD0d8znFl8pDHU4Fphd2G9GU"

--BNDRUpxe3aD0d8znFl8pDHU4Fphd2G9GU
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/10/16 =E4=B8=8A=E5=8D=883:03, DrYak wrote:
> Hello
>=20
> I'm having trouble on a BTRFS file system that I use on a Raspberry Pi.=

> I can still mount and access (nearly all) my data.
>=20
> The trouble origin itself is probably hardware (flacky USB3-to-mSATA
> adapter and/or power stability), not necessarily a bug in BTRFS.
>=20
> As I've said I can retreive nearly all the data I need, so I could
> surely just `btrfs restore` and then rebuild a new filesystem.
>=20
> BUT...
>=20
> I wanted to know if it would possible to just repair the filesystem.
> (Basically kill the broken extent and/or excise the corresponding tree
> leaf).

It's not impossible, but not practical under most cases.

>=20
> Are there any way ?
>=20
> (Again it's not critical, I could btrfs-restore, I just want to know if=

> it would be possible to clean it instead).
>=20
>=20
>=20
> Here are `journalctl` message regarding the failure:
>=20
> Oct 15 20:37:20 marsberry kernel: BTRFS info (device sdb1): enabling
> auto defrag
> Oct 15 20:37:20 marsberry kernel: BTRFS info (device sdb1): enabling ss=
d
> optimizations
> Oct 15 20:37:20 marsberry kernel: BTRFS info (device sdb1): disk space
> caching is enabled
> Oct 15 20:37:20 marsberry kernel: BTRFS info (device sdb1): has skinny
> extents
> Oct 15 20:37:20 marsberry kernel: BTRFS info (device sdb1): bdev
> /dev/sdb1 errs: wr 0, rd 0, flush 0, corrupt 126, gen 0
> Oct 15 20:37:49 marsberry kernel: BTRFS error (device sdb1): bad tree
> block start, want 547248750592 have 0
> Oct 15 20:37:49 marsberry kernel: BTRFS error (device sdb1): bad tree
> block start, want 547248750592 have 0

For this block start 0, it means the header of the expected tree block
is all zero.
Normally, either it means the write doesn't reach disk, or a wrong
discard is triggered.

>=20
>=20
>=20
> And here's the read-only check output:
>=20
> # btrfs check /dev/sdb1
> Opening filesystem to check...
> Checking filesystem on /dev/sdb1
> UUID: 5475b0ac-0010-4875-a0d6-e6641c951f5c
> [1/7] checking root items
> [2/7] checking extents
> checksum verify failed on 547248750592 found E4E3BDB6 wanted 00000000
> checksum verify failed on 547248750592 found E4E3BDB6 wanted 00000000
> bad tree block 547248750592, bytenr mismatch, want=3D547248750592, have=
=3D0
> checksum verify failed on 547248766976 found 8E4EC148 wanted 00000000
> checksum verify failed on 547248766976 found 8E4EC148 wanted 00000000
> bad tree block 547248766976, bytenr mismatch, want=3D547248766976, have=
=3D0
> owner ref check failed [547248750592 16384]
> owner ref check failed [547248766976 16384]
> ERROR: errors found in extent allocation tree or chunk allocation

According to the owner ref check line, it's extent tree. So you have
some chance repair it.

Since it's non-critical, please try "btrfs check --init-extent-tree" to
see if it's working.

Thanks,
Qu

> [3/7] checking free space cache
> [4/7] checking fs roots
> [5/7] checking only csums items (without verifying data)
> checksum verify failed on 547248766976 found 8E4EC148 wanted 00000000
> checksum verify failed on 547248766976 found 8E4EC148 wanted 00000000
> bad tree block 547248766976, bytenr mismatch, want=3D547248766976, have=
=3D0
> Error going to next leaf -5
> [6/7] checking root refs
> [7/7] checking quota groups skipped (not enabled on this FS)
> found 247339167744 bytes used, error(s) found
> total csum bytes: 241066812
> total tree bytes: 434569216
> total fs tree bytes: 169771008
> total extent tree bytes: 16039936
> btree space waste bytes: 42891494
> file data blocks allocated: 270783406080
>  referenced 268366499840
>=20
>=20
>=20
> So any way to remove the damnaged data instead of restore/re-mkfs the
> still non-damaged one ?
>=20
> Thanks you!
>=20


--BNDRUpxe3aD0d8znFl8pDHU4Fphd2G9GU--

--vg3dwxhdHslQOs9vw8yI9enaEdVixP5GX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl2md8EACgkQwj2R86El
/qjj1QgAp5k6xPui5uaxpz6gXDml53F3Acn5wzcvhHMcrBtTtyq8QWvNuzAakDmF
I3JELhDhkx+yPoREpc84Lofm/IKJ644WHE4GRLPX+GODV6R5W95ueqSK6LqcPZAa
uUDqoPNyLJwK3dmfVu7garq2DVBWRiXx8kVOEz3TCG92w9DFmqKe5+033XzmkhKT
c5o8FOs9pT+Y9T7qpTbFWE4buxRg6XfBmf2erSVkrhlfk8EA1K3nJ75eadipi0SS
afRT5a0lqYBFp6E6ECv0Ntp5e3Uq77ELcHjyJli87zl85SKOb0or7KA8v9mmYi78
j69jICETIJbe9dOTiCuWeDtmqirc8Q==
=nOq4
-----END PGP SIGNATURE-----

--vg3dwxhdHslQOs9vw8yI9enaEdVixP5GX--
