Return-Path: <linux-btrfs+bounces-10194-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 15B529EB603
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Dec 2024 17:20:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8298188477C
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Dec 2024 16:20:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFBE01BDABE;
	Tue, 10 Dec 2024 16:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W5kLzhfj"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF8C218A94C;
	Tue, 10 Dec 2024 16:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733847617; cv=none; b=bug95CS6QBdUK0Ew2oRnXcaGy8o8RofIDqUsi1aVntIvY6vmNpyNKtZwmBm9YQShlBR5jfJ8iPNYN5CeFnU5O3HyZZWEp+i0BxWCmwvA42JJg7+NbEn+0PbkWi3U5e9ytEs2tC534QQfACLN9Em1u1wLYZx/zJdi4ITVUyjY6g8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733847617; c=relaxed/simple;
	bh=2FFDIyt9HQiwlBcQMtPHa2HROdninP3g8JMDVwboPe8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FJZTib8wTPrLNUtZ6tskNFTLijnZEAV8R/mr2ootAxU8YgE/mx39nnZ+OXJL6+Tvs6j7OlHtSufEu40kQ5tcQ/w0FGB9k08Zv1uTkoOV9jhgEPP2+ztWIoPhbfW8xp1Q/leIxxH5ubVfT02Q3sOnS6m1DJCg6t9fyh+z34g8pZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W5kLzhfj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 279E7C4CED6;
	Tue, 10 Dec 2024 16:20:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733847617;
	bh=2FFDIyt9HQiwlBcQMtPHa2HROdninP3g8JMDVwboPe8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=W5kLzhfjyDJ5QKhrmpnJXdPFxNvUjcwziZHIsH1MVTM5JzHFkmxrAa7ZhtYWw+NMi
	 W2jYvjKVn+WlgQENuhwckkyjOBrKKs6aFontpX3C29ev1ie5Pq5hD0YUkw+iLZZUSr
	 ZNychqzElSM5Q1c2mw/rdzhXd5K2qNIVezcvo6CUGjPxN+JZhD8S8WPFLuEoKAR1BN
	 bHe8KTpivqPnouQ3r/yskjq6nh69FvXrNyxgNtWo27I8U/XbhtPtQDyohaVP8rGaXi
	 +w3C78qq9cO8xxMNPrmIL8wEYPHG0agJVwTUmj8JhsA4912cnnh7TDeNSEjuizlKOb
	 U4fZvHzWfKXTg==
Date: Tue, 10 Dec 2024 11:20:15 -0500
From: Sasha Levin <sashal@kernel.org>
To: David Sterba <dsterba@suse.cz>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Qu Wenruo <wqu@suse.com>, David Sterba <dsterba@suse.com>,
	clm@fb.com, josef@toxicpanda.com, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 6.12 09/19] btrfs: zlib: make the compression
 path to handle sector size < page size
Message-ID: <Z1hqP7E_H96rMscS@sashalap>
References: <20241124123912.3335344-1-sashal@kernel.org>
 <20241124123912.3335344-9-sashal@kernel.org>
 <20241125152059.GY31418@suse.cz>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20241125152059.GY31418@suse.cz>

On Mon, Nov 25, 2024 at 04:20:59PM +0100, David Sterba wrote:
>On Sun, Nov 24, 2024 at 07:38:44AM -0500, Sasha Levin wrote:
>> From: Qu Wenruo <wqu@suse.com>
>>
>> [ Upstream commit f6ebedb09bb276256e084196e2322562dc4aac10 ]
>>
>> Inside zlib_compress_folios(), each time we switch the input page cache,
>> the @start is increased by PAGE_SIZE.
>>
>> But for the incoming compression support for sector size < page size
>> (previously we support compression only when the range is fully page
>> aligned), this is not going to handle the following case:
>>
>>     0          32K         64K          96K
>>     |          |///////////||///////////|
>>
>> @start has the initial value 32K, indicating the start filepos of the
>> to-be-compressed range.
>>
>> And when grabbing the first page as input, we always call "start +=
>> PAGE_SIZE;".
>>
>> But since @start is starting at 32K, it will be increased by 64K,
>> resulting it to be 96K for the next range, causing incorrect input range
>> and corruption for the future subpage compression.
>>
>> Fix it by only increase @start by the input size.
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> Signed-off-by: David Sterba <dsterba@suse.com>
>> Signed-off-by: Sasha Levin <sashal@kernel.org>
>
>Please drop this patch from stable, it's preparatory work and has
>otherwise no effect.

Will do, thanks!

-- 
Thanks,
Sasha

