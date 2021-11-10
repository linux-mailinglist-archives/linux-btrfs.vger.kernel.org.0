Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA00644BFA4
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Nov 2021 12:01:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231858AbhKJLEp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 10 Nov 2021 06:04:45 -0500
Received: from out30-45.freemail.mail.aliyun.com ([115.124.30.45]:47997 "EHLO
        out30-45.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231675AbhKJLE2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 10 Nov 2021 06:04:28 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04407;MF=eguan@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0UvuiLch_1636542099;
Received: from localhost(mailfrom:eguan@linux.alibaba.com fp:SMTPD_---0UvuiLch_1636542099)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 10 Nov 2021 19:01:39 +0800
Date:   Wed, 10 Nov 2021 19:01:39 +0800
From:   Eryu Guan <eguan@linux.alibaba.com>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Qu Wenruo <wqu@suse.com>, fstests@vger.kernel.org,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v3] fstests: btrfs: make nospace_cache related test cases
 to work with latest v2 cache
Message-ID: <20211110110139.GX60846@e18g06458.et15sqa>
References: <20211110093417.47185-1-wqu@suse.com>
 <20211110104809.GV60846@e18g06458.et15sqa>
 <e33a7317-d740-b698-61bf-4882bea4a70b@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e33a7317-d740-b698-61bf-4882bea4a70b@gmx.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Nov 10, 2021 at 06:52:17PM +0800, Qu Wenruo wrote:
> 
> 
> On 2021/11/10 18:48, Eryu Guan wrote:
> >On Wed, Nov 10, 2021 at 05:34:17PM +0800, Qu Wenruo wrote:
> >>In the coming btrfs-progs v5.15 release, mkfs.btrfs will change to use
> >>v2 cache by default.
> >>
> >>However nospace_cache mount option will not work with v2 cache, as it
> >>would make v2 cache out of sync with on-disk used space.
> >>
> >>So mounting a btrfs with v2 cache using "nospace_cache" will make btrfs
> >>to reject the mount.
> >>
> >>There are quite some test cases relying on nospace_cache to prevent v1
> >>cache to take up data space.
> >>
> >>For those test cases, we no longer need the "nospace_cache" mount option
> >>if the filesystem is already using v2 cache.
> >>Since v2 cache is using metadata space, it will no longer take up data
> >>space, thus no extra mount options for those test cases.
> >>
> >>By this, we can keep those existing tests to run without problem for
> >>both v1 and v2 cache.
> >>
> >>Signed-off-by: Qu Wenruo <wqu@suse.com>
> >>---
> >>Changelog:
> >>v2:
> >>- Add _scratch_no_v1_cache_opt() function
> >>v3:
> >>- Add _require_btrfs_command for _scratch_no_v1_cache_opt()
> >>---
> >>  common/btrfs    | 11 +++++++++++
> >>  tests/btrfs/102 |  2 +-
> >>  tests/btrfs/140 |  5 ++---
> >>  tests/btrfs/141 |  5 ++---
> >>  tests/btrfs/142 |  5 ++---
> >>  tests/btrfs/143 |  5 ++---
> >>  tests/btrfs/151 |  4 ++--
> >>  tests/btrfs/157 |  7 +++----
> >>  tests/btrfs/158 |  7 +++----
> >>  tests/btrfs/170 |  4 ++--
> >>  tests/btrfs/199 |  4 ++--
> >>  tests/btrfs/215 |  2 +-
> >>  12 files changed, 33 insertions(+), 28 deletions(-)
> >>
> >>diff --git a/common/btrfs b/common/btrfs
> >>index ac880bdd..e21c452c 100644
> >>--- a/common/btrfs
> >>+++ b/common/btrfs
> >>@@ -445,3 +445,14 @@ _scratch_btrfs_is_zoned()
> >>  	[ `_zone_type ${SCRATCH_DEV}` != "none" ] && return 0
> >>  	return 1
> >>  }
> >>+
> >>+_scratch_no_v1_cache_opt()
> >
> >This name indicates it's a general helper, but it's btrfs-specific, how
> >about _scratch_btrfs_no_v1_cache_opt ?
> >
> >>+{
> >>+	_require_btrfs_command inspect-internal dump-tree
> >
> >This will call _notrun if btrfs command doesn't have inspect-internal
> >dump-tree sub-command, and _notrun will call exit, but ...
> >
> >>+
> >>+	if $BTRFS_UTIL_PROG inspect-internal dump-tree $SCRATCH_DEV |\
> >>+	   grep -q "FREE_SPACE_TREE"; then
> >>+		return
> >>+	fi
> >>+	echo -n "-onospace_cache"
> >>+}
> >>diff --git a/tests/btrfs/102 b/tests/btrfs/102
> >>index e5a1b068..c1678b5d 100755
> >>--- a/tests/btrfs/102
> >>+++ b/tests/btrfs/102
> >>@@ -22,7 +22,7 @@ _scratch_mkfs >>$seqres.full 2>&1
> >>  # Mount our filesystem without space caches enabled so that we do not get any
> >>  # space used from the initial data block group that mkfs creates (space caches
> >>  # used space from data block groups).
> >>-_scratch_mount "-o nospace_cache"
> >>+_scratch_mount $(_scratch_no_v1_cache_opt)
> >
> >_scratch_no_v1_cache_opt is called in a sub-shell, so the _notrun will
> >just exit the sub-shell, not the test itself. Should call the _require
> >rule in test.
> 
> That means we will have a hard dependency on binding
> _scratch_btrfs_no_v1_cache_opt() with _require rule then.
> 
> Then a sudden "_require_btrfs_command inspect-internal dump-tree"
> without context could be sometimes confusing AFAIK.

That's true.

> 
> Considering "inspect-internal" should be in btrfs-progs for a very long
> time, any non-EOF distro should have them already, can we just remove
> the _require rule?

It seems like that dump-tree sub-command was added in 2016 in v4.5, so I
guess I'm fine with it.

Thanks,
Eryu
