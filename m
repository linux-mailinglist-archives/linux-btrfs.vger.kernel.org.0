Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40AA934585A
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Mar 2021 08:11:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229972AbhCWHLS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 23 Mar 2021 03:11:18 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:13213 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbhCWHLL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 23 Mar 2021 03:11:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1616483470; x=1648019470;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7/O405QzoA/a4odZjLMPmNSngqpFxwtzpI9AdJ0Emqw=;
  b=n6iOadLZA2VZczHq7+DBHbB6G89yypFxUKGGNk/Cno9d10aRXHEZ/wh2
   auppd9Wim6Ww7wN9cbLmM/FoPKpo53YsTwDuRgTGF+ml0/M0gX+eT/OEk
   gLzYkM8PAuOHCDcA9OKt7wutkNs5vytdvO0fNk+7r0IcHFj01gym6GkMM
   NXvA1ahbL/spYi24KbV2a1x3exRXXLk4edxu/wxO01s24mWkWED8OleJA
   LR04CKlQsEqYhsyH/ireqXnIBIYHs5/4xTsU0G/VwIdkQAi5Ka4YWJxlg
   HB4Ts0KGM0jyDSqbH/h3r5vvU/Oxaye56StbOB/JpSINXK+eM/ceFaVbW
   g==;
IronPort-SDR: 2Xt38Py6/ncr22jSyTvFEghGs2yVpxe1CJmIPXkDX7dqJVb87xV+GB2VfU3kzIXlJsWQ0u6XX4
 TTroLDteYjizSa2rAex9ECaxtRxtrP0vvn9yprSprgXBJSHBlovX6tZauGDDV9o8Sv7TSWfkoL
 KC1+nAHgYRamqbZYUy6uoAJSLFaWoATtwqyeKLBS/G93bQ2q5ZOc4Vsx0zSWenB1aLv/ZCVTlz
 y3J/MPnMqE5vty/5EDJlNmLhNnWPWHLOqedUd99LuhH85q+aD6vju7RczvB4vcUI93Xgt73gXe
 Wo0=
X-IronPort-AV: E=Sophos;i="5.81,271,1610380800"; 
   d="scan'208";a="273532003"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 23 Mar 2021 15:11:10 +0800
IronPort-SDR: 7+vPvczHQDwDa13jbX0vL59fGYKriI5UfItCQ5MLjPVH8PJylDcGQWqYrNaXLNrOkJODfac7Sh
 VVKr+CrjaC+mj+pVAKw2wG+UFhh6+cbYLfvLHjTWiSX5Gz8diHrt6GrphM1Xj91t8vJU0bwZMX
 x8jeLnFIyNluxMtOJNluTk/+oPA+VpS2BcMLsgkcJlt8wKn7QVnR6qEkJlUFbNRM9Y0rmlc8uK
 RrWzwLk0N53445jBIzQkjaDBbRB8HOR4TiT2/XmFIZDIXtvqRCI1EmnX+LjfaHlL6xjQgP9/t9
 25Q7v2JnRm5ZhlBwo5o57ath
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2021 23:53:17 -0700
IronPort-SDR: /s1FtpXWU0WpAQiEj4JyqyD5weacqpif1/yI2uRy5IWSZ/yyE6HustN2TNqYzzzHfYbdfc9dKN
 LQyCbnCmSKo/OQqvqCtRERcNrrXUnlVzaTaccLB/CBqf6EPzqB5KvWvUn5YmJaQ09jdV4peK94
 vM60ni5SMGWGvlkGHrowdVJNITJxsMEU7MNTGKzJRhITdIRccqlwrmGEJ+7IWFqtTh9usVWQLI
 qCPXZxdkP/JXH4SNqqNIBT4sVKzfnFQaDUTucKTkqf8BYlS5K5ftWj1W5dKo6eucDicmQBypUo
 YsU=
WDCIronportException: Internal
Received: from wdmnc1396.ad.shared (HELO naota-xeon) ([10.225.48.248])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2021 00:11:10 -0700
Date:   Tue, 23 Mar 2021 16:11:08 +0900
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        David Sterba <dsterba@suse.com>,
        "linux-btrfs @ vger . kernel . org" <linux-btrfs@vger.kernel.org>,
        Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH v2 2/2] btrfs: zoned: automatically reclaim zones
Message-ID: <20210323071108.w433eusa2jqdgc5e@naota-xeon>
References: <cover.1616149060.git.johannes.thumshirn@wdc.com>
 <58648eb48c6cb2b35d201518c8dc430b7797bcaa.1616149060.git.johannes.thumshirn@wdc.com>
 <6611a836-72be-eada-1f2d-33454ce5fa04@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6611a836-72be-eada-1f2d-33454ce5fa04@toxicpanda.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Mar 19, 2021 at 01:59:02PM -0400, Josef Bacik wrote:
> On 3/19/21 6:48 AM, Johannes Thumshirn wrote:
> > When a file gets deleted on a zoned file system, the space freed is not
> > returned back into the block group's free space, but is migrated to
> > zone_unusable.
> > 
> > As this zone_unusable space is behind the current write pointer it is not
> > possible to use it for new allocations. In the current implementation a
> > zone is reset once all of the block group's space is accounted as zone
> > unusable.
> > 
> > This behaviour can lead to premature ENOSPC errors on a busy file system.
> > 
> > Instead of only reclaiming the zone once it is completely unusable,
> > kick off a reclaim job once the amount of unusable bytes exceeds a user
> > configurable threshold between 51% and 100%. It can be set per mounted
> > filesystem via the sysfs tunable bg_reclaim_threshold which is set to 75%
> > per default.
> > 
> > Similar to reclaiming unused block groups, these dirty block groups are
> > added to a to_reclaim list and then on a transaction commit, the reclaim
> > process is triggered but after we deleted unused block groups, which will
> > free space for the relocation process.
> > 
> > Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> > ---
> > 
> > AFAICT sysfs_create_files() does not have the ability to provide a is_visible
> > callback, so the bg_reclaim_threshold sysfs file is visible for non zoned
> > filesystems as well, even though only for zoned filesystems we're adding block
> > groups to the reclaim list. I'm all ears for a approach that is sensible in
> > this regard.
> > 
> > 
> >   fs/btrfs/block-group.c       | 84 ++++++++++++++++++++++++++++++++++++
> >   fs/btrfs/block-group.h       |  2 +
> >   fs/btrfs/ctree.h             |  3 ++
> >   fs/btrfs/disk-io.c           | 11 +++++
> >   fs/btrfs/free-space-cache.c  |  9 +++-
> >   fs/btrfs/sysfs.c             | 35 +++++++++++++++
> >   fs/btrfs/volumes.c           |  2 +-
> >   fs/btrfs/volumes.h           |  1 +
> >   include/trace/events/btrfs.h | 12 ++++++
> >   9 files changed, 157 insertions(+), 2 deletions(-)
> > 
> > diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
> > index 9ae3ac96a521..af9026795ddd 100644
> > --- a/fs/btrfs/block-group.c
> > +++ b/fs/btrfs/block-group.c
> > @@ -1485,6 +1485,80 @@ void btrfs_mark_bg_unused(struct btrfs_block_group *bg)
> >   	spin_unlock(&fs_info->unused_bgs_lock);
> >   }
> > +void btrfs_reclaim_bgs(struct btrfs_fs_info *fs_info)
> > +{
> > +	struct btrfs_block_group *bg;
> > +	struct btrfs_space_info *space_info;
> > +	int ret = 0;
> > +
> > +	if (!test_bit(BTRFS_FS_OPEN, &fs_info->flags))
> > +		return;
> > +
> > +	if (!btrfs_exclop_start(fs_info, BTRFS_EXCLOP_BALANCE))
> > +		return;
> > +
> > +	mutex_lock(&fs_info->reclaim_bgs_lock);
> > +	while (!list_empty(&fs_info->reclaim_bgs)) {
> > +		bg = list_first_entry(&fs_info->reclaim_bgs,
> > +				      struct btrfs_block_group,
> > +				      bg_list);
> > +		list_del_init(&bg->bg_list);
> > +
> > +		space_info = bg->space_info;
> > +		mutex_unlock(&fs_info->reclaim_bgs_lock);
> > +
> > +		/* Don't want to race with allocators so take the groups_sem */
> > +		down_write(&space_info->groups_sem);
> > +
> > +		spin_lock(&bg->lock);
> > +		if (bg->reserved || bg->pinned || bg->ro) {
> 
> How do we deal with backup supers in zoned again?  Will they show up as
> readonly?  If so we may not want the bg->ro check, but I may be insane.

No superblock/backups are placed into a zone composing a block group,
because, if placed, it becomes a hole blocking sequential writes. The
zones containing superblock/backups are reserved and no device extents
are allocated there. So, bg->ro == 0, if the block group is read-write.
