Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 113D7164018
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Feb 2020 10:17:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726297AbgBSJR1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 19 Feb 2020 04:17:27 -0500
Received: from luna.lichtvoll.de ([194.150.191.11]:57455 "EHLO
        mail.lichtvoll.de" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726202AbgBSJR1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 19 Feb 2020 04:17:27 -0500
Received: from 127.0.0.1 (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.lichtvoll.de (Postfix) with ESMTPSA id 81D17B3381;
        Wed, 19 Feb 2020 10:17:24 +0100 (CET)
From:   Martin Steigerwald <martin@lichtvoll.de>
To:     Marc MERLIN <marc@merlins.org>
Cc:     dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH] btrfs: do not zero f_bavail if we have available space
Date:   Wed, 19 Feb 2020 10:17:24 +0100
Message-ID: <2776783.E9KYCc1pZO@merkaba>
In-Reply-To: <CAKhhfD7S=kcKLRURdNFZ8H4beS8=XjFvnOQXche7+SVOGFGC_w@mail.gmail.com>
References: <20200131143105.52092-1-josef@toxicpanda.com> <20200202175247.GB3929@twin.jikos.cz> <CAKhhfD7S=kcKLRURdNFZ8H4beS8=XjFvnOQXche7+SVOGFGC_w@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Authentication-Results: mail.lichtvoll.de;
        auth=pass smtp.auth=martin smtp.mailfrom=martin@lichtvoll.de
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Marc MERLIN - 19.02.20, 01:42:57 CET:
> Has the patch gotten to any 5.5 release too?

Yes, as git log easily reveals.

> On Sun, Feb 2, 2020, 12:53 David Sterba <dsterba@suse.cz> wrote:
> > On Fri, Jan 31, 2020 at 09:31:05AM -0500, Josef Bacik wrote:
> > > There was some logic added a while ago to clear out f_bavail in
> > > statfs() if we did not have enough free metadata space to satisfy
> > > our global reserve.  This was incorrect at the time, however
> > > didn't really pose a problem for normal file systems because we
> > > would often allocate chunks if we got this low on free metadata
> > > space, and thus wouldn't really hit this case unless we were
> > > actually full.
> > > 
> > > Fast forward to today and now we are much better about not
> > > allocating
> > > metadata chunks all of the time.  Couple this with d792b0f19711
> > > which
> > > now means we'll easily have a larger global reserve than our free
> > > space, we are now more likely to trip over this while still
> > > having plenty of space.
> > > 
> > > Fix this by skipping this logic if the global rsv's space_info is
> > > not
> > > full.  space_info->full is 0 unless we've attempted to allocate a
> > > chunk for that space_info and that has failed.  If this happens
> > > then the space for the global reserve is definitely sacred and we
> > > need to report b_avail == 0, but before then we can just use our
> > > calculated b_avail.
> > > 
> > > There are other cases where df isn't quite right, and Qu is
> > > addressing them in a more holistic way.  This simply fixes the
> > > users that are currently experiencing pain because of this
> > > problem.
> > > 
> > > Fixes: ca8a51b3a979 ("btrfs: statfs: report zero available if
> > > metadata> 
> > are exhausted")
> > 
> > > Reported-by: Martin Steigerwald <martin@lichtvoll.de>
> > > Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> > 
> > Added to 5.6 queue, thanks.


-- 
Martin


