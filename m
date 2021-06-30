Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90F933B88A2
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Jun 2021 20:40:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233152AbhF3Smm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 30 Jun 2021 14:42:42 -0400
Received: from a4-3.smtp-out.eu-west-1.amazonses.com ([54.240.4.3]:37601 "EHLO
        a4-3.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233628AbhF3Smk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 30 Jun 2021 14:42:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=vbsgq4olmwpaxkmtpgfbbmccllr2wq3g; d=urbackup.org; t=1625078410;
        h=Subject:From:To:References:Message-ID:Date:MIME-Version:In-Reply-To:Content-Type:Content-Transfer-Encoding;
        bh=XYqfPZ/4N9DVr9qimH0OrJIJJV6hvwqD7Ikjo8/2CdY=;
        b=eilpbOUSWFxncYp3BR1MRLDV2aTDolA2MEx5ICfi0omqboQoMfJBJTNMCXrwGLTQ
        Od6G445VE5qu/4zxkqFeLgNreKkz+gSoa+Ccu6dIPgjJVyPLSgT2RDFZsYEMk3HexdH
        8GBny61Hy2ZxVbnFiOHj4QmPYNEb6sFsA9SMy8Q4=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=uku4taia5b5tsbglxyj6zym32efj7xqv; d=amazonses.com; t=1625078410;
        h=Subject:From:To:References:Message-ID:Date:MIME-Version:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID;
        bh=XYqfPZ/4N9DVr9qimH0OrJIJJV6hvwqD7Ikjo8/2CdY=;
        b=RPGj3QvLikV5v7/Sf9QfMhmtVXpfSYHFgXBwPUphAangajlZomO6c03TBGeN/8Rv
        tyqAme5Ly7jpe8eRjb2LWYI2n+0uJ8YOjv9xsX31owuVmte9r70j3uJR+DFGENvrm+H
        rDHob5rIb/3f5z7DRJzneWcXk047URLtWTRCYu0I=
Subject: Re: IO failure without other (device) error
From:   Martin Raiber <martin@urbackup.org>
To:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <010201795331ffe5-6933accd-b72f-45f0-be86-c2832b6fe306-000000@eu-west-1.amazonses.com>
 <0102017a1fead031-e0b49bda-297e-42f8-8fde-5567c5cfdec9-000000@eu-west-1.amazonses.com>
Message-ID: <0102017a5e38aa40-fb2774c8-5be1-4022-abfa-c59fe23f46a3-000000@eu-west-1.amazonses.com>
Date:   Wed, 30 Jun 2021 18:40:09 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <0102017a1fead031-e0b49bda-297e-42f8-8fde-5567c5cfdec9-000000@eu-west-1.amazonses.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Feedback-ID: 1.eu-west-1.zKMZH6MF2g3oUhhjaE2f3oQ8IBjABPbvixQzV8APwT0=:AmazonSES
X-SES-Outgoing: 2021.06.30-54.240.4.3
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 18.06.2021 18:18 Martin Raiber wrote:
> On 10.05.2021 00:14 Martin Raiber wrote:
>> I get this (rare) issue where btrfs reports an IO error in run_delayed_refs or finish_ordered_io with no underlying device errors being reported. This is with 5.10.26 but with a few patches like the pcpu ENOMEM fix or work-arounds for btrfs ENOSPC issues:
>>
>> [1885197.101981] systemd-sysv-generator[2324776]: SysV service '/etc/init.d/exim4' lacks a native systemd unit file. Automatically generating a unit file for compatibility. Please update package to include a native systemd unit file, in order to make it more safe and robust.
>> [2260628.156893] BTRFS: error (device dm-0) in btrfs_finish_ordered_io:2736: errno=-5 IO failure
>> [2260628.156980] BTRFS info (device dm-0): forced readonly
>>
>> This issue occured on two different machines now (on one twice). Both with ECC RAM. One bare metal (where dm-0 is on a NVMe) and one in a VM (where dm-0 is a ceph volume).
> Just got it again (5.10.43). So I guess the question is how can I trace where this error comes from... The error message points at btrfs_csum_file_blocks but nothing beyond that. Grep for EIO and put a WARN_ON at each location?
>
Added the WARN_ON -EIOs. And hit it. It points at read_extent_buffer_pages (this time), this part before unlock_exit:

    for (i = 0; i < num_pages; i++) {
        page = eb->pages[i];
        wait_on_page_locked(page);
        if (!PageUptodate(page))
            -->ret = -EIO;
    }

Complete dmesg output. In this instance it seems to not be able to read a csum. It doesn't go read only in this case... Maybe it should?

[Wed Jun 30 10:31:11 2021] systemd[1]: Started Journal Service.
[Wed Jun 30 10:43:22 2021] ------------[ cut here ]------------
[Wed Jun 30 10:43:22 2021] WARNING: CPU: 13 PID: 3965190 at fs/btrfs/extent_io.c:5597 read_extent_buffer_pages+0x346/0x360
[Wed Jun 30 10:43:22 2021] Modules linked in: zram bcache crc64 loop dm_crypt bfq xfs dm_mod st sr_mod cdrom bridge stp llc intel_powerclamp coretemp kvm_intel snd_pcm mgag200 snd_timer kvm snd drm_kms_helper iTCO_wdt soundcore dcdbas irqbypass serio_raw pcspkr joydev iTCO_vendor_support evdev i2c_algo_bit i7core_edac sg ipmi_si ipmi_devintf ipmi_msghandler wmi acpi_power_meter button ib_iser rdma_cm iw_cm ib_cm ib_core iscsi_tcp libiscsi_tcp libiscsi scsi_transport_iscsi drm configfs ip_tables x_tables autofs4 raid10 raid456 async_raid6_recov async_memcpy async_pq async_xor async_tx raid0 multipath linear raid1 md_mod ses enclosure sd_mod hid_generic usbhid hid crct10dif_pclmul crc32_pclmul crc32c_intel ghash_clmulni_intel aesni_intel crypto_simd ahci cryptd glue_helper libahci uhci_hcd ehci_pci psmouse mpt3sas ehci_hcd raid_class lpc_ich libata nvme scsi_transport_sas mfd_core nvme_core usbcore t10_pi scsi_mod bnx2
[Wed Jun 30 10:43:22 2021] CPU: 13 PID: 3965190 Comm: io_wqe_worker-0 Tainted: G          I       5.10.44 #1
[Wed Jun 30 10:43:22 2021] Hardware name: Dell Inc. PowerEdge R510/0DPRKF, BIOS 1.13.0 03/02/2018
[Wed Jun 30 10:43:22 2021] RIP: 0010:read_extent_buffer_pages+0x346/0x360
[Wed Jun 30 10:43:22 2021] Code: 48 8b 43 08 a8 01 48 8d 78 ff 48 0f 44 fb 31 f6 e8 8f d5 db ff 48 8b 43 08 48 8d 50 ff a8 01 48 0f 45 da 48 8b 03 a8 04 75 ab <0f> 0b 41 be fb ff ff ff eb a1 e8 5b a2 56 00 66 66 2e 0f 1f 84 00
[Wed Jun 30 10:43:22 2021] RSP: 0018:ffffc900215ab5f0 EFLAGS: 00010246
[Wed Jun 30 10:43:22 2021] RAX: 06ffff80000020a3 RBX: ffffea0008a1b680 RCX: 0000000000000000
[Wed Jun 30 10:43:22 2021] RDX: dead0000000000ff RSI: ffffc900215ab588 RDI: ffffffff82208780
[Wed Jun 30 10:43:22 2021] RBP: ffff88844c924d68 R08: 000000000000000d R09: 00000000000003bb
[Wed Jun 30 10:43:22 2021] R10: 0000000000000001 R11: 0000000000000000 R12: ffff88844c924e10
[Wed Jun 30 10:43:22 2021] R13: ffffea00091094c0 R14: 0000000000000000 R15: ffff88844c924e10
[Wed Jun 30 10:43:22 2021] FS:  0000000000000000(0000) GS:ffff888713b80000(0000) knlGS:0000000000000000
[Wed Jun 30 10:43:22 2021] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[Wed Jun 30 10:43:22 2021] CR2: 00007f4c7a7fb00a CR3: 000000012f1ba003 CR4: 00000000000206e0
[Wed Jun 30 10:43:22 2021] Call Trace:
[Wed Jun 30 10:43:22 2021]  btree_read_extent_buffer_pages+0x9f/0x110
[Wed Jun 30 10:43:22 2021]  read_tree_block+0x36/0x60
[Wed Jun 30 10:43:22 2021]  read_block_for_search.isra.0+0x1ab/0x360
[Wed Jun 30 10:43:22 2021]  btrfs_search_slot+0x232/0x970
[Wed Jun 30 10:43:22 2021]  btrfs_lookup_csum+0x75/0x170
[Wed Jun 30 10:43:22 2021]  btrfs_lookup_bio_sums+0x23a/0x620
[Wed Jun 30 10:43:22 2021]  btrfs_submit_compressed_read+0x44f/0x4e0
[Wed Jun 30 10:43:22 2021]  btrfs_submit_data_bio+0x170/0x180
[Wed Jun 30 10:43:22 2021]  submit_one_bio+0x44/0x70
[Wed Jun 30 10:43:22 2021]  extent_readahead+0x374/0x3a0
[Wed Jun 30 10:43:22 2021]  ? xas_load+0x5/0x70
[Wed Jun 30 10:43:22 2021]  ? xa_get_order+0x93/0xd0
[Wed Jun 30 10:43:22 2021]  ? __mod_memcg_lruvec_state+0x21/0xe0
[Wed Jun 30 10:43:22 2021]  ? __add_to_page_cache_locked+0x19d/0x3f0
[Wed Jun 30 10:43:22 2021]  read_pages+0x83/0x1e0
[Wed Jun 30 10:43:22 2021]  page_cache_ra_unbounded+0x1aa/0x1f0
[Wed Jun 30 10:43:22 2021]  ? find_get_entry+0xd5/0x140
[Wed Jun 30 10:43:22 2021]  force_page_cache_ra+0xdc/0x140
[Wed Jun 30 10:43:22 2021]  generic_file_buffered_read+0x5d9/0x8e0
[Wed Jun 30 10:43:22 2021]  btrfs_file_read_iter+0x38/0xc0
[Wed Jun 30 10:43:22 2021]  generic_file_splice_read+0xfc/0x1b0
[Wed Jun 30 10:43:22 2021]  do_splice+0x670/0x720
[Wed Jun 30 10:43:22 2021]  io_issue_sqe+0xde7/0xfa0
[Wed Jun 30 10:43:22 2021]  ? pick_next_task_fair+0x32/0x380
[Wed Jun 30 10:43:22 2021]  ? __switch_to+0x7b/0x3d0
[Wed Jun 30 10:43:22 2021]  io_wq_submit_work+0x50/0x1a0
[Wed Jun 30 10:43:22 2021]  io_worker_handle_work+0x1a1/0x570
[Wed Jun 30 10:43:22 2021]  io_wqe_worker+0x2c1/0x360
[Wed Jun 30 10:43:22 2021]  ? io_worker_handle_work+0x570/0x570
[Wed Jun 30 10:43:22 2021]  kthread+0x11b/0x140
[Wed Jun 30 10:43:22 2021]  ? __kthread_bind_mask+0x60/0x60
[Wed Jun 30 10:43:22 2021]  ret_from_fork+0x1f/0x30
[Wed Jun 30 10:43:22 2021] ---[ end trace 32a38f7d02f704b2 ]---
[Wed Jun 30 10:43:22 2021] BTRFS info (device dm-0): no csum found for inode 23468615 start 10428416
[Wed Jun 30 10:43:22 2021] BTRFS warning (device dm-0): csum failed root 1571 ino 23468615 off 586692173824 csum 0xc0a0c537 expected csum 0x00000000 mirror 1
[Wed Jun 30 10:43:22 2021] BTRFS error (device dm-0): bdev /dev/mapper/LUKS-RC-75aba4438f084377be2fc6d7d1f8eba0 errs: wr 0, rd 0, flush 0, corrupt 2, gen 0

