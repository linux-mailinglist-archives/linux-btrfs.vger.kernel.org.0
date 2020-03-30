Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F0B111987A4
	for <lists+linux-btrfs@lfdr.de>; Tue, 31 Mar 2020 00:57:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728987AbgC3W5b (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 30 Mar 2020 18:57:31 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:56006 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728876AbgC3W5b (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 30 Mar 2020 18:57:31 -0400
Received: by mail-wm1-f67.google.com with SMTP id r16so551521wmg.5
        for <linux-btrfs@vger.kernel.org>; Mon, 30 Mar 2020 15:57:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1ZQRQYnsMdJ1K6ze3pf7G0hbFdsAYTOSKUaKNVv1MYU=;
        b=TrtI7IlK8ZeygtwShbtG5R35XeXg6ipkbSOaCatJGShig/GibF4eSkZxn3LnNnLulT
         u+RJJmVcsh0XBQ2eiq0OVb+U1FFI2votZh5d4C0AAHTBnhxFA75gZa7UJyyFxUp3C9Pr
         l2944OOd9vCMFdXSCABuX6Y0te+37HA1a6V1hYcLXbzunrS7GhIftOkVjWcx8QnAKcnL
         ZDd+nvppoZRUMH5/o2sGFhoWD8qnOXc2KNNY93iLZxDghMBkjyBPwNBrYh6yqDa10U6s
         aS5C7CED5GKZVzHwBfbyIzUkWjTBOO2Ee8Qu8Bl3rjFg5BpOP+XEOjojnZJcIxo3UkwP
         RLZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1ZQRQYnsMdJ1K6ze3pf7G0hbFdsAYTOSKUaKNVv1MYU=;
        b=dw5djTAP2UINmVQGo8s9T5XBoskanrVnMZHkCk8Rub2s3UcJ4Mb6Y5vUJdjRQpQH1i
         oekHZfBZfOOKyVKJYP1y0coBblukbltXLLxdWBzd55dhaQnkwH4wJrJ1uROhhdqLlms0
         nT8U5/Wc7SL/c7H0y+iSxUJgtYQqHoExxbqnwcULfDpILiO9fzkUp7ADoDzzl3k6D3mD
         PL4Dz1AZpxkpl7m7MRROowMoV1IjLmkemuBG1IFDhy7bmKrEP6SC08Yg8OOx3Y89rqUm
         8H6n98qbxJ7Skor1YTPLkRgI+xZjzse+3Kzy1jKfIurbhj5WbafBgRWI5IgjX12wcqtr
         3ZmA==
X-Gm-Message-State: ANhLgQ0BqWESzAtug4Ud/a88f9ewnqsc7Bphxt6221co2+4mdcMnzP3w
        oKLt4L/cIsSU0TMWMd3oxsOMVWZ325gfzfxD1IBVFQ==
X-Google-Smtp-Source: ADFU+vulCBdN0ZNtIdc80M119LbwcPR5xnxHJIHisUrfZaIM/LJeC5ZIIzJ/SwW3W+jwTM/hGdiq5hUwr2KpDjzto8E=
X-Received: by 2002:a1c:540f:: with SMTP id i15mr371765wmb.124.1585609048691;
 Mon, 30 Mar 2020 15:57:28 -0700 (PDT)
MIME-Version: 1.0
References: <CAOH-_yXQD9D1emP6bPw1vO3SYfxxVqy8D5ONRXnZTbBeEgyPrw@mail.gmail.com>
In-Reply-To: <CAOH-_yXQD9D1emP6bPw1vO3SYfxxVqy8D5ONRXnZTbBeEgyPrw@mail.gmail.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Mon, 30 Mar 2020 16:57:12 -0600
Message-ID: <CAJCQCtQ1JUzsbu97j5OJz9=H0y7qeAOsOkMCj8=VLKGfYzyt8A@mail.gmail.com>
Subject: Re: Corrupted btrfs after cpu overheat
To:     carlos ortega <carlosortega0113z@gmail.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Mar 28, 2020 at 5:40 PM carlos ortega
<carlosortega0113z@gmail.com> wrote:
> dmesg
> [    0.000000] DMI: innotek GmbH VirtualBox/VirtualBox, BIOS

It's a lot more complicated to figure out what went wrong, because
there are multiple layers between Btrfs and the hardware in this case.


> [   24.426496] BTRFS: device label parrot-home devid 1 transid 10086
> /dev/mapper/parrot--vg-home
> [   24.426790] BTRFS: device label parrot-opt devid 1 transid 69
> /dev/mapper/parrot--vg-opt

Also, this Btrfs is on top of device-mapper (dm-crypt or LVM? or
both?) so it's more layers. That's not to say it shouldn't work and be
safe. It's just a lot harder to figure out what went wrong.


> [   39.141310] BTRFS info (device dm-2): setting nodatacow, compression disabled
> [   39.141313] BTRFS info (device dm-2): use zlib compression, level 3
> [   39.141314] BTRFS info (device dm-2): turning on discard
> [   39.141315] BTRFS info (device dm-2): disk space caching is enabled
> [   39.141316] BTRFS info (device dm-2): has skinny extents
> [   39.353529] BTRFS info (device dm-3): setting nodatacow, compression disabled
> [   39.353532] BTRFS info (device dm-3): use zlib compression, level 3
> [   39.353534] BTRFS info (device dm-3): turning on discard
> [   39.353535] BTRFS info (device dm-3): disk space caching is enabled
> [   39.353536] BTRFS info (device dm-3): has skinny extents
> [   39.841262] BTRFS info (device dm-3): checking UUID tree


Can you post the /etc/fstab for this file system? There are
conflicting mount options, nodatacow means no compression.

Also, the discard mount option can complicate things if discards end
up being out of order from other commits.



> [   39.842514] BTRFS error (device dm-3): parent transid verify failed
> on 37978112 wanted 10077 found 10086
> [   39.859415] BTRFS error (device dm-3): parent transid verify failed
> on 37978112 wanted 10077 found 10086

It wants a transid that's older than what it has. That's definitely
not normal. What do you get for:

# btrfs insp dump-s /dev/dm-3

5.4.19 is current but has this file system ever been written to by
kernel 5.2.0-5.2.14?




> [   39.859968] ------------[ cut here ]------------
> [   39.860007] WARNING: CPU: 0 PID: 727 at fs/btrfs/extent-tree.c:3071
> __btrfs_free_extent.isra.0+0x6a0/0x980 [btrfs]
> [   39.860008] Modules linked in: joydev(E) pktcdvd(E)
> snd_intel8x0(E+) snd_ac97_codec(E) ac97_bus(E) snd_pcm(E) snd_timer(E)
> snd(E) soundcore(E) sg(E) evdev(E) serio_raw(E) ac(E) pcspkr(E)
> edac_mce_amd(E) parport_pc(E) ppdev(E) lp(E) parport(E) ip_tables(E)
> x_tables(E) autofs4(E) dm_crypt(E) dm_mod(E) raid10(E) raid456(E)
> async_raid6_recov(E) async_memcpy(E) async_pq(E) async_xor(E)
> async_tx(E) raid1(E) raid0(E) multipath(E) linear(E) md_mod(E) xfs(E)
> btrfs(E) xor(E) zstd_decompress(E) zstd_compress(E) raid6_pq(E)
> libcrc32c(E) ext4(E) crc16(E) mbcache(E) jbd2(E) crc32c_generic(E)
> nls_ascii(E) hid_generic(E) usbhid(E) hid(E) crct10dif_pclmul(E)
> crc32_pclmul(E) crc32c_intel(E) sr_mod(E) cdrom(E) sd_mod(E)
> ghash_clmulni_intel(E) ata_generic(E) xhci_pci(E) vmwgfx(E)
> xhci_hcd(E) ttm(E) ata_piix(E) aesni_intel(E) libata(E) crypto_simd(E)
> drm_kms_helper(E) cryptd(E) e1000(E) glue_helper(E) usbcore(E)
> psmouse(E) usb_common(E) i2c_piix4(E) drm(E) scsi_mod(E) video(E)
> button(E)
> [   39.860036] CPU: 0 PID: 727 Comm: mount Tainted: G            E
> 5.4.0-4parrot1-amd64 #1 Parrot 5.4.19-4parrot1
> [   39.860037] Hardware name: innotek GmbH VirtualBox/VirtualBox, BIOS
> VirtualBox 12/01/2006
> [   39.860051] RIP: 0010:__btrfs_free_extent.isra.0+0x6a0/0x980 [btrfs]
> [   39.860053] Code: ff ff 48 8b 3c 24 4d 89 f0 4c 89 e9 48 c7 44 24
> 48 00 00 00 00 48 89 ea 4c 89 e6 e8 9a b4 ff ff 41 89 c7 e9 8e fb ff
> ff 0f 0b <0f> 0b 49 8b 3c 24 e8 65 5a 00 00 49 89 d9 4d 89 f0 4c 89 e9
> ff b4
> [   39.860054] RSP: 0018:ffffae6f40427938 EFLAGS: 00010246
> [   39.860055] RAX: 00000000fffffffe RBX: 0000000000000000 RCX: 0000000000000002
> [   39.860055] RDX: 00000000fffffffe RSI: 0000000000000000 RDI: 0000000000000000
> [   39.860056] RBP: 0000000001504000 R08: 0000000000000000 R09: 0000000000000000
> [   39.860057] R10: 0000000000000002 R11: 0000000000000000 R12: ffff890aca4801c0
> [   39.860057] R13: 0000000000000000 R14: 0000000000000003 R15: 00000000fffffffe
> [   39.860058] FS:  00007fc7f83b6c80(0000) GS:ffff890ad9a00000(0000)
> knlGS:0000000000000000
> [   39.860059] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   39.860059] CR2: 000055a574d179d8 CR3: 000000019772a000 CR4: 00000000000406f0
> [   39.860063] Call Trace:
> [   39.860099]  ? btrfs_merge_delayed_refs+0x31a/0x370 [btrfs]
> [   39.860114]  __btrfs_run_delayed_refs+0x749/0xf90 [btrfs]
> [   39.860119]  ? kmem_cache_alloc+0x159/0x210
> [   39.860132]  btrfs_run_delayed_refs+0x72/0x190 [btrfs]
> [   39.860165]  btrfs_commit_transaction+0x54/0x9a0 [btrfs]
> [   39.860201]  ? start_transaction+0x95/0x480 [btrfs]
> [   39.860216]  close_ctree+0x29d/0x2f0 [btrfs]
> [   39.860230]  btrfs_mount_root+0x66c/0x690 [btrfs]
> [   39.860233]  ? __lookup_constant+0x46/0x60
> [   39.860234]  legacy_get_tree+0x27/0x40
> [   39.860237]  vfs_get_tree+0x25/0xb0
> [   39.860238]  fc_mount+0xe/0x30
> [   39.860240]  vfs_kern_mount.part.0+0x71/0x90
> [   39.860253]  btrfs_mount+0x155/0x8a0 [btrfs]
> [   39.860256]  ? filename_lookup+0xf1/0x170
> [   39.860258]  ? tomoyo_init_request_info+0x86/0x90
> [   39.860259]  ? tomoyo_mount_permission+0x3e/0x1c0
> [   39.860260]  ? __lookup_constant+0x46/0x60
> [   39.860262]  ? legacy_get_tree+0x27/0x40
> [   39.860263]  legacy_get_tree+0x27/0x40
> [   39.860264]  vfs_get_tree+0x25/0xb0
> [   39.860266]  do_mount+0x770/0x980
> [   39.860267]  ksys_mount+0x7e/0xc0
> [   39.860269]  __x64_sys_mount+0x21/0x30
> [   39.860271]  do_syscall_64+0x52/0x160
> [   39.860273]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> [   39.860275] RIP: 0033:0x7fc7f825acda
> [   39.860277] Code: 48 8b 0d b9 e1 0b 00 f7 d8 64 89 01 48 83 c8 ff
> c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 49 89 ca b8 a5 00 00
> 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 86 e1 0b 00 f7 d8 64 89
> 01 48
> [   39.860278] RSP: 002b:00007fffe3040f48 EFLAGS: 00000246 ORIG_RAX:
> 00000000000000a5
> [   39.860289] RAX: ffffffffffffffda RBX: 00005633fb563a00 RCX: 00007fc7f825acda
> [   39.860290] RDX: 00005633fb563c10 RSI: 00005633fb563cf0 RDI: 00005633fb563c30
> [   39.860298] RBP: 00007fc7f83b0204 R08: 00005633fb563c80 R09: 00007fc7f829b4c0
> [   39.860299] R10: 0000000000000c00 R11: 0000000000000246 R12: 0000000000000000
> [   39.860299] R13: 0000000000000c00 R14: 00005633fb563c30 R15: 00005633fb563c10
> [   39.860301] ---[ end trace 2155c25bb5f33a74 ]---
> [   39.860304] BTRFS info (device dm-3): leaf 30605312 gen 10087 total
> ptrs 8 free space 15846 owner 2
> [   39.860305] item 0 key (22020096 169 0) itemoff 16250 itemsize 33
> [   39.860306] extent refs 1 gen 10087 flags 2
> [   39.860306] ref#0: tree block backref root 3
> [   39.860307] item 1 key (22020096 192 8388608) itemoff 16226 itemsize 24
> [   39.860308] block group used 0 chunk_objectid 256 flags 34
> [   39.860309] item 2 key (30408704 192 268435456) itemoff 16202 itemsize 24
> [   39.860310] block group used 65536 chunk_objectid 256 flags 36
> [   39.860311] item 3 key (30441472 169 0) itemoff 16169 itemsize 33
> [   39.860312] extent refs 1 gen 10079 flags 2
> [   39.860312] ref#0: tree block backref root 18446744073709551607
> [   39.860313] item 4 key (30457856 169 0) itemoff 16136 itemsize 33
> [   39.860314] extent refs 1 gen 10086 flags 2
> [   39.860314] ref#0: tree block backref root 7
> [   39.860315] item 5 key (30474240 169 0) itemoff 16103 itemsize 33
> [   39.860316] extent refs 1 gen 10086 flags 2
> [   39.860316] ref#0: tree block backref root 2
> [   39.860317] item 6 key (30490624 169 0) itemoff 16070 itemsize 33
> [   39.860318] extent refs 1 gen 10086 flags 2
> [   39.860318] ref#0: tree block backref root 1
> [   39.860319] item 7 key (13183746048 192 1073741824) itemoff 16046 itemsize 24
> [   39.860320] block group used 0 chunk_objectid 256 flags 1
> [   39.860321] BTRFS error (device dm-3): unable to find ref byte nr
> 22036480 parent 0 root 3  owner 0 offset 0

No idea.

What's the complete output you get for 'btrfs check' on this file
system (without --repair).


-- 
Chris Murphy
