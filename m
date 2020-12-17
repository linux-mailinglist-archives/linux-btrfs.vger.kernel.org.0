Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15F862DD3B3
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Dec 2020 16:06:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727185AbgLQPEZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 17 Dec 2020 10:04:25 -0500
Received: from mx2.suse.de ([195.135.220.15]:52404 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726983AbgLQPEY (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 17 Dec 2020 10:04:24 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 9BAD5AC7B;
        Thu, 17 Dec 2020 15:03:43 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id A0290DA83A; Thu, 17 Dec 2020 16:02:03 +0100 (CET)
Date:   Thu, 17 Dec 2020 16:02:03 +0100
From:   David Sterba <dsterba@suse.cz>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org, josef@toxicpanda.com,
        Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH 0/2] btrfs: fix races between clone, fallocate and memory
 mapped writes
Message-ID: <20201217150203.GP6430@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, fdmanana@kernel.org,
        linux-btrfs@vger.kernel.org, josef@toxicpanda.com,
        Filipe Manana <fdmanana@suse.com>
References: <cover.1607939569.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1607939569.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Dec 14, 2020 at 09:56:40AM +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> For a very long time there's been a race between clone/dedupe and memory
> mapped writes as well as between fallocate and memory mapped writes. For
> both cases the consequence of the race is that it can makes us deadlock
> when we are low on available metadata space, since clone/dedupe/fallocate
> start a transaction while holding file ranges locked, and allocating the
> metadata can result in the async reclaim task to flush the inodes being
> used by clone/dedupe/fallocate, if a memory mapped write happened before
> we locked the file ranges.
> 
> For the dedupe case, Josef's recent fix [1] ("btrfs: fix race between dedupe
> and mmap") happens to fix this deadlock problem as well. The first patch
> in this patchset fixes the issue for both clone and dedupe, as it's centered
> on the shared extent locking function, and it is independent of Josef's fix
> (works both with and without that fix).

Thanks, I was wondering how all the patches are related.
> 
> [1] https://lore.kernel.org/linux-btrfs/afdc2109f83fff1a925d7a66a6a047d4400721d4.1607724668.git.josef@toxicpanda.com/
> 
> Filipe Manana (2):
>   btrfs: fix race between cloning and memory mapped writes leading to
>     deadlock
>   btrfs: fix race between fallocate and memory mapped writes leading to
>     deadlock

Added to misc-next, thanks.
