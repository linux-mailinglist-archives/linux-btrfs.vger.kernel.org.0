Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0FB9627C2A
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Nov 2022 12:24:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236435AbiKNLYd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 14 Nov 2022 06:24:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236458AbiKNLYP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 14 Nov 2022 06:24:15 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D58826AE8;
        Mon, 14 Nov 2022 03:19:58 -0800 (PST)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MiJZO-1pQ2Z03oKE-00fOxX; Mon, 14
 Nov 2022 12:19:49 +0100
Message-ID: <e2917c47-98b8-7236-4952-7c1be74e3946@gmx.com>
Date:   Mon, 14 Nov 2022 19:19:45 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Content-Language: en-US
To:     fdmanana@kernel.org, fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
References: <cover.1668011769.git.fdmanana@suse.com>
 <62ef22111c9cb654e6e5e50f7337105b9ef804d7.1668011769.git.fdmanana@suse.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [PATCH v2 1/3] btrfs/003: fix failure on new btrfs-progs versions
In-Reply-To: <62ef22111c9cb654e6e5e50f7337105b9ef804d7.1668011769.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:Mst8tHXG762uz5cFfsRpK2COEAp73GWM+7yGpjzYqmBGqKubuga
 MlcfnGWIOo+c48LY04CiqgXCVWL0aNJad6tcoeEz2exAXmcf1GueZYsXqohHnic/4i3avxu
 dB/hJo/7dxOc05347VykZ3ucozJcjk9ovHcb++woeLZMb09gBc4AvhoEHfV+WLc/CRA5DYy
 dKtKudnjEatWSna2NpUCQ==
UI-OutboundReport: notjunk:1;M01:P0:3/HBKFO++SU=;M0F1RLarP5Kd8rTDx6mtO0rZFjv
 5fBYJzTazWmxRQhWPggY+vqeXK/IymxG4wUbfAMdeoodElMIQI7ed3YtsgkztEG5z1hpcN+qG
 O6xFE952l8mSvjkbYHBBY30PhECXqZ8wff+K/qiVOsevouq0GlUBb22WfG6uXYCtn5Yrx72WM
 wfScDxKtLtuucH4Yqxj0+D0Ow214Q8bSEoHtxZSmbD/5EaFCALsjECD0iuyR9js5OGOexhIa6
 2sqYzuzoBHcf/py3DvlP6mnny42eKd31HoLULA6Tx1W2HVjCogRc/qq6luYOIQQ+XNtKstkMU
 Be5sZVEwC+abY1q8hygqR537rsb9M2WBvX0hy75wu9WH9w9dfwGuIdyhLdBL/XPntsbDAo4hq
 JPNap6Bn0i9KrCyEpMGfyQ4fB72k4QIF5iCGCyF9PwZmRDqgRsXyILuIaxmwokZKoXJUjUQpe
 AeSfR2vJHsCBh09WB2oWlS3I0a07twfWNdV3TugrprD6rwbNlYaDA9Or+kT28TPLz6CYFYemZ
 tq2kR3pj59ykSSIsQ67+KFh2aMbsP6rZY+FK8f0psPZiJ/OoeYQjzWQR0BjW+K/nta5s0Q9fK
 WAmH5s+/UE7ypg5R3xByOHtwOucfsKVd9HoXeKbbPV3v9K9Rh1Peu8IqJPRkI+p1gIqVVJjw1
 XQluJ7gG3Td1mKCFz267UHJB138iilm9p6szrC7asu+uLnKfi9AwhQvr7EACLxq1BlvEvjy0U
 YDv/SqN3T6fd0v7pp2QqITqpbIvFquxfndDUkrJ50F9VfyVDdBS1wWP2L6rMh0uZBQMfmJywm
 4dlTrdWyGfY2PSjfwbOGhffEmnMHyMkWv/l9OMH39l7OqZYzONEu1lg9/l5ZDhtDAy/m+tM6u
 orpXHdReem973kExC5irnZpSKQxaLPm53EqHB6B+b2anJVfOlOzGjunFIZQHVDJ0y8sJbC53w
 wr1t91zVHwc3a29pGmYLHg8kI54=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/11/10 00:44, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Starting with btrfs-progs version 5.19, the output of 'filesystem show'
> command changed when we have a missing device. The old output was like the
> following:
> 
>      Label: none  uuid: 139ef309-021f-4b98-a3a8-ce230a83b1e2
>              Total devices 2 FS bytes used 128.00KiB
>              devid    1 size 5.00GiB used 1.26GiB path /dev/loop0
>              *** Some devices missing
> 
> While the new output (btrfs-progs 5.19+) is like the following:
> 
>      Label: none  uuid: 4a85a40b-9b79-4bde-8e52-c65a550a176b
>              Total devices 2 FS bytes used 128.00KiB
>              devid    1 size 5.00GiB used 1.26GiB path /dev/loop0
>              devid    2 size 0 used 0 path /dev/loop1 MISSING
> 
> More specifically it happened in the following btrfs-progs commit:
> 
>      957a79c9b016 ("btrfs-progs: fi show: print missing device for a mounted file system")
> 
> This is making btrfs/003 fail with btrfs-progs 5.19+. Update the grep
> filter in btrfs/003 so that it works with both output formats.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

After more digging, it shows that the test case itself will skip 
non-deletable disks, thus it doesn't cover my LVM based test environment 
at all.

Thanks,
Qu

> ---
>   tests/btrfs/003 | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/tests/btrfs/003 b/tests/btrfs/003
> index cf605730..fae6d9d1 100755
> --- a/tests/btrfs/003
> +++ b/tests/btrfs/003
> @@ -141,8 +141,9 @@ _test_replace()
>   	_devmgt_remove ${removed_dev_htl} $ds
>   	dev_removed=1
>   
> -	$BTRFS_UTIL_PROG filesystem show $SCRATCH_DEV | grep "Some devices missing" >> $seqres.full || _fail \
> -							"btrfs did not report device missing"
> +	$BTRFS_UTIL_PROG filesystem show $SCRATCH_DEV | \
> +		grep -ie '\bmissing\b' >> $seqres.full || \
> +		_fail "btrfs did not report device missing"
>   
>   	# add a new disk to btrfs
>   	ds=${devs[@]:$(($n)):1}
