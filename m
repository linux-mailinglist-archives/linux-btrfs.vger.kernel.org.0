Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55E1044DB2B
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Nov 2021 18:33:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234321AbhKKRgq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 11 Nov 2021 12:36:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232659AbhKKRgp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 11 Nov 2021 12:36:45 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4717CC061766
        for <linux-btrfs@vger.kernel.org>; Thu, 11 Nov 2021 09:33:56 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id i12so4879454wmq.4
        for <linux-btrfs@vger.kernel.org>; Thu, 11 Nov 2021 09:33:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=shySzPtxfTUqvZWrlhG9bdQ6u/RI+mInvF5YmUr9z6Y=;
        b=JXrygciTjHMPqk1oZyylpes7vYIIpt2+pZUxvi+uzewWduKje/j9ryc41zRczwviYJ
         EBSkFDNbHtoBTqQFlM+c0V5gLPzd1fLCEeE9MqOQX8JTHdZkEe3Yapk4RkHE4SRZDRJ+
         wrCtHIJlZkQA9plHnpntjBseprLfoGdsX7zyqfmA9p6LsKqVxf7BI550LyCYlax0twx4
         +q+QtfogA17du374fD8AFS364ukrPKtjS/ez/95bM1jYSU0KXu/dlhpEhGI5tJsSy+g0
         tQhrApnHvDJug9CTo7sh8FQ2XoCqJBzS/8det16XyDwgsCAUkuUAS21PPHPA17qdbuCr
         BS/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=shySzPtxfTUqvZWrlhG9bdQ6u/RI+mInvF5YmUr9z6Y=;
        b=bPPp7bUFwlB4DhqSvuPC1Qm1Q4+Npw/YMb02h4PC5C3nxNvCBQvwUaSC5QgBY8hi9Q
         jyAh7TVt7qKlL2IiuS/MvsmLm/3kE07y9hAyIsNbRuCcLEILlQXyvAmGly6TvBIp2l0f
         SpBR4W8gw6YAGpt1ZDMld8pQITi91Wqmf5av+ed0LPts+bsldtT/tPnCB3wN0btCX9es
         2Z72C4bURaziEp1cX4E7z5RO1dYq6mfHPfJtaJV9W2S1dcB36G+5bopTOWPZkX28MHvY
         2otC+Oc/nxPtIYmkx90qOztPH3v2dMNvzUA/jiGvWWmKLp3UJWPK/aJc6dmJrLMp0u6W
         VJmw==
X-Gm-Message-State: AOAM531sPZGmNT0cWzq5rL2WP8cGnFkNWzQyj/2h1YQXRAopwO0X2ITJ
        NIKruTYYCweNLnZrE0mt3AYnrjlpw/2OS0FYyUcr3thJ4Ic=
X-Google-Smtp-Source: ABdhPJwQdK6s09AOzw4lKzx+750h5qN7I5A1nu5aLs8vnN/qAYOQC0KravB+YONObfpvLUlEn3v4BMBQzAgfRpzRkJs=
X-Received: by 2002:a05:600c:354b:: with SMTP id i11mr28003760wmq.61.1636652034489;
 Thu, 11 Nov 2021 09:33:54 -0800 (PST)
MIME-Version: 1.0
References: <CAJtFHUSN+RfZa2BitX9gH++M54uA7MTmn4Fn6Afx2RL4NPeaVQ@mail.gmail.com>
In-Reply-To: <CAJtFHUSN+RfZa2BitX9gH++M54uA7MTmn4Fn6Afx2RL4NPeaVQ@mail.gmail.com>
From:   Eli V <eliventer@gmail.com>
Date:   Thu, 11 Nov 2021 12:33:43 -0500
Message-ID: <CAJtFHURRaL-v60s_gk5+unRQtsU9wvZOTtLm5=c0ALqBF23kbQ@mail.gmail.com>
Subject: Re: 5.10 kernel/fs exhausting reserve running btrfs_delete_unused_bgs,
 going read-only
To:     linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Nov 11, 2021 at 10:17 AM Eli V <eliventer@gmail.com> wrote:
>
> Ideas requested on how to fix a large btrfs filesystem that goes
> read-only shortly after a fresh
> mount, with this in dmesg:
>
> BTRFS info (device sdb): left=1507328, need=1572864, flags=1
> BTRFS info (device sdb): space_info 2 has 1507328 free, is not full
> BTRFS info (device sdb): space_info total=75497472, used=72482816,
> pinned=0, reserved=1507328, may_use=0, readonly=0
> BTRFS info (device sdb): global_block_rsv: size 536870912 reserved 533856256
> BTRFS info (device sdb): trans_block_rsv: size 4194304 reserved 4194304
> BTRFS info (device sdb): chunk_block_rsv: size 0 reserved 0
> BTRFS info (device sdb): delayed_block_rsv: size 0 reserved 0
> BTRFS info (device sdb): delayed_refs_rsv: size 298844160 reserved 110231552
> BTRFS info (device sdb): left=1441792, need=1572864, flags=1
> BTRFS info (device sdb): space_info 2 has 1441792 free, is not full
> BTRFS info (device sdb): space_info total=75497472, used=72482816,
> pinned=0, reserved=1572864, may_use=0, readonly=0
> ...
> BTRFS info (device sdb): global_block_rsv: size 536870912 reserved 533266432
> BTRFS info (device sdb): trans_block_rsv: size 4194304 reserved 4194304
> BTRFS info (device sdb): chunk_block_rsv: size 0 reserved 0
> BTRFS info (device sdb): delayed_block_rsv: size 0 reserved 0
> BTRFS info (device sdb): delayed_refs_rsv: size 342884352 reserved 155910144
> BTRFS info (device sdb): left=1376256, need=1572864, flags=1
> BTRFS info (device sdb): space_info 2 has 1376256 free, is not full
> BTRFS info (device sdb): space_info total=75497472, used=72482816,
> pinned=0, reserved=1638400, may_use=0, readonly=0
> BTRFS info (device sdb): global_block_rsv: size 536870912 reserved 533266432
> BTRFS error (device sdb): allocation failed flags 18, wanted 65536
> BTRFS: Transaction aborted (error -28)
> WARNING: CPU: 1 PID: 1060882 at fs/btrfs/volumes.c:2989
> btrfs_remove_chunk+0x553/0x6b0 [btrfs]
> CPU: 1 PID: 1060882 Comm: btrfs-cleaner Tainted: G        W I
> 5.10.0-9-amd64 #1 Debian 5.10.70-1
> RIP: 0010:btrfs_remove_chunk+0x553/0x6b0 [btrfs]
> Code: 40 0a 00 00 02 72 28 83 f8 fb 0f 84 91 00 00 00 83 f8 e2 0f 84
> 88 00 00 00 89 c6 48 c7 c7 40 22 71 c0 89 04 24 e8 80 33 1f e0 <0f> 0b
> 8b 04 24 89 c1 ba ad 0b 00 00 4c 89 ef 89 04 24 48 c7 c6 d0
> RSP: 0018:ffffb82003983d90 EFLAGS: 00010286
> RAX: 0000000000000000 RBX: ffff95a324c2ef00 RCX: ffff959f5fc18a08
> RDX: 00000000ffffffd8 RSI: 0000000000000027 RDI: ffff959f5fc18a00
> RBP: ffff959d85f4a000 R08: 0000000000000000 R09: ffffb82003983bb0
> R10: ffffb82003983ba8 R11: ffffffffa16ba8f8 R12: ffff959d1acc4150
> R13: ffff95a1c807f138 R14: ffff959d85f4a380 R15: ffff95a095e90000
> FS:  0000000000000000(0000) GS:ffff959f5fc00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000557323588e70 CR3: 00000002dfa0a005 CR4: 00000000000206e0
> Call Trace:
>  btrfs_delete_unused_bgs+0x651/0x7a0 [btrfs]
>  cleaner_kthread+0xef/0x120 [btrfs]
>  ? btree_invalidatepage+0x40/0x40 [btrfs]
>  kthread+0x11b/0x140
>  ? __kthread_bind_mask+0x60/0x60
>  ret_from_fork+0x22/0x30
> ---[ end trace 6ad4eacda93c19a4 ]---
> BTRFS: error (device sdb) in btrfs_remove_chunk:2989: errno=-28 No space left
>
> After it goes read-only usage seems ok:
> $ btrfs filesystem usage -T /mirror
> Overall:
>     Device size:                 382.02TiB
>     Device allocated:            381.01TiB
>     Device unallocated:            1.01TiB
>     Device missing:                  0.00B
>     Used:                        337.69TiB
>     Free (estimated):             43.86TiB      (min: 43.86TiB)
>     Free (statfs, df):            42.97TiB
>     Data ratio:                       1.00
>     Metadata ratio:                   1.00
>     Global reserve:              512.00MiB      (used: 0.00B)
>     Multiple profiles:                  no
>
>             Data      Metadata  System
> Id Path     single    RAID1     RAID1    Unallocated
> -- -------- --------- --------- -------- -----------
>  1 /dev/sdb  27.22TiB  29.50GiB        -    33.51GiB
>  2 /dev/sdc  27.20TiB  39.00GiB        -    43.00GiB
>  3 /dev/sdd  36.28TiB  51.00GiB        -    57.00GiB
>  4 /dev/sde  36.24TiB  63.00GiB        -    78.00GiB
>  5 /dev/sdf  54.36TiB  98.02GiB 32.00MiB   121.05GiB
>  6 /dev/sdg  54.26TiB 148.50GiB  4.00MiB   172.50GiB
>  7 /dev/sdh  72.26TiB 247.52GiB 36.00MiB   269.55GiB
>  8 /dev/sdi  72.29TiB 234.50GiB        -   256.51GiB
> -- -------- --------- --------- -------- -----------
>    Total    380.12TiB 911.04GiB 72.00MiB     1.01TiB
>    Used     337.27TiB 432.68GiB 69.12MiB

Compiling 5.10.78 using 1GB for global reserve also went read-only
immediately, but using 2GB allowed things to get through and the fs
stayed rw after mount. It would be really nice if that could be a
kernel boot or sysfs param instead of a recompile. I'll run with 2GB
for now and see how things go:

btrfs filesystem usage -T /mirror
Overall:
    Device size:                 382.02TiB
    Device allocated:            381.13TiB
    Device unallocated:          913.12GiB
    Device missing:                  0.00B
    Used:                        337.69TiB
    Free (estimated):             43.86TiB      (min: 43.86TiB)
    Free (statfs, df):            42.97TiB
    Data ratio:                       1.00
    Metadata ratio:                   1.00
    Global reserve:                2.00GiB      (used: 0.00B)
    Multiple profiles:                  no

            Data      Metadata  System
Id Path     single    RAID1     RAID1    Unallocated
-- -------- --------- --------- -------- -----------
 1 /dev/sdb  27.23TiB  29.50GiB        -    29.51GiB
 2 /dev/sdc  27.21TiB  39.00GiB        -    39.00GiB
 3 /dev/sdd  36.28TiB  51.00GiB        -    51.00GiB
 4 /dev/sde  36.26TiB  63.00GiB        -    63.00GiB
 5 /dev/sdf  54.38TiB  98.02GiB 32.00MiB    98.05GiB
 6 /dev/sdg  54.28TiB 148.50GiB  4.00MiB   148.50GiB
 7 /dev/sdh  72.28TiB 247.52GiB 36.00MiB   249.55GiB
 8 /dev/sdi  72.31TiB 234.50GiB        -   234.51GiB
-- -------- --------- --------- -------- -----------
   Total    380.24TiB 911.04GiB 72.00MiB   913.12GiB
   Used     337.27TiB 432.68GiB 69.12MiB
