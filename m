Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F1C124253A
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Aug 2020 08:15:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726607AbgHLGPv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 12 Aug 2020 02:15:51 -0400
Received: from mx2.suse.de ([195.135.220.15]:54390 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725944AbgHLGPu (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 12 Aug 2020 02:15:50 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 40E05AC12;
        Wed, 12 Aug 2020 06:16:10 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id EE7E3DA81B; Wed, 12 Aug 2020 08:14:46 +0200 (CEST)
Date:   Wed, 12 Aug 2020 08:14:46 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Filipe Manana <fdmanana@gmail.com>
Cc:     Qu Wenruo <wqu@suse.com>, Nikolay Borisov <nborisov@suse.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH v4] btrfs: trim: fix underflow in trim length to prevent
 access beyond device boundary
Message-ID: <20200812061446.GU2026@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Filipe Manana <fdmanana@gmail.com>,
        Qu Wenruo <wqu@suse.com>, Nikolay Borisov <nborisov@suse.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        Filipe Manana <fdmanana@suse.com>
References: <20200731112911.115665-1-wqu@suse.com>
 <5cda2c95-e407-8b11-e206-20c4aac5d48b@suse.com>
 <269982fa-0174-5816-3a23-37912737abc9@suse.com>
 <CAL3q7H7pKrurKVafXQ3+AsHtkWGEKdGa9NiyO_HBUy1MyzJFEw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL3q7H7pKrurKVafXQ3+AsHtkWGEKdGa9NiyO_HBUy1MyzJFEw@mail.gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Aug 11, 2020 at 11:24:29AM +0100, Filipe Manana wrote:
> On Tue, Aug 11, 2020 at 9:48 AM Qu Wenruo <wqu@suse.com> wrote:
> >
> >
> >
> > On 2020/8/11 下午4:41, Nikolay Borisov wrote:
> > >
> > >
> > > On 31.07.20 г. 14:29 ч., Qu Wenruo wrote:
> > >> [BUG]
> > >> The following script can lead to tons of beyond device boundary access:
> > >>
> > >>   mkfs.btrfs -f $dev -b 10G
> > >>   mount $dev $mnt
> > >>   trimfs $mnt
> > >>   btrfs filesystem resize 1:-1G $mnt
> > >>   trimfs $mnt
> > >>
> > >> [CAUSE]
> > >> Since commit 929be17a9b49 ("btrfs: Switch btrfs_trim_free_extents to
> > >> find_first_clear_extent_bit"), we try to avoid trimming ranges that's
> > >> already trimmed.
> > >>
> > >> So we check device->alloc_state by finding the first range which doesn't
> > >> have CHUNK_TRIMMED and CHUNK_ALLOCATED not set.
> > >>
> > >> But if we shrunk the device, that bits are not cleared, thus we could
> > >> easily got a range starts beyond the shrunk device size.
> > >>
> > >> This results the returned @start and @end are all beyond device size,
> > >> then we call "end = min(end, device->total_bytes -1);" making @end
> > >> smaller than device size.
> > >>
> > >> Then finally we goes "len = end - start + 1", totally underflow the
> > >> result, and lead to the beyond-device-boundary access.
> > >>
> > >> [FIX]
> > >> This patch will fix the problem in two ways:
> > >> - Clear CHUNK_TRIMMED | CHUNK_ALLOCATED bits when shrinking device
> > >>   This is the root fix
> > >>
> > >> - Add extra safe net when trimming free device extents
> > >>   We check and warn if the returned range is already beyond current
> > >>   device.
> > >>
> > >> Link: https://github.com/kdave/btrfs-progs/issues/282
> > >> Fixes: 929be17a9b49 ("btrfs: Switch btrfs_trim_free_extents to find_first_clear_extent_bit")
> > >> Signed-off-by: Qu Wenruo <wqu@suse.com>
> > >> Reviewed-by: Filipe Manana <fdmanana@suse.com>
> > >> ---
> > >> Changelog:
> > >> v2:
> > >> - Add proper fixes tag
> > >> - Add extra warning for beyond device end case
> > >> - Add graceful exit for already trimmed case
> > >> v3:
> > >> - Don't return EUCLEAN for beyond boundary access
> > >> - Rephrase the warning message for beyond boundary access
> > >> v4:
> > >> - Remove one duplicated check on exiting the trim loop
> > >> ---
> > >>  fs/btrfs/extent-tree.c | 14 ++++++++++++++
> > >>  fs/btrfs/volumes.c     | 12 ++++++++++++
> > >>  2 files changed, 26 insertions(+)
> > >>
> > >> diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
> > >> index fa7d83051587..6b1b5dfba4b3 100644
> > >> --- a/fs/btrfs/extent-tree.c
> > >> +++ b/fs/btrfs/extent-tree.c
> > >> @@ -33,6 +33,7 @@
> > >>  #include "delalloc-space.h"
> > >>  #include "block-group.h"
> > >>  #include "discard.h"
> > >> +#include "rcu-string.h"
> > >>
> > >>  #undef SCRAMBLE_DELAYED_REFS
> > >>
> > >> @@ -5669,6 +5670,19 @@ static int btrfs_trim_free_extents(struct btrfs_device *device, u64 *trimmed)
> > >>                                          &start, &end,
> > >>                                          CHUNK_TRIMMED | CHUNK_ALLOCATED);
> > >>
> > >> +            /* CHUNK_* bits not cleared properly */
> > >> +            if (start > device->total_bytes) {
> > >> +                    WARN_ON(IS_ENABLED(CONFIG_BTRFS_DEBUG));
> > >> +                    btrfs_warn_in_rcu(fs_info,
> > >> +"ignoring attempt to trim beyond device size: offset %llu length %llu device %s device size %llu",
> > >> +                                      start, end - start + 1,
> > >> +                                      rcu_str_deref(device->name),
> > >> +                                      device->total_bytes);
> > >> +                    mutex_unlock(&fs_info->chunk_mutex);
> > >> +                    ret = 0;
> > >> +                    break;
> > >> +            }
> > >
> > > Isn't this a NOOP, because the latter chunk ensures we can never cross
> > > device->total_bytes. Since this is a purely defensive mechanism and
> > > following this patch we *should* never have CHUNK_* bits set beyond
> > > device->total_bytes I'd say make this an ASSERT(). Otherwise you force
> > > people to pay the cost of the check for every trim ...
> >
> > I'm fine with the ASSERT() idea.
> >
> > But on the other hand, we really don't know how things can go wrong, and
> > such graceful exit makes us way easier to expose and fix bugs when it
> > happens in a production system.
> >
> > So currently I'm 50-50 on change it to ASSERT().
> 
> Typical non-debug kernels provided by at least some distros (looking
> at debian) don't have btrfs asserts enabled by default.
> So such a type of bug can lead to losing any data a user might have
> stored beyond the new size boundary.
> And if they are enabled, it results in a crash / BUG_ON(). So I'm
> strongly for the warning and skipping trim requests beyond the fs
> size.

I agree, the check should be a always enabled and just warn.
