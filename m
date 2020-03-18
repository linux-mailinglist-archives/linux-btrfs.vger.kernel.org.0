Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8E518189669
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Mar 2020 09:00:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726553AbgCRIAm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 18 Mar 2020 04:00:42 -0400
Received: from mout.gmx.net ([212.227.15.19]:43495 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726513AbgCRIAm (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 18 Mar 2020 04:00:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1584518439;
        bh=fHeltzmR8s7UVecZjca6ZxDUgHdyZp59uXPLz/fb6hA=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=T/LQj6eSXM4NCK3g/iIUy3DBbT02bYAXFita8Z7JjXrD3ZlN7NdADCRkJnM9sLyaX
         XaLcBo6TKoxFN+fVW5a7k+RGL8NdLjUMaJFvIZiDnW+ExgeTlzngb2GDX/lElpYD79
         jwESjP0up44TeRDTOHuYyAfn8xRqXBiejQFSNmco=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1M9Wys-1jB9iE2hd6-005Z8n; Wed, 18
 Mar 2020 09:00:39 +0100
Subject: Re: failed to read block groups: -5; open_ctree failed
To:     Liwei <xieliwei@gmail.com>, linux-btrfs@vger.kernel.org
References: <CAPE0SYyr3sSmPn+f+ZnZuPTTSQdR=vC3JA33B9ctc2o19hHnTQ@mail.gmail.com>
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
Message-ID: <f6cf0b91-141c-cb43-b7ed-6376566baec8@gmx.com>
Date:   Wed, 18 Mar 2020 16:00:35 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CAPE0SYyr3sSmPn+f+ZnZuPTTSQdR=vC3JA33B9ctc2o19hHnTQ@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="S1sQOYTH2lY82F9xfDwpEQccbX1Gb4U13"
X-Provags-ID: V03:K1:BIV/VMiQOWw09SdFHbqm6uOJJvUrsyqSR1IYL27mMJu4pVyn6Wv
 1nbKpGjT0ys9KzZh9J78cmhj39EB38aoZ8oyJP8xGROdZfSJYqN2UyrXTG3IWb4xcPCbFJ3
 64Bdk1Oyv0s0eB7KmCA3ktYLP+ElstienDO2k+NYlIOS7L9bGecyRjLNrAEkihS8RQDr4mr
 akdWllsYBEYj4ZfOtLjRg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:KKUMl9bedXo=:FQmEjPJhwvHo6iD1vteGic
 vU4hxtzc1dDofQW3J54kzx9gxZOeFeSenfK2Sy1ROOR3QNCSB/2ENrQ8i6dOtP5E6xP4regEk
 8+2814ZfouZzMoHrHsqekmyAik0Or5fk6RMs/KQmu4tvs5EjN6NJph5RQbUjXd5kuTQy7S/Ap
 cqsTPhCvDSAAX3FbD0yrwGTG/5fhfw7+xRvbpNXnLFD/ZMM2pJFAgc6pkFR6cj5DN/p3kE7/C
 9arvHpRtvQw/Is7ys35862G2mQd4JU3GTepsnxc98fFOk8zFiUW7tHDXgqowr52IOMFWVBC8M
 mFn6/E5KKQUL9eAACTSBCKEQZYvKpjuylI/ymY6jvpJ0fhCgA7p2kbgwlnmYHjRuVcMaeyLd6
 YB1KND1njoqO/JCc34UBUE9SjnO7XyLhGB+FGbfcJDQNfZnD2nibA5zG++iB+5uvBzCVjW+2F
 d7Mj4asjO+VdVX9jp7JBfZWxHCJFxmEKY6fQ1r+JbOuU1GdZAdouJ6cniq9h+cDQiDpYY7D7o
 /kLxI0L9YV12iLWTLR3bpCYRA29OhbWpyZfDl510X86HpAOEuluyIbotuVUKOkZq6nwx8/4zL
 271gigJGy2293QCjDC2PQk17opUXqDRNdltwQ6ttt14HPuijQnocIu609sSkOudCY3hYq73Fa
 UycyUf1RS+805vPkqydq7w1CvB1P57XNTwlr8xJMDywTub+vYtquC35zYsXTm4bUR2ZWJhsHp
 ut1QVaaEx8TiH8dC2fnCkOv09HrR3Sm6fZxU3heiF4t+WriwvXpL8oqgC/sCLScm6nTI4loZE
 N8I9r+Rmxes5gL9mj/4QKOhWOQ8ZYTy/bTMeBx8/W6kb4qO2Qciq83Oz2HchFS8fTFYuCxTQ4
 PjtE2w+xJo/MvO7uUSID8+LVz/IXgv7gaZUn8fZGPAh5JaLNx+qhIPTchsT3D5yqw9ScOAxmt
 agqMK1qnkXi1AL5Di3oECfowggfeaMcB6KZlemh68e0x6Uy9W3ZcWe8gcqRPdmkg+JYYEJsGY
 LfkjkAqizI75HiyxpOKyOiCWVSYexjh2CjoHhQOyyxb0XMb7Zm9PNfKSbGfFMfJ8Jgjfg6Yp5
 fVVgHgkiqaISkOasryAt5NR3PphtuW5j2jPXaZ+i2KZimulnWB0eyHDOaTJE5UWaO7f/Ee+pZ
 BGTw2SbHSwzlkYPjpLo8RB9yE6zcPxoFziTpMT0w9P2C23lGcgRE7r9c5E+WMl3orP9oVFoMU
 TKleKwb3n22sSlc7F
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--S1sQOYTH2lY82F9xfDwpEQccbX1Gb4U13
Content-Type: multipart/mixed; boundary="BOtPw5VDw8zabHio2G0pQTOr57Jwf8kML"

--BOtPw5VDw8zabHio2G0pQTOr57Jwf8kML
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/3/18 =E4=B8=8A=E5=8D=8810:26, Liwei wrote:
> Hi list,
> I'm getting the following log while trying to mount my filesystem:
> [   23.403026] BTRFS: device label dstore devid 1 transid 1288839 /dev/=
dm-8
> [   23.491459] BTRFS info (device dm-8): enabling auto defrag
> [   23.491461] BTRFS info (device dm-8): disk space caching is enabled
> [   23.717506] BTRFS info (device dm-8): bdev /dev/mapper/vg- dstore
> errs: wr 0, rd 728, flush 0, corrupt 16, gen 0
> [   32.108724] BTRFS error (device dm-8): bad tree block start, want
> 39854304329728 have 0
> [   32.110570] BTRFS error (device dm-8): bad tree block start, want
> 39854304329728 have 0
> [   32.112030] BTRFS error (device dm-8): failed to read block groups: =
-5
> [   32.273712] BTRFS error (device dm-8): open_ctree failed

Extent tree corruption.

And it's not some small problem, but data loss.
The on-disk data is completely wiped (all 0).

>=20
> A check gives me:
> #btrfs check /dev/mapper/recovery
> Opening filesystem to check...
> checksum verify failed on 39854304329728 found E4E3BDB6 wanted 00000000=

> checksum verify failed on 39854304329728 found E4E3BDB6 wanted 00000000=

> checksum verify failed on 39854304329728 found E4E3BDB6 wanted 00000000=

> checksum verify failed on 39854304329728 found E4E3BDB6 wanted 00000000=

> bad tree block 39854304329728, bytenr mismatch, want=3D39854304329728, =
have=3D0
> ERROR: cannot open file system
>=20
> The same thing happens with the other superblocks, all superblocks are
> not corrupted.

Super blocks is only in 4K size, you won't expect that could contain all
your metadata, right?

>=20
> The reason this happened is a controller failure occurred while trying
> to expand the underlying raid6 causing some pretty nasty drive
> dropouts. Looking through older generations of tree roots, I'm getting
> the same zeroed node at 39854304329728.
>=20
> It seems like at some point md messed up recovering from the
> controller failure (or rather I did) and it seems like I am getting a
> lot of zeroed-out/corrupted areas?

Yes, that's exactly the case.

> Can someone confirm if that is the
> case or if it is just some weird state the filesystem is in?
>=20
> I'm not hung up about hosing the filesystem as we have a complete
> backup before doing the raid expansion, but it'd be great if I can
> avoid restoring as that will take a very long time.

Since part of your on-disk data/metadata is wiped, I don't believe the
wiped metadata is only limited in extent tree.

But if you're really lucky, and the wiped range is only in extent tree,
btrfs-restore would be able to restore most of your data.

Thanks,
Qu

>=20
> Other obligatory information:
> # uname -a
> Linux dstore-1 4.19.0-4-amd64 #1 SMP Debian 4.19.28-2 (2019-03-15)
> x86_64 GNU/Linux
> # btrfs --version
> btrfs-progs v4.20.1
>=20
> Thank you very much!
> Liwei
>=20


--BOtPw5VDw8zabHio2G0pQTOr57Jwf8kML--

--S1sQOYTH2lY82F9xfDwpEQccbX1Gb4U13
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl5x1SMACgkQwj2R86El
/qjFagf/QeiXn7FVNIWnZd4nqt9RCWq3di3LoyLsa40iVAK+hQ6Dex0k4LimC4H8
Suenuq2Czi1tXSlKLF3vEWZ53Kael+0oxBlrHJqiwcep847IOv0qnBeY3ZNnCT7i
63NG3gkZEegHH5RKINsV7R7G2UORhDq7vVvxqawIRK0jiteCycovEbZ2yxdfcr3r
WRKHIj8ZgV+BKgxfLa7lJTb4jcLY27mbjmKt2EQg7u/J/kKUpV/woWWYXdSofuic
h5RZJHd4+52Qn9O3cPyW9zVEqphMx6g8oxYrdMitWixk8md11IIVLJmjUrWCXm1x
Awi+vT0aFge/gqjzJX7v0fM2fEh7xg==
=LM69
-----END PGP SIGNATURE-----

--S1sQOYTH2lY82F9xfDwpEQccbX1Gb4U13--
