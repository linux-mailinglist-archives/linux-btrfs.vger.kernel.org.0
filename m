Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBF3A718BAF
	for <lists+linux-btrfs@lfdr.de>; Wed, 31 May 2023 23:17:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229681AbjEaVRF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 31 May 2023 17:17:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbjEaVRE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 31 May 2023 17:17:04 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1F09B3
        for <linux-btrfs@vger.kernel.org>; Wed, 31 May 2023 14:17:00 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id 41be03b00d2f7-517ab9a4a13so117827a12.1
        for <linux-btrfs@vger.kernel.org>; Wed, 31 May 2023 14:17:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bashdev.org; s=google; t=1685567820; x=1688159820;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xvcUKREt7DGGmkkywW7+2cW+ijG77lyLHrNkaFRfCOI=;
        b=NxIr46ODJBlW0grgWWUaSMRvP9w08DJxaT5U10BkpkpZbCArC6rM9Y918mCm7uRJnH
         Fxud8PSjAARRKGGlq7rMz93wiECp0rOSV7hLrOH6P2eoW0tilDoeDQS76G3AabzJC70e
         1hZ1s1MmG8HoQrJMVxclyYTKrN+YhXUSYOtU0bMbRTgQ8Pe4kreT99LMH5cYkBG8ftBh
         ltgOY7gbl0sdPvItlfdTF026TyCjBp7B6OVG6fye4ul3UqSSpd2GeWJLlQmf+/++Ttnf
         +OXXvhaK+94wQVHaw5W/UQ97NsI3aeGpFi6X1nGvW+JJfPLj0R+hE2TG6WT6BSqb8Ah0
         iA6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685567820; x=1688159820;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xvcUKREt7DGGmkkywW7+2cW+ijG77lyLHrNkaFRfCOI=;
        b=Gcdj49W3sDAsGy+YXxAgm3pamtL4zsXcS3i4/m1Oia7ooOu4fBOKfP3LgGYpVzUH+Z
         9iOHAH80vg/1lW9D+VSJgadGF1IQFeTCIIbzqw18+sEGB1FlUJTUlQveoRAeZL76/W+b
         c4wEEljtl230JK4C+NA48ewXWj7Oi9AqHXwGL/1gr/icuIIbWyK/lkMKwn8lovfoA31j
         tX31TEFkS/9a8FgY4G9l/QSkQyB2f+ZmD+A1iD1Km60GZgHBx/fw4fmbDCaILjJwjtYb
         GZCB6hbk1AlgMsG/G3YsODI65K7NNHXBMh+Kde99kcNSrXjYERFbPG7tnFXwQdSeOnvw
         K9hQ==
X-Gm-Message-State: AC+VfDxmfRlDudn6CDcy5z9g3GToAL+q9RlHe0IpkWkqILBbrZpgT9yf
        /QqV8U/BrDRDgxhUJC/8d2csLv86qLsptXt5VjSJAdThl37ruKCbA5A=
X-Google-Smtp-Source: ACHHUZ7um4kmkCgKRGk10K7IXqa3cLgtx2kVprimjnlPPPkYWDFwHCotlb98yzEdus8YSelAhfpxPCbbPinFuyr/4V8=
X-Received: by 2002:a05:6a21:6da3:b0:105:e434:670b with SMTP id
 wl35-20020a056a216da300b00105e434670bmr8882114pzb.4.1685567820064; Wed, 31
 May 2023 14:17:00 -0700 (PDT)
MIME-Version: 1.0
References: <CAMmhH1vkKS2Ot0TyJZ+sDFXhi_-YTWcBkQhSfFxrXmdEAJtK5Q@mail.gmail.com>
 <20230529140714.GG575@twin.jikos.cz> <CAMmhH1vrgLtHHadL7c8u1Pew21rg49UrrCfQCcS8oyGB4K4Krg@mail.gmail.com>
In-Reply-To: <CAMmhH1vrgLtHHadL7c8u1Pew21rg49UrrCfQCcS8oyGB4K4Krg@mail.gmail.com>
From:   ash lee <ash@bashdev.org>
Date:   Wed, 31 May 2023 16:16:49 -0500
Message-ID: <CAMmhH1u3ztraf6LBY1VBJ45brEj1rd2Miv6bdR8FsjL9ETzN6A@mail.gmail.com>
Subject: Re: BTRFS kernel BUG at fs/inode.c;611!
To:     dsterba@suse.cz
Cc:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

the second, which may be related, can be replicated whenever i run
"btdu". The symptom itself is that my entire system freezes and
becomes unrecoverable. this seems related to me having issues whenever
there is high amounts of load on BTRFS

In my kernel logs shows the following. (with a bunch of similar angry
messages around it).

Interestingly, i'm actually able to run balance with a smaller dusage.

May 31 06:11:30 dog kernel: ------------[ cut here ]------------
May 31 06:11:30 dog kernel: WARNING: CPU: 13 PID: 39036 at
kernel/sched/core.c:2240 migrate_enable+0xf0/0x100
May 31 06:11:30 dog kernel: Modules linked in: snd_seq_dummy
snd_seq_midi snd_hrtimer snd_seq_midi_event snd_seq xt_nat veth
nft_chain_nat xt_MASQUERADE nf_nat xfrm_user xfrm_algo >
May 31 06:11:30 dog kernel:  snd_hda_ext_core snd_soc_acpi_intel_match
snd_soc_acpi kvm_intel snd_hda_codec_hdmi snd_soc_core mac80211
snd_compress kvm soundwire_bus jitterentropy_>
May 31 06:11:30 dog kernel:  autofs4 nls_utf8 cifs cifs_arc4 cifs_md4
dns_resolver fscache netfs nls_ascii nls_cp437 vfat fat dm_mod
hid_microsoft ff_memless binfmt_misc fuse btrfs>
May 31 06:11:30 dog kernel: CPU: 13 PID: 39036 Comm: btdu Tainted: P
     W  OE      6.1.0-9-amd64 #1  Debian 6.1.27-1
May 31 06:11:30 dog kernel: Hardware name: ASUS System Product
Name/ROG MAXIMUS Z690 FORMULA, BIOS 2103 09/30/2022
May 31 06:11:30 dog kernel: RIP: 0010:migrate_enable+0xf0/0x100
May 31 06:11:30 dog kernel: Code: 10 65 48 2b 04 25 28 00 00 00 75 22
48 83 c4 18 5b 5d c3 cc cc cc cc 83 e8 01 66 89 83 f0 07 00 00 eb d9
0f 1f 44 00 00 eb d2 <0f> 0b eb ce e8 67 >
May 31 06:11:30 dog kernel: RSP: 0018:ffffa39d23faf958 EFLAGS: 00010297
May 31 06:11:30 dog kernel: RAX: 0000000000000000 RBX:
ffff9666044b9980 RCX: 0000000000000000
May 31 06:11:30 dog kernel: RDX: 0000000000000000 RSI:
0000000000000001 RDI: ffffa39d03953000
May 31 06:11:30 dog kernel: RBP: ffffa39d23faf9c0 R08:
0000000000000000 R09: ffffa39d23faf678
May 31 06:11:30 dog kernel: R10: 0000000000000003 R11:
ffff96822d76e468 R12: ffff966581c9ac90
May 31 06:11:30 dog kernel: R13: ffff966293fe8800 R14:
0000000000000000 R15: 0000000000001e6e
May 31 06:11:30 dog kernel: FS:  00007fddc7e715c0(0000)
GS:ffff9681ad340000(0000) knlGS:0000000000000000
May 31 06:11:30 dog kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 00000000800500=
33
May 31 06:11:30 dog kernel: CR2: 000055f03739a008 CR3:
00000003606b0005 CR4: 0000000000770ee0
May 31 06:11:30 dog kernel: PKRU: 55555554
May 31 06:11:30 dog kernel: Call Trace:
May 31 06:11:30 dog kernel:  <TASK>
May 31 06:11:30 dog kernel:  __bpf_prog_exit+0x29/0x30
May 31 06:11:30 dog kernel:  bpf_trampoline_6442467175_0+0x56/0x1000
May 31 06:11:30 dog kernel:  mark_page_accessed+0x5/0x40
May 31 06:11:30 dog kernel:  find_extent_buffer+0x54/0x80 [btrfs]
May 31 06:11:30 dog kernel:  read_block_for_search+0xfd/0x330 [btrfs]
May 31 06:11:30 dog kernel:  btrfs_search_slot+0x327/0xc80 [btrfs]
May 31 06:11:30 dog kernel:  ? kmem_cache_alloc+0x148/0x2e0
May 31 06:11:30 dog kernel:  find_parent_nodes+0x115/0x1c70 [btrfs]
May 31 06:11:30 dog kernel:  btrfs_find_all_roots_safe+0xb8/0x130 [btrfs]
May 31 06:11:30 dog kernel:  ? btrfs_scrub_progress+0x160/0x160 [btrfs]
May 31 06:11:30 dog kernel:  iterate_extent_inodes+0x1fb/0x370 [btrfs]
May 31 06:11:30 dog kernel:  ? iterate_inodes_from_logical+0xb4/0xf0 [btrfs=
]
May 31 06:11:30 dog kernel:  iterate_inodes_from_logical+0xb4/0xf0 [btrfs]
May 31 06:11:30 dog kernel:  btrfs_ioctl_logical_to_ino+0x105/0x170 [btrfs]
May 31 06:11:30 dog kernel:  __x64_sys_ioctl+0x8d/0xd0
May 31 06:11:30 dog kernel:  do_syscall_64+0x58/0xc0
May 31 06:11:30 dog kernel:  ? fpregs_assert_state_consistent+0x22/0x50
May 31 06:11:30 dog kernel:  ? exit_to_user_mode_prepare+0x40/0x1d0
May 31 06:11:30 dog kernel:  ? syscall_exit_to_user_mode+0x17/0x40
May 31 06:11:30 dog kernel:  ? do_syscall_64+0x67/0xc0
May 31 06:11:30 dog kernel:  ? syscall_exit_to_user_mode+0x17/0x40
May 31 06:11:30 dog kernel:  ? do_syscall_64+0x67/0xc0
May 31 06:11:30 dog kernel:  ? do_syscall_64+0x67/0xc0
May 31 06:11:30 dog kernel:  entry_SYSCALL_64_after_hwframe+0x63/0xcd
May 31 06:11:30 dog kernel: RIP: 0033:0x7fddc7f7476f
May 31 06:11:30 dog kernel: Code: 00 48 89 44 24 18 31 c0 48 8d 44 24
60 c7 04 24 10 00 00 00 48 89 44 24 08 48 8d 44 24 20 48 89 44 24 10
b8 10 00 00 00 0f 05 <89> c2 3d 00 f0 ff >
May 31 06:11:30 dog kernel: RSP: 002b:00007ffc6c03cd80 EFLAGS:
00000246 ORIG_RAX: 0000000000000010
May 31 06:11:30 dog kernel: RAX: ffffffffffffffda RBX:
00000000c0389424 RCX: 00007fddc7f7476f
May 31 06:11:30 dog kernel: RDX: 00007ffc6c03ce08 RSI:
ffffffffc0389424 RDI: 0000000000000003
May 31 06:11:30 dog kernel: RBP: 00007ffc6c03ce50 R08:
00005563c40a5e44 R09: 00001f391dbfe894
May 31 06:11:30 dog kernel: R10: 00007ffc6c1c6080 R11:
0000000000000246 R12: 00007fddc7e612a0
May 31 06:11:30 dog kernel: R13: 00007fddc79d7000 R14:
00007fddc7e71330 R15: 00001f391dbfe894
May 31 06:11:30 dog kernel:  </TASK>
May 31 06:11:30 dog kernel: ---[ end trace 0000000000000000 ]---
May 31 06:11:31 dog kernel: BUG: using smp_processor_id() in
preemptible [00000000] code: dockerd/32291
May 31 06:11:31 dog kernel: caller is mod_objcg_state+0x34/0x2d0
May 31 06:11:31 dog kernel: CPU: 12 PID: 32291 Comm: dockerd Tainted:
P        W  OE      6.1.0-9-amd64 #1  Debian 6.1.27-1
May 31 06:11:31 dog kernel: Hardware name: ASUS System Product
Name/ROG MAXIMUS Z690 FORMULA, BIOS 2103 09/30/2022
May 31 06:11:31 dog kernel: Call Trace:
May 31 06:11:31 dog kernel:  <TASK>
May 31 06:11:31 dog kernel:  dump_stack_lvl+0x44/0x5c
May 31 06:11:31 dog kernel:  check_preemption_disabled+0xe1/0xf0
May 31 06:11:31 dog kernel:  mod_objcg_state+0x34/0x2d0
May 31 06:11:31 dog kernel:  memcg_slab_post_alloc_hook+0x14d/0x220
May 31 06:11:31 dog kernel:  ? __alloc_file+0x23/0xd0
May 31 06:11:31 dog kernel:  kmem_cache_alloc+0x148/0x2e0
May 31 06:11:31 dog kernel:  __alloc_file+0x23/0xd0
May 31 06:11:31 dog kernel:  ? filemap_get_read_batch+0x135/0x250
May 31 06:11:31 dog kernel:  alloc_empty_file+0x3d/0xb0
May 31 06:11:31 dog kernel:  path_openat+0x4b/0x1260
May 31 06:11:31 dog kernel:  ? current_time+0x3c/0x100
May 31 06:11:31 dog kernel:  ? atime_needs_update+0x104/0x180
May 31 06:11:31 dog kernel:  ? lookup_nulls_elem_raw+0x45/0x80
May 31 06:11:31 dog kernel:  do_filp_open+0xaf/0x160
May 31 06:11:31 dog kernel:  do_sys_openat2+0xaf/0x170
May 31 06:11:31 dog kernel:  bpf_trampoline_6442497611_1+0x7c/0x1000
May 31 06:11:31 dog kernel:  do_sys_openat2+0x5/0x170
May 31 06:11:31 dog kernel:  __x64_sys_openat+0x6a/0xa0
May 31 06:11:31 dog kernel:  do_syscall_64+0x58/0xc0
May 31 06:11:31 dog kernel:  ? fpregs_assert_state_consistent+0x22/0x50
May 31 06:11:31 dog kernel:  ? exit_to_user_mode_prepare+0x40/0x1d0
May 31 06:11:31 dog kernel:  ? syscall_exit_to_user_mode+0x17/0x40
May 31 06:11:31 dog kernel:  ? do_syscall_64+0x67/0xc0
May 31 06:11:31 dog kernel:  ? syscall_exit_to_user_mode+0x17/0x40
May 31 06:11:31 dog kernel:  ? do_syscall_64+0x67/0xc0
May 31 06:11:31 dog kernel:  ? do_syscall_64+0x67/0xc0
May 31 06:11:31 dog kernel:  entry_SYSCALL_64_after_hwframe+0x63/0xcd
May 31 06:11:31 dog kernel: RIP: 0033:0x55bf35b3a46e
May 31 06:11:31 dog kernel: Code: 48 89 6c 24 38 48 8d 6c 24 38 e8 0d
00 00 00 48 8b 6c 24 38 48 83 c4 40 c3 cc cc cc 49 89 f2 48 89 fa 48
89 ce 48 89 df 0f 05 <48> 3d 01 f0 ff ff >
May 31 06:11:31 dog kernel: RSP: 002b:000000c005952c90 EFLAGS:
00000202 ORIG_RAX: 0000000000000101
May 31 06:11:31 dog kernel: RAX: ffffffffffffffda RBX:
ffffffffffffff9c RCX: 000055bf35b3a46e
May 31 06:11:31 dog kernel: RDX: 0000000000080000 RSI:
000000c0069e9880 RDI: ffffffffffffff9c
May 31 06:11:31 dog kernel: RBP: 000000c005952cd0 R08:
0000000000000000 R09: 0000000000000000
May 31 06:11:31 dog kernel: R10: 0000000000000000 R11:
0000000000000202 R12: 0000000000000000
May 31 06:11:31 dog kernel: R13: 0000000000000032 R14:
000000c000fb7d40 R15: 000000c002100400
May 31 06:11:31 dog kernel:  </TASK>
May 31 06:11:31 dog kernel: BUG: unable to handle page fault for
address: 00002349ea7d0008
May 31 06:11:31 dog kernel: #PF: supervisor read access in kernel mode

On Wed, May 31, 2023 at 4:12=E2=80=AFPM ash lee <ash@bashdev.org> wrote:
>
> So this isn't the only issue i'm running into. I've been trying to
> capture more logs since my system has been having problems (processes
> deadlocking, etc). Here are two more problems that i'm not really sure
> what to do about. I'll put them into two different emails to separate
> the kernel logs
>
> First is warnings that look like this in my kernel log. These happen
> during day to day usage and triggers during supposedly high FS load,
> it will end up deadlocking firefox, dpkg, vim, gcc, ld, etc.
>
> when these logs happens, it seems that whatever program did that
> syscall ends up deadlocking and i need to restart the system for the
> process to go away, even after kill -9.
>
> I was suspicious and ran a 4 pass memcheck overnight and, but passed
> with no errors. SMART is also reporting no errors.
>
>
> May 31 15:36:55 dog kernel: ------------[ cut here ]------------
> May 31 15:36:55 dog kernel: WARNING: CPU: 10 PID: 40198 at
> fs/btrfs/backref.c:1560 btrfs_is_data_extent_shared+0x2f6/0x3e0
> [btrfs]
> May 31 15:36:55 dog kernel: Modules linked in: snd_seq_dummy
> snd_seq_midi snd_hrtimer snd_seq_midi_event snd_seq xt_nat veth
> nft_chain_nat xt_MASQUERADE nf_nat xfrm_user xfrm_algo br_netfilter b>
> May 31 15:36:55 dog kernel:  snd_soc_hdac_hda snd_hda_ext_core libarc4
> snd_soc_acpi_intel_match snd_soc_acpi nvidia_drm(POE) snd_soc_core
> snd_compress kvm soundwire_bus snd_hda_intel snd_intel_d>
> May 31 15:36:55 dog kernel:  x_tables autofs4 nls_utf8 cifs cifs_arc4
> cifs_md4 dns_resolver fscache netfs nls_ascii nls_cp437 vfat fat
> dm_mod hid_microsoft ff_memless binfmt_misc fuse btrfs blak>
> May 31 15:36:55 dog kernel: CPU: 10 PID: 40198 Comm: dpkg Tainted: P
>         OE      6.1.0-9-amd64 #1  Debian 6.1.27-1
> May 31 15:36:55 dog kernel: Hardware name: ASUS System Product
> Name/ROG MAXIMUS Z690 FORMULA, BIOS 2103 09/30/2022
> May 31 15:36:55 dog kernel: RIP:
> 0010:btrfs_is_data_extent_shared+0x2f6/0x3e0 [btrfs]
> May 31 15:36:55 dog kernel: Code: ff 48 39 88 08 01 00 00 72 19 49 83
> 7d 00 01 0f 86 8d fe ff ff 41 c6 84 24 c0 00 00 00 00 e9 7f fe ff ff
> 31 d2 e9 2f ff ff ff <0f> 0b eb ad 48 8b 7d 80 48 81 c7>
> May 31 15:36:55 dog kernel: RSP: 0018:ffffc011e51c7c60 EFLAGS: 00010202
> May 31 15:36:55 dog kernel: RAX: ffffa0ae3ad32080 RBX:
> 0000231716778000 RCX: 000000000081000a
> May 31 15:36:55 dog kernel: RDX: ffffa0b0005cebe8 RSI:
> ffffc011e51c7c88 RDI: ffffa0b0005cebe0
> May 31 15:36:55 dog kernel: RBP: ffffc011e51c7d00 R08:
> ffffa0b0005cebe8 R09: ffffa0ae3ad32900
> May 31 15:36:55 dog kernel: R10: 0000000000000000 R11:
> 0000000000000000 R12: ffffa0af801d1700
> May 31 15:36:55 dog kernel: R13: ffffa0b0005cebe0 R14:
> 0000000000000007 R15: 0000000000000008
> May 31 15:36:55 dog kernel: FS:  00007fdc7e0b3380(0000)
> GS:ffffa0cc2d280000(0000) knlGS:0000000000000000
> May 31 15:36:55 dog kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005=
0033
> May 31 15:36:55 dog kernel: CR2: 000055fa0443f030 CR3:
> 0000000163820002 CR4: 0000000000770ee0
> May 31 15:36:55 dog kernel: PKRU: 55555554
> May 31 15:36:55 dog kernel: Call Trace:
> May 31 15:36:55 dog kernel:  <TASK>
> May 31 15:36:55 dog kernel:  ? btrfs_alloc_page_array+0x5d/0x90 [btrfs]
> May 31 15:36:55 dog kernel:  ? extent_fiemap+0x97b/0xad0 [btrfs]
> May 31 15:36:55 dog kernel:  extent_fiemap+0x97b/0xad0 [btrfs]
> May 31 15:36:55 dog kernel:  btrfs_fiemap+0x45/0x80 [btrfs]
> May 31 15:36:55 dog kernel:  do_vfs_ioctl+0x1f2/0x910
> May 31 15:36:55 dog kernel:  __x64_sys_ioctl+0x6e/0xd0
> May 31 15:36:55 dog kernel:  do_syscall_64+0x58/0xc0
> May 31 15:36:55 dog kernel:  ? do_syscall_64+0x67/0xc0
> May 31 15:36:55 dog kernel:  ? do_syscall_64+0x67/0xc0
> May 31 15:36:55 dog kernel:  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> May 31 15:36:55 dog kernel: RIP: 0033:0x7fdc7e250afb
> May 31 15:36:55 dog kernel: Code: 00 48 89 44 24 18 31 c0 48 8d 44 24
> 60 c7 04 24 10 00 00 00 48 89 44 24 08 48 8d 44 24 20 48 89 44 24 10
> b8 10 00 00 00 0f 05 <89> c2 3d 00 f0 ff ff 77 1c 48 8b>
> May 31 15:36:55 dog kernel: RSP: 002b:00007fff0b298c60 EFLAGS:
> 00000246 ORIG_RAX: 0000000000000010
> May 31 15:36:55 dog kernel: RAX: ffffffffffffffda RBX:
> 0000000000001702 RCX: 00007fdc7e250afb
> May 31 15:36:55 dog kernel: RDX: 00007fff0b298cf0 RSI:
> 00000000c020660b RDI: 000000000000000b
> May 31 15:36:55 dog kernel: RBP: 00007fff0b298cf0 R08:
> 000000000000002c R09: 0000000000000050
> May 31 15:36:55 dog kernel: R10: 0000000000000000 R11:
> 0000000000000246 R12: 00007fff0b298cc0
> May 31 15:36:55 dog kernel: R13: 000055fa021ed89e R14:
> 000000000000000b R15: 000055fa03ed2620
> May 31 15:36:55 dog kernel:  </TASK>
> May 31 15:36:55 dog kernel: ---[ end trace 0000000000000000 ]---
> May 31 15:36:55 dog kernel: ------------[ cut here ]------------
> May 31 15:36:55 dog kernel: WARNING: CPU: 10 PID: 40198 at
> fs/btrfs/backref.c:1627 btrfs_is_data_extent_shared+0x315/0x3e0
> [btrfs]
> May 31 15:36:55 dog kernel: Modules linked in: snd_seq_dummy
> snd_seq_midi snd_hrtimer snd_seq_midi_event snd_seq xt_nat veth
> nft_chain_nat xt_MASQUERADE nf_nat xfrm_user xfrm_algo br_netfilter b>
> May 31 15:36:55 dog kernel:  snd_soc_hdac_hda snd_hda_ext_core libarc4
> snd_soc_acpi_intel_match snd_soc_acpi nvidia_drm(POE) snd_soc_core
> snd_compress kvm soundwire_bus snd_hda_intel snd_intel_d>
> May 31 15:36:55 dog kernel:  x_tables autofs4 nls_utf8 cifs cifs_arc4
> cifs_md4 dns_resolver fscache netfs nls_ascii nls_cp437 vfat fat
> dm_mod hid_microsoft ff_memless binfmt_misc fuse btrfs blak>
> May 31 15:36:55 dog kernel: CPU: 10 PID: 40198 Comm: dpkg Tainted: P
>      W  OE      6.1.0-9-amd64 #1  Debian 6.1.27-1
> May 31 15:36:55 dog kernel: Hardware name: ASUS System Product
> Name/ROG MAXIMUS Z690 FORMULA, BIOS 2103 09/30/2022
> May 31 15:36:55 dog kernel: RIP:
> 0010:btrfs_is_data_extent_shared+0x315/0x3e0 [btrfs]
> May 31 15:36:55 dog kernel: Code: 7f fe ff ff 31 d2 e9 2f ff ff ff 0f
> 0b eb ad 48 8b 7d 80 48 81 c7 b8 03 00 00 e8 06 81 2e eb 8b 95 78 ff
> ff ff e9 41 ff ff ff <0f> 0b e9 52 fe ff ff 45 85 f6 0f>
> May 31 15:36:55 dog kernel: RSP: 0018:ffffc011e51c7c60 EFLAGS: 00010202
> May 31 15:36:55 dog kernel: RAX: 0000000000000001 RBX:
> 0000231716778000 RCX: 000000000081400a
> May 31 15:36:55 dog kernel: RDX: 0000000000000000 RSI:
> 6d194b1e6aa9791c RDI: ffffc011e51c7bf0
> May 31 15:36:55 dog kernel: RBP: ffffc011e51c7d00 R08:
> ffffa0b0005cebe8 R09: ffffa0ae3ad32680
> May 31 15:36:55 dog kernel: R10: 000000000000000a R11:
> 0000000000000001 R12: ffffa0af801d1700
> May 31 15:36:55 dog kernel: R13: ffffa0b0005cebe0 R14:
> 0000000000000008 R15: 0000000000000008
> May 31 15:36:55 dog kernel: FS:  00007fdc7e0b3380(0000)
> GS:ffffa0cc2d280000(0000) knlGS:0000000000000000
> May 31 15:36:55 dog kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005=
0033
> May 31 15:36:55 dog kernel: CR2: 000055fa0443f030 CR3:
> 0000000163820002 CR4: 0000000000770ee0
> May 31 15:36:55 dog kernel: PKRU: 55555554
> May 31 15:36:55 dog kernel: Call Trace:
> May 31 15:36:55 dog kernel:  <TASK>
> May 31 15:36:55 dog kernel:  ? btrfs_alloc_page_array+0x5d/0x90 [btrfs]
> May 31 15:36:55 dog kernel:  ? extent_fiemap+0x97b/0xad0 [btrfs]
> May 31 15:36:55 dog kernel:  extent_fiemap+0x97b/0xad0 [btrfs]
> May 31 15:36:55 dog kernel:  btrfs_fiemap+0x45/0x80 [btrfs]
> May 31 15:36:55 dog kernel:  do_vfs_ioctl+0x1f2/0x910
> May 31 15:36:55 dog kernel:  __x64_sys_ioctl+0x6e/0xd0
> May 31 15:36:55 dog kernel:  do_syscall_64+0x58/0xc0
> May 31 15:36:55 dog kernel:  ? do_syscall_64+0x67/0xc0
> May 31 15:36:55 dog kernel:  ? do_syscall_64+0x67/0xc0
> May 31 15:36:55 dog kernel:  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> May 31 15:36:55 dog kernel: RIP: 0033:0x7fdc7e250afb
> May 31 15:36:55 dog kernel: Code: 00 48 89 44 24 18 31 c0 48 8d 44 24
> 60 c7 04 24 10 00 00 00 48 89 44 24 08 48 8d 44 24 20 48 89 44 24 10
> b8 10 00 00 00 0f 05 <89> c2 3d 00 f0 ff ff 77 1c 48 8b>
> May 31 15:36:55 dog kernel: RSP: 002b:00007fff0b298c60 EFLAGS:
> 00000246 ORIG_RAX: 0000000000000010
> May 31 15:36:55 dog kernel: RAX: ffffffffffffffda RBX:
> 0000000000001702 RCX: 00007fdc7e250afb
> May 31 15:36:55 dog kernel: RDX: 00007fff0b298cf0 RSI:
> 00000000c020660b RDI: 000000000000000b
> May 31 15:36:55 dog kernel: RBP: 00007fff0b298cf0 R08:
> 000000000000002c R09: 0000000000000050
> May 31 15:36:55 dog kernel: R10: 0000000000000000 R11:
> 0000000000000246 R12: 00007fff0b298cc0
> May 31 15:36:55 dog kernel: R13: 000055fa021ed89e R14:
> 000000000000000b R15: 000055fa03ed2620
> May 31 15:36:55 dog kernel:  </TASK>
> May 31 15:36:55 dog kernel: ---[ end trace 0000000000000000 ]---
> May 31 15:36:55 dog kernel: ------------[ cut here ]------------
> May 31 15:36:55 dog kernel: WARNING: CPU: 10 PID: 40198 at
> fs/btrfs/backref.c:1627 btrfs_is_data_extent_shared+0x3cf/0x3e0
> [btrfs]
> May 31 15:36:55 dog kernel: Modules linked in: snd_seq_dummy
> snd_seq_midi snd_hrtimer snd_seq_midi_event snd_seq xt_nat veth
> nft_chain_nat xt_MASQUERADE nf_nat xfrm_user xfrm_algo br_netfilter b>
> May 31 15:36:55 dog kernel:  snd_soc_hdac_hda snd_hda_ext_core libarc4
> snd_soc_acpi_intel_match snd_soc_acpi nvidia_drm(POE) snd_soc_core
> snd_compress kvm soundwire_bus snd_hda_intel snd_intel_d>
> May 31 15:36:55 dog kernel:  x_tables autofs4 nls_utf8 cifs cifs_arc4
> cifs_md4 dns_resolver fscache netfs nls_ascii nls_cp437 vfat fat
> dm_mod hid_microsoft ff_memless binfmt_misc fuse btrfs blak>
> May 31 15:36:55 dog kernel: CPU: 10 PID: 40198 Comm: dpkg Tainted: P
>      W  OE      6.1.0-9-amd64 #1  Debian 6.1.27-1
> May 31 15:36:55 dog kernel: Hardware name: ASUS System Product
> Name/ROG MAXIMUS Z690 FORMULA, BIOS 2103 09/30/2022
> May 31 15:36:55 dog kernel: RIP:
> 0010:btrfs_is_data_extent_shared+0x3cf/0x3e0 [btrfs]
> May 31 15:36:55 dog kernel: Code: 48 83 f8 fe 0f 85 a7 fe ff ff 48 8b
> 45 80 48 8d b8 b8 03 00 00 e8 d1 ca c0 eb 48 c7 85 78 ff ff ff 00 00
> 00 00 e9 fc fc ff ff <0f> 0b e9 4a fe ff ff e8 15 e9 bf>
> May 31 15:36:55 dog kernel: RSP: 0018:ffffc011e51c7c60 EFLAGS: 00010212
> May 31 15:36:55 dog kernel: RAX: 0000000000000006 RBX:
> 0000234f03518000 RCX: 00000000a74fe00a
> May 31 15:36:55 dog kernel: RDX: 0000000000000000 RSI:
> 7b6841ce8bf7c8dc RDI: ffffc011e51c7bf0
> May 31 15:36:55 dog kernel: RBP: ffffc011e51c7d00 R08:
> ffffc011e51c7bd8 R09: ffffa0b0005ce880
> May 31 15:36:55 dog kernel: R10: 000000000000000a R11:
> 0000000000000001 R12: ffffa0af801d1700
> May 31 15:36:55 dog kernel: R13: ffffa0b0005cebe0 R14:
> 0000000000000012 R15: 0000000000000012
> May 31 15:36:55 dog kernel: FS:  00007fdc7e0b3380(0000)
> GS:ffffa0cc2d280000(0000) knlGS:0000000000000000
> May 31 15:36:55 dog kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005=
0033
> May 31 15:36:55 dog kernel: CR2: 000055fa0443f030 CR3:
> 0000000163820002 CR4: 0000000000770ee0
> May 31 15:36:55 dog kernel: PKRU: 55555554
> May 31 15:36:55 dog kernel: Call Trace:
> May 31 15:36:55 dog kernel:  <TASK>
> May 31 15:36:55 dog kernel:  ? btrfs_alloc_page_array+0x5d/0x90 [btrfs]
> May 31 15:36:55 dog kernel:  ? extent_fiemap+0x97b/0xad0 [btrfs]
> May 31 15:36:55 dog kernel:  extent_fiemap+0x97b/0xad0 [btrfs]
> May 31 15:36:55 dog kernel:  btrfs_fiemap+0x45/0x80 [btrfs]
> May 31 15:36:55 dog kernel:  do_vfs_ioctl+0x1f2/0x910
> May 31 15:36:55 dog kernel:  __x64_sys_ioctl+0x6e/0xd0
> May 31 15:36:55 dog kernel:  do_syscall_64+0x58/0xc0
> May 31 15:36:55 dog kernel:  ? do_syscall_64+0x67/0xc0
> May 31 15:36:55 dog kernel:  ? do_syscall_64+0x67/0xc0
> May 31 15:36:55 dog kernel:  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> May 31 15:36:55 dog kernel: RIP: 0033:0x7fdc7e250afb
> May 31 15:36:55 dog kernel: Code: 00 48 89 44 24 18 31 c0 48 8d 44 24
> 60 c7 04 24 10 00 00 00 48 89 44 24 08 48 8d 44 24 20 48 89 44 24 10
> b8 10 00 00 00 0f 05 <89> c2 3d 00 f0 ff ff 77 1c 48 8b>
> May 31 15:36:55 dog kernel: RSP: 002b:00007fff0b298c60 EFLAGS:
> 00000246 ORIG_RAX: 0000000000000010
> May 31 15:36:55 dog kernel: RAX: ffffffffffffffda RBX:
> 0000000000001702 RCX: 00007fdc7e250afb
> May 31 15:36:55 dog kernel: RDX: 00007fff0b298cf0 RSI:
> 00000000c020660b RDI: 000000000000000b
> May 31 15:36:55 dog kernel: RBP: 00007fff0b298cf0 R08:
> 000000000000002c R09: 0000000000000050
> May 31 15:36:55 dog kernel: R10: 0000000000000000 R11:
> 0000000000000246 R12: 00007fff0b298cc0
> May 31 15:36:55 dog kernel: R13: 000055fa021ed89e R14:
> 000000000000000b R15: 000055fa03ed2620
> May 31 15:36:55 dog kernel:  </TASK>
> May 31 15:36:55 dog kernel: ---[ end trace 0000000000000000 ]---
>
>
> On Mon, May 29, 2023 at 9:13=E2=80=AFAM David Sterba <dsterba@suse.cz> wr=
ote:
> >
> > On Sat, May 27, 2023 at 08:31:30PM -0500, ash lee wrote:
> > > Hi, during running of a BTRFS balance, i ran into this bug. It ended
> > > up deadlocking the BTRFS balance, and i could not pause/cancel it.
> > >
> > > I have the rest of the kernel logs as well if those would help.
> > >
> > > 2,3508,4363269431,-;kernel BUG at fs/inode.c:611!
> >
> > The code is
> >
> >  603 void clear_inode(struct inode *inode)
> >  604 {
> >  605         /*
> >  606          * We have to cycle the i_pages lock here because reclaim =
can be in the
> >  607          * process of removing the last page (in __filemap_remove_=
folio())
> >  608          * and we must not free the mapping under it.
> >  609          */
> >  610         xa_lock_irq(&inode->i_data.i_pages);
> >  611         BUG_ON(inode->i_data.nrpages);
> >
> >
> >
> > > 4,3512,4363269439,-;RIP: 0010:clear_inode+0x72/0x80
> > > 4,3526,4363269454,-; evict+0xcd/0x1d0
> > > 4,3527,4363269457,-; btrfs_relocate_block_group+0xb2/0x3f0 [btrfs]
> > > 4,3528,4363269484,-; btrfs_relocate_chunk+0x3b/0x120 [btrfs]
> > > 4,3529,4363269501,-; btrfs_balance+0x7a4/0xf70 [btrfs]
> > > 4,3530,4363269517,-; btrfs_ioctl+0x2276/0x2610 [btrfs]
> > > 4,3531,4363269533,-; ? __rseq_handle_notify_resume+0xa6/0x4a0
> > > 4,3532,4363269535,-; ? proc_nr_files+0x30/0x30
> > > 4,3533,4363269537,-; ? call_rcu+0x116/0x660
> > > 4,3534,4363269539,-; ? percpu_counter_add_batch+0x53/0xc0
> > > 4,3535,4363269541,-; __x64_sys_ioctl+0x8d/0xd0
> > > 4,3536,4363269542,-; do_syscall_64+0x58/0xc0
> > > 4,3537,4363269544,-; ? handle_mm_fault+0xdb/0x2d0
> > > 4,3538,4363269546,-; ? preempt_count_add+0x47/0xa0
> > > 4,3539,4363269547,-; ? up_read+0x37/0x70
> > > 4,3540,4363269548,-; ? do_user_addr_fault+0x1ef/0x690
> > > 4,3541,4363269550,-; ? fpregs_assert_state_consistent+0x22/0x50
> > > 4,3542,4363269552,-; ? exit_to_user_mode_prepare+0x40/0x1d0
> >
> > > 20 46 ac
> > > 6,3591,4708011011,-;traps: iotop[354859] general protection fault
> > > ip:42b1bf sp:7fff207cf020 error:0 in python3.11[41f000+2b3000]
> > > 6,3610,5061930113,-;iotop[359003]: segfault at 8e8 ip 00000000000008e=
8
> > > sp 00007fff29df99d8 error 14 in python3.11[400000+1f000] likely on CP=
U
> > > 10 (core 20, socket 0)
> > > 6,3611,5061930122,-;Code: Unable to access opcode bytes at 0x8be.
> > > 4,3625,5313827230,-;------------[ cut here ]------------
> > > 4,3626,5313827233,-;WARNING: CPU: 21 PID: 392166 at
> > > fs/btrfs/backref.c:1560 btrfs_is_data_extent_shared+0x2f6/0x3e0
> > > [btrfs]
> >
> > A warning in btrfs_is_data_extent_shared but triggered from some inline
> > function, I don't see a direct call.
> >
> > > 4,3632,5313827384,-;RIP: 0010:btrfs_is_data_extent_shared+0x2f6/0x3e0=
 [btrfs]
> > > 4,3646,5313827433,-; ? btrfs_alloc_page_array+0x5d/0x90 [btrfs]
> > > 4,3647,5313827463,-; ? extent_fiemap+0x97b/0xad0 [btrfs]
> > > 4,3648,5313827492,-; extent_fiemap+0x97b/0xad0 [btrfs]
> > > 4,3649,5313827521,-; btrfs_fiemap+0x45/0x80 [btrfs]
> > > 4,3650,5313827548,-; do_vfs_ioctl+0x1f2/0x910
> > > 4,3651,5313827552,-; __x64_sys_ioctl+0x6e/0xd0
> > > 4,3652,5313827553,-; do_syscall_64+0x58/0xc0
> > > 4,3653,5313827556,-; ? syscall_exit_to_user_mode+0x17/0x40
> > > 4,3654,5313827558,-; ? do_syscall_64+0x67/0xc0
> > > 4,3655,5313827560,-; ? handle_mm_fault+0xdb/0x2d0
> > > 4,3656,5313827562,-; ? preempt_count_add+0x47/0xa0
> > > 4,3657,5313827565,-; ? up_read+0x37/0x70
> > > 4,3658,5313827566,-; ? do_user_addr_fault+0x1ef/0x690
> > > 4,3659,5313827569,-; ? fpregs_assert_state_consistent+0x22/0x50
> > > 4,3660,5313827571,-; ? exit_to_user_mode_prepare+0x40/0x1d0
> > > 4,3661,5313827573,-; entry_SYSCALL_64_after_hwframe+0x63/0xcd
> >
> > And again
