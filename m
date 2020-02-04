Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C5475151AC3
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 Feb 2020 13:50:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727164AbgBDMuQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 4 Feb 2020 07:50:16 -0500
Received: from mail.orlives.de ([148.251.55.246]:50164 "EHLO mail.orlives.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727126AbgBDMuQ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 4 Feb 2020 07:50:16 -0500
X-Greylist: delayed 332 seconds by postgrey-1.27 at vger.kernel.org; Tue, 04 Feb 2020 07:50:14 EST
Received: from mail.orlives.de (localhost [127.0.0.1])
        by mail.orlives.de (Postfix) with ESMTPSA id 1FB83A0040
        for <linux-btrfs@vger.kernel.org>; Tue,  4 Feb 2020 13:44:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=orlives.de; s=dkim1;
        t=1580820280;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
        to:to:cc:mime-version:mime-version:content-type:content-type:autocrypt:autocrypt;
        bh=bTJcAwGuoH6fUARF4ipWyxzcFXBteNkZdJ/5Typk1eU=;
        b=wmLOG4vNrJVpYMxcGh7a+qP1s8Qx/pm2fQ486ybc7R3HqOOlDwGFHf29rsu/fAGJFX5iT4
        BELQH1f75pTEJWMWPvVIYri6XZXR0ZrxCjxIldAlgvOm7Mp7vuHn7v7bjPD1nwQoNpbOlm
        5vray4cXNnCq+f5TbLnVFC/plLi2ZjCFgTcdtD0Ce3NEuPKfJ52wtCuiAAykWKO7perIjW
        bGPF0Vpo97UssdgIBfRPnkaQCzm0pYTWh6eM9y5kIj20rj/xAl+xLcVLBRcmlUinY8STOi
        m3PT/naCJGculbdEq8J9UB3kZ4Lqa/UuhIvf3BBIYiJHCFjrJ7iynY+0kk/pwx6/1KYZsi
        FZVpz26TS5ex3GgvfyntejGv7+2XKj21UV2D/vS5E17zBi9fYizAItj6ymPdqCCySzoJ9s
        /KsYFhxorp8VLXGdnjqS71gHz76EQE3LGZMQxGdZrEk2Z21YugeCUaf84Cy1ySy57P8XAh
        Q3C4gsBdFzb0X7WQC2yHfCE8LWd9z6wdVN7hnqMdojl+nkV4JXzwXj9pPJdIIwhuIQVy/m
        HCSV11SZaMsKKPXMchq6TWh0XYYsYo5j451r6gqudNcAH9ZjoTNL/Gs5PnlfXOkRJ74JYP
        aKb/bgmFcK6hADUww5y0htA/oD7clNotbWUfvyRIwuzp6AVOpVT/o=
To:     linux-btrfs@vger.kernel.org
From:   Trolli Schmittlauch <t.schmittlauch+ml@orlives.de>
Autocrypt: addr=t.schmittlauch+ml@orlives.de; prefer-encrypt=mutual; keydata=
 mQENBF4y2DoBCADCzwZ+V1tJOR2JK20uAVPkAOC5PdIe/UYCVZsYIbh8aIz0HsiqWeTCj3J8
 nZEVKKm6fQRtyMILZeWNHQ98ck+1tmr4a6UQ4UDl+Xb1VuhU4frZI/d75olkn2JNwYcJJcdn
 MJ4WUZ8BWhmia+8ng+7nJ1yOw1ad0uS8dL+w+m+eimFr7HjIXUV/Y5I8NGhkROFDu72byMn1
 OTaq4HFfgilYsDGu8AWUtn+ZBXmCDIYbvXANjDcyuGTTnS/vgyFx66rHOgZKqTafuSAC1k61
 dAYvLlo06yb4S4VNwkW17ho9L6sgqfY5rFd+zQYnXdau7AK7TLAFywHgafHU20Ffv6PbABEB
 AAG0Gzx0LnNjaG1pdHRsYXVjaEBvcmxpdmVzLmRlPokBSQQQAQgAMwIZAQUCXjLYQAIbAwQL
 CQgHBhUICQoLAgMWAgEWIQSJFhEikPObK3+nglaeUEWy+uvFawAKCRCeUEWy+uvFa6UPCACt
 EeMFD8HIbP6vIfs0dQdYw7SyG/Ws/ZEhi61+HfBeltem2LMbcY3B1UNGWWt1px1oFq0sCd12
 j8JhjTPyFoQv+vRDEygMk/OrXfnn32dl9Ttubgz68ktxjv6xQ2q+TGHStUCe9Q1opGqjWqV0
 bqFV9nbpX5DX3urG4eDqjUrvUMasp3/RBBC6dSzRcutbmnFEUhbnQcG2JhxkUqJxErJO7Rs7
 dw5wR+43zipZznrtP/W8nCmL7E8VYn3KWFSb4jSmMyYneqBrhSZMB/BfiOMrWnnMpPChRLyR
 GLqZoyhWDPZyAbKyjlVQVS3d9BtLn5PzNaYRAl9Gad8h+o/WWHGXuQENBF4y2DoBCACmbQWs
 /CCONpIwsHxKt4fEfbW1XhQFoKPmGF2Xonas6kN3Oh8XXFekkXfnRQJX+fOuv7DbaUsmkPzd
 TB2YtfidZJ6xIYPzSgSMsA945dEOY5yYfeNCH1pQYcq1xfM7bHGSwaNervx0wnK/g7yBgp6E
 1stOwqoR9M3KgmQJPuaSISSfUH5NKcx38S6w+56I3//f1jyCRG5vkQzHsdioBWkAOfagQmcv
 6fMhDYCoxlTooxlj1/5mSkspCS7fDkVcZn48t+sPfQAywpUDrWBZhp1vrDHfl+wUvCSXPYEz
 9dkT9NmLz24H20tLV+btVgMsPXSlnM34lNjABg2x7isCoCZ9ABEBAAGJATYEGAEIACAFAl4y
 2EACGwwWIQSJFhEikPObK3+nglaeUEWy+uvFawAKCRCeUEWy+uvFayO5CACDYH46Tay5BSwn
 FK3EwAYSpXIFzhQet7os7InGRS8/2yuqzsunRDbMy11rTGmXXA1LuTizqsgebQbALpkuHEpi
 gX9b20RfsfuZYbdbtLzzVDuOVuGP3+CSJrB1Z+nGeF1+L4m5n7VDPX0MyWKwhlWY9hVmNQ2+
 lMt+fb6+330M9cXCz6H2/k7b2BTEM9xZPytt2ICT8I9rX5+8tuHDrstr13P40QOR0Exh5EHw
 LA00FYsr0e+ijzxRP9EC3AA9Gt/518IRS7FGvszu4qWWRT33P2cABoVUPpsybrhvuApgpf5y
 DLO17h0Vxwoq2qqCO/RqIw+o8Lj89xOl4VkPpXe4
Subject: btrfs scrub prevents system suspend
Message-ID: <6055ac8f-b13d-85ed-7109-3314c5c71c1f@localhost>
Date:   Tue, 4 Feb 2020 13:44:38 +0100
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="a7dRvWnDqXMr59N9K6VnyYwSufa4iIeNO"
Authentication-Results: ORIGINATING;
        auth=pass smtp.auth=t.schmittlauch@orlives.de smtp.mailfrom=t.schmittlauch@orlives.de
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--a7dRvWnDqXMr59N9K6VnyYwSufa4iIeNO
Content-Type: multipart/mixed; boundary="GIf1s07HPIygTrXfGPLPSI6bFLNkSomvX";
 protected-headers="v1"
From: Trolli Schmittlauch <t.schmittlauch+ml@orlives.de>
To: linux-btrfs@vger.kernel.org
Message-ID: <6055ac8f-b13d-85ed-7109-3314c5c71c1f@localhost>
Subject: btrfs scrub prevents system suspend

--GIf1s07HPIygTrXfGPLPSI6bFLNkSomvX
Content-Type: multipart/mixed;
 boundary="------------B0FC79D74FFA3842D9F1D651"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------B0FC79D74FFA3842D9F1D651
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi

I noticed that a running `btrfs scrub` operation prevents a system from s=
uspending to RAM. I wonder whether this is a known issue and being worked=
 on.
A kernel trace leading to btrfs scrub can be found attached.

My current system setup:
NixOS 19.09
kernel 4.19.98
btrfs-progs v5.2.1

I can also try to reproduce this issue with a more recent kernel version.=
 (am currently on a train with bad link)

In the downstream bug report [1] suggests that this could be resolved/ wo=
rked around in systemd by adding `Conflicts=3Dsuspend.target sleep.target=
? to the scrubbing service's systemd unit.
So should this be managed at btrfs (kernel) level or in systemd?

All the best
schmittlauch

[1] https://github.com/NixOS/nixpkgs/issues/79086

--------------B0FC79D74FFA3842D9F1D651
Content-Type: text/x-log; charset=UTF-8;
 name="btrfs-scrub-suspend_partial.log"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="btrfs-scrub-suspend_partial.log"

systemd[1]: Starting Suspend...
systemd-sleep[15702]: Suspending system...
kernel: PM: Syncing filesystems ... done.
kernel: Freezing user space processes ...=20
kernel: Freezing of tasks failed after 20.007 seconds (1 tasks refusing t=
o freeze, wq_busy=3D0):
kernel: btrfs           D    0 12483      1 0x00000004
kernel: Call Trace:
kernel:  ? __schedule+0x1f4/0x820
kernel:  ? scrub_missing_raid56_end_io+0x40/0x40 [btrfs]
kernel:  schedule+0x28/0x80
kernel:  scrub_add_page_to_rd_bio+0x211/0x2c0 [btrfs]
kernel:  ? wait_woken+0x80/0x80
kernel:  scrub_pages+0x239/0x430 [btrfs]
kernel:  scrub_stripe+0x72b/0xee0 [btrfs]
kernel:  ? kmem_cache_alloc+0x158/0x1c0
kernel:  ? btrfs_check_space_for_delayed_refs+0xc7/0x100 [btrfs]
kernel:  ? btrfs_block_rsv_check+0x20/0x60 [btrfs]
kernel:  ? scrub_chunk+0xd2/0x130 [btrfs]
kernel:  scrub_chunk+0xd2/0x130 [btrfs]
kernel:  scrub_enumerate_chunks+0x20f/0x570 [btrfs]
kernel:  ? wait_woken+0x60/0x80
kernel:  btrfs_scrub_dev+0x1e2/0x580 [btrfs]
kernel:  ? __kmalloc_track_caller+0x167/0x210
kernel:  btrfs_ioctl+0xfea/0x31b0 [btrfs]
kernel:  ? __switch_to_asm+0x41/0x70
kernel:  ? __switch_to_asm+0x35/0x70
kernel:  ? __switch_to_asm+0x41/0x70
kernel:  ? __switch_to_asm+0x35/0x70
kernel:  ? do_vfs_ioctl+0xa4/0x620
kernel:  do_vfs_ioctl+0xa4/0x620
kernel:  ? __switch_to_asm+0x41/0x70
kernel:  ? __switch_to_asm+0x35/0x70
kernel:  ? __switch_to_asm+0x41/0x70
kernel:  ? get_task_io_context+0x43/0x80
kernel:  ksys_ioctl+0x60/0x90
kernel:  ? __switch_to+0x115/0x440
kernel:  __x64_sys_ioctl+0x16/0x20
kernel:  do_syscall_64+0x4e/0x100
kernel:  entry_SYSCALL_64_after_hwframe+0x44/0xa9
kernel: RIP: 0033:0x7f7da656cb57
kernel: Code: Bad RIP value.
kernel: RSP: 002b:00007f7da647dd48 EFLAGS: 00000246 ORIG_RAX: 00000000000=
00010
kernel: RAX: ffffffffffffffda RBX: 0000000000b163e0 RCX: 00007f7da656cb57=

kernel: RDX: 0000000000b163e0 RSI: 00000000c400941b RDI: 0000000000000003=

kernel: RBP: 0000000000000000 R08: 00007f7da647e700 R09: 0000000000000000=

kernel: R10: 00007f7da647e700 R11: 0000000000000246 R12: 00007ffd7f26ddce=

kernel: R13: 00007ffd7f26ddcf R14: 00007f7da647e700 R15: 00007f7da67c9000=

kernel: OOM killer enabled.
kernel: Restarting tasks ... done.
kernel: PM: suspend exit
kernel: PM: suspend entry (s2idle)
rtkit-daemon[2121]: Demoted 5 threads.
kernel: PM: Syncing filesystems ... done.
kernel: Freezing user space processes ...=20
kernel: Freezing of tasks failed after 20.001 seconds (1 tasks refusing t=
o freeze, wq_busy=3D0):
kernel: btrfs           D    0 12483      1 0x00000004
kernel: Call Trace:
kernel:  ? __schedule+0x1f4/0x820
kernel:  ? scrub_missing_raid56_end_io+0x40/0x40 [btrfs]
kernel:  schedule+0x28/0x80
kernel:  scrub_add_page_to_rd_bio+0x211/0x2c0 [btrfs]
kernel:  ? wait_woken+0x80/0x80
kernel:  scrub_pages+0x239/0x430 [btrfs]
kernel:  ? btrfs_lookup_csums_range+0x93/0x450 [btrfs]
kernel:  scrub_stripe+0x72b/0xee0 [btrfs]
kernel:  ? start_transaction+0xef/0x3f0 [btrfs]
kernel:  ? kmem_cache_alloc+0x158/0x1c0
kernel:  ? btrfs_check_space_for_delayed_refs+0xc7/0x100 [btrfs]
kernel:  ? btrfs_block_rsv_check+0x20/0x60 [btrfs]
kernel:  ? scrub_chunk+0xd2/0x130 [btrfs]
kernel:  ? scrub_chunk+0xd2/0x130 [btrfs]
kernel:  ? scrub_enumerate_chunks+0x20f/0x570 [btrfs]
kernel:  ? wait_woken+0x60/0x80
kernel:  ? btrfs_scrub_dev+0x1e2/0x580 [btrfs]
kernel:  ? __kmalloc_track_caller+0x167/0x210
kernel:  ? btrfs_ioctl+0xfea/0x31b0 [btrfs]
kernel:  ? __switch_to_asm+0x41/0x70
kernel:  ? __switch_to_asm+0x35/0x70
kernel:  ? __switch_to_asm+0x41/0x70
kernel:  ? __switch_to_asm+0x35/0x70
kernel:  ? do_vfs_ioctl+0xa4/0x620
kernel:  ? do_vfs_ioctl+0xa4/0x620
kernel:  ? __switch_to_asm+0x41/0x70
kernel:  ? __switch_to_asm+0x35/0x70
kernel:  ? __switch_to_asm+0x41/0x70
kernel:  ? get_task_io_context+0x43/0x80
kernel:  ? ksys_ioctl+0x60/0x90
kernel:  ? __switch_to+0x115/0x440
kernel:  ? __x64_sys_ioctl+0x16/0x20
kernel:  ? do_syscall_64+0x4e/0x100
kernel:  ? entry_SYSCALL_64_after_hwframe+0x44/0xa9
kernel: OOM killer enabled.
kernel: Restarting tasks ... done.

--------------B0FC79D74FFA3842D9F1D651--

--GIf1s07HPIygTrXfGPLPSI6bFLNkSomvX--

--a7dRvWnDqXMr59N9K6VnyYwSufa4iIeNO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEiRYRIpDzmyt/p4JWnlBFsvrrxWsFAl45ZzYACgkQnlBFsvrr
xWs/RQf+PfVkTvTHmjaiVJ+gcQr8rY5lKCCGEsDIfpNhXHCVmoFzNG9s2pOW25RF
9RlBu19wk6QWNpLkYMkEvrZtNsc0/1oncGAMMXgGfYJywVwCZuWyoXZ8vXOHUk9X
A8SjlB82GwF9hKHz2WzrzNB2vtXxLUg9dksRKL0loutqz2XgiNk89wDkVMcuMyRV
Cthq2n38ilP7pqdhWFWtkgLPbmlSnoCmvRtieclpV1F/u1dJQNulZxQDco+NPrkh
Uep+GF/9TnXsvrj8KKzifOV06nhyqKpj44EEMsD9t9X4oXbSlLAxILcFCYwBnVEe
Zi654tjHvNZMi3dHz95dcsVGzEoQdQ==
=FssW
-----END PGP SIGNATURE-----

--a7dRvWnDqXMr59N9K6VnyYwSufa4iIeNO--
