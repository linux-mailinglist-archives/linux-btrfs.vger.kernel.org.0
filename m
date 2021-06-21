Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEC983AE453
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Jun 2021 09:42:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229984AbhFUHov (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 21 Jun 2021 03:44:51 -0400
Received: from mout.gmx.net ([212.227.17.20]:60819 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229641AbhFUHo1 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 21 Jun 2021 03:44:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1624261332;
        bh=gyoQsyiKcbjCxzK0NeU+Oh0QBq7UqHs4A3l84eUpNoA=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=Lq4jP8B9nWtrVGGPAhqSBrWcoCOfq5mLDQsAnOH2g7XK8Bb35YRwbB7osjDNP4NwM
         BIH2gnpxjje0Bur4LhbGICWqIi1bekCHzA60d7MXUUlbqs+IvxMhmomrI/sytFdUzx
         NFUMf834O31qLNHs5HbI31ShbCBHYkhuGo/kBUEg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M4axq-1lwszt0fp8-001lZ9; Mon, 21
 Jun 2021 09:42:11 +0200
Subject: Re: Filesystem goes readonly soon after mount, cannot free space or
 rebalance
To:     Asif Youssuff <yoasif@gmail.com>, linux-btrfs@vger.kernel.org
References: <2bb832db-3c33-d3ba-d9ae-4ebd44c1c7f3@gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <1b89f8a3-42a4-3c6d-aec8-1b91a7b43713@gmx.com>
Date:   Mon, 21 Jun 2021 15:42:08 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <2bb832db-3c33-d3ba-d9ae-4ebd44c1c7f3@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:5BJntR+02HVqf3PMHRJAwVNYgCh2wCfOs23sMJh7jCsv+G9Asrw
 4nEUWK2Nu0ib2Ubpi3W+6NG8CxRxRaHj5fuz7epu+DJFyYTJTxfgfjwK0GrsHjNfLrUIaHd
 WwURXYFV/8wgv4pDDfGJWj/3Ylrv0UL0FVD7MXGnGiKkeEuoHEIXRpUHLUckTp8E4jGnbMO
 gNpdn8Lvvxv0lthGlP48Q==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:3I73oMBnS1Y=:lVm0/Cq80wckcIqhr+XfKO
 ZZGrkjbf4HfvS37c2l9XUR+pVAjSKlhjwYdjIivCdQF4MH56XS7FVvBM4V1tl0GW79I/XOGxB
 /X5GTwbtOhCFY5mnWKnJY5bWf3/f9v0fL+uZ2k6FYGIxLetV8qDbmJ/nDV+d/jgxuk6lfRMUQ
 okH/QgjJWgOo5lDPqko2/eVmgGF1i5Ohs3ZCWCRuM2mdCbHh5jfc3gbVoXn5mDOoyNMm7B+7O
 5fVYo63a8ETEZkrd8Yw0TiNi1KwY0WLnDzjajz2verQo8F+0Sx5eZeNDANfKvxjWJPTzcZyAw
 tWkPtRoAlSgK0chYRuuv+ui9/v5ArY5dIyuWZXCEogLhL2iadYKTIDHTJ3WCWR7pdcmjEbEAG
 Kj9v4u/L3Ok9N40YBw33O9wdKuj6rxiOcubT4qW/mifq/7DQ9Zs6WYLq1BHZCQzZBuy5+iPfp
 /K/TiNEdnb6FKrxAL1j22ymoH85lkHQlq5MOc3jHcKuro+DbpJh8ugXClnsYcUvFizdsThrqe
 7CaepqZGzDhox0QRuHAItTDPaWQhWI6pkZ4m+oD0ESZnibz7J/kb2mW6vyRgWXSPZFi1ftcRZ
 eqx7KKZljAZxRYehAffKjoEYETvCSO49DuBGhJhjTuGN6q+AO/bT9lpf6V1nvm/aglHKs7kPn
 pke9H//lpTgFNZonbtnggiaXZsJAnLcMPKmjv9x2dP+pFv69j+MQMp2dafjSwIo+ok8WzGvbT
 wOHV2lrEnyFfZyJuWIWGyu4TkwIszEnB7toecy/KPzu/RQ05gBLng6c/feLOXbNx/JMoKEeNj
 ormfztYciO+2bfWGxokm2OTupYibKZIW6Jo/pcxQ89bC0LjxW1bvh/h0asPLaQaUXdpnq8fQc
 EtUD0OQDtYUvSDYUD0Mgc+BfLjUw9dcuuzLnnb6jFntzZlamgZAueoMgmwyxtHMwGepmeIUGG
 j5qxdONIUNltdg8hsXn3a1RcSNVCqM7Xx+DKTLVGby679Sr1AjayVkpLz1c8RB+qRQNuafIWN
 eDGvuI0eJOHCeqys7mfzj5VvCIyrjSM8S54y+D/gKkuWIvb3DlsHepx2mZEjBmlgiGi7KjHUa
 82FvMmNPUakzx3kM5QdKiDOnYjc5W4d40MMb0YZxiIFmfun0xBHAcbMUg==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/6/19 =E4=B8=8B=E5=8D=881:16, Asif Youssuff wrote:
> Hi Btrfs mailing list,
>
> I'm running into a weird situation where my filesystem goes readonly
> soon after mount. Removing snapshots or files doesn't help, and the
> changes are not persisted after the filesystem goes readonly and is
> remounted.
>
> I made the mistake of starting a large rebalance operation while using
> an expansive balance filter (I don't recall the figure, unfortunately),
> so I can't even add a new disk (given as a solution to disk full errors
> on various places on the web).
>
> Mounting with skip_balance stops the balance operation, but doesn't
> *cancel* it, so adding a new disk isn't possible.
>
> I'm pretty stuck here so any ideas on how to resolve would be great!
>
> uname -a
> Linux butter-server 5.12.11-051211-generic #202106161201 SMP Wed Jun 16
> 12:32:38 UTC 2021 x86_64 x86_64 x86_64 GNU/Linux
>
> btrfs --version
> btrfs-progs v5.4.1
>
> btrfs fi show
> Label: none=C2=A0 uuid: c8557a6e-4b51-44f1-ba8f-75fce8c7dfcd
>  =C2=A0=C2=A0 =C2=A0Total devices 1 FS bytes used 5.38TiB
>  =C2=A0=C2=A0 =C2=A0devid=C2=A0=C2=A0=C2=A0 1 size 5.46TiB used 5.46TiB =
path /dev/sdh1
>
> Label: none=C2=A0 uuid: 48ed8a66-731d-499b-829e-dd07dd7260cc
>  =C2=A0=C2=A0 =C2=A0Total devices 13 FS bytes used 50.79TiB
>  =C2=A0=C2=A0 =C2=A0devid=C2=A0=C2=A0=C2=A0 4 size 5.46TiB used 5.46TiB =
path /dev/sdf
>  =C2=A0=C2=A0 =C2=A0devid=C2=A0=C2=A0=C2=A0 5 size 7.28TiB used 7.28TiB =
path /dev/sdj
>  =C2=A0=C2=A0 =C2=A0devid=C2=A0=C2=A0=C2=A0 7 size 12.73TiB used 12.73Ti=
B path /dev/sdg
>  =C2=A0=C2=A0 =C2=A0devid=C2=A0=C2=A0=C2=A0 9 size 5.46TiB used 5.46TiB =
path /dev/sdd
>  =C2=A0=C2=A0 =C2=A0devid=C2=A0=C2=A0 10 size 7.28TiB used 7.28TiB path =
/dev/sdp
>  =C2=A0=C2=A0 =C2=A0devid=C2=A0=C2=A0 11 size 7.28TiB used 7.28TiB path =
/dev/sdl
>  =C2=A0=C2=A0 =C2=A0devid=C2=A0=C2=A0 12 size 5.46TiB used 5.46TiB path =
/dev/sdb
>  =C2=A0=C2=A0 =C2=A0devid=C2=A0=C2=A0 14 size 7.28TiB used 7.28TiB path =
/dev/sda
>  =C2=A0=C2=A0 =C2=A0devid=C2=A0=C2=A0 15 size 7.28TiB used 7.28TiB path =
/dev/sdn

All devices above are exhauseted, without unallocated space.

>  =C2=A0=C2=A0 =C2=A0devid=C2=A0=C2=A0 17 size 9.10TiB used 7.49TiB path =
/dev/sde

But there are several TiB unllocated space.

>  =C2=A0=C2=A0 =C2=A0devid=C2=A0=C2=A0 18 size 7.28TiB used 7.28TiB path =
/dev/sdm
>  =C2=A0=C2=A0 =C2=A0devid=C2=A0=C2=A0 20 size 7.28TiB used 7.28TiB path =
/dev/sdc
>  =C2=A0=C2=A0 =C2=A0devid=C2=A0=C2=A0 21 size 7.28TiB used 6.42TiB path =
/dev/sdo

And there is also some space.

I believe it's a bug in metadata overcommit code, which makes btrfs to
believe it can overcommit.

But in reality, metadata is RAID1C4, needs at least 4 devices, not 2.

And this illusion makes btrfs continue over-commit, and hits a situation
where it really runs of out space during critical operations, and went RO.


>
>
> sudo btrfs fi df /media/camino/
> Data, RAID1: total=3D37.59TiB, used=3D36.98TiB
> Data, RAID6: total=3D13.77TiB, used=3D13.75TiB
> System, RAID1C4: total=3D32.00MiB, used=3D12.97MiB
> Metadata, RAID1C4: total=3D66.00GiB, used=3D65.63GiB
> GlobalReserve, single: total=3D512.00MiB, used=3D0.00B
>
>
> After mount, my .allocation looks like (this is rw):
>
> grep -R . allocation/
> allocation/metadata/disk_used:281696862208
> allocation/metadata/bytes_pinned:17383424
> allocation/metadata/bytes_used:70424215552
> allocation/metadata/total_bytes_pinned:57327616
> allocation/metadata/disk_total:283467841536
> allocation/metadata/total_bytes:70866960384
> allocation/metadata/bytes_reserved:24412160
> allocation/metadata/bytes_readonly:0
> allocation/metadata/raid1c4/used_bytes:70424215552
> allocation/metadata/raid1c4/total_bytes:70866960384
> allocation/metadata/bytes_zone_unusable:0
> allocation/metadata/bytes_may_use:842219520
> allocation/metadata/flags:4
> allocation/system/disk_used:54525952
> allocation/system/bytes_pinned:0
> allocation/system/bytes_used:13631488
> allocation/system/total_bytes_pinned:114688
> allocation/system/disk_total:134217728
> allocation/system/total_bytes:33554432
> allocation/system/bytes_reserved:81920
> allocation/system/bytes_readonly:0
> allocation/system/raid1c4/used_bytes:13631488
> allocation/system/raid1c4/total_bytes:33554432
> allocation/system/bytes_zone_unusable:0
> allocation/system/bytes_may_use:0
> allocation/system/flags:2
> allocation/global_rsv_reserved:535183360
> allocation/data/raid1/used_bytes:40658677952512
> allocation/data/raid1/total_bytes:41329991548928
> allocation/data/disk_used:96436269289472
> allocation/data/bytes_pinned:65359872
> allocation/data/raid6/used_bytes:15118913384448
> allocation/data/raid6/total_bytes:15141606326272
> allocation/data/bytes_used:55777591259136
> allocation/data/total_bytes_pinned:4347092992
> allocation/data/disk_total:97801589424128
> allocation/data/total_bytes:56471597875200
> allocation/data/bytes_reserved:0
> allocation/data/bytes_readonly:2555904
> allocation/data/bytes_zone_unusable:0
> allocation/data/bytes_may_use:0
> allocation/data/flags:1
> allocation/global_rsv_size:536870912
>
> After the disk goes readonly, my .allocation looks like:
>
> grep -R . allocation/
> allocation/metadata/disk_used:281865486336
> allocation/metadata/bytes_pinned:0
> allocation/metadata/bytes_used:70466371584
> allocation/metadata/total_bytes_pinned:0
> allocation/metadata/disk_total:283467841536
> allocation/metadata/total_bytes:70866960384
> allocation/metadata/bytes_reserved:0
> allocation/metadata/bytes_readonly:0
> allocation/metadata/raid1c4/used_bytes:70466371584
> allocation/metadata/raid1c4/total_bytes:70866960384
> allocation/metadata/bytes_zone_unusable:0
> allocation/metadata/bytes_may_use:536870912
> allocation/metadata/flags:4
> allocation/system/disk_used:54394880
> allocation/system/bytes_pinned:0
> allocation/system/bytes_used:13598720
> allocation/system/total_bytes_pinned:0
> allocation/system/disk_total:134217728
> allocation/system/total_bytes:33554432
> allocation/system/bytes_reserved:0
> allocation/system/bytes_readonly:0
> allocation/system/raid1c4/used_bytes:13598720
> allocation/system/raid1c4/total_bytes:33554432
> allocation/system/bytes_zone_unusable:0
> allocation/system/bytes_may_use:0
> allocation/system/flags:2
> allocation/global_rsv_reserved:536870912
> allocation/data/raid1/used_bytes:40658677952512
> allocation/data/raid1/total_bytes:41329991548928
> allocation/data/disk_used:96434427817984
> allocation/data/bytes_pinned:0
> allocation/data/raid6/used_bytes:15117071912960
> allocation/data/raid6/total_bytes:15141606326272
> allocation/data/bytes_used:55775749865472
> allocation/data/total_bytes_pinned:0
> allocation/data/disk_total:97801589424128
> allocation/data/total_bytes:56471597875200
> allocation/data/bytes_reserved:0
> allocation/data/bytes_readonly:2555904
> allocation/data/bytes_zone_unusable:0
> allocation/data/bytes_may_use:0
> allocation/data/flags:1
> allocation/global_rsv_size:536870912
>
>
> dmesg error (full dmesg attached):
>
> [ 1043.994674] ------------[ cut here ]------------
> [ 1043.994676] BTRFS: Transaction aborted (error -28)
> [ 1043.994739] WARNING: CPU: 7 PID: 11673 at fs/btrfs/block-group.c:2721
> btrfs_start_dirty_block_groups+0x48c/0x4f0 [btrfs]
> [ 1043.994912] Modules linked in: xt_mark xt_nat veth
> nf_conntrack_netlink nfnetlink xfrm_user xfrm_algo xt_addrtype
> br_netfilter xt_CHECKSUM iptable_mangle xt_MASQUERADE iptable_nat nf_nat
> xt_conntrack nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 ipt_REJECT
> nf_reject_ipv4 xt_tcpudp bridge stp llc ebtable_filter ebtables
> ip6table_filter ip6_tables iptable_filter bpfilter ppdev parport_pc
> parport vmw_vsock_vmci_transport vsock vmw_vmci overlay bluetooth
> ecdh_generic ecc msr binfmt_misc joydev input_leds ipmi_ssif dm_crypt
> intel_rapl_msr intel_rapl_common x86_pkg_temp_thermal intel_powerclamp
> coretemp kvm_intel kvm rapl intel_cstate intel_pch_thermal lpc_ich
> mei_me mei ie31200_edac acpi_ipmi ipmi_si ipmi_devintf ipmi_msghandler
> mac_hid acpi_pad sch_fq_codel ib_iser rdma_cm iw_cm ib_cm ib_core
> iscsi_tcp libiscsi_tcp libiscsi scsi_transport_iscsi ip_tables x_tables
> autofs4 btrfs blake2b_generic raid10 raid456 async_raid6_recov
> async_memcpy async_pq async_xor async_tx xor raid6_pq libcrc32c raid1
> [ 1043.995121]=C2=A0 raid0 multipath linear dm_mirror dm_region_hash dm_=
log
> hid_generic usbhid hid uas usb_storage ast drm_vram_helper
> drm_ttm_helper ttm crct10dif_pclmul drm_kms_helper crc32_pclmul
> ghash_clmulni_intel aesni_intel syscopyarea sysfillrect sysimgblt
> fb_sys_fops crypto_simd ahci cec cryptd rc_core libahci mpt3sas igb drm
> dca xhci_pci raid_class e1000e i2c_algo_bit scsi_transport_sas
> xhci_pci_renesas video
> [ 1043.995272] CPU: 7 PID: 11673 Comm: snapperd Not tainted
> 5.12.11-051211-generic #202106161201
> [ 1043.995282] Hardware name: Supermicro X10SLM-F/X10SLM-F, BIOS 3.0
> 04/24/2015
> [ 1043.995289] RIP: 0010:btrfs_start_dirty_block_groups+0x48c/0x4f0 [btr=
fs]
> [ 1043.995459] Code: 8b 53 50 f0 48 0f ba aa 48 0a 00 00 03 72 20 83 f8
> fb 74 46 83 f8 e2 74 41 89 c6 48 c7 c7 e0 1a 85 c0 89 45 8c e8 57 99 9c
> e9 <0f> 0b 8b 45 8c 89 c1 ba a1 0a 00 00 48 89 df 89 45 8c 48 c7 c6 00
> [ 1043.995466] RSP: 0018:ffffb8ba424c3bf8 EFLAGS: 00010282
> [ 1043.995474] RAX: 0000000000000000 RBX: ffff89af68c460d0 RCX:
> ffff89b57fdd85c8
> [ 1043.995478] RDX: 00000000ffffffd8 RSI: 0000000000000027 RDI:
> ffff89b57fdd85c0
> [ 1043.995482] RBP: ffffb8ba424c3c70 R08: 0000000000000000 R09:
> ffffb8ba424c39d8
> [ 1043.995489] R10: ffffb8ba424c39d0 R11: ffffffffab5542e8 R12:
> ffff89af9b305000
> [ 1043.995493] R13: ffff89af9b305170 R14: ffff89af06973000 R15:
> ffff89af9b305160
> [ 1043.995498] FS:=C2=A0 00007f5f18556700(0000) GS:ffff89b57fdc0000(0000=
)
> knlGS:0000000000000000
> [ 1043.995503] CS:=C2=A0 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 1043.995507] CR2: 00007fdb1af228a0 CR3: 000000027477a002 CR4:
> 00000000001706e0
> [ 1043.995513] Call Trace:
> [ 1043.995521]=C2=A0 btrfs_commit_transaction+0x7ff/0xa20 [btrfs]
> [ 1043.995640]=C2=A0 ? start_transaction+0xd5/0x590 [btrfs]
> [ 1043.995751]=C2=A0 create_snapshot+0x1bb/0x270 [btrfs]
> [ 1043.995894]=C2=A0 btrfs_mksubvol+0x112/0x1f0 [btrfs]
> [ 1043.996037]=C2=A0 btrfs_mksnapshot+0x80/0xb0 [btrfs]
> [ 1043.996178]=C2=A0 __btrfs_ioctl_snap_create+0x176/0x180 [btrfs]
> [ 1043.996320]=C2=A0 btrfs_ioctl_snap_create_v2+0xc0/0x150 [btrfs]
> [ 1043.996462]=C2=A0 btrfs_ioctl+0x93c/0x970 [btrfs]
> [ 1043.996603]=C2=A0 ? __cond_resched+0x1a/0x50
> [ 1043.996614]=C2=A0 __x64_sys_ioctl+0x91/0xc0
> [ 1043.996623]=C2=A0 do_syscall_64+0x38/0x90
> [ 1043.996630]=C2=A0 entry_SYSCALL_64_after_hwframe+0x44/0xae
> [ 1043.996640] RIP: 0033:0x7f5f1db09317
> [ 1043.996647] Code: b3 66 90 48 8b 05 71 4b 2d 00 64 c7 00 26 00 00 00
> 48 c7 c0 ff ff ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 b8 10 00 00 00 0f
> 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 41 4b 2d 00 f7 d8 64 89 01 48
> [ 1043.996653] RSP: 002b:00007f5f185532c8 EFLAGS: 00000246 ORIG_RAX:
> 0000000000000010
> [ 1043.996660] RAX: ffffffffffffffda RBX: 00007f5f185532d0 RCX:
> 00007f5f1db09317
> [ 1043.996664] RDX: 00007f5f185532d0 RSI: 0000000050009417 RDI:
> 0000000000000007
> [ 1043.996668] RBP: 0000000000000006 R08: 000000000000000f R09:
> 00007f5f18554f84
> [ 1043.996671] R10: 0000000000000000 R11: 0000000000000246 R12:
> 0000000000000007
> [ 1043.996675] R13: 00007f5f18555450 R14: 0000000000000000 R15:
> 0000000000000001
> [ 1043.996683] ---[ end trace 84d7b5fe58817f91 ]---
> [ 1043.996689] BTRFS: error (device sdf) in
> btrfs_start_dirty_block_groups:2721: errno=3D-28 No space left
> [ 1044.014701] BTRFS error (device sdf): allocation failed flags 1028,
> wanted 16384 tree-log 0
> [ 1044.014835] BTRFS: error (device sdf) in __btrfs_free_extent:3216:
> errno=3D-28 No space left
> [ 1044.014918] BTRFS: error (device sdf) in btrfs_run_delayed_refs:2163:
> errno=3D-28 No space left

Can you delete some subvolumes/snapshot to free some space?

In such critical case, I don't believe balance will do any help.

Regular file deletion also needs extra metadata, thus maybe only
subvolumes/snapshots deletion can help.

Thanks,
Qu
>
>
> Thanks for the help!
> Asif
