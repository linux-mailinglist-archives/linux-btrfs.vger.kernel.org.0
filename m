Return-Path: <linux-btrfs+bounces-7891-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 888FB971952
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Sep 2024 14:29:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FE3F282E69
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Sep 2024 12:29:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67A411B7904;
	Mon,  9 Sep 2024 12:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eWh0f7OP"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F9B01B78E4;
	Mon,  9 Sep 2024 12:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725884969; cv=none; b=rFq20uvA3ZZJpFMhv65GkJj0YzWm2QWlFlXJcDLM+0LLimw7vH06sr5p3D6zjDgFapAAX9w2htWvBq5CsSZqIochyjvIvCRQbmwtWdu3nNqyHpMtXOhG3n1wPK7dkZzm1OC64PHHwFaSu5Q4E9YEriOtUXT0gyCwTVYbcLXhTMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725884969; c=relaxed/simple;
	bh=7+WLDiLOY1RzEGzJdqaxTMQgG4gRsQmqvM8Xj+7Pfx8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dGxQeoBXip5yo6vdwuAPsEcINr0ontt02DQJW69pmJSpVom91MVA1iLzvnOZUPTfOWaaT7HBB3Bzjtq4mEfgSVh7GVZOtfY3Y0dejB58GLYly8AlXcsIkpfkEyBLoSamw22JQsEPhHGbMkN/7F+isSInZkXhuU6qGtikEEd5UVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eWh0f7OP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32380C4CECD;
	Mon,  9 Sep 2024 12:29:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725884969;
	bh=7+WLDiLOY1RzEGzJdqaxTMQgG4gRsQmqvM8Xj+7Pfx8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=eWh0f7OPhD+3Hy/YSQZM6ByT2+g9mH0AR+HRxhRoqyE1bYKs4ltmftvBI5Fv1m7i4
	 s1imfIqCRaHT321DTUfcBbuhW0JnCLGeFpgXxsr3OOxj5G06nSwLb3wpcrhxIOVyKH
	 LO11wBQA3I0TIgwVq1Ri2TQGnRgZCNVPzc22MGAmCgI6mm0lkUhXyc09WtDe/f5C/b
	 jqHB/l7KQlxypTtMq1LxTfQWp7t+MJoOIY06U40/JoPnF9z2yVkZK+Fb7cqMMdx6Qg
	 BwMGtEcpPH6lNdA/a9xmQHs0MtiKrRQbxPit9JClyo/5UK2Kpl3VfdGCPsjhY1+QXF
	 +bHHgI6DyZSRA==
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a8d29b7edc2so266901266b.1;
        Mon, 09 Sep 2024 05:29:29 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWsP/X4gvtpkVLoYIbRhWYhD04KJ/jhvvlGcNlWB8ELGdKWCq6M5emq4pPD0RqsvfVTHaqzvESY90U1L/eO@vger.kernel.org, AJvYcCXU4vuaJoiHX828jdk3/EZD4aHs/Ss4NTXOzkuFEmvbhEYX+Spn9nOEmNqNNN3xDd80LKyByiwoFzP6Tg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzDwyXmKL3JI7iH5KKv+Ijz0mFMgsENBHTUCRRQfSEPDRV6nMcO
	z2W+Ka9XsS/QPWYPj8ZT6VUWLCMP9ooaiN+ZrpOKdl1Yj+rCMDSjr+K/BIBPGOmZUG30jFbyswr
	S5Io6czSC2J/H0fbyJeAr5tgCK0s=
X-Google-Smtp-Source: AGHT+IGCII3N7KdT0xT84KPzbGWF88501aKy2+zgBZNyOi9f1eItgKmACCHt07IXbaUNftsSqRhA6RpEqezz/5ZSDPU=
X-Received: by 2002:a17:907:783:b0:a86:7e2d:f10b with SMTP id
 a640c23a62f3a-a8a88667fc7mr1248826266b.37.1725884967578; Mon, 09 Sep 2024
 05:29:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <9e26957661751f7697220d978a9a7f927d0ec378.1723726582.git.jth@kernel.org>
 <CAL3q7H6NP_Rr33cdeV3+=GvseOafowaED-maWhtUw65P4Bti+w@mail.gmail.com> <617cf535-4534-42da-9bee-2ef6c2806efb@wdc.com>
In-Reply-To: <617cf535-4534-42da-9bee-2ef6c2806efb@wdc.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Mon, 9 Sep 2024 13:28:50 +0100
X-Gmail-Original-Message-ID: <CAL3q7H4nvqLwk7g=rZ3NVp+W2ttAHN7mi8QO-qy7hqhe0AzoJA@mail.gmail.com>
Message-ID: <CAL3q7H4nvqLwk7g=rZ3NVp+W2ttAHN7mi8QO-qy7hqhe0AzoJA@mail.gmail.com>
Subject: Re: [PATCH] btrfs: don't take dev_replace rwsem on task already
 holding it
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc: Johannes Thumshirn <jth@kernel.org>, Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, 
	David Sterba <dsterba@suse.com>, 
	"open list:BTRFS FILE SYSTEM" <linux-btrfs@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 9, 2024 at 11:35=E2=80=AFAM Johannes Thumshirn
<Johannes.Thumshirn@wdc.com> wrote:
>
> On 26.08.24 13:11, Filipe Manana wrote:
> > On Thu, Aug 15, 2024 at 1:57=E2=80=AFPM Johannes Thumshirn <jth@kernel.=
org> wrote:
> >>
> >> From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> >>
> >> Running fstests btrfs/011 with MKFS_OPTIONS=3D"-O rst" to force the us=
age of
> >> the RAID stripe-tree, we get the following splat from lockdep:
> >>
> >>   BTRFS info (device sdd): dev_replace from /dev/sdd (devid 1) to /dev=
/sdb started
> >>
> >>   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >>   WARNING: possible recursive locking detected
> >>   6.11.0-rc3-btrfs-for-next #599 Not tainted
> >>   --------------------------------------------
> >>   btrfs/2326 is trying to acquire lock:
> >>   ffff88810f215c98 (&fs_info->dev_replace.rwsem){++++}-{3:3}, at: btrf=
s_map_block+0x39f/0x2250
> >>
> >>   but task is already holding lock:
> >>   ffff88810f215c98 (&fs_info->dev_replace.rwsem){++++}-{3:3}, at: btrf=
s_map_block+0x39f/0x2250
> >>
> >>   other info that might help us debug this:
> >>    Possible unsafe locking scenario:
> >>
> >>          CPU0
> >>          ----
> >>     lock(&fs_info->dev_replace.rwsem);
> >>     lock(&fs_info->dev_replace.rwsem);
> >>
> >>    *** DEADLOCK ***
> >>
> >>    May be due to missing lock nesting notation
> >>
> >>   1 lock held by btrfs/2326:
> >>    #0: ffff88810f215c98 (&fs_info->dev_replace.rwsem){++++}-{3:3}, at:=
 btrfs_map_block+0x39f/0x2250
> >>
> >>   stack backtrace:
> >>   CPU: 1 UID: 0 PID: 2326 Comm: btrfs Not tainted 6.11.0-rc3-btrfs-for=
-next #599
> >>   Hardware name: Bochs Bochs, BIOS Bochs 01/01/2011
> >>   Call Trace:
> >>    <TASK>
> >>    dump_stack_lvl+0x5b/0x80
> >>    __lock_acquire+0x2798/0x69d0
> >>    ? __pfx___lock_acquire+0x10/0x10
> >>    ? __pfx___lock_acquire+0x10/0x10
> >>    lock_acquire+0x19d/0x4a0
> >>    ? btrfs_map_block+0x39f/0x2250
> >>    ? __pfx_lock_acquire+0x10/0x10
> >>    ? find_held_lock+0x2d/0x110
> >>    ? lock_is_held_type+0x8f/0x100
> >>    down_read+0x8e/0x440
> >>    ? btrfs_map_block+0x39f/0x2250
> >>    ? __pfx_down_read+0x10/0x10
> >>    ? do_raw_read_unlock+0x44/0x70
> >>    ? _raw_read_unlock+0x23/0x40
> >>    btrfs_map_block+0x39f/0x2250
> >>    ? btrfs_dev_replace_by_ioctl+0xd69/0x1d00
> >>    ? btrfs_bio_counter_inc_blocked+0xd9/0x2e0
> >>    ? __kasan_slab_alloc+0x6e/0x70
> >>    ? __pfx_btrfs_map_block+0x10/0x10
> >>    ? __pfx_btrfs_bio_counter_inc_blocked+0x10/0x10
> >>    ? kmem_cache_alloc_noprof+0x1f2/0x300
> >>    ? mempool_alloc_noprof+0xed/0x2b0
> >>    btrfs_submit_chunk+0x28d/0x17e0
> >>    ? __pfx_btrfs_submit_chunk+0x10/0x10
> >>    ? bvec_alloc+0xd7/0x1b0
> >>    ? bio_add_folio+0x171/0x270
> >>    ? __pfx_bio_add_folio+0x10/0x10
> >>    ? __kasan_check_read+0x20/0x20
> >>    btrfs_submit_bio+0x37/0x80
> >>    read_extent_buffer_pages+0x3df/0x6c0
> >>    btrfs_read_extent_buffer+0x13e/0x5f0
> >>    read_tree_block+0x81/0xe0
> >>    read_block_for_search+0x4bd/0x7a0
> >>    ? __pfx_read_block_for_search+0x10/0x10
> >>    btrfs_search_slot+0x78d/0x2720
> >>    ? __pfx_btrfs_search_slot+0x10/0x10
> >>    ? lock_is_held_type+0x8f/0x100
> >>    ? kasan_save_track+0x14/0x30
> >>    ? __kasan_slab_alloc+0x6e/0x70
> >>    ? kmem_cache_alloc_noprof+0x1f2/0x300
> >>    btrfs_get_raid_extent_offset+0x181/0x820
> >>    ? __pfx_lock_acquire+0x10/0x10
> >>    ? __pfx_btrfs_get_raid_extent_offset+0x10/0x10
> >>    ? down_read+0x194/0x440
> >>    ? __pfx_down_read+0x10/0x10
> >>    ? do_raw_read_unlock+0x44/0x70
> >>    ? _raw_read_unlock+0x23/0x40
> >>    btrfs_map_block+0x5b5/0x2250
> >>    ? __pfx_btrfs_map_block+0x10/0x10
> >>    scrub_submit_initial_read+0x8fe/0x11b0
> >>    ? __pfx_scrub_submit_initial_read+0x10/0x10
> >>    submit_initial_group_read+0x161/0x3a0
> >>    ? lock_release+0x20e/0x710
> >>    ? __pfx_submit_initial_group_read+0x10/0x10
> >>    ? __pfx_lock_release+0x10/0x10
> >>    scrub_simple_mirror.isra.0+0x3eb/0x580
> >>    scrub_stripe+0xe4d/0x1440
> >>    ? lock_release+0x20e/0x710
> >>    ? __pfx_scrub_stripe+0x10/0x10
> >>    ? __pfx_lock_release+0x10/0x10
> >>    ? do_raw_read_unlock+0x44/0x70
> >>    ? _raw_read_unlock+0x23/0x40
> >>    scrub_chunk+0x257/0x4a0
> >>    scrub_enumerate_chunks+0x64c/0xf70
> >>    ? __mutex_unlock_slowpath+0x147/0x5f0
> >>    ? __pfx_scrub_enumerate_chunks+0x10/0x10
> >>    ? bit_wait_timeout+0xb0/0x170
> >>    ? __up_read+0x189/0x700
> >>    ? scrub_workers_get+0x231/0x300
> >>    ? up_write+0x490/0x4f0
> >>    btrfs_scrub_dev+0x52e/0xcd0
> >>    ? create_pending_snapshots+0x230/0x250
> >>    ? __pfx_btrfs_scrub_dev+0x10/0x10
> >>    btrfs_dev_replace_by_ioctl+0xd69/0x1d00
> >>    ? lock_acquire+0x19d/0x4a0
> >>    ? __pfx_btrfs_dev_replace_by_ioctl+0x10/0x10
> >>    ? lock_release+0x20e/0x710
> >>    ? btrfs_ioctl+0xa09/0x74f0
> >>    ? __pfx_lock_release+0x10/0x10
> >>    ? do_raw_spin_lock+0x11e/0x240
> >>    ? __pfx_do_raw_spin_lock+0x10/0x10
> >>    btrfs_ioctl+0xa14/0x74f0
> >>    ? lock_acquire+0x19d/0x4a0
> >>    ? find_held_lock+0x2d/0x110
> >>    ? __pfx_btrfs_ioctl+0x10/0x10
> >>    ? lock_release+0x20e/0x710
> >>    ? do_sigaction+0x3f0/0x860
> >>    ? __pfx_do_vfs_ioctl+0x10/0x10
> >>    ? do_raw_spin_lock+0x11e/0x240
> >>    ? lockdep_hardirqs_on_prepare+0x270/0x3e0
> >>    ? _raw_spin_unlock_irq+0x28/0x50
> >>    ? do_sigaction+0x3f0/0x860
> >>    ? __pfx_do_sigaction+0x10/0x10
> >>    ? __x64_sys_rt_sigaction+0x18e/0x1e0
> >>    ? __pfx___x64_sys_rt_sigaction+0x10/0x10
> >>    ? __x64_sys_close+0x7c/0xd0
> >>    __x64_sys_ioctl+0x137/0x190
> >>    do_syscall_64+0x71/0x140
> >>    entry_SYSCALL_64_after_hwframe+0x76/0x7e
> >>   RIP: 0033:0x7f0bd1114f9b
> >>   Code: Unable to access opcode bytes at 0x7f0bd1114f71.
> >>   RSP: 002b:00007ffc8a8c3130 EFLAGS: 00000246 ORIG_RAX: 00000000000000=
10
> >>   RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007f0bd1114f9b
> >>   RDX: 00007ffc8a8c35e0 RSI: 00000000ca289435 RDI: 0000000000000003
> >>   RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000007
> >>   R10: 0000000000000008 R11: 0000000000000246 R12: 00007ffc8a8c6c85
> >>   R13: 00000000398e72a0 R14: 0000000000004361 R15: 0000000000000004
> >>    </TASK>
> >>
> >> This happens because on RAID stripe-tree filesystems we recurse back i=
nto
> >> btrfs_map_block() on scrub to perform the logical to device physical
> >> mapping.
> >>
> >> But as the device replace task is already holding the dev_replace::rws=
em
> >> we deadlock.
> >>
> >> So don't take the dev_replace::rwsem in case our task is the task perf=
orming
> >> the device replace.
> >>
> >> Suggested-by: Filipe Manana <fdmanana@suse.com>
> >> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> >> ---
> >>   fs/btrfs/dev-replace.c | 2 ++
> >>   fs/btrfs/fs.h          | 2 ++
> >>   fs/btrfs/volumes.c     | 4 +++-
> >>   3 files changed, 7 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/fs/btrfs/dev-replace.c b/fs/btrfs/dev-replace.c
> >> index 83d5cdd77f29..604399e59a3d 100644
> >> --- a/fs/btrfs/dev-replace.c
> >> +++ b/fs/btrfs/dev-replace.c
> >> @@ -641,6 +641,7 @@ static int btrfs_dev_replace_start(struct btrfs_fs=
_info *fs_info,
> >>                  return ret;
> >>
> >>          down_write(&dev_replace->rwsem);
> >> +       dev_replace->replace_task =3D current;
> >>          switch (dev_replace->replace_state) {
> >>          case BTRFS_IOCTL_DEV_REPLACE_STATE_NEVER_STARTED:
> >>          case BTRFS_IOCTL_DEV_REPLACE_STATE_FINISHED:
> >> @@ -994,6 +995,7 @@ static int btrfs_dev_replace_finishing(struct btrf=
s_fs_info *fs_info,
> >>          list_add(&tgt_device->dev_alloc_list, &fs_devices->alloc_list=
);
> >>          fs_devices->rw_devices++;
> >>
> >> +       dev_replace->replace_task =3D NULL;
> >>          up_write(&dev_replace->rwsem);
> >>          btrfs_rm_dev_replace_blocked(fs_info);
> >>
> >> diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
> >> index 3d6d4b503220..53824da92cc3 100644
> >> --- a/fs/btrfs/fs.h
> >> +++ b/fs/btrfs/fs.h
> >> @@ -317,6 +317,8 @@ struct btrfs_dev_replace {
> >>
> >>          struct percpu_counter bio_counter;
> >>          wait_queue_head_t replace_wait;
> >> +
> >> +       struct task_struct *replace_task;
> >>   };
> >>
> >>   /*
> >> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> >> index 4b9b647a7e29..d2e80a1f258d 100644
> >> --- a/fs/btrfs/volumes.c
> >> +++ b/fs/btrfs/volumes.c
> >> @@ -6481,7 +6481,9 @@ int btrfs_map_block(struct btrfs_fs_info *fs_inf=
o, enum btrfs_map_op op,
> >>          *length =3D min_t(u64, map->chunk_len - map_offset, max_len);
> >>
> >>          down_read(&dev_replace->rwsem);
> >> -       dev_replace_is_ongoing =3D btrfs_dev_replace_is_ongoing(dev_re=
place);
> >> +       if (btrfs_dev_replace_is_ongoing(dev_replace) && dev_replace->=
replace_task !=3D current)
> >> +               dev_replace_is_ongoing =3D 1;
> >
> > So the idea I suggested was not like this.
> > The idea was just to not ever down_read() the semaphore if the current
> > task is the replace task.
>
> So your idea is sth like the following (not yet tested):

Yes, exactly.

>
> diff --git a/fs/btrfs/dev-replace.c b/fs/btrfs/dev-replace.c
> index 83d5cdd77f29..604399e59a3d 100644
> --- a/fs/btrfs/dev-replace.c
> +++ b/fs/btrfs/dev-replace.c
> @@ -641,6 +641,7 @@ static int btrfs_dev_replace_start(struct
> btrfs_fs_info *fs_info,
>                  return ret;
>
>          down_write(&dev_replace->rwsem);
> +       dev_replace->replace_task =3D current;
>          switch (dev_replace->replace_state) {
>          case BTRFS_IOCTL_DEV_REPLACE_STATE_NEVER_STARTED:
>          case BTRFS_IOCTL_DEV_REPLACE_STATE_FINISHED:
> @@ -994,6 +995,7 @@ static int btrfs_dev_replace_finishing(struct
> btrfs_fs_info *fs_info,
>          list_add(&tgt_device->dev_alloc_list, &fs_devices->alloc_list);
>          fs_devices->rw_devices++;
>
> +       dev_replace->replace_task =3D NULL;
>          up_write(&dev_replace->rwsem);
>          btrfs_rm_dev_replace_blocked(fs_info);
>
> diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
> index 79f64e383edd..cbfb225858a5 100644
> --- a/fs/btrfs/fs.h
> +++ b/fs/btrfs/fs.h
> @@ -317,6 +317,8 @@ struct btrfs_dev_replace {
>
>          struct percpu_counter bio_counter;
>          wait_queue_head_t replace_wait;
> +
> +       struct task_struct *replace_task;
>   };
>
>   /*
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index 8f340ad1d938..995b0647f538 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -6480,13 +6480,15 @@ int btrfs_map_block(struct btrfs_fs_info
> *fs_info, enum btrfs_map_op op,
>          max_len =3D btrfs_max_io_len(map, map_offset, &io_geom);
>          *length =3D min_t(u64, map->chunk_len - map_offset, max_len);
>
> -       down_read(&dev_replace->rwsem);
> +       if (dev_replace->replace_task !=3D current)
> +               down_read(&dev_replace->rwsem);
> +
>          dev_replace_is_ongoing =3D btrfs_dev_replace_is_ongoing(dev_repl=
ace);
>          /*
>           * Hold the semaphore for read during the whole operation, write=
 is
>           * requested at commit time but must wait.
>           */
> -       if (!dev_replace_is_ongoing)
> +       if (!dev_replace_is_ongoing && dev_replace->replace_task !=3D cur=
rent)
>                  up_read(&dev_replace->rwsem);
>
>          switch (map->type & BTRFS_BLOCK_GROUP_PROFILE_MASK) {
> @@ -6626,7 +6628,7 @@ int btrfs_map_block(struct btrfs_fs_info *fs_info,
> enum btrfs_map_op op,
>          bioc->mirror_num =3D io_geom.mirror_num;
>
>   out:
> -       if (dev_replace_is_ongoing) {
> +       if (dev_replace_is_ongoing && dev_replace->replace_task !=3D
> current) {
>                  lockdep_assert_held(&dev_replace->rwsem);
>                  /* Unlock and let waiting writers proceed */
>                  up_read(&dev_replace->rwsem);
>
>
> >
> > What this patch is doing is fishy, because it's setting
> > dev_replace_is_ongoing to false when there's an actual dev replace in
> > progress.
> > By setting it to false we are preventing the redirection of a write to
> > the new device.
> >
> > Was that intentional? If so, why (the changelog doesn't mention it,
> > and that's a very important detail)?
>
> Nope that was unintentional. Thanks for spotting.
>
> > For my suggestion, since we will skip the locking of the semaphore,
> > we'll have to compare "current" with "dev_replace->replace_task"
> > without any locking,
> > but that's ok and we can use data_race() to silence KCSAN.
>
> I'll check if KCSAN actually complains about this.
>
> As for David's remark, do you prefere a pid or a task_struct to be
> stored in struct dev_replace?

I'm fine with either one.

Thanks.

>
> Thanks,
>         Johannes

