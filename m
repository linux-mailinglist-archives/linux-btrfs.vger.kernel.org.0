Return-Path: <linux-btrfs+bounces-4247-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C61208A470B
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Apr 2024 04:36:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 51A53B211D6
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Apr 2024 02:36:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6774C1BF37;
	Mon, 15 Apr 2024 02:36:16 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from out198-176.us.a.mail.aliyun.com (out198-176.us.a.mail.aliyun.com [47.90.198.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7CF7179BF
	for <linux-btrfs@vger.kernel.org>; Mon, 15 Apr 2024 02:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.198.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713148575; cv=none; b=dF8HTY6Iz9dVMGJmzmQOYcN+/JHoOHV/NIhXjlqTFjJHM1xfKTLueY3wgTPICKpOOnSGhsEBzRQd2xMoS01CZtsaNeFAFC72Og22ZG4SMVxKfwVzDVakfLy3im8rV/iZ1yvfqsivwyL15shtqC9r+x41VhE7y9rwVHMvLAam+bM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713148575; c=relaxed/simple;
	bh=nqk4umB2YDA+VYJtVXWBmvm+jOJLelUwXoQFGfkMoGM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:Message-Id:
	 MIME-Version:Content-Type; b=n60S5G+RVgx7vR+maViYNPU8rY+HfP46XQ6UvypA+5l1adR7lw29KQWvAPyGYAmqAdu2z9qdN80UJJeJGpK/YKk1d1tfZLoew1Mx7Bq78QrWELellEczNptkZLv0CUaYxYCcEdzRuTs9eZBdmg4KYzAvFmKuXoaK5FTbhMipE94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=e16-tech.com; spf=pass smtp.mailfrom=e16-tech.com; arc=none smtp.client-ip=47.90.198.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=e16-tech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=e16-tech.com
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.04600599|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.144802-0.020258-0.83494;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047194;MF=wangyugui@e16-tech.com;NM=1;PH=DS;RN=4;RT=4;SR=0;TI=SMTPD_---.XAE2VUt_1713148557;
Received: from 192.168.2.112(mailfrom:wangyugui@e16-tech.com fp:SMTPD_---.XAE2VUt_1713148557)
          by smtp.aliyun-inc.com;
          Mon, 15 Apr 2024 10:35:58 +0800
Date: Mon, 15 Apr 2024 10:35:58 +0800
From: Wang Yugui <wangyugui@e16-tech.com>
To: Qu Wenruo <wqu@suse.com>
Subject: Re: [PATCH v2] btrfs: do not wait for short bulk allocation
Cc: linux-btrfs@vger.kernel.org,
 Julian Taylor <julian.taylor@1und1.de>,
 Filipe Manana <fdmanana@suse.com>
In-Reply-To: <4ad8e412-1a37-42b1-8cc4-2ffec664b035@suse.com>
References: <20240414202622.B092.409509F4@e16-tech.com> <4ad8e412-1a37-42b1-8cc4-2ffec664b035@suse.com>
Message-Id: <20240415103557.D8BC.409509F4@e16-tech.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="GB2312"
Content-Transfer-Encoding: 8bit
X-Mailer: Becky! ver. 2.81.06 [en]

Hi,
> 
> 
> ÔÚ 2024/4/14 21:56, Wang Yugui Ð´µÀ:
> > Hi,
> >
> >> [BUG]
> >> There is a recent report that when memory pressure is high (including
> >> cached pages), btrfs can spend most of its time on memory allocation in
> >> btrfs_alloc_page_array() for compressed read/write.
> >>
> >> [CAUSE]
> >> For btrfs_alloc_page_array() we always go alloc_pages_bulk_array(), and
> >> even if the bulk allocation failed (fell back to single page
> >> allocation) we still retry but with extra memalloc_retry_wait().
> >>
> >> If the bulk alloc only returned one page a time, we would spend a lot of
> >> time on the retry wait.
> >>
> >> The behavior was introduced in commit 395cb57e8560 ("btrfs: wait between
> >> incomplete batch memory allocations").
> >>
> >> [FIX]
> >> Although the commit mentioned that other filesystems do the wait, it's
> >> not the case at least nowadays.
> >>
> >> All the mainlined filesystems only call memalloc_retry_wait() if they
> >> failed to allocate any page (not only for bulk allocation).
> >> If there is any progress, they won't call memalloc_retry_wait() at all.
> >>
> >> For example, xfs_buf_alloc_pages() would only call memalloc_retry_wait()
> >> if there is no allocation progress at all, and the call is not for
> >> metadata readahead.
> >>
> >> So I don't believe we should call memalloc_retry_wait() unconditionally
> >> for short allocation.
> >>
> >> This patch would only call memalloc_retry_wait() if failed to allocate
> >> any page for tree block allocation (which goes with __GFP_NOFAIL and may
> >> not need the special handling anyway), and reduce the latency for
> >> btrfs_alloc_page_array().
> >>
> >> Reported-by: Julian Taylor <julian.taylor@1und1.de>
> >> Tested-by: Julian Taylor <julian.taylor@1und1.de>
> >> Link: https://lore.kernel.org/all/8966c095-cbe7-4d22-9784-a647d1bf27c3@1und1.de/
> >> Fixes: 395cb57e8560 ("btrfs: wait between incomplete batch memory allocations")
> >
> > It seems this patch remove all the logic of
> > 	395cb57e8560 ("btrfs: wait between incomplete batch memory allocations"),
> >
> > so we should revert this part too?
> 
> Oh, right.
> 
> Feel free to submit a patch to cleanup the headers here.

This patch is in misc-next now, and yet not in linux upstream.

so a v3 patch in the format of revert 395cb57e8560 ("btrfs: wait between
incomplete batch memory allocations")' maybe better.

Best Regards
Wang Yugui (wangyugui@e16-tech.com)
2024/04/15


> Thanks,
> Qu
> >
> > diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> > index c140dd0..df4675e 100644
> > --- a/fs/btrfs/extent_io.c
> > +++ b/fs/btrfs/extent_io.c
> > @@ -6,7 +6,6 @@
> >   #include <linux/mm.h>
> >   #include <linux/pagemap.h>
> >   #include <linux/page-flags.h>
> > -#include <linux/sched/mm.h>
> >   #include <linux/spinlock.h>
> >   #include <linux/blkdev.h>
> >   #include <linux/swap.h>
> >


