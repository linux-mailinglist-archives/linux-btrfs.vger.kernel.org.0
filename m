Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B76122C8F40
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Nov 2020 21:32:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388523AbgK3Ubi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 30 Nov 2020 15:31:38 -0500
Received: from mx2.suse.de ([195.135.220.15]:40446 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728687AbgK3Ubi (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 30 Nov 2020 15:31:38 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id ADD2AAFAB;
        Mon, 30 Nov 2020 20:30:56 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id D1B12DA6E1; Mon, 30 Nov 2020 21:29:18 +0100 (CET)
Date:   Mon, 30 Nov 2020 21:29:18 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Boris Burkov <boris@bur.io>
Cc:     dsterba@suse.cz, linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v7 00/10] btrfs: free space tree mounting fixes
Message-ID: <20201130202918.GK6430@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Boris Burkov <boris@bur.io>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <cover.1605736355.git.boris@bur.io>
 <20201120213222.GA8669@twin.jikos.cz>
 <20201130182416.GA2017125@devbig008.ftw2.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201130182416.GA2017125@devbig008.ftw2.facebook.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Nov 30, 2020 at 10:24:16AM -0800, Boris Burkov wrote:
> On Fri, Nov 20, 2020 at 10:32:22PM +0100, David Sterba wrote:
> > On Wed, Nov 18, 2020 at 03:06:15PM -0800, Boris Burkov wrote:
> > Is this fixing a problem caused by some patches in this series? Because
> > if yes, the fix should be folded there. A standalone patch makese sense
> > in case we can't fold it there (eg. after merging to Linus' tree),
> > otherwise the merged patchsets should be made of complete patches,
> > without fixes-to-fixes. Even if the patchset is in misc-next, fixups are
> > still doable.
> 
> The new 'needs_free_space' patch (#3) fixes the bug in this series that
> you caught, so if I understand correctly, I should appropriately fold
> that one into one of the existing patches.

I'll fold it but which one, 1 is only refactoring code and 2 starting
orphan cleanup, so I think it's 2. I have run the test on each commit
with the same test steps as be fore but can't reproduce it (in a VM,
previously it was another box).

> The lockdep issue exists in misc-next as far as I can tell, so I think a
> standalone patch makes sense.

Ok.
