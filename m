Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8FC24117CB5
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Dec 2019 01:54:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727329AbfLJAwk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 9 Dec 2019 19:52:40 -0500
Received: from mout.gmx.net ([212.227.15.18]:48371 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727304AbfLJAwk (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 9 Dec 2019 19:52:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1575939158;
        bh=dvRuAFAzM2Gs7nQuDERED4ZPNHrG3VF2fP25XM45PrY=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=Bf1Tal++T+ikeBMr6WuoE6zZT2MX2PPKJGeRQGXanRQcHLfqRVJOJygphi2pjXWva
         0hBjQTsTaaJ9dIj1JuLhFi6CvlTCx25xrkAAnntpb3glFUurQyZabw9Mhy1RswhcJf
         rq+v2prZROHakp15t95J4W8r+8k6057Nw9JJNXfQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([13.231.109.76]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MCKBc-1iV6750VNK-009QWq; Tue, 10
 Dec 2019 01:52:37 +0100
Subject: Re: df shows no available space in 5.4.1
To:     Martin Raiber <martin@urbackup.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <0102016edd1b0184-848d9b6d-6b80-4ce3-8428-e472a224e554-000000@eu-west-1.amazonses.com>
 <784074e1-667a-a2c7-5b47-7cbe36f5fdf5@gmx.com>
 <0102016eec056406-8dc0180d-5a2d-44e8-9ae2-f02573e62203-000000@eu-west-1.amazonses.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <b0501a9b-34da-e69b-a06b-1946f7917269@gmx.com>
Date:   Tue, 10 Dec 2019 08:52:33 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <0102016eec056406-8dc0180d-5a2d-44e8-9ae2-f02573e62203-000000@eu-west-1.amazonses.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="hdkp3nYwrIDAMqD7brdwpsik9GjyPwQMt"
X-Provags-ID: V03:K1:CKaHwZBN1y5coiozSsEX2fThgsbj4+cB1FsBthlNCSw4oGCmYm0
 /AGKaQY26n31/9ilWOvTMHEX6kwjCfODCMahML+ksB8B0p60RI52Tyq+p4blR4Etq99uSYU
 YruNDlXRipoK+y/U3rwAuQkNMH7jDiTlibhPUmFKr8fyZ3OUokVQKbgMuzixk2ohLIaDZzO
 Z+G5ZgNCWkQU8vXNq381Q==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:gDbDmceCXk8=:slVCKXvFfQM+xEe1rnslc/
 z7OaVIkch22cTOsc1oAbSSTb0BCFW5WQW/vywD1ai7nirvv5v2batCAXDmS3SXF6pmrs/e+gS
 3BEIoyRZSITc5sxpXcWQRVwXYIoJ3FO6DX8ioyy9YhgrzoYrRVmdWcAYQG7i1niuPcIdeFHBK
 yWE6aQmmxMIQvcIVyEFzSlUL/pOO62l365w4HU85DWOsFjz0wrVUA14OaTKFjTMMcSg1XroBM
 ISlxPaUHl8LW54A2tnLy1I/sI8QTwH20ZBtqdiF3JvbhB5ojWjsd7kQ3Y02i/6pE16tN6PsMG
 JYO+dlLwz05WW22fLZ9gdaHEstz1mQBjB9ghzxLT3VoaH/y69zu6UQIcSQfyrSOyTxzPj3RwM
 awCiAWRIkWIS6jYA23NSSdehZ9cyLJMn8Zh63y7mFdCC432its+jAK1sbTwS5OnjUS+Z6QGj6
 3Mc3HaXyJ8buIc6SvohPA5Ojp4fi8tAyoS5N1ZYRJIAbGetG37kTFs5WAg0mD9130wPv4r2Rt
 GGaSgjyjDyB+WM3X0s2qP8rQDvoUAUTgv4VDr25EzrwswM57m7HsEiP7pzZBfAMNsr8bZMq8W
 siRhJQx6qKBs/v4cZDwiFONrzPjXb7aaCQLf9zCYM4JGIqjkt93WObRfQnCE90HjtLxtsqxt/
 4uSmNDf13Nh+e3sKAPl+J+f6ESlAZhQa+8pSQSTLtBFhRr1Fsdq91o2TPEO+EFDUJFsQV4O/0
 vNvlgXQYNXCHLCU0Sa/GytjraCkj6ujE60Omz9b+osAOWCs2ML3oUTKDW7EcX7sC2xhC/oRXC
 bm3YTLfN/d6QlxwxtR9Lr8nRsvfj0DFSZdyaiqviuDixQMKtk3v8TIWydhkD7tgYO/XFw840N
 v7eFk2Tb3OUD1CpfDDdnl/ZVA0i+H33c7+ESV1sAbFM7UdL2HSvURKg1q3bbU42K/woAQnoJN
 z0AAe7Ta4CmYDOpH1HO8SybvFkBgpJethoHRgr9b8PLQC9B/WVp59r1G4LR97atAZlNSk9SgD
 qmG6BETSIrld/KczQZyDw0ZiV8fkTlAqWaCKl3wd7Ff/xOnq4FU0ks3MMRr6hKNHsW0ZZ0/Sc
 0x44++7CHwKJeAos2Mg8MtKpx9+mq14vClTCXWVxWj100JZvco57tmtlRruO0ptPuoH/bjozf
 1GtaWQAfD011QcBSS+Wp9ebnq+0RG3pgnMRFoKStWzMnP/Gj83O/6BsQmtWGQf9BGXgxy2A83
 3R6pU4Vhbe2+RdI55CjhSptIEnWZggt8W+OhCDtdAcIepuvlKcHgtPQ9WB2Q=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--hdkp3nYwrIDAMqD7brdwpsik9GjyPwQMt
Content-Type: multipart/mixed; boundary="E7FA24hI7SaVFK63jD2ozXWQAMYUC872P"

--E7FA24hI7SaVFK63jD2ozXWQAMYUC872P
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/12/10 =E4=B8=8A=E5=8D=882:56, Martin Raiber wrote:
> On 07.12.2019 08:28 Qu Wenruo wrote:
>>
>> On 2019/12/7 =E4=B8=8A=E5=8D=885:26, Martin Raiber wrote:
>>> Hi,
>>>
>>> with kernel 5.4.1 I have the problem that df shows 100% space used. I=

>>> can still write to the btrfs volume, but my software looks at the
>>> available space and starts deleting stuff if statfs() says there is a=

>>> low amount of available space.
>> If the bug still happens, mind to try the snippet to see why this happ=
ened?
>>
>> You will need to:
>> - Apply the patch to your kernel code
>> - Recompile the kernel or btrfs module
>>   So this needs some experience in kernel compile.
>> - Reboot to newly compiled kernel or load the debug btrfs module
>>
>> Thanks,
>> Qu
>>
>> diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
>> index 23aa630f04c9..cf34c05b16d7 100644
>> --- a/fs/btrfs/relocation.c
>> +++ b/fs/btrfs/relocation.c
>> @@ -523,7 +523,8 @@ static int should_ignore_root(struct btrfs_root *r=
oot)
>>  {
>>         struct btrfs_root *reloc_root;
>>
>> -       if (!test_bit(BTRFS_ROOT_REF_COWS, &root->state))
>> +       if (!test_bit(BTRFS_ROOT_REF_COWS, &root->state) ||
>> +           test_bit(BTRFS_ROOT_DEAD_RELOC_TREE, &root->state))
>>                 return 0;
>>
>>         reloc_root =3D root->reloc_root;
>> diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
>> index f452a94abdc3..c2b70d97a63b 100644
>> --- a/fs/btrfs/super.c
>> +++ b/fs/btrfs/super.c
>> @@ -2064,6 +2064,8 @@ static int btrfs_statfs(struct dentry *dentry,
>> struct kstatfs *buf)
>>                                         found->disk_used;
>>                 }
>>
>> +               pr_info("%s: found type=3D0x%llx disk_used=3D%llu fact=
or=3D%d\n",
>> +                       __func__, found->flags, found->disk_used, fact=
or);
>>                 total_used +=3D found->disk_used;
>>         }
>>
>> @@ -2071,6 +2073,8 @@ static int btrfs_statfs(struct dentry *dentry,
>> struct kstatfs *buf)
>>
>>         buf->f_blocks =3D div_u64(btrfs_super_total_bytes(disk_super),=

>> factor);
>>         buf->f_blocks >>=3D bits;
>> +       pr_info("%s: super_total_bytes=3D%llu total_used=3D%llu
>> factor=3D%d\n", __func__,
>> +               btrfs_super_total_bytes(disk_super), total_used, facto=
r);
>>         buf->f_bfree =3D buf->f_blocks - (div_u64(total_used, factor) =
>>
>> bits);
>>
>>         /* Account global block reserve as used, it's in logical size
>> already */
>>
> Applied. It's currently 100% used directly after reboot, and I am
> getting this log output:

Thank you a lot for the debug output!

>=20
> [...]
> [=C2=A0 241.245150] btrfs_statfs: super_total_bytes=3D128835387392
> total_used=3D93778841600 factor=3D1
> [=C2=A0 241.904824] btrfs_statfs: found type=3D0x1 disk_used=3D93464006=
656 factor=3D1
> [=C2=A0 241.904824] btrfs_statfs: found type=3D0x4 disk_used=3D31481856=
0 factor=3D1
> [=C2=A0 241.904824] btrfs_statfs: found type=3D0x2 disk_used=3D16384 fa=
ctor=3D1
> [=C2=A0 241.904824] btrfs_statfs: super_total_bytes=3D128835387392
> total_used=3D93778841600 factor=3D1

This proves the on-disk numbers are all correct, so far so good.

The remaining problem is the block_rsv part. Which matches with the new
ticket system introduced in v5.4.

Mind to test the new debug snippet?

diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index f452a94abdc3..516969534095 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -2076,6 +2076,8 @@ static int btrfs_statfs(struct dentry *dentry,
struct kstatfs *buf)
        /* Account global block reserve as used, it's in logical size
already */
        spin_lock(&block_rsv->lock);
        /* Mixed block groups accounting is not byte-accurate, avoid
overflow */
+       pr_info("%s: block_rsv->size=3D%llu block_rsv->reserved=3D%llu\n"=
,
__func__,
+               block_rsv->size, block_rsv->reserved);
        if (buf->f_bfree >=3D block_rsv->size >> bits)
                buf->f_bfree -=3D block_rsv->size >> bits;
        else


--E7FA24hI7SaVFK63jD2ozXWQAMYUC872P--

--hdkp3nYwrIDAMqD7brdwpsik9GjyPwQMt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFLBAEBCAA1FiEELd9y5aWlW6idqkLhwj2R86El/qgFAl3u7FEXHHF1d2VucnVv
LmJ0cmZzQGdteC5jb20ACgkQwj2R86El/qhNCAf9GtWJoZnh3C/Cp3a7zZMiWhWm
T09aXU/yfTcqF9Stk1EKpEVXwLiRb2Zkzf+3EMpNiaI68Q302bNlIvQ3Ibz2jj05
ohzkwintBAfqc4WSB2TkSltNLxd2v8w4te1yXj7PmanMvcOCyboFP70dpW872q8H
RxXiBsN/vvRDFWVsMvfePwaguuRJLbQ4O8cjZ+Ld7i1Yq16LRAjuFLi4CU5O7ARX
bDAOtj1pcSVkEUAi8RqEkcOC5Zy1mNdk1pTbhClLPx9Gl4SuEnbNHebpncTp0onv
iZdjzk/Aja01O0A1rtqq13vdiDDi6jz8gy52rHIwDvSTGrU8IFAd546mK7Etlw==
=6Ukt
-----END PGP SIGNATURE-----

--hdkp3nYwrIDAMqD7brdwpsik9GjyPwQMt--
