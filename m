Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A9482F9350
	for <lists+linux-btrfs@lfdr.de>; Sun, 17 Jan 2021 16:13:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729543AbhAQPLt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 17 Jan 2021 10:11:49 -0500
Received: from out20-61.mail.aliyun.com ([115.124.20.61]:36018 "EHLO
        out20-61.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729527AbhAQPLc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 17 Jan 2021 10:11:32 -0500
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.1072974|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0852759-0.00026807-0.914456;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047190;MF=guan@eryu.me;NM=1;PH=DS;RN=4;RT=4;SR=0;TI=SMTPD_---.JLjGNwU_1610896234;
Received: from localhost(mailfrom:guan@eryu.me fp:SMTPD_---.JLjGNwU_1610896234)
          by smtp.aliyun-inc.com(10.147.41.187);
          Sun, 17 Jan 2021 23:10:34 +0800
Date:   Sun, 17 Jan 2021 23:10:34 +0800
From:   Eryu Guan <guan@eryu.me>
To:     Boris Burkov <boris@bur.io>
Cc:     fstests@vger.kernel.org, kernel-team@fb.com,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs/220: fix clear_cache and inode_cache option tests
Message-ID: <20210117151034.GB2347@desktop>
References: <409e4c73fefce666d151b043d6b2a0d821f8ef85.1610485406.git.boris@bur.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <409e4c73fefce666d151b043d6b2a0d821f8ef85.1610485406.git.boris@bur.io>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jan 12, 2021 at 01:17:47PM -0800, Boris Burkov wrote:
> I recently changed clear_cache to not appear in mount options, as it has
> one shot semantics, which was breaking this test. Test explicitly that
> it _doesn't_ appear, which properly fails on old filesystems and passes
> on misc-next.
> 
> The patch that changed this behavior was:
> 8b228324a8ce btrfs: clear free space tree on ro->rw remount
> 
> Separately, inode_cache is deprecated and will never appear in mount
> options; remove it entirely.
> 
> Signed-off-by: Boris Burkov

Missing email address in above tag.

Also cc'ed linux-btrfs list for review.

Thanks,
Eryu

> ---
>  tests/btrfs/220 | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/tests/btrfs/220 b/tests/btrfs/220
> index c84c7065..1242460f 100755
> --- a/tests/btrfs/220
> +++ b/tests/btrfs/220
> @@ -215,11 +215,8 @@ test_optional_kernel_features()
>  
>  test_non_revertible_options()
>  {
> -	test_mount_opt "clear_cache" "clear_cache"
>  	test_mount_opt "degraded" "degraded"
>  
> -	test_mount_opt "inode_cache" "inode_cache"
> -
>  	# nologreplay should be used only with
>  	test_should_fail "nologreplay"
>  	test_mount_opt "nologreplay,ro" "ro,rescue=nologreplay"
> @@ -238,6 +235,11 @@ test_non_revertible_options()
>  	test_mount_opt "rescue=nologreplay,ro" "ro,rescue=nologreplay"
>  }
>  
> +test_one_shot_options()
> +{
> +	test_mount_opt "clear_cache" ""
> +}
> +
>  # All these options can be reverted (with their "no" counterpart), or can have
>  # their values set to default on remount
>  test_revertible_options()
> @@ -321,6 +323,8 @@ test_optional_kernel_features
>  
>  test_non_revertible_options
>  
> +test_one_shot_options
> +
>  test_revertible_options
>  
>  test_subvol
> -- 
> 2.24.1
