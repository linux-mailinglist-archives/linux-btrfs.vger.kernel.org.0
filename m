Return-Path: <linux-btrfs+bounces-15585-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A187B0BFC2
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Jul 2025 11:15:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71ADC3AB2B3
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Jul 2025 09:15:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C441289342;
	Mon, 21 Jul 2025 09:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=harmstone.com header.i=@harmstone.com header.b="rR1hJLJy"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail.burntcomma.com (mail2.burntcomma.com [217.169.27.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 281D7AD5E
	for <linux-btrfs@vger.kernel.org>; Mon, 21 Jul 2025 09:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.169.27.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753089332; cv=none; b=A1OYhQrhaUd/8f7ZfRLRmGKtRhpzOWFqm45kBtv0C4aC2F7ihdL6OJcnXbnqAhjHXNXy8hjS0KKEB/Z7qEMN3TQpmBDJTXgk5YdwCS10O/RneLKzspoB4/6hvauhLQCRMN7aUW2E2VxPVNW+VBltowpGmwptvJriU05JeQZx2sA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753089332; c=relaxed/simple;
	bh=9naIinSfYp/cHffLacgr3p+kEE4skTil6yyeoEPAG4s=;
	h=Message-ID:Date:Mime-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Upl/ES3bLQ808bCDUYO8ogg4OGa/1J+DiTZKU++q/N/ur55Uxjm501+4rJ5D5siWOGO38ZXfo5igmw174nBIGMXbj9M7XpMSv/C2QlyFuBhFPRgVeFGC3cPR4YZBmjlttuGx9wbOTtEVv0Hsz8qgw2I3p1WEJXz/sy4KxPlEbCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=harmstone.com; spf=pass smtp.mailfrom=harmstone.com; dkim=pass (1024-bit key) header.d=harmstone.com header.i=@harmstone.com header.b=rR1hJLJy; arc=none smtp.client-ip=217.169.27.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=harmstone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=harmstone.com
Received: from [IPV6:2a02:8012:8cf0:0:ce28:aaff:fe0d:6db2] (beren.burntcomma.com [IPv6:2a02:8012:8cf0:0:ce28:aaff:fe0d:6db2])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256
	 client-signature RSA-PSS (2048 bits) client-digest SHA256)
	(Client CN "hellas", Issuer "burntcomma.com" (verified OK))
	by mail.burntcomma.com (Postfix) with ESMTPS id F13DF29DC6A;
	Mon, 21 Jul 2025 10:15:15 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=harmstone.com;
	s=mail; t=1753089316;
	bh=asjSquuLP9zPFlOty1zoTzjqCNzJ3E18hoAzdFHcp/c=;
	h=Date:Subject:To:References:From:In-Reply-To;
	b=rR1hJLJyD4A2rsWKe5PAh4+K6BIbi36zAWob/UMfabnEZ/BbLCBOUtJIiiN+HnZqv
	 aYrbgGtS7+fNIwGPk1PPwuu4bv7eze2d8OGtvOM2OWK6pm4v/6Vk9CV5fKAqyM/c4z
	 yHGbEKl9MBjd+c7MuIY9xnkbbtD9IbCz38rErAlQ=
Message-ID: <9a96e97b-84c5-4750-ad31-346fb816e960@harmstone.com>
Date: Mon, 21 Jul 2025 10:15:15 +0100
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Subject: Re: [PATCH v3 2/3] btrfs-progs: check free space maps to block group
To: Leo Martins <loemra.dev@gmail.com>, linux-btrfs@vger.kernel.org
References: <cover.1728346056.git.loemra.dev@gmail.com>
 <fe95778b1f5e29c035720ca7c02946fde25dcbb2.1728346056.git.loemra.dev@gmail.com>
Content-Language: en-US
From: Mark Harmstone <mark@harmstone.com>
Autocrypt: addr=mark@harmstone.com; keydata=
 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
In-Reply-To: <fe95778b1f5e29c035720ca7c02946fde25dcbb2.1728346056.git.loemra.dev@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Replying to this, as I've just run into this problem myself, and these patches
weren't accepted.

Patch 1 is fine.

For patch 2, there's an easier way of doing this: replace btrfs_lookup_first_block_group()
with btrfs_lookup_block_group(), which almost certainly was what was meant in
the first place.
But... doing this will cause pretty much all of the existing tests to fail,
so you'll have to fix them all in the same patch. I suspect this was the
reason that the patches didn't get accepted.

For patch 3, I wouldn't bother. I know there's some inevitable drift between
kernel-shared and the actual kernel, but adding a tree-checker to one and not
the other seems a bit too far. And if you were to add it to the kernel, that'd
add a runtime overhead for something harmless.

I suggest that when you resubmit these patches, you do it via a GitHub PR.
That way you won't have megabytes and megabytes of fixed tests sent to the
mailing list, the CI will run the tests for you automatically, and it's
less likely that it'll get forgotten about.

Mark

On 08/10/2024 1.27 am, Leo Martins wrote:
> Check that the block-group that is found matches the objectid and offset
> of the free-space-info. Without this the check only verifies that there
> is some block-group that exists with objectid >= free-space-info's
> objectid.
> 
> I have softened the language of the warning and included instructions on
> how to fix the problem. This can be done in a couple of ways:
> - btrfs check --repair
> - btrfs rescue clear-space-cache v2
> 
> I chose to include btrfs rescue as it is more targeted.
> 
> Signed-off-by: Leo Martins <loemra.dev@gmail.com>
> ---
> CHANGELOG:
> v3:
> - softened the warning and added instructions
> ---
>   common/clear-cache.c | 11 +++++++++--
>   1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/common/clear-cache.c b/common/clear-cache.c
> index 6493866d..6b362f64 100644
> --- a/common/clear-cache.c
> +++ b/common/clear-cache.c
> @@ -165,9 +165,16 @@ static int check_free_space_tree(struct btrfs_root *root)
>   		}
>   
>   		bg = btrfs_lookup_first_block_group(fs_info, key.objectid);
> -		if (!bg) {
> +		if (!bg || key.objectid != bg->start ||
> +		    key.offset != bg->length) {
>   			fprintf(stderr,
> -		"We have a space info key for a block group that doesn't exist\n");
> +				"We have a space info key [%llu %u %llu] for a block group that "
> +				"doesn't exist.\n",
> +				key.objectid, key.type, key.offset);
> +			fprintf(stderr,
> +				"This is likely due to a minor bug in mkfs.btrfs that doesn't properly\n"
> +				"cleanup free spaces and can be fixed using btrfs rescue "
> +				"clear-space-cache v2\n");
>   			ret = -EINVAL;
>   			goto out;
>   		}


