Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 71A887065F
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Jul 2019 19:06:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728715AbfGVRGm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 22 Jul 2019 13:06:42 -0400
Received: from mx2.suse.de ([195.135.220.15]:47558 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728233AbfGVRGm (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 22 Jul 2019 13:06:42 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id B06C1AFDB
        for <linux-btrfs@vger.kernel.org>; Mon, 22 Jul 2019 17:06:40 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 8D5B9DA882; Mon, 22 Jul 2019 19:07:15 +0200 (CEST)
Date:   Mon, 22 Jul 2019 19:07:15 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 2/5] btrfs-progs: fsck-tests: Check if current kernel can
 mount fs with specified sector size
Message-ID: <20190722170715.GB22308@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20190705072651.25150-1-wqu@suse.com>
 <20190705072651.25150-3-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190705072651.25150-3-wqu@suse.com>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jul 05, 2019 at 03:26:48PM +0800, Qu Wenruo wrote:
> [BUG]
> When doing test on platforms with page size other than 4K (e.g aarch64
> can use 64K page size, or ppc64le), certain test wills fail like:
>       [TEST/fsck]   012-leaf-corruption
>   mount: /home/adam/btrfs-progs/tests/mnt: wrong fs type, bad option, bad superblock on /dev/loop4, missing codepage or helper program, or other error.
>   find: '/home/adam/btrfs-progs/tests//mnt/lost+found': No such file or directory
>   inode 1862 not recovered correctly
>   test failed for case 012-leaf-corruption
> 
>       [TEST/fsck]   028-unaligned-super-dev-sizes
>   failed: mount -t btrfs -o loop ./dev_and_super_mismatch_unaligned.raw.restored /home/adam/btrfs-progs/tests//mnt
>   test failed for case 028-unaligned-super-dev-sizes
> 
>       [TEST/fsck]   037-freespacetree-repair
>   failed: /home/adam/btrfs-progs/mkfs.btrfs -f -n 4k /home/adam/btrfs-progs/tests//test.img
>   test failed for case 037-freespacetree-repair
> 
> [CAUSE]
> 
> For fsck/012 and fsck/028, it's caused by the lack of subpage size sector
> size support, thus we require kernel page size to match on-disk sector size:
>   BTRFS error (device loop4): sectorsize 4096 not supported yet, only support 65536
>   BTRFS error (device loop4): superblock contains fatal errors
>   BTRFS error (device loop4): open_ctree failed
> 
> For fsck/037, it's mkfs causing the problem as we're using 4k nodesize,
> but on 64K page sized system, we will use 64K sectorsize and cause
> conflicts.
> 
> [FIX]
> Considering it's easier and easier to get aarch64 boards with enough
> performance (e.g rpi4, rk3399, S922) to compile kernel and run tests,
> let's skip such tests before widespread complain comes.
> 
> This patch will introduce a new check, check_prereq_mount_with_sectorsize(),
> which will test if kernel can mount btrfs with specified sectorsize.
> So that even one day we support subpage sized sectorsize, we won't need
> to update test case again.
> 
> For fsck/037, also specify sector size manually. And since in that case
> we still need to mount the fs, also add
> check_prereq_mount_with_sectorsize() call.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  tests/common                                  | 29 +++++++++++++++++++
>  tests/fsck-tests/012-leaf-corruption/test.sh  |  1 +
>  .../028-unaligned-super-dev-sizes/test.sh     |  1 +
>  .../037-freespacetree-repair/test.sh          |  3 +-
>  4 files changed, 33 insertions(+), 1 deletion(-)
> 
> diff --git a/tests/common b/tests/common
> index 79a16f1e187d..5ad16b69b61d 100644
> --- a/tests/common
> +++ b/tests/common
> @@ -306,6 +306,35 @@ check_prereq()
>  	fi
>  }
>  
> +# Require to mount images with speicified sectorsize
> +# This is to make sure we can run this test on different arch
> +# (e.g aarch64 with 64K pagesize)
> +check_prereq_mount_with_sectorsize()
> +{
> +	prepare_test_dev 128M
> +	check_prereq mkfs.btrfs
> +	setup_root_helper
> +
> +	local sectorsize=$1
> +	local loop_opt
> +
> +	if [[ -b "$TEST_DEV" ]]; then
> +		loop_opt=""
> +	elif [[ -f "$TEST_DEV" ]]; then
> +		loop_opt="-o loop"
> +	else
> +		_fail "Invalid \$TEST_DEV: $TEST_DEV"
> +	fi
> +
> +	run_check_mkfs_test_dev -f -s $sectorsize
> +	$SUDO_HELPER mount -t btrfs $loop_opt "$TEST_DEV" "$TEST_MNT" \
> +		&> /dev/null
> +	if [ $? -ne 0 ]; then
> +		_not_run "kernel doesn't support sectorsize $sectorsize"
> +	fi
> +	run_check_umount_test_dev
> +}

I think the reason why each requires the specific 4k size should be
documented there. This helper hides several things, like forcing 128M on
the default test device, mkfs and mount. Those are probably inevitable
to make sure the combination is supported but the helper should be
independent and not possibly interfere with anything the test could use.

The helper could be added as a separate patch, where the updated tests
should document the reasons for using it.

> +
>  check_global_prereq()
>  {
>  	which "$1" &> /dev/null
> diff --git a/tests/fsck-tests/012-leaf-corruption/test.sh b/tests/fsck-tests/012-leaf-corruption/test.sh
> index 68d9f695d4de..d5da1d210f28 100755
> --- a/tests/fsck-tests/012-leaf-corruption/test.sh
> +++ b/tests/fsck-tests/012-leaf-corruption/test.sh
> @@ -107,6 +107,7 @@ check_leaf_corrupt_no_data_ext()
>  
>  setup_root_helper
>  
> +check_prereq_mount_with_sectorsize 4096
>  generate_leaf_corrupt_no_data_ext test.img

So the tests with pre-generated images can't succeed so the test must be
skipped, unless we have images for all valid page size values.

>  check_image test.img
>  check_leaf_corrupt_no_data_ext test.img
> diff --git a/tests/fsck-tests/028-unaligned-super-dev-sizes/test.sh b/tests/fsck-tests/028-unaligned-super-dev-sizes/test.sh
> index 4015df2d8570..49fa35241d04 100755
> --- a/tests/fsck-tests/028-unaligned-super-dev-sizes/test.sh
> +++ b/tests/fsck-tests/028-unaligned-super-dev-sizes/test.sh
> @@ -6,6 +6,7 @@
>  source "$TEST_TOP/common"
>  
>  check_prereq btrfs
> +check_prereq_mount_with_sectorsize 4096
>  setup_root_helper
>  
>  check_all_images
> diff --git a/tests/fsck-tests/037-freespacetree-repair/test.sh b/tests/fsck-tests/037-freespacetree-repair/test.sh
> index 7f547a33512d..32e6651ac705 100755
> --- a/tests/fsck-tests/037-freespacetree-repair/test.sh
> +++ b/tests/fsck-tests/037-freespacetree-repair/test.sh
> @@ -10,6 +10,7 @@ prepare_test_dev 256M
>  
>  check_prereq btrfs
>  check_prereq mkfs.btrfs
> +check_prereq_mount_with_sectorsize 4096
>  check_global_prereq grep
>  check_global_prereq tail
>  check_global_prereq head
> @@ -55,7 +56,7 @@ if ! [ -f "/sys/fs/btrfs/features/free_space_tree" ]; then
>  	exit
>  fi
>  
> -run_check_mkfs_test_dev -n 4k
> +run_check_mkfs_test_dev -s 4k -n 4k

Can the test be updated so it always succeeds, ie. giving it a valid
sectorsize/nodesize based on getconf? Besides the hardcoded size values
(for the device and files), I don't see anything that would mandate 4k
sectorsize.

>  run_check_mount_test_dev -oclear_cache,space_cache=v2
>  
>  # create files which will populate the FST
> -- 
> 2.22.0
