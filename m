Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9F142F3221
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Jan 2021 14:47:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728970AbhALNqW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 12 Jan 2021 08:46:22 -0500
Received: from mout.gmx.net ([212.227.17.20]:41853 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727033AbhALNqV (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 12 Jan 2021 08:46:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1610459086;
        bh=xzW7W54/B49Go/OEtonnFy56QLfCndeqePFvmO+iXT8=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=ZXusZpk6Cldg5V4GxbJg93qL1QKfAD0PVfbIGW/z86dhGp760lli8MkwbU93dJsFD
         lj3l001D8BaJcxBu8VyrY0iXQN94sZAwTpVBoG0+M+CHELAWwhHqnlE45ynnBtDb+4
         /abeaatL13a06xpeuEXvDJHSkudWv/dtZ/F0J2x0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1McpNy-1kQX7f1zu6-00ZuET; Tue, 12
 Jan 2021 14:44:46 +0100
Subject: Re: [bug] Balance fails due to ENOSPC
To:     Anand Jain <anand.jain@oracle.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <1540e370-a019-5d3b-312d-dc5e70169597@oracle.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <28a3f2db-dabf-9b59-4bb5-0608717656dc@gmx.com>
Date:   Tue, 12 Jan 2021 21:44:41 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <1540e370-a019-5d3b-312d-dc5e70169597@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:lwH5tEhuBaM21nluGdh5W0ZGlCFTuS2kwPTQQazSS8STtblz4Wd
 URcDRgTIZ6+Rxud2PtH8+eBg6vbowAWK4RPPaQi55N1+zat0jPwvF/9Qs/4CyiGo9S9if7E
 1Q7tIOKWOgd8MPiPH5xTCpUzjXiSoi8qzwWLgTcu9ASDzB2nkgYTMC36xNt1MCgh/RQl6UY
 7WX3EHPOwnuLwwUdU+HJA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:bFB+sB20/Ik=:A/bUYptSNROc61BknTN3Jq
 ghdhXfKSNxLcWx8ld4bFuXa9Yh/yz8EvDq+2EW9B9emaid8c8bnG1h2GdyXPqgrgNIPc/zGyY
 lF/HWysUgjRbcjILYNh1Qh0uUaAw/TTN93B2RWknB4FWzT8juY68hKz5h9gtVqREPOBdxYf+r
 FDg0pZQP4ODrXDuXCUjYD1/TVzcmi2vEj9tSCasXFdDjZ2Wh1M1C7w0iyBralDDAgeyl11UZH
 HhnvAlJ9eM+Qx2hyeixKIEGdr7HBBXWO6d+/FtwMgyFZcRyhrxyocz42c6C95yJ4m1BK1UZmC
 cDeyDu2P7MPzfU4qB8Sdxdl9yqiwJfxnT7Mh9xaqpcAFRlossFXXv5XdbohMcfdZRjIR3cbcS
 fS9VymiE44bPBDmtO1BvfrTGPiCr4elfwOrbWqPozyz4/U6bXT2cLQQyRJJ9d9bxmX6stGy4w
 tba8l+D7ZyLz7qck0MhU57tQ+7qBnJVjNLTwVKdgOWXzsrah4MMk48o0/F0VcX2+hgrhj9dtS
 xnyZMAbzBrbmLGXf/v8dqH1RM/158DS9UVyiXX1dVTb2rNC2uPCM0LPckjD/aQT4giLqFKwot
 WL7wQLHrrTc0DZoPz3M46OuyIY20OEFOZmAQvnrUsSvtY/8wmN8K1zssTS4MfeJ1cVxiArvMJ
 fnFryhyniVYCcoRT0cQjtC4Ww8xHzQAwS2nWx2lUprxzAplnGCJnSLvFj2sqoEhEhgRIEqav0
 RI6fA3Nrfo82yz3kA8pEZqYlK60GFNldSMhDlkKwdOzmqV64sX8iS7otNJEG0FwjrvF81XsN8
 q7qtiTc4vHYWc7D8lLiBOkwmyePfqSxdD166zZpnvUTVUacmb50J5ufL4zFtSJQEOmF4L08WY
 XGoyVlzWiRD9CUPfieqA==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/1/12 =E4=B8=8B=E5=8D=886:35, Anand Jain wrote:
>
>
> Balance fails due to ENOSPC on 5.11.0-rc2+.
>
>
> [ 2460.219094] BTRFS info (device sdb6): balance: start -f
> -dconvert=3Dsingle -mconvert=3Dsingle -sconvert=3Dsingle
> [ 2460.219224] BTRFS info (device sdb6): relocating block group
> 194572713984 flags data
> [ 2460.241299] ------------[ cut here ]------------
> [ 2460.241302] BTRFS: Transaction aborted (error -28)
> [ 2460.241328] WARNING: CPU: 3 PID: 4135 at fs/btrfs/volumes.c:3003
> btrfs_remove_chunk+0x60e/0x6c0 [btrfs]
> ::
> [ 2460.241447] RIP: 0010:btrfs_remove_chunk+0x60e/0x6c0 [btrfs]
> ::
> [ 2460.241497] Call Trace:
> [ 2460.241500]=C2=A0 btrfs_relocate_chunk+0x9d/0xd0 [btrfs]
> [ 2460.241533]=C2=A0 __btrfs_balance+0x413/0xa30 [btrfs]
> [ 2460.241566]=C2=A0 btrfs_balance+0x436/0x4d0 [btrfs]
> [ 2460.241597]=C2=A0 btrfs_ioctl_balance+0x2d5/0x380 [btrfs]
> [ 2460.241647]=C2=A0 btrfs_ioctl+0x565/0x22b0 [btrfs]
> [ 2460.241693]=C2=A0 ? selinux_file_ioctl+0x174/0x220
> [ 2460.241698]=C2=A0 ? handle_mm_fault+0xd7/0x2b0
> [ 2460.241702]=C2=A0 __x64_sys_ioctl+0x91/0xc0
> [ 2460.241705]=C2=A0 ? __x64_sys_ioctl+0x91/0xc0
> [ 2460.241707]=C2=A0 do_syscall_64+0x38/0x50
> [ 2460.241711]=C2=A0 entry_SYSCALL_64_after_hwframe+0x44/0xa9
> ::
> [ 2460.241735] ---[ end trace 95b8b7b84503a477 ]---
> [ 2460.241738] BTRFS: error (device sdb6) in btrfs_remove_chunk:3003:
> errno=3D-28 No space left
> [ 2460.241743] BTRFS info (device sdb6): forced readonly
> [ 2460.242646] BTRFS info (device sdb6): 1 enospc errors during balance
> [ 2460.242649] BTRFS info (device sdb6): balance: ended with status: -30
>
>
> btrfs fi us /Volumes/
> Overall:
>  =C2=A0=C2=A0=C2=A0 Device size:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 154.97GiB
>  =C2=A0=C2=A0=C2=A0 Device allocated:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 154.97GiB
>  =C2=A0=C2=A0=C2=A0 Device unallocated:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 2.00MiB
>  =C2=A0=C2=A0=C2=A0 Device missing:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0.00B
>  =C2=A0=C2=A0=C2=A0 Used:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 147.91GiB
>  =C2=A0=C2=A0=C2=A0 Free (estimated):=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 2.75GiB=C2=A0=C2=A0=C2=A0 (min: 2.75GiB)
>  =C2=A0=C2=A0=C2=A0 Data ratio:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1.99
>  =C2=A0=C2=A0=C2=A0 Metadata ratio:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1.52
>  =C2=A0=C2=A0=C2=A0 Global reserve:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 183.72MiB=C2=A0=C2=A0=C2=A0 (used: 0.00B)
>
> Data,single: Size:894.00MiB, Used:0.00B (0.00%)
>  =C2=A0=C2=A0 /dev/sdb6=C2=A0=C2=A0=C2=A0=C2=A0 894.00MiB
>
> Data,RAID1: Size:75.53GiB, Used:73.23GiB (96.96%)
>  =C2=A0=C2=A0 /dev/sdb6=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 75.53GiB
>  =C2=A0=C2=A0 /dev/sdc2=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 75.53GiB
>
> Metadata,single: Size:964.00MiB, Used:0.00B (0.00%)
>  =C2=A0=C2=A0 /dev/sdb6=C2=A0=C2=A0=C2=A0=C2=A0 964.00MiB
>
> Metadata,RAID1: Size:1.00GiB, Used:737.25MiB (72.00%)
>  =C2=A0=C2=A0 /dev/sdb6=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1.00GiB
>  =C2=A0=C2=A0 /dev/sdc2=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1.00GiB

Metadata is only 1G, with 737M used, and 183 reserved as GlobalRSV.

Although the GlobalRSV is a little smaller than older kernel, but it
should be more or less enough.

In theory, we should be able to modify the fs stealing from GlobalRSV,
and since btrfs_remove_chunk:3003 is updating device time, either it
means we didn't really reserve enough metadata when we start the trans,
or we didn't do the steal when we really need.

Would you like to provide the dmesg if you can reproduce with "-o
enospc_debug" mount option?

Thanks,
Qu
>
> System,single: Size:32.00MiB, Used:0.00B (0.00%)
>  =C2=A0=C2=A0 /dev/sdb6=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 32.00MiB
>
> System,RAID1: Size:32.00MiB, Used:16.00KiB (0.05%)
>  =C2=A0=C2=A0 /dev/sdb6=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 32.00MiB
>  =C2=A0=C2=A0 /dev/sdc2=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 32.00MiB
>
> Unallocated:
>  =C2=A0=C2=A0 /dev/sdb6=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1.00MiB
>  =C2=A0=C2=A0 /dev/sdc2=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1.00MiB
