Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90D7F23D232
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Aug 2020 22:09:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728693AbgHEUJl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 5 Aug 2020 16:09:41 -0400
Received: from mx2.suse.de ([195.135.220.15]:56274 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726774AbgHEQ3S (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 5 Aug 2020 12:29:18 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id B29B3AC65;
        Wed,  5 Aug 2020 16:29:33 +0000 (UTC)
Date:   Wed, 5 Aug 2020 11:29:14 -0500
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 3/3] btrfs: add more information for balance
Message-ID: <20200805162914.pcstf7datq2mdqqz@fiona>
References: <20200803202913.15913-1-rgoldwyn@suse.de>
 <20200803202913.15913-4-rgoldwyn@suse.de>
 <fd3307e1-eb59-26b0-790f-4845968e2bce@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fd3307e1-eb59-26b0-790f-4845968e2bce@suse.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 15:17 05/08, Nikolay Borisov wrote:
> 
> 
> On 3.08.20 г. 23:29 ч., Goldwyn Rodrigues wrote:
> > From: Goldwyn Rodrigues <rgoldwyn@suse.com>
> > 
> > Include information about the state of the balance and expected,
> > considered and completed statistics.
> > 
> > Q: I am not sure of the cancelled state, and stopping seemed more
> > appropriate since it was a transient state to cancelling the operation.
> > Would you prefer to call it cancelled?
> > 
> > This information is not used by user space as of now. We could use it
> > for "btrfs balance status" or ignore this patch for inclusion at all.
> > 
> > Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
> > ---
> >  fs/btrfs/sysfs.c | 29 ++++++++++++++++++++++++++++-
> >  1 file changed, 28 insertions(+), 1 deletion(-)
> > 
> > diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
> > index 71950c121588..001a7ae375d0 100644
> > --- a/fs/btrfs/sysfs.c
> > +++ b/fs/btrfs/sysfs.c
> > @@ -808,6 +808,33 @@ static ssize_t btrfs_checksum_show(struct kobject *kobj,
> >  
> >  BTRFS_ATTR(, checksum, btrfs_checksum_show);
> >  
> > +static ssize_t btrfs_balance_show(struct btrfs_fs_info *fs_info, char *buf)
> > +{
> > +	ssize_t ret = 0;
> > +	struct btrfs_balance_control *bctl;
> > +
> > +	ret += scnprintf(buf, PAGE_SIZE, "balance\n");
> > +	spin_lock(&fs_info->balance_lock);
> > +	bctl = fs_info->balance_ctl;
> > +	if (!bctl) {
> > +		ret += scnprintf(buf + ret, PAGE_SIZE - ret,
> > +				"State: stopping\n");
> 
> nit: Shouldn't this be "stopped"?

I named it stopping because it was in the phase where the request had
come in but it had not completed the stop. This phase lasts for a couple
of hundreds of milliseconds in my test environment.

> 
> > +		goto out;
> > +	}
> > +	if (test_bit(BTRFS_FS_BALANCE_RUNNING, &fs_info->flags))
> > +		ret += scnprintf(buf + ret, PAGE_SIZE - ret,
> > +				"State: running\n");
> > +	else
> > +		ret += scnprintf(buf + ret, PAGE_SIZE - ret,
> > +				"State: paused\n");
> > +	ret += scnprintf(buf + ret, PAGE_SIZE - ret, "%llu %llu %llu\n",
> > +			bctl->stat.expected, bctl->stat.considered,
> > +			bctl->stat.completed);
> > +out:
> > +	spin_unlock(&fs_info->balance_lock);
> > +	return ret;
> > +}
> 
> Technically I don't see anything wrong with this, however I got reminded
> of the following text from sysfs documentation:
> 
> "
> Mixing types, expressing multiple lines of data, and doing fancy
> 
> formatting of data is heavily frowned upon. Doing these things may get
> 
> you publicly humiliated and your code rewritten without notice.
> "
> 

Yes, I think it is best to drop this. This information can be obtained
by ioctls as well.

-- 
Goldwyn
