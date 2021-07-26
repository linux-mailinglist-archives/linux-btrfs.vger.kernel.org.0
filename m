Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F3483D5C1A
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Jul 2021 16:50:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234677AbhGZOJ7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 26 Jul 2021 10:09:59 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:55546 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233206AbhGZOJ7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 26 Jul 2021 10:09:59 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 6F7AB1FEB0;
        Mon, 26 Jul 2021 14:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1627311026;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=38Us6RW3hXMtB7GEsOSM2FHFCSmuabUX1dr4ar/WcsQ=;
        b=ygBTA7lLrQGwhxVrx6JfAac3UZfgyTDs3jT0xeVID2566px1hqaMNjOmTSMa3g4jmTwnX0
        idiSoz7dsxBrcUiAj3Lc7+dupsXIMOpJVr58FX4Em9ZzmOfwas+PouVV1JUde0aFIXbh8W
        3AIPm6U5jpk9tPtawTzX7hFhYgZcdJI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1627311026;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=38Us6RW3hXMtB7GEsOSM2FHFCSmuabUX1dr4ar/WcsQ=;
        b=8vM3tWCnJJBtrgSM677lv/M5sYaRYIZzjr6zWjzG3mJIdYpKSFlXq6/KmJmjTnVkuU0V3j
        vgzRazxM/lCpVHCQ==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 6851DA3B81;
        Mon, 26 Jul 2021 14:50:26 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 79017DA8D8; Mon, 26 Jul 2021 16:47:42 +0200 (CEST)
Date:   Mon, 26 Jul 2021 16:47:42 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 04/10] btrfs: tree-checker: use table values for stripe
 checks
Message-ID: <20210726144742.GD5047@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1627300614.git.dsterba@suse.com>
 <b7a7bb037ee8622784d94f39997d8ab1fbec892a.1627300614.git.dsterba@suse.com>
 <aa326600-b1e0-e3d4-38b5-1ef0b4527e8e@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aa326600-b1e0-e3d4-38b5-1ef0b4527e8e@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jul 26, 2021 at 08:29:25PM +0800, Qu Wenruo wrote:
> 
> 
> On 2021/7/26 下午8:15, David Sterba wrote:
> > There are hardcoded values in several checks regarding chunks and stripe
> > constraints. We have that defined in the raid table and ought to use it.
> >
> > Signed-off-by: David Sterba <dsterba@suse.com>
> 
> Reviewed-by: Qu Wenruo <wqu@suse.com>
> 
> But one weird off-topics inlined below.
> 
> > ---
> >   fs/btrfs/tree-checker.c | 17 +++++++++++------
> >   1 file changed, 11 insertions(+), 6 deletions(-)
> >
> > diff --git a/fs/btrfs/tree-checker.c b/fs/btrfs/tree-checker.c
> > index a8b2e0d2c025..ac9416cb4496 100644
> > --- a/fs/btrfs/tree-checker.c
> > +++ b/fs/btrfs/tree-checker.c
> > @@ -873,13 +873,18 @@ int btrfs_check_chunk_valid(struct extent_buffer *leaf,
> >   		}
> >   	}
> >
> > -	if (unlikely((type & BTRFS_BLOCK_GROUP_RAID10 && sub_stripes != 2) ||
> > -		     (type & BTRFS_BLOCK_GROUP_RAID1 && num_stripes != 2) ||
> > -		     (type & BTRFS_BLOCK_GROUP_RAID5 && num_stripes < 2) ||
> > -		     (type & BTRFS_BLOCK_GROUP_RAID6 && num_stripes < 3) ||
> > -		     (type & BTRFS_BLOCK_GROUP_DUP && num_stripes != 2) ||
> > +	if (unlikely((type & BTRFS_BLOCK_GROUP_RAID10 &&
> > +		      sub_stripes != btrfs_raid_array[BTRFS_RAID_RAID10].sub_stripes) ||
> > +		     (type & BTRFS_BLOCK_GROUP_RAID1 &&
> > +		      num_stripes != btrfs_raid_array[BTRFS_RAID_RAID1].devs_min) ||
> 
> We're adding support for single device RAID0, but there won't be
> anything called single device RAID1 at all, right?

Raid 1 with one device can only work in degraded mode so that's
different, it still expects at least 2 devices.
