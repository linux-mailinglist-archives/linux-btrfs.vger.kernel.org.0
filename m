Return-Path: <linux-btrfs+bounces-117-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B38197EA8DA
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Nov 2023 03:57:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 166AEB209BC
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Nov 2023 02:57:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FCB5747B;
	Tue, 14 Nov 2023 02:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="WcxtumEI"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92F517E;
	Tue, 14 Nov 2023 02:56:50 +0000 (UTC)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA8F11A2;
	Mon, 13 Nov 2023 18:56:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
	s=s31663417; t=1699930600; x=1700535400; i=quwenruo.btrfs@gmx.com;
	bh=L9S/GNSoBl/VKkfPtgbzd5qKFUygxUbosUOexm32ASc=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=WcxtumEIxRlME13hw+8xjsR3SdMl8UHroN5zpYZ1I1hSuwebllvttWnYZSx5sAF2
	 QCABKGtn2EPz8dG9WkBmGD928nOJuXkUoLpBDsIg1WwM4LFesmj1vTh9ejsqXJWG0
	 DVkLOXWz+BrH5+uurUKCI+LsC0m0DmBzU4rstT/qsm1RhiZt+ymoD3Y1h+cNtRVbM
	 +EtyLTOcgjBp9lFIe3j0Fjgi3enMVakvX9c78jxRGmqcuHcLkVndcExp1uyenJ/WQ
	 StTPKHyjXLWBwHag0PDyu6cORycj1yVJXZJoLvXTlE4f1qvlqH6np89OpRUIxBN6N
	 /UGrMCMyfRNZY5FC7g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.117] ([122.151.37.21]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1Mel3n-1rdAkU2b01-00aoBe; Tue, 14
 Nov 2023 03:56:40 +0100
Message-ID: <4407b54a-30c6-4ee8-b2bc-bcfdb668e441@gmx.com>
Date: Tue, 14 Nov 2023 13:26:35 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fstests: btrfs: test snapshot creation with existing
 qgroup
Content-Language: en-US
To: Filipe Manana <fdmanana@kernel.org>, Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
References: <20231112233325.103250-1-wqu@suse.com>
 <CAL3q7H5so2=7MojMydXZfxQPCYmFrcNMvqA8fBxtKfEZ5hhsNA@mail.gmail.com>
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
Autocrypt: addr=quwenruo.btrfs@gmx.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNIlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT7CwJQEEwEIAD4CGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCY00iVQUJDToH
 pgAKCRDCPZHzoSX+qNKACACkjDLzCvcFuDlgqCiS4ajHAo6twGra3uGgY2klo3S4JespWifr
 BLPPak74oOShqNZ8yWzB1Bkz1u93Ifx3c3H0r2vLWrImoP5eQdymVqMWmDAq+sV1Koyt8gXQ
 XPD2jQCrfR9nUuV1F3Z4Lgo+6I5LjuXBVEayFdz/VYK63+YLEAlSowCF72Lkz06TmaI0XMyj
 jgRNGM2MRgfxbprCcsgUypaDfmhY2nrhIzPUICURfp9t/65+/PLlV4nYs+DtSwPyNjkPX72+
 LdyIdY+BqS8cZbPG5spCyJIlZonADojLDYQq4QnufARU51zyVjzTXMg5gAttDZwTH+8LbNI4
 mm2YzsBNBFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcga
 CbPEwhLj1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj
 /IrRUUka68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fN
 GSsRb+pKEKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0
 q1eW4Jrv0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEv
 ABEBAAHCwHwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCY00ibgUJDToHvwAK
 CRDCPZHzoSX+qK6vB/9yyZlsS+ijtsvwYDjGA2WhVhN07Xa5SBBvGCAycyGGzSMkOJcOtUUf
 tD+ADyrLbLuVSfRN1ke738UojphwkSFj4t9scG5A+U8GgOZtrlYOsY2+cG3R5vjoXUgXMP37
 INfWh0KbJodf0G48xouesn08cbfUdlphSMXujCA8y5TcNyRuNv2q5Nizl8sKhUZzh4BascoK
 DChBuznBsucCTAGrwPgG4/ul6HnWE8DipMKvkV9ob1xJS2W4WJRPp6QdVrBWJ9cCdtpR6GbL
 iQi22uZXoSPv/0oUrGU+U5X4IvdnvT+8viPzszL5wXswJZfqfy8tmHM85yjObVdIG6AlnrrD
In-Reply-To: <CAL3q7H5so2=7MojMydXZfxQPCYmFrcNMvqA8fBxtKfEZ5hhsNA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ka6N3+suPP3aoZRR8YtuNOEQT5chuWAi4TXAOSJz+vI+q2wAGj3
 HaaN+3BLXNvD5wgNQg7Xf93e4UNcBgcvu+rEduWqvYSCdJUBCavsrmRABBu52VefNMzI+oo
 2Rv51OAL+QhO8hkSFDsmG+stFU5wyn4TYtR+ibeykKiMhlFSJQJC1m6NcTO2zkrL3JDZkA6
 FdgIEwaJPyQt3cENdAoQw==
UI-OutboundReport: notjunk:1;M01:P0:w938nZuAJYE=;+B8oWcjlZ01q7U70Lc/yOkvxSH2
 I+0Tv4z/KQ5K3oSKBvriE2+OIs7atuVPM1Oakdrvv9MMLDU4/w3n3QyW82YTr4sbQA9Ygwi0G
 VeaxW5aFmgRQIgMHIyHeS9yD70admoVwVRq0BsVh/Uc3pc4rBfvLfwTWs64e4akWKDrRAoqkG
 veARwwDgPUIeNc5tobNQCbs1MINKk37PmkmbF94pSjgcdmK/G2mpJp4ypGuWqZ6ICWXfGxaEH
 GR5qBETiFI6c1Ws0CYpxGW12UUig2x76l0DgW7q/OYxIrSKLF5eO3Uwb10SIupA+mXPJUGHdh
 6EMg5e89DIahtNLohQt1w9KIGyalCwuz0aLx2hCQs1DHdKs81TNdoA0Z5jUoj4t2vj+3C1zmF
 /yfvSYTw2U3u2WTtVsp/39CnzMFW8pNDLh7Nu2d/u/ptVGNfnUt7ZHBbCuji7U3B6rmeqjYTf
 UR5zOzAE1fBrKe6pNKDwnk3Fk1qO5DagGMrFzsKkQvX+MjBQjUikyJ/PyM9im9yNkcxTwPDAA
 JwppHPdVtvr2mi87SunYUMMyyGZTeYOpTgvKZPli9zcfIGF//K2nTwjHUZPfv6vT0JDIDA33f
 V2sS+egd6WG3VdmBEPr2BaEFugQGKlByaz8oHwujoGKikiJvRfJ9ZQAwu15dFZvBuXV5yCpxL
 P63IT/d2pBHit/DtaX32v8gZcsLLEOX5g8ikLIGgBUBNCmCF8zw9eeXO8jXXzZQWUEOWHCbs+
 CEpL9icY/9eNLBGDybL/IH0+lDGvpbGAsl5eNCqa9R4jFmfXXvqDKmr995/6ZYsVtpYcYtbsU
 9QeNNfP+ARdqMCnzen49LAJVEQsTHXGqS49e4NMJBjbWBQNa5IdpHJE4aqYlb8/pTml1+4xv2
 Oq2GbjbI8BW/n0iq4Pc3V6ploi2rr5HputDcFjOhx1KMsfRWOaqlupEouDBtVA2ysg76oBCaa
 2dX0UmBtWjcvbwpimWALkfjacW0=



On 2023/11/14 00:03, Filipe Manana wrote:
> On Sun, Nov 12, 2023 at 11:33=E2=80=AFPM Qu Wenruo <wqu@suse.com> wrote:
>>
>> [BUG]
>> There is a sysbot regression report about transaction abort during
>> snapshot creation, which is caused by the new timing of qgroup creation
>> and too strict error check.
>>
>> [FIX]
>> The proper fix is already submitted, with the title "btrfs: do not abor=
t
>> transaction if there is already an existing qgroup".
>>
>> [TEST]
>> The new test case would reproduce the regression by:
>>
>> - Create a subvolume and a snapshot of it
>>
>> - Record the subvolumeid of the snapshot
>>
>> - Re-create the fs
>>    Since btrfs won't reuse the subvolume id, we have to re-create the f=
s.
>>
>> - Enable quota and create a qgroup with the same subvolumeid
>>
>> - Create a subvolume and a snapshot of it
>>    For unpatched and affected kernel (thankfully no release is affected=
),
>>    the snapshot creation would fail due to aborted transaction.
>>
>> - Make sure the subvolume id doesn't change for the snapshot
>>    There is one very hacky attempt to fix it by avoiding using the
>>    subvolume id, which is completely wrong and would be caught by this
>>    extra check.
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>>   tests/btrfs/303     | 80 ++++++++++++++++++++++++++++++++++++++++++++=
+
>>   tests/btrfs/303.out |  2 ++
>>   2 files changed, 82 insertions(+)
>>   create mode 100755 tests/btrfs/303
>>   create mode 100644 tests/btrfs/303.out
>>
>> diff --git a/tests/btrfs/303 b/tests/btrfs/303
>> new file mode 100755
>> index 00000000..fe924496
>> --- /dev/null
>> +++ b/tests/btrfs/303
>> @@ -0,0 +1,80 @@
>> +#! /bin/bash
>> +# SPDX-License-Identifier: GPL-2.0
>> +# Copyright (C) 2023 SUSE Linux Products GmbH. All Rights Reserved.
>> +#
>> +# FS QA Test 303
>> +#
>> +# A regression test to make sure snapshot creation won't cause transac=
tion
>> +# abort if there is already an existing qgroup.
>> +#
>> +. ./common/preamble
>> +_begin_fstest auto quick qgroup
>
> Also 'snapshot' and 'subvol' groups.
>
>> +
>> +. ./common/filter
>> +
>> +_supported_fs btrfs
>> +_require_scratch
>> +
>> +_fixed_by_kernel_commit xxxxxxxxxxxx \
>> +       "btrfs: do not abort transaction if there is already an existin=
g qgroup"
>> +
>> +_scratch_mkfs >> $seqres.full 2>&1 || _fail "mkfs failed"
>> +_scratch_mount
>> +
>> +# Create the first subvolume and get its id.
>> +# This subvolume id should not change no matter if there is an existin=
g
>> +# qgroup for it.
>> +$BTRFS_UTIL_PROG subvolume create "$SCRATCH_MNT/subvol" >> $seqres.ful=
l
>> +$BTRFS_UTIL_PROG subvolume snapshot "$SCRATCH_MNT/subvol" \
>> +       "$SCRATCH_MNT/snapshot">> $seqres.full
>> +
>> +init_subvolid=3D$(_btrfs_get_subvolid "$SCRATCH_MNT" "snapshot")
>> +
>> +if [ -z "$init_subvolid" ]; then
>> +       _fail "Unable to get the subvolid of the first snapshot"
>> +fi
>> +
>> +echo "Subvolumeid: ${init_subvolid}" >> $seqres.full
>> +
>> +_scratch_unmount
>> +
>> +# Re-create the fs, as btrfs won't reuse the subvolume id.
>> +_scratch_mkfs >> $seqres.full 2>&1 || _fail "2nd mkfs failed"
>> +_scratch_mount
>> +
>> +$BTRFS_UTIL_PROG quota enable "$SCRATCH_MNT" >> $seqres.full
>> +$BTRFS_UTIL_PROG quota rescan -w "$SCRATCH_MNT" >> $seqres.full
>> +
>> +# Create a qgroup for the first subvolume, this would make the later
>> +# subvolume creation to find an existing qgroup, and abort transaction=
.
>> +$BTRFS_UTIL_PROG qgroup create 0/"$init_subvolid" "$SCRATCH_MNT" >> $s=
eqres.full
>> +sync
>
> This sync is not needed. An unpatched kernel still fails, and a
> patched kernel passes this test without the sync.
>
> Also, please always comment on why a sync is needed.
> In this case it can be removed because it's redundant.

Would address all comments, but here I'm a little curious about the
"sync" comment principle.

I totally understand for this particular case the "sync" is unnecessary,
the qgroup item doesn't need to be committed, thus it's totally
reasonable to remove this sync.

But I'm wondering is there any other reasons why we should avoid
unnecessary "sync"s?
Like slowing down the test or just to improve our awareness and avoid
sync-happy guys?

Thanks,
Qu
>
>> +
>> +# Now create the first snapshot, which should have the same subvolid n=
o matter
>> +# if the quota is enabled.
>> +$BTRFS_UTIL_PROG subvolume create "$SCRATCH_MNT/subvol" >> $seqres.ful=
l
>> +$BTRFS_UTIL_PROG subvolume snapshot "$SCRATCH_MNT/subvol" \
>> +       "$SCRATCH_MNT/snapshot">> $seqres.full
>> +
>> +# Either the snapshot create failed and transaction is aborted thus no
>> +# snapshot here, or we should be able to create the snapshot.
>> +new_subvolid=3D$(_btrfs_get_subvolid "$SCRATCH_MNT" "snapshot")
>> +
>> +echo "Subvolumeid: ${new_subvolid}" >> $seqres.full
>> +
>> +if [ -z "$new_subvolid" ]; then
>> +       _fail "Unable to get the subvolid of the first snapshot"
>> +fi
>> +
>> +# Make sure the subvolumeid for the first snapshot didn't change.
>> +if [ "$new_subvolid" -ne "$init_subvolid" ]; then
>> +       _fail "Subvolumeid for the first snapshot changed, has ${new_su=
bvolid} expect ${init_subvolid}"
>> +fi
>> +
>> +_scratch_unmount
>
> This explicit unmount is not needed, the fstests framework
> automatically does that.
>
> Otherwise it looks fine, thanks.
>
>> +
>> +echo "Silence is golden"
>> +
>> +# success, all done
>> +status=3D0
>> +exit
>> diff --git a/tests/btrfs/303.out b/tests/btrfs/303.out
>> new file mode 100644
>> index 00000000..d48808e6
>> --- /dev/null
>> +++ b/tests/btrfs/303.out
>> @@ -0,0 +1,2 @@
>> +QA output created by 303
>> +Silence is golden
>> --
>> 2.42.0
>>
>>
>

