Return-Path: <linux-btrfs+bounces-9288-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CC1E9B8AB1
	for <lists+linux-btrfs@lfdr.de>; Fri,  1 Nov 2024 06:38:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31CB028125E
	for <lists+linux-btrfs@lfdr.de>; Fri,  1 Nov 2024 05:38:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75FE614A4C6;
	Fri,  1 Nov 2024 05:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PKhmagDZ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 943A828FC;
	Fri,  1 Nov 2024 05:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730439530; cv=none; b=THwztVt4AX1R47EWIpZAT8NFRUFdj6KBvK88U9+pN3m9eh1PK4/0xAlO/uR9rwUSDW2Sn4N5A+3RaxV+sEpsdwgtBRcTApZH9hRfnsoeU77+HbylS0y8WEH0KJ9QAosOfqcjscUPLdZFQMnC28lERSpkPlM2L3ptCyJnQolmdXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730439530; c=relaxed/simple;
	bh=Mvm4k8wOVzrhh/yFTkYdCnF59bYJM081/6UnOVv7P6w=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=c0rFcFHS94w72/bmxrxpD2i4Tzux3u8e0ByoZa4dbB5nYAvT9Or7J5/SgSs7ZrksSWxY5PQIw7DNpkh7aGmQlycVVD1wxy9zdfCQTxIYrCwbheoL8zO0H7wdRV72PKOKZgmDj6oA7dl06PzWqIfkT3mbRdjQLX1tm/A5KKXJM8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PKhmagDZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 403BEC4CECD;
	Fri,  1 Nov 2024 05:38:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730439530;
	bh=Mvm4k8wOVzrhh/yFTkYdCnF59bYJM081/6UnOVv7P6w=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
	b=PKhmagDZ7bz4qQZpkPbV7ziKlICstyf3VvpXpF7uOCxOtGWFKQC3MwgxhyiGS2dSw
	 jZKsfbL6XqGuEE9cZBssHEMAYgPwsesu7WqsFiPNSCN0ApeuQAGkt1A3tOIyDF15gg
	 5iAwAEPwO7gOfhFIddeFfjvT7wXrMDnYOVCkSKn7i6VvfFZZ6gLVlcOsaYbFmRSnNl
	 uaq8ThpOknXI8ZnrpE4oEn7rh0Rxb++RAXhWT3sTsqf9HuhRwmxCjGMPuxKZzyYDO+
	 cH/A9VYKzq4F4mGJeMUy1U8jOuWuxn+de7quN3fdZmyIkW+1ExsXhT7xL2AjTsq1LA
	 WQBcll1T201Gw==
Message-ID: <054daee0-04f2-4ac5-ae47-38acb7b2fb57@kernel.org>
Date: Fri, 1 Nov 2024 14:38:48 +0900
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Damien Le Moal <dlemoal@kernel.org>
Subject: Re: [PATCH 3/4] btrfs: use bio_is_zone_append in the completion
 handler
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
 Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
 David Sterba <dsterba@suse.com>
Cc: linux-block@vger.kernel.org, linux-btrfs@vger.kernel.org
References: <20241101052206.437530-1-hch@lst.de>
 <20241101052206.437530-4-hch@lst.de>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20241101052206.437530-4-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/1/24 14:21, Christoph Hellwig wrote:
> Otherwise it won't catch bios turned into regular writes by the
> block level zone write plugging.
> 
> Fixes: 9b1ce7f0c6f8 ("block: Implement zone append emulation")
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>


-- 
Damien Le Moal
Western Digital Research

