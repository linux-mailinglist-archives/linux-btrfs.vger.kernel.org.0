Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88FAB277CF7
	for <lists+linux-btrfs@lfdr.de>; Fri, 25 Sep 2020 02:34:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726826AbgIYAek (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 24 Sep 2020 20:34:40 -0400
Received: from mout.gmx.net ([212.227.15.15]:44227 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726631AbgIYAej (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 24 Sep 2020 20:34:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1600994075;
        bh=3eCb0dfVlKZtPWD/VZwtfvHxI7xaF72hPtt3G5jWavo=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=CK/3eY6OODynZlyAws+MuLfBUVmjbSQZK2dpURPp0i2pujHRTADc7sg1y0ibKtLrl
         W9I64ihWHEGRcf8xkAZ/SeS166PcNxiz6LJBiJadiju0DhDlozmlbKlZdiM63+O7vw
         9fnfbfbDeVgWlafoSpjjkRf/HYnsT1Q+D3bdTKg8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MeU0k-1ktqaE1V8W-00aZF6; Fri, 25
 Sep 2020 02:34:35 +0200
Subject: Re: [PATCH 0/5] New rescue mount options
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1600961206.git.josef@toxicpanda.com>
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
Message-ID: <3530c799-992b-d6f1-d40a-f855b3fe8be7@gmx.com>
Date:   Fri, 25 Sep 2020 08:34:31 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <cover.1600961206.git.josef@toxicpanda.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="DAHE50sU0GAxgbJPF0oR0TzIleR6EtnFS"
X-Provags-ID: V03:K1:6FQQq+Ny9ywPPeNsNlrFlvtVWSDu1jAbhoD5DD0dqT+KQzj4Mp/
 I4Q9wEMvt0BT7ZLNLSXvMWDdXXDR/Xn+zqe5Sg0dgV8Kc33xw36mt8f0ycm4HsnHOwV/Q/j
 Z8cnrjwoVyTiI7T9lZE5Opuhv7x2HRLHIpan9I6iAjYBDPjaiP3I2I85siIXCsSQ3Mg4buS
 NSq70/3I5dIJhuQVse3/w==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:7nwpLnCr3bU=:bHxKgkWXTKBUgoOCv35Zpn
 owl/tXfpRtUIMwUHvhhJ2mDlWF7y4L4SaBvt/o0XWqkhd7p+O1X40Dz0Qm31C5ISGSj90T14G
 /kJZrM0FKqlBpGXS1RZKNY7DkqcKaIQZxTrABzjoe29j3d0GA+yFLpbSs+PdJ1lp80DsI+nfb
 TWuvHDMK8j0fEzkVU/b9Vcyp1zhgCiAHnW1DBE3z9OiaO5QFkstXh8zzO6nyTWHtlqbQlssV9
 iIXdHtu7U34RiPgCSC9g8R6P1iMmqVnHI/LVYrCCTWJplXtwEPHZhIpfG/qzYRPFcD6UrRg1b
 zcEDjI/SSSAU4myN0CCpO+10TOJJp/62AKbsi5a+QFIvcyBqpcrxgV/r+UPMvKqmepKeEpnys
 kwwDh5nvLUihxeyF9r02HIa+CHy/qrj/MTofQdc/jmpVUjkIuHewkd9uuxI9XgrVvRFF1Awec
 G8q6gN2yxLwk5N5RDxPspCskyYtQa1gUdr7jIEY/vXg/EBUorf90wtWRYJw/BXnMWTDGauOOP
 c194t8ZzlCMdmMVdaaSxekteCX4vZW8A+N9E8m92fU1cIqfLZNyfm6fg7lrFD1FzgqFEeSZFm
 4U+uLN096tqWprjeOT2QGU9qvF7y5ZfTBhzT2Rqym+a7k2gi8vz6ZzBtyOA9EPUiI5IJYy4zO
 emIINMvFNqE4mKT0slW8AOlZAJ/aAf4y9b30nvVUz9A7JRRpTIdD4JDH4opQ2MQ/PjD9Jhy3e
 wpihLlGApTxQWqwXnjloCpWc/hPtZh9wGckZihjPWP/Wk2OFDZTR/+5zRyoIZNbCj09bse4P8
 8YwFSfW2ztGuSPa6OMldAJ/cNCtkBRx2nOkUnbIIJygvXo0kmrhijagTqEt3ixPrTkTVk1Z9A
 8sovUd8pzBH17FYemthWnfm5S+xsng0RR3hUHCwrAKt/al5ctxmWiRFncWoFEdkZeKri1jL4c
 SYzd1YRfdGxqe1hqcO9xLjNIbID4YL9cOqvEX+ZndXprpu/SXXZ1xR01ppgGIFLrZHHoHkklu
 o0zbJuWMSUC6QO6oH8goEOROd+tFicQ4U9laCmD6sY3UHNnNE4iSetY8XfxBthDaBhTSdppzx
 hYkNY0w3bX3Sp+WosJL6oO9P7re+2ZIhh5MvPNgaoAmFHFoLsnk3uRPuHwDUotP7VZsMWzwsx
 AvcPpYrMUySmiqagUTRdrRLYAQ8/Mgzc+mLROS1P2X9EqD3LkwjLkO7T4fhsOF8RCNWfd0y28
 nMBZrCJl+uirHfwPi7x5jJOm69s6/ZQekdtRE0A==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--DAHE50sU0GAxgbJPF0oR0TzIleR6EtnFS
Content-Type: multipart/mixed; boundary="LOctzHlekc9PAaw5mlUk4a7qDZ8d5ecNk"

--LOctzHlekc9PAaw5mlUk4a7qDZ8d5ecNk
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/9/24 =E4=B8=8B=E5=8D=8811:32, Josef Bacik wrote:
> Hello,
>=20
> This is the next version of my rescue=3Dall patches, this time broken u=
p in to a
> few discrete patches, with some cleanups as well.  I have a PR for the =
xfstest
> that exercises these options, it can be found here
>=20
>   https://github.com/btrfs/fstests/pull/35
>=20
> This is the same idea as the previous versions, except I've made a mech=
anical
> change.  Instead we have rescue=3Dignorebadroots, which ignores any glo=
bal roots
> that we may not be able to read.  We will still fail to mount if thinks=
 like the
> chunk root or the tree root are corrupt, but this will allow us to moun=
t read
> only if the extent root or csum root are completely hosed.
>=20
> I've added a new patch this go around, rescue=3Dignoredatacsums.  Someb=
ody had
> indicated that they would prefer that the original rescue=3Dall allowed=
 us to
> continue to read csums if the root was still intact.  In order to handl=
e that
> usecase that's what you get with rescue=3Dignorebadroots, however if yo=
ur csum
> tree is corrupt in the middle of the tree you could still end up with p=
roblems.
> Thus we have rescue=3Dignoredatacsums which will completely disable the=
 csum tree
> as well.

The extra hard ignore for data csum is really good.

>=20
> And finally we have rescue=3Dall, which simply enables ignoredatacsums,=

> ignorebadroots, and notreelogreplay.  We need an easy catch-all option =
for
> distros to fallback on to get users the highest probability of being ab=
le to
> recover their data, so we will use rescue=3Dall to turn on all the fanc=
iest rescue
> options that we have, and then use the discrete options for more fine g=
rained
> recovery.  Thanks,

Now rescue=3Dall makes more sense. It's just an alias for one to salvage
as much data as possible.

Thanks,
Qu
>=20
> Josef
>=20
> Josef Bacik (5):
>   btrfs: unify the ro checking for mount options
>   btrfs: push the NODATASUM check into btrfs_lookup_bio_sums
>   btrfs: introduce rescue=3Dignorebadroots
>   btrfs: introduce rescue=3Dignoredatacsums
>   btrfs: introduce rescue=3Dall
>=20
>  fs/btrfs/block-group.c | 48 +++++++++++++++++++++++++++
>  fs/btrfs/block-rsv.c   |  8 +++++
>  fs/btrfs/compression.c | 17 ++++------
>  fs/btrfs/ctree.h       |  2 ++
>  fs/btrfs/disk-io.c     | 74 +++++++++++++++++++++++++++---------------=

>  fs/btrfs/file-item.c   |  4 +++
>  fs/btrfs/inode.c       | 18 +++++++---
>  fs/btrfs/super.c       | 49 ++++++++++++++++++++++++----
>  fs/btrfs/volumes.c     |  7 ++++
>  9 files changed, 179 insertions(+), 48 deletions(-)
>=20


--LOctzHlekc9PAaw5mlUk4a7qDZ8d5ecNk--

--DAHE50sU0GAxgbJPF0oR0TzIleR6EtnFS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl9tOxcACgkQwj2R86El
/qhw+wf/X+88O97WfPRj1NOu/UnGvl/lYzgkol8YGKVoFoBZasZYjrkYqdoeUIrU
XJI4oBdGTvzuNN3Y3kbrbuijD41nchZ9rg4OSLXt/lZFclh/KUx2kEFeCrj3nwRi
b2YDF/kq2LGoW+s+B9OBicP/ImmJg94VYqlooZJnTCjoCTqEyS+ezQUJveV3Q6aT
N2pewbq3R/Z1j9J9Une4qbXbFMBqgAzPNEC0dU6yaNPQ1rwN55B3r4ASsT5sz3xl
HXvSbBg9FjI4jqaHOAtUBkaK3HMmv1Meo94CTWFf+UJ0vRwAgn89jH5/1ua6MiQV
VMA02IK56cyORTqUwEQzfMJAo0EPiw==
=HHM8
-----END PGP SIGNATURE-----

--DAHE50sU0GAxgbJPF0oR0TzIleR6EtnFS--
