Return-Path: <linux-btrfs+bounces-20783-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ED7aHRH+b2mUUgAAu9opvQ
	(envelope-from <linux-btrfs+bounces-20783-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 Jan 2026 23:13:37 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E52354CD0A
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 Jan 2026 23:13:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 21FF7629267
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 Jan 2026 20:55:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1D9433971F;
	Tue, 20 Jan 2026 20:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="kacdOBF+"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EC543A9005
	for <linux-btrfs@vger.kernel.org>; Tue, 20 Jan 2026 20:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768941980; cv=none; b=Cw7S0lkHXVNT8h/Ql7TZxqnCZrRr+NUfDcQDIKQ1D9xqPITY3uq2kUCgY0w/pb8AlNCNn8on3VHUGB8LFuSQGvgisFOqJju32wSwzTBLBXWuu2FFC31zzd7Rx/+C5cctda+fDoH34P+xw+LNrMVx3Cl32Gyl6ONrr9dXNFr2IQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768941980; c=relaxed/simple;
	bh=5fcUTLVvE2Nvx5pavsTgJCCIPrtqRuEEMz8sO+V/SYo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=TcikmtiXfsqefa+IPyi6StqKmVfxGT1ubWaRr9EWdCsRm7eg8/0K4IQF+V0pHDOSO5jj+eJJdGzRYViqW9AD1+eCs1PRo71EfzYH89t+6MYIFMfqlfMXuBdwH/jV77rLiKXyW3A7gu3ZM2ugVP10xTF8RnoaGsS3AVfVDChc5Ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=kacdOBF+; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1768941971; x=1769546771; i=quwenruo.btrfs@gmx.com;
	bh=I2/8yxQ0EZQjf/m+Cnx5LSfcIu0jHP0bLFYIn3KSsws=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=kacdOBF+91pNKaALE6PxQX4tWDGr6o+soDrvLU7rlfuLts6HEw5l/3iNxFcMNpaT
	 dE5jHn7tiWS4y8ZGoD1FT1EVa4aupiDNwOpU0mmdIWgjx7iMjho/AH4bMQOHTwPNN
	 QzRYzObJ46P7BD3sAO01gN7MKdNtRsqtz9GrU/gIaz9e4r+EyCQD3Kw7dNo0ECoo4
	 2sJxRkVEC8reF4nhfI3s+2Xn+d/wcB40jR0QLOQoywSMdcAlIplRudSDj0ay6FOjU
	 jGsaW+6dcBwphOjVunYHrYl6JEBYx2F5lJuH0CpEpJoROTFLJVm5QUV2G37usTUwl
	 XV6Hw4BNBRj6HLWIxQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MsYux-1vwewD1MZ1-00rRbd; Tue, 20
 Jan 2026 21:46:10 +0100
Message-ID: <3a5d1472-7ff0-447f-9d02-f75a60161ead@gmx.com>
Date: Wed, 21 Jan 2026 07:16:06 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] btrfs: allocate path in load_block_group_size_class()
To: fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <cover.1768911827.git.fdmanana@suse.com>
 <05452a804b036b205a791be1c1c5e09d0279812d.1768911827.git.fdmanana@suse.com>
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
In-Reply-To: <05452a804b036b205a791be1c1c5e09d0279812d.1768911827.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:QaaEKuXKJ1QhEuXwA/tyaC+pvnSu908ElQW/K8aY9cQJCsP5oAD
 Mt7UIey36KtqC9Z4TIomNek/VAuZB5O1J48mmpRZ0hi1nX+8kSqyZ5UN9SAXNzss8I4q+/U
 z9kfC84Y6qI25XNZJ65VGVDZb/2dfhfXN3hU9FlLcL342DWk/KzcgtOKqlydsrHQpBLDK74
 Lf7EI2MS0JsjTHn8PNK8w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:uY9xAPgRMIs=;TxbPq8vC8gmNdZURWdnkLg7TGgC
 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
X-Spamd-Result: default: False [-1.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[gmx.com:s=s31663417];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20783-lists,linux-btrfs=lfdr.de];
	DMARC_POLICY_ALLOW(0.00)[gmx.com,quarantine];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmx.com:+];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	FREEMAIL_FROM(0.00)[gmx.com];
	R_SPF_SOFTFAIL(0.00)[~all];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[quwenruo.btrfs@gmx.com,linux-btrfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,suse.com:email,gmx.com:mid,gmx.com:dkim]
X-Rspamd-Queue-Id: E52354CD0A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



=E5=9C=A8 2026/1/20 22:55, fdmanana@kernel.org =E5=86=99=E9=81=93:
> From: Filipe Manana <fdmanana@suse.com>
>=20
> Instead of allocating and freeing a path in every iteration of
> load_block_group_size_class(), through its helper function
> sample_block_group_extent_item(), allocate the path in the former and
> pass it to the later.
>=20
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> ---
>   fs/btrfs/block-group.c | 32 +++++++++++++++++---------------
>   1 file changed, 17 insertions(+), 15 deletions(-)
>=20
> diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
> index 343c29344484..a7828673be39 100644
> --- a/fs/btrfs/block-group.c
> +++ b/fs/btrfs/block-group.c
> @@ -579,24 +579,24 @@ int btrfs_add_new_free_space(struct btrfs_block_gr=
oup *block_group, u64 start,
>    * @index:        the integral step through the block group to grab fr=
om
>    * @max_index:    the granularity of the sampling
>    * @key:          return value parameter for the item we find
> + * @path:         path to use for searching in the extent tree
>    *
>    * Pre-conditions on indices:
>    * 0 <=3D index <=3D max_index
>    * 0 < max_index
>    *
> - * Returns: 0 on success, 1 if the search didn't yield a useful item, n=
egative
> - * error code on error.
> + * Returns: 0 on success, 1 if the search didn't yield a useful item.
>    */
>   static int sample_block_group_extent_item(struct btrfs_caching_control=
 *caching_ctl,
>   					  struct btrfs_block_group *block_group,
>   					  int index, int max_index,
> -					  struct btrfs_key *found_key)
> +					  struct btrfs_key *found_key,
> +					  struct btrfs_path *path)
>   {
>   	struct btrfs_fs_info *fs_info =3D block_group->fs_info;
>   	struct btrfs_root *extent_root;
>   	u64 search_offset;
>   	const u64 search_end =3D btrfs_block_group_end(block_group);
> -	BTRFS_PATH_AUTO_FREE(path);
>   	struct btrfs_key search_key;
>   	int ret =3D 0;
>  =20
> @@ -606,17 +606,9 @@ static int sample_block_group_extent_item(struct bt=
rfs_caching_control *caching_
>   	lockdep_assert_held(&caching_ctl->mutex);
>   	lockdep_assert_held_read(&fs_info->commit_root_sem);
>  =20
> -	path =3D btrfs_alloc_path();
> -	if (!path)
> -		return -ENOMEM;
> -
>   	extent_root =3D btrfs_extent_root(fs_info, max_t(u64, block_group->st=
art,
>   						       BTRFS_SUPER_INFO_OFFSET));
>  =20
> -	path->skip_locking =3D true;
> -	path->search_commit_root =3D true;
> -	path->reada =3D READA_FORWARD;
> -
>   	search_offset =3D index * div_u64(block_group->length, max_index);
>   	search_key.objectid =3D block_group->start + search_offset;
>   	search_key.type =3D BTRFS_EXTENT_ITEM_KEY;
> @@ -679,6 +671,7 @@ static int sample_block_group_extent_item(struct btr=
fs_caching_control *caching_
>   static void load_block_group_size_class(struct btrfs_caching_control *=
caching_ctl,
>   					struct btrfs_block_group *block_group)
>   {
> +	BTRFS_PATH_AUTO_FREE(path);
>   	struct btrfs_fs_info *fs_info =3D block_group->fs_info;
>   	struct btrfs_key key;
>   	int i;
> @@ -688,14 +681,23 @@ static void load_block_group_size_class(struct btr=
fs_caching_control *caching_ct
>   	if (!btrfs_block_group_should_use_size_class(block_group))
>   		return;
>  =20
> +	path =3D btrfs_alloc_path();
> +	if (!path)
> +		return;

Considering the function is only called inside a workqueue, we can avoid=
=20
a memory allocation by using on-stack path, which also reduces one error=
=20
path.

Although this is a prett minor optimization, the patch still looks good=20
to me.

Thanks,
Qu


> +
> +	path->skip_locking =3D true;
> +	path->search_commit_root =3D true;
> +	path->reada =3D READA_FORWARD;
> +
>   	lockdep_assert_held(&caching_ctl->mutex);
>   	lockdep_assert_held_read(&fs_info->commit_root_sem);
>   	for (i =3D 0; i < 5; ++i) {
>   		int ret;
>  =20
> -		ret =3D sample_block_group_extent_item(caching_ctl, block_group, i, 5=
, &key);
> -		if (ret < 0)
> -			return;
> +		ret =3D sample_block_group_extent_item(caching_ctl, block_group,
> +						     i, 5, &key, path);
> +		btrfs_release_path(path);
> +		ASSERT(ret >=3D 0);
>   		if (ret > 0)
>   			continue;
>   		min_size =3D min_t(u64, min_size, key.offset);


