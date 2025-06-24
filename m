Return-Path: <linux-btrfs+bounces-14896-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6101FAE597C
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Jun 2025 03:59:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFE5D177B1E
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Jun 2025 01:59:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00F911E104E;
	Tue, 24 Jun 2025 01:59:37 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E34F1282E1;
	Tue, 24 Jun 2025 01:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750730376; cv=none; b=MkmAwHxKMDtbYW8mP390PfuLolaxk9wow83Vh5KIneX9iWIkKnkiiwHxQoRVkufF3C7v0385BphjpyxLo+GH3YtySS6VQg0QIGWJuZ0Kj8amuuuL/tfVBbP5fb3YuORPJMhyqxq7eS0IdLg4wWeG73QdZpqOILCWd3aDf73hf/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750730376; c=relaxed/simple;
	bh=cFYo9JSZgdoMD7bmIa6Q/cBU/txWlDTW2HAL89FwK1o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C95/Xm9sw+UNntpTYhRjo3N1FGPh/zTpucMEW2vIAKMev2kfVGCSqw4uRTGt5LI5sdZxHtmpEPCcr1NK8SouYgqY2cUcr3ysm3X2q9e6er3W3ggFf6pfq52jbM/SzO/fX0FeYKXrcZIvU1/r33JEcrb3aT0sC7wg4aLaykV5xsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-669ff7000002311f-d1-685a06810df4
Date: Tue, 24 Jun 2025 10:59:24 +0900
From: Byungchul Park <byungchul@sk.com>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: linux-kernel@vger.kernel.org, clm@fb.com, josef@toxicpanda.com,
	dsterba@suse.com, linux-btrfs@vger.kernel.org,
	kernel_team@skhynix.com, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, yeoreum.yun@arm.com,
	yunseong.kim@ericsson.com, gwan-gyeong.mun@intel.com,
	harry.yoo@oracle.com, ysk@kzalloc.com
Subject: Re: [RFC] DEPT report on around btrfs, unlink, and truncate
Message-ID: <20250624015924.GE5820@system.software.com>
References: <20250623032152.GB70156@system.software.com>
 <55c8b839-e844-49fe-bedc-948e60f681c7@gmx.com>
 <20250623081919.GA53365@system.software.com>
 <474347bb-bbba-4238-8964-299f87de664a@gmx.com>
 <20250623095250.GA3199@system.software.com>
 <a93738a1-57af-4eef-9a32-edfc60c7e7b4@gmx.com>
 <20250624014426.GC5820@system.software.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250624014426.GC5820@system.software.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrJIsWRmVeSWpSXmKPExsXC9ZZnoW4jW1SGwY4NhhZz1q9hs5jUP4Pd
	4sKPRiaLi6//MFncX/aMxeLPQ0OLS49XsFtc3jWHzWJx9xsWi0d9b9kt5n4xtPiyehWbxdq/
	1xgdeD3WzFvD6PHr61U2j4nN79g97t5fyOSxeM9LJo+Fv18we5yY8ZvF4+PTWywe67dcZfGY
	sHkjq8fnTXIB3FFcNimpOZllqUX6dglcGV9332AqeGZUsXNbRQPjXKUuRk4OCQETiSWH9jPB
	2a8+soHYLAKqEu2zn7OC2GwC6hI3bvxkBrFFBNQkuk5OAarh4mAWOMAk0TT/PViRsICLxNd7
	s1hAbF4Bc4mTx9pYQYqEBK4xSWycf5MVIiEocXLmE7AiZqCpf+ZdAprKAWRLSyz/xwERlpdo
	3jobbBmngIXExZdzGUFsUQFliQPbjjOBzJQQmMwuseDQdTaIqyUlDq64wTKBUXAWkhWzkKyY
	hbBiFpIVCxhZVjEKZeaV5SZm5pjoZVTmZVboJefnbmIERuCy2j/ROxg/XQg+xCjAwajEw7vD
	KjJDiDWxrLgy9xCjBAezkgjvIaewDCHelMTKqtSi/Pii0pzU4kOM0hwsSuK8Rt/KU4QE0hNL
	UrNTUwtSi2CyTBycUg2Mye3iJ5MZvP9xB/QwmldvqmLsdH27Yape6f3kGQJpFyd3zet8Mdf2
	Ietim39xv40ud231k+g2FLsb0K/7Z1X8/U13PQ2WztC+sJ5X5TbjC2HdJ483WZqe36B1b/HZ
	j0v0Thlsf//Fcd2UfI3DNZtaricxJOdO3DhjOdOJqLNZvf4vwstm35SYrsRSnJFoqMVcVJwI
	AD32cjO8AgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprAIsWRmVeSWpSXmKPExsXC5WfdrNvIFpVhcOySksWc9WvYLCb1z2C3
	uPCjkcni4us/TBb3lz1jsfjz0NDi8NyTrBaXHq9gt7i8aw6bxeLuNywWj/reslvM/WJo8WX1
	KjaLtX+vMTrweayZt4bR49fXq2weE5vfsXvcvb+QyWPxnpdMHgt/v2D2ODHjN4vHx6e3WDwW
	v/jA5LF+y1UWjwmbN7J6fN4kF8ATxWWTkpqTWZZapG+XwJXxdfcNpoJnRhU7t1U0MM5V6mLk
	5JAQMJFY8uojG4jNIqAq0T77OSuIzSagLnHjxk9mEFtEQE2i6+QUoBouDmaBA0wSTfPfgxUJ
	C7hIfL03iwXE5hUwlzh5rI0VpEhI4BqTxMb5N1khEoISJ2c+AStiBpr6Z94loKkcQLa0xPJ/
	HBBheYnmrbPBlnEKWEhcfDmXEcQWFVCWOLDtONMERr5ZSCbNQjJpFsKkWUgmLWBkWcUokplX
	lpuYmWOqV5ydUZmXWaGXnJ+7iREYT8tq/0zcwfjlsvshRgEORiUe3h1WkRlCrIllxZW5hxgl
	OJiVRHgPOYVlCPGmJFZWpRblxxeV5qQWH2KU5mBREuf1Ck9NEBJITyxJzU5NLUgtgskycXBK
	NTCuO31gdouCR/OUl6quO78xTzDYsJvlSu+P3pnWZTKNz45z3b/0KNh93t2NOz1+ajQ8P/0w
	5PHzJbGPFIPv6teayt+On567UEsumIdXuUDrbUXZ1y9tIeGedfeUcg+du+GhUWWVdOlV2Aar
	/Yt4ijYJ+6quZ7718GHS0X19x9gNvM+mZE/hefNDiaU4I9FQi7moOBEAfv8Vy6MCAAA=
X-CFilter-Loop: Reflected

On Tue, Jun 24, 2025 at 10:44:26AM +0900, Byungchul Park wrote:
> On Mon, Jun 23, 2025 at 07:28:38PM +0930, Qu Wenruo wrote:
> > 在 2025/6/23 19:22, Byungchul Park 写道:
> > > On Mon, Jun 23, 2025 at 06:22:44PM +0930, Qu Wenruo wrote:
> > > > 在 2025/6/23 17:49, Byungchul Park 写道:
> > > > > On Mon, Jun 23, 2025 at 03:20:43PM +0930, Qu Wenruo wrote:
> > > > > > 在 2025/6/23 12:51, Byungchul Park 写道:
> > > > > > > Hi folks,
> > > > > > > 
> > > > > > > Thanks to Yunseong, we got two DEPT reports in btrfs.  It doesn't mean
> > > > > > > it's obvious deadlocks, but after digging into the reports, I'm
> > > > > > > wondering if it could happen by any chance.
> > > > > > > 
> > > > > > > 1) The first scenario that I'm concerning is:
> > > > > > > 
> > > > > > >      context A            context B
> > > > > > > 
> > > > > > >                           do_truncate()
> > > > > > >                             ...
> > > > > > >                               btrfs_do_readpage() // with folio lock held
> > > > > > 
> > > > > >                                  This one is for data.
> > > > > 
> > > > > Do you mean this folio is for data?  Thanks for the confirmation.
> > > > 
> > > > Yes, only data folios will go through btrfs_do_readpage().
> > > > 
> > > > For metadata, we never go through btrfs_do_readpage(), but
> > > > read_extent_buffer_pages_nowait().
> > > > 
> > > > 
> > > > > 
> > > > > > >      do_unlinkat()
> > > > > > >        ...
> > > > > > >          push_leaf_right()
> > > > > > >         btrfs_tree_lock_nested()
> > > > > > >           down_write_nested(&eb->lock) // hold
> > > > > 
> > > > > This is struct extent_buffer's rw_sem.  Right?
> > > > > 
> > > > > > >                                 btrfs_get_extent()
> > > > > > >                                   btrfs_lookup_file_extent()
> > > > > > >                                     btrfs_search_slot()
> > > > > > >                                       down_read_nested(&eb->lock) // stuck
> > > > > > 
> > > > > >                                          This one is for metadata.
> > > > >                                                ^
> > > > >                                        I don't get this actually.
> > > > > 
> > > > > This is struct extent_buffer's rw_sem, too.  Cannot this rw_sem be the
> > > > > same as the rw_sem above in context A?
> > > > 
> > > > My bad, I thought you're talking about that down_read_nested()
> > > > conflicting with folio lock.
> > > > 
> > > > But if you're talking about extent_buffer::lock, then the one in context
> > > > B will wait for the one in context A, and that's expected.
> > > 
> > > Sounds good.
> > > 
> > > > > > Data and metadata page cache will never cross into each other.
> > > > > > 
> > > > > > Thanks,
> > > > > > Qu
> > > > > > 
> > > > > > >           __push_leaf_right()
> > > > > > >             ...
> > > > > > >               folio_lock() // stuck
> > > > > 
> > > > > Did you mean this folio is always for metadata?
> > > > 
> > > > Can you explain more on where this folio_lock() comes from?
> > > 
> > > I should also rely on the following stacktrace in the dept report.  I
> > > asked Yunseong who reported this issue, for the decoded stacktrace, so
> > > that I can interpret that better.  I will get back once I figure out
> > > where the wait on PG_locked comes from.
> > > 
> > >     [  304.344198][ T7488] [W] dept_page_wait_on_bit(pg_locked_map:0):
> > >     [  304.344211][ T7488] [<ffff8000823b1d20>] __push_leaf_right+0x8f0/0xc70
> > 
> > I believe it's from btrfs_clear_buffer_dirty():
> > 
> > As we have a for() loop iterating all the folios of a an extent buffer
> > (aka, metadata structure), then clear the dirty flags.
> > 
> > The same applies to btrfs_mark_buffer_dirty() -> set_extent_buffer_dirty().
> 
> Thanks to Yunseong, I figured out this is the case.
> 
> > In that case, the folio is 100% belonging to btree inode thus metadata.
> 
> Good to know.
> 
> Lastly, is it still good with directly manipulating block devs or
							^
						I meant block devs files.

	Byungchul

> stacked file system using loopback devices, from the confliction of
> folios and extent_buffers?
> 
> If you confirm it, this issue can be closed :-) Thanks in advance.
> 
> 	Byungchul
> 
> > Thus the folio lock can not conflict with a data folio, thus there
> > should be no deadlock.
> > 
> > Thanks,
> > Qu
> > 
> > 
> > >     [  304.344232][ T7488] stacktrace:
> > >     [  304.344241][ T7488]       __push_leaf_right+0x8f0/0xc70
> > >     [  304.344260][ T7488]       push_leaf_right+0x408/0x628
> > >     [  304.344278][ T7488]       btrfs_del_items+0x974/0xaec
> > >     [  304.344297][ T7488]       btrfs_truncate_inode_items+0x1c5c/0x2b00
> > >     [  304.344314][ T7488]       btrfs_evict_inode+0xa4c/0xd38
> > >     [  304.344335][ T7488]       evict+0x340/0x7b0
> > >     [  304.344352][ T7488]       iput+0x4ec/0x840
> > >     [  304.344369][ T7488]       do_unlinkat+0x444/0x59c
> > >     [  304.344388][ T7488]       __arm64_sys_unlinkat+0x11c/0x260
> > >     [  304.344407][ T7488]       invoke_syscall+0x88/0x2e0
> > >     [  304.344425][ T7488]       el0_svc_common.constprop.0+0xe8/0x2e0
> > >     [  304.344445][ T7488]       do_el0_svc+0x44/0x60
> > >     [  304.344463][ T7488]       el0_svc+0x50/0x188
> > >     [  304.344482][ T7488]       el0t_64_sync_handler+0x10c/0x140
> > >     [  304.344503][ T7488]       el0t_64_sync+0x198/0x19c
> > > 
> > > Thanks.
> > > 
> > >       Byungchul
> > > 
> > > > I didn't see any location where __push_leaf_right() is locking a folio
> > > > nor the original do_unlinkat().
> > > > 
> > > > So here I can only guess the folio is from __push_leaf_right() context,
> > > > that means it can only be a metadata folio.
> > > > 
> > > > > 
> > > > > If no, it could lead a deadlock in my opinion.  If yes, dept should
> > > > > assign different classes to folios between data data and metadata.
> > > > 
> > > > So far I believe the folio belongs to metadata.
> > > > 
> > > > And since btrfs has very different handling of metadata folios, and it's
> > > > a little confusing that, we also have a btree_inode to handle the
> > > > metadata page cache, but do not have read_folio() callbacks, it can be a
> > > > little confusing to some automatic tools.
> > > > 
> > > > Thanks,
> > > > Qu
> > 
> > 

