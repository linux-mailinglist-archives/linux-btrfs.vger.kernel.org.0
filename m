Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C274273398
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Sep 2020 22:33:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726467AbgIUUd6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 21 Sep 2020 16:33:58 -0400
Received: from mx2.suse.de ([195.135.220.15]:41094 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726427AbgIUUd5 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 21 Sep 2020 16:33:57 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 8B139ACD8;
        Mon, 21 Sep 2020 20:34:32 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 0C17DDA6E0; Mon, 21 Sep 2020 22:32:40 +0200 (CEST)
Date:   Mon, 21 Sep 2020 22:32:40 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc:     Nikolay Borisov <nborisov@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 6/7] btrfs: Call submit_bio_hook directly for metadata
 pages
Message-ID: <20200921203240.GV6756@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Nikolay Borisov <nborisov@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <20200918133439.23187-1-nborisov@suse.com>
 <20200918133439.23187-7-nborisov@suse.com>
 <SN4PR0401MB35988E131C20F42AF70484FA9B3A0@SN4PR0401MB3598.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN4PR0401MB35988E131C20F42AF70484FA9B3A0@SN4PR0401MB3598.namprd04.prod.outlook.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Sep 21, 2020 at 03:04:54PM +0000, Johannes Thumshirn wrote:
> On 18/09/2020 15:34, Nikolay Borisov wrote:
> > diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> > index 8cabcb7642a9..4a00cfd4082f 100644
> > --- a/fs/btrfs/extent_io.c
> > +++ b/fs/btrfs/extent_io.c
> > @@ -172,8 +172,8 @@ int __must_check submit_one_bio(struct bio *bio, int mirror_num,
> >  		ret = btrfs_submit_data_bio(tree->private_data, bio, mirror_num,
> >  					    bio_flags);
> >  	else
> > -		ret = tree->ops->submit_bio_hook(tree->private_data, bio,
> > -						 mirror_num, bio_flags);
> > +		ret = btrfs_submit_metadata_bio(tree->private_data, bio,
> > +						mirror_num, bio_flags);
> >  
> 
> 
> Hmm we could even turn this into a little helper calling either
> btrfs_submit_data_bio or btrfs_submit_metadata_bio. But that's just stylistic
> preference I guess.

Yeah a helper could be here but I think it's fine without that extra
indirection, the code is clear that for data inode it's some "data"
function, with the same set of parameters. If there's just one location
switching the two, the helper would not help much IMHO.
