Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9182A7DE03C
	for <lists+linux-btrfs@lfdr.de>; Wed,  1 Nov 2023 12:21:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232947AbjKALVV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 1 Nov 2023 07:21:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbjKALVU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 1 Nov 2023 07:21:20 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F5E9111
        for <linux-btrfs@vger.kernel.org>; Wed,  1 Nov 2023 04:20:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698837628;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QTyqcZlOHGQJXCdpHXByWJ/AWE1HuXyWWjV78aM+2Ag=;
        b=OWUcTkZyjbX6dBEEpjWCmhBDLNyuPtcNRKnbfADatuZbObDKQLIKS1ifYXx4WEo2niKM8p
        7Wrkob8d5DOMRlRZe4w1oOdEpvrPRw2HdC9Zwan54qpbcPsCmomvIpKlBhREFiSS2laqx8
        TTFoYj+SyLbVEJtkE2rxAkn2FDzfkLQ=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-620-nGfJtPZuPLGq4vBy5eD0TQ-1; Wed, 01 Nov 2023 07:20:25 -0400
X-MC-Unique: nGfJtPZuPLGq4vBy5eD0TQ-1
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-280351c9fa1so3033760a91.3
        for <linux-btrfs@vger.kernel.org>; Wed, 01 Nov 2023 04:20:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698837623; x=1699442423;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QTyqcZlOHGQJXCdpHXByWJ/AWE1HuXyWWjV78aM+2Ag=;
        b=VzdD9iBmf7D5K/ICiM87iajewWkXd8CtyCYINYxukr3cjpf4IJAElMMjgx2h098oZo
         VMKzFis+BlBSWs6OzM/RbyXqeOp6E004ikiEPzWEr1nbErB1EN9ArKTTD+4cZKHddvke
         afUrmZuX1QlbyGEiUitLd6gjZxhCtJXOtK9ilwlNTGUoYRKW6cdbaocTWmlfwvogs++S
         vz9pAYNGiqDhlgQZcX5qZGLBHj9yviqPiLWT7az3l1sf9btOMmlrUHnRi/Vg+glLYkyn
         PSVgfq2tmt3LIUHap4Kr0VEdX5dQP6qtP+MWZ47KYsSFX4sf11vUSKFqh/sRv0JISPLp
         zucw==
X-Gm-Message-State: AOJu0Yz2j2uZe6ukU4bx0eAaQktzS372HUCxyFA84TnT6N9AeAbJEdl6
        sMbQb2pI7VrXA4vRoC9nBgajI2+xuQljZWT9brd/hq9D94/Uje+9dd9HANdBRp5ZbDIMp3jM7HF
        rZU4H1i97SoymMAmVAFGRXsY76nx2Jy24B5AM
X-Received: by 2002:a17:90b:696:b0:280:4829:52cc with SMTP id m22-20020a17090b069600b00280482952ccmr7762042pjz.37.1698837623325;
        Wed, 01 Nov 2023 04:20:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHLiVFV6YUI+YSkw11wJLkt38RQoqekfEHjOdQAtn6hLgGJyc4YTy2QdZJN+ZeDZsW+61clUQ==
X-Received: by 2002:a17:90b:696:b0:280:4829:52cc with SMTP id m22-20020a17090b069600b00280482952ccmr7762027pjz.37.1698837622943;
        Wed, 01 Nov 2023 04:20:22 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id 14-20020a17090a004e00b0027782f611d1sm733828pjb.36.2023.11.01.04.20.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Nov 2023 04:20:22 -0700 (PDT)
Date:   Wed, 1 Nov 2023 19:20:19 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v4 3/5] btrfs/219: fix _cleanup() to successful release
 the loop-device
Message-ID: <20231101112019.j3iojkkcwjz6bzrb@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <cover.1698712764.git.anand.jain@oracle.com>
 <77a360863a5d41d4e849fdb829145c6591d4e955.1698712764.git.anand.jain@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <77a360863a5d41d4e849fdb829145c6591d4e955.1698712764.git.anand.jain@oracle.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Oct 31, 2023 at 08:53:41AM +0800, Anand Jain wrote:
> When we fail with the message 'We were allowed to mount when we should
> have failed,' it will fail to clean up the loop devices, making it
> difficult to run further test cases or the same test case again.
> 
> So we need a 2nd loop device local variable to release it. Let's
> reorganize the local variables to clean them up in the _cleanup() function.
> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---
> 
> v4: rm -f, removed error/output redirection
>     rm, -r removed for file image
>     Check for the initialization of the local variable loop_dev[1-2]
>      before calling  _destroy_loop_device().

This looks like a single change of the whole patchset below:
  [PATCH 0/6 v3] btrfs/219 cloned-device mount capability update

The v3 patchset has some review points, better to be changed too.
And the V3 has 6 patches in the patchset, now this patch names 3/5.
I'm a little confused. Could you send the whole v4 patchset? Of
course you can send them with the RVBs you've gotten.

Thanks,
Zorro

> 
> v3: a split from the patch 5/6
> 
>  tests/btrfs/219 | 63 ++++++++++++++++++++++++++++---------------------
>  1 file changed, 36 insertions(+), 27 deletions(-)
> 
> diff --git a/tests/btrfs/219 b/tests/btrfs/219
> index b747ce34fcc4..35824df2baaa 100755
> --- a/tests/btrfs/219
> +++ b/tests/btrfs/219
> @@ -19,14 +19,19 @@ _cleanup()
>  {
>  	cd /
>  	rm -f $tmp.*
> -	if [ ! -z "$loop_mnt" ]; then
> -		$UMOUNT_PROG $loop_mnt
> -		rm -rf $loop_mnt
> -	fi
> -	[ ! -z "$loop_mnt1" ] && rm -rf $loop_mnt1
> -	[ ! -z "$fs_img1" ] && rm -rf $fs_img1
> -	[ ! -z "$fs_img2" ] && rm -rf $fs_img2
> -	[ ! -z "$loop_dev" ] && _destroy_loop_device $loop_dev
> +
> +	# The variables are set before the test case can fail.
> +	$UMOUNT_PROG ${loop_mnt1} &> /dev/null
> +	$UMOUNT_PROG ${loop_mnt2} &> /dev/null
> +	rm -rf $loop_mnt1
> +	rm -rf $loop_mnt2
> +
> +	[ ! -z $loop_dev1 ] && _destroy_loop_device $loop_dev1
> +	[ ! -z $loop_dev1 ] && _destroy_loop_device $loop_dev2
> +
> +	rm -f $fs_img1
> +	rm -f $fs_img2
> +
>  	_btrfs_rescan_devices
>  }
>  
> @@ -36,56 +41,60 @@ _cleanup()
>  # real QA test starts here
>  
>  _supported_fs btrfs
> +
> +loop_mnt1=$TEST_DIR/$seq/mnt1
> +loop_mnt2=$TEST_DIR/$seq/mnt2
> +fs_img1=$TEST_DIR/$seq/img1
> +fs_img2=$TEST_DIR/$seq/img2
> +loop_dev1=""
> +loop_dev2=""
> +
>  _require_test
>  _require_loop
>  _require_btrfs_forget_or_module_loadable
>  _fixed_by_kernel_commit 5f58d783fd78 \
>  	"btrfs: free device in btrfs_close_devices for a single device filesystem"
>  
> -loop_mnt=$TEST_DIR/$seq.mnt
> -loop_mnt1=$TEST_DIR/$seq.mnt1
> -fs_img1=$TEST_DIR/$seq.img1
> -fs_img2=$TEST_DIR/$seq.img2
> -
> -mkdir $loop_mnt
> -mkdir $loop_mnt1
> +mkdir -p $loop_mnt1
> +mkdir -p $loop_mnt2
>  
>  $XFS_IO_PROG -f -c "truncate 256m" $fs_img1 >>$seqres.full 2>&1
>  
>  _mkfs_dev $fs_img1 >>$seqres.full 2>&1
>  cp $fs_img1 $fs_img2
>  
> +loop_dev1=`_create_loop_device $fs_img1`
> +loop_dev2=`_create_loop_device $fs_img2`
> +
>  # Normal single device case, should pass just fine
> -_mount -o loop $fs_img1 $loop_mnt > /dev/null  2>&1 || \
> +_mount $loop_dev1 $loop_mnt1 > /dev/null  2>&1 || \
>  	_fail "Couldn't do initial mount"
> -$UMOUNT_PROG $loop_mnt
> +$UMOUNT_PROG $loop_mnt1
>  
>  _btrfs_forget_or_module_reload
>  
>  # Now mount the new version again to get the higher generation cached, umount
>  # and try to mount the old version.  Mount the new version again just for good
>  # measure.
> -loop_dev=`_create_loop_device $fs_img1`
> -
> -_mount $loop_dev $loop_mnt > /dev/null 2>&1 || \
> +_mount $loop_dev1 $loop_mnt1 > /dev/null 2>&1 || \
>  	_fail "Failed to mount the second time"
> -$UMOUNT_PROG $loop_mnt
> +$UMOUNT_PROG $loop_mnt1
>  
> -_mount -o loop $fs_img2 $loop_mnt > /dev/null 2>&1 || \
> +_mount $loop_dev2 $loop_mnt2 > /dev/null 2>&1 || \
>  	_fail "We couldn't mount the old generation"
> -$UMOUNT_PROG $loop_mnt
> +$UMOUNT_PROG $loop_mnt2
>  
> -_mount $loop_dev $loop_mnt > /dev/null 2>&1 || \
> +_mount $loop_dev1 $loop_mnt1 > /dev/null 2>&1 || \
>  	_fail "Failed to mount the second time"
> -$UMOUNT_PROG $loop_mnt
> +$UMOUNT_PROG $loop_mnt1
>  
>  # Now we definitely can't mount them at the same time, because we're still tied
>  # to the limitation of one fs_devices per fsid.
>  _btrfs_forget_or_module_reload
>  
> -_mount $loop_dev $loop_mnt > /dev/null 2>&1 || \
> +_mount $loop_dev1 $loop_mnt1 > /dev/null 2>&1 || \
>  	_fail "Failed to mount the third time"
> -_mount -o loop $fs_img2 $loop_mnt1 > /dev/null 2>&1 && \
> +_mount $loop_dev2 $loop_mnt2 > /dev/null 2>&1 && \
>  	_fail "We were allowed to mount when we should have failed"
>  
>  _btrfs_rescan_devices
> -- 
> 2.31.1
> 
> 

