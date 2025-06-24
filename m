Return-Path: <linux-btrfs+bounces-14895-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ACD46AE595C
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Jun 2025 03:44:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B863F441F8A
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Jun 2025 01:44:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5300F1DED69;
	Tue, 24 Jun 2025 01:44:40 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E70448C11;
	Tue, 24 Jun 2025 01:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750729479; cv=none; b=bkZZaPXKiYAf9b5UJJUsIHEQKHO1ObitMVgAqU2UJjzydfsOzzvrHSRIveGhvMly8r+SM3+/crFfafafFRDdp87hDcMPWCLDKwT/geiwz/8UDuyKeqvFqKTqiqDCLRDSeOMkJDA2C9yH3+FB9KSo5nm1756s8v6cV5ez4ilZLc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750729479; c=relaxed/simple;
	bh=WlnMuspRPyMWl/xbGBZrbSOgSvJn+PLFxZ9lYy6uCVk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GiNc3irpKn0/KX+3T6qDO5K3/tV7NbCi14RqsIq9a5cebROcBKoyKJJWKu9ztoNHguGsglTyZGGWZQ/MXENNWP3NuG8Qg/sxU97iSJI223b7nCMQQIJ09uxQIhl8BXJi/b6bRSE4s+xOmDpaqNRXBDyJ62PYCImB29nIBhFwf6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-669ff7000002311f-d5-685a02ff5c8a
Date: Tue, 24 Jun 2025 10:44:26 +0900
From: Byungchul Park <byungchul@sk.com>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: linux-kernel@vger.kernel.org, clm@fb.com, josef@toxicpanda.com,
	dsterba@suse.com, linux-btrfs@vger.kernel.org,
	kernel_team@skhynix.com, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, yeoreum.yun@arm.com,
	yunseong.kim@ericsson.com, gwan-gyeong.mun@intel.com,
	harry.yoo@oracle.com, ysk@kzalloc.com
Subject: Re: [RFC] DEPT report on around btrfs, unlink, and truncate
Message-ID: <20250624014426.GC5820@system.software.com>
References: <20250623032152.GB70156@system.software.com>
 <55c8b839-e844-49fe-bedc-948e60f681c7@gmx.com>
 <20250623081919.GA53365@system.software.com>
 <474347bb-bbba-4238-8964-299f87de664a@gmx.com>
 <20250623095250.GA3199@system.software.com>
 <a93738a1-57af-4eef-9a32-edfc60c7e7b4@gmx.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a93738a1-57af-4eef-9a32-edfc60c7e7b4@gmx.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrJIsWRmVeSWpSXmKPExsXC9ZZnoe5/pqgMg0WvDS3mrF/DZjGpfwa7
	xYUfjUwWF1//YbK4v+wZi8Wfh4YWlx6vYLe4vGsOm8Xi7jcsFo/63rJbzP1iaPFl9So2i7V/
	rzE68HqsmbeG0ePX16tsHhOb37F73L2/kMlj8Z6XTB4Lf79g9jgx4zeLx8ent1g81m+5yuIx
	YfNGVo/Pm+QCuKO4bFJSczLLUov07RK4Mo4dv8pasE+/Yn2vSwPjZoUuRk4OCQETiXuv2tlg
	7KcXGhhBbBYBVYmn/w6CxdkE1CVu3PjJDGKLCKhJdJ2cAhTn4mAWOMAk0TT/PStIQljAReLr
	vVksIDavgLnEriVfmEGKhARWMEmcOHmRESIhKHFy5hOwImagqX/mXQIq4gCypSWW/+OACMtL
	NG+dDbaMU8BaYuPnlUwgtqiAssSBbceZQGZKCExml9j16SErxNWSEgdX3GCZwCg4C8mKWUhW
	zEJYMQvJigWMLKsYhTLzynITM3NM9DIq8zIr9JLzczcxAiNwWe2f6B2Mny4EH2IU4GBU4uHd
	YRWZIcSaWFZcmXuIUYKDWUmE95BTWIYQb0piZVVqUX58UWlOavEhRmkOFiVxXqNv5SlCAumJ
	JanZqakFqUUwWSYOTqkGxqlWDq88zrJ8Fu87z7Zc2a6sgm8147HpB5dflFp6bs6uK19uege/
	Oet0NbX2ZN7sOt4TtSvDddOUov0LDW5+CUibL9jvsfZ6jH/tjRDvCbd6xQTd3j9ovztL7YBJ
	f1K8u6Mt9+mNbZLXn3i3233dXhRfeupm+YpNP41K6i4HxiRpXtPYxzi/X4mlOCPRUIu5qDgR
	ABhiMuK8AgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprAIsWRmVeSWpSXmKPExsXC5WfdrPufKSrD4N9GNYs569ewWUzqn8Fu
	ceFHI5PFxdd/mCzuL3vGYvHnoaHF4bknWS0uPV7BbnF51xw2i8Xdb1gsHvW9ZbeY+8XQ4svq
	VWwWa/9eY3Tg81gzbw2jx6+vV9k8Jja/Y/e4e38hk8fiPS+ZPBb+fsHscWLGbxaPj09vsXgs
	fvGByWP9lqssHhM2b2T1+LxJLoAnissmJTUnsyy1SN8ugSvj2PGrrAX79CvW97o0MG5W6GLk
	5JAQMJF4eqGBEcRmEVCVePrvIBuIzSagLnHjxk9mEFtEQE2i6+QUoDgXB7PAASaJpvnvWUES
	wgIuEl/vzWIBsXkFzCV2LfnCDFIkJLCCSeLEyYuMEAlBiZMzn4AVMQNN/TPvElARB5AtLbH8
	HwdEWF6ieetssGWcAtYSGz+vZAKxRQWUJQ5sO840gZFvFpJJs5BMmoUwaRaSSQsYWVYximTm
	leUmZuaY6hVnZ1TmZVboJefnbmIExtOy2j8TdzB+uex+iFGAg1GJh3eHVWSGEGtiWXFl7iFG
	CQ5mJRHeQ05hGUK8KYmVValF+fFFpTmpxYcYpTlYlMR5vcJTE4QE0hNLUrNTUwtSi2CyTByc
	Ug2Mhz9lul09usIrd6bTtJilM9d+uO2tKDhjzyGOrK+yD59d+aFn9lnJ0T7m4mmLzj3FNmoZ
	waH5K+SUBaZFLn9yoDlhx4XgnUx8suzrHm8/uC/l39w1l0yOxTAbFP7xLX8uY+E/92vc2nVX
	58yQrPyj+UfU3PhMqdaZl7H5m2se3lZ1fPJD9J3RFiWW4oxEQy3mouJEAMHOUCijAgAA
X-CFilter-Loop: Reflected

On Mon, Jun 23, 2025 at 07:28:38PM +0930, Qu Wenruo wrote:
> 在 2025/6/23 19:22, Byungchul Park 写道:
> > On Mon, Jun 23, 2025 at 06:22:44PM +0930, Qu Wenruo wrote:
> > > 在 2025/6/23 17:49, Byungchul Park 写道:
> > > > On Mon, Jun 23, 2025 at 03:20:43PM +0930, Qu Wenruo wrote:
> > > > > 在 2025/6/23 12:51, Byungchul Park 写道:
> > > > > > Hi folks,
> > > > > > 
> > > > > > Thanks to Yunseong, we got two DEPT reports in btrfs.  It doesn't mean
> > > > > > it's obvious deadlocks, but after digging into the reports, I'm
> > > > > > wondering if it could happen by any chance.
> > > > > > 
> > > > > > 1) The first scenario that I'm concerning is:
> > > > > > 
> > > > > >      context A            context B
> > > > > > 
> > > > > >                           do_truncate()
> > > > > >                             ...
> > > > > >                               btrfs_do_readpage() // with folio lock held
> > > > > 
> > > > >                                  This one is for data.
> > > > 
> > > > Do you mean this folio is for data?  Thanks for the confirmation.
> > > 
> > > Yes, only data folios will go through btrfs_do_readpage().
> > > 
> > > For metadata, we never go through btrfs_do_readpage(), but
> > > read_extent_buffer_pages_nowait().
> > > 
> > > 
> > > > 
> > > > > >      do_unlinkat()
> > > > > >        ...
> > > > > >          push_leaf_right()
> > > > > >         btrfs_tree_lock_nested()
> > > > > >           down_write_nested(&eb->lock) // hold
> > > > 
> > > > This is struct extent_buffer's rw_sem.  Right?
> > > > 
> > > > > >                                 btrfs_get_extent()
> > > > > >                                   btrfs_lookup_file_extent()
> > > > > >                                     btrfs_search_slot()
> > > > > >                                       down_read_nested(&eb->lock) // stuck
> > > > > 
> > > > >                                          This one is for metadata.
> > > >                                                ^
> > > >                                        I don't get this actually.
> > > > 
> > > > This is struct extent_buffer's rw_sem, too.  Cannot this rw_sem be the
> > > > same as the rw_sem above in context A?
> > > 
> > > My bad, I thought you're talking about that down_read_nested()
> > > conflicting with folio lock.
> > > 
> > > But if you're talking about extent_buffer::lock, then the one in context
> > > B will wait for the one in context A, and that's expected.
> > 
> > Sounds good.
> > 
> > > > > Data and metadata page cache will never cross into each other.
> > > > > 
> > > > > Thanks,
> > > > > Qu
> > > > > 
> > > > > >           __push_leaf_right()
> > > > > >             ...
> > > > > >               folio_lock() // stuck
> > > > 
> > > > Did you mean this folio is always for metadata?
> > > 
> > > Can you explain more on where this folio_lock() comes from?
> > 
> > I should also rely on the following stacktrace in the dept report.  I
> > asked Yunseong who reported this issue, for the decoded stacktrace, so
> > that I can interpret that better.  I will get back once I figure out
> > where the wait on PG_locked comes from.
> > 
> >     [  304.344198][ T7488] [W] dept_page_wait_on_bit(pg_locked_map:0):
> >     [  304.344211][ T7488] [<ffff8000823b1d20>] __push_leaf_right+0x8f0/0xc70
> 
> I believe it's from btrfs_clear_buffer_dirty():
> 
> As we have a for() loop iterating all the folios of a an extent buffer
> (aka, metadata structure), then clear the dirty flags.
> 
> The same applies to btrfs_mark_buffer_dirty() -> set_extent_buffer_dirty().

Thanks to Yunseong, I figured out this is the case.

> In that case, the folio is 100% belonging to btree inode thus metadata.

Good to know.

Lastly, is it still good with directly manipulating block devs or
stacked file system using loopback devices, from the confliction of
folios and extent_buffers?

If you confirm it, this issue can be closed :-) Thanks in advance.

	Byungchul

> Thus the folio lock can not conflict with a data folio, thus there
> should be no deadlock.
> 
> Thanks,
> Qu
> 
> 
> >     [  304.344232][ T7488] stacktrace:
> >     [  304.344241][ T7488]       __push_leaf_right+0x8f0/0xc70
> >     [  304.344260][ T7488]       push_leaf_right+0x408/0x628
> >     [  304.344278][ T7488]       btrfs_del_items+0x974/0xaec
> >     [  304.344297][ T7488]       btrfs_truncate_inode_items+0x1c5c/0x2b00
> >     [  304.344314][ T7488]       btrfs_evict_inode+0xa4c/0xd38
> >     [  304.344335][ T7488]       evict+0x340/0x7b0
> >     [  304.344352][ T7488]       iput+0x4ec/0x840
> >     [  304.344369][ T7488]       do_unlinkat+0x444/0x59c
> >     [  304.344388][ T7488]       __arm64_sys_unlinkat+0x11c/0x260
> >     [  304.344407][ T7488]       invoke_syscall+0x88/0x2e0
> >     [  304.344425][ T7488]       el0_svc_common.constprop.0+0xe8/0x2e0
> >     [  304.344445][ T7488]       do_el0_svc+0x44/0x60
> >     [  304.344463][ T7488]       el0_svc+0x50/0x188
> >     [  304.344482][ T7488]       el0t_64_sync_handler+0x10c/0x140
> >     [  304.344503][ T7488]       el0t_64_sync+0x198/0x19c
> > 
> > Thanks.
> > 
> >       Byungchul
> > 
> > > I didn't see any location where __push_leaf_right() is locking a folio
> > > nor the original do_unlinkat().
> > > 
> > > So here I can only guess the folio is from __push_leaf_right() context,
> > > that means it can only be a metadata folio.
> > > 
> > > > 
> > > > If no, it could lead a deadlock in my opinion.  If yes, dept should
> > > > assign different classes to folios between data data and metadata.
> > > 
> > > So far I believe the folio belongs to metadata.
> > > 
> > > And since btrfs has very different handling of metadata folios, and it's
> > > a little confusing that, we also have a btree_inode to handle the
> > > metadata page cache, but do not have read_folio() callbacks, it can be a
> > > little confusing to some automatic tools.
> > > 
> > > Thanks,
> > > Qu
> 
> 

