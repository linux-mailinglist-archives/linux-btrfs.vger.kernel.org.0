Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8354F22A8C3
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 Jul 2020 08:16:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726652AbgGWGQP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 23 Jul 2020 02:16:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726522AbgGWGQO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 23 Jul 2020 02:16:14 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68C14C0619DC;
        Wed, 22 Jul 2020 23:16:14 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id x9so2095558plr.2;
        Wed, 22 Jul 2020 23:16:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=IkIFm2++IUwpx/m4LS5QkaX4zvzFK2fvJNHUZdP8i80=;
        b=upjAZZPs4tRBKlGS5VMFjj+3y6i1F+1afh7W95t80+Wcv8YjRCHpQC+zz8AK3kuj66
         LQk/Hg06bXfOcOr0aU4x+Fl68hIZ6rx9s5seH82wxoORixI5gGGIVQvc55+NYGjqX/uH
         4J/8yxKX+ckvurv1ILgyKnjpmC78WJeJZxAUW4CWjf46l3bE0W/oTn9uJ1lGfVB05AB2
         vEaAzNHjv92HPYZyrwIvlcDAfC+96W+oJdfp5HzhYH451iMzyD0T70sQb919WxuowZpt
         Zx4MvABVcOT+2o1SAPCFbmN4oqUTkmOe55qdqacIA7bd41E/Uc3jQ7TrrrP4vBJKJWCh
         HPUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=IkIFm2++IUwpx/m4LS5QkaX4zvzFK2fvJNHUZdP8i80=;
        b=eIZnip1KZLfOHlZrV2uJxkjV0t1Exzg1YXYsCRNYeuIHlBopuF9B7AFPgmqCTMc6a7
         UpZeGJLNtRA2jQYGlFrUVLM7TCb/nC3fVscPGD6Nj/0+6bmQ84Z3LoFxNehOKeSG1a2I
         SqluOF/Ze1q8nq6/4GiP0BZw/dpsH+Le7GGS52hIpB04lAzl/jItoZ2w7ftIxxAY1LNa
         psrkIufhysgf8/KB1iHJ30YtrmSD/NKSx4/MdeenYSzzR/dIbLLjiwXf0oSMyGvW2ihk
         LJbzW2M8ic7za5jHgv8qPiDuwhitAxQFh3+ooGpCHizZDarwILfVdteIMCx8d0b4FfTc
         dHAw==
X-Gm-Message-State: AOAM531KpZg3oGkonUso5N0GU9Pky2Y5TSTz1edIRSoU5b2OdeQxGhPq
        T2rxqg9LP+enbVwRxDJ1RwM=
X-Google-Smtp-Source: ABdhPJwEnh1JHrh2+XiM4ZjbrMAGsUHtQDvMDaKPtpVC2qBiE4d2gr2VcjDotQmcmN5wylOHEYCmxw==
X-Received: by 2002:a17:902:c209:: with SMTP id 9mr2582164pll.133.1595484973892;
        Wed, 22 Jul 2020 23:16:13 -0700 (PDT)
Received: from localhost ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id gm3sm1519746pjb.44.2020.07.22.23.16.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2020 23:16:13 -0700 (PDT)
Date:   Thu, 23 Jul 2020 14:16:05 +0800
From:   Murphy Zhou <jencce.kernel@gmail.com>
To:     fdmanana@kernel.org
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Filipe Manana <fdmanana@suse.com>,
        Murphy Zhou <jencce.kernel@gmail.com>
Subject: Re: [PATCH] generic/501: make the test work on machines with a non
 4K page size
Message-ID: <20200723061605.ggltcoikywaphe74@xzhoux.usersys.redhat.com>
References: <20200722141254.19511-1-fdmanana@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200722141254.19511-1-fdmanana@kernel.org>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jul 22, 2020 at 03:12:54PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Currently generic/501 fails on machines with a page size different from 4K
> (like ppc64le), because the clone operation fails with -EINVAL due to the
> fact we pass it an offset that is 4K aligned but not aligned to the page
> size of the machine.

Tested OK. Take much longer time though.

Ack. Thanks!
> 
> The test doesn't actually need offsets and lengths to be 4K aligned, so
> just update the test to use offsets and lenghts that work for page size.
> Also add a comment mentioning that a file size of at least 16Mb was a
> necessary condition to trigger the btrfs bug.
> 
> The test is a regression test for a btrfs issue fixed by kernel commit
> bd3599a0e142cd ("Btrfs: fix file data corruption after cloning a range
> and fsync"), which landed in kernel 4.18.
> 
> Since I couldn't compile a 4.17 kernel on debian testing, I tried this
> with a 4.18 kernel with that commit reverted, and it fails as expected
> on a x86_64 box:
> 
> $ ./check generic/501
> FSTYP         -- btrfs
> PLATFORM      -- Linux/x86_64 debian9 4.18.0-btrfs-next-64 #1 SMP (...)
> MKFS_OPTIONS  -- /dev/sdc
> MOUNT_OPTIONS -- /dev/sdc /home/fdmanana/btrfs-tests/scratch_1
> 
> generic/501 1s ... - output mismatch (see .../xfstests/results//generic/501.out.bad)
>     --- tests/generic/501.out	2020-07-22 14:50:12.585674202 +0100
>     +++ /home/fdmanana/git/hub/xfstests/results//generic/501.out.bad ...
>     @@ -2,4 +2,4 @@
>      File bar digest before power failure:
>      69319d0343ab8f5ea564167da445addc  SCRATCH_MNT/bar
>      File bar digest after power failure:
>     -69319d0343ab8f5ea564167da445addc  SCRATCH_MNT/bar
>     +21de7d7325fe4dae1f3311d5a76f819f  SCRATCH_MNT/bar
>     ...
>     (Run 'diff -u /home/fdmanana/git/hub/xfstests/tests/generic/501.out ...
> Ran: generic/501
> Failures: generic/501
> Failed 1 of 1 tests
> 
> Without the commit reverted it passes as expected.
> 
> Reported-by: Murphy Zhou <jencce.kernel@gmail.com>
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> ---
>  tests/generic/501     | 14 ++++++++------
>  tests/generic/501.out |  4 ++--
>  2 files changed, 10 insertions(+), 8 deletions(-)
> 
> diff --git a/tests/generic/501 b/tests/generic/501
> index 0d1f6ffe..bf020095 100755
> --- a/tests/generic/501
> +++ b/tests/generic/501
> @@ -42,14 +42,16 @@ _require_metadata_journaling $SCRATCH_DEV
>  _init_flakey
>  _mount_flakey
>  
> -$XFS_IO_PROG -f -c "pwrite -S 0x18 9000K 6908K" $SCRATCH_MNT/foo >>$seqres.full
> -$XFS_IO_PROG -f -c "pwrite -S 0x20 2572K 156K" $SCRATCH_MNT/bar >>$seqres.full
> +# Use file sizes and offsets/lengths for the clone operation that are multiples
> +# of 64Kb, so that the test works on machine with any page size.
> +$XFS_IO_PROG -f -s -c "pwrite -S 0x18 0 2M" $SCRATCH_MNT/foo >>$seqres.full
> +$XFS_IO_PROG -f -s -c "pwrite -S 0x20 0 20M" $SCRATCH_MNT/bar >>$seqres.full
>  
>  # We clone from file foo into a range of file bar that overlaps the existing
> -# extent at file bar. The destination offset of the reflink operation matches
> -# the eof position of file bar minus 4Kb.
> -$XFS_IO_PROG -c "fsync" \
> -	     -c "reflink ${SCRATCH_MNT}/foo 0 2724K 15908K" \
> +# extent at file bar. The clone operation must also extend the size of file bar.
> +# Note: in order to trigger the original bug on btrfs, the destination file size
> +# must be at least 16Mb and the destination file must have been fsynced before.
> +$XFS_IO_PROG -c "reflink ${SCRATCH_MNT}/foo 0 19M 2M" \
>  	     -c "fsync" \
>  	     $SCRATCH_MNT/bar >>$seqres.full
>  
> diff --git a/tests/generic/501.out b/tests/generic/501.out
> index 5d7da017..778aba4b 100644
> --- a/tests/generic/501.out
> +++ b/tests/generic/501.out
> @@ -1,5 +1,5 @@
>  QA output created by 501
>  File bar digest before power failure:
> -95a95813a8c2abc9aa75a6c2914a077e  SCRATCH_MNT/bar
> +69319d0343ab8f5ea564167da445addc  SCRATCH_MNT/bar
>  File bar digest after power failure:
> -95a95813a8c2abc9aa75a6c2914a077e  SCRATCH_MNT/bar
> +69319d0343ab8f5ea564167da445addc  SCRATCH_MNT/bar
> -- 
> 2.26.2
> 

-- 
Murphy
