Return-Path: <linux-btrfs+bounces-7529-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA22B95FCD6
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Aug 2024 00:37:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 44CB4B2266A
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Aug 2024 22:37:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F296219D88B;
	Mon, 26 Aug 2024 22:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qb09TzyV"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A3F119CD0B;
	Mon, 26 Aug 2024 22:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724711860; cv=none; b=ooiQPp0268WV6zT5/3uRvTRQ71gbSx/V1pcG85S2poAqIPtTQvA0/q1wV2m52lLsUiurLoo0vAff6TGoxfRVB8H8TaAwoKpZpAAZimhr6mAqjgQUJE6wLTizxrElnTgy9mVqAqaRKMS+HnGGAgxNvaA6gmOwdvaeYt3IkU8AZUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724711860; c=relaxed/simple;
	bh=Oouq4cH0zqJeEJMbFJlnLLmoyhkHLvjJPAdomYbsrho=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=BQyd7pD7pQlQDYbaqREVY4On1VFy7Rg7L0iEOwul2rA+btCruhRYSswYUPBZ8g9jH2DADhYeaz4F2hnOF9th/3YydKCL9W10zinLy/FU25UwEK2yNEKb4aXuF+vcuCYwwJ1hRelMn8MsVtq4B2M7h2MD2tHLMGQjbUX5amvj3gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qb09TzyV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E9E7C4DDF5;
	Mon, 26 Aug 2024 22:37:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724711859;
	bh=Oouq4cH0zqJeEJMbFJlnLLmoyhkHLvjJPAdomYbsrho=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=Qb09TzyVc2l4aw3RBI9o82wnxLWEiNEzfGCk4UIhyL3hZpBlOTJ9d3PDuG7L3lTn4
	 z+SuSa5wiedDwB7LHBOBudcJTFUvjTf2hkF8PDKPAkXApE4y+Cmm4WVESRX8doB/sh
	 cenMFNtCryIU8ZfTceOclp6BJ1Er54Fcv4FO74ca0Okc48+9BBUwN7ahWvuDIN4TB9
	 Nx928/ZCZz3gH52p3wbt1qEtUKK7/nxmuJHewXNnLZnIunD12QqJT2cqRQY9l0Q12+
	 Hiu7Z+WdKb/yxF+kr7tZx1gIBTDUMWHKcMiAdDQvNfa8bYTos40KkOsnDzp7GQBOGK
	 0fq4/WSB4Fj0Q==
Message-ID: <9a25857d-21ca-46c8-82bb-bb642d9328bf@kernel.org>
Date: Tue, 27 Aug 2024 07:37:37 +0900
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] block: rework bio splitting
From: Damien Le Moal <dlemoal@kernel.org>
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
 David Sterba <dsterba@suse.com>, Hans Holmberg <Hans.Holmberg@wdc.com>,
 Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 linux-block@vger.kernel.org, linux-btrfs@vger.kernel.org
References: <20240826173820.1690925-1-hch@lst.de>
 <20240826173820.1690925-2-hch@lst.de>
 <e59de073-c608-4206-8f98-9f46b1750931@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <e59de073-c608-4206-8f98-9f46b1750931@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/27/24 07:26, Damien Le Moal wrote:
> On 8/27/24 02:37, Christoph Hellwig wrote:
>> The current setup with bio_may_exceed_limit and __bio_split_to_limits
>> is a bit of a mess.
>>
>> Change it so that __bio_split_to_limits does all the work and is just
>> a variant of bio_split_to_limits that returns nr_segs.  This is done
>> by inlining it and instead have the various bio_split_* helpers directly
>> submit the potentially split bios.
>>
>> To support btrfs, the rw version has a lower level helper split out
>> that just returns the offset to split.  This turns out to nicely clean
>> up the btrfs flow as well.
>>
>> Signed-off-by: Christoph Hellwig <hch@lst.de>
>> ---
>>  block/blk-merge.c   | 146 +++++++++++++++++---------------------------
>>  block/blk-mq.c      |  11 ++--
>>  block/blk.h         |  63 +++++++++++++------
>>  fs/btrfs/bio.c      |  30 +++++----
>>  include/linux/bio.h |   4 +-
>>  5 files changed, 125 insertions(+), 129 deletions(-)
>>
>> diff --git a/block/blk-merge.c b/block/blk-merge.c
>> index de5281bcadc538..c7222c4685e060 100644
>> --- a/block/blk-merge.c
>> +++ b/block/blk-merge.c
>> @@ -105,9 +105,33 @@ static unsigned int bio_allowed_max_sectors(const struct queue_limits *lim)
>>  	return round_down(UINT_MAX, lim->logical_block_size) >> SECTOR_SHIFT;
>>  }
>>  
>> -static struct bio *bio_split_discard(struct bio *bio,
>> -				     const struct queue_limits *lim,
>> -				     unsigned *nsegs, struct bio_set *bs)
>> +static struct bio *bio_submit_split(struct bio *bio, int split_sectors)
> 
> Why not "unsigned int" for split_sectors ? That would avoid the need for the
> first "if" of the function. Note that bio_split() also takes an int for the
> sector count and also checks for < 0 count with a BUG_ON(). We can clean that up
> too. BIOs sector count is unsigned int...
> 
>> +{
>> +	if (unlikely(split_sectors < 0)) {
>> +		bio->bi_status = errno_to_blk_status(split_sectors);
>> +		bio_endio(bio);
>> +		return NULL;
>> +	}
>> +
>> +	if (split_sectors) {
> 
> May be the simple case should come first ? E.g.:
> 
> 	if (!split_sectors)
> 		return bio;
> 
> But shouldn't this check be:
> 
> 	if (split_sectors >= bio_sectors(bio))
> 		return bio;

Please ignore this one. The passed sector count is a limit, which can be 0, so
checking  "if (!split_sectors)" is correct.

-- 
Damien Le Moal
Western Digital Research


