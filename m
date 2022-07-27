Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C0CA58260D
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Jul 2022 14:04:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232679AbiG0MEH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 27 Jul 2022 08:04:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232638AbiG0MEF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 27 Jul 2022 08:04:05 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B66934B0D8
        for <linux-btrfs@vger.kernel.org>; Wed, 27 Jul 2022 05:04:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658923443;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DsD0QECCbedGk1mxtV9KjVLQ7LObk4racnW2KcHcVX4=;
        b=ZTT4+M0Gb0P90Nbzr6LBBRo7estZQWkRvJxXPWaBu02SjtQ2tVNTFjLHBtxjxdFL++5/+m
        3JeB/pZTXk9cGbJAa790jLW3nPbRZz0a998FKprq7ZF8LA0zNGokPlCk0ycxHYu9chxTRm
        jI5/Kpeibk9LSCvh1BXmEdxp9O2TbTU=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-68-mosaKfw4OLOd--vjtyVKaA-1; Wed, 27 Jul 2022 08:04:02 -0400
X-MC-Unique: mosaKfw4OLOd--vjtyVKaA-1
Received: by mail-ot1-f72.google.com with SMTP id d25-20020a0568301b7900b0061cc02d2736so8661189ote.17
        for <linux-btrfs@vger.kernel.org>; Wed, 27 Jul 2022 05:04:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DsD0QECCbedGk1mxtV9KjVLQ7LObk4racnW2KcHcVX4=;
        b=i+HvdvoIY8NCxu0t9TufRxWsp8nHvetIrykJwPsXBCEfCo+ZloiGvkE2LmaUBzQ8w+
         /teSASpGnRx533ASaPjNMmxcRTMXDRwT4i6f3LhMURpSmLH2n6kpOKBCmMNXsashSoz7
         B7BkLUmOnrb9MwPs5KFoXTbXW3gWMrcTafm8dvBZQdCJIZlM3vNILH5owHNDnpSxjbiC
         P01I/OXYSyeyDNCHkz39+53atS82ExVfDuhf+GN8QnswCfyKBaGD3s9bOCQAsTEFECoz
         HhKTw3McnI0zW9+sbBcKCb31yGGf+5qIfzsfwSmfokxxyZyQeqiO5ndlyaAXfFJzQHIb
         +HKA==
X-Gm-Message-State: AJIora9aNrQAEDxtKHCKSRAr9rf7iHtDldF0AIL+RPyM6rpD9IkJKMpr
        JuQdYm9hv2NiP7eVcbM1xKjMlXY/MVCeGh4J4iysEUoS2Yj/Npe2KHxhKtZPt6NCf0N+kj9XJHk
        zWNXoS0nfZhKU287ZfxAZYrw=
X-Received: by 2002:a05:6871:79d:b0:10d:67e:c610 with SMTP id o29-20020a056871079d00b0010d067ec610mr1823093oap.147.1658923441748;
        Wed, 27 Jul 2022 05:04:01 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1u6uLmBQiFJvjhEucQKHNBt0KRkOGlfEp8ncDSWmrMdorHEMCi0N2mT1ygATkOO7L1H7g/IiQ==
X-Received: by 2002:a05:6871:79d:b0:10d:67e:c610 with SMTP id o29-20020a056871079d00b0010d067ec610mr1823079oap.147.1658923441428;
        Wed, 27 Jul 2022 05:04:01 -0700 (PDT)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id c17-20020a056870b29100b000e686d1386dsm8970720oao.7.2022.07.27.05.03.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jul 2022 05:04:01 -0700 (PDT)
Date:   Wed, 27 Jul 2022 20:03:54 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org, fstests@vger.kernel.org,
        Boris Burkov <boris@bur.io>
Subject: Re: [PATCH v2] fstests: add test case to make sure btrfs can handle
 one corrupted device
Message-ID: <20220727120354.zjc5nobsmidp2rsz@zlang-mailbox>
References: <20220727054148.73405-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220727054148.73405-1-wqu@suse.com>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jul 27, 2022 at 01:41:48PM +0800, Qu Wenruo wrote:
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
> Reviewed-by: Boris Burkov <boris@bur.io>
> ---
> Changelog:
> v2:
> - Use _btrfs_get_profile_configs() helper to grab the mkfs options
> - Use fixed number of devices 4 to co-operate with above change
> - Remove a not-so-helpful debug output into $seqres.full
> - Add to group auto and volume
> - Use $SCRATCH_DEV as the first device and target to corrupt
> ---
>  tests/btrfs/261     | 90 +++++++++++++++++++++++++++++++++++++++++++++
>  tests/btrfs/261.out |  2 +
>  2 files changed, 92 insertions(+)
>  create mode 100755 tests/btrfs/261
>  create mode 100644 tests/btrfs/261.out
> 
> diff --git a/tests/btrfs/261 b/tests/btrfs/261
> new file mode 100755
> index 00000000..8861ae99
> --- /dev/null
> +++ b/tests/btrfs/261
> @@ -0,0 +1,90 @@
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
> +_begin_fstest auto volume raid
> +
> +. ./common/filter
> +. ./common/populate

By checking the code, I can't find anything depends on these two common files.
So I think it's fine to remove these two include files (correct me if I'm wrong)

Others looks good to me, as you've gotten a review from btrfs list, I'll merge
this patch if no more objection.

Reviewed-by: Zorro Lang <zlang@redhat.com>

Thanks,
Zorro

> +
> +_supported_fs btrfs
> +_require_scratch_dev_pool 4
> +_btrfs_get_profile_configs replace-missing
> +_require_fssum
> +
> +prepare_fs()
> +{
> +	local mkfs_opts=$1
> +
> +	# We don't want too large fs which can take too long to populate
> +	# And the extra redirection of stderr is to avoid the RAID56 warning
> +	# message to polluate the golden output
> +	_scratch_pool_mkfs $mkfs_opts -b 1G >> $seqres.full 2>&1
> +	if [ $? -ne 0 ]; then
> +		_fail "mkfs $mkfs_opts failed"
> +	fi
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
> +	_scratch_unmount
> +}
> +
> +workload()
> +{
> +	local mkfs_opts=$1
> +	local num_devs=$2
> +
> +	_scratch_dev_pool_get 4
> +	echo "=== Testing profile $mkfs_opts ===" >> $seqres.full
> +	rm -f -- $tmp.saved_fssum
> +	prepare_fs "$mkfs_opts"
> +
> +	# $SCRATCH_DEV is always the first device of dev pool.
> +	# Corrupt the disk but keep the primary superblock.
> +	$XFS_IO_PROG -c "pwrite 1M 1023M" $SCRATCH_DEV > /dev/null 2>&1
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
> +		echo "scrub failed to fix the fs for profile $mkfs_opts"
> +	fi
> +	_scratch_unmount
> +	_scratch_dev_pool_put
> +}
> +
> +for t in "${_btrfs_profile_configs[@]}"; do
> +	workload "$t"
> +done
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

