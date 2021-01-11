Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA7C22F223E
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Jan 2021 22:54:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389073AbhAKVx0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 11 Jan 2021 16:53:26 -0500
Received: from mx2.suse.de ([195.135.220.15]:60380 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725917AbhAKVxZ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 11 Jan 2021 16:53:25 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id DF30BAD1E;
        Mon, 11 Jan 2021 21:52:43 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id E353BDA701; Mon, 11 Jan 2021 22:50:51 +0100 (CET)
Date:   Mon, 11 Jan 2021 22:50:51 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v5 2/8] btrfs: only let one thread pre-flush delayed refs
 in commit
Message-ID: <20210111215051.GH6430@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1608319304.git.josef@toxicpanda.com>
 <9e47b11bdfe5b4905fdaa81e952de2e2466c6335.1608319304.git.josef@toxicpanda.com>
 <20210108160109.GB6430@twin.jikos.cz>
 <52aef9a6-efc7-0820-7056-067e69c2a856@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <52aef9a6-efc7-0820-7056-067e69c2a856@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jan 11, 2021 at 10:33:42AM +0200, Nikolay Borisov wrote:
> On 8.01.21 г. 18:01 ч., David Sterba wrote:
> > On Fri, Dec 18, 2020 at 02:24:20PM -0500, Josef Bacik wrote:
> >> @@ -2043,23 +2043,22 @@ int btrfs_commit_transaction(struct btrfs_trans_handle *trans)
> >>  	btrfs_trans_release_metadata(trans);
> >>  	trans->block_rsv = NULL;
> >>  
> >> -	/* make a pass through all the delayed refs we have so far
> >> -	 * any runnings procs may add more while we are here
> >> -	 */
> >> -	ret = btrfs_run_delayed_refs(trans, 0);
> >> -	if (ret) {
> >> -		btrfs_end_transaction(trans);
> >> -		return ret;
> >> -	}
> >> -
> >> -	cur_trans = trans->transaction;
> >> -
> >>  	/*
> >> -	 * set the flushing flag so procs in this transaction have to
> >> -	 * start sending their work down.
> >> +	 * We only want one transaction commit doing the flushing so we do not
> >> +	 * waste a bunch of time on lock contention on the extent root node.
> >>  	 */
> >> -	cur_trans->delayed_refs.flushing = 1;
> >> -	smp_wmb();
> > 
> > This barrier obviously separates the flushing = 1 and the rest of the
> > code, now implemented as test_and_set_bit, which implies full barrier.
> > 
> > However, hunk in btrfs_should_end_transaction removes the barrier and
> > I'm not sure whether this is correct:
> > 
> > -	smp_mb();
> >  	if (cur_trans->state >= TRANS_STATE_COMMIT_START ||
> > -	    cur_trans->delayed_refs.flushing)
> > +	    test_bit(BTRFS_DELAYED_REFS_FLUSHING,
> > +		     &cur_trans->delayed_refs.flags))
> >  		return true;
> > 
> > This is never called under locks so we don't have complete
> > synchronization of neither the transaction state nor the flushing bit.
> > btrfs_should_end_transaction is merely a hint and not called in critical
> > places so we could probably afford to keep it without a barrier, or keep
> > it with comment(s).
> 
> I think the point is moot in this case, because the test_bit either sees
> the flag or it doesn't. It's not possible for the flag to be set AND
> should_end_transaction return false that would be gross violation of
> program correctness.

So that's for the flushing part, but what about cur_trans->state?
