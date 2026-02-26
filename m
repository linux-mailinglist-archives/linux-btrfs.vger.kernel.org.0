Return-Path: <linux-btrfs+bounces-22035-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EC/ZKCrToGmrnAQAu9opvQ
	(envelope-from <linux-btrfs+bounces-22035-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Feb 2026 00:11:38 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 034BD1B0CBA
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Feb 2026 00:11:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 64F77302F9A8
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Feb 2026 23:10:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECE954418E9;
	Thu, 26 Feb 2026 23:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="UouvcX6p"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE0B0187FE4
	for <linux-btrfs@vger.kernel.org>; Thu, 26 Feb 2026 23:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772147451; cv=none; b=gff993ESIsNN4ekHwNC7X9pgLvhiUoz9slJD0Evg3tFezYquSiACmPR3ZYQcRy+/tEIZj4d1dKQsdDKygfbGdt/Dp52/6mBlsZjASUqvGyXJCxW/su+b0T0YC7CT6pBm/vQO+YbbSt9JU1Ef8MJiq1ty6CJgyRt9qpPWpsuVVGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772147451; c=relaxed/simple;
	bh=dZVAXrv2bUoc617OMbkddo8WvV+0f9sNegwO+ZBT0/c=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=BHNx9iUtQ5WjCYioQKT9CgGe6V8ZcmWl9XicTliLCohRoIxpxaO2U/SUHvupQDkY6mWB/OPwh+qcB0Vt07ZSPgFkAO1ANMrQG8vcYPWZBSX8RFdG7fYDGu/vuwQ6S93tEWvnbt3LIdIKFAC7BuQ5agbbV49sWo9lNJe8XCk+Vrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=UouvcX6p; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4836d4c26d3so9538905e9.2
        for <linux-btrfs@vger.kernel.org>; Thu, 26 Feb 2026 15:10:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1772147448; x=1772752248; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=pmZo1YbynEqSRLLgOxpQu8LSLmtyre2cWq9MoxNlQ04=;
        b=UouvcX6pj4/iohLkTec2s6k/k223+mb2X2dZ+W+cZdeeKOZ6/K5EhUNbM+X9RGoYv2
         SeUzUP8rgd88/mk+xwZkX5y9E/47mHboC5X4k01kfrQ2g0Q3/YmnchP9R3p9F7rQsDBU
         qMv9DKP8viESPC/Grfa5ntkFycgGng5fhfBgBXqk8kJE4lAelcnvlrTdjWSLw7gT5ZkB
         rMJQ8OjRKOPO9KjENU3QjeBUZ6HZxt8Uo0eOP9In2MMXSNs9Ya7QJZyFD4bk1FJDoD4T
         2nf2Oi6j9iSzbrQDpqq9a25NtOCNMgEcNqdX0NGgYGeomyrZ/qLow4YdKmT/0AySJL1i
         4n+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772147448; x=1772752248;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pmZo1YbynEqSRLLgOxpQu8LSLmtyre2cWq9MoxNlQ04=;
        b=MNql47Ps1erdCy/ZS3Jj8cSCU+50m3iasqWs8Sv/Omv4gsDz+ObFtmQsC0qeYkuKEs
         Q8p8p4RtqapnwUYyvCJQQLGzfvdRDWwR2Xwnu8dxDgdson75nGU3pZYgPCq4KJN2Bm2V
         D/LOfffkyJ5pGmQ9ltnxeKV5VCvp+Z1A6KY9F7Ou1188iH+7ZYxtLHHotoW+GxhzT2wS
         V5JTLbylZxm+qOL3Ax5+3QT8Uuaovbi7V7t8ThZEGUb2vEzK8EjTopcywjl+rPOYrrNM
         nL8bg+HTWDCHZpIjnRHVSTW/gXxX+Kx8fgnc9i+YOT4L0WmgPz0UDUyk+TYjRy+jkMwv
         BIqA==
X-Forwarded-Encrypted: i=1; AJvYcCVbbAqqfPekhwwHd4HPHyawVPz2OmkgmIbCpbcrkVp5RlOv43Co7AQRSJ5V2H1HM03ZUr9tw+FRiZFKNQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzALnJB1ZC/uqTXgcQwekavEAO4GvDbp009rmJIIjnAOt4mgJbV
	gjpnuaEX2l+DWuoJOGgMivFL/AyrPXEdcIMbFvz6MYFUk5bY5PcEs0iDXnYrFdObn6A=
X-Gm-Gg: ATEYQzzGdRFNbiUb5jkhvWmH5UPeQl7UAWzluptUPBbz9HgDqbpjX0hBJe+hpa0j2Th
	bL05B+i6hq8UWYM9T0i4JONcZYvwiQy5wseqQImrFzW2GIjKhx8rFm136wFLoX1s5NemS1aJpw4
	atG43Op2fUOHeedscNh74qkldDYt32B94dQQ6TxVHQJZkhGbQEllu56wGgtc/8L89crQweCFToQ
	n+KHbwaqRdXihVUwQ5OcKzOMfI0p/7/qWCkhiKqZBHcCguTQFG84Z43sevMUylq/x7ZlfXX87pz
	u7W9AQassKoxwf2JitgENrhP/ycmDP2EPvHmdFGQYpy1TDDcykce9fsOESnCnwGYqij+o3abP5I
	sQu08ymsyqp8+aJE0b4CDm9MK5j7N0ig2Zlfa08AXQ1MJoURauUKbP8OEfx4nmqxljh61K7p8Sa
	mTK3I8Hp/H6C1gBGbiRzXZVZ0ltAnF7ZXfrdYkXs0iNcYHnkB9zyjhybI5vF4aIw==
X-Received: by 2002:a05:600c:828c:b0:483:3380:ca0c with SMTP id 5b1f17b1804b1-483c9c24748mr9037455e9.35.1772147448161;
        Thu, 26 Feb 2026 15:10:48 -0800 (PST)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2adfb5dc944sm40874165ad.39.2026.02.26.15.10.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Feb 2026 15:10:47 -0800 (PST)
Message-ID: <af7f84f6-fea8-462f-bb04-118bab556369@suse.com>
Date: Fri, 27 Feb 2026 09:40:43 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] btrfs: fix exploits that allow malicious users to
 turn fs into RO mode
To: fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <cover.1772105193.git.fdmanana@suse.com>
Content-Language: en-US
From: Qu Wenruo <wqu@suse.com>
Autocrypt: addr=wqu@suse.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNGFF1IFdlbnJ1byA8d3F1QHN1c2UuY29tPsLAlAQTAQgAPgIbAwULCQgHAgYVCAkKCwIE
 FgIDAQIeAQIXgBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJnEXVgBQkQ/lqxAAoJEMI9kfOh
 Jf6o+jIH/2KhFmyOw4XWAYbnnijuYqb/obGae8HhcJO2KIGcxbsinK+KQFTSZnkFxnbsQ+VY
 fvtWBHGt8WfHcNmfjdejmy9si2jyy8smQV2jiB60a8iqQXGmsrkuR+AM2V360oEbMF3gVvim
 2VSX2IiW9KERuhifjseNV1HLk0SHw5NnXiWh1THTqtvFFY+CwnLN2GqiMaSLF6gATW05/sEd
 V17MdI1z4+WSk7D57FlLjp50F3ow2WJtXwG8yG8d6S40dytZpH9iFuk12Sbg7lrtQxPPOIEU
 rpmZLfCNJJoZj603613w/M8EiZw6MohzikTWcFc55RLYJPBWQ+9puZtx1DopW2jOwE0EWdWB
 rwEIAKpT62HgSzL9zwGe+WIUCMB+nOEjXAfvoUPUwk+YCEDcOdfkkM5FyBoJs8TCEuPXGXBO
 Cl5P5B8OYYnkHkGWutAVlUTV8KESOIm/KJIA7jJA+Ss9VhMjtePfgWexw+P8itFRSRrrwyUf
 E+0WcAevblUi45LjWWZgpg3A80tHP0iToOZ5MbdYk7YFBE29cDSleskfV80ZKxFv6koQocq0
 vXzTfHvXNDELAuH7Ms/WJcdUzmPyBf3Oq6mKBBH8J6XZc9LjjNZwNbyvsHSrV5bgmu/THX2n
 g/3be+iqf6OggCiy3I1NSMJ5KtR0q2H2Nx2Vqb1fYPOID8McMV9Ll6rh8S8AEQEAAcLAfAQY
 AQgAJgIbDBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJnEXWBBQkQ/lrSAAoJEMI9kfOhJf6o
 cakH+QHwDszsoYvmrNq36MFGgvAHRjdlrHRBa4A1V1kzd4kOUokongcrOOgHY9yfglcvZqlJ
 qfa4l+1oxs1BvCi29psteQTtw+memmcGruKi+YHD7793zNCMtAtYidDmQ2pWaLfqSaryjlzR
 /3tBWMyvIeWZKURnZbBzWRREB7iWxEbZ014B3gICqZPDRwwitHpH8Om3eZr7ygZck6bBa4MU
 o1XgbZcspyCGqu1xF/bMAY2iCDcq6ULKQceuKkbeQ8qxvt9hVxJC2W3lHq8dlK1pkHPDg9wO
 JoAXek8MF37R8gpLoGWl41FIUb3hFiu3zhDDvslYM4BmzI18QgQTQnotJH8=
In-Reply-To: <cover.1772105193.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22035-lists,linux-btrfs=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wqu@suse.com,linux-btrfs@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.com:mid,suse.com:dkim,suse.com:email]
X-Rspamd-Queue-Id: 034BD1B0CBA
X-Rspamd-Action: no action



在 2026/2/27 01:03, fdmanana@kernel.org 写道:
> From: Filipe Manana <fdmanana@suse.com>
> 
> We have a couple scenarios that regular users can exploit to trigger a
> transaction abort and turn a filesystem into RO mode, causing some
> disruption. The first 2 patches fix these, the remainder are just a few
> trivial and cleanups.
> 

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

> Filipe Manana (5):
>    btrfs: fix transaction abort on file creation due to name hash collision
>    btrfs: fix transaction abort when snapshotting received subvolumes
>    btrfs: stop checking for -EEXIST return value from btrfs_uuid_tree_add()
>    btrfs: remove duplicated uuid tree existence check in btrfs_uuid_tree_add()
>    btrfs: remove pointless error check in btrfs_check_dir_item_collision()
> 
>   fs/btrfs/dir-item.c    |  4 +---
>   fs/btrfs/inode.c       | 19 +++++++++++++++++++
>   fs/btrfs/ioctl.c       |  2 +-
>   fs/btrfs/transaction.c | 18 +++++++++++++++++-
>   fs/btrfs/uuid-tree.c   |  5 +----
>   5 files changed, 39 insertions(+), 9 deletions(-)
> 


