Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29D423C16EB
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 Jul 2021 18:14:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229580AbhGHQRR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 8 Jul 2021 12:17:17 -0400
Received: from a4-2.smtp-out.eu-west-1.amazonses.com ([54.240.4.2]:56267 "EHLO
        a4-2.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229553AbhGHQRR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 8 Jul 2021 12:17:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=vbsgq4olmwpaxkmtpgfbbmccllr2wq3g; d=urbackup.org; t=1625760874;
        h=Subject:To:References:From:Message-ID:Date:MIME-Version:In-Reply-To:Content-Type:Content-Transfer-Encoding;
        bh=v5TrdRD8u5ib3ScvKsWKCVQ305RLRyPYaAnwFPuCe8A=;
        b=oh8ryhj4V6lUpFTh7gaUU9YRX4nY6QkndVh/71yCCofM1C6hhpW5e8M4d4WiQuDS
        CFfLU5c/SHfRHZxEnu4NDg5phY2WANAo7csXvveBAnFZDI0mKIWbbJxPSrAYcByCXCE
        krWDPyFCvJzGF5crUJjBaVy0+gxCPwBYgrh+hL08=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=uku4taia5b5tsbglxyj6zym32efj7xqv; d=amazonses.com; t=1625760874;
        h=Subject:To:References:From:Message-ID:Date:MIME-Version:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID;
        bh=v5TrdRD8u5ib3ScvKsWKCVQ305RLRyPYaAnwFPuCe8A=;
        b=M0eBkHmxd1WWTPYOIn7YojE5hcixHDyuH5KNRFYropIcZGm6eESXWKzCJ8J8QpoD
        9jwLpTOSpoA/MKV9ufpnHu4XeX2CswAKpSMoYApWvnMNDrMobsk5fdquuY4b/bdi6Sy
        MsQ67Xi/ww+iF+i4uPp0QoZI/ue61kltOvDuOLzM=
Subject: Re: IO failure without other (device) error
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <010201795331ffe5-6933accd-b72f-45f0-be86-c2832b6fe306-000000@eu-west-1.amazonses.com>
 <0102017a1fead031-e0b49bda-297e-42f8-8fde-5567c5cfdec9-000000@eu-west-1.amazonses.com>
 <0102017a5e38aa40-fb2774c8-5be1-4022-abfa-c59fe23f46a3-000000@eu-west-1.amazonses.com>
 <4e6c3598-92b4-30d6-3df8-6b70badbd893@gmx.com>
 <0102017a631abd46-c29f6d05-e5b2-44b1-a945-53f43026154f-000000@eu-west-1.amazonses.com>
 <6422009e-be80-f753-2243-2a13178a1763@gmx.com>
 <0102017a680d637c-4a958f96-dd8b-433d-84a6-8fc6a84abf47-000000@eu-west-1.amazonses.com>
 <a5357b44-6c1c-3174-a76c-09f01802386a@gmx.com>
From:   Martin Raiber <martin@urbackup.org>
Message-ID: <0102017a86e63e18-a5023d15-0b20-43e8-b71c-6dd241451179-000000@eu-west-1.amazonses.com>
Date:   Thu, 8 Jul 2021 16:14:34 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <a5357b44-6c1c-3174-a76c-09f01802386a@gmx.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Feedback-ID: 1.eu-west-1.zKMZH6MF2g3oUhhjaE2f3oQ8IBjABPbvixQzV8APwT0=:AmazonSES
X-SES-Outgoing: 2021.07.08-54.240.4.2
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 03.07.2021 00:46 Qu Wenruo wrote:
>
>
> On 2021/7/3 上午12:29, Martin Raiber wrote:
>> On 02.07.2021 00:19 Qu Wenruo wrote:
>>>
>>>
>>> On 2021/7/2 上午1:25, Martin Raiber wrote:
>>>> On 01.07.2021 03:40 Qu Wenruo wrote:
>>>>>
>>>>>
>>>>> On 2021/7/1 上午2:40, Martin Raiber wrote:
>>>>>> On 18.06.2021 18:18 Martin Raiber wrote:
>>>>>>> On 10.05.2021 00:14 Martin Raiber wrote:
>>>>>>>> I get this (rare) issue where btrfs reports an IO error in run_delayed_refs or finish_ordered_io with no underlying device errors being reported. This is with 5.10.26 but with a few patches like the pcpu ENOMEM fix or work-arounds for btrfs ENOSPC issues:
>>>>>>>>
>>>>>>>> [1885197.101981] systemd-sysv-generator[2324776]: SysV service '/etc/init.d/exim4' lacks a native systemd unit file. Automatically generating a unit file for compatibility. Please update package to include a native systemd unit file, in order to make it more safe and robust.
>>>>>>>> [2260628.156893] BTRFS: error (device dm-0) in btrfs_finish_ordered_io:2736: errno=-5 IO failure
>>>>>>>> [2260628.156980] BTRFS info (device dm-0): forced readonly
>>>>>>>>
>>>>>>>> This issue occured on two different machines now (on one twice). Both with ECC RAM. One bare metal (where dm-0 is on a NVMe) and one in a VM (where dm-0 is a ceph volume).
>>>>>>> Just got it again (5.10.43). So I guess the question is how can I trace where this error comes from... The error message points at btrfs_csum_file_blocks but nothing beyond that. Grep for EIO and put a WARN_ON at each location?
>>>>>>>
>>>>>> Added the WARN_ON -EIOs. And hit it. It points at read_extent_buffer_pages (this time), this part before unlock_exit:
>>>>>
>>>>> Well, this is quite different from your initial report.
>>>>>
>>>>> Your initial report is EIO in btrfs_finish_ordered_io(), which happens
>>>>> after all data is written back to disk.
>>>>>
>>>>> But in this particular case, it happens before we submit the data to disk.
>>>>>
>>>>> In this case, we search csum tree first, to find the csum for the range
>>>>> we want to read, before submit the read bio.
>>>>>
>>>>> Thus they are at completely different path.
>>>> Yes it fails to read the csum, because read_extent_buffer_pages returns -EIO. I made the, I think, reasonable assumption that there is only one issue in btrfs where -EIO happens without an actual IO error on the underlying device. The original issue has line numbers that point at btrfs_csum_file_blocks which calls btrfs_lookup_csum which is in the call path of this issue. Can't confirm it's the same issue because the original report didn't have the WARN_ONs in there, so feel free to treat them as separate issues.
>>>>>
>>>>>>
>>>>>>        for (i = 0; i < num_pages; i++) {
>>>>>>            page = eb->pages[i];
>>>>>>            wait_on_page_locked(page);
>>>>>>            if (!PageUptodate(page))
>>>>>>                -->ret = -EIO;
>>>>>>        }
>>>>>>
>>>>>> Complete dmesg output. In this instance it seems to not be able to read a csum. It doesn't go read only in this case... Maybe it should?
>>>>>>
>>>>>> [Wed Jun 30 10:31:11 2021] kernel log
>>>>>
>>>>> For this particular case, btrfs first can't find the csum for the range
>>>>> of read, and just left the csum as all zeros and continue.
>>>>>
>>>>> Then the data read from disk will definitely cause a csum mismatch.
>>>>>
>>>>> This normally means a csum tree corruption.
>>>>>
>>>>> Can you run btrfs-check on that fs?
>>>>
>>>> It didn't "find" the csum because it has an -EIO error reading the extent where the csum is supposed to be stored. It is not a csum tree corruption because that would cause different log messages like transid not matching or csum of tree nodes being wrong, I think.
>>>
>>> Yes, that's what I expect, and feel strange about.
>>>
>>>>
>>>> Sorry, the file is long deleted. Scrub comes back as clean and I guess the -EIO error causing the csum read failure was only transient anyway.
>>>>
>>>> I'm not sufficiently familiar with btrfs/block device/mm subsystem obviously but here is one guess what could be wrong.
>>>>
>>>> It waits for completion for the read of the extent buffer page like this:
>>>>
>>>> wait_on_page_locked(page);
>>>> if (!PageUptodate(page))
>>>>       ret = -EIO;
>>>>
>>>> while in filemap.c it reads a page like this:
>>>>
>>>> wait_on_page_locked(page);
>>>> if (PageUptodate(page))
>>>>       goto out;
>>>> lock_page(page);
>>>> if (!page->mapping) {
>>>>           unlock_page(page);
>>>>           put_page(page);
>>>>           goto repeat;
>>>> }
>>>
>>> Yes, that what we do for data read path, as each time a page get
>>> unlocked, we can get page invalidator trigger for the page, and when we
>>> re-lock the page, it may has been invalidated.
>>>
>>> Although above check has been updated to do extra check including
>>> page->mapping and page->private check to be extra sure.
>>>
>>>> /* Someone else locked and filled the page in a very small window */
>>>> if (PageUptodate(page)) {
>>>>           unlock_page(page);
>>>>           goto out;
>>>>
>>>> }
>>>>
>>>> With the comment:
>>>>
>>>>> /*
>>>>> * Page is not up to date and may be locked due to one of the following
>>>>> * case a: Page is being filled and the page lock is held
>>>>> * case b: Read/write error clearing the page uptodate status
>>>>> * case c: Truncation in progress (page locked)
>>>>> * case d: Reclaim in progress
>>>>> *  [...]
>>>>> */
>>>> So maybe the extent buffer page gets e.g. reclaimed in the small window between unlock and PageUptodate check?
>>>
>>> But for metadata case, unlike data path, we have very limited way to
>>> invalidate/release a page.
>>>
>>> Unlike data path, metadata page uses it page->private as pointer to
>>> extent buffer.
>>>
>>> And each time we want to drop a metadata page, we can only do that if
>>> the extent buffer owning the page can be removed from the extent buffer
>>> cache.
>>>
>>> Thus a unlock metadata page get released halfway is not expected
>>> behavior at all.
>> I see. It mainly checks extent_buffer->refs and it increments that after allocating/finding the extent... No further idea what could be the problem...
>>>
>>>>
>>>> Another option is case b (read/write error), but the NVMe/dm subsystem doesn't log any error for some reason.
>>>
>>> I don't believe that's the case neither, or we should have csum mismatch
>>> report from btrfs.
>>>
>>>>
>>>> I guess I could add the lock and check for mapping and PageError(page) to narrow it down further?
>>>>
>>> If you have a proper way to reproduce the bug reliable, I could craft a
>>> diff for you to debug (with everything output to ftrace buffer to debug)
>>
>> Unfortunately I can't reproduce it and it is really rare. I could add further output at that location. E.g. checking for mapping presence if the page has an error or if it was submitted for read or was Uptodate before?
>>
>> For now I'll just extent the retry logic in btree_read_extent_buffer_pages to try the same mirror multiple times (The problematic btrfs filesystems have single metadata). That should do it as work-around.
>>
> My recommendation for debugging is to add extra trace_printk() on
> btree_releasepage() to see when a metadata page really get freed, and
> read_extent_buffer_pages() to see what's the possible race.
>
> Another idea is to add extra debug output in end_bio_extent_readpage()
> for metadata pages.
>
> As I'm still wondering if there is something wrong detected by btrfs
> module but without any error message.
>
> In that case, we definitely want to add a proper error message.

I guess this would be a proper error message:

--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -6505,8 +6505,14 @@ int read_extent_buffer_pages(struct extent_buffer *eb, int wait, int mirror_num)
        for (i = 0; i < num_pages; i++) {
                page = eb->pages[i];
                wait_on_page_locked(page);
-               if (!PageUptodate(page))
+               if (!PageUptodate(page)) {
+                       btrfs_err_rl(eb->fs_info,
+                               "error reading extent buffer "
+                               "start %llu len %lu PageError %d",
+                               eb->start, eb->len,
+                               PageError(page) ? 1 : 0);
                        ret = -EIO;
+               }
        }

        return ret;

I haven't added this to the kernel I'm running yet. It currently still has a WARN_ON instead of the error message.

I also added the retry like this:

--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -385,6 +385,7 @@ static int btree_read_extent_buffer_pages(struct extent_buffer *eb,
        int num_copies = 0;
        int mirror_num = 0;
        int failed_mirror = 0;
+       int tries = 2;

        io_tree = &BTRFS_I(fs_info->btree_inode)->io_tree;
        while (1) {
@@ -403,6 +404,10 @@ static int btree_read_extent_buffer_pages(struct extent_buffer *eb,

                num_copies = btrfs_num_copies(fs_info,
                                              eb->start, eb->len);
+
+               if (num_copies == 1 && tries-- > 0)
+                       continue;
+
                if (num_copies == 1)
                        break;

On Tuesday I got this:

[Tue Jul  6 14:49:17 2021] ------------[ cut here ]------------
[Tue Jul  6 14:49:17 2021] WARNING: CPU: 13 PID: 2265463 at fs/btrfs/extent_io.c:5597 read_extent_buffer_pages+0x346/0x360
[Tue Jul  6 14:49:17 2021] Modules linked in: zram bcache crc64 loop dm_crypt bfq xfs dm_mod st sr_mod cdrom bridge stp llc intel_powerclamp coretemp snd_pcm kvm_intel snd_timer snd mgag200 kvm soundcore drm_kms_helper iTCO_wdt dcdbas irqbypass pcspkr serio_raw iTCO_vendor_support i2c_algo_bit evdev joydev i7core_edac sg ipmi_si ipmi_devintf ipmi_msghandler wmi acpi_power_meter button ib_iser rdma_cm iw_cm ib_cm ib_core iscsi_tcp libiscsi_tcp libiscsi scsi_transport_iscsi drm configfs ip_tables x_tables autofs4 raid10 raid456 async_raid6_recov async_memcpy async_pq async_xor async_tx raid0 multipath linear raid1 md_mod ses enclosure sd_mod hid_generic usbhid hid crct10dif_pclmul crc32_pclmul crc32c_intel ghash_clmulni_intel aesni_intel crypto_simd cryptd glue_helper ahci libahci uhci_hcd ehci_pci psmouse mpt3sas ehci_hcd lpc_ich raid_class libata nvme scsi_transport_sas mfd_core nvme_core usbcore t10_pi scsi_mod bnx2
[Tue Jul  6 14:49:17 2021] CPU: 13 PID: 2265463 Comm: btrfs Tainted: G          I       5.10.47 #1
[Tue Jul  6 14:49:17 2021] Hardware name: Dell Inc. PowerEdge R510/0DPRKF, BIOS 1.13.0 03/02/2018
[Tue Jul  6 14:49:17 2021] RIP: 0010:read_extent_buffer_pages+0x346/0x360
[Tue Jul  6 14:49:17 2021] Code: 48 8b 43 08 a8 01 48 8d 78 ff 48 0f 44 fb 31 f6 e8 cf d0 db ff 48 8b 43 08 48 8d 50 ff a8 01 48 0f 45 da 48 8b 03 a8 04 75 ab <0f> 0b 41 be fb ff ff ff eb a1 e8 4b af 56 00 66 66 2e 0f 1f 84 00
[Tue Jul  6 14:49:17 2021] RSP: 0018:ffffc9007562bb40 EFLAGS: 00010246
[Tue Jul  6 14:49:17 2021] RAX: 06ffff80000020e3 RBX: ffffea00095a5fc0 RCX: 0000000000000000
[Tue Jul  6 14:49:17 2021] RDX: dead0000000000ff RSI: 0000000000000020 RDI: ffff888713babd40
[Tue Jul  6 14:49:17 2021] RBP: ffff88869a7d6f78 R08: 0000f5a746752ed4 R09: 0000000000000483
[Tue Jul  6 14:49:17 2021] R10: 0000000000000001 R11: 0000000000000000 R12: ffff88869a7d7020
[Tue Jul  6 14:49:17 2021] R13: ffffea0005f51f80 R14: 0000000000000000 R15: ffff88869a7d7020
[Tue Jul  6 14:49:17 2021] FS:  00007f748ddc18c0(0000) GS:ffff888713b80000(0000) knlGS:0000000000000000
[Tue Jul  6 14:49:17 2021] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[Tue Jul  6 14:49:17 2021] CR2: 00005618b6037058 CR3: 000000011feca004 CR4: 00000000000206e0
[Tue Jul  6 14:49:17 2021] Call Trace:
[Tue Jul  6 14:49:17 2021]  btree_read_extent_buffer_pages+0x66/0x130
[Tue Jul  6 14:49:17 2021]  read_tree_block+0x36/0x60
[Tue Jul  6 14:49:17 2021]  btrfs_read_node_slot+0xc0/0x110
[Tue Jul  6 14:49:17 2021]  btrfs_search_forward+0x1db/0x350
[Tue Jul  6 14:49:17 2021]  search_ioctl+0x19e/0x250
[Tue Jul  6 14:49:17 2021]  btrfs_ioctl_tree_search+0x63/0xc0
[Tue Jul  6 14:49:17 2021]  btrfs_ioctl+0x1874/0x3060
[Tue Jul  6 14:49:17 2021]  ? page_add_new_anon_rmap+0xa3/0x1f0
[Tue Jul  6 14:49:17 2021]  ? handle_mm_fault+0xf6c/0x1950
[Tue Jul  6 14:49:17 2021]  ? __x64_sys_ioctl+0x83/0xb0
[Tue Jul  6 14:49:17 2021]  __x64_sys_ioctl+0x83/0xb0
[Tue Jul  6 14:49:17 2021]  do_syscall_64+0x33/0x80
[Tue Jul  6 14:49:17 2021]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[Tue Jul  6 14:49:17 2021] RIP: 0033:0x7f748deb8cc7
[Tue Jul  6 14:49:17 2021] Code: 00 00 00 48 8b 05 c9 91 0c 00 64 c7 00 26 00 00 00 48 c7 c0 ff ff ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 b8 10 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 99 91 0c 00 f7 d8 64 89 01 48
[Tue Jul  6 14:49:17 2021] RSP: 002b:00007ffc7e07f098 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
[Tue Jul  6 14:49:17 2021] RAX: ffffffffffffffda RBX: 00007ffc7e0801d8 RCX: 00007f748deb8cc7
[Tue Jul  6 14:49:17 2021] RDX: 00007ffc7e07f0f8 RSI: 00000000d0009411 RDI: 0000000000000005
[Tue Jul  6 14:49:17 2021] RBP: 0000000000bafaad R08: 000000000000000b R09: 00007f748df82be0
[Tue Jul  6 14:49:17 2021] R10: 0000000000000010 R11: 0000000000000246 R12: 0000000000000005
[Tue Jul  6 14:49:17 2021] R13: 00007ffc7e07ffe1 R14: 000000000000000b R15: 00007ffc7e07f160
[Tue Jul  6 14:49:17 2021] ---[ end trace 81f64eb2e9ceb4de ]---

with no other message afterwards. This means the retry is working and "fixed" the problem for me. I'll keep monitoring this and will try to catch the -EIO from other areas, like the original btrfs_finish_ordered_io.

