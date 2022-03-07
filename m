Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F057F4CF2EB
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Mar 2022 08:49:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235969AbiCGHtx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Mar 2022 02:49:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235960AbiCGHts (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 7 Mar 2022 02:49:48 -0500
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E96D833E0D
        for <linux-btrfs@vger.kernel.org>; Sun,  6 Mar 2022 23:48:52 -0800 (PST)
Received: by mail-lj1-x231.google.com with SMTP id bn33so19109822ljb.6
        for <linux-btrfs@vger.kernel.org>; Sun, 06 Mar 2022 23:48:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=kaWJC+zwtgNL2kzEHWh+lqiQ0NwOKZHTUKl/gTVAdGI=;
        b=ckmaTbrmiCAkoXx0NjaAFaJ9r2qbhNlR9Pl3ncQUr+9D9HHV+0ey2O/esRqRUO1Vn7
         miTaJFaXScFoefMbptHGM4w834UsvcbJpTsEJZsTMFD65vVpsyIQNxmEQnGdy/W957Oa
         ljsj44ddBLp3KY7DR1jmBDWOQBiyMNnUsnwSyk6SWTR0jgjPeco1AvSqFypcloROr6ca
         OVE91vR9PKmrKQbPYJIi7QQmKjzNtUMp7w1rwl0iQCuW/mlpXhpWgQNoZZshvF+b61PF
         crFta0c5yZD6bb39czImxGz+HlaY8ACg+1GQ2gssDsWoEK2SRN763sSAINOidvhhIk++
         cP5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=kaWJC+zwtgNL2kzEHWh+lqiQ0NwOKZHTUKl/gTVAdGI=;
        b=DMWtGmf7DSfdwsGVfyo8gshVww2HYmDUvJ3GjeXxgc73JzeSgNTu+650frmXbSD4Om
         C5msOKGpa+zIsothtbtYW6DD6rx04pXAe44YPu9xxMgjOlyuo06BQ5zQ1sN9jaz2DGMA
         rBB+1o9mdmiSw1n9qUyajTfdZTwUZld9E5nTuQYJIb9Vu5o75aV9VlS7vOWUedQZw1Ok
         TrtPqlDLQGpUIosEVD4Vmiz+wvjMKBXDGYbp6Ms0vrGi+UL4pMac4EAz1qtlSB6u04oM
         J66+Sya66cBzCs3vJ34VwRhUU/vBHCzLc7JCVBgaXS9gyybJ7eFfOAniNfueu278lJ30
         nvuw==
X-Gm-Message-State: AOAM5334skl6FcUFKRLVijPdS7KUC5lPzhjt1ap7Soa2Vo2ccqVffoYA
        9O0OzcoDO0SRSsaKAuPT3JBWUi+ZZrZGPExk
X-Google-Smtp-Source: ABdhPJx3LC2MWQ6WBvqHIgD7sOVv8lNijbO6p1LtAY4SPJdcrCSC48UpCkTrvbddNSmIuebIVY/Gsg==
X-Received: by 2002:a05:651c:1548:b0:247:b6e5:a6fc with SMTP id y8-20020a05651c154800b00247b6e5a6fcmr6900853ljp.125.1646639331170;
        Sun, 06 Mar 2022 23:48:51 -0800 (PST)
Received: from ?IPV6:2a00:1370:8182:3ffd:fa46:42b2:52e1:1c7d? ([2a00:1370:8182:3ffd:fa46:42b2:52e1:1c7d])
        by smtp.gmail.com with ESMTPSA id p16-20020a05651211f000b00443423ce6a2sm2700869lfs.127.2022.03.06.23.48.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Mar 2022 23:48:50 -0800 (PST)
Message-ID: <c8da340d-053d-ee69-b73d-e3412470c208@gmail.com>
Date:   Mon, 7 Mar 2022 10:48:49 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: Error encountered when working with loop devices on zoned btrfs
Content-Language: en-US
To:     April Kolwey <cheapiephp@gmail.com>, linux-btrfs@vger.kernel.org
References: <CAFkGwLgySb_Bs_e-Ou+58o4Y4W7QGBCRk0aqZ8kk9LqRqGiBdA@mail.gmail.com>
From:   Andrei Borzenkov <arvidjaar@gmail.com>
In-Reply-To: <CAFkGwLgySb_Bs_e-Ou+58o4Y4W7QGBCRk0aqZ8kk9LqRqGiBdA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 06.03.2022 06:24, April Kolwey wrote:
> Hi,
> I have a box here running 5.17-rc4 (slightly old, I know - but I don't
> think anything relevant has been touched since then) with btrfs in
> zoned mode running on an HM-SMR SATA hard drive. It's mostly been
> working fine, but I managed to get it to act up earlier today when I
> was doing some rather strange activities. Specifically, I had the
> following set up:
> * FS mounted as normal, no special options, not at /
> * Three 2TB sparse files (created with the "truncate" command)
> present, alongside other unrelated data
> * Three loop devices created, one backed by each of these files
> * A 4-disk md RAID 6 array (operating in degraded mode with the 4th
> disk missing) on top of these three loop devices, and the initial sync
> already having completed
> * The array formatted with a GPT partition table and ext4
> * This ext4 FS mounted at another mount point
> * A large (~700GB) file being copied from the btrfs volume to this ext4 one
> 
> This ran OK for a while, then suddenly went read-only with the
> following errors appearing in dmesg:
> 
> [686057.758230] BTRFS info (device sda): reclaiming chunk
> 6369168064512 with 20% used 79% unusable
> [686057.758254] BTRFS info (device sda): relocating block group
> 6369168064512 flags data
> [686059.334968] ------------[ cut here ]------------
> [686059.334974] WARNING: CPU: 5 PID: 454656 at
> fs/btrfs/extent-tree.c:2389 btrfs_cross_ref_exist+0x9a/0xb0 [btrfs]
> [686059.335006] Modules linked in: ext4 crc16 mbcache jbd2 uas
> usb_storage loop vhost_net tun vhost vhost_iotlb macvtap macvlan tap
> dm_zoned rpcsec_gss_krb5 auth_rpcgss nfnetlink nfsv4 cpufreq_userspace
> cpufreq_powersave cpufreq_ondemand cpufreq_conservative dns_resolver
> nfs lockd scsi_transport_iscsi grace fscache netfs tcm_loop
> iscsi_target_mod rfkill target_core_user qrtr uio target_core_mod
> sunrpc binfmt_misc nls_ascii nls_cp437 vfat fat intel_rapl_msr
> intel_rapl_common edac_mce_amd snd_hda_codec_realtek kvm_amd
> snd_hda_codec_generic ledtrig_audio snd_hda_codec_hdmi kvm
> snd_hda_intel snd_intel_dspcfg snd_intel_sdw_acpi snd_hda_codec
> irqbypass snd_hda_core snd_hwdep snd_pcm rapl joydev wmi_bmof
> efi_pstore snd_timer sp5100_tco watchdog k10temp evdev snd ccp
> soundcore rng_core sg button acpi_cpufreq nct6775 hwmon_vid parport_pc
> ppdev lp parport fuse configfs ip_tables x_tables autofs4 btrfs
> blake2b_generic zstd_compress efivarfs raid10 raid456
> async_raid6_recov async_memcpy async_pq
> [686059.335042]  async_xor async_tx xor raid6_pq libcrc32c
> crc32c_generic raid1 raid0 multipath linear md_mod dm_mirror
> dm_region_hash dm_log dm_mod hid_logitech_hidpp hid_logitech_dj amdgpu
> hid_generic drm_ttm_helper usbhid hid ttm sd_mod gpu_sched
> i2c_algo_bit drm_kms_helper crc32_pclmul crc32c_intel ahci cec rc_core
> libahci xhci_pci ghash_clmulni_intel xhci_hcd libata nvme usbcore drm
> scsi_mod aesni_intel nvme_core r8169 t10_pi crc_t10dif realtek
> crct10dif_generic crypto_simd mdio_devres crct10dif_pclmul gpio_amdpt
> cryptd libphy i2c_piix4 usb_common scsi_common crct10dif_common wmi
> gpio_generic
> [686059.335071] CPU: 5 PID: 454656 Comm: kworker/u64:27 Tainted: G
>    W         5.17.0-rc4-amd64 #1  Debian 5.17~rc4-1~exp1
> [686059.335074] Hardware name: To Be Filled By O.E.M. To Be Filled By
> O.E.M./B450M Pro4, BIOS P3.50 07/18/2019
> [686059.335076] Workqueue: writeback wb_workfn (flush-btrfs-5)
> [686059.335080] RIP: 0010:btrfs_cross_ref_exist+0x9a/0xb0 [btrfs]
> [686059.335104] Code: 89 44 24 04 e8 87 21 ff ff 48 83 bb f7 01 00 00
> f7 8b 44 24 04 75 04 85 c0 7f 0f 48 83 c4 08 5b 5d 41 5c 41 5d 41 5e
> 41 5f c3 <0f> 0b eb ed b8 f4 ff ff ff eb e6 66 66 2e 0f 1f 84 00 00 00
> 00 00
> [686059.335105] RSP: 0018:ffffadd943ba77c8 EFLAGS: 00010202
> [686059.335107] RAX: 0000000000000001 RBX: ffff979c83be3000 RCX:
> 000001a42bf1a005
> [686059.335108] RDX: 000001a42bf18005 RSI: 9fbeed0512c619c0 RDI:
> 00000000000398b0
> [686059.335109] RBP: 00000000000001f2 R08: ffff979cbf494bc0 R09:
> 0000000000000001
> [686059.335110] R10: ffff979ba29d9a10 R11: 0000000000000001 R12:
> 0000000008d1f000
> [686059.335111] R13: 000007c51fcc3000 R14: 0000000000000000 R15:
> ffff979ba29d9a10
> [686059.335113] FS:  0000000000000000(0000) GS:ffff97ab5e940000(0000)
> knlGS:0000000000000000
> [686059.335114] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [686059.335115] CR2: 0000563262f65240 CR3: 000000011156e000 CR4:
> 00000000003506e0
> [686059.335116] Call Trace:
> [686059.335120]  <TASK>
> [686059.335122]  run_delalloc_nocow+0x456/0x970 [btrfs]
> [686059.335149]  btrfs_run_delalloc_range+0x6f/0x650 [btrfs]
> [686059.335174]  writepage_delalloc+0xc1/0x180 [btrfs]
> [686059.335201]  __extent_writepage+0x139/0x350 [btrfs]
> [686059.335229]  extent_write_cache_pages+0x260/0x410 [btrfs]
> [686059.335256]  extent_writepages+0x7a/0x140 [btrfs]
> [686059.335283]  do_writepages+0xcf/0x1c0
> [686059.335287]  __writeback_single_inode+0x41/0x340
> [686059.335290]  writeback_sb_inodes+0x1fc/0x480
> [686059.335293]  __writeback_inodes_wb+0x4c/0xe0
> [686059.335295]  wb_writeback+0x1d7/0x2c0
> [686059.335298]  wb_workfn+0x2e7/0x510
> [686059.335299]  ? psi_task_switch+0xbc/0x1f0
> [686059.335302]  ? _raw_spin_unlock+0x16/0x30
> [686059.335305]  process_one_work+0x1e5/0x3b0
> [686059.335307]  worker_thread+0x50/0x3a0
> [686059.335309]  ? rescuer_thread+0x390/0x390
> [686059.335310]  kthread+0xe7/0x110
> [686059.335312]  ? kthread_complete_and_exit+0x20/0x20
> [686059.335314]  ret_from_fork+0x22/0x30
> [686059.335318]  </TASK>
> [686059.335318] ---[ end trace 0000000000000000 ]---
> [686059.569331] ata6.00: exception Emask 0x0 SAct 0x79fe060 SErr 0x0 action 0x0
> [686059.569338] ata6.00: irq_stat 0x40000008
> [686059.569342] ata6.00: failed command: WRITE FPDMA QUEUED
> [686059.569344] ata6.00: cmd 61/a8:c0:6b:fd:2d/00:00:7a:00:00/40 tag
> 24 ncq dma 688128 out
>                          res 43/04:a8:6b:fd:2d/00:00:7a:00:00/00 Emask
> 0x400 (NCQ error) <F>
> [686059.569351] ata6.00: status: { DRDY SENSE ERR }
> [686059.569353] ata6.00: error: { ABRT }
> [686059.611703] ata6.00: configured for UDMA/133
> [686059.611800] sd 5:0:0:0: [sda] tag#24 FAILED Result:
> hostbyte=DID_OK driverbyte=DRIVER_OK cmd_age=0s
> [686059.611805] sd 5:0:0:0: [sda] tag#24 Sense Key : Illegal Request [current]
> [686059.611809] sd 5:0:0:0: [sda] tag#24 Add. Sense: Unaligned write command

...

> 
> This continued on for quite some time with the loop devices, md, and
> ext4 all complaining of write errors due to btrfs having gone
> read-only. I don't believe this is a hardware error as after stopping
> the array and remounting the zoned drive rw again, I was able to
> continue normal use. However, if this is suspected then I am willing
> to run a full test on this drive if needed.
> 

Well, something sends command to drive that drive does not accept. I
cannot tell whether this is btrfs or lower layers.

So you are right, it does not look like hardware error.
