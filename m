Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67B3722A6C0
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 Jul 2020 06:57:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725846AbgGWE5I (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 23 Jul 2020 00:57:08 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:42341 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725822AbgGWE5H (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 23 Jul 2020 00:57:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595480226;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/4MD7qsWN1B0yrMgLKUYI1ow/qdtbtLAlSs3+Jsg6Ps=;
        b=CxUOXCDMCUntAf3KRNQm6hIKVwlU+RfY3TULWpSYtzB0m8w+OuiTpahUhdVDdvJXnDLOQR
        bdwj2CI9KqqHE8fC6lTxhfKV3pAvLXvsXhmEgJS9TMVAaSuTpczizYhUzZ2XuipqXHcE14
        8Rb6X4p9OvqEoJL9QnhlHM1opE+At6w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-278-0ayObmDiPvm1xWNhVZwY2w-1; Thu, 23 Jul 2020 00:57:02 -0400
X-MC-Unique: 0ayObmDiPvm1xWNhVZwY2w-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DBF0B800688;
        Thu, 23 Jul 2020 04:57:00 +0000 (UTC)
Received: from localhost (dhcp-12-102.nay.redhat.com [10.66.12.102])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 471055D9D5;
        Thu, 23 Jul 2020 04:57:00 +0000 (UTC)
Date:   Thu, 23 Jul 2020 13:09:10 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     fdmanana@kernel.org
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Filipe Manana <fdmanana@suse.com>,
        Murphy Zhou <jencce.kernel@gmail.com>
Subject: Re: [PATCH] generic/501: make the test work on machines with a non
 4K page size
Message-ID: <20200723050909.GD2937@dhcp-12-102.nay.redhat.com>
Mail-Followup-To: fdmanana@kernel.org, fstests@vger.kernel.org,
        linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>,
        Murphy Zhou <jencce.kernel@gmail.com>
References: <20200722141254.19511-1-fdmanana@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200722141254.19511-1-fdmanana@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
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

Looks good to me, although I think you don't need to list the whole test
process in the commit log. Anyway, that's fine for me.

Reviewed-by: Zorro Lang <zlang@redhat.com>

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

