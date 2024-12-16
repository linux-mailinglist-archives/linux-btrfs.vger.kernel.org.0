Return-Path: <linux-btrfs+bounces-10438-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E4CA09F3D60
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Dec 2024 23:23:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39D45188E87E
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Dec 2024 22:23:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C8881D88D0;
	Mon, 16 Dec 2024 22:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Dwcs4wny"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAE6B1D618E;
	Mon, 16 Dec 2024 22:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734387757; cv=none; b=i9UbxCItTzvwI2iNLPNP5asKjO2sR9GlDKtzUFxyqexjTSOWCrwId4CPUwEkP+C37kn40onxsVkbgM3BM8bZfwmTSxIwnGo6Z916i50yO/U303S33YrwMnddSzw0uhDq7gwTUoWRu40wdZPU75oYadV/ZxIuKKKAPjVsrMoiFm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734387757; c=relaxed/simple;
	bh=IGj7ZQLRogtSqYDDTYha6CIAX2CI0GubiUcgK8+7lG0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FiV08f1fX1kAzKlqeCKZ+sYemvIEqDtCWNcwwcYmR/Flbz0BGJ2WwBbw1DahIyxudK8WSfvyaTUOPTDILG46NF9vW28djz4SsfxGVAA8+dIUfpdW1/hxn/La3SrbZaKoWI0sMS8IMi6offf2lEgmBlmIZZs3FDLs3q1XugqwBE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Dwcs4wny; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=kBeBy37eOfB4RDK+YYN8OncW/LStVLH5Vx9yVDjVx4s=; b=Dwcs4wnyULvYx2Ii18LeNhXiQF
	KfiY0zpAPISjMkHD4GBEfrg/fLaGB3Qs4+m8ZFoMorTFxqBTrXy0WZ6X01llxbG7PR8F3CHAZegy1
	5udFyr8zeKN+CCYgkk0NtEiATB9hGt3EGvnsTBvQ/RdzIKPUUwr/55QScOa80ueKTVI6va/uJQH44
	Kzl7l1diW9BV+H6xtFIdH9ImVK2D0bpxLIROj+nG5onQi1XCQFsFH7Ky2YnrAsQRwbz2gzKwXqzNH
	KzgABOdqqAbuAHBrdIt19+OPkSCHSYNyvwiX7bAK93I/xpYqEocL0Lae/a7llvY2c00OY+MWc5Vme
	FdyASPmw==;
Received: from 77-249-17-89.cable.dynamic.v4.ziggo.nl ([77.249.17.89] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tNJTu-00000004x7w-00wb;
	Mon, 16 Dec 2024 22:22:27 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 75BB830031E; Mon, 16 Dec 2024 23:22:25 +0100 (CET)
Date: Mon, 16 Dec 2024 23:22:25 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: "Roger L. Beckermeyer III" <beckerlee3@gmail.com>, dsterba@suse.cz,
	oleg@redhat.com, mhiramat@kernel.org, linux-kernel@vger.kernel.org,
	josef@toxicpanda.com, linux-btrfs@vger.kernel.org, lkp@intel.com
Subject: Re: [PATCH 1/6] rbtree: add rb_find_add_cached() to rbtree.h
Message-ID: <20241216222225.GF9803@noisy.programming.kicks-ass.net>
References: <cover.1733850317.git.beckerlee3@gmail.com>
 <4768e17a808c754748ac9264b5de9e8f00f22380.1733850317.git.beckerlee3@gmail.com>
 <20241213090613.GC21636@noisy.programming.kicks-ass.net>
 <ad36347a-14a5-41d4-82d5-f557a0a7f08c@gmx.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ad36347a-14a5-41d4-82d5-f557a0a7f08c@gmx.com>

On Tue, Dec 17, 2024 at 08:43:26AM +1030, Qu Wenruo wrote:
> 
> 
> 在 2024/12/13 19:36, Peter Zijlstra 写道:
> > On Thu, Dec 12, 2024 at 10:46:18AM -0600, Roger L. Beckermeyer III wrote:
> > > Adds rb_find_add_cached() as a helper function for use with
> > > red-black trees. Used in btrfs to reduce boilerplate code.
> > > 
> > > Suggested-by: Josef Bacik <josef@toxicpanda.com>
> > > Signed-off-by: Roger L. Beckermeyer III <beckerlee3@gmail.com>
> > 
> > Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> 
> I guess it's fine to merge this change through btrfs tree?

Yeah, I think so. I don't think there's anything else pending for this
file -- its not touched much.

> 
> Just curious about the existing cmp() and less() functions, as they only
> accept the exist node as const.
> 
> I'm wondering if this is intentional to allow the less/cmp() functions
> to modify the new node if needed.
> As I normally assume such cmp()/less() should never touch any node nor
> its entries.

Oh yeah, they probably should not. I think it's just because the
callchain as a whole does not have const on the new node (for obvious
raisins), and I failed to put it on for the comparators.

You could add it (and fix up the whole tree) and see if anything comes
apart.

