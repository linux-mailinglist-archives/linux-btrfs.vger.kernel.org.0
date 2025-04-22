Return-Path: <linux-btrfs+bounces-13201-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26184A95A50
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Apr 2025 03:10:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 080453B5827
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Apr 2025 01:10:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A269316CD33;
	Tue, 22 Apr 2025 01:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DvzbOgIA"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1C31335C7
	for <linux-btrfs@vger.kernel.org>; Tue, 22 Apr 2025 01:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745284213; cv=none; b=gY67T+Pak8uAQZXMP6o6Sf/Qp5OQgN7zvtgpkVtVpipkniSpDREzjHr72C4g+4QIC+CvnClWXGJKv4sqyzLVd51UgdlOahy9RFqaM3wdO0aUZWPT7b/eMnU6lRr/v/ntz2EGvEgoT+B43MwgjYHOdYF/R2qWMPwAAeWfXLFyXeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745284213; c=relaxed/simple;
	bh=8OZiz7tyZcHobvQlRKTrHf9V5AWyFQifBuHADFLti4k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dlMPa1+XxdSeoDyCn3Hf7P+dlqze3zjqDMf0tpjgbLaLEhujouO1/M8SxwXunz2T8bGD0Y5jVKPhi+xb6wc5jg74UHSW0zoA0cpmUo1EHl8EwSRfNybwi1h1W8sYkwxuO4EakgPcOnwf269yvq0sgz2s0UzX57WO8OG5tM/OCNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DvzbOgIA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F912C4CEE4;
	Tue, 22 Apr 2025 01:10:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745284212;
	bh=8OZiz7tyZcHobvQlRKTrHf9V5AWyFQifBuHADFLti4k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DvzbOgIAozgBcANensyzkc5u+JO1Zr2nPOqp3ZQoZVUoi+JAuVQYAVLsRDX0vGMme
	 nKkCpwREejUz9h2Sy/EEgHAM5bghWfJup22DR+0gXMJRAGKtUIh+ux7eexTHR/5J6x
	 S7TL0IwkL37TD6WeI8vW1Ip8qorknw+KDSmTyWuMbhM6UqTmCkb4xRYTi1KqWWGYJE
	 z6B7d/i3YcITYxUw0ZKBu5E4GNZnfz9o6PSQmUqPvrrMvKfAP3oiVpUb+61JjBibLV
	 csqnueHnFq0tlPVfkYhycxZg91TOIYJp24o2xIKZ/bCtJULMqyipGV4rTM49lIGUaK
	 7yEJ35vZTXfsw==
Date: Mon, 21 Apr 2025 18:10:11 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: Qu Wenruo <wqu@suse.com>,
	Linux Memory Management List <linux-mm@kvack.org>,
	linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: Sleep inside atomic for aarch64, triggered by generic/482
Message-ID: <20250422011011.GH25700@frogsfrogsfrogs>
References: <d6c22895-b3b5-454e-b889-9d0bd148e2fb@suse.com>
 <20250421172906.GA25651@frogsfrogsfrogs>
 <c1c4d0a9-05bb-4c60-ae64-8c1ee9223cc0@gmx.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c1c4d0a9-05bb-4c60-ae64-8c1ee9223cc0@gmx.com>

On Tue, Apr 22, 2025 at 05:39:52AM +0930, Qu Wenruo wrote:
> 
> 
> 在 2025/4/22 02:59, Darrick J. Wong 写道:
> > On Sun, Apr 20, 2025 at 08:24:12PM +0930, Qu Wenruo wrote:
> > > Hi,
> > > 
> > > Recently I hit two dmesg reports from generic/482, on aarch64 64K page size
> > > with 4K fs block size.
> > > 
> > > The involved warning looks like this:
> > > 
> > > 117645.139610] BTRFS info (device dm-13): using free-space-tree
> > > [117645.146707] BTRFS info (device dm-13): start tree-log replay
> > > [117645.158598] BTRFS info (device dm-13): last unmount of filesystem
> > > 214efad4-5c63-49b6-ad29-f09c4966de33
> > > [117645.322288] BUG: sleeping function called from invalid context at
> > > mm/util.c:743
> > > [117645.322312] in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 46,
> > > name: kcompactd0
> > > [117645.322325] preempt_count: 1, expected: 0
> > > [117645.322329] RCU nest depth: 0, expected: 0
> > > [117645.322338] CPU: 3 UID: 0 PID: 46 Comm: kcompactd0 Tainted: G W  OE
> > > 6.15.0-rc2-custom+ #116 PREEMPT(voluntary)
> > > [117645.322343] Tainted: [W]=WARN, [O]=OOT_MODULE, [E]=UNSIGNED_MODULE
> > > [117645.322345] Hardware name: QEMU KVM Virtual Machine, BIOS unknown
> > > 2/2/2022
> > > [117645.322347] Call trace:
> > > [117645.322349]  show_stack+0x34/0x98 (C)
> > > [117645.322360]  dump_stack_lvl+0x60/0x80
> > > [117645.322366]  dump_stack+0x18/0x24
> > > [117645.322370]  __might_resched+0x130/0x168
> > > [117645.322375]  folio_mc_copy+0x54/0xa8
> > > [117645.322382]  __migrate_folio.isra.0+0x5c/0x1f8
> > > [117645.322387]  __buffer_migrate_folio+0x28c/0x2a0
> > > [117645.322391]  buffer_migrate_folio_norefs+0x1c/0x30
> > > [117645.322395]  move_to_new_folio+0x94/0x2c0
> > > [117645.322398]  migrate_pages_batch+0x7e4/0xd10
> > > [117645.322402]  migrate_pages_sync+0x88/0x240
> > > [117645.322405]  migrate_pages+0x4d0/0x660
> > > [117645.322409]  compact_zone+0x454/0x718
> > > [117645.322414]  compact_node+0xa4/0x1b8
> > > [117645.322418]  kcompactd+0x300/0x458
> > > [117645.322421]  kthread+0x11c/0x140
> > > [117645.322426]  ret_from_fork+0x10/0x20
> > > [117645.400370] BTRFS: device fsid 214efad4-5c63-49b6-ad29-f09c4966de33
> > > devid 1 transid 31 /dev/mapper/thin-vol.482 (253:13) scanned by mount
> > > (924470)
> > > [117645.404282] BTRFS info (device dm-13): first mount of filesystem
> > > 214efad4-5c63-49b6-ad29-f09c4966de33
> > > 
> > > Again this has no btrfs involved in the call trace.
> > > 
> > > This looks exactly like the report here:
> > > 
> > > https://lore.kernel.org/linux-mm/67f6e11f.050a0220.25d1c8.000b.GAE@google.com/
> > > 
> > > However there are something new here:
> > > 
> > > - The target fs is btrfs, no large folio support yet
> > >    At least the branch I'm testing (based on v6.15-rc2) doesn't support
> > >    folio.
> > > 
> > >    Furthermore since it's btrfs, there is no buffer_head usage involved.
> > >    (But the rootfs is indeed ext4)
> > 
> > Doesn't matter; the block device can create large folios in its page
> > cache and blkid reading the bdev can create buffer heads.
> > 
> > willy's workaround in:
> > https://lore.kernel.org/linux-fsdevel/Z_VwF1MA-R7MgDVG@casper.infradead.org/
> 
> Thanks a lot for the info.
> 
> However this also makes me wonder, what if the block size of the block
> device eventually go larger than page size?
> 
> E.g. I know some vendors (samsumg?) are pushing for larger block size, with
> that the minimal order will still be larger than page size.
> 
> Thus I guess we can not avoid it anyway?

Yeah.  I think willy thinks this is an implementation bug in readahead,
so it'll probably get fixed sooner or later.

--D

> Thanks,
> Qu
> 
> > 
> > works enough to make this go away.
> > 
> > --D
> > 
> > > 
> > > - Arm64 64K page size with 4K block size
> > >    It's less common than x86_64.
> > > 
> > > Fortunately I can reproduce the bug reliable, it takes around 3~10 runs to
> > > hit it.
> > > 
> > > Hope this report would help a little.
> > > Thanks,
> > > Qu
> > > 
> > 
> 

