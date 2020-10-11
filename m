Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5ED2128A5C1
	for <lists+linux-btrfs@lfdr.de>; Sun, 11 Oct 2020 07:13:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726413AbgJKFNq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 11 Oct 2020 01:13:46 -0400
Received: from out20-75.mail.aliyun.com ([115.124.20.75]:51154 "EHLO
        out20-75.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725882AbgJKFNq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 11 Oct 2020 01:13:46 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07436612|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.299902-0.0029918-0.697107;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047202;MF=guan@eryu.me;NM=1;PH=DS;RN=4;RT=4;SR=0;TI=SMTPD_---.IhgccVE_1602393220;
Received: from localhost(mailfrom:guan@eryu.me fp:SMTPD_---.IhgccVE_1602393220)
          by smtp.aliyun-inc.com(10.147.41.120);
          Sun, 11 Oct 2020 13:13:40 +0800
Date:   Sun, 11 Oct 2020 13:13:40 +0800
From:   Eryu Guan <guan@eryu.me>
To:     fdmanana@kernel.org
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH] fstests: add a filter for the new getcap output
Message-ID: <20201011051340.GW3853@desktop>
References: <f2980ed83a5268a96b3ff9da15c58477ff24d7a4.1602334589.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f2980ed83a5268a96b3ff9da15c58477ff24d7a4.1602334589.git.fdmanana@suse.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Oct 10, 2020 at 01:57:31PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Starting with version 2.41 of libcap, the output of the getcap program
> changed and therefore some existing tests fail when the installed version
> of libcap is >= 2.41 (the latest version available at the moment is 2.44).
> 
> The change was made by the following commit of libcap:
> 
>   commit 177cd418031b1acfcf73fe3b1af9f3279828681c
>   Author: Andrew G. Morgan <morgan@kernel.org>
>   Date:   Tue Jul 21 22:58:05 2020 -0700
> 
>       A more compact form for the text representation of capabilities.
> 
>       While this does not change anything about the supported range of
>       equivalent text specifications for capabilities, as accepted by
>       cap_from_text(), this does alter the preferred output format of
>       cap_to_text() to be two characters shorter in most cases. That is,
>       what used to be summarized as:
> 
>          "= cap_foo+..."
> 
>       is now converted to the equivalent text:
> 
>          "cap_foo=..."
> 
>       which is also more intuitive.
> 
> So add a filter to change the old format to the new one and adapt existing
> tests to use it and expect the new format in the golden output.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> ---
>  common/filter         | 28 ++++++++++++++++++++++++++++
>  tests/btrfs/214       | 14 +++++++-------
>  tests/generic/093     |  2 +-
>  tests/generic/093.out |  2 +-
>  tests/overlay/064     |  4 ++--
>  tests/overlay/064.out |  4 ++--
>  tests/xfs/296         |  2 +-
>  tests/xfs/296.out     |  4 ++--
>  8 files changed, 44 insertions(+), 16 deletions(-)
> 
> diff --git a/common/filter b/common/filter
> index 2477f386..64844c98 100644
> --- a/common/filter
> +++ b/common/filter
> @@ -603,5 +603,33 @@ _filter_assert_dmesg()
>  	    -e "s#$warn2#Intentional warnings in assfail#"
>  }
>  
> +# With version 2.41 of libcap, the output format of getcap changed.
> +# More specifically such change was added by the following commit:
> +#
> +# commit 177cd418031b1acfcf73fe3b1af9f3279828681c
> +# Author: Andrew G. Morgan <morgan@kernel.org>
> +# Date:   Tue Jul 21 22:58:05 2020 -0700
> +#
> +#     A more compact form for the text representation of capabilities.
> +#
> +#     While this does not change anything about the supported range of
> +#     equivalent text specifications for capabilities, as accepted by
> +#     cap_from_text(), this does alter the preferred output format of
> +#     cap_to_text() to be two characters shorter in most cases. That is,
> +#     what used to be summarized as:
> +#
> +#        "= cap_foo+..."
> +#
> +#     is now converted to the equivalent text:
> +#
> +#        "cap_foo=..."
> +#
> +#     which is also more intuitive.
> +#
> +_filter_getcap()
> +{
> +        sed -e "s/ = / /" -e "s/\+/=/"
> +}
> +

Thanks for the fix!

I' wondering if we could introduce a new _getcap helper which calls
_filter_getcap internally, so external users could just call _getcap
instead of "$GETCAP_PROG ... | _filter_getcap", like what we did in
commit 794f4594fbf4 ("fstests: filter redundant output by getfattr")

Thanks,
Eryu

>  # make sure this script returns success
>  /bin/true
> diff --git a/tests/btrfs/214 b/tests/btrfs/214
> index 35c4656c..6d08b991 100755
> --- a/tests/btrfs/214
> +++ b/tests/btrfs/214
> @@ -43,7 +43,7 @@ check_capabilities()
>  	local ret
>  	file="$1"
>  	cap="$2"
> -	ret=$($GETCAP_PROG "$file")
> +	ret=$($GETCAP_PROG "$file" | _filter_getcap)
>  	if [ -z "$ret" ]; then
>  		echo "$ret"
>  		echo "missing capability in file $file"
> @@ -84,7 +84,7 @@ full_nocap_inc_withcap_send()
>  	$BTRFS_UTIL_PROG subvolume snapshot -r "$FS1" "$FS1/snap_inc" >/dev/null
>  	$BTRFS_UTIL_PROG send -p "$FS1/snap_init" "$FS1/snap_inc" -q | \
>  					$BTRFS_UTIL_PROG receive "$FS2" -q
> -	check_capabilities "$FS2/snap_inc/foo.bar" "cap_sys_ptrace,cap_sys_nice+ep"
> +	check_capabilities "$FS2/snap_inc/foo.bar" "cap_sys_ptrace,cap_sys_nice=ep"
>  
>  	_scratch_unmount
>  }
> @@ -107,25 +107,25 @@ roundtrip_send()
>  	$SETCAP_PROG "cap_sys_ptrace+ep cap_sys_nice+ep" "$FS1/foo.bar"
>  	$BTRFS_UTIL_PROG subvolume snapshot -r "$FS1" "$FS1/snap_init" >/dev/null
>  	$BTRFS_UTIL_PROG send "$FS1/snap_init" -q | $BTRFS_UTIL_PROG receive "$FS2" -q
> -	check_capabilities "$FS2/snap_init/foo.bar" "cap_sys_ptrace,cap_sys_nice+ep"
> +	check_capabilities "$FS2/snap_init/foo.bar" "cap_sys_ptrace,cap_sys_nice=ep"
>  
>  	# Test incremental send with different owner/group but same capabilities
>  	chgrp 100 "$FS1/foo.bar"
>  	$SETCAP_PROG "cap_sys_ptrace+ep cap_sys_nice+ep" "$FS1/foo.bar"
>  	$BTRFS_UTIL_PROG subvolume snapshot -r "$FS1" "$FS1/snap_inc" >/dev/null
> -	check_capabilities "$FS1/snap_inc/foo.bar" "cap_sys_ptrace,cap_sys_nice+ep"
> +	check_capabilities "$FS1/snap_inc/foo.bar" "cap_sys_ptrace,cap_sys_nice=ep"
>  	$BTRFS_UTIL_PROG send -p "$FS1/snap_init" "$FS1/snap_inc" -q | \
>  				$BTRFS_UTIL_PROG receive "$FS2" -q
> -	check_capabilities "$FS2/snap_inc/foo.bar" "cap_sys_ptrace,cap_sys_nice+ep"
> +	check_capabilities "$FS2/snap_inc/foo.bar" "cap_sys_ptrace,cap_sys_nice=ep"
>  
>  	# Test capabilities after incremental send with different group and capabilities
>  	chgrp 0 "$FS1/foo.bar"
>  	$SETCAP_PROG "cap_sys_time+ep cap_syslog+ep" "$FS1/foo.bar"
>  	$BTRFS_UTIL_PROG subvolume snapshot -r "$FS1" "$FS1/snap_inc2" >/dev/null
> -	check_capabilities "$FS1/snap_inc2/foo.bar" "cap_sys_time,cap_syslog+ep"
> +	check_capabilities "$FS1/snap_inc2/foo.bar" "cap_sys_time,cap_syslog=ep"
>  	$BTRFS_UTIL_PROG send -p "$FS1/snap_inc" "$FS1/snap_inc2" -q | \
>  				$BTRFS_UTIL_PROG receive "$FS2"  -q
> -	check_capabilities "$FS2/snap_inc2/foo.bar" "cap_sys_time,cap_syslog+ep"
> +	check_capabilities "$FS2/snap_inc2/foo.bar" "cap_sys_time,cap_syslog=ep"
>  
>  	_scratch_unmount
>  }
> diff --git a/tests/generic/093 b/tests/generic/093
> index 0f835e7e..ed5f6f50 100755
> --- a/tests/generic/093
> +++ b/tests/generic/093
> @@ -51,7 +51,7 @@ touch $file
>  
>  echo "**** Verifying that appending to file clears capabilities ****"
>  $SETCAP_PROG cap_chown+ep $file
> -$GETCAP_PROG $file | filefilter
> +$GETCAP_PROG $file | filefilter | _filter_getcap
>  echo data1 >> $file
>  cat $file
>  $GETCAP_PROG $file | filefilter
> diff --git a/tests/generic/093.out b/tests/generic/093.out
> index cb29153e..fe6dfe5c 100644
> --- a/tests/generic/093.out
> +++ b/tests/generic/093.out
> @@ -1,7 +1,7 @@
>  QA output created by 093
>  
>  **** Verifying that appending to file clears capabilities ****
> -file = cap_chown+ep
> +file cap_chown=ep
>  data1
>  
>  **** Verifying that appending to file doesn't clear other xattrs ****
> diff --git a/tests/overlay/064 b/tests/overlay/064
> index f5d5df1b..7ec3e420 100755
> --- a/tests/overlay/064
> +++ b/tests/overlay/064
> @@ -55,7 +55,7 @@ _scratch_mount "-o metacopy=on"
>  $XFS_IO_PROG -c "stat" ${SCRATCH_MNT}/file1 >>$seqres.full
>  
>  # Make sure cap_setuid is still there
> -$GETCAP_PROG ${SCRATCH_MNT}/file1 | _filter_scratch
> +$GETCAP_PROG ${SCRATCH_MNT}/file1 | _filter_scratch | _filter_getcap
>  
>  # Trigger metadata only copy-up
>  chmod 000 ${SCRATCH_MNT}/file2
> @@ -64,7 +64,7 @@ chmod 000 ${SCRATCH_MNT}/file2
>  $XFS_IO_PROG -c "stat" ${SCRATCH_MNT}/file2 >>$seqres.full
>  
>  # Make sure cap_setuid is still there
> -$GETCAP_PROG ${SCRATCH_MNT}/file2 | _filter_scratch
> +$GETCAP_PROG ${SCRATCH_MNT}/file2 | _filter_scratch | _filter_getcap
>  
>  # success, all done
>  status=0
> diff --git a/tests/overlay/064.out b/tests/overlay/064.out
> index cdd3064d..07f89fbd 100644
> --- a/tests/overlay/064.out
> +++ b/tests/overlay/064.out
> @@ -1,3 +1,3 @@
>  QA output created by 064
> -SCRATCH_MNT/file1 = cap_setuid+ep
> -SCRATCH_MNT/file2 = cap_setuid+ep
> +SCRATCH_MNT/file1 cap_setuid=ep
> +SCRATCH_MNT/file2 cap_setuid=ep
> diff --git a/tests/xfs/296 b/tests/xfs/296
> index 915ffa0c..f67b8386 100755
> --- a/tests/xfs/296
> +++ b/tests/xfs/296
> @@ -49,7 +49,7 @@ $SETCAP_PROG cap_setgid,cap_setuid+ep $dump_dir/testfile
>  echo "Checking for xattr on source file"
>  getfattr --absolute-names -m user.name $dump_dir/testfile | _dir_filter
>  echo "Checking for capability on source file"
> -$GETCAP_PROG $dump_dir/testfile | _dir_filter
> +$GETCAP_PROG $dump_dir/testfile | _dir_filter | _filter_getcap
>  getfattr --absolute-names -m security.capability $dump_dir/testfile | _dir_filter
>  
>  _do_dump_file -f $tmp.df.0
> diff --git a/tests/xfs/296.out b/tests/xfs/296.out
> index c279465c..f5cc624e 100644
> --- a/tests/xfs/296.out
> +++ b/tests/xfs/296.out
> @@ -4,7 +4,7 @@ Checking for xattr on source file
>  user.name
>  
>  Checking for capability on source file
> -DUMP_DIR/testfile = cap_setgid,cap_setuid+ep
> +DUMP_DIR/testfile cap_setgid,cap_setuid=ep
>  # file: DUMP_DIR/testfile
>  security.capability
>  
> @@ -50,7 +50,7 @@ Checking for xattr on restored file
>  user.name
>  
>  Checking for capability on restored file
> -RESTORE_DIR/DUMP_SUBDIR/testfile = cap_setgid,cap_setuid+ep
> +RESTORE_DIR/DUMP_SUBDIR/testfile cap_setgid,cap_setuid=ep
>  # file: RESTORE_DIR/DUMP_SUBDIR/testfile
>  security.capability
>  
> -- 
> 2.28.0
