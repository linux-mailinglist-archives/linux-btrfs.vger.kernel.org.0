Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AEF44FF046
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Apr 2022 09:01:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232476AbiDMHEM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 13 Apr 2022 03:04:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbiDMHEL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 13 Apr 2022 03:04:11 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 214F31CFF9;
        Wed, 13 Apr 2022 00:01:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CCB31B82032;
        Wed, 13 Apr 2022 07:01:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59B06C385A3;
        Wed, 13 Apr 2022 07:01:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649833307;
        bh=TirwWPHAJh8hXQBbi2wqUHXLsJIF2sLZyUlzqx1HbFY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pFY1/odaUlSBNqM0oCoWHz+thvsu/L/qZUXjAaMq9ah8cqBnYFhiDbJMjAyWx+EbT
         hOHZ0oPaDUVHoF1h5p/ymJKFqe/CciP/BF1tA/fOCPwTuzm7xjX7Sm+/y2xrSeiC1a
         /zIsU46t1qJjMwK09BLKSl43YMpF0ROwyb5M2I+4iN+6jLOR8AzS6gY1JS0OfedstH
         3sQjnqq1DO9VI633RwzCmqP59eLCxCNCPXEMsjjWMOlzKgYHqR7wSgVJfyVUEcsETs
         Mxx/9JBcFmlEUN8F6bANCbqlWOeLFuPf47jiAUBWRE1Tol1IKlDmkCxmjxlbVfVvXW
         sJ4VUrXj6WCHA==
Date:   Wed, 13 Apr 2022 09:01:43 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     fdmanana@kernel.org
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH] common/rc: fix _try_scratch_mount() and _test_mount()
 when mount fails
Message-ID: <20220413070143.qluv7bwd6kujb5km@wittgenstein>
References: <0ab59504aef01776ab58f9f92c55e86bf1c75424.1649685964.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0ab59504aef01776ab58f9f92c55e86bf1c75424.1649685964.git.fdmanana@suse.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Apr 11, 2022 at 03:08:38PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> After the recent commit 4a7b35d7a76cd9 ("common: allow to run all tests
> on idmapped mounts"), some test that use _try_scratch_mount started to
> fail. For example:
> 
> $ ./check btrfs/131 btrfs/220
> FSTYP         -- btrfs
> PLATFORM      -- Linux/x86_64 debian9 5.17.0-rc8-btrfs-next-114 (...)
> MKFS_OPTIONS  -- /dev/sdc
> MOUNT_OPTIONS -- /dev/sdc /home/fdmanana/btrfs-tests/scratch_1
> 
> btrfs/131 2s ... - output mismatch (see .../results//btrfs/131.out.bad)
>     --- tests/btrfs/131.out	2020-06-10 19:29:03.818519162 +0100
>     +++ /home/fdmanana/git/hub/xfstests/results//btrfs/131.out.bad (...)
>     @@ -6,8 +6,6 @@
>      Disabling free space cache and enabling free space tree
>      free space tree is enabled
>      Trying to mount without free space tree
>     -mount failed
>     -mount failed
>      Mounting existing free space tree
>      free space tree is enabled
>     ...
>     (Run 'diff -u /home/fdmanana/git/hub/xfstests/tests/btrfs/131.out ...
> btrfs/220 7s ... - output mismatch (see .../results//btrfs/220.out.bad)
>     --- tests/btrfs/220.out	2020-10-16 23:13:46.802162554 +0100
>     +++ /home/fdmanana/git/hub/xfstests/results//btrfs/220.out.bad (...)
>     @@ -1,2 +1,32 @@
>      QA output created by 220
>     +Option fragment=invalid should fail to mount
>     +umount: /home/fdmanana/btrfs-tests/scratch_1: not mounted.
>     +Option nologreplay should fail to mount
>     +umount: /home/fdmanana/btrfs-tests/scratch_1: not mounted.
>     +Option norecovery should fail to mount
>     +umount: /home/fdmanana/btrfs-tests/scratch_1: not mounted.
>     ...
>     (Run 'diff -u /home/fdmanana/git/hub/xfstests/tests/btrfs/220.out ...
> Ran: btrfs/131 btrfs/220
> Failures: btrfs/131 btrfs/220
> Failed 2 of 2 tests
> 
> The reason is that if _try_scratch_mount() fails to mount the filesystem,
> we don't return the failure, instead we call _idmapped_mount(), which
> can succeed and make _try_scratch_mount() return 0 (success). The same
> happens for _test_mount(), however a quick search revealed no tests
> currently relying on the return value of _test_mount().
> 
> So fix that by making _try_scratch_mount() return immediately if it gets
> a mount failure. Also do the same for _test_mount().
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> ---

Thank you,
Acked-by: Christian Brauner (Microsoft) <brauner@kernel.org>
