Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5210D3FAC03
	for <lists+linux-btrfs@lfdr.de>; Sun, 29 Aug 2021 15:43:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235415AbhH2NnH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 29 Aug 2021 09:43:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbhH2NnF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 29 Aug 2021 09:43:05 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CEB1C061575;
        Sun, 29 Aug 2021 06:42:13 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id g138so7016143wmg.4;
        Sun, 29 Aug 2021 06:42:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=42k7rPri6WRKbIU/r0i18a/GKhWZ5Qu+f92Ok7uVS4w=;
        b=XaoHJYo4dTQO5JgIwoj48nj721UCXhtttE0Loy1BBdGnSgHmyT19GUyx4DeyTDahvt
         feKhPR7Mn4JT6Kn9o1+7EmTOZpixJqQKqEGDi1/eN7fZPrizHeKJYXkde1+iAHlHfq9I
         VLa0d2EUNitzO2gZNkYVHbtf/mPJha6SRKlxn2/wtqCAL13I5cgY+uwolwohV4RT92Sb
         46Fy2e3YgALB9+JuENun82CsEHN6B13qYFMj0y4OHALu3TW2NRVDnr8OizCKaUABvNVB
         FXULtjbOlz7BZP34QiUmw+e5At5WUGzmzHNsEvsl5AN211fNUm8YFk2TCthJIDUNpaWm
         U1fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=42k7rPri6WRKbIU/r0i18a/GKhWZ5Qu+f92Ok7uVS4w=;
        b=et7c0sHaY1RT/cxsLzD3Vi5+gNX2XahmLQhKvIdtuZvLYoc6guQCQCjEZUaF9meJey
         WM5Qnb/REvJOd0jJZYu8oF4L7mcMZ1FmXvZ044IF94X1e3SFIqiLUPDYe+Wp4t6Mw1cq
         YhNXKI2Wa7AJ0msTwR0Uk1xl12+Q5SbNkOB4nI+9Fhc2j94CbZ89rtfk+lGBQdUfSk+s
         CUUJVW6gkJWfS9fQVzz1Wkd0dHCeml2/KdH6ZpPHas215aze3chwNtQ4YdfKJRSU4UjR
         itSpvy2rOdlHIQ3lciuKZm2bmybkKS8UkF7foZsGp1GGCVLJhGA3ydE+vxRiiaABHxrB
         RZfw==
X-Gm-Message-State: AOAM533QDJx//6s7xFcwx58Ju77y3cDTJpUaI9nZPE1KT7oPNGZgDbkl
        pF0bAyWDalEnNuSDjF5tsOfwQlKFoJE=
X-Google-Smtp-Source: ABdhPJwXqJMrsOUNDr4v3pKgkoHsBoESSdVSnY5laI4J77NNDTOycGFyUasZGjeCe1F98wrUALtr+w==
X-Received: by 2002:a05:600c:b46:: with SMTP id k6mr27875477wmr.35.1630244531819;
        Sun, 29 Aug 2021 06:42:11 -0700 (PDT)
Received: from localhost ([8.208.10.148])
        by smtp.gmail.com with ESMTPSA id e2sm14021483wrq.56.2021.08.29.06.42.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Aug 2021 06:42:11 -0700 (PDT)
Date:   Sun, 29 Aug 2021 21:42:07 +0800
From:   Eryu Guan <guaneryu@gmail.com>
To:     Qu Wenruo <wqu@suse.com>
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2] fstests: btrfs/246: add test case to make sure btrfs
 can create compressed inline extent
Message-ID: <YSuOr0XhCgVBcnc8@desktop>
References: <20210826053432.13146-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210826053432.13146-1-wqu@suse.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Aug 26, 2021 at 01:34:32PM +0800, Qu Wenruo wrote:
> Btrfs has the ability to inline small file extents into its metadata,
> and such inlined extents can be further compressed if needed.
> 
> The new test case is for a regression caused by commit f2165627319f
> ("btrfs: compression: don't try to compress if we don't have enough
> pages").
> 
> That commit prevents btrfs from creating compressed inline extents, even
> "-o compress,max_inline=2048" is specified, only uncompressed inline
> extents can be created.
> 
> The test case will make sure that the content of the small file is
> consistent between cycle mount, then use "btrfs inspect dump-tree" to
> verify the created extent is both inlined and compressed.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Is there a proposed fix available that could be referenced in the commit
log?

> ---
> Changelog:
> v2:
> - Also output the sha256sum to make sure the content is consistent
> ---
>  tests/btrfs/246     | 53 +++++++++++++++++++++++++++++++++++++++++++++
>  tests/btrfs/246.out |  5 +++++
>  2 files changed, 58 insertions(+)
>  create mode 100755 tests/btrfs/246
>  create mode 100644 tests/btrfs/246.out
> 
> diff --git a/tests/btrfs/246 b/tests/btrfs/246
> new file mode 100755
> index 00000000..e0d8016f
> --- /dev/null
> +++ b/tests/btrfs/246
> @@ -0,0 +1,53 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2021 SUSE Linux Products GmbH.  All Rights Reserved.
> +#
> +# FS QA Test 246
> +#
> +# Make sure btrfs can create compressed inline extents
> +#
> +. ./common/preamble
> +_begin_fstest auto quick compress
> +
> +# Override the default cleanup function.
> +_cleanup()
> +{
> +	cd /
> +	rm -r -f $tmp.*
> +}
> +
> +# Import common functions.
> +. ./common/filter
> +# For __populate_find_inode()
> +. ./common/populate

This function starts with double underscore, I take it as a 'private'
function in common/populate. But all it does is returning the inode
number of the given file, I think we could just open-code it in this
test as

ino=$(stat -c %i $SCRATCH_MNT/foobar)

Otherwise test looks fine to me.

Thanks,
Eryu

> +
> +# real QA test starts here
> +
> +# Modify as appropriate.
> +_supported_fs btrfs
> +_require_scratch
> +
> +_scratch_mkfs > /dev/null
> +_scratch_mount -o compress,max_inline=2048
> +
> +# This should create compressed inline extent
> +$XFS_IO_PROG -f -c "pwrite 0 2048" $SCRATCH_MNT/foobar > /dev/null
> +ino=$(__populate_find_inode $SCRATCH_MNT/foobar)
> +echo "sha256sum before mount cycle"
> +sha256sum $SCRATCH_MNT/foobar | _filter_scratch
> +_scratch_cycle_mount
> +echo "sha256sum after mount cycle"
> +sha256sum $SCRATCH_MNT/foobar | _filter_scratch
> +_scratch_unmount
> +
> +$BTRFS_UTIL_PROG inspect dump-tree -t 5 $SCRATCH_DEV | \
> +	grep "($ino EXTENT_DATA 0" -A2 > $tmp.dump-tree
> +echo "dump tree result for ino $ino:" >> $seqres.full
> +cat $tmp.dump-tree >> $seqres.full
> +
> +grep -q "inline extent" $tmp.dump-tree || echo "no inline extent found"
> +grep -q "compression 1" $tmp.dump-tree || echo "no compressed extent found"
> +
> +# success, all done
> +status=0
> +exit
> diff --git a/tests/btrfs/246.out b/tests/btrfs/246.out
> new file mode 100644
> index 00000000..3908cc50
> --- /dev/null
> +++ b/tests/btrfs/246.out
> @@ -0,0 +1,5 @@
> +QA output created by 246
> +sha256sum before mount cycle
> +0ca3bfdeda1ef5036bfa5dad078a9f15724e79cf296bd4388cf786bfaf4195d0  SCRATCH_MNT/foobar
> +sha256sum after mount cycle
> +0ca3bfdeda1ef5036bfa5dad078a9f15724e79cf296bd4388cf786bfaf4195d0  SCRATCH_MNT/foobar
> -- 
> 2.31.1
