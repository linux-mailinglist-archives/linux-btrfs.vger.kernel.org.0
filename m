Return-Path: <linux-btrfs+bounces-21768-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2AiNCkoulmm5bwIAu9opvQ
	(envelope-from <linux-btrfs+bounces-21768-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Feb 2026 22:25:30 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 9312015A0BA
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Feb 2026 22:25:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8FE4230101F5
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Feb 2026 21:25:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 747DC32F741;
	Wed, 18 Feb 2026 21:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="BJlhGtpD"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21FA3332EB7
	for <linux-btrfs@vger.kernel.org>; Wed, 18 Feb 2026 21:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771449918; cv=none; b=R/IfLIiXuyXQfwh2UmVFc5bDQ0OCRHQSIY09NUjWfUYlDdEaGWZE3BB0YkKysx1EQmvDxtS8x+p2E4uM1MICNfDSgAt78pjwaYh7r7zSsLR6HFJRKrRkgrKNrLZwYKv7s7BD0o3YFHRyzddZJTASWrxPJvmPW4GWY4RnQyrHYf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771449918; c=relaxed/simple;
	bh=kJceYlbfkX4bveIkRcpM0YbIJbje0x2DMP1Uc90nvMM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Wnrb3fhOijkK0UwGGg8jS6isQOiH5DlFNsBk5UEBcjsDvA/bNwILvZsYhWZ/CqMfwBf5ka9GkEOcH67hBj1tay+2XD14BI+GgENT10FBnXcMqKFdJsYExQM+K5pGByfo+ZHJ3aC2LtU4UYIQlTC5xEBfOy2xL7BWTmzHSQ8B6l0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=BJlhGtpD; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1771449914; x=1772054714; i=quwenruo.btrfs@gmx.com;
	bh=LPeb67Ud9++KUO7cKiowfeqtP+SSEJxEv/LBAdeBTPY=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=BJlhGtpDtN99jWMzPlcSxNEu2aOWAvjjcFF/vqu9HUeI8Zq7XkyXS0t+UdUhBbeC
	 JhqDNSVmE8VpCdO12adVPza35QndIkuS0OzPw3h99lOhzO94pg47hdQoMTR2Hybxd
	 ywO8SMBr6hUNdjbBV7vqCZXdQEC1gjoa1tcPXNTS8c6tS1XTwfCjMuhApDxvLcKEQ
	 InV91JlOvtCb+eQcgc7LkL6RZFqK5avdndMvo5llD/ZctftBcEQkfaLdIF8CVRWh/
	 8VI6tD5cggjzaAqh9BcbEO4HqdK5mEZRSjoYwDn2IS87qe5iGLJqsEGrMkNigFh0g
	 9flAUAXgaY3jprXC/g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MQe5k-1w4S2Y3K4c-00Sj3t; Wed, 18
 Feb 2026 22:25:14 +0100
Message-ID: <7ca15a56-02bc-42ed-8bd4-50736769bf83@gmx.com>
Date: Thu, 19 Feb 2026 07:55:09 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: avoid unnecessary root node COW during
 snapshotting
To: fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <f4267e2d75ae6d1cf5a88b86616ff27ed08e2469.1771432096.git.fdmanana@suse.com>
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
In-Reply-To: <f4267e2d75ae6d1cf5a88b86616ff27ed08e2469.1771432096.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:jiam8FycAY0U6abrgS9Z+VUzKxghn/bxS8lha39WC9GNBsEYPJ5
 Xu2D0BpS02y5iDgZIZ6uomoGthg6uoAdv8FOwC7FYumg3b1sAcANnBHMCDbzgoPL6vpCRZk
 IrLHv1TASwbNP4uwSCaVJejaR5Jy7e/87YJ/0DHIpT2efledlQGxlAJItuDvX4AjrN5iclb
 6N7iQD/VkRInuzxfakwDg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:dMU3d6LEZaY=;IlQ+DhHk3lqrRHU8H+Xacb0VdKM
 +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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmx.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmx.com:s=s31663417];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21768-lists,linux-btrfs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[gmx.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[quwenruo.btrfs@gmx.com,linux-btrfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-btrfs];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmx.com]
X-Rspamd-Queue-Id: 9312015A0BA
X-Rspamd-Action: no action



=E5=9C=A8 2026/2/19 03:15, fdmanana@kernel.org =E5=86=99=E9=81=93:
> From: Filipe Manana <fdmanana@suse.com>
>=20
> There's no need to COW the root node of the subvolume we are snaphotting
> because we then call btrfs_copy_root(), which creates a copy of the root
> node and sets its generation to the current transaction. So remove this
> redudant COW right before calling btrfs_copy_root(), saving one extent
> allocation, memory allocation, copying things, etc, and making the code
> less confusing. Also rename the extent buffer variable from "old" to
> "root_eb" since that name no longer makes any sense after removing the
> unnecessary COW operation.
>=20
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

> ---
>   fs/btrfs/transaction.c | 20 +++++---------------
>   1 file changed, 5 insertions(+), 15 deletions(-)
>=20
> diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
> index 02afd7d72454..3112bd5520b7 100644
> --- a/fs/btrfs/transaction.c
> +++ b/fs/btrfs/transaction.c
> @@ -1669,7 +1669,7 @@ static noinline int create_pending_snapshot(struct=
 btrfs_trans_handle *trans,
>   	BTRFS_PATH_AUTO_FREE(path);
>   	struct btrfs_dir_item *dir_item;
>   	struct extent_buffer *tmp;
> -	struct extent_buffer *old;
> +	struct extent_buffer *root_eb;
>   	struct timespec64 cur_time;
>   	int ret =3D 0;
>   	u64 to_reserve =3D 0;
> @@ -1807,20 +1807,10 @@ static noinline int create_pending_snapshot(stru=
ct btrfs_trans_handle *trans,
>   	btrfs_set_stack_timespec_nsec(&new_root_item->otime, cur_time.tv_nsec=
);
>   	btrfs_set_root_otransid(new_root_item, trans->transid);
>  =20
> -	old =3D btrfs_lock_root_node(root);
> -	ret =3D btrfs_cow_block(trans, root, old, NULL, 0, &old,
> -			      BTRFS_NESTING_COW);
> -	if (unlikely(ret)) {
> -		btrfs_tree_unlock(old);
> -		free_extent_buffer(old);
> -		btrfs_abort_transaction(trans, ret);
> -		goto fail;
> -	}
> -
> -	ret =3D btrfs_copy_root(trans, root, old, &tmp, objectid);
> -	/* clean up in any case */
> -	btrfs_tree_unlock(old);
> -	free_extent_buffer(old);
> +	root_eb =3D btrfs_lock_root_node(root);
> +	ret =3D btrfs_copy_root(trans, root, root_eb, &tmp, objectid);
> +	btrfs_tree_unlock(root_eb);
> +	free_extent_buffer(root_eb);
>   	if (unlikely(ret)) {
>   		btrfs_abort_transaction(trans, ret);
>   		goto fail;


