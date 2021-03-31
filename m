Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4CE934FE1A
	for <lists+linux-btrfs@lfdr.de>; Wed, 31 Mar 2021 12:33:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235025AbhCaKcw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 31 Mar 2021 06:32:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234997AbhCaKcr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 31 Mar 2021 06:32:47 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69337C061574
        for <linux-btrfs@vger.kernel.org>; Wed, 31 Mar 2021 03:32:47 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id b9so19103982wrt.8
        for <linux-btrfs@vger.kernel.org>; Wed, 31 Mar 2021 03:32:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=SDE/QVAjz2lXM28QEBU3KqpzNstzi43fp88ygq90hjs=;
        b=k1+Skzxlabp78kErUP4l0PR0vaentrM3CvxXQY6VEfMRScINDLjTkpIDrfixpkw5p+
         cb2iDVPzvwS1lxDiMOfpgzJ2G10oSMqeMiV13D5pSf+r5GJGdMjzK253aiCRXp9wyOzP
         K93LmmOtg9thFV8K/taifha3cpEPPGON983oE0pLq/rzA0ymYHqfyjd4yu5RsLbieSBP
         8aigsY3Z6+kJyCPgtIVyM5+dVqeAaLhwr+PtamCnseBAJQ5ycoPOw8UzSJD5y4K31v3N
         KQjnNQHCcThP6vw9YCU0RMjHNHTLBkmIoQdNChDKYyWp6BGRz+srqxJyaxtEMuDd1YXr
         iQAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SDE/QVAjz2lXM28QEBU3KqpzNstzi43fp88ygq90hjs=;
        b=Em1kDakdAF/p9M7vzoufqeEgeHeoy2BDZb5oIdke/w4u9Ib/rWx581dhNUX+LTdF67
         yFyAOaSppKg3jeGR+gOOyYwXWDtu1pzA7U3D39i3m7146eRxIx1USWUwTFazRPyspKK8
         9WLxIX281FnCeS+vEtHPiWwE7H71VNXmUvb8TMtDorcngdLZ+f4MqQpPLrd8ysuCxS0y
         OblIYgpagUf2GunuoLDznolnZnJm36Zrz3WCWBN8Nd0YehukEEGpmhXxaFmZ6tMMFnbs
         s7Pp+GJJjaQnkxmYkWZWqYCpsrZO+MoRU1uFfC+E3oSegy+Wb5AQ6UMg+4UV1jFSpVAZ
         7M4g==
X-Gm-Message-State: AOAM531f/8XCJF9vXiAnpOKSOwkn3R9NX+M5fOLyybpL+4RU5X8g77Iq
        tpy2MCTLEUsEjLl7uZiEM4u7b+GmMYDCpw==
X-Google-Smtp-Source: ABdhPJyIy4gmfQs6hVp2tJSRj4u15IfjyBW/nfrHTTRo/GAOBQirRI6qE0bQDoG79G1FDY0aO+nr9Q==
X-Received: by 2002:a05:6000:1819:: with SMTP id m25mr2823268wrh.169.1617186766065;
        Wed, 31 Mar 2021 03:32:46 -0700 (PDT)
Received: from yuna.elaboris.de (dslb-002-202-189-052.002.202.pools.vodafone-ip.de. [2.202.189.52])
        by smtp.gmail.com with ESMTPSA id p16sm4867897wrt.54.2021.03.31.03.32.45
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Mar 2021 03:32:45 -0700 (PDT)
Subject: Re: Any ideas what this warnings are about?
To:     linux-btrfs@vger.kernel.org
References: <43acc426-d683-d1b6-729d-c6bc4a2fff4d@gmail.com>
 <20210331015827.GV32440@hungrycats.org>
From:   Markus Schaaf <markuschaaf@gmail.com>
Message-ID: <adbc670b-b85e-a44d-3089-089c4564f57f@gmail.com>
Date:   Wed, 31 Mar 2021 12:32:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <20210331015827.GV32440@hungrycats.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Am 31.03.21 um 03:58 schrieb Zygo Blaxell:

>> ------------[ cut here ]------------
>> WARNING: CPU: 1 PID: 314 at fs/fs-writeback.c:2472 __writeback_inodes_sb_nr+0xb8/0xd0
>> Modules linked in: iTCO_wdt wireguard curve25519_x86_64 libchacha20poly1305 intel_pmc_bxt iTCO_vendor_support chacha_x86_64 poly1305_x86_64 libblake2s blake2s_x86_64 ip6_udp_tunnel udp_tunnel libcurve25519_generic libchacha libblake2s_generic psmouse joydev mousedev pcspkr i2c_i801 i2c_smbus lpc_ich iptable_filter xt_nat xt_tcpudp intel_agp intel_gtt iptable_nat nf_nat qemu_fw_cfg nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 mac_hid vfat fat auth_rpcgss sunrpc fuse ip_tables x_tables btrfs blake2b_generic libcrc32c crc32c_generic xor raid6_pq dm_crypt cbc encrypted_keys trusted tpm usbhid dm_mod virtio_gpu virtio_dma_buf drm_kms_helper syscopyarea sysfillrect sysimgblt fb_sys_fops cec drm virtio_scsi virtio_balloon virtio_net virtio_console net_failover agpgart failover crct10dif_pclmul crc32_pclmul crc32c_intel ghash_clmulni_intel aesni_intel crypto_simd cryptd glue_helper serio_raw sr_mod cdrom xhci_pci virtio_pci virtio_rng rng_core
>> CPU: 1 PID: 314 Comm: btrfs-transacti Tainted: G        W         5.10.26-1-MANJARO #1
>> Hardware name: Hetzner vServer, BIOS 20171111 11/11/2017
>> RIP: 0010:__writeback_inodes_sb_nr+0xb8/0xd0
>> Code: 0f b6 d1 48 8d 74 24 10 e8 35 fc ff ff 48 89 e7 e8 7d fb ff ff 48 8b 44 24 48 65 48 2b 04 25 28 00 00 00 75 09 48 83 c4 50 c3 <0f> 0b eb cf e8 df 8c 75 00 66 66 2e 0f 1f 84 00 00 00 00 00 0f 1f
>> RSP: 0018:ffffb1f5448f7d98 EFLAGS: 00010246
>> RAX: 0000000000000000 RBX: ffff961185aa5488 RCX: 0000000000000000
>> RDX: 0000000000000002 RSI: 0000000000004b45 RDI: ffff9611b7220000
>> RBP: ffff9611b64d3958 R08: ffff961184efc800 R09: 0000000000000140
>> R10: ffff9611859e6400 R11: ffff961192af3c10 R12: ffff9611838f7c00
>> R13: ffff961185aa5000 R14: ffff961185aa5460 R15: 0000000000011a0f
>> FS:  0000000000000000(0000) GS:ffff9611fad00000(0000) knlGS:0000000000000000
>> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> CR2: 00007f654bc76b58 CR3: 0000000002c60000 CR4: 00000000003506e0
>> Call Trace:
>>   btrfs_commit_transaction+0x448/0xbc0 [btrfs]
>>   ? start_transaction+0xcc/0x5b0 [btrfs]
>>   transaction_kthread+0x143/0x170 [btrfs]
>>   ? btrfs_cleanup_transaction.isra.0+0x560/0x560 [btrfs]
>>   kthread+0x133/0x150
>>   ? __kthread_bind_mask+0x60/0x60
>>   ret_from_fork+0x22/0x30
>> ---[ end trace 3cefecf5d9d20b50 ]---
>>
>> ------------[ cut here ]------------
>> WARNING: CPU: 0 PID: 758 at fs/fs-writeback.c:2472 __writeback_inodes_sb_nr+0xb8/0xd0
> 
> That bug was introduced in 4.15 as part of a fix for a deadlock bug.
> It's still there today.  Not very high on anyone's TODO list as it's
> mostly harmless--btrfs can't be umounted during a transaction as the
> umount itself uses a transaction.  The warning doesn't come from btrfs
> code, so we can't just turn it off.

That warning spams my logs every 1-5 minutes. There is no unmounting 
happening.

> 
>> Modules linked in: iTCO_wdt wireguard curve25519_x86_64 libchacha20poly1305 intel_pmc_bxt iTCO_vendor_support chacha_x86_64 poly1305_x86_64 libblake2s blake2s_x86_>
>> CPU: 0 PID: 758 Comm: journal-offline Tainted: G        W         5.10.26-1-MANJARO #1
>> Hardware name: Hetzner vServer, BIOS 20171111 11/11/2017
>> RIP: 0010:__writeback_inodes_sb_nr+0xb8/0xd0
>> Code: 0f b6 d1 48 8d 74 24 10 e8 35 fc ff ff 48 89 e7 e8 7d fb ff ff 48 8b 44 24 48 65 48 2b 04 25 28 00 00 00 75 09 48 83 c4 50 c3 <0f> 0b eb cf e8 df 8c 75 00 66>
>> RSP: 0018:ffffb1f540d7fd40 EFLAGS: 00010246
>> RAX: 0000000000000000 RBX: ffff961185aa5488 RCX: 0000000000000000
>> RDX: 0000000000000002 RSI: 0000000000004be5 RDI: ffff9611b7220000
>> RBP: ffff961182209208 R08: ffff961184efc800 R09: 0000000000000140
>> R10: ffff9611859e6400 R11: ffff961192af3c10 R12: ffff961183891200
>> R13: ffff961185aa5000 R14: ffff961185aa5460 R15: ffff9611b65d5e10
>> FS:  00007f654b80e640(0000) GS:ffff9611fac00000(0000) knlGS:0000000000000000
>> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> CR2: 00007f654cf39010 CR3: 0000000003884000 CR4: 00000000003506f0
>> Call Trace:
>>   btrfs_commit_transaction+0x448/0xbc0 [btrfs]
>>   ? btrfs_wait_ordered_range+0x1b8/0x210 [btrfs]
>>   ? btrfs_sync_file+0x2b8/0x4e0 [btrfs]
>>   btrfs_sync_file+0x343/0x4e0 [btrfs]
>>   __x64_sys_fsync+0x34/0x60
>>   do_syscall_64+0x33/0x40
> 
> Normally you need to mount -o flushoncommit to trigger this warning.
> Maybe sync is triggering it too?

I've looked again and yes, this "special" filesystem is mounted 
flushoncommit and discard=async. Would it be better to not set these 
options, for now?

BR
