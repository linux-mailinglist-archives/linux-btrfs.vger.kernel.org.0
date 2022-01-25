Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1513B49BA9B
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Jan 2022 18:49:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354556AbiAYRsK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 25 Jan 2022 12:48:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385053AbiAYRrA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 25 Jan 2022 12:47:00 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBCC9C061401
        for <linux-btrfs@vger.kernel.org>; Tue, 25 Jan 2022 09:46:58 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id j2so31939891ejk.6
        for <linux-btrfs@vger.kernel.org>; Tue, 25 Jan 2022 09:46:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:to:content-language:from
         :subject:content-transfer-encoding;
        bh=kJn1wcYm3MYJGAiuNmMejktrP2xA4sxIE3XLHUeUZ/M=;
        b=VIyrMHNshoQpVUYYsMCuEPEV3yTVO/BXrMjgh0tQ3qBfwT3i6AdftecCchH6RQE9TT
         Mq+vR2vOxLr5dx4FJceSsQ8jmbuZjpmGwycvSqdXLfe7DINV4iogQraM9E3UcUztWJI3
         yAqbVYvUWeVe1cvyIgJ7cJM23FFxVIsKRTbGoxND5rfKGoxVq1O+nCovRrEN1DmxZadx
         5GnaqeBIUBZStxxymO8XnFIar6WZi+BM30yzC8aLJn5fc+fF3RJKGSdos5YpOTYCSHDV
         WY2umrerFPeylt96ASmMHZP5V5guyrN6rHaVPRkBNcNmPSe6ggdiY0+nD2ulLcnA8FDL
         Bd5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:to
         :content-language:from:subject:content-transfer-encoding;
        bh=kJn1wcYm3MYJGAiuNmMejktrP2xA4sxIE3XLHUeUZ/M=;
        b=u7a7QG62JfD/kgs8qvZP9Q6YRnX7F7RtQtw5RZt5IdRsoARlteOL7g6UBIr1uwvZP4
         DLsFbJ3E3zKZ7piYuWRyiB+m+6F16fN9eQ9ALS1158POuL106/xOA/RvcPFqFg9cGyCS
         4hcweHaKJhR9vpsn9S+HQtvyaEEF2SlQS2H4OALIr85vlvLVeO/QPOcJ2yVSURdY+wzC
         FlM8VOrUHV4Z3Ov8sKdTHQOS1OYeueAlLz6F83EeV3qr3a4OPva9ispRAYKt9WeHPhOe
         yJg6t+wMTnlkpJ1o31oXufyVjuruw/kHcMeuV8uqgante9G2eytseK56MMsjl2vUIpIl
         TaMw==
X-Gm-Message-State: AOAM531+taAsrz9IVC/pvQCvkQOPWf/8GBFd3TAanbgqEOUM04PwZSsQ
        I343iOoah7kbOgyYbVlj13RzqIIzczo=
X-Google-Smtp-Source: ABdhPJxuSLZ/8oK26/yVk1a0+bKyX4xQelYzhX1ntFR7KMOdH9gy2ZeTjoyVfBII2wNmte1OggbY3A==
X-Received: by 2002:a17:907:161f:: with SMTP id hb31mr1703468ejc.269.1643132817453;
        Tue, 25 Jan 2022 09:46:57 -0800 (PST)
Received: from ?IPV6:2a02:587:482e:a301:6679:f0ff:fe54:e6a6? ([2a02:587:482e:a301:6679:f0ff:fe54:e6a6])
        by smtp.gmail.com with ESMTPSA id by16sm6457138ejb.73.2022.01.25.09.46.56
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Jan 2022 09:46:56 -0800 (PST)
Message-ID: <9bdd0eb6-4a4f-e168-0fb0-77f4d753ec19@gmail.com>
Date:   Tue, 25 Jan 2022 19:46:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
To:     linux-btrfs@vger.kernel.org
Content-Language: en-US
From:   "Apostolos B." <barz621@gmail.com>
Subject: No space left errors on shutdown with systemd-homed /home dir
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello.

When i shut down my pc i get No space left errors -even though i have 
plenty of space in both / and home dirs- and this message on the journal:

Ιαν 25 14:34:31 mainland kernel: BTRFS info (device dm-0): relocating 
block group 2177892352 flags data
Ιαν 25 14:34:31 mainland kernel: BTRFS info (device dm-0): relocating 
block group 1104150528 flags data
Ιαν 25 14:34:32 mainland kernel: BTRFS info (device dm-0): relocating 
block group 30408704 flags metadata|dup
Ιαν 25 14:34:32 mainland kernel: ------------[ cut here ]------------
Ιαν 25 14:34:32 mainland kernel: BTRFS: Transaction aborted (error -28)
Ιαν 25 14:34:32 mainland kernel: WARNING: CPU: 4 PID: 18307 at 
fs/btrfs/extent-tree.c:3066 __btrfs_free_extent+0x59c/0x950 [btrfs]
Ιαν 25 14:34:32 mainland kernel: Modules linked in: uhid rfcomm 
snd_seq_dummy snd_hrtimer snd_seq snd_seq_device i2c_dev dm_crypt cbc 
encrypted_keys trusted asn1_e>
Ιαν 25 14:34:32 mainland kernel:  snd_pcm_dmaengine kvm snd_hda_intel 
iTCO_wdt irqbypass snd_intel_dspcfg intel_pmc_bxt crct10dif_pclmul 
snd_intel_sdw_acpi hid_mul>
Ιαν 25 14:34:32 mainland kernel:  int340x_thermal_zone tpm_tis 
tpm_tis_core wmi int3400_thermal tpm mac_hid rng_core acpi_thermal_rel 
acpi_tad acpi_pad ipmi_devint>
Ιαν 25 14:34:32 mainland kernel: CPU: 4 PID: 18307 Comm: systemd-homewor 
Tainted: G        W         5.16.2-arch1-1 #1 
86fbf2c313cc37a553d65deb81d98e9dcc2a3659
Ιαν 25 14:34:32 mainland kernel: Hardware name: SAMSUNG ELECTRONICS CO., 
LTD. 930XDB/931XDB/930XDY/NP930XDB-KF1IT, BIOS P03RFX.055.210415.SP 
04/15/2021
Ιαν 25 14:34:32 mainland kernel: RIP: 
0010:__btrfs_free_extent+0x59c/0x950 [btrfs]
Ιαν 25 14:34:32 mainland kernel: Code: 24 14 ba 7e 0c 00 00 48 c7 c6 40 
d4 bc c0 4c 89 ef e8 44 25 0c 00 e9 99 fe ff ff 44 89 e6 48 c7 c7 a0 95 
bd c0 e8 24 6c 28 e>
Ιαν 25 14:34:32 mainland kernel: RSP: 0018:ffffb1ab80f837a0 EFLAGS: 00010246
Ιαν 25 14:34:32 mainland kernel: RAX: 0000000000000000 RBX: 
0000000000000000 RCX: 0000000000000000
Ιαν 25 14:34:32 mainland kernel: RDX: 0000000000000000 RSI: 
0000000000000000 RDI: 0000000000000000
Ιαν 25 14:34:32 mainland kernel: RBP: 0000000000d07000 R08: 
0000000000000000 R09: 0000000000000000
Ιαν 25 14:34:32 mainland kernel: R10: 0000000000000000 R11: 
0000000000000000 R12: 00000000ffffffe4
Ιαν 25 14:34:32 mainland kernel: R13: ffff982240648888 R14: 
ffff9823b62514d0 R15: fffffffffffffff7
Ιαν 25 14:34:32 mainland kernel: FS:  00007f336b49ea80(0000) 
GS:ffff9823c3700000(0000) knlGS:0000000000000000
Ιαν 25 14:34:32 mainland kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 
0000000080050033
Ιαν 25 14:34:32 mainland kernel: CR2: 00007fa3c5637050 CR3: 
000000010cfd0002 CR4: 0000000000770ee0
Ιαν 25 14:34:32 mainland kernel: PKRU: 55555554
Ιαν 25 14:34:32 mainland kernel: Call Trace:
Ιαν 25 14:34:32 mainland kernel:  <TASK>
Ιαν 25 14:34:32 mainland kernel: __btrfs_run_delayed_refs+0x25c/0x10d0 
[btrfs c10068e329b0dae5c9bb0cca4f6f33712f172b3b]
Ιαν 25 14:34:32 mainland kernel: btrfs_run_delayed_refs+0x73/0x200 
[btrfs c10068e329b0dae5c9bb0cca4f6f33712f172b3b]
Ιαν 25 14:34:32 mainland kernel:  ? __reserve_bytes+0x164/0x7d0 [btrfs 
c10068e329b0dae5c9bb0cca4f6f33712f172b3b]
Ιαν 25 14:34:32 mainland kernel: btrfs_commit_transaction+0xf6/0xb20 
[btrfs c10068e329b0dae5c9bb0cca4f6f33712f172b3b]
Ιαν 25 14:34:32 mainland kernel:  relocate_block_group+0x6e/0x5a0 [btrfs 
c10068e329b0dae5c9bb0cca4f6f33712f172b3b]
Ιαν 25 14:34:32 mainland kernel: btrfs_relocate_block_group+0x18b/0x340 
[btrfs c10068e329b0dae5c9bb0cca4f6f33712f172b3b]
Ιαν 25 14:34:32 mainland kernel:  btrfs_relocate_chunk+0x27/0x100 [btrfs 
c10068e329b0dae5c9bb0cca4f6f33712f172b3b]
Ιαν 25 14:34:32 mainland kernel:  btrfs_shrink_device+0x277/0x5a0 [btrfs 
c10068e329b0dae5c9bb0cca4f6f33712f172b3b]
Ιαν 25 14:34:32 mainland kernel:  btrfs_ioctl_resize+0x449/0x470 [btrfs 
c10068e329b0dae5c9bb0cca4f6f33712f172b3b]
Ιαν 25 14:34:32 mainland kernel:  btrfs_ioctl+0x1fa8/0x2fc0 [btrfs 
c10068e329b0dae5c9bb0cca4f6f33712f172b3b]
Ιαν 25 14:34:32 mainland kernel:  ? btrfs_statfs+0x418/0x570 [btrfs 
c10068e329b0dae5c9bb0cca4f6f33712f172b3b]
Ιαν 25 14:34:32 mainland kernel:  ? _copy_to_user+0x1c/0x50
Ιαν 25 14:34:32 mainland kernel:  ? do_statfs_native+0xaf/0xe0
Ιαν 25 14:34:32 mainland kernel:  ? __seccomp_filter+0x39e/0x570
Ιαν 25 14:34:32 mainland kernel:  ? __x64_sys_ioctl+0x8b/0xd0
Ιαν 25 14:34:32 mainland kernel:  __x64_sys_ioctl+0x8b/0xd0
Ιαν 25 14:34:32 mainland kernel:  do_syscall_64+0x59/0x90
Ιαν 25 14:34:32 mainland kernel:  ? do_syscall_64+0x69/0x90
Ιαν 25 14:34:32 mainland kernel:  ? syscall_exit_to_user_mode+0x23/0x50
Ιαν 25 14:34:32 mainland kernel:  ? do_syscall_64+0x69/0x90
Ιαν 25 14:34:32 mainland kernel:  ? syscall_exit_to_user_mode+0x23/0x50
Ιαν 25 14:34:32 mainland kernel:  ? do_syscall_64+0x69/0x90
Ιαν 25 14:34:32 mainland kernel:  ? exc_page_fault+0x72/0x180
Ιαν 25 14:34:32 mainland kernel: entry_SYSCALL_64_after_hwframe+0x44/0xae
Ιαν 25 14:34:32 mainland kernel: RIP: 0033:0x7f336baa359b
Ιαν 25 14:34:32 mainland kernel: Code: ff ff ff 85 c0 79 9b 49 c7 c4 ff 
ff ff ff 5b 5d 4c 89 e0 41 5c c3 66 0f 1f 84 00 00 00 00 00 f3 0f 1e fa 
b8 10 00 00 00 0f 0>
Ιαν 25 14:34:32 mainland kernel: RSP: 002b:00007ffc945a04d8 EFLAGS: 
00000246 ORIG_RAX: 0000000000000010
Ιαν 25 14:34:32 mainland kernel: RAX: ffffffffffffffda RBX: 
0000000072184000 RCX: 00007f336baa359b
Ιαν 25 14:34:32 mainland kernel: RDX: 00007ffc945a0570 RSI: 
0000000050009403 RDI: 0000000000000004
Ιαν 25 14:34:32 mainland kernel: RBP: 0000000000000004 R08: 
0000000000000000 R09: 00007ffc945a0370
Ιαν 25 14:34:32 mainland kernel: R10: 0000000072184000 R11: 
0000000000000246 R12: 00007ffc945a0570
Ιαν 25 14:34:32 mainland kernel: R13: 0000000000000000 R14: 
000055c0fade8cc0 R15: 00007ffc945a1920
Ιαν 25 14:34:32 mainland kernel:  </TASK>
Ιαν 25 14:34:32 mainland kernel: ---[ end trace 81d5963d986040ee ]---
Ιαν 25 14:34:32 mainland kernel: BTRFS: error (device dm-0) in 
__btrfs_free_extent:3066: errno=-28 No space left
Ιαν 25 14:34:32 mainland kernel: BTRFS info (device dm-0): forced readonly
Ιαν 25 14:34:32 mainland kernel: BTRFS: error (device dm-0) in 
btrfs_run_delayed_refs:2149: errno=-28 No space left

The dm-0 device is my /home directory and is set up using systemd-homed

Kernel version: 5.16.2

Systemd version: 250.3

btrfs-progs version: 5.16

It seems to cause no issues thus far but a solution would be good to have.

Thanks in advance.

