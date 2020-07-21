Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4039E2277BD
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Jul 2020 06:51:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726737AbgGUEvC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 21 Jul 2020 00:51:02 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:34567 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726677AbgGUEvC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 21 Jul 2020 00:51:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595307061;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vb2UOgFRAfaLx63n3vDlxINfD7qAtaGzrBh7ybUpiyY=;
        b=dms/AtPyPdGjTZ77Vqw1V1PaVrBO1uOzhg8NszVAa6JPSum6ptDE46SJAPBoLJteP2Oc4N
        kRYPvaveGHX/MqDCwgSBM8TISm3lhE7FOJXLoaOdSSbooVclxdI8WgCUohn2z2yObCGpCh
        ot+DDx6FqZMDBiNdQvlIDAE3Gz/IjJQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-499-8BVx8wJCNt2zkE3gnSG7Iw-1; Tue, 21 Jul 2020 00:50:56 -0400
X-MC-Unique: 8BVx8wJCNt2zkE3gnSG7Iw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F3A6F1005504;
        Tue, 21 Jul 2020 04:50:55 +0000 (UTC)
Received: from localhost (dhcp-12-102.nay.redhat.com [10.66.12.102])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6C82A74F45;
        Tue, 21 Jul 2020 04:50:55 +0000 (UTC)
Date:   Tue, 21 Jul 2020 13:03:01 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v4] generic: add a test for umount racing mount
Message-ID: <20200721050301.GA3495@dhcp-12-102.nay.redhat.com>
Mail-Followup-To: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
References: <20200719171853.GE2557159@desktop>
 <20200720190556.3292884-1-boris@bur.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200720190556.3292884-1-boris@bur.io>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jul 20, 2020 at 12:05:56PM -0700, Boris Burkov wrote:
> Test if dirtying many inodes (which can delay umount) then
> unmounting and quickly mounting again causes the mount to fail.
> 
> A race, which breaks the test in btrfs, is fixed by the patch:
> "btrfs: fix mount failure caused by race with umount"
> 
> Signed-off-by: Boris Burkov <boris@bur.io>
> ---

This version looks good to me,
Reviewed-by: Zorro Lang <zlang@redhat.com>

> - dd to XFS_IO_PROG
> - 1M writes to 4k writes
> 
>  tests/generic/603     | 53 +++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/603.out |  2 ++
>  tests/generic/group   |  1 +
>  3 files changed, 56 insertions(+)
>  create mode 100755 tests/generic/603
>  create mode 100644 tests/generic/603.out
> 
> diff --git a/tests/generic/603 b/tests/generic/603
> new file mode 100755
> index 00000000..90f0d1d3
> --- /dev/null
> +++ b/tests/generic/603
> @@ -0,0 +1,53 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2020 Facebook  All Rights Reserved.
> +#
> +# FS QA Test 603
> +#
> +# Evicting dirty inodes can take a long time during umount.
> +# Check that a new mount racing with such a delayed umount succeeds.
> +#
> +seq=`basename $0`
> +seqres=$RESULT_DIR/$seq
> +echo "QA output created by $seq"
> +
> +here=`pwd`
> +tmp=/tmp/$$
> +status=1	# failure is the default!
> +trap "_cleanup; exit \$status" 0 1 2 3 15
> +
> +_cleanup()
> +{
> +	cd /
> +	rm -f $tmp.*
> +}
> +
> +# get standard environment, filters and checks
> +. ./common/rc
> +. ./common/filter
> +
> +# remove previous $seqres.full before test
> +rm -f $seqres.full
> +
> +# real QA test starts here
> +
> +# Modify as appropriate.
> +_supported_fs generic
> +_supported_os Linux
> +_require_scratch
> +
> +_scratch_mkfs > /dev/null 2>&1
> +_scratch_mount
> +for i in $(seq 0 500)
> +do
> +	$XFS_IO_PROG -c "pwrite 0 4K" $SCRATCH_MNT/$i >/dev/null 2>&1
> +done
> +_scratch_unmount &
> +_scratch_mount
> +wait
> +
> +echo "Silence is golden"
> +
> +# success, all done
> +status=0
> +exit
> diff --git a/tests/generic/603.out b/tests/generic/603.out
> new file mode 100644
> index 00000000..6810da89
> --- /dev/null
> +++ b/tests/generic/603.out
> @@ -0,0 +1,2 @@
> +QA output created by 603
> +Silence is golden
> diff --git a/tests/generic/group b/tests/generic/group
> index d9ab9a31..c0ace35b 100644
> --- a/tests/generic/group
> +++ b/tests/generic/group
> @@ -605,3 +605,4 @@
>  600 auto quick quota
>  601 auto quick quota
>  602 auto quick encrypt
> +603 auto quick
> -- 
> 2.24.1
> 

