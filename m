Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13E6835081F
	for <lists+linux-btrfs@lfdr.de>; Wed, 31 Mar 2021 22:21:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236421AbhCaUVJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 31 Mar 2021 16:21:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236400AbhCaUVB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 31 Mar 2021 16:21:01 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE052C061574
        for <linux-btrfs@vger.kernel.org>; Wed, 31 Mar 2021 13:21:00 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id d191so10746473wmd.2
        for <linux-btrfs@vger.kernel.org>; Wed, 31 Mar 2021 13:21:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=RAw4z09/nQnQlvorb2ZoYgMD14DgI0lIEVTMwYymnL8=;
        b=ZmVRnegJTb5t0P+wDy4xQSlEaFg9u5OGWIjFgxJ/J83+JHvuAbFdqS0WX5uQWs8z7/
         3XfTJfhA+aHt5Bf22GGSZb5VT2iS7Iz0AefIRxHgcbC1f8rW5BIuEpZ4PDpflXo8MTvG
         kzYn3kkxxm5yL/34TXuhExeIttWJH//FcCTKReI6MHd1HikHK2SLJY7848hn/KjLiTRW
         GsZpkeiWmoLHCEDsnkr5SDx6lbFSqNoo81FEI1CiqQTS/Um7P2OD6/G8nDXNSq0Wikwt
         DxlLw0NOA69HRz9RnYkv7Fbx/B9e1p1+1MWLBNXtAKLLq56keinlXTRUk84EnpoZy2PO
         zxbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=RAw4z09/nQnQlvorb2ZoYgMD14DgI0lIEVTMwYymnL8=;
        b=L2oey0nnUgmB7cHjDSdHRiFlD/+8Zq3YkhpExz7Oc9nvPl0ZQUdzMGLxF3hPxS1fXJ
         BgkXxP9ZHwK0UaBMhyikZZxZH5AWRWbK3ta8MeStcBJUUvct8dAIAXNyIHG7t+RnjzPc
         JPt/5CSBogifq6OAkhcneBvVRxNQbPNucLkGV6OAEbo9OCD0Lepl+5Zdcua2EhXmT4vB
         CfdaFh51UYDZHE5F6v1cQkoU5Sl0K+eMhTU9ICtAdFJjqBBR4ZVQ7Zc71us/PXlNzVBE
         Zw/BycYDtUDj9rHJgH4m8aTmTnrAJHp2c2+aLh0Tg0esTvmPUqzkz+G/EaRDDQJy36gS
         Lviw==
X-Gm-Message-State: AOAM532ym5sj1ahCq4Xs+K+xlU/8XT/qLxOfDDWUM5RgcYGE25uQUnT9
        xNn2h63DPfJrG2VCfz1ihSzcIhYtGygZv1ipRo1EdvlhnJuznQ==
X-Google-Smtp-Source: ABdhPJwZCycfwbli6+reI2u0d/zq5ZlEj64yDp/wM7Em6BioT5D6h4mKd37K2JE8PT8Icz1szAA9jqeHmfIm3Mt7uuI=
X-Received: by 2002:a05:600c:acf:: with SMTP id c15mr4750042wmr.124.1617222059366;
 Wed, 31 Mar 2021 13:20:59 -0700 (PDT)
MIME-Version: 1.0
References: <43acc426-d683-d1b6-729d-c6bc4a2fff4d@gmail.com>
 <20210331015827.GV32440@hungrycats.org> <adbc670b-b85e-a44d-3089-089c4564f57f@gmail.com>
In-Reply-To: <adbc670b-b85e-a44d-3089-089c4564f57f@gmail.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Wed, 31 Mar 2021 14:20:43 -0600
Message-ID: <CAJCQCtSKjcDuVprCq_kjaMrwgJ1QXq=8YaU9b8hok+sqYhvqxA@mail.gmail.com>
Subject: Re: Any ideas what this warnings are about?
To:     Markus Schaaf <markuschaaf@gmail.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Mar 31, 2021 at 4:33 AM Markus Schaaf <markuschaaf@gmail.com> wrote=
:
>
> Am 31.03.21 um 03:58 schrieb Zygo Blaxell:
>
> >> ------------[ cut here ]------------
> >> WARNING: CPU: 1 PID: 314 at fs/fs-writeback.c:2472 __writeback_inodes_=
sb_nr+0xb8/0xd0
> >> Modules linked in: iTCO_wdt wireguard curve25519_x86_64 libchacha20pol=
y1305 intel_pmc_bxt iTCO_vendor_support chacha_x86_64 poly1305_x86_64 libbl=
ake2s blake2s_x86_64 ip6_udp_tunnel udp_tunnel libcurve25519_generic libcha=
cha libblake2s_generic psmouse joydev mousedev pcspkr i2c_i801 i2c_smbus lp=
c_ich iptable_filter xt_nat xt_tcpudp intel_agp intel_gtt iptable_nat nf_na=
t qemu_fw_cfg nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 mac_hid vfat fat a=
uth_rpcgss sunrpc fuse ip_tables x_tables btrfs blake2b_generic libcrc32c c=
rc32c_generic xor raid6_pq dm_crypt cbc encrypted_keys trusted tpm usbhid d=
m_mod virtio_gpu virtio_dma_buf drm_kms_helper syscopyarea sysfillrect sysi=
mgblt fb_sys_fops cec drm virtio_scsi virtio_balloon virtio_net virtio_cons=
ole net_failover agpgart failover crct10dif_pclmul crc32_pclmul crc32c_inte=
l ghash_clmulni_intel aesni_intel crypto_simd cryptd glue_helper serio_raw =
sr_mod cdrom xhci_pci virtio_pci virtio_rng rng_core
> >> CPU: 1 PID: 314 Comm: btrfs-transacti Tainted: G        W         5.10=
.26-1-MANJARO #1
> >> Hardware name: Hetzner vServer, BIOS 20171111 11/11/2017
> >> RIP: 0010:__writeback_inodes_sb_nr+0xb8/0xd0
> >> Code: 0f b6 d1 48 8d 74 24 10 e8 35 fc ff ff 48 89 e7 e8 7d fb ff ff 4=
8 8b 44 24 48 65 48 2b 04 25 28 00 00 00 75 09 48 83 c4 50 c3 <0f> 0b eb cf=
 e8 df 8c 75 00 66 66 2e 0f 1f 84 00 00 00 00 00 0f 1f
> >> RSP: 0018:ffffb1f5448f7d98 EFLAGS: 00010246
> >> RAX: 0000000000000000 RBX: ffff961185aa5488 RCX: 0000000000000000
> >> RDX: 0000000000000002 RSI: 0000000000004b45 RDI: ffff9611b7220000
> >> RBP: ffff9611b64d3958 R08: ffff961184efc800 R09: 0000000000000140
> >> R10: ffff9611859e6400 R11: ffff961192af3c10 R12: ffff9611838f7c00
> >> R13: ffff961185aa5000 R14: ffff961185aa5460 R15: 0000000000011a0f
> >> FS:  0000000000000000(0000) GS:ffff9611fad00000(0000) knlGS:0000000000=
000000
> >> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> >> CR2: 00007f654bc76b58 CR3: 0000000002c60000 CR4: 00000000003506e0
> >> Call Trace:
> >>   btrfs_commit_transaction+0x448/0xbc0 [btrfs]
> >>   ? start_transaction+0xcc/0x5b0 [btrfs]
> >>   transaction_kthread+0x143/0x170 [btrfs]
> >>   ? btrfs_cleanup_transaction.isra.0+0x560/0x560 [btrfs]
> >>   kthread+0x133/0x150
> >>   ? __kthread_bind_mask+0x60/0x60
> >>   ret_from_fork+0x22/0x30
> >> ---[ end trace 3cefecf5d9d20b50 ]---
> >>
> >> ------------[ cut here ]------------
> >> WARNING: CPU: 0 PID: 758 at fs/fs-writeback.c:2472 __writeback_inodes_=
sb_nr+0xb8/0xd0
> >
> > That bug was introduced in 4.15 as part of a fix for a deadlock bug.
> > It's still there today.  Not very high on anyone's TODO list as it's
> > mostly harmless--btrfs can't be umounted during a transaction as the
> > umount itself uses a transaction.  The warning doesn't come from btrfs
> > code, so we can't just turn it off.
>
> That warning spams my logs every 1-5 minutes. There is no unmounting
> happening.
>
> >
> >> Modules linked in: iTCO_wdt wireguard curve25519_x86_64 libchacha20pol=
y1305 intel_pmc_bxt iTCO_vendor_support chacha_x86_64 poly1305_x86_64 libbl=
ake2s blake2s_x86_>
> >> CPU: 0 PID: 758 Comm: journal-offline Tainted: G        W         5.10=
.26-1-MANJARO #1
> >> Hardware name: Hetzner vServer, BIOS 20171111 11/11/2017
> >> RIP: 0010:__writeback_inodes_sb_nr+0xb8/0xd0
> >> Code: 0f b6 d1 48 8d 74 24 10 e8 35 fc ff ff 48 89 e7 e8 7d fb ff ff 4=
8 8b 44 24 48 65 48 2b 04 25 28 00 00 00 75 09 48 83 c4 50 c3 <0f> 0b eb cf=
 e8 df 8c 75 00 66>
> >> RSP: 0018:ffffb1f540d7fd40 EFLAGS: 00010246
> >> RAX: 0000000000000000 RBX: ffff961185aa5488 RCX: 0000000000000000
> >> RDX: 0000000000000002 RSI: 0000000000004be5 RDI: ffff9611b7220000
> >> RBP: ffff961182209208 R08: ffff961184efc800 R09: 0000000000000140
> >> R10: ffff9611859e6400 R11: ffff961192af3c10 R12: ffff961183891200
> >> R13: ffff961185aa5000 R14: ffff961185aa5460 R15: ffff9611b65d5e10
> >> FS:  00007f654b80e640(0000) GS:ffff9611fac00000(0000) knlGS:0000000000=
000000
> >> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> >> CR2: 00007f654cf39010 CR3: 0000000003884000 CR4: 00000000003506f0
> >> Call Trace:
> >>   btrfs_commit_transaction+0x448/0xbc0 [btrfs]
> >>   ? btrfs_wait_ordered_range+0x1b8/0x210 [btrfs]
> >>   ? btrfs_sync_file+0x2b8/0x4e0 [btrfs]
> >>   btrfs_sync_file+0x343/0x4e0 [btrfs]
> >>   __x64_sys_fsync+0x34/0x60
> >>   do_syscall_64+0x33/0x40
> >
> > Normally you need to mount -o flushoncommit to trigger this warning.
> > Maybe sync is triggering it too?
>
> I've looked again and yes, this "special" filesystem is mounted
> flushoncommit and discard=3Dasync. Would it be better to not set these
> options, for now?


Flushoncommit is safe but noisy in dmesg, and can make things slow it
just depends on the workload. And discard=3Dasync is also considered
safe, though relatively new. The only way to know for sure is disable
it, and only it, run for some time period to establish "normative"
behavior, and then enable only this option and see if behavior changes
from the baseline.

If you don't have a heavy write and delete workload, you may not
really need discard=3Dasync anyway, and a weekly fstrim is generally
sufficient for the fast majority of workloads. Conversely a heavy
write and delete workload translates into a backlog of trim that gets
issued all at once, once a week, and can make an SSD bog down after
it's issued. So you just have to test it with your particular workload
to know.

Discard=3Dasync exists because a weekly fstrim, and discard=3Dsync can
supply way too much hinting all at once to the drive about what blocks
are no longer needed and are ready for garbage collection. But again,
it's workload specific, and even hardware specific. Some hardware is
sufficiently overprovisioned that there's no benefit to issuing
discards at all, and normal usage gives the drive firmware all it
needs to know about what blocks are ready for garbage collection (and
erasing blocks to prepare them for future writes).

--=20
Chris Murphy
