Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A8934BD018
	for <lists+linux-btrfs@lfdr.de>; Sun, 20 Feb 2022 18:10:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238077AbiBTRIC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 20 Feb 2022 12:08:02 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbiBTRIA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 20 Feb 2022 12:08:00 -0500
Received: from out20-51.mail.aliyun.com (out20-51.mail.aliyun.com [115.124.20.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3D16433AF;
        Sun, 20 Feb 2022 09:07:38 -0800 (PST)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07479047|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0254344-0.00384722-0.970718;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047207;MF=guan@eryu.me;NM=1;PH=DS;RN=3;RT=3;SR=0;TI=SMTPD_---.Msqt-kA_1645376856;
Received: from localhost(mailfrom:guan@eryu.me fp:SMTPD_---.Msqt-kA_1645376856)
          by smtp.aliyun-inc.com(33.45.119.179);
          Mon, 21 Feb 2022 01:07:36 +0800
Date:   Mon, 21 Feb 2022 01:07:35 +0800
From:   Eryu Guan <guan@eryu.me>
To:     Gabriel Niebler <gniebler@suse.com>
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] fstests: fix btrfs/255 to fail on deadlock
Message-ID: <YhJ1VwUqPWkgPx2V@desktop>
References: <20220216100535.4231-1-gniebler@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220216100535.4231-1-gniebler@suse.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Feb 16, 2022 at 11:05:35AM +0100, Gabriel Niebler wrote:
> In its current implementation, the test btrfs/255 would hang forever
> on any kernel w/o patch "btrfs: fix deadlock between quota disable
> and qgroup rescan worker", rather than failing, as it should.
> Fix this by introducing generous timeouts.
> 
> Signed-off-by: Gabriel Niebler <gniebler@suse.com>

If deadlock was already triggered, I don't think killing the userspace
program with timeout will help, as the kernel already deadlocked, and
filesystem and/or device can't be used by next test either.

I think we should just exclude the test when running tests on unpatched
kernel.

Thanks,
Eryu

> ---
>  tests/btrfs/255 | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)
> 
> diff --git a/tests/btrfs/255 b/tests/btrfs/255
> index 7e70944a..4c779458 100755
> --- a/tests/btrfs/255
> +++ b/tests/btrfs/255
> @@ -14,6 +14,7 @@ _begin_fstest auto qgroup balance
>  
>  # real QA test starts here
>  _supported_fs btrfs
> +_require_command "$TIMEOUT_PROG" timeout
>  _require_scratch
>  
>  _scratch_mkfs >> $seqres.full 2>&1
> @@ -37,15 +38,23 @@ done
>  _btrfs_stress_balance $SCRATCH_MNT >> $seqres.full &
>  balance_pid=$!
>  echo $balance_pid >> $seqres.full
> +timeout=$((30 * 60))
>  for ((i = 0; i < 20; i++)); do
> -	$BTRFS_UTIL_PROG quota enable $SCRATCH_MNT
> -	$BTRFS_UTIL_PROG quota disable $SCRATCH_MNT
> +	$TIMEOUT_PROG -s KILL ${timeout}s $BTRFS_UTIL_PROG quota enable $SCRATCH_MNT
> +	[ $? -eq 0 ] || _fail "quota enable timed out"
> +	$TIMEOUT_PROG -s KILL ${timeout}s $BTRFS_UTIL_PROG quota disable $SCRATCH_MNT
> +	[ $? -eq 0 ] || _fail "quota disable timed out"
>  done
>  kill $balance_pid &> /dev/null
> -wait
> +
>  # wait for the balance operation to finish
> +elapsed=0
>  while ps aux | grep "balance start" | grep -qv grep; do
> +	if [ $elapsed -gt $timeout ]; then
> +		_fail "balance not finished after $timeout seconds"
> +	fi
>  	sleep 1
> +	elapsed=$(( ++elapsed ))
>  done
>  
>  echo "Silence is golden"
> -- 
> 2.35.1
