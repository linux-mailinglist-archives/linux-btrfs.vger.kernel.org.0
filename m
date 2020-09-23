Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA560275991
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Sep 2020 16:12:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726606AbgIWOMc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 23 Sep 2020 10:12:32 -0400
Received: from mx2.suse.de ([195.135.220.15]:39948 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726130AbgIWOMc (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 23 Sep 2020 10:12:32 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id A912FAE7A;
        Wed, 23 Sep 2020 14:13:08 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 77D7ADA6E3; Wed, 23 Sep 2020 16:11:15 +0200 (CEST)
Date:   Wed, 23 Sep 2020 16:11:15 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     dsterba@suse.cz, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 4/7] btrfs: Don't opencode is_data_inode in
 end_bio_extent_readpage
Message-ID: <20200923141115.GO6756@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20200918133439.23187-1-nborisov@suse.com>
 <20200918133439.23187-5-nborisov@suse.com>
 <20200921202909.GU6756@twin.jikos.cz>
 <e6268502-272f-ff6f-b38c-24949d18dbe4@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e6268502-272f-ff6f-b38c-24949d18dbe4@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Sep 23, 2020 at 09:23:48AM +0300, Nikolay Borisov wrote:
> 
> 
> On 21.09.20 г. 23:29 ч., David Sterba wrote:
> > On Fri, Sep 18, 2020 at 04:34:36PM +0300, Nikolay Borisov wrote:
> >> Use the is_data_inode helper.
> >>
> >> Signed-off-by: Nikolay Borisov <nborisov@suse.com>
> >> ---
> >>  fs/btrfs/extent_io.c | 3 +--
> >>  1 file changed, 1 insertion(+), 2 deletions(-)
> >>
> >> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> >> index 6e976bd86600..26b002e2f3b3 100644
> >> --- a/fs/btrfs/extent_io.c
> >> +++ b/fs/btrfs/extent_io.c
> >> @@ -2816,8 +2816,7 @@ static void end_bio_extent_readpage(struct bio *bio)
> >>  		struct page *page = bvec->bv_page;
> >>  		struct inode *inode = page->mapping->host;
> >>  		struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
> >> -		bool data_inode = btrfs_ino(BTRFS_I(inode))
> >> -			!= BTRFS_BTREE_INODE_OBJECTID;
> >> +		bool data_inode = is_data_inode(inode);
> > 
> > I think you can remove the temporary variable and call is_data_inode
> > directly in the later code, there's only one use.
> > 
> 
> Actually it's used twice, yet I did an experiment to remove it and
> bloat-o-meter indicates it's a win to call the inline function twice:

My oversight, sorry.

> add/remove: 0/0 grow/shrink: 0/2 up/down: 0/-161 (-161)
> Function                                     old     new   delta
> end_bio_extent_readpage.cold                 117     104     -13
> end_bio_extent_readpage                     1614    1466    -148
> Total: Before=45527, After=45366, chg -0.35%

Ok, I'll update it to call the helper.
