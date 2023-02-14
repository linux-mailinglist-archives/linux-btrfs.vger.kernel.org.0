Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 716FA697007
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Feb 2023 22:48:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232164AbjBNVse (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 14 Feb 2023 16:48:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjBNVsd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 14 Feb 2023 16:48:33 -0500
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C2AA2B084
        for <linux-btrfs@vger.kernel.org>; Tue, 14 Feb 2023 13:48:31 -0800 (PST)
Received: by mail-oi1-x22c.google.com with SMTP id c15so14199445oic.8
        for <linux-btrfs@vger.kernel.org>; Tue, 14 Feb 2023 13:48:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8xAPUVHOhm5IGzbD5Rdt21L89sWep7Fc++8mGBtkMvQ=;
        b=PjIIWeOhXNsFlTNNDqF18I+AfMvF2XO5X/Uf8tsygunKAHhxUDyk2W40YTsjZCGqJK
         wm1jAV9EvkeNzQ0jZuYMFdEfqodTKwuZeI/UfZWNAOD5f8hkIZjhdVZiUeb1KbrCtjCM
         Rwq1msZnFkYNroZnpKFntb4LtiNc/m2iar5TrOUuJ38iy3T+rBF4gnKyLizRxwiTLR1v
         G3flue5i96bgsghCfBwHMXzPOrGylsO4ST523KL9Hr5Q/ahWTehBsjVgOre3zspawH00
         uu3lrtg7FCjHBg4zsFLqAOChXbJaa4Ih08Qpcm9OhedWhFyKNi3l/JyznxtCld55NHfI
         5s0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8xAPUVHOhm5IGzbD5Rdt21L89sWep7Fc++8mGBtkMvQ=;
        b=R6oWXHYRTztgaWEOBpl5g4VvWbra8NVHkGW9aolSJ9UHrgpRZlpb9k/HnAiTGmqqsD
         HxMlU6OM8bVhUihN2Xgx/3ahFMRxncFxhDNdPyxpoYtUkQBsWAaZ5JV5Xm2ED4zjlCN+
         tF3d9Sv/93Th5wAKBANAKtvrSfW0kNdHPy6lHaYfkpRR8u6a+ebUyGcQ6QXWd0PgH7lF
         RSkTuA6S1dRAW9qc9pEbNHxfvbU+29uOtFi9VYtcaGRDLZeBP8aePPtRjPIa9BbvypFH
         MCHSNOiE+VFdPFR7LgDxf+LqX1oDfHE14Fgliy3h8BrB32nMij+Agdw840rcItAe30BX
         2Vvw==
X-Gm-Message-State: AO0yUKXhhSF4xXlo8Phz/rF2JLVAIZoHGMeQ6PwsNODP2RpefYH/ekKF
        f+w9XY61j5DpxXDF+4auFUiZBl2u24/p8TtVxh8=
X-Google-Smtp-Source: AK7set/7RHgQ40Bo1isKbZnYNkDzYA+EOZVmlMhn8l5vf2avVyCkuhpbIAlzU2fLLIwAUzSmPZeqFbK5OjchrcBZ1gE=
X-Received: by 2002:aca:541:0:b0:37d:5e52:6844 with SMTP id
 62-20020aca0541000000b0037d5e526844mr26223oif.98.1676411310447; Tue, 14 Feb
 2023 13:48:30 -0800 (PST)
MIME-Version: 1.0
References: <cover.1674679476.git.boris@bur.io> <a88ac5fba9dadaba4c04edd0782d0f2e8cf5b8e6.1674679476.git.boris@bur.io>
In-Reply-To: <a88ac5fba9dadaba4c04edd0782d0f2e8cf5b8e6.1674679476.git.boris@bur.io>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Tue, 14 Feb 2023 21:47:54 +0000
Message-ID: <CAL3q7H7eKMD44Z1+=Kb-1RFMMeZpAm2fwyO59yeBwCcSOU80Pg@mail.gmail.com>
Subject: Re: [PATCH 1/2] btrfs: fix size class loading logic
To:     Boris Burkov <boris@bur.io>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jan 25, 2023 at 9:33 PM Boris Burkov <boris@bur.io> wrote:
>
> The original implementation was completely incorrect. It used
> btrfs_search_slot to make an inexact match, which simply returned >0 to
> indicate not finding the key.
>
> Change it to using search_forward with no transid to actually walk the
> leaves looking for extent items. Some small tweaks to the key space
> condition checking in the iteration were also necessary.
>
> Finally, since the sampling lookups are of fixed complexity, move them
> into the main, blocking part of caching a block group, not as a
> best-effort thing after. This has no effect on total block group caching
> throughput as there is only one thread anyway, but makes it simpler and
> reduces weird races where we change the size class simultaneously from
> an allocation and loading.
>
> Signed-off-by: Boris Burkov <boris@bur.io>
> ---
>  fs/btrfs/block-group.c | 56 ++++++++++++++++++++++++++++--------------
>  1 file changed, 37 insertions(+), 19 deletions(-)
>
> diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
> index 73e1270b3904..45ccb25c5b1f 100644
> --- a/fs/btrfs/block-group.c
> +++ b/fs/btrfs/block-group.c
> @@ -555,7 +555,8 @@ u64 add_new_free_space(struct btrfs_block_group *bloc=
k_group, u64 start, u64 end
>   * Returns: 0 on success, 1 if the search didn't yield a useful item, ne=
gative
>   * error code on error.
>   */
> -static int sample_block_group_extent_item(struct btrfs_block_group *bloc=
k_group,
> +static int sample_block_group_extent_item(struct btrfs_caching_control *=
caching_ctl,
> +                                         struct btrfs_block_group *block=
_group,
>                                           int index, int max_index,
>                                           struct btrfs_key *key)
>  {
> @@ -563,17 +564,19 @@ static int sample_block_group_extent_item(struct bt=
rfs_block_group *block_group,
>         struct btrfs_root *extent_root;
>         int ret =3D 0;
>         u64 search_offset;
> +       u64 search_end =3D block_group->start + block_group->length;
>         struct btrfs_path *path;
>
>         ASSERT(index >=3D 0);
>         ASSERT(index <=3D max_index);
>         ASSERT(max_index > 0);
> +       lockdep_assert_held(&caching_ctl->mutex);
> +       lockdep_assert_held_read(&fs_info->commit_root_sem);
>
>         path =3D btrfs_alloc_path();
>         if (!path)
>                 return -ENOMEM;
>
> -       down_read(&fs_info->commit_root_sem);
>         extent_root =3D btrfs_extent_root(fs_info, max_t(u64, block_group=
->start,
>                                                        BTRFS_SUPER_INFO_O=
FFSET));
>
> @@ -586,21 +589,36 @@ static int sample_block_group_extent_item(struct bt=
rfs_block_group *block_group,
>         key->type =3D BTRFS_EXTENT_ITEM_KEY;
>         key->offset =3D 0;
>
> -       ret =3D btrfs_search_slot(NULL, extent_root, key, path, 0, 0);
> -       if (ret !=3D 0)
> -               goto out;
> -       if (key->objectid < block_group->start ||
> -           key->objectid > block_group->start + block_group->length) {
> -               ret =3D 1;
> -               goto out;
> -       }
> -       if (key->type !=3D BTRFS_EXTENT_ITEM_KEY) {
> -               ret =3D 1;
> -               goto out;
> +       while (1) {
> +               ret =3D btrfs_search_forward(extent_root, key, path, 0);

Boris, this is broken and can result in a deadlock.

btrfs_search_forward() will always lock the root node, despite the
path having ->skip_locking and ->search_commit_root set to true (1).
It's not meant to be used for commit roots, so it always needs to do lockin=
g.

So if another task is COWing a child node of the same root node and
then needs to wait for block group caching to complete when trying to
allocate a metadata extent, it deadlocks.
For example:

[539604.239315] sysrq: Show Blocked State
[539604.240133] task:kworker/u16:6   state:D stack:0     pid:2119594
ppid:2      flags:0x00004000
[539604.241613] Workqueue: btrfs-cache btrfs_work_helper [btrfs]
[539604.242673] Call Trace:
[539604.243129]  <TASK>
[539604.243925]  __schedule+0x41d/0xee0
[539604.244797]  ? rcu_read_lock_sched_held+0x12/0x70
[539604.245399]  ? rwsem_down_read_slowpath+0x185/0x490
[539604.246111]  schedule+0x5d/0xf0
[539604.246593]  rwsem_down_read_slowpath+0x2da/0x490
[539604.247290]  ? rcu_barrier_tasks_trace+0x10/0x20
[539604.248090]  __down_read_common+0x3d/0x150
[539604.248702]  down_read_nested+0xc3/0x140
[539604.249280]  __btrfs_tree_read_lock+0x24/0x100 [btrfs]
[539604.250097]  btrfs_read_lock_root_node+0x48/0x60 [btrfs]
[539604.250915]  btrfs_search_forward+0x59/0x460 [btrfs]
[539604.251781]  ? btrfs_global_root+0x50/0x70 [btrfs]
[539604.252476]  caching_thread+0x1be/0x920 [btrfs]
[539604.253167]  btrfs_work_helper+0xf6/0x400 [btrfs]
[539604.253848]  process_one_work+0x24f/0x5a0
[539604.254476]  worker_thread+0x52/0x3b0
[539604.255166]  ? __pfx_worker_thread+0x10/0x10
[539604.256047]  kthread+0xf0/0x120
[539604.256591]  ? __pfx_kthread+0x10/0x10
[539604.257212]  ret_from_fork+0x29/0x50
[539604.257822]  </TASK>
[539604.258233] task:btrfs-transacti state:D stack:0     pid:2236474
ppid:2      flags:0x00004000
[539604.259802] Call Trace:
[539604.260243]  <TASK>
[539604.260615]  __schedule+0x41d/0xee0
[539604.261205]  ? rcu_read_lock_sched_held+0x12/0x70
[539604.262000]  ? rwsem_down_read_slowpath+0x185/0x490
[539604.262822]  schedule+0x5d/0xf0
[539604.263374]  rwsem_down_read_slowpath+0x2da/0x490
[539604.266228]  ? lock_acquire+0x160/0x310
[539604.266917]  ? rcu_read_lock_sched_held+0x12/0x70
[539604.267996]  ? lock_contended+0x19e/0x500
[539604.268720]  __down_read_common+0x3d/0x150
[539604.269400]  down_read_nested+0xc3/0x140
[539604.270057]  __btrfs_tree_read_lock+0x24/0x100 [btrfs]
[539604.271129]  btrfs_read_lock_root_node+0x48/0x60 [btrfs]
[539604.272372]  btrfs_search_slot+0x143/0xf70 [btrfs]
[539604.273295]  update_block_group_item+0x9e/0x190 [btrfs]
[539604.274282]  btrfs_start_dirty_block_groups+0x1c4/0x4f0 [btrfs]
[539604.275381]  ? __mutex_unlock_slowpath+0x45/0x280
[539604.276390]  btrfs_commit_transaction+0xee/0xed0 [btrfs]
[539604.277391]  ? lock_acquire+0x1a4/0x310
[539604.278080]  ? start_transaction+0xcb/0x6c0 [btrfs]
[539604.279099]  transaction_kthread+0x142/0x1c0 [btrfs]
[539604.279996]  ? __pfx_transaction_kthread+0x10/0x10 [btrfs]
[539604.280673]  kthread+0xf0/0x120
[539604.281050]  ? __pfx_kthread+0x10/0x10
[539604.281496]  ret_from_fork+0x29/0x50
[539604.281966]  </TASK>
[539604.282255] task:fsstress        state:D stack:0     pid:2236483
ppid:1      flags:0x00004006
[539604.283897] Call Trace:
[539604.284700]  <TASK>
[539604.285088]  __schedule+0x41d/0xee0
[539604.285660]  schedule+0x5d/0xf0
[539604.286175]  btrfs_wait_block_group_cache_progress+0xf2/0x170 [btrfs]
[539604.287342]  ? __pfx_autoremove_wake_function+0x10/0x10
[539604.288450]  find_free_extent+0xd93/0x1750 [btrfs]
[539604.289256]  ? _raw_spin_unlock+0x29/0x50
[539604.289911]  ? btrfs_get_alloc_profile+0x127/0x2a0 [btrfs]
[539604.290843]  btrfs_reserve_extent+0x147/0x290 [btrfs]
[539604.291943]  btrfs_alloc_tree_block+0xcb/0x3e0 [btrfs]
[539604.292903]  __btrfs_cow_block+0x138/0x580 [btrfs]
[539604.293773]  btrfs_cow_block+0x10e/0x240 [btrfs]
[539604.294595]  btrfs_search_slot+0x7f3/0xf70 [btrfs]
[539604.295585]  btrfs_update_device+0x71/0x1b0 [btrfs]
[539604.296459]  btrfs_chunk_alloc_add_chunk_item+0xe0/0x340 [btrfs]
[539604.297489]  btrfs_chunk_alloc+0x1bf/0x490 [btrfs]
[539604.298335]  find_free_extent+0x6fa/0x1750 [btrfs]
[539604.299174]  ? _raw_spin_unlock+0x29/0x50
[539604.299950]  ? btrfs_get_alloc_profile+0x127/0x2a0 [btrfs]
[539604.300918]  btrfs_reserve_extent+0x147/0x290 [btrfs]
[539604.301797]  btrfs_alloc_tree_block+0xcb/0x3e0 [btrfs]
[539604.303017]  ? lock_release+0x224/0x4a0
[539604.303855]  __btrfs_cow_block+0x138/0x580 [btrfs]
[539604.304789]  btrfs_cow_block+0x10e/0x240 [btrfs]
[539604.305611]  btrfs_search_slot+0x7f3/0xf70 [btrfs]
[539604.306682]  ? btrfs_global_root+0x50/0x70 [btrfs]
[539604.308198]  lookup_inline_extent_backref+0x17b/0x7a0 [btrfs]
[539604.309254]  lookup_extent_backref+0x43/0xd0 [btrfs]
[539604.310122]  __btrfs_free_extent+0xf8/0x810 [btrfs]
[539604.310874]  ? lock_release+0x224/0x4a0
[539604.311724]  ? btrfs_merge_delayed_refs+0x17b/0x1d0 [btrfs]
[539604.313023]  __btrfs_run_delayed_refs+0x2ba/0x1260 [btrfs]
[539604.314271]  btrfs_run_delayed_refs+0x8f/0x1c0 [btrfs]
[539604.315445]  ? rcu_read_lock_sched_held+0x12/0x70
[539604.316706]  btrfs_commit_transaction+0xa2/0xed0 [btrfs]
[539604.317855]  ? do_raw_spin_unlock+0x4b/0xa0
[539604.318544]  ? _raw_spin_unlock+0x29/0x50
[539604.319240]  create_subvol+0x53d/0x6e0 [btrfs]
[539604.320283]  btrfs_mksubvol+0x4f5/0x590 [btrfs]
[539604.321220]  __btrfs_ioctl_snap_create+0x11b/0x180 [btrfs]
[539604.322307]  btrfs_ioctl_snap_create_v2+0xc6/0x150 [btrfs]
[539604.323295]  btrfs_ioctl+0x9f7/0x33e0 [btrfs]
[539604.324331]  ? rcu_read_lock_sched_held+0x12/0x70
[539604.325137]  ? lock_release+0x224/0x4a0
[539604.325808]  ? __x64_sys_ioctl+0x87/0xc0
[539604.326467]  __x64_sys_ioctl+0x87/0xc0
[539604.327109]  do_syscall_64+0x38/0x90
[539604.327875]  entry_SYSCALL_64_after_hwframe+0x72/0xdc
[539604.328792] RIP: 0033:0x7f05a7babaeb
[539604.329378] RSP: 002b:00007ffd0fecc480 EFLAGS: 00000246 ORIG_RAX:
0000000000000010
[539604.330561] RAX: ffffffffffffffda RBX: 00007ffd0fecd520 RCX:
00007f05a7babaeb
[539604.335194] RDX: 00007ffd0fecc4e0 RSI: 0000000050009418 RDI:
0000000000000004
[539604.336583] RBP: 0000000000000002 R08: 0000000000000000 R09:
000055a66e107480
[539604.337685] R10: 00007f05a7ac5358 R11: 0000000000000246 R12:
0000000000000004
[539604.339220] R13: 00007ffd0fecc4e0 R14: 0000000000000004 R15:
000055a66c4be590
[539604.341137]  </TASK>

This needs to use regular btrfs_search_slot() with some skip and stop logic=
.

Thanks.


> +               if (ret !=3D 0)
> +                       goto out;
> +               /* Success; sampled an extent item in the block group */
> +               if (key->type =3D=3D BTRFS_EXTENT_ITEM_KEY &&
> +                   key->objectid >=3D block_group->start &&
> +                   key->objectid + key->offset <=3D search_end)
> +                       goto out;
> +
> +               /* We can't possibly find a valid extent item anymore */
> +               if (key->objectid >=3D search_end) {
> +                       ret =3D 1;
> +                       break;
> +               }
> +               if (key->type < BTRFS_EXTENT_ITEM_KEY)
> +                       key->type =3D BTRFS_EXTENT_ITEM_KEY;
> +               else
> +                       key->objectid++;
> +               btrfs_release_path(path);
> +               up_read(&fs_info->commit_root_sem);
> +               mutex_unlock(&caching_ctl->mutex);
> +               cond_resched();
> +               mutex_lock(&caching_ctl->mutex);
> +               down_read(&fs_info->commit_root_sem);
>         }
>  out:
> +       lockdep_assert_held(&caching_ctl->mutex);
> +       lockdep_assert_held_read(&fs_info->commit_root_sem);
>         btrfs_free_path(path);
> -       up_read(&fs_info->commit_root_sem);
>         return ret;
>  }
>
> @@ -638,7 +656,8 @@ static int sample_block_group_extent_item(struct btrf=
s_block_group *block_group,
>   *
>   * Returns: 0 on success, negative error code on error.
>   */
> -static int load_block_group_size_class(struct btrfs_block_group *block_g=
roup)
> +static int load_block_group_size_class(struct btrfs_caching_control *cac=
hing_ctl,
> +                                      struct btrfs_block_group *block_gr=
oup)
>  {
>         struct btrfs_key key;
>         int i;
> @@ -646,11 +665,11 @@ static int load_block_group_size_class(struct btrfs=
_block_group *block_group)
>         enum btrfs_block_group_size_class size_class =3D BTRFS_BG_SZ_NONE=
;
>         int ret;
>
> -       if (btrfs_block_group_should_use_size_class(block_group))
> +       if (!btrfs_block_group_should_use_size_class(block_group))
>                 return 0;
>
>         for (i =3D 0; i < 5; ++i) {
> -               ret =3D sample_block_group_extent_item(block_group, i, 5,=
 &key);
> +               ret =3D sample_block_group_extent_item(caching_ctl, block=
_group, i, 5, &key);
>                 if (ret < 0)
>                         goto out;
>                 if (ret > 0)
> @@ -812,6 +831,7 @@ static noinline void caching_thread(struct btrfs_work=
 *work)
>         mutex_lock(&caching_ctl->mutex);
>         down_read(&fs_info->commit_root_sem);
>
> +       load_block_group_size_class(caching_ctl, block_group);
>         if (btrfs_test_opt(fs_info, SPACE_CACHE)) {
>                 ret =3D load_free_space_cache(block_group);
>                 if (ret =3D=3D 1) {
> @@ -867,8 +887,6 @@ static noinline void caching_thread(struct btrfs_work=
 *work)
>
>         wake_up(&caching_ctl->wait);
>
> -       load_block_group_size_class(block_group);
> -
>         btrfs_put_caching_control(caching_ctl);
>         btrfs_put_block_group(block_group);
>  }
> --
> 2.38.1
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
