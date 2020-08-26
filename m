Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8820C2529C9
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Aug 2020 11:14:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727930AbgHZJOe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 26 Aug 2020 05:14:34 -0400
Received: from mx2.suse.de ([195.135.220.15]:42754 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727811AbgHZJOd (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 26 Aug 2020 05:14:33 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 3A84DB785;
        Wed, 26 Aug 2020 09:15:03 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 189D0DA730; Wed, 26 Aug 2020 11:13:23 +0200 (CEST)
Date:   Wed, 26 Aug 2020 11:13:22 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH] btrfs: fix possible infinite loop in data async reclaim
Message-ID: <20200826091322.GA28318@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <24f846bc8860cab91ca134d0a337cc290589a092.1598389008.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <24f846bc8860cab91ca134d0a337cc290589a092.1598389008.git.josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Aug 25, 2020 at 04:56:59PM -0400, Josef Bacik wrote:
> Dave reported an issue where generic/102 would sometimes hang.  This
> turned out to be because we'd get into this spot where we were no longer
> making progress on data reservations because our exit condition was not
> met.  The log is basically
> 
> while (!space_info->full && !list_empty(&space_info->tickets))
> 	flush_space(space_info, flush_state);
> 
> where flush state is our various flush states, but doesn't include
> ALLOC_CHUNK_FORCE.  This is because we actually lead with allocating
> chunks, and so the assumption was that once you got to the actual
> flushing states you could no longer allocate chunks.  This was a stupid
> assumption, because you could have deleted block groups that would be
> reclaimed by a transaction commit, thus unsetting space_info->full.
> This is essentially what happens with generic/102, and so sometimes
> you'd get stuck in the flushing loop because we weren't allocating
> chunks, but flushing space wasn't giving us what we needed to make
> progress.
> 
> Fix this by adding ALLOC_CHUNK_FORCE to the end of our flushing states,
> that way we will eventually bail out because we did end up with
> space_info->full if we free'd a chunk previously.  Otherwise, as is the
> case for this test, we'll allocate our chunk and continue on our happy
> merry way.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Thanks. As the flushing states are added one by one at the end of the
series, I'll add it as a separate patch. Folding it to some other patch
would lose a bit more of information that's in the changelog, so this
leaves a short window where the 102 hang could happen but again the
flushing sequence is not switched at once.
