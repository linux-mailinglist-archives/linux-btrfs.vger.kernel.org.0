Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 01DAA11EE2
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 May 2019 17:46:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727737AbfEBPmF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 May 2019 11:42:05 -0400
Received: from mx2.suse.de ([195.135.220.15]:39190 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728189AbfEBP2W (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 2 May 2019 11:28:22 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 3ABCFADE0
        for <linux-btrfs@vger.kernel.org>; Thu,  2 May 2019 15:28:21 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 6F7BCDA871; Thu,  2 May 2019 17:29:18 +0200 (CEST)
Date:   Thu, 2 May 2019 17:29:14 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: Return EBUSY in case
 btrfs_start_write_no_snapshotting fails
Message-ID: <20190502152912.GD20156@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20190423114816.8304-1-nborisov@suse.com>
 <d465b4a4-4956-7ba0-aaba-c58d3aab656f@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d465b4a4-4956-7ba0-aaba-c58d3aab656f@suse.com>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Apr 23, 2019 at 04:59:36PM +0300, Nikolay Borisov wrote:
> 
> 
> On 23.04.19 г. 14:48 ч., Nikolay Borisov wrote:
> > If btrfs_start_write_no_snapshotting fails (returns 0) it means there
> > is snapshot in progress hence resource is busy and not that we are
> > out of space. Change the return value to correctly reflect this.
> > 
> > Signed-off-by: Nikolay Borisov <nborisov@suse.com>
> > ---
> >  fs/btrfs/file.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
> > index 2030b9bcb977..ce1dec51ff92 100644
> > --- a/fs/btrfs/file.c
> > +++ b/fs/btrfs/file.c
> > @@ -1547,7 +1547,7 @@ static noinline int check_can_nocow(struct btrfs_inode *inode, loff_t pos,
> >  
> >  	ret = btrfs_start_write_no_snapshotting(root);
> >  	if (!ret)
> > -		return -ENOSPC;
> > +		return -EBUSY;
> 
> This error is not returned to userspace, nevertheless write won't expect
> EBUSY in case it ever is. Perhaps EAGAIN makes more sense?

Yeah, EAGAIN sounds better.
