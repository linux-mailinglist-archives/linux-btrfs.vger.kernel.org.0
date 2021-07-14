Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FC533C88B1
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Jul 2021 18:32:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235534AbhGNQfV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 14 Jul 2021 12:35:21 -0400
Received: from a4-6.smtp-out.eu-west-1.amazonses.com ([54.240.4.6]:52665 "EHLO
        a4-6.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235843AbhGNQfV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 14 Jul 2021 12:35:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=vbsgq4olmwpaxkmtpgfbbmccllr2wq3g; d=urbackup.org; t=1626280348;
        h=From:Subject:To:References:Message-ID:Date:MIME-Version:In-Reply-To:Content-Type:Content-Transfer-Encoding;
        bh=kdezr35jRYueidu0+1JC0al158mRuDXJ5DJYBwRIhFM=;
        b=qoT3DCvJ8rjlPCpstWJNi/Nf4NMo/N3T2uzLt+QV2jI2Qo4SHAj5+hvrmN/pDpCP
        znxr/cVbnbOxsAJrAVOHXsqYOEi2ocqQzXuFxuQmLmhb18uBsnz3DXa+Mei6iAE9n2/
        tZg55PPmmsKA6DhvB1DPKY+iJy6hUPtIqdj1kCPE=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=uku4taia5b5tsbglxyj6zym32efj7xqv; d=amazonses.com; t=1626280348;
        h=From:Subject:To:References:Message-ID:Date:MIME-Version:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID;
        bh=kdezr35jRYueidu0+1JC0al158mRuDXJ5DJYBwRIhFM=;
        b=J5D8p29tX2EODTrc15l+gzeFZMw6SOvNu4KCI1G4PYuEVrJwLG8oeU8HAA86YX7G
        vaI4nB9NrulUV4hA0jbCLAAENnbUxsijJQMFijFtaeGfRVM4NoCtCsjXdulHVDCbYi5
        PrS77YYjj/j6ooF1bukG/8/lbz5nvjUtkf4R2TM0=
From:   Martin Raiber <martin@urbackup.org>
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
 <0102017a86e63e18-a5023d15-0b20-43e8-b71c-6dd241451179-000000@eu-west-1.amazonses.com>
 <75a45aff-a75f-a6ec-1a7b-6ea4d89071bb@gmx.com>
Message-ID: <0102017aa5dcc902-1d1e5407-152a-4e8e-be78-9fd5d5c68cc9-000000@eu-west-1.amazonses.com>
Date:   Wed, 14 Jul 2021 16:32:28 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <75a45aff-a75f-a6ec-1a7b-6ea4d89071bb@gmx.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Feedback-ID: 1.eu-west-1.zKMZH6MF2g3oUhhjaE2f3oQ8IBjABPbvixQzV8APwT0=:AmazonSES
X-SES-Outgoing: 2021.07.14-54.240.4.6
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 09.07.2021 01:32 Qu Wenruo wrote:
>
> [...]
>>> My recommendation for debugging is to add extra trace_printk() on
>>> btree_releasepage() to see when a metadata page really get freed, and
>>> read_extent_buffer_pages() to see what's the possible race.
>>>
>>> Another idea is to add extra debug output in end_bio_extent_readpage()
>>> for metadata pages.
>>>
>>> As I'm still wondering if there is something wrong detected by btrfs
>>> module but without any error message.
>>>
>>> In that case, we definitely want to add a proper error message.
>>
>> I guess this would be a proper error message:
>>
>> --- a/fs/btrfs/extent_io.c
>> +++ b/fs/btrfs/extent_io.c
>> @@ -6505,8 +6505,14 @@ int read_extent_buffer_pages(struct extent_buffer *eb, int wait, int mirror_num)
>>          for (i = 0; i < num_pages; i++) {
>>                  page = eb->pages[i];
>>                  wait_on_page_locked(page);
>> -               if (!PageUptodate(page))
>> +               if (!PageUptodate(page)) {
>> +                       btrfs_err_rl(eb->fs_info,
>> +                               "error reading extent buffer "
>> +                               "start %llu len %lu PageError %d",
>> +                               eb->start, eb->len,
>> +                               PageError(page) ? 1 : 0);
>
> What I originally mean is, in end_bio_extent_readpage() we may hit a
> case where @uptodate is 0, but we don't have any error message for it.
>
> Your error message is fine, it has PageError() to indicate whether we're
> really hitting a case like above, or someone is releasing the metadata
> page improperly.
>
> If combined with the following diff, it can rule out or catch the error
> in metadata read path directly, as I'm still wondering if it's error
> from the bio, or the error from improperly released metadata pages.
>
> Thanks,
> Qu
>
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index b5f5de7e4a29..b1f8862ba539 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -3047,6 +3047,16 @@ static void end_bio_extent_readpage(struct bio *bio)
>                 if (likely(uptodate))
>                         goto readpage_ok;
>
> +               if (!is_data_inode(inode)) {
> +                       struct extent_buffer *eb;
> +
> +                       eb = (struct extent_buffer *)page->private;
> +                       btrfs_err_rl(fs_info,
> +               "metadata read error, page=%llu eb=%llu bio_status=%d
> ret=%d",
> +                                    page_offset(page), eb->start,
> +                                    bio->bi_status, ret);
> +               }
> +
>                 if (is_data_inode(inode)) {
>                         /*
>                          * btrfs_submit_read_repair() will handle all
> the good
>
Added this to the kernel as well, but it is not hit:

[199571.686344] BTRFS error (device dm-0): error reading extent buffer start 97231241216 len 16384 PageError 0
[199571.686423] ------------[ cut here ]------------
[199571.686432] WARNING: CPU: 22 PID: 3451967 at fs/btrfs/extent_io.c:5611 read_extent_buffer_pages+0x308/0x380
[199571.686433] Modules linked in: zram bcache crc64 loop dm_crypt bfq xfs dm_mod st sr_mod cdrom bridge stp llc intel_powerclamp coretemp kvm_intel kvm snd_pcm snd_timer snd dcdbas irqbypass soundcore mgag200 serio_raw pcspkr drm_kms_helper evdev joydev iTCO_wdt iTCO_vendor_support i2c_algo_bit i7core_edac sg ipmi_si ipmi_devintf ipmi_msghandler wmi acpi_power_meter button ib_iser rdma_cm iw_cm ib_cm ib_core iscsi_tcp libiscsi_tcp libiscsi scsi_transport_iscsi drm configfs ip_tables x_tables autofs4 raid10 raid456 async_raid6_recov async_memcpy async_pq async_xor async_tx raid1 raid0 multipath linear md_mod ses enclosure sd_mod hid_generic usbhid hid crct10dif_pclmul crc32_pclmul crc32c_intel ghash_clmulni_intel aesni_intel crypto_simd cryptd glue_helper ahci ehci_pci uhci_hcd libahci psmouse mpt3sas ehci_hcd raid_class lpc_ich libata nvme scsi_transport_sas mfd_core usbcore nvme_core t10_pi scsi_mod bnx2
[199571.686505] CPU: 22 PID: 3451967 Comm: kworker/u49:9 Tainted: G          I       5.10.48 #1
[199571.686506] Hardware name: Dell Inc. PowerEdge R510/0DPRKF, BIOS 1.13.0 03/02/2018
[199571.686510] Workqueue: btrfs-endio-write btrfs_work_helper
[199571.686513] RIP: 0010:read_extent_buffer_pages+0x308/0x380
[199571.686516] Code: e9 8a fe ff ff 85 c9 75 05 83 fb 01 74 32 41 89 ce eb b3 48 c7 c6 b0 54 e4 81 48 c7 c7 80 d5 65 82 e8 2c b0 1a 00 85 c0 75 65 <0f> 0b 41 be fb ff ff ff 48 83 04 24 08 48 8b 04 24 4c 39 e0 74 86
[199571.686517] RSP: 0018:ffffc9004ad93a58 EFLAGS: 00010282
[199571.686519] RAX: 0000000000000000 RBX: ffffea001fbbc300 RCX: 0000000000000000
[199571.686520] RDX: 0000000000000000 RSI: ffff888e13cd8b80 RDI: ffff888e13cd8b80
[199571.686521] RBP: ffff888b616af7b8 R08: ffffffff825e21c8 R09: 0000000000027ffb
[199571.686522] R10: 00000000ffff8000 R11: 3fffffffffffffff R12: ffff888b616af860
[199571.686523] R13: ffffea0031592dc0 R14: 0000000000000000 R15: ffff888b616af860
[199571.686525] FS:  0000000000000000(0000) GS:ffff888e13cc0000(0000) knlGS:0000000000000000
[199571.686526] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[199571.686527] CR2: 00007f034897600a CR3: 000000011f344006 CR4: 00000000000206e0
[199571.686528] Call Trace:
[199571.686536]  btree_read_extent_buffer_pages+0x66/0x130
[199571.686539]  read_tree_block+0x36/0x60
[199571.686543]  read_block_for_search.isra.0+0x1ab/0x360
[199571.686547]  ? ttwu_do_wakeup+0x17/0x130
[199571.686550]  btrfs_search_slot+0x232/0x970
[199571.686552]  btrfs_lookup_csum+0x75/0x170
[199571.686557]  ? kmem_cache_alloc+0xda/0x1d0
[199571.686559]  btrfs_csum_file_blocks+0x17d/0x690
[199571.686561]  ? insert_reserved_file_extent+0x1cb/0x210
[199571.686564]  btrfs_finish_ordered_io.isra.0+0x49d/0x8d0
[199571.686567]  btrfs_work_helper+0xe0/0x310
[199571.686572]  process_one_work+0x1b6/0x350
[199571.686574]  worker_thread+0x53/0x3e0
[199571.686575]  ? process_one_work+0x350/0x350
[199571.686577]  kthread+0x11b/0x140
[199571.686579]  ? __kthread_bind_mask+0x60/0x60
[199571.686584]  ret_from_fork+0x1f/0x30
[199571.686586] ---[ end trace 05ee2703b7a5772f ]---

PageError isn't set es well, so it looks like the page is unlocked without setting an error but not setting Uptodate?

(I left the WARN_ON in to get a call trace and it retries so there is no further error message now for my kernel)
>
>>                          ret = -EIO;
>> +               }
>>          }
>>
>>          return ret;
>>
>> I haven't added this to the kernel I'm running yet. It currently still has a WARN_ON instead of the error message.
>>
>> I also added the retry like this:
>>
>> --- a/fs/btrfs/disk-io.c
>> +++ b/fs/btrfs/disk-io.c
>> @@ -385,6 +385,7 @@ static int btree_read_extent_buffer_pages(struct extent_buffer *eb,
>>          int num_copies = 0;
>>          int mirror_num = 0;
>>          int failed_mirror = 0;
>> +       int tries = 2;
>>
>>          io_tree = &BTRFS_I(fs_info->btree_inode)->io_tree;
>>          while (1) {
>> @@ -403,6 +404,10 @@ static int btree_read_extent_buffer_pages(struct extent_buffer *eb,
>>
>>                  num_copies = btrfs_num_copies(fs_info,
>>                                                eb->start, eb->len);
>> +
>> +               if (num_copies == 1 && tries-- > 0)
>> +                       continue;
>> +
>>                  if (num_copies == 1)
>>                          break;
>>
>> On Tuesday I got this:
>>
>> [Tue Jul  6 14:49:17 2021] ------------[ cut here ]------------
>> [Tue Jul  6 14:49:17 2021] WARNING: CPU: 13 PID: 2265463 at fs/btrfs/extent_io.c:5597 read_extent_buffer_pages+0x346/0x360
>> [Tue Jul  6 14:49:17 2021] Modules linked in: zram bcache crc64 loop dm_crypt bfq xfs dm_mod st sr_mod cdrom bridge stp llc intel_powerclamp coretemp snd_pcm kvm_intel snd_timer snd mgag200 kvm soundcore drm_kms_helper iTCO_wdt dcdbas irqbypass pcspkr serio_raw iTCO_vendor_support i2c_algo_bit evdev joydev i7core_edac sg ipmi_si ipmi_devintf ipmi_msghandler wmi acpi_power_meter button ib_iser rdma_cm iw_cm ib_cm ib_core iscsi_tcp libiscsi_tcp libiscsi scsi_transport_iscsi drm configfs ip_tables x_tables autofs4 raid10 raid456 async_raid6_recov async_memcpy async_pq async_xor async_tx raid0 multipath linear raid1 md_mod ses enclosure sd_mod hid_generic usbhid hid crct10dif_pclmul crc32_pclmul crc32c_intel ghash_clmulni_intel aesni_intel crypto_simd cryptd glue_helper ahci libahci uhci_hcd ehci_pci psmouse mpt3sas ehci_hcd lpc_ich raid_class libata nvme scsi_transport_sas mfd_core nvme_core usbcore t10_pi scsi_mod bnx2
>> [Tue Jul  6 14:49:17 2021] CPU: 13 PID: 2265463 Comm: btrfs Tainted: G          I       5.10.47 #1
>> [Tue Jul  6 14:49:17 2021] Hardware name: Dell Inc. PowerEdge R510/0DPRKF, BIOS 1.13.0 03/02/2018
>> [Tue Jul  6 14:49:17 2021] RIP: 0010:read_extent_buffer_pages+0x346/0x360
>> [Tue Jul  6 14:49:17 2021] Code: 48 8b 43 08 a8 01 48 8d 78 ff 48 0f 44 fb 31 f6 e8 cf d0 db ff 48 8b 43 08 48 8d 50 ff a8 01 48 0f 45 da 48 8b 03 a8 04 75 ab <0f> 0b 41 be fb ff ff ff eb a1 e8 4b af 56 00 66 66 2e 0f 1f 84 00
>> [Tue Jul  6 14:49:17 2021] RSP: 0018:ffffc9007562bb40 EFLAGS: 00010246
>> [Tue Jul  6 14:49:17 2021] RAX: 06ffff80000020e3 RBX: ffffea00095a5fc0 RCX: 0000000000000000
>> [Tue Jul  6 14:49:17 2021] RDX: dead0000000000ff RSI: 0000000000000020 RDI: ffff888713babd40
>> [Tue Jul  6 14:49:17 2021] RBP: ffff88869a7d6f78 R08: 0000f5a746752ed4 R09: 0000000000000483
>> [Tue Jul  6 14:49:17 2021] R10: 0000000000000001 R11: 0000000000000000 R12: ffff88869a7d7020
>> [Tue Jul  6 14:49:17 2021] R13: ffffea0005f51f80 R14: 0000000000000000 R15: ffff88869a7d7020
>> [Tue Jul  6 14:49:17 2021] FS:  00007f748ddc18c0(0000) GS:ffff888713b80000(0000) knlGS:0000000000000000
>> [Tue Jul  6 14:49:17 2021] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> [Tue Jul  6 14:49:17 2021] CR2: 00005618b6037058 CR3: 000000011feca004 CR4: 00000000000206e0
>> [Tue Jul  6 14:49:17 2021] Call Trace:
>> [Tue Jul  6 14:49:17 2021]  btree_read_extent_buffer_pages+0x66/0x130
>> [Tue Jul  6 14:49:17 2021]  read_tree_block+0x36/0x60
>> [Tue Jul  6 14:49:17 2021]  btrfs_read_node_slot+0xc0/0x110
>> [Tue Jul  6 14:49:17 2021]  btrfs_search_forward+0x1db/0x350
>> [Tue Jul  6 14:49:17 2021]  search_ioctl+0x19e/0x250
>> [Tue Jul  6 14:49:17 2021]  btrfs_ioctl_tree_search+0x63/0xc0
>> [Tue Jul  6 14:49:17 2021]  btrfs_ioctl+0x1874/0x3060
>> [Tue Jul  6 14:49:17 2021]  ? page_add_new_anon_rmap+0xa3/0x1f0
>> [Tue Jul  6 14:49:17 2021]  ? handle_mm_fault+0xf6c/0x1950
>> [Tue Jul  6 14:49:17 2021]  ? __x64_sys_ioctl+0x83/0xb0
>> [Tue Jul  6 14:49:17 2021]  __x64_sys_ioctl+0x83/0xb0
>> [Tue Jul  6 14:49:17 2021]  do_syscall_64+0x33/0x80
>> [Tue Jul  6 14:49:17 2021]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
>> [Tue Jul  6 14:49:17 2021] RIP: 0033:0x7f748deb8cc7
>> [Tue Jul  6 14:49:17 2021] Code: 00 00 00 48 8b 05 c9 91 0c 00 64 c7 00 26 00 00 00 48 c7 c0 ff ff ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 b8 10 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 99 91 0c 00 f7 d8 64 89 01 48
>> [Tue Jul  6 14:49:17 2021] RSP: 002b:00007ffc7e07f098 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
>> [Tue Jul  6 14:49:17 2021] RAX: ffffffffffffffda RBX: 00007ffc7e0801d8 RCX: 00007f748deb8cc7
>> [Tue Jul  6 14:49:17 2021] RDX: 00007ffc7e07f0f8 RSI: 00000000d0009411 RDI: 0000000000000005
>> [Tue Jul  6 14:49:17 2021] RBP: 0000000000bafaad R08: 000000000000000b R09: 00007f748df82be0
>> [Tue Jul  6 14:49:17 2021] R10: 0000000000000010 R11: 0000000000000246 R12: 0000000000000005
>> [Tue Jul  6 14:49:17 2021] R13: 00007ffc7e07ffe1 R14: 000000000000000b R15: 00007ffc7e07f160
>> [Tue Jul  6 14:49:17 2021] ---[ end trace 81f64eb2e9ceb4de ]---
>>
>> with no other message afterwards. This means the retry is working and "fixed" the problem for me. I'll keep monitoring this and will try to catch the -EIO from other areas, like the original btrfs_finish_ordered_io.
>>

