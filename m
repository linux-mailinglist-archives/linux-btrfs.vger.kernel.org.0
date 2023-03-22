Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD71E6C47C2
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Mar 2023 11:36:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230303AbjCVKf7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 22 Mar 2023 06:35:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230272AbjCVKf6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 22 Mar 2023 06:35:58 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D347D56503;
        Wed, 22 Mar 2023 03:35:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 84342B81BF5;
        Wed, 22 Mar 2023 10:35:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D825C433EF;
        Wed, 22 Mar 2023 10:35:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679481354;
        bh=oTDESu3u5w3wCPmqBC3F2IGrs5qDSh58zq87j8LfSnA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=kST/UJzhGCgiqDAtjqg9toOOcnnUXb+e1uP+V9mY0xZZm0eu4OX/Udqb4A4kc8aJv
         aWLUVx5RA4Eg5tuB3Z6hgazO0O6AiXhk4lHf+ECh5eAl6Zc4bEY9xAAwUBFMss/iFp
         hyrWvORZ8QAhE9IHlsTqRaSidWup8VVXV2hXPiK1He0+zCAMxB3JQaulQQMIxWxwOi
         oNYhEx/nwbdZlXgjk5E8GkyyNOLZbBCReteWZOFIlUUTLaBWMBpzE7skwv0tM6ZpyH
         e38ZPGyGapJIUK3ZpHdjjTtN/z1pWLgmSDTPF3be7uvMxsl1Ct73u8NrLn99MG5iZo
         kIYafIOAuhJDA==
Received: by mail-oi1-f178.google.com with SMTP id bj20so3790395oib.3;
        Wed, 22 Mar 2023 03:35:54 -0700 (PDT)
X-Gm-Message-State: AO0yUKXRuUKdNXTBroM10kgT7d9GRXBC1IsD0zK6rC1rI8FELDEccxgw
        hGLrwyefYs2OPK4ziw9A2T6ClFae1ZvXV2PVWS0=
X-Google-Smtp-Source: AK7set+1nQu5vSC9HACgUOSLcJcSYa7bP4Lu8c+xzdBDnA6hzBDMshPO5kpdFK5jJvZqCoOFup0yarxYytc0oztwVew=
X-Received: by 2002:a05:6808:6286:b0:378:573b:ca8d with SMTP id
 du6-20020a056808628600b00378573bca8dmr817607oib.6.1679481353291; Wed, 22 Mar
 2023 03:35:53 -0700 (PDT)
MIME-Version: 1.0
References: <CAFcO6XN3VD8ogmHwqRk4kbiwtpUSNySu2VAxN8waEPciCHJvMA@mail.gmail.com>
In-Reply-To: <CAFcO6XN3VD8ogmHwqRk4kbiwtpUSNySu2VAxN8waEPciCHJvMA@mail.gmail.com>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Wed, 22 Mar 2023 10:35:16 +0000
X-Gmail-Original-Message-ID: <CAL3q7H5v4xchGWOuHiaVLhK8+mZkphQvOYEP68pcmyYKwRwm=g@mail.gmail.com>
Message-ID: <CAL3q7H5v4xchGWOuHiaVLhK8+mZkphQvOYEP68pcmyYKwRwm=g@mail.gmail.com>
Subject: Re: KASAN: A slab-use-after-free Read bug in btrfs_search_slot in fs/btrfs/ctree.c
To:     butt3rflyh4ck <butterflyhuangxx@gmail.com>
Cc:     clm@fb.com, Josef Bacik <josef@toxicpanda.com>, dsterba@suse.com,
        linux-btrfs@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Mar 22, 2023 at 9:08=E2=80=AFAM butt3rflyh4ck
<butterflyhuangxx@gmail.com> wrote:
>
> Hi, there is a slab-use-after-free Read bug in btrfs_search_slot in
> fs/btrfs/ctree.c, I reproduce it in the latest kernel too.
>
> #simple analysis
> When a thread calls BTRFS_QUOTA_CTL_ENABLE to create a new quota tree
> and then calls BTRFS_QUOTA_CTL_DISABLE to release a quota tree, there
> is a race condition window in between. During this time, if another
> thread calls BTRFS_IOC_QGROUP_ASSIGN to update the status and
> information of the dirty qgroup, it would call update_qgroup_info_item
> to update, it may trigger a use-after-free (UAF) vulnerability.

Thanks for the report, I've just sent a patch to fix it:

https://lore.kernel.org/linux-btrfs/35b9a70650ea947387cf352914a8774b4f7e8a6=
f.1679481128.git.fdmanana@suse.com/


>
> #crash log
> [74672.719605][T27736]
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [74672.720403][T27736] BUG: KASAN: slab-use-after-free in
> btrfs_search_slot+0x2962/0x2db0
> [74672.721113][T27736] Read of size 8 at addr ffff888022ec0208 by task
> btrfs_search_sl/27736
> [74672.721794][T27736]
> [74672.721995][T27736] CPU: 1 PID: 27736 Comm: btrfs_search_sl Not
> tainted 6.3.0-rc3 #37
> [74672.722653][T27736] Hardware name: QEMU Standard PC (i440FX + PIIX,
> 1996), BIOS 1.15.0-1 04/01/2014
> [74672.723377][T27736] Call Trace:
> [74672.723688][T27736]  <TASK>
> [74672.723968][T27736]  dump_stack_lvl+0xd9/0x150
> [74672.724405][T27736]  print_report+0xc1/0x5e0
> [74672.724810][T27736]  ? __virt_addr_valid+0x61/0x2e0
> [74672.725247][T27736]  ? __phys_addr+0xc9/0x150
> [74672.725635][T27736]  ? btrfs_search_slot+0x2962/0x2db0
> [74672.726092][T27736]  kasan_report+0xc0/0xf0
> [74672.726469][T27736]  ? btrfs_search_slot+0x2962/0x2db0
> [74672.726934][T27736]  btrfs_search_slot+0x2962/0x2db0
> [74672.727373][T27736]  ? fs_reclaim_acquire+0xba/0x160
> [74672.727802][T27736]  ? split_leaf+0x13d0/0x13d0
> [74672.728236][T27736]  ? rcu_is_watching+0x12/0xb0
> [74672.728673][T27736]  ? kmem_cache_alloc+0x338/0x3c0
> [74672.729132][T27736]  update_qgroup_status_item+0xf7/0x320
> [74672.729614][T27736]  ? add_qgroup_rb+0x3d0/0x3d0
> [74672.730019][T27736]  ? do_raw_spin_lock+0x12d/0x2b0
> [74672.730470][T27736]  ? spin_bug+0x1d0/0x1d0
> [74672.730847][T27736]  btrfs_run_qgroups+0x5de/0x840
> [74672.731290][T27736]  ? btrfs_qgroup_rescan_worker+0xa70/0xa70
> [74672.731788][T27736]  ? __del_qgroup_relation+0x4ba/0xe00
> [74672.732288][T27736]  btrfs_ioctl+0x3d58/0x5d80
> [74672.732705][T27736]  ? tomoyo_path_number_perm+0x16a/0x550
> [74672.733217][T27736]  ? tomoyo_execute_permission+0x4a0/0x4a0
> [74672.733701][T27736]  ? btrfs_ioctl_get_supported_features+0x50/0x50
> [74672.734237][T27736]  ? __sanitizer_cov_trace_switch+0x54/0x90
> [74672.734754][T27736]  ? do_vfs_ioctl+0x132/0x1660
> [74672.735170][T27736]  ? vfs_fileattr_set+0xc40/0xc40
> [74672.735610][T27736]  ? _raw_spin_unlock_irq+0x2e/0x50
> [74672.736092][T27736]  ? sigprocmask+0xf2/0x340
> [74672.736497][T27736]  ? __fget_files+0x26a/0x480
> [74672.736932][T27736]  ? bpf_lsm_file_ioctl+0x9/0x10
> [74672.737368][T27736]  ? btrfs_ioctl_get_supported_features+0x50/0x50
> [74672.737936][T27736]  __x64_sys_ioctl+0x198/0x210
> [74672.738356][T27736]  do_syscall_64+0x39/0xb0
> [74672.738751][T27736]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> [74672.739289][T27736] RIP: 0033:0x4556ad
> [74672.739634][T27736] Code: c3 e8 c7 1f 00 00 0f 1f 80 00 00 00 00 f3
> 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b
> 4c 24 08 0f 05 <48> 3d 01 f8
> [74672.741232][T27736] RSP: 002b:00007fa5f496b178 EFLAGS: 00000283
> ORIG_RAX: 0000000000000010
> [74672.741930][T27736] RAX: ffffffffffffffda RBX: 00007fa5f496b640
> RCX: 00000000004556ad
> [74672.742601][T27736] RDX: 0000000020000000 RSI: 0000000040189429
> RDI: 0000000000000003
> [74672.743245][T27736] RBP: 00007fa5f496b1a0 R08: 0000000000000000
> R09: 0000000000000000
> [74672.743919][T27736] R10: 0000000000000000 R11: 0000000000000283
> R12: 00007fa5f496b640
> [74672.744622][T27736] R13: 000000000000006e R14: 0000000000417b20
> R15: 00007fa5f494b000
> [74672.745272][T27736]  </TASK>
> [74672.745533][T27736]
> [74672.745778][T27736] Allocated by task 27677:
> [74672.746163][T27736]  kasan_save_stack+0x22/0x40
> [74672.746571][T27736]  kasan_set_track+0x25/0x30
> [74672.746981][T27736]  __kasan_kmalloc+0xa4/0xb0
> [74672.747439][T27736]  btrfs_alloc_root+0x48/0x90
> [74672.747856][T27736]  btrfs_create_tree+0x146/0xa20
> [74672.748294][T27736]  btrfs_quota_enable+0x461/0x1d20
> [74672.748683][T27736]  btrfs_ioctl+0x4a1c/0x5d80
> [74672.749057][T27736]  __x64_sys_ioctl+0x198/0x210
> [74672.749429][T27736]  do_syscall_64+0x39/0xb0
> [74672.749774][T27736]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> [74672.750646][T27736]
> [74672.750937][T27736] Freed by task 27677:
> [74672.751699][T27736]  kasan_save_stack+0x22/0x40
> [74672.752479][T27736]  kasan_set_track+0x25/0x30
> [74672.753236][T27736]  kasan_save_free_info+0x2e/0x50
> [74672.754041][T27736]  ____kasan_slab_free+0x162/0x1c0
> [74672.754948][T27736]  slab_free_freelist_hook+0x89/0x1c0
> [74672.755822][T27736]  __kmem_cache_free+0xaf/0x2e0
> [74672.756642][T27736]  btrfs_put_root+0x1ff/0x2b0
> [74672.757379][T27736]  btrfs_quota_disable+0x80a/0xbc0
> [74672.758262][T27736]  btrfs_ioctl+0x3e5f/0x5d80
> [74672.758996][T27736]  __x64_sys_ioctl+0x198/0x210
> [74672.759843][T27736]  do_syscall_64+0x39/0xb0
> [74672.760685][T27736]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> [74672.761639][T27736]
> [74672.762018][T27736] The buggy address belongs to the object at
> ffff888022ec0000
> [74672.762018][T27736]  which belongs to the cache kmalloc-4k of size 409=
6
> [74672.764569][T27736] The buggy address is located 520 bytes inside of
> [74672.764569][T27736]  freed 4096-byte region [ffff888022ec0000,
> ffff888022ec1000)
> [74672.766900][T27736]
> [74672.767254][T27736] The buggy address belongs to the physical page:
> [74672.768271][T27736] page:ffffea00008bb000 refcount:1 mapcount:0
> mapping:0000000000000000 index:0x0 pfn:0x22ec0
> [74672.769366][T27736] head:ffffea00008bb000 order:3 entire_mapcount:0
> nr_pages_mapped:0 pincount:0
> [74672.770239][T27736] flags:
> 0xfff00000010200(slab|head|node=3D0|zone=3D1|lastcpupid=3D0x7ff)
> [74672.771510][T27736] raw: 00fff00000010200 ffff888012842140
> ffffea000054ba00 dead000000000002
> [74672.772770][T27736] raw: 0000000000000000 0000000000040004
> 00000001ffffffff 0000000000000000
> [74672.773941][T27736] page dumped because: kasan: bad access detected
> [74672.774788][T27736] page_owner tracks the page as allocated
> [74672.775407][T27736] page last allocated via order 3, migratetype
> Unmovable, gfp_mask
> 0xd2040(__GFP_IO|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC),
> pid 88
> [74672.777249][T27736]  get_page_from_freelist+0x119c/0x2d50
> [74672.777719][T27736]  __alloc_pages+0x1cb/0x4a0
> [74672.778106][T27736]  alloc_pages+0x1aa/0x270
> [74672.778493][T27736]  allocate_slab+0x260/0x390
> [74672.778901][T27736]  ___slab_alloc+0xa9a/0x13e0
> [74672.779308][T27736]  __slab_alloc.constprop.0+0x56/0xb0
> [74672.779771][T27736]  __kmem_cache_alloc_node+0x136/0x320
> [74672.780479][T27736]  __kmalloc+0x4e/0x1a0
> [74672.781123][T27736]  tomoyo_realpath_from_path+0xc3/0x600
> [74672.782021][T27736]  tomoyo_path_perm+0x22f/0x420
> [74672.782862][T27736]  tomoyo_path_unlink+0x92/0xd0
> [74672.783780][T27736]  security_path_unlink+0xdb/0x150
> [74672.784648][T27736]  do_unlinkat+0x377/0x680
> [74672.785278][T27736]  __x64_sys_unlink+0xca/0x110
> [74672.785959][T27736]  do_syscall_64+0x39/0xb0
> [74672.786623][T27736]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> [74672.787544][T27736] page last free stack trace:
> [74672.788247][T27736]  free_pcp_prepare+0x4e5/0x920
> [74672.789067][T27736]  free_unref_page+0x1d/0x4e0
> [74672.789854][T27736]  __unfreeze_partials+0x17c/0x1a0
> [74672.790707][T27736]  qlist_free_all+0x6a/0x180
> [74672.791406][T27736]  kasan_quarantine_reduce+0x189/0x1d0
> [74672.792277][T27736]  __kasan_slab_alloc+0x64/0x90
> [74672.793033][T27736]  kmem_cache_alloc+0x17c/0x3c0
> [74672.793789][T27736]  getname_flags.part.0+0x50/0x4e0
> [74672.794559][T27736]  getname_flags+0x9e/0xe0
> [74672.795202][T27736]  vfs_fstatat+0x77/0xb0
> [74672.795861][T27736]  __do_sys_newlstat+0x84/0x100
> [74672.796638][T27736]  do_syscall_64+0x39/0xb0
> [74672.797276][T27736]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> [74672.798060][T27736]
> [74672.798411][T27736] Memory state around the buggy address:
> [74672.799239][T27736]  ffff888022ec0100: fb fb fb fb fb fb fb fb fb
> fb fb fb fb fb fb fb
> [74672.800425][T27736]  ffff888022ec0180: fb fb fb fb fb fb fb fb fb
> fb fb fb fb fb fb fb
> [74672.801562][T27736] >ffff888022ec0200: fb fb fb fb fb fb fb fb fb
> fb fb fb fb fb fb fb
> [74672.802809][T27736]                       ^
> [74672.803509][T27736]  ffff888022ec0280: fb fb fb fb fb fb fb fb fb
> fb fb fb fb fb fb fb
> [74672.804419][T27736]  ffff888022ec0300: fb fb fb fb fb fb fb fb fb
> fb fb fb fb fb fb fb
> [74672.805112][T27736]
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
>
> Regards,
>  butt3rflyh4ck.
>
> --
> Active Defense Lab of Venustech
