Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73C44382CC7
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 May 2021 15:03:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237209AbhEQNEX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 17 May 2021 09:04:23 -0400
Received: from mx2.suse.de ([195.135.220.15]:56524 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234728AbhEQNEJ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 17 May 2021 09:04:09 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 88830AF4E;
        Mon, 17 May 2021 13:02:52 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 0EA33DB228; Mon, 17 May 2021 15:00:19 +0200 (CEST)
Date:   Mon, 17 May 2021 15:00:19 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Boris Burkov <boris@bur.io>
Cc:     Tian Tao <tiantao6@hisilicon.com>, dsterba@suse.com,
        josef@toxicpanda.com, clm@fb.com, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2] btrfs: add goto in btrfs_defrag_file for error
 handling
Message-ID: <20210517130019.GP7604@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Boris Burkov <boris@bur.io>,
        Tian Tao <tiantao6@hisilicon.com>, dsterba@suse.com,
        josef@toxicpanda.com, clm@fb.com, linux-btrfs@vger.kernel.org
References: <1620177988-6664-1-git-send-email-tiantao6@hisilicon.com>
 <YJMe9CLl6zib1WvF@zen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YJMe9CLl6zib1WvF@zen>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, May 05, 2021 at 03:40:52PM -0700, Boris Burkov wrote:
> On Wed, May 05, 2021 at 09:26:28AM +0800, Tian Tao wrote:
> > ret is assigned -EAGAIN at line 1455 and then reassigned defrag_count
> > at line 1547 after exiting the while loop.this causes the
> > btrfs_defrag_file function to not return the correct value in the event
> > of an error, this patch fixed this issue.
> 
> This looks like a correct fix, in that it locally improves what it
> claims to improve. However, I have some questions about the style and
> consistency of the function as a whole as a result. I think Dave had
> a similar comment in his very first reply on v1.
> 
> The loop has the following early exit points:
> fs unmounted
> cancellation
> swapfile/error in cluster_pages_for_defrag
> newer_off == (u64)-1
> error (ENOMEM or ENOENT) in find_new_extents
> 
> To me, it is confusing that of all these, only cancellation goes to a
> label called "error". I would expect at least the swapfile/cluster case
> to also jump to error. find_new_extents is interesting, because ENOENT
> could be semantically special as an error and warrant a break rather
> than a goto error, so we ought to figure that out correctly too.
> 
> If there is some good reason that only cancellation should receive this
> treatment, and that some early exit cases should break or goto out_ra
> then I would at least name the new label "cancel" and write a comment or
> a note in the git commit explaining the difference.

The naming convention of the exit labels describes what happens at the
label point and not the reason, as the label can be targeted from
various branches but the same clanup is done. The naming is not
consistent everywhere, but at least that's the idea.

> Thinking out loud, I suspect a way to really fix this messy function is
> to do something like lift the contents of the while loop into a helper
> function which returns the next incremental defrag_count, an error, or 0
> for done.

Reading it again with the above in mind, there are two types of errors
to end the defrag:

- if some defrag work has been done but not entire file was processed
- the rest, eg. some hard errors

In the first case the optional flushing should still happen. In both
cases the incompat bits should be set -- this is now missing.

I'm not sure if the whole while loop could be factored out, there's a
lot of shared state with the function. The different kinds of errors
would have to be reflected too but that's doable.

As this patch fixes the return value of canceled defrag, I'd take it as
is and address the other issues separately.
