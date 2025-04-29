Return-Path: <linux-btrfs+bounces-13522-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C9B5AA19BD
	for <lists+linux-btrfs@lfdr.de>; Tue, 29 Apr 2025 20:15:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23BF51C00F1B
	for <lists+linux-btrfs@lfdr.de>; Tue, 29 Apr 2025 18:13:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B77D6253B7E;
	Tue, 29 Apr 2025 18:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HoH5Mz/o"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0305C40C03;
	Tue, 29 Apr 2025 18:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745950362; cv=none; b=Dw2dZ3QhkrWRR8lMjdSPcIoGxqNdfFX0lSFnHQpcxIlQmrsGIzw+bjjEeyxThkWdFqLuKS596ZoORyyFjIzHvKqU/N1U/Ezl7MKWvD9/o/pfqpv5/C5gTeYcf6JXNXX6j2EmEhVF1uWWJVo6vSIKPmGFd6sImwoSsRWk2HYl7Cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745950362; c=relaxed/simple;
	bh=PfWyWll01BkLPtg1EutKc/qIg8v9WzXCArrnHWjqZ1o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=muFlc9zf1ZAxVhHcw/8TqDQomAQ4KAaGR5/70HEoquw+yZKRQGGIL1zLmjD7ER7J1iil7wiJyKprXBID6WcOr4V0WQ9uv3Ors/A6ndgUiX8WrqPqcA4rduc8tj8JdpktqruTLmCShPi2Pd5JdGpLOa8URqRxR8O5jUHZhwulLDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HoH5Mz/o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0986C4CEEA;
	Tue, 29 Apr 2025 18:12:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745950361;
	bh=PfWyWll01BkLPtg1EutKc/qIg8v9WzXCArrnHWjqZ1o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HoH5Mz/oZ50tnVSOUahTbqnI6tCgZ16QZ+70it1Urh5KgBlFJInALRa3zDHW8HgTl
	 Fv3reBhTJ5XtKGXLaFxNtCp9i/pgGNXcrqc3AxoM/Zs/0bKLplLrwJKPy5hsP/Bpas
	 ay53Op4mI9UORY3UyD9aiXwQ36ibeYszcA6BpxBzf21cl5m3xGn+7cCa/vWjS6nB03
	 vC/bA91B9IhlKLpsrwneWp5H4nwIbYz5/FGxeILBe8p7ksshSJLKfPo+1EaO2fj5f6
	 oqFAoaQI8f/ujM2J4F++cISR2ufW/9RXqORPvMmmrkYBgxRpuLUHGLpJAU4KoXGBDt
	 aPNvd7OvAzaKQ==
Date: Tue, 29 Apr 2025 08:12:40 -1000
From: Tejun Heo <tj@kernel.org>
To: Junxuan Liao <ljx@cs.wisc.edu>
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>, linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: btrfs thread_pool_size logic out of sync with workqueue
Message-ID: <aBEWmCB5Ofr5lCp7@slm.duckdns.org>
References: <5ee9b1d7-4772-4404-b972-93b01ed1e033@cs.wisc.edu>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5ee9b1d7-4772-4404-b972-93b01ed1e033@cs.wisc.edu>

On Mon, Apr 28, 2025 at 06:23:39PM -0500, Junxuan Liao wrote:
> Hi all,
> 
> Commit 636b927eba5bc63375 (workqueue: Make unbound workqueues to use
> per-cpu pool_workqueues) makes max_active per CPU for unbounded
> workqueues as well, but thread_pool_size in btrfs_fs_info and the mount
> option thread_pool still assume the limit is global.
> 
> e.g. The default value of 8 allows a total of 64 workers on an 8-CPU
> machine.
> 
> As far as I know, this means that on the Btrfs side we can no longer
> control the concurrency level at the same granularity as before. We
> should rewrite the auto-scaling logic, change the default
> thread_pool_size value, and update the documentation. 
> 
> Am I missing something?

5797b1c18919 ("workqueue: Implement system-wide nr_active enforcement for
unbound workqueues") turned max_active system-wide. The count is now split
across nodes proportional to the number of cpus each node has. This is still
a different behavior from before where max_active was applied per node, but
no behavior change on single node machines and the new behavior is easier to
work with.

Thanks.

-- 
tejun

