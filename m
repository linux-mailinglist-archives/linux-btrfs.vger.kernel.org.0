Return-Path: <linux-btrfs+bounces-21755-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aIozNLvMlWl+UwIAu9opvQ
	(envelope-from <linux-btrfs+bounces-21755-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Feb 2026 15:29:15 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 48D73157109
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Feb 2026 15:29:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3ADA230160DB
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Feb 2026 14:29:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82744336EDA;
	Wed, 18 Feb 2026 14:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=harmstone.com header.i=@harmstone.com header.b="Jc4MqWW1"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail.burntcomma.com (mail2.burntcomma.com [217.169.27.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5F6333373D
	for <linux-btrfs@vger.kernel.org>; Wed, 18 Feb 2026 14:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.169.27.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771424952; cv=none; b=PY6rDyYsDBtfZ6zGx6DdCROpOKr5aNBMLY+GREj0WiMMTL8ffDvrPmQVL6WOwaZKfKVonf5ogbWB8OAB4u7oo5nYrzFfPyURyXJoMv05gBn5VFNg61wR6rUTYTWbIF0pFmfkKyWYFj33FNteRn4xBJ7BlbGK5D+iwGmWB9xaBTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771424952; c=relaxed/simple;
	bh=tboELz0cbDM3+K6P42EtmK+fAgVzX727u8OZ7ScP7U8=;
	h=Message-ID:Date:Mime-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r1xHIc+cJctoI7hufwgLqJhm7wxVXfTHgCuoSABwWiODFcPomg0Vu0FXX782+PgQV9P2FbR7V/w6sY9agPJZ3ndGSxW+WfwH4KuCkG39FVsokRcZYhQ7c+tBzdAz9Os52p1qygUKQm7QsvPDeqMT16UNqkJaa8IyZAtLnv3ZFTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=harmstone.com; spf=pass smtp.mailfrom=harmstone.com; dkim=pass (1024-bit key) header.d=harmstone.com header.i=@harmstone.com header.b=Jc4MqWW1; arc=none smtp.client-ip=217.169.27.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=harmstone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=harmstone.com
Received: from [IPV6:2a02:8012:8cf0:0:ce28:aaff:fe0d:6db2] (beren.burntcomma.com [IPv6:2a02:8012:8cf0:0:ce28:aaff:fe0d:6db2])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256
	 client-signature RSA-PSS (2048 bits) client-digest SHA256)
	(Client CN "hellas", Issuer "burntcomma.com" (verified OK))
	by mail.burntcomma.com (Postfix) with ESMTPS id B0B043037A5;
	Wed, 18 Feb 2026 14:29:05 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=harmstone.com;
	s=mail; t=1771424945;
	bh=e9Qr9H2LdzQGrrTGhzafTCgFnIjxvxYrFPmR62Kclik=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=Jc4MqWW12Ez8N7Z7+HCtjxYscc3m28gH5LHM3VEzGBfukfiCN7VjUiEW0NaSMvjp0
	 TpbIoO5zhBhAYxW8djt79ZITCkgiZrlnYJOapmR6XYaN/pzuzXwAbazrZ+Kjrv0ffP
	 sNFc0RoielcosC8+YYJ2bN7/RoLPTysDgB1ZyrT0=
Message-ID: <8369b0f4-f7b7-40ad-8a72-4d7fafd88a84@harmstone.com>
Date: Wed, 18 Feb 2026 14:29:05 +0000
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Subject: Re: [PATCH v8 09/17] btrfs: redirect I/O for remapped block groups
To: Chris Mason <clm@meta.com>
Cc: linux-btrfs@vger.kernel.org, Boris Burkov <boris@bur.io>
References: <20260107141015.25819-1-mark@harmstone.com>
 <20260107141015.25819-10-mark@harmstone.com>
 <20260125125830.2352988-1-clm@meta.com>
Content-Language: en-US
From: Mark Harmstone <mark@harmstone.com>
Autocrypt: addr=mark@harmstone.com; keydata=
 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
In-Reply-To: <20260125125830.2352988-1-clm@meta.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[harmstone.com,none];
	R_DKIM_ALLOW(-0.20)[harmstone.com:s=mail];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21755-lists,linux-btrfs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mark@harmstone.com,linux-btrfs@vger.kernel.org];
	DKIM_TRACE(0.00)[harmstone.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-btrfs];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[harmstone.com:mid,harmstone.com:dkim,harmstone.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 48D73157109
X-Rspamd-Action: no action

Claude's right, and I made this mistake because I was copying the 
"return -EINVAL" a few lines lower down, which also leaks. I'll patch 
them both.

On 25/01/2026 12.57 pm, Chris Mason wrote:
> Mark Harmstone <mark@harmstone.com> wrote:
>> Change btrfs_map_block() so that if the block group has the REMAPPED
>> flag set, we call btrfs_translate_remap() to obtain a new address.
>>
>> btrfs_translate_remap() searches the remap tree for a range
>> corresponding to the logical address passed to btrfs_map_block(). If it
>> is within an identity remap, this part of the block group hasn't yet
>> been relocated, and so we use the existing address.
>>
>> If it is within an actual remap, we subtract the start of the remap
>> range and add the address of its destination, contained in the item's
>> payload.
>>
> 
> Hi everyone,
> 
> Another AI review from linux-next runs:
> 
>> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
>> --- a/fs/btrfs/volumes.c
>> +++ b/fs/btrfs/volumes.c
>> @@ -6586,6 +6586,24 @@ struct btrfs_io_geometry io_geom = { 0 };
>> 	if (IS_ERR(map))
>> 		return PTR_ERR(map);
>>
>> +	if (map->type & BTRFS_BLOCK_GROUP_REMAPPED) {
>> +		u64 new_logical = logical;
>> +
>> +		ret = btrfs_translate_remap(fs_info, &new_logical, length);
>> +		if (ret)
>> +			return ret;
>                          ^^^^^^^^^^
> 
> When btrfs_translate_remap() returns an error, does this leak the chunk
> map? The map was obtained via btrfs_get_chunk_map() which increments a
> refcount, and btrfs_get_chunk_map() documents that callers are
> responsible for dropping the reference. The other error paths in this
> function use goto out, which calls btrfs_free_chunk_map(map).
> 
>> +
>> +		if (new_logical != logical) {
>> +			btrfs_free_chunk_map(map);
>> +
>> +			map = btrfs_get_chunk_map(fs_info, new_logical, *length);
>> +			if (IS_ERR(map))
>> +				return PTR_ERR(map);
>> +
>> +			logical = new_logical;
>> +		}
>> +	}
> 
> [ ... ]


