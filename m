Return-Path: <linux-btrfs+bounces-12137-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35662A592AE
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Mar 2025 12:23:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D41A83A66C1
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Mar 2025 11:23:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2EF2220696;
	Mon, 10 Mar 2025 11:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Raq4xoas"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from casper.infradead.org (unknown [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF05E21E0AE;
	Mon, 10 Mar 2025 11:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741605818; cv=none; b=g79wZQcKjzMRRHlwHI+PPLgpCY1xEDE/sVXdMSN+sZssNuo4flqtd+H2gGmQPKw3J6nQbv5DXrTby+LQcyhxAeiX3W9MExcxsGD21BuW8H8HDPCqqoIINqRLTBkpBK7UcNUotCA0DqPFoa2/wCM0hCTpD5i6iwCwJaBZ/Agzrj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741605818; c=relaxed/simple;
	bh=E5eFDYZ2bw6fQtD72q9Yk5lSyan7UWSFac8+dlQpXI8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lUtV0i9A9XEppKlNpftFFhDuCiDHtufHJ5cDvMQaP4RGKC5E6lXPg6PSRCMkZp18itoimV9OaEgqjjjU+zn4uTMx+XFW6kufWRbdrCfW/XgEK0LfjQuEzKNSBvw1vPom8o8XyN/YNK5pugpvJ89IUfPFfyWDbjp50YF0hBtWkfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Raq4xoas; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=YNZPfFGP+uTjY3cBvGbcg2FVm6EpkrIboOpfDM7t1i0=; b=Raq4xoas0fmypQOdr6ECbQkBOT
	j86zk+zLOjLmtUAdXKk0LM4yQ5CI7CH903YBuJ3bkln87vw0qVkcaongwBya1WjmrvVvgSKwCqHBN
	tk8uVdYWY8bJ9CArVBY3fqa60iFl2SA27A+3WM6Ob7XsI/B41lKeLqZJOjSTL6+mHl3B6q/cb8Ykm
	fuKehtjXAaWNcnLDrERnDZZg+1JGBYJnsasMdamty3GMALSSELYDSgYo4mNxE35pzDtu2UDLYrd2E
	M4OMKrYkDptRYP7jXlRXdC8g/zCdfjxvDrmvQ8+KTIXY/3wXf7EkvcPaJf9vIjTDvhoG6HMpOdWir
	DHymwHZw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1trbE4-00000004Ees-049a;
	Mon, 10 Mar 2025 11:23:17 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 889E7300599; Mon, 10 Mar 2025 12:23:15 +0100 (CET)
Date: Mon, 10 Mar 2025 12:23:15 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Cc: Chris Murphy <lists@colorremedies.com>,
	Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>,
	David Sterba <dsterba@suse.cz>,
	Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>
Subject: Re: BUG: MAX_LOCKDEP_CHAIN_HLOCKS too low!
Message-ID: <20250310112315.GS16878@noisy.programming.kicks-ass.net>
References: <20230125171517.GV11562@twin.jikos.cz>
 <CABXGCsOD7jVGYkFFG-nM9BgNq_7c16yU08EBfaUc6+iNsX338g@mail.gmail.com>
 <Y9K6m5USnON/19GT@boqun-archlinux>
 <CABXGCsMD6nAPpF34c6oMK47kHUQqADQPUCWrxyY7WFiKi1qPNg@mail.gmail.com>
 <a8992f62-06e6-b183-3ab5-8118343efb3f@redhat.com>
 <7e48c1ec-c653-484e-88fb-69f3deb40b1d@app.fastmail.com>
 <Y9NN9CFWc40oxmzP@boqun-archlinux>
 <b112394d-7efa-c6f9-bbef-a73c501ff02c@redhat.com>
 <2ffd1b69-76c2-4e15-a139-1406746ae4ef@app.fastmail.com>
 <CABXGCsOz43OKLXUcJcqHfNpyppgK6EbfZ7aoXYPS1t21+N6i8g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABXGCsOz43OKLXUcJcqHfNpyppgK6EbfZ7aoXYPS1t21+N6i8g@mail.gmail.com>

On Mon, Mar 10, 2025 at 03:51:21AM +0500, Mikhail Gavrilov wrote:
> On Fri, Jan 27, 2023 at 8:33 PM Chris Murphy <lists@colorremedies.com> wrote:
> > Also, at least in Fedora Rawhide where the mainline debug kernels appear, mostly get used non-interactively with automated tests. So if we're going to discover lockdep issues, we need the kernel logs to be reliable at the time those tests are run, and we don't have a practical way of adding another boot parameter just for these tests.
> >
> > Anyway I went ahead and submitted an MR to bump this to 19.
> > https://gitlab.com/cki-project/kernel-ark/-/merge_requests/2271
> >
> 
> Hi,
> Two years have passed since my last message in this thread.
> And now CONFIG_LOCKDEP_CHAIN_BITS=19 has become insufficient.
> https://gitlab.com/cki-project/kernel-ark/-/blob/os-build/redhat/configs/fedora/generic/CONFIG_LOCKDEP_CHAINS_BITS
> 
> I am again faced by "BUG: MAX_LOCKDEP_CHAIN_HLOCKS too low!"
> Still not exists a boot parameter that could redefine
> MAX_LOCKDEP_CHAIN_HLOCKS at boot time?
> And what should we do? Again, bump CONFIG_LOCKDEP_CHAIN_BITS? Now up to 20?

What are you actually doing? Anyway, check your chains to see if there's
anything obviously silly causing a combinatorial explosion.



