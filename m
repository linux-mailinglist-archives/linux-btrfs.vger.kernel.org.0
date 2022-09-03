Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE1555ABBE8
	for <lists+linux-btrfs@lfdr.de>; Sat,  3 Sep 2022 02:46:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229731AbiICAoO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 2 Sep 2022 20:44:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbiICAoM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 2 Sep 2022 20:44:12 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DEBCDC5D3
        for <linux-btrfs@vger.kernel.org>; Fri,  2 Sep 2022 17:44:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662165850;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yOBDvKJ7qVFQZivKym6g6NBVGmxKrxbTzFWb9Hu5L78=;
        b=PH07hjny3GjuPGTi2gpJ6Yr3FKerZj1ZaeuEXl74NZGKtS/znp1mZpasZdSdHDU4PXwAwJ
        iNcUpgF+Zmj1VdwfwSfuMYrX/qI1DpK5aPnEHfS75/T8CtXECJ5z7msxjZ7PEp80IhARvS
        geWo5o2kz5m7Eypm/0wetoufSXLYUEs=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-365-fXVee7AuNFKgUgR-Rfar6A-1; Fri, 02 Sep 2022 20:44:09 -0400
X-MC-Unique: fXVee7AuNFKgUgR-Rfar6A-1
Received: by mail-qk1-f200.google.com with SMTP id g6-20020a05620a40c600b006bbdeb0b1f2so3206905qko.22
        for <linux-btrfs@vger.kernel.org>; Fri, 02 Sep 2022 17:44:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=yOBDvKJ7qVFQZivKym6g6NBVGmxKrxbTzFWb9Hu5L78=;
        b=mpgDG1lvVWvlDV//UAi0FUUH5w1UqhfcFZvZhLPj2GIKEAIz30RhzJcoGI9WNw2G4W
         5Gng/Adyu4apz/WBFT7ANNfTbFgiENQRqgLd3mKwsvjC1BWVA3RoDPou2Pn4potXdibm
         BoWztsRWvVrhw7tnkYrE3HolxGe0SdeayOUHoCwDt0T3NUvIUiT3rKh9H0i0PJ57QEgl
         gRrKeAW0IcPNbE7hGynuVz0leldRJmKhP9xNPUW291miACKmg6/uhjvAvtpPhn+h82Mv
         zkq9KpMyNycCdiT4BRvym/hEIDd9LGrkujpUjZc8xwXcBKT4LN3Dzq/N47Xs/5ncKgOV
         v/KQ==
X-Gm-Message-State: ACgBeo3PGqGyarqQ+0FGgZCubVZYAXQW5GqZD5jnm9PBJjWcRPcBj+OM
        qYLAjvtlgauqX+hdAOCJ7iII1DFPXZ+UXcfbSyVR9kbJJHyXLgzv1b2WgCkG0ZM/ZKhgcfozC2h
        SsvKX+fmkptlvus+jBP0Hyj0=
X-Received: by 2002:a05:622a:1b8c:b0:344:5d0e:e795 with SMTP id bp12-20020a05622a1b8c00b003445d0ee795mr31313336qtb.86.1662165848368;
        Fri, 02 Sep 2022 17:44:08 -0700 (PDT)
X-Google-Smtp-Source: AA6agR57Vedc3NssA7yui3Ckh/vwesHYzFCyslYqSieBZL/EeSk123D5AMgLpdLjgKP5CvNX+MxOYw==
X-Received: by 2002:a05:622a:1b8c:b0:344:5d0e:e795 with SMTP id bp12-20020a05622a1b8c00b003445d0ee795mr31313322qtb.86.1662165848123;
        Fri, 02 Sep 2022 17:44:08 -0700 (PDT)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id o1-20020ac85541000000b00339163a06fcsm1968981qtr.6.2022.09.02.17.44.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Sep 2022 17:44:07 -0700 (PDT)
Date:   Sat, 3 Sep 2022 08:44:01 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     fdmanana@kernel.org
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH v2] btrfs: test that we can not delete a subvolume with
 an active swap file
Message-ID: <20220903004401.xobe5elurx3bkh3f@zlang-mailbox>
References: <0bc9cd4abfbde3f76b981628942f94631cef7162.1662110839.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0bc9cd4abfbde3f76b981628942f94631cef7162.1662110839.git.fdmanana@suse.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Sep 02, 2022 at 10:30:32AM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Verify that we can not delete a subvolume that has an active swap file,
> and that after disabling the swap file, we can delete it.
> 
> This tests a fix done by kernel commit 60021bd754c6ca ("btrfs: prevent
> subvol with swapfile from being deleted"), which landed in kernel 5.18.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> ---
> 
> V2: Add _cleanup() override to make sure swapfile is disabled in case
>     the test is interrupted.

Thanks for doing this cleanup, now it's good to me.

Reviewed-by: Zorro Lang <zlang@redhat.com>

> 
>  tests/btrfs/274     | 58 +++++++++++++++++++++++++++++++++++++++++++++
>  tests/btrfs/274.out |  6 +++++
>  2 files changed, 64 insertions(+)
>  create mode 100755 tests/btrfs/274
>  create mode 100644 tests/btrfs/274.out
> 
> diff --git a/tests/btrfs/274 b/tests/btrfs/274
> new file mode 100755
> index 00000000..c0594e25
> --- /dev/null
> +++ b/tests/btrfs/274
> @@ -0,0 +1,58 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (C) 2022 SUSE Linux Products GmbH. All Rights Reserved.
> +#
> +# FS QA Test 274
> +#
> +# Test that we can not delete a subvolume that has an active swap file.
> +#
> +. ./common/preamble
> +_begin_fstest auto quick swap subvol
> +
> +_cleanup()
> +{
> +	cd /
> +	rm -f $tmp.*
> +	test -n "$swap_file" && swapoff $swap_file &> /dev/null
> +}
> +
> +. ./common/filter
> +
> +_supported_fs btrfs
> +_fixed_by_kernel_commit 60021bd754c6ca \
> +    "btrfs: prevent subvol with swapfile from being deleted"
> +_require_scratch_swapfile
> +
> +_scratch_mkfs >> $seqres.full 2>&1
> +_scratch_mount
> +
> +swap_file="$SCRATCH_MNT/subvol/swap"
> +$BTRFS_UTIL_PROG subvolume create $SCRATCH_MNT/subvol | _filter_scratch
> +
> +echo "Creating and activating swap file..."
> +_format_swapfile $swap_file $(($(get_page_size) * 32)) >> $seqres.full
> +_swapon_file $swap_file
> +
> +echo "Attempting to delete subvolume with swap file enabled..."
> +# Output differs with different btrfs-progs versions and some display multiple
> +# lines on failure like this for example:
> +#
> +#   ERROR: Could not destroy subvolume/snapshot: Operation not permitted
> +#   WARNING: deletion failed with EPERM, send may be in progress
> +#   Delete subvolume (no-commit): '/home/fdmanana/btrfs-tests/scratch_1/subvol'
> +#
> +# So just redirect all output to the .full file and check the command's exit
> +# status instead.
> +$BTRFS_UTIL_PROG subvolume delete $SCRATCH_MNT/subvol >> $seqres.full 2>&1 && \
> +    echo "subvolume deletion successful, expected failure!"
> +
> +echo "Disabling swap file..."
> +swapoff $swap_file
> +
> +echo "Attempting to delete subvolume after disabling swap file..."
> +$BTRFS_UTIL_PROG subvolume delete $SCRATCH_MNT/subvol >> $seqres.full 2>&1 || \
> +   echo "subvolume deletion failure, expected success!"
> +
> +# success, all done
> +status=0
> +exit
> diff --git a/tests/btrfs/274.out b/tests/btrfs/274.out
> new file mode 100644
> index 00000000..66e0de25
> --- /dev/null
> +++ b/tests/btrfs/274.out
> @@ -0,0 +1,6 @@
> +QA output created by 274
> +Create subvolume 'SCRATCH_MNT/subvol'
> +Creating and activating swap file...
> +Attempting to delete subvolume with swap file enabled...
> +Disabling swap file...
> +Attempting to delete subvolume after disabling swap file...
> -- 
> 2.35.1
> 

