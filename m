Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8553CCCD43
	for <lists+linux-btrfs@lfdr.de>; Sun,  6 Oct 2019 01:21:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725978AbfJEXVV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 5 Oct 2019 19:21:21 -0400
Received: from mout.gmx.net ([212.227.17.20]:40047 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725801AbfJEXVU (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 5 Oct 2019 19:21:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1570317672;
        bh=nuzhpWypGPC8RCe0szPiW7TgmqNlnrWdXQpf0fGTnFU=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=lgLpZ4/C+GS71veoMW0Bahnd/DaK03d7LZLS45A+mw1TUTEJ2Xx0x6+TpJ5MJmXrg
         cSdno5GpibcyH2DEP1SCcL5j3RC87TxNX0kR3BROKPN6ugS57Cr4OvTSICJcTJV2+N
         X3KgVIzV/0Eist+Nnkjn1n6APeXHreu19zygZo20=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([13.231.109.76]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MNbox-1iSGHU3tZT-00P1br; Sun, 06
 Oct 2019 01:21:12 +0200
Subject: Re: [PATCH v2 2/2] btrfs: Add test for btrfs balance convert
 functionality
To:     Eryu Guan <guaneryu@gmail.com>, Nikolay Borisov <nborisov@suse.com>
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
References: <20191001090419.22153-1-nborisov@suse.com>
 <20191001090419.22153-2-nborisov@suse.com> <20191005175354.GD2622@desktop>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <fc8d4539-116c-5447-9954-569151de582c@gmx.com>
Date:   Sun, 6 Oct 2019 07:21:07 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191005175354.GD2622@desktop>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:7w6P1TD/JFEQ4yUdrLdDtnRPIio7+afG5IGZJN2uxEurHDyk5On
 9JFSA6Ru6132vj7JCDo2373apIOqwFl68wabWGN0PAeyDysdUNiv6KwoXqajqvwXnI958cI
 Tr9lSk5FxfkJW87QowzyCM6/Yma/R0l/11AuXHj1cWTwWQkULiV0HKr6v0GJD8YvGhMwMGk
 Fq5e3UURgoefqQ8UH2+hg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:LyrGhGWPJ4s=:iok5lKoehPIZUCmql+eO2n
 W+4FtMW6+v0i1aFUbnhnPYGvHVnv7adtdwn6YMgY3xSC83w/bttcN0AZrfTxWcG5BRy2zrqY8
 Wtwhp+ya+i7HpFTf1eeZ5/yBlVrZcZz1AT3/biXHc77YjA1ND5qgLJyTZlRvDGgmBl0cQ5hVc
 OtVy0/RUgNHWsYQ8HWCbvw0ckNKXC1QFPmn40mTgwsJiYcJR7rRxcxV3WqUq+psOtVh2H9R/w
 re5wLNO2+OFUA89m+vZUm4EVpIDVDD4IFG7s8w71BcrdNL4XT+vGirbUHlDOgCvPC3gXoA6HJ
 PyekubRa3kmqMvhwZUUsCu5CZRkKPKQiiPU8YXYlFbQcUMquQQItC3E7Yl/YEdVjij+e/+oUp
 5j9RMNL/tTtJ6bfge5PpXUA5LjbDJ8MK/JEKFBKDT4q8es8xp5qkNH4Qm3KWVdLckbgN//x6L
 wufSXG2KTPWFJ9piVJ8w9LRE6ZLrPvFgWJnINFdYHdkAGXEctgqTYcts4ETdPJKR9qMbBg4AT
 QndrEItZK+4f8wi7BkKJF/SZ6QhncabGvG3sXzmPpEdc/LJ7ZnSM1O3Z8fvgqIIuGAUwxIOb2
 X3Llbeq0uSM7W8A/5dXgC6KK1x3job5Xp1ZNZQV+pkQ/HLOpqhyPh6sQZPaq1XEKvOPi/zHD2
 DzICs4rH+/M0EzYg2wj6qkKnGFEs126lqJLwkpgsR1Kg+AzuwsWxGyPtVWuoMQg8dQlNAWSua
 Rxnz0ly+bc6weDWqYfCBD++WszIJDSAoW7mX+JkX5qelWHA6l7UFHdu1ZO0X0gNQdwEhq3Vjw
 QQS5XygRXzXDbijbPoj1ARI/4A+LWTk72dfIjIj9gXOQQYZLMYSbzC+MAadpKLH9nNUjp46aU
 k9TdAWNbrU4s19VQpVCSxgegNRKSsmhoPYSVPKAxEY/G4AIhMtU8VTFAsHOMahCgNnxBPsbd9
 42VmLhsEo9HEu6BpCiyHvfPpAXw+Tqcor/iZgYH7IWHiislE+Oz73GWzlrEr2m2NJIfefkVRs
 /2ABs1DY/ihddsD1Aa98f3PcivfVW/UpRGEnZUH3JD8clxnl/8k8WEb4d15QCDjGgGllF8ke2
 v/ytK021WZj2hvJf3Gb27Ob8pgOBbDnYhVlAKl9tlSNZV8JD5v0+y4i6IxcDQqrEhzKmbBat5
 w0F1orxMC6T8y37A2PKdw+rTH23CBhXK892lkCWtqvICNJ71voQ+R1w+cycJOz3WolLCgkXem
 iYLV4m/P85jls0Xrf4VUQDbUyprW6EOeygYwLHYSRRwUOn2fvnCFsaLhy4jU=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2019/10/6 =E4=B8=8A=E5=8D=881:53, Eryu Guan wrote:
> Hi Qu,
>
> On Tue, Oct 01, 2019 at 12:04:19PM +0300, Nikolay Borisov wrote:
>> Add basic test to ensure btrfs conversion functionality is tested. This=
 test
>> exercies conversion to all possible types of the data portion. This is =
sufficient
>> since from the POV of relocation we are only moving blockgroups.
>>
>> Signed-off-by: Nikolay Borisov <nborisov@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Still one small nitpick inlined below (just small wording, can be fixed
at commit time).

>
> Would you please help review this v2 as well? Thanks a lot!
>
> Eryu
>
>> ---
>>  tests/btrfs/194     | 84 +++++++++++++++++++++++++++++++++++++++++++++=
++++++++
>>  tests/btrfs/194.out |  2 ++
>>  tests/btrfs/group   |  1 +
>>  3 files changed, 87 insertions(+)
>>  create mode 100755 tests/btrfs/194
>>  create mode 100644 tests/btrfs/194.out
>>
>> diff --git a/tests/btrfs/194 b/tests/btrfs/194
>> new file mode 100755
>> index 000000000000..39b6e0a969c1
>> --- /dev/null
>> +++ b/tests/btrfs/194
>> @@ -0,0 +1,84 @@
>> +#! /bin/bash
>> +# SPDX-License-Identifier: GPL-2.0
>> +# Copyright (c) 2019 SUSE Linux Products GmbH. All Rights Reserved.
>> +#
>> +# FS QA Test 194
>> +#
>> +# Test raid profile conversion. It's sufficient to test all dest profi=
les as
>> +# source profiles just rely on being able to read the metadata.

data and metadata.

In fact in the test case itself it's purely data.

THanks,
Qu

>> +#
>> +seq=3D`basename $0`
>> +seqres=3D$RESULT_DIR/$seq
>> +echo "QA output created by $seq"
>> +
>> +here=3D`pwd`
>> +tmp=3D/tmp/$$
>> +status=3D1	# failure is the default!
>> +trap "_cleanup; exit \$status" 0 1 2 3 15
>> +
>> +_cleanup()
>> +{
>> +	cd /
>> +	rm -f $tmp.*
>> +}
>> +
>> +# get standard environment, filters and checks
>> +. ./common/rc
>> +. ./common/filter
>> +
>> +# remove previous $seqres.full before test
>> +rm -f $seqres.full
>> +
>> +# real QA test starts here
>> +
>> +# Modify as appropriate.
>> +_supported_fs btrfs
>> +_supported_os Linux
>> +_require_scratch_dev_pool 4
>> +
>> +
>> +declare -a TEST_VECTORS=3D(
>> +# $nr_dev_min:$data:$metadata:$data_convert:$metadata_convert
>> +"4:single:raid1"
>> +"4:single:raid0"
>> +"4:single:raid10"
>> +"4:single:dup"
>> +"4:single:raid5"
>> +"4:single:raid6"
>> +"2:raid1:single"
>> +)
>> +
>> +run_testcase() {
>> +	IFS=3D':' read -ra args <<< $1
>> +	num_disks=3D${args[0]}
>> +	src_type=3D${args[1]}
>> +	dst_type=3D${args[2]}
>> +
>> +	_scratch_dev_pool_get $num_disks
>> +
>> +	echo "=3D=3D=3D Running test: $1 =3D=3D=3D" >> $seqres.full
>> +
>> +	_scratch_pool_mkfs -d$src_type >> $seqres.full 2>&1
>> +	_scratch_mount
>> +
>> +	# Create random filesystem with 20k write ops
>> +	run_check $FSSTRESS_PROG -d $SCRATCH_MNT -w -n 10000 $FSSTRESS_AVOID
>> +
>> +	$BTRFS_UTIL_PROG balance start -f -dconvert=3D$dst_type $SCRATCH_MNT =
>> $seqres.full 2>&1
>> +	[ $? -eq 0 ] || echo "$1: Failed convert"
>> +
>> +	$BTRFS_UTIL_PROG scrub start -B $SCRATCH_MNT >>$seqres.full 2>&1
>> +	[ $? -eq 0 ] || echo "$1: Scrub failed"
>> +
>> +	_scratch_unmount
>> +	_check_btrfs_filesystem $SCRATCH_DEV
>> +	_scratch_dev_pool_put
>> +}
>> +
>> +for i in "${TEST_VECTORS[@]}"; do
>> +	run_testcase $i
>> +done
>> +
>> +echo "Silence is golden"
>> +status=3D0
>> +exit
>> diff --git a/tests/btrfs/194.out b/tests/btrfs/194.out
>> new file mode 100644
>> index 000000000000..7bfd50ffb5a4
>> --- /dev/null
>> +++ b/tests/btrfs/194.out
>> @@ -0,0 +1,2 @@
>> +QA output created by 194
>> +Silence is golden
>> diff --git a/tests/btrfs/group b/tests/btrfs/group
>> index b92cb12ca66f..a2c0ad87d0f6 100644
>> --- a/tests/btrfs/group
>> +++ b/tests/btrfs/group
>> @@ -196,3 +196,4 @@
>>  191 auto quick send dedupe
>>  192 auto replay snapshot stress
>>  193 auto quick qgroup enospc limit
>> +194 auto volume balance
>> --
>> 2.7.4
>>
