Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7163F431805
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Oct 2021 13:49:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231648AbhJRLvL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 18 Oct 2021 07:51:11 -0400
Received: from 7.mo575.mail-out.ovh.net ([46.105.63.230]:35259 "EHLO
        7.mo575.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbhJRLvH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 18 Oct 2021 07:51:07 -0400
X-Greylist: delayed 2126 seconds by postgrey-1.27 at vger.kernel.org; Mon, 18 Oct 2021 07:51:06 EDT
Received: from player698.ha.ovh.net (unknown [10.110.115.246])
        by mo575.mail-out.ovh.net (Postfix) with ESMTP id 3138022C21
        for <linux-btrfs@vger.kernel.org>; Mon, 18 Oct 2021 11:13:28 +0000 (UTC)
Received: from RCM-web4.webmail.mail.ovh.net (89-64-40-92.dynamic.chello.pl [89.64.40.92])
        (Authenticated sender: mailing@dmilz.net)
        by player698.ha.ovh.net (Postfix) with ESMTPSA id 070D7234BCBBF
        for <linux-btrfs@vger.kernel.org>; Mon, 18 Oct 2021 11:13:28 +0000 (UTC)
MIME-Version: 1.0
Date:   Mon, 18 Oct 2021 13:13:27 +0200
From:   mailing@dmilz.net
To:     linux-btrfs@vger.kernel.org
Subject: Re: Filesystem Read Only due to errno=-28 during metadata allocation
In-Reply-To: <f2ed8b05b03db6a4fec4cba7ed17222a@dmilz.net>
References: <f2ed8b05b03db6a4fec4cba7ed17222a@dmilz.net>
User-Agent: Roundcube Webmail/1.4.11
Message-ID: <cf9398e622007944806e237c105b1e2f@dmilz.net>
X-Sender: mailing@dmilz.net
X-Originating-IP: 89.64.40.92
X-Webmail-UserID: mailing@dmilz.net
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 6257751685147261557
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvtddrvddvtddgfeehucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucenucfjughrpeggfffhvffujghffgfkgihitgfgsehtjehjtddtredvnecuhfhrohhmpehmrghilhhinhhgsegumhhilhiirdhnvghtnecuggftrfgrthhtvghrnhepueekveetkeelgefgjeekheekteeugefgvedtgfehudfggeelkeeuuddugfeugfelnecukfhppedtrddtrddtrddtpdekledrieegrdegtddrledvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhlrgihvghrieelkedrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehmrghilhhinhhgsegumhhilhiirdhnvghtpdhrtghpthhtoheplhhinhhugidqsghtrhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrgh
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 13.10.2021 14:35, mailing@dmilz.net wrote:
> Hello,
> 
> I faced issue with btrfs FS /var forced to RO due to errno=-28 (no 
> space left).
> 
> The server was restarted to bring back FS in RW.
> 
> Before reboot:
> $ btrfs fi usage /var -m
> Overall:
>     Device size:         2560.00MiB
>     Device allocated:         2559.00MiB
>     Device unallocated:            1.00MiB
>     Device missing:            0.00MiB
>     Used:         1116.00MiB
>     Free (estimated):          451.25MiB (min: 451.25MiB)
>     Data ratio:               1.00
>     Metadata ratio:               2.00
>     Global reserve:           13.00MiB (used: 0.00MiB)
> 
> Data,single: Size:1559.25MiB, Used:1108.00MiB
>    /dev/mapper/rootvg-varvol 1559.25MiB
> 
> Metadata,DUP: Size:467.88MiB, Used:3.94MiB
>    /dev/mapper/rootvg-varvol  935.75MiB
> 
> System,DUP: Size:32.00MiB, Used:0.06MiB
>    /dev/mapper/rootvg-varvol   64.00MiB
> 
> Unallocated:
>    /dev/mapper/rootvg-varvol    1.00MiB
> 
> The FS went RO on Sunday, with this trace:
> 2021-10-10T00:13:12.790042+02:00 SERVERNAME kernel: BTRFS: Transaction
> aborted (error -28)
> 2021-10-10T00:13:12.790053+02:00 SERVERNAME kernel: ------------[ cut
> here ]------------
> 2021-10-10T00:13:12.790055+02:00 SERVERNAME kernel: WARNING: CPU: 8
> PID: 8532 at ../fs/btrfs/extent-tree.c:2353
> btrfs_run_delayed_refs+0x2b4/0x2c0 [btrfs]
> 2021-10-10T00:13:12.790057+02:00 SERVERNAME kernel: Modules linked in:
> lin_tape(OEX) pfo(OEX) nfsv3 nfs_acl nfs lockd grace sunrpc fscache
> rpadlpar_io(X) rpaphp(X) tcp_diag udp_diag raw_diag inet_diag
> unix_diag af_packet_diag netlink_diag binfmt_misc af_packet xfs
> libcrc32c st ch ibmveth(X) vmx_crypto gf128mul crct10dif_vpmsum
> uio_pdrv_genirq uio rtc_generic btrfs xor zstd_decompress
> zstd_compress xxhash raid6_pq dm_service_time sd_mod ibmvfc(X)
> scsi_transport_fc crc32c_vpmsum dm_mirror dm_region_hash dm_log sg
> dm_multipath dm_mod scsi_dh_rdac scsi_dh_emc scsi_dh_alua scsi_mod
> autofs4
> 2021-10-10T00:13:12.790059+02:00 SERVERNAME kernel: Supported: Yes, 
> External
> 2021-10-10T00:13:12.790053+02:00 SERVERNAME kernel: ------------[ cut
> here ]------------
> 2021-10-10T00:13:12.790055+02:00 SERVERNAME kernel: WARNING: CPU: 8
> PID: 8532 at ../fs/btrfs/extent-tree.c:2353
> btrfs_run_delayed_refs+0x2b4/0x2c0 [btrfs]
> 2021-10-10T00:13:12.790057+02:00 SERVERNAME kernel: Modules linked in:
> lin_tape(OEX) pfo(OEX) nfsv3 nfs_acl nfs lockd grace sunrpc fscache
> rpadlpar_io(X) rpaphp(X) tcp_diag udp_diag raw_diag inet_diag
> unix_diag af_packet_diag netlink_diag binfmt_misc af_packet xfs
> libcrc32c st ch ibmveth(X) vmx_crypto gf128mul crct10dif_vpmsum
> uio_pdrv_genirq uio rtc_generic btrfs xor zstd_decompress
> zstd_compress xxhash raid6_pq dm_service_time sd_mod ibmvfc(X)
> scsi_transport_fc crc32c_vpmsum dm_mirror dm_region_hash dm_log sg
> dm_multipath dm_mod scsi_dh_rdac scsi_dh_emc scsi_dh_alua scsi_mod
> autofs4
> 2021-10-10T00:13:12.790059+02:00 SERVERNAME kernel: Supported: Yes, 
> External
> 2021-10-10T00:13:12.790060+02:00 SERVERNAME kernel: CPU: 8 PID: 8532
> Comm: vpdupdate Tainted: G W OE 4.12.14-122.83-default #1 SLE12-SP5
> 2021-10-10T00:13:12.790076+02:00 SERVERNAME kernel: task:
> c0000068d70c1600 task.stack: c000002aba1a0000
> 2021-10-10T00:13:12.790078+02:00 SERVERNAME kernel: NIP:
> d000000035876474 LR: d000000035876470 CTR: 0000000000000000
> 2021-10-10T00:13:12.790080+02:00 SERVERNAME kernel: REGS:
> c000002aba1a3870 TRAP: 0700 Tainted: G W OE (4.12.14-122.83-default)
> 2021-10-10T00:13:12.790081+02:00 SERVERNAME kernel: MSR:
> 800000010282b033 <SF,VEC,VSX,EE,FP,ME,IR,DR,RI,LE,TM[E]>
> 2021-10-10T00:13:12.790083+02:00 SERVERNAME kernel: CR: 24444422 XER: 
> 20040000
> 2021-10-10T00:13:12.790085+02:00 SERVERNAME kernel: CFAR:
> c0000000009c817c SOFTE: 1
> 2021-10-10T00:13:12.790086+02:00 SERVERNAME kernel: GPR00:
> d000000035876470 c000002aba1a3af0 d000000035993288 0000000000000026
> 2021-10-10T00:13:12.790088+02:00 SERVERNAME kernel: GPR04:
> c00000e6bf30ade8 c00000e6bf322a00 0000000000000007 c0000000013ed474
> 2021-10-10T00:13:12.790090+02:00 SERVERNAME kernel: GPR08:
> 0000000000000000 c000000000dc16fc 000000e6be550000 000000000000134f
> 2021-10-10T00:13:12.790091+02:00 SERVERNAME kernel: GPR12:
> 0000000000004000 c00000000f6c9400 00000000007fffff 0000000000000014
> 2021-10-10T00:13:12.790093+02:00 SERVERNAME kernel: GPR16:
> 00000100231aa080 0000010022868988 aaaaaaaaaaaaaaab c000000024ebf778
> 2021-10-10T00:13:12.790095+02:00 SERVERNAME kernel: GPR20:
> 0000000000000000 0000000000000000 0000000000000000 c00000e5a1f6eb30
> 2021-10-10T00:13:12.790097+02:00 SERVERNAME kernel: GPR24:
> c00000e5a1f6eb20 00000000000016ba c00000e5a1f6e9c0 c00000e6828cc000
> 2021-10-10T00:13:12.790098+02:00 SERVERNAME kernel: GPR28:
> c0000014b1bc02d0 0000000000000000 c00000e6828cc000 ffffffffffffffe4
> 2021-10-10T00:13:12.790100+02:00 SERVERNAME kernel: NIP
> [d000000035876474] btrfs_run_delayed_refs+0x2b4/0x2c0 [btrfs]
> 2021-10-10T00:13:12.790101+02:00 SERVERNAME kernel: LR
> [d000000035876470] btrfs_run_delayed_refs+0x2b0/0x2c0 [btrfs]
> 2021-10-10T00:13:12.790103+02:00 SERVERNAME kernel: Call Trace:
> 2021-10-10T00:13:12.790104+02:00 SERVERNAME kernel: [c000002aba1a3af0]
> [d000000035876470] btrfs_run_delayed_refs+0x2b0/0x2c0 [btrfs]
> (unreliable)
> 2021-10-10T00:13:12.790106+02:00 SERVERNAME kernel: [c000002aba1a3bb0]
> [d000000035891554] btrfs_commit_transaction+0x74/0xc10 [btrfs]
> 2021-10-10T00:13:12.790108+02:00 SERVERNAME kernel: [c000002aba1a3c80]
> [d0000000358b3328] btrfs_sync_file+0x3a8/0x510 [btrfs]
> 2021-10-10T00:13:12.790110+02:00 SERVERNAME kernel: [c000002aba1a3d80]
> [c000000000408720] vfs_fsync_range+0x70/0x120
> 2021-10-10T00:13:12.790111+02:00 SERVERNAME kernel: [c000002aba1a3dd0]
> [c00000000040886c] do_fsync+0x5c/0xb0
> 2021-10-10T00:13:12.790113+02:00 SERVERNAME kernel: [c000002aba1a3e10]
> [c000000000408cfc] SyS_fdatasync+0x2c/0x40
> 2021-10-10T00:13:12.790115+02:00 SERVERNAME kernel: [c000002aba1a3e30]
> [c00000000000b308] system_call+0x3c/0x130
> 2021-10-10T00:13:12.790116+02:00 SERVERNAME kernel: Instruction dump:
> 2021-10-10T00:13:12.790118+02:00 SERVERNAME kernel: e87c0060 3c820000
> e8848b48 38a0fffb 4bfe6905 60000000 4bffffb4 3c620000
> 2021-10-10T00:13:12.790120+02:00 SERVERNAME kernel: e8638b38 7fe4fb78
> 480e3f55 e8410018 <0fe00000> 4bffff98 60000000 3c4c0012
> 2021-10-10T00:13:12.790122+02:00 SERVERNAME kernel: ---[ end trace
> c9aa23777165dfdc ]---
> 2021-10-10T00:13:12.790124+02:00 SERVERNAME kernel: BTRFS: error
> (device dm-22) in btrfs_run_delayed_refs:2353: errno=-28 No space left
> 2021-10-10T00:13:12.790125+02:00 SERVERNAME kernel: btrfs_printk: 12
> callbacks suppressed
> 2021-10-10T00:13:12.790127+02:00 SERVERNAME kernel: BTRFS info (device
> dm-22): forced readonly
> 2021-10-10T00:13:12.790060+02:00 SERVERNAME kernel: CPU: 8 PID: 8532
> Comm: vpdupdate Tainted: G W OE 4.12.14-122.83-default #1 SLE12-SP5
> 2021-10-10T00:13:12.790076+02:00 SERVERNAME kernel: task:
> c0000068d70c1600 task.stack: c000002aba1a0000
> 2021-10-10T00:13:12.790078+02:00 SERVERNAME kernel: NIP:
> d000000035876474 LR: d000000035876470 CTR: 0000000000000000
> 2021-10-10T00:13:12.790080+02:00 SERVERNAME kernel: REGS:
> c000002aba1a3870 TRAP: 0700 Tainted: G W OE (4.12.14-122.83-default)
> 2021-10-10T00:13:12.790081+02:00 SERVERNAME kernel: MSR:
> 800000010282b033 <SF,VEC,VSX,EE,FP,ME,IR,DR,RI,LE,TM[E]>
> 2021-10-10T00:13:12.790083+02:00 SERVERNAME kernel: CR: 24444422 XER: 
> 20040000
> 2021-10-10T00:13:12.790085+02:00 SERVERNAME kernel: CFAR:
> c0000000009c817c SOFTE: 1
> 2021-10-10T00:13:12.790086+02:00 SERVERNAME kernel: GPR00:
> d000000035876470 c000002aba1a3af0 d000000035993288 0000000000000026
> 2021-10-10T00:13:12.790088+02:00 SERVERNAME kernel: GPR04:
> c00000e6bf30ade8 c00000e6bf322a00 0000000000000007 c0000000013ed474
> 2021-10-10T00:13:12.790090+02:00 SERVERNAME kernel: GPR08:
> 0000000000000000 c000000000dc16fc 000000e6be550000 000000000000134f
> 2021-10-10T00:13:12.790091+02:00 SERVERNAME kernel: GPR12:
> 0000000000004000 c00000000f6c9400 00000000007fffff 0000000000000014
> 2021-10-10T00:13:12.790093+02:00 SERVERNAME kernel: GPR16:
> 00000100231aa080 0000010022868988 aaaaaaaaaaaaaaab c000000024ebf778
> 2021-10-10T00:13:12.790095+02:00 SERVERNAME kernel: GPR20:
> 0000000000000000 0000000000000000 0000000000000000 c00000e5a1f6eb30
> 2021-10-10T00:13:12.790097+02:00 SERVERNAME kernel: GPR24:
> c00000e5a1f6eb20 00000000000016ba c00000e5a1f6e9c0 c00000e6828cc000
> 2021-10-10T00:13:12.790098+02:00 SERVERNAME kernel: GPR28:
> c0000014b1bc02d0 0000000000000000 c00000e6828cc000 ffffffffffffffe4
> 2021-10-10T00:13:12.790100+02:00 SERVERNAME kernel: NIP
> [d000000035876474] btrfs_run_delayed_refs+0x2b4/0x2c0 [btrfs]
> 2021-10-10T00:13:12.790101+02:00 SERVERNAME kernel: LR
> [d000000035876470] btrfs_run_delayed_refs+0x2b0/0x2c0 [btrfs]
> 2021-10-10T00:13:12.790103+02:00 SERVERNAME kernel: Call Trace:
> 2021-10-10T00:13:12.790104+02:00 SERVERNAME kernel: [c000002aba1a3af0]
> [d000000035876470] btrfs_run_delayed_refs+0x2b0/0x2c0 [btrfs]
> (unreliable)
> 2021-10-10T00:13:12.790106+02:00 SERVERNAME kernel: [c000002aba1a3bb0]
> [d000000035891554] btrfs_commit_transaction+0x74/0xc10 [btrfs]
> 2021-10-10T00:13:12.790108+02:00 SERVERNAME kernel: [c000002aba1a3c80]
> [d0000000358b3328] btrfs_sync_file+0x3a8/0x510 [btrfs]
> 2021-10-10T00:13:12.790110+02:00 SERVERNAME kernel: [c000002aba1a3d80]
> [c000000000408720] vfs_fsync_range+0x70/0x120
> 2021-10-10T00:13:12.790111+02:00 SERVERNAME kernel: [c000002aba1a3dd0]
> [c00000000040886c] do_fsync+0x5c/0xb0
> 2021-10-10T00:13:12.790113+02:00 SERVERNAME kernel: [c000002aba1a3e10]
> [c000000000408cfc] SyS_fdatasync+0x2c/0x40
> 2021-10-10T00:13:12.790115+02:00 SERVERNAME kernel: [c000002aba1a3e30]
> [c00000000000b308] system_call+0x3c/0x130
> 2021-10-10T00:13:12.790116+02:00 SERVERNAME kernel: Instruction dump:
> 2021-10-10T00:13:12.790118+02:00 SERVERNAME kernel: e87c0060 3c820000
> e8848b48 38a0fffb 4bfe6905 60000000 4bffffb4 3c620000
> 2021-10-10T00:13:12.790120+02:00 SERVERNAME kernel: e8638b38 7fe4fb78
> 480e3f55 e8410018 <0fe00000> 4bffff98 60000000 3c4c0012
> 2021-10-10T00:13:12.790122+02:00 SERVERNAME kernel: ---[ end trace
> c9aa23777165dfdc ]---
> 2021-10-10T00:13:12.790124+02:00 SERVERNAME kernel: BTRFS: error
> (device dm-22) in btrfs_run_delayed_refs:2353: errno=-28 No space left
> 2021-10-10T00:13:12.790125+02:00 SERVERNAME kernel: btrfs_printk: 12
> callbacks suppressed
> 2021-10-10T00:13:12.790127+02:00 SERVERNAME kernel: BTRFS info (device
> dm-22): forced readonly
> 
> $ btrfs --version
> btrfs-progs v4.5.3+20160729
> 
> $ btrfs fi show /var
> Label: none  uuid: f96f4980-4682-4d2d-8d7a-3c0e2c1c6680
>         Total devices 1 FS bytes used 1.06GiB
>         devid    1 size 2.50GiB used 2.50GiB path 
> /dev/mapper/rootvg-varvol
> 
> uname -a
> Linux SERVERNAME 4.12.14-122.83-default #1 SMP Tue Aug 3 08:37:22 UTC
> 2021 (c86c48c) ppc64le ppc64le ppc64le GNU/Linux
> 
> On the previous Friday after weekly balance:
> btrfs fi usage /var
> Overall:
>     Device size:                   2.50GiB
>     Device allocated:              1.73GiB
>     Device unallocated:          792.75MiB
>     Device missing:                  0.00B
>     Used:                          1.09GiB
>     Free (estimated):              1.11GiB      (min: 739.62MiB)
>     Data ratio:                       1.00
>     Metadata ratio:                   2.00
>     Global reserve:               13.00MiB      (used: 0.00B)
> 
> Data,single: Size:1.41GiB, Used:1.08GiB
>    /dev/mapper/rootvg-varvol       1.41GiB
> 
> Metadata,DUP: Size:128.00MiB, Used:3.94MiB
>    /dev/mapper/rootvg-varvol     256.00MiB
> 
> System,DUP: Size:32.00MiB, Used:64.00KiB
>    /dev/mapper/rootvg-varvol      64.00MiB
> 
> Unallocated:
>    /dev/mapper/rootvg-varvol     792.75MiB
> 
> 
> I don't have extract of btrfs fi usage /var command during the
> weekend, but a script is extracting the Space allocated ("Size") and
> Used in Data and Metadata. I observed twice during the weekend space
> allocated to metadata is suddenly growing while the metadata used
> remains the same. The first time I had enough "Device unallocated" and
> no problem was observed, the second (on Sunday after midnight), it
> leads to FS RO (no space left).
> 
> Is there any situation that can lead to metadata allocation but
> without actual usage of metadata?

Same behavior this weekend (but no RO due to enough Device unallocated), 
something is allocating space to metadata but is not using it:

### Sat Oct 16 23:59:57 CEST 2021
Overall:
     Device size:                        5120.00MiB
     Device allocated:                   2647.25MiB
     Device unallocated:                 2472.75MiB
     Device missing:                        0.00MiB
     Used:                               1097.75MiB
     Free (estimated):                   2942.38MiB      (min: 
1706.00MiB)
     Data ratio:                               1.00
     Metadata ratio:                           2.00
     Global reserve:                       13.00MiB      (used: 0.00MiB)

Data,single: Size:1559.25MiB, Used:1089.62MiB
    /dev/mapper/rootvg-varvol    1559.25MiB

Metadata,DUP: Size:512.00MiB, Used:4.00MiB
    /dev/mapper/rootvg-varvol    1024.00MiB

System,DUP: Size:32.00MiB, Used:0.06MiB
    /dev/mapper/rootvg-varvol      64.00MiB

Unallocated:
    /dev/mapper/rootvg-varvol    2472.75MiB



### Sun Oct 17 00:00:32 CEST 2021
Overall:
     Device size:                        5120.00MiB
     Device allocated:                   2903.25MiB
     Device unallocated:                 2216.75MiB
     Device missing:                        0.00MiB
     Used:                               1097.44MiB
     Free (estimated):                   2686.69MiB      (min: 
1578.31MiB)
     Data ratio:                               1.00
     Metadata ratio:                           2.00
     Global reserve:                       13.00MiB      (used: 0.00MiB)

Data,single: Size:1559.25MiB, Used:1089.31MiB
    /dev/mapper/rootvg-varvol    1559.25MiB

Metadata,DUP: Size:640.00MiB, Used:4.00MiB
    /dev/mapper/rootvg-varvol    1280.00MiB

System,DUP: Size:32.00MiB, Used:0.06MiB
    /dev/mapper/rootvg-varvol      64.00MiB

Unallocated:
    /dev/mapper/rootvg-varvol    2216.75MiB


### Sun Oct 17 00:05:27 CEST 2021
Overall:
     Device size:                        5120.00MiB
     Device allocated:                   2903.25MiB
     Device unallocated:                 2216.75MiB
     Device missing:                        0.00MiB
     Used:                               1099.69MiB
     Free (estimated):                   2684.44MiB      (min: 
1576.06MiB)
     Data ratio:                               1.00
     Metadata ratio:                           2.00
     Global reserve:                       13.00MiB      (used: 0.00MiB)

Data,single: Size:1559.25MiB, Used:1091.56MiB
    /dev/mapper/rootvg-varvol    1559.25MiB

Metadata,DUP: Size:640.00MiB, Used:4.00MiB
    /dev/mapper/rootvg-varvol    1280.00MiB

System,DUP: Size:32.00MiB, Used:0.06MiB
    /dev/mapper/rootvg-varvol      64.00MiB

Unallocated:
    /dev/mapper/rootvg-varvol    2216.75MiB


### Sun Oct 17 00:05:32 CEST 2021
Overall:
     Device size:                        5120.00MiB
     Device allocated:                   3159.25MiB
     Device unallocated:                 1960.75MiB
     Device missing:                        0.00MiB
     Used:                               1100.25MiB
     Free (estimated):                   2427.88MiB      (min: 
1447.50MiB)
     Data ratio:                               1.00
     Metadata ratio:                           2.00
     Global reserve:                       13.00MiB      (used: 0.00MiB)

Data,single: Size:1559.25MiB, Used:1092.12MiB
    /dev/mapper/rootvg-varvol    1559.25MiB

Metadata,DUP: Size:768.00MiB, Used:4.00MiB
    /dev/mapper/rootvg-varvol    1536.00MiB

System,DUP: Size:32.00MiB, Used:0.06MiB
    /dev/mapper/rootvg-varvol      64.00MiB

Unallocated:
    /dev/mapper/rootvg-varvol    1960.75MiB

### Sun Oct 17 00:12:53 CEST 2021
Overall:
     Device size:                        5120.00MiB
     Device allocated:                   3159.25MiB
     Device unallocated:                 1960.75MiB
     Device missing:                        0.00MiB
     Used:                               1100.62MiB
     Free (estimated):                   2427.50MiB      (min: 
1447.12MiB)
     Data ratio:                               1.00
     Metadata ratio:                           2.00
     Global reserve:                       13.00MiB      (used: 0.00MiB)

Data,single: Size:1559.25MiB, Used:1092.50MiB
    /dev/mapper/rootvg-varvol    1559.25MiB

Metadata,DUP: Size:768.00MiB, Used:4.00MiB
    /dev/mapper/rootvg-varvol    1536.00MiB

System,DUP: Size:32.00MiB, Used:0.06MiB
    /dev/mapper/rootvg-varvol      64.00MiB

Unallocated:
    /dev/mapper/rootvg-varvol    1960.75MiB
### Sun Oct 17 00:12:58 CEST 2021
Overall:
     Device size:                        5120.00MiB
     Device allocated:                   2903.25MiB
     Device unallocated:                 2216.75MiB
     Device missing:                        0.00MiB
     Used:                               1100.69MiB
     Free (estimated):                   2683.44MiB      (min: 
1575.06MiB)
     Data ratio:                               1.00
     Metadata ratio:                           2.00
     Global reserve:                       13.00MiB      (used: 0.12MiB)

Data,single: Size:1559.25MiB, Used:1092.56MiB
    /dev/mapper/rootvg-varvol    1559.25MiB

Metadata,DUP: Size:640.00MiB, Used:4.00MiB
    /dev/mapper/rootvg-varvol    1280.00MiB

System,DUP: Size:32.00MiB, Used:0.06MiB
    /dev/mapper/rootvg-varvol      64.00MiB

Unallocated:
    /dev/mapper/rootvg-varvol    2216.75MiB



