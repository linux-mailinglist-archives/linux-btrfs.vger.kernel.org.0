Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADF743DB5AE
	for <lists+linux-btrfs@lfdr.de>; Fri, 30 Jul 2021 11:11:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237895AbhG3JLz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 30 Jul 2021 05:11:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230513AbhG3JLy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 30 Jul 2021 05:11:54 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66A08C061765
        for <linux-btrfs@vger.kernel.org>; Fri, 30 Jul 2021 02:11:49 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id c7-20020a9d27870000b02904d360fbc71bso8789322otb.10
        for <linux-btrfs@vger.kernel.org>; Fri, 30 Jul 2021 02:11:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ch8MWzq+UnPiN5MYRHsS5qEeOcpy8UQavz8sBAor59c=;
        b=tXfuyEbDYpTjn3HUWxM3bCQcxc/ooC00nkkFqj3UIc8QZuRdOFa/yKh7jaZiaHzx1t
         UfUICzrc7HPfxLFeMd/BGjy2d1mViBPtmQcmpu6+XFGYSxIk23JzBXkqzmmt3Ea8ZPjr
         Qt/d+ok72YrhhsREG2SzQ3yQHB2fEzYytVCjsSRzc4rQ19T7JbFmYG0c8IhxZ0v7NGX4
         REoK5b0umv1FW/coMVqYZx3xCnzxVvul7xum/VgLIma0pwSsYh4u8Id9g3d6ThisZr5X
         TUIBCx39KXwvPvZoqJP6vmOUQfLYmV70DHgqbnd4XFU3+jV1LBxDgCH6WR6zoIgCe1dz
         FCuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ch8MWzq+UnPiN5MYRHsS5qEeOcpy8UQavz8sBAor59c=;
        b=fTWmUAGkgCmXyAaX3kTpnvGTBQaPJp4yJPLxetoOh2uX8wJOWo9i4Q7BlJxpzjyyxD
         dKVbg/y0mTOQc6KlJ82cyyCOxRm/IkXa1Jf2W+ARm+MjELEgxWxgPp+HgiNLW5aackjB
         O1OLzNwzBoHIEvh+Z1znm8Q1++NeU295tSv5P3HyaV4Nq053QxAGoxVpFXVGfTJbHO30
         8q9qOZR1CjZlJH2m/ahIBMrYG5LMWvvM1aReOyWhQUvTPHvS71VwsSgpGOnIDMXD/ZZ5
         zWzJ9CTSYjm+Qe5aoDwQSCPt4/thj3ho8QW109GlFekvLo7VTvLvwnbJ/LV6NwN7Iiqp
         RmEQ==
X-Gm-Message-State: AOAM530llb+xY8yIForWlO1YI0b9mChHzUEbpA0nM5hbX4GS+dFumiO9
        i4bre6ONIN/VI2HDz7CgkSdBqObRMjhiWYZktCzQ6geM/dw=
X-Google-Smtp-Source: ABdhPJwJeTe9Co/um7Xs/UaM9Oo4oHY0ppNXhiesopWSDboPoZlZOLnpUR1+pDcqbmyu7mRkwBYijMUaiuQzrD6/vag=
X-Received: by 2002:a05:6830:2476:: with SMTP id x54mr1247369otr.10.1627636308745;
 Fri, 30 Jul 2021 02:11:48 -0700 (PDT)
MIME-Version: 1.0
References: <CAHzMYBSap30NbnPnv4ka+fDA2nYGHfjYvD-NgT04t4vvN4q2sw@mail.gmail.com>
 <a5dd8f30-48f0-4954-f3fb-1a0722ae468f@gmail.com> <CAHzMYBQ+ALSKJbNqDy_=pyHEB_Y3CZ4X=hRYpx+7SWAcF58qiw@mail.gmail.com>
In-Reply-To: <CAHzMYBQ+ALSKJbNqDy_=pyHEB_Y3CZ4X=hRYpx+7SWAcF58qiw@mail.gmail.com>
From:   Jorge Bastos <jorge.mrbastos@gmail.com>
Date:   Fri, 30 Jul 2021 10:11:37 +0100
Message-ID: <CAHzMYBThqj1daz3owbewytXydnfrCkXj8j5qL2_9r07VHXhw5Q@mail.gmail.com>
Subject: Re: Why usable space can be so different?
To:     Andrei Borzenkov <arvidjaar@gmail.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Was going to convert the metadata do single profile since don't need
DUP for this but stupidly forgot to free up some space first, balance
crashed and fs went read_only, and strangely it does the same even
after mounting with skip_balance:

Jul 30 09:35:09 Tower1 kernel: BTRFS info (device sdz1): using free space tree
Jul 30 09:35:09 Tower1 kernel: BTRFS info (device sdz1): has skinny extents
Jul 30 09:35:13 Tower1 kernel: BTRFS info (device sdz1): balance: resume skipped
Jul 30 09:35:32 Tower1 kernel: ------------[ cut here ]------------
Jul 30 09:35:32 Tower1 kernel: BTRFS: Transaction aborted (error -28)
Jul 30 09:35:32 Tower1 kernel: WARNING: CPU: 7 PID: 4673 at
fs/btrfs/block-group.c:2122
btrfs_create_pending_block_groups+0x176/0x1ff
Jul 30 09:35:32 Tower1 kernel: Modules linked in: xt_CHECKSUM
ipt_REJECT xt_nat ip6table_mangle ip6table_nat veth iptable_mangle tun
md_mod ipmi_devintf iptable_nat xt_MASQUERADE nf_nat wireguard
curve25519_x86_64 libcurve25519_generic libchacha20poly1305
chacha_x86_64 poly1305_x86_64 ip6_udp_tunnel udp_tunnel libblake2s
blake2s_x86_64 libblake2s_generic libchacha ip6table_filter ip6_tables
iptable_filter ip_tables mlx4_en mlx4_core igb i2c_algo_bit sb_edac
x86_pkg_temp_thermal intel_powerclamp coretemp crct10dif_pclmul
crc32_pclmul crc32c_intel ghash_clmulni_intel aesni_intel crypto_simd
cryptd glue_helper rapl ipmi_ssif intel_cstate nvme i2c_i801
intel_uncore nvme_core ahci input_leds wmi i2c_smbus i2c_core
led_class libahci acpi_ipmi acpi_power_meter ipmi_si button acpi_pad
[last unloaded: vhost_iotlb]
Jul 30 09:35:32 Tower1 kernel: CPU: 7 PID: 4673 Comm: mc Tainted: G
    W         5.10.21-Unraid #1
Jul 30 09:35:32 Tower1 kernel: Hardware name: Supermicro Super
Server/X10SRi-F, BIOS 3.3 10/28/2020
Jul 30 09:35:32 Tower1 kernel: RIP:
0010:btrfs_create_pending_block_groups+0x176/0x1ff
Jul 30 09:35:32 Tower1 kernel: Code: 45 50 48 8d b8 40 0a 00 00 e8 ae
db ff ff 84 c0 75 1a 83 fb fb 74 15 83 fb e2 74 10 89 de 48 c7 c7 da
a1 d9 81 e8 9a 65 44 00 <0f> 0b 89 d9 ba 4a 08 00 00 48 c7 c6 00 9e c2
81 48 89 ef e8 3e 91
Jul 30 09:35:32 Tower1 kernel: RSP: 0018:ffffc9000360fdd0 EFLAGS: 00010286
Jul 30 09:35:32 Tower1 kernel: RAX: 0000000000000000 RBX:
00000000ffffffe4 RCX: 0000000000000027
Jul 30 09:35:32 Tower1 kernel: RDX: 00000000ffffefff RSI:
0000000000000001 RDI: ffff88903fbd8920
Jul 30 09:35:32 Tower1 kernel: RBP: ffff88815cc28270 R08:
0000000000000000 R09: 00000000ffffefff
Jul 30 09:35:32 Tower1 kernel: R10: ffffc9000360fc00 R11:
ffffc9000360fbf8 R12: ffff888cdd644508
Jul 30 09:35:32 Tower1 kernel: R13: 0000000000000004 R14:
0000000000000000 R15: ffff8881015b6000
Jul 30 09:35:32 Tower1 kernel: FS:  000015074d988740(0000)
GS:ffff88903fbc0000(0000) knlGS:0000000000000000
Jul 30 09:35:32 Tower1 kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
Jul 30 09:35:32 Tower1 kernel: CR2: 00007ffcdcb4bf18 CR3:
0000000101e96001 CR4: 00000000001706e0
Jul 30 09:35:32 Tower1 kernel: Call Trace:
Jul 30 09:35:32 Tower1 kernel: __btrfs_end_transaction+0x5b/0x150
Jul 30 09:35:32 Tower1 kernel: btrfs_unlink+0x9e/0xb6
Jul 30 09:35:32 Tower1 kernel: vfs_unlink+0x82/0xeb
Jul 30 09:35:32 Tower1 kernel: do_unlinkat+0xfe/0x1d3
Jul 30 09:35:32 Tower1 kernel: do_syscall_64+0x5d/0x6a
Jul 30 09:35:32 Tower1 kernel: entry_SYSCALL_64_after_hwframe+0x44/0xa9
Jul 30 09:35:32 Tower1 kernel: RIP: 0033:0x15074e246277
Jul 30 09:35:32 Tower1 kernel: Code: f0 ff ff 73 01 c3 48 8b 0d 16 6c
0d 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 66
90 b8 57 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d e9 6b 0d
00 f7 d8 64 89 01 48
Jul 30 09:35:32 Tower1 kernel: RSP: 002b:00007ffcdcb4fd18 EFLAGS:
00000206 ORIG_RAX: 0000000000000057
Jul 30 09:35:32 Tower1 kernel: RAX: ffffffffffffffda RBX:
00000000006167a0 RCX: 000015074e246277
Jul 30 09:35:32 Tower1 kernel: RDX: 000000000058d130 RSI:
00000000ffffffff RDI: 00000000005d1e70
Jul 30 09:35:32 Tower1 kernel: RBP: 00000000006133b0 R08:
0000000000000001 R09: 0000000000000000
Jul 30 09:35:32 Tower1 kernel: R10: 0000000000000000 R11:
0000000000000206 R12: 00007ffcdcb4fd7c
Jul 30 09:35:32 Tower1 kernel: R13: 0000000000000000 R14:
00000000005d14e0 R15: 00000000006133b0
Jul 30 09:35:32 Tower1 kernel: ---[ end trace 9e1013fad580900f ]---
Jul 30 09:35:32 Tower1 kernel: BTRFS: error (device sdz1) in
btrfs_create_pending_block_groups:2122: errno=-28 No space left
Jul 30 09:35:32 Tower1 kernel: BTRFS info (device sdz1): forced readonly
Jul 30 09:36:34 Tower1 kernel: BTRFS info (device sdz1): using free space tree
Jul 30 09:36:34 Tower1 kernel: BTRFS info (device sdz1): has skinny extents
Jul 30 09:36:38 Tower1 kernel: BTRFS info (device sdz1): balance: resume skipped
Jul 30 09:37:13 Tower1 kernel: ------------[ cut here ]------------


I'm just going to re-format these with xfs, I don't really need btrfs
for this, just used it because it's my default fs.
