Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AC9A28A141
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Aug 2019 16:36:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726704AbfHLOgu convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Mon, 12 Aug 2019 10:36:50 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:42557 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726480AbfHLOgu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 12 Aug 2019 10:36:50 -0400
Received: by mail-lj1-f194.google.com with SMTP id 15so6741103ljr.9
        for <linux-btrfs@vger.kernel.org>; Mon, 12 Aug 2019 07:36:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=elzwEYnE0FshUcAicer9wfnk6Uo3LVK+R6TClwJtehU=;
        b=myO8Go67WGBpFaN39zQ2VyafRr4fXtHeRJaw4m22U9Gb9sArhcKF+l06ckQff0dGkv
         tm9rRK6gBCTC4gEzQABrr3ndpvWVWVGyeyq5pP/6NNz/i3KRke9yIyZWUKz6G/vkxLhX
         jKvKtyG20idvEnWuCbCX0gyExSbgy2b3QvzUAza9TVLSY5sL8aMNH8m2UgTyHGT4Pf2m
         Zm48i0GOUv5WhhngnKth21nPy1CqrkVMeiZIgiL4Vv8XMXHL1dh9i665GGxpJBa5vkJe
         DvqJpKyPwqGikIPQ1N2rDljlvShWiAiiS+z5SU0IbFz1fq64bpKP2slVyzJyAkdH5j8U
         qRjg==
X-Gm-Message-State: APjAAAWhYXBQJxMQNxoFnAE2/XWNM3YDV6xN8+lYmOr1w9ia2Bq2o8Rd
        dBTnvYv0KbfMhl4OVM2YvDiAI5rzFM5iUw==
X-Google-Smtp-Source: APXvYqyKBdNdJ4F3CJw42vHukxxvbm5SuYbaeKrUoTB8pzj3BmeqZ4UhRWinGx2tjCl+EdO1sJBicQ==
X-Received: by 2002:a2e:900c:: with SMTP id h12mr18629283ljg.197.1565620607740;
        Mon, 12 Aug 2019 07:36:47 -0700 (PDT)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com. [209.85.167.49])
        by smtp.gmail.com with ESMTPSA id b21sm5009803lff.11.2019.08.12.07.36.47
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Aug 2019 07:36:47 -0700 (PDT)
Received: by mail-lf1-f49.google.com with SMTP id c9so74332724lfh.4
        for <linux-btrfs@vger.kernel.org>; Mon, 12 Aug 2019 07:36:47 -0700 (PDT)
X-Received: by 2002:ac2:5c4f:: with SMTP id s15mr21517612lfp.74.1565620607455;
 Mon, 12 Aug 2019 07:36:47 -0700 (PDT)
MIME-Version: 1.0
References: <20190810124101.15440-1-git@thecybershadow.net>
 <20190810124101.15440-2-git@thecybershadow.net> <ebdcf4f9-dd5e-b4ec-4a5b-ccda52c825d4@suse.com>
In-Reply-To: <ebdcf4f9-dd5e-b4ec-4a5b-ccda52c825d4@suse.com>
From:   Vladimir Panteleev <git@thecybershadow.net>
Date:   Mon, 12 Aug 2019 14:36:31 +0000
X-Gmail-Original-Message-ID: <CAHhfkvx=aTAYoKLyE0RP8Eag9WbCBJ0Q3tdVAfZ1YNp=+HW3RQ@mail.gmail.com>
Message-ID: <CAHhfkvx=aTAYoKLyE0RP8Eag9WbCBJ0Q3tdVAfZ1YNp=+HW3RQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] btrfs: Add global_reserve_size mount option
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi Nikolay,

Thank you for looking at my patch!

You are completely correct in that this pampers over a bug I do not
understand. And, I would very much like to understand and fix the
underlying bug instead of settling for a workaround.

Unfortunately, after three days of looking at BTRFS code (and getting
to where I am now), I have realized that, as a developer with no
experience in filesystems or kernel development, it would take me a
lot more, possibly several weeks, to reach a level of understanding of
BTRFS to the point where I could contribute a meaningful fix. This is
not something I would be opposed to, as I have the time and I've
personally invested into BTRFS, but it certainly would be a lot easier
if I could at least get occasional confirmation that my findings and
understanding so far are correct and that I am on the right track.
Unfortunately the people in a position to do this seem to be too busy
with far more important issues than helping debug my particular edge
case, and the previous thread has not received any replies since my
last few posts there, so this patch is the least I could contribute so
far.

FWIW #1: My current best guess at why the problem occurs, using my
current level of understanding of BTRFS, is that the filesystem in
question (16TB of historical snapshots) has so many subvolumes and
fragmentation that balance or device delete operations allocate so
much metadata space while processing the chunk (by allocating new
blocks for splitting filled metadata tree nodes) that the global
reserve is overrun. Corrections or advice on how to verify this theory
would be appreciated! (Or perhaps I should just use my patch to fix my
filesystem and move on with my life. Would be good to know when I can
wipe the disks containing the test case FS which reproduces the bug
and use them for something else.)

FWIW #2: I noticed that Josef Bacik proposed a change back in 2013 to
increase the global reserve size to 1G. The comments on the patch was
the reason I proposed to make it configurable rather than raising the
size again: https://patchwork.kernel.org/patch/2517071/

Thanks!

On Mon, 12 Aug 2019 at 08:37, Nikolay Borisov <nborisov@suse.com> wrote:
>
>
>
> On 10.08.19 г. 15:41 ч., Vladimir Panteleev wrote:
> > In some circumstances (filesystems with many extents and backrefs),
> > the global reserve gets overrun causing balance and device deletion
> > operations to fail with -ENOSPC. Providing a way for users to increase
> > the global reserve size can allow them to complete the operation.
> >
> > Signed-off-by: Vladimir Panteleev <git@thecybershadow.net>
>
> I'm inclined to NAK this patch. On the basis that it pampers over
> deficiencies in the current ENOSPC handling algorithms. Furthermore in
> your cover letter you state that you don't completely understand the
> root cause. So at the very best this is pampering over a bug.
>
> > ---
> >  fs/btrfs/block-rsv.c |  2 +-
> >  fs/btrfs/ctree.h     |  3 +++
> >  fs/btrfs/disk-io.c   |  1 +
> >  fs/btrfs/super.c     | 17 ++++++++++++++++-
> >  4 files changed, 21 insertions(+), 2 deletions(-)
> >
> > diff --git a/fs/btrfs/block-rsv.c b/fs/btrfs/block-rsv.c
> > index 698470b9f32d..5e5f5521de0e 100644
> > --- a/fs/btrfs/block-rsv.c
> > +++ b/fs/btrfs/block-rsv.c
> > @@ -272,7 +272,7 @@ void btrfs_update_global_block_rsv(struct btrfs_fs_info *fs_info)
> >       spin_lock(&sinfo->lock);
> >       spin_lock(&block_rsv->lock);
> >
> > -     block_rsv->size = min_t(u64, num_bytes, SZ_512M);
> > +     block_rsv->size = min_t(u64, num_bytes, fs_info->global_reserve_size);
> >
> >       if (block_rsv->reserved < block_rsv->size) {
> >               num_bytes = btrfs_space_info_used(sinfo, true);
> > diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> > index 299e11e6c554..d975d4f5723c 100644
> > --- a/fs/btrfs/ctree.h
> > +++ b/fs/btrfs/ctree.h
> > @@ -775,6 +775,8 @@ struct btrfs_fs_info {
> >        */
> >       u64 max_inline;
> >
> > +     u64 global_reserve_size;
> > +
> >       struct btrfs_transaction *running_transaction;
> >       wait_queue_head_t transaction_throttle;
> >       wait_queue_head_t transaction_wait;
> > @@ -1359,6 +1361,7 @@ static inline u32 BTRFS_MAX_XATTR_SIZE(const struct btrfs_fs_info *info)
> >
> >  #define BTRFS_DEFAULT_COMMIT_INTERVAL        (30)
> >  #define BTRFS_DEFAULT_MAX_INLINE     (2048)
> > +#define BTRFS_DEFAULT_GLOBAL_RESERVE_SIZE (SZ_512M)
> >
> >  #define btrfs_clear_opt(o, opt)              ((o) &= ~BTRFS_MOUNT_##opt)
> >  #define btrfs_set_opt(o, opt)                ((o) |= BTRFS_MOUNT_##opt)
> > diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> > index 5f7ee70b3d1a..06f835a44b8a 100644
> > --- a/fs/btrfs/disk-io.c
> > +++ b/fs/btrfs/disk-io.c
> > @@ -2723,6 +2723,7 @@ int open_ctree(struct super_block *sb,
> >       atomic64_set(&fs_info->tree_mod_seq, 0);
> >       fs_info->sb = sb;
> >       fs_info->max_inline = BTRFS_DEFAULT_MAX_INLINE;
> > +     fs_info->global_reserve_size = BTRFS_DEFAULT_GLOBAL_RESERVE_SIZE;
> >       fs_info->metadata_ratio = 0;
> >       fs_info->defrag_inodes = RB_ROOT;
> >       atomic64_set(&fs_info->free_chunk_space, 0);
> > diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
> > index 78de9d5d80c6..f44223a44cb8 100644
> > --- a/fs/btrfs/super.c
> > +++ b/fs/btrfs/super.c
> > @@ -327,6 +327,7 @@ enum {
> >       Opt_treelog, Opt_notreelog,
> >       Opt_usebackuproot,
> >       Opt_user_subvol_rm_allowed,
> > +     Opt_global_reserve_size,
> >
> >       /* Deprecated options */
> >       Opt_alloc_start,
> > @@ -394,6 +395,7 @@ static const match_table_t tokens = {
> >       {Opt_notreelog, "notreelog"},
> >       {Opt_usebackuproot, "usebackuproot"},
> >       {Opt_user_subvol_rm_allowed, "user_subvol_rm_allowed"},
> > +     {Opt_global_reserve_size, "global_reserve_size=%s"},
> >
> >       /* Deprecated options */
> >       {Opt_alloc_start, "alloc_start=%s"},
> > @@ -426,7 +428,7 @@ int btrfs_parse_options(struct btrfs_fs_info *info, char *options,
> >                       unsigned long new_flags)
> >  {
> >       substring_t args[MAX_OPT_ARGS];
> > -     char *p, *num;
> > +     char *p, *num, *retptr;
> >       u64 cache_gen;
> >       int intarg;
> >       int ret = 0;
> > @@ -746,6 +748,15 @@ int btrfs_parse_options(struct btrfs_fs_info *info, char *options,
> >               case Opt_user_subvol_rm_allowed:
> >                       btrfs_set_opt(info->mount_opt, USER_SUBVOL_RM_ALLOWED);
> >                       break;
> > +             case Opt_global_reserve_size:
> > +                     info->global_reserve_size = memparse(args[0].from, &retptr);
> > +                     if (retptr != args[0].to || info->global_reserve_size == 0) {
> > +                             ret = -EINVAL;
> > +                             goto out;
> > +                     }
> > +                     btrfs_info(info, "global_reserve_size at %llu",
> > +                                info->global_reserve_size);
> > +                     break;
> >               case Opt_enospc_debug:
> >                       btrfs_set_opt(info->mount_opt, ENOSPC_DEBUG);
> >                       break;
> > @@ -1336,6 +1347,8 @@ static int btrfs_show_options(struct seq_file *seq, struct dentry *dentry)
> >               seq_puts(seq, ",clear_cache");
> >       if (btrfs_test_opt(info, USER_SUBVOL_RM_ALLOWED))
> >               seq_puts(seq, ",user_subvol_rm_allowed");
> > +     if (info->global_reserve_size != BTRFS_DEFAULT_GLOBAL_RESERVE_SIZE)
> > +             seq_printf(seq, ",global_reserve_size=%llu", info->global_reserve_size);
> >       if (btrfs_test_opt(info, ENOSPC_DEBUG))
> >               seq_puts(seq, ",enospc_debug");
> >       if (btrfs_test_opt(info, AUTO_DEFRAG))
> > @@ -1725,6 +1738,7 @@ static int btrfs_remount(struct super_block *sb, int *flags, char *data)
> >       u64 old_max_inline = fs_info->max_inline;
> >       u32 old_thread_pool_size = fs_info->thread_pool_size;
> >       u32 old_metadata_ratio = fs_info->metadata_ratio;
> > +     u64 old_global_reserve_size = fs_info->global_reserve_size;
> >       int ret;
> >
> >       sync_filesystem(sb);
> > @@ -1859,6 +1873,7 @@ static int btrfs_remount(struct super_block *sb, int *flags, char *data)
> >       btrfs_resize_thread_pool(fs_info,
> >               old_thread_pool_size, fs_info->thread_pool_size);
> >       fs_info->metadata_ratio = old_metadata_ratio;
> > +     fs_info->global_reserve_size = old_global_reserve_size;
> >       btrfs_remount_cleanup(fs_info, old_opts);
> >       return ret;
> >  }
> >
