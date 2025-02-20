Return-Path: <linux-btrfs+bounces-11605-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B14D9A3D20C
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Feb 2025 08:21:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C795189BC14
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Feb 2025 07:21:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBDAF1E5B9F;
	Thu, 20 Feb 2025 07:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="OC/HkBxV"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-30.smtpout.orange.fr [80.12.242.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A357F339A8;
	Thu, 20 Feb 2025 07:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740036045; cv=none; b=ZIxacW2O6MAD9tQy8NcEjGO6zGkJLhoqIRlzZgu4W6W939M6Cp1jwcBX3VmyjOVLOPDNksw79IPZGaAgXaz8pUqHQ4Hwsnx8b0/g3XMmrfjRs0K82Ft794ejkBwNhf0NCZIx7/6qNOW14xBscrbLyyKp7nOrBcbh+rVFxY6tsdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740036045; c=relaxed/simple;
	bh=6/f8W238BNZamCUmwGGc0unXgt1zsGiS4dRwpAbVjEM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GePJdTXTzRLBpbdBjhN9k48r3+yNH/1WCqVAfX1RQVQp+vdlCHaIGM8/yyncCOMgbUjV/iDUEs1fzYNBdrHOzhN5J431nYH2XojTIY9J5xE7+bi8l+2bVX4UHSk52OFwAKw8KpqbapQpZgAs/yuEc/4JCw4b6iwG8MUkipWYOow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=OC/HkBxV; arc=none smtp.client-ip=80.12.242.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.37] ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id l0iotu6FD5obUl0istOkR1; Thu, 20 Feb 2025 08:11:50 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1740035510;
	bh=OqTdwTr1/cWlHB1WJoanOZERiAU7KnG/HsvdWmyLIeI=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=OC/HkBxVmMAMd7krYxc7PX+WAz01oESrabJBgQgtnL8RPFqj3JsQJHVeqCJECBq5P
	 A7AK+SngG2sESDLv+oB/0WPkucICG0NtaicdoqpeVm3aM+D9ZM0QniMyL5V2b+3H8g
	 tMPPGVvdOX4Owr5NqmJrdPexEKh3S/22nVXDq7Kr66PmHsgVs+ep9YvyxiQNLZxuqa
	 3lyGU+kLmSY2ii+vccwOtteOXpwYYl7UG30KGhv1GeIK1IDNftWaHY63Jj0q766TVs
	 I2+YoGpYO1vXC4AjH9W/ANEpQyp7Pk7v9ANYrtb73jXxwAXt4mjD3R7TwWG2l/VSDX
	 hYaLfAaoPa+BQ==
X-ME-Helo: [192.168.1.37]
X-ME-Auth: bWFyaW9uLmphaWxsZXRAd2FuYWRvby5mcg==
X-ME-Date: Thu, 20 Feb 2025 08:11:50 +0100
X-ME-IP: 90.11.132.44
Message-ID: <4cbdb517-2d4b-4f73-9822-a9c4ec794b54@wanadoo.fr>
Date: Thu, 20 Feb 2025 08:11:46 +0100
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: zoned: Remove some code duplication
To: Naohiro Aota <Naohiro.Aota@wdc.com>, Chris Mason <clm@fb.com>,
 Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
 "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <74072f83285f96aba98add7d24c9f944d22a721b.1739974151.git.christophe.jaillet@wanadoo.fr>
 <D7X1HAEVN3TO.Z7JG9SRUODCE@wdc.com>
Content-Language: en-US, fr-FR
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <D7X1HAEVN3TO.Z7JG9SRUODCE@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 20/02/2025 à 06:55, Naohiro Aota a écrit :
> On Wed Feb 19, 2025 at 11:10 PM JST, Christophe JAILLET wrote:
>> This code snippet is written twice in row, so remove one of them.
>>
>> This was apparently added by accident in commit efe28fcf2e47 ("btrfs:
>> handle unexpected parent block offset in btrfs_alloc_tree_block()")
>>
>> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>> ---
>>   fs/btrfs/zoned.c | 9 ---------
>>   1 file changed, 9 deletions(-)
>>
>> diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
>> index b5b9d16664a8..6c4534316aad 100644
>> --- a/fs/btrfs/zoned.c
>> +++ b/fs/btrfs/zoned.c
>> @@ -1663,15 +1663,6 @@ int btrfs_load_block_group_zone_info(struct btrfs_block_group *cache, bool new)
>>   	}
>>   
>>   out:
>> -	/* Reject non SINGLE data profiles without RST */
>> -	if ((map->type & BTRFS_BLOCK_GROUP_DATA) &&
>> -	    (map->type & BTRFS_BLOCK_GROUP_PROFILE_MASK) &&
>> -	    !fs_info->stripe_root) {
>> -		btrfs_err(fs_info, "zoned: data %s needs raid-stripe-tree",
>> -			  btrfs_bg_type_to_raid_name(map->type));
>> -		return -EINVAL;
>> -	}
>> -
>>   	/* Reject non SINGLE data profiles without RST. */
>>   	if ((map->type & BTRFS_BLOCK_GROUP_DATA) &&
>>   	    (map->type & BTRFS_BLOCK_GROUP_PROFILE_MASK) &&
> 
> Thanks, but which repository/branch are you working with? I cannot
> find the duplicated lines in btrfs/for-next, linus/master, nor
> linux-stable. Also, the pointed commit seems wrong too.

Sorry for the lack of context.

This is based on linux-next. In my case -next-20250219

This can be seen at :
  
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/fs/btrfs/zoned.c?id=efe28fcf2e47aa5142bff2c284ea7337b40901e8#n1666

The commit Id is the one given at :
  
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/fs/btrfs/zoned.c?id=efe28fcf2e47aa5142bff2c284ea7337b40901e8


CJ

