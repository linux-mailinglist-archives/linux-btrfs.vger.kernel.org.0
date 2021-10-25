Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7405A4391AF
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Oct 2021 10:46:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232153AbhJYIsk convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Mon, 25 Oct 2021 04:48:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231727AbhJYIsk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 25 Oct 2021 04:48:40 -0400
X-Greylist: delayed 400 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 25 Oct 2021 01:46:17 PDT
Received: from rx2.rx-server.de (rx2.rx-server.de [IPv6:2a03:4000:45:69b::100:10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8577C061745
        for <linux-btrfs@vger.kernel.org>; Mon, 25 Oct 2021 01:46:17 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by rx2.rx-server.de (Postfix) with ESMTP id 6468443FDE
        for <linux-btrfs@vger.kernel.org>; Mon, 25 Oct 2021 10:46:16 +0200 (CEST)
X-Spam-Flag: NO
X-Spam-Score: -2.401
X-Spam-Level: 
X-Spam-Status: No, score=-2.401 required=5 tests=[BAYES_00=-1.9,
        FROM_IS_REPLY_TO=-0.5, NO_DNS_FOR_FROM=0.001, NO_RECEIVED=-0.001,
        NO_RELAYS=-0.001] autolearn=ham autolearn_force=no
Received: from rx2.rx-server.de ([127.0.0.1])
        by localhost (rx2.rx-server.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id uapGCCfuRLdx for <linux-btrfs@vger.kernel.org>;
        Mon, 25 Oct 2021 10:46:16 +0200 (CEST)
X-Original-To: linux-btrfs@vger.kernel.org
From:   Mia <9speysdx24@kr33.de>
To:     linux-btrfs@vger.kernel.org
Subject: filesystem corrupt - error -117
Date:   Mon, 25 Oct 2021 08:46:14 +0000
Message-Id: <em33e101b0-d634-48b5-8a32-45e295f48f16@rx2.rx-server.de>
In-Reply-To: <em969af203-04e6-4eff-a115-1129ae853867@frystation>
References: <em969af203-04e6-4eff-a115-1129ae853867@frystation>
Reply-To: Mia <9speysdx24@kr33.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello,
I need support since my root filesystem just went readonly :(

[641955.981560] BTRFS error (device sda3): tree block 342685007872 owner 
7 already locked by pid=8099, extent tree corruption detected
[641955.983724] ------------[ cut here ]------------
[641955.983731] BTRFS: Transaction aborted (error -117)
[641955.984030] WARNING: CPU: 0 PID: 8099 at fs/btrfs/inode.c:3131 
btrfs_finish_ordered_io+0x6b4/0x7a0 [btrfs]
[641955.984031] Modules linked in: nfsv3 nfs_acl rpcsec_gss_krb5 
auth_rpcgss nfsv4 dns_resolver nfs lockd grace fscache dm_mod veth 
xfrm_user xfrm_algo br_netfilter ip6t_REJECT nf_reject_ipv6 ip6_tables 
nft_chain_route_ipv6 nft_chain_nat_ipv6 ip6t_MASQUERADE nf_nat_ipv6 
nf_log_ipv6 xt_recent ipt_REJECT nf_reject_ipv4 xt_multiport xt_comment 
xt_hashlimit xt_conntrack xt_addrtype xt_mark xt_nat 
nft_chain_route_ipv4 aufs(OE) xt_CT nft_counter nfnetlink_log xt_NFLOG 
nf_log_ipv4 nf_log_common xt_LOG nf_nat_tftp nf_nat_snmp_basic 
nf_conntrack_snmp nf_nat_sip nf_nat_pptp xt_CHECKSUM nf_nat_proto_gre 
nf_nat_irc ipt_MASQUERADE nf_nat_h323 nf_nat_ftp nf_nat_amanda ts_kmp 
nf_conntrack_amanda nf_conntrack_sane nf_conntrack_tftp xt_tcpudp 
nft_compat nf_conntrack_sip nf_conntrack_pptp nf_conntrack_proto_gre 
nf_conntrack_netlink
[641955.984048]  nf_conntrack_netbios_ns nf_conntrack_broadcast 
nf_conntrack_irc nf_conntrack_h323 nf_conntrack_ftp nft_chain_nat_ipv4 
nf_nat_ipv4 nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 
wireguard(E) ip6_udp_tunnel udp_tunnel nf_tables nfnetlink overlay 
bridge stp llc fuse ext4 crc16 mbcache jbd2 fscrypto ecb 
crct10dif_pclmul crc32_pclmul joydev ghash_clmulni_intel serio_raw 
virtio_balloon pcspkr sg virtio_console qemu_fw_cfg evdev sunrpc 
ip_tables x_tables autofs4 btrfs xor zstd_decompress zstd_compress 
xxhash raid6_pq libcrc32c crc32c_generic hid_generic usbhid hid sr_mod 
cdrom sd_mod ata_generic virtio_net net_failover virtio_scsi failover 
crc32c_intel bochs_drm ttm aesni_intel aes_x86_64 drm_kms_helper 
crypto_simd cryptd glue_helper ata_piix psmouse libata uhci_hcd drm 
ehci_hcd scsi_mod
[641955.984073]  usbcore virtio_pci i2c_piix4 virtio_ring floppy virtio 
usb_common button
[641955.984078] CPU: 0 PID: 8099 Comm: kworker/u8:1 Tainted: G           
OE     4.19.0-17-amd64 #1 Debian 4.19.194-3
[641955.984079] Hardware name: netcup KVM Server, BIOS RS 2000 G9 
06/01/2021
[641955.984096] Workqueue: btrfs-endio-write btrfs_endio_write_helper 
[btrfs]
[641955.984114] RIP: 0010:btrfs_finish_ordered_io+0x6b4/0x7a0 [btrfs]
[641955.984115] Code: 49 8b 44 24 50 f0 48 0f ba a8 00 17 00 00 02 72 1b 
41 83 fd fb 0f 84 82 94 07 00 44 89 ee 48 c7 c7 b8 c6 61 c0 e8 f5 8e 97 
e0 <0f> 0b 44 89 e9 ba 3b 0c 00 00 48 c7 c6 d0 01 61 c0 4c 89 e7 e8 19
[641955.984116] RSP: 0018:ffff97e883197dd0 EFLAGS: 00010286
[641955.984117] RAX: 0000000000000000 RBX: ffff8b19259ae0a0 RCX: 
0000000000000006
[641955.984117] RDX: 0000000000000007 RSI: 0000000000000086 RDI: 
ffff8b1c2fa166b0
[641955.984118] RBP: ffff8b19259ade80 R08: 0000000000000a78 R09: 
0000000000000004
[641955.984118] R10: 0000000000000000 R11: 0000000000000001 R12: 
ffff8b1c2bc7e548
[641955.984119] R13: 00000000ffffff8b R14: ffff8b1a3f0e1800 R15: 
ffff8b19358df520
[641955.984121] FS:  0000000000000000(0000) GS:ffff8b1c2fa00000(0000) 
knlGS:0000000000000000
[641955.984122] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[641955.984122] CR2: 00007f9c537966a8 CR3: 0000000427bcc000 CR4: 
0000000000340ef0
[641955.984124] Call Trace:
[641955.984180]  normal_work_helper+0xba/0x380 [btrfs]
[641955.984266]  process_one_work+0x1a7/0x3a0
[641955.984287]  worker_thread+0x30/0x390
[641955.984288]  ? create_worker+0x1a0/0x1a0
[641955.984290]  kthread+0x112/0x130
[641955.984302]  ? kthread_bind+0x30/0x30
[641955.984350]  ret_from_fork+0x22/0x40
[641955.984369] ---[ end trace cc28f56e39ff5127 ]---
[641955.984377] BTRFS: error (device sda3) in 
btrfs_finish_ordered_io:3131: errno=-117 unknown
[641955.986629] BTRFS info (device sda3): forced readonly
[641955.986738] BTRFS error (device sda3): pending csums is 4096


root@rx1 ~ # btrfs fi show
Label: none  uuid: 21306973-6bf3-4877-9543-633d472dcb46
     Total devices 1 FS bytes used 189.12GiB
     devid    1 size 319.00GiB used 199.08GiB path /dev/sda3

root@rx1 ~ # btrfs fi df /
Data, single: total=194.89GiB, used=187.46GiB
System, single: total=32.00MiB, used=48.00KiB
Metadata, single: total=4.16GiB, used=1.65GiB
GlobalReserve, single: total=380.45MiB, used=0.00B

root@rx1 ~ # btrfs --version                                             
                                                                          
                                                :(
btrfs-progs v4.20.1


root@rx1 ~ # uname -a
Linux rx1 4.19.0-17-amd64 #1 SMP Debian 4.19.194-3 (2021-07-18) x86_64 
GNU/Linux

Hope someone can help.
Regrads
Mia

