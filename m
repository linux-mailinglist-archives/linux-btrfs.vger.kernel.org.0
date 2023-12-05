Return-Path: <linux-btrfs+bounces-637-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 380E78056C4
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Dec 2023 15:07:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E18B1281D35
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Dec 2023 14:07:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 028FB61FC4;
	Tue,  5 Dec 2023 14:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Tm0LKl3v";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Zj/pfwXt"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2a07:de40:b251:101:10:150:64:2])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C469B9
	for <linux-btrfs@vger.kernel.org>; Tue,  5 Dec 2023 06:07:17 -0800 (PST)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id BDB151FB3F;
	Tue,  5 Dec 2023 14:07:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1701785233;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fzyibvV3Dsfs9Doz/3YTRYmUl1IG7CZvnaG3pePqsLY=;
	b=Tm0LKl3vh9cQTjLEoLyfZvDgSndUw5Ke9+2mbHWpahHnJaWiPJegtxL/e+YUKu+OLKyNgT
	Ys6616d438ZXtNCkx1TpPQKzR9meuQg8l3jshNia9xlViu13Wg2PLjvGCZdLKb+Sgc+Dc4
	UAYyFyXBKMB3aLmC/jsq44DH8zipido=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1701785233;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fzyibvV3Dsfs9Doz/3YTRYmUl1IG7CZvnaG3pePqsLY=;
	b=Zj/pfwXt73K/iPzI3QgKk6sj0VBzyUX/Gb2vK2hXdJwOsaE/3wExXr3+sZMKaU7DaX7sxu
	7DsBNOVR/yiPeYCw==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 830DD138FF;
	Tue,  5 Dec 2023 14:07:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id UL5zHZEub2UgfwAAn2gu4w
	(envelope-from <dsterba@suse.cz>); Tue, 05 Dec 2023 14:07:13 +0000
Date: Tue, 5 Dec 2023 15:00:23 +0100
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 2/2] btrfs: cleanup metadata page pointer usage
Message-ID: <20231205140023.GA2751@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1701410200.git.wqu@suse.com>
 <1d39380364ff0a1c8e6e352a98312fb2a860f25b.1701410201.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1d39380364ff0a1c8e6e352a98312fb2a860f25b.1701410201.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -1.18
X-Spamd-Result: default: False [-1.18 / 50.00];
	 ARC_NA(0.00)[];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_TWO(0.00)[2];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,opensuse.org:url];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-1.18)[88.97%]

On Fri, Dec 01, 2023 at 04:36:55PM +1030, Qu Wenruo wrote:
> Although we have migrated extent_buffer::pages[] to folios[], we're
> still mostly using the folio_page() help to grab the page.
> 
> This patch would do the following cleanups for metadata:
> 
> - Introduce num_extent_folios() helper
>   This is to replace most num_extent_pages() callers.
> 
> - Use num_extent_folios() to iterate future large folios
>   This allows us to use things like
>   bio_add_folio()/bio_add_folio_nofail(), and only set the needed flags
>   for the folio (aka the leading/tailing page), which reduces the loop
>   iteration to 1 for large folios.
> 
> - Change metadata related functions to use folio pointers
>   Including their function name, involving:
>   * attach_extent_buffer_page()
>   * detach_extent_buffer_page()
>   * page_range_has_eb()
>   * btrfs_release_extent_buffer_pages()
>   * btree_clear_page_dirty()
>   * btrfs_page_inc_eb_refs()
>   * btrfs_page_dec_eb_refs()
> 
> - Change btrfs_is_subpage() to accept an address_space pointer
>   This is to allow both page->mapping and folio->mapping to be utilized.
>   As data is still using the old per-page code, and may keep so for a
>   while.
> 
> - Special corner case place holder for future order mismatches between
>   extent buffer and inode filemap
>   For now it's  just a block of comments and a dead ASSERT(), no real
>   handling yet.
> 
> The subpage code would still go page, just because subpage and large
> folio are conflicting conditions, thus we don't need to bother subpage
> with higher order folios at all. Just folio_page(folio, 0) would be
> enough.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

KASAN reports some problems:

[  228.984474] Btrfs loaded, debug=on, assert=on, ref-verify=on, zoned=yes, fsverity=yes
[  228.986241] BTRFS: selftest: sectorsize: 4096  nodesize: 4096
[  228.987192] BTRFS: selftest: running btrfs free space cache tests
[  228.988141] BTRFS: selftest: running extent only tests
[  228.989096] BTRFS: selftest: running bitmap only tests
[  228.990108] BTRFS: selftest: running bitmap and extent tests
[  228.991396] BTRFS: selftest: running space stealing from bitmap to extent tests
[  228.993137] BTRFS: selftest: running bytes index tests
[  228.994741] BTRFS: selftest: running extent buffer operation tests
[  228.995875] BTRFS: selftest: running btrfs_split_item tests
[  228.997062] ==================================================================
[  228.998388] BUG: KASAN: global-out-of-bounds in alloc_eb_folio_array+0xd6/0x180 [btrfs]
[  229.000005] Read of size 8 at addr ffffffffc07f32e8 by task modprobe/13543
[  229.000973] 
[  229.001294] CPU: 2 PID: 13543 Comm: modprobe Tainted: G           O       6.7.0-rc4-default+ #2250
[  229.002556] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.2-3-gd478f380-rebuilt.opensuse.org 04/01/2014
[  229.004054] Call Trace:
[  229.004489]  <TASK>
[  229.004913]  dump_stack_lvl+0x46/0x70
[  229.005546]  print_address_description.constprop.0+0x30/0x420
[  229.006431]  print_report+0xb0/0x260
[  229.007023]  ? kasan_addr_to_slab+0x9/0xc0
[  229.007685]  kasan_report+0xbe/0xf0
[  229.008275]  ? alloc_eb_folio_array+0xd6/0x180 [btrfs]
[  229.009212]  ? alloc_eb_folio_array+0xd6/0x180 [btrfs]
[  229.010113]  alloc_eb_folio_array+0xd6/0x180 [btrfs]
[  229.010932]  ? btrfs_alloc_page_array+0x100/0x100 [btrfs]
[  229.011816]  ? is_module_address+0x11/0x30
[  229.012488]  ? static_obj+0x73/0xa0
[  229.013054]  ? lockdep_init_map_type+0xe8/0x360
[  229.013751]  ? __raw_spin_lock_init+0x73/0x90
[  229.014426]  ? __alloc_extent_buffer+0x14a/0x190 [btrfs]
[  229.015225]  __alloc_dummy_extent_buffer+0x2e/0x2b0 [btrfs]
[  229.016121]  test_btrfs_split_item+0xcf/0x7d0 [btrfs]
[  229.016995]  ? btrfs_test_free_space_cache+0x1e0/0x1e0 [btrfs]
[  229.017872]  ? info_print_prefix+0x100/0x100
[  229.018523]  ? btrfs_test_free_space_cache+0xda/0x1e0 [btrfs]
[  229.019461]  ? __kmem_cache_free+0xfa/0x200
[  229.020064]  btrfs_run_sanity_tests+0x78/0x140 [btrfs]
[  229.020976]  init_btrfs_fs+0x38/0x220 [btrfs]
[  229.021867]  ? btrfs_interface_init+0x20/0x20 [btrfs]
[  229.022818]  do_one_initcall+0xc3/0x3b0
[  229.023473]  ? trace_event_raw_event_initcall_level+0x150/0x150
[  229.024436]  ? __kmem_cache_alloc_node+0x1b5/0x2e0
[  229.025279]  ? do_init_module+0x38/0x3b0
[  229.025806]  ? kasan_unpoison+0x40/0x60
[  229.026477]  do_init_module+0x135/0x3b0
[  229.027134]  load_module+0x11c1/0x13c0
[  229.027766]  ? layout_and_allocate.isra.0+0x280/0x280
[  229.028435]  ? kernel_read_file+0x252/0x3f0
[  229.029060]  ? __ia32_sys_fsconfig+0x70/0x70
[  229.029755]  ? init_module_from_file+0xd1/0x130
[  229.030489]  init_module_from_file+0xd1/0x130
[  229.031184]  ? __do_sys_init_module+0x1a0/0x1a0
[  229.031954]  ? idempotent_init_module+0x3b9/0x3d0
[  229.032727]  ? do_raw_spin_unlock+0x84/0xf0
[  229.033393]  idempotent_init_module+0x1ac/0x3d0
[  229.034101]  ? init_module_from_file+0x130/0x130
[  229.034837]  ? __fget_files+0xfd/0x1e0
[  229.035449]  __x64_sys_finit_module+0x72/0xb0
[  229.037902]  do_syscall_64+0x41/0xe0
[  229.038495]  entry_SYSCALL_64_after_hwframe+0x46/0x4e
[  229.039314] RIP: 0033:0x7f07839f53dd
[  229.042725] RSP: 002b:00007fff7eb94c18 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
[  229.043642] RAX: ffffffffffffffda RBX: 00005574ab37ba20 RCX: 00007f07839f53dd
[  229.044833] RDX: 0000000000000000 RSI: 00005574ab372c5a RDI: 000000000000000e
[  229.046002] RBP: 00005574ab372c5a R08: 0000000000000000 R09: 00005574ab37baa0
[  229.047195] R10: 00005574ab37f850 R11: 0000000000000246 R12: 0000000000040000
[  229.048275] R13: 0000000000000000 R14: 00005574ab3841b0 R15: 00005574ab37b480
[  229.049320]  </TASK>
[  229.049767] 
[  229.050124] The buggy address belongs to the variable:
[  229.050961]  __func__.1+0x288/0xffffffffffeeafa0 [btrfs]
[  229.051928] 
[  229.052205] Memory state around the buggy address:
[  229.052971]  ffffffffc07f3180: f9 f9 f9 f9 00 04 f9 f9 f9 f9 f9 f9 00 00 00 00
[  229.054075]  ffffffffc07f3200: 00 00 00 00 03 f9 f9 f9 f9 f9 f9 f9 00 00 00 03
[  229.055173] >ffffffffc07f3280: f9 f9 f9 f9 00 02 f9 f9 f9 f9 f9 f9 00 07 f9 f9
[  229.056210]                                                           ^
[  229.057066]  ffffffffc07f3300: f9 f9 f9 f9 00 00 00 00 04 f9 f9 f9 f9 f9 f9 f9
[  229.058152]  ffffffffc07f3380: 00 00 00 02 f9 f9 f9 f9 00 00 03 f9 f9 f9 f9 f9
[  229.059119] ==================================================================
[  229.060341] Disabling lock debugging due to kernel taint
[  229.061254] BUG: unable to handle page fault for address: 00006b636f6c5f7a
[  229.062383] #PF: supervisor read access in kernel mode
[  229.063232] #PF: error_code(0x0000) - not-present page
[  229.064079] PGD 0 P4D 0 
[  229.064544] Oops: 0000 [#1] PREEMPT SMP KASAN
[  229.065296] CPU: 2 PID: 13543 Comm: modprobe Tainted: G    B      O       6.7.0-rc4-default+ #2250
[  229.066783] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.2-3-gd478f380-rebuilt.opensuse.org 04/01/2014
[  229.068574] RIP: 0010:folio_flags.constprop.0+0x12/0x30 [btrfs]
[  229.072394] RSP: 0018:ffff88800294f840 EFLAGS: 00010282
[  229.073281] RAX: 0000000000000000 RBX: 00006b636f6c5f72 RCX: ffffffffc05c5c12
[  229.074409] RDX: 0000000000000000 RSI: 0000000000000008 RDI: 00006b636f6c5f7a
[  229.075488] RBP: 00006b636f6c5f72 R08: 0000000000000001 R09: fffffbfff37183f8
[  229.076600] R10: ffffffff9b8c1fc7 R11: 0000000000000001 R12: 0000000000000000
[  229.077723] R13: ffff88801d1e4008 R14: 0000000000001000 R15: ffffffffc08b0228
[  229.078905] FS:  00007f07838e5740(0000) GS:ffff88806ce00000(0000) knlGS:0000000000000000
[  229.080262] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  229.081228] CR2: 00006b636f6c5f7a CR3: 000000000598a000 CR4: 00000000000006b0
[  229.082417] Call Trace:
[  229.082849]  <TASK>
[  229.083289]  ? __die+0x1f/0x60
[  229.083896]  ? page_fault_oops+0x71/0xa0
[  229.084629]  ? exc_page_fault+0x69/0xd0
[  229.085354]  ? asm_exc_page_fault+0x22/0x30
[  229.086130]  ? folio_flags.constprop.0+0x12/0x30 [btrfs]
[  229.087170]  ? folio_flags.constprop.0+0x12/0x30 [btrfs]
[  229.088173]  __alloc_dummy_extent_buffer+0x5b/0x2b0 [btrfs]
[  229.089206]  test_btrfs_split_item+0xcf/0x7d0 [btrfs]
[  229.090139]  ? btrfs_test_free_space_cache+0x1e0/0x1e0 [btrfs]
[  229.091192]  ? info_print_prefix+0x100/0x100
[  229.091900]  ? btrfs_test_free_space_cache+0xda/0x1e0 [btrfs]
[  229.092924]  ? __kmem_cache_free+0xfa/0x200
[  229.093604]  btrfs_run_sanity_tests+0x78/0x140 [btrfs]
[  229.094544]  init_btrfs_fs+0x38/0x220 [btrfs]
[  229.095401]  ? btrfs_interface_init+0x20/0x20 [btrfs]
[  229.096325]  do_one_initcall+0xc3/0x3b0
[  229.096948]  ? trace_event_raw_event_initcall_level+0x150/0x150
[  229.097765]  ? __kmem_cache_alloc_node+0x1b5/0x2e0
[  229.098594]  ? do_init_module+0x38/0x3b0
[  229.099189]  ? kasan_unpoison+0x40/0x60
[  229.099794]  do_init_module+0x135/0x3b0
[  229.100479]  load_module+0x11c1/0x13c0
[  229.101095]  ? layout_and_allocate.isra.0+0x280/0x280
[  229.101874]  ? kernel_read_file+0x252/0x3f0
[  229.102481]  ? __ia32_sys_fsconfig+0x70/0x70
[  229.103189]  ? init_module_from_file+0xd1/0x130
[  229.103918]  init_module_from_file+0xd1/0x130
[  229.104615]  ? __do_sys_init_module+0x1a0/0x1a0
[  229.105352]  ? idempotent_init_module+0x3b9/0x3d0
[  229.106118]  ? do_raw_spin_unlock+0x84/0xf0
[  229.106787]  idempotent_init_module+0x1ac/0x3d0
[  229.107592]  ? init_module_from_file+0x130/0x130
[  229.108413]  ? __fget_files+0xfd/0x1e0
[  229.108979]  __x64_sys_finit_module+0x72/0xb0
[  229.109686]  do_syscall_64+0x41/0xe0
[  229.110286]  entry_SYSCALL_64_after_hwframe+0x46/0x4e
[  229.111074] RIP: 0033:0x7f07839f53dd
[  229.114183] RSP: 002b:00007fff7eb94c18 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
[  229.115057] RAX: ffffffffffffffda RBX: 00005574ab37ba20 RCX: 00007f07839f53dd
[  229.116099] RDX: 0000000000000000 RSI: 00005574ab372c5a RDI: 000000000000000e
[  229.117162] RBP: 00005574ab372c5a R08: 0000000000000000 R09: 00005574ab37baa0
[  229.118178] R10: 00005574ab37f850 R11: 0000000000000246 R12: 0000000000040000
[  229.119254] R13: 0000000000000000 R14: 00005574ab3841b0 R15: 00005574ab37b480
[  229.120183]  </TASK>
[  229.120582] Modules linked in: btrfs(O+) blake2b_generic libcrc32c xor lzo_compress lzo_decompress raid6_pq zstd_decompress zstd_compress xxhash zstd_common loop
[  229.122735] CR2: 00006b636f6c5f7a
[  229.123266] ---[ end trace 0000000000000000 ]---
[  229.123916] RIP: 0010:folio_flags.constprop.0+0x12/0x30 [btrfs]
[  229.127469] RSP: 0018:ffff88800294f840 EFLAGS: 00010282
[  229.128273] RAX: 0000000000000000 RBX: 00006b636f6c5f72 RCX: ffffffffc05c5c12
[  229.129305] RDX: 0000000000000000 RSI: 0000000000000008 RDI: 00006b636f6c5f7a
[  229.130327] RBP: 00006b636f6c5f72 R08: 0000000000000001 R09: fffffbfff37183f8
[  229.131362] R10: ffffffff9b8c1fc7 R11: 0000000000000001 R12: 0000000000000000
[  229.132442] R13: ffff88801d1e4008 R14: 0000000000001000 R15: ffffffffc08b0228
[  229.133657] FS:  00007f07838e5740(0000) GS:ffff88806ce00000(0000) knlGS:0000000000000000
[  229.134887] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  229.135776] CR2: 00006b636f6c5f7a CR3: 000000000598a000 CR4: 00000000000006b0

