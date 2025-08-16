Return-Path: <linux-btrfs+bounces-16108-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B253AB28966
	for <lists+linux-btrfs@lfdr.de>; Sat, 16 Aug 2025 02:50:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A37EE5A5F40
	for <lists+linux-btrfs@lfdr.de>; Sat, 16 Aug 2025 00:50:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACE8332C8B;
	Sat, 16 Aug 2025 00:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="i0lOVaBK"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46D3710E9
	for <linux-btrfs@vger.kernel.org>; Sat, 16 Aug 2025 00:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755305448; cv=none; b=Hv5P2ZH8g7PmgWf8a0u4coO/GLCdb7ntq8eLP7aR6+SNjkWYMxfACK6+EeAYOAGRp5hzEFtsYx5pB5sPOtHrvcAVJoNcR5FqYPXwdqS8NQ7MuTia/yxCdOIh5kI8OXJs1pCMNzpEDP3sSHcsnZUAxM7cvwpXQGdmpnSiGMAvEsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755305448; c=relaxed/simple;
	bh=3mDeU39WqeCSn53M3PM7AOCrLX1dw9Z89ly34ZiptYw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A8vBJ0IA3IMhKtfEX56UXLKDCzXMgJJEvs7TFm+8O75p3WrsjO9rdvK+feDhbDo5AaNCtSpXUbrUVGtQ3KGt4w8IhGDVfdLFnuTP9IJE0oDXGhjYHKAhpgaZ8DLhFItWu5QZmbK0OGDD5q6ZxYTkG7xpxljopgt2MwxwiIYE7Eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=i0lOVaBK; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 15 Aug 2025 17:50:28 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1755305444;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JYBQzGDsedWj5iS2Ox4ruwlLXhsJn8Up52SCqrZu26M=;
	b=i0lOVaBKU/KtRy5RzOuMa+9ztCY5xKPzokqbgv0c5rfXlz0ju2FitYrkJSKPEa04WUvNVW
	3Z3QZxn9GT6+kmc3Buh4o9m2Bsj5woiXutsudPxwLmroN7utFdFyI8vkrXaUKS7vXFbDnl
	qM6IGgXhuydH1vqKEqay57nkoZ1OUXI=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Boris Burkov <boris@bur.io>
Cc: linux-btrfs@vger.kernel.org, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, kernel-team@fb.com, wqu@suse.com, willy@infradead.org
Subject: Re: [PATCH v2 3/3] btrfs: set AS_UNCHARGED on the btree_inode
Message-ID: <mlfxq3ocdmnzvpykzo3zmeebdv5rpohk64aevx3fbwvmj6xitb@ebxlwsd72utx>
References: <cover.1755300815.git.boris@bur.io>
 <786282400115bf7701d7f9c6b00a9549f67e29f7.1755300815.git.boris@bur.io>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <786282400115bf7701d7f9c6b00a9549f67e29f7.1755300815.git.boris@bur.io>
X-Migadu-Flow: FLOW_OUT

On Fri, Aug 15, 2025 at 04:40:33PM -0700, Boris Burkov wrote:
> extent_buffers are global and shared so their pages should not belong to
> any particular cgroup (currently whichever cgroups happens to allocate
> the extent_buffer).
> 
> Btrfs tree operations should not arbitrarily block on cgroup reclaim or
> have the shared extent_buffer pages on a cgroup's reclaim lists.
> 
> Signed-off-by: Boris Burkov <boris@bur.io>

Acked-by: Shakeel Butt <shakeel.butt@linux.dev>

I think mm-tree is better for this series.


