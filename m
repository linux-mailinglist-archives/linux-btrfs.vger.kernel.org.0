Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19362697E4A
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Feb 2023 15:24:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229587AbjBOOYz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 15 Feb 2023 09:24:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjBOOYy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 15 Feb 2023 09:24:54 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 375D62385A
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Feb 2023 06:24:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676471048;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jSIKkot8QTaKRSc9LAyx2lDHIDveDMhL+xYOW2MFkz0=;
        b=NTAUhaKU2yN7VYs/VcgIokD6EHxvoZrC782nU0INuuJdwrbbza3qDG4ZiNVKoVInpiZiNU
        8ypSOq703K++wEqqK9mJ6iPTpq0mDTn/So5a/n9Ag8xYob3TJNL9R5pNj0ie+gD8gh/42A
        mfT9X1NPY9fFDJ8XE0MRCRKcg6UCd/A=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-455-8gMxtjHmOPSrwseIen658g-1; Wed, 15 Feb 2023 09:24:07 -0500
X-MC-Unique: 8gMxtjHmOPSrwseIen658g-1
Received: by mail-pf1-f199.google.com with SMTP id c11-20020a62e80b000000b005a8ba9365c1so4857366pfi.18
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Feb 2023 06:24:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jSIKkot8QTaKRSc9LAyx2lDHIDveDMhL+xYOW2MFkz0=;
        b=Cu8iFm0nbK4dKRkYyJVl/0KIsV5Dx93NBodkBGI6hsAPhs6+jIv3Jb93gSNZdlnWhu
         x4tYWncO1rWAJ3QVE1n6X3SnePPBlCZI7/S7JQJramocinQLnsLbSibQqyJlG3Vtzupg
         X1t6nh63TfjJHZwo8F8vgAY5Y6sJNVBR0P8ZNMCf9qiLI1FBox6cNwz7fBxDA0T01EdQ
         PynF+4zsZuvRDZ8Ql8xcBW51JoxZwRcYsEi0eTd+auUexcdzZ38r2k+/HoO0uSaijlk+
         Pxuv1nSCICfCpdkhia7MtC9YBBFnoRGDr/OIBQqJ7DBRZENSqqqgnVOUZSrYH9gOt08X
         V9ow==
X-Gm-Message-State: AO0yUKWj1TjC6hkTaljUp5K4/zS9lJfiCHMxnsEVDQDaYTvqbOsaNkyn
        uCx2120g+gcqeuez016zfd93aucglB1a8TtXx1Mrgx6zcbi8kJ/gnXD5J8oRNZoIyXIuygFoQgR
        /AELXqEZ0JIxLT3Hs/E9H0Aw=
X-Received: by 2002:a17:902:c641:b0:19a:743e:b152 with SMTP id s1-20020a170902c64100b0019a743eb152mr1941825pls.63.1676471045906;
        Wed, 15 Feb 2023 06:24:05 -0800 (PST)
X-Google-Smtp-Source: AK7set/zjEDh12onm8Psu6/eQfyVHBWcD1SbgI/9RCVRufOgmdQtw4dt55uGvlDPFX7fiKn3Lq+6BA==
X-Received: by 2002:a17:902:c641:b0:19a:743e:b152 with SMTP id s1-20020a170902c64100b0019a743eb152mr1941809pls.63.1676471045563;
        Wed, 15 Feb 2023 06:24:05 -0800 (PST)
Received: from zlang-mailbox ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id jf21-20020a170903269500b0019a7bb18f98sm9332476plb.48.2023.02.15.06.24.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Feb 2023 06:24:05 -0800 (PST)
Date:   Wed, 15 Feb 2023 22:24:01 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v3] fstests: btrfs/185, 198 and 219 add
 _fixed_by_kernel_commit
Message-ID: <20230215142401.3lkbmkpxvkhads7t@zlang-mailbox>
References: <cover.1676034764.git.anand.jain@oracle.com>
 <b0375c439b0f4d4da5de569d19bcb53bc2a0c66a.1676446803.git.anand.jain@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b0375c439b0f4d4da5de569d19bcb53bc2a0c66a.1676446803.git.anand.jain@oracle.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Feb 15, 2023 at 03:51:22PM +0800, Anand Jain wrote:
> Recently, these test cases were added to the auto group. To ensure we have
> some clues if they fail in older kernels, add "_fixed_by_kernel_commit"
> for the fix and update the test summary.
> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---

Looks good to me,
Reviewed-by: Zorro Lang <zlang@redhat.com>

> v3: Combine these patches together.
> 	fstests: btrfs/198, add _fixed_by_kernel_commit
> 	fstests: btrfs/219, add _fixed_by_kernel_commit
> 	fstests: btrfs/185, add _fixed_by_kernel_commit
>     
> v2: btrfs/219: _fixed_by_kernel_commit: Substitute the placeholder with
>     the commit id.
> 
>  tests/btrfs/185 | 2 ++
>  tests/btrfs/198 | 6 +++---
>  tests/btrfs/219 | 9 ++++-----
>  3 files changed, 9 insertions(+), 8 deletions(-)
> 
> diff --git a/tests/btrfs/185 b/tests/btrfs/185
> index efb10ac72b79..ba0200617e69 100755
> --- a/tests/btrfs/185
> +++ b/tests/btrfs/185
> @@ -27,6 +27,8 @@ _cleanup()
>  _supported_fs btrfs
>  _require_scratch_dev_pool 2
>  _scratch_dev_pool_get 2
> +_fixed_by_kernel_commit a9261d4125c9 \
> +	"btrfs: harden agaist duplicate fsid on scanned devices"
>  
>  device_1=$(echo $SCRATCH_DEV_POOL | $AWK_PROG '{print $1}')
>  device_2=$(echo $SCRATCH_DEV_POOL | $AWK_PROG '{print $2}')
> diff --git a/tests/btrfs/198 b/tests/btrfs/198
> index 2b68754ade52..7d23ffcee3c5 100755
> --- a/tests/btrfs/198
> +++ b/tests/btrfs/198
> @@ -4,9 +4,7 @@
>  #
>  # FS QA Test 198
>  #
> -# Test stale and alien non-btrfs device in the fs devices list.
> -#  Bug fixed in:
> -#    btrfs: remove identified alien device in open_fs_devices
> +# Test outdated and foreign non-btrfs devices in the device listing.
>  #
>  . ./common/preamble
>  _begin_fstest auto quick volume
> @@ -22,6 +20,8 @@ _require_scratch
>  _require_scratch_dev_pool 4
>  # Zoned btrfs only supports SINGLE profile
>  _require_non_zoned_device ${SCRATCH_DEV}
> +_fixed_by_kernel_commit 96c2e067ed3e3e \
> +	"btrfs: skip devices without magic signature when mounting"
>  
>  workout()
>  {
> diff --git a/tests/btrfs/219 b/tests/btrfs/219
> index d69e6ac918ae..b747ce34fcc4 100755
> --- a/tests/btrfs/219
> +++ b/tests/btrfs/219
> @@ -6,11 +6,8 @@
>  #
>  # Test a variety of stale device usecases.  We cache the device and generation
>  # to make sure we do not allow stale devices, which can end up with some wonky
> -# behavior for loop back devices.  This was changed with
> -#
> -#   btrfs: allow single disk devices to mount with older generations
> -#
> -# But I've added a few other test cases so it's clear what we expect to happen
> +# behavior for loop back devices.
> +# And, added a few other test cases so it's clear what we expect to happen
>  # currently.
>  #
>  
> @@ -42,6 +39,8 @@ _supported_fs btrfs
>  _require_test
>  _require_loop
>  _require_btrfs_forget_or_module_loadable
> +_fixed_by_kernel_commit 5f58d783fd78 \
> +	"btrfs: free device in btrfs_close_devices for a single device filesystem"
>  
>  loop_mnt=$TEST_DIR/$seq.mnt
>  loop_mnt1=$TEST_DIR/$seq.mnt1
> -- 
> 2.38.1
> 

