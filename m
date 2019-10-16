Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 83420D8F15
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Oct 2019 13:15:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392620AbfJPLP4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 16 Oct 2019 07:15:56 -0400
Received: from mx2.suse.de ([195.135.220.15]:54724 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727653AbfJPLP4 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 16 Oct 2019 07:15:56 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A9622B2D0;
        Wed, 16 Oct 2019 11:15:54 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 28ABFDA7E3; Wed, 16 Oct 2019 13:16:06 +0200 (CEST)
Date:   Wed, 16 Oct 2019 13:16:05 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 0/7] btrfs-progs: Support for BG_TREE feature
Message-ID: <20191016111605.GB2751@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20191008044936.157873-1-wqu@suse.com>
 <20191014151723.GP2751@twin.jikos.cz>
 <1d23e48d-8908-5e1c-0c56-7b6ccaef5d27@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1d23e48d-8908-5e1c-0c56-7b6ccaef5d27@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Oct 15, 2019 at 08:32:30AM +0800, Qu Wenruo wrote:
> > Have we settled the argument whether to use a new tree or key tricks for
> > the blocgroup data? I think we have not and will read the previous
> > discussions. For a feature like this I want to be sure we understand all
> > the pros and cons.
> > 
> Yep, we haven't settled on the whether creating a new tree, or
> re-organize the keys.
> 
> But as my last discussion said, I see no obvious pro using the existing
> extent tree to hold the new block group item keys, even we can pack them
> all together.

For me the obvious pro is minimum change to existing set of trees.

> And for backup roots, indeed I forgot to add this feature.
> But to me that's a minor point, not a show stopper.
>
> The most important aspect to me is, to allow real world user of super
> large fs to try this feature, to prove the usefulness of this design,
> other than my on-paper analyse.
> 
> That's why I'm pushing the patchset, even it may not pass any review.
> I just want to hold a up-to-date branch so that when some one needs, it
> can grab and try them themselves.

Ok that's fine and I can add the branch to for-next for ease of testing.
I'm working on a prototype that does it the bg item key way, it compiles
and creates almost correct filesystem, so I have to fix it before
posting. The patches are on top of your bg-tree feature so we could have
both in the same kernel for testing.
