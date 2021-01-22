Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A94CC300CD8
	for <lists+linux-btrfs@lfdr.de>; Fri, 22 Jan 2021 20:56:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730047AbhAVTmZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 22 Jan 2021 14:42:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:39116 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729986AbhAVSnD (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 22 Jan 2021 13:43:03 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id DB9AA23AAC
        for <linux-btrfs@vger.kernel.org>; Fri, 22 Jan 2021 18:42:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611340942;
        bh=BquE8INPHxuVkYSYM+3Nj4iCCcuWqutd70U0XWvyv70=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=uP5e1FOsby/0+UBLmvlkva2nA1ITeSFWh2ToVWqFnRGlCwVtYZPkSDWRnxV82AaLw
         E1wik8Bjc42pPevr3p28kqa7D98PxK7CN5Pdqr7nftpnqazhjQMkryVH+2YBPBh69+
         msGFVIWoB+1g8ZyMRzfVJvk+nuRiGltEcTE8pJHtZ5E2ZDnjB8ZUYXa+nQ1j3Johjt
         tmGVIqWrLZLOKMBFGn5HWFUuw6lFeWUK1zMkhczE82Us9s4b1tktq9aa9YcQmWpocC
         vpq4cZB9JJxetIpU5EJpEeFLPUDLfRV2esVTfdxQn5RHdBqq7XDTnwnNHOIKpwiR+K
         PogO4OgTtqCpg==
Received: by mail-qv1-f48.google.com with SMTP id et9so3119114qvb.10
        for <linux-btrfs@vger.kernel.org>; Fri, 22 Jan 2021 10:42:21 -0800 (PST)
X-Gm-Message-State: AOAM532oAZvyaS7Z2fabxOijzwmfS0ywwa/SZbwOwxqExXcgStAkh5Px
        B4Z+yq4YT8kXE0wb+ctAC8b2vv1dBzg6aji8qls=
X-Google-Smtp-Source: ABdhPJzx117ZnjIjXy18IluN3IDa/1I9M6xVAGBUIzYKN1AWnUbPk4H4uGySB8FmJeocvU8/u7Z522Vr/VRn5nh2DJo=
X-Received: by 2002:ad4:46cd:: with SMTP id g13mr2913957qvw.27.1611340940993;
 Fri, 22 Jan 2021 10:42:20 -0800 (PST)
MIME-Version: 1.0
References: <c655306f61af9b2d75ed22053a7cdc3f21022d72.1611337435.git.fdmanana@suse.com>
 <e8333d58-c51d-f2ed-27c1-5815087550ad@toxicpanda.com>
In-Reply-To: <e8333d58-c51d-f2ed-27c1-5815087550ad@toxicpanda.com>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Fri, 22 Jan 2021 18:42:09 +0000
X-Gmail-Original-Message-ID: <CAL3q7H5K5JJXi51B1+U5qFUeccBvKLJ9aqUcUdpBGRv8BvJWVw@mail.gmail.com>
Message-ID: <CAL3q7H5K5JJXi51B1+U5qFUeccBvKLJ9aqUcUdpBGRv8BvJWVw@mail.gmail.com>
Subject: Re: [PATCH] btrfs: fix log replay failure due to race with space
 cache rebuild
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jan 22, 2021 at 6:39 PM Josef Bacik <josef@toxicpanda.com> wrote:
>
> On 1/22/21 12:56 PM, fdmanana@kernel.org wrote:
> > From: Filipe Manana <fdmanana@suse.com>
> >
> > After a sudden power failure we may end up with a space cache on disk that
> > is not valid and needs to be rebuilt from scratch.
> >
> > If that happens, during log replay when we attempt to pin an extent buffer
> > from a log tree, at btrfs_pin_extent_for_log_replay(), we do not wait for
> > the space cache to be rebuilt through the call to:
> >
> >      btrfs_cache_block_group(cache, 1);
> >
> > That is because that only waits for the task (work queue job) that loads
> > the space cache to change the cache state from BTRFS_CACHE_FAST to any
> > other value. That is ok when the space cache on disk exists and is valid,
> > but when the cache is not valid and needs to be rebuilt, it ends up
> > returning as soon as the cache state changes to BTRFS_CACHE_STARTED (done
> > at caching_thread()).
> >
> > So this means that we can end up trying to unpin a range which is not yet
> > marked as free in the block group. This results in the call to
> > btrfs_remove_free_space() to return -EINVAL to
> > btrfs_pin_extent_for_log_replay(), which in turn makes the log replay fail
> > as well as mounting the filesystem. More specifically the -EINVAL comes
> > from free_space_cache.c:remove_from_bitmap(), because the requested range
> > is not marked as free space (ones in the bitmap), we have the following
> > condition triggered:
> >
> > static noinline int remove_from_bitmap(struct btrfs_free_space_ctl *ctl,
> > (...)
> >         if (ret < 0 || search_start != *offset)
> >              return -EINVAL;
> > (...)
> >
> > It's the "search_start != *offset" that results in the condition being
> > evaluated to true.
> >
> > When this happens we got the following in dmesg/syslog:
> >
> > [72383.415114] BTRFS: device fsid 32b95b69-0ea9-496a-9f02-3f5a56dc9322 devid 1 transid 1432 /dev/sdb scanned by mount (3816007)
> > [72383.417837] BTRFS info (device sdb): disk space caching is enabled
> > [72383.418536] BTRFS info (device sdb): has skinny extents
> > [72383.423846] BTRFS info (device sdb): start tree-log replay
> > [72383.426416] BTRFS warning (device sdb): block group 30408704 has wrong amount of free space
> > [72383.427686] BTRFS warning (device sdb): failed to load free space cache for block group 30408704, rebuilding it now
> > [72383.454291] BTRFS: error (device sdb) in btrfs_recover_log_trees:6203: errno=-22 unknown (Failed to pin buffers while recovering log root tree.)
> > [72383.456725] BTRFS: error (device sdb) in btrfs_replay_log:2253: errno=-22 unknown (Failed to recover log tree)
> > [72383.460241] BTRFS error (device sdb): open_ctree failed
> >
> > We also mark the range for the extent buffer in the excluded extents io
> > tree. That is fine when the space cache is valid on disk and we can load
> > it, in which case it causes no problems.
> >
> > However, for the case where we need to rebuild the space cache, because it
> > is either invalid or it is missing, having the extent buffer range marked
> > in the excluded extents io tree leads to a -EINVAL failure from the call
> > to btrfs_remove_free_space(), resulting in the log replay and mount to
> > fail. This is because by having the range marked in the excluded extents
> > io tree, the caching thread ends up never adding the range of the extent
> > buffer as free space in the block group since the calls to
> > add_new_free_space(), called from load_extent_tree_free(), filter out any
> > ranges that are marked as excluded extents.
> >
> > So fix this by making sure that during log replay we wait for the caching
> > task to finish completely when we need to rebuild a space cache, and also
> > drop the need to mark the extent buffer range in the excluded extents io
> > tree, as well as clearing ranges from that tree at
> > btrfs_finish_extent_commit().
> >
> > This started to happen with some frequency on large filesystems having
> > block groups with a lot of fragmentation since the recent commit
> > e747853cae3ae3 ("btrfs: load free space cache asynchronously"), but in
> > fact the issue has been there for years, it was just much less likely
> > to happen.
> >
> > Signed-off-by: Filipe Manana <fdmanana@suse.com>
> > ---
> >   fs/btrfs/extent-tree.c | 27 ++++++++++++++++++---------
> >   1 file changed, 18 insertions(+), 9 deletions(-)
> >
> > diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
> > index 30b1a630dc2f..89d1b0551cf8 100644
> > --- a/fs/btrfs/extent-tree.c
> > +++ b/fs/btrfs/extent-tree.c
> > @@ -2602,8 +2602,6 @@ int btrfs_pin_extent_for_log_replay(struct btrfs_trans_handle *trans,
> >       struct btrfs_block_group *cache;
> >       int ret;
> >
> > -     btrfs_add_excluded_extent(trans->fs_info, bytenr, num_bytes);
> > -
> >       cache = btrfs_lookup_block_group(trans->fs_info, bytenr);
> >       if (!cache)
> >               return -EINVAL;
> > @@ -2615,6 +2613,15 @@ int btrfs_pin_extent_for_log_replay(struct btrfs_trans_handle *trans,
> >        * the pinned extents.
> >        */
> >       btrfs_cache_block_group(cache, 1);
> > +     /*
> > +      * Make sure we wait until the cache is completely built in case it is
> > +      * missing or is invalid and therefore needs to be rebuilt.
> > +      */
> > +     if (btrfs_test_opt(trans->fs_info, SPACE_CACHE)) {
> > +             ret = btrfs_wait_block_group_cache_done(cache);
> > +             if (ret)
> > +                     return ret;
> > +     }
>
> Sorry I didn't explain this well in my previous reply and on slack.
>
> If we are going to keep the btrfs_remove_free_space() below, which we have to,
> we cannot remove the btrfs_add_excluded_extent() without also unconditionally
> loading the space cache.  The 'load_cache_only' only means we'll wait for the
> space cache to be loaded in the SPACE_CACHE case, not that we won't start caching.
>
> Consider the free space tree case, we'll be doing the normal caching, and we'll
> either hit the case that you're trying to fix, because we attempt to remove a
> free space range that has been partially cached in the bitmap.  Or we'll hit the
> case where we think we've removed the free space even though it's not been
> loaded yet.
>
> Your fix needs to remove the excluded extent parts as well as do
>
> btrfs_cache_block_group(cache, 0);
> btrfs_wait_block_group_cache_done(cache);
>
> in order to be properly safe in all cases.  Thanks,

Yes, I realized that later, I have a new version being tested right now:

https://pastebin.com/pgQ2y11a

I messed and didn't realize the wait is necessary even if there is no
space cache or tree enabled.

>
> Josef
