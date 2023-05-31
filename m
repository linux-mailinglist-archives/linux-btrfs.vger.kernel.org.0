Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C374A718BA3
	for <lists+linux-btrfs@lfdr.de>; Wed, 31 May 2023 23:13:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230110AbjEaVNH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 31 May 2023 17:13:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229996AbjEaVNG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 31 May 2023 17:13:06 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57F32B3
        for <linux-btrfs@vger.kernel.org>; Wed, 31 May 2023 14:13:04 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id e9e14a558f8ab-33b204f0ca0so226735ab.2
        for <linux-btrfs@vger.kernel.org>; Wed, 31 May 2023 14:13:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bashdev.org; s=google; t=1685567583; x=1688159583;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LrMpyvcsKhGIUjRHvcNnH8wYRWZu2eXcVygti7oXPgw=;
        b=U/V3X0qJYDUKxPkCLGVuwCuzPQr4RLee8+q0pdsUvqaKUedPT/ElYvbGu2dMznm5Dx
         BH7Ozc1+jM1nA8QirktjiILGGq6ghs+HAtcSLGwYT/2Kz67e4s77vgK1W4Li9fwBSM01
         Ux0nTzNQRUOIfC864Y3PcOGzVS6gUBH8YakfmlOaPtDSwPDcms6PkBqx+ybo0G9had51
         hS3DaGbctu5ITDcX3gH/qDkVp2k97V0AKE3l9nGWWnP4wwMUXcrWJ0PwEAoE/I6uYKuG
         bxyjRh7KJ634MMVt+0R2AhTqyvl9u+Z0dJxECjL1m4bnBd31Q037U1g6UF8+XETV8HiW
         A1WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685567583; x=1688159583;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LrMpyvcsKhGIUjRHvcNnH8wYRWZu2eXcVygti7oXPgw=;
        b=lN8PUZld0xa26qdQjBYAwL0uUlS3VO0iBLXhtM8tAj8/vYLg+sJX1CRqXHn6JSdGJY
         nGSEHQC4kaCUkpK8POCa4J0XPYvLAvEhe5CJMoPYJv0ahg9CLHcsra97qiJkUnotcSSO
         BLK90Q3ZnMzYq8n/s4GDuCj7/vp50QP4AaG1Uwf+Kg8VjpiZjMOANTr9CTilu3h1coSY
         LoJWHBX0abkbr8TUZiv3BpBZV971xa7B3OPzz/pgrJyRyafIwxhHUDr/rsh38LtrP5Ai
         2Psq4Kv0OeoOTtpbsIQuAbTwiFOkFvQikaHKo75XPoE/GY4F2Fh/5aHUyulzh04fT88w
         qcJg==
X-Gm-Message-State: AC+VfDx4aKpeTHZmfnDW5yyO7DuTXHelMfZiZyx+UJWMP1I+1rRYSFoR
        +Wo/iq7KvGXIKEFyvB7GpNy/Tnlt2vPhfr+d23Oy0dW4FzrlNwhDgYc=
X-Google-Smtp-Source: ACHHUZ7VByWNEXB3NziSWDwBT+6jgEltY0ob7fTFF+B/99SumZbsDDS1Ar/tO5KwRTSB281JyKnB0Eu4NBzQYzHsXk8=
X-Received: by 2002:a05:6e02:6c9:b0:33b:1b4c:69e1 with SMTP id
 p9-20020a056e0206c900b0033b1b4c69e1mr3826385ils.17.1685567583567; Wed, 31 May
 2023 14:13:03 -0700 (PDT)
MIME-Version: 1.0
References: <CAMmhH1vkKS2Ot0TyJZ+sDFXhi_-YTWcBkQhSfFxrXmdEAJtK5Q@mail.gmail.com>
 <20230529140714.GG575@twin.jikos.cz>
In-Reply-To: <20230529140714.GG575@twin.jikos.cz>
From:   ash lee <ash@bashdev.org>
Date:   Wed, 31 May 2023 16:12:52 -0500
Message-ID: <CAMmhH1vrgLtHHadL7c8u1Pew21rg49UrrCfQCcS8oyGB4K4Krg@mail.gmail.com>
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

So this isn't the only issue i'm running into. I've been trying to
capture more logs since my system has been having problems (processes
deadlocking, etc). Here are two more problems that i'm not really sure
what to do about. I'll put them into two different emails to separate
the kernel logs

First is warnings that look like this in my kernel log. These happen
during day to day usage and triggers during supposedly high FS load,
it will end up deadlocking firefox, dpkg, vim, gcc, ld, etc.

when these logs happens, it seems that whatever program did that
syscall ends up deadlocking and i need to restart the system for the
process to go away, even after kill -9.

I was suspicious and ran a 4 pass memcheck overnight and, but passed
with no errors. SMART is also reporting no errors.


May 31 15:36:55 dog kernel: ------------[ cut here ]------------
May 31 15:36:55 dog kernel: WARNING: CPU: 10 PID: 40198 at
fs/btrfs/backref.c:1560 btrfs_is_data_extent_shared+0x2f6/0x3e0
[btrfs]
May 31 15:36:55 dog kernel: Modules linked in: snd_seq_dummy
snd_seq_midi snd_hrtimer snd_seq_midi_event snd_seq xt_nat veth
nft_chain_nat xt_MASQUERADE nf_nat xfrm_user xfrm_algo br_netfilter b>
May 31 15:36:55 dog kernel:  snd_soc_hdac_hda snd_hda_ext_core libarc4
snd_soc_acpi_intel_match snd_soc_acpi nvidia_drm(POE) snd_soc_core
snd_compress kvm soundwire_bus snd_hda_intel snd_intel_d>
May 31 15:36:55 dog kernel:  x_tables autofs4 nls_utf8 cifs cifs_arc4
cifs_md4 dns_resolver fscache netfs nls_ascii nls_cp437 vfat fat
dm_mod hid_microsoft ff_memless binfmt_misc fuse btrfs blak>
May 31 15:36:55 dog kernel: CPU: 10 PID: 40198 Comm: dpkg Tainted: P
        OE      6.1.0-9-amd64 #1  Debian 6.1.27-1
May 31 15:36:55 dog kernel: Hardware name: ASUS System Product
Name/ROG MAXIMUS Z690 FORMULA, BIOS 2103 09/30/2022
May 31 15:36:55 dog kernel: RIP:
0010:btrfs_is_data_extent_shared+0x2f6/0x3e0 [btrfs]
May 31 15:36:55 dog kernel: Code: ff 48 39 88 08 01 00 00 72 19 49 83
7d 00 01 0f 86 8d fe ff ff 41 c6 84 24 c0 00 00 00 00 e9 7f fe ff ff
31 d2 e9 2f ff ff ff <0f> 0b eb ad 48 8b 7d 80 48 81 c7>
May 31 15:36:55 dog kernel: RSP: 0018:ffffc011e51c7c60 EFLAGS: 00010202
May 31 15:36:55 dog kernel: RAX: ffffa0ae3ad32080 RBX:
0000231716778000 RCX: 000000000081000a
May 31 15:36:55 dog kernel: RDX: ffffa0b0005cebe8 RSI:
ffffc011e51c7c88 RDI: ffffa0b0005cebe0
May 31 15:36:55 dog kernel: RBP: ffffc011e51c7d00 R08:
ffffa0b0005cebe8 R09: ffffa0ae3ad32900
May 31 15:36:55 dog kernel: R10: 0000000000000000 R11:
0000000000000000 R12: ffffa0af801d1700
May 31 15:36:55 dog kernel: R13: ffffa0b0005cebe0 R14:
0000000000000007 R15: 0000000000000008
May 31 15:36:55 dog kernel: FS:  00007fdc7e0b3380(0000)
GS:ffffa0cc2d280000(0000) knlGS:0000000000000000
May 31 15:36:55 dog kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 00000000800500=
33
May 31 15:36:55 dog kernel: CR2: 000055fa0443f030 CR3:
0000000163820002 CR4: 0000000000770ee0
May 31 15:36:55 dog kernel: PKRU: 55555554
May 31 15:36:55 dog kernel: Call Trace:
May 31 15:36:55 dog kernel:  <TASK>
May 31 15:36:55 dog kernel:  ? btrfs_alloc_page_array+0x5d/0x90 [btrfs]
May 31 15:36:55 dog kernel:  ? extent_fiemap+0x97b/0xad0 [btrfs]
May 31 15:36:55 dog kernel:  extent_fiemap+0x97b/0xad0 [btrfs]
May 31 15:36:55 dog kernel:  btrfs_fiemap+0x45/0x80 [btrfs]
May 31 15:36:55 dog kernel:  do_vfs_ioctl+0x1f2/0x910
May 31 15:36:55 dog kernel:  __x64_sys_ioctl+0x6e/0xd0
May 31 15:36:55 dog kernel:  do_syscall_64+0x58/0xc0
May 31 15:36:55 dog kernel:  ? do_syscall_64+0x67/0xc0
May 31 15:36:55 dog kernel:  ? do_syscall_64+0x67/0xc0
May 31 15:36:55 dog kernel:  entry_SYSCALL_64_after_hwframe+0x63/0xcd
May 31 15:36:55 dog kernel: RIP: 0033:0x7fdc7e250afb
May 31 15:36:55 dog kernel: Code: 00 48 89 44 24 18 31 c0 48 8d 44 24
60 c7 04 24 10 00 00 00 48 89 44 24 08 48 8d 44 24 20 48 89 44 24 10
b8 10 00 00 00 0f 05 <89> c2 3d 00 f0 ff ff 77 1c 48 8b>
May 31 15:36:55 dog kernel: RSP: 002b:00007fff0b298c60 EFLAGS:
00000246 ORIG_RAX: 0000000000000010
May 31 15:36:55 dog kernel: RAX: ffffffffffffffda RBX:
0000000000001702 RCX: 00007fdc7e250afb
May 31 15:36:55 dog kernel: RDX: 00007fff0b298cf0 RSI:
00000000c020660b RDI: 000000000000000b
May 31 15:36:55 dog kernel: RBP: 00007fff0b298cf0 R08:
000000000000002c R09: 0000000000000050
May 31 15:36:55 dog kernel: R10: 0000000000000000 R11:
0000000000000246 R12: 00007fff0b298cc0
May 31 15:36:55 dog kernel: R13: 000055fa021ed89e R14:
000000000000000b R15: 000055fa03ed2620
May 31 15:36:55 dog kernel:  </TASK>
May 31 15:36:55 dog kernel: ---[ end trace 0000000000000000 ]---
May 31 15:36:55 dog kernel: ------------[ cut here ]------------
May 31 15:36:55 dog kernel: WARNING: CPU: 10 PID: 40198 at
fs/btrfs/backref.c:1627 btrfs_is_data_extent_shared+0x315/0x3e0
[btrfs]
May 31 15:36:55 dog kernel: Modules linked in: snd_seq_dummy
snd_seq_midi snd_hrtimer snd_seq_midi_event snd_seq xt_nat veth
nft_chain_nat xt_MASQUERADE nf_nat xfrm_user xfrm_algo br_netfilter b>
May 31 15:36:55 dog kernel:  snd_soc_hdac_hda snd_hda_ext_core libarc4
snd_soc_acpi_intel_match snd_soc_acpi nvidia_drm(POE) snd_soc_core
snd_compress kvm soundwire_bus snd_hda_intel snd_intel_d>
May 31 15:36:55 dog kernel:  x_tables autofs4 nls_utf8 cifs cifs_arc4
cifs_md4 dns_resolver fscache netfs nls_ascii nls_cp437 vfat fat
dm_mod hid_microsoft ff_memless binfmt_misc fuse btrfs blak>
May 31 15:36:55 dog kernel: CPU: 10 PID: 40198 Comm: dpkg Tainted: P
     W  OE      6.1.0-9-amd64 #1  Debian 6.1.27-1
May 31 15:36:55 dog kernel: Hardware name: ASUS System Product
Name/ROG MAXIMUS Z690 FORMULA, BIOS 2103 09/30/2022
May 31 15:36:55 dog kernel: RIP:
0010:btrfs_is_data_extent_shared+0x315/0x3e0 [btrfs]
May 31 15:36:55 dog kernel: Code: 7f fe ff ff 31 d2 e9 2f ff ff ff 0f
0b eb ad 48 8b 7d 80 48 81 c7 b8 03 00 00 e8 06 81 2e eb 8b 95 78 ff
ff ff e9 41 ff ff ff <0f> 0b e9 52 fe ff ff 45 85 f6 0f>
May 31 15:36:55 dog kernel: RSP: 0018:ffffc011e51c7c60 EFLAGS: 00010202
May 31 15:36:55 dog kernel: RAX: 0000000000000001 RBX:
0000231716778000 RCX: 000000000081400a
May 31 15:36:55 dog kernel: RDX: 0000000000000000 RSI:
6d194b1e6aa9791c RDI: ffffc011e51c7bf0
May 31 15:36:55 dog kernel: RBP: ffffc011e51c7d00 R08:
ffffa0b0005cebe8 R09: ffffa0ae3ad32680
May 31 15:36:55 dog kernel: R10: 000000000000000a R11:
0000000000000001 R12: ffffa0af801d1700
May 31 15:36:55 dog kernel: R13: ffffa0b0005cebe0 R14:
0000000000000008 R15: 0000000000000008
May 31 15:36:55 dog kernel: FS:  00007fdc7e0b3380(0000)
GS:ffffa0cc2d280000(0000) knlGS:0000000000000000
May 31 15:36:55 dog kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 00000000800500=
33
May 31 15:36:55 dog kernel: CR2: 000055fa0443f030 CR3:
0000000163820002 CR4: 0000000000770ee0
May 31 15:36:55 dog kernel: PKRU: 55555554
May 31 15:36:55 dog kernel: Call Trace:
May 31 15:36:55 dog kernel:  <TASK>
May 31 15:36:55 dog kernel:  ? btrfs_alloc_page_array+0x5d/0x90 [btrfs]
May 31 15:36:55 dog kernel:  ? extent_fiemap+0x97b/0xad0 [btrfs]
May 31 15:36:55 dog kernel:  extent_fiemap+0x97b/0xad0 [btrfs]
May 31 15:36:55 dog kernel:  btrfs_fiemap+0x45/0x80 [btrfs]
May 31 15:36:55 dog kernel:  do_vfs_ioctl+0x1f2/0x910
May 31 15:36:55 dog kernel:  __x64_sys_ioctl+0x6e/0xd0
May 31 15:36:55 dog kernel:  do_syscall_64+0x58/0xc0
May 31 15:36:55 dog kernel:  ? do_syscall_64+0x67/0xc0
May 31 15:36:55 dog kernel:  ? do_syscall_64+0x67/0xc0
May 31 15:36:55 dog kernel:  entry_SYSCALL_64_after_hwframe+0x63/0xcd
May 31 15:36:55 dog kernel: RIP: 0033:0x7fdc7e250afb
May 31 15:36:55 dog kernel: Code: 00 48 89 44 24 18 31 c0 48 8d 44 24
60 c7 04 24 10 00 00 00 48 89 44 24 08 48 8d 44 24 20 48 89 44 24 10
b8 10 00 00 00 0f 05 <89> c2 3d 00 f0 ff ff 77 1c 48 8b>
May 31 15:36:55 dog kernel: RSP: 002b:00007fff0b298c60 EFLAGS:
00000246 ORIG_RAX: 0000000000000010
May 31 15:36:55 dog kernel: RAX: ffffffffffffffda RBX:
0000000000001702 RCX: 00007fdc7e250afb
May 31 15:36:55 dog kernel: RDX: 00007fff0b298cf0 RSI:
00000000c020660b RDI: 000000000000000b
May 31 15:36:55 dog kernel: RBP: 00007fff0b298cf0 R08:
000000000000002c R09: 0000000000000050
May 31 15:36:55 dog kernel: R10: 0000000000000000 R11:
0000000000000246 R12: 00007fff0b298cc0
May 31 15:36:55 dog kernel: R13: 000055fa021ed89e R14:
000000000000000b R15: 000055fa03ed2620
May 31 15:36:55 dog kernel:  </TASK>
May 31 15:36:55 dog kernel: ---[ end trace 0000000000000000 ]---
May 31 15:36:55 dog kernel: ------------[ cut here ]------------
May 31 15:36:55 dog kernel: WARNING: CPU: 10 PID: 40198 at
fs/btrfs/backref.c:1627 btrfs_is_data_extent_shared+0x3cf/0x3e0
[btrfs]
May 31 15:36:55 dog kernel: Modules linked in: snd_seq_dummy
snd_seq_midi snd_hrtimer snd_seq_midi_event snd_seq xt_nat veth
nft_chain_nat xt_MASQUERADE nf_nat xfrm_user xfrm_algo br_netfilter b>
May 31 15:36:55 dog kernel:  snd_soc_hdac_hda snd_hda_ext_core libarc4
snd_soc_acpi_intel_match snd_soc_acpi nvidia_drm(POE) snd_soc_core
snd_compress kvm soundwire_bus snd_hda_intel snd_intel_d>
May 31 15:36:55 dog kernel:  x_tables autofs4 nls_utf8 cifs cifs_arc4
cifs_md4 dns_resolver fscache netfs nls_ascii nls_cp437 vfat fat
dm_mod hid_microsoft ff_memless binfmt_misc fuse btrfs blak>
May 31 15:36:55 dog kernel: CPU: 10 PID: 40198 Comm: dpkg Tainted: P
     W  OE      6.1.0-9-amd64 #1  Debian 6.1.27-1
May 31 15:36:55 dog kernel: Hardware name: ASUS System Product
Name/ROG MAXIMUS Z690 FORMULA, BIOS 2103 09/30/2022
May 31 15:36:55 dog kernel: RIP:
0010:btrfs_is_data_extent_shared+0x3cf/0x3e0 [btrfs]
May 31 15:36:55 dog kernel: Code: 48 83 f8 fe 0f 85 a7 fe ff ff 48 8b
45 80 48 8d b8 b8 03 00 00 e8 d1 ca c0 eb 48 c7 85 78 ff ff ff 00 00
00 00 e9 fc fc ff ff <0f> 0b e9 4a fe ff ff e8 15 e9 bf>
May 31 15:36:55 dog kernel: RSP: 0018:ffffc011e51c7c60 EFLAGS: 00010212
May 31 15:36:55 dog kernel: RAX: 0000000000000006 RBX:
0000234f03518000 RCX: 00000000a74fe00a
May 31 15:36:55 dog kernel: RDX: 0000000000000000 RSI:
7b6841ce8bf7c8dc RDI: ffffc011e51c7bf0
May 31 15:36:55 dog kernel: RBP: ffffc011e51c7d00 R08:
ffffc011e51c7bd8 R09: ffffa0b0005ce880
May 31 15:36:55 dog kernel: R10: 000000000000000a R11:
0000000000000001 R12: ffffa0af801d1700
May 31 15:36:55 dog kernel: R13: ffffa0b0005cebe0 R14:
0000000000000012 R15: 0000000000000012
May 31 15:36:55 dog kernel: FS:  00007fdc7e0b3380(0000)
GS:ffffa0cc2d280000(0000) knlGS:0000000000000000
May 31 15:36:55 dog kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 00000000800500=
33
May 31 15:36:55 dog kernel: CR2: 000055fa0443f030 CR3:
0000000163820002 CR4: 0000000000770ee0
May 31 15:36:55 dog kernel: PKRU: 55555554
May 31 15:36:55 dog kernel: Call Trace:
May 31 15:36:55 dog kernel:  <TASK>
May 31 15:36:55 dog kernel:  ? btrfs_alloc_page_array+0x5d/0x90 [btrfs]
May 31 15:36:55 dog kernel:  ? extent_fiemap+0x97b/0xad0 [btrfs]
May 31 15:36:55 dog kernel:  extent_fiemap+0x97b/0xad0 [btrfs]
May 31 15:36:55 dog kernel:  btrfs_fiemap+0x45/0x80 [btrfs]
May 31 15:36:55 dog kernel:  do_vfs_ioctl+0x1f2/0x910
May 31 15:36:55 dog kernel:  __x64_sys_ioctl+0x6e/0xd0
May 31 15:36:55 dog kernel:  do_syscall_64+0x58/0xc0
May 31 15:36:55 dog kernel:  ? do_syscall_64+0x67/0xc0
May 31 15:36:55 dog kernel:  ? do_syscall_64+0x67/0xc0
May 31 15:36:55 dog kernel:  entry_SYSCALL_64_after_hwframe+0x63/0xcd
May 31 15:36:55 dog kernel: RIP: 0033:0x7fdc7e250afb
May 31 15:36:55 dog kernel: Code: 00 48 89 44 24 18 31 c0 48 8d 44 24
60 c7 04 24 10 00 00 00 48 89 44 24 08 48 8d 44 24 20 48 89 44 24 10
b8 10 00 00 00 0f 05 <89> c2 3d 00 f0 ff ff 77 1c 48 8b>
May 31 15:36:55 dog kernel: RSP: 002b:00007fff0b298c60 EFLAGS:
00000246 ORIG_RAX: 0000000000000010
May 31 15:36:55 dog kernel: RAX: ffffffffffffffda RBX:
0000000000001702 RCX: 00007fdc7e250afb
May 31 15:36:55 dog kernel: RDX: 00007fff0b298cf0 RSI:
00000000c020660b RDI: 000000000000000b
May 31 15:36:55 dog kernel: RBP: 00007fff0b298cf0 R08:
000000000000002c R09: 0000000000000050
May 31 15:36:55 dog kernel: R10: 0000000000000000 R11:
0000000000000246 R12: 00007fff0b298cc0
May 31 15:36:55 dog kernel: R13: 000055fa021ed89e R14:
000000000000000b R15: 000055fa03ed2620
May 31 15:36:55 dog kernel:  </TASK>
May 31 15:36:55 dog kernel: ---[ end trace 0000000000000000 ]---


On Mon, May 29, 2023 at 9:13=E2=80=AFAM David Sterba <dsterba@suse.cz> wrot=
e:
>
> On Sat, May 27, 2023 at 08:31:30PM -0500, ash lee wrote:
> > Hi, during running of a BTRFS balance, i ran into this bug. It ended
> > up deadlocking the BTRFS balance, and i could not pause/cancel it.
> >
> > I have the rest of the kernel logs as well if those would help.
> >
> > 2,3508,4363269431,-;kernel BUG at fs/inode.c:611!
>
> The code is
>
>  603 void clear_inode(struct inode *inode)
>  604 {
>  605         /*
>  606          * We have to cycle the i_pages lock here because reclaim ca=
n be in the
>  607          * process of removing the last page (in __filemap_remove_fo=
lio())
>  608          * and we must not free the mapping under it.
>  609          */
>  610         xa_lock_irq(&inode->i_data.i_pages);
>  611         BUG_ON(inode->i_data.nrpages);
>
>
>
> > 4,3512,4363269439,-;RIP: 0010:clear_inode+0x72/0x80
> > 4,3526,4363269454,-; evict+0xcd/0x1d0
> > 4,3527,4363269457,-; btrfs_relocate_block_group+0xb2/0x3f0 [btrfs]
> > 4,3528,4363269484,-; btrfs_relocate_chunk+0x3b/0x120 [btrfs]
> > 4,3529,4363269501,-; btrfs_balance+0x7a4/0xf70 [btrfs]
> > 4,3530,4363269517,-; btrfs_ioctl+0x2276/0x2610 [btrfs]
> > 4,3531,4363269533,-; ? __rseq_handle_notify_resume+0xa6/0x4a0
> > 4,3532,4363269535,-; ? proc_nr_files+0x30/0x30
> > 4,3533,4363269537,-; ? call_rcu+0x116/0x660
> > 4,3534,4363269539,-; ? percpu_counter_add_batch+0x53/0xc0
> > 4,3535,4363269541,-; __x64_sys_ioctl+0x8d/0xd0
> > 4,3536,4363269542,-; do_syscall_64+0x58/0xc0
> > 4,3537,4363269544,-; ? handle_mm_fault+0xdb/0x2d0
> > 4,3538,4363269546,-; ? preempt_count_add+0x47/0xa0
> > 4,3539,4363269547,-; ? up_read+0x37/0x70
> > 4,3540,4363269548,-; ? do_user_addr_fault+0x1ef/0x690
> > 4,3541,4363269550,-; ? fpregs_assert_state_consistent+0x22/0x50
> > 4,3542,4363269552,-; ? exit_to_user_mode_prepare+0x40/0x1d0
>
> > 20 46 ac
> > 6,3591,4708011011,-;traps: iotop[354859] general protection fault
> > ip:42b1bf sp:7fff207cf020 error:0 in python3.11[41f000+2b3000]
> > 6,3610,5061930113,-;iotop[359003]: segfault at 8e8 ip 00000000000008e8
> > sp 00007fff29df99d8 error 14 in python3.11[400000+1f000] likely on CPU
> > 10 (core 20, socket 0)
> > 6,3611,5061930122,-;Code: Unable to access opcode bytes at 0x8be.
> > 4,3625,5313827230,-;------------[ cut here ]------------
> > 4,3626,5313827233,-;WARNING: CPU: 21 PID: 392166 at
> > fs/btrfs/backref.c:1560 btrfs_is_data_extent_shared+0x2f6/0x3e0
> > [btrfs]
>
> A warning in btrfs_is_data_extent_shared but triggered from some inline
> function, I don't see a direct call.
>
> > 4,3632,5313827384,-;RIP: 0010:btrfs_is_data_extent_shared+0x2f6/0x3e0 [=
btrfs]
> > 4,3646,5313827433,-; ? btrfs_alloc_page_array+0x5d/0x90 [btrfs]
> > 4,3647,5313827463,-; ? extent_fiemap+0x97b/0xad0 [btrfs]
> > 4,3648,5313827492,-; extent_fiemap+0x97b/0xad0 [btrfs]
> > 4,3649,5313827521,-; btrfs_fiemap+0x45/0x80 [btrfs]
> > 4,3650,5313827548,-; do_vfs_ioctl+0x1f2/0x910
> > 4,3651,5313827552,-; __x64_sys_ioctl+0x6e/0xd0
> > 4,3652,5313827553,-; do_syscall_64+0x58/0xc0
> > 4,3653,5313827556,-; ? syscall_exit_to_user_mode+0x17/0x40
> > 4,3654,5313827558,-; ? do_syscall_64+0x67/0xc0
> > 4,3655,5313827560,-; ? handle_mm_fault+0xdb/0x2d0
> > 4,3656,5313827562,-; ? preempt_count_add+0x47/0xa0
> > 4,3657,5313827565,-; ? up_read+0x37/0x70
> > 4,3658,5313827566,-; ? do_user_addr_fault+0x1ef/0x690
> > 4,3659,5313827569,-; ? fpregs_assert_state_consistent+0x22/0x50
> > 4,3660,5313827571,-; ? exit_to_user_mode_prepare+0x40/0x1d0
> > 4,3661,5313827573,-; entry_SYSCALL_64_after_hwframe+0x63/0xcd
>
> And again
