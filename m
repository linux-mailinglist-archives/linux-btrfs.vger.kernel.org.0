Return-Path: <linux-btrfs+bounces-13808-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AC06AAE849
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 May 2025 19:57:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66C689E06EA
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 May 2025 17:56:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC41628DEE2;
	Wed,  7 May 2025 17:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="AS8sAdy/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="I8iDZu3Z"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23E2A28DF2C
	for <linux-btrfs@vger.kernel.org>; Wed,  7 May 2025 17:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746640569; cv=none; b=Ylyj0KB+eqeP27aUVaQewFXuNgiHbNiddLb1nnh7zcbuVtQovDk2igXokdXzB3SqFwBfxCYpsQedTh3S5jqUgMCSkjIEvJqg94sMtCKWuIUQ1Ihq3DVEZHGmkLHLLT6TKco/GnSfcZy/sbpnhmDCLQbG7EG4r5lsMGdmqL9i6T4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746640569; c=relaxed/simple;
	bh=3jXUE0omBhPjs6f+Wzrgceg0upHUvPWcSzVcu/ml9vE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kqfPrH8Ia4JfkQgR6Sfl0379/aR2kMKQsMoSLR4KY54Q/LTKDd3oECshtVp1DVEO9vYYmEkHC2L9Pt0ALqjrH7oCX3EU2PWl6GTrrzv99fFYjC2zBU9TeA7pCGWqwipR7bM9iV2E/21YOX6Vj/5MRlgHDO5QWd81nip4yEBZZcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=AS8sAdy/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=I8iDZu3Z; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id EE9D825400D3;
	Wed,  7 May 2025 13:56:05 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Wed, 07 May 2025 13:56:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1746640565;
	 x=1746726965; bh=9Mu2lM2tmk1Y4rPyMS7NPn63feko5LOPkxVDCvezj8I=; b=
	AS8sAdy/jH9rhm/dVI3fq7FnMYRX2ieXjloRErGOhk4ZTWDCl+Z+RB0defZo5VLV
	2njNLHmFOEk7aSR+rP4JMp4kA/0N9j4RJnhPEJTRpvGCcB+8SkaljgcPt7pfJCFi
	1UkR3nqMDrJPNZdz5C8iWDxCYGCE6nJwztK6oySjuUGDdnkQZ8M1WvCw/85BByNv
	GzMDc7XUaV+6mHhdrKI000kRp2Gj1BLg9n3RgL75wRxhuRp7J4C7qZzxp4bnqapd
	3aOBLYoOiXXyOh3tBj+jQ/zQEJ0FRtwuak3Bj19t8kCGEO9oqfqD5OZty3PGAZQD
	SafpZjcng/dphcT17FA4Qg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1746640565; x=
	1746726965; bh=9Mu2lM2tmk1Y4rPyMS7NPn63feko5LOPkxVDCvezj8I=; b=I
	8iDZu3ZoWGP9mUz7KgDZQUU4LfHeB9WvL58wWM04DOjbRYM9CaDlGeJHZCDFda1o
	guq8NFjd4NfDLadnNH+tjHOoX93dNvvkJ8d4zP/wKq+KCm7j9WXt5cNWEYt3yLPT
	arRndvhB+jlwubNTMzYHYAoi967IkVNRqyOMT229ySYtF6d+HdQpqdkmDKgyA0Ty
	isPtUVmrO0TwvzcxasgJ2WE449Of2QXfO2uGM6Yf/EG+fLz9s/TCC+ogpY/5NKtj
	M633TG+jh6XXdG0SbCxZGeuB0yNh4lNbo7obCHXnasmF7T7gkhSuKHbCphQ7GtLz
	1pLojCR9U8q9jn7tgQSLA==
X-ME-Sender: <xms:tZ4baJToMIRjzmXJI1xILMWi3YpJiBL9iJuOZ31NIAnotPs-zrsz-Q>
    <xme:tZ4baCwbLkK0Umy08inbBu2GjDPDdQhhcYKjjmthlYucv1uUIOtsNIGIQtHyJloOL
    KNR6M2hRFNsfFAAsWw>
X-ME-Received: <xmr:tZ4baO1x-8WRGf4RbHA5UFmQ8OqmwKdDSs7xo7AfDCy1mrDr1SgIUVA0g63TzcuZHHEUU_jDIoxFf3SoHv-RQMeaR5o>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvkeejheduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddt
    tdejnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhioh
    eqnecuggftrfgrthhtvghrnhepudetveejteehgfdtvefhveevhfdtveevueefhfejgeeh
    hfejgfetkedugefftdeinecuffhomhgrihhnpehqvghmuhdrohhrghenucevlhhushhtvg
    hrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhrihhssegsuhhrrdhi
    ohdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepfh
    gumhgrnhgrnhgrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdgsthhr
    fhhssehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:tZ4baBDcyQWvmxW5bDYKHdOenq0r9N_Iqb5fL7lULIqXSLxjvA5JfQ>
    <xmx:tZ4baCjXrM1i0m7GYIaxhsdWJdituO_QTTVn-kwy25UIBZWse2AZ0Q>
    <xmx:tZ4baFoorGVYYQ8_amRK_4E3YhTbX8A-xdZnSPAmsxPqHhptcpbhDw>
    <xmx:tZ4baNibI6jRXrJr854Z0T52ru4FWYWGwtrN3a1pmvFI-0HSjmTw7g>
    <xmx:tZ4baAPRI9bvypX3KZosh2WF6o80jRsCo_0KCPhj19j-0JE_CXHKxuVX>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 7 May 2025 13:56:05 -0400 (EDT)
Date: Wed, 7 May 2025 10:56:48 -0700
From: Boris Burkov <boris@bur.io>
To: Filipe Manana <fdmanana@kernel.org>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: fix use-after-free on extent state when clearing
 or converting range
Message-ID: <20250507175648.GA2049866@zen.localdomain>
References: <6c867267b93c24307018cd43f52151bef5b87ded.1746572669.git.fdmanana@suse.com>
 <20250507174039.GA1626532@zen.localdomain>
 <CAL3q7H6ubDxNuxf31skLvaavpz4DDxADcFK_Q7prjUz1Jk0vKA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL3q7H6ubDxNuxf31skLvaavpz4DDxADcFK_Q7prjUz1Jk0vKA@mail.gmail.com>

On Wed, May 07, 2025 at 06:50:29PM +0100, Filipe Manana wrote:
> On Wed, May 7, 2025 at 6:41 PM Boris Burkov <boris@bur.io> wrote:
> >
> > On Wed, May 07, 2025 at 12:05:16AM +0100, fdmanana@kernel.org wrote:
> > > From: Filipe Manana <fdmanana@suse.com>
> > >
> > > When clearing or converting a range in an extent io tree, before calling
> > > clear_state_bit() against the current extent state record, we grab the
> > > next extent state to process and then use it. However when we attempt to
> > > use it, it may have been freed by the clear_state_bit() call we just did
> > > in case it merged the current extent state with the next state, as in
> > > the case the current extent state is expanded to cover the range of the
> > > next state and the next state record is freed.
> > >
> > > Boris was running into an use-after-free due to that particular situation
> > > when running generic/465 with a kernel that has KASAN enabled, triggering
> > > the following stack trace:
> > >
> > >    [ 1091.984085] run fstests generic/465 at 2025-05-06 23:15:33
> > >    [ 1098.142785] ==================================================================
> > >    [ 1098.144066] BUG: KASAN: slab-use-after-free in btrfs_clear_extent_bit_changeset+0x955/0xd00 [btrfs]
> > >    [ 1098.145844] Read of size 8 at addr ffff88813beecee0 by task aio-dio-append-/33544
> > >
> > >    [ 1098.147319] CPU: 9 UID: 0 PID: 33544 Comm: aio-dio-append- Not tainted 6.15.0-rc5-btrfs-next-196+ #2 PREEMPT(full)
> > >    [ 1098.147326] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.2-0-gea1b7a073390-prebuilt.qemu.org 04/01/2014
> > >    [ 1098.147329] Call Trace:
> > >    [ 1098.147333]  <TASK>
> > >    [ 1098.147337]  dump_stack_lvl+0x62/0x80
> > >    [ 1098.147352]  print_report+0xc1/0x610
> > >    [ 1098.147359]  ? __virt_addr_valid+0x1b2/0x2b0
> > >    [ 1098.147367]  ? btrfs_clear_extent_bit_changeset+0x955/0xd00 [btrfs]
> > >    [ 1098.147595]  kasan_report+0xb4/0xe0
> > >    [ 1098.147602]  ? btrfs_clear_extent_bit_changeset+0x955/0xd00 [btrfs]
> > >    [ 1098.147749]  btrfs_clear_extent_bit_changeset+0x955/0xd00 [btrfs]
> > >    [ 1098.147897]  btrfs_dio_iomap_begin+0x319/0x1940 [btrfs]
> > >    [ 1098.148048]  ? __pfx_btrfs_dio_iomap_begin+0x10/0x10 [btrfs]
> > >    [ 1098.148194]  ? __pfx_btrfs_dio_iomap_begin+0x10/0x10 [btrfs]
> > >    [ 1098.148336]  iomap_iter+0x458/0xbc0
> > >    [ 1098.148344]  ? filemap_check_errors+0x50/0xe0
> > >    [ 1098.148351]  __iomap_dio_rw+0x5fc/0x1820
> > >    [ 1098.148356]  ? llist_add_batch+0xbb/0x140
> > >    [ 1098.148363]  ? __pfx___iomap_dio_rw+0x10/0x10
> > >    [ 1098.148367]  ? schedule+0x74/0x180
> > >    [ 1098.148372]  ? preempt_count_add+0x7d/0x150
> > >    [ 1098.148379]  ? rwsem_down_read_slowpath+0x2f4/0xd00
> > >    [ 1098.148385]  ? __pfx_rwsem_down_read_slowpath+0x10/0x10
> > >    [ 1098.148394]  ? rwsem_wake+0xc9/0x110
> > >    [ 1098.148399]  ? __pfx_down_read+0x10/0x10
> > >    [ 1098.148405]  iomap_dio_rw+0xe/0x40
> > >    [ 1098.148409]  btrfs_direct_read+0x40e/0x6c0 [btrfs]
> > >    [ 1098.148555]  ? __pfx_btrfs_direct_read+0x10/0x10 [btrfs]
> > >    [ 1098.148700]  btrfs_file_read_iter+0x4f/0x1a0 [btrfs]
> > >    [ 1098.148845]  vfs_read+0x63b/0x900
> > >    [ 1098.148851]  ? __pfx_vfs_read+0x10/0x10
> > >    [ 1098.148855]  ? _raw_spin_unlock_irq+0x1b/0x40
> > >    [ 1098.148860]  ? sigprocmask+0x156/0x280
> > >    [ 1098.148865]  ? __rseq_handle_notify_resume+0x9c0/0xc60
> > >    [ 1098.148871]  ? fdget+0x2ba/0x3c0
> > >    [ 1098.148878]  ksys_pread64+0x112/0x140
> > >    [ 1098.148882]  ? __pfx_ksys_pread64+0x10/0x10
> > >    [ 1098.148887]  ? fpregs_assert_state_consistent+0x4d/0xb0
> > >    [ 1098.148892]  do_syscall_64+0x4a/0x110
> > >    [ 1098.148897]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> > >    [ 1098.148902] RIP: 0033:0x7f307d1becb7
> > >    [ 1098.148907] Code: 08 89 3c 24 (...)
> > >    [ 1098.148911] RSP: 002b:00007f307ced2e90 EFLAGS: 00000293 ORIG_RAX: 0000000000000011
> > >    [ 1098.148916] RAX: ffffffffffffffda RBX: 00007fff17a99660 RCX: 00007f307d1becb7
> > >    [ 1098.148920] RDX: 0000000000100000 RSI: 00007f307ced5000 RDI: 0000000000000004
> > >    [ 1098.148922] RBP: 00005650e39cb004 R08: 0000000000000000 R09: 00007f307ced36c0
> > >    [ 1098.148925] R10: 0000000000a00000 R11: 0000000000000293 R12: ffffffffffffff88
> > >    [ 1098.148928] R13: 0000000000000000 R14: 00007fff17a99410 R15: 00007f307c6d3000
> > >    [ 1098.148934]  </TASK>
> > >
> > >    [ 1098.186955] Allocated by task 33532:
> > >    [ 1098.187472]  kasan_save_stack+0x20/0x40
> > >    [ 1098.188029]  kasan_save_track+0x10/0x30
> > >    [ 1098.188580]  __kasan_slab_alloc+0x55/0x70
> > >    [ 1098.189159]  kmem_cache_alloc_noprof+0x13b/0x3b0
> > >    [ 1098.189830]  alloc_extent_state+0x21/0x2e0 [btrfs]
> > >    [ 1098.190676]  btrfs_clear_extent_bit_changeset+0x810/0xd00 [btrfs]
> > >    [ 1098.191682]  try_release_extent_mapping+0x4fe/0x6c0 [btrfs]
> > >    [ 1098.192627]  btrfs_release_folio+0x80/0xc0 [btrfs]
> > >    [ 1098.193549]  mapping_evict_folio.part.0+0x143/0x1a0
> > >    [ 1098.194281]  mapping_try_invalidate+0x12d/0x2c0
> > >    [ 1098.194944]  btrfs_direct_write+0x872/0xb50 [btrfs]
> > >    [ 1098.195790]  btrfs_do_write_iter+0x34e/0x6c0 [btrfs]
> > >    [ 1098.196314]  vfs_write+0x876/0xc40
> > >    [ 1098.196613]  ksys_pwrite64+0x112/0x140
> > >    [ 1098.196939]  do_syscall_64+0x4a/0x110
> > >    [ 1098.197332]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> > >
> > >    [ 1098.198045] Freed by task 33544:
> > >    [ 1098.198432]  kasan_save_stack+0x20/0x40
> > >    [ 1098.198899]  kasan_save_track+0x10/0x30
> > >    [ 1098.199352]  kasan_save_free_info+0x36/0x60
> > >    [ 1098.199859]  __kasan_slab_free+0x34/0x50
> > >    [ 1098.200331]  kmem_cache_free+0x2b4/0x4c0
> > >    [ 1098.200824]  btrfs_clear_extent_bit_changeset+0x314/0xd00 [btrfs]
> > >    [ 1098.201578]  btrfs_dio_iomap_begin+0x319/0x1940 [btrfs]
> > >    [ 1098.202638]  iomap_iter+0x458/0xbc0
> > >    [ 1098.203296]  __iomap_dio_rw+0x5fc/0x1820
> > >    [ 1098.204031]  iomap_dio_rw+0xe/0x40
> > >    [ 1098.204670]  btrfs_direct_read+0x40e/0x6c0 [btrfs]
> > >    [ 1098.205691]  btrfs_file_read_iter+0x4f/0x1a0 [btrfs]
> > >    [ 1098.206719]  vfs_read+0x63b/0x900
> > >    [ 1098.207334]  ksys_pread64+0x112/0x140
> > >    [ 1098.208043]  do_syscall_64+0x4a/0x110
> > >    [ 1098.208757]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> > >
> > >    [ 1098.209988] The buggy address belongs to the object at ffff88813beecee0
> > >                    which belongs to the cache btrfs_extent_state of size 88
> > >    [ 1098.212355] The buggy address is located 0 bytes inside of
> > >                    freed 88-byte region [ffff88813beecee0, ffff88813beecf38)
> > >
> > >    [ 1098.214746] The buggy address belongs to the physical page:
> > >    [ 1098.215698] page: refcount:0 mapcount:0 mapping:0000000000000000 index:0xffff88813beec3f0 pfn:0x13beec
> > >    [ 1098.217258] flags: 0x17fffc000000200(workingset|node=0|zone=2|lastcpupid=0x1ffff)
> > >    [ 1098.218284] page_type: f5(slab)
> > >    [ 1098.218666] raw: 017fffc000000200 ffff88818647c580 ffff88817f7b6150 ffff88817f7b6150
> > >    [ 1098.219588] raw: ffff88813beec3f0 0000000000140013 00000000f5000000 0000000000000000
> > >    [ 1098.220725] page dumped because: kasan: bad access detected
> > >
> > >    [ 1098.221985] Memory state around the buggy address:
> > >    [ 1098.222824]  ffff88813beecd80: fb fb fb fb fb fc fc fc fc fc fc fc fc fc fc fc
> > >    [ 1098.224078]  ffff88813beece00: fc fc fc 00 00 00 00 00 00 00 00 00 00 00 fc fc
> > >    [ 1098.225322] >ffff88813beece80: fc fc fc fc fc fc fc fc fc fc fc fc fa fb fb fb
> > >    [ 1098.226649]                                                        ^
> > >    [ 1098.227489]  ffff88813beecf00: fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc fc
> > >    [ 1098.228327]  ffff88813beecf80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> > >    [ 1098.229259] ==================================================================
> > >
> > > Fix this by grabbing the next extent state at clear_state_bit() and making
> > > it return that next state to the caller. Like this we return the correct
> > > next state in case we merge the current state with the next state, so that
> > > the correct state is the next state's next state before the merging.
> > >
> > > This fixes a bug in the patch:
> > >
> > >   "btrfs: avoid unnecessary next node searches when clearing bits from extent range"
> > >
> > > which is only in for-next and this patch is meant to be squashed into that
> > > one.
> > >
> > > Reported-by: Boris Burkov <boris@bur.io>
> > > Signed-off-by: Filipe Manana <fdmanana@suse.com>
> >
> > Thanks for the quick fix. Makes sense and passed 10/10 for me.
> >
> > I sort of liked how you un-conflated iteration and clearing in the last
> > patch, but it seems like it might be necessary after all.
> >
> > Reviewed-by: Boris Burkov <boris@bur.io>
> >
> > > ---
> > >  fs/btrfs/extent-io-tree.c | 58 +++++++++++++++++++--------------------
> > >  1 file changed, 28 insertions(+), 30 deletions(-)
> > >
> > > diff --git a/fs/btrfs/extent-io-tree.c b/fs/btrfs/extent-io-tree.c
> > > index bac2d9671d56..b1b96eb5f64e 100644
> > > --- a/fs/btrfs/extent-io-tree.c
> > > +++ b/fs/btrfs/extent-io-tree.c
> > > @@ -537,6 +537,18 @@ static int split_state(struct extent_io_tree *tree, struct extent_state *orig,
> > >       return 0;
> > >  }
> > >
> > > +/*
> > > + * Use this during tree iteration to avoid doing next node searches when it's
> > > + * not needed (the current record ends at or after the target range's end).
> > > + */
> > > +static inline struct extent_state *next_search_state(struct extent_state *state, u64 end)
> > > +{
> > > +     if (state->end < end)
> > > +             return next_state(state);
> > > +
> > > +     return NULL;
> > > +}
> > > +
> > >  /*
> > >   * Utility function to clear some bits in an extent state struct.  It will
> > >   * optionally wake up anyone waiting on this state (wake == 1).
> > > @@ -544,9 +556,12 @@ static int split_state(struct extent_io_tree *tree, struct extent_state *orig,
> > >   * If no bits are set on the state struct after clearing things, the
> > >   * struct is freed and removed from the tree
> > >   */
> > > -static void clear_state_bit(struct extent_io_tree *tree, struct extent_state *state,
> > > -                         u32 bits, int wake, struct extent_changeset *changeset)
> > > +static struct extent_state *clear_state_bit(struct extent_io_tree *tree,
> > > +                                         struct extent_state *state,
> > > +                                         u32 bits, int wake, u64 end,
> > > +                                         struct extent_changeset *changeset)
> > >  {
> > > +     struct extent_state *next;
> > >       u32 bits_to_clear = bits & ~EXTENT_CTLBITS;
> > >       int ret;
> > >
> > > @@ -559,6 +574,7 @@ static void clear_state_bit(struct extent_io_tree *tree, struct extent_state *st
> > >       if (wake)
> > >               wake_up(&state->wq);
> > >       if (state->state == 0) {
> >
> > It took me a moment to see that this path is the reason we can't just do
> > next_search_state() after clear_state_bit() (and why you put it before
> > in the first buggy patch).
> >
> > Perhaps a comment either here or at the top level of clear_state_bit
> > could make that apparent to future readers?
> 
> Isn't that really superfluous?
> The code right below explicitly removes and frees the extent state:
> 
> next = next_search_state(state, end);
> if (extent_state_in_tree(state)) {
>    rb_erase(&state->rb_node, &tree->state);
>    RB_CLEAR_NODE(&state->rb_node);
>    btrfs_free_extent_state(state);
> } else {
>    WARN_ON(1);
> }
> 
> 

I agree 100% for an inline comment.

I don't think it's superfluous for clear_state_bit() to document that
it is designed to be used in an iteration and has careful logic for
facilitating that by returning the next extent_state after being done
removing or merging.

With that said, I am OK with no new comment, especially because now the
fixed up patch won't be changing the signature of clear_state_bit(), so
it's not a behavior specification "regression".

> >
> > > +             next = next_search_state(state, end);
> > >               if (extent_state_in_tree(state)) {
> > >                       rb_erase(&state->rb_node, &tree->state);
> > >                       RB_CLEAR_NODE(&state->rb_node);
> > > @@ -568,7 +584,9 @@ static void clear_state_bit(struct extent_io_tree *tree, struct extent_state *st
> > >               }
> > >       } else {
> > >               merge_state(tree, state);
> > > +             next = next_search_state(state, end);
> > >       }
> > > +     return next;
> > >  }
> > >
> > >  /*
> > > @@ -581,18 +599,6 @@ static void set_gfp_mask_from_bits(u32 *bits, gfp_t *mask)
> > >       *bits &= EXTENT_NOWAIT - 1;
> > >  }
> > >
> > > -/*
> > > - * Use this during tree iteration to avoid doing next node searches when it's
> > > - * not needed (the current record ends at or after the target range's end).
> > > - */
> > > -static inline struct extent_state *next_search_state(struct extent_state *state, u64 end)
> > > -{
> > > -     if (state->end < end)
> > > -             return next_state(state);
> > > -
> > > -     return NULL;
> > > -}
> > > -
> > >  /*
> > >   * Clear some bits on a range in the tree.  This may require splitting or
> > >   * inserting elements in the tree, so the gfp mask is used to indicate which
> > > @@ -607,7 +613,6 @@ int btrfs_clear_extent_bit_changeset(struct extent_io_tree *tree, u64 start, u64
> > >                                    struct extent_changeset *changeset)
> > >  {
> > >       struct extent_state *state;
> > > -     struct extent_state *next;
> > >       struct extent_state *cached;
> > >       struct extent_state *prealloc = NULL;
> > >       u64 last_end;
> > > @@ -673,7 +678,7 @@ int btrfs_clear_extent_bit_changeset(struct extent_io_tree *tree, u64 start, u64
> > >
> > >       /* The state doesn't have the wanted bits, go ahead. */
> > >       if (!(state->state & bits)) {
> > > -             next = next_search_state(state, end);
> > > +             state = next_search_state(state, end);
> > >               goto next;
> > >       }
> > >
> > > @@ -703,8 +708,8 @@ int btrfs_clear_extent_bit_changeset(struct extent_io_tree *tree, u64 start, u64
> > >                       goto out;
> > >               }
> > >               if (state->end <= end) {
> > > -                     next = next_search_state(state, end);
> > > -                     clear_state_bit(tree, state, bits, wake, changeset);
> > > +                     state = clear_state_bit(tree, state, bits, wake, end,
> > > +                                             changeset);
> > >                       goto next;
> > >               }
> > >               if (need_resched())
> > > @@ -734,19 +739,17 @@ int btrfs_clear_extent_bit_changeset(struct extent_io_tree *tree, u64 start, u64
> > >               if (wake)
> > >                       wake_up(&state->wq);
> > >
> > > -             clear_state_bit(tree, prealloc, bits, wake, changeset);
> > > +             clear_state_bit(tree, prealloc, bits, wake, end, changeset);
> > >
> > >               prealloc = NULL;
> > >               goto out;
> > >       }
> > >
> > > -     next = next_search_state(state, end);
> > > -     clear_state_bit(tree, state, bits, wake, changeset);
> > > +     state = clear_state_bit(tree, state, bits, wake, end, changeset);
> > >  next:
> > >       if (last_end >= end)
> > >               goto out;
> > >       start = last_end + 1;
> > > -     state = next;
> > >       if (state && !need_resched())
> > >               goto hit_next;
> > >
> > > @@ -1316,7 +1319,6 @@ int btrfs_convert_extent_bit(struct extent_io_tree *tree, u64 start, u64 end,
> > >                            struct extent_state **cached_state)
> > >  {
> > >       struct extent_state *state;
> > > -     struct extent_state *next;
> > >       struct extent_state *prealloc = NULL;
> > >       struct rb_node **p = NULL;
> > >       struct rb_node *parent = NULL;
> > > @@ -1382,12 +1384,10 @@ int btrfs_convert_extent_bit(struct extent_io_tree *tree, u64 start, u64 end,
> > >       if (state->start == start && state->end <= end) {
> > >               set_state_bits(tree, state, bits, NULL);
> > >               cache_state(state, cached_state);
> > > -             next = next_search_state(state, end);
> > > -             clear_state_bit(tree, state, clear_bits, 0, NULL);
> > > +             state = clear_state_bit(tree, state, clear_bits, 0, end, NULL);
> > >               if (last_end >= end)
> > >                       goto out;
> > >               start = last_end + 1;
> > > -             state = next;
> > >               if (state && state->start == start && !need_resched())
> > >                       goto hit_next;
> > >               goto search_again;
> > > @@ -1423,12 +1423,10 @@ int btrfs_convert_extent_bit(struct extent_io_tree *tree, u64 start, u64 end,
> > >               if (state->end <= end) {
> > >                       set_state_bits(tree, state, bits, NULL);
> > >                       cache_state(state, cached_state);
> > > -                     next = next_search_state(state, end);
> > > -                     clear_state_bit(tree, state, clear_bits, 0, NULL);
> > > +                     state = clear_state_bit(tree, state, clear_bits, 0, end, NULL);
> > >                       if (last_end >= end)
> > >                               goto out;
> > >                       start = last_end + 1;
> > > -                     state = next;
> > >                       if (state && state->start == start && !need_resched())
> > >                               goto hit_next;
> > >               }
> > > @@ -1510,7 +1508,7 @@ int btrfs_convert_extent_bit(struct extent_io_tree *tree, u64 start, u64 end,
> > >
> > >               set_state_bits(tree, prealloc, bits, NULL);
> > >               cache_state(prealloc, cached_state);
> > > -             clear_state_bit(tree, prealloc, clear_bits, 0, NULL);
> > > +             clear_state_bit(tree, prealloc, clear_bits, 0, end, NULL);
> > >               prealloc = NULL;
> > >               goto out;
> > >       }
> > > --
> > > 2.47.2
> > >

