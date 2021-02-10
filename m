Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31101317329
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Feb 2021 23:18:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232732AbhBJWSH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 10 Feb 2021 17:18:07 -0500
Received: from mx2.suse.de ([195.135.220.15]:44544 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232097AbhBJWRx (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 10 Feb 2021 17:17:53 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id B223AAC88;
        Wed, 10 Feb 2021 22:17:11 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 0DF09DA6E9; Wed, 10 Feb 2021 23:15:17 +0100 (CET)
Date:   Wed, 10 Feb 2021 23:15:17 +0100
From:   David Sterba <dsterba@suse.cz>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 0/3] btrfs: fix a couple swapfile support bugs
Message-ID: <20210210221517.GX1993@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, fdmanana@kernel.org,
        linux-btrfs@vger.kernel.org
References: <cover.1612350698.git.fdmanana@suse.com>
 <cover.1612529182.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1612529182.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Feb 05, 2021 at 12:55:35PM +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> The following patchset fixes 2 bugs with the swapfile support, where we can
> end up falling back to COW when writing to an active swapfile. The first patch
> is actually independent and just makes the nocow buffered IO path more efficient
> by eliminating a repeated check for a read-only block group.
> 
> V2: Removed the part of optimizing the direct IO nocow path from patch 2,
>     because removing the RO block group check from can_nocow_extent() would
>     leave the buffered write path that checks if we can fallback to nocow at
>     write time (and not writeback time), after hitting ENOSPC when attempting
>     to reserve data space, from doing that check. The optimization can still
>     be done, but that would require adding more context information to
>     can_nocow_extent(), so it could know when it needs to check if the block
>     group is RO or not - since things are a bit entangled around that function
>     and its callers, I've left it out for now.
> 
> Filipe Manana (3):
>   btrfs: avoid checking for RO block group twice during nocow writeback
>   btrfs: fix race between writes to swap files and scrub
>   btrfs: fix race between swap file activation and snapshot creation

Added to for-next, thanks. Target merge is 5.12-rc.
