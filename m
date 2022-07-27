Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72F79581F5A
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Jul 2022 06:57:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240508AbiG0E5x (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 27 Jul 2022 00:57:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230389AbiG0E5w (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 27 Jul 2022 00:57:52 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3F6273ED45
        for <linux-btrfs@vger.kernel.org>; Tue, 26 Jul 2022 21:57:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658897870;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IbE62iUJHkwOMDK5hCfM6fTnWhJm8/2epgJJb5+P2Ig=;
        b=HIwMvZmEo7TvwPwl0RCESZWcuMWhUgSNwALaD497s10FwGRuRWx/PsYMvGDT7Dor5qmcW1
        XMFIsqlRDjKLoy4h4qWy9UDxuH6RWB+ldifs2s8GclD7C8EZSOivGTA6OmTIDTR0Uh8Y+V
        i0hOYcSBKGr8ajRgIoevSEg3Kqp+dh4=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-460-LabT4iRRPzOucvegqKdS0Q-1; Wed, 27 Jul 2022 00:57:43 -0400
X-MC-Unique: LabT4iRRPzOucvegqKdS0Q-1
Received: by mail-qv1-f72.google.com with SMTP id lg17-20020a056214549100b004743ebacd29so6004706qvb.1
        for <linux-btrfs@vger.kernel.org>; Tue, 26 Jul 2022 21:57:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=IbE62iUJHkwOMDK5hCfM6fTnWhJm8/2epgJJb5+P2Ig=;
        b=MeaL3S3o1CeE9qOVy7dqd4bh439l7OBZ4LezsQpwnChSaZdJ2hUsLZ5X3wz1wqS1Xt
         fLvzukeChdeXrgvvhdyZfFvLSmE9HH7BhSGd4LPWJN92h/I/3nHclb7RnPctUvlLck8R
         UIfCCVDwPhDb/i5a9B6d3dEP7Xyqaj2inojuorz4fSJM7MFx1nmWA8JxSXU80vwzu+Yp
         GNbSL1jbAtHg920tEVsuTcQYSlnZnBNvcKujNd69HUIHw2f6CYJdl2zFD2gOjsKKG9Qe
         dWL+P/8K++yUdl6h7uGa3J70XRJAb3dCKgiNGETS7c9wbzg829t3u2AgIXHumTFnaiJb
         7jGQ==
X-Gm-Message-State: AJIora/6n1B/HjgBYtFczPzmuUTJSUg/NrDfjjzpFNp1T86kvg6k5Vdu
        Xbd1ar3QAcCabugQfmCy3uDeBhlfMEGzyLCUyhdUjjOXY6iil0DwAP3A7K9W1dIw+m5vG6gVXnK
        4O0tpkxAp4JJ2pz7vNQ4MvLs=
X-Received: by 2002:a05:622a:110f:b0:31e:d7a5:59bd with SMTP id e15-20020a05622a110f00b0031ed7a559bdmr17565068qty.580.1658897862765;
        Tue, 26 Jul 2022 21:57:42 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vD5jQD8jDRjVfa5bS/TYxC7qTwa6MLP4flYHPvkehsQ7QO8ETEElIdCNG0mCs8Sn8z+DHs5A==
X-Received: by 2002:a05:622a:110f:b0:31e:d7a5:59bd with SMTP id e15-20020a05622a110f00b0031ed7a559bdmr17565056qty.580.1658897862470;
        Tue, 26 Jul 2022 21:57:42 -0700 (PDT)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id ay15-20020a05620a178f00b006b60f5f53ccsm12349565qkb.25.2022.07.26.21.57.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jul 2022 21:57:41 -0700 (PDT)
Date:   Wed, 27 Jul 2022 12:57:36 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
Subject: Re: [PATCH] fstests: add test case to make sure btrfs can handle one
 corrupted device
Message-ID: <20220727045736.pa46d55t67g7jwwl@zlang-mailbox>
References: <20220726062948.56315-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220726062948.56315-1-wqu@suse.com>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jul 26, 2022 at 02:29:48PM +0800, Qu Wenruo wrote:
> The new test case will verify that btrfs can handle one corrupted device
> without affecting the consistency of the filesystem.
> 
> Unlike a missing device, one corrupted device can return garbage to the fs,
> thus btrfs has to utilize its data/metadata checksum to verify which
> data is correct.
> 
> The test case will:
> 
> - Create a small fs
>   Mostly to speedup the test
> 
> - Fill the fs with a regular file
> 
> - Use fsstress to create some contents
> 
> - Save the fssum for later verification
> 
> - Corrupt one device with garbage but keep the primary superblock
>   untouched
> 
> - Run fssum verification
> 
> - Run scrub to fix the fs
> 
> - Run scrub again to make sure the fs is fine
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  tests/btrfs/261     | 94 +++++++++++++++++++++++++++++++++++++++++++++
>  tests/btrfs/261.out |  2 +
>  2 files changed, 96 insertions(+)
>  create mode 100755 tests/btrfs/261
>  create mode 100644 tests/btrfs/261.out
> 
> diff --git a/tests/btrfs/261 b/tests/btrfs/261
> new file mode 100755
> index 00000000..15218e28
> --- /dev/null
> +++ b/tests/btrfs/261
> @@ -0,0 +1,94 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (C) 2022 SUSE Linux Products GmbH. All Rights Reserved.
> +#
> +# FS QA Test 261
> +#
> +# Make sure btrfs raid profiles can handling one corrupted device
> +# without affecting the consistency of the fs.
> +#
> +. ./common/preamble
> +_begin_fstest raid

Do you think about add it into auto group, or more groups?

> +
> +. ./common/filter
> +. ./common/populate
> +
> +_supported_fs btrfs
> +_require_scratch_dev_pool 4
> +_require_fssum
> +
> +prepare_fs()
> +{
> +	local profile=$1
> +
> +	# We don't want too large fs which can take too long to populate
> +	# And the extra redirection of stderr is to avoid the RAID56 warning
> +	# message to polluate the golden output
> +	_scratch_pool_mkfs -m $profile -d $profile -b 1G >> $seqres.full 2>&1
> +	if [ $? -ne 0 ]; then
> +		echo "mkfs $mkfs_opts failed"
> +		return
> +	fi

If mkfs fails, below workload() will keep running, I think it's not what you
want, right?

> +
> +	# Disable compression, as compressed read repair is known to have problems
> +	_scratch_mount -o compress=no
> +
> +	# Fill some part of the fs first
> +	$XFS_IO_PROG -f -c "pwrite -S 0xfe 0 400M" $SCRATCH_MNT/garbage > /dev/null 2>&1
> +
> +	# Then use fsstress to generate some extra contents.
> +	# Disable setattr related operations, as it may set NODATACOW which will
> +	# not allow us to use btrfs checksum to verify the content.
> +	$FSSTRESS_PROG -f setattr=0 -d $SCRATCH_MNT -w -n 3000 > /dev/null 2>&1
> +	sync
> +
> +	# Save the fssum of this fs
> +	$FSSUM_PROG -A -f -w $tmp.saved_fssum $SCRATCH_MNT
> +	$BTRFS_UTIL_PROG fi show $SCRATCH_MNT >> $seqres.full
> +	_scratch_unmount
> +}
> +
> +workload()
> +{
> +	local target=$(echo $SCRATCH_DEV_POOL | $AWK_PROG '{print $1}')

In common/config, we always set SCRATCH_DEV to the first of $SCRATCH_DEV_POOL,
as below:

        # a btrfs tester will set only SCRATCH_DEV_POOL, we will put first of its dev
        # to SCRATCH_DEV and rest to SCRATCH_DEV_POOL to maintain the backward compatibility
        if [ ! -z "$SCRATCH_DEV_POOL" ]; then
                if [ ! -z "$SCRATCH_DEV" ]; then
                        echo "common/config: Error: \$SCRATCH_DEV ($SCRATCH_DEV) should be unset when \$SCRATCH_DEV_POOL ($SCRATCH_DEV_POOL) is set"
                        exit 1
                fi
                SCRATCH_DEV=`echo $SCRATCH_DEV_POOL | awk '{print $1}'`

is that help?

> +	local profile=$1
> +	local num_devs=$2
> +
> +	_scratch_dev_pool_get $num_devs
> +	echo "=== Testing profile $profile ===" >> $seqres.full
> +	rm -f -- $tmp.saved_fssum
> +	prepare_fs $profile
> +
> +	# Corrupt the target device, only keep the superblock.
> +	$XFS_IO_PROG -c "pwrite 1M 1023M" $target > /dev/null 2>&1

Do you need "_require_scratch_nocheck", if you corrupt the fs purposely?

But I think it won't check the SCRATCH_DEV currently, due to you even don't use
_require_scratch, and the _require_scratch_dev_pool might not trigger a fsck at
the end of the testing.

Hmm... I prefer having a "_require_scratch_nocheck", and you can use $SCRATCH_DEV
to replace your "$target".

> +
> +	_scratch_mount
> +
> +	# All content should be fine
> +	$FSSUM_PROG -r $tmp.saved_fssum $SCRATCH_MNT > /dev/null
> +
> +	# Scrub to fix the fs, this is known to report various correctable
> +	# errors
> +	$BTRFS_UTIL_PROG scrub start -B $SCRATCH_MNT >> $seqres.full 2>&1
> +
> +	# Make sure above scrub fixed the fs
> +	$BTRFS_UTIL_PROG scrub start -Br $SCRATCH_MNT >> $seqres.full
> +	if [ $? -ne 0 ]; then
> +		echo "scrub failed to fix the fs for profile $profile"
> +	fi
> +	_scratch_unmount
> +	_scratch_dev_pool_put
> +}
> +
> +workload raid1 2
> +workload raid1c3 3
> +workload raid1c4 4
> +workload raid10 4
> +workload raid5 3
> +workload raid6 4
> +
> +echo "Silence is golden"
> +
> +# success, all done
> +status=0
> +exit
> diff --git a/tests/btrfs/261.out b/tests/btrfs/261.out
> new file mode 100644
> index 00000000..679ddc0f
> --- /dev/null
> +++ b/tests/btrfs/261.out
> @@ -0,0 +1,2 @@
> +QA output created by 261
> +Silence is golden
> -- 
> 2.36.1
> 

