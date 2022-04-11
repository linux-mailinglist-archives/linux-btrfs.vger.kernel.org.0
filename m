Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A05D24FC7D1
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Apr 2022 00:47:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243496AbiDKWtT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 11 Apr 2022 18:49:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234169AbiDKWtS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 11 Apr 2022 18:49:18 -0400
Received: from mail105.syd.optusnet.com.au (mail105.syd.optusnet.com.au [211.29.132.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AFCE92ED73;
        Mon, 11 Apr 2022 15:47:02 -0700 (PDT)
Received: from dread.disaster.area (pa49-186-233-190.pa.vic.optusnet.com.au [49.186.233.190])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id B9C5810C888F;
        Tue, 12 Apr 2022 08:47:01 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1ne2oF-00GbEI-PK; Tue, 12 Apr 2022 08:46:59 +1000
Date:   Tue, 12 Apr 2022 08:46:59 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     fdmanana@kernel.org
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
        brauner@kernel.org, Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH] common/rc: fix _try_scratch_mount() and _test_mount()
 when mount fails
Message-ID: <20220411224659.GK1609613@dread.disaster.area>
References: <0ab59504aef01776ab58f9f92c55e86bf1c75424.1649685964.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0ab59504aef01776ab58f9f92c55e86bf1c75424.1649685964.git.fdmanana@suse.com>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=deDjYVbe c=1 sm=1 tr=0 ts=6254afe6
        a=bHAvQTfMiaNt/bo4vVGwyA==:117 a=bHAvQTfMiaNt/bo4vVGwyA==:17
        a=kj9zAlcOel0A:10 a=z0gMJWrwH1QA:10 a=VwQbUJbxAAAA:8 a=iox4zFpeAAAA:8
        a=20KFwNOVAAAA:8 a=7-415B0cAAAA:8 a=49UVxCNO6jtb8jSYA8wA:9
        a=CjuIK1q_8ugA:10 a=AjGcO6oz07-iQ99wixmX:22 a=WzC6qhA0u3u7Ye7llzcV:22
        a=biEYGPWJfzWAr4FL6Ov7:22
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
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
>  common/rc | 8 ++++++++
>  1 file changed, 8 insertions(+)

Yup, that fixes the generic/607 failure that I just hit.

Reviewed-by: Dave Chinner <dchinner@redhat.com>

-- 
Dave Chinner
david@fromorbit.com
