Return-Path: <linux-btrfs+bounces-14846-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD82AAE383B
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Jun 2025 10:19:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFD633A662B
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Jun 2025 08:19:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 855A7202C2D;
	Mon, 23 Jun 2025 08:19:36 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21395611E;
	Mon, 23 Jun 2025 08:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750666776; cv=none; b=J/LZbWqp4YOiGi64Nxx/6XcmokFrXuLzWM6epnvEx1+RZIIpFeM13ApcFWJaSU6L8OrpBhqWI8M3sx5LrCtLsAeCmCQ251+Ya57ALewMkOjjS45ywSw3mGSQ3fzTW3v7O+FQalqP2e+EakSgqpDybS1BmCSG+bX7nRrsMgt415s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750666776; c=relaxed/simple;
	bh=WWBeO5OTzRFr06gyOVz/3N3Y0Wkv1uFKWtr2eesSv4Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t8Vk4qfbNO8GrshYm9QqB5rYdbY/GLZ0Ebme+k2MiOzBYuLiCB23UVRg8RsHeaisFeVePuhCl0gMJJWMZCXfBoGKoSx2CeThCQ3N+mfFMMpkGh/jthYL183ChdRzZhU9yypueOnsizPW9w48sT9jNT2AOkcTg2o72heboA7Y2y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-681ff7000002311f-0b-68590e0c8d22
Date: Mon, 23 Jun 2025 17:19:19 +0900
From: Byungchul Park <byungchul@sk.com>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: linux-kernel@vger.kernel.org, clm@fb.com, josef@toxicpanda.com,
	dsterba@suse.com, linux-btrfs@vger.kernel.org,
	kernel_team@skhynix.com, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, yeoreum.yun@arm.com,
	yunseong.kim@ericsson.com, gwan-gyeong.mun@intel.com,
	harry.yoo@oracle.com, ysk@kzalloc.com
Subject: Re: [RFC] DEPT report on around btrfs, unlink, and truncate
Message-ID: <20250623081919.GA53365@system.software.com>
References: <20250623032152.GB70156@system.software.com>
 <55c8b839-e844-49fe-bedc-948e60f681c7@gmx.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <55c8b839-e844-49fe-bedc-948e60f681c7@gmx.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrBIsWRmVeSWpSXmKPExsXC9ZZnoS4PX2SGQdMvA4s569ewWUzqn8Fu
	ceFHI5PFxdd/mCzuL3vGYvHnoaHFpccr2C0u75rDZrG4+w2LxaO+t+wWc78YWnxZvYrNYu3f
	a4wOvB5r5q1h9Pj19Sqbx8Tmd+wed+8vZPJYvOclk8fC3y+YPU7M+M3i8fHpLRaP9VuusnhM
	2LyR1ePzJrkA7igum5TUnMyy1CJ9uwSujOlfNrAXvF/BWDH9+1vWBsZL9V2MHBwSAiYSTWfD
	uxg5wcx/H/czgtgsAqoSM7/PZQax2QTUJW7c+AlmiwioSXSdnMLWxcjFwSxwgEmiaf57VpCE
	sICLxNd7s1hAbF4BC4mpF3rAbCGBTImLnc2MEHFBiZMzn4DFmYGG/pl3iRnkBmYBaYnl/zgg
	wvISzVtng+3iFLCWmHDrKlirqICyxIFtx5kg7pzMLrH1rQeELSlxcMUNlgmMgrOQbJiFZMMs
	hA2zkGxYwMiyilEoM68sNzEzx0QvozIvs0IvOT93EyMw/pbV/onewfjpQvAhRgEORiUe3gSe
	iAwh1sSy4srcQ4wSHMxKIryHnMIyhHhTEiurUovy44tKc1KLDzFKc7AoifMafStPERJITyxJ
	zU5NLUgtgskycXBKNTCGPf6xtHDhVjHng0zJexarV8/2Edpu13Q0+9lV0cWrftgEvv31O9E6
	37vr34uYWy/uSTp9f6ORPWPtvWe9tw1C2zN3Hv60wOO79dWOxdx+dl9Y1Ar5n1wWuan1opTJ
	8MhvgxWz1KpuPMp0sNM8fehc29tNpp9+x5pfOLV4zQIlzptN6kEnnLTDlViKMxINtZiLihMB
	JCcdb7sCAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprIIsWRmVeSWpSXmKPExsXC5WfdrMvDF5lhMG+3ssWc9WvYLCb1z2C3
	uPCjkcni4us/TBb3lz1jsfjz0NDi8NyTrBaXHq9gt7i8aw6bxeLuNywWj/reslvM/WJo8WX1
	KjaLtX+vMTrweayZt4bR49fXq2weE5vfsXvcvb+QyWPxnpdMHgt/v2D2ODHjN4vHx6e3WDwW
	v/jA5LF+y1UWjwmbN7J6fN4kF8ATxWWTkpqTWZZapG+XwJUx/csG9oL3Kxgrpn9/y9rAeKm+
	i5GTQ0LAROLfx/2MIDaLgKrEzO9zmUFsNgF1iRs3foLZIgJqEl0np7B1MXJxMAscYJJomv+e
	FSQhLOAi8fXeLBYQm1fAQmLqhR4wW0ggU+JiZzMjRFxQ4uTMJ2BxZqChf+ZdAhrKAWRLSyz/
	xwERlpdo3jobbBengLXEhFtXwVpFBZQlDmw7zjSBkW8WkkmzkEyahTBpFpJJCxhZVjGKZOaV
	5SZm5pjqFWdnVOZlVugl5+duYgRG1LLaPxN3MH657H6IUYCDUYmHd4V3RIYQa2JZcWXuIUYJ
	DmYlEd5DTmEZQrwpiZVVqUX58UWlOanFhxilOViUxHm9wlMThATSE0tSs1NTC1KLYLJMHJxS
	DYzeOhFTRG2drWdp751iIPN394FPNXO++k5XLzfIYKvpuTyF8Z/1hGvtrz25Vi/n4tnek+rj
	nVArd/jsipyA6Q9Pzg7fvnOv990kpraWAi+Py/+TP7J/Vs6SMT2Zr/vQ4kOaqGS6Ue7t93zR
	v9T3FR9Z01Vr9m89r5rPLqb3xz4+97aqesbAVavEUpyRaKjFXFScCADSutdvpAIAAA==
X-CFilter-Loop: Reflected

On Mon, Jun 23, 2025 at 03:20:43PM +0930, Qu Wenruo wrote:
> 在 2025/6/23 12:51, Byungchul Park 写道:
> > Hi folks,
> > 
> > Thanks to Yunseong, we got two DEPT reports in btrfs.  It doesn't mean
> > it's obvious deadlocks, but after digging into the reports, I'm
> > wondering if it could happen by any chance.
> > 
> > 1) The first scenario that I'm concerning is:
> > 
> >    context A            context B
> > 
> >                         do_truncate()
> >                           ...
> >                             btrfs_do_readpage() // with folio lock held
> 
>                                This one is for data.

Do you mean this folio is for data?  Thanks for the confirmation.

> >    do_unlinkat()
> >      ...
> >        push_leaf_right()
> >       btrfs_tree_lock_nested()
> >         down_write_nested(&eb->lock) // hold

This is struct extent_buffer's rw_sem.  Right?

> >                               btrfs_get_extent()
> >                                 btrfs_lookup_file_extent()
> >                                   btrfs_search_slot()
> >                                     down_read_nested(&eb->lock) // stuck
> 
>                                        This one is for metadata.
						^
					I don't get this actually.

This is struct extent_buffer's rw_sem, too.  Cannot this rw_sem be the
same as the rw_sem above in context A?

> Data and metadata page cache will never cross into each other.
> 
> Thanks,
> Qu
> 
> >         __push_leaf_right()
> >           ...
> >             folio_lock() // stuck

Did you mean this folio is always for metadata?

If no, it could lead a deadlock in my opinion.  If yes, dept should
assign different classes to folios between data data and metadata.

	Byungchul

> > 2) The second scenario that I'm concerning is:
> > 
> >    context A            context B
> > 
> >                         do_truncate()
> >                           ...
> >                             btrfs_do_readpage() // with folio lock held
> >    do_unlinkat()
> >      ...
> >        btrfs_truncate_inode_items()
> >       btrfs_lock_root_node()
> >         down_write_nested(&eb->lock) // hold
> >       btrfs_del_items()
> >         push_leaf_right()
> >           __push_leaf_right()
> >                               btrfs_get_extent()
> >                                 btrfs_lookup_file_extent()
> >                                   btrfs_search_slot()
> >                                     btrfs_read_lock_root_node()
> >                                       down_read_nested(&eb->lock) // stuck
> >             ...
> >               folio_lock() //stuck
> > 
> > Am I missing something?
> > 
> > FYI, the followings are the DEPT reports we got.
> > 
> >       Byungchul
> > 
> > ---
> >   [  304.343395][ T7488] ===================================================
> >   [  304.343446][ T7488] DEPT: Circular dependency has been detected.
> >   [  304.343462][ T7488] 6.15.0-rc6-00043-ga83a69ec7f9f #5 Not tainted
> >   [  304.343477][ T7488] ---------------------------------------------------
> >   [  304.343488][ T7488] summary
> >   [  304.343498][ T7488] ---------------------------------------------------
> >   [  304.343509][ T7488] *** DEADLOCK ***
> >   [  304.343509][ T7488]
> >   [  304.343520][ T7488] context A
> >   [  304.343531][ T7488]    [S] lock(btrfs-tree-00:0)
> >   [  304.343545][ T7488]    [W] dept_page_wait_on_bit(pg_locked_map:0)
> >   [  304.343559][ T7488]    [E] unlock(btrfs-tree-00:0)
> >   [  304.343572][ T7488]
> >   [  304.343581][ T7488] context B
> >   [  304.343591][ T7488]    [S] (unknown)(pg_locked_map:0)
> >   [  304.343603][ T7488]    [W] lock(btrfs-tree-00:0)
> >   [  304.343616][ T7488]    [E] dept_page_clear_bit(pg_locked_map:0)
> >   [  304.343629][ T7488]
> >   [  304.343637][ T7488] [S]: start of the event context
> >   [  304.343647][ T7488] [W]: the wait blocked
> >   [  304.343656][ T7488] [E]: the event not reachable
> >   [  304.343666][ T7488] ---------------------------------------------------
> >   [  304.343676][ T7488] context A's detail
> >   [  304.343686][ T7488] ---------------------------------------------------
> >   [  304.343696][ T7488] context A
> >   [  304.343706][ T7488]    [S] lock(btrfs-tree-00:0)
> >   [  304.343718][ T7488]    [W] dept_page_wait_on_bit(pg_locked_map:0)
> >   [  304.343731][ T7488]    [E] unlock(btrfs-tree-00:0)
> >   [  304.343744][ T7488]
> >   [  304.343753][ T7488] [S] lock(btrfs-tree-00:0):
> >   [  304.343764][ T7488] [<ffff8000824f41d8>] btrfs_tree_lock_nested+0x38/0x324
> >   [  304.343796][ T7488] stacktrace:
> >   [  304.343805][ T7488]       down_write_nested+0xe4/0x21c
> >   [  304.343826][ T7488]       btrfs_tree_lock_nested+0x38/0x324
> >   [  304.343865][ T7488]       push_leaf_right+0x23c/0x628
> >   [  304.343896][ T7488]       btrfs_del_items+0x974/0xaec
> >   [  304.343916][ T7488]       btrfs_truncate_inode_items+0x1c5c/0x2b00
> >   [  304.343938][ T7488]       btrfs_evict_inode+0xa4c/0xd38
> >   [  304.343968][ T7488]       evict+0x340/0x7b0
> >   [  304.343993][ T7488]       iput+0x4ec/0x840
> >   [  304.344011][ T7488]       do_unlinkat+0x444/0x59c
> >   [  304.344038][ T7488]       __arm64_sys_unlinkat+0x11c/0x260
> >   [  304.344057][ T7488]       invoke_syscall+0x88/0x2e0
> >   [  304.344084][ T7488]       el0_svc_common.constprop.0+0xe8/0x2e0
> >   [  304.344104][ T7488]       do_el0_svc+0x44/0x60
> >   [  304.344123][ T7488]       el0_svc+0x50/0x188
> >   [  304.344151][ T7488]       el0t_64_sync_handler+0x10c/0x140
> >   [  304.344172][ T7488]       el0t_64_sync+0x198/0x19c
> >   [  304.344189][ T7488]
> >   [  304.344198][ T7488] [W] dept_page_wait_on_bit(pg_locked_map:0):
> >   [  304.344211][ T7488] [<ffff8000823b1d20>] __push_leaf_right+0x8f0/0xc70
> >   [  304.344232][ T7488] stacktrace:
> >   [  304.344241][ T7488]       __push_leaf_right+0x8f0/0xc70
> >   [  304.344260][ T7488]       push_leaf_right+0x408/0x628
> >   [  304.344278][ T7488]       btrfs_del_items+0x974/0xaec
> >   [  304.344297][ T7488]       btrfs_truncate_inode_items+0x1c5c/0x2b00
> >   [  304.344314][ T7488]       btrfs_evict_inode+0xa4c/0xd38
> >   [  304.344335][ T7488]       evict+0x340/0x7b0
> >   [  304.344352][ T7488]       iput+0x4ec/0x840
> >   [  304.344369][ T7488]       do_unlinkat+0x444/0x59c
> >   [  304.344388][ T7488]       __arm64_sys_unlinkat+0x11c/0x260
> >   [  304.344407][ T7488]       invoke_syscall+0x88/0x2e0
> >   [  304.344425][ T7488]       el0_svc_common.constprop.0+0xe8/0x2e0
> >   [  304.344445][ T7488]       do_el0_svc+0x44/0x60
> >   [  304.344463][ T7488]       el0_svc+0x50/0x188
> >   [  304.344482][ T7488]       el0t_64_sync_handler+0x10c/0x140
> >   [  304.344503][ T7488]       el0t_64_sync+0x198/0x19c
> >   [  304.344518][ T7488]
> >   [  304.344527][ T7488] [E] unlock(btrfs-tree-00:0):
> >   [  304.344539][ T7488] (N/A)
> >   [  304.344549][ T7488] ---------------------------------------------------
> >   [  304.344559][ T7488] context B's detail
> >   [  304.344568][ T7488] ---------------------------------------------------
> >   [  304.344578][ T7488] context B
> >   [  304.344588][ T7488]    [S] (unknown)(pg_locked_map:0)
> >   [  304.344600][ T7488]    [W] lock(btrfs-tree-00:0)
> >   [  304.344613][ T7488]    [E] dept_page_clear_bit(pg_locked_map:0)
> >   [  304.344625][ T7488]
> >   [  304.344634][ T7488] [S] (unknown)(pg_locked_map:0):
> >   [  304.344646][ T7488] (N/A)
> >   [  304.344655][ T7488]
> >   [  304.344663][ T7488] [W] lock(btrfs-tree-00:0):
> >   [  304.344675][ T7488] [<ffff8000824f3b48>] btrfs_tree_read_lock_nested+0x38/0x330
> >   [  304.344694][ T7488] stacktrace:
> >   [  304.344703][ T7488]       down_read_nested+0xc8/0x368
> >   [  304.344720][ T7488]       btrfs_tree_read_lock_nested+0x38/0x330
> >   [  304.344737][ T7488]       btrfs_search_slot+0x1204/0x2dc8
> >   [  304.344756][ T7488]       btrfs_lookup_file_extent+0xe0/0x128
> >   [  304.344773][ T7488]       btrfs_get_extent+0x2cc/0x1e24
> >   [  304.344789][ T7488]       btrfs_do_readpage+0x628/0x1258
> >   [  304.344810][ T7488]       btrfs_read_folio+0x310/0x450
> >   [  304.344828][ T7488]       btrfs_truncate_block+0x2c0/0xb24
> >   [  304.344854][ T7488]       btrfs_cont_expand+0x11c/0xba8
> >   [  304.344870][ T7488]       btrfs_setattr+0x8d8/0x10f4
> >   [  304.344885][ T7488]       notify_change+0x900/0xfbc
> >   [  304.344906][ T7488]       do_truncate+0x154/0x210
> >   [  304.344937][ T7488]       vfs_truncate+0x55c/0x66c
> >   [  304.344957][ T7488]       __arm64_sys_truncate+0x16c/0x1e4
> >   [  304.344978][ T7488]       invoke_syscall+0x88/0x2e0
> >   [  304.344997][ T7488]       el0_svc_common.constprop.0+0xe8/0x2e0
> >   [  304.345017][ T7488]
> >   [  304.345025][ T7488] [E] dept_page_clear_bit(pg_locked_map:0):
> >   [  304.345037][ T7488] [<ffff80008249c284>] end_folio_read+0x3e4/0x590
> >   [  304.345056][ T7488] stacktrace:
> >   [  304.345065][ T7488]       folio_unlock+0x8c/0x160
> >   [  304.345099][ T7488]       end_folio_read+0x3e4/0x590
> >   [  304.345116][ T7488]       btrfs_do_readpage+0x830/0x1258
> >   [  304.345132][ T7488]       btrfs_read_folio+0x310/0x450
> >   [  304.345149][ T7488]       btrfs_truncate_block+0x2c0/0xb24
> >   [  304.345164][ T7488]       btrfs_cont_expand+0x11c/0xba8
> >   [  304.345179][ T7488]       btrfs_setattr+0x8d8/0x10f4
> >   [  304.345194][ T7488]       notify_change+0x900/0xfbc
> >   [  304.345213][ T7488]       do_truncate+0x154/0x210
> >   [  304.345232][ T7488]       vfs_truncate+0x55c/0x66c
> >   [  304.345252][ T7488]       __arm64_sys_truncate+0x16c/0x1e4
> >   [  304.345272][ T7488]       invoke_syscall+0x88/0x2e0
> >   [  304.345291][ T7488]       el0_svc_common.constprop.0+0xe8/0x2e0
> >   [  304.345310][ T7488]       do_el0_svc+0x44/0x60
> >   [  304.345328][ T7488]       el0_svc+0x50/0x188
> >   [  304.345347][ T7488]       el0t_64_sync_handler+0x10c/0x140
> >   [  304.345369][ T7488] ---------------------------------------------------
> >   [  304.345379][ T7488] information that might be helpful
> >   [  304.345388][ T7488] ---------------------------------------------------
> >   [  304.345402][ T7488] CPU: 1 UID: 0 PID: 7488 Comm: syz-executor Not tainted 6.15.0-rc6-00043-ga83a69ec7f9f #5 PREEMPT
> >   [  304.345416][ T7488] Hardware name: QEMU KVM Virtual Machine, BIOS 2025.02-8 05/13/2025
> >   [  304.345422][ T7488] Call trace:
> >   [  304.345426][ T7488]  show_stack+0x34/0x80 (C)
> >   [  304.345452][ T7488]  dump_stack_lvl+0x104/0x180
> >   [  304.345476][ T7488]  dump_stack+0x20/0x2c
> >   [  304.345490][ T7488]  cb_check_dl+0x1080/0x10ec
> >   [  304.345504][ T7488]  bfs+0x4d8/0x630
> >   [  304.345514][ T7488]  add_dep+0x1cc/0x364
> >   [  304.345526][ T7488]  __dept_wait+0x60c/0x16e0
> >   [  304.345537][ T7488]  dept_wait+0x168/0x1a8
> >   [  304.345548][ T7488]  btrfs_clear_buffer_dirty+0x420/0x820
> >   [  304.345561][ T7488]  __push_leaf_right+0x8f0/0xc70
> >   [  304.345575][ T7488]  push_leaf_right+0x408/0x628
> >   [  304.345589][ T7488]  btrfs_del_items+0x974/0xaec
> >   [  304.345603][ T7488]  btrfs_truncate_inode_items+0x1c5c/0x2b00
> >   [  304.345616][ T7488]  btrfs_evict_inode+0xa4c/0xd38
> >   [  304.345632][ T7488]  evict+0x340/0x7b0
> >   [  304.345644][ T7488]  iput+0x4ec/0x840
> >   [  304.345657][ T7488]  do_unlinkat+0x444/0x59c
> >   [  304.345671][ T7488]  __arm64_sys_unlinkat+0x11c/0x260
> >   [  304.345685][ T7488]  invoke_syscall+0x88/0x2e0
> >   [  304.345698][ T7488]  el0_svc_common.constprop.0+0xe8/0x2e0
> >   [  304.345713][ T7488]  do_el0_svc+0x44/0x60
> >   [  304.345726][ T7488]  el0_svc+0x50/0x188
> >   [  304.345741][ T7488]  el0t_64_sync_handler+0x10c/0x140
> >   [  304.345756][ T7488]  el0t_64_sync+0x198/0x19c
> >   [  304.345857][ T7488] ===================================================
> >   [  304.345995][ T7488] DEPT: Circular dependency has been detected.
> >   [  304.346006][ T7488] 6.15.0-rc6-00043-ga83a69ec7f9f #5 Not tainted
> >   [  304.346019][ T7488] ---------------------------------------------------
> >   [  304.346029][ T7488] summary
> >   [  304.346038][ T7488] ---------------------------------------------------
> >   [  304.346049][ T7488] *** DEADLOCK ***
> >   [  304.346049][ T7488]
> >   [  304.346058][ T7488] context A
> >   [  304.346069][ T7488]    [S] lock(btrfs-tree-01:0)
> >   [  304.346082][ T7488]    [W] dept_page_wait_on_bit(pg_locked_map:0)
> >   [  304.346095][ T7488]    [E] unlock(btrfs-tree-01:0)
> >   [  304.346108][ T7488]
> >   [  304.346117][ T7488] context B
> >   [  304.346126][ T7488]    [S] (unknown)(pg_locked_map:0)
> >   [  304.346139][ T7488]    [W] lock(btrfs-tree-01:0)
> >   [  304.346151][ T7488]    [E] dept_page_clear_bit(pg_locked_map:0)
> >   [  304.346164][ T7488]
> >   [  304.346173][ T7488] [S]: start of the event context
> >   [  304.346183][ T7488] [W]: the wait blocked
> >   [  304.346192][ T7488] [E]: the event not reachable
> >   [  304.346201][ T7488] ---------------------------------------------------
> >   [  304.346211][ T7488] context A's detail
> >   [  304.346221][ T7488] ---------------------------------------------------
> >   [  304.346231][ T7488] context A
> >   [  304.346240][ T7488]    [S] lock(btrfs-tree-01:0)
> >   [  304.346253][ T7488]    [W] dept_page_wait_on_bit(pg_locked_map:0)
> >   [  304.346266][ T7488]    [E] unlock(btrfs-tree-01:0)
> >   [  304.346278][ T7488]
> >   [  304.346287][ T7488] [S] lock(btrfs-tree-01:0):
> >   [  304.346299][ T7488] [<ffff8000824f41d8>] btrfs_tree_lock_nested+0x38/0x324
> >   [  304.346321][ T7488] stacktrace:
> >   [  304.346330][ T7488]       down_write_nested+0xe4/0x21c
> >   [  304.346347][ T7488]       btrfs_tree_lock_nested+0x38/0x324
> >   [  304.346363][ T7488]       btrfs_lock_root_node+0x70/0xac
> >   [  304.346379][ T7488]       btrfs_search_slot+0x3f8/0x2dc8
> >   [  304.346399][ T7488]       btrfs_truncate_inode_items+0x2ec/0x2b00
> >   [  304.346417][ T7488]       btrfs_evict_inode+0xa4c/0xd38
> >   [  304.346438][ T7488]       evict+0x340/0x7b0
> >   [  304.346456][ T7488]       iput+0x4ec/0x840
> >   [  304.346473][ T7488]       do_unlinkat+0x444/0x59c
> >   [  304.346492][ T7488]       __arm64_sys_unlinkat+0x11c/0x260
> >   [  304.346511][ T7488]       invoke_syscall+0x88/0x2e0
> >   [  304.346530][ T7488]       el0_svc_common.constprop.0+0xe8/0x2e0
> >   [  304.346550][ T7488]       do_el0_svc+0x44/0x60
> >   [  304.346568][ T7488]       el0_svc+0x50/0x188
> >   [  304.346588][ T7488]       el0t_64_sync_handler+0x10c/0x140
> >   [  304.346608][ T7488]       el0t_64_sync+0x198/0x19c
> >   [  304.346623][ T7488]
> >   [  304.346632][ T7488] [W] dept_page_wait_on_bit(pg_locked_map:0):
> >   [  304.346644][ T7488] [<ffff8000823b1d20>] __push_leaf_right+0x8f0/0xc70
> >   [  304.346665][ T7488] stacktrace:
> >   [  304.346674][ T7488]       __push_leaf_right+0x8f0/0xc70
> >   [  304.346692][ T7488]       push_leaf_right+0x408/0x628
> >   [  304.346711][ T7488]       btrfs_del_items+0x974/0xaec
> >   [  304.346729][ T7488]       btrfs_truncate_inode_items+0x1c5c/0x2b00
> >   [  304.346747][ T7488]       btrfs_evict_inode+0xa4c/0xd38
> >   [  304.346767][ T7488]       evict+0x340/0x7b0
> >   [  304.346785][ T7488]       iput+0x4ec/0x840
> >   [  304.346802][ T7488]       do_unlinkat+0x444/0x59c
> >   [  304.346820][ T7488]       __arm64_sys_unlinkat+0x11c/0x260
> >   [  304.346850][ T7488]       invoke_syscall+0x88/0x2e0
> >   [  304.346871][ T7488]       el0_svc_common.constprop.0+0xe8/0x2e0
> >   [  304.346891][ T7488]       do_el0_svc+0x44/0x60
> >   [  304.346909][ T7488]       el0_svc+0x50/0x188
> >   [  304.346928][ T7488]       el0t_64_sync_handler+0x10c/0x140
> >   [  304.346949][ T7488]       el0t_64_sync+0x198/0x19c
> >   [  304.346963][ T7488]
> >   [  304.346972][ T7488] [E] unlock(btrfs-tree-01:0):
> >   [  304.346984][ T7488] (N/A)
> >   [  304.346994][ T7488] ---------------------------------------------------
> >   [  304.347004][ T7488] context B's detail
> >   [  304.347013][ T7488] ---------------------------------------------------
> >   [  304.347023][ T7488] context B
> >   [  304.347033][ T7488]    [S] (unknown)(pg_locked_map:0)
> >   [  304.347046][ T7488]    [W] lock(btrfs-tree-01:0)
> >   [  304.347058][ T7488]    [E] dept_page_clear_bit(pg_locked_map:0)
> >   [  304.347071][ T7488]
> >   [  304.347080][ T7488] [S] (unknown)(pg_locked_map:0):
> >   [  304.347092][ T7488] (N/A)
> >   [  304.347101][ T7488]
> >   [  304.347109][ T7488] [W] lock(btrfs-tree-01:0):
> >   [  304.347121][ T7488] [<ffff8000824f3b48>] btrfs_tree_read_lock_nested+0x38/0x330
> >   [  304.347140][ T7488] stacktrace:
> >   [  304.347149][ T7488]       down_read_nested+0xc8/0x368
> >   [  304.347165][ T7488]       btrfs_tree_read_lock_nested+0x38/0x330
> >   [  304.347181][ T7488]       btrfs_read_lock_root_node+0x70/0xb4
> >   [  304.347198][ T7488]       btrfs_search_slot+0x34c/0x2dc8
> >   [  304.347217][ T7488]       btrfs_lookup_file_extent+0xe0/0x128
> >   [  304.347233][ T7488]       btrfs_get_extent+0x2cc/0x1e24
> >   [  304.347248][ T7488]       btrfs_do_readpage+0x628/0x1258
> >   [  304.347270][ T7488]       btrfs_read_folio+0x310/0x450
> >   [  304.347287][ T7488]       btrfs_truncate_block+0x2c0/0xb24
> >   [  304.347302][ T7488]       btrfs_cont_expand+0x11c/0xba8
> >   [  304.347317][ T7488]       btrfs_setattr+0x8d8/0x10f4
> >   [  304.347332][ T7488]       notify_change+0x900/0xfbc
> >   [  304.347352][ T7488]       do_truncate+0x154/0x210
> >   [  304.347374][ T7488]       vfs_truncate+0x55c/0x66c
> >   [  304.347394][ T7488]       __arm64_sys_truncate+0x16c/0x1e4
> >   [  304.347414][ T7488]       invoke_syscall+0x88/0x2e0
> >   [  304.347433][ T7488]
> >   [  304.347441][ T7488] [E] dept_page_clear_bit(pg_locked_map:0):
> >   [  304.347453][ T7488] [<ffff80008249c284>] end_folio_read+0x3e4/0x590
> >   [  304.347471][ T7488] stacktrace:
> >   [  304.347480][ T7488]       folio_unlock+0x8c/0x160
> >   [  304.347504][ T7488]       end_folio_read+0x3e4/0x590
> >   [  304.347520][ T7488]       btrfs_do_readpage+0x830/0x1258
> >   [  304.347536][ T7488]       btrfs_read_folio+0x310/0x450
> >   [  304.347553][ T7488]       btrfs_truncate_block+0x2c0/0xb24
> >   [  304.347568][ T7488]       btrfs_cont_expand+0x11c/0xba8
> >   [  304.347583][ T7488]       btrfs_setattr+0x8d8/0x10f4
> >   [  304.347598][ T7488]       notify_change+0x900/0xfbc
> >   [  304.347617][ T7488]       do_truncate+0x154/0x210
> >   [  304.347636][ T7488]       vfs_truncate+0x55c/0x66c
> >   [  304.347656][ T7488]       __arm64_sys_truncate+0x16c/0x1e4
> >   [  304.347676][ T7488]       invoke_syscall+0x88/0x2e0
> >   [  304.347695][ T7488]       el0_svc_common.constprop.0+0xe8/0x2e0
> >   [  304.347714][ T7488]       do_el0_svc+0x44/0x60
> >   [  304.347732][ T7488]       el0_svc+0x50/0x188
> >   [  304.347751][ T7488]       el0t_64_sync_handler+0x10c/0x140
> >   [  304.347772][ T7488] ---------------------------------------------------
> >   [  304.347782][ T7488] information that might be helpful
> >   [  304.347791][ T7488] ---------------------------------------------------
> >   [  304.347803][ T7488] CPU: 1 UID: 0 PID: 7488 Comm: syz-executor Not tainted 6.15.0-rc6-00043-ga83a69ec7f9f #5 PREEMPT
> >   [  304.347815][ T7488] Hardware name: QEMU KVM Virtual Machine, BIOS 2025.02-8 05/13/2025
> >   [  304.347821][ T7488] Call trace:
> >   [  304.347825][ T7488]  show_stack+0x34/0x80 (C)
> >   [  304.347852][ T7488]  dump_stack_lvl+0x104/0x180
> >   [  304.347870][ T7488]  dump_stack+0x20/0x2c
> >   [  304.347884][ T7488]  cb_check_dl+0x1080/0x10ec
> >   [  304.347897][ T7488]  bfs+0x4d8/0x630
> >   [  304.347906][ T7488]  add_dep+0x1cc/0x364
> >   [  304.347917][ T7488]  __dept_wait+0x60c/0x16e0
> >   [  304.347928][ T7488]  dept_wait+0x168/0x1a8
> >   [  304.347940][ T7488]  btrfs_clear_buffer_dirty+0x420/0x820
> >   [  304.347952][ T7488]  __push_leaf_right+0x8f0/0xc70
> >   [  304.347967][ T7488]  push_leaf_right+0x408/0x628
> >   [  304.347980][ T7488]  btrfs_del_items+0x974/0xaec
> >   [  304.347994][ T7488]  btrfs_truncate_inode_items+0x1c5c/0x2b00
> >   [  304.348007][ T7488]  btrfs_evict_inode+0xa4c/0xd38
> >   [  304.348023][ T7488]  evict+0x340/0x7b0
> >   [  304.348036][ T7488]  iput+0x4ec/0x840
> >   [  304.348048][ T7488]  do_unlinkat+0x444/0x59c
> >   [  304.348062][ T7488]  __arm64_sys_unlinkat+0x11c/0x260
> >   [  304.348076][ T7488]  invoke_syscall+0x88/0x2e0
> >   [  304.348090][ T7488]  el0_svc_common.constprop.0+0xe8/0x2e0
> >   [  304.348105][ T7488]  do_el0_svc+0x44/0x60
> >   [  304.348118][ T7488]  el0_svc+0x50/0x188
> >   [  304.348132][ T7488]  el0t_64_sync_handler+0x10c/0x140
> >   [  304.348148][ T7488]  el0t_64_sync+0x198/0x19c
> >   [  304.386144][ T8054] BTRFS info (device loop0): first mount of filesystem 3a492a15-ac49-4ce6-945e-cef7a687c6c9
> >   [  304.389687][ T8054] BTRFS info (device loop0): using crc32c (crc32c-arm64) checksum algorithm
> >   [  304.389788][ T8054] BTRFS info (device loop0): using free-space-tree
> >   [  304.701202][ T7488] BTRFS info (device loop3): last unmount of filesystem 3a492a15-ac49-4ce6-945e-cef7a687c6c9
> > 

