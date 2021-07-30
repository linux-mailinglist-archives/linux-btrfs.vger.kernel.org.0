Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D847F3DB209
	for <lists+linux-btrfs@lfdr.de>; Fri, 30 Jul 2021 05:52:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234928AbhG3Dwd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 29 Jul 2021 23:52:33 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:57271 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S230352AbhG3Dwd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 29 Jul 2021 23:52:33 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 16U3qQd0009312
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 29 Jul 2021 23:52:26 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 109A515C37C0; Thu, 29 Jul 2021 23:52:26 -0400 (EDT)
Date:   Thu, 29 Jul 2021 23:52:26 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] fstests: generic/204: fail if the mkfs fails
Message-ID: <YQN3enkt+icpfG0e@mit.edu>
References: <fe1cd52ce8954e5aee1fc0a4baf5c75ef7d2635a.1627590942.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fe1cd52ce8954e5aee1fc0a4baf5c75ef7d2635a.1627590942.git.josef@toxicpanda.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jul 29, 2021 at 04:35:53PM -0400, Josef Bacik wrote:
> My nightly fstests runs on my Raspberry Pi got stuck trying to run
> generic/204.  This boiled down to mkfs failing to make the scratch
> device that small with the subpage blocksize support, and thus trying to
> fill a 1tib drive with tiny files.  On one hand I'd like to make
> _scratch_mkfs failures automatically fail the test, but I worry about
> cases where a test may be checking for an option and need to do
> something different with failures, so for now simply fail if we can't
> make our tiny-fs in generic/204.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

FWIW, I'm carrying the following patch in my local xfstests tree:

commit cb8e8d44de5bbb1d6163dfeb2b77e8f003a564da
Author: Theodore Ts'o <tytso@mit.edu>
Date:   Mon Jul 3 01:29:21 2017 -0400

    common: kill the test if mkfs.ext4 in _scratch_mkfs_sized fails
    
    If the file system size specified by test is incompatible with the
    mkfs options used in the test configuration, make sure the test stops
    at that point instad of doing something undefined.
    
    Signed-off-by: Theodore Ts'o <tytso@mit.edu>

diff --git a/common/rc b/common/rc
index 332e18b7..1dcad4a3 100644
--- a/common/rc
+++ b/common/rc
@@ -1034,7 +1034,9 @@ _scratch_mkfs_sized()
 		fi
 		;;
 	ext2|ext3|ext4|ext4dev)
-		${MKFS_PROG} -t $FSTYP -F $MKFS_OPTIONS -b $blocksize $SCRATCH_DEV $blocks
+		echo "${MKFS_PROG} -t $FSTYP -F $MKFS_OPTIONS -b $blocksize $SCRATCH_DEV $blocks"
+		${MKFS_PROG} -t $FSTYP -F $MKFS_OPTIONS -b $blocksize $SCRATCH_DEV $blocks || \
+		    _die "${MKFS_PROG}.$FSTYP failed!"
 		;;
 	gfs2)
 		# mkfs.gfs2 doesn't automatically shrink journal files on small



I tried getting this upstream, but apparently there was pushback where
when the mkfs failed, it was considered a *feature* that the test
would run on some random scratch file system that was previously there
from before.

I didn't appreciate wasting time trying to run down test failures
caused by some completely inappropriate file system being used for a
test after _scratch_mkfs_sized failed, so I've just been carrying the
patch locally....

						- Ted
