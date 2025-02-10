Return-Path: <linux-btrfs+bounces-11354-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F32A6A2E2CD
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Feb 2025 04:31:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4281F3A3388
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Feb 2025 03:31:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CEB07DA9C;
	Mon, 10 Feb 2025 03:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="L1j5HbVh"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63C8135953;
	Mon, 10 Feb 2025 03:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739158268; cv=none; b=szkg7iSk6IQNTXaW92s9XVznVwVKEEslTxdDhGUoVbUtwbvEBmOuaJEHiShvlf5bWnkxX0CZGe19Sx2FnRwvZ/+WaEXsmgC7OkJPb+ZVG6izz2ntSZOKRf1Y92XbhiCfLmzV3pTZf3T+vZTaLFbIK9KMnc34dd3PBl2/qb3REpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739158268; c=relaxed/simple;
	bh=1f3x+siZYS6LElA4tc1PfNHsa2Zp5kc6L3sGQe4QSG8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KxTovbbi+kplOEEJRxvnVku35qc/Gk7/m1lM/9QjhrOR82ezhLcB73MgGi2YxnYnqmH2slaCdTUnj9TZNUtaq7Yl4ugJtMGnDW/7sXUiemH+2C07W3HiyYcbb7xZgHVX9jGuhnsNt7wimi/wa9kXfEn7SJB/xPZ8ikloVpsh6vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=L1j5HbVh; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=jKyKxJG1CehLv64t/I+nNxw205hWiJ7lH/fbFF5jH8U=; b=L1j5HbVhssnJgNwpb9Sp/6knBd
	B6t8fWjANAlAK7V/PhQkNzgeLuKongf1qITJlwlYCLsJ2feCyVv/ZaiU8AzWPGFGmxDpXsm53Svr2
	YPNUnSDGfiox88gM4T31FENNcoaVwY36IAPzaxtoFQ+ZQg1117de38HT0M+vrnJlAIusvpKv3oHBo
	SuoCjBRQtmoiAYvFbHsY99ObjctEM5uzfiYrw06j1MR+yp9nwQziAp3JHoxwVBus9Rpe7CDFFyfuI
	XJf8vowbjsp14t4gYkt8/c1Mg3i18RG8yrlehRgprqPWXXcu9sx/m4vJJ7y2vEEWQIgNMxNCdodOo
	tN/s1SjA==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1thKVk-0000000EbzO-0aMq;
	Mon, 10 Feb 2025 03:31:04 +0000
Date: Mon, 10 Feb 2025 03:31:04 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: Linux Memory Management List <linux-mm@kvack.org>,
	linux-btrfs <linux-btrfs@vger.kernel.org>,
	"fstests@vger.kernel.org" <fstests@vger.kernel.org>
Subject: Re: Btrfs crash on generic/437 on x86_64
Message-ID: <Z6ly-MHIztjtS98S@casper.infradead.org>
References: <152296f3-5c81-4a94-97f3-004108fba7be@gmx.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <152296f3-5c81-4a94-97f3-004108fba7be@gmx.com>

On Mon, Feb 10, 2025 at 01:40:16PM +1030, Qu Wenruo wrote:
> But this one is a little weird, we got a folio which is still mapped
> during filemap_unaccount_folio().
> 
> I can reproduce it with default mount option with generic/437, so far 32
> runs are enough to trigger it reliably.
> 
> And I'm not yet able to reproduce it on aarch64 (64K page size, 4K page
> size so far).
> 
> I'm already trying to bisect the bug, it so far it's still reproducible
> at 6.14-rc1.
> 
> Any advice/clue would be appreciated.
> 
> Dmesg:
> 
> [   58.305921] BTRFS info (device dm-0): using free-space-tree
> [   58.319296] run fstests generic/437 at 2025-02-10 13:24:19
> [   59.283069] BUG: Bad rss-counter state mm:0000000048578720
> type:MM_FILEPAGES val:1

This is the original problem, all else is a consequence.  We're calling
check_mm() in __mmdrop() -- ie we're dropping the last refcount on a
task, and the counters show one page is still mapped.  And it's a file
page.  (now see below for the consequence)

> [   59.296485] page: refcount:3 mapcount:1 mapping:00000000828f872f
> index:0x0 pfn:0x13ab4f

This folio still has a mapcount of 1.

> [   59.297223] memcg:ffff888105a32000
> [   59.297533] aops:btrfs_aops [btrfs] ino:1031b
> [   59.298188] flags:
> 0x2ffff800000002d(locked|referenced|uptodate|lru|node=0|zone=2|lastcpupid=0x1ffff)
> [   59.298955] raw: 02ffff800000002d ffffea0004184948 ffffea0004c40c88
> ffff888107c7a2b8
> [   59.299607] raw: 0000000000000000 0000000000000000 0000000300000000
> ffff888105a32000
> [   59.300261] page dumped because: VM_BUG_ON_FOLIO(folio_mapped(folio))
> [   59.300846] ------------[ cut here ]------------
> [   59.301256] kernel BUG at mm/filemap.c:154!
> [   59.301635] Oops: invalid opcode: 0000 [#1] PREEMPT SMP NOPTI
> [   59.302144] CPU: 4 UID: 0 PID: 17354 Comm: umount Tainted: G
>  OE      6.14.0-rc1-custom+ #211
> [   59.302953] Tainted: [O]=OOT_MODULE, [E]=UNSIGNED_MODULE
> [   59.303447] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS
> unknown 02/02/2022
> [   59.304291] RIP: 0010:filemap_unaccount_folio+0x153/0x1f0
> [   59.305224] Code: b0 f0 00 00 00 e9 5d f6 00 00 48 c7 c6 80 1b 43 82
> 48 89 df e8 ae 89 04 00 0f 0b 48 c7 c6 10 d8 44 82 48 89 df e8 9d 89 04
> 00 <0f> 0b 48 8b 06 a8 40 74 4c 8b 43 50 e9 ce fe ff ff 48 c7 c6 80 1b
> [   59.308807] RSP: 0018:ffffc90005387a18 EFLAGS: 00010046
> [   59.309382] RAX: 0000000000000039 RBX: ffffea0004ead3c0 RCX:
> 0000000000000027
> [   59.310313] RDX: 0000000000000000 RSI: 0000000000000001 RDI:
> ffff888277c21880
> [   59.311856] RBP: ffff888107c7a2b8 R08: ffffffff82cad0a8 R09:
> 00000000fffff000
> [   59.312879] R10: ffffffff82c55100 R11: 6d75642065676170 R12:
> 0000000000000001
> [   59.313607] R13: ffffffffffffffff R14: ffffc90005387ad8 R15:
> ffff888107c7a2c0
> [   59.314347] FS:  00007ff0455f2b80(0000) GS:ffff888277c00000(0000)
> knlGS:0000000000000000
> [   59.315159] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   59.315744] CR2: 000055e761f94f58 CR3: 0000000166a44000 CR4:
> 00000000000006f0
> [   59.316476] Call Trace:
> [   59.316749]  <TASK>
> [   59.321408]  delete_from_page_cache_batch+0x95/0x3c0
> [   59.321912]  truncate_inode_pages_range+0x142/0x570
> [   59.322413]  btrfs_evict_inode+0x8b/0x390 [btrfs]

So we're evicting an inode, and we ask truncate_inode_pages_range()
to get rid of all the folios in the inode's mapping.  It walks the
rmap to find them all ... and doesn't find the one above because it's
exited already.

We need to figure out how we came to not unmap the page from the page
tables originally.  Looking through the merge log of the mm tree, my
suspicion falls on the following patchsets:

       - "synchronously scan and reclaim empty user PTE pages" from Qi Zheng
         addresses an issue where "huge" amounts of pte pagetables are
         accumulated:

       - "mm/vma: make more mmap logic userland testable" from Lorenzo
         Stoakes continues the work of moving vma-related code into the
         (relatively) new mm/vma.c

but of course it could be almost anything.

