Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2FBC9BB74C
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Sep 2019 16:57:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731515AbfIWO47 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 23 Sep 2019 10:56:59 -0400
Received: from mx2.suse.de ([195.135.220.15]:34116 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727629AbfIWO4z (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 23 Sep 2019 10:56:55 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 1980CB78B;
        Mon, 23 Sep 2019 14:56:54 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 48178DA871; Mon, 23 Sep 2019 16:57:15 +0200 (CEST)
Date:   Mon, 23 Sep 2019 16:57:15 +0200
From:   David Sterba <dsterba@suse.cz>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] Btrfs: fix selftests failure due to uninitialized i_mode
 in test inodes
Message-ID: <20190923145715.GB2751@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, fdmanana@kernel.org,
        linux-btrfs@vger.kernel.org
References: <20190918120852.764-1-fdmanana@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190918120852.764-1-fdmanana@kernel.org>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Sep 18, 2019 at 01:08:52PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Some of the self tests create a test inode, setup some extents and then do
> calls to btrfs_get_extent() to test that the corresponding extent maps
> exist and are correct. However btrfs_get_extent(), since the 5.2 merge
> window, now errors out when it finds a regular or prealloc extent for an
> inode that does not correspond to a regular file (its ->i_mode is not
> S_IFREG). This causes the self tests to fail sometimes, specially when
> KASAN, slub_debug and page poisoning are enabled:
> 
>   $ modprobe btrfs
>   modprobe: ERROR: could not insert 'btrfs': Invalid argument
> 
>   $ dmesg
>   [ 9414.691648] Btrfs loaded, crc32c=crc32c-intel, debug=on, assert=on, integrity-checker=on, ref-verify=on
>   [ 9414.692655] BTRFS: selftest: sectorsize: 4096  nodesize: 4096
>   [ 9414.692658] BTRFS: selftest: running btrfs free space cache tests
>   [ 9414.692918] BTRFS: selftest: running extent only tests
>   [ 9414.693061] BTRFS: selftest: running bitmap only tests
>   [ 9414.693366] BTRFS: selftest: running bitmap and extent tests
>   [ 9414.696455] BTRFS: selftest: running space stealing from bitmap to extent tests
>   [ 9414.697131] BTRFS: selftest: running extent buffer operation tests
>   [ 9414.697133] BTRFS: selftest: running btrfs_split_item tests
>   [ 9414.697564] BTRFS: selftest: running extent I/O tests
>   [ 9414.697583] BTRFS: selftest: running find delalloc tests
>   [ 9415.081125] BTRFS: selftest: running find_first_clear_extent_bit test
>   [ 9415.081278] BTRFS: selftest: running extent buffer bitmap tests
>   [ 9415.124192] BTRFS: selftest: running inode tests
>   [ 9415.124195] BTRFS: selftest: running btrfs_get_extent tests
>   [ 9415.127909] BTRFS: selftest: running hole first btrfs_get_extent test
>   [ 9415.128343] BTRFS critical (device (efault)): regular/prealloc extent found for non-regular inode 256
>   [ 9415.131428] BTRFS: selftest: fs/btrfs/tests/inode-tests.c:904 expected a real extent, got 0
> 
> This happens because the test inodes are created without ever initializing
> the i_mode field of the inode, and neither VFS's new_inode() nor the btrfs
> callback btrfs_alloc_inode() initialize the i_mode. Initialization of the
> i_mode is done through the various callbacks used by the VFS to create
> new inodes (regular files, directories, symlinks, tmpfiles, etc), which
> all call btrfs_new_inode() which in turn calls inode_init_owner(), which
> sets the inode's i_mode. Since the tests only uses new_inode() to create
> the test inodes, the i_mode was never initialized.
> 
> This always happens on a VM I used with kasan, slub_debug and many other
> debug facilities enabled. It also happened to someone who reported this
> on bugzilla (on a 5.3-rc).
> 
> Fix this by setting i_mode to S_IFREG at btrfs_new_test_inode().
> 
> Fixes: 6bf9e4bd6a2778 ("btrfs: inode: Verify inode mode to avoid NULL pointer dereference")
> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=204397
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Added to misc-next, thanks.
