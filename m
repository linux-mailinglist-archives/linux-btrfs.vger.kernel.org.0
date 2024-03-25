Return-Path: <linux-btrfs+bounces-3564-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 086B688B2C0
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Mar 2024 22:28:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 399FE1C3E541
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Mar 2024 21:28:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32C546E5F6;
	Mon, 25 Mar 2024 21:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dorminy.me header.i=@dorminy.me header.b="g6bsPvMg"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from box.fidei.email (box.fidei.email [71.19.144.250])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 302D66D1B4
	for <linux-btrfs@vger.kernel.org>; Mon, 25 Mar 2024 21:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=71.19.144.250
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711402078; cv=none; b=BKST3YYo9wJhoevUXPVg0Ldt4X71GqhesK6ieeuKJyYQRTBW66Qoxb2H3ENgjsFEYR7MmYwicl/0UzVYhNwmPGTwG0DZv9YwOhsGcoVwGXqoitf+YqGacXmjGyYrU4tdcE3bfVCYgQ/P7eiux1Ohp04SDZrQ8ZLX3tv5TqxnzyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711402078; c=relaxed/simple;
	bh=QV4/k2icBqv9TWTTf1hn/x1jqSnz0wHjWGCYkbL3cmE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RrMLoX2jrQxnMFYhHF3IQo4WlvSbDpm7BMtnfZKcvHyONHgodFD7GmR+WkPT40vJ4EWcNXE0Fxg4RCqjpMVoQUzPug8aSAFkfGjZKYO0iokzVl+8GoMoD+sY+NbET+Z/qJyzEKsVfY/pkBYbcx1J0MlAh+Xidq1ZBGi9RK3jEfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dorminy.me; spf=pass smtp.mailfrom=dorminy.me; dkim=pass (2048-bit key) header.d=dorminy.me header.i=@dorminy.me header.b=g6bsPvMg; arc=none smtp.client-ip=71.19.144.250
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dorminy.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dorminy.me
Received: from authenticated-user (box.fidei.email [71.19.144.250])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by box.fidei.email (Postfix) with ESMTPSA id 02B038119C;
	Mon, 25 Mar 2024 17:18:55 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dorminy.me; s=mail;
	t=1711401538; bh=QV4/k2icBqv9TWTTf1hn/x1jqSnz0wHjWGCYkbL3cmE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=g6bsPvMgOOTjpqln1aa/IHDRW53Z4a2zveicFCtJGzpIxWjpsBsYAVJvb5V7STgA0
	 iFYPEKZWXrJuqxupqufw1EGefcrL3AHaL2vhYbq3bZjI3IUt0aAoYcYc3hcYErhFKz
	 DJ1QxjiJ6NZLxuQKfE4908Eu3cSuuQj6SEtWqqzO/UKn4lNoGQuQBhupo6CzkS1BzF
	 wV/ISvDpdQKXAG45As21HCSTv9d4TKXKxV6hfCg9TEbIHA9E2kv/mx6aVlWuAPrZYJ
	 w6I74TcUNI09Y1bbdqWZO+jIBGq4ZeHNlMuf3+EC5XR9ZAQ0Jw+r8lGwvXUhA01YQG
	 jt5WhR/K1L7vg==
Message-ID: <a4fa315e-294f-4649-9315-629648e15de3@dorminy.me>
Date: Mon, 25 Mar 2024 17:18:51 -0400
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] btrfs: fallback to single page allocation to avoid bulk
 allocation latency
Content-Language: en-US
To: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Cc: Julian Taylor <julian.taylor@1und1.de>
References: <9ec01e023cc34e5729dd4a86affd5158f87c7a83.1711311627.git.wqu@suse.com>
From: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
In-Reply-To: <9ec01e023cc34e5729dd4a86affd5158f87c7a83.1711311627.git.wqu@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 3/24/24 16:20, Qu Wenruo wrote:
> [BUG]
> There is a recent report that when memory pressure is high (including
> cached pages), btrfs can spend most of its time on memory allocation in
> btrfs_alloc_page_array().
> 
> [CAUSE]
> For btrfs_alloc_page_array() we always go alloc_pages_bulk_array(), and
> even if the bulk allocation failed we still retry but with extra
> memalloc_retry_wait().
> 
> If the bulk alloc only returned one page a time, we would spend a lot of
> time on the retry wait.
> 
> [FIX]
> Instead of always trying the same bulk allocation, fallback to single
> page allocation if the initial bulk allocation attempt doesn't fill the
> whole request.


I still think the argument in 395cb57e85604 is reasonably compelling: 
that it's polite and normative among filesystems to throw in a 
retry_wait() between attempts to allocate, and I'm not sure why we're 
seeing this performance impact where others seemingly don't.

But your change does a lot more than just cutting out the retry_wait(); 
it only tries the bulk allocator once. Given the bulk allocator falls 
back to the single-page allocator itself and can allocate multiple pages 
on any given iteration, I think it's better to just cut out the 
retry_wait() if we must, in hopes we can allocate more than one when 
retrying?

Or, could we add in GFP_RETRY_MAYFAIL into the btrfs_alloc_page_array() 
call in compression.c instead, so that page reclaim is started if the 
initial alloc_pages_bulk_array() doesn't work out?

