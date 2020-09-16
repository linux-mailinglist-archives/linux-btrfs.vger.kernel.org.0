Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04E4026C127
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Sep 2020 11:53:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726473AbgIPJx1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 16 Sep 2020 05:53:27 -0400
Received: from mx2.suse.de ([195.135.220.15]:54050 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726369AbgIPJxZ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 16 Sep 2020 05:53:25 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D64DBAED9;
        Wed, 16 Sep 2020 09:53:38 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 76195DA7C7; Wed, 16 Sep 2020 11:52:11 +0200 (CEST)
Date:   Wed, 16 Sep 2020 11:52:11 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        syzbot+e864a35d361e1d4e29a5@syzkaller.appspotmail.com
Subject: Re: [PATCH] btrfs: fix overflow when copying corrupt csums
Message-ID: <20200916095211.GK1791@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Anand Jain <anand.jain@oracle.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        syzbot+e864a35d361e1d4e29a5@syzkaller.appspotmail.com
References: <20200915144931.24555-1-johannes.thumshirn@wdc.com>
 <2c4bc253-9941-0f81-0c3a-cf22b8b9dadb@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2c4bc253-9941-0f81-0c3a-cf22b8b9dadb@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Sep 16, 2020 at 09:08:56AM +0800, Anand Jain wrote:
> On 15/9/20 10:49 pm, Johannes Thumshirn wrote:
> > index 160b485d2cc0..28b962840972 100644
> > --- a/fs/btrfs/disk-io.c
> > +++ b/fs/btrfs/disk-io.c
> > @@ -587,15 +587,15 @@ static int btree_readpage_end_io_hook(struct btrfs_io_bio *io_bio,
> >   
> >   	if (memcmp_extent_buffer(eb, result, 0, csum_size)) {
> >   		u32 val;
> > -		u32 found = 0;
> > +		u8 found[BTRFS_CSUM_SIZE] = { };
> 
> 
> u8 found[BTRFS_CSUM_SIZE] = {0}; not required?

Yes, { 0 } is the initializer we use, I fixed that.
> 
> >   
> >   		memcpy(&found, result, csum_size);
> >   
> >   		read_extent_buffer(eb, &val, 0, csum_size);
> >   		btrfs_warn_rl(fs_info,
> > -		"%s checksum verify failed on %llu wanted %x found %x level %d",
> > +		"%s checksum verify failed on %llu wanted %x found %*pH level %d",
> >   			      fs_info->sb->s_id, eb->start,
> > -			      val, found, btrfs_header_level(eb));
> > +			      val, csum_size, found, btrfs_header_level(eb));

And the format of csum as well.
