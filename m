Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B94F2A95E3
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Nov 2020 12:58:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726565AbgKFL6q (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 6 Nov 2020 06:58:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726317AbgKFL6q (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 6 Nov 2020 06:58:46 -0500
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CFF8C0613CF
        for <linux-btrfs@vger.kernel.org>; Fri,  6 Nov 2020 03:58:46 -0800 (PST)
Received: by mail-qt1-x844.google.com with SMTP id g17so529643qts.5
        for <linux-btrfs@vger.kernel.org>; Fri, 06 Nov 2020 03:58:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=FcDYDHJVHCWNewZJ3H/NxQgUx4O6H3JGvtZYxvZmaq8=;
        b=sB1bsvt8OLwFjLI2yKZmGIt0cwLEpBTHehC1eK9V2DW/iOPQnLs9a4PQUjoFJtIMCd
         mCYU5+o3xCWNr4aEFcrBbCvFB/ti6on9pt0o3ZSwGCGF3gp9Cbbo3UwrM+wAQqPtxexN
         qNZbClHv8vNM43OWtjGCMxU+2fEjKRu0dIYgfCltoIqRlvNe5nLMBSNQamRG78hpbxBG
         jCMMOHDEt3Isy9ixui9elRNCiT+GkYsqPrAtr6yvRiFsD/8Jkaex7vr8ChTcSAMcm8tk
         2NNNHazsmGmXR6eV3S7uLDMpEkEwWJGlAlqOzVnZR7PMgL+Eslv3XQByBOQkPSdXQCme
         F4sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=FcDYDHJVHCWNewZJ3H/NxQgUx4O6H3JGvtZYxvZmaq8=;
        b=fdVS8O1zV9BeV1nTxgPB/o2xnaQ6mfIF/mek1oTwURUaSQ7X+X8j3LwS3x0m26h1YT
         zQwUSroDkbYV9hlxyDhiXSThkSzhq+tZfY9DEFWIZc6oUjK6mxPFLiHZ+pHGwn59skLw
         V6TQlz1beSm0LYKEwJn3+gmiU6dOocLAsq9sifyfHXBm7gLY3kAKLSsvue+V1/QlAP72
         vvDxQyTukeNlTeVz9G76t5pt/gAbmbprdy55X1I2+BaoyEpKH2Y6ppzxWAjzAR+j6wc9
         RrqVM8qNDQX2l4NWGiKl+5gydyRByyxq0hsCZWgmYq7CzQTSBwjy2SCuyiS+jLLyl6cE
         GFFQ==
X-Gm-Message-State: AOAM532FF2HMGEEDnDILQi8xf7mtdo8KvNpld4NeRcr/zSTjSedQp/cB
        p6Co/IszDEquwGw2pg7Yz2I12/KBRaDi16a7sSI=
X-Google-Smtp-Source: ABdhPJxa+whI9C/J40KgBZxDRBm8s43DonHKFg6AcjtN98LIvOcPDpKGL3v7TcRaxoa/u36enhFtdkEnjHjnt/O1luQ=
X-Received: by 2002:aed:2321:: with SMTP id h30mr1011253qtc.213.1604663925478;
 Fri, 06 Nov 2020 03:58:45 -0800 (PST)
MIME-Version: 1.0
References: <cover.1604591048.git.josef@toxicpanda.com> <1cee2922a32c305056a9559ccf7aede49777beae.1604591048.git.josef@toxicpanda.com>
In-Reply-To: <1cee2922a32c305056a9559ccf7aede49777beae.1604591048.git.josef@toxicpanda.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Fri, 6 Nov 2020 11:58:34 +0000
Message-ID: <CAL3q7H7jrF3Acu0DHfShMWE_WmwAcwF5b7-ZOj4vRPZ61_pf-Q@mail.gmail.com>
Subject: Re: [PATCH 14/14] btrfs: set the lockdep class for ebs on creation
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Nov 5, 2020 at 3:47 PM Josef Bacik <josef@toxicpanda.com> wrote:
>
> Both Filipe and Fedora QA recently hit the following lockdep splat
>
> WARNING: possible recursive locking detected
> 5.10.0-0.rc1.20201028gited8780e3f2ec.57.fc34.x86_64 #1 Not tainted
> --------------------------------------------
> rsync/2610 is trying to acquire lock:
> ffff89617ed48f20 (&eb->lock){++++}-{2:2}, at: btrfs_tree_read_lock_atomic=
+0x34/0x140
>
> but task is already holding lock:
> ffff8961757b1130 (&eb->lock){++++}-{2:2}, at: btrfs_tree_read_lock_atomic=
+0x34/0x140
>
> other info that might help us debug this:
>  Possible unsafe locking scenario:
>        CPU0
>        ----
>   lock(&eb->lock);
>   lock(&eb->lock);
>
>  *** DEADLOCK ***
>  May be due to missing lock nesting notation
> 2 locks held by rsync/2610:
>  #0: ffff896107212b90 (&type->i_mutex_dir_key#10){++++}-{3:3}, at: walk_c=
omponent+0x10c/0x190
>  #1: ffff8961757b1130 (&eb->lock){++++}-{2:2}, at: btrfs_tree_read_lock_a=
tomic+0x34/0x140
>
> stack backtrace:
> CPU: 1 PID: 2610 Comm: rsync Not tainted 5.10.0-0.rc1.20201028gited8780e3=
f2ec.57.fc34.x86_64 #1
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 0.0.0 02/06/2=
015
> Call Trace:
>  dump_stack+0x8b/0xb0
>  __lock_acquire.cold+0x12d/0x2a4
>  ? kvm_sched_clock_read+0x14/0x30
>  ? sched_clock+0x5/0x10
>  lock_acquire+0xc8/0x400
>  ? btrfs_tree_read_lock_atomic+0x34/0x140
>  ? read_block_for_search.isra.0+0xdd/0x320
>  _raw_read_lock+0x3d/0xa0
>  ? btrfs_tree_read_lock_atomic+0x34/0x140
>  btrfs_tree_read_lock_atomic+0x34/0x140
>  btrfs_search_slot+0x616/0x9a0
>  btrfs_lookup_dir_item+0x6c/0xb0
>  btrfs_lookup_dentry+0xa8/0x520
>  ? lockdep_init_map_waits+0x4c/0x210
>  btrfs_lookup+0xe/0x30
>  __lookup_slow+0x10f/0x1e0
>  walk_component+0x11b/0x190
>  path_lookupat+0x72/0x1c0
>  filename_lookup+0x97/0x180
>  ? strncpy_from_user+0x96/0x1e0
>  ? getname_flags.part.0+0x45/0x1a0
>  vfs_statx+0x64/0x100
>  ? lockdep_hardirqs_on_prepare+0xff/0x180
>  ? _raw_spin_unlock_irqrestore+0x41/0x50
>  __do_sys_newlstat+0x26/0x40
>  ? lockdep_hardirqs_on_prepare+0xff/0x180
>  ? syscall_enter_from_user_mode+0x27/0x80
>  ? syscall_enter_from_user_mode+0x27/0x80
>  do_syscall_64+0x33/0x40
>  entry_SYSCALL_64_after_hwframe+0x44/0xa9
>
> I have also seen a report of lockdep complaining about the lock class
> that was looked up being the same as the lock class on the lock we were
> using, but I can't find the report.
>
> These are problems that occur because we do not have the lockdep class
> set on the extent buffer until _after_ we read the eb in properly.  This
> is problematic for concurrent readers, because we will create the extent
> buffer, lock it, and then attempt to read the extent buffer.
>
> If a second thread comes in and tries to do a search down the same path
> they'll get the above lockdep splat because the class isn't set properly
> on the extent buffer.
>
> There was a good reason for this, we generally didn't know the real
> owner of the eb until we read it, specifically in refcount'ed roots.
>
> However now all refcount'ed roots have the same class name, so we no
> longer need to worry about this.  For non-refcount'ed tree's we know
> which root we're on based on the parent.
>
> Fix this by setting the lockdep class on the eb at creation time instead
> of read time.  This will fix the splat and the weirdness where the class
> changes in the middle of locking the block.
>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Reviewed-by: Filipe Manana <fdmanana@suse.com>

I couldn't get anymore the lockdep splat I reported before (after
applying the whole patchset of course), it used to happen very often
with btrfs/033.

Looks good, thanks.

> ---
>  fs/btrfs/disk-io.c     | 3 ---
>  fs/btrfs/extent-tree.c | 8 +++++---
>  fs/btrfs/extent_io.c   | 1 +
>  fs/btrfs/volumes.c     | 1 -
>  4 files changed, 6 insertions(+), 7 deletions(-)
>
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index f14398b5d933..a90839426cfa 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -577,9 +577,6 @@ int btrfs_validate_metadata_buffer(struct btrfs_io_bi=
o *io_bio, u64 phy_offset,
>                 goto err;
>         }
>
> -       btrfs_set_buffer_lockdep_class(btrfs_header_owner(eb),
> -                                      eb, found_level);
> -
>         csum_tree_block(eb, result);
>
>         if (memcmp_extent_buffer(eb, result, 0, csum_size)) {
> diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
> index 14b6e19f6151..517c2558f973 100644
> --- a/fs/btrfs/extent-tree.c
> +++ b/fs/btrfs/extent-tree.c
> @@ -4629,6 +4629,11 @@ btrfs_init_new_buffer(struct btrfs_trans_handle *t=
rans, struct btrfs_root *root,
>                 return ERR_PTR(-EUCLEAN);
>         }
>
> +       /*
> +        * This needs to stay, because we could allocate a free'd block f=
rom an
> +        * old tree into a new tree, so we need to make sure this new blo=
ck is
> +        * set to the appropriate level and owner.
> +        */
>         btrfs_set_buffer_lockdep_class(owner, buf, level);
>         __btrfs_tree_lock(buf, nest);
>         btrfs_clean_tree_block(buf);
> @@ -5018,9 +5023,6 @@ static noinline int do_walk_down(struct btrfs_trans=
_handle *trans,
>                                                     level - 1);
>                 if (IS_ERR(next))
>                         return PTR_ERR(next);
> -
> -               btrfs_set_buffer_lockdep_class(root->root_key.objectid, n=
ext,
> -                                              level - 1);
>                 reada =3D 1;
>         }
>         btrfs_tree_lock(next);
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index a883350d5e7f..3c61981b2c7b 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -5196,6 +5196,7 @@ struct extent_buffer *alloc_extent_buffer(struct bt=
rfs_fs_info *fs_info,
>         eb =3D __alloc_extent_buffer(fs_info, start, len);
>         if (!eb)
>                 return ERR_PTR(-ENOMEM);
> +       btrfs_set_buffer_lockdep_class(owner_root, eb, level);
>
>         num_pages =3D num_extent_pages(eb);
>         for (i =3D 0; i < num_pages; i++, index++) {
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index 0ca2e96a9cda..4830c40fc400 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -6902,7 +6902,6 @@ int btrfs_read_sys_array(struct btrfs_fs_info *fs_i=
nfo)
>         if (IS_ERR(sb))
>                 return PTR_ERR(sb);
>         set_extent_buffer_uptodate(sb);
> -       btrfs_set_buffer_lockdep_class(root->root_key.objectid, sb, 0);
>         /*
>          * The sb extent buffer is artificial and just used to read the s=
ystem array.
>          * set_extent_buffer_uptodate() call does not properly mark all i=
t's
> --
> 2.26.2
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
