Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AAE4BA0931
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Aug 2019 20:02:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726658AbfH1SC2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 28 Aug 2019 14:02:28 -0400
Received: from mx2.suse.de ([195.135.220.15]:52488 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726592AbfH1SC1 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 28 Aug 2019 14:02:27 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C894DAF57;
        Wed, 28 Aug 2019 18:02:26 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 13EABDA809; Wed, 28 Aug 2019 20:02:48 +0200 (CEST)
Date:   Wed, 28 Aug 2019 20:02:48 +0200
From:   David Sterba <dsterba@suse.cz>
To:     dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        kernel-team@fb.com, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/9][v3] Rework reserve ticket handling
Message-ID: <20190828180247.GG2752@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        kernel-team@fb.com, linux-btrfs@vger.kernel.org
References: <20190822191102.13732-1-josef@toxicpanda.com>
 <20190823125532.GO2752@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190823125532.GO2752@twin.jikos.cz>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Aug 23, 2019 at 02:55:33PM +0200, David Sterba wrote:
> On Thu, Aug 22, 2019 at 03:10:53PM -0400, Josef Bacik wrote:
> > This is the next round of my reserve ticket refinements.  Most of the changes
> > are just fixing issues brought up by review.  The updated diffstat is as follows
> > 
> >  fs/btrfs/block-group.c    |   5 +-
> >  fs/btrfs/block-rsv.c      |  10 +--
> >  fs/btrfs/delalloc-space.c |   4 --
> >  fs/btrfs/delayed-ref.c    |   2 +-
> >  fs/btrfs/extent-tree.c    |  13 +---
> >  fs/btrfs/space-info.c     | 171 +++++++++++++++++++---------------------------
> >  fs/btrfs/space-info.h     |  30 +++++---
> >  7 files changed, 98 insertions(+), 137 deletions(-)
> 
> I'll add the series to for-next as topic branch, the comments seem to be
> more in the changelog or function names, that I'll updated and fold to
> the patches (no need to resend the whole patchset).

Updated and pushed to misc-next.
