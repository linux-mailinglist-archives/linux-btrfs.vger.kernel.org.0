Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C3092A2993
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Nov 2020 12:32:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728537AbgKBLcV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 2 Nov 2020 06:32:21 -0500
Received: from mo4-p00-ob.smtp.rzone.de ([85.215.255.20]:31971 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728288AbgKBLcV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 2 Nov 2020 06:32:21 -0500
X-Greylist: delayed 723 seconds by postgrey-1.27 at vger.kernel.org; Mon, 02 Nov 2020 06:32:18 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1604316737;
        s=strato-dkim-0002; d=schmidt-vach.de;
        h=Date:Message-ID:Subject:From:To:X-RZG-CLASS-ID:X-RZG-AUTH:From:
        Subject:Sender;
        bh=faA52agqLCqRiNG+fN0HTwrei/w9zDP1gEcwAUvNUQY=;
        b=FmvKDiMQ2Yza9Gn7sZjbc1IPfqaj9YooGLJmHlvCvfV9vt1NgX3YcxB0HdZo2lPGNm
        hUJOVI/c0fN2f/0h2kVmjjjcVAgKjw15U13ZD14BG9CTrTidjHQP0VyyR17iWiGBD53Z
        h0kYeqcEWoiqNt0Fx+tw1eVajTnCZ56b1yUNO6+BJtfnpYmfxw5m9ihJ4UcMLSwVZje4
        3buUNABlterXM6pmUuNd2iwClhbWBXao/NbzA7DNs4J+7khQJK29Qmeo/e69JlJ21Fsa
        dp7pylRNYsZvy/wssE7KtQyYqoVpnSyFaH6+W3XSlBQYsi6joZFuPSROXnxKMJD65QBR
        0m3A==
X-RZG-AUTH: ":L2QWfFO8cv5iX0TTKLPqtaFoDurlTeEw+AuF6GGvwDaT3+Tt3P/srPzkuRlzM4xq9oAbh18mcNkplog9o8AMuVtzsTaNOEssi4eLYh8OSN1kJ7HUiA=="
X-RZG-CLASS-ID: mo00
Received: from [IPv6:2001:16b8:3f21:1b00:3076:2184:e50e:f42e]
        by smtp.strato.de (RZmta 47.3.0 AUTH)
        with ESMTPSA id q0a5ebwA2BKEEV4
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate)
        for <linux-btrfs@vger.kernel.org>;
        Mon, 2 Nov 2020 12:20:14 +0100 (CET)
To:     linux-btrfs@vger.kernel.org
From:   Christian <btrfs@schmidt-vach.de>
Subject: damaged filesystem - how to continue
Message-ID: <d59bc5b1-a90f-fca9-f9d0-554a4d03ee03@schmidt-vach.de>
Date:   Mon, 2 Nov 2020 12:20:13 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello,
how can I bring my filesystem into a healthy state again?

I have all details so far collected on

https://superuser.com/questions/1597946/btrfs-damaged-filesystem-how-to-continue

# uname -a ; btrfs --version ; btrfs fi show ; dmesg | grep -i btrfs
Linux openmediavault.local 5.8.0-0.bpo.2-amd64 #1 SMP Debian 
5.8.10-1~bpo10+1 (2020-09-26) x86_64 GNU/Linux
btrfs-progs v4.20.1
Label: none  uuid: dc7ca9ad-6af0-47e9-9c3a-860127d2c362
         Total devices 5 FS bytes used 17.24TiB
         devid    1 size 7.28TiB used 7.15TiB path /dev/sdf
         devid    2 size 7.28TiB used 7.17TiB path /dev/sdg
         devid    3 size 7.28TiB used 7.16TiB path /dev/sdd
         devid    4 size 7.28TiB used 7.16TiB path /dev/sde
         devid    5 size 7.28TiB used 7.17TiB path /dev/sdc

[    3.750273] Btrfs loaded, crc32c=crc32c-generic
[    3.938726] BTRFS: device fsid dc7ca9ad-6af0-47e9-9c3a-860127d2c362 
devid 5 transid 899698 /dev/sdc scanned by btrfs (230)
[    3.938869] BTRFS: device fsid dc7ca9ad-6af0-47e9-9c3a-860127d2c362 
devid 3 transid 899698 /dev/sdd scanned by btrfs (230)
[    3.939023] BTRFS: device fsid dc7ca9ad-6af0-47e9-9c3a-860127d2c362 
devid 4 transid 899698 /dev/sde scanned by btrfs (230)
[    3.939171] BTRFS: device fsid dc7ca9ad-6af0-47e9-9c3a-860127d2c362 
devid 1 transid 899698 /dev/sdf scanned by btrfs (230)
[    3.939324] BTRFS: device fsid dc7ca9ad-6af0-47e9-9c3a-860127d2c362 
devid 2 transid 899698 /dev/sdg scanned by btrfs (230)
[   12.944790] BTRFS info (device sdf): force zstd compression, level 3
[   12.944794] BTRFS info (device sdf): disk space caching is enabled
[   12.944796] BTRFS info (device sdf): has skinny extents
[   15.830946] BTRFS info (device sdf): bdev /dev/sdf errs: wr 0, rd 2, 
flush 0, corrupt 0, gen 0
[   15.830954] BTRFS info (device sdf): bdev /dev/sde errs: wr 0, rd 5, 
flush 0, corrupt 0, gen 0
[   64.976120] BTRFS info (device sdf): checking UUID tree
[  101.407155] WARNING: CPU: 3 PID: 1377 at fs/btrfs/extent-tree.c:3060 
__btrfs_free_extent.isra.51+0x681/0x980 [btrfs]
[  101.407156] Modules linked in: softdog xt_nat xt_tcpudp veth 
xt_conntrack xt_MASQUERADE nf_conntrack_netlink xfrm_user xfrm_algo 
nft_counter xt_addrtype nft_compat nft_chain_nat nf_nat nf_conntrack 
nf_defrag_ipv6 nf_defrag_ipv4 br_netfilter bridge stp llc nf_tables 
nfnetlink cpufreq_userspace cpufreq_conservative cpufreq_powersave 
overlay zram zsmalloc radeon ttm drm_kms_helper iTCO_wdt intel_pmc_bxt 
cec iTCO_vendor_support drm watchdog i2c_algo_bit at24 kvm_intel sg 
rng_core i3000_edac kvm irqbypass pcspkr serio_raw evdev button 
acpi_cpufreq nfsd auth_rpcgss w83793 w83627hf nfs_acl lockd hwmon_vid 
coretemp grace sunrpc ip_tables x_tables autofs4 ext4 crc16 mbcache jbd2 
btrfs blake2b_generic zstd_decompress zstd_compress raid10 raid456 
async_raid6_recov async_memcpy async_pq async_xor async_tx xor raid6_pq 
libcrc32c crc32c_generic raid1 raid0 multipath linear md_mod sd_mod 
t10_pi crc_t10dif crct10dif_generic sr_mod cdrom ata_generic 
crct10dif_common ehci_pci uhci_hcd ahci libahci ehci_hcd
[  101.407222] CPU: 3 PID: 1377 Comm: btrfs-transacti Not tainted 
5.8.0-0.bpo.2-amd64 #1 Debian 5.8.10-1~bpo10+1
[  101.407254] RIP: 0010:__btrfs_free_extent.isra.51+0x681/0x980 [btrfs]
[  101.407322]  ? btrfs_merge_delayed_refs+0x356/0x3c0 [btrfs]
[  101.407352]  __btrfs_run_delayed_refs+0x6ac/0x1000 [btrfs]
[  101.407394]  ? btrfs_create_pending_block_groups+0x147/0x240 [btrfs]
[  101.407425]  btrfs_run_delayed_refs+0x64/0x1f0 [btrfs]
[  101.407464]  btrfs_write_dirty_block_groups+0x18d/0x3d0 [btrfs]
[  101.407495]  ? btrfs_run_delayed_refs+0x90/0x1f0 [btrfs]
[  101.407529]  commit_cowonly_roots+0x232/0x2f0 [btrfs]
[  101.407564]  btrfs_commit_transaction+0x4ef/0xa60 [btrfs]
[  101.407600]  ? start_transaction+0xd5/0x540 [btrfs]
[  101.407633]  transaction_kthread+0x144/0x170 [btrfs]
[  101.407667]  ? btrfs_cleanup_transaction+0x590/0x590 [btrfs]
[  101.407687] BTRFS info (device sdf): leaf 36126720 gen 899699 total 
ptrs 243 free space 1262 owner 2
[  101.408999] BTRFS error (device sdf): unable to find ref byte nr 
1407768248320 parent 0 root 2  owner 0 offset 0
[  101.409319] BTRFS: Transaction aborted (error -2)
[  101.409368] WARNING: CPU: 3 PID: 1377 at fs/btrfs/extent-tree.c:3066 
__btrfs_free_extent.isra.51+0x6dd/0x980 [btrfs]
[  101.409369] Modules linked in: softdog xt_nat xt_tcpudp veth 
xt_conntrack xt_MASQUERADE nf_conntrack_netlink xfrm_user xfrm_algo 
nft_counter xt_addrtype nft_compat nft_chain_nat nf_nat nf_conntrack 
nf_defrag_ipv6 nf_defrag_ipv4 br_netfilter bridge stp llc nf_tables 
nfnetlink cpufreq_userspace cpufreq_conservative cpufreq_powersave 
overlay zram zsmalloc radeon ttm drm_kms_helper iTCO_wdt intel_pmc_bxt 
cec iTCO_vendor_support drm watchdog i2c_algo_bit at24 kvm_intel sg 
rng_core i3000_edac kvm irqbypass pcspkr serio_raw evdev button 
acpi_cpufreq nfsd auth_rpcgss w83793 w83627hf nfs_acl lockd hwmon_vid 
coretemp grace sunrpc ip_tables x_tables autofs4 ext4 crc16 mbcache jbd2 
btrfs blake2b_generic zstd_decompress zstd_compress raid10 raid456 
async_raid6_recov async_memcpy async_pq async_xor async_tx xor raid6_pq 
libcrc32c crc32c_generic raid1 raid0 multipath linear md_mod sd_mod 
t10_pi crc_t10dif crct10dif_generic sr_mod cdrom ata_generic 
crct10dif_common ehci_pci uhci_hcd ahci libahci ehci_hcd
[  101.409420] CPU: 3 PID: 1377 Comm: btrfs-transacti Tainted: G 
W         5.8.0-0.bpo.2-amd64 #1 Debian 5.8.10-1~bpo10+1
[  101.409451] RIP: 0010:__btrfs_free_extent.isra.51+0x6dd/0x980 [btrfs]
[  101.409513]  ? btrfs_merge_delayed_refs+0x356/0x3c0 [btrfs]
[  101.409543]  __btrfs_run_delayed_refs+0x6ac/0x1000 [btrfs]
[  101.409583]  ? btrfs_create_pending_block_groups+0x147/0x240 [btrfs]
[  101.409613]  btrfs_run_delayed_refs+0x64/0x1f0 [btrfs]
[  101.409653]  btrfs_write_dirty_block_groups+0x18d/0x3d0 [btrfs]
[  101.409683]  ? btrfs_run_delayed_refs+0x90/0x1f0 [btrfs]
[  101.409717]  commit_cowonly_roots+0x232/0x2f0 [btrfs]
[  101.409752]  btrfs_commit_transaction+0x4ef/0xa60 [btrfs]
[  101.409786]  ? start_transaction+0xd5/0x540 [btrfs]
[  101.409820]  transaction_kthread+0x144/0x170 [btrfs]
[  101.409854]  ? btrfs_cleanup_transaction+0x590/0x590 [btrfs]
[  101.409869] BTRFS: error (device sdf) in __btrfs_free_extent:3066: 
errno=-2 No such entry
[  101.410110] BTRFS info (device sdf): forced readonly
[  101.410113] BTRFS: error (device sdf) in btrfs_run_delayed_refs:2173: 
errno=-2 No such entry
[  101.410407] BTRFS warning (device sdf): Skipping commit of aborted 
transaction.
[  101.410414] BTRFS: error (device sdf) in cleanup_transaction:1898: 
errno=-2 No such entry
