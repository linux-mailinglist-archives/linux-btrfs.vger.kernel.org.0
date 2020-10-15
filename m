Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B63628F4C8
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Oct 2020 16:32:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388201AbgJOOcu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 15 Oct 2020 10:32:50 -0400
Received: from mx2.suse.de ([195.135.220.15]:41758 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387861AbgJOOcu (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 15 Oct 2020 10:32:50 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id CBC8DAC24;
        Thu, 15 Oct 2020 14:32:48 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 9D5A5DA7C3; Thu, 15 Oct 2020 16:31:20 +0200 (CEST)
Date:   Thu, 15 Oct 2020 16:31:20 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     David Sterba <dsterba@suse.com>, torvalds@linux-foundation.org,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] Btrfs updates for 5.10
Message-ID: <20201015143120.GO6756@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Stephen Rothwell <sfr@canb.auug.org.au>,
        David Sterba <dsterba@suse.com>, torvalds@linux-foundation.org,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1602519695.git.dsterba@suse.com>
 <20201015114011.1f5f985a@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201015114011.1f5f985a@canb.auug.org.au>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

On Thu, Oct 15, 2020 at 11:40:11AM +1100, Stephen Rothwell wrote:
> Hi David,
> On Mon, 12 Oct 2020 22:25:02 +0200 David Sterba <dsterba@suse.com> wrote:
> >
> > Mishaps:
> > 
> > - commit 62cf5391209a ("btrfs: move btrfs_rm_dev_replace_free_srcdev
> >   outside of all locks") is a rebase leftover after the patch got
> >   merged to 5.9-rc8 as a466c85edc6f ("btrfs: move
> >   btrfs_rm_dev_replace_free_srcdev outside of all locks"), the
> >   remaining part is trivial and the patch is in the middle of the
> >   series so I'm keeping it there instead of rebasing
> 
> And yet, this entire pull request has been rebased since what was in
> linux-next on Tuesday (and what would still be there today except I
> dropped it because of several conflicts) ...  it looks like it was
> rebased a week ago, but then never included in your "for-next" branch.
> So I supposed it has had your internal testing, at least.

I was on vacation last week and rebased the to-be-pulled branch on top
of v5.9-rc8 so there are at least a few days before the pull request is
sent.

The patch queue was feature frozen for 2 weeks, there should be no
surprises whether it's rc7 or rc8, but the latter contained a corruption
fix so it was desirable to rebase the development queue. Due to my
limited time I forgot to update the for-next branches, sorry. We do
enough internal testing of course.
