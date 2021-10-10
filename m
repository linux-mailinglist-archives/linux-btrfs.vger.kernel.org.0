Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9445942818A
	for <lists+linux-btrfs@lfdr.de>; Sun, 10 Oct 2021 15:32:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232788AbhJJNeW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 10 Oct 2021 09:34:22 -0400
Received: from out20-99.mail.aliyun.com ([115.124.20.99]:35241 "EHLO
        out20-99.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232786AbhJJNeV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 10 Oct 2021 09:34:21 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.08859921|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.278371-0.00175368-0.719876;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047206;MF=guan@eryu.me;NM=1;PH=DS;RN=5;RT=5;SR=0;TI=SMTPD_---.LWl7PFo_1633872740;
Received: from localhost(mailfrom:guan@eryu.me fp:SMTPD_---.LWl7PFo_1633872740)
          by smtp.aliyun-inc.com(10.147.40.200);
          Sun, 10 Oct 2021 21:32:21 +0800
Date:   Sun, 10 Oct 2021 21:32:20 +0800
From:   Eryu Guan <guan@eryu.me>
To:     Ma Xinjian <xinjianx.ma@intel.com>
Cc:     fstests@vger.kernel.org, Philip Li <philip.li@intel.com>,
        kernel test robot <lkp@intel.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 1/2] btrfs/049: remove the test
Message-ID: <YWLrZHPZ1VIn5qIH@desktop>
References: <20210927072019.46609-1-xinjianx.ma@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210927072019.46609-1-xinjianx.ma@intel.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[cc'ed btrfs list]

On Mon, Sep 27, 2021 at 03:20:18PM +0800, Ma Xinjian wrote:
> inode_cache is deprecated and will never appear in mount
> options; remove it entirely

Please also cc btrfs list in future patches for btrfs-specific tests.

And I'd like an ack from btrfs folks.

Thanks,
Eryu

> 
> Link: https://www.spinics.net/lists/linux-btrfs/msg107910.html
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Ma Xinjian <xinjianx.ma@intel.com>
> ---
>  tests/btrfs/049 | 85 -------------------------------------------------
>  1 file changed, 85 deletions(-)
>  delete mode 100755 tests/btrfs/049
> 
> diff --git a/tests/btrfs/049 b/tests/btrfs/049
> deleted file mode 100755
> index 87c205ca..00000000
> --- a/tests/btrfs/049
> +++ /dev/null
> @@ -1,85 +0,0 @@
> -#! /bin/bash
> -# SPDX-License-Identifier: GPL-2.0
> -# Copyright (c) 2014 Fujitsu.  All Rights Reserved.
> -#
> -# FS QA Test No. btrfs/049
> -#
> -# Regression test for btrfs inode caching vs tree log which was
> -# addressed by the following kernel patch.
> -#
> -# Btrfs: fix inode caching vs tree log
> -#
> -. ./common/preamble
> -_begin_fstest auto quick
> -
> -# Override the default cleanup function.
> -_cleanup()
> -{
> -	_cleanup_flakey
> -	rm -rf $tmp
> -}
> -
> -# Import common functions.
> -. ./common/filter
> -. ./common/dmflakey
> -
> -# real QA test starts here
> -_supported_fs btrfs
> -_require_scratch
> -_require_dm_target flakey
> -# Zoned btrfs does not support inode cache
> -_require_non_zoned_device "$SCRATCH_DEV"
> -
> -_scratch_mkfs >> $seqres.full 2>&1
> -
> -SAVE_MOUNT_OPTIONS="$MOUNT_OPTIONS"
> -MOUNT_OPTIONS="$MOUNT_OPTIONS -o inode_cache,commit=100"
> -
> -# create a basic flakey device that will never error out
> -_init_flakey
> -_mount_flakey
> -
> -_get_inode_id()
> -{
> -	local inode_id
> -	inode_id=`stat $1 | grep Inode: | $AWK_PROG '{print $4}'`
> -	echo $inode_id
> -}
> -
> -$XFS_IO_PROG -f -c "pwrite 0 10M" -c "fsync" \
> -	$SCRATCH_MNT/data >& /dev/null
> -
> -inode_id=`_get_inode_id "$SCRATCH_MNT/data"`
> -rm -f $SCRATCH_MNT/data
> -
> -for i in `seq 1 5`;
> -do
> -	mkdir $SCRATCH_MNT/dir_$i
> -	new_inode_id=`_get_inode_id $SCRATCH_MNT/dir_$i`
> -	if [ $new_inode_id -eq $inode_id ]
> -	then
> -		$XFS_IO_PROG -f -c "pwrite 0 1M" -c "fsync" \
> -			$SCRATCH_MNT/dir_$i/data1 >& /dev/null
> -		_load_flakey_table 1
> -		_unmount_flakey
> -		need_umount=1
> -		break
> -	fi
> -	sleep 1
> -done
> -
> -# restore previous mount options
> -export MOUNT_OPTIONS="$SAVE_MOUNT_OPTIONS"
> -
> -# ok mount so that any recovery that needs to happen is done
> -if [ $new_inode_id -eq $inode_id ];then
> -	_load_flakey_table $FLAKEY_ALLOW_WRITES
> -	_mount_flakey
> -	_unmount_flakey
> -fi
> -
> -# make sure we got a valid fs after replay
> -_check_scratch_fs $FLAKEY_DEV
> -
> -status=0
> -exit
> -- 
> 2.20.1
