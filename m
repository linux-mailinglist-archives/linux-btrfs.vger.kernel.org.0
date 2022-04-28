Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3E365137E7
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Apr 2022 17:13:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348915AbiD1PQX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 28 Apr 2022 11:16:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345202AbiD1PQW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 28 Apr 2022 11:16:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6696169CC7;
        Thu, 28 Apr 2022 08:13:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F357661F3B;
        Thu, 28 Apr 2022 15:13:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5245FC385A0;
        Thu, 28 Apr 2022 15:13:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651158787;
        bh=YmTzsyBY8wtMBLxETN1cWIZCKSqnwg+rGNvlGsrNoc0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WgbzYEkF+5VS7YeIcjrKMKLt02iYGJOuQgApJcM2oiZZ2gSxsotTBDOBun6IJQ8SA
         txER8pf7+XI+eFwA4hcKLOXotuSWA/Zwc3RrY4jFVvmni9rSt0HXQ+s4do6r07KjmF
         ek4qDMyUopzWNrjVHlIotvvxplq5Yh0/TQv/WEwJhEskhTLtsc9a55Qs3Wygi4h+ox
         eGKlO70Ho8eMms1P6Japbr12qP9xl3ODFBhlI/XB4fhFuNpPRbsmRgMH9uFu0kOSph
         Nowi0xWumCtxhi5dj7Sqv5QuFJNj7Ji7xUH3VjAIeqfurX6xf67JMja6glUIcqqZWC
         fWF59YJ5NCH+A==
Date:   Thu, 28 Apr 2022 08:13:06 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] fstests: add some missing _require_loop's
Message-ID: <20220428151306.GO17014@magnolia>
References: <bd80e5861da3f901428ea66f271f8c4f267c4c23.1651158291.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bd80e5861da3f901428ea66f271f8c4f267c4c23.1651158291.git.josef@toxicpanda.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Apr 28, 2022 at 11:05:00AM -0400, Josef Bacik wrote:
> Got a new box running overnight fstests and noticed a couple of failures
> because I forgot to enable loop device support.  Fix these two tests to
> have _require_loop so they don't fail if there's no loop device support.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Yep, these both use loop mounts.

Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  tests/btrfs/012   | 1 +
>  tests/generic/648 | 1 +
>  2 files changed, 2 insertions(+)
> 
> diff --git a/tests/btrfs/012 b/tests/btrfs/012
> index 29552b14..60461a34 100755
> --- a/tests/btrfs/012
> +++ b/tests/btrfs/012
> @@ -30,6 +30,7 @@ _require_command "$MKFS_EXT4_PROG" mkfs.ext4
>  _require_command "$E2FSCK_PROG" e2fsck
>  # ext4 does not support zoned block device
>  _require_non_zoned_device "${SCRATCH_DEV}"
> +_require_loop
>  
>  BLOCK_SIZE=`_get_block_size $TEST_DIR`
>  
> diff --git a/tests/generic/648 b/tests/generic/648
> index e5c743c5..d7bf5697 100755
> --- a/tests/generic/648
> +++ b/tests/generic/648
> @@ -39,6 +39,7 @@ _require_scratch_reflink
>  _require_cp_reflink
>  _require_dm_target error
>  _require_command "$KILLALL_PROG" "killall"
> +_require_loop
>  
>  echo "Silence is golden."
>  
> -- 
> 2.26.3
> 
