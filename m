Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00ADB21E750
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Jul 2020 07:08:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725853AbgGNFI0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 14 Jul 2020 01:08:26 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:25245 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725283AbgGNFI0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 14 Jul 2020 01:08:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594703304;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qgO8HTJnu+5ctZ0vQFoMf+HsrcNfNflyFagdmojxzUU=;
        b=YRttWmdQUNNevy1mvoMq4EE461KWng+X+0X83OXLqdJKNmpZtTcWruvCAvcbpsi2EB5jt/
        D0xPCiYxDQdq5Y7PgVZqKg9KJkWiSJ1wEane4bQBajvftLail1twkKH+YHjGDpdzk7ZxXt
        stWwyTSuKN8xdNmohOP/4JBDwkNe6DI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-4-xQkAGs8NPuWGCMLZtnrBCw-1; Tue, 14 Jul 2020 01:08:19 -0400
X-MC-Unique: xQkAGs8NPuWGCMLZtnrBCw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 76A271800D42;
        Tue, 14 Jul 2020 05:08:18 +0000 (UTC)
Received: from localhost (dhcp-12-102.nay.redhat.com [10.66.12.102])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E4DB010013C0;
        Tue, 14 Jul 2020 05:08:17 +0000 (UTC)
Date:   Tue, 14 Jul 2020 13:21:06 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Boris Burkov <boris@bur.io>
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v3] generic: add a test for umount racing mount
Message-ID: <20200714052106.GX1938@dhcp-12-102.nay.redhat.com>
Mail-Followup-To: Boris Burkov <boris@bur.io>, fstests@vger.kernel.org,
        linux-btrfs@vger.kernel.org
References: <20200712113741.GW1938@dhcp-12-102.nay.redhat.com>
 <20200713204639.1271794-1-boris@bur.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200713204639.1271794-1-boris@bur.io>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jul 13, 2020 at 01:46:39PM -0700, Boris Burkov wrote:
> Test if dirtying many inodes (which can delay umount) then
> unmounting and quickly mounting again causes the mount to fail.
> 
> A race, which breaks the test in btrfs, is fixed by the patch:
> "btrfs: fix mount failure caused by race with umount"
> 
> Signed-off-by: Boris Burkov <boris@bur.io>
> ---

If Eryu won't tend to change dd to XFS_IO_PROG, this version is good to me:)

Reviewed-by: Zorro Lang <zlang@redhat.com>

Thanks,
Zorro

>  tests/generic/603     | 53 +++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/603.out |  2 ++
>  tests/generic/group   |  1 +
>  3 files changed, 56 insertions(+)
>  create mode 100755 tests/generic/603
>  create mode 100644 tests/generic/603.out
> 
> diff --git a/tests/generic/603 b/tests/generic/603
> new file mode 100755
> index 00000000..8e9a80e6
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
> +	dd if=/dev/zero of="$SCRATCH_MNT/$i" bs=1M count=1 > /dev/null 2>&1
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

