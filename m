Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9DE34EAB2C
	for <lists+linux-btrfs@lfdr.de>; Tue, 29 Mar 2022 12:22:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235117AbiC2KXq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 29 Mar 2022 06:23:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235125AbiC2KWx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 29 Mar 2022 06:22:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB649E025;
        Tue, 29 Mar 2022 03:21:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D28ED61194;
        Tue, 29 Mar 2022 10:21:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE0E4C3410F;
        Tue, 29 Mar 2022 10:21:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648549268;
        bh=1ANO9Lo1sojOZqkPtzcdK9gqsV//54mXWnVR798ohRU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YsdoVbdPcMXh0SvDUEy+8Il2NJf2CqGixuDurlAeDkZ0IvmgrnOikAmsCSwiiwEjM
         Fcd1Ri+j2YzwP4s0XEVVOaJ/RqJK/845H6XkW4Abwdn2J85P011GLnxuzoz412UPeB
         8RDGxqXV7O1Bo3WqfGod9J5yieAwvROphynBhQWLjxOB3Ftq16cRIjgEZ2Gi9LoKPo
         qsP8QDksgKty9AOugfN4uibXoFv6iEwmU8L5V+YHcoD/oLkeythkRZYGDfy7CkmN7d
         KwiJFZeii9UXQsdozuzXF39ayPUupPChnJ8biU7KLS53p6SSWyn2i5+jnSwzXSzY4A
         7nRD1yTmmEpSA==
Date:   Tue, 29 Mar 2022 11:21:05 +0100
From:   Filipe Manana <fdmanana@kernel.org>
To:     Kaiwen Hu <kevinhu@synology.com>
Cc:     linux-btrfs@vger.kernel.org, fstests@vger.kernel.org,
        robbieko@synology.com, cccheng@synology.com, seanding@synology.com
Subject: Re: [PATCH] btrfs: test that we can't delete subvolume within
 swapfile
Message-ID: <YkLdkbw/DeV1grHP@debian9.Home>
References: <20220329100201.1502010-1-kevinhu@synology.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220329100201.1502010-1-kevinhu@synology.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Mar 29, 2022 at 06:02:02PM +0800, Kaiwen Hu wrote:
> Subvolumes with active swapfiles should be forbidden
> to be deleted, because when the subvolume is deleted,
> we cannot swapoff the swapfile in the deleted subvolume.
> 
> Fixed by the patch
> 	btrfs: prevent subvol with swapfile from being deleted
> 
> Reviewed-by: Robbie Ko <robbieko@synology.com>
> Signed-off-by: Kaiwen Hu <kevinhu@synology.com>
> ---
>  tests/btrfs/174     | 10 ++++++++++
>  tests/btrfs/174.out |  3 +++
>  2 files changed, 13 insertions(+)

Thanks for doing this.

However we don't change existing tests to exercise bugs.

The few exceptions where we change an existing test case are, typically,
if the test case is very recent and we didn't get it quite right, or
if we had a filesystem behaviour change that makes the test fail - like
for example the recent changes that allow cross mount reflink operations.

So this should be a new test case.

> 
> diff --git a/tests/btrfs/174 b/tests/btrfs/174
> index 3bb5e7f9..08d4af40 100755
> --- a/tests/btrfs/174
> +++ b/tests/btrfs/174
> @@ -11,6 +11,7 @@
>  _begin_fstest auto quick swap
>  
>  . ./common/filter
> +. ./common/filter.btrfs
>  
>  _supported_fs btrfs
>  _require_scratch_swapfile
> @@ -43,7 +44,16 @@ echo "Defrag"
>  # fragmented.
>  $BTRFS_UTIL_PROG filesystem defrag -c "$swapfile" 2>&1 | grep -o "Text file busy"
>  
> +# We cannot delete sub-volume when the sub-volume contains active swapfile.
> +echo "Delete subvol"
> +$BTRFS_UTIL_PROG subvolume delete "$SCRATCH_MNT/swapvol" \
> +	2>&1 | grep -o "Text file busy"
> +
>  swapoff "$swapfile"
> +
> +# Delete the sub-volume
> +$BTRFS_UTIL_PROG subvolume delete $SCRATCH_MNT/swapvol | _filter_btrfs_subvol_delete
> +
>  _scratch_unmount
>  
>  status=0
> diff --git a/tests/btrfs/174.out b/tests/btrfs/174.out
> index 15bdf79e..8bed461b 100644
> --- a/tests/btrfs/174.out
> +++ b/tests/btrfs/174.out
> @@ -8,3 +8,6 @@ Snapshot
>  Text file busy
>  Defrag
>  Text file busy
> +Delete subvol
> +Text file busy
> +Delete subvolume 'SCRATCH_MNT/swapvol'
> -- 
> 2.25.1
> 
