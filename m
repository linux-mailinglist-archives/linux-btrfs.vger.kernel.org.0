Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF6E5300AB2
	for <lists+linux-btrfs@lfdr.de>; Fri, 22 Jan 2021 19:11:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729858AbhAVSAN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 22 Jan 2021 13:00:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:54184 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730009AbhAVRzk (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 22 Jan 2021 12:55:40 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 152D423A6A
        for <linux-btrfs@vger.kernel.org>; Fri, 22 Jan 2021 17:54:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611338095;
        bh=XtnbyBVcWzxBZzZwI59bCwj9mDFOLv9Gyi7d/3xtQes=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Qrs29xgVq041IdFMNOzMaaRTppFj9qu/VR9juwMlFEYIeuMJ69zL08PWU9CAOTbOz
         r5zxLGLo87SmiRgsnnMdqsvtQYitKvnnd3t8Keaxxzx5j1zwKbjoxdaWbY+UnoaedI
         YPS2TgvgaAgL3STtvlrMR8/OR0u8xkrzrCJZyhmbv/s4cAO9IEUVx+iWthlwmvYjlU
         4CH4DG/MOp1PX4A5SvqYuvENCy5xZKAunACjfKS+Pl7MQHHuW0Xb1R+br03v0cjjGi
         sGjp52siLcmnX44f+u+tYw9WfCLpJ0lTQpFgqETUHxk8ZfBi8b30S7DESMbF/CTGsQ
         HylyW3ZBJX84g==
Received: by mail-qv1-f47.google.com with SMTP id et9so3039749qvb.10
        for <linux-btrfs@vger.kernel.org>; Fri, 22 Jan 2021 09:54:55 -0800 (PST)
X-Gm-Message-State: AOAM531QKKHap92v/RZJu7CzfKeN7JV2FbRuH4QB5bK2TMSCxzAClG08
        I1OmXz07APbSdYllsp6FQqYlfHs480/kdyw0fwU=
X-Google-Smtp-Source: ABdhPJykbYQojxK4X5KgC0rHpxJwhuvtVDgdP+0oTpg7s2BAIrUrep30knbYxTHMPPnvuDiqIjelUvqRypFT/87EU3k=
X-Received: by 2002:a05:6214:10e7:: with SMTP id q7mr551865qvt.28.1611338094196;
 Fri, 22 Jan 2021 09:54:54 -0800 (PST)
MIME-Version: 1.0
References: <cover.1611327201.git.fdmanana@suse.com> <d20f67adb1ab345a9af9e0262e1aba0772832751.1611327201.git.fdmanana@suse.com>
 <89cf3d62-7544-9c7a-7c5a-145d4252389c@toxicpanda.com>
In-Reply-To: <89cf3d62-7544-9c7a-7c5a-145d4252389c@toxicpanda.com>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Fri, 22 Jan 2021 17:54:42 +0000
X-Gmail-Original-Message-ID: <CAL3q7H4hhCmxzg4xSS=0VhngiydYVR-+OD+Z6gu06UcPYzy-Yw@mail.gmail.com>
Message-ID: <CAL3q7H4hhCmxzg4xSS=0VhngiydYVR-+OD+Z6gu06UcPYzy-Yw@mail.gmail.com>
Subject: Re: [PATCH 1/2] btrfs: fix log replay failure due to race with space
 cache rebuild
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jan 22, 2021 at 4:43 PM Josef Bacik <josef@toxicpanda.com> wrote:
>
> On 1/22/21 10:28 AM, fdmanana@kernel.org wrote:
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
> > as well as mounting the filesystem. When this happens we got the following
> > in dmesg/syslog:
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
> > So fix this by making sure that during log replay we wait for the caching
> > task to finish completely when we need to rebuild a space cache.
> >
> > Fixes: e747853cae3ae3 ("btrfs: load free space cache asynchronously")
> > Signed-off-by: Filipe Manana <fdmanana@suse.com>
>
> This could actually happen before, it was just less likely because we'd start
> the async thread from the callers context.

Yes, I missed that initially, as discussed on slack in the meanwhile.

> I assume we're getting the -EINVAL
> from the remove_from_bitmap() function?

Correct, I'll add more details on the next version (new patch actually).

>  So we've loaded part of the free space
> but not all of it, and thus get the -EINVAL.  This probably needs the earlier
> Fixes, all the async patch did was make it easier to hit.
>
> <snip>
>
> > diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
> > index 30b1a630dc2f..594534482ad3 100644
> > --- a/fs/btrfs/extent-tree.c
> > +++ b/fs/btrfs/extent-tree.c
> > @@ -2600,6 +2600,7 @@ int btrfs_pin_extent_for_log_replay(struct btrfs_trans_handle *trans,
> >                                   u64 bytenr, u64 num_bytes)
> >   {
> >       struct btrfs_block_group *cache;
> > +     struct btrfs_caching_control *caching_ctl;
> >       int ret;
> >
> >       btrfs_add_excluded_extent(trans->fs_info, bytenr, num_bytes);
> > @@ -2615,6 +2616,13 @@ int btrfs_pin_extent_for_log_replay(struct btrfs_trans_handle *trans,
> >        * the pinned extents.
> >        */
> >       btrfs_cache_block_group(cache, 1);
>
> Instead we could probably just do
>
> if (btrfs_test_opt(fs_info, SPACE_CACHE)) {
>         btrfs_cache_block_group(cache, 0);
>         btrfs_wait_block_group_cache_done(cache);
> }
>
> here instead of changing all of the function arguments and such.  Thanks,

Yes, in fact I was leaking the refcount on the caching_ctl as well.
btrfs_cache_block_group(cache, 1) needs to be called always, it's
needed for the free space tree as well.

Thanks, just sent another version that combines both patches into one.

>
> Josef
