Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25FF549D4B8
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Jan 2022 22:50:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232779AbiAZVun (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 26 Jan 2022 16:50:43 -0500
Received: from wout1-smtp.messagingengine.com ([64.147.123.24]:45987 "EHLO
        wout1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232775AbiAZVum (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 26 Jan 2022 16:50:42 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 706DA320229A;
        Wed, 26 Jan 2022 16:50:41 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Wed, 26 Jan 2022 16:50:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
        :content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; bh=HhEU9W8pq1Tlma
        IaRfVePGFJcB6jr81d+EX0LOl9Tj0=; b=NlSlAbgTR3KG6ILhSmCAAsWlHBLk6X
        kpAE/qMjth2Xxue3O+/D9vetrozvIfHFevIXjETrv8SxanVgviXK/ikrWWqf2QvL
        h28AxjJej5MW+3dk5a2FjLr6SeEzSWkE/qtmRtdMdO3et9iU4NWI+oE/mMyRmyd2
        lJkPvoNtjADvHqEfhYSGXOMLG7D05qMAmruV7rdtCvCpoUZqb6StYGlh0P4trORq
        NFqArob614+qevoC8fF3l/5Tg/tvgn4fw6EF/0v5Y6BuPlLhdq14Chvj6R5NFLJf
        XHYLtb2Qj+0hmGDT2792E4ihl98MMfc/2nx2PEtPo3Izu+abIgRYlCsA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; bh=HhEU9W8pq1TlmaIaRfVePGFJcB6jr81d+EX0LOl9T
        j0=; b=WvJ2HzcHzwDY+DYdEesKajo81OtqwsTVmknR8Zqjb8jpc71N+Inqu0XwH
        Ev6+6CxWVN74KYeuglqfwLFwYEckVIAaPJLDfAqijQKhvcoFs/RGlTiXvxCC5Aj/
        CFR+GUEiAmfHysbnySzm7NnfUYpTDOOGqpiBZd9gNKAwxmBXrN7oVF1+gWVZ7cJI
        /U9lAwIJMLTaYZkyh46lqpq3XhW99KFG0S2ky71F6T4MZlviOeRZBe52LjbEwqVP
        zyejeE/BDWv5ZHu7438AfkZHKAGgSB1aywF7pM6fFRX1qCEP4ebdYv/UjxR6OLF9
        R5N2031LH4Vm33jDhme+drSEpDeqw==
X-ME-Sender: <xms:MMLxYYt-1dVMKciexSc5_bC35l9IRxPBQ1BuritmqdDsbnjQMes9dw>
    <xme:MMLxYVffsVXtg3Gf3n0nrQdZrFdRZlEfaJWHQhRPTO_Z0ryZr7JVX3RsDG8qBrbf7
    aHQ_h4Kyy-IKDuFlek>
X-ME-Received: <xmr:MMLxYTya-Jh5jq1Ga4MG-wlevasjAhmQ0NGzBG16zsPz-jokaq8dO8POLFC1kbwnfKfUDr9z5fLBGP6MF7fHH0UMFovLFw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrfedugdduhedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggugfgjsehtke
    ertddttdejnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhr
    rdhioheqnecuggftrfgrthhtvghrnhepgfejgeffffefvefgtedvgeegledvtdfhfeekue
    fgtefghfeggfekgedugeetueevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
    pehmrghilhhfrhhomhepsghorhhishessghurhdrihho
X-ME-Proxy: <xmx:MMLxYbP_nvgrGEogZJXVgrZTmevbaxdAsRpPW6lGpKHfgsAH8yMcow>
    <xmx:MMLxYY91teQzSyLAvAfsEalMKjG_5nl3r0fs2DVu-03ahRj1-AEW1w>
    <xmx:MMLxYTUknEt_rZHJqpT9g9utcTCNMDVN9sDzIbXC_oQc1UJZiK2-iA>
    <xmx:McLxYdFC0NZU7Rw3XTfe6Zzj_MaA_Ju544auYRMxKDzYLmrbqoiqkw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 26 Jan 2022 16:50:40 -0500 (EST)
Date:   Wed, 26 Jan 2022 13:50:38 -0800
From:   Boris Burkov <boris@bur.io>
To:     "Apostolos B." <barz621@gmail.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: No space left errors on shutdown with systemd-homed /home dir
Message-ID: <YfHCLhpkS+t8a8CG@zen>
References: <9bdd0eb6-4a4f-e168-0fb0-77f4d753ec19@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9bdd0eb6-4a4f-e168-0fb0-77f4d753ec19@gmail.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jan 25, 2022 at 07:46:51PM +0200, Apostolos B. wrote:
> Hello.
> 
> When i shut down my pc i get No space left errors -even though i have plenty
> of space in both / and home dirs- and this message on the journal:

How did you conclude you have plenty of space? df can be misleading with
btrfs, for example. Can you please post the output of
'btrfs filesystem usage /home'

Thanks,
Boris

> 
> Ιαν 25 14:34:31 mainland kernel: BTRFS info (device dm-0): relocating block
> group 2177892352 flags data
> Ιαν 25 14:34:31 mainland kernel: BTRFS info (device dm-0): relocating block
> group 1104150528 flags data
> Ιαν 25 14:34:32 mainland kernel: BTRFS info (device dm-0): relocating block
> group 30408704 flags metadata|dup
> Ιαν 25 14:34:32 mainland kernel: ------------[ cut here ]------------
> Ιαν 25 14:34:32 mainland kernel: BTRFS: Transaction aborted (error -28)
> Ιαν 25 14:34:32 mainland kernel: WARNING: CPU: 4 PID: 18307 at
> fs/btrfs/extent-tree.c:3066 __btrfs_free_extent+0x59c/0x950 [btrfs]
> Ιαν 25 14:34:32 mainland kernel: Modules linked in: uhid rfcomm
> snd_seq_dummy snd_hrtimer snd_seq snd_seq_device i2c_dev dm_crypt cbc
> encrypted_keys trusted asn1_e>
> Ιαν 25 14:34:32 mainland kernel:  snd_pcm_dmaengine kvm snd_hda_intel
> iTCO_wdt irqbypass snd_intel_dspcfg intel_pmc_bxt crct10dif_pclmul
> snd_intel_sdw_acpi hid_mul>
> Ιαν 25 14:34:32 mainland kernel:  int340x_thermal_zone tpm_tis tpm_tis_core
> wmi int3400_thermal tpm mac_hid rng_core acpi_thermal_rel acpi_tad acpi_pad
> ipmi_devint>
> Ιαν 25 14:34:32 mainland kernel: CPU: 4 PID: 18307 Comm: systemd-homewor
> Tainted: G        W         5.16.2-arch1-1 #1
> 86fbf2c313cc37a553d65deb81d98e9dcc2a3659
> Ιαν 25 14:34:32 mainland kernel: Hardware name: SAMSUNG ELECTRONICS CO.,
> LTD. 930XDB/931XDB/930XDY/NP930XDB-KF1IT, BIOS P03RFX.055.210415.SP
> 04/15/2021
> Ιαν 25 14:34:32 mainland kernel: RIP: 0010:__btrfs_free_extent+0x59c/0x950
> [btrfs]
> Ιαν 25 14:34:32 mainland kernel: Code: 24 14 ba 7e 0c 00 00 48 c7 c6 40 d4
> bc c0 4c 89 ef e8 44 25 0c 00 e9 99 fe ff ff 44 89 e6 48 c7 c7 a0 95 bd c0
> e8 24 6c 28 e>
> Ιαν 25 14:34:32 mainland kernel: RSP: 0018:ffffb1ab80f837a0 EFLAGS: 00010246
> Ιαν 25 14:34:32 mainland kernel: RAX: 0000000000000000 RBX: 0000000000000000
> RCX: 0000000000000000
> Ιαν 25 14:34:32 mainland kernel: RDX: 0000000000000000 RSI: 0000000000000000
> RDI: 0000000000000000
> Ιαν 25 14:34:32 mainland kernel: RBP: 0000000000d07000 R08: 0000000000000000
> R09: 0000000000000000
> Ιαν 25 14:34:32 mainland kernel: R10: 0000000000000000 R11: 0000000000000000
> R12: 00000000ffffffe4
> Ιαν 25 14:34:32 mainland kernel: R13: ffff982240648888 R14: ffff9823b62514d0
> R15: fffffffffffffff7
> Ιαν 25 14:34:32 mainland kernel: FS:  00007f336b49ea80(0000)
> GS:ffff9823c3700000(0000) knlGS:0000000000000000
> Ιαν 25 14:34:32 mainland kernel: CS:  0010 DS: 0000 ES: 0000 CR0:
> 0000000080050033
> Ιαν 25 14:34:32 mainland kernel: CR2: 00007fa3c5637050 CR3: 000000010cfd0002
> CR4: 0000000000770ee0
> Ιαν 25 14:34:32 mainland kernel: PKRU: 55555554
> Ιαν 25 14:34:32 mainland kernel: Call Trace:
> Ιαν 25 14:34:32 mainland kernel:  <TASK>
> Ιαν 25 14:34:32 mainland kernel: __btrfs_run_delayed_refs+0x25c/0x10d0
> [btrfs c10068e329b0dae5c9bb0cca4f6f33712f172b3b]
> Ιαν 25 14:34:32 mainland kernel: btrfs_run_delayed_refs+0x73/0x200 [btrfs
> c10068e329b0dae5c9bb0cca4f6f33712f172b3b]
> Ιαν 25 14:34:32 mainland kernel:  ? __reserve_bytes+0x164/0x7d0 [btrfs
> c10068e329b0dae5c9bb0cca4f6f33712f172b3b]
> Ιαν 25 14:34:32 mainland kernel: btrfs_commit_transaction+0xf6/0xb20 [btrfs
> c10068e329b0dae5c9bb0cca4f6f33712f172b3b]
> Ιαν 25 14:34:32 mainland kernel:  relocate_block_group+0x6e/0x5a0 [btrfs
> c10068e329b0dae5c9bb0cca4f6f33712f172b3b]
> Ιαν 25 14:34:32 mainland kernel: btrfs_relocate_block_group+0x18b/0x340
> [btrfs c10068e329b0dae5c9bb0cca4f6f33712f172b3b]
> Ιαν 25 14:34:32 mainland kernel:  btrfs_relocate_chunk+0x27/0x100 [btrfs
> c10068e329b0dae5c9bb0cca4f6f33712f172b3b]
> Ιαν 25 14:34:32 mainland kernel:  btrfs_shrink_device+0x277/0x5a0 [btrfs
> c10068e329b0dae5c9bb0cca4f6f33712f172b3b]
> Ιαν 25 14:34:32 mainland kernel:  btrfs_ioctl_resize+0x449/0x470 [btrfs
> c10068e329b0dae5c9bb0cca4f6f33712f172b3b]
> Ιαν 25 14:34:32 mainland kernel:  btrfs_ioctl+0x1fa8/0x2fc0 [btrfs
> c10068e329b0dae5c9bb0cca4f6f33712f172b3b]
> Ιαν 25 14:34:32 mainland kernel:  ? btrfs_statfs+0x418/0x570 [btrfs
> c10068e329b0dae5c9bb0cca4f6f33712f172b3b]
> Ιαν 25 14:34:32 mainland kernel:  ? _copy_to_user+0x1c/0x50
> Ιαν 25 14:34:32 mainland kernel:  ? do_statfs_native+0xaf/0xe0
> Ιαν 25 14:34:32 mainland kernel:  ? __seccomp_filter+0x39e/0x570
> Ιαν 25 14:34:32 mainland kernel:  ? __x64_sys_ioctl+0x8b/0xd0
> Ιαν 25 14:34:32 mainland kernel:  __x64_sys_ioctl+0x8b/0xd0
> Ιαν 25 14:34:32 mainland kernel:  do_syscall_64+0x59/0x90
> Ιαν 25 14:34:32 mainland kernel:  ? do_syscall_64+0x69/0x90
> Ιαν 25 14:34:32 mainland kernel:  ? syscall_exit_to_user_mode+0x23/0x50
> Ιαν 25 14:34:32 mainland kernel:  ? do_syscall_64+0x69/0x90
> Ιαν 25 14:34:32 mainland kernel:  ? syscall_exit_to_user_mode+0x23/0x50
> Ιαν 25 14:34:32 mainland kernel:  ? do_syscall_64+0x69/0x90
> Ιαν 25 14:34:32 mainland kernel:  ? exc_page_fault+0x72/0x180
> Ιαν 25 14:34:32 mainland kernel: entry_SYSCALL_64_after_hwframe+0x44/0xae
> Ιαν 25 14:34:32 mainland kernel: RIP: 0033:0x7f336baa359b
> Ιαν 25 14:34:32 mainland kernel: Code: ff ff ff 85 c0 79 9b 49 c7 c4 ff ff
> ff ff 5b 5d 4c 89 e0 41 5c c3 66 0f 1f 84 00 00 00 00 00 f3 0f 1e fa b8 10
> 00 00 00 0f 0>
> Ιαν 25 14:34:32 mainland kernel: RSP: 002b:00007ffc945a04d8 EFLAGS: 00000246
> ORIG_RAX: 0000000000000010
> Ιαν 25 14:34:32 mainland kernel: RAX: ffffffffffffffda RBX: 0000000072184000
> RCX: 00007f336baa359b
> Ιαν 25 14:34:32 mainland kernel: RDX: 00007ffc945a0570 RSI: 0000000050009403
> RDI: 0000000000000004
> Ιαν 25 14:34:32 mainland kernel: RBP: 0000000000000004 R08: 0000000000000000
> R09: 00007ffc945a0370
> Ιαν 25 14:34:32 mainland kernel: R10: 0000000072184000 R11: 0000000000000246
> R12: 00007ffc945a0570
> Ιαν 25 14:34:32 mainland kernel: R13: 0000000000000000 R14: 000055c0fade8cc0
> R15: 00007ffc945a1920
> Ιαν 25 14:34:32 mainland kernel:  </TASK>
> Ιαν 25 14:34:32 mainland kernel: ---[ end trace 81d5963d986040ee ]---
> Ιαν 25 14:34:32 mainland kernel: BTRFS: error (device dm-0) in
> __btrfs_free_extent:3066: errno=-28 No space left
> Ιαν 25 14:34:32 mainland kernel: BTRFS info (device dm-0): forced readonly
> Ιαν 25 14:34:32 mainland kernel: BTRFS: error (device dm-0) in
> btrfs_run_delayed_refs:2149: errno=-28 No space left
> 
> The dm-0 device is my /home directory and is set up using systemd-homed
> 
> Kernel version: 5.16.2
> 
> Systemd version: 250.3
> 
> btrfs-progs version: 5.16
> 
> It seems to cause no issues thus far but a solution would be good to have.
> 
> Thanks in advance.
> 
