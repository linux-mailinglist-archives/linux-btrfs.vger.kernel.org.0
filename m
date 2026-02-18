Return-Path: <linux-btrfs+bounces-21762-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YJ8CIfPglWk4VwIAu9opvQ
	(envelope-from <linux-btrfs+bounces-21762-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Feb 2026 16:55:31 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A1F14157848
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Feb 2026 16:55:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 30EE33005308
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Feb 2026 15:55:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2994A343D66;
	Wed, 18 Feb 2026 15:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=harmstone.com header.i=@harmstone.com header.b="vDWdy1hD"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail.burntcomma.com (mail2.burntcomma.com [217.169.27.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C07E3342503
	for <linux-btrfs@vger.kernel.org>; Wed, 18 Feb 2026 15:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.169.27.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771430126; cv=none; b=nRNgpi79spurh3GWayQG0jcRXvxC+sNBbe5bK6AiBdPmIfqm2Knd/KCrZmRANMvVjP0m0+41Bjc49W7a65Ylyza8VmRjXm3RRI9XK8er+Artz1lx0EAyZSNrf2Pjb0iaoKN2fJ5jgYiY/4Df3pf89OuGLc8tY9UbMqvb4JEPDQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771430126; c=relaxed/simple;
	bh=I1it41f4+Jw9ou1GGOSrdrRftUmVt0NR6Fq12+gy80g=;
	h=Message-ID:Date:Mime-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dUZ/qR8PB/f/K6y4FYZ3hgs0pCvMVSBkI2pjbo+l6rCWTe+fadkgi7D6BUdFF3qwmZd2O7pQGK2s/jyI2koQIz5DnJ23hMzyH++Xci5jaWzCkQeNp0hFGG6RX/2JngtOJGYfD07W4KJ00Bl1hWUqbLUjw8pv1Pr9T+GLKYBrtcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=harmstone.com; spf=pass smtp.mailfrom=harmstone.com; dkim=pass (1024-bit key) header.d=harmstone.com header.i=@harmstone.com header.b=vDWdy1hD; arc=none smtp.client-ip=217.169.27.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=harmstone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=harmstone.com
Received: from [IPV6:2a02:8012:8cf0:0:ce28:aaff:fe0d:6db2] (beren.burntcomma.com [IPv6:2a02:8012:8cf0:0:ce28:aaff:fe0d:6db2])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256
	 client-signature RSA-PSS (2048 bits) client-digest SHA256)
	(Client CN "hellas", Issuer "burntcomma.com" (verified OK))
	by mail.burntcomma.com (Postfix) with ESMTPS id DCDE730383F;
	Wed, 18 Feb 2026 15:55:19 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=harmstone.com;
	s=mail; t=1771430119;
	bh=a5BMWqt3E+L/WJYGqbeWWJp8qzVxdmkjvGl/3xoYxKw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=vDWdy1hDLbi054Rd+cylqXG9vyL2aub+VWLXeQxcXFC1RzJr3iwrxpFoDlC2i++Gp
	 Y+dDaYJs/fwGLg2IZtG/+yzjzjRLtQtWkr9eHNesn0Qwt5GIJaM8i+Ci5NQRwvcazA
	 L+iuEjq2Bso+J9q/he4kfpYuS96v5HCzc34TQ/qk=
Message-ID: <408293e5-75f8-461b-9d0e-65ff95027a0b@harmstone.com>
Date: Wed, 18 Feb 2026 15:55:19 +0000
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Subject: Re: [PATCH] btrfs: fix chunk map leaks in btrfs_map_block()
To: Filipe Manana <fdmanana@kernel.org>
Cc: linux-btrfs@vger.kernel.org, Chris Mason <clm@fb.com>
References: <20260218143334.25014-1-mark@harmstone.com>
 <CAL3q7H4nVSx-cVS03APKyhus_wx+QcFdP_67WrV8gTnP6ApFNw@mail.gmail.com>
Content-Language: en-US
From: Mark Harmstone <mark@harmstone.com>
Autocrypt: addr=mark@harmstone.com; keydata=
 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
In-Reply-To: <CAL3q7H4nVSx-cVS03APKyhus_wx+QcFdP_67WrV8gTnP6ApFNw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[harmstone.com,none];
	R_DKIM_ALLOW(-0.20)[harmstone.com:s=mail];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21762-lists,linux-btrfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-btrfs];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A1F14157848
X-Rspamd-Action: no action

On 18/02/2026 2.54 pm, Filipe Manana wrote:
> On Wed, Feb 18, 2026 at 2:33 PM Mark Harmstone <mark@harmstone.com> wrote:
>>
>> Fix the two early returns in btrfs_map_block() so that we can no longer
>> fail to put the chunk map after getting it.
>>
>> Signed-off-by: Mark Harmstone <mark@harmstone.com>
>> Reported-by: Chris Mason <clm@fb.com>
> 
> So being a bug fix, this is the type of patch that should have a Fixes tag.
> 
> The commit that introduced the first leak is not in any released
> kernel, so no stable releases are affected.
> However it's still useful to have the Fixes tag here, because in case
> someone decides to backport the offending commit, either upstream or
> downstream, there are scripts in place to check if there are newer
> commits that fix a bug in the former commit and therefore must be
> backported as well.
> 
> But the second leak was introduced in a much older commit, from 2024,
> and should be backported.
> Se comments inline below.
> 
> Also, since this was reported publicly, please add a Link tag pointing
> to the URL with the review.
> 
>> ---
>>   fs/btrfs/volumes.c | 8 +++++---
>>   1 file changed, 5 insertions(+), 3 deletions(-)
>>
>> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
>> index 83e2834ea273..a1f0fccd552c 100644
>> --- a/fs/btrfs/volumes.c
>> +++ b/fs/btrfs/volumes.c
>> @@ -7082,7 +7082,7 @@ int btrfs_map_block(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
>>
>>                  ret = btrfs_translate_remap(fs_info, &new_logical, length);
>>                  if (ret)
>> -                       return ret;
>> +                       goto out;
> 
> For this hunk:
> 
> Fixes: 18ba64992871 ("btrfs: redirect I/O for remapped block groups")
> 
>>
>>                  if (new_logical != logical) {
>>                          btrfs_free_chunk_map(map);
>> @@ -7096,8 +7096,10 @@ int btrfs_map_block(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
>>          }
>>
>>          num_copies = btrfs_chunk_map_num_copies(map);
>> -       if (io_geom.mirror_num > num_copies)
>> -               return -EINVAL;
>> +       if (io_geom.mirror_num > num_copies) {
>> +               ret = -EINVAL;
>> +               goto out;
>> +       }
> 
> For this hunk:
> 
> Fixes: 0ae653fbec2b ("btrfs: reduce chunk_map lookups in btrfs_map_block()")
> 
> I would suggest splitting this into 2 different patches, each one with
> the respective Fixes tag so that the second leak can be backported
> more easily.

Thanks Filipe, I'll do just that. Please ignore this one.

> 
>>
>>          map_offset = logical - map->start;
>>          io_geom.raid56_full_stripe_start = (u64)-1;
>> --
>> 2.52.0
>>
>>


