Return-Path: <linux-btrfs+bounces-3827-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ED071895A52
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Apr 2024 19:03:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E00F2825DB
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Apr 2024 17:03:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DF21159914;
	Tue,  2 Apr 2024 17:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="n9He4OyK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rSd2APjg"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8F1B133283;
	Tue,  2 Apr 2024 17:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712077381; cv=none; b=ecNgN17JoGWxjTGeVau9/c9X3+TWThhSyA5lRSFREbvW9bnnd1C13o84T7DWx9nC6iyrtCPVYYORnRPQsvl/hXGGhsrc7zEh/OMIuvqSprYRk7YSkr+HqLkAmbainPFzpNZ879FqyXqC3U4+9FMn+AUNzhbs8iYeMt6oOS+IfZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712077381; c=relaxed/simple;
	bh=EwZQPw0rXw1+ZzxYVlkCTDKJgyGwiBNvjrPDVbd1wJ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cTj17/PZGTGLEtWCMiYqY1x2k2cSvM4pC7fwng1I2gQvEBMg/FA1G2tDIj11YyvvtG3TSTf0vX7trvm5pSQ2wfiavw+7nHhAM2FgamT5ovYVI5++uilvd2q3eJ7aN/QS5aPn5hObnhavptuHD5aQnm2ouvyj6VGCoE14xghMYjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=n9He4OyK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=rSd2APjg; arc=none smtp.client-ip=66.111.4.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.nyi.internal (Postfix) with ESMTP id 67CEF5C00A8;
	Tue,  2 Apr 2024 13:02:57 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Tue, 02 Apr 2024 13:02:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1712077377; x=1712163777; bh=6VbWtkKYHG
	LXihFIQvpnDSwsUDWfSDZxdE2WCUOWTeY=; b=n9He4OyKCJncMNkZ7zmUIkDPjn
	dmJOXHVsLCoBejFotRIZqzOIInkWNwIKosnSoMyGYllYCdoer/WmKXE4c7BgAsZb
	DfqwsNTl9CNc+SxANOk6ppFjFMXynDGq5GhYUeEAm276AJ3inThT3b0VtpDBTwg/
	FctZUTmrq4qUvdcI1rmkLEvGur871eI10zTEmCpLlB4j2gyVVbYNIoBJvy1nM+m2
	h3fnS7BuiTGkRubvq6qhbfSvqnhU5FdN8o7xiaYEvh+cTzeJoD9/uO+88AqQxCGo
	RWPQlUiO7cnZEm+cF4Z5R07jZblj3xev1LdBNBFFe6mtRelj/zcCqgVAkvtw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1712077377; x=1712163777; bh=6VbWtkKYHGLXihFIQvpnDSwsUDWf
	SDZxdE2WCUOWTeY=; b=rSd2APjg42eBozmalwW0vnkjCwLWxOSr7piPxX4nD+Jx
	gYJAHy/aq4Wvj6Jm6DMOdylNmxcc0jyyCCEQrkJlSNCvAM96x//sJzOIqbNPZrGl
	bYbKIEjakL3SJ9ETE/Rv+xdl29uykpE86hMys2JHjy/pFq/PDI0ReHJAt+k+TJx5
	C6WidSiK5vW3oce/FLT+Md3myx3Pt09n8I9oJEIiZ5tfFQ+XFPs3/UYGG5BzpoHf
	/deY7vmBLrCJOIrO/RUHGwf6XQhYjSRmFbapxdREj9xn52bXqtb5hJh6RrXuWZZ9
	6t+T/eMe4J/qeV2LAouc3uTYVhCyQuwFqrbtL7KzEA==
X-ME-Sender: <xms:QDoMZmbtapPBAMc2bKlacDv_TYojG48QY1IZ4r6toDTb4jxf6BXeXA>
    <xme:QDoMZpbUzmthnuAw27JZbVjPJZ2Y64pJP4lnuKKLuicvSLLEw66nxV23R6kUjthu1
    73s6ZgA_vKPpswhJ9s>
X-ME-Received: <xmr:QDoMZg-gt7830m0Nislsw-mt68l8ZxaVq9x9z9w3E25y0fMxHm23AbmRg_TaL1MmHUcUZr0ESogiZZTvl29r27AfupA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudefvddguddtkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhr
    ihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhioheqnecuggftrfgrthhtvghrnh
    epkedvkeffjeellefhveehvdejudfhjedthfdvveeiieeiudfguefgtdejgfefleejnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghorhhish
    essghurhdrihho
X-ME-Proxy: <xmx:QDoMZooMtG-zumq1w_43CO1QDS3i156Z8Uegj2q53WogTU7vzC6leA>
    <xmx:QDoMZhoXacq0dBV-OkGt039aWiqM5NYWO74-z6U6OYbmrqLmVXQZDg>
    <xmx:QDoMZmTOXvL4L2AiuyWxGAeTctUN9OHeEUbiZf--7hluNXTCVKZPoA>
    <xmx:QDoMZhpKmc6jhHzcYF73BocKNFWDwpjkgJyxaaMsQanbinPsqTHYTw>
    <xmx:QToMZiRClYtv2PuhhcHhPnfhE2ve4J61OzbLK4SzXLK2oYvrPKUcggwF-xK9>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 2 Apr 2024 13:02:55 -0400 (EDT)
Date: Tue, 2 Apr 2024 10:04:51 -0700
From: Boris Burkov <boris@bur.io>
To: Naohiro Aota <Naohiro.Aota@wdc.com>
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Johannes Thumshirn <jth@kernel.org>, Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Hans Holmberg <Hans.Holmberg@wdc.com>, "hch@lst.de" <hch@lst.de>,
	Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Subject: Re: [PATCH RFC PATCH 2/3] btrfs: zoned: reserve relocation zone on
 mount
Message-ID: <20240402170451.GA3175858@zen.localdomain>
References: <20240328-hans-v1-0-4cd558959407@kernel.org>
 <20240328-hans-v1-2-4cd558959407@kernel.org>
 <e32027a2-6032-4937-a362-287897abdf11@kernel.org>
 <ozmewhhflwko2z75luj33futfnkhoryyhk7vvb76suuagqse7o@gdwyk3dj3yw7>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ozmewhhflwko2z75luj33futfnkhoryyhk7vvb76suuagqse7o@gdwyk3dj3yw7>

On Tue, Apr 02, 2024 at 06:03:35AM +0000, Naohiro Aota wrote:
> On Fri, Mar 29, 2024 at 08:05:34AM +0900, Damien Le Moal wrote:
> > On 3/28/24 22:56, Johannes Thumshirn wrote:
> > > From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> > > 
> > > Reserve one zone as a data relocation target on each mount. If we already
> > > find one empty block group, there's no need to force a chunk allocation,
> > > but we can use this empty data block group as our relocation target.

I'm confused why it's sufficient to ensure the reservation only once at
mount. What ensures that the fs is in a condition to handle needed
relocations a month later after we have already made use of the one bg
we reserved at mount? Do we always reserve the "just-relocated-out-of"
fresh one for future relocations or something? I couldn't infer that
from a quick look at the use-sites of data_reloc_bg, but I could have
easily missed it.

> > > 
> > > Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> > > ---
> > >  fs/btrfs/disk-io.c |  2 ++
> > >  fs/btrfs/zoned.c   | 46 ++++++++++++++++++++++++++++++++++++++++++++++
> > >  fs/btrfs/zoned.h   |  3 +++
> > >  3 files changed, 51 insertions(+)
> > > 
> > > diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> > > index 5a35c2c0bbc9..83b56f109d29 100644
> > > --- a/fs/btrfs/disk-io.c
> > > +++ b/fs/btrfs/disk-io.c
> > > @@ -3550,6 +3550,8 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
> > >  	}
> > >  	btrfs_discard_resume(fs_info);
> > >  
> > > +	btrfs_reserve_relocation_zone(fs_info);
> > > +
> > >  	if (fs_info->uuid_root &&
> > >  	    (btrfs_test_opt(fs_info, RESCAN_UUID_TREE) ||
> > >  	     fs_info->generation != btrfs_super_uuid_tree_generation(disk_super))) {
> > > diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
> > > index d51faf7f4162..fb8707f4cab5 100644
> > > --- a/fs/btrfs/zoned.c
> > > +++ b/fs/btrfs/zoned.c
> > > @@ -17,6 +17,7 @@
> > >  #include "fs.h"
> > >  #include "accessors.h"
> > >  #include "bio.h"
> > > +#include "transaction.h"
> > >  
> > >  /* Maximum number of zones to report per blkdev_report_zones() call */
> > >  #define BTRFS_REPORT_NR_ZONES   4096
> > > @@ -2634,3 +2635,48 @@ void btrfs_check_active_zone_reservation(struct btrfs_fs_info *fs_info)
> > >  	}
> > >  	spin_unlock(&fs_info->zone_active_bgs_lock);
> > >  }
> > > +
> > > +static u64 find_empty_block_group(struct btrfs_space_info *sinfo)
> > > +{
> > > +	struct btrfs_block_group *bg;
> > > +
> > > +	for (int i = 0; i < BTRFS_NR_RAID_TYPES; i++) {
> > > +		list_for_each_entry(bg, &sinfo->block_groups[i], list) {
> > > +			if (bg->used == 0)
> > > +				return bg->start;
> > > +		}
> > > +	}
> > > +
> > > +	return 0;
> > 
> > The first block group does not start at offset 0 ? If it does, then this is not
> > correct. Maybe turn this function into returning a bool and add a pointer
> > argument to return the bg start value ?
> 
> No, it does not. The bg->start (logical address) increases monotonically as
> a new block group is created. And, the first block group created by
> mkfs.btrfs has a non-zero bg->start address.
> 
> > > +}
> > > +
> > > +void btrfs_reserve_relocation_zone(struct btrfs_fs_info *fs_info)
> > > +{
> > > +	struct btrfs_root *tree_root = fs_info->tree_root;
> > > +	struct btrfs_space_info *sinfo = fs_info->data_sinfo;
> > > +	struct btrfs_trans_handle *trans;
> > > +	u64 flags = btrfs_get_alloc_profile(fs_info, sinfo->flags);
> > > +	u64 bytenr = 0;
> > > +
> > > +	if (!btrfs_is_zoned(fs_info))
> > > +		return;
> > > +
> > > +	bytenr = find_empty_block_group(sinfo);
> > > +	if (!bytenr) {
> > > +		int ret;
> > > +
> > > +		trans = btrfs_join_transaction(tree_root);
> > > +		if (IS_ERR(trans))
> > > +			return;
> > > +
> > > +		ret = btrfs_chunk_alloc(trans, flags, CHUNK_ALLOC_FORCE);
> > > +		btrfs_end_transaction(trans);
> > > +
> > > +		if (!ret)
> > > +			bytenr = find_empty_block_group(sinfo);
> > 
> > What if this fail again ?
> 
> That (almost) means we don't have any free space to create a new block
> group. Then, we don't have a way to deal with it. Maybe, we can reclaim
> directly here?

To my more general point, should we keep trying in a more sustained way
on the live fs, even if it happens to be full-full at mount?

> 
> Anyway, in that case, we will set fs_info->data_reloc_bg = 0, which is the
> same behavior as the current code.

Well right now it is only called from mount, in which case it will only
fail if we are full, since there shouldn't be concurrent allocations.

OTOH, if this does get called from some more live fs context down the
line, then this could easily race with allocations using the block
group. For that reason, I think it makes sense to either add locking,
a retry loop, or inline reclaim.

> 
> > > +	}
> > > +
> > > +	spin_lock(&fs_info->relocation_bg_lock);
> > > +	fs_info->data_reloc_bg = bytenr;
> > > +	spin_unlock(&fs_info->relocation_bg_lock);
> > > +}
> > > diff --git a/fs/btrfs/zoned.h b/fs/btrfs/zoned.h
> > > index 77c4321e331f..048ffada4549 100644
> > > --- a/fs/btrfs/zoned.h
> > > +++ b/fs/btrfs/zoned.h
> > > @@ -97,6 +97,7 @@ int btrfs_zone_finish_one_bg(struct btrfs_fs_info *fs_info);
> > >  int btrfs_zoned_activate_one_bg(struct btrfs_fs_info *fs_info,
> > >  				struct btrfs_space_info *space_info, bool do_finish);
> > >  void btrfs_check_active_zone_reservation(struct btrfs_fs_info *fs_info);
> > > +void btrfs_reserve_relocation_zone(struct btrfs_fs_info *fs_info);
> > >  #else /* CONFIG_BLK_DEV_ZONED */
> > >  static inline int btrfs_get_dev_zone(struct btrfs_device *device, u64 pos,
> > >  				     struct blk_zone *zone)
> > > @@ -271,6 +272,8 @@ static inline int btrfs_zoned_activate_one_bg(struct btrfs_fs_info *fs_info,
> > >  
> > >  static inline void btrfs_check_active_zone_reservation(struct btrfs_fs_info *fs_info) { }
> > >  
> > > +static inline void btrfs_reserve_relocation_zone(struct btrfs_fs_info *fs_info) { }
> > > +
> > >  #endif
> > >  
> > >  static inline bool btrfs_dev_is_sequential(struct btrfs_device *device, u64 pos)
> > > 
> > 
> > -- 
> > Damien Le Moal
> > Western Digital Research
> > 

