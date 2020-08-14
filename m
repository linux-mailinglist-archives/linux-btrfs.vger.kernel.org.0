Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42C3E244610
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 Aug 2020 10:02:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726768AbgHNIC3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 14 Aug 2020 04:02:29 -0400
Received: from mx2.suse.de ([195.135.220.15]:53590 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726124AbgHNIC2 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 14 Aug 2020 04:02:28 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id F3D84AB9F;
        Fri, 14 Aug 2020 08:02:49 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 86F76DA6EF; Fri, 14 Aug 2020 10:01:24 +0200 (CEST)
Date:   Fri, 14 Aug 2020 10:01:24 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org, Nikolay Borisov <nborisov@suse.com>,
        Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH v4 2/4] btrfs: extent-tree: Kill BUG_ON() in
 __btrfs_free_extent() and do better comment
Message-ID: <20200814080124.GT2026@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org,
        Nikolay Borisov <nborisov@suse.com>,
        Josef Bacik <josef@toxicpanda.com>
References: <20200812060509.71590-1-wqu@suse.com>
 <20200812060509.71590-3-wqu@suse.com>
 <20200813141019.GI2026@twin.jikos.cz>
 <bf3d96a8-f19c-1b0d-9171-c82f7a4d3d0f@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bf3d96a8-f19c-1b0d-9171-c82f7a4d3d0f@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Aug 14, 2020 at 08:52:19AM +0800, Qu Wenruo wrote:
> 
> 
> On 2020/8/13 下午10:10, David Sterba wrote:
> > On Wed, Aug 12, 2020 at 02:05:07PM +0800, Qu Wenruo wrote:
> >> @@ -2987,13 +3049,20 @@ static int __btrfs_free_extent(struct btrfs_trans_handle *trans,
> >>  				found_extent = 1;
> >>  				break;
> >>  			}
> >> +
> >> +			/* Quick path didn't find the EXTEMT/METADATA_ITEM */
> >>  			if (path->slots[0] - extent_slot > 5)
> >>  				break;
> >>  			extent_slot--;
> >>  		}
> >>
> >>  		if (!found_extent) {
> >> -			BUG_ON(iref);
> >> +			if (unlikely(iref)) {
> >> +				btrfs_crit(info,
> >> +"invalid iref, no EXTENT/METADATA_ITEM found but has inline extent ref");
> >> +				goto err_dump_abort;
> >
> > This is not calling transaction abort at the place where it happens,
> > here and several other places too.
> 
> Did you mean, we want the btrfs_abort_transaction() call not merged
> under one tag, so that we can get the kernel warning with the line number?
> 
> If so, that's indeed the case, we lose the exact line number.
> 
> But we still have the unique error message to locate the problem without
> much hassle (it's less obvious than the line number thought).
> 
> Thus to me, we don't lose much debug info anyway.

https://btrfs.wiki.kernel.org/index.php/Development_notes#Error_handling_and_transaction_abort

"Please keep all transaction abort exactly at the place where they happen
and do not merge them to one. This pattern should be used everwhere and
is important when debugging because we can pinpoint the line in the code
from the syslog message and do not have to guess which way it got to the
merged call."

It's very convenient to paste the file:line number from a stacktrace
report and land exactly in the spot where it failed.
