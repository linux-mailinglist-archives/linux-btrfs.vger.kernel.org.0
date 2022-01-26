Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A45049D4F6
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Jan 2022 23:08:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232930AbiAZWIB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 26 Jan 2022 17:08:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232918AbiAZWIA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 26 Jan 2022 17:08:00 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B7C5C06161C
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Jan 2022 14:08:00 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id w14so1038071edd.10
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Jan 2022 14:08:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=wKASxYlJ2b6zw9K+x+0ITHLI0zfPa5r3AQFKCi2aMSY=;
        b=GVaB4F32I0bx4QuSNuJmQNbITCcJmEwIZIYxJWG/WQAVuC4eVgTYyLYXUbd2nmoJ0e
         LAHUPFoF3SHA3slh6hAUVVqSasPeRJXWsufAbik+TPOWqKywbCplGuZIXqNfEC1uSEhj
         LGJ1uEj8uFlwgT6t3QFyUZykAfiIQO2bp63OhSxNzH+VVqe5UanQBsh9nim0YKBNNUuZ
         xYa7nTP+ip7+vERJzHOmwDnbhv6ul9d0PCRIzMIwha2C3pUIbxnp3zPumQ5YMmeas1pO
         zW6wlFNNwZnhygINxnv5dXlNJxQZtNdN6qOoB20Ak75K8ijTi+NRHVY8ItaxPLwPX7+v
         4upQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=wKASxYlJ2b6zw9K+x+0ITHLI0zfPa5r3AQFKCi2aMSY=;
        b=ZfDlMb5DNK4NOLLRkwRuczRi/lVeD8cYLL3u+EezXRtzt9TyO8XODI/HdRHe9fvoL5
         DskbAaKFVgcvVDjUe0tvviDnT3BKkTtHdk30vTopJLzQvh0d6CDJ9kYwhZF2uoScf8g7
         o3wlSUGKlsERRhoiEYS6o9TPMj6L2wt3xW7oI5irdCiyTWeVOV3yjRWHJGx+kS+fi3W1
         Z10wsBcRBjK0p3O/iaAQcF/f6knTihvwagJ2P98E/wrRbhCaY7Mamre8OQt0GA5b9nVR
         3Z1d4bs352wZNy/eB51KRs5kNcSD5kAlsKTX4aUy2dxxS2/DMsUbPKckWWOENl8cdIcb
         BZmQ==
X-Gm-Message-State: AOAM530ZmMIvU9rdbjIO6uWqx304q8G4+a/1r0oKUyxfZ1D+28ZF+BlB
        1Q68LE0RSxod+txaUMmy4VCPXyzJi10J2w==
X-Google-Smtp-Source: ABdhPJw+4x9xFq7Hw339KBc9+eXkyqlXAG5UF79IfaDmdYqQDcZUpPMEC3HbpNILGKww6GcH5UFAdQ==
X-Received: by 2002:aa7:c14a:: with SMTP id r10mr998638edp.292.1643234878934;
        Wed, 26 Jan 2022 14:07:58 -0800 (PST)
Received: from ?IPV6:2a02:587:482e:a301:6679:f0ff:fe54:e6a6? ([2a02:587:482e:a301:6679:f0ff:fe54:e6a6])
        by smtp.gmail.com with ESMTPSA id s7sm7876648ejo.212.2022.01.26.14.07.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jan 2022 14:07:58 -0800 (PST)
Message-ID: <4263e65e-f585-e7f6-b1aa-04885c0ed662@gmail.com>
Date:   Thu, 27 Jan 2022 00:07:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: No space left errors on shutdown with systemd-homed /home dir
Content-Language: en-US
To:     Boris Burkov <boris@bur.io>
Cc:     linux-btrfs@vger.kernel.org
References: <9bdd0eb6-4a4f-e168-0fb0-77f4d753ec19@gmail.com>
 <YfHCLhpkS+t8a8CG@zen>
From:   "Apostolos B." <barz621@gmail.com>
In-Reply-To: <YfHCLhpkS+t8a8CG@zen>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

  This is what homectl inspect user reports:

   Disk Size: 128.0G
   Disk Usage: 3.8G (= 3.1%)
   Disk Free: 124.0G (= 96.9%)

and this is what btrfs usage reports:

sudo btrfs filesystem usage /home/toliz

Overall:
     Device size:             127.98GiB
     Device allocated:               4.02GiB
     Device unallocated:     123.96GiB
     Device missing:                 0.00B
     Used:                           1.89GiB
     Free (estimated):             124.10GiB    (min: 62.12GiB)
     Free (statfs, df):             124.10GiB
     Data ratio:                  1.00
     Metadata ratio:                  2.00
     Global reserve:               5.14MiB    (used: 0.00B)
     Multiple profiles:                    no

Data,single: Size:2.01GiB, Used:1.86GiB (92.73%)
    /dev/mapper/home-toliz       2.01GiB

Metadata,DUP: Size:1.00GiB, Used:12.47MiB (1.22%)
    /dev/mapper/home-toliz       2.00GiB

System,DUP: Size:8.00MiB, Used:16.00KiB (0.20%)
    /dev/mapper/home-toliz      16.00MiB

Unallocated:
    /dev/mapper/home-toliz     123.96GiB


On 26/1/22 23:50, Boris Burkov wrote:
> On Tue, Jan 25, 2022 at 07:46:51PM +0200, Apostolos B. wrote:
>> Hello.
>>
>> When i shut down my pc i get No space left errors -even though i have plenty
>> of space in both / and home dirs- and this message on the journal:
> How did you conclude you have plenty of space? df can be misleading with
> btrfs, for example. Can you please post the output of
> 'btrfs filesystem usage /home'
>
> Thanks,
> Boris
>
>> Ιαν 25 14:34:31 mainland kernel: BTRFS info (device dm-0): relocating block
>> group 2177892352 flags data
>> Ιαν 25 14:34:31 mainland kernel: BTRFS info (device dm-0): relocating block
>> group 1104150528 flags data
>> Ιαν 25 14:34:32 mainland kernel: BTRFS info (device dm-0): relocating block
>> group 30408704 flags metadata|dup
>> Ιαν 25 14:34:32 mainland kernel: ------------[ cut here ]------------
>> Ιαν 25 14:34:32 mainland kernel: BTRFS: Transaction aborted (error -28)
>> Ιαν 25 14:34:32 mainland kernel: WARNING: CPU: 4 PID: 18307 at
>> fs/btrfs/extent-tree.c:3066 __btrfs_free_extent+0x59c/0x950 [btrfs]
>> Ιαν 25 14:34:32 mainland kernel: Modules linked in: uhid rfcomm
>> snd_seq_dummy snd_hrtimer snd_seq snd_seq_device i2c_dev dm_crypt cbc
>> encrypted_keys trusted asn1_e>
>> Ιαν 25 14:34:32 mainland kernel:  snd_pcm_dmaengine kvm snd_hda_intel
>> iTCO_wdt irqbypass snd_intel_dspcfg intel_pmc_bxt crct10dif_pclmul
>> snd_intel_sdw_acpi hid_mul>
>> Ιαν 25 14:34:32 mainland kernel:  int340x_thermal_zone tpm_tis tpm_tis_core
>> wmi int3400_thermal tpm mac_hid rng_core acpi_thermal_rel acpi_tad acpi_pad
>> ipmi_devint>
>> Ιαν 25 14:34:32 mainland kernel: CPU: 4 PID: 18307 Comm: systemd-homewor
>> Tainted: G        W         5.16.2-arch1-1 #1
>> 86fbf2c313cc37a553d65deb81d98e9dcc2a3659
>> Ιαν 25 14:34:32 mainland kernel: Hardware name: SAMSUNG ELECTRONICS CO.,
>> LTD. 930XDB/931XDB/930XDY/NP930XDB-KF1IT, BIOS P03RFX.055.210415.SP
>> 04/15/2021
>> Ιαν 25 14:34:32 mainland kernel: RIP: 0010:__btrfs_free_extent+0x59c/0x950
>> [btrfs]
>> Ιαν 25 14:34:32 mainland kernel: Code: 24 14 ba 7e 0c 00 00 48 c7 c6 40 d4
>> bc c0 4c 89 ef e8 44 25 0c 00 e9 99 fe ff ff 44 89 e6 48 c7 c7 a0 95 bd c0
>> e8 24 6c 28 e>
>> Ιαν 25 14:34:32 mainland kernel: RSP: 0018:ffffb1ab80f837a0 EFLAGS: 00010246
>> Ιαν 25 14:34:32 mainland kernel: RAX: 0000000000000000 RBX: 0000000000000000
>> RCX: 0000000000000000
>> Ιαν 25 14:34:32 mainland kernel: RDX: 0000000000000000 RSI: 0000000000000000
>> RDI: 0000000000000000
>> Ιαν 25 14:34:32 mainland kernel: RBP: 0000000000d07000 R08: 0000000000000000
>> R09: 0000000000000000
>> Ιαν 25 14:34:32 mainland kernel: R10: 0000000000000000 R11: 0000000000000000
>> R12: 00000000ffffffe4
>> Ιαν 25 14:34:32 mainland kernel: R13: ffff982240648888 R14: ffff9823b62514d0
>> R15: fffffffffffffff7
>> Ιαν 25 14:34:32 mainland kernel: FS:  00007f336b49ea80(0000)
>> GS:ffff9823c3700000(0000) knlGS:0000000000000000
>> Ιαν 25 14:34:32 mainland kernel: CS:  0010 DS: 0000 ES: 0000 CR0:
>> 0000000080050033
>> Ιαν 25 14:34:32 mainland kernel: CR2: 00007fa3c5637050 CR3: 000000010cfd0002
>> CR4: 0000000000770ee0
>> Ιαν 25 14:34:32 mainland kernel: PKRU: 55555554
>> Ιαν 25 14:34:32 mainland kernel: Call Trace:
>> Ιαν 25 14:34:32 mainland kernel:  <TASK>
>> Ιαν 25 14:34:32 mainland kernel: __btrfs_run_delayed_refs+0x25c/0x10d0
>> [btrfs c10068e329b0dae5c9bb0cca4f6f33712f172b3b]
>> Ιαν 25 14:34:32 mainland kernel: btrfs_run_delayed_refs+0x73/0x200 [btrfs
>> c10068e329b0dae5c9bb0cca4f6f33712f172b3b]
>> Ιαν 25 14:34:32 mainland kernel:  ? __reserve_bytes+0x164/0x7d0 [btrfs
>> c10068e329b0dae5c9bb0cca4f6f33712f172b3b]
>> Ιαν 25 14:34:32 mainland kernel: btrfs_commit_transaction+0xf6/0xb20 [btrfs
>> c10068e329b0dae5c9bb0cca4f6f33712f172b3b]
>> Ιαν 25 14:34:32 mainland kernel:  relocate_block_group+0x6e/0x5a0 [btrfs
>> c10068e329b0dae5c9bb0cca4f6f33712f172b3b]
>> Ιαν 25 14:34:32 mainland kernel: btrfs_relocate_block_group+0x18b/0x340
>> [btrfs c10068e329b0dae5c9bb0cca4f6f33712f172b3b]
>> Ιαν 25 14:34:32 mainland kernel:  btrfs_relocate_chunk+0x27/0x100 [btrfs
>> c10068e329b0dae5c9bb0cca4f6f33712f172b3b]
>> Ιαν 25 14:34:32 mainland kernel:  btrfs_shrink_device+0x277/0x5a0 [btrfs
>> c10068e329b0dae5c9bb0cca4f6f33712f172b3b]
>> Ιαν 25 14:34:32 mainland kernel:  btrfs_ioctl_resize+0x449/0x470 [btrfs
>> c10068e329b0dae5c9bb0cca4f6f33712f172b3b]
>> Ιαν 25 14:34:32 mainland kernel:  btrfs_ioctl+0x1fa8/0x2fc0 [btrfs
>> c10068e329b0dae5c9bb0cca4f6f33712f172b3b]
>> Ιαν 25 14:34:32 mainland kernel:  ? btrfs_statfs+0x418/0x570 [btrfs
>> c10068e329b0dae5c9bb0cca4f6f33712f172b3b]
>> Ιαν 25 14:34:32 mainland kernel:  ? _copy_to_user+0x1c/0x50
>> Ιαν 25 14:34:32 mainland kernel:  ? do_statfs_native+0xaf/0xe0
>> Ιαν 25 14:34:32 mainland kernel:  ? __seccomp_filter+0x39e/0x570
>> Ιαν 25 14:34:32 mainland kernel:  ? __x64_sys_ioctl+0x8b/0xd0
>> Ιαν 25 14:34:32 mainland kernel:  __x64_sys_ioctl+0x8b/0xd0
>> Ιαν 25 14:34:32 mainland kernel:  do_syscall_64+0x59/0x90
>> Ιαν 25 14:34:32 mainland kernel:  ? do_syscall_64+0x69/0x90
>> Ιαν 25 14:34:32 mainland kernel:  ? syscall_exit_to_user_mode+0x23/0x50
>> Ιαν 25 14:34:32 mainland kernel:  ? do_syscall_64+0x69/0x90
>> Ιαν 25 14:34:32 mainland kernel:  ? syscall_exit_to_user_mode+0x23/0x50
>> Ιαν 25 14:34:32 mainland kernel:  ? do_syscall_64+0x69/0x90
>> Ιαν 25 14:34:32 mainland kernel:  ? exc_page_fault+0x72/0x180
>> Ιαν 25 14:34:32 mainland kernel: entry_SYSCALL_64_after_hwframe+0x44/0xae
>> Ιαν 25 14:34:32 mainland kernel: RIP: 0033:0x7f336baa359b
>> Ιαν 25 14:34:32 mainland kernel: Code: ff ff ff 85 c0 79 9b 49 c7 c4 ff ff
>> ff ff 5b 5d 4c 89 e0 41 5c c3 66 0f 1f 84 00 00 00 00 00 f3 0f 1e fa b8 10
>> 00 00 00 0f 0>
>> Ιαν 25 14:34:32 mainland kernel: RSP: 002b:00007ffc945a04d8 EFLAGS: 00000246
>> ORIG_RAX: 0000000000000010
>> Ιαν 25 14:34:32 mainland kernel: RAX: ffffffffffffffda RBX: 0000000072184000
>> RCX: 00007f336baa359b
>> Ιαν 25 14:34:32 mainland kernel: RDX: 00007ffc945a0570 RSI: 0000000050009403
>> RDI: 0000000000000004
>> Ιαν 25 14:34:32 mainland kernel: RBP: 0000000000000004 R08: 0000000000000000
>> R09: 00007ffc945a0370
>> Ιαν 25 14:34:32 mainland kernel: R10: 0000000072184000 R11: 0000000000000246
>> R12: 00007ffc945a0570
>> Ιαν 25 14:34:32 mainland kernel: R13: 0000000000000000 R14: 000055c0fade8cc0
>> R15: 00007ffc945a1920
>> Ιαν 25 14:34:32 mainland kernel:  </TASK>
>> Ιαν 25 14:34:32 mainland kernel: ---[ end trace 81d5963d986040ee ]---
>> Ιαν 25 14:34:32 mainland kernel: BTRFS: error (device dm-0) in
>> __btrfs_free_extent:3066: errno=-28 No space left
>> Ιαν 25 14:34:32 mainland kernel: BTRFS info (device dm-0): forced readonly
>> Ιαν 25 14:34:32 mainland kernel: BTRFS: error (device dm-0) in
>> btrfs_run_delayed_refs:2149: errno=-28 No space left
>>
>> The dm-0 device is my /home directory and is set up using systemd-homed
>>
>> Kernel version: 5.16.2
>>
>> Systemd version: 250.3
>>
>> btrfs-progs version: 5.16
>>
>> It seems to cause no issues thus far but a solution would be good to have.
>>
>> Thanks in advance.
>>
