Return-Path: <linux-btrfs+bounces-13523-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AF342AA1ABC
	for <lists+linux-btrfs@lfdr.de>; Tue, 29 Apr 2025 20:35:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 411DE1BC1471
	for <lists+linux-btrfs@lfdr.de>; Tue, 29 Apr 2025 18:35:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FCEF25335B;
	Tue, 29 Apr 2025 18:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O8pwGZ6Y"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E861188A0E;
	Tue, 29 Apr 2025 18:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745951711; cv=none; b=roQb95sPuWFMDJItjZml25LOeqkdzIm8YGdY3IakZUgWWtGPprI8HvA1f4AQ95JQaAnnFt7hvT+O3z3R5M6k34echlp+I6E8OqJFLqxDyBZIHGfScGtZTNzStOhsWK2zlwImhH9rAcyPiPmNf0poVDxCrvu6cItI1wCngqnHPbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745951711; c=relaxed/simple;
	bh=AP3h628SrJQ4W+0Pp3/H6Qmzl2B1h1zdDn/vSJq8xfw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B32rvhho75rPdPv6gISlmEtag1MpXZHcXW2rDJifeQEshrSDgkxLoF3mT4DgrjOOnqrv4QUBkIiIwLLnUj/XEKb/G9cnpLzVYpwwv01qZUjSi8UblyPbx9aupDf755vqCBALwIJPMAtYhs2q7xYAF9Bxk4ctW513w9fb8VUMMO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O8pwGZ6Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03792C4CEE3;
	Tue, 29 Apr 2025 18:35:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745951711;
	bh=AP3h628SrJQ4W+0Pp3/H6Qmzl2B1h1zdDn/vSJq8xfw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=O8pwGZ6YgKQrR5FzO9W204QHL2hgQDJXziJj57eQGM+r661MxQ669R5bR0rRW6dW4
	 LHaaK+kVf+FpV9l8+8Q9rC+NwUCQXX4kaVwxAVMi8gz4qPqONJtDw5AMzyNkkmo/xW
	 1SGaPL68eXutjCWTs8I2+jWn6sYweL6VF/Z4irn6sHf8zHyJirjpG+eA7eRLV6HXXJ
	 Lcoe8pnyBwbzHpwZFO1a0lqQYcpF2YHBiJW2wNXLjCRc0pM8FXzRu+liVrJeOlsI3R
	 4VypT4Agjm7nWcpIOmYshnj6P4nQwZAMV6nQzU6q0ZDgFFRAT9alq5eapkJXwPlab4
	 L/E2Xyj9msVLA==
Date: Tue, 29 Apr 2025 08:35:10 -1000
From: Tejun Heo <tj@kernel.org>
To: Junxuan Liao <ljx@cs.wisc.edu>
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>, linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: btrfs thread_pool_size logic out of sync with workqueue
Message-ID: <aBEb3kjVKcqzNBov@slm.duckdns.org>
References: <5ee9b1d7-4772-4404-b972-93b01ed1e033@cs.wisc.edu>
 <aBEWmCB5Ofr5lCp7@slm.duckdns.org>
 <476f9bf7-2cd2-4c26-b55f-b42b9fe7eafc@cs.wisc.edu>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <476f9bf7-2cd2-4c26-b55f-b42b9fe7eafc@cs.wisc.edu>

On Tue, Apr 29, 2025 at 01:28:46PM -0500, Junxuan Liao wrote:
> 
> 
> On 4/29/25 1:12 PM, Tejun Heo wrote:
> > 5797b1c18919 ("workqueue: Implement system-wide nr_active enforcement for
> > unbound workqueues") turned max_active system-wide. The count is now split
> > across nodes proportional to the number of cpus each node has. This is still
> > a different behavior from before where max_active was applied per node, but
> > no behavior change on single node machines and the new behavior is easier to
> > work with.
> 
> Thanks! I missed that. workqueue.rst doesn't reflect the change though.

Yeah, I really should but patches welcome. :-)

Thanks.

-- 
tejun

