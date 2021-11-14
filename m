Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3001944F7EE
	for <lists+linux-btrfs@lfdr.de>; Sun, 14 Nov 2021 13:44:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235186AbhKNMqM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 14 Nov 2021 07:46:12 -0500
Received: from out20-98.mail.aliyun.com ([115.124.20.98]:60016 "EHLO
        out20-98.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbhKNMqJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 14 Nov 2021 07:46:09 -0500
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07531802|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.132454-0.000853996-0.866692;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047188;MF=guan@eryu.me;NM=1;PH=DS;RN=4;RT=4;SR=0;TI=SMTPD_---.Lsf1oxm_1636893792;
Received: from localhost(mailfrom:guan@eryu.me fp:SMTPD_---.Lsf1oxm_1636893792)
          by smtp.aliyun-inc.com(10.147.41.137);
          Sun, 14 Nov 2021 20:43:13 +0800
Date:   Sun, 14 Nov 2021 20:43:12 +0800
From:   Eryu Guan <guan@eryu.me>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        fstests@vger.kernel.org
Subject: Re: [PATCH] fstests: detect btrfs compression and disable certain
 tests
Message-ID: <YZEEYNmDRpgPLqkL@desktop>
References: <f2b314338ecd06ae734ff0f0537f0cdf247db8f6.1636737764.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f2b314338ecd06ae734ff0f0537f0cdf247db8f6.1636737764.git.josef@toxicpanda.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Nov 12, 2021 at 12:23:18PM -0500, Josef Bacik wrote:
> Our nightly xfstests runs exposed a set of tests that always fail if we
> have compression enabled.  This is because compression obviously messes
> with the amount of data space allocated on disk, and these tests are
> testing either that quota is doing the correct thing, or that we're able
> to completely fill the file system.
> 
> Add a helper to check to see if we have any of our compression related
> mount options set and simply _not_run for these specific tests.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>  common/btrfs      | 10 ++++++++++
>  tests/btrfs/126   |  4 ++++
>  tests/btrfs/139   |  4 ++++
>  tests/btrfs/230   |  4 ++++
>  tests/btrfs/232   |  4 ++++
>  tests/generic/275 |  4 ++++
>  tests/generic/427 |  4 ++++
>  7 files changed, 34 insertions(+)
> 
> diff --git a/common/btrfs b/common/btrfs
> index 2eab4b29..b4067121 100644
> --- a/common/btrfs
> +++ b/common/btrfs
> @@ -113,6 +113,16 @@ _require_btrfs_fs_sysfs()
>  
>  }
>  
> +_require_btrfs_no_compress()

I think we could make it a common helper, not juse for btrfs, e.g.

_require_scratch_no_compress()

and do case switch based on $FSTYP, and only call
_require_scratch_btrfs_no_compress() for btrfs. Other $FSTYP could
return directly for now, and extend _require_scratch_no_compress() in
future if other filesystems gain compress support.

> +{
> +	if [ "$FSTYP" != "btrfs" ]; then
> +		return
> +	fi
> +
> +	_scratch_mount_options | grep -q "compress"

Could call _normalize_mount_options instead of _scratch_mount_options

> +	[ $? -eq 0 ] && _notrun "This test requires no compression enabled"
> +}
> +
>  _check_btrfs_filesystem()
>  {
>  	device=$1
> diff --git a/tests/btrfs/126 b/tests/btrfs/126
> index a13a0a6e..d9b638fd 100755
> --- a/tests/btrfs/126
> +++ b/tests/btrfs/126
> @@ -19,6 +19,10 @@ _supported_fs btrfs
>  _require_scratch
>  _require_btrfs_qgroup_report
>  
> +# This test requires specific data space usage, skip if we have compression
> +# enabled.
> +_require_btrfs_no_compress
> +
>  _scratch_mkfs >/dev/null
>  # Use enospc_debug mount option to trigger restrict space info check
>  _scratch_mount "-o enospc_debug"
> diff --git a/tests/btrfs/139 b/tests/btrfs/139
> index 7760182a..dcf85416 100755
> --- a/tests/btrfs/139
> +++ b/tests/btrfs/139
> @@ -19,6 +19,10 @@ _supported_fs btrfs
>  # We at least need 2GB of free space on $SCRATCH_DEV
>  _require_scratch_size $((2 * 1024 * 1024))
>  
> +# This test requires specific data space usage, skip if we have compression
> +# enabled.
> +_require_btrfs_no_compress
> +
>  _scratch_mkfs > /dev/null 2>&1
>  _scratch_mount
>  
> diff --git a/tests/btrfs/230 b/tests/btrfs/230
> index 2daacfbe..d431be50 100755
> --- a/tests/btrfs/230
> +++ b/tests/btrfs/230
> @@ -17,6 +17,10 @@ _begin_fstest auto quick qgroup limit
>  
>  _supported_fs btrfs
>  
> +# This test requires specific data space usage, skip if we have compression
> +# enabled.
> +_require_btrfs_no_compress
> +
>  # Need at least 2GiB
>  _require_scratch_size $((2 * 1024 * 1024))
>  _scratch_mkfs > /dev/null 2>&1
> diff --git a/tests/btrfs/232 b/tests/btrfs/232
> index 8691a508..eca1bf41 100755
> --- a/tests/btrfs/232
> +++ b/tests/btrfs/232
> @@ -33,6 +33,10 @@ writer()
>  
>  _supported_fs btrfs
>  
> +# This test requires specific data space usage, skip if we have compression
> +# enabled.
> +_require_btrfs_no_compress
> +
>  _require_scratch_size $((2 * 1024 * 1024))
>  _scratch_mkfs > /dev/null 2>&1
>  _scratch_mount
> diff --git a/tests/generic/275 b/tests/generic/275
> index bf0aa2b3..012bd45f 100755
> --- a/tests/generic/275
> +++ b/tests/generic/275
> @@ -25,6 +25,10 @@ _cleanup()
>  _supported_fs generic
>  _require_scratch
>  
> +# This test requires specific data space usage, skip if we have compression
> +# enabled.
> +_require_btrfs_no_compress

With _require_scratch_no_compress also avoids calling a btrfs specific
function in a generic test.

Thanks,
Eryu

> +
>  echo "------------------------------"
>  echo "write until ENOSPC test"
>  echo "------------------------------"
> diff --git a/tests/generic/427 b/tests/generic/427
> index 0f99c1b2..2ebcbf43 100755
> --- a/tests/generic/427
> +++ b/tests/generic/427
> @@ -22,6 +22,10 @@ _require_scratch
>  _require_test_program "feature"
>  _require_aiodio aio-dio-eof-race
>  
> +# This test requires specific data space usage, skip if we have compression
> +# enabled.
> +_require_btrfs_no_compress
> +
>  # limit the filesystem size, to save the time of filling filesystem
>  _scratch_mkfs_sized $((256 * 1024 * 1024)) >>$seqres.full 2>&1
>  _scratch_mount
> -- 
> 2.26.3
