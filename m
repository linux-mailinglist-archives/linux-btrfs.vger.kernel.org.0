Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B3E6918BC64
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Mar 2020 17:26:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727708AbgCSQ0S (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 19 Mar 2020 12:26:18 -0400
Received: from mx2.suse.de ([195.135.220.15]:49656 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727477AbgCSQ0S (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 19 Mar 2020 12:26:18 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id C6370ACA1;
        Thu, 19 Mar 2020 16:26:16 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 4399EDA70E; Thu, 19 Mar 2020 17:25:48 +0100 (CET)
Date:   Thu, 19 Mar 2020 17:25:47 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     dsterba@suse.cz, linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH] btrfs: use nofs allocations for running delayed items
Message-ID: <20200319162547.GF12659@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <20200319141132.3127-1-josef@toxicpanda.com>
 <20200319143428.GD12659@twin.jikos.cz>
 <3c965a52-1750-940b-03a9-003a92c9d263@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3c965a52-1750-940b-03a9-003a92c9d263@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Mar 19, 2020 at 10:51:15AM -0400, Josef Bacik wrote:
> On 3/19/20 10:34 AM, David Sterba wrote:
> > On Thu, Mar 19, 2020 at 10:11:32AM -0400, Josef Bacik wrote:
> >> This is because we hold that delayed node's mutex while doing tree
> >> operations.  Fix this by just wrapping the searches in nofs.
> > 
> > For the time being we have to do the explicit NOFS so in the code it's
> > a bit awkward. The hint is a function that takes transaction as
> > argument.
> > 
> > I'm working on the scope NOFS (marked by the transaction start/end), it's
> > intrusive, all over the code and there are some cases when I want to add
> > assertions that turns out to be tricky for some functions.
> > 
> 
> That could be cleaner, do you want me to drop this and just add a
> 
> if (trans)
> 	memalloc_nofs_save()
> 
> memalloc_nofs_restore()
> 
> in btrfs_search_slot?  That'll catch all of these usages.  I'm not married to 
> any particular approach.  Thanks,

Not all I think but I haven't looked closer. Maybe the search slot is
used in majority of cases anyway. The outer scope between
memalloc_nofs_save/memalloc_nofs_restored has been used so far and it's
obvious where it starts and ends so even if it's not pretty let's use it
for now.
