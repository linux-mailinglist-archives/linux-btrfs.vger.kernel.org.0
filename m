Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0E4F723FA1
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Jun 2023 12:34:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230499AbjFFKea (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 6 Jun 2023 06:34:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236833AbjFFKeT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 6 Jun 2023 06:34:19 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86318E6A;
        Tue,  6 Jun 2023 03:34:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
 s=s31663417; t=1686047650; x=1686652450; i=quwenruo.btrfs@gmx.com;
 bh=CCWBJ3dq+hW0ZfX3+ZL5j3tWH0mTjK4evRXMZPitIsg=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=S3XazeC8bmQ1x7rinPM2BEuSYkFu8AlsFQYns3FY5djIqC+jfv1jMb4hLdzMHaNpEdeuoe8
 9rThR9E60Rv0ugVllNs6GxsHqugbQdLS0q+6i2uPqrqHTsl5PJLdBYMP9vT1iLP3RrOixHixq
 uxz5/N8QKgtkdaQyiJpHkNCrUNkriUzOCbIkOEI6aQoaIZ10Hnst9Epa+b0BMnGr352GaEbCf
 G50rAIgxBMP+IRLtpIKCFTTCRIpOn9AvKHJHJQXJB20uDzr0RwLsquPX1isQnPthBnCyz4Hd9
 C47+NWMrO7L7Df/OFXcWyCx5d1QjFEVl93na1aBp1famQe2yboTQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MjjCF-1qU13S1U0x-00lDZH; Tue, 06
 Jun 2023 12:34:09 +0200
Message-ID: <7f251b2a-da6c-da9d-933b-b441dda01b64@gmx.com>
Date:   Tue, 6 Jun 2023 18:34:06 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH] btrfs: add a test case to verify read-only scrub
Content-Language: en-US
To:     Filipe Manana <fdmanana@kernel.org>, Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
References: <20230606022354.48911-1-wqu@suse.com>
 <CAL3q7H6teZ0MyWWO-xsYk7cP+TyQw5WKdPKE-ra0+zxp_dDMzg@mail.gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <CAL3q7H6teZ0MyWWO-xsYk7cP+TyQw5WKdPKE-ra0+zxp_dDMzg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:timp6+Kr0dXHcDEti3YKeDIoJMHi/+8WhfNIAhFtgWwcfdhbfOk
 TE4xHY75QiuFsHnlReWSmw/fhrqYFYk4oO8aMuA4YcJ65htOV8V1aj+Mu42TgEWjIzPffP8
 lOSUScF36mtUwSXZFWVqOQi/pGgwrTfLSMBU04WpeIw95S1zZ+qeHfT0gfRIWQrUoFanmgV
 94OjVlNgu5dHeFJt1BhyQ==
UI-OutboundReport: notjunk:1;M01:P0:YIysKroTnc0=;0tRNBoTNQnOmeKbohcfc86Plezq
 Er5eK0IxLxgmH4dhh7ljnWJ+l3MJena8kx2STyppYkhcW/B0PCts7HpMG7WaBOY8iNOniAJgB
 Xh1sJWyo+GSWd5L4mQMtOLfhRAYSbpjSkFW08hlVrUrMTqhiIIcFp2yCrB5e4jaWg0ttOd9vP
 DiF0db2LJZ7ngYtCphPOVgwwMgysnltsbmwQ1Jj0/V8j2RoAGGQ8q8SWUiGnIP3rMt7BDdLbY
 BpnrEiu4vBgj9oXRTlRgQoDLXCMRoPtey6+QnenuuGQrHDHIMk7sscHstm/MFsR7+Yt62DRMI
 +iAlItpZujUxWh5m9RkVtSMUtMxqyZmcHp/f6BaRXgPVFOSwsjePrJL3oCe/Wh0nx6fnlt3Qb
 Ifa91HyzC1+4X76M+XjhrVNX/zbTZ17XTAprsdw5SLC2+zbpRrN5KQnt98sg+UguIU+lDVVCe
 2wx7HeEBI/yPdidX+VKcpkat246kpXtO6Be0co0/v0/mL4Fj63bJ2/gqWlm4JurA7TFwFyDew
 zmxDKucLm1yk6tjnz7V4bSPp7NiNTob0R/B9lni7Yzi7NBzkVjtXU9A9g/iZB+qnTccoRd8X+
 ivoVMUZ9FDNkx/4v6CQrwSVty5COpKuQSgHpCd/pXLyjpITIJJOUipE48iHBXaClxznZYce/f
 5ZEvctDuepkPs8I3CmTalSOj9cxmEu0x5xUGSf8/5CRaiF0gdsLSkQ8GFcHjxDkYejZCNxBJ6
 DfQBBtquICrnHsz74AOxYee+8cWPwqrYVtBgD+ObXEMe83kSB6XJvzefwNexjwBTHUvJf4kdh
 7Vk5JIQ+AO1vlnI/9dqk+1WstVXECaUn/WPbzBH4HYpWoIeRn6yd5Qd0sortHYRARYg3Q8vCP
 RHdvGIg3DG8nQhPiz6U0w4rg76++mVh2OgSUj5N08upm4IdA/WLVMS4dPFUwZn+RDeewYg2VY
 gHWgpmDB/9B6WFXxeL1cwtdGfS0=
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/6/6 17:35, Filipe Manana wrote:
> On Tue, Jun 6, 2023 at 4:20=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrote:
>>
>> There is a regression on btrfs read-only scrub behavior.
>>
>> The commit e02ee89baa66 ("btrfs: scrub: switch scrub_simple_mirror() to
>> scrub_stripe infrastructure") makes btrfs scrub to ignore the read-only
>> flag completely, causing scrub to always fix the corruption.
>>
>> This test case would create an fs with repairable corruptions, then run
>> a read-only scrub, and finally to make sure the corruption is not
>> repaired.
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>>   tests/btrfs/288     | 65 ++++++++++++++++++++++++++++++++++++++++++++=
+
>>   tests/btrfs/288.out | 39 +++++++++++++++++++++++++++
>>   2 files changed, 104 insertions(+)
>>   create mode 100755 tests/btrfs/288
>>   create mode 100644 tests/btrfs/288.out
>>
>> diff --git a/tests/btrfs/288 b/tests/btrfs/288
>> new file mode 100755
>> index 00000000..7795bdd9
>> --- /dev/null
>> +++ b/tests/btrfs/288
>> @@ -0,0 +1,65 @@
>> +#! /bin/bash
>> +# SPDX-License-Identifier: GPL-2.0
>> +# Copyright (C) 2023 SUSE Linux Products GmbH. All Rights Reserved.
>> +#
>> +# FS QA Test 288
>> +#
>> +# Make sure btrfs-scrub respects the read-only flag.
>> +#
>> +. ./common/preamble
>> +_begin_fstest auto repair quick volume scrub
>> +
>> +# For filedefrag and all the filters
>
> This comment is a bit confusing. File defrag? The test doesn't exercise =
defrag.
> Probably just leaving the comment out is better, it's obvious since we
> are using filters.
>
>> +. ./common/filter
>> +
>> +# real QA test starts here
>> +
>> +# Modify as appropriate.
>> +_supported_fs btrfs
>> +_require_scratch_dev_pool 2
>> +
>> +_require_odirect
>> +# Overwriting data is forbidden on a zoned block device
>> +_require_non_zoned_device "${SCRATCH_DEV}"
>
> Can we please get a _fixed_by_kernel_commit call to identify the patch
> that fixes the regression?

Unfortunately it's not yet merged, we only have the offending commit.

>
>> +
>> +_scratch_dev_pool_get 2
>> +
>> +# Step 1, create a raid btrfs with one 128K file
>> +echo "step 1......mkfs.btrfs"
>> +_scratch_pool_mkfs -d raid1 -b 1G >> $seqres.full 2>&1
>> +_scratch_mount
>> +
>> +$XFS_IO_PROG -f -d -c "pwrite -S 0xaa -b 128K 0 128K" "$SCRATCH_MNT/fo=
obar" |\
>> +       _filter_xfs_io_offset
>
> So why do we filter offsets?
> Why not just a plain _filter_xfs_io as we most commonly do?

Oh yep, that's better.

Thanks for the review,
Qu

>
> Thanks.
>
>> +
>> +# Step 2, corrupt one mirror so we can still repair the fs.
>> +echo "step 2......corrupt one mirror"
>> +# ensure btrfs-map-logical sees the tree updates
>> +sync
>> +
>> +logical=3D$(_btrfs_get_first_logical $SCRATCH_MNT/foobar)
>> +
>> +physical1=3D$(_btrfs_get_physical ${logical} 1)
>> +devpath1=3D$(_btrfs_get_device_path ${logical} 1)
>> +
>> +_scratch_unmount
>> +
>> +echo " corrupt stripe #1, devpath $devpath1 physical $physical1" \
>> +       >> $seqres.full
>> +$XFS_IO_PROG -d -c "pwrite -S 0xf1 -b 64K $physical1 64K" $devpath1 \
>> +       > /dev/null
>> +
>> +
>> +# Step 3, do a read-only scrub, which should not fix the corruption.
>> +_scratch_mount -o ro
>> +$BTRFS_UTIL_PROG scrub start -BRrd $SCRATCH_MNT >> $seqres.full 2>&1
>> +_scratch_unmount
>> +
>> +# Step 4, make sure the corruption is still there
>> +$XFS_IO_PROG -d -c "pread -v -b 512 $physical1 512" $devpath1 |\
>> +       _filter_xfs_io_offset
>> +
>> +_scratch_dev_pool_put
>> +# success, all done
>> +status=3D0
>> +exit
>> diff --git a/tests/btrfs/288.out b/tests/btrfs/288.out
>> new file mode 100644
>> index 00000000..c6c8e886
>> --- /dev/null
>> +++ b/tests/btrfs/288.out
>> @@ -0,0 +1,39 @@
>> +QA output created by 288
>> +step 1......mkfs.btrfs
>> +wrote 131072/131072 bytes
>> +XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>> +step 2......corrupt one mirror
>> +XXXXXXXX:  f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1  ..........=
......
>> +XXXXXXXX:  f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1  ..........=
......
>> +XXXXXXXX:  f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1  ..........=
......
>> +XXXXXXXX:  f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1  ..........=
......
>> +XXXXXXXX:  f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1  ..........=
......
>> +XXXXXXXX:  f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1  ..........=
......
>> +XXXXXXXX:  f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1  ..........=
......
>> +XXXXXXXX:  f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1  ..........=
......
>> +XXXXXXXX:  f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1  ..........=
......
>> +XXXXXXXX:  f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1  ..........=
......
>> +XXXXXXXX:  f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1  ..........=
......
>> +XXXXXXXX:  f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1  ..........=
......
>> +XXXXXXXX:  f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1  ..........=
......
>> +XXXXXXXX:  f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1  ..........=
......
>> +XXXXXXXX:  f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1  ..........=
......
>> +XXXXXXXX:  f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1  ..........=
......
>> +XXXXXXXX:  f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1  ..........=
......
>> +XXXXXXXX:  f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1  ..........=
......
>> +XXXXXXXX:  f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1  ..........=
......
>> +XXXXXXXX:  f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1  ..........=
......
>> +XXXXXXXX:  f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1  ..........=
......
>> +XXXXXXXX:  f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1  ..........=
......
>> +XXXXXXXX:  f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1  ..........=
......
>> +XXXXXXXX:  f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1  ..........=
......
>> +XXXXXXXX:  f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1  ..........=
......
>> +XXXXXXXX:  f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1  ..........=
......
>> +XXXXXXXX:  f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1  ..........=
......
>> +XXXXXXXX:  f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1  ..........=
......
>> +XXXXXXXX:  f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1  ..........=
......
>> +XXXXXXXX:  f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1  ..........=
......
>> +XXXXXXXX:  f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1  ..........=
......
>> +XXXXXXXX:  f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1  ..........=
......
>> +read 512/512 bytes
>> +XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>> --
>> 2.39.0
>>
