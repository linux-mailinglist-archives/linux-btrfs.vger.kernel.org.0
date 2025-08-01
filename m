Return-Path: <linux-btrfs+bounces-15792-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FD45B187DB
	for <lists+linux-btrfs@lfdr.de>; Fri,  1 Aug 2025 21:46:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC40A1C21B19
	for <lists+linux-btrfs@lfdr.de>; Fri,  1 Aug 2025 19:46:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ADBC1FC0F0;
	Fri,  1 Aug 2025 19:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c3JratLn"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D0D31E492D
	for <linux-btrfs@vger.kernel.org>; Fri,  1 Aug 2025 19:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754077592; cv=none; b=F3lXqG5UtVqr9+R7omwwu7MPIahIly2YjL4NsQPOLMh9Mucu58g1PNuG19odYEAbgt5dJgADMyFXTMmDkhb9qql4Qq7Vye3EIbYDAUMb/Bot1WXDAXNlgwb6FyTAuwtxE4NyfFTrIgaquozCj1veR9QMNkMjXdtTlWUYTWs4hvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754077592; c=relaxed/simple;
	bh=P9k9I6hRUJAqh1B5lJO1rJTw+YXNpz90u4yGpPRaNzE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i5wFlCKDSibfE0tHuSpnr6L/1WQzrRDqKjlrnxOt4EGg1Qr0ZAOtjmrWJYeI14rXIyv4XmSrGUlibKjunV4mQystag7tB3a3vH6hvLW7qxy6NSYe9vVjfUnUDOBsvBBUaZId0hbYIHMEZgPipfNQgVcmPEJTmwn56qkLJdEAbV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=c3JratLn; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754077589;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zBJk/wWP7q2brYyNhM8DMILvR2WABsM5sIWd7OhCrcc=;
	b=c3JratLnZduT/rj2KF8izqBHJNvDDDIZLpT0dat7RB/C68gKg9vRPIfrUUh/extgeCCGEO
	Uf0YjaLQbfVLAL5hXva7kCXIEw236H2LxyT8q+jygU1P54EccM+pJOOCrq/rCRQVpnmlKt
	FLiHfsGxCI4IbzRPCIe1XvzwRbezQmQ=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-590-WI3GgIHgMFeTgfJXxKZT-w-1; Fri, 01 Aug 2025 15:46:27 -0400
X-MC-Unique: WI3GgIHgMFeTgfJXxKZT-w-1
X-Mimecast-MFC-AGG-ID: WI3GgIHgMFeTgfJXxKZT-w_1754077587
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-31f3b65ce07so3555755a91.1
        for <linux-btrfs@vger.kernel.org>; Fri, 01 Aug 2025 12:46:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754077587; x=1754682387;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zBJk/wWP7q2brYyNhM8DMILvR2WABsM5sIWd7OhCrcc=;
        b=rp3lU9EjwMpHBc98fccTgwNRo9+bo7QpZERh3Gie03KlMvbJ3TcqWCPNV1PuQtKg0r
         Bncb2U5xbRaRIIFaRvu/b2Shgq/QSETRlULEam8jMM6MaRKpyy3BZIhvp97h7EHVMgI1
         OkxwSWf9uElSZ5Z53tROHDYfOUiIfpHe2mK9uCCmREY/gGdp9Aqz3V5pD4gKZzA9b8re
         OlkGBaLZKh5X1MfDar2qHlp47R12NtOZzxZqx5oBe7IXTJ3LU4dDlLLwM/ez3GFaGCVw
         6ihOdrjKqfxFBfJ6m8Ryy89Hn5tDVvm3BmolysxeRK0UbN07rJMeonglqvmpuYsy5SjN
         iGlQ==
X-Forwarded-Encrypted: i=1; AJvYcCWH74VFt5BibxbcWmsinY2xJ0epwUlyucbO5xryz/t+fl/8bJ1lGcERLXWyiqgEeBZVhlI2ZpTNUtreUQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxqB3Vc46qkzfsMNIK1TsAgQVfPVdCNdcJGFcSkpFrP/0A2/ahN
	GK+D4wyuHae0Yu+bGHwO3PRXu6RH+I4UaLvm0rDfJAWD7qBemWlUKu0GFodtWgw4w73mdOeX8t9
	rVcBg1uNOoQMBJ5qdi5QH5gh2IZ3bclwgeRvbp/OhAsNMrucS5lC5ji52MqiomV6D
X-Gm-Gg: ASbGncvxuoONyJVe+yY5JuJ2EWH7leqo+4vQlvC4aZcH882UmcX/2YbkaCOm3RNz81l
	zb580mQEtX7X2GHd1ObblaFRdFKnqmF7UQ7Cj8raeq7QAkVCHOTrRvSq68egboUI704nii0eZLM
	WIbR5xlN+CO+MT7Ogj9RalanNYZB9XxU8A0JZ8wym4rtKnY1tOr84FytKr3kmILMa+ewSmGAmnW
	uhVeqL5vcmXiY1/cgC+eCMe46f/6TIavCx3VAYJ/5aLPaSmXFffucIygwXPYjTr+j4AvXPF6IWF
	GOu+8uF8vsgh66IK9H1s/7IbQrQuhqbcK1NYo1+3D1jnqoQc3gSBJSzNXRhkeKnh+y1A/27Eoyc
	kG5Ka
X-Received: by 2002:a17:90b:5806:b0:311:c970:c9c0 with SMTP id 98e67ed59e1d1-3211628f2f5mr1070408a91.22.1754077586345;
        Fri, 01 Aug 2025 12:46:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGUoRGdH2fPQdyvCmIwOnZHhF964o5NqAusm60nOlUnIfb4no5WQI2iIqnj4BQatyglrLoWGA==
X-Received: by 2002:a17:90b:5806:b0:311:c970:c9c0 with SMTP id 98e67ed59e1d1-3211628f2f5mr1070374a91.22.1754077585713;
        Fri, 01 Aug 2025 12:46:25 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3207eca6feasm5393190a91.21.2025.08.01.12.46.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Aug 2025 12:46:25 -0700 (PDT)
Date: Sat, 2 Aug 2025 03:46:21 +0800
From: Zorro Lang <zlang@redhat.com>
To: fdmanana@kernel.org
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
	Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH] generic: test fsync of file with 0 links and extents
Message-ID: <20250801194621.7cy2stxo767pva2z@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <ab95518f5483a2e23e0f3cdf1bc67258c0e71918.1753902704.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <ab95518f5483a2e23e0f3cdf1bc67258c0e71918.1753902704.git.fdmanana@suse.com>

On Wed, Jul 30, 2025 at 08:21:41PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
>=20
> Create two files, the first one with some data, and then fsync both
> files. The first file is fsynced after removing its hardlink. After a
> power failure we expect the fs to be mountable and for only the second
> file to be present.
>=20
> This exercises an issue found in btrfs and fixed by the following patch:
>=20
>   btrfs: fix log tree replay failure due to file with 0 links and extents
>=20
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> ---

This test case looks good to me. And looks like I triggered the btrfs bug
(kernel crash) [1] with this case. If it's the expected test result, then

Reviewed-by: Zorro Lang <zlang@redhat.com>


[1]
[2375125.078932] run fstests generic/771 at 2025-08-02 03:26:24
[2375125.442949] BTRFS: device fsid 9a850dcc-f313-4c8b-96c0-bb82000e8b68 de=
vid 1 transid 8 /dev/mapper/flakey-test.771 (252:7) scanned by mount (12778=
3)
[2375125.456810] BTRFS info (device dm-7): first mount of filesystem 9a850d=
cc-f313-4c8b-96c0-bb82000e8b68
[2375125.466137] BTRFS info (device dm-7): using crc32c (crc32c-x86_64) che=
cksum algorithm
[2375125.474158] BTRFS info (device dm-7): using free-space-tree
[2375125.482034] BTRFS info (device dm-7): checking UUID tree
[2375125.531795] BTRFS info (device dm-7): last unmount of filesystem 9a850=
dcc-f313-4c8b-96c0-bb82000e8b68
[2375125.578357] BTRFS: device fsid 9a850dcc-f313-4c8b-96c0-bb82000e8b68 de=
vid 1 transid 8 /dev/mapper/flakey-test.771 (252:7) scanned by mount (12782=
7)
[2375125.592066] BTRFS info (device dm-7): first mount of filesystem 9a850d=
cc-f313-4c8b-96c0-bb82000e8b68
[2375125.601381] BTRFS info (device dm-7): using crc32c (crc32c-x86_64) che=
cksum algorithm
[2375125.609391] BTRFS info (device dm-7): using free-space-tree
[2375125.617546] BTRFS info (device dm-7): start tree-log replay
[2375125.623731] BUG: kernel NULL pointer dereference, address: 00000000000=
00219
[2375125.630868] #PF: supervisor read access in kernel mode
[2375125.636179] #PF: error_code(0x0000) - not-present page
[2375125.641491] PGD 11315c067 P4D 0=20
[2375125.644898] Oops: Oops: 0000 [#1] SMP NOPTI
[2375125.649259] CPU: 18 UID: 0 PID: 127827 Comm: mount Tainted: G S       =
          ------  ---  6.16.0-0.rc1.250613g27605c8c0f69.21.fc43.x86_64 #1 P=
REEMPT(lazy)=20
[2375125.663583] Tainted: [S]=3DCPU_OUT_OF_SPEC
[2375125.667682] Hardware name: Dell Inc. PowerEdge R750/0PJ80M, BIOS 1.5.4=
 12/17/2021
[2375125.675337] RIP: 0010:iput+0x20/0x230
[2375125.679174] Code: 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 0f 1f 44 0=
0 00 48 85 ff 0f 84 86 01 00 00 41 54 55 48 8d af 50 01 00 00 53 48 89 fb <=
f6> 87 91 00 00 00 01 74 3a e9 68 01 00 00 8b 53 48 8b 83 90 00 00
[2375125.698093] RSP: 0018:ff2f85c0e8abb7c0 EFLAGS: 00010206
[2375125.703494] RAX: 0000000000000000 RBX: 0000000000000188 RCX: 000000000=
00b6012
[2375125.710799] RDX: 0000000000000000 RSI: ffffffff95fc5070 RDI: 000000000=
0000188
[2375125.718107] RBP: 00000000000002d8 R08: 0000000000000000 R09: ffffffff9=
31aabd6
[2375125.725411] R10: ff153ec034a8f5b0 R11: ffbf667744d2a3c0 R12: ff2f85c0e=
8abb93f
[2375125.732719] R13: 0000000000000000 R14: ff153ec0ff155770 R15: 00000000f=
ffffffb
[2375125.740025] FS:  00007f0bec606840(0000) GS:ff153ecfa8cff000(0000) knlG=
S:0000000000000000
[2375125.748284] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[2375125.754201] CR2: 0000000000000219 CR3: 00000002076a7006 CR4: 000000000=
0773ef0
[2375125.761510] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 000000000=
0000000
[2375125.768814] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 000000000=
0000400
[2375125.776121] PKRU: 55555554
[2375125.779008] Call Trace:
[2375125.781631]  <TASK>
[2375125.783911]  replay_one_extent+0xba/0x740
[2375125.788098]  ? copy_extent_buffer+0x126/0x160
[2375125.792629]  ? btrfs_release_path+0x2b/0x1b0
[2375125.797075]  ? read_extent_buffer+0x102/0x140
[2375125.801609]  replay_one_buffer+0x2ee/0x500
[2375125.805883]  ? find_extent_buffer+0xab/0x110
[2375125.810326]  walk_up_log_tree+0xe8/0x320
[2375125.814429]  ? btrfs_root_node+0x2d/0x50
[2375125.818526]  ? walk_log_tree+0x2e/0x280
[2375125.822538]  walk_log_tree+0xc6/0x280
[2375125.826378]  btrfs_recover_log_trees+0x1cc/0x5a0
[2375125.831171]  ? __pfx_replay_one_buffer+0x10/0x10
[2375125.835964]  open_ctree+0x916/0xb9c
[2375125.839630]  btrfs_get_tree_super.cold+0xb/0xbf
[2375125.844336]  vfs_get_tree+0x26/0xd0
[2375125.848003]  fc_mount+0x12/0x50
[2375125.851320]  btrfs_get_tree_subvol+0x10d/0x210
[2375125.855941]  vfs_get_tree+0x26/0xd0
[2375125.859606]  vfs_cmd_create+0x57/0xd0
[2375125.863446]  __do_sys_fsconfig+0x4b6/0x650
[2375125.867718]  do_syscall_64+0x82/0x2c0
[2375125.871558]  ? __do_sys_getgid+0x27/0x30
[2375125.875657]  ? do_syscall_64+0x82/0x2c0
[2375125.879669]  ? __do_sys_newfstatat+0x4a/0x80
[2375125.884117]  ? from_kgid_munged+0x17/0x30
[2375125.888301]  ? __do_sys_getegid+0x27/0x30
[2375125.892487]  ? do_syscall_64+0x82/0x2c0
[2375125.896499]  ? do_syscall_64+0x82/0x2c0
[2375125.900511]  ? do_syscall_64+0x82/0x2c0
[2375125.904525]  ? __x64_sys_statx+0x9a/0xe0
[2375125.908626]  ? do_syscall_64+0x82/0x2c0
[2375125.912639]  ? clear_bhb_loop+0x50/0xa0
[2375125.916649]  ? clear_bhb_loop+0x50/0xa0
[2375125.920664]  ? clear_bhb_loop+0x50/0xa0
[2375125.924676]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[2375125.929902] RIP: 0033:0x7f0bec7e548e
[2375125.933673] Code: 73 01 c3 48 8b 0d 72 19 0f 00 f7 d8 64 89 01 48 83 c=
8 ff c3 0f 1f 84 00 00 00 00 00 f3 0f 1e fa 49 89 ca b8 af 01 00 00 0f 05 <=
48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 42 19 0f 00 f7 d8 64 89 01 48
[2375125.952591] RSP: 002b:00007fff5b55e518 EFLAGS: 00000246 ORIG_RAX: 0000=
0000000001af
[2375125.960329] RAX: ffffffffffffffda RBX: 00005593c5cb8420 RCX: 00007f0be=
c7e548e
[2375125.967637] RDX: 0000000000000000 RSI: 0000000000000006 RDI: 000000000=
0000003
[2375125.974943] RBP: 00007fff5b55e660 R08: 0000000000000000 R09: 000000000=
0000048
[2375125.982249] R10: 0000000000000000 R11: 0000000000000246 R12: 000000000=
0000000
[2375125.989554] R13: 00005593c5cb96f0 R14: 00007f0bec960b00 R15: 00005593c=
5cb97b8
[2375125.996860]  </TASK>
[2375125.999224] Modules linked in: dm_flakey xfs joydev rfkill nft_fib_ine=
t nft_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4 nf_rejec=
t_ipv6 nft_reject nft_ct nft_chain_nat nf_nat mlx5_ib nf_conntrack nf_defra=
g_ipv6 nf_defrag_ipv4 ib_uverbs macsec ib_core mlx5_fwctl nf_tables intel_r=
apl_msr intel_rapl_common intel_uncore_frequency intel_uncore_frequency_com=
mon i10nm_edac skx_edac_common nfit libnvdimm x86_pkg_temp_thermal intel_po=
werclamp coretemp kvm_intel mlx5_core kvm spi_nor dax_hmem cxl_acpi iTCO_wd=
t irqbypass ipmi_ssif cxl_port mtd intel_pmc_bxt rapl mlxfw iTCO_vendor_sup=
port cxl_core isst_if_mmio intel_cstate isst_if_mbox_pci psample mei_me int=
el_th_gth platform_profile dell_smbios fwctl tls i2c_i801 intel_th_pci spi_=
intel_pci tg3 mei einj dcdbas dell_wmi_descriptor wmi_bmof intel_uncore acp=
i_power_meter isst_if_common pci_hyperv_intf i2c_smbus spi_intel intel_th i=
ntel_pch_thermal intel_vsec ipmi_si acpi_ipmi ipmi_devintf ipmi_msghandler =
fuse loop nfnetlink zram lz4hc_compress lz4_compress
[2375125.999290]  polyval_clmulni ghash_clmulni_intel mgag200 sha512_ssse3 =
sha1_ssse3 megaraid_sas i2c_algo_bit wmi
[2375126.098659] CR2: 0000000000000219
[2375126.102153] ---[ end trace 0000000000000000 ]---
[2375126.342787] RIP: 0010:iput+0x20/0x230
[2375126.346628] Code: 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 0f 1f 44 0=
0 00 48 85 ff 0f 84 86 01 00 00 41 54 55 48 8d af 50 01 00 00 53 48 89 fb <=
f6> 87 91 00 00 00 01 74 3a e9 68 01 00 00 8b 53 48 8b 83 90 00 00
[2375126.365548] RSP: 0018:ff2f85c0e8abb7c0 EFLAGS: 00010206
[2375126.370949] RAX: 0000000000000000 RBX: 0000000000000188 RCX: 000000000=
00b6012
[2375126.378253] RDX: 0000000000000000 RSI: ffffffff95fc5070 RDI: 000000000=
0000188
[2375126.385560] RBP: 00000000000002d8 R08: 0000000000000000 R09: ffffffff9=
31aabd6
[2375126.392865] R10: ff153ec034a8f5b0 R11: ffbf667744d2a3c0 R12: ff2f85c0e=
8abb93f
[2375126.400171] R13: 0000000000000000 R14: ff153ec0ff155770 R15: 00000000f=
ffffffb
[2375126.407478] FS:  00007f0bec606840(0000) GS:ff153ecfa8cff000(0000) knlG=
S:0000000000000000
[2375126.415737] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[2375126.421657] CR2: 0000000000000219 CR3: 00000002076a7006 CR4: 000000000=
0773ef0
[2375126.428961] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 000000000=
0000000
[2375126.436268] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 000000000=
0000400
[2375126.443574] PKRU: 55555554
[2375126.446461] note: mount[127827] exited with irqs disabled
[2375866.234285] sysrq: Show Blocked State
[2375866.245781] task:btrfs-transacti state:D stack:0     pid:127842 tgid:1=
27842 ppid:2      task_flags:0x208040 flags:0x00004000
[2375866.257188] Call Trace:
[2375866.259830]  <TASK>
[2375866.262130]  __schedule+0x2f9/0x7b0
[2375866.265821]  schedule+0x27/0x80
[2375866.269154]  btrfs_commit_transaction+0x912/0xd30
[2375866.274058]  ? start_transaction+0x228/0x840
[2375866.278516]  ? __pfx_autoremove_wake_function+0x10/0x10
[2375866.283935]  transaction_kthread+0x157/0x1c0
[2375866.288395]  ? __pfx_transaction_kthread+0x10/0x10
[2375866.293378]  kthread+0xfc/0x240
[2375866.296713]  ? __pfx_kthread+0x10/0x10
[2375866.300653]  ret_from_fork+0x14f/0x180
[2375866.304590]  ? __pfx_kthread+0x10/0x10
[2375866.308526]  ret_from_fork_asm+0x1a/0x30
=2E..


>  .gitignore            |  1 +
>  src/Makefile          |  2 +-
>  src/unlink-fsync.c    | 45 ++++++++++++++++++++++++++++++++
>  tests/generic/771     | 60 +++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/771.out |  4 +++
>  5 files changed, 111 insertions(+), 1 deletion(-)
>  create mode 100644 src/unlink-fsync.c
>  create mode 100755 tests/generic/771
>  create mode 100644 tests/generic/771.out
>=20
> diff --git a/.gitignore b/.gitignore
> index 58dc2a63..6948fd60 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -210,6 +210,7 @@ tags
>  /src/fiemap-fault
>  /src/min_dio_alignment
>  /src/dio-writeback-race
> +/src/unlink-fsync
> =20
>  # Symlinked files
>  /tests/generic/035.out
> diff --git a/src/Makefile b/src/Makefile
> index 2cc1fb40..7080e348 100644
> --- a/src/Makefile
> +++ b/src/Makefile
> @@ -21,7 +21,7 @@ TARGETS =3D dirstress fill fill2 getpagesize holes lsta=
t64 \
>  	t_mmap_writev_overlap checkpoint_journal mmap-rw-fault allocstale \
>  	t_mmap_cow_memory_failure fake-dump-rootino dio-buf-fault rewinddir-tes=
t \
>  	readdir-while-renames dio-append-buf-fault dio-write-fsync-same-fd \
> -	dio-writeback-race
> +	dio-writeback-race unlink-fsync
> =20
>  LINUX_TARGETS =3D xfsctl bstat t_mtab getdevicesize preallo_rw_pattern_r=
eader \
>  	preallo_rw_pattern_writer ftrunc trunc fs_perms testx looptest \
> diff --git a/src/unlink-fsync.c b/src/unlink-fsync.c
> new file mode 100644
> index 00000000..ce008c6b
> --- /dev/null
> +++ b/src/unlink-fsync.c
> @@ -0,0 +1,45 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2025 SUSE Linux Products GmbH.  All Rights Reserved.
> + */
> +
> +/*
> + * Utility to open an existing file, unlink it while holding an open fd =
on it
> + * and then fsync the file before closing the fd.
> + */
> +
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <unistd.h>
> +#include <fcntl.h>
> +
> +int main(int argc, char *argv[])
> +{
> +	int fd;
> +	int ret;
> +
> +	if (argc !=3D 2) {
> +		fprintf(stderr, "Use: %s <file path>\n", argv[0]);
> +		return 1;
> +	}
> +
> +	fd =3D open(argv[1], O_WRONLY, 0666);
> +	if (fd =3D=3D -1) {
> +		perror("failed to open file");
> +		exit(1);
> +	}
> +
> +	ret =3D unlink(argv[1]);
> +	if (ret =3D=3D -1) {
> +		perror("unlink failed");
> +		exit(2);
> +	}
> +
> +	ret =3D fsync(fd);
> +	if (ret =3D=3D -1) {
> +		perror("fsync failed");
> +		exit(3);
> +	}
> +
> +	return 0;
> +}
> diff --git a/tests/generic/771 b/tests/generic/771
> new file mode 100755
> index 00000000..ad30cc0a
> --- /dev/null
> +++ b/tests/generic/771
> @@ -0,0 +1,60 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2025 SUSE Linux Products GmbH.  All Rights Reserved.
> +#
> +# FS QA Test 771
> +#
> +# Create two files, the first one with some data, and then fsync both fi=
les.
> +# The first file is fsynced after removing its hardlink. After a power f=
ailure
> +# we expect the fs to be mountable and for only the second file to be pr=
esent.
> +#
> +. ./common/preamble
> +_begin_fstest auto quick log
> +
> +_cleanup()
> +{
> +	_cleanup_flakey
> +	cd /
> +	rm -r -f $tmp.*
> +}
> +
> +. ./common/filter
> +. ./common/dmflakey
> +
> +_require_scratch
> +_require_test_program unlink-fsync
> +_require_dm_target flakey
> +
> +[ "$FSTYP" =3D "btrfs" ] && _fixed_by_kernel_commit xxxxxxxxxxxx \
> +	"btrfs: fix log tree replay failure due to file with 0 links and extent=
s"
> +
> +_scratch_mkfs >> $seqres.full 2>&1 || _fail "mkfs failed"
> +_require_metadata_journaling $SCRATCH_DEV
> +_init_flakey
> +_mount_flakey
> +
> +# Create our first test file with some data.
> +mkdir $SCRATCH_MNT/testdir
> +$XFS_IO_PROG -f -c "pwrite 0K 64K" $SCRATCH_MNT/testdir/foo | _filter_xf=
s_io
> +
> +# fsync our first test file after unlinking it - we keep an fd open for =
the
> +# file, unlink it and then fsync the file using that fd, so that we log/=
journal
> +# a file with 0 hard links.
> +$here/src/unlink-fsync $SCRATCH_MNT/testdir/foo
> +
> +# Create another test file and fsync it.
> +touch $SCRATCH_MNT/testdir/bar
> +$XFS_IO_PROG -c "fsync" $SCRATCH_MNT/testdir/bar
> +
> +# Simulate a power failure and replay the log/journal.
> +# On btrfs we had a bug where the replay procedure failed, causing the f=
s mount
> +# to fail, because the first test file has extents and the second one, w=
hich has
> +# an higher inode number, has a non-zero (1) link count - the replay cod=
e got
> +# confused and thought the extents belonged to the second file and then =
it
> +# failed when trying to open a non-existing inode to replay the extents.
> +_flakey_drop_and_remount
> +
> +# File foo should not exist and file bar should exist.
> +ls -1 $SCRATCH_MNT/testdir
> +
> +_exit 0
> diff --git a/tests/generic/771.out b/tests/generic/771.out
> new file mode 100644
> index 00000000..e40d7091
> --- /dev/null
> +++ b/tests/generic/771.out
> @@ -0,0 +1,4 @@
> +QA output created by 771
> +wrote 65536/65536 bytes at offset 0
> +XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +bar
> --=20
> 2.47.2
>=20
>=20


