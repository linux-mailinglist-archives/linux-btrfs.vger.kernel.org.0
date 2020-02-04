Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8C2B7151829
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 Feb 2020 10:48:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726329AbgBDJsp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 4 Feb 2020 04:48:45 -0500
Received: from mx2.suse.de ([195.135.220.15]:41378 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726151AbgBDJsp (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 4 Feb 2020 04:48:45 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id E53A6AD76;
        Tue,  4 Feb 2020 09:48:41 +0000 (UTC)
Subject: Re: [PATCH 00/24][v3] Convert data reservations to the ticketing
 infrastructure
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <20200203204951.517751-1-josef@toxicpanda.com>
From:   Nikolay Borisov <nborisov@suse.com>
Autocrypt: addr=nborisov@suse.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <8dee9e37-4d3f-9a1d-01e0-e7ef367ae5f7@suse.com>
Date:   Tue, 4 Feb 2020 11:48:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200203204951.517751-1-josef@toxicpanda.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 3.02.20 г. 22:49 ч., Josef Bacik wrote:
> v2->v3:
> - added a comment patch for the flushing states for data.
> - I forgot to add cancel_work_sync() for the new async data flusher thread.
> - Cleaned up a few of Nikolay's nits.
> 
> v1->v2:
> - dropped the RFC
> - realized that I mis-translated the transaction commit logic from the old way
>   to the new way, so I've reworked a bunch of patches to clearly pull that
>   behavior into the generic flushing code.  I've then cleaned it up later to
>   make it easy to bisect down to behavior changes.
> - Cleaned up the priority flushing, there's no need for an explicit state array.
> - Removed the CHUNK_FORCE_ALLOC from the normal flushing as well, simply keep
>   the logic of allocating chunks until we've made our reservation or we are
>   full, then fall back on the normal flushing mechanism.
> 
> -------------- Original email --------------
> Nikolay reported a problem where we'd occasionally fail generic/371.  This test
> has two tasks running in a loop, one that fallocate and rm's, and one that
> pwrite's and rm's.  There is enough space for both of these files to exist at
> one time, but sometimes the pwrite would fail.
> 
> It would fail because we do not serialize data reseravtions.  If one task is
> stuck doing the reclaim work, and another task comes in and steals it's
> reservation enough times, we'll give up and return ENOSPC.  We validated this by
> adding a printk to the data reservation path to tell us that it was succeeding
> at making a reservation while another task was flushing.
> 
> To solve this problem I've converted data reservations over to the ticketing
> system that metadata uses.  There are some cleanups and some fixes that have to
> come before we could do that.  The following are simply cleanups
> 
>   [PATCH 01/20] btrfs: change nr to u64 in btrfs_start_delalloc_roots
>   [PATCH 02/20] btrfs: remove orig from shrink_delalloc
>   [PATCH 03/20] btrfs: handle U64_MAX for shrink_delalloc
> 
> The following are fixes that are needed to handle data space infos properly.
> 
>   [PATCH 04/20] btrfs: make shrink_delalloc take space_info as an arg
>   [PATCH 05/20] btrfs: make ALLOC_CHUNK use the space info flags
>   [PATCH 06/20] btrfs: call btrfs_try_granting_tickets when freeing
>   [PATCH 07/20] btrfs: call btrfs_try_granting_tickets when unpinning
>   [PATCH 08/20] btrfs: call btrfs_try_granting_tickets when reserving
>   [PATCH 09/20] btrfs: use the btrfs_space_info_free_bytes_may_use
> 
> I then converted the data reservation path over to the ticketing infrastructure,
> but I did it in a way that mirrored exactly what we currently have.  The idea is
> that I want to be able to bisect regressions that happen from behavior change,
> and doing that would be hard if I just had a single patch doing the whole
> conversion at once.  So the following patches are only moving code around
> logically, but preserve the same behavior as before
> 
>   [PATCH 10/20] btrfs: add flushing states for handling data
>   [PATCH 11/20] btrfs: add btrfs_reserve_data_bytes and use it
>   [PATCH 12/20] btrfs: use ticketing for data space reservations
> 
> And then the following patches were changing the behavior of how we flush space
> for data reservations.
> 
>   [PATCH 13/20] btrfs: run delayed iputs before committing the
>   [PATCH 14/20] btrfs: flush delayed refs when trying to reserve data
>   [PATCH 15/20] btrfs: serialize data reservations if we are flushing
>   [PATCH 16/20] btrfs: rework chunk allocate for data reservations
>   [PATCH 17/20] btrfs: drop the commit_cycles stuff for data
> 
> And then a cleanup now that the data reservation code is the same as the
> metadata reservation code.
> 
>   [PATCH 18/20] btrfs: use the same helper for data and metadata
> 
> Finally a patch to change the flushing from direct to asynchronous, mirroring
> what we do for metadata for better latency.
> 
>   [PATCH 19/20] btrfs: do async reclaim for data reservations
> 
> And then a final cleanup now that we're where we want to be with the data
> reservation path.
> 
>   [PATCH 20/20] btrfs: kill the priority_reclaim_space helper
> 
> I've marked this as an RFC because I've only tested this with generic/371.  I'm
> starting my overnight runs of xfstests now and will likely find regressions, but
> I'd like to get review started so this can get merged ASAP.  Thanks,
> 
> Josef
> 
> 

For the whole series:

Tested-by: Nikolay Borisov <nborisov@suse.com>

There are no regressions in xfstest, fixes generic/371 and also the
tests that exhibited performance problems in v1 are now fixed (as of v2).
