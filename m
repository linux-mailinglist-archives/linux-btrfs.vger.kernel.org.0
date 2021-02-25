Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BF023257DD
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 Feb 2021 21:41:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234153AbhBYUkm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 25 Feb 2021 15:40:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233604AbhBYUkg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 25 Feb 2021 15:40:36 -0500
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EFD1C061574
        for <linux-btrfs@vger.kernel.org>; Thu, 25 Feb 2021 12:39:56 -0800 (PST)
Received: by mail-qk1-x72f.google.com with SMTP id z128so6968358qkc.12
        for <linux-btrfs@vger.kernel.org>; Thu, 25 Feb 2021 12:39:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=C+LvL0wuL8NwoVQ7Pnss9XgGDzsrNpez+sn5/6edmB8=;
        b=EIIfRNV9F0d2LC+QDJUnnaZ4hSmRH/ftdgHqJlSO7h5zdp/FWF0nzns5DdPY9Lnpd8
         xaKrTxuk2pYjw+k5PAemmpAZ/MZ3iUfBsNEM/rIFNRrzYNVi+oeAbD4rm/cp8RRYwa4E
         4sHKtWVJ8ZUYyjDqy1hN8JNhDqDscQUGvlD6uBToIf04elwLBdV4yeVp9Gws9BC38Rf6
         zIOnrfDlEv0btwFUWOfFkWdQnbAyywLJ4K+9sMXjrA+wdzjlTt7rliw2dOhkqgrnMD14
         89jDye6iyWISJJNYgR+A/urJ0SaRJgCKvq4e5oYPzb4HPRF/BTZyP+PlKA0kaec2tsVw
         o1nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=C+LvL0wuL8NwoVQ7Pnss9XgGDzsrNpez+sn5/6edmB8=;
        b=A4BBvAfdrRNbvQdk6PFzwErfOITCF8xtzKqoRFJ1t+dk+rpmoqencGtXMpv/1HR9uh
         RSKTCdszSUnC8EtYQrS9IjBlY2ewW+iQoRZGNP3E8frvpAf9kVsBxMVbs1E3E8UsJfaR
         OqjHn02io9IViIC2xqeSZ7FvaIoexRsSQAxKPC3aU5g8YMLiOL1uU1A4p2tLVGiyUw4R
         8uKPU1Lw93TsYAp63Dp/Qo6BMy0aym6BUW11FrpxeETuAZC1xI8miwtN8UeJdZsC8ksL
         nIrMIKYydSlkXHdrgU9gmxUK8j7c/rYnabiyFvd9BJ72QirpcCDI3Ym0mMVjVBPC9Rdx
         e21A==
X-Gm-Message-State: AOAM53277ERYNAI1cOGPxbfHzUl3q4jOOwLBts6bzwKBJUEavFhIJalP
        edu0FxfXWPri+WLQvYb2zdyTQMfwgtwRTTSlOk8=
X-Google-Smtp-Source: ABdhPJyu+uzVrDTefSl9ENfRutpvIF1wIn+VKvxQqsujQYqUHUrD3ojiKIEW2hBEEkx8AV0/eRyw0PNGLyK8zUui5ho=
X-Received: by 2002:a37:b482:: with SMTP id d124mr4289081qkf.338.1614285595298;
 Thu, 25 Feb 2021 12:39:55 -0800 (PST)
MIME-Version: 1.0
References: <434d856f-bd7b-4889-a6ec-e81aaebfa735.ref@schaufler-ca.com> <434d856f-bd7b-4889-a6ec-e81aaebfa735@schaufler-ca.com>
In-Reply-To: <434d856f-bd7b-4889-a6ec-e81aaebfa735@schaufler-ca.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Thu, 25 Feb 2021 20:39:44 +0000
Message-ID: <CAL3q7H4kxtm8HQ-VtNj42KhQmX3ehDnoKbV8Xn4YqEjMXLP_4g@mail.gmail.com>
Subject: Re: WARNING: CPU: 3 PID: 2548 at fs/btrfs/transaction.c:537 start_transaction+0x489/0x4f0
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Feb 25, 2021 at 7:52 PM Casey Schaufler <casey@schaufler-ca.com> wr=
ote:
>
> I recently upgraded a Smack based system to Fedora33. I now get
> this stack trace on a regular basis. The system appears to be
> functioning correctly, but I find the warning worrisome.

You have SELinux enabled I suppose.

Try the following patch:

https://pastebin.com/HXYCxyTD

And yes, the warning in this context, should cause no harm.

Thanks.

>
>
> [  220.732359] ------------[ cut here ]------------
> [  220.732398] WARNING: CPU: 3 PID: 2548 at fs/btrfs/transaction.c:537 st=
art_transaction+0x489/0x4f0
> [  220.732400] Modules linked in: nft_objref nf_conntrack_netbios_ns nf_c=
onntrack_broadcast nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib nft_rejec=
t_inet nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_ct nft_chain_nat ip6tab=
le_nat ip6table_mangle ip6table_raw ip6table_security iptable_nat nf_nat nf=
_conntrack nf_defrag_ipv6 nf_defrag_ipv4 iptable_mangle iptable_raw iptable=
_security ip_set nf_tables nfnetlink ip6table_filter rfkill ip6_tables ipta=
ble_filter bpfilter sunrpc snd_hda_codec_generic ledtrig_audio snd_hda_inte=
l snd_intel_dspcfg snd_hda_codec intel_rapl_msr intel_rapl_common snd_hda_c=
ore kvm_intel snd_hwdep snd_seq snd_seq_device snd_pcm snd_timer i2c_i801 i=
2c_smbus snd kvm virtio_balloon soundcore iTCO_wdt intel_pmc_bxt iTCO_vendo=
r_support lpc_ich irqbypass zram ip_tables crct10dif_pclmul crc32_pclmul qx=
l crc32c_intel drm_ttm_helper ttm drm_kms_helper cec drm ghash_clmulni_inte=
l serio_raw virtio_console virtio_net net_failover virtio_blk failover qemu=
_fw_cfg fuse
> [  220.732439] CPU: 3 PID: 2548 Comm: mkdir Not tainted 5.9.0-rc2smack+ #=
81
> [  220.732441] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1=
.13.0-2.fc32 04/01/2014
> [  220.732444] RIP: 0010:start_transaction+0x489/0x4f0
> [  220.732447] Code: e9 be fc ff ff be 03 00 00 00 4c 89 ff e8 3f b6 05 0=
0 85 c0 0f 84 8a fc ff ff c7 44 24 0c 00 00 00 00 4c 63 e0 e9 34 ff ff ff <=
0f> 0b e9 c7 fb ff ff be 02 00 00 00 e8 86 72 17 00 e9 f0 fb ff ff
> [  220.732449] RSP: 0018:ffffc90001887d10 EFLAGS: 00010202
> [  220.732452] RAX: ffff88816f1e0000 RBX: 0000000000000201 RCX: 000000000=
0000003
> [  220.732454] RDX: 0000000000000201 RSI: 0000000000000002 RDI: ffff88817=
7849000
> [  220.732456] RBP: ffff888177849000 R08: 0000000000000001 R09: 000000000=
0000004
> [  220.732458] R10: ffffffff825e8f7a R11: 0000000000000003 R12: fffffffff=
fffffe2
> [  220.732460] R13: 0000000000000000 R14: ffff88803d884270 R15: ffff88816=
80d8000
> [  220.732463] FS:  00007f67317b8440(0000) GS:ffff88817bcc0000(0000) knlG=
S:0000000000000000
> [  220.732465] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  220.732467] CR2: 00007f67247a22a8 CR3: 000000004bfbc002 CR4: 000000000=
0370ee0
> [  220.732472] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 000000000=
0000000
> [  220.732474] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 000000000=
0000400
> [  220.732475] Call Trace:
> [  220.732480]  ? slab_free_freelist_hook+0xea/0x1b0
> [  220.732483]  ? trace_hardirqs_on+0x1c/0xe0
> [  220.732490]  btrfs_setxattr_trans+0x3c/0xf0
> [  220.732496]  __vfs_setxattr+0x63/0x80
> [  220.732502]  smack_d_instantiate+0x2d3/0x360
> [  220.732507]  security_d_instantiate+0x29/0x40
> [  220.732511]  d_instantiate_new+0x38/0x90
> [  220.732515]  btrfs_mkdir+0x1cf/0x1e0
> [  220.732521]  vfs_mkdir+0x14f/0x200
> [  220.732525]  do_mkdirat+0x6d/0x110
> [  220.732531]  do_syscall_64+0x2d/0x40
> [  220.732534]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> [  220.732537] RIP: 0033:0x7f673196ae6b
> [  220.732540] Code: 8b 05 11 20 0d 00 41 bc ff ff ff ff 64 c7 00 16 00 0=
0 00 e9 37 ff ff ff e8 d2 f3 01 00 66 90 f3 0f 1e fa b8 53 00 00 00 0f 05 <=
48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d dd 1f 0d 00 f7 d8 64 89 01 48
> [  220.732542] RSP: 002b:00007ffc3c679b18 EFLAGS: 00000246 ORIG_RAX: 0000=
000000000053
> [  220.732545] RAX: ffffffffffffffda RBX: 00000000000001ff RCX: 00007f673=
196ae6b
> [  220.732547] RDX: 0000000000000000 RSI: 00000000000001ff RDI: 00007ffc3=
c67a30d
> [  220.732549] RBP: 00007ffc3c67a30d R08: 00000000000001ff R09: 000000000=
0000000
> [  220.732551] R10: 000055d3e39fe930 R11: 0000000000000246 R12: 000000000=
0000000
> [  220.732553] R13: 00007ffc3c679cd8 R14: 00007ffc3c67a30d R15: 00007ffc3=
c679ce0
> [  220.732563] irq event stamp: 11029
> [  220.732566] hardirqs last  enabled at (11037): [<ffffffff81153fe6>] co=
nsole_unlock+0x486/0x670
> [  220.732569] hardirqs last disabled at (11044): [<ffffffff81153c01>] co=
nsole_unlock+0xa1/0x670
> [  220.732572] softirqs last  enabled at (8864): [<ffffffff81e0102f>] asm=
_call_on_stack+0xf/0x20
> [  220.732575] softirqs last disabled at (8851): [<ffffffff81e0102f>] asm=
_call_on_stack+0xf/0x20
> [  220.732577] ---[ end trace 8f958916039daced ]---
>
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
