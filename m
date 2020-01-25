Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E6890149558
	for <lists+linux-btrfs@lfdr.de>; Sat, 25 Jan 2020 12:49:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726194AbgAYLqw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 25 Jan 2020 06:46:52 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:33325 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726146AbgAYLqw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 25 Jan 2020 06:46:52 -0500
Received: by mail-lj1-f195.google.com with SMTP id y6so5587267lji.0
        for <linux-btrfs@vger.kernel.org>; Sat, 25 Jan 2020 03:46:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Bleh9B/5iqqh299uX3kVKkH1RaAnGF7lhJqrUoW/L90=;
        b=hRBvvew3OwAHEN+O+sXbFEXE6ak+5o+MIOBSN3nYbAlZllT4/6I0XBML4GsDJo/q94
         KL6pfDdT+i9fuFs/mtDSnVjV+MzaWzn4751YAIea7BDcDQPYMlpaXroOdPSU/r8IRg5P
         adtHci+y3+imh46UZJBhpUtuxtXhuaTV+9Hs6wSE7/RKSgUo0tKyOLy5AFXLnFlaZM1s
         TmuU+qVXm1StLv0pGLzWWSqeQL1yky5AcXxdNHFOtRdR6ZRijUX5Td21Nqknt1jnbEzR
         A45XHgtn52tOq8CjXWSAbeORHCSyfinAkJOFJcK4uzIb3o0JlEuel5f70VdsT8oWiYuY
         DBPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:autocrypt:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Bleh9B/5iqqh299uX3kVKkH1RaAnGF7lhJqrUoW/L90=;
        b=hD5pcEfY52yirDWXZw9nprMcsDTFH4i03H1eMa0328dV0nbIBXJx7FkD+0NVa2z4dk
         NtmYoU0xT+V/MtBawJb+/UKYdlXWlq1k/Qrim6dH9ZomlxDooqMXIj8gu91KwzFbSnEw
         iDGQmXQq+agcuHaYCGiajn3QyBBdQnK1MI9KPUdkle7pAZGQsfrcIYhccA2k+dgLW1g4
         jwIiLWdYlfcesHvr20/uvAJHCAvdDiZs4GHFiJRRz0EHSyvkQ35bz8uxBbfnbL5fTMMk
         WXxofviYa+9n8zFbbSnqn5Fz32qRN8nPUJ/PgYGyP7VjD2PC6ublZJ4KbtrNRe2UxxLs
         KOaA==
X-Gm-Message-State: APjAAAW+1c3ghvvgrtbgRMP2R47rIV+wg+UC1FJszy+BfnR++Fcvk3C9
        DMhKwOHmP3/VJLyqQFxcRcy9Hv0koro=
X-Google-Smtp-Source: APXvYqwJ2WTiWfepzV5KM4ACS59v2SQy2eSttRfM17t8qBtP3AxcuWIhz/qYvuibll69EC6GhvYItQ==
X-Received: by 2002:a2e:b054:: with SMTP id d20mr5068444ljl.190.1579952809891;
        Sat, 25 Jan 2020 03:46:49 -0800 (PST)
Received: from ?IPv6:2a00:1370:812d:af15:a51e:b905:dd2b:45cf? ([2a00:1370:812d:af15:a51e:b905:dd2b:45cf])
        by smtp.gmail.com with ESMTPSA id h19sm4620940ljl.57.2020.01.25.03.46.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 Jan 2020 03:46:48 -0800 (PST)
Subject: Re: tree first key mismatch detected (reproducible error)
To:     Thorsten Hirsch <t.hirsch@web.de>, linux-btrfs@vger.kernel.org
References: <CAH+WbHxsOEt9Z7t=ubtCmoCb2f4nDpMCCSXnT+-k5oR2pQFpOQ@mail.gmail.com>
From:   Andrei Borzenkov <arvidjaar@gmail.com>
Autocrypt: addr=arvidjaar@gmail.com; prefer-encrypt=mutual; keydata=
 xsDiBDxiRwwRBAC3CN9wdwpVEqUGmSoqF8tWVIT4P/bLCSZLkinSZ2drsblKpdG7x+guxwts
 +LgI8qjf/q5Lah1TwOqzDvjHYJ1wbBauxZ03nDzSLUhD4Ms1IsqlIwyTLumQs4vcQdvLxjFs
 G70aDglgUSBogtaIEsiYZXl4X0j3L9fVstuz4/wXtwCg1cN/yv/eBC0tkcM1nsJXQrC5Ay8D
 /1aA5qPticLBpmEBxqkf0EMHuzyrFlqVw1tUjZ+Ep2LMlem8malPvfdZKEZ71W1a/XbRn8FE
 SOp0tUa5GwdoDXgEp1CJUn+WLurR0KPDf01E4j/PHHAoABgrqcOTcIVoNpv2gNiBySVsNGzF
 XTeY/Yd6vQclkqjBYONGN3r9R8bWA/0Y1j4XK61qjowRk3Iy8sBggM3PmmNRUJYgroerpcAr
 2byz6wTsb3U7OzUZ1Llgisk5Qum0RN77m3I37FXlIhCmSEY7KZVzGNW3blugLHcfw/HuCB7R
 1w5qiLWKK6eCQHL+BZwiU8hX3dtTq9d7WhRW5nsVPEaPqudQfMSi/Ux1kc0mQW5kcmVpIEJv
 cnplbmtvdiA8YXJ2aWRqYWFyQGdtYWlsLmNvbT7CZQQTEQIAJQIbAwYLCQgHAwIGFQgCCQoL
 BBYCAwECHgECF4AFAliWAiQCGQEACgkQR6LMutpd94wFGwCeNuQnMDxve/Fo3EvYIkAOn+zE
 21cAnRCQTXd1hTgcRHfpArEd/Rcb5+SczsBNBDxiRyQQBACQtME33UHfFOCApLki4kLFrIw1
 5A5asua10jm5It+hxzI9jDR9/bNEKDTKSciHnM7aRUggLwTt+6CXkMy8an+tVqGL/MvDc4/R
 KKlZxj39xP7wVXdt8y1ciY4ZqqZf3tmmSN9DlLcZJIOT82DaJZuvr7UJ7rLzBFbAUh4yRKaN
 nwADBwQAjNvMr/KBcGsV/UvxZSm/mdpvUPtcw9qmbxCrqFQoB6TmoZ7F6wp/rL3TkQ5UElPR
 gsG12+Dk9GgRhnnxTHCFgN1qTiZNX4YIFpNrd0au3W/Xko79L0c4/49ten5OrFI/psx53fhY
 vLYfkJnc62h8hiNeM6kqYa/x0BEddu92ZG7CRgQYEQIABgUCPGJHJAAKCRBHosy62l33jMhd
 AJ48P7WDvKLQQ5MKnn2D/TI337uA/gCgn5mnvm4SBctbhaSBgckRmgSxfwQ=
Message-ID: <688e0961-c80e-4db0-bf87-dabbfc72adf1@gmail.com>
Date:   Sat, 25 Jan 2020 14:46:48 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAH+WbHxsOEt9Z7t=ubtCmoCb2f4nDpMCCSXnT+-k5oR2pQFpOQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

25.01.2020 14:37, Thorsten Hirsch пишет:
> Hi, here's a btrfs problem that started happening today on my main computer:
> 
> BTRFS error (device nvme0n1p3): tree first key mismatch detected,
> bytenr=109690880 parent_transid=1329869 key
> expected=(48044838912,168,12288) has=(48045363200,168,12288)
> 

This looks like bit flip

48044838912 == B2FB21000
48045363200 == B2FBA1000

with usual recommendation to check your RAM.

> It always occurs some minutes after booting, sometimes even seconds
> after booting. The partition is then remounted read-only. I already
> tried scrubbing the partition (aborts itself after some seconds) and
> balancing (seems to trigger the error immediately and doesn't even
> start).
> 
> I attached some more output of dmesg. The distribution is Arch Linux
> and the kernel is the most recent one in Arch's default kernel
> package: 5.4.14-arch1-1 (I upgraded from 5.4.13 to 5.4.14 just
> yesterday).
> 
> Best regards,
> Thorsten
> 
> [Jan25 12:00] BTRFS error (device nvme0n1p3): tree first key mismatch
> detected, bytenr=109690880 parent_transid=1329869 key
> expected=(48044838912,168,12288) has=(48045363200,168,12288)
> [  +0,000003] ------------[ cut here ]------------
> [  +0,000001] BTRFS: Transaction aborted (error -117)
> [  +0,000041] WARNING: CPU: 7 PID: 382 at fs/btrfs/extent-tree.c:3080
> __btrfs_free_extent.isra.0+0x694/0x9e0 [btrfs]
> [  +0,000000] Modules linked in: xt_nat xt_tcpudp veth xt_conntrack
> xt_MASQUERADE nf_conntrack_netlink nfnetlink xfrm_user xfrm_algo
> xt_addrtype iptable_filter iptable_nat nf_nat nf_conntrack
> nf_defrag_ipv6 nf_defrag_ipv4 br_netfilter bridge stp llc edac_mce_amd
> kvm_amd snd_hda_codec_ca0110 snd_hda_codec_generic wmi_bmof kvm
> ledtrig_audio snd_hda_codec_hdmi snd_hda_intel snd_intel_nhlt pktcdvd
> irqbypass snd_hda_codec uvcvideo snd_hda_core snd_hwdep
> videobuf2_vmalloc snd_pcm videobuf2_memops nls_iso8859_1
> videobuf2_v4l2 nls_cp437 videobuf2_common snd_timer crct10dif_pclmul
> vfat crc32_pclmul videodev fat snd joydev ghash_clmulni_intel
> input_leds mousedev mc psmouse aesni_intel r8169 crypto_simd realtek
> cryptd ccp glue_helper k10temp i2c_piix4 soundcore libphy rng_core wmi
> gpio_amdpt evdev mac_hid pinctrl_amd acpi_cpufreq fuse vboxnetflt(OE)
> vboxnetadp(OE) vboxdrv(OE) sg crypto_user ip_tables x_tables sr_mod
> cdrom sd_mod hid_generic usbhid hid serio_raw atkbd libps2 ahci
> libahci libata xhci_pci
> [  +0,000018]  xhci_hcd scsi_mod i8042 serio amdgpu gpu_sched
> i2c_algo_bit ttm drm_kms_helper syscopyarea sysfillrect sysimgblt
> fb_sys_fops drm agpgart btrfs libcrc32c crc32c_generic crc32c_intel
> xor raid6_pq
> [  +0,000005] CPU: 7 PID: 382 Comm: btrfs-transacti Tainted: G
>   OE     5.4.14-arch1-1 #1
> [  +0,000001] Hardware name: Gigabyte Technology Co., Ltd.
> AB350M-DS3H/AB350M-DS3H-CF, BIOS F50a 11/27/2019
> [  +0,000010] RIP: 0010:__btrfs_free_extent.isra.0+0x694/0x9e0 [btrfs]
> [  +0,000001] Code: e8 c1 ee 00 00 8b 4c 24 38 85 c9 0f 84 39 fe ff ff
> 48 8b 54 24 48 e9 04 fe ff ff 44 89 fe 48 c7 c7 a0 ce 30 c0 e8 ba 48
> c4 d1 <0f> 0b 48 8b 3c 24 44 89 f9 ba 08 0c 00 00 48 c7 c6 a0 20 30 c0
> e8
> [  +0,000001] RSP: 0018:ffff8fc081363ba0 EFLAGS: 00010286
> [  +0,000001] RAX: 0000000000000000 RBX: 0000000000000192 RCX: 0000000000000000
> [  +0,000000] RDX: 0000000000000001 RSI: 0000000000000096 RDI: 00000000ffffffff
> [  +0,000001] RBP: 0000000b3090a000 R08: 000000000000049b R09: 0000000000000004
> [  +0,000000] R10: 0000000000000000 R11: 0000000000000001 R12: ffff8b958a1c9c40
> [  +0,000001] R13: 0000000000000000 R14: 0000000000000001 R15: 00000000ffffff8b
> [  +0,000001] FS:  0000000000000000(0000) GS:ffff8b958e9c0000(0000)
> knlGS:0000000000000000
> [  +0,000000] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  +0,000001] CR2: 00007fdcf263d000 CR3: 000000032f11a000 CR4: 00000000003406e0
> [  +0,000001] Call Trace:
> [  +0,000012]  ? __btrfs_run_delayed_refs+0xc9f/0xff0 [btrfs]
> [  +0,000009]  __btrfs_run_delayed_refs+0x25e/0xff0 [btrfs]
> [  +0,000011]  btrfs_run_delayed_refs+0x6a/0x180 [btrfs]
> [  +0,000013]  btrfs_start_dirty_block_groups+0x28e/0x470 [btrfs]
> [  +0,000011]  btrfs_commit_transaction+0x116/0x9b0 [btrfs]
> [  +0,000003]  ? _raw_spin_unlock+0x16/0x30
> [  +0,000010]  ? join_transaction+0x108/0x3a0 [btrfs]
> [  +0,000010]  transaction_kthread+0x13a/0x180 [btrfs]
> [  +0,000002]  kthread+0xfb/0x130
> [  +0,000010]  ? btrfs_cleanup_transaction+0x560/0x560 [btrfs]
> [  +0,000001]  ? kthread_park+0x90/0x90
> [  +0,000001]  ret_from_fork+0x1f/0x40
> [  +0,000002] ---[ end trace 51366456523028bd ]---
> [  +0,000001] BTRFS: error (device nvme0n1p3) in
> __btrfs_free_extent:3080: errno=-117 unknown
> [  +0,000001] BTRFS info (device nvme0n1p3): forced readonly
> [  +0,000002] BTRFS: error (device nvme0n1p3) in
> btrfs_run_delayed_refs:2188: errno=-117 unknown
> 

