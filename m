Return-Path: <linux-btrfs+bounces-7907-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D96B9732A7
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Sep 2024 12:25:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 172531F21BB5
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Sep 2024 10:25:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A49F6198A22;
	Tue, 10 Sep 2024 10:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pDfy82SR"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5AAB188A28;
	Tue, 10 Sep 2024 10:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725963565; cv=none; b=LTvChTlBZlccmuXrLkT3f14tCn2HFI55m5v64YWm/Leiiu1JGnHNZx0oL5+PWuGhT+IWQ/rcYOXbUVi+oCnelF2/AyOKmk0ldoWCxhVIPEqLlzgKVCZEmsdxsAJlksoT+mOEnbefz4bQwrAVkush4Km8xLaPKb23Cw7+dGf9PiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725963565; c=relaxed/simple;
	bh=q+krpLA9WNZnvWjIyi+jH35POZYLBa+qsnEdlbQwO1c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lwYx8HTES7k/6XOUXbivJrzixzpwl3HdQeoYHb5aYCbjZDHvmm6Yij8VaF4AiO+RqNbtNIP/6sDmxBDWKpLpoEIxu8CtBhIe5b+QHZwLXsSEaQX4tko95IfAEaC40pXZah/8FwtJPJsNoUIe0lpp7Q923cP4adAoUgL11/J/3Qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pDfy82SR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CD09C4CECD;
	Tue, 10 Sep 2024 10:19:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725963565;
	bh=q+krpLA9WNZnvWjIyi+jH35POZYLBa+qsnEdlbQwO1c=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=pDfy82SRX/3DseH/ISW4EfhbED8IUd/WnNLYsR/WR+c0K6YqiSeFBL8YvWkGb7Pkj
	 fuTyCtihHqULNZGAP4Kxm2OHZ+yByXxzIe/abC4RsxhtQIiqhPaV7/e5As3b4shlBr
	 OMg2hFt+Mei0sNcCNEhA0BNr2YGkpukFK73zCpPM5C1cxfvxb30oWdSw9pP9x4O8w0
	 Bvgfjo3IQh1gHabXOiYxoo2TmQ9SRtcbLn3RpcdvIGwzyU6hOcu6XjlB2Q7+RzCpPH
	 giivcXw3viUx99BWZdpX5ZAsyFrRnGHyNG3NX3bXSL9u2jE8Mrk0XnueKOiAZ5uPsx
	 sdnBPwmubnHhg==
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a8d6ac24a3bso245327966b.1;
        Tue, 10 Sep 2024 03:19:25 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUFS5DNYqRYNhnQ3ivFun1fuETTCFu8zgpZIlcJUZzUVbGWRJJNEQAv88FBENR70ECvvp6Et4BVjciHmg==@vger.kernel.org, AJvYcCXX/c1Fep/4IHaa9Yv6MP9yxzuoM9WZ50JIJq0vbfZi0nsfCh5hF11MXyL0nnXkg1in8rtGSPmmfGBaMEId@vger.kernel.org
X-Gm-Message-State: AOJu0YyvM73dCjZdiSZJ+wzsIXz21EpDVsscdNylL9lIqPbQFhkMpFxB
	G+qiVxou/o3TFe5TFuA0MPOTeVBaI1OsUvmu9nAld9zgaf98xjLqrMD/AT+Cv948ZsgwhMZ9s6a
	QnFo0j3rkmexasMiXhPysVyi+2kk=
X-Google-Smtp-Source: AGHT+IFo9x4lYJkrVXpDHxHeK47RKEfUZ1ZqkW1WcXUsxFDleK/79LOy4Ht37GLyfA/he+2dRYXyfBg3SYBVXYEVgmY=
X-Received: by 2002:a17:907:7283:b0:a86:9fac:6939 with SMTP id
 a640c23a62f3a-a8ffb2fe465mr25911166b.30.1725963564121; Tue, 10 Sep 2024
 03:19:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <dd0cb649510537a495bc64d91e09da5a8119d2e3.1725950283.git.jth@kernel.org>
In-Reply-To: <dd0cb649510537a495bc64d91e09da5a8119d2e3.1725950283.git.jth@kernel.org>
From: Filipe Manana <fdmanana@kernel.org>
Date: Tue, 10 Sep 2024 11:18:45 +0100
X-Gmail-Original-Message-ID: <CAL3q7H7RE+cUJaN7fmvwT64gVteRY2s=uqcQPjcBe8dwChBj7Q@mail.gmail.com>
Message-ID: <CAL3q7H7RE+cUJaN7fmvwT64gVteRY2s=uqcQPjcBe8dwChBj7Q@mail.gmail.com>
Subject: Re: [PATCH v2] btrfs: don't take dev_replace rwsem on task already
 holding it
To: Johannes Thumshirn <jth@kernel.org>
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>, 
	"open list:BTRFS FILE SYSTEM" <linux-btrfs@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 10, 2024 at 8:55=E2=80=AFAM Johannes Thumshirn <jth@kernel.org>=
 wrote:
>
> From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
>
> Running fstests btrfs/011 with MKFS_OPTIONS=3D"-O rst" to force the usage=
 of
> the RAID stripe-tree, we get the following splat from lockdep:
>
>  BTRFS info (device sdd): dev_replace from /dev/sdd (devid 1) to /dev/sdb=
 started
>
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>  WARNING: possible recursive locking detected
>  6.11.0-rc3-btrfs-for-next #599 Not tainted
>  --------------------------------------------
>  btrfs/2326 is trying to acquire lock:
>  ffff88810f215c98 (&fs_info->dev_replace.rwsem){++++}-{3:3}, at: btrfs_ma=
p_block+0x39f/0x2250
>
>  but task is already holding lock:
>  ffff88810f215c98 (&fs_info->dev_replace.rwsem){++++}-{3:3}, at: btrfs_ma=
p_block+0x39f/0x2250
>
>  other info that might help us debug this:
>   Possible unsafe locking scenario:
>
>         CPU0
>         ----
>    lock(&fs_info->dev_replace.rwsem);
>    lock(&fs_info->dev_replace.rwsem);
>
>   *** DEADLOCK ***
>
>   May be due to missing lock nesting notation
>
>  1 lock held by btrfs/2326:
>   #0: ffff88810f215c98 (&fs_info->dev_replace.rwsem){++++}-{3:3}, at: btr=
fs_map_block+0x39f/0x2250
>
>  stack backtrace:
>  CPU: 1 UID: 0 PID: 2326 Comm: btrfs Not tainted 6.11.0-rc3-btrfs-for-nex=
t #599
>  Hardware name: Bochs Bochs, BIOS Bochs 01/01/2011
>  Call Trace:
>   <TASK>
>   dump_stack_lvl+0x5b/0x80
>   __lock_acquire+0x2798/0x69d0
>   ? __pfx___lock_acquire+0x10/0x10
>   ? __pfx___lock_acquire+0x10/0x10
>   lock_acquire+0x19d/0x4a0
>   ? btrfs_map_block+0x39f/0x2250
>   ? __pfx_lock_acquire+0x10/0x10
>   ? find_held_lock+0x2d/0x110
>   ? lock_is_held_type+0x8f/0x100
>   down_read+0x8e/0x440
>   ? btrfs_map_block+0x39f/0x2250
>   ? __pfx_down_read+0x10/0x10
>   ? do_raw_read_unlock+0x44/0x70
>   ? _raw_read_unlock+0x23/0x40
>   btrfs_map_block+0x39f/0x2250
>   ? btrfs_dev_replace_by_ioctl+0xd69/0x1d00
>   ? btrfs_bio_counter_inc_blocked+0xd9/0x2e0
>   ? __kasan_slab_alloc+0x6e/0x70
>   ? __pfx_btrfs_map_block+0x10/0x10
>   ? __pfx_btrfs_bio_counter_inc_blocked+0x10/0x10
>   ? kmem_cache_alloc_noprof+0x1f2/0x300
>   ? mempool_alloc_noprof+0xed/0x2b0
>   btrfs_submit_chunk+0x28d/0x17e0
>   ? __pfx_btrfs_submit_chunk+0x10/0x10
>   ? bvec_alloc+0xd7/0x1b0
>   ? bio_add_folio+0x171/0x270
>   ? __pfx_bio_add_folio+0x10/0x10
>   ? __kasan_check_read+0x20/0x20
>   btrfs_submit_bio+0x37/0x80
>   read_extent_buffer_pages+0x3df/0x6c0
>   btrfs_read_extent_buffer+0x13e/0x5f0
>   read_tree_block+0x81/0xe0
>   read_block_for_search+0x4bd/0x7a0
>   ? __pfx_read_block_for_search+0x10/0x10
>   btrfs_search_slot+0x78d/0x2720
>   ? __pfx_btrfs_search_slot+0x10/0x10
>   ? lock_is_held_type+0x8f/0x100
>   ? kasan_save_track+0x14/0x30
>   ? __kasan_slab_alloc+0x6e/0x70
>   ? kmem_cache_alloc_noprof+0x1f2/0x300
>   btrfs_get_raid_extent_offset+0x181/0x820
>   ? __pfx_lock_acquire+0x10/0x10
>   ? __pfx_btrfs_get_raid_extent_offset+0x10/0x10
>   ? down_read+0x194/0x440
>   ? __pfx_down_read+0x10/0x10
>   ? do_raw_read_unlock+0x44/0x70
>   ? _raw_read_unlock+0x23/0x40
>   btrfs_map_block+0x5b5/0x2250
>   ? __pfx_btrfs_map_block+0x10/0x10
>   scrub_submit_initial_read+0x8fe/0x11b0
>   ? __pfx_scrub_submit_initial_read+0x10/0x10
>   submit_initial_group_read+0x161/0x3a0
>   ? lock_release+0x20e/0x710
>   ? __pfx_submit_initial_group_read+0x10/0x10
>   ? __pfx_lock_release+0x10/0x10
>   scrub_simple_mirror.isra.0+0x3eb/0x580
>   scrub_stripe+0xe4d/0x1440
>   ? lock_release+0x20e/0x710
>   ? __pfx_scrub_stripe+0x10/0x10
>   ? __pfx_lock_release+0x10/0x10
>   ? do_raw_read_unlock+0x44/0x70
>   ? _raw_read_unlock+0x23/0x40
>   scrub_chunk+0x257/0x4a0
>   scrub_enumerate_chunks+0x64c/0xf70
>   ? __mutex_unlock_slowpath+0x147/0x5f0
>   ? __pfx_scrub_enumerate_chunks+0x10/0x10
>   ? bit_wait_timeout+0xb0/0x170
>   ? __up_read+0x189/0x700
>   ? scrub_workers_get+0x231/0x300
>   ? up_write+0x490/0x4f0
>   btrfs_scrub_dev+0x52e/0xcd0
>   ? create_pending_snapshots+0x230/0x250
>   ? __pfx_btrfs_scrub_dev+0x10/0x10
>   btrfs_dev_replace_by_ioctl+0xd69/0x1d00
>   ? lock_acquire+0x19d/0x4a0
>   ? __pfx_btrfs_dev_replace_by_ioctl+0x10/0x10
>   ? lock_release+0x20e/0x710
>   ? btrfs_ioctl+0xa09/0x74f0
>   ? __pfx_lock_release+0x10/0x10
>   ? do_raw_spin_lock+0x11e/0x240
>   ? __pfx_do_raw_spin_lock+0x10/0x10
>   btrfs_ioctl+0xa14/0x74f0
>   ? lock_acquire+0x19d/0x4a0
>   ? find_held_lock+0x2d/0x110
>   ? __pfx_btrfs_ioctl+0x10/0x10
>   ? lock_release+0x20e/0x710
>   ? do_sigaction+0x3f0/0x860
>   ? __pfx_do_vfs_ioctl+0x10/0x10
>   ? do_raw_spin_lock+0x11e/0x240
>   ? lockdep_hardirqs_on_prepare+0x270/0x3e0
>   ? _raw_spin_unlock_irq+0x28/0x50
>   ? do_sigaction+0x3f0/0x860
>   ? __pfx_do_sigaction+0x10/0x10
>   ? __x64_sys_rt_sigaction+0x18e/0x1e0
>   ? __pfx___x64_sys_rt_sigaction+0x10/0x10
>   ? __x64_sys_close+0x7c/0xd0
>   __x64_sys_ioctl+0x137/0x190
>   do_syscall_64+0x71/0x140
>   entry_SYSCALL_64_after_hwframe+0x76/0x7e
>  RIP: 0033:0x7f0bd1114f9b
>  Code: Unable to access opcode bytes at 0x7f0bd1114f71.
>  RSP: 002b:00007ffc8a8c3130 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
>  RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007f0bd1114f9b
>  RDX: 00007ffc8a8c35e0 RSI: 00000000ca289435 RDI: 0000000000000003
>  RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000007
>  R10: 0000000000000008 R11: 0000000000000246 R12: 00007ffc8a8c6c85
>  R13: 00000000398e72a0 R14: 0000000000004361 R15: 0000000000000004
>   </TASK>
>
> This happens because on RAID stripe-tree filesystems we recurse back into
> btrfs_map_block() on scrub to perform the logical to device physical
> mapping.
>
> But as the device replace task is already holding the dev_replace::rwsem
> we deadlock.
>
> So don't take the dev_replace::rwsem in case our task is the task perform=
ing
> the device replace.
>
> Suggested-by: Filipe Manana <fdmanana@suse.com>
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Looks good, thanks.
The review applies regardless of using task_struct or pid_t.

> ---
>  fs/btrfs/dev-replace.c | 2 ++
>  fs/btrfs/fs.h          | 2 ++
>  fs/btrfs/volumes.c     | 8 +++++---
>  3 files changed, 9 insertions(+), 3 deletions(-)
>
> diff --git a/fs/btrfs/dev-replace.c b/fs/btrfs/dev-replace.c
> index 83d5cdd77f29..604399e59a3d 100644
> --- a/fs/btrfs/dev-replace.c
> +++ b/fs/btrfs/dev-replace.c
> @@ -641,6 +641,7 @@ static int btrfs_dev_replace_start(struct btrfs_fs_in=
fo *fs_info,
>                 return ret;
>
>         down_write(&dev_replace->rwsem);
> +       dev_replace->replace_task =3D current;
>         switch (dev_replace->replace_state) {
>         case BTRFS_IOCTL_DEV_REPLACE_STATE_NEVER_STARTED:
>         case BTRFS_IOCTL_DEV_REPLACE_STATE_FINISHED:
> @@ -994,6 +995,7 @@ static int btrfs_dev_replace_finishing(struct btrfs_f=
s_info *fs_info,
>         list_add(&tgt_device->dev_alloc_list, &fs_devices->alloc_list);
>         fs_devices->rw_devices++;
>
> +       dev_replace->replace_task =3D NULL;
>         up_write(&dev_replace->rwsem);
>         btrfs_rm_dev_replace_blocked(fs_info);
>
> diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
> index 79f64e383edd..cbfb225858a5 100644
> --- a/fs/btrfs/fs.h
> +++ b/fs/btrfs/fs.h
> @@ -317,6 +317,8 @@ struct btrfs_dev_replace {
>
>         struct percpu_counter bio_counter;
>         wait_queue_head_t replace_wait;
> +
> +       struct task_struct *replace_task;
>  };
>
>  /*
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index 8f340ad1d938..995b0647f538 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -6480,13 +6480,15 @@ int btrfs_map_block(struct btrfs_fs_info *fs_info=
, enum btrfs_map_op op,
>         max_len =3D btrfs_max_io_len(map, map_offset, &io_geom);
>         *length =3D min_t(u64, map->chunk_len - map_offset, max_len);
>
> -       down_read(&dev_replace->rwsem);
> +       if (dev_replace->replace_task !=3D current)
> +               down_read(&dev_replace->rwsem);
> +
>         dev_replace_is_ongoing =3D btrfs_dev_replace_is_ongoing(dev_repla=
ce);
>         /*
>          * Hold the semaphore for read during the whole operation, write =
is
>          * requested at commit time but must wait.
>          */
> -       if (!dev_replace_is_ongoing)
> +       if (!dev_replace_is_ongoing && dev_replace->replace_task !=3D cur=
rent)
>                 up_read(&dev_replace->rwsem);
>
>         switch (map->type & BTRFS_BLOCK_GROUP_PROFILE_MASK) {
> @@ -6626,7 +6628,7 @@ int btrfs_map_block(struct btrfs_fs_info *fs_info, =
enum btrfs_map_op op,
>         bioc->mirror_num =3D io_geom.mirror_num;
>
>  out:
> -       if (dev_replace_is_ongoing) {
> +       if (dev_replace_is_ongoing && dev_replace->replace_task !=3D curr=
ent) {
>                 lockdep_assert_held(&dev_replace->rwsem);
>                 /* Unlock and let waiting writers proceed */
>                 up_read(&dev_replace->rwsem);
> --
> 2.43.0
>
>

