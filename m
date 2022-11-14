Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96CBF627BCC
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Nov 2022 12:12:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236600AbiKNLMw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 14 Nov 2022 06:12:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236619AbiKNLM1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 14 Nov 2022 06:12:27 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5114C25C58;
        Mon, 14 Nov 2022 03:09:03 -0800 (PST)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MlNp7-1pOclR2l8H-00ll4G; Mon, 14
 Nov 2022 12:08:57 +0100
Message-ID: <4bb1fde6-5853-8a4f-bf9d-1488d6e92283@gmx.com>
Date:   Mon, 14 Nov 2022 19:08:53 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH v2 2/3] btrfs/053: fix test failure when running with
 btrfs-progs v6.0+
Content-Language: en-US
To:     fdmanana@kernel.org, fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
References: <cover.1668011940.git.fdmanana@suse.com>
 <793a063833727ea80a1d0c6f13f531cff9581a1a.1668011940.git.fdmanana@suse.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <793a063833727ea80a1d0c6f13f531cff9581a1a.1668011940.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:VX7s9hHmHQjEo7sjOh1hWMAw3jRAzaVOJ/YSD8a8U1rYmqxyNP8
 PB+OIOCWtF7DksuT33L31YpmwPYIRDht/HH2h8U2Tv5/laRpnbb9agnezlVnG1VSEJpXcTU
 aClt5swgZP1QfJ/FvtaI9EhHnUreoOyM/D21c7HRhECh9H6V2VfHiLR2iw55E6NdbbSOLVv
 TLPIZxqFx1QNxFpL4FoKg==
UI-OutboundReport: notjunk:1;M01:P0:VAIM9Of5FCI=;BinJvHbyM1462vZBBifVm/T1SA4
 UmJYB9OSP0/r8+oXBtgBJMYpOSIQANLWYF2MifV8quxsE5I9rrbC/AYZuwvDQXNCmSBuuSl2U
 XKLHVYXlPbSXhqRrMzT6mgB/01+Bh23UrmLQdQiyCb/oE9cSkILWdHCBY2lmiu9WdYLjK6IEM
 nYozV/Y/quUjHPB9B3Z4J1gD6sRQz6p6Pl8SVObND8eJ6a+zGEVesfc/yNipNHHWfnLKCDwiN
 I7nK2ayzWnC6BRJ3DBMiBWej/f3cYFYnqgAlhJolsBMCSe0SSXJLAtP+NdfC50oiNiVTBKNzn
 B0riUrWYTzAj0FJ+bGOxnuqLljWNAGxn/c4HAN4DcL1tg+HAE6ZWHuTxYCSOb6k3+BfhSj4qE
 zC4HA420fU6BPx2LhgiIWTqZazBuZcVRKyOkYxGALTKCPhwvXyDvhrjpBD0Ec2PwVy5KNtvYD
 B+tj+CUQdAvIiUU+SAo3iBusk8QyckWpP+ztdhc5CwpFUfHtTUTrb7MpsAf7MreYyuC12koWe
 N6qbGRWmeQxSvpcTLb6ouKhh+19E3u2o/1wQOzmgAPXrOgrickch9MLrOJzjnvOHh+dnovdU3
 DILYTbt8C/TrAFwU9j8mW1yd2SFhqj+y7mdoqP/y3Qc1uEgzY5vphN4lpCTLs0809Cq117vXu
 wYGsGwgr7bFmoMn++s2tqJ0H7eKHl6wEstJbvgBSa9Ghb7fF17V3KyDw5KE5LU3QV+vWrGs2r
 1E25i7+lNECdsWG67z43LfOosKv4h+U8pWR2iRFmBz1ljpbR6N7H/Fyg0/uSlBua6buFVXrzq
 sGop/CCmDfRSuPZHGzrKsQtNCjc+zMP1R18BlnAgZPt6ePHdx+5aNA/IuERap8KWTx2dIbTwF
 qxg5MYvMxn8tqKS6wsZQySqpc2qx3edjme5kUgt7N/46T8L74udRRhn4j/pl3JI2TuFjQdRrp
 mlQ9r+a1s1umC57KOKRJF3oT+7U=
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
> In btrfs-progs v6.0 the --leafsize (-l) command line option was removed
> from mkfs.btrfs, so btrfs/053 can fail with v6.0+ in case the scratch
> device does not have a btrfs filesystem created before running the test,
> in which case mounting the scratch device fails.
> 
> The change was introduced by the following btrfs-progs commit:
> 
>    f7a768d62498 ("btrfs-progs: mkfs: remove support for option --leafsize")
> 
> Change the test to use --nodesize (-n) instead, since it exists in both
> old and new btrfs-progs versions. Also redirect mkfs output to the test's
> log file and fail explicitly if mkfs failed.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>   tests/btrfs/053 | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tests/btrfs/053 b/tests/btrfs/053
> index fbd2e7d9..67239f10 100755
> --- a/tests/btrfs/053
> +++ b/tests/btrfs/053
> @@ -44,7 +44,7 @@ send_files_dir=$TEST_DIR/btrfs-test-$seq
>   rm -fr $send_files_dir
>   mkdir $send_files_dir
>   
> -_scratch_mkfs "-l $leaf_size" >/dev/null 2>&1
> +_scratch_mkfs "--nodesize $leaf_size" >> $seqres.full 2>&1 || _fail "mkfs failed"
>   _scratch_mount
>   
>   echo "hello world" > $SCRATCH_MNT/foobar
> @@ -72,7 +72,7 @@ _run_btrfs_util_prog send -p $SCRATCH_MNT/mysnap1 -f $send_files_dir/2.snap \
>   _scratch_unmount
>   _check_scratch_fs
>   
> -_scratch_mkfs "-l $leaf_size" >/dev/null 2>&1
> +_scratch_mkfs "--nodesize $leaf_size" >> $seqres.full 2>&1 || _fail "mkfs failed"
>   _scratch_mount
>   
>   _run_btrfs_util_prog receive -f $send_files_dir/1.snap $SCRATCH_MNT
