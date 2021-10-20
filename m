Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FE08434CBD
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 Oct 2021 15:53:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230190AbhJTNz1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 20 Oct 2021 09:55:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230160AbhJTNz0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 20 Oct 2021 09:55:26 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1098EC061746
        for <linux-btrfs@vger.kernel.org>; Wed, 20 Oct 2021 06:53:12 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id b12so3058945qtq.3
        for <linux-btrfs@vger.kernel.org>; Wed, 20 Oct 2021 06:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=4jG8wrbAIAwwRwuzGQslnM39v46b3HnxiqwMR7t/ONg=;
        b=XsKRXK3iq+Zix2mUvOMI39mFr5FlW98+q8eUfgI92njnLqhybIB1b5TgV+1zP+QgPN
         B4ct9758VvgBblihLZBnRHUa8JQjuwVW3yHS4eeIcJMt5hvUp0XYWhAHiyZXsvQFR1ZF
         nBw8SVoyUXyIF8sdLgsxJXiWK51C4ENUpe1oOWDj83uCAp8MY4DxiUKmYs6XFClwaEre
         wNBuu1rF5CULlwrq6vZS4lE8/do7qjLlzax4NmwjOpTefiTofHxcG2mU3X/evkuCSDJF
         MfCaBphlSy+pCZVTo3ItXdNYQh4OYR0nC1Gc4BdzubU/qXVlqRj4v4bmNOPsu/cM62cg
         YO+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4jG8wrbAIAwwRwuzGQslnM39v46b3HnxiqwMR7t/ONg=;
        b=6FUJfcpeXiCG+z9L6KqFXksk9wkCwMCg2BUQmHnBVZcQox0dmAqHgWqA8eB8/Rxfpn
         OVvD0L1hMeNzlEhjvphqcXqa5X7t9s7fxQgZ9iHUIegPeAKaxKBcUepqe3uCosv89WKE
         w6c4qFm7oCvVmmpt9UdDebLieX3mBJITBGAUyfsg1WUXy1VetHdNyToHirEmnAneQMhQ
         cREuOz4zhIXRXILDG47G7KbrJccT+C0dqerVYUoys9NhC7O28vqrFF1QuGDUzv5RE6sP
         4FRbmWB8rkTLe4KbMhYBZNOmN+hpbxPTPFRJ6E3a+sEvy5DXckkX02bHtd6nz401Wefw
         qT6Q==
X-Gm-Message-State: AOAM530rl1irPrWrqOr91tR9RHV0AAQZ9LNaqCAoA6Z6ez/Pt5epPkQB
        qfEIe8tir0eI5QZZBPJqLHWHrEBJ0VZ5rw==
X-Google-Smtp-Source: ABdhPJwjgHb7uUtCGMmJXkif4DUX/B4n9YR/4qICN5BmbTIcT0kEE1DxgyoUDkIn/W9FexMm7bULvQ==
X-Received: by 2002:a05:622a:1116:: with SMTP id e22mr81168qty.78.1634737991113;
        Wed, 20 Oct 2021 06:53:11 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id h66sm1010390qkc.5.2021.10.20.06.53.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Oct 2021 06:53:10 -0700 (PDT)
Date:   Wed, 20 Oct 2021 09:53:09 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 3/3] btrfs/249: test btrfs filesystem usage command on
 missing seed device
Message-ID: <YXAfRcmJ9oYj/kpe@localhost.localdomain>
References: <cover.1634713680.git.anand.jain@oracle.com>
 <599618f8698efc64ef8e25e0cf1d97541927d8ac.1634713680.git.anand.jain@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <599618f8698efc64ef8e25e0cf1d97541927d8ac.1634713680.git.anand.jain@oracle.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Oct 20, 2021 at 03:16:44PM +0800, Anand Jain wrote:
> If there is a missing seed device in a sprout, the btrfs filesystem usage
> command fails, which is fixed by the following patches:
> 
>   btrfs: sysfs add devinfo/fsid to retrieve fsid from the device
>   btrfs-progs: read fsid from the sysfs in device_is_seed
> 
> Test if it works now after these patches in the kernel and in the
> btrfs-progs respectively.
> 
> Suggested-by: Josef Bacik <josef@toxicpanda.com>
> Signed-off-by: Anand Jain <anand.jain@oracle.com>

Shouldn't this use


as well?  I wish there was a way to detect that btrfs-progs had support for
reading it but I suppose this is a good enough gate.  Maybe add a


> ---
>  tests/btrfs/249     | 67 +++++++++++++++++++++++++++++++++++++++++++++
>  tests/btrfs/249.out |  2 ++
>  2 files changed, 69 insertions(+)
>  create mode 100755 tests/btrfs/249
>  create mode 100644 tests/btrfs/249.out
> 
> diff --git a/tests/btrfs/249 b/tests/btrfs/249
> new file mode 100755
> index 000000000000..f8f2f07052c6
> --- /dev/null
> +++ b/tests/btrfs/249
> @@ -0,0 +1,67 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2021 Anand Jain.  All Rights Reserved.
> +# Copyright (c) 2021 Oracle.  All Rights Reserved.
> +#
> +# FS QA Test 249
> +#
> +# Validate if the command 'btrfs filesystem usage' works with missing seed
> +# device
> +# Steps:
> +#  Create a degraded raid1 seed device
> +#  Create a sprout filesystem (an rw device on top of a seed device)
> +#  Dump 'btrfs filesystem usage', check it didn't fail
> +#
> +# Tests btrfs-progs bug fixed by the kernel patch and a btrfs-prog patch
> +#   btrfs: sysfs add devinfo/fsid to retrieve fsid from the device
> +#   btrfs-progs: read fsid from the sysfs in device_is_seed
> +
> +. ./common/preamble
> +_begin_fstest auto quick seed volume
> +
> +# Import common functions.
> +# . ./common/filter
> +
> +# real QA test starts here
> +
> +# Modify as appropriate.
> +_supported_fs btrfs
> +_require_scratch_dev_pool 3
> +_require_command "$WIPEFS_PROG" wipefs
> +_require_btrfs_forget_or_module_loadable

Need

_require_btrfs_sysfs_fsid

here I think.

> +
> +_scratch_dev_pool_get 2
> +# use the scratch devices as seed devices
> +seed_dev1=$(echo $SCRATCH_DEV_POOL | $AWK_PROG '{ print $1 }')
> +seed_dev2=$(echo $SCRATCH_DEV_POOL | $AWK_PROG '{ print $2 }')
> +
> +# use the spare device as a sprout device
> +_spare_dev_get
> +sprout_dev=$SPARE_DEV
> +
> +# create raid1 seed filesystem
> +_scratch_pool_mkfs "-draid1 -mraid1" >> $seqres.full 2>&1
> +$BTRFS_TUNE_PROG -S 1 $seed_dev1
> +$WIPEFS_PROG -a $seed_dev1 >> $seqres.full 2>&1
> +_btrfs_forget_or_module_reload
> +_mount -o degraded $seed_dev2 $SCRATCH_MNT >> $seqres.full 2>&1
> +
> +# create a sprout device
> +$BTRFS_UTIL_PROG device add -f $SPARE_DEV $SCRATCH_MNT >> $seqres.full 2>&1
> +
> +# dump filesystem usage if it fails error goes to the bad.out file
> +$BTRFS_UTIL_PROG filesystem usage $SCRATCH_MNT >> $seqres.full
> +# also check for the error code
> +ret=$?
> +if [ $ret != 0 ]; then
> +	_fail "FAILED: btrfs filesystem usage, ret $ret"

Can you add "check your btrfs-progs version" here or something?  In case I'm an
idiot and forget to update btrfs-progs on the overnight xfstests boxes?  Thanks,

Josef
