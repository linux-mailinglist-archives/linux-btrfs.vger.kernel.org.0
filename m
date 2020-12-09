Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A00682D40B8
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Dec 2020 12:12:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730333AbgLILJd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 9 Dec 2020 06:09:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727221AbgLILJ0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 9 Dec 2020 06:09:26 -0500
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4B05C0613CF
        for <linux-btrfs@vger.kernel.org>; Wed,  9 Dec 2020 03:08:45 -0800 (PST)
Received: by mail-qk1-x742.google.com with SMTP id d14so125931qkc.13
        for <linux-btrfs@vger.kernel.org>; Wed, 09 Dec 2020 03:08:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=VeyntEt/ohYdh8C7LWnioNR+YRgUwKzalwVcd5TCbbc=;
        b=CcTkBVGSLGcZS5NsSBu+xquCS9qYWwyIl1mgi5YOHQhtwS+CqukJz6aP7h3YUbeGaq
         g0DEUXJlhjtYE6LklPQpq0CLeOCFThYCdataJDzrhv8ixsoLtFHyaLNEP6qzjN5+t60x
         hb4EYxu3PwE4REIhZcvDXK4e4vAOIPL3wFDPJu6vDfoL9WAPu8OtgTtLsiKUx8+svtVK
         Lp5y2mCbugRbldyEmRv0nhvCCk+DGx+GlPv+dnx7naKAC0q9y10UD33LGnbEb5Lo15V/
         U3JoU4bZpArxSWEm4c339PPph80zzcpEWltUqUXPu8GE+ysP6HhIQQ5uwbul/9pgbxhl
         Dl4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=VeyntEt/ohYdh8C7LWnioNR+YRgUwKzalwVcd5TCbbc=;
        b=PSKWxIZ/0gTLSvdmSmndH/0GmdQQskEAXrfHR/41yG4kKj3Wz+WveldYvuhjvf/vnn
         bdPCkNaLlXouqjxaJSxhKQUiQHe4eiPS0XS1q6vKCYRmThYwa9oyGCGFQiFsRyZ01Vvf
         3pmgKb8hswyAJolsrHp8DFx8KURY88Y88VdD2fa0kykbyzEcVaBf9w0pRx0EJZAfrYTc
         JgU0R59csSozCHm7LohdnyFlONLqf2nrDpNzxWOC8Bgc/315oGvY5BLTRgv++MNjzFT0
         wsRSmS+C8bCSWpqwWPPIXEpa218VWrWSfCGybJPhiYrcaf/b6jghc85ygmrS/e1Y0MWq
         amFA==
X-Gm-Message-State: AOAM530I+qS1sFgG5wLCTA2nBSBQtlEEnVhruf9n29O0zqya2lIaQ+wd
        X2QSiSRWfrT55AiwOkVMS90ydWtV9QyHB7s+QYo=
X-Google-Smtp-Source: ABdhPJzv4BDcxAI5+1mYlE6FOBuFlMTjmZ1Cjr501DM1j+zpGVHnX36kXDAKM9c5U2pJ5/X+zFbbV/A7u3Fy/vI5TbQ=
X-Received: by 2002:a37:6692:: with SMTP id a140mr2365781qkc.0.1607512124898;
 Wed, 09 Dec 2020 03:08:44 -0800 (PST)
MIME-Version: 1.0
References: <7ffdf22e-352c-70e3-eb7c-86c591febe7c@panasas.com>
In-Reply-To: <7ffdf22e-352c-70e3-eb7c-86c591febe7c@panasas.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Wed, 9 Dec 2020 11:08:33 +0000
Message-ID: <CAL3q7H7O=bgoR0Le_pi8vChWBhKzcUw_pRZmeXrgjO0mnr1DMA@mail.gmail.com>
Subject: Re: Assertion in tree-log.c
To:     "Ellis H. Wilson III" <ellisw@panasas.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Dec 7, 2020 at 5:57 PM Ellis H. Wilson III <ellisw@panasas.com> wro=
te:
>
> Hi all,
>
> We've hit this assertion a few times, and I wanted to know if it was a
> known issue:
>
> Dec 05 08:53:51 6afa1e4331fa46 kernel: assertion failed: ret =3D=3D 0, fi=
le:
> fs/btrfs/tree-log.c, line: 4286
> Dec 05 08:53:51 6afa1e4331fa46 kernel: ------------[ cut here ]----------=
--
> Dec 05 08:53:51 6afa1e4331fa46 kernel: kernel BUG at fs/btrfs/ctree.h:329=
5!
> Dec 05 08:53:51 6afa1e4331fa46 kernel: invalid opcode: 0000 [#1] SMP PTI
> Dec 05 08:53:51 6afa1e4331fa46 kernel: Modules linked in: af_packet_diag
> netlink_diag sctp_diag sctp libcrc32c tcp_diag udp_diag raw_diag
> inet_diag unix_diag af_packet binfmt_misc bonding iscsi_ibft
> iscsi_boot_sysfs msr nls_iso8859_1 nls_cp437 vfat fat dax_pmem btrfs(O)
> ipmi_ssif xor iTCO_wdt nd_pmem device_dax nd_btt raid6_pq
> iTCO_vendor_support intel_rapl ib_core skx_edac x86_pkg_temp_thermal
> intel_powerclamp coretemp raid0 kvm_intel kvm irqbypass crct10dif_pclmul
> crc32_pclmul crc32c_intel ghash_clmulni_intel pcbc aesni_intel
> aes_x86_64 crypto_simd glue_helper cryptd ioatdma md_mod ipmi_si nfit
> i2c_i801 lpc_ich mei_me shpchp ipmi_devintf mei dca pcspkr wmi joydev
> ipmi_msghandler libnvdimm acpi_pad button hid_generic usbhid ast
> i2c_algo_bit drm_kms_helper syscopyarea sysfillrect sysimgblt xhci_pci
> i40e(O) fb_sys_fops xhci_hcd
> Dec 05 08:53:52 6afa1e4331fa46 kernel:  ttm ptp pps_core nvme drm ahci
> drm_panel_orientation_quirks nvme_core usbcore libahci sg dm_multipath
> dm_mod scsi_dh_rdac scsi_dh_emc scsi_dh_alua efivarfs
> Dec 05 08:53:52 6afa1e4331fa46 kernel: CPU: 2 PID: 6897 Comm: iopathv4
> Tainted: G           O     4.12.14-lp150.11-default #1 openSUSE Leap
> 15.0 (unreleased)

As mentioned before by Chris, that's an old openSUSE Leap release.
You should move to Leap 15.2 (or 15.1, but its support ends by the end
of January).

> Dec 05 08:53:52 6afa1e4331fa46 kernel: task: ffff8808351146c0
> task.stack: ffffc90008704000
> Dec 05 08:53:52 6afa1e4331fa46 kernel: RIP:
> 0010:assfail.constprop.28+0x18/0x1a [btrfs]
> Dec 05 08:53:52 6afa1e4331fa46 kernel: RSP: 0018:ffffc90008707b08
> EFLAGS: 00010296
> Dec 05 08:53:52 6afa1e4331fa46 kernel: RAX: 0000000000000041 RBX:
> ffff880117eb0990 RCX: 0000000000000000
> Dec 05 08:53:52 6afa1e4331fa46 kernel: RDX: ffff88085c09fd40 RSI:
> ffff88085c097a68 RDI: ffff88085c097a68
> Dec 05 08:53:52 6afa1e4331fa46 kernel: RBP: 0000000000000ef2 R08:
> 0000000000002dde R09: 0000000000000003
> Dec 05 08:53:52 6afa1e4331fa46 kernel: R10: 0000000000000189 R11:
> 0000000000000001 R12: 0000160000000000
> Dec 05 08:53:52 6afa1e4331fa46 kernel: R13: 0000000000000096 R14:
> ffff880000000000 R15: ffff880141d39690
> Dec 05 08:53:52 6afa1e4331fa46 kernel: FS:  00007f7ca3d96700(0000)
> GS:ffff88085c080000(0000) knlGS:0000000000000000
> Dec 05 08:53:52 6afa1e4331fa46 kernel: CS:  0010 DS: 0000 ES: 0000 CR0:
> 0000000080050033
> Dec 05 08:53:52 6afa1e4331fa46 kernel: CR2: 00007f296c031c20 CR3:
> 000000083120a003 CR4: 00000000007606e0
> Dec 05 08:53:52 6afa1e4331fa46 kernel: DR0: 0000000000000000 DR1:
> 0000000000000000 DR2: 0000000000000000
> Dec 05 08:53:52 6afa1e4331fa46 kernel: DR3: 0000000000000000 DR6:
> 00000000fffe0ff0 DR7: 0000000000000400
> Dec 05 08:53:52 6afa1e4331fa46 kernel: PKRU: 55555554
> Dec 05 08:53:52 6afa1e4331fa46 kernel: Call Trace:
> Dec 05 08:53:52 6afa1e4331fa46 kernel:  copy_items+0x9b4/0xbe0 [btrfs]
> Dec 05 08:53:52 6afa1e4331fa46 kernel:  btrfs_log_inode+0x775/0xe00 [btrf=
s]
> Dec 05 08:53:52 6afa1e4331fa46 kernel:
> btrfs_log_inode_parent+0x249/0xd30 [btrfs]
> Dec 05 08:53:52 6afa1e4331fa46 kernel:  ? kmem_cache_alloc+0x1a8/0x510
> Dec 05 08:53:52 6afa1e4331fa46 kernel:  ?
> __filemap_fdatawrite_range+0xa3/0xe0
> Dec 05 08:53:52 6afa1e4331fa46 kernel:  ?
> __filemap_fdatawrite_range+0xb1/0xe0
> Dec 05 08:53:52 6afa1e4331fa46 kernel:  ? wait_current_trans+0x1f/0xd0
> [btrfs]
> Dec 05 08:53:52 6afa1e4331fa46 kernel:  ? join_transaction+0x22/0x3f0
> [btrfs]
> Dec 05 08:53:52 6afa1e4331fa46 kernel:  btrfs_log_dentry_safe+0x58/0x80
> [btrfs]
> Dec 05 08:53:52 6afa1e4331fa46 kernel:  btrfs_sync_file+0x2dc/0x420 [btrf=
s]
> Dec 05 08:53:52 6afa1e4331fa46 kernel:  do_fsync+0x38/0x60
> Dec 05 08:53:52 6afa1e4331fa46 kernel:  SyS_fsync+0xc/0x10
> Dec 05 08:53:52 6afa1e4331fa46 kernel:  do_syscall_64+0x7b/0x140
> Dec 05 08:53:52 6afa1e4331fa46 kernel:
> entry_SYSCALL_64_after_hwframe+0x3d/0xa2
> Dec 05 08:53:52 6afa1e4331fa46 kernel: RIP: 0033:0x7f7caaf8f5fc
> Dec 05 08:53:52 6afa1e4331fa46 kernel: RSP: 002b:00007f7ca3d93990
> EFLAGS: 00000293 ORIG_RAX: 000000000000004a
> Dec 05 08:53:52 6afa1e4331fa46 kernel: RAX: ffffffffffffffda RBX:
> 0000000000000000 RCX: 00007f7caaf8f5fc
> Dec 05 08:53:52 6afa1e4331fa46 kernel: RDX: 0000000000000000 RSI:
> 0000000000080002 RDI: 0000000000000111
> Dec 05 08:53:52 6afa1e4331fa46 kernel: RBP: 0000000000000000 R08:
> 0000000000001777 R09: 00000000eddb1d58
> Dec 05 08:53:52 6afa1e4331fa46 kernel: R10: fffffffffffffa88 R11:
> 0000000000000293 R12: 00007f7ca3d93a50
> Dec 05 08:53:52 6afa1e4331fa46 kernel: R13: 0000000001bea4e0 R14:
> 00000000eddb1d58 R15: f5402026a5ae13a5
> Dec 05 08:53:52 6afa1e4331fa46 kernel: Code: 80 a0 48 89 fe 48 c7 c7 30
> 27 81 a0 e8 61 70 9a e0 0f 0b 89 f1 48 c7 c2 3e bf 80 a0 48 89 fe 48 c7
> c7 00 29 81 a0 e8 47 70 9a e0 <0f> 0b 0f 1f 44 00 00 41 57 41 56 41 be
> f4 ff ff ff 41 55 41 54
> Dec 05 08:53:52 6afa1e4331fa46 kernel: RIP:
> assfail.constprop.28+0x18/0x1a [btrfs] RSP: ffffc90008707b08
> Dec 05 08:53:52 6afa1e4331fa46 kernel: ---[ end trace 13cc0fa206f6ac86 ]-=
--
>
>
> The closest thing I can find to it is this patch, which appears to be
> archived and open:
>
> https://lore.kernel.org/linux-btrfs/20190916151307.GB1645163@kroah.com/T/
>
> Sorry if my search-engine-skills are failing me and there is a better
> matching bug that's been fixed already for this.

No, that's a fix for a very different and unrelated problem.

What fixes the problem are the two following patches:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?=
id=3D0c713cbab6200b0ab6473b50435e450a6e1de85d

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?=
id=3D5e548b32018d96c377fda4bdac2bf511a448ca67

The second one does not mention any functional problem in its
changelog, but that's because I only realized it caused a functional
problem, a similar race like the first one, after it was merged into
Linus' tree.
Both are in openSUSE Leap 15.2 (and 15.1).

>
> Best,
>
> ellis



--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
