Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4E7C75DF90
	for <lists+linux-btrfs@lfdr.de>; Sun, 23 Jul 2023 03:27:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbjGWB0d (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 22 Jul 2023 21:26:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjGWB0c (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 22 Jul 2023 21:26:32 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1020710DA;
        Sat, 22 Jul 2023 18:26:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
 s=s31663417; t=1690075584; x=1690680384; i=quwenruo.btrfs@gmx.com;
 bh=pxrDlV0G7jS7Kx0r0wBVJ+o44XvXI4MhL/QN0aoZGGc=;
 h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
 b=qikGjnPaUPuxlbEoP0StI+bmDRc09h0UGXZZ6QRLKzC6OPawbAF+AkyDbEF1iktZat8RWQt
 lVY4lTAot6AwBrdGJBVCeMXoitANdelpO+tdUf9f2zWP3BBZ9b45xwseO/F5oQcNK1rUKUrlg
 wi4920Lxgtkxd7tpcqk855YmKg70jLTcC5aSx1VD6KC8zAtrwKLQ1Nx9bPVUkRH55QSsg/tyq
 SDZBk3SU6FzFj88tREuJVa3kbYXC47dpKlWgiNC0uOS7qK4zjRPI1NRS8Y1GlJ/l2nQTyQ1pT
 Q0Fe3EPMgWlPVrjbWfB5awBSTR7/ZmbWO0zmPSw0KDKs30ZviL8A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MowKi-1pYAK11dD4-00qP6X; Sun, 23
 Jul 2023 03:26:24 +0200
Message-ID: <6bd2e453-f373-b065-98d9-9be0328d44ad@gmx.com>
Date:   Sun, 23 Jul 2023 09:26:19 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] btrfs: add a test case to make sure scrub can repair
 parity corruption
To:     Anand Jain <anand.jain@oracle.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
References: <20230630013614.56667-1-wqu@suse.com>
 <f97ff066-d94e-29fc-b915-bf2c6a85d915@oracle.com>
Content-Language: en-US
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <f97ff066-d94e-29fc-b915-bf2c6a85d915@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:RK2RPGCHwkGrYH3xclBmXNmfNh0Lj5XPH8/9T9IfjwvVJ1X/Lek
 UlXdhGvr8LIl4XAn4dkwYDiO+Vgsv9sdmmKoYpxdFpV85wqJ+T1ESUzooGGt8WSDJr0C5MI
 9f8C2rs7WlhclBR8meJK41EvGOJpA9GhZNn90nD5wAllvYAb5uiB8QKSyJngj2u7WnDj918
 OtD9Zr4+/ONSslOFDS8rA==
UI-OutboundReport: notjunk:1;M01:P0:01pgQKZVKmA=;xdCRFrP2EbBPxmJt0wGSbr7Xm0y
 U/F3jUUkJuMgmusIFB/bIQOFTy/DHeGueBZClHsvtWiArWrkcEEgh6OLZhxeqCLMZRyGoMYn+
 mEWBxTvHiPP+Bnfc3rRvwCuJ1GfjB6EL8lYyHMtKGdQzyDL5UwhTy4FdPXTJuR9nBrnnynJyS
 9pXhmNTvgglq7cpCd1mezc+gbv+0vcHoz8ocV1njo85l7yUhbUn37GdhT63cx17IIMM1t/0D8
 YJGmWDa82wuGdAC8hznUc2dP72QufbyqVl9NamyQKLYN7aTg5IJv2JcpCwAWY5bI4J+XwzbKA
 0BVGNk0CNFKn4uq86zNFVCrNmbPG7Wvr2QBSHPd7LB9/xOCswqWcFAOu0EDXHJ1L1RaksEv7H
 9uMKWBhX1zz6b+cUMdbp5awqaDcj/TLHJ+IA9vGNI5H4Jbzei3tBFoC8TSoe2mdZMBfV6ZFmD
 +AW0PWYc2wARxtmMdzjZm63mZ7O+TAT8cNkf/CWICaXyDa8rJcBJbel6ZqEKQb/OnEdNSF8Ro
 yHGs6qUnnRvlbJCsHwh3nxbdBK+EwHHoD9rkI6OIO0dt3HUXnyi6EsoA4dRpWXnryl6Qa73+S
 0wog994HHAzUOGaSd3ac1VWexNRnpmTKz6CWuufhwiXWdHd8OdkPHfLJDZm7y9orlfIiRSKmk
 aj3joLTrAN7rv4gFFbY1HFVtVwo0LztL64xa75fmYAqoJlDOE8uN6g+Lm151OzO0K56ymeyfl
 tPQP5KMRXX9/cVuOo1SKQPrZ2ajbhCH0xtmRVVEpvpDRnN1S2q5HXTsKihzlqnX9BAI3MAMxd
 CKF3oql6TjT+7X9I67Lq9GbmnOlL0xEqjdB0BRWhR8757xyLvl0cxEOiSpoRMh71+JUyEhTNG
 vRy+BOji3t6Be7DOxX3N4MmwtxH8jBst4DNlBfJ7B/AOtur9qnpSISByfeHLtEJzSWImoIqwV
 0NphnbGpYWznDv38aeXhcOH2b0o=
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/7/22 21:24, Anand Jain wrote:
>
>
> On 30/06/2023 09:36, Qu Wenruo wrote:
>> There is a kernel regression caused by commit 75b470332965 ("btrfs:
>> raid56: migrate recovery and scrub recovery path to use error_bitmap"),
>> which leads to scrub not repairing corrupted parity stripes.
>>
>> So here we add a test case to verify the P/Q stripe scrub behavior by:
>>
>> - Create a RAID5 or RAID6 btrfs with minimal amount of devices
>> =C2=A0=C2=A0 This means 2 devices for RAID5, and 3 devices for RAID6.
>> =C2=A0=C2=A0 This would result the parity stripe to be a mirror of the =
only data
>> =C2=A0=C2=A0 stripe.
>>
>> =C2=A0=C2=A0 And since we have control of the content of data stripes, =
the content
>> =C2=A0=C2=A0 of the P stripe is also fixed.
>>
>> - Create an 64K file
>> =C2=A0=C2=A0 The file would cover one data stripe.
>>
>> - Corrupt the P stripe
>>
>> - Scrub the fs
>> =C2=A0=C2=A0 If scrub is working, the P stripe would be repaired.
>>
>> =C2=A0=C2=A0 Unfortunately scrub can not report any P/Q corruption, lim=
ited by its
>> =C2=A0=C2=A0 reporting structure.
>> =C2=A0=C2=A0 So we can not use the return value of scrub to determine i=
f we
>> =C2=A0=C2=A0 repaired anything.
>>
>> - Verify the content of the P stripe
>>
>> - Use "btrfs check --check-data-csum" to double check
>>
>> By above steps, we can verify if the P stripe is properly fixed.
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>> =C2=A0 tests/btrfs/294=C2=A0=C2=A0=C2=A0=C2=A0 | 86 +++++++++++++++++++=
++++++++++++++++++++++++++
>> =C2=A0 tests/btrfs/294.out |=C2=A0 2 ++
>> =C2=A0 2 files changed, 88 insertions(+)
>> =C2=A0 create mode 100755 tests/btrfs/294
>> =C2=A0 create mode 100644 tests/btrfs/294.out
>>
>> diff --git a/tests/btrfs/294 b/tests/btrfs/294
>> new file mode 100755
>> index 00000000..97b85988
>> --- /dev/null
>> +++ b/tests/btrfs/294
>> @@ -0,0 +1,86 @@
>> +#! /bin/bash
>> +# SPDX-License-Identifier: GPL-2.0
>> +# Copyright (C) 2023 SUSE Linux Products GmbH. All Rights Reserved.
>> +#
>> +# FS QA Test 294
>> +#
>> +# Make sure btrfs scrub can fix parity stripe corruption
>> +#
>> +. ./common/preamble
>> +_begin_fstest auto quick raid scrub
>> +
>> +. ./common/filter
>> +
>> +_supported_fs btrfs
>> +_require_odirect
>> +_require_non_zoned_device "${SCRATCH_DEV}"
>> +_require_scratch_dev_pool 3
>> +_fixed_by_kernel_commit xxxxxxxxxxxx \
>> +=C2=A0=C2=A0=C2=A0 "btrfs: raid56: always verify the P/Q contents for =
scrub"
>> +
>> +workload()
>> +{
>> +=C2=A0=C2=A0=C2=A0 local profile=3D$1
>> +=C2=A0=C2=A0=C2=A0 local nr_devs=3D$2
>> +
>> +=C2=A0=C2=A0=C2=A0 echo "=3D=3D=3D Testing $nr_devs devices $profile =
=3D=3D=3D" >> $seqres.full
>> +=C2=A0=C2=A0=C2=A0 _scratch_dev_pool_get $nr_devs
>> +
>> +=C2=A0=C2=A0=C2=A0 _scratch_pool_mkfs -d $profile -m single >> $seqres=
.full 2>&1
>> +=C2=A0=C2=A0=C2=A0 # Disable space cache to prevent v1 space cache aff=
ecting
>> +=C2=A0=C2=A0=C2=A0 # the result.
>
>
>> +=C2=A0=C2=A0=C2=A0 _scratch_mount -o nospace_cache
>
> [ 1562.331370] BTRFS error (device sdb3): cannot disable free space tree
>
>
> Mount is failing for the -o nospace_cache option.

Indeed, I guess this is caused by block group tree feature.

The original intention is just to prevent v1 cache, considering v2 is
required by several features, I'd switch it to explicitly require v2
cache instead.

Thanks,
Qu
>
>> +
>> +=C2=A0=C2=A0=C2=A0 # Create one 64K extent which would cover one data =
stripe.
>> +=C2=A0=C2=A0=C2=A0 $XFS_IO_PROG -f -d -c "pwrite -S 0xaa -b 64K 0 64K"=
 \
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "$SCRATCH_MNT/foobar" > /de=
v/null
>> +=C2=A0=C2=A0=C2=A0 sync
>> +
>> +=C2=A0=C2=A0=C2=A0 # Corrupt the P/Q stripe
>> +=C2=A0=C2=A0=C2=A0 local logical=3D$(_btrfs_get_first_logical $SCRATCH=
_MNT/foobar)
>> +
>> +=C2=A0=C2=A0=C2=A0 # The 2nd copy is pointed to P stripe directly.
>> +=C2=A0=C2=A0=C2=A0 physical_p=3D$(_btrfs_get_physical ${logical} 2)
>> +=C2=A0=C2=A0=C2=A0 devpath_p=3D$(_btrfs_get_device_path ${logical} 2)
>> +
>> +=C2=A0=C2=A0=C2=A0 _scratch_unmount
>> +
>> +=C2=A0=C2=A0=C2=A0 echo "Corrupt stripe P at devpath $devpath_p physic=
al $physical_p" \
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 >> $seqres.full
>> +=C2=A0=C2=A0=C2=A0 $XFS_IO_PROG -d -c "pwrite -S 0xff -b 64K $physical=
_p 64K"
>> $devpath_p \
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > /dev/null
>> +
>> +=C2=A0=C2=A0=C2=A0 # Do a scrub to try repair the P stripe.
>> +=C2=A0=C2=A0=C2=A0 _scratch_mount -o nospace_cache
>> +=C2=A0=C2=A0=C2=A0 $BTRFS_UTIL_PROG scrub start -BdR $SCRATCH_MNT >> $=
seqres.full 2>&1
>> +=C2=A0=C2=A0=C2=A0 _scratch_unmount
>> +
>> +=C2=A0=C2=A0=C2=A0 # Verify the repaired content directly
>> +=C2=A0=C2=A0=C2=A0 local output=3D$($XFS_IO_PROG -c "pread -qv $physic=
al_p 16"
>> $devpath_p | _filter_xfs_io_offset)
>> +=C2=A0=C2=A0=C2=A0 local expect=3D"XXXXXXXX:=C2=A0 aa aa aa aa aa aa a=
a aa aa aa aa aa aa
>> aa aa aa=C2=A0 ................"
>> +
>> +=C2=A0=C2=A0=C2=A0 echo "The first 16 bytes of parity stripe after scr=
ub:" >>
>> $seqres.full
>
>> +=C2=A0=C2=A0=C2=A0 echo $output >> $seqres.full
>> +
>
> White space error here.
>
> Thanks.
>
>> +=C2=A0=C2=A0=C2=A0 if [ "$output" !=3D "$expect" ]; then > +=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 echo "Unexpected
>> parity content"
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 echo "has:"
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 echo "$output"
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 echo "expect"
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 echo "$expect"
>> +=C2=A0=C2=A0=C2=A0 fi
>> +
>> +=C2=A0=C2=A0=C2=A0 # Last safenet, let btrfs check --check-data-csum t=
o do an
>> offline scrub.
>> +=C2=A0=C2=A0=C2=A0 $BTRFS_UTIL_PROG check --check-data-csum $SCRATCH_D=
EV >>
>> $seqres.full 2>&1
>> +=C2=A0=C2=A0=C2=A0 if [ $? -ne 0 ]; then
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 echo "Error detected after =
the scrub"
>> +=C2=A0=C2=A0=C2=A0 fi
>> +=C2=A0=C2=A0=C2=A0 _scratch_dev_pool_put
>> +}
>> +
>> +workload raid5 2
>> +workload raid6 3
>> +
>> +echo "Silence is golden"
>> +status=3D0
>> +exit
>> diff --git a/tests/btrfs/294.out b/tests/btrfs/294.out
>> new file mode 100644
>> index 00000000..c09531de
>> --- /dev/null
>> +++ b/tests/btrfs/294.out
>> @@ -0,0 +1,2 @@
>> +QA output created by 294
>> +Silence is golden
>
