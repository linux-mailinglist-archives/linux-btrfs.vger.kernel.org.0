Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19F7A44F7C9
	for <lists+linux-btrfs@lfdr.de>; Sun, 14 Nov 2021 13:11:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233656AbhKNMOU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 14 Nov 2021 07:14:20 -0500
Received: from out20-110.mail.aliyun.com ([115.124.20.110]:36894 "EHLO
        out20-110.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231147AbhKNMOS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 14 Nov 2021 07:14:18 -0500
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07440201|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.0382905-0.000491757-0.961218;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047201;MF=guan@eryu.me;NM=1;PH=DS;RN=5;RT=5;SR=0;TI=SMTPD_---.LseN9sz_1636891882;
Received: from localhost(mailfrom:guan@eryu.me fp:SMTPD_---.LseN9sz_1636891882)
          by smtp.aliyun-inc.com(10.147.40.26);
          Sun, 14 Nov 2021 20:11:22 +0800
Date:   Sun, 14 Nov 2021 20:11:22 +0800
From:   Eryu Guan <guan@eryu.me>
To:     Qu Wenruo <wqu@suse.com>
Cc:     Eryu Guan <eguan@linux.alibaba.com>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>, fstests@vger.kernel.org,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v3] fstests: btrfs: make nospace_cache related test cases
 to work with latest v2 cache
Message-ID: <YZD86qQFpuRCsG+J@desktop>
References: <20211110093417.47185-1-wqu@suse.com>
 <20211110104809.GV60846@e18g06458.et15sqa>
 <e33a7317-d740-b698-61bf-4882bea4a70b@gmx.com>
 <20211110110139.GX60846@e18g06458.et15sqa>
 <72a12bb8-c268-046c-1a38-a7017b2228e2@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <72a12bb8-c268-046c-1a38-a7017b2228e2@suse.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Nov 10, 2021 at 08:13:07PM +0800, Qu Wenruo wrote:
> 
> 
> On 2021/11/10 19:01, Eryu Guan wrote:
> > On Wed, Nov 10, 2021 at 06:52:17PM +0800, Qu Wenruo wrote:
> > > 
> > > 
> > > On 2021/11/10 18:48, Eryu Guan wrote:
> > > > On Wed, Nov 10, 2021 at 05:34:17PM +0800, Qu Wenruo wrote:
> > > > > In the coming btrfs-progs v5.15 release, mkfs.btrfs will change to use
> > > > > v2 cache by default.
> > > > > 
> > > > > However nospace_cache mount option will not work with v2 cache, as it
> > > > > would make v2 cache out of sync with on-disk used space.
> > > > > 
> > > > > So mounting a btrfs with v2 cache using "nospace_cache" will make btrfs
> > > > > to reject the mount.
> > > > > 
> > > > > There are quite some test cases relying on nospace_cache to prevent v1
> > > > > cache to take up data space.
> > > > > 
> > > > > For those test cases, we no longer need the "nospace_cache" mount option
> > > > > if the filesystem is already using v2 cache.
> > > > > Since v2 cache is using metadata space, it will no longer take up data
> > > > > space, thus no extra mount options for those test cases.
> > > > > 
> > > > > By this, we can keep those existing tests to run without problem for
> > > > > both v1 and v2 cache.
> > > > > 
> > > > > Signed-off-by: Qu Wenruo <wqu@suse.com>
> > > > > ---
> > > > > Changelog:
> > > > > v2:
> > > > > - Add _scratch_no_v1_cache_opt() function
> > > > > v3:
> > > > > - Add _require_btrfs_command for _scratch_no_v1_cache_opt()
> > > > > ---
> > > > >   common/btrfs    | 11 +++++++++++
> > > > >   tests/btrfs/102 |  2 +-
> > > > >   tests/btrfs/140 |  5 ++---
> > > > >   tests/btrfs/141 |  5 ++---
> > > > >   tests/btrfs/142 |  5 ++---
> > > > >   tests/btrfs/143 |  5 ++---
> > > > >   tests/btrfs/151 |  4 ++--
> > > > >   tests/btrfs/157 |  7 +++----
> > > > >   tests/btrfs/158 |  7 +++----
> > > > >   tests/btrfs/170 |  4 ++--
> > > > >   tests/btrfs/199 |  4 ++--
> > > > >   tests/btrfs/215 |  2 +-
> > > > >   12 files changed, 33 insertions(+), 28 deletions(-)
> > > > > 
> > > > > diff --git a/common/btrfs b/common/btrfs
> > > > > index ac880bdd..e21c452c 100644
> > > > > --- a/common/btrfs
> > > > > +++ b/common/btrfs
> > > > > @@ -445,3 +445,14 @@ _scratch_btrfs_is_zoned()
> > > > >   	[ `_zone_type ${SCRATCH_DEV}` != "none" ] && return 0
> > > > >   	return 1
> > > > >   }
> > > > > +
> > > > > +_scratch_no_v1_cache_opt()
> > > > 
> > > > This name indicates it's a general helper, but it's btrfs-specific, how
> > > > about _scratch_btrfs_no_v1_cache_opt ?
> > > > 
> > > > > +{
> > > > > +	_require_btrfs_command inspect-internal dump-tree
> > > > 
> > > > This will call _notrun if btrfs command doesn't have inspect-internal
> > > > dump-tree sub-command, and _notrun will call exit, but ...
> > > > 
> > > > > +
> > > > > +	if $BTRFS_UTIL_PROG inspect-internal dump-tree $SCRATCH_DEV |\
> > > > > +	   grep -q "FREE_SPACE_TREE"; then
> > > > > +		return
> > > > > +	fi
> > > > > +	echo -n "-onospace_cache"
> > > > > +}
> > > > > diff --git a/tests/btrfs/102 b/tests/btrfs/102
> > > > > index e5a1b068..c1678b5d 100755
> > > > > --- a/tests/btrfs/102
> > > > > +++ b/tests/btrfs/102
> > > > > @@ -22,7 +22,7 @@ _scratch_mkfs >>$seqres.full 2>&1
> > > > >   # Mount our filesystem without space caches enabled so that we do not get any
> > > > >   # space used from the initial data block group that mkfs creates (space caches
> > > > >   # used space from data block groups).
> > > > > -_scratch_mount "-o nospace_cache"
> > > > > +_scratch_mount $(_scratch_no_v1_cache_opt)
> > > > 
> > > > _scratch_no_v1_cache_opt is called in a sub-shell, so the _notrun will
> > > > just exit the sub-shell, not the test itself. Should call the _require
> > > > rule in test.
> > > 
> > > That means we will have a hard dependency on binding
> > > _scratch_btrfs_no_v1_cache_opt() with _require rule then.
> > > 
> > > Then a sudden "_require_btrfs_command inspect-internal dump-tree"
> > > without context could be sometimes confusing AFAIK.
> > 
> > That's true.
> > 
> > > 
> > > Considering "inspect-internal" should be in btrfs-progs for a very long
> > > time, any non-EOF distro should have them already, can we just remove
> > > the _require rule?
> > 
> > It seems like that dump-tree sub-command was added in 2016 in v4.5, so I
> > guess I'm fine with it.
> 
> Mind to remove the _require rule at merge time?
> Or do I need to resend?

A new version is preferred, as it's not only delete the _require rule,
but also needs a function rename, and a rebase against latest master
branch. The patch currently doesn't apply due to conflit.

Thanks,
Eryu
