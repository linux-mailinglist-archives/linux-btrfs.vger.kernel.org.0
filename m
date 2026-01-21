Return-Path: <linux-btrfs+bounces-20796-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cEfZGadYcGlvXQAAu9opvQ
	(envelope-from <linux-btrfs+bounces-20796-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Jan 2026 05:40:07 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 198D8511D7
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Jan 2026 05:40:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 98C6C4E4894
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Jan 2026 04:40:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1B4D3C1FCC;
	Wed, 21 Jan 2026 04:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="JCR13RrM"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B30713C1981
	for <linux-btrfs@vger.kernel.org>; Wed, 21 Jan 2026 04:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768970396; cv=none; b=dKZZCxYM0fZncPIk/3gHwHOd5eaL8kuMe0DvaR5CDLpPii++3LHCf3qvp4WoEKMQ7T95MZ2vLEhAX1ZNz2xw5X9oLdTdYC5/JEUtyZKr7SXH0QOxXEZy8YuH8NBEeQFGEGtDmynSdA2fVgP/t0khL0dbUMd6pZxBHbMiLiorZMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768970396; c=relaxed/simple;
	bh=MplfbfFNDs4CfOzJeHkau7pFZKQBvSfZ6/52hz2xS4E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UvUFvY5FgguA3uAB9CrNZCH1jpjbCNX0vvLTZctbY6/+7wUnEanG+n58GuuXZ7pnqJgDtTq6igJBcqEFU7o621E1PQ5OYofTqfiRdEO+cU6x/2vP+DaMAultAB6E3Bm2Ufh4QIrYj8C15ES6x/ojUEUtGdDqifL/exHQoqtYcOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=JCR13RrM; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1768970391; x=1769575191; i=quwenruo.btrfs@gmx.com;
	bh=YiAxHAPuqK0WCfXoMYfIphtytEZThws0R7YQmheThgc=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=JCR13RrMbVS255j0v6DppCkgTECE01JYT4CgklTFeG1yQudpQth70nttdFjyhpM5
	 8jhAnUTRdQCn3Z5AjknGUrmPFkgKjfVxMe8bQ7Hf28gd67ZMdZHHUee6MymrjGA3Y
	 5sCUClI8Y13S1GMPNV/SSLI1QkpMfH6umtsAZZJwl1HadGkPM7R+CQRxtBBEVjR9M
	 kn1hb8+gi1vcfUkhi2YmRfdZ/PFnr60EsEqRN5u12QSd+kKUCfGkUg2mIHbSh8I+w
	 //DWPwTpHgHw6J7zpwn1LPPoEAbCAFuatrx3zWN/ZpCHjn8EWTRWw/12tLopOLDR3
	 x30owCg66QKcpfLujQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MXp5Q-1vGrfu1Qfk-00WQo9; Wed, 21
 Jan 2026 05:39:51 +0100
Message-ID: <b1f7072a-57de-4df5-abcf-a9e975e5c58f@gmx.com>
Date: Wed, 21 Jan 2026 15:09:44 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] btrfs: allocate path in load_block_group_size_class()
To: dsterba@suse.cz
Cc: fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <cover.1768911827.git.fdmanana@suse.com>
 <05452a804b036b205a791be1c1c5e09d0279812d.1768911827.git.fdmanana@suse.com>
 <3a5d1472-7ff0-447f-9d02-f75a60161ead@gmx.com>
 <20260121042455.GO26902@twin.jikos.cz>
Content-Language: en-US
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
Autocrypt: addr=quwenruo.btrfs@gmx.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNIlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT7CwJQEEwEIAD4CGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCZxF1YAUJEP5a
 sQAKCRDCPZHzoSX+qF+mB/9gXu9C3BV0omDZBDWevJHxpWpOwQ8DxZEbk9b9LcrQlWdhFhyn
 xi+l5lRziV9ZGyYXp7N35a9t7GQJndMCFUWYoEa+1NCuxDs6bslfrCaGEGG/+wd6oIPb85xo
 naxnQ+SQtYLUFbU77WkUPaaIU8hH2BAfn9ZSDX9lIxheQE8ZYGGmo4wYpnN7/hSXALD7+oun
 tZljjGNT1o+/B8WVZtw/YZuCuHgZeaFdhcV2jsz7+iGb+LsqzHuznrXqbyUQgQT9kn8ZYFNW
 7tf+LNxXuwedzRag4fxtR+5GVvJ41Oh/eygp8VqiMAtnFYaSlb9sjia1Mh+m+OBFeuXjgGlG
 VvQFzsBNBFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcga
 CbPEwhLj1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj
 /IrRUUka68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fN
 GSsRb+pKEKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0
 q1eW4Jrv0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEv
 ABEBAAHCwHwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCZxF1gQUJEP5a0gAK
 CRDCPZHzoSX+qHGpB/kB8A7M7KGL5qzat+jBRoLwB0Y3Zax0QWuANVdZM3eJDlKJKJ4HKzjo
 B2Pcn4JXL2apSan2uJftaMbNQbwotvabLXkE7cPpnppnBq7iovmBw++/d8zQjLQLWInQ5kNq
 Vmi36kmq8o5c0f97QVjMryHlmSlEZ2Wwc1kURAe4lsRG2dNeAd4CAqmTw0cMIrR6R/Dpt3ma
 +8oGXJOmwWuDFKNV4G2XLKcghqrtcRf2zAGNogg3KulCykHHripG3kPKsb7fYVcSQtlt5R6v
 HZStaZBzw4PcDiaAF3pPDBd+0fIKS6BlpeNRSFG94RYrt84Qw77JWDOAZsyNfEIEE0J6LSR/
In-Reply-To: <20260121042455.GO26902@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:9o241XQj1Q8+B8myZ3fN2+94LQvvV6NcagWCmUqmZdFnvJgKgZA
 NFv3wjQkOex0x0WQXCt7GbrHcl/5oFV5H76QNAhO0Mi7vcd5V7O4A8Wn6bfqmJdqr+vGWjg
 A5Vk00CMM0WZIjkMJYSMEic6vI4XzYOC01haVtszSWBDEEWXEtwvW91A5xzG0txQ9fkoOlM
 Iojy2nOnnNK7w4zH9dfMg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:mLtYFJe8IRY=;Xz+pMEPoPMRah0gCQpnQfZlxUbO
 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
X-Spamd-Result: default: False [-1.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[gmx.com:s=s31663417];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[gmx.com,quarantine];
	TAGGED_FROM(0.00)[bounces-20796-lists,linux-btrfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmx.com:+];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	FREEMAIL_FROM(0.00)[gmx.com];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[quwenruo.btrfs@gmx.com,linux-btrfs@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,gmx.com:mid,gmx.com:dkim,dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: 198D8511D7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



=E5=9C=A8 2026/1/21 14:54, David Sterba =E5=86=99=E9=81=93:
> On Wed, Jan 21, 2026 at 07:16:06AM +1030, Qu Wenruo wrote:
>> =E5=9C=A8 2026/1/20 22:55, fdmanana@kernel.org =E5=86=99=E9=81=93:
>>> From: Filipe Manana <fdmanana@suse.com>
>>>
>>> Instead of allocating and freeing a path in every iteration of
>>> load_block_group_size_class(), through its helper function
>>> sample_block_group_extent_item(), allocate the path in the former and
>>> pass it to the later.
>>>
>>> Signed-off-by: Filipe Manana <fdmanana@suse.com>
>>> ---
>>>    fs/btrfs/block-group.c | 32 +++++++++++++++++---------------
>>>    1 file changed, 17 insertions(+), 15 deletions(-)
>>>
>>> diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
>>> index 343c29344484..a7828673be39 100644
>>> --- a/fs/btrfs/block-group.c
>>> +++ b/fs/btrfs/block-group.c
>>> @@ -579,24 +579,24 @@ int btrfs_add_new_free_space(struct btrfs_block_=
group *block_group, u64 start,
>>>     * @index:        the integral step through the block group to grab=
 from
>>>     * @max_index:    the granularity of the sampling
>>>     * @key:          return value parameter for the item we find
>>> + * @path:         path to use for searching in the extent tree
>>>     *
>>>     * Pre-conditions on indices:
>>>     * 0 <=3D index <=3D max_index
>>>     * 0 < max_index
>>>     *
>>> - * Returns: 0 on success, 1 if the search didn't yield a useful item,=
 negative
>>> - * error code on error.
>>> + * Returns: 0 on success, 1 if the search didn't yield a useful item.
>>>     */
>>>    static int sample_block_group_extent_item(struct btrfs_caching_cont=
rol *caching_ctl,
>>>    					  struct btrfs_block_group *block_group,
>>>    					  int index, int max_index,
>>> -					  struct btrfs_key *found_key)
>>> +					  struct btrfs_key *found_key,
>>> +					  struct btrfs_path *path)
>>>    {
>>>    	struct btrfs_fs_info *fs_info =3D block_group->fs_info;
>>>    	struct btrfs_root *extent_root;
>>>    	u64 search_offset;
>>>    	const u64 search_end =3D btrfs_block_group_end(block_group);
>>> -	BTRFS_PATH_AUTO_FREE(path);
>>>    	struct btrfs_key search_key;
>>>    	int ret =3D 0;
>>>   =20
>>> @@ -606,17 +606,9 @@ static int sample_block_group_extent_item(struct =
btrfs_caching_control *caching_
>>>    	lockdep_assert_held(&caching_ctl->mutex);
>>>    	lockdep_assert_held_read(&fs_info->commit_root_sem);
>>>   =20
>>> -	path =3D btrfs_alloc_path();
>>> -	if (!path)
>>> -		return -ENOMEM;
>>> -
>>>    	extent_root =3D btrfs_extent_root(fs_info, max_t(u64, block_group-=
>start,
>>>    						       BTRFS_SUPER_INFO_OFFSET));
>>>   =20
>>> -	path->skip_locking =3D true;
>>> -	path->search_commit_root =3D true;
>>> -	path->reada =3D READA_FORWARD;
>>> -
>>>    	search_offset =3D index * div_u64(block_group->length, max_index);
>>>    	search_key.objectid =3D block_group->start + search_offset;
>>>    	search_key.type =3D BTRFS_EXTENT_ITEM_KEY;
>>> @@ -679,6 +671,7 @@ static int sample_block_group_extent_item(struct b=
trfs_caching_control *caching_
>>>    static void load_block_group_size_class(struct btrfs_caching_contro=
l *caching_ctl,
>>>    					struct btrfs_block_group *block_group)
>>>    {
>>> +	BTRFS_PATH_AUTO_FREE(path);
>>>    	struct btrfs_fs_info *fs_info =3D block_group->fs_info;
>>>    	struct btrfs_key key;
>>>    	int i;
>>> @@ -688,14 +681,23 @@ static void load_block_group_size_class(struct b=
trfs_caching_control *caching_ct
>>>    	if (!btrfs_block_group_should_use_size_class(block_group))
>>>    		return;
>>>   =20
>>> +	path =3D btrfs_alloc_path();
>>> +	if (!path)
>>> +		return;
>>
>> Considering the function is only called inside a workqueue, we can avoi=
d
>> a memory allocation by using on-stack path, which also reduces one erro=
r
>> path.
>=20
> As a generic pattern we could switch to on-stack variables for the
> functions called from workqueues but it may not be obvious that it's OK
> to do that (unlike eg. the compression functions).
>=20
> But I'd like to have an assertion or a debug warning for that, not sure
> how exactly to do it, maybe something is in the task_struct.
>=20

I was looking into that during async csum development. But I didn't find=
=20
a good way to determine if we're in workqueue.
The closest one I found is in_task(), which can not distinguish=20
workqueue and regular userspace falling into kernel situations.

Maybe there are some way to poking into the current task structure, but=20
I didn't find a straightforward helper.

Thanks,
Qu


