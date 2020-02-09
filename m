Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 05DAB156B40
	for <lists+linux-btrfs@lfdr.de>; Sun,  9 Feb 2020 16:53:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727779AbgBIPxC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 9 Feb 2020 10:53:02 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:53735 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727692AbgBIPxC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 9 Feb 2020 10:53:02 -0500
Received: by mail-pj1-f66.google.com with SMTP id n96so3078756pjc.3;
        Sun, 09 Feb 2020 07:53:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Rg3xtxUVxTdvNUv6i3nkOtjO2KPDKiqBIT9VHd1+jr4=;
        b=c6p8btqpouR9XCizjPgKAdQbUosUfrlWVA1BUTamjdr+dm6uyCDI9cn1AhCUTjBVes
         8ijSv055Y4zczgAbpB95O7nfdQafA3oVnbRF/eAFqm11HjJrPmPHkb5FnCylaJWtfbjH
         /7m9qzj1MyL13naXNDbgLfjSYO44v54QI1ZOKxklYVxYadbMoUaszIdUVte50/YsQZpr
         1VRYxrwcyurR7SCdiv5RaFDBBZn+1xLULsP6Mejw76PhfqCH4zKZGyS5QXDZPz6NYLI7
         4d5aPJVDWOGieQv8MtsMsSXH1tlwQL6PR7JbzsBVSpFIKGz6wjFloqZe5eZCyoGpuYXU
         IPrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Rg3xtxUVxTdvNUv6i3nkOtjO2KPDKiqBIT9VHd1+jr4=;
        b=avFa7iMeyZwRXGOw4DLXMaMRUX1NgAK215avZHLV596z9QSrL81cgP5vqJAGoBMiNd
         6xeuJ+8od6ljnOuVRnJigW7DBqRl8iz5F8z+fKLFZo8F499SPKBXXK+yhSnsH8bMBQ9b
         1aulzXJHdB5nofCroQ9C1DUpgWtW9QNMULuGEOpEzWP21JKFnAPdx4K0lgwCQ+v/HGqr
         ArSQvR6otwoSqLP5tiJnsjqjNiEltykCT56K9yE6+T233B+eWP/h54xSbzUDPPPWTQa7
         Q/MeC1QLPoYv5VHVcZuX1ZseWiuDseSj0ruYVrV1s6tVi+gGV5ZAj0cfjTrQgC/+Ds3F
         o2gA==
X-Gm-Message-State: APjAAAWigPvcVZ1EB2t10w2S0gErTzX9lGCpcYoKPp8IoIRZr/GbHZfc
        nruGwangRNmyBsXzqfMdYqM=
X-Google-Smtp-Source: APXvYqyt92+/G7ON72Vzm92BJjyVirVR9lBE8cO52g012ziz6rp8rFvGwpXmKRThpS5xlfFsjZK3/w==
X-Received: by 2002:a17:90a:8b82:: with SMTP id z2mr16230575pjn.59.1581263581175;
        Sun, 09 Feb 2020 07:53:01 -0800 (PST)
Received: from localhost ([178.128.102.47])
        by smtp.gmail.com with ESMTPSA id v5sm9328747pgc.11.2020.02.09.07.52.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Feb 2020 07:53:00 -0800 (PST)
Date:   Sun, 9 Feb 2020 23:52:55 +0800
From:   Eryu Guan <guaneryu@gmail.com>
To:     Qu Wenruo <wqu@suse.com>
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 2/2] fstests: btrfs: Fix a bug where test case can't grab
 the 2nd device when glob is used
Message-ID: <20200209155255.GG2697@desktop>
References: <20200120070938.30247-1-wqu@suse.com>
 <20200120070938.30247-2-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200120070938.30247-2-wqu@suse.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jan 20, 2020 at 03:09:38PM +0800, Qu Wenruo wrote:
> If SCRATCH_DEV_POOL is definted using glob, e.g.
> SCRATCH_DEV_POOL="/dev/mapper/test-scratch[123456]", then btrfs/175 will

I don't think this is necessary, and I think it's not a problem that
fstests should resolve.

Usually Config file is not always changing, setting SCRATCH_DEV_POOL
correctly for once should be fine. A simple command could expand the
device list for you:

    [root@fedoravm xfstests]# ls /dev/mapper/testvg-lv[1234567]
    /dev/mapper/testvg-lv1  /dev/mapper/testvg-lv2 /dev/mapper/testvg-lv3  /dev/mapper/testvg-lv4 /dev/mapper/testvg-lv5  /dev/mapper/testvg-lv6 /dev/mapper/testvg-lv7

Then just copy/paste the device list.

Thanks,
Eryu

> fail like this:
> btrfs/175 15s ... - output mismatch (see results//btrfs/175.out.bad)
>     --- tests/btrfs/175.out     2019-10-22 15:18:14.085632007 +0800
>     +++ results//btrfs/175.out.bad      2020-01-20 14:53:56.518567916 +0800
>     @@ -6,3 +6,4 @@
>      Single on multiple devices
>      swapon: SCRATCH_MNT/swap: swapon failed: Invalid argument
>      Single on one device
>     +ERROR: checking status of : No such file or directory
>     ...
>     (Run 'diff -u tests/btrfs/175.out results//btrfs/175.out.bad'  to see the entire diff)
> 
> This is caused by the extra quotation mark (and the complexity nature of
> bash glob).
> 
>   # SCRATCH_DEV_POOL="/dev/mapper/test-scratch[123]"
>   # echo ${SCRATCH_DEV_POOL}
>   /dev/mapper/test-scratch1 /dev/mapper/test-scratch2 /dev/mapper/test-scratch3
>   # echo "${SCRATCH_DEV_POOL}"
>   /dev/mapper/test-scratch[123]
> 
> To fix the problem, remove the quotation mark out of
> ${SCRATCH_DEV_POOL} or $SCRATCH_DEV_POOL for all related test cases.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
> The weirdest thing is, only btrfs/17[56], all other related test cases
> pass without any problem.
> 
> Maybe it's time to provide a proper wrapper to do such thing?
> ---
>  tests/btrfs/140 | 2 +-
>  tests/btrfs/141 | 2 +-
>  tests/btrfs/142 | 2 +-
>  tests/btrfs/143 | 2 +-
>  tests/btrfs/157 | 2 +-
>  tests/btrfs/158 | 2 +-
>  tests/btrfs/175 | 2 +-
>  tests/btrfs/176 | 6 +++---
>  8 files changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/tests/btrfs/140 b/tests/btrfs/140
> index f0db8022cb48..0e6c91019854 100755
> --- a/tests/btrfs/140
> +++ b/tests/btrfs/140
> @@ -65,7 +65,7 @@ get_devid()
>  get_device_path()
>  {
>  	local devid=$1
> -	echo "$SCRATCH_DEV_POOL" | $AWK_PROG "{print \$$devid}"
> +	echo $SCRATCH_DEV_POOL | $AWK_PROG "{print \$$devid}"
>  }
>  
>  _scratch_dev_pool_get 2
> diff --git a/tests/btrfs/141 b/tests/btrfs/141
> index c8c184ba29b0..5678e6513f80 100755
> --- a/tests/btrfs/141
> +++ b/tests/btrfs/141
> @@ -65,7 +65,7 @@ get_devid()
>  get_device_path()
>  {
>  	local devid=$1
> -	echo "$SCRATCH_DEV_POOL" | $AWK_PROG "{print \$$devid}"
> +	echo $SCRATCH_DEV_POOL | $AWK_PROG "{print \$$devid}"
>  }
>  
>  _scratch_dev_pool_get 2
> diff --git a/tests/btrfs/142 b/tests/btrfs/142
> index db0a3377a1ed..ae480352c4d9 100755
> --- a/tests/btrfs/142
> +++ b/tests/btrfs/142
> @@ -66,7 +66,7 @@ get_devid()
>  get_device_path()
>  {
>  	local devid=$1
> -	echo "$SCRATCH_DEV_POOL" | $AWK_PROG "{print \$$devid}"
> +	echo $SCRATCH_DEV_POOL | $AWK_PROG "{print \$$devid}"
>  }
>  
>  start_fail()
> diff --git a/tests/btrfs/143 b/tests/btrfs/143
> index 0388a52899c9..9e1e7ea0874d 100755
> --- a/tests/btrfs/143
> +++ b/tests/btrfs/143
> @@ -73,7 +73,7 @@ get_devid()
>  get_device_path()
>  {
>  	local devid=$1
> -	echo "$SCRATCH_DEV_POOL" | $AWK_PROG "{print \$$devid}"
> +	echo $SCRATCH_DEV_POOL | $AWK_PROG "{print \$$devid}"
>  }
>  
>  SYSFS_BDEV=`_sysfs_dev $SCRATCH_DEV`
> diff --git a/tests/btrfs/157 b/tests/btrfs/157
> index 634370b97ec0..c60d05ce36f3 100755
> --- a/tests/btrfs/157
> +++ b/tests/btrfs/157
> @@ -70,7 +70,7 @@ get_devid()
>  get_device_path()
>  {
>  	local devid=$1
> -	echo "$SCRATCH_DEV_POOL" | $AWK_PROG "{print \$$devid}"
> +	echo $SCRATCH_DEV_POOL | $AWK_PROG "{print \$$devid}"
>  }
>  
>  _scratch_dev_pool_get 4
> diff --git a/tests/btrfs/158 b/tests/btrfs/158
> index d6df9eaa7dea..179c620b223f 100755
> --- a/tests/btrfs/158
> +++ b/tests/btrfs/158
> @@ -62,7 +62,7 @@ get_devid()
>  get_device_path()
>  {
>  	local devid=$1
> -	echo "$SCRATCH_DEV_POOL" | $AWK_PROG "{print \$$devid}"
> +	echo $SCRATCH_DEV_POOL | $AWK_PROG "{print \$$devid}"
>  }
>  
>  _scratch_dev_pool_get 4
> diff --git a/tests/btrfs/175 b/tests/btrfs/175
> index d13be3e95ed4..e1c3c28fe5a4 100755
> --- a/tests/btrfs/175
> +++ b/tests/btrfs/175
> @@ -63,7 +63,7 @@ _scratch_mount
>  # Create the swap file, then add the device. That way we know it's all on one
>  # device.
>  _format_swapfile "$SCRATCH_MNT/swap" $(($(get_page_size) * 10))
> -scratch_dev2="$(echo "${SCRATCH_DEV_POOL}" | awk '{ print $2 }')"
> +scratch_dev2="$(echo ${SCRATCH_DEV_POOL} | awk '{ print $2 }')"
>  $BTRFS_UTIL_PROG device add -f "$scratch_dev2" "$SCRATCH_MNT"
>  swapon "$SCRATCH_MNT/swap" 2>&1 | _filter_scratch
>  swapoff "$SCRATCH_MNT/swap" > /dev/null 2>&1
> diff --git a/tests/btrfs/176 b/tests/btrfs/176
> index 196ba2b8bdf6..c2d67c6f807a 100755
> --- a/tests/btrfs/176
> +++ b/tests/btrfs/176
> @@ -39,9 +39,9 @@ _require_scratch_swapfile
>  # We check the filesystem manually because we move devices around.
>  rm -f "${RESULT_DIR}/require_scratch"
>  
> -scratch_dev1="$(echo "${SCRATCH_DEV_POOL}" | awk '{ print $1 }')"
> -scratch_dev2="$(echo "${SCRATCH_DEV_POOL}" | awk '{ print $2 }')"
> -scratch_dev3="$(echo "${SCRATCH_DEV_POOL}" | awk '{ print $3 }')"
> +scratch_dev1="$(echo ${SCRATCH_DEV_POOL} | awk '{ print $1 }')"
> +scratch_dev2="$(echo ${SCRATCH_DEV_POOL} | awk '{ print $2 }')"
> +scratch_dev3="$(echo ${SCRATCH_DEV_POOL} | awk '{ print $3 }')"
>  
>  echo "Remove device"
>  _scratch_mkfs >> $seqres.full 2>&1
> -- 
> 2.24.1
> 
