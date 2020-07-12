Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6164021C911
	for <lists+linux-btrfs@lfdr.de>; Sun, 12 Jul 2020 13:25:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728805AbgGLLZB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 12 Jul 2020 07:25:01 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:20382 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725765AbgGLLZA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 12 Jul 2020 07:25:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594553099;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=n/hZzYnvHI04LG9yCpMZWg1IxGU0A7wFj97tewndyiw=;
        b=fSQOZd1hOLd4cK9clXG7PzAhQWSdYCEJ8SlCVsDxyvsXpDcP8iaL5aoX5PLg/ipfk0FMON
        cYTNnUaFEAXpG/j1DZDkpYFHKPyFLWC9CiNt8WqgscoT13es8JYfsnmDmMXAgvHADHLW7d
        Zu0gRH0AIqhWJ9FVwIm/yaYHMKt34Ow=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-114-ciAJeNEROoy6gb0Y7vR9yQ-1; Sun, 12 Jul 2020 07:24:57 -0400
X-MC-Unique: ciAJeNEROoy6gb0Y7vR9yQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1B11C100CC84;
        Sun, 12 Jul 2020 11:24:56 +0000 (UTC)
Received: from localhost (dhcp-12-102.nay.redhat.com [10.66.12.102])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5DC1574F59;
        Sun, 12 Jul 2020 11:24:55 +0000 (UTC)
Date:   Sun, 12 Jul 2020 19:37:41 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Boris Burkov <boris@bur.io>
Cc:     Josef Bacik <josef@toxicpanda.com>, fstests@vger.kernel.org,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2] generic: add a test for umount racing mount
Message-ID: <20200712113741.GW1938@dhcp-12-102.nay.redhat.com>
Mail-Followup-To: Boris Burkov <boris@bur.io>,
        Josef Bacik <josef@toxicpanda.com>, fstests@vger.kernel.org,
        linux-btrfs@vger.kernel.org
References: <c8bfc2c7-4c13-72e4-3665-c2e2dec99dd4@toxicpanda.com>
 <20200710171836.127889-1-boris@bur.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200710171836.127889-1-boris@bur.io>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jul 10, 2020 at 10:18:36AM -0700, Boris Burkov wrote:
> Test if dirtying many inodes (which can delay umount) then
> unmounting and quickly mounting again causes the mount to fail.
> 
> A race, which breaks the test in btrfs, is fixed by the patch:
> "btrfs: fix mount failure caused by race with umount"
> 
> Signed-off-by: Boris Burkov <boris@bur.io>
> ---
>  tests/generic/603     | 52 +++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/603.out |  2 ++
>  tests/generic/group   |  1 +
>  3 files changed, 55 insertions(+)
>  create mode 100755 tests/generic/603
>  create mode 100644 tests/generic/603.out
> 
> diff --git a/tests/generic/603 b/tests/generic/603
> new file mode 100755
> index 00000000..e67899cb
> --- /dev/null
> +++ b/tests/generic/603
> @@ -0,0 +1,52 @@
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
> +_require_test

It should be _require_scratch, due to you never use TEST_DIR below, but you
used $SCRATCH_MNT.

> +
> +_scratch_mkfs > /dev/null 2>&1
> +_scratch_mount
> +for i in $(seq 0 500)
> +do
> +	dd if=/dev/zero of="$SCRATCH_MNT/$i" bs=1M count=1 > /dev/null 2>&1
> +done
> +_scratch_unmount &

I have a question, can we make sure the this umount operation won't affect
next running case?

> +_scratch_mount
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

