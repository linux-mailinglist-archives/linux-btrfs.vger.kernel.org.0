Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CEE01AC22E
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Apr 2020 15:19:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2895049AbgDPNRy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 16 Apr 2020 09:17:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2894890AbgDPNRc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 16 Apr 2020 09:17:32 -0400
Received: from mail-vk1-xa42.google.com (mail-vk1-xa42.google.com [IPv6:2607:f8b0:4864:20::a42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89FEBC061A0C
        for <linux-btrfs@vger.kernel.org>; Thu, 16 Apr 2020 06:16:55 -0700 (PDT)
Received: by mail-vk1-xa42.google.com with SMTP id y129so1852089vkf.6
        for <linux-btrfs@vger.kernel.org>; Thu, 16 Apr 2020 06:16:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=omDMy6ztrQY+7IXlbc9RcSGiU3JTT7fWsOMWbuDNU9Q=;
        b=oIJVC/Dsv3WJsziO10cKDn8TWRfkgwlcNmeHtq/6KqqX7R0j9Pmj6nH6yIyW/e9/kZ
         8ipEY+Y/xAxIQLv/2dYwhEngL+0VjapkMk0YSK/yWMFsGFds7eJl9BekapdUlFr+JftR
         3DNB6r/fMORjXGRaGFw6N94bH2edLxgOKoSGxoIUNTyATXWcI7Y9UUAJNvmzWiMCX1ML
         XVm1pGlPUueRuYXqXKY72WcADdr8OKgp/YOf57i5Nc+zn49k1w9K3bBbDmFkOEgYT+EB
         Vl/jWStD0e75rt09fhb1QSQ/MS6m+t0OI/Q6mV+SHEutUOncXLCfQUyWtmhVzFf+qifz
         M41Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=omDMy6ztrQY+7IXlbc9RcSGiU3JTT7fWsOMWbuDNU9Q=;
        b=lkFaAN2wli6ci9S3nP6E3i9w9j4jxtmWruv/ZZlfVXp0PoE/QzHGGYKjAeZeV1g4GV
         yECUdQrIWuCTfwi/TpuimabEBoDDJBzVsWFpwJODkWeHu23feBCDWCc3wzqS40ihOvRK
         rJvrAPxgSElLQO64b9RYQR2GOTE9VosxYowMmUZAm4P/Iy8UwlUM57nJ/s/DMdAbnElc
         EQrup02chQ6aPg6FBL82yV4gJ28U5JGdAS+tGnYWW9CwVZyoxeZEqYqAjRLvaFTJjQ1p
         104jwk1QfaE1qYJ30d1YEIirzJcfi6T8LrWmlRTcnyPQQ3stpIcGU8lA/G1Vfgz6GK2F
         dWbA==
X-Gm-Message-State: AGi0PuazS845NbgM493IyxJBAGNKxVUOr02okrcg1kRqyh+NuXcWc/rd
        k6KRTJ9A8Y/TRNEKrxA5CXNdxeSpFaGo6gRf1I0=
X-Google-Smtp-Source: APiQypIdtFqiEoLfiXLLkPKAZQ2lsxlyoH6eZIJXxoWkOs7IRga0QAFOhZI477/0YMZgvbCNVXuX1vxRoPo4qTcLODs=
X-Received: by 2002:a1f:2c50:: with SMTP id s77mr23305003vks.14.1587043014621;
 Thu, 16 Apr 2020 06:16:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200324144752.9541-1-josef@toxicpanda.com>
In-Reply-To: <20200324144752.9541-1-josef@toxicpanda.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Thu, 16 Apr 2020 14:16:43 +0100
Message-ID: <CAL3q7H6rrXEYgQ+yE97nOrYxEKarDci0qjs0hM8VtOMOF6=khw@mail.gmail.com>
Subject: Re: [PATCH] btrfs: drop logs when we've aborted a transaction
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Mar 24, 2020 at 2:48 PM Josef Bacik <josef@toxicpanda.com> wrote:
>
> Dave reported a problem where we were panicing with generic/475 with
> misc-5.7.  This is because we were doing IO after we had stopped all of
> the worker threads, because we do the log tree cleanup on roots at drop
> time.  Cleaning up the log tree may need to do reads if we happened to
> have evicted the blocks from memory.

Here the "may need" is actually a "will always need", because before
calling btrfs_free_fs_roots() at close_ctree(),
we drop all the extent buffers from memory from the btree inode
through the call to invalidate_inode_pages2().

So this causes a use-after-free on the workqueues used for reads while
traversing the log trees during the log dropping, since the workqueues
were freed before right after invalidate_inode_pages2(),
everytime we abort a transaction and we have at least one log root
around that is big enough to not consist of only one leaf.

>
> Because of this simply add a helper to btrfs_cleanup_transaction() that
> will go through and drop all of the log roots.  This gets run before we
> do the close_ctree() work, and thus we are allowed to do any reads that
> we would need.  I ran this through many iterations of generic/475 with
> constrained memory and I did not see the issue.
>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Fixes: 8c38938c7bb096 ("btrfs: move the root freeing stuff into btrfs_put_r=
oot")
Reviewed-by: Filipe Manana <fdmanana@suse.com>

Thanks.

>
> ---
>  fs/btrfs/disk-io.c | 36 ++++++++++++++++++++++++++++++++----
>  1 file changed, 32 insertions(+), 4 deletions(-)
>
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index a6cb5cbbdb9f..d10c7be10f3b 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -2036,9 +2036,6 @@ void btrfs_free_fs_roots(struct btrfs_fs_info *fs_i=
nfo)
>                 for (i =3D 0; i < ret; i++)
>                         btrfs_drop_and_free_fs_root(fs_info, gang[i]);
>         }
> -
> -       if (test_bit(BTRFS_FS_STATE_ERROR, &fs_info->fs_state))
> -               btrfs_free_log_root_tree(NULL, fs_info);
>  }
>
>  static void btrfs_init_scrub(struct btrfs_fs_info *fs_info)
> @@ -3888,7 +3885,7 @@ void btrfs_drop_and_free_fs_root(struct btrfs_fs_in=
fo *fs_info,
>         spin_unlock(&fs_info->fs_roots_radix_lock);
>
>         if (test_bit(BTRFS_FS_STATE_ERROR, &fs_info->fs_state)) {
> -               btrfs_free_log(NULL, root);
> +               ASSERT(root->log_root =3D=3D NULL);
>                 if (root->reloc_root) {
>                         btrfs_put_root(root->reloc_root);
>                         root->reloc_root =3D NULL;
> @@ -4211,6 +4208,36 @@ static void btrfs_error_commit_super(struct btrfs_=
fs_info *fs_info)
>         up_write(&fs_info->cleanup_work_sem);
>  }
>
> +static void btrfs_drop_all_logs(struct btrfs_fs_info *fs_info)
> +{
> +       struct btrfs_root *gang[8];
> +       u64 root_objectid =3D 0;
> +       int ret;
> +
> +       spin_lock(&fs_info->fs_roots_radix_lock);
> +       while ((ret =3D radix_tree_gang_lookup(&fs_info->fs_roots_radix,
> +                                            (void **)gang, root_objectid=
,
> +                                            ARRAY_SIZE(gang))) !=3D 0) {
> +               int i;
> +
> +               for (i =3D 0; i < ret; i++)
> +                       gang[i] =3D btrfs_grab_root(gang[i]);
> +               spin_unlock(&fs_info->fs_roots_radix_lock);
> +
> +               for (i =3D 0; i < ret; i++) {
> +                       if (!gang[i])
> +                               continue;
> +                       root_objectid =3D gang[i]->root_key.objectid;
> +                       btrfs_free_log(NULL, gang[i]);
> +                       btrfs_put_root(gang[i]);
> +               }
> +               root_objectid++;
> +               spin_lock(&fs_info->fs_roots_radix_lock);
> +       }
> +       spin_unlock(&fs_info->fs_roots_radix_lock);
> +       btrfs_free_log_root_tree(NULL, fs_info);
> +}
> +
>  static void btrfs_destroy_ordered_extents(struct btrfs_root *root)
>  {
>         struct btrfs_ordered_extent *ordered;
> @@ -4603,6 +4630,7 @@ static int btrfs_cleanup_transaction(struct btrfs_f=
s_info *fs_info)
>         btrfs_destroy_delayed_inodes(fs_info);
>         btrfs_assert_delayed_root_empty(fs_info);
>         btrfs_destroy_all_delalloc_inodes(fs_info);
> +       btrfs_drop_all_logs(fs_info);
>         mutex_unlock(&fs_info->transaction_kthread_mutex);
>
>         return 0;
> --
> 2.17.1
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
