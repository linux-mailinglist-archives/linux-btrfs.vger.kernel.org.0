Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59E391AE329
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Apr 2020 19:07:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728205AbgDQRHH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Apr 2020 13:07:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727913AbgDQRHG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Apr 2020 13:07:06 -0400
Received: from mail-vk1-xa44.google.com (mail-vk1-xa44.google.com [IPv6:2607:f8b0:4864:20::a44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F7A4C061A0C
        for <linux-btrfs@vger.kernel.org>; Fri, 17 Apr 2020 10:07:06 -0700 (PDT)
Received: by mail-vk1-xa44.google.com with SMTP id 10so749986vkr.7
        for <linux-btrfs@vger.kernel.org>; Fri, 17 Apr 2020 10:07:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=xDfDsyJp0qQG9YB7HR7ELhU0hc5XdLVfiE/nL21JPGw=;
        b=DUTUChJ7eqAWmeEnc97taSr4nXwR1snTxcOA5LxU9lwwB7H9YbHRBY89cPztrRyjZ6
         0SpcUr038yiuk5HfuW9J4jIqhYmGkgyBCQgOON0ZWweE9K1hJTyY5aKMdPyYgV8Reony
         An9gBBEMrU05acjyDm0VUjYwMVHQ21h7JR40u2Q+Mv1lI/L0MaGoPmRirTkR1NBS8zct
         TcMdqHW/9PHY3fXYh7o1DgSEpjRB2RDqvwlwqU5iUJH89vWooC8/nOLAZ1o5n41aID/M
         G1FuoyUoFBstR7FTuNI3fOVFqmFyTRXOzO7lob5ThEX6wXfRNh4DysmcmFUYbvAVRfnn
         B2vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=xDfDsyJp0qQG9YB7HR7ELhU0hc5XdLVfiE/nL21JPGw=;
        b=cg80TRBt7fWB6jjLKbvm+tNaiET7P9BzsmDbH3cJTRe7/lZER9QrBAaVAmxqDqBgqs
         k8FWMUnmRDVovW1/cO/BE6RU7aCd3HkKLzXdNnoEAfpkIYa6xvq22DpBLk3H7IGC87Wa
         OEP0mbGEPFoniJicSC36FKdenK/FA3VewzlOq1F/LhLYAs4mM8fmLsnc2Chp25daM6fI
         JGVQLI0Oo0eXZBuHDAiqKcZrJbpX2eALIcNBgaBZNkD8zKGN8bci8ahk0H8Jtm6V0uty
         BrlqEWAD6F/lZP2Y0b0Ckl5BCgv0g4KFC2GeAoekLghMpUE7FMG4dXv8YK1vrwEWkXaf
         xmFg==
X-Gm-Message-State: AGi0Puajg4AQG4O1+JYwgJnzFgt74bXTpkgWv7gxvT3gMDVNG1xrdTea
        pCGKUTggk4zjUBTGyjGl+m1SnsOC0bwQ0VNjZoo=
X-Google-Smtp-Source: APiQypJXGszTfF6F2NfwD8zmnRe4p7rNo6CyaKM+11NzW+XNq8Fvwwqz7xhZEB80Ss5DMxuM4TaIK6oi12Vki7WRXXE=
X-Received: by 2002:a1f:d145:: with SMTP id i66mr3427179vkg.24.1587143225296;
 Fri, 17 Apr 2020 10:07:05 -0700 (PDT)
MIME-Version: 1.0
References: <20200324144752.9541-1-josef@toxicpanda.com> <CAL3q7H6rrXEYgQ+yE97nOrYxEKarDci0qjs0hM8VtOMOF6=khw@mail.gmail.com>
In-Reply-To: <CAL3q7H6rrXEYgQ+yE97nOrYxEKarDci0qjs0hM8VtOMOF6=khw@mail.gmail.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Fri, 17 Apr 2020 18:06:54 +0100
Message-ID: <CAL3q7H4sfdeagShohQUC_Mp2KBkkNqxwHCVgDto25dbRrkDqrA@mail.gmail.com>
Subject: Re: [PATCH] btrfs: drop logs when we've aborted a transaction
To:     Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Apr 16, 2020 at 2:16 PM Filipe Manana <fdmanana@gmail.com> wrote:
>
> On Tue, Mar 24, 2020 at 2:48 PM Josef Bacik <josef@toxicpanda.com> wrote:
> >
> > Dave reported a problem where we were panicing with generic/475 with
> > misc-5.7.  This is because we were doing IO after we had stopped all of
> > the worker threads, because we do the log tree cleanup on roots at drop
> > time.  Cleaning up the log tree may need to do reads if we happened to
> > have evicted the blocks from memory.
>
> Here the "may need" is actually a "will always need", because before
> calling btrfs_free_fs_roots() at close_ctree(),
> we drop all the extent buffers from memory from the btree inode
> through the call to invalidate_inode_pages2().
>
> So this causes a use-after-free on the workqueues used for reads while
> traversing the log trees during the log dropping, since the workqueues
> were freed before right after invalidate_inode_pages2(),
> everytime we abort a transaction and we have at least one log root
> around that is big enough to not consist of only one leaf.
>
> >
> > Because of this simply add a helper to btrfs_cleanup_transaction() that
> > will go through and drop all of the log roots.  This gets run before we
> > do the close_ctree() work, and thus we are allowed to do any reads that
> > we would need.  I ran this through many iterations of generic/475 with
> > constrained memory and I did not see the issue.
> >
> > Signed-off-by: Josef Bacik <josef@toxicpanda.com>
>
> Fixes: 8c38938c7bb096 ("btrfs: move the root freeing stuff into btrfs_put=
_root")
> Reviewed-by: Filipe Manana <fdmanana@suse.com>

Also, a sample stack trace of when this happens would be good to have
in the changelog:

[24862.061099] general protection fault, probably for non-canonical
address 0x6b6b6b6b6b6b6b6b: 0000 [#1] PREEMPT SMP DEBUG_PAGEALLOC PTI
[24862.063225] CPU: 2 PID: 12359 Comm: umount Tainted: G        W
   5.6.0-rc7-btrfs-next-58 #1
[24862.064892] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
BIOS rel-1.12.0-59-gc9ba5276e321-prebuilt.qemu.org 04/01/2014
[24862.067078] RIP: 0010:btrfs_queue_work+0x33/0x1c0 [btrfs]
[24862.068085] Code: 41 55 41 54 55 53 48 89 f5 48 83 ec 08 48 8b 46
70 a8 04 0f 84 a3 00 00 00 4c 8b 67 08 4d 85 e4 0f 84 96 00 00 00 4c
89 65 68 <41> 83 7c 24 64 ff 74 06 f0 41 ff 44 24 58 48 83 7d 08 00 74
41 49
[24862.071550] RSP: 0018:ffff9cfb015937d8 EFLAGS: 00010246
[24862.072424] RAX: 0000000000000000 RBX: ffff8eb5e339ed80 RCX: 00000000000=
00000
[24862.073754] RDX: 0000000000000001 RSI: ffff8eb5eb33b770 RDI: ffff8eb5e37=
a0460
[24862.075084] RBP: ffff8eb5eb33b770 R08: 000000000000020c R09: ffffffff9fc=
09ac0
[24862.076439] R10: 0000000000000007 R11: 0000000000000000 R12: 6b6b6b6b6b6=
b6b6b
[24862.077769] R13: ffff9cfb00229040 R14: 0000000000000008 R15: ffff8eb5d38=
68000
[24862.079102] FS:  00007f167ea022c0(0000) GS:ffff8eb5fae00000(0000)
knlGS:0000000000000000
[24862.080620] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[24862.081696] CR2: 00007f167e5e0cb1 CR3: 0000000138c18004 CR4: 00000000003=
606e0
[24862.083049] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 00000000000=
00000
[24862.084396] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 00000000000=
00400
[24862.085739] Call Trace:
[24862.086250]  btrfs_end_bio+0x81/0x130 [btrfs]
[24862.087025]  __split_and_process_bio+0xaf/0x4e0 [dm_mod]
[24862.087980]  ? percpu_counter_add_batch+0xa3/0x120
[24862.088831]  dm_process_bio+0x98/0x290 [dm_mod]
[24862.089695]  ? generic_make_request+0xfb/0x410
[24862.090523]  dm_make_request+0x4d/0x120 [dm_mod]
[24862.091101]  ? generic_make_request+0xfb/0x410
[24862.091893]  generic_make_request+0x12a/0x410
[24862.092724]  ? submit_bio+0x38/0x160
[24862.093403]  submit_bio+0x38/0x160
[24862.094052]  ? percpu_counter_add_batch+0xa3/0x120
[24862.094987]  btrfs_map_bio+0x289/0x570 [btrfs]
[24862.095844]  ? kmem_cache_alloc+0x24d/0x300
[24862.096668]  btree_submit_bio_hook+0x79/0xc0 [btrfs]
[24862.097621]  submit_one_bio+0x31/0x50 [btrfs]
[24862.098460]  read_extent_buffer_pages+0x2fe/0x450 [btrfs]
[24862.099490]  btree_read_extent_buffer_pages+0x7e/0x170 [btrfs]
[24862.100613]  walk_down_log_tree+0x343/0x690 [btrfs]
[24862.101551]  ? walk_log_tree+0x3d/0x380 [btrfs]
[24862.102423]  walk_log_tree+0xf7/0x380 [btrfs]
[24862.103244]  ? plist_requeue+0xf0/0xf0
[24862.103946]  ? delete_node+0x4b/0x230
[24862.104669]  free_log_tree+0x4c/0x130 [btrfs]
[24862.105519]  ? wait_log_commit+0x140/0x140 [btrfs]
[24862.106434]  btrfs_free_log+0x17/0x30 [btrfs]
[24862.107274]  btrfs_drop_and_free_fs_root+0xb0/0xd0 [btrfs]
[24862.108025]  btrfs_free_fs_roots+0x10c/0x190 [btrfs]
[24862.108673]  ? do_raw_spin_unlock+0x49/0xc0
[24862.109197]  ? _raw_spin_unlock+0x29/0x40
[24862.109708]  ? release_extent_buffer+0x121/0x170 [btrfs]
[24862.110379]  close_ctree+0x289/0x2e6 [btrfs]
[24862.110911]  generic_shutdown_super+0x6c/0x110
[24862.111461]  kill_anon_super+0xe/0x30
[24862.111926]  btrfs_kill_super+0x12/0x20 [btrfs]
[24862.112498]  deactivate_locked_super+0x3a/0x70
[24862.113043]  cleanup_mnt+0xb4/0x150
[24862.113478]  task_work_run+0x7e/0xc0
[24862.114108]  exit_to_usermode_loop+0xfa/0x100
[24862.114924]  do_syscall_64+0x20c/0x280
[24862.115622]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
[24862.116557] RIP: 0033:0x7f167e2ecb37
[24862.117169] Code: 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f
44 00 00 31 f6 e9 09 00 00 00 66 0f 1f 84 00 00 00 00 00 b8 a6 00 00
00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 31 03 2b 00 f7 d8 64 89
01 48
[24862.120429] RSP: 002b:00007ffdd2cceb58 EFLAGS: 00000246 ORIG_RAX:
00000000000000a6
[24862.121729] RAX: 0000000000000000 RBX: 000055de5c568060 RCX: 00007f167e2=
ecb37
[24862.122969] RDX: 0000000000000001 RSI: 0000000000000000 RDI: 000055de5c5=
68240
[24862.124221] RBP: 000055de5c568240 R08: 000055de5c568270 R09: 00000000000=
00015
[24862.125449] R10: 00000000000006b4 R11: 0000000000000246 R12: 00007f167e7=
eee64
[24862.126659] R13: 0000000000000000 R14: 0000000000000000 R15: 00007ffdd2c=
cede0
[24862.127611] Modules linked in: btrfs dm_mod loop blake2b_generic
xor raid6_pq libcrc32c intel_rapl_msr intel_rapl_common kvm_intel kvm
irqbypass crct10dif_pclmul crc32_pclmul ghash_clmulni_intel bochs_drm
aesni_intel crypto_simd drm_vram_helper drm_ttm_helper cryptd
glue_helper ttm drm_kms_helper joydev evdev drm sg pcspkr serio_raw
button qemu_fw_cfg parport_pc ppdev lp parport ip_tables x_tables
autofs4 ext4 crc32c_generic crc16 mbcache jbd2 sd_mod t10_pi
virtio_scsi ata_generic ata_piix crc32c_intel libata psmouse scsi_mod
virtio_pci e1000 virtio_ring virtio i2c_piix4 [last unloaded: btrfs]
[24862.134473] ---[ end trace 7ec1a70e82f52891 ]---


David, this is a regression introduced in 5.7-rc1, and it's very easy
to hit with generic/475.
Any reason this wasn't picked yet, despite having been posted several weeks=
 ago?

Thanks.

>
> Thanks.
>
> >
> > ---
> >  fs/btrfs/disk-io.c | 36 ++++++++++++++++++++++++++++++++----
> >  1 file changed, 32 insertions(+), 4 deletions(-)
> >
> > diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> > index a6cb5cbbdb9f..d10c7be10f3b 100644
> > --- a/fs/btrfs/disk-io.c
> > +++ b/fs/btrfs/disk-io.c
> > @@ -2036,9 +2036,6 @@ void btrfs_free_fs_roots(struct btrfs_fs_info *fs=
_info)
> >                 for (i =3D 0; i < ret; i++)
> >                         btrfs_drop_and_free_fs_root(fs_info, gang[i]);
> >         }
> > -
> > -       if (test_bit(BTRFS_FS_STATE_ERROR, &fs_info->fs_state))
> > -               btrfs_free_log_root_tree(NULL, fs_info);
> >  }
> >
> >  static void btrfs_init_scrub(struct btrfs_fs_info *fs_info)
> > @@ -3888,7 +3885,7 @@ void btrfs_drop_and_free_fs_root(struct btrfs_fs_=
info *fs_info,
> >         spin_unlock(&fs_info->fs_roots_radix_lock);
> >
> >         if (test_bit(BTRFS_FS_STATE_ERROR, &fs_info->fs_state)) {
> > -               btrfs_free_log(NULL, root);
> > +               ASSERT(root->log_root =3D=3D NULL);
> >                 if (root->reloc_root) {
> >                         btrfs_put_root(root->reloc_root);
> >                         root->reloc_root =3D NULL;
> > @@ -4211,6 +4208,36 @@ static void btrfs_error_commit_super(struct btrf=
s_fs_info *fs_info)
> >         up_write(&fs_info->cleanup_work_sem);
> >  }
> >
> > +static void btrfs_drop_all_logs(struct btrfs_fs_info *fs_info)
> > +{
> > +       struct btrfs_root *gang[8];
> > +       u64 root_objectid =3D 0;
> > +       int ret;
> > +
> > +       spin_lock(&fs_info->fs_roots_radix_lock);
> > +       while ((ret =3D radix_tree_gang_lookup(&fs_info->fs_roots_radix=
,
> > +                                            (void **)gang, root_object=
id,
> > +                                            ARRAY_SIZE(gang))) !=3D 0)=
 {
> > +               int i;
> > +
> > +               for (i =3D 0; i < ret; i++)
> > +                       gang[i] =3D btrfs_grab_root(gang[i]);
> > +               spin_unlock(&fs_info->fs_roots_radix_lock);
> > +
> > +               for (i =3D 0; i < ret; i++) {
> > +                       if (!gang[i])
> > +                               continue;
> > +                       root_objectid =3D gang[i]->root_key.objectid;
> > +                       btrfs_free_log(NULL, gang[i]);
> > +                       btrfs_put_root(gang[i]);
> > +               }
> > +               root_objectid++;
> > +               spin_lock(&fs_info->fs_roots_radix_lock);
> > +       }
> > +       spin_unlock(&fs_info->fs_roots_radix_lock);
> > +       btrfs_free_log_root_tree(NULL, fs_info);
> > +}
> > +
> >  static void btrfs_destroy_ordered_extents(struct btrfs_root *root)
> >  {
> >         struct btrfs_ordered_extent *ordered;
> > @@ -4603,6 +4630,7 @@ static int btrfs_cleanup_transaction(struct btrfs=
_fs_info *fs_info)
> >         btrfs_destroy_delayed_inodes(fs_info);
> >         btrfs_assert_delayed_root_empty(fs_info);
> >         btrfs_destroy_all_delalloc_inodes(fs_info);
> > +       btrfs_drop_all_logs(fs_info);
> >         mutex_unlock(&fs_info->transaction_kthread_mutex);
> >
> >         return 0;
> > --
> > 2.17.1
> >
>
>
> --
> Filipe David Manana,
>
> =E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you'=
re right.=E2=80=9D



--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
