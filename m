Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 12764A7A17
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Sep 2019 06:41:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726163AbfIDElR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 4 Sep 2019 00:41:17 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39473 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725267AbfIDEjj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 4 Sep 2019 00:39:39 -0400
Received: by mail-wr1-f65.google.com with SMTP id t16so19665651wra.6
        for <linux-btrfs@vger.kernel.org>; Tue, 03 Sep 2019 21:39:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=liland-com.20150623.gappssmtp.com; s=20150623;
        h=subject:references:from:to:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding:content-language;
        bh=xgSt7sqrXkx5FXb9owWHRK9no1RdcpcVdjXzgj+Q2uI=;
        b=KNT9F/aqxI3P4JcHXvzAiZB10BvN23Vm6nA1nxHLrjhsH65j7TMrGG4WPM0STi8pvr
         gNWCvkbvbC36V6zlGXXWKHM6ZtarWPk87XEbF2Y/BV7wz2Xv96xxO0KU1Lr9KiSBevwa
         dFQ4kv33fABIzQPcxnJbE55BryEty5s4ryPl7AwgB5YIHoqkNGyQtBclpKbEqrkn7Huw
         j74CAEA3+lQkBe+CeFlHFFBFcaWuFHBVa6s0pUqx+CNFnE5zzsdfGI5L1lwhLvxMGmDL
         YxfpJBwWqpPZqNTUBDXIbihqOJucF87R1ssywMTDLH48DdG/I1vvmFTtwGStPROUSFGe
         DUSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:references:from:to:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=xgSt7sqrXkx5FXb9owWHRK9no1RdcpcVdjXzgj+Q2uI=;
        b=qcsyTIyuA5fea9TVBjhN2zmH8Xv+jE9Pk4IWrEjyOUny5qNXMXoe14K880/enVtxds
         OKJeksqFNWOOSchyP+HvPAM+7wrRPNLShq2kunxxWdtXPNvK89Icn559H87/mwOpHqwM
         OAN+akV2UCJlIsTumUx5WGACGNTVI/NWoVfp7OE4YbAKf5XldOVZ9h5q/wsCIsXEh+Ah
         C48NotRfCLOfsHDXn3YJ26vuLyCkPDA3Hqrzh7fjsnoHuxr0YeUaHcgPCOD0PrDaAUp5
         9GDsm1OIIGAY8qbpWmdmiU8GyisBn1LPkW9mY/TOINxjERQ7kh+IJkrR63pCFDid7Hxq
         JCsA==
X-Gm-Message-State: APjAAAVxd2Teind4CXHYi5wtGyg6KgQ0KusIiJlz08JHuGEvmWMEkOYx
        N5GmDnYigFrByImzT7v+hJCRcYdhuQt7n/BsAtFEkVZ+Nvuod2mO8WFd6gP2pUEyeQdLngg0HM1
        8MwMhZaMamwe8mwNvinQ8Aw==
X-Google-Smtp-Source: APXvYqzVYT5Fm4uskwNVDKReFPTEohxQqrKmeHjHzVOp47CQfu5TWoRB+IPNpjqzzfjZM4EUNJksYg==
X-Received: by 2002:a5d:4fc9:: with SMTP id h9mr33943446wrw.334.1567571971251;
        Tue, 03 Sep 2019 21:39:31 -0700 (PDT)
Received: from [192.168.42.1] (84-112-118-202.cable.dynamic.surfer.at. [84.112.118.202])
        by smtp.gmail.com with ESMTPSA id x6sm2087530wmf.38.2019.09.03.21.39.30
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Sep 2019 21:39:30 -0700 (PDT)
Subject: Re: Unmountable degraded BTRFS RAID6 filesystem
References: <f58d5ec1-4b38-ad8b-068d-d3bb1f616ec2@liland.com>
 <CAJCQCtTqetLF1sMmgoPyN=2FOHu+MSSW-MGsN6NairLPdNmK+g@mail.gmail.com>
From:   Edmund Urbani <edmund.urbani@liland.com>
To:     linux-btrfs@vger.kernel.org
Message-ID: <c57b8314-4914-628c-f62b-c5291a6be53c@liland.com>
Date:   Wed, 4 Sep 2019 06:39:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CAJCQCtTqetLF1sMmgoPyN=2FOHu+MSSW-MGsN6NairLPdNmK+g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 09/04/2019 01:30 AM, Chris Murphy wrote:
> On Tue, Sep 3, 2019 at 2:20 PM Edmund Urbani <edmund.urbani@liland.com> w=
rote:
>>
>> Hi all,
>>
>> two days ago my btrfs filesystem became quite slow and the logs showed a
>> lot of I/O errors on one of the HDDs. I ordered a replacement drive and
>> tried to remove the failing drive from the filesystem (btrfs device
>> remove). That removal command did not finish but just sat there without
>> any output.
> What exact commands?
btrfs device delete /dev/sdb1 /mnt/shared
>
> 'btrfs device del missing' I expect causes reconstruction from parity
> as well as a balance to create the new 9 device stripe width (well, 7
> data + 2 parity). This is not an inherently bad thing to do, it should
> work and should be COW. And there's one extra copy available in case
> of an unrecoverable read error, it can still do additional
> reconstruction.
>
> Because it's a balance though, it might be really, really slow and I
> don't think there is no way to cancel device removal. I don't think
> it's possible to cancel it with btrfs balance stop.
>
> How many subvolumes and snapshots? Are quotas enabled?
One subvolume, no snapshot (I used to have some, but I think I removed
them all), no quotes.
>
>
>> Today the new drive arrived. Device removal still had not finished, but
>> the filesystem had entered read-only mode last night.
> Likely pre-existing problem is discovered during the balance, or bug
> triggered, or both, and the file system goes read only to avoid
> further corruption. Do you have kernel messages for the entire time
> starting at 'device delete' until the file system goes read only?
Well, I found this in the logs and that might be around the time I
started device removal:

Sep=C2=A0 1 16:19:30 phoenix kernel: ------------[ cut here ]------------
Sep=C2=A0 1 16:19:30 phoenix kernel: WARNING: CPU: 9 PID: 6401 at
fs/btrfs/ctree.h:1564 btrfs_update_device+0x1ae/0x1c0 [btrfs]
Sep=C2=A0 1 16:19:30 phoenix kernel: Modules linked in: nfnetlink_queue
nfnetlink_log nvidia_uvm(O) nvidia(PO) tun nfsd auth_rpcgss oid_registry
nfs_acl ipt_MASQUERADE nf_nat_masquerade_ipv4 nf_conntrack_netlink
nfnetlink xfrm_user xt_addrtype br_netfilter bridge stp llc
nf_conntrack_irc xt_CT xt_tcpudp xt_helper nf_conntrack_ftp nf_log_ipv4
nf_log_common ip6table_raw ip6table_mangle iptable_nat nf_conntrack_ipv4
nf_defrag_ipv4 nf_nat_ipv4 nf_nat xt_TCPMSS xt_LOG ipt_REJECT
nf_reject_ipv4 iptable_raw iptable_mangle xt_multiport xt_state xt_limit
xt_conntrack nf_conntrack ip6table_filter ip6_tables iptable_filter
ip_tables x_tables binfm
t_misc snd_hda_codec_hdmi ata_generic kvm_amd kvm snd_hda_intel
irqbypass ftdi_sio snd_hda_codec usbserial snd_hda_core pcspkr ipmi_si
snd_pcm i2c_piix4 k10temp snd_timer pata_acpi ohci_pci
Sep=C2=A0 1 16:19:30 phoenix kernel:=C2=A0 snd e1000e nvidiafb vgastate shp=
chp
evdev xts crypto_simd cryptd glue_helper aes_x86_64 ixgb ixgbe tulip
cxgb3 cxgb mdio bonding vxlan ip6_udp_tunnel udp_tunnel macvlan tg3
libphy sky2 r8169 pcnet32 mii igb ptp pps_core dca e1000 bnx2 msdos fat
fscrypto configfs overlay fuse nfs lockd grace sunrpc fscache btrfs
zstd_decompress zstd_compress xxhash zlib_deflate dm_thin_pool
dm_persistent_data dm_bio_prison hid_sunplus hid_sony hid_samsung hid_pl
hid_petalynx hid_logitech_dj hid_gyration sl811_hcd usbhid xhci_pci
xhci_hcd ohci_hcd uhci_hcd usb_storage ehci_pci ehci_hcd qla2xxx
megaraid_sas megaraid aa
craid sx8 DAC960 3w_9xxx 3w_xxxx mptsas scsi_transport_sas mptfc
scsi_transport_fc mptspi mptscsih mptbase atp870u dc395x qla1280 imm
parport dmx3191d sym53c8xx gdth BusLogic aic7xxx aic79xx
Sep=C2=A0 1 16:19:30 phoenix kernel:=C2=A0 scsi_transport_spi sr_mod cdrom =
sg
pdc_adma sata_inic162x sata_mv ata_piix ahci libahci sata_qstor sata_vsc
sata_uli sata_sis sata_sx4 sata_nv sata_via sata_svw sata_sil24 sata_sil
sata_promise pata_sl82c105 pata_via pata_jmicron pata_marvell pata_sis
pata_netcell pata_pdc202xx_old pata_triflex pata_atiixp pata_opti
pata_amd pata_ali pata_it8213 pata_ns87415 pata_ns87410 pata_serverworks
pata_cypress pata_oldpiix pata_artop pata_it821x pata_optidma
pata_hpt3x2n pata_hpt3x3 pata_hpt37x pata_hpt366 pata_cmd64x pata_efar
pata_rz1000 pata_sil680 pata_radisys pata_pdc2027x pata_mpiix [last
unloaded: nvid
ia]
Sep=C2=A0 1 16:19:30 phoenix kernel: CPU: 9 PID: 6401 Comm: btrfs Tainted:
P=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 W=C2=A0 O=C2=A0=C2=A0=C2=A0 4.1=
4.78-gentoo #1
Sep=C2=A0 1 16:19:30 phoenix kernel: Hardware name: System manufacturer
System Product Name/KGP(M)E-D16, BIOS 2202=C2=A0=C2=A0=C2=A0 03/29/2012
Sep=C2=A0 1 16:19:30 phoenix kernel: task: ffff880090b7c700 task.stack:
ffffc9000b394000
Sep=C2=A0 1 16:19:30 phoenix kernel: RIP:
0010:btrfs_update_device+0x1ae/0x1c0 [btrfs]
Sep=C2=A0 1 16:19:30 phoenix kernel: RSP: 0018:ffffc9000b397b98 EFLAGS: 000=
10206
Sep=C2=A0 1 16:19:30 phoenix kernel: RAX: 0000000000000fff RBX:
ffff88035d1b4690 RCX: 000002baa1371e00
Sep=C2=A0 1 16:19:30 phoenix kernel: RDX: 0000000000001000 RSI:
ffff880000000000 RDI: ffff88031455fd20
Sep=C2=A0 1 16:19:30 phoenix kernel: RBP: ffff88022c53e400 R08:
ffffc9000b397b50 R09: ffffc9000b397b58
Sep=C2=A0 1 16:19:30 phoenix kernel: R10: 0000000000000003 R11:
0000000000003000 R12: 0000000000000000
Sep=C2=A0 1 16:19:30 phoenix kernel: R13: 0000000000003cf0 R14:
ffff88031455fd20 R15: ffff880826250348
Sep=C2=A0 1 16:19:30 phoenix kernel: FS:=C2=A0 00007f16f8e4e8c0(0000)
GS:ffff88042f980000(0000) knlGS:0000000000000000
Sep=C2=A0 1 16:19:30 phoenix kernel: CS:=C2=A0 0010 DS: 0000 ES: 0000 CR0:
0000000080050033
Sep=C2=A0 1 16:19:30 phoenix kernel: CR2: 00007f0c0564b180 CR3:
0000000438a32000 CR4: 00000000000006e0
Sep=C2=A0 1 16:19:30 phoenix kernel: Call Trace:
Sep=C2=A0 1 16:19:30 phoenix kernel:=C2=A0 btrfs_remove_chunk+0x2f9/0x700 [=
btrfs]
Sep=C2=A0 1 16:19:30 phoenix kernel:=C2=A0 btrfs_relocate_chunk+0x9c/0xd0 [=
btrfs]
Sep=C2=A0 1 16:19:30 phoenix kernel:=C2=A0 btrfs_shrink_device+0x1c0/0x4f0 =
[btrfs]
Sep=C2=A0 1 16:19:30 phoenix kernel:=C2=A0 ?
btrfs_find_device_missing_or_by_path+0x30/0x120 [btrfs]
Sep=C2=A0 1 16:19:30 phoenix kernel:=C2=A0 btrfs_rm_device+0x19b/0x4f0 [btr=
fs]
Sep=C2=A0 1 16:19:30 phoenix kernel:=C2=A0 ? _copy_from_user+0x3f/0x80
Sep=C2=A0 1 16:19:30 phoenix kernel:=C2=A0 btrfs_ioctl+0x2129/0x2380 [btrfs=
]
Sep=C2=A0 1 16:19:30 phoenix kernel:=C2=A0 ? _copy_to_user+0x22/0x30
Sep=C2=A0 1 16:19:30 phoenix kernel:=C2=A0 ? cp_new_stat+0x138/0x150
Sep=C2=A0 1 16:19:30 phoenix kernel:=C2=A0 do_vfs_ioctl+0x9b/0x5e0
Sep=C2=A0 1 16:19:30 phoenix kernel:=C2=A0 ? SyS_newstat+0x35/0x40
Sep=C2=A0 1 16:19:30 phoenix kernel:=C2=A0 SyS_ioctl+0x47/0x90
Sep=C2=A0 1 16:19:30 phoenix kernel:=C2=A0 do_syscall_64+0x55/0x100
Sep=C2=A0 1 16:19:30 phoenix kernel:=C2=A0 entry_SYSCALL_64_after_hwframe+0=
x3d/0xa2
Sep=C2=A0 1 16:19:30 phoenix kernel: RIP: 0033:0x7f16f7be80f7
Sep=C2=A0 1 16:19:30 phoenix kernel: RSP: 002b:00007ffd701d26e8 EFLAGS:
00000206 ORIG_RAX: 0000000000000010
Sep=C2=A0 1 16:19:30 phoenix kernel: RAX: ffffffffffffffda RBX:
00007ffd701d4880 RCX: 00007f16f7be80f7
Sep=C2=A0 1 16:19:30 phoenix kernel: RDX: 00007ffd701d3720 RSI:
000000005000943a RDI: 0000000000000003
Sep=C2=A0 1 16:19:30 phoenix kernel: RBP: 00007ffd701d3720 R08:
0000000000000000 R09: 000000000000000c
Sep=C2=A0 1 16:19:30 phoenix kernel: R10: 0000000000000572 R11:
0000000000000206 R12: 0000000000000000
Sep=C2=A0 1 16:19:30 phoenix kernel: R13: 0000000000000000 R14:
0000000000000003 R15: 00007ffd701d4888
Sep=C2=A0 1 16:19:30 phoenix kernel: Code: 4c 89 f7 45 31 c0 ba 10 00 00 00
4c 89 ee e8 9a 40 ff ff 4c 89 f7 e8 42 29 fd ff e9 de fe ff ff 41 bc f4
ff ff ff e9 db fe ff ff <0f> 0b eb b7 0f 1f 40 00 66 2e 0f 1f 84 00 00
00 00 00 53 31 d2
Sep=C2=A0 1 16:19:30 phoenix kernel: ---[ end trace edd626af3a502d93 ]---
Sep=C2=A0 1 16:19:30 phoenix kernel: ------------[ cut here ]------------
Sep=C2=A0 1 16:19:30 phoenix kernel: WARNING: CPU: 10 PID: 6401 at
fs/btrfs/ctree.h:1564 btrfs_update_device+0x1ae/0x1c0 [btrfs]
Sep=C2=A0 1 16:19:30 phoenix kernel: Modules linked in: nfnetlink_queue
nfnetlink_log nvidia_uvm(O) nvidia(PO) tun nfsd auth_rpcgss oid_registry
nfs_acl ipt_MASQUERADE nf_nat_masquerade_ipv4 nf_conntrack_netlink
nfnetlink xfrm_user xt_addrtype br_netfilter bridge stp llc
nf_conntrack_irc xt_CT xt_tcpudp xt_helper nf_conntrack_ftp nf_log_ipv4
nf_log_common ip6table_raw ip6table_mangle iptable_nat nf_conntrack_ipv4
nf_defrag_ipv4 nf_nat_ipv4 nf_nat xt_TCPMSS xt_LOG ipt_REJECT
nf_reject_ipv4 iptable_raw iptable_mangle xt_multiport xt_state xt_limit
xt_conntrack nf_conntrack ip6table_filter ip6_tables iptable_filter
ip_tables x_tables binfm
t_misc snd_hda_codec_hdmi ata_generic kvm_amd kvm snd_hda_intel
irqbypass ftdi_sio snd_hda_codec usbserial snd_hda_core pcspkr ipmi_si
snd_pcm i2c_piix4 k10temp snd_timer pata_acpi ohci_pci
Sep=C2=A0 1 16:19:30 phoenix kernel:=C2=A0 snd e1000e nvidiafb vgastate shp=
chp
evdev xts crypto_simd cryptd glue_helper aes_x86_64 ixgb ixgbe tulip
cxgb3 cxgb mdio bonding vxlan ip6_udp_tunnel udp_tunnel macvlan tg3
libphy sky2 r8169 pcnet32 mii igb ptp pps_core dca e1000 bnx2 msdos fat
fscrypto configfs overlay fuse nfs lockd grace sunrpc fscache btrfs
zstd_decompress zstd_compress xxhash zlib_deflate dm_thin_pool
dm_persistent_data dm_bio_prison hid_sunplus hid_sony hid_samsung hid_pl
hid_petalynx hid_logitech_dj hid_gyration sl811_hcd usbhid xhci_pci
xhci_hcd ohci_hcd uhci_hcd usb_storage ehci_pci ehci_hcd qla2xxx
megaraid_sas megaraid aa
craid sx8 DAC960 3w_9xxx 3w_xxxx mptsas scsi_transport_sas mptfc
scsi_transport_fc mptspi mptscsih mptbase atp870u dc395x qla1280 imm
parport dmx3191d sym53c8xx gdth BusLogic aic7xxx aic79xx
Sep=C2=A0 1 16:19:30 phoenix kernel:=C2=A0 scsi_transport_spi sr_mod cdrom =
sg
pdc_adma sata_inic162x sata_mv ata_piix ahci libahci sata_qstor sata_vsc
sata_uli sata_sis sata_sx4 sata_nv sata_via sata_svw sata_sil24 sata_sil
sata_promise pata_sl82c105 pata_via pata_jmicron pata_marvell pata_sis
pata_netcell pata_pdc202xx_old pata_triflex pata_atiixp pata_opti
pata_amd pata_ali pata_it8213 pata_ns87415 pata_ns87410 pata_serverworks
pata_cypress pata_oldpiix pata_artop pata_it821x pata_optidma
pata_hpt3x2n pata_hpt3x3 pata_hpt37x pata_hpt366 pata_cmd64x pata_efar
pata_rz1000 pata_sil680 pata_radisys pata_pdc2027x pata_mpiix [last
unloaded: nvid
ia]
Sep=C2=A0 1 16:19:30 phoenix kernel: CPU: 10 PID: 6401 Comm: btrfs Tainted:
P=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 W=C2=A0 O=C2=A0=C2=A0=C2=A0 4.1=
4.78-gentoo #1
Sep=C2=A0 1 16:19:30 phoenix kernel: Hardware name: System manufacturer
System Product Name/KGP(M)E-D16, BIOS 2202=C2=A0=C2=A0=C2=A0 03/29/2012
Sep=C2=A0 1 16:19:30 phoenix kernel: task: ffff880090b7c700 task.stack:
ffffc9000b394000
Sep=C2=A0 1 16:19:30 phoenix kernel: RIP:
0010:btrfs_update_device+0x1ae/0x1c0 [btrfs]
Sep=C2=A0 1 16:19:30 phoenix kernel: RSP: 0018:ffffc9000b397b98 EFLAGS: 000=
10206
Sep=C2=A0 1 16:19:30 phoenix kernel: RAX: 0000000000000fff RBX:
ffff88035d1b4690 RCX: 000002baa1371e00
Sep=C2=A0 1 16:19:30 phoenix kernel: RDX: 0000000000001000 RSI:
ffff880000000000 RDI: ffff88031455fd20
Sep=C2=A0 1 16:19:30 phoenix kernel: RBP: ffff8808261adc00 R08:
ffffc9000b397b50 R09: ffffc9000b397b58
Sep=C2=A0 1 16:19:30 phoenix kernel: R10: 0000000000000003 R11:
0000000000003000 R12: 0000000000000000
Sep=C2=A0 1 16:19:30 phoenix kernel: R13: 0000000000003e16 R14:
ffff88031455fd20 R15: ffff880826250348
Sep=C2=A0 1 16:19:30 phoenix kernel: FS:=C2=A0 00007f16f8e4e8c0(0000)
GS:ffff88042fa00000(0000) knlGS:0000000000000000
Sep=C2=A0 1 16:19:30 phoenix kernel: CS:=C2=A0 0010 DS: 0000 ES: 0000 CR0:
0000000080050033
Sep=C2=A0 1 16:19:30 phoenix kernel: CR2: 00007f0c0564b180 CR3:
0000000438a32000 CR4: 00000000000006e0
Sep=C2=A0 1 16:19:30 phoenix kernel: Call Trace:
Sep=C2=A0 1 16:19:30 phoenix kernel:=C2=A0 btrfs_remove_chunk+0x2f9/0x700 [=
btrfs]
Sep=C2=A0 1 16:19:30 phoenix kernel:=C2=A0 btrfs_relocate_chunk+0x9c/0xd0 [=
btrfs]
Sep=C2=A0 1 16:19:30 phoenix kernel:=C2=A0 btrfs_shrink_device+0x1c0/0x4f0 =
[btrfs]
Sep=C2=A0 1 16:19:30 phoenix kernel:=C2=A0 ?
btrfs_find_device_missing_or_by_path+0x30/0x120 [btrfs]
Sep=C2=A0 1 16:19:30 phoenix kernel:=C2=A0 btrfs_rm_device+0x19b/0x4f0 [btr=
fs]
Sep=C2=A0 1 16:19:30 phoenix kernel:=C2=A0 ? _copy_from_user+0x3f/0x80
Sep=C2=A0 1 16:19:30 phoenix kernel:=C2=A0 btrfs_ioctl+0x2129/0x2380 [btrfs=
]
Sep=C2=A0 1 16:19:30 phoenix kernel:=C2=A0 ? _copy_to_user+0x22/0x30
Sep=C2=A0 1 16:19:30 phoenix kernel:=C2=A0 ? cp_new_stat+0x138/0x150
Sep=C2=A0 1 16:19:30 phoenix kernel:=C2=A0 do_vfs_ioctl+0x9b/0x5e0
Sep=C2=A0 1 16:19:30 phoenix kernel:=C2=A0 ? SyS_newstat+0x35/0x40
Sep=C2=A0 1 16:19:30 phoenix kernel:=C2=A0 SyS_ioctl+0x47/0x90
Sep=C2=A0 1 16:19:30 phoenix kernel:=C2=A0 do_syscall_64+0x55/0x100
Sep=C2=A0 1 16:19:30 phoenix kernel:=C2=A0 entry_SYSCALL_64_after_hwframe+0=
x3d/0xa2
Sep=C2=A0 1 16:19:30 phoenix kernel: RIP: 0033:0x7f16f7be80f7
Sep=C2=A0 1 16:19:30 phoenix kernel: RSP: 002b:00007ffd701d26e8 EFLAGS:
00000206 ORIG_RAX: 0000000000000010
Sep=C2=A0 1 16:19:30 phoenix kernel: RAX: ffffffffffffffda RBX:
00007ffd701d4880 RCX: 00007f16f7be80f7
Sep=C2=A0 1 16:19:30 phoenix kernel: RDX: 00007ffd701d3720 RSI:
000000005000943a RDI: 0000000000000003
Sep=C2=A0 1 16:19:30 phoenix kernel: RBP: 00007ffd701d3720 R08:
0000000000000000 R09: 000000000000000c
Sep=C2=A0 1 16:19:30 phoenix kernel: R10: 0000000000000572 R11:
0000000000000206 R12: 0000000000000000
Sep=C2=A0 1 16:19:30 phoenix kernel: R13: 0000000000000000 R14:
0000000000000003 R15: 00007ffd701d4888
Sep=C2=A0 1 16:19:30 phoenix kernel: Code: 4c 89 f7 45 31 c0 ba 10 00 00 00
4c 89 ee e8 9a 40 ff ff 4c 89 f7 e8 42 29 fd ff e9 de fe ff ff 41 bc f4
ff ff ff e9 db fe ff ff <0f> 0b eb b7 0f 1f 40 00 66 2e 0f 1f 84 00 00
00 00 00 53 31 d2
Sep=C2=A0 1 16:19:30 phoenix kernel: ---[ end trace edd626af3a502d94 ]---
Sep=C2=A0 1 16:19:30 phoenix kernel: ------------[ cut here ]------------
Sep=C2=A0 1 16:19:30 phoenix kernel: WARNING: CPU: 11 PID: 6401 at
fs/btrfs/ctree.h:1564 btrfs_update_device+0x1ae/0x1c0 [btrfs]
Sep=C2=A0 1 16:19:30 phoenix kernel: Modules linked in: nfnetlink_queue
nfnetlink_log nvidia_uvm(O) nvidia(PO) tun nfsd auth_rpcgss oid_registry
nfs_acl ipt_MASQUERADE nf_nat_masquerade_ipv4 nf_conntrack_netlink
nfnetlink xfrm_user xt_addrtype br_netfilter bridge stp llc
nf_conntrack_irc xt_CT xt_tcpudp xt_helper nf_conntrack_ftp nf_log_ipv4
nf_log_common ip6table_raw ip6table_mangle iptable_nat nf_conntrack_ipv4
nf_defrag_ipv4 nf_nat_ipv4 nf_nat xt_TCPMSS xt_LOG ipt_REJECT
nf_reject_ipv4 iptable_raw iptable_mangle xt_multiport xt_state xt_limit
xt_conntrack nf_conntrack ip6table_filter ip6_tables iptable_filter
ip_tables x_tables binfmt_misc snd_hda_codec_hdmi ata_generic kvm_amd
kvm snd_hda_intel irqbypass ftdi_sio snd_hda_codec usbserial
snd_hda_core pcspkr ipmi_si snd_pcm i2c_piix4 k10temp snd_timer
pata_acpi ohci_pci
Sep=C2=A0 1 16:19:30 phoenix kernel:=C2=A0 snd e1000e nvidiafb vgastate shp=
chp
evdev xts crypto_simd cryptd glue_helper aes_x86_64 ixgb ixgbe tulip
cxgb3 cxgb mdio bonding vxlan ip6_udp_tunnel udp_tunnel macvlan tg3
libphy sky2 r8169 pcnet32 mii igb ptp pps_core dca e1000 bnx2 msdos fat
fscrypto configfs overlay fuse nfs lockd grace sunrpc fscache btrfs
zstd_decompress zstd_compress xxhash zlib_deflate dm_thin_pool
dm_persistent_data dm_bio_prison hid_sunplus hid_sony hid_samsung hid_pl
hid_petalynx hid_logitech_dj hid_gyration sl811_hcd usbhid xhci_pci
xhci_hcd ohci_hcd uhci_hcd usb_storage ehci_pci ehci_hcd qla2xxx
megaraid_sas megaraid aacraid sx8 DAC960 3w_9xxx 3w_xxxx mptsas
scsi_transport_sas mptfc scsi_transport_fc mptspi mptscsih mptbase
atp870u dc395x qla1280 imm parport dmx3191d sym53c8xx gdth BusLogic
aic7xxx aic79xx
Sep=C2=A0 1 16:19:30 phoenix kernel:=C2=A0 scsi_transport_spi sr_mod cdrom =
sg
pdc_adma sata_inic162x sata_mv ata_piix ahci libahci sata_qstor sata_vsc
sata_uli sata_sis sata_sx4 sata_nv sata_via sata_svw sata_sil24 sata_sil
sata_promise pata_sl82c105 pata_via pata_jmicron pata_marvell pata_sis
pata_netcell pata_pdc202xx_old pata_triflex pata_atiixp pata_opti
pata_amd pata_ali pata_it8213 pata_ns87415 pata_ns87410 pata_serverworks
pata_cypress pata_oldpiix pata_artop pata_it821x pata_optidma
pata_hpt3x2n pata_hpt3x3 pata_hpt37x pata_hpt366 pata_cmd64x pata_efar
pata_rz1000 pata_sil680 pata_radisys pata_pdc2027x pata_mpiix [last
unloaded: nvidia]
Sep=C2=A0 1 16:19:30 phoenix kernel: CPU: 11 PID: 6401 Comm: btrfs Tainted:
P=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 W=C2=A0 O=C2=A0=C2=A0=C2=A0 4.1=
4.78-gentoo #1
Sep=C2=A0 1 16:19:30 phoenix kernel: Hardware name: System manufacturer
System Product Name/KGP(M)E-D16, BIOS 2202=C2=A0=C2=A0=C2=A0 03/29/2012
Sep=C2=A0 1 16:19:30 phoenix kernel: task: ffff880090b7c700 task.stack:
ffffc9000b394000
Sep=C2=A0 1 16:19:30 phoenix kernel: RIP:
0010:btrfs_update_device+0x1ae/0x1c0 [btrfs]
Sep=C2=A0 1 16:19:30 phoenix kernel: RSP: 0018:ffffc9000b397b98 EFLAGS: 000=
10206
Sep=C2=A0 1 16:19:30 phoenix kernel: RAX: 0000000000000fff RBX:
ffff88035d1b4690 RCX: 000002baa1371e00
Sep=C2=A0 1 16:19:30 phoenix kernel: RDX: 0000000000001000 RSI:
ffff880000000000 RDI: ffff88031455fd20
Sep=C2=A0 1 16:19:30 phoenix kernel: RBP: ffff880825590400 R08:
ffffc9000b397b50 R09: ffffc9000b397b58
Sep=C2=A0 1 16:19:30 phoenix kernel: R10: 0000000000000003 R11:
0000000000003000 R12: 0000000000000000
Sep=C2=A0 1 16:19:30 phoenix kernel: R13: 0000000000003db4 R14:
ffff88031455fd20 R15: ffff880826250348
Sep=C2=A0 1 16:19:30 phoenix kernel: FS:=C2=A0 00007f16f8e4e8c0(0000)
GS:ffff88042fa80000(0000) knlGS:0000000000000000
Sep=C2=A0 1 16:19:30 phoenix kernel: CS:=C2=A0 0010 DS: 0000 ES: 0000 CR0:
0000000080050033
Sep=C2=A0 1 16:19:30 phoenix kernel: CR2: 000056068cac8ec8 CR3:
0000000438a32000 CR4: 00000000000006e0
Sep=C2=A0 1 16:19:30 phoenix kernel: Call Trace:
Sep=C2=A0 1 16:19:30 phoenix kernel:=C2=A0 btrfs_remove_chunk+0x2f9/0x700 [=
btrfs]
Sep=C2=A0 1 16:19:30 phoenix kernel:=C2=A0 btrfs_relocate_chunk+0x9c/0xd0 [=
btrfs]
Sep=C2=A0 1 16:19:30 phoenix kernel:=C2=A0 btrfs_shrink_device+0x1c0/0x4f0 =
[btrfs]
Sep=C2=A0 1 16:19:30 phoenix kernel:=C2=A0 ?
btrfs_find_device_missing_or_by_path+0x30/0x120 [btrfs]
Sep=C2=A0 1 16:19:30 phoenix kernel:=C2=A0 btrfs_rm_device+0x19b/0x4f0 [btr=
fs]
Sep=C2=A0 1 16:19:30 phoenix kernel:=C2=A0 ? _copy_from_user+0x3f/0x80
Sep=C2=A0 1 16:19:30 phoenix kernel:=C2=A0 btrfs_ioctl+0x2129/0x2380 [btrfs=
]
Sep=C2=A0 1 16:19:30 phoenix kernel:=C2=A0 ? _copy_to_user+0x22/0x30
Sep=C2=A0 1 16:19:30 phoenix kernel:=C2=A0 ? cp_new_stat+0x138/0x150
Sep=C2=A0 1 16:19:30 phoenix kernel:=C2=A0 do_vfs_ioctl+0x9b/0x5e0
Sep=C2=A0 1 16:19:30 phoenix kernel:=C2=A0 ? SyS_newstat+0x35/0x40
Sep=C2=A0 1 16:19:30 phoenix kernel:=C2=A0 SyS_ioctl+0x47/0x90
Sep=C2=A0 1 16:19:30 phoenix kernel:=C2=A0 do_syscall_64+0x55/0x100
Sep=C2=A0 1 16:19:30 phoenix kernel:=C2=A0 entry_SYSCALL_64_after_hwframe+0=
x3d/0xa2
Sep=C2=A0 1 16:19:30 phoenix kernel: RIP: 0033:0x7f16f7be80f7
Sep=C2=A0 1 16:19:30 phoenix kernel: RSP: 002b:00007ffd701d26e8 EFLAGS:
00000206 ORIG_RAX: 0000000000000010
Sep=C2=A0 1 16:19:30 phoenix kernel: RAX: ffffffffffffffda RBX:
00007ffd701d4880 RCX: 00007f16f7be80f7
Sep=C2=A0 1 16:19:30 phoenix kernel: RDX: 00007ffd701d3720 RSI:
000000005000943a RDI: 0000000000000003
Sep=C2=A0 1 16:19:30 phoenix kernel: RBP: 00007ffd701d3720 R08:
0000000000000000 R09: 000000000000000c
Sep=C2=A0 1 16:19:30 phoenix kernel: R13: 0000000000000000 R14:
0000000000000003 R15: 00007ffd701d4888
Sep=C2=A0 1 16:19:30 phoenix kernel: Code: 4c 89 f7 45 31 c0 ba 10 00 00 00
4c 89 ee e8 9a 40 ff ff 4c 89 f7 e8 42 29 fd ff e9 de fe ff ff 41 bc f4
ff ff ff e9 db fe ff ff <0f> 0b eb b7 0f 1f 40 00 66 2e 0f 1f 84 00 00
00 00 00 53 31 d2
Sep=C2=A0 1 16:19:30 phoenix kernel: ---[ end trace edd626af3a502d95 ]---
Sep=C2=A0 1 16:19:30 phoenix kernel: ------------[ cut here ]------------
Sep=C2=A0 1 16:19:30 phoenix kernel: WARNING: CPU: 6 PID: 6401 at
fs/btrfs/ctree.h:1564 btrfs_update_device+0x1ae/0x1c0 [btrfs]
Sep=C2=A0 1 16:19:30 phoenix kernel: Modules linked in: nfnetlink_queue
nfnetlink_log nvidia_uvm(O) nvidia(PO) tun nfsd auth_rpcgss oid_registry
nfs_acl ipt_MASQUERADE nf_nat_masquerade_ipv4 nf_conntrack_netlink
nfnetlink xfrm_user xt_addrtype br_netfilter bridge stp llc
nf_conntrack_irc xt_CT xt_tcpudp xt_helper nf_conntrack_ftp nf_log_ipv4
nf_log_common ip6table_raw ip6table_mangle iptable_nat nf_conntrack_ipv4
nf_defrag_ipv4 nf_nat_ipv4 nf_nat xt_TCPMSS xt_LOG ipt_REJECT
nf_reject_ipv4 iptable_raw iptable_mangle xt_multiport xt_state xt_limit
xt_conntrack nf_conntrack ip6table_filter ip6_tables iptable_filter
ip_tables x_tables binfmt_misc snd_hda_codec_hdmi ata_generic kvm_amd
kvm snd_hda_intel irqbypass ftdi_sio snd_hda_codec usbserial
snd_hda_core pcspkr ipmi_si snd_pcm i2c_piix4 k10temp snd_timer
pata_acpi ohci_pci
Sep=C2=A0 1 16:19:30 phoenix kernel:=C2=A0 snd e1000e nvidiafb vgastate shp=
chp
evdev xts crypto_simd cryptd glue_helper aes_x86_64 ixgb ixgbe tulip
cxgb3 cxgb mdio bonding vxlan ip6_udp_tunnel udp_tunnel macvlan tg3
libphy sky2 r8169 pcnet32 mii igb ptp pps_core dca e1000 bnx2 msdos fat
fscrypto configfs overlay fuse nfs lockd grace sunrpc fscache btrfs
zstd_decompress zstd_compress xxhash zlib_deflate dm_thin_pool
dm_persistent_data dm_bio_prison hid_sunplus hid_sony hid_samsung hid_pl
hid_petalynx hid_logitech_dj hid_gyration sl811_hcd usbhid xhci_pci
xhci_hcd ohci_hcd uhci_hcd usb_storage ehci_pci ehci_hcd qla2xxx
megaraid_sas megaraid aacraid sx8 DAC960 3w_9xxx 3w_xxxx mptsas
scsi_transport_sas mptfc scsi_transport_fc mptspi mptscsih mptbase
atp870u dc395x qla1280 imm parport dmx3191d sym53c8xx gdth BusLogic
aic7xxx aic79xx
Sep=C2=A0 1 16:19:30 phoenix kernel:=C2=A0 scsi_transport_spi sr_mod cdrom =
sg
pdc_adma sata_inic162x sata_mv ata_piix ahci libahci sata_qstor sata_vsc
sata_uli sata_sis sata_sx4 sata_nv sata_via sata_svw sata_sil24 sata_sil
sata_promise pata_sl82c105 pata_via pata_jmicron pata_marvell pata_sis
pata_netcell pata_pdc202xx_old pata_triflex pata_atiixp pata_opti
pata_amd pata_ali pata_it8213 pata_ns87415 pata_ns87410 pata_serverworks
pata_cypress pata_oldpiix pata_artop pata_it821x pata_optidma
pata_hpt3x2n pata_hpt3x3 pata_hpt37x pata_hpt366 pata_cmd64x pata_efar
pata_rz1000 pata_sil680 pata_radisys pata_pdc2027x pata_mpiix [last
unloaded: nvidia]
Sep=C2=A0 1 16:19:30 phoenix kernel: CPU: 6 PID: 6401 Comm: btrfs Tainted:
P=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 W=C2=A0 O=C2=A0=C2=A0=C2=A0 4.1=
4.78-gentoo #1
Sep=C2=A0 1 16:19:30 phoenix kernel: Hardware name: System manufacturer
System Product Name/KGP(M)E-D16, BIOS 2202=C2=A0=C2=A0=C2=A0 03/29/2012
Sep=C2=A0 1 16:19:30 phoenix kernel: task: ffff880090b7c700 task.stack:
ffffc9000b394000
Sep=C2=A0 1 16:19:30 phoenix kernel: RIP:
0010:btrfs_update_device+0x1ae/0x1c0 [btrfs]
Sep=C2=A0 1 16:19:30 phoenix kernel: RSP: 0018:ffffc9000b397b98 EFLAGS: 000=
10206
Sep=C2=A0 1 16:19:30 phoenix kernel: RAX: 0000000000000fff RBX:
ffff88035d1b4690 RCX: 000002baa1371e00
Sep=C2=A0 1 16:19:30 phoenix kernel: RDX: 0000000000001000 RSI:
ffff880000000000 RDI: ffff880250a8a388
Sep=C2=A0 1 16:19:30 phoenix kernel: RBP: ffff880825886400 R08:
ffffc9000b397b50 R09: ffffc9000b397b58
Sep=C2=A0 1 16:19:30 phoenix kernel: R10: 0000000000000003 R11:
0000000000003000 R12: 0000000000000000
Sep=C2=A0 1 16:19:30 phoenix kernel: R13: 0000000000003f9e R14:
ffff880250a8a388 R15: ffff880826250348
Sep=C2=A0 1 16:19:30 phoenix kernel: FS:=C2=A0 00007f16f8e4e8c0(0000)
GS:ffff88042f800000(0000) knlGS:0000000000000000
Sep=C2=A0 1 16:19:30 phoenix kernel: CS:=C2=A0 0010 DS: 0000 ES: 0000 CR0:
0000000080050033
Sep=C2=A0 1 16:19:30 phoenix kernel: CR2: 00007f0c0564b180 CR3:
0000000438a32000 CR4: 00000000000006e0
Sep=C2=A0 1 16:19:30 phoenix kernel: Call Trace:
Sep=C2=A0 1 16:19:30 phoenix kernel:=C2=A0 btrfs_remove_chunk+0x2f9/0x700 [=
btrfs]
Sep=C2=A0 1 16:19:30 phoenix kernel:=C2=A0 btrfs_relocate_chunk+0x9c/0xd0 [=
btrfs]
Sep=C2=A0 1 16:19:30 phoenix kernel:=C2=A0 btrfs_shrink_device+0x1c0/0x4f0 =
[btrfs]
Sep=C2=A0 1 16:19:30 phoenix kernel:=C2=A0 ?
btrfs_find_device_missing_or_by_path+0x30/0x120 [btrfs]
Sep=C2=A0 1 16:19:30 phoenix kernel:=C2=A0 btrfs_rm_device+0x19b/0x4f0 [btr=
fs]
Sep=C2=A0 1 16:19:30 phoenix kernel:=C2=A0 ? _copy_from_user+0x3f/0x80
Sep=C2=A0 1 16:19:30 phoenix kernel:=C2=A0 btrfs_ioctl+0x2129/0x2380 [btrfs=
]
Sep=C2=A0 1 16:19:30 phoenix kernel:=C2=A0 ? _copy_to_user+0x22/0x30
Sep=C2=A0 1 16:19:30 phoenix kernel:=C2=A0 ? cp_new_stat+0x138/0x150
Sep=C2=A0 1 16:19:30 phoenix kernel:=C2=A0 do_vfs_ioctl+0x9b/0x5e0
Sep=C2=A0 1 16:19:30 phoenix kernel:=C2=A0 ? SyS_newstat+0x35/0x40
Sep=C2=A0 1 16:19:30 phoenix kernel:=C2=A0 SyS_ioctl+0x47/0x90
Sep=C2=A0 1 16:19:30 phoenix kernel:=C2=A0 do_syscall_64+0x55/0x100
Sep=C2=A0 1 16:19:30 phoenix kernel:=C2=A0 entry_SYSCALL_64_after_hwframe+0=
x3d/0xa2
Sep=C2=A0 1 16:19:30 phoenix kernel: RIP: 0033:0x7f16f7be80f7
Sep=C2=A0 1 16:19:30 phoenix kernel: RSP: 002b:00007ffd701d26e8 EFLAGS:
00000206 ORIG_RAX: 0000000000000010
Sep=C2=A0 1 16:19:30 phoenix kernel: RAX: ffffffffffffffda RBX:
00007ffd701d4880 RCX: 00007f16f7be80f7
Sep=C2=A0 1 16:19:30 phoenix kernel: RDX: 00007ffd701d3720 RSI:
000000005000943a RDI: 0000000000000003
Sep=C2=A0 1 16:19:30 phoenix kernel: RBP: 00007ffd701d3720 R08:
0000000000000000 R09: 000000000000000c
Sep=C2=A0 1 16:19:30 phoenix kernel: R10: 0000000000000572 R11:
0000000000000206 R12: 0000000000000000
Sep=C2=A0 1 16:19:30 phoenix kernel: R13: 0000000000000000 R14:
0000000000000003 R15: 00007ffd701d4888
Sep=C2=A0 1 16:19:30 phoenix kernel: Code: 4c 89 f7 45 31 c0 ba 10 00 00 00
4c 89 ee e8 9a 40 ff ff 4c 89 f7 e8 42 29 fd ff e9 de fe ff ff 41 bc f4
ff ff ff e9 db fe ff ff <0f> 0b eb b7 0f 1f 40 00 66 2e 0f 1f 84 00 00
00 00 00 53 31 d2
Sep=C2=A0 1 16:19:30 phoenix kernel: ---[ end trace edd626af3a502d96 ]---
Sep=C2=A0 1 16:19:30 phoenix kernel: ------------[ cut here ]------------
Sep=C2=A0 1 16:19:30 phoenix kernel: WARNING: CPU: 7 PID: 6401 at
fs/btrfs/ctree.h:1564 btrfs_update_device+0x1ae/0x1c0 [btrfs]
Sep=C2=A0 1 16:19:30 phoenix kernel: Modules linked in: nfnetlink_queue
nfnetlink_log nvidia_uvm(O) nvidia(PO) tun nfsd auth_rpcgss oid_registry
nfs_acl ipt_MASQUERADE nf_nat_masquerade_ipv4 nf_conntrack_netlink
nfnetlink xfrm_user xt_addrtype br_netfilter bridge stp llc
nf_conntrack_irc xt_CT xt_tcpudp xt_helper nf_conntrack_ftp nf_log_ipv4
nf_log_common ip6table_raw ip6table_mangle iptable_nat nf_conntrack_ipv4
nf_defrag_ipv4 nf_nat_ipv4 nf_nat xt_TCPMSS xt_LOG ipt_REJECT
nf_reject_ipv4 iptable_raw iptable_mangle xt_multiport xt_state xt_limit
xt_conntrack nf_conntrack ip6table_filter ip6_tables iptable_filter
ip_tables x_tables binfmt_misc snd_hda_codec_hdmi ata_generic kvm_amd
kvm snd_hda_intel irqbypass ftdi_sio snd_hda_codec usbserial
snd_hda_core pcspkr ipmi_si snd_pcm i2c_piix4 k10temp snd_timer
pata_acpi ohci_pci
Sep=C2=A0 1 16:19:30 phoenix kernel:=C2=A0 snd e1000e nvidiafb vgastate shp=
chp
evdev xts crypto_simd cryptd glue_helper aes_x86_64 ixgb ixgbe tulip
cxgb3 cxgb mdio bonding vxlan ip6_udp_tunnel udp_tunnel macvlan tg3
libphy sky2 r8169 pcnet32 mii igb ptp pps_core dca e1000 bnx2 msdos fat
fscrypto configfs overlay fuse nfs lockd grace sunrpc fscache btrfs
zstd_decompress zstd_compress xxhash zlib_deflate dm_thin_pool
dm_persistent_data dm_bio_prison hid_sunplus hid_sony hid_samsung hid_pl
hid_petalynx hid_logitech_dj hid_gyration sl811_hcd usbhid xhci_pci
xhci_hcd ohci_hcd uhci_hcd usb_storage ehci_pci ehci_hcd qla2xxx
megaraid_sas megaraid aacraid sx8 DAC960 3w_9xxx 3w_xxxx mptsas
scsi_transport_sas mptfc scsi_transport_fc mptspi mptscsih mptbase
atp870u dc395x qla1280 imm parport dmx3191d sym53c8xx gdth BusLogic
aic7xxx aic79xx
Sep=C2=A0 1 16:19:30 phoenix kernel:=C2=A0 scsi_transport_spi sr_mod cdrom =
sg
pdc_adma sata_inic162x sata_mv ata_piix ahci libahci sata_qstor sata_vsc
sata_uli sata_sis sata_sx4 sata_nv sata_via sata_svw sata_sil24 sata_sil
sata_promise pata_sl82c105 pata_via pata_jmicron pata_marvell pata_sis
pata_netcell pata_pdc202xx_old pata_triflex pata_atiixp pata_opti
pata_amd pata_ali pata_it8213 pata_ns87415 pata_ns87410 pata_serverworks
pata_cypress pata_oldpiix pata_artop pata_it821x pata_optidma
pata_hpt3x2n pata_hpt3x3 pata_hpt37x pata_hpt366 pata_cmd64x pata_efar
pata_rz1000 pata_sil680 pata_radisys pata_pdc2027x pata_mpiix [last
unloaded: nvidia]
Sep=C2=A0 1 16:19:30 phoenix kernel: CPU: 7 PID: 6401 Comm: btrfs Tainted:
P=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 W=C2=A0 O=C2=A0=C2=A0=C2=A0 4.1=
4.78-gentoo #1
Sep=C2=A0 1 16:19:30 phoenix kernel: Hardware name: System manufacturer
System Product Name/KGP(M)E-D16, BIOS 2202=C2=A0=C2=A0=C2=A0 03/29/2012
Sep=C2=A0 1 16:19:30 phoenix kernel: task: ffff880090b7c700 task.stack:
ffffc9000b394000
Sep=C2=A0 1 16:19:30 phoenix kernel: RIP:
0010:btrfs_update_device+0x1ae/0x1c0 [btrfs]
Sep=C2=A0 1 16:19:30 phoenix kernel: RSP: 0018:ffffc9000b397b98 EFLAGS: 000=
10206
Sep=C2=A0 1 16:19:30 phoenix kernel: RAX: 0000000000000fff RBX:
ffff88035d1b4690 RCX: 000002baa1371e00
Sep=C2=A0 1 16:19:30 phoenix kernel: RDX: 0000000000001000 RSI:
ffff880000000000 RDI: ffff88031455fd20
Sep=C2=A0 1 16:19:30 phoenix kernel: RBP: ffff880825881400 R08:
ffffc9000b397b50 R09: ffffc9000b397b58
Sep=C2=A0 1 16:19:30 phoenix kernel: R10: 0000000000000003 R11:
0000000000003000 R12: 0000000000000000
Sep=C2=A0 1 16:19:30 phoenix kernel: R13: 0000000000003c8e R14:
ffff88031455fd20 R15: ffff880826250348
Sep=C2=A0 1 16:19:30 phoenix kernel: FS:=C2=A0 00007f16f8e4e8c0(0000)
GS:ffff88042f880000(0000) knlGS:0000000000000000
Sep=C2=A0 1 16:19:30 phoenix kernel: CS:=C2=A0 0010 DS: 0000 ES: 0000 CR0:
0000000080050033
Sep=C2=A0 1 16:19:30 phoenix kernel: CR2: 00007f0bfd599394 CR3:
0000000438a32000 CR4: 00000000000006e0
Sep=C2=A0 1 16:19:30 phoenix kernel: Call Trace:
Sep=C2=A0 1 16:19:30 phoenix kernel:=C2=A0 btrfs_remove_chunk+0x2f9/0x700 [=
btrfs]
Sep=C2=A0 1 16:19:30 phoenix kernel:=C2=A0 btrfs_relocate_chunk+0x9c/0xd0 [=
btrfs]
Sep=C2=A0 1 16:19:30 phoenix kernel:=C2=A0 btrfs_shrink_device+0x1c0/0x4f0 =
[btrfs]
Sep=C2=A0 1 16:19:30 phoenix kernel:=C2=A0 ?
btrfs_find_device_missing_or_by_path+0x30/0x120 [btrfs]
Sep=C2=A0 1 16:19:30 phoenix kernel:=C2=A0 btrfs_rm_device+0x19b/0x4f0 [btr=
fs]
Sep=C2=A0 1 16:19:30 phoenix kernel:=C2=A0 ? _copy_from_user+0x3f/0x80
Sep=C2=A0 1 16:19:30 phoenix kernel:=C2=A0 btrfs_ioctl+0x2129/0x2380 [btrfs=
]
Sep=C2=A0 1 16:19:30 phoenix kernel:=C2=A0 ? _copy_to_user+0x22/0x30
Sep=C2=A0 1 16:19:30 phoenix kernel:=C2=A0 ? cp_new_stat+0x138/0x150
Sep=C2=A0 1 16:19:30 phoenix kernel:=C2=A0 do_vfs_ioctl+0x9b/0x5e0
Sep=C2=A0 1 16:19:30 phoenix kernel:=C2=A0 ? SyS_newstat+0x35/0x40
Sep=C2=A0 1 16:19:30 phoenix kernel:=C2=A0 SyS_ioctl+0x47/0x90
Sep=C2=A0 1 16:19:30 phoenix kernel:=C2=A0 do_syscall_64+0x55/0x100
Sep=C2=A0 1 16:19:30 phoenix kernel:=C2=A0 entry_SYSCALL_64_after_hwframe+0=
x3d/0xa2
Sep=C2=A0 1 16:19:30 phoenix kernel: RIP: 0033:0x7f16f7be80f7
Sep=C2=A0 1 16:19:30 phoenix kernel: RSP: 002b:00007ffd701d26e8 EFLAGS:
00000206 ORIG_RAX: 0000000000000010
Sep=C2=A0 1 16:19:30 phoenix kernel: RAX: ffffffffffffffda RBX:
00007ffd701d4880 RCX: 00007f16f7be80f7
Sep=C2=A0 1 16:19:30 phoenix kernel: RDX: 00007ffd701d3720 RSI:
000000005000943a RDI: 0000000000000003
Sep=C2=A0 1 16:19:30 phoenix kernel: RBP: 00007ffd701d3720 R08:
0000000000000000 R09: 000000000000000c
Sep=C2=A0 1 16:19:30 phoenix kernel: R10: 0000000000000572 R11:
0000000000000206 R12: 0000000000000000
Sep=C2=A0 1 16:19:30 phoenix kernel: R13: 0000000000000000 R14:
0000000000000003 R15: 00007ffd701d4888
Sep=C2=A0 1 16:19:30 phoenix kernel: Code: 4c 89 f7 45 31 c0 ba 10 00 00 00
4c 89 ee e8 9a 40 ff ff 4c 89 f7 e8 42 29 fd ff e9 de fe ff ff 41 bc f4
ff ff ff e9 db fe ff ff <0f> 0b eb b7 0f 1f 40 00 66 2e 0f 1f 84 00 00
00 00 00 53 31 d2
Sep=C2=A0 1 16:19:30 phoenix kernel: ---[ end trace edd626af3a502d97 ]---
Sep=C2=A0 1 16:19:30 phoenix kernel: ------------[ cut here ]------------
Sep=C2=A0 1 16:19:30 phoenix kernel: WARNING: CPU: 8 PID: 6401 at
fs/btrfs/ctree.h:1564 btrfs_update_device+0x1ae/0x1c0 [btrfs]
Sep=C2=A0 1 16:19:30 phoenix kernel: Modules linked in: nfnetlink_queue
nfnetlink_log nvidia_uvm(O) nvidia(PO) tun nfsd auth_rpcgss oid_registry
nfs_acl ipt_MASQUERADE nf_nat_masquerade_ipv4 nf_conntrack_netlink
nfnetlink xfrm_user xt_addrtype br_netfilter bridge stp llc
nf_conntrack_irc xt_CT xt_tcpudp xt_helper nf_conntrack_ftp nf_log_ipv4
nf_log_common ip6table_raw ip6table_mangle iptable_nat nf_conntrack_ipv4
nf_defrag_ipv4 nf_nat_ipv4 nf_nat xt_TCPMSS xt_LOG ipt_REJECT
nf_reject_ipv4 iptable_raw iptable_mangle xt_multiport xt_state xt_limit
xt_conntrack nf_conntrack ip6table_filter ip6_tables iptable_filter
ip_tables x_tables binfmt_misc snd_hda_codec_hdmi ata_generic kvm_amd
kvm snd_hda_intel irqbypass ftdi_sio snd_hda_codec usbserial
snd_hda_core pcspkr ipmi_si snd_pcm i2c_piix4 k10temp snd_timer
pata_acpi ohci_pci
Sep=C2=A0 1 16:19:30 phoenix kernel:=C2=A0 snd e1000e nvidiafb vgastate shp=
chp
evdev xts crypto_simd cryptd glue_helper aes_x86_64 ixgb ixgbe tulip
cxgb3 cxgb mdio bonding vxlan ip6_udp_tunnel udp_tunnel macvlan tg3
libphy sky2 r8169 pcnet32 mii igb ptp pps_core dca e1000 bnx2 msdos fat
fscrypto configfs overlay fuse nfs lockd grace sunrpc fscache btrfs
zstd_decompress zstd_compress xxhash zlib_deflate dm_thin_pool
dm_persistent_data dm_bio_prison hid_sunplus hid_sony hid_samsung hid_pl
hid_petalynx hid_logitech_dj hid_gyration sl811_hcd usbhid xhci_pci
xhci_hcd ohci_hcd uhci_hcd usb_storage ehci_pci ehci_hcd qla2xxx
megaraid_sas megaraid aacraid sx8 DAC960 3w_9xxx 3w_xxxx mptsas
scsi_transport_sas mptfc scsi_transport_fc mptspi mptscsih mptbase
atp870u dc395x qla1280 imm parport dmx3191d sym53c8xx gdth BusLogic
aic7xxx aic79xx
Sep=C2=A0 1 16:19:30 phoenix kernel:=C2=A0 scsi_transport_spi sr_mod cdrom =
sg
pdc_adma sata_inic162x sata_mv ata_piix ahci libahci sata_qstor sata_vsc
sata_uli sata_sis sata_sx4 sata_nv sata_via sata_svw sata_sil24 sata_sil
sata_promise pata_sl82c105 pata_via pata_jmicron pata_marvell pata_sis
pata_netcell pata_pdc202xx_old pata_triflex pata_atiixp pata_opti
pata_amd pata_ali pata_it8213 pata_ns87415 pata_ns87410 pata_serverworks
pata_cypress pata_oldpiix pata_artop pata_it821x pata_optidma
pata_hpt3x2n pata_hpt3x3 pata_hpt37x pata_hpt366 pata_cmd64x pata_efar
pata_rz1000 pata_sil680 pata_radisys pata_pdc2027x pata_mpiix [last
unloaded: nvidia]
Sep=C2=A0 1 16:19:30 phoenix kernel: CPU: 8 PID: 6401 Comm: btrfs Tainted:
P=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 W=C2=A0 O=C2=A0=C2=A0=C2=A0 4.1=
4.78-gentoo #1
Sep=C2=A0 1 16:19:30 phoenix kernel: Hardware name: System manufacturer
System Product Name/KGP(M)E-D16, BIOS 2202=C2=A0=C2=A0=C2=A0 03/29/2012
Sep=C2=A0 1 16:19:30 phoenix kernel: task: ffff880090b7c700 task.stack:
ffffc9000b394000
Sep=C2=A0 1 16:19:30 phoenix kernel: RIP:
0010:btrfs_update_device+0x1ae/0x1c0 [btrfs]
Sep=C2=A0 1 16:19:30 phoenix kernel: RSP: 0018:ffffc9000b397b98 EFLAGS: 000=
10206
Sep=C2=A0 1 16:19:30 phoenix kernel: RAX: 0000000000000fff RBX:
ffff88035d1b4690 RCX: 000002baa1371e00
Sep=C2=A0 1 16:19:30 phoenix kernel: RDX: 0000000000001000 RSI:
ffff880000000000 RDI: ffff88031455fd20
Sep=C2=A0 1 16:19:30 phoenix kernel: RBP: ffff88022bb44c00 R08:
ffffc9000b397b50 R09: ffffc9000b397b58
Sep=C2=A0 1 16:19:30 phoenix kernel: R10: 0000000000000003 R11:
0000000000003000 R12: 0000000000000000
Sep=C2=A0 1 16:19:30 phoenix kernel: R13: 0000000000003d52 R14:
ffff88031455fd20 R15: ffff880826250348
Sep=C2=A0 1 16:19:30 phoenix kernel: FS:=C2=A0 00007f16f8e4e8c0(0000)
GS:ffff88042f900000(0000) knlGS:0000000000000000
Sep=C2=A0 1 16:19:30 phoenix kernel: CS:=C2=A0 0010 DS: 0000 ES: 0000 CR0:
0000000080050033
Sep=C2=A0 1 16:19:30 phoenix kernel: CR2: 00007f5854176078 CR3:
0000000438a32000 CR4: 00000000000006e0
Sep=C2=A0 1 16:19:30 phoenix kernel: Call Trace:
Sep=C2=A0 1 16:19:30 phoenix kernel:=C2=A0 btrfs_remove_chunk+0x2f9/0x700 [=
btrfs]
Sep=C2=A0 1 16:19:30 phoenix kernel:=C2=A0 btrfs_relocate_chunk+0x9c/0xd0 [=
btrfs]
Sep=C2=A0 1 16:19:30 phoenix kernel:=C2=A0 btrfs_shrink_device+0x1c0/0x4f0 =
[btrfs]
Sep=C2=A0 1 16:19:30 phoenix kernel:=C2=A0 ?
btrfs_find_device_missing_or_by_path+0x30/0x120 [btrfs]
Sep=C2=A0 1 16:19:30 phoenix kernel:=C2=A0 btrfs_rm_device+0x19b/0x4f0 [btr=
fs]
Sep=C2=A0 1 16:19:30 phoenix kernel:=C2=A0 ? _copy_from_user+0x3f/0x80
Sep=C2=A0 1 16:19:30 phoenix kernel:=C2=A0 btrfs_ioctl+0x2129/0x2380 [btrfs=
]
Sep=C2=A0 1 16:19:30 phoenix kernel:=C2=A0 ? _copy_to_user+0x22/0x30
Sep=C2=A0 1 16:19:30 phoenix kernel:=C2=A0 ? cp_new_stat+0x138/0x150
Sep=C2=A0 1 16:19:30 phoenix kernel:=C2=A0 do_vfs_ioctl+0x9b/0x5e0
Sep=C2=A0 1 16:19:30 phoenix kernel:=C2=A0 ? SyS_newstat+0x35/0x40
Sep=C2=A0 1 16:19:30 phoenix kernel:=C2=A0 SyS_ioctl+0x47/0x90
Sep=C2=A0 1 16:19:30 phoenix kernel:=C2=A0 do_syscall_64+0x55/0x100
Sep=C2=A0 1 16:19:30 phoenix kernel:=C2=A0 entry_SYSCALL_64_after_hwframe+0=
x3d/0xa2
Sep=C2=A0 1 16:19:30 phoenix kernel: RIP: 0033:0x7f16f7be80f7
Sep=C2=A0 1 16:19:30 phoenix kernel: RSP: 002b:00007ffd701d26e8 EFLAGS:
00000206 ORIG_RAX: 0000000000000010
Sep=C2=A0 1 16:19:30 phoenix kernel: RAX: ffffffffffffffda RBX:
00007ffd701d4880 RCX: 00007f16f7be80f7
Sep=C2=A0 1 16:19:30 phoenix kernel: RDX: 00007ffd701d3720 RSI:
000000005000943a RDI: 0000000000000003
Sep=C2=A0 1 16:19:30 phoenix kernel: RBP: 00007ffd701d3720 R08:
0000000000000000 R09: 000000000000000c
Sep=C2=A0 1 16:19:30 phoenix kernel: R10: 0000000000000572 R11:
0000000000000206 R12: 0000000000000000
Sep=C2=A0 1 16:19:30 phoenix kernel: R13: 0000000000000000 R14:
0000000000000003 R15: 00007ffd701d4888
Sep=C2=A0 1 16:19:30 phoenix kernel: Code: 4c 89 f7 45 31 c0 ba 10 00 00 00
4c 89 ee e8 9a 40 ff ff 4c 89 f7 e8 42 29 fd ff e9 de fe ff ff 41 bc f4
ff ff ff e9 db fe ff ff <0f> 0b eb b7 0f 1f 40 00 66 2e 0f 1f 84 00 00
00 00 00 53 31 d2
Sep=C2=A0 1 16:19:30 phoenix kernel: ---[ end trace edd626af3a502d98 ]---
Sep=C2=A0 1 16:19:30 phoenix kernel: BTRFS info (device sdb1): relocating
block group 71262403559424 flags data|raid6

There are more of this sort with other blocks groups to be found in the log=
.

Also there are a few of these:
Sep=C2=A0 1 21:10:17 phoenix kernel: ata6.00: exception Emask 0x0 SAct
0x10000020 SErr 0x0 action 0x0
Sep=C2=A0 1 21:10:17 phoenix kernel: ata6.00: irq_stat 0x40000008
Sep=C2=A0 1 21:10:17 phoenix kernel: ata6.00: failed command: READ FPDMA QU=
EUED
Sep=C2=A0 1 21:10:17 phoenix kernel: ata6.00: cmd
60/20:28:80:66:09/00:00:50:01:00/40 tag 5 ncq dma 16384 in\x0a=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
res 41/40:00:88:66:09/00:00:50:01:00/40 Emask 0x409 (media error) <F>
Sep=C2=A0 1 21:10:17 phoenix kernel: ata6.00: status: { DRDY ERR }
Sep=C2=A0 1 21:10:17 phoenix kernel: ata6.00: error: { UNC }
Sep=C2=A0 1 21:10:17 phoenix kernel: ata6.00: configured for UDMA/133
Sep=C2=A0 1 21:10:17 phoenix kernel: sd 5:0:0:0: [sdf] tag#5 UNKNOWN(0x2003=
)
Result: hostbyte=3D0x00 driverbyte=3D0x08
Sep=C2=A0 1 21:10:17 phoenix kernel: sd 5:0:0:0: [sdf] tag#5 Sense Key : 0x=
3
[current]
Sep=C2=A0 1 21:10:17 phoenix kernel: sd 5:0:0:0: [sdf] tag#5 ASC=3D0x11 ASC=
Q=3D0x4
Sep=C2=A0 1 21:10:17 phoenix kernel: sd 5:0:0:0: [sdf] tag#5 CDB: opcode=3D=
0x88
88 00 00 00 00 01 50 09 66 80 00 00 00 20 00 00
Sep=C2=A0 1 21:10:17 phoenix kernel: print_req_error: I/O error, dev sdf,
sector 5637760640
Sep=C2=A0 1 21:10:17 phoenix kernel: BTRFS error (device sdb1): bdev
/dev/sdf1 errs: wr 0, rd 289, flush 0, corrupt 0, gen 0
Sep=C2=A0 1 21:10:17 phoenix kernel: ata6: EH complete
Sep=C2=A0 1 21:10:17 phoenix kernel: BTRFS warning (device sdb1): sdb1
checksum verify failed on 70943861833728 wanted 49137758 found 776101D6
level 0
Sep=C2=A0 1 21:10:17 phoenix kernel: BTRFS warning (device sdb1): sdb1
checksum verify failed on 70943861833728 wanted 49137758 found 776101D6
level 0
Sep=C2=A0 1 21:10:17 phoenix kernel: BTRFS warning (device sdb1): sdb1
checksum verify failed on 70943861833728 wanted 49137758 found 776101D6
level 0
Sep=C2=A0 1 21:10:17 phoenix kernel: BTRFS warning (device sdb1): sdb1
checksum verify failed on 70943861833728 wanted 49137758 found 776101D6
level 0
Sep=C2=A0 1 21:10:17 phoenix kernel: BTRFS warning (device sdb1): sdb1
checksum verify failed on 70943861833728 wanted 49137758 found 776101D6
level 0
Sep=C2=A0 1 21:10:17 phoenix kernel: BTRFS warning (device sdb1): sdb1
checksum verify failed on 70943861833728 wanted 49137758 found 776101D6
level 0
Sep=C2=A0 1 21:10:17 phoenix kernel: BTRFS warning (device sdb1): sdb1
checksum verify failed on 70943861833728 wanted 49137758 found 776101D6
level 0
Sep=C2=A0 1 21:10:17 phoenix kernel: BTRFS warning (device sdb1): sdb1
checksum verify failed on 70943861833728 wanted 49137758 found 776101D6
level 0
Sep=C2=A0 1 21:10:17 phoenix kernel: BTRFS warning (device sdb1): sdb1
checksum verify failed on 70943861833728 wanted 49137758 found 776101D6
level 0

So, yes /dev/sdf is also causing problems. I was going to replace that
one next. I still have the old /dev/sdb lying around BTW. It has not
completely failed yet, it's just not installed at the moment.

I am still looking for log entries related to the filesystem going
read-only. Not sure when exactly that happened and the logs are spammed
with plenty of the above...
>
>> Linux phoenix 4.14.78-gentoo #1 SMP Mon Dec 3 09:25:24 CET 2018 x86_64
> kernel 4.14.141 is the current version LTS for that series, and there
> are hundreds of bug fix insertions/removals between just those two
> versions
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/diff/?id=
=3Dv4.14.141&id2=3Dv4.14.78&dt=3D2
>
> between kernel 4.14.141 and 5.2.11, there are thousands of changes
> just in Btrfs... thousands
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/diff/?id=
=3Dv5.2.11&id2=3Dv4.14.141&dt=3D2
>
> And quite a few in raid56.c which isn't that big to begin with, but
> there are a lot of simplifications and improvements from what I can
> tell
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/diff/fs/=
btrfs/raid56.c?id=3Dv5.2.11&id2=3Dv4.14.141
>
> Anyway, it's worth a try to try and mount with 5.2.11 using '-o
> ro,degraded' and at least see if it will mount. But it gives you some
> idea why there's a strong bias toward using newer kernels. It's too
> hard to remember all the changes, even for developers.
The latest kernel version in the gentoo tree is 5.2.9. I am compiling
that now...

>
>
>> AMD Opteron(tm) Processor 6174 AuthenticAMD GNU/Linux
>>
>> *****
>> btrfs --version
>>
>> btrfs-progs v4.19
> This is OK, but the change log will show lots of bug fixes here too. I
> wouldn't make changes (no repair attempts at all, including chunk
> recover or --repair) until you get some dev advice about the next
> step.
I already tried --repair as well, but it would not do anything anyway in
the filesystem's current state.
>
>
>
>
>> [ 8904.358084] BTRFS info (device sda1): turning on discard
> Unexpected.
I had still that in fstab for some reason. Not sure why/when I added
that. These are not SSDs.
>
>> [ 8904.358088] BTRFS info (device sda1): allowing degraded mounts
>> [ 8904.358089] BTRFS info (device sda1): disk space caching is enabled
>> [ 8904.358091] BTRFS info (device sda1): has skinny extents
>> [ 8904.361743] BTRFS warning (device sda1): devid 8 uuid
>> 0e8b4aff-6d64-4d31-a135-705421928f94 is missing
>> [ 8905.705036] BTRFS info (device sda1): bdev (null) errs: wr 0, rd
>> 14809, flush 0, corrupt 4, gen 0
>> [ 8905.705041] BTRFS info (device sda1): bdev /dev/sda1 errs: wr 0, rd
>> 4, flush 0, corrupt 0, gen 0
>> [ 8905.705052] BTRFS info (device sda1): bdev /dev/sdf1 errs: wr 0, rd
>> 10543, flush 0, corrupt 0, gen 0
>> [ 8905.705062] BTRFS info (device sda1): bdev /dev/sdc1 errs: wr 0, rd
>> 8, flush 0, corrupt 0, gen 0
> four devices with read errors
>
> When was the last time the volume was scrubbed? Do you know for sure
> these errors have not gone up at all since the last successful scrub?
> And were any errors reported for that last scrub?
Oh, that must have been quite a while ago. Sometime in 2018? Maybe? All
these drives have been up and running for several years now. sda and sdc
should still be fine, the replaced drive is sdb and sdf is next in line.
>
>
>> I have tried all the mount / restore options listed here:
>> https://forums.unraid.net/topic/46802-faq-for-unraid-v6/page/2/?tab=3Dco=
mments#comment-543490
> Good. Stick with ro attempts for now. Including if you want to try a
> newer kernel. If it succeeds to mount ro, my advice is to update
> backups so at least critical information isn't lost. Back up while you
> can. Any repair attempt makes changes that will risk the data being
> permanently lost. So it's important to be really deliberate about any
> changes.
I'll let you know, when I have the new kernel up and running.
>
>
>> ... and all I keep getting is "bad tree block" errors. Superblocks seem
>> fine (btrfs rescue super-reecover found no problem). I am considering
>> trying "btrfs rescue chunk-recover" at this point.
>>
>> Could this help in my situation? What do you think?
> I'm not sure if chunk recover can work on degraded volumes. Your best
> bet is to not make any further changes to the volume itself.
>
> Preserve all logs.
>
ok




--=20
*Liland IT GmbH*


Ferlach =E2=97=8F Wien =E2=97=8F M=C3=BCnchen
Tel: +43 463 220111
Tel: +49 89=20
458 15 940
office@Liland.com
https://Liland.com <https://Liland.com>=C2=A0



Copyright =C2=A9 2019 Liland IT GmbH=C2=A0

Diese Mail enthaelt vertrauliche und/oder=20
rechtlich geschuetzte=C2=A0Informationen.=C2=A0
Wenn Sie nicht der richtige Adressat=20
sind oder diese Email irrtuemlich=C2=A0erhalten haben, informieren Sie bitt=
e=20
sofort den Absender und vernichten=C2=A0Sie diese Mail. Das unerlaubte Kopi=
eren=20
sowie die unbefugte Weitergabe=C2=A0dieser Mail ist nicht gestattet.=C2=A0

This=20
email may contain confidential and/or privileged information.=C2=A0
If you are=20
not the intended recipient (or have received this email in=C2=A0error) plea=
se=20
notify the sender immediately and destroy this email. Any=C2=A0unauthorised=
=20
copying, disclosure or distribution of the material in this=C2=A0email is=
=20
strictly forbidden.

