Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BC71D9B005
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 Aug 2019 14:56:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389665AbfHWMzM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 23 Aug 2019 08:55:12 -0400
Received: from mx2.suse.de ([195.135.220.15]:46846 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727894AbfHWMzM (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 23 Aug 2019 08:55:12 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 2CA30AD72;
        Fri, 23 Aug 2019 12:55:11 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 699B0DA796; Fri, 23 Aug 2019 14:55:35 +0200 (CEST)
Date:   Fri, 23 Aug 2019 14:55:33 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     kernel-team@fb.com, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/9][v3] Rework reserve ticket handling
Message-ID: <20190823125532.GO2752@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        kernel-team@fb.com, linux-btrfs@vger.kernel.org
References: <20190822191102.13732-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190822191102.13732-1-josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Aug 22, 2019 at 03:10:53PM -0400, Josef Bacik wrote:
> This is the next round of my reserve ticket refinements.  Most of the changes
> are just fixing issues brought up by review.  The updated diffstat is as follows
> 
>  fs/btrfs/block-group.c    |   5 +-
>  fs/btrfs/block-rsv.c      |  10 +--
>  fs/btrfs/delalloc-space.c |   4 --
>  fs/btrfs/delayed-ref.c    |   2 +-
>  fs/btrfs/extent-tree.c    |  13 +---
>  fs/btrfs/space-info.c     | 171 +++++++++++++++++++---------------------------
>  fs/btrfs/space-info.h     |  30 +++++---
>  7 files changed, 98 insertions(+), 137 deletions(-)

I'll add the series to for-next as topic branch, the comments seem to be
more in the changelog or function names, that I'll updated and fold to
the patches (no need to resend the whole patchset).

We're running out of time before the merge window freeze, so the enospc
updates are probably the last big thing going in, I'll continue with the
remaining patchsets and will try to push them in for-next today.
