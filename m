Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2B2BE131CFC
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Jan 2020 02:03:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727462AbgAGBDr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 6 Jan 2020 20:03:47 -0500
Received: from mout.gmx.net ([212.227.15.19]:42245 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727295AbgAGBDr (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 6 Jan 2020 20:03:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1578359019;
        bh=WNAKdfiT72SMy0j6SbmBT0u0v1tr9cXZ+dRRqm2b7YE=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=ilqXWmS4T8i2/5KcD/6bWad/ddB9ygsccklbyux+fbjUmZSFUDi9kdlFDv5sWmyTf
         xLe73ZCsP2av/C3XLgBeEqpsIFlBLyB+aNM3wVL/4PNuXZ++VXYqiEbRteXriy//zX
         OtkMZObKWur3YUnFIDFxbAsKy5i4P9460DfORFGU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1Mnpns-1jTkie1qva-00pNTu; Tue, 07
 Jan 2020 02:03:39 +0100
Subject: Re: [PATCH v3 3/3] btrfs: statfs: Use virtual chunk allocation to
 calculation available data space
To:     Josef Bacik <josef@toxicpanda.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20200106061343.18772-1-wqu@suse.com>
 <20200106061343.18772-4-wqu@suse.com>
 <1c9b3644-4b77-a7c8-c47d-19743cad7f06@toxicpanda.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <1ae46229-4162-2942-4923-f7fef091efdf@gmx.com>
Date:   Tue, 7 Jan 2020 09:03:33 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <1c9b3644-4b77-a7c8-c47d-19743cad7f06@toxicpanda.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="s5h8OKjYzWkVvQEw85VfB1qx1FyOV0fVu"
X-Provags-ID: V03:K1:txAVGddjDdqjsE+o/rWSlRSBVHhLbJYU8ld06pQsJC+ZS+h5WtV
 achHnorn9xv56tTkQk9/5lzJIzL5hp2vCP5+wZxjVG3HYRi59GKkeRri5B8fCmGeRBWARKA
 uyXQZU+2Fg4FJy5/1i208lIUff4pNcxteT2fExVL5pxbQvwSGgewbAVp9/J8PGDsASjXwI5
 fQxdqpP6/gy3QL5CTBxZw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:2X6QXpzIDi0=:nMkrmTOv/3HwsiJCGEtZ9t
 4mzgix6469GjQO/LZdogrqkUGSwYkTN5GRVXxEiBaJ27aUk2WKB0PyE6rKthjneHhJrXE4cza
 deHeYoTf/VMbeFMUVb12Ac19T9JoMBbK6i/wQtz5dEUTKFokpCKGwbmk/8+TeHLt3aXTWjxns
 8R7mbUw2H5s3p6ltj+GWGTM5apI3AvU6BDZLVQev93dNO8QziERPo8K0adkUT1qJgK1MfPQuI
 8CER1SAI6BLt79iayUHkJEBVdD6dhGOzq1cEY/U8hArcStzRdEfC838ZIV9nyYvSGgtl5LIy9
 4vXtyvfvstkc1WMgBAEl/RNvdrhkBRCDmCZoBYuZbLi072lOdlXNa49btcJMIyywKzzls/QAs
 LBP+Nh9nEMkDJin1uJJdRoe6z40UX4YwXG4Btzp3haBPV1VV3xPhnmyRZ5GToZxMw9oq7zkqk
 bYcUPIlVz6FHmH39V0Tzx8f/7dkbTlmiTgFq0PEUSC+h5M6p9DIG2H8+XhuIv8Ag3LXFa8kfW
 aGqjN7fVzAM/3QUWwA1WmqSCMGdcCOW9zy+gTvyXiINLFwz49kHmT5/aPkHhLPId4IZh9tQdA
 f8kB5abQ0XAyvgVnVL0pegzz0kcZG/inBAqEoADXc6JvKSAMTiwfIF+wcGmGPDPxrjBb2sUFX
 oGC0rRw2kmZ+o7wz6f9NZA3MUX/I1zGVbprxeosNJzJSO2QsKLfr/Tj81Uu7OFCLpbcca6He6
 Dhz6oKT7innKVRv/FbON/PamWMGpY0WRFRp1kGdQT8ajB98N1bgv0klwbVRPO0p5XiIiOyccn
 SPK7y3wX7EkNfBFcJKsLt7etSZykpo7L7je8Q3I8LHvk99Zl7YKsK50YZoejzQszLuzseKyaF
 /y5NEwPRCdIAj2Zzv02wSVWTMmyOAoPqYx3IAe0IJqLKu54aOiH2ZGTAkijpM4rAI5FsJ3/75
 kdbKbhGbGTIWZceMwZUD+Autwr4OAFW2syjKeQM5yl4Lj40SzOkaPNo0qdZfx7fuD1YX+2LBS
 agZ2nfDqtT0S1gP0GcTvU/nX50iUg+6mm0vp3U5FTNKArQFXF/437YAqiOTnMxWmwnq2eGulw
 n75jC5Y2gwxKj5cOtYWWxb+sb5llcyX7w/RlXs88OeeT5Ka9mgzbuyCFYIaUhLeXRM7/8S0mn
 y11qre1BjokoUwYpMkmLIMHlXYtMRXQUja+DxFeMRnKUMY3emLmhLbYW+8j3r1tetJ5oUAa33
 AEyEhHKf/bGU1lmD0IYa2L1I7YLTh8rKzy9A+OltC4+eyW3TgO9cYhOS9w8g=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--s5h8OKjYzWkVvQEw85VfB1qx1FyOV0fVu
Content-Type: multipart/mixed; boundary="GbjpwVfPhruOo7Jmm1wQScKQ6NcEyTnB3"

--GbjpwVfPhruOo7Jmm1wQScKQ6NcEyTnB3
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/1/6 =E4=B8=8B=E5=8D=8810:44, Josef Bacik wrote:
> On 1/6/20 1:13 AM, Qu Wenruo wrote:
>> Although btrfs_calc_avail_data_space() is trying to do an estimation
>> on how many data chunks it can allocate, the estimation is far from
>> perfect:
>>
>> - Metadata over-commit is not considered at all
>> - Chunk allocation doesn't take RAID5/6 into consideration
>>
>> Although current per-profile available space itself is not able to
>> handle metadata over-commit itself, the virtual chunk infrastructure c=
an
>> be re-used to address above problems.
>>
>> This patch will change btrfs_calc_avail_data_space() to do the followi=
ng
>> things:
>> - Do metadata virtual chunk allocation first
>> =C2=A0=C2=A0 This is to address the over-commit behavior.
>> =C2=A0=C2=A0 If current metadata chunks have enough free space, we can=
 completely
>> =C2=A0=C2=A0 skip this step.
>>
>> - Allocate data virtual chunks as many as possible
>> =C2=A0=C2=A0 Just like what we did in per-profile available space esti=
mation.
>> =C2=A0=C2=A0 Here we only need to calculate one profile, since statfs(=
) call is
>> =C2=A0=C2=A0 a relative cold path.
>>
>> Now statfs() should be able to report near perfect estimation on
>> available data space, and can handle RAID5/6 better.
>>
>> [BENCHMARK]
>> For the performance difference, here is the benchmark:
>> =C2=A0 Disk layout:
>> =C2=A0 - devid 1:=C2=A0=C2=A0=C2=A0 1G
>> =C2=A0 - devid 2:=C2=A0=C2=A0=C2=A0 2G
>> =C2=A0 - devid 3:=C2=A0=C2=A0=C2=A0 3G
>> =C2=A0 - devid 4:=C2=A0=C2=A0=C2=A0 4G
>> =C2=A0 - devid 5:=C2=A0=C2=A0=C2=A0 5G
>> =C2=A0 metadata:=C2=A0=C2=A0=C2=A0 RAID1
>> =C2=A0 data:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 RAID5
>>
>> =C2=A0 This layout should be the worst case for RAID5, as it can
>> =C2=A0 from 5 disks raid5 to 2 disks raid 5 with unusable space.
>>
>> =C2=A0 Then use ftrace to trace the execution time of btrfs_statfs() a=
fter
>> =C2=A0 allocating 1G data chunk. Both have 12 samples.
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 avg=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 std
>> =C2=A0 Patched:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 17.59 us=C2=A0=C2=A0=C2=A0 7.04
>> =C2=A0 WIthout patch (v5.5-rc2):=C2=A0=C2=A0=C2=A0 14.98 us=C2=A0=C2=A0=
=C2=A0 6.16
>>
>> When the fs is cold, there is a small performance for this particular
>> case, as we need to do several more iterations to calculate correct
>> RAID5 data space.
>> But it's still pretty good, and won't block chunk allocator for any
>> observable time.
>>
>> When the fs is hot, the performance bottleneck is the chunk_mutex, whe=
re
>> the most common and longest holder would be __btrfs_chunk_alloc().
>> In that case, we may sleep much longer as __btrfs_chunk_alloc() can
>> trigger IO.
>>
>> Since the new implementation is not observable slower than the old one=
,
>> and won't cause meaningful delay for chunk allocator, it should be mor=
e
>> or less OK.
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>=20
> Sorry I should have been more specific.=C2=A0 Taking the chunk_mutex he=
re
> means all the people running statfs at the same time are going to be
> serialized.=C2=A0 Can we just do what overcommit does and take the alre=
ady
> calculated free space instead of doing the calculation again?=C2=A0 Tha=
nks,

If we want to take metadata over-commit into consideration, then we can't=
=2E

E.g. if we have only 256M metadata chunk, but over-commit to reserve 1G
metadata space.
We should take that 768M into metadata profile allocation before we do
data allocation.

And since metadata can have completely different profile, we have to go
this complex calculation again.

Thanks,
Qu

>=20
> Josef


--GbjpwVfPhruOo7Jmm1wQScKQ6NcEyTnB3--

--s5h8OKjYzWkVvQEw85VfB1qx1FyOV0fVu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFLBAEBCAA1FiEELd9y5aWlW6idqkLhwj2R86El/qgFAl4T2OUXHHF1d2VucnVv
LmJ0cmZzQGdteC5jb20ACgkQwj2R86El/qhCKQf/aAPaQNXnHLgA38erRupGCzOl
bAalFzj2oLbVAtScJoqC5kJ0YQckJDiFbHcjGNuZWr1oDvvb0PlBG2+r3K7mcgjc
YT/16DHSGdJoTWdX44pPIUNBz/6Hprg0uf+mDMTdBng+hXEFPUJYrMuumXtlH+Jl
joRk7O/apqBtpmmRHQRtSnIZ8XXtFpNdY2CK4uhzws3oh0FcPJa4RXLRTeb95DjJ
FxNM61z3lV53sNPzsv/g5puGi2i6eL+8JtDN2tG8NeWIrzyJwCZhdZbWEk0F/ijI
S6ZtIXf/FKF4rePic2/JJiB6wx865CT8upWpRMVgDDduK2KkATdvwUjxwkQWJg==
=Ny0d
-----END PGP SIGNATURE-----

--s5h8OKjYzWkVvQEw85VfB1qx1FyOV0fVu--
