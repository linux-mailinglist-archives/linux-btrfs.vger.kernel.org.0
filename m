Return-Path: <linux-btrfs+bounces-7650-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98F23963106
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Aug 2024 21:35:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4ADB828639D
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Aug 2024 19:35:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C8C31AC425;
	Wed, 28 Aug 2024 19:35:24 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from vps-vb.mhejs.net (vps-vb.mhejs.net [37.28.154.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 521A41547DD;
	Wed, 28 Aug 2024 19:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.28.154.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724873723; cv=none; b=q/yBhYm9g6fPZesdvVfO1EM6OeYHp7837Cq916pUa7cZrz7kWpmuOPJcbsBQi1BYhM6emmyb4Zmrj2kaVbu/VZE3znfdkYbbcax0xPkexn1y2QEN6aqs34vJXltEg9JSZfEpCZbFrICtWJ7eVrzqaZk/ilDslUf2CiszDUGtq3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724873723; c=relaxed/simple;
	bh=DZ6T94WHKxZ8kfrLQJLjoj5/Z9fkQxyoXEjNWKT/+jw=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=cSM/kyuUROoUVTgokruCu+4p7ILBFqPy0QuJjMGhu6qWstmkq68MMpL/3BTC8va9Jsb/1bOYz/1J+xHyMxuUKyV6LISyDsozR8MGTSg/SyfLLWt/DLTGb+ITTbpjBOAe3r9M0DpjewGmwwKpocPQdr2PFqhQNFzTVxRwJ3AkgTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=maciej.szmigiero.name; spf=pass smtp.mailfrom=maciej.szmigiero.name; arc=none smtp.client-ip=37.28.154.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=maciej.szmigiero.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maciej.szmigiero.name
Received: from MUA
	by vps-vb.mhejs.net with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.94.2)
	(envelope-from <mail@maciej.szmigiero.name>)
	id 1sjO2G-0000s7-SQ; Wed, 28 Aug 2024 21:08:52 +0200
Message-ID: <3c95fb54-9cac-4b4f-8e1b-84ca041b57cb@maciej.szmigiero.name>
Date: Wed, 28 Aug 2024 21:08:47 +0200
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US, pl-PL
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Autocrypt: addr=mail@maciej.szmigiero.name; keydata=
 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
Subject: Root filesystem read access for firmware load during hibernation
 image writing
To: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <len.brown@intel.com>,
 Pavel Machek <pavel@ucw.cz>
Cc: linux-pm <linux-pm@vger.kernel.org>, linux-kernel@vger.kernel.org,
 Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
 David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Disposition-Notification-To: "Maciej S. Szmigiero"
 <mail@maciej.szmigiero.name>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

I have a quick question about hibernation "image writing" state - is
(root) filesystem *read* access supposed to be working normally at that point?

Specifically, I know that devices are resumed (PMSG_THAW) after preparing
the hibernation image.

In my case, a USB device (RTL8821CU) gets reset at that stage due to
commit 04b8c8143d46 ("btusb: fix Realtek suspend/resume") and so it tries
to request_firmware() from the root filesystem after that thaw/reset,
when the hibernation image is being written.

It usually succeeds, however often it deadlocks somewhere in Btrfs code
resulting in the system failing to power off after writing the hibernate
image:
power_off() calls dpm_suspend_start(), which calls dpm_prepare(), which
waits for device probe to finish.

And device probe is stuck forever trying to load that USB stick firmware
from the filesystem - so in the end the system never powers off during
(after) hibernation.

That's why I wonder whether this firmware load is supposed to work correctly
during that hibernation state and so the system may be hitting some kind of
a swsusp/btrfs/block layer race condition.

Or, alternatively, maybe  reading files is not supported at this point and
so this is really a btrtl/rtw88 bug?

CCing Btrfs people in case it is some known Btrfs issue.

Btw, this is on upstream kernel 6.10.6 and the "Show Blocked State" trace
during that failed power off is attached below.

Thanks,
Maciej

> [59782.982908][    C0] sysrq: Show Blocked State                                
> [59782.987522][    C0] task:kworker/u19:0   state:D stack:0     pid:84    tgid:84    ppid:2      flags:0x00004000
> [59782.998043][    C0] Workqueue: hci0 hci_power_on [bluetooth]
> [59783.004047][    C0] Call Trace:
> [59783.007356][    C0]  <TASK>
> [59783.010303][    C0]  __schedule+0x3a2/0x1520
> [59783.014805][    C0]  schedule+0x23/0xf0
> [59783.018846][    C0]  io_schedule+0x4d/0x80
> [59783.023157][    C0]  bit_wait_io+0xd/0x60
> [59783.027373][    C0]  __wait_on_bit+0x41/0x100
> [59783.031952][    C0]  ? wait_for_completion_killable+0x1c0/0x1c0
> [59783.038182][    C0]  out_of_line_wait_on_bit+0x90/0xb0
> [59783.043598][    C0]  ? swake_up_locked+0x50/0x50
> [59783.048462][    C0]  read_extent_buffer_pages+0x1e8/0x210
> [59783.054155][    C0]  btrfs_read_extent_buffer+0x89/0x170
> [59783.059754][    C0]  read_tree_block+0x3c/0x90
> [59783.064428][    C0]  read_block_for_search+0x24b/0x350
> [59783.069846][    C0]  btrfs_search_slot+0x31e/0xc30
> [59783.074898][    C0]  ? btrfs_alloc_inode+0x4e/0x2a0
> [59783.080024][    C0]  btrfs_lookup_inode+0x3a/0xc0
> [59783.084980][    C0]  ? btrfs_fill_inode+0x49/0x220
> [59783.090019][    C0]  btrfs_read_locked_inode+0x543/0x620
> [59783.095610][    C0]  ? can_cow_file_range_inline+0x70/0x70
> [59783.101381][    C0]  btrfs_iget_path+0x8f/0xe0
> [59783.106054][    C0]  btrfs_lookup_dentry+0x347/0x610
> [59783.111274][    C0]  ? d_alloc_parallel+0x225/0x3d0
> [59783.116415][    C0]  btrfs_lookup+0xe/0x30
> [59783.120733][    C0]  __lookup_slow+0x9a/0x170
> [59783.125314][    C0]  walk_component+0x13e/0x1d0
> [59783.130075][    C0]  ? inode_permission+0x154/0x1b0
> [59783.135207][    C0]  link_path_walk.part.0.constprop.0+0x26b/0x370
> [59783.141704][    C0]  ? path_init+0x5f/0x430
> [59783.146102][    C0]  path_openat+0xa3/0x1270
> [59783.150590][    C0]  do_file_open_root+0x10b/0x1f0
> [59783.155633][    C0]  ? alloc_lookup_fw_priv+0x14e/0x270
> [59783.161138][    C0]  file_open_root+0x9f/0x170
> [59783.165820][    C0]  kernel_read_file_from_path_initns+0xbd/0x140
> [59783.172223][    C0]  fw_get_filesystem_firmware+0x146/0x300
> [59783.178091][    C0]  _request_firmware+0x32d/0x520
> [59783.183134][    C0]  ? bt_info+0x6e/0x90 [bluetooth]
> [59783.188431][    C0]  request_firmware+0x45/0x70
> [59783.193192][    C0]  rtl_load_file+0x62/0x100 [btrtl]
> [59783.198508][    C0]  btrtl_initialize+0x1e2/0x690 [btrtl]
> [59783.204184][    C0]  ? work_grab_pending+0x169/0x1b0
> [59783.209419][    C0]  btrtl_setup_realtek+0x21/0x90 [btrtl]
> [59783.215191][    C0]  btusb_setup_realtek+0x12/0x30 [btusb]
> [59783.220955][    C0]  hci_dev_open_sync+0x101/0xb80 [bluetooth]
> [59783.227159][    C0]  hci_dev_do_open+0x2e/0x70 [bluetooth]
> [59783.232982][    C0]  hci_power_on+0x4d/0x250 [bluetooth]
> [59783.238624][    C0]  process_one_work+0x170/0x380
> [59783.243575][    C0]  worker_thread+0x2d8/0x400
> [59783.248248][    C0]  ? cancel_work_sync+0x80/0x80
> [59783.253198][    C0]  kthread+0xc8/0x100
> [59783.257234][    C0]  ? kthread_park+0x90/0x90
> [59783.261812][    C0]  ret_from_fork+0x4c/0x60
> [59783.266297][    C0]  ? kthread_park+0x90/0x90
> [59783.270885][    C0]  ret_from_fork_asm+0x11/0x20
> [59783.275736][    C0]  </TASK>
> [59783.278785][    C0] task:btrfs-transacti state:D stack:0     pid:3806  tgid:3806  ppid:2      flags:0x00004000
> [59783.289289][    C0] Call Trace:
> [59783.292598][    C0]  <TASK>
> [59783.295536][    C0]  __schedule+0x3a2/0x1520
> [59783.300031][    C0]  schedule+0x23/0xf0
> [59783.304065][    C0]  schedule_preempt_disabled+0x11/0x20
> [59783.309656][    C0]  rwsem_down_write_slowpath+0x238/0x5b0
> [59783.315430][    C0]  down_write+0x56/0x60
> [59783.319644][    C0]  btrfs_tree_lock_nested+0x22/0x90
> [59783.324958][    C0]  btrfs_search_slot+0x62b/0xc30
> [59783.330007][    C0]  btrfs_lookup_inode+0x3a/0xc0
> [59783.334964][    C0]  __btrfs_update_delayed_inode+0x85/0x310
> [59783.340927][    C0]  __btrfs_run_delayed_items+0x1cd/0x2c0
> [59783.346699][    C0]  btrfs_commit_transaction+0x232/0xe20
> [59783.352375][    C0]  ? start_transaction+0xc0/0x820
> [59783.357508][    C0]  transaction_kthread+0x15c/0x1c0
> [59783.362735][    C0]  ? close_ctree+0x490/0x490
> [59783.367408][    C0]  kthread+0xc8/0x100
> [59783.371437][    C0]  ? kthread_park+0x90/0x90
> [59783.376008][    C0]  ret_from_fork+0x4c/0x60
> [59783.380492][    C0]  ? kthread_park+0x90/0x90
> [59783.386462][    C0]  ret_from_fork_asm+0x11/0x20
> [59783.392531][    C0]  </TASK>
> [59783.396713][    C0] task:elogind-daemon  state:D stack:0     pid:6101  tgid:6101  ppid:1      flags:0x00004002
> [59783.408306][    C0] Call Trace:
> [59783.412679][    C0]  <TASK>
> [59783.416705][    C0]  __schedule+0x3a2/0x1520
> [59783.422270][    C0]  ? acpi_ut_repair_name+0x3c/0xc0
> [59783.428577][    C0]  ? acpi_ns_search_and_enter+0x55/0x220
> [59783.435422][    C0]  schedule+0x23/0xf0
> [59783.440553][    C0]  schedule_timeout+0x160/0x170
> [59783.446593][    C0]  wait_for_completion+0x81/0x130
> [59783.452815][    C0]  __flush_work+0x18a/0x2e0
> [59783.458474][    C0]  ? flush_workqueue_prep_pwqs+0x120/0x120
> [59783.465507][    C0]  wait_for_device_probe+0x25/0xa0
> [59783.471797][    C0]  ? __alloc_pages_noprof+0x1c3/0x320
> [59783.478363][    C0]  dpm_prepare+0x28/0x420
> [59783.483842][    C0]  dpm_suspend_start+0x28/0x70
> [59783.489779][    C0]  hibernation_platform_enter+0x58/0x140
> [59783.496621][    C0]  hibernate+0x3ae/0x420
> [59783.502013][    C0]  state_store+0xea/0x100
> [59783.507492][    C0]  kernfs_fop_write_iter+0x172/0x200
> [59783.513973][    C0]  vfs_write+0x265/0x4a0
> [59783.519366][    C0]  ksys_write+0x77/0x110
> [59783.524747][    C0]  do_syscall_64+0x64/0x130
> [59783.530399][    C0]  ? devkmsg_write+0xcf/0x1c0
> [59783.536231][    C0]  ? xas_load+0x8/0xc0
> [59783.541423][    C0]  ? xas_store+0x3b0/0x630
> [59783.546980][    C0]  ? do_iter_readv_writev+0x114/0x210
> [59783.553539][    C0]  ? __xa_erase+0x53/0xa0
> [59783.559001][    C0]  ? xa_erase+0x2e/0x50
> [59783.564279][    C0]  ? zswap_invalidate+0x32/0x50
> [59783.570292][    C0]  ? free_swap_slot+0x85/0xc0
> [59783.576108][    C0]  ? put_swap_folio+0x19c/0x3c0
> [59783.582114][    C0]  ? delete_from_swap_cache+0x6b/0xa0
> [59783.588663][    C0]  ? folio_free_swap+0x95/0x1d0
> [59783.594659][    C0]  ? do_writev+0x82/0x120
> [59783.600120][    C0]  ? do_wp_page+0x829/0xfa0
> [59783.605761][    C0]  ? sysvec_call_function_single+0x15/0x90
> [59783.612770][    C0]  ? asm_sysvec_call_function_single+0x16/0x20
> [59783.620139][    C0]  ? __pte_offset_map+0x25/0x1a0
> [59783.626241][    C0]  ? __handle_mm_fault+0x7e0/0x850
> [59783.632517][    C0]  ? __count_memcg_events+0x53/0xf0
> [59783.638882][    C0]  ? handle_mm_fault+0xc9/0x2c0
> [59783.644880][    C0]  ? do_user_addr_fault+0x476/0x750
> [59783.651248][    C0]  ? exc_page_fault+0x73/0x140
> [59783.657166][    C0]  ? irqentry_exit_to_user_mode+0x58/0x130
> [59783.664173][    C0]  entry_SYSCALL_64_after_hwframe+0x55/0x5d
> [59783.737346][    C0] task:kworker/u17:5   state:D stack:0     pid:228761 tgid:228761 ppid:2      flags:0x00004000
> [59783.749138][    C0] Workqueue: writeback wb_workfn (flush-btrfs-1)
> [59783.756741][    C0] Call Trace:
> [59783.761149][    C0]  <TASK>
> [59783.765194][    C0]  __schedule+0x3a2/0x1520
> [59783.770783][    C0]  ? blk_mq_flush_plug_list.part.0+0x185/0x5b0
> [59783.778208][    C0]  schedule+0x23/0xf0
> [59783.783346][    C0]  io_schedule+0x4d/0x80
> [59783.788764][    C0]  bit_wait_io+0xd/0x60
> [59783.794086][    C0]  __wait_on_bit+0x41/0x100
> [59783.799780][    C0]  ? wait_for_completion_killable+0x1c0/0x1c0
> [59783.807124][    C0]  out_of_line_wait_on_bit+0x90/0xb0
> [59783.813649][    C0]  ? swake_up_locked+0x50/0x50
> [59783.819628][    C0]  read_extent_buffer_pages+0x1e8/0x210
> [59783.826412][    C0]  btrfs_read_extent_buffer+0x89/0x170
> [59783.833092][    C0]  read_tree_block+0x3c/0x90
> [59783.838871][    C0]  read_block_for_search+0x24b/0x350
> [59783.845372][    C0]  btrfs_search_slot+0x31e/0xc30
> [59783.851514][    C0]  ? run_delalloc_nocow+0x72/0x780
> [59783.857839][    C0]  btrfs_lookup_file_extent+0x48/0x70
> [59783.864432][    C0]  run_delalloc_nocow+0xd0/0x780
> [59783.870584][    C0]  ? __wake_up+0x54/0x80
> [59783.876000][    C0]  ? merge_next_state+0x27/0xc0
> [59783.882059][    C0]  btrfs_run_delalloc_range+0x51/0x5e0
> [59783.888745][    C0]  ? find_lock_delalloc_range+0x147/0x210
> [59783.895702][    C0]  writepage_delalloc+0xaa/0x140
> [59783.901854][    C0]  extent_write_cache_pages+0x289/0x800
> [59783.908648][    C0]  ? sched_balance_find_src_group+0x4c4/0xc40
> [59783.915984][    C0]  btrfs_writepages+0x69/0xc0
> [59783.921851][    C0]  do_writepages+0xcf/0x260
> [59783.927544][    C0]  ? sched_balance_rq+0x213/0xe80
> [59783.933790][    C0]  __writeback_single_inode+0x51/0x370
> [59783.940486][    C0]  ? wbc_detach_inode+0x129/0x270
> [59783.946726][    C0]  writeback_sb_inodes+0x282/0x560
> [59783.953075][    C0]  __writeback_inodes_wb+0x4c/0xe0
> [59783.959410][    C0]  wb_writeback+0x187/0x300
> [59783.965122][    C0]  wb_workfn+0x2c2/0x4b0
> [59783.970538][    C0]  process_one_work+0x170/0x380
> [59783.976587][    C0]  worker_thread+0x2d8/0x400
> [59783.982359][    C0]  ? cancel_work_sync+0x80/0x80
> [59783.988413][    C0]  kthread+0xc8/0x100
> [59783.993556][    C0]  ? kthread_park+0x90/0x90
> [59783.999233][    C0]  ret_from_fork+0x4c/0x60
> [59784.004814][    C0]  ? kthread_park+0x90/0x90
> [59784.010482][    C0]  ret_from_fork_asm+0x11/0x20
> [59784.016430][    C0]  </TASK>
> [59784.020579][    C0] task:kworker/2:0     state:D stack:0     pid:235839 tgid:235839 ppid:2      flags:0x00004000
> [59784.032377][    C0] Workqueue: events request_firmware_work_func
> [59784.039807][    C0] Call Trace:
> [59784.044224][    C0]  <TASK>
> [59784.048276][    C0]  __schedule+0x3a2/0x1520
> [59784.053884][    C0]  ? blk_mq_flush_plug_list.part.0+0x185/0x5b0
> [59784.061317][    C0]  schedule+0x23/0xf0
> [59784.066472][    C0]  io_schedule+0x4d/0x80
> [59784.071897][    C0]  bit_wait_io+0xd/0x60
> [59784.077237][    C0]  __wait_on_bit+0x41/0x100
> [59784.082940][    C0]  ? wait_for_completion_killable+0x1c0/0x1c0
> [59784.090277][    C0]  out_of_line_wait_on_bit+0x90/0xb0
> [59784.096800][    C0]  ? swake_up_locked+0x50/0x50
> [59784.102778][    C0]  read_extent_buffer_pages+0x1e8/0x210
> [59784.109578][    C0]  btrfs_read_extent_buffer+0x89/0x170
> [59784.116300][    C0]  read_tree_block+0x3c/0x90
> [59784.122114][    C0]  read_block_for_search+0x24b/0x350
> [59784.128656][    C0]  btrfs_search_slot+0x31e/0xc30
> [59784.134834][    C0]  btrfs_lookup_csum+0x6d/0x170
> [59784.140915][    C0]  ? btrfs_csum_root+0x73/0xa0
> [59784.146911][    C0]  btrfs_lookup_bio_sums+0x12b/0x450
> [59784.153453][    C0]  btrfs_submit_chunk+0x134/0x580
> [59784.159718][    C0]  btrfs_submit_bio+0x16/0x30
> [59784.165617][    C0]  submit_one_bio+0x36/0x50
> [59784.171328][    C0]  btrfs_readahead+0x35f/0x390
> [59784.177324][    C0]  ? end_bbio_meta_write+0x320/0x320
> [59784.183857][    C0]  ? memcg_list_lru_alloc+0x3a0/0x3a0
> [59784.190484][    C0]  read_pages+0x58/0x220
> [59784.195920][    C0]  page_cache_ra_unbounded+0x103/0x180
> [59784.202633][    C0]  filemap_get_pages+0x105/0x580
> [59784.208813][    C0]  filemap_read+0xce/0x320
> [59784.214443][    C0]  ? alloc_vmap_area+0x2d2/0xb90
> [59784.220612][    C0]  ? alloc_pages_bulk_noprof+0x4af/0x570
> [59784.227507][    C0]  ? __vmalloc_node_range_noprof+0x381/0x8e0
> [59784.234780][    C0]  ? kernel_read_file+0x1ba/0x280
> [59784.241053][    C0]  __kernel_read+0x15e/0x2e0
> [59784.246853][    C0]  kernel_read_file+0x120/0x280
> [59784.252927][    C0]  kernel_read_file_from_path_initns+0xf2/0x140
> [59784.260443][    C0]  ? fw_map_paged_buf+0x60/0x60
> [59784.266489][    C0]  fw_get_filesystem_firmware+0x146/0x300
> [59784.273447][    C0]  _request_firmware+0x364/0x520
> [59784.279592][    C0]  request_firmware_work_func+0x41/0xa0
> [59784.286364][    C0]  process_one_work+0x170/0x380
> [59784.292422][    C0]  worker_thread+0x2d8/0x400
> [59784.298186][    C0]  ? cancel_work_sync+0x80/0x80
> [59784.304214][    C0]  kthread+0xc8/0x100
> [59784.309322][    C0]  ? kthread_park+0x90/0x90
> [59784.314963][    C0]  ret_from_fork+0x4c/0x60
> [59784.320528][    C0]  ? kthread_park+0x90/0x90
> [59784.326171][    C0]  ret_from_fork_asm+0x11/0x20
> [59784.332085][    C0]  </TASK>
> [59784.336195][    C0] task:kworker/u18:0   state:D stack:0     pid:236036 tgid:236036 ppid:2      flags:0x00004000
> [59784.347964][    C0] Workqueue: events_unbound deferred_probe_work_func
> [59784.355939][    C0] Call Trace:
> [59784.360337][    C0]  <TASK>
> [59784.364365][    C0]  __schedule+0x3a2/0x1520
> [59784.369950][    C0]  ? usb_start_wait_urb+0xbb/0x190 [usbcore]
> [59784.377180][    C0]  schedule+0x23/0xf0
> [59784.382303][    C0]  schedule_timeout+0x160/0x170
> [59784.388343][    C0]  wait_for_completion+0x81/0x130
> [59784.394559][    C0]  rtw_chip_info_setup+0x15a/0x750 [rtw88_core]
> [59784.402071][    C0]  rtw_usb_probe+0x431/0xd00 [rtw88_usb]
> [59784.408929][    C0]  usb_probe_interface+0xfe/0x310 [usbcore]
> [59784.416092][    C0]  really_probe+0xc8/0x3a0
> [59784.421688][    C0]  ? pm_runtime_barrier+0x61/0xb0
> [59784.427918][    C0]  ? driver_probe_device+0xb0/0xb0
> [59784.434233][    C0]  __driver_probe_device+0x78/0x150
> [59784.440637][    C0]  driver_probe_device+0x2d/0xb0
> [59784.446755][    C0]  __device_attach_driver+0x8c/0x100
> [59784.453243][    C0]  bus_for_each_drv+0x80/0xd0
> [59784.459091][    C0]  __device_attach+0xc0/0x1d0
> [59784.464941][    C0]  bus_probe_device+0x89/0xa0
> [59784.470775][    C0]  deferred_probe_work_func+0x8a/0xe0
> [59784.477340][    C0]  process_one_work+0x170/0x380
> [59784.483364][    C0]  worker_thread+0x2d8/0x400
> [59784.489117][    C0]  ? cancel_work_sync+0x80/0x80
> [59784.495138][    C0]  kthread+0xc8/0x100
> [59784.500246][    C0]  ? kthread_park+0x90/0x90
> [59784.505922][    C0]  ret_from_fork+0x4c/0x60
> [59784.511495][    C0]  ? kthread_park+0x90/0x90
> [59784.517147][    C0]  ret_from_fork_asm+0x11/0x20
> [59784.523077][    C0]  </TASK>

