Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D113514FEAE
	for <lists+linux-btrfs@lfdr.de>; Sun,  2 Feb 2020 18:53:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726906AbgBBRxK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 2 Feb 2020 12:53:10 -0500
Received: from mx2.suse.de ([195.135.220.15]:44452 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726893AbgBBRxK (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 2 Feb 2020 12:53:10 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id ACD00AD14;
        Sun,  2 Feb 2020 17:53:08 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 54A59DA7A1; Sun,  2 Feb 2020 18:52:47 +0100 (CET)
Date:   Sun, 2 Feb 2020 18:52:47 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        Martin Steigerwald <martin@lichtvoll.de>
Subject: Re: [PATCH] btrfs: do not zero f_bavail if we have available space
Message-ID: <20200202175247.GB3929@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        Martin Steigerwald <martin@lichtvoll.de>
References: <20200131143105.52092-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200131143105.52092-1-josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jan 31, 2020 at 09:31:05AM -0500, Josef Bacik wrote:
> There was some logic added a while ago to clear out f_bavail in statfs()
> if we did not have enough free metadata space to satisfy our global
> reserve.  This was incorrect at the time, however didn't really pose a
> problem for normal file systems because we would often allocate chunks
> if we got this low on free metadata space, and thus wouldn't really hit
> this case unless we were actually full.
> 
> Fast forward to today and now we are much better about not allocating
> metadata chunks all of the time.  Couple this with d792b0f19711 which
> now means we'll easily have a larger global reserve than our free space,
> we are now more likely to trip over this while still having plenty of
> space.
> 
> Fix this by skipping this logic if the global rsv's space_info is not
> full.  space_info->full is 0 unless we've attempted to allocate a chunk
> for that space_info and that has failed.  If this happens then the space
> for the global reserve is definitely sacred and we need to report
> b_avail == 0, but before then we can just use our calculated b_avail.
> 
> There are other cases where df isn't quite right, and Qu is addressing
> them in a more holistic way.  This simply fixes the users that are
> currently experiencing pain because of this problem.
> 
> Fixes: ca8a51b3a979 ("btrfs: statfs: report zero available if metadata are exhausted")
> Reported-by: Martin Steigerwald <martin@lichtvoll.de>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Added to 5.6 queue, thanks.
