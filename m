Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2ED23180DC2
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Mar 2020 02:46:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727588AbgCKBqB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 10 Mar 2020 21:46:01 -0400
Received: from mx2.suse.de ([195.135.220.15]:38582 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727484AbgCKBqB (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 10 Mar 2020 21:46:01 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id CA9FBAD31;
        Wed, 11 Mar 2020 01:45:59 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id C396DDA7A7; Wed, 11 Mar 2020 02:45:34 +0100 (CET)
Date:   Wed, 11 Mar 2020 02:45:34 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH 0/5] Deal with a few ENOSPC corner cases
Message-ID: <20200311014534.GG12659@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <20200309202322.12327-1-josef@toxicpanda.com>
 <0c2c685d-ce31-99a3-9d12-78725da73d63@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0c2c685d-ce31-99a3-9d12-78725da73d63@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Mar 10, 2020 at 07:28:03PM +0200, Nikolay Borisov wrote:
> On 9.03.20 г. 22:23 ч., Josef Bacik wrote:
> > Nikolay has been digging into a failure of generic/320 on ppc64.  This has
> > shaken out a variety of issues, and he's done a good job at running all of the
> > weird corners down and then testing my ideas to get them all fixed.  This is the
> > series that has survived the longest, so we're declaring victory.
> > 
> > First there is the global reserve stealing logic.  The way unlink works is it
> > attempts to start a transaction with a normal reservation amount, and if this
> > fails with ENOSPC we fall back to stealing from the global reserve.  This is
> > problematic because of all the same reasons we had with previous iterations of
> > the ENOSPC handling, thundering herd.  We get a bunch of failures all at once,
> > everybody tries to allocate from the global reserve, some win and some lose, we
> > get an ENSOPC.
> > 
> > To fix this we need to integrate this logic into the normal ENOSPC
> > infrastructure.  The idea is simple, we add a new flushing state that indicates
> > we are allowed to steal from the global reserve.  We still go through all of the
> > normal flushing work, and at the moment we begin to fail all the tickets we try
> > to satisfy any tickets that are allowed to steal by stealing from the global
> > reserve.  If this works we start the flushing system over again just like we
> > would with a normal ticket satisfaction.  This serializes our global reserve
> > stealing, so we don't have the thundering herd problem
> > 
> > This isn't the only problem however.  Nikolay also noticed that we would
> > sometimes have huge amounts of space in the trans block rsv and we would ENOSPC
> > out.  This is because the may_commit_transaction() logic didn't take into
> > account the space that would be reclaimed by all of the outstanding trans
> > handles being required to stop in order to commit the transaction.
> > 
> > Another corner here was that priority tickets could race in and make
> > may_commit_transaction() think that it had no work left to do, and thus not
> > commit the transaction.
> > 
> > Those fixes all address the failures that Nikolay was seeing.  The last two
> > patches are just cleanups around how we handle priority tickets.  We shouldn't
> > even be serializing priority tickets behind normal tickets, only behind other
> > priority tickets.  And finally there would be a small window where priority
> > tickets would fail out if there were multiple priority tickets and one of them
> > failed.  This is addressed by the previous patch.
> > 
> > Nikolay has put these through many iterations of generic/320, and so far it
> > hasn't failed.  Thanks,
> > 
> > Josef
> > 
> 
> This patchset causes regressions on following tests:
> 
> btrfs/132 btrfs/170 btrfs/177 generic/102 generic/103 generic/170
> generic/172 generic/275 generic/299 generic/464 generic/551
> 
> Please don't merge for now.

Thanks for letting me know, space handling fixes could always use longer
period of testing. At this point we're getting close to pre merge window
freeze so I'd be more nervous merging it now.
