Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B7D66123B75
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Dec 2019 01:20:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726072AbfLRAUh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 17 Dec 2019 19:20:37 -0500
Received: from mout.gmx.net ([212.227.15.15]:51277 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725940AbfLRAUh (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 17 Dec 2019 19:20:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1576628429;
        bh=anlZVTRTOvpR7xXsPzkN/l3ZezFKGFVpEu2iix0/mKc=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=JlF7WoWwC5G0shhA0Sb8fng1qlpfQy6ZMf5dgpNhoZ+fc0neZOijth01FDT74sGOa
         0PKL8vl0cYAVfJam54chvLxH2w/JpjJYxLKWBWaRP2/4eLbWYVUhdxoEjWpdQFpK84
         IzbU362XaG8JrK88+ag5mUIJpAv8l67NHUwWt2mc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MpUZ4-1htyNM2GdQ-00pup2; Wed, 18
 Dec 2019 01:20:29 +0100
Subject: Re: [PATCH] fstests: btrfs/14[01]: Use proper helper to get both
 devid and physical for corruption
To:     fdmanana@gmail.com, Qu Wenruo <wqu@suse.com>
Cc:     fstests <fstests@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
References: <20191212083123.25888-1-wqu@suse.com>
 <CAL3q7H5C+R3nPs-hW8k5pdFy9qDEVvD1UY+jNngZcmaDhcyr7w@mail.gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <9d1d3929-71d9-c309-19ca-6a987287f0ba@gmx.com>
Date:   Wed, 18 Dec 2019 08:20:24 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <CAL3q7H5C+R3nPs-hW8k5pdFy9qDEVvD1UY+jNngZcmaDhcyr7w@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="YtSjRFLsyWJ0oKog85PvqUbSLzYaao2UZ"
X-Provags-ID: V03:K1:+ER9c92SgEPJpQZk5cm/RWW6bKYZN9kovo4xl4hIYLOZgBv8b1E
 T9qfcdgVLLPhkPLjZTxuRdlL5qjYMonsdZ50GEOedw+l6FWF1Cnw0w00tVgaWlHx7wiG4FS
 6Y+im3xrAFIwdweq0bVPLvVr07DdERQfWwcmAkHAcx2jA/c+4kQeogqAO9qrJ7XGtVdcl7t
 5f0J4cOF61AfwxJwhanLA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:KF8I7u38CLI=:xucOvcr+GIP+0b+ilshqHd
 g+phspHXOv1lqKnBZAonjjs3n9zdoLGxnkTCU6OX6/echAyk9JC13qfLDt519M12PvNzmetT+
 w71BuQ7Azvj6URYcdgwDbIGuIjiHv/3UNiOkcwifBf6qf/3Jmx3XT7FrLCuFQWg3F0PeAt9eK
 9OKKk4aqHmWarJVwfx/ahWTKv+KFv9NbW2FsY2m284XYfPF2pwIbaVbWX1s+EzflS7hnj2MJ/
 xwcbHprT/365for+rszSLcbczxOABT9e0Ws+/Ol55pqw0MYl6RXyLWXqXtUMu8d4aSfg/ANPz
 gbawOreuNDt5nZCvPe8IZN0EagJtpWVxEmpFai5Tdrr0Wz+JkS4S+2pXRagho95cvN2t3U1jA
 wLYdoi2/DLmo9ijIqsQmtCIC8ldhQtowjemKk+CRk6z1VBZVy3YBvByGnCiozFtIpEag90P1B
 D8jb7NUggXvbRLXX1oGMewcmEAyTEhemtoi/GoA8pGZpCUly7g3NE/LR+y+nnK4epodHT8Ue8
 nv43uYZ74ymViC+2+SefQS+XMUwrAPXO6k0n7ElR4L3/GpkpeBQnS9Rz4EpkkKacEqaPKCw19
 BF8qrTwEp5tjkfn2lmYMhxltSNVLbZ0mAeYdV5quA6wug7TfkyV3KCB620O3MNfmZHGqhIxgo
 gkiNMyAYomn6gMfVPOu3qXL+krqcHdmw5dfpYaLavNA38cyW0xYhHTvy9aABtII7DARVQ4KxG
 KGCmXK+rsyptSkQkSHycP0FYa1Bb0m6UNhwIharXcl5CiRUMXcH1GwlRXPSca1VDcwiFX4ed2
 rPJtbYHGiJ5UH+Vmj46VCy28+T27dF1I3aNFNHWJq7W7r0Q1C0sQOVFY4uOn/uOwAN9TPW0SL
 a7g4m6r04wbcJdtXv9XB6PyfVw3ECXzzp9nHArUq7PUGmnbvYSU+mwCKPYj9z+tRq/oZSjo5E
 MwlHA8nS1yYQv0olwKJtwlQF8hzB9MU9wyEcP0NNVSqle5pePAhwYUb5pkwtCxySQHeUhX7LS
 HVvuzr/4disW1NRlac+jtHFV4ygVCb7qK7lWwDiiagQfx3QRsCeW34XRdk1brlmra/TYlZeGP
 RmueRcbLjEYngFID8XNzhDADhSV6SOzFF8i21BWhDLK3IBZpQrKs0jhG/3q7sWKrn2z3I7myB
 an1gcxIobAiVzneO8g8J0gfVNDT18gkKixY+ySvgJc9uiSYdD94KtR/JH7fYlAc1XKQxCCMLf
 Y5ehaSvScQSBgVePx22DE4b1nHkj4UtdIl8gEcP6o9qc4e86rYA3xTOLPWVM=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--YtSjRFLsyWJ0oKog85PvqUbSLzYaao2UZ
Content-Type: multipart/mixed; boundary="13CrFc9Df2qkNcUaQ35qxQK4H8EM0c7qJ"

--13CrFc9Df2qkNcUaQ35qxQK4H8EM0c7qJ
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/12/18 =E4=B8=8A=E5=8D=881:43, Filipe Manana wrote:
> On Thu, Dec 12, 2019 at 8:31 AM Qu Wenruo <wqu@suse.com> wrote:
>>
>> [BUG]
>> With btrfs-progs v5.4, btrfs/140 and btrfs/141 will fail.
>=20
> Oddly, it doesn't fail for me. Only 142, 143, 157 and 158.
>=20
> However this seems correct.
>=20
>>
>> [CAUSE]
>> Both tests are testing re-silvering of RAID1, thus they need to corrup=
t
>> on-disk data.
>>
>> This requires to do manual logical -> physical bytes mapping in the te=
st
>> case.
>> However the test case itself uses too many hard coded helper to grab
>> physical offset, which will change with mkfs.btrfs.
>>
>> [FIX]
>> Use more flex helper, to get both devid and physical for such
>=20
> more flex -> more flexible
>=20
>> corruption.
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>>  tests/btrfs/140     | 36 ++++++++++++++++++++++++++++--------
>>  tests/btrfs/140.out |  2 --
>>  tests/btrfs/141     | 33 ++++++++++++++++++++++++++-------
>>  tests/btrfs/141.out |  2 --
>>  4 files changed, 54 insertions(+), 19 deletions(-)
>>
>> diff --git a/tests/btrfs/140 b/tests/btrfs/140
>> index 1c5aa679..5c6de733 100755
>> --- a/tests/btrfs/140
>> +++ b/tests/btrfs/140
>> @@ -46,10 +46,26 @@ _require_odirect
>>
>>  get_physical()
>>  {
>> -       # $1 is logical address
>> -       # print chunk tree and find devid 2 which is $SCRATCH_DEV
>> -       $BTRFS_UTIL_PROG inspect-internal dump-tree -t 3 $SCRATCH_DEV =
| \
>> -       grep $1 -A 6 | awk '($1 ~ /stripe/ && $3 ~ /devid/ && $4 ~ /1/=
) { print $6 }'
>> +       local logical=3D$1
>> +       local stripe=3D$2
>> +        $BTRFS_UTIL_PROG inspect-internal dump-tree -t 3 $SCRATCH_DEV=
 | \
>> +               grep $logical -A 6 | \
>> +               awk "(\$1 ~ /stripe/ && \$3 ~ /devid/ && \$2 ~ /$strip=
e/) { print \$6 }"
>> +}
>=20
> Same as before, $AWK_PROG.
>=20
> These helpers seems the same as in 142 and 143 (and 141, updated later
> in this patch).
> I know this patch isn't introducing them, but we should move them into
> helpers at common/btrfs one day.

This is also recommended by Nikolay.

However there is a problem, mostly on the `grep` line.
- The target
  Some caller uses logical address like this, but some uses chunk type.
  This difference also affects the "-A" option, as logical matches the
chunk key, while
  the type matches the chunk type, causing a small difference in "-A"
number.

- The "-A" number for different chunk type
  The "-A" number depends mostly on the number of stripes.
  It needs to cover all stripes, while doesn't catch the stripes of the
next chunk.

  Currently we all use immediate number, as that number matches current
dump-tree
  output, but there is no guarantee for it at all as that dump-tree
output can also change.

  The best pattern should be something to only grab the first continuous
hunk of stripes.

But unfortunately I don't have enough experience in awk/grep, thus have
no choice but use the current immediate way, and not extracting them
into a generic helper.

Any advice would be highly appreciated.

Thanks,
Qu
>=20
> Thanks.
>=20
>> +
>> +get_devid()
>> +{
>> +       local logical=3D$1
>> +       local stripe=3D$2
>> +        $BTRFS_UTIL_PROG inspect-internal dump-tree -t 3 $SCRATCH_DEV=
 | \
>> +               grep $logical -A 6 | \
>> +               awk "(\$1 ~ /stripe/ && \$3 ~ /devid/ && \$2 ~ /$strip=
e/) { print \$4 }"
>> +}
>> +
>> +get_device_path()
>> +{
>> +       local devid=3D$1
>> +       echo "$SCRATCH_DEV_POOL" | awk "{print \$$devid}"
>>  }
>>
>>  _scratch_dev_pool_get 2
>> @@ -72,11 +88,15 @@ echo "step 2......corrupt file extent" >>$seqres.f=
ull
>>
>>  ${FILEFRAG_PROG} -v $SCRATCH_MNT/foobar >> $seqres.full
>>  logical_in_btrfs=3D`${FILEFRAG_PROG} -v $SCRATCH_MNT/foobar | _filter=
_filefrag | cut -d '#' -f 1`
>> -physical_on_scratch=3D`get_physical ${logical_in_btrfs}`
>> +physical=3D$(get_physical ${logical_in_btrfs} 1)
>> +devid=3D$(get_devid ${logical_in_btrfs} 1)
>> +devpath=3D$(get_device_path ${devid})
>>
>>  _scratch_unmount
>> -$XFS_IO_PROG -d -c "pwrite -S 0xbb -b 64K $physical_on_scratch 64K" $=
SCRATCH_DEV |\
>> -       _filter_xfs_io_offset
>> +
>> +echo " corrupt stripe #1, devid $devid devpath $devpath physical $phy=
sical" \
>> +       >> $seqres.full
>> +$XFS_IO_PROG -d -c "pwrite -S 0xbb -b 64K $physical 64K" $devpath > /=
dev/null
>>
>>  _scratch_mount
>>
>> @@ -96,7 +116,7 @@ done
>>  _scratch_unmount
>>
>>  # check if the repair works
>> -$XFS_IO_PROG -d -c "pread -v -b 512 $physical_on_scratch 512" $SCRATC=
H_DEV |\
>> +$XFS_IO_PROG -d -c "pread -v -b 512 $physical 512" $devpath |\
>>         _filter_xfs_io_offset
>>
>>  _scratch_dev_pool_put
>> diff --git a/tests/btrfs/140.out b/tests/btrfs/140.out
>> index f3fdf174..fb5aa108 100644
>> --- a/tests/btrfs/140.out
>> +++ b/tests/btrfs/140.out
>> @@ -1,8 +1,6 @@
>>  QA output created by 140
>>  wrote 131072/131072 bytes
>>  XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>> -wrote 65536/65536 bytes
>> -XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>>  XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  .........=
=2E......
>>  XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  .........=
=2E......
>>  XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  .........=
=2E......
>> diff --git a/tests/btrfs/141 b/tests/btrfs/141
>> index 186d18c8..2f5ad1a2 100755
>> --- a/tests/btrfs/141
>> +++ b/tests/btrfs/141
>> @@ -46,10 +46,26 @@ _require_command "$FILEFRAG_PROG" filefrag
>>
>>  get_physical()
>>  {
>> -        # $1 is logical address
>> -        # print chunk tree and find devid 2 which is $SCRATCH_DEV
>> +       local logical=3D$1
>> +       local stripe=3D$2
>>          $BTRFS_UTIL_PROG inspect-internal dump-tree -t 3 $SCRATCH_DEV=
 | \
>> -       grep $1 -A 6 | awk '($1 ~ /stripe/ && $3 ~ /devid/ && $4 ~ /1/=
) { print $6 }'
>> +               grep $logical -A 6 | \
>> +               awk "(\$1 ~ /stripe/ && \$3 ~ /devid/ && \$2 ~ /$strip=
e/) { print \$6 }"
>> +}
>> +
>> +get_devid()
>> +{
>> +       local logical=3D$1
>> +       local stripe=3D$2
>> +        $BTRFS_UTIL_PROG inspect-internal dump-tree -t 3 $SCRATCH_DEV=
 | \
>> +               grep $logical -A 6 | \
>> +               awk "(\$1 ~ /stripe/ && \$3 ~ /devid/ && \$2 ~ /$strip=
e/) { print \$4 }"
>> +}
>> +
>> +get_device_path()
>> +{
>> +       local devid=3D$1
>> +       echo "$SCRATCH_DEV_POOL" | awk "{print \$$devid}"
>>  }
>>
>>  _scratch_dev_pool_get 2
>> @@ -72,11 +88,14 @@ echo "step 2......corrupt file extent" >>$seqres.f=
ull
>>
>>  ${FILEFRAG_PROG} -v $SCRATCH_MNT/foobar >> $seqres.full
>>  logical_in_btrfs=3D`${FILEFRAG_PROG} -v $SCRATCH_MNT/foobar | _filter=
_filefrag | cut -d '#' -f 1`
>> -physical_on_scratch=3D`get_physical ${logical_in_btrfs}`
>> +physical=3D$(get_physical ${logical_in_btrfs} 1)
>> +devid=3D$(get_devid ${logical_in_btrfs} 1)
>> +devpath=3D$(get_device_path ${devid})
>>
>>  _scratch_unmount
>> -$XFS_IO_PROG -d -c "pwrite -S 0xbb -b 64K $physical_on_scratch 64K" $=
SCRATCH_DEV |\
>> -       _filter_xfs_io_offset
>> +echo " corrupt stripe #1, devid $devid devpath $devpath physical $phy=
sical" \
>> +       >> $seqres.full
>> +$XFS_IO_PROG -d -c "pwrite -S 0xbb -b 64K $physical 64K" $devpath > /=
dev/null
>>
>>  _scratch_mount
>>
>> @@ -97,7 +116,7 @@ done
>>  _scratch_unmount
>>
>>  # check if the repair works
>> -$XFS_IO_PROG -c "pread -v -b 512 $physical_on_scratch 512" $SCRATCH_D=
EV |\
>> +$XFS_IO_PROG -c "pread -v -b 512 $physical 512" $devpath |\
>>         _filter_xfs_io_offset
>>
>>  _scratch_dev_pool_put
>> diff --git a/tests/btrfs/141.out b/tests/btrfs/141.out
>> index 116f98a2..4b8be189 100644
>> --- a/tests/btrfs/141.out
>> +++ b/tests/btrfs/141.out
>> @@ -1,8 +1,6 @@
>>  QA output created by 141
>>  wrote 131072/131072 bytes
>>  XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>> -wrote 65536/65536 bytes
>> -XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>>  XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  .........=
=2E......
>>  XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  .........=
=2E......
>>  XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  .........=
=2E......
>> --
>> 2.23.0
>>
>=20
>=20


--13CrFc9Df2qkNcUaQ35qxQK4H8EM0c7qJ--

--YtSjRFLsyWJ0oKog85PvqUbSLzYaao2UZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFLBAEBCAA1FiEELd9y5aWlW6idqkLhwj2R86El/qgFAl35cMgXHHF1d2VucnVv
LmJ0cmZzQGdteC5jb20ACgkQwj2R86El/qi8GQf+P4tyMymsCyEcwboRxUz65fkq
kZOlsKsyWvH35HN9429KJ3qYdsmHS7rTy5qXgb8cSntXtJ2jS+Qn5A6w6lHJoB25
49eugurH7QQQyjIwIS9IRcq43W9yK2o6GZR+HppK/QA5fWCCPacOEU6k4lhLQOam
SLm31lqKqS+k22Y/sSmv4NKSpevVGWXysvqu8t2BATf/yruhiXGPmpy0xWXyyI4t
Ns0dqcHC7PSc+lnDTNmEnXaB9K04c5taPc+1aLjGe++4pR83A7/X0OoUolc4cnCN
HbENILjEWK1wL/zEoBubGOMaF3mDHuog8bLNJZHqJcnKoBnchw0TciJeOFyWGw==
=7kEM
-----END PGP SIGNATURE-----

--YtSjRFLsyWJ0oKog85PvqUbSLzYaao2UZ--
