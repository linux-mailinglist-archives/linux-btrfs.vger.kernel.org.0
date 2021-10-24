Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFB8843892F
	for <lists+linux-btrfs@lfdr.de>; Sun, 24 Oct 2021 15:34:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231618AbhJXNgj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 24 Oct 2021 09:36:39 -0400
Received: from out20-194.mail.aliyun.com ([115.124.20.194]:38867 "EHLO
        out20-194.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230301AbhJXNgi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 24 Oct 2021 09:36:38 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07483197|-1;BR=01201311R111S28rulernew998_84748_2000303;CH=blue;DM=|CONTINUE|false|;DS=CONTINUE|ham_alarm|0.02026-0.000258078-0.979482;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047202;MF=guan@eryu.me;NM=1;PH=DS;RN=5;RT=5;SR=0;TI=SMTPD_---.Lh.bWLy_1635082455;
Received: from localhost(mailfrom:guan@eryu.me fp:SMTPD_---.Lh.bWLy_1635082455)
          by smtp.aliyun-inc.com(10.147.41.138);
          Sun, 24 Oct 2021 21:34:16 +0800
Date:   Sun, 24 Oct 2021 21:34:15 +0800
From:   Eryu Guan <guan@eryu.me>
To:     Ma Xinjian <xinjianx.ma@intel.com>
Cc:     fstests@vger.kernel.org, Philip Li <philip.li@intel.com>,
        kernel test robot <lkp@intel.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 2/2] btrfs/091: remove noinode_cache option
Message-ID: <YXVg1xoLIvwxcjbD@desktop>
References: <20210927072019.46609-1-xinjianx.ma@intel.com>
 <20210927072019.46609-2-xinjianx.ma@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210927072019.46609-2-xinjianx.ma@intel.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Sep 27, 2021 at 03:20:19PM +0800, Ma Xinjian wrote:
> inode cache feature has been removed
> 
> Link: https://www.spinics.net/lists/linux-btrfs/msg107910.html

From above link, the inode cache feathre has been removed since v5.11
kernel, which is relatively a recent kernel,  but old kernels may still
need this noinode_cache mount option.  So we'd better to keep this
check.

We could add check for inode_cache option as well, and only check for
noinode_cache when inode cache is supported.

> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Ma Xinjian <xinjianx.ma@intel.com>
> ---
>  tests/btrfs/091 | 21 +--------------------
>  1 file changed, 1 insertion(+), 20 deletions(-)
> 
> diff --git a/tests/btrfs/091 b/tests/btrfs/091
> index 307289b1..f2cd00b2 100755
> --- a/tests/btrfs/091
> +++ b/tests/btrfs/091
> @@ -23,21 +23,12 @@ _require_cp_reflink
>  # use largest node/leaf size (64K) to allow the test to be run on arch with
>  # page size > 4k.
>  NODESIZE=65536
> -SUPPORT_NOINODE_CACHE="yes"
>  
>  run_check _scratch_mkfs "--nodesize $NODESIZE"
>  
> -# inode cache will also take space in fs tree, disable them to get consistent
> -# result.
>  # discard error output since we will check return value manually.
>  # also disable all compression, or output will mismatch with golden output
> -_try_scratch_mount "-o noinode_cache,compress=no,compress-force=no" 2> /dev/null
> -
> -# Check for old kernel which doesn't support 'noinode_cache' mount option
> -if [ $? -ne 0 ]; then
> -	support_noinode_cache="no"

This seems like a type in the original code, it should be in upper case.

Thanks,
Eryu

> -	_scratch_mount
> -fi
> +_try_scratch_mount "-o compress=no,compress-force=no" 2> /dev/null
>  
>  _run_btrfs_util_prog subvolume create $SCRATCH_MNT/subv1
>  _run_btrfs_util_prog subvolume create $SCRATCH_MNT/subv2
> @@ -46,16 +37,6 @@ _run_btrfs_util_prog subvolume create $SCRATCH_MNT/subv3
>  _run_btrfs_util_prog quota enable $SCRATCH_MNT
>  _run_btrfs_util_prog quota rescan -w $SCRATCH_MNT
>  
> -# if we don't support noinode_cache mount option, then we should double check
> -# whether inode cache is enabled before executing the real test payload.
> -if [ $SUPPORT_NOINODE_CACHE == "no" ]; then
> -	EMPTY_SIZE=`$BTRFS_UTIL_PROG qgroup show $units $SCRATCH_MNT | \
> -		$SED_PROG -n '/[0-9]/p' | $AWK_PROG '{print $2}' | head -n1`
> -	if [ $EMPTY_SIZE != $NODESIZE ]; then
> -		_notrun "Kernel doesn't support to disable inode cache"
> -	fi
> -fi
> -
>  $XFS_IO_PROG -f -c "pwrite 0 256K" $SCRATCH_MNT/subv1/file1 | _filter_xfs_io
>  cp --reflink $SCRATCH_MNT/subv1/file1 $SCRATCH_MNT/subv2/file1
>  cp --reflink $SCRATCH_MNT/subv1/file1 $SCRATCH_MNT/subv3/file1
> -- 
> 2.20.1
