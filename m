Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1998B532B4F
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 May 2022 15:29:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236104AbiEXN2a (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 24 May 2022 09:28:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233673AbiEXN23 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 24 May 2022 09:28:29 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2C2F99685;
        Tue, 24 May 2022 06:28:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1653398905;
        bh=KkgrfHFDxocqVQTtDL+WqtOBrGmgcXBZUiemoXpMmbE=;
        h=X-UI-Sender-Class:Date:To:Cc:References:From:Subject:In-Reply-To;
        b=gQOygaNreapnXSLo8j1CWeeWo7Y+iTegmDO+Dk4+YG2ceF2IqdpkeRzCcvXKJepT0
         GBijM7HHZc+OrseCBBupNrTPYYV38OLAv91h5aeuH35FLoS6db4Y43cM+wnxNX67lJ
         SVld0CIDnHsMXJomatW7Hbwt0rKPYrxML3+LnL5k=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M72sJ-1nvO7j3MOF-008db1; Tue, 24
 May 2022 15:28:25 +0200
Message-ID: <6b7fa64f-7a20-639f-3820-edf52b4813f2@gmx.com>
Date:   Tue, 24 May 2022 21:28:21 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org
References: <20220524071838.715013-1-hch@lst.de>
 <20220524071838.715013-9-hch@lst.de>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [PATCH 8/9] btrfs: test repair with sectors corrupted in multiple
 mirrors
In-Reply-To: <20220524071838.715013-9-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:7PzE4dah5eQB+5j5CRHSRxfAvtUPGEBRE7w1oVgWocONXDmSTFL
 vPN1SgDsFYKa+YnWC9nMHEqGdSaZ8PC+VcpB0tOCVPew+ife7JtOvfy0843eRPkUSRDagcm
 I4UFBvm0DkM+mhIRtWN4cA/OeHmWrZ+HKPDYVJVNUVUNU2Oq98Uq0LAes/yAfeD1LKdqsh0
 hf/VRNFq1oXBgE+XuuIZg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:HSPR82JQL2c=:fBUqslTA/t9ZldWqo1Jb7f
 M6VSlBEyWTj7UPy3tyC1bD6qpcvE+AzhdRMgoZdSU+hynrP4X4f3bqY6Q61sHdbuCKRSQl3Ap
 vCcmsFtWP0uv67yilD+vN4qkgrDlTtdNL/g9TsgBYBljRBdGP5Qem529eR/J1zhuAwkB9AGaE
 Kef0bvxNk37je5v7aPCv8XUhdofUOxtUd54ApYQ0BgxruAtYSbd3PpNL/pRenInB5rcobwsny
 LggkaCqTLK2cyFVoN0zQaq2+ZLf13EQFO4BqGOz6O54vO3UWwO7G/TImo7AQ3rV7hg1O0bQYV
 nhZeqsYBv9gJFy1PPOp3kDhEKte1A2/P+eyGIqwDJkXx7KZLe2lUkcg2MUmzr6krAQan+IZUC
 KGDi/7NXkhkP3ujkDd6f3Q2YETrIu9/3DYCxRavp3Pri/9kaujdqXXo2xPsM/qgGbRyWwYNpK
 ZRv6SNDf36rAt0eEdRfNlFtxZoJtK6AOiGeYwUjQfj6NNOqGUSFrQ7VYKSlLyHnyG2YSKp/Ad
 lw7pNuvk6IOIDe7QJJDABKnEZftJfxeHDvG6o1nQXhpZQNIFC37bzkkY8aXSuOm3nQzvRCCp9
 x7mhTRTV/FG+7rap/BEHeELVNxUchK+pKKvtjjSnXXX2SDjsN1cAWrfSibUbZNsCtYH9h13GA
 vsh4DCUrjobVBbYllu0r0+VHjXnWB00DVB+MI9KOTc6sEErIip5RS1OSyRv0XYwKVDH43NPeW
 adQI9zTCxsO9xfMABUTbi2L8Sg28bCX8wNJ9EW64J3vg8GLKq7JKYCB1Ex54mk8QVOYBZoXdJ
 UhbV7FVT6Wj3gdicnZEXWnddq3Gt6Zxhjuz6rrHK+iOF7RC8JHLxTRPCHsabLm/N2Ck7hD6Hd
 newZaNbb9vA7yCpzzTA0yI4rJjmoSsdTERZ0bYEZQDQBRSElQk3Jxd4KziPkVoPrQoQrmuXoy
 FJACslUk/Yw4IYccOf+rAbHXprti9a93HFcmIvBu2OJiyVoDHdqFPlXgP/87D/W5gh1apH7ly
 20MI9AZr+mEZBvPHfaSxVyrV1ElTVwjQDTqvfHVPweT5tEymbz4HSq1LA93/BHQS2bFJVTHO3
 Prccv1E+R6Ca/ucOLydbpWdLJlmcmxpFCI7gYZ0ZDYaebF/wy75MoorRw==
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/5/24 15:18, Christoph Hellwig wrote:
> Test that repair handles the case where it needs to read from more than
> a single mirror on the raid1c3 profile.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Just a cosmetic nitpick inlined below.

> ---
>   tests/btrfs/265     | 86 +++++++++++++++++++++++++++++++++++++++++++++
>   tests/btrfs/265.out | 75 +++++++++++++++++++++++++++++++++++++++
>   2 files changed, 161 insertions(+)
>   create mode 100755 tests/btrfs/265
>   create mode 100644 tests/btrfs/265.out
>
> diff --git a/tests/btrfs/265 b/tests/btrfs/265
> new file mode 100755
> index 00000000..b243ba0b
> --- /dev/null
> +++ b/tests/btrfs/265
> @@ -0,0 +1,86 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2017 Liu Bo.  All Rights Reserved.
> +# Copyright (c) 2022 Christoph Hellwig.
> +#
> +# FS QA Test 265
> +#
> +# Test that btrfs raid repair on a raid1c3 profile can repair corruptio=
n on two
> +# mirrors for the same logical offset.
> +#
> +. ./common/preamble
> +_begin_fstest auto quick read_repair
> +
> +# Import common functions.
> +. ./common/filter
> +
> +# real QA test starts here
> +
> +_supported_fs btrfs
> +_require_scratch_dev_pool 3
> +
> +_require_odirect
> +# Overwriting data is forbidden on a zoned block device
> +_require_non_zoned_device "${SCRATCH_DEV}"
> +
> +_scratch_dev_pool_get 3
> +# step 1, create a raid1 btrfs which contains one 128k file.
> +echo "step 1......mkfs.btrfs"
> +
> +mkfs_opts=3D"-d raid1c3 -b 1G"
> +_scratch_pool_mkfs $mkfs_opts >>$seqres.full 2>&1
> +
> +# make sure data is written to the start position of the data chunk

This comment is definitely from old test cases.

Now it's obsolete in several ways:

- We have solid reasons that btrfs can write the new data into the
   middle of an empty chunk

   The full details explanation can be found here:

https://lore.kernel.org/linux-btrfs/e636ebd2-2e67-0e94-9758-925df5a89557@g=
mx.com/T/#u

- Now with the new helpers, we no longer relies on the extent layout

So we don't need the comment, nor the `_btrfs_no_v1_cache_opt` here.

Thanks,
Qu

> +_scratch_mount $(_btrfs_no_v1_cache_opt)
> +
> +$XFS_IO_PROG -f -d -c "pwrite -S 0xaa -b 128K 0 128K" \
> +	"$SCRATCH_MNT/foobar" | \
> +	_filter_xfs_io_offset
> +
> +# step 2, corrupt the first 64k of one copy (on SCRATCH_DEV which is th=
e first
> +# one in $SCRATCH_DEV_POOL
> +echo "step 2......corrupt file extent"
> +
> +# ensure btrfs-map-logical sees the tree updates
> +sync
> +
> +logical=3D$(_btrfs_get_first_logical $SCRATCH_MNT/foobar)
> +
> +physical1=3D$(_btrfs_get_physical ${logical} 1)
> +devpath1=3D$(_btrfs_get_device_path ${logical} 1)
> +
> +physical2=3D$(_btrfs_get_physical ${logical} 2)
> +devpath2=3D$(_btrfs_get_device_path ${logical} 2)
> +
> +_scratch_unmount
> +
> +echo " corrupt stripe #1, devpath $devpath1 physical $physical1" \
> +	>> $seqres.full
> +$XFS_IO_PROG -d -c "pwrite -S 0xbf -b 64K $physical1 64K" $devpath1 \
> +	> /dev/null
> +
> +echo " corrupt stripe #2, devpath $devpath2 physical $physical2" \
> +	>> $seqres.full
> +$XFS_IO_PROG -d -c "pwrite -S 0xbf -b 64K $physical2 64K" $devpath2 \
> +	> /dev/null
> +
> +_scratch_mount
> +
> +# step 3, 128k dio read (this read can repair bad copy)
> +echo "step 3......repair the bad copy"
> +
> +_btrfs_direct_read_on_mirror 0 3 "$SCRATCH_MNT/foobar" 0 128K
> +_btrfs_direct_read_on_mirror 1 3 "$SCRATCH_MNT/foobar" 0 128K
> +
> +_scratch_unmount
> +
> +echo "step 4......check if the repair worked"
> +$XFS_IO_PROG -d -c "pread -v -b 512 $physical1 512" $devpath1 |\
> +	_filter_xfs_io_offset
> +$XFS_IO_PROG -d -c "pread -v -b 512 $physical2 512" $devpath2 |\
> +	_filter_xfs_io_offset
> +
> +_scratch_dev_pool_put
> +# success, all done
> +status=3D0
> +exit
> diff --git a/tests/btrfs/265.out b/tests/btrfs/265.out
> new file mode 100644
> index 00000000..c62c7a39
> --- /dev/null
> +++ b/tests/btrfs/265.out
> @@ -0,0 +1,75 @@
> +QA output created by 265
> +step 1......mkfs.btrfs
> +wrote 131072/131072 bytes
> +XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +step 2......corrupt file extent
> +step 3......repair the bad copy
> +step 4......check if the repair worked
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ...........=
.....
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ...........=
.....
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ...........=
.....
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ...........=
.....
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ...........=
.....
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ...........=
.....
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ...........=
.....
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ...........=
.....
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ...........=
.....
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ...........=
.....
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ...........=
.....
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ...........=
.....
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ...........=
.....
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ...........=
.....
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ...........=
.....
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ...........=
.....
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ...........=
.....
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ...........=
.....
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ...........=
.....
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ...........=
.....
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ...........=
.....
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ...........=
.....
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ...........=
.....
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ...........=
.....
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ...........=
.....
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ...........=
.....
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ...........=
.....
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ...........=
.....
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ...........=
.....
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ...........=
.....
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ...........=
.....
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ...........=
.....
> +read 512/512 bytes
> +XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ...........=
.....
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ...........=
.....
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ...........=
.....
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ...........=
.....
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ...........=
.....
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ...........=
.....
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ...........=
.....
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ...........=
.....
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ...........=
.....
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ...........=
.....
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ...........=
.....
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ...........=
.....
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ...........=
.....
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ...........=
.....
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ...........=
.....
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ...........=
.....
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ...........=
.....
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ...........=
.....
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ...........=
.....
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ...........=
.....
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ...........=
.....
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ...........=
.....
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ...........=
.....
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ...........=
.....
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ...........=
.....
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ...........=
.....
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ...........=
.....
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ...........=
.....
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ...........=
.....
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ...........=
.....
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ...........=
.....
> +XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ...........=
.....
> +read 512/512 bytes
> +XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
