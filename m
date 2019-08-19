Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9E6E5927EC
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 Aug 2019 17:06:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727600AbfHSPGG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 19 Aug 2019 11:06:06 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:38362 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726343AbfHSPGF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 19 Aug 2019 11:06:05 -0400
Received: by mail-qt1-f196.google.com with SMTP id x4so2229802qts.5
        for <linux-btrfs@vger.kernel.org>; Mon, 19 Aug 2019 08:06:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=gy3fXG93wDCL009Izr4gh52nSweDqrInxb2498QgBP0=;
        b=2EVxPO5USz6QXwFP7wnBdV4kKITaVVaR6m407mlERSdOghOdubpiAFF/JND6q9QAcD
         HCbYa5/MW3tCZCybjLwjMAh7tTfGo61nJl/XLojz973gKrRN3tlnwtr+XXkfHSpCLJXX
         zyClatVHBJ/WLsIIYNg0o7NFJouizV9YI2z2Aq62tywvwziNgoxx/S/Z1zkxSHOl43wq
         XKQWjLTXSZR2dnLlj2QR+SepnvgADmRy29KV9n6XUWiY+hAHywAyt4VGvs0dXEfDeVSJ
         AjZKYXp9qQA8KVA2JLWXwb7zfuPL8WNVVH+NI60qVQXVGlB+slTSlQTjc5CdQojkA1Wz
         qS9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=gy3fXG93wDCL009Izr4gh52nSweDqrInxb2498QgBP0=;
        b=q5SwWKVy1bfrICbj5bFGHnTFGAZIX1cQYhIOjbzrTmofYqtY3PwCv+IlUYkNQ44VdC
         5wIiHyD/gSOmM1tetXmF8DxG+6ZsGq+K2JwFN/LzQBjOlIK/ps7N8E8s7uoFUGpgHKKm
         K34GWJ1Xl9PqXdcsFHfIp+iVu/D6f1+VY2ehU6ymkwH7sRlebGOYbVMAgY/gGJXIK5Cr
         eg+m4ID2K43Z65JKXPGFoSPnp4tpEq+rTxOFYC8B30iVsELI8CyQXLMPhhVQammh7b27
         XEzBemcLno1ZLzWZrYTlDgZTfw2mS28yjvWtIzs4lzx7pjV/PVT0BiT3pyCKk1/Ye3Qa
         nLrw==
X-Gm-Message-State: APjAAAWXd49Z9pEAcYWAggKaVt1cJRDhxQhpdS9XgJFOVFIINenXHulz
        5oX+zgvGGUjRUK09y4qqRbqGNg==
X-Google-Smtp-Source: APXvYqxsdiAzrKm59+JYg9CVZ0DZLDKx1qc5mMfx3fODu7fgdOLdh4JRNCniKOFO4iQg7Jk4AZOJBg==
X-Received: by 2002:ac8:4787:: with SMTP id k7mr21635080qtq.239.1566227164361;
        Mon, 19 Aug 2019 08:06:04 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id w10sm7145414qts.37.2019.08.19.08.06.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Aug 2019 08:06:03 -0700 (PDT)
Date:   Mon, 19 Aug 2019 11:06:02 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     Josef Bacik <josef@toxicpanda.com>, kernel-team@fb.com,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 6/8] btrfs: rework wake_all_tickets
Message-ID: <20190819150601.rj4k2li2f2bl35eo@MacBook-Pro-91.local>
References: <20190816141952.19369-1-josef@toxicpanda.com>
 <20190816141952.19369-7-josef@toxicpanda.com>
 <92c9dda1-bc57-48b5-e3d1-2a0af4e56adb@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <92c9dda1-bc57-48b5-e3d1-2a0af4e56adb@suse.com>
User-Agent: NeoMutt/20180716
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Aug 19, 2019 at 05:49:45PM +0300, Nikolay Borisov wrote:
> 
> 
> On 16.08.19 г. 17:19 ч., Josef Bacik wrote:
> > Now that we no longer partially fill tickets we need to rework
> > wake_all_tickets to call btrfs_try_to_wakeup_tickets() in order to see
> > if any subsequent tickets are able to be satisfied.  If our tickets_id
> > changes we know something happened and we can keep flushing.
> > 
> > Also if we find a ticket that is smaller than the first ticket in our
> > queue then we want to retry the flushing loop again in case
> > may_commit_transaction() decides we could satisfy the ticket by
> > committing the transaction.
> > 
> > Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> > ---
> >  fs/btrfs/space-info.c | 34 +++++++++++++++++++++++++++-------
> >  1 file changed, 27 insertions(+), 7 deletions(-)
> > 
> > diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
> > index 8a1c7ada67cb..bd485be783b8 100644
> > --- a/fs/btrfs/space-info.c
> > +++ b/fs/btrfs/space-info.c
> > @@ -676,19 +676,39 @@ static inline int need_do_async_reclaim(struct btrfs_fs_info *fs_info,
> >  		!test_bit(BTRFS_FS_STATE_REMOUNTING, &fs_info->fs_state));
> >  }
> >  
> > -static bool wake_all_tickets(struct list_head *head)
> > +static bool wake_all_tickets(struct btrfs_fs_info *fs_info,
> > +			     struct btrfs_space_info *space_info)
> >  {
> >  	struct reserve_ticket *ticket;
> > +	u64 tickets_id = space_info->tickets_id;
> > +	u64 first_ticket_bytes = 0;
> > +
> > +	while (!list_empty(&space_info->tickets) &&
> > +	       tickets_id == space_info->tickets_id) {
> > +		ticket = list_first_entry(&space_info->tickets,
> > +					  struct reserve_ticket, list);
> > +
> > +		/*
> > +		 * may_commit_transaction will avoid committing the transaction
> > +		 * if it doesn't feel like the space reclaimed by the commit
> > +		 * would result in the ticket succeeding.  However if we have a
> > +		 * smaller ticket in the queue it may be small enough to be
> > +		 * satisified by committing the transaction, so if any
> > +		 * subsequent ticket is smaller than the first ticket go ahead
> > +		 * and send us back for another loop through the enospc flushing
> > +		 * code.
> > +		 */
> > +		if (first_ticket_bytes == 0)
> > +			first_ticket_bytes = ticket->bytes;
> > +		else if (first_ticket_bytes > ticket->bytes)
> > +			return true;
> >  
> > -	while (!list_empty(head)) {
> > -		ticket = list_first_entry(head, struct reserve_ticket, list);
> >  		list_del_init(&ticket->list);
> >  		ticket->error = -ENOSPC;
> >  		wake_up(&ticket->wait);
> > -		if (ticket->bytes != ticket->orig_bytes)
> > -			return true;
> > +		btrfs_try_to_wakeup_tickets(fs_info, space_info);
> 
> So the change in this logic is directly related to the implementation of
> btrfs_try_to_wakeup_tickets. Because when we fail and remove a ticket in
> this function we give a chance that the next ticket *could* be
> satisfied. But how well does that work in practice, given you fail
> normal prio tickets here, whereas btrfs_try_to_wakeup_tickets first
> checks the prio ticket. So even if you are failing normal ticket but
> there is one unsatifiable prio ticket that won't really change anything.

In practice we don't get to this state with high priority tickets on the list.
Anything that would be long-ish term on the priority list is evict, and we wait
for iput()'s in the normal flushing code.  At the point we hit wake_all_tickets
we generally should only have tickets on the normal list.

I suppose we could possibly get into this situation, but again the high priority
tickets are going to be evict, truncate block, and relocate, which all have
significantly lower reservation amounts than things like create or unlink.  If
those things are unable to get reservations then we are truly out of space.
Thanks,

Josef
