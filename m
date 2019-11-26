Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1A32010A213
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Nov 2019 17:28:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727511AbfKZQ2S (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 26 Nov 2019 11:28:18 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:41961 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727135AbfKZQ2S (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 26 Nov 2019 11:28:18 -0500
Received: by mail-qt1-f195.google.com with SMTP id 59so16515252qtg.8
        for <linux-btrfs@vger.kernel.org>; Tue, 26 Nov 2019 08:28:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=T7l3rTl8i9rz5vSGTvef2wq+IhU5HZoYnZq0+JMuTNI=;
        b=bSQsym5jTu7tid1V3wKIvVCHxL+wKQhCPOlXkUQjUCvneK6rKaNSbylQWHm69lFcTm
         +/7Nnp/4oxFT/0FJbatV3grWVAsJeLwdjyhbLYJ5iUTEmLVCR4XxFhJoDTOUCnOUOtkZ
         xhdsV+WMCqU9yDJ6CdugPWL6KfPX2PjPm5hUMd6vEspt5hJ9yZrhL/cCPLYZxjVhN1yk
         Ekpseix5IyFPhq0Siv6omqwY/rv3mfsK0do2HF6aFtB2o/B7/hIrdoHrnUPhgKDf2VKG
         0LRHkXaNOro6zQjZGGIQ01ohx3tWlP9UbroOMLnyDgfO9fdsBZXWGMP2CEXaZa6ykfnw
         eADg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=T7l3rTl8i9rz5vSGTvef2wq+IhU5HZoYnZq0+JMuTNI=;
        b=SK7n2KYvh0K8Z/Hylg9ZI5SUL5kU1FzA4POpbtI0lilQUDWMK/GEGT66Qp+cUM1yRh
         9GD1F16BRbWO4ddvdnUgblW4OFFS9QLMf+3Y0x+IwM8xbHGzKdYPPRbT8sXonIycHNhP
         PzX9EmtSblBTj7yEtXUBQTxbetjdO9Kp4VCo7wkDTcFHjre6G/0RrNOjmv74j3nca5F4
         OJd11KkJJmXl0zG0LyteV07pRAVOFBnbwGMyfoJcAtPHK3RPiD9LEu9grQYzC7vwEinR
         3aAaodZlXu4IQS/nYowg9fKUTNwQ3zjw2LjatiO6qyizb9XiH56Y8THwuQTPK8LZMimm
         M7hQ==
X-Gm-Message-State: APjAAAVdlsDNPNM9XOmxEvHXEuhB+K8qCi7mDSLcfoJ4eKKSb1hjcbdP
        sbjjL70zjh2CVFJsUzRwg2hfjUlEmk5Z5RF5
X-Google-Smtp-Source: APXvYqzMcggS4owg/MLlThHemgQ+ESLFPJISuwQymF92LUp7dNX2POBbT1zQSAnXouS4/BROGtr70A==
X-Received: by 2002:ac8:885:: with SMTP id v5mr19139358qth.299.1574785697571;
        Tue, 26 Nov 2019 08:28:17 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id 198sm5420412qkn.70.2019.11.26.08.28.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Nov 2019 08:28:16 -0800 (PST)
Date:   Tue, 26 Nov 2019 11:28:15 -0500
From:   Josef Bacik <josef@toxicpanda.com>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com, wqu@suse.com
Subject: Re: [PATCH 4/4] btrfs: use btrfs_can_overcommit in inc_block_group_ro
Message-ID: <20191126162815.vopzao2ndeqmgi6k@MacBook-Pro-91.local>
References: <20191125144011.146722-1-josef@toxicpanda.com>
 <20191125144011.146722-5-josef@toxicpanda.com>
 <bc6ee1c0-b8cd-01c9-a38d-42ac59ed0093@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bc6ee1c0-b8cd-01c9-a38d-42ac59ed0093@gmx.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Nov 26, 2019 at 11:00:24AM +0800, Qu Wenruo wrote:
> 
> 
> On 2019/11/25 下午10:40, Josef Bacik wrote:
> > inc_block_group_ro does a calculation to see if we have enough room left
> > over if we mark this block group as read only in order to see if it's ok
> > to mark the block group as read only.
> > 
> > The problem is this calculation _only_ works for data, where our used is
> > always less than our total.  For metadata we will overcommit, so this
> > will almost always fail for metadata.
> > 
> > Fix this by exporting btrfs_can_overcommit, and then see if we have
> > enough space to remove the remaining free space in the block group we
> > are trying to mark read only.  If we do then we can mark this block
> > group as read only.
> 
> This patch is indeed much better than my naive RFC patches.
> 
> Instead of reducing over commit threshold, this just increase the check
> to can_overcommit(), brilliant.
> 
> However some small nitpicks below.
> > 
> > Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> > ---
> >  fs/btrfs/block-group.c | 37 ++++++++++++++++++++++++++-----------
> >  fs/btrfs/space-info.c  | 19 ++++++++++---------
> >  fs/btrfs/space-info.h  |  3 +++
> >  3 files changed, 39 insertions(+), 20 deletions(-)
> > 
> > diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
> > index 3ffbc2e0af21..7b1f6d2b9621 100644
> > --- a/fs/btrfs/block-group.c
> > +++ b/fs/btrfs/block-group.c
> > @@ -1184,7 +1184,6 @@ static int inc_block_group_ro(struct btrfs_block_group *cache, int force)
> Now @force parameter is not used any more.
> 
> We can have a cleanup patch for it.
> 
> >  {
> >  	struct btrfs_space_info *sinfo = cache->space_info;
> >  	u64 num_bytes;
> > -	u64 sinfo_used;
> >  	int ret = -ENOSPC;
> >  
> >  	spin_lock(&sinfo->lock);
> > @@ -1200,19 +1199,38 @@ static int inc_block_group_ro(struct btrfs_block_group *cache, int force)
> >  
> >  	num_bytes = cache->length - cache->reserved - cache->pinned -
> >  		    cache->bytes_super - cache->used;
> > -	sinfo_used = btrfs_space_info_used(sinfo, true);
> >  
> >  	/*
> > -	 * sinfo_used + num_bytes should always <= sinfo->total_bytes.
> > -	 *
> > -	 * Here we make sure if we mark this bg RO, we still have enough
> > -	 * free space as buffer.
> > +	 * Data never overcommits, even in mixed mode, so do just the straight
> > +	 * check of left over space in how much we have allocated.
> >  	 */
> > -	if (sinfo_used + num_bytes + sinfo->total_bytes) {
> > +	if (sinfo->flags & BTRFS_BLOCK_GROUP_DATA) {
> > +		u64 sinfo_used = btrfs_space_info_used(sinfo, true);
> > +
> > +		/*
> > +		 * sinfo_used + num_bytes should always <= sinfo->total_bytes.
> > +		 *
> > +		 * Here we make sure if we mark this bg RO, we still have enough
> > +		 * free space as buffer.
> > +		 */
> > +		if (sinfo_used + num_bytes + sinfo->total_bytes)
> 
> The same code copied from patch 3 I guess?
> The same typo.
> 
> > +			ret = 0;
> > +	} else {
> > +		/*
> > +		 * We overcommit metadata, so we need to do the
> > +		 * btrfs_can_overcommit check here, and we need to pass in
> > +		 * BTRFS_RESERVE_NO_FLUSH to give ourselves the most amount of
> > +		 * leeway to allow us to mark this block group as read only.
> > +		 */
> > +		if (btrfs_can_overcommit(cache->fs_info, sinfo, num_bytes,
> > +					 BTRFS_RESERVE_NO_FLUSH))
> > +			ret = 0;
> > +	}
> 
> For metadata chunks, allocating a new chunk won't change how we do over
> commit calculation.
> 
> I guess we can skip the chunk allocation for metadata chunks in
> btrfs_inc_block_group_ro()?

I _think_ so?  But you are working/testing in this area right now, try and see
how it works out?  I _think_ we'll still need to pre-allocate for data, and I
feel like relocation is an area where we may not be able to allocate new chunks
at certain times, so pre-allocating the metadata chunk may be useful.  System is
another one I would be iffy on.

If we're going to do that I would way rather it be a separate thing and only
after somebody has tested it to death to make sure it's not going to bite us in
the ass.  Thanks,

Josef
