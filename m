Return-Path: <linux-btrfs+bounces-4851-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E44388C0866
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 May 2024 02:26:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 141E81C20FB4
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 May 2024 00:26:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0D2D1FAA;
	Thu,  9 May 2024 00:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="C/k8yHEb"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F16E510E9
	for <linux-btrfs@vger.kernel.org>; Thu,  9 May 2024 00:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715214358; cv=none; b=dE5U7RvZqounjfXrXND5pX/C3/PO3H+jbdGET+g4YjICAlsx2TuUMTCfDA8Z8K1v25Q9LkOX8YprS5OjZmAbD9aQ3kk+mmy0G0nMzB5OkI0IWc+Ieb0zpfPphyCpMCz15EgvhI0emE3ItYyjNDH9OWvGIeUfATa7lp46DYAKEGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715214358; c=relaxed/simple;
	bh=r65sxUAr0pblkOyzYUyPfKhqosiHoFMDsNOtIUBhaF4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Sa54wAEHZJgE7Cs31hS4aLvHN0Z+dkt9IB4xfNTxwLXVNiOiGBs3EqP51VfLDHSrBW9AK5vebiBsHjhExRQvrccvczgexl/t3PgNAupE08zvlA8iq3NiiO2VVe307joPlF4rJzgrHAb7Qbuoi60Mdl3qVjkounrjHJ0WO2XzKsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=C/k8yHEb; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1715214350; x=1715819150; i=quwenruo.btrfs@gmx.com;
	bh=RmYqs45sDOfe6RUCFnPLrgg628dmQDOvwhsEpmRsDLg=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=C/k8yHEbj0Ll/2Z9X1xTMQLjFhXhOO2UcYz5ue2Rl9LdyTTQ20futsOSENn6FkfO
	 2UF9r8+HUrNWIBFxEmvenoF5fRA04CJ20IxLwINJTXRZExPoAOZsM6tzGu5loNhYn
	 fM72euCNREru3pNYMhnaZkr0mv7o55u+WIhY4u7cR0MkdW2/lkpd0JxkkzKfaLFnC
	 EtBQmaa7uWCxlm1wa7sXESDAP1MjI+hx7Xw3VH7DINTG4rt/XRWeL/ReTxM/rQm0L
	 eaVDK8DEDloKs0Pr+E59LTWhsSa4AMkAAPF5UzCQQlI211aSDFn/M4CZATnxlyVvm
	 mE2X72uqmuJ0CToRUg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.219] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MLQxX-1sNMMQ0fAp-00IX1s; Thu, 09
 May 2024 02:25:49 +0200
Message-ID: <23310a98-c2dc-4a99-ac83-593da5e7d42f@gmx.com>
Date: Thu, 9 May 2024 09:55:45 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/8] btrfs: remove inode_lock from struct btrfs_root and
 use xarray locks
To: fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <cover.1715169723.git.fdmanana@suse.com>
 <51066985ea4e9ea16388854a1d48ee197f07219f.1715169723.git.fdmanana@suse.com>
Content-Language: en-US
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
Autocrypt: addr=quwenruo.btrfs@gmx.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNIlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT7CwJQEEwEIAD4CGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCY00iVQUJDToH
 pgAKCRDCPZHzoSX+qNKACACkjDLzCvcFuDlgqCiS4ajHAo6twGra3uGgY2klo3S4JespWifr
 BLPPak74oOShqNZ8yWzB1Bkz1u93Ifx3c3H0r2vLWrImoP5eQdymVqMWmDAq+sV1Koyt8gXQ
 XPD2jQCrfR9nUuV1F3Z4Lgo+6I5LjuXBVEayFdz/VYK63+YLEAlSowCF72Lkz06TmaI0XMyj
 jgRNGM2MRgfxbprCcsgUypaDfmhY2nrhIzPUICURfp9t/65+/PLlV4nYs+DtSwPyNjkPX72+
 LdyIdY+BqS8cZbPG5spCyJIlZonADojLDYQq4QnufARU51zyVjzTXMg5gAttDZwTH+8LbNI4
 mm2YzsBNBFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcga
 CbPEwhLj1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj
 /IrRUUka68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fN
 GSsRb+pKEKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0
 q1eW4Jrv0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEv
 ABEBAAHCwHwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCY00ibgUJDToHvwAK
 CRDCPZHzoSX+qK6vB/9yyZlsS+ijtsvwYDjGA2WhVhN07Xa5SBBvGCAycyGGzSMkOJcOtUUf
 tD+ADyrLbLuVSfRN1ke738UojphwkSFj4t9scG5A+U8GgOZtrlYOsY2+cG3R5vjoXUgXMP37
 INfWh0KbJodf0G48xouesn08cbfUdlphSMXujCA8y5TcNyRuNv2q5Nizl8sKhUZzh4BascoK
 DChBuznBsucCTAGrwPgG4/ul6HnWE8DipMKvkV9ob1xJS2W4WJRPp6QdVrBWJ9cCdtpR6GbL
 iQi22uZXoSPv/0oUrGU+U5X4IvdnvT+8viPzszL5wXswJZfqfy8tmHM85yjObVdIG6AlnrrD
In-Reply-To: <51066985ea4e9ea16388854a1d48ee197f07219f.1715169723.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:0BIDYGhowoVf61DptUhtGFTXKN0kZ4JHv8h29cYpKElw0upxJhI
 kjj5dWfuu49YWrFMdDJs7yB9hkfDP8J5kwvrWe5/Ge0ed/LdbSuLojNFHIk7Fduet9H0w2C
 65ykmZIMlYNNikpzgp1TB8e8l17HbNCenl+SMD+JmWWpodNOMsVqEufusiqy+/wWnwwLSBq
 b9DtY+CRdINCwxQ4WFxjw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:xJymb4nbCE8=;fOkQIPtWtWzdu7ZEjmTtgJGnbbU
 m5Spgu2XM0nBcTn2+NX6gts5PwxTIr8mIaeiu3doow0Ltig1Duqnuy3HKj/JTG8GIqrtPK2ZF
 ABYKLd3MEofoGMGxsrCmQqvfCXzpVwqWemJBBqeEkZGfyEMsRRWGxTZq2PWVMXpTDTotF+YY8
 1IW8aZ6yY3KWHwFThvlw3RFELYkBSyurQ+lbQZVR5ISbx5xQ1POdnNVYY9ircySqTpcFQmUcT
 AxvT4hoPDeER3tmAmIUC3VohmraSr5OK6aYsKqzVpuhKCfOcS5uj/2qfwoZcNRs3JCQJwIhIh
 ZGlaSq3GLxqNxsKMIfbP7qcOdRx6f17BHhEyqiGszaQj6BQiPryGzPWiHullOTaWceIrSBh9u
 MDVBrwAsJGFQN3ytQ0hSRSNC5xOZWnySnDfcMDOqrAVrCqlh/jHkmIlDqnZjdNb4UJVPf/G9w
 spj8ZeyLMNA+y42LZTFxvMs97Qp/ff0PBvCNsSlxM+XE88oJnV0EQ5TER2lW7NhlXVmo2pLSj
 6VKuLNMwhEbKOsLHn4+arugh6ebvrpVEtGp/WJ1NCvczaJnzKug6REB86n7BppWxqrE5+RdW5
 h1pVsulNGtLpcn+W482tY12t4EwL4Or/shhHW4qpLltD+HsOzWnK4cUCOlCHTmkF/7RbFQcfS
 N6oHdi32J7Q7fRbqySehnqe/Y4QGBO9ooPk8uDlEwcYbU4pIgB4L65akayT/GsbfXJT4dlNkq
 4sM9pWmEkUEB8k3aOGDYIIajY34jcaa4+vhcN/7TADErgSZkUUtwjI+vmv1yCsARLUQKDesF9
 wnxzCR0bJSrxsOxZRDbbhm1i0DPPAl+NvpFFfy+xSIbAY=



=E5=9C=A8 2024/5/8 21:47, fdmanana@kernel.org =E5=86=99=E9=81=93:
> From: Filipe Manana <fdmanana@suse.com>
>
> Currently we use the spinlock inode_lock from struct btrfs_root to
> serialize access to two different data structures:
>
> 1) The delayed inodes xarray (struct btrfs_root::delayed_nodes);
> 2) The inodes xarray (struct btrfs_root::inodes).
>
> Instead of using our own lock, we can use the spinlock that is part of t=
he
> xarray implementation, by using the xa_lock() and xa_unlock() APIs and
> using the xarray APIs with the double underscore prefix that don't take
> the xarray locks and assume the caller is using xa_lock() and xa_unlock(=
).
>
> So remove the spinlock inode_lock from struct btrfs_root and use the
> corresponding xarray locks. This brings 2 benefits:
>
> 1) We reduce the size of struct btrfs_root, from 1336 bytes down to
>     1328 bytes on a 64 bits release kernel config;
>
> 2) We reduce lock contention by not using anymore  the same lock for
>     changing two different and unrelated xarrays.
>
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> ---
>   fs/btrfs/ctree.h         |  1 -
>   fs/btrfs/delayed-inode.c | 24 +++++++++++-------------
>   fs/btrfs/disk-io.c       |  1 -
>   fs/btrfs/inode.c         | 18 ++++++++----------
>   4 files changed, 19 insertions(+), 25 deletions(-)
>
> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> index aa2568f86dc9..1004cb934b4a 100644
> --- a/fs/btrfs/ctree.h
> +++ b/fs/btrfs/ctree.h
> @@ -221,7 +221,6 @@ struct btrfs_root {
>
>   	struct list_head root_list;
>
> -	spinlock_t inode_lock;
>   	/*
>   	 * Xarray that keeps track of in-memory inodes, protected by the lock
>   	 * @inode_lock.
> diff --git a/fs/btrfs/delayed-inode.c b/fs/btrfs/delayed-inode.c
> index 95a0497fa866..1373f474c9b6 100644
> --- a/fs/btrfs/delayed-inode.c
> +++ b/fs/btrfs/delayed-inode.c
> @@ -77,14 +77,14 @@ static struct btrfs_delayed_node *btrfs_get_delayed_=
node(
>   		return node;
>   	}
>
> -	spin_lock(&root->inode_lock);
> +	xa_lock(&root->delayed_nodes);
>   	node =3D xa_load(&root->delayed_nodes, ino);

Do we need xa_lock() here?

The doc shows xa_load() use RCU read lock already.
Only xa_store()/xa_find() would take xa_lock internally, thus they need
to be converted.

Or did I miss something else?

Thanks,
Qu
>
>   	if (node) {
>   		if (btrfs_inode->delayed_node) {
>   			refcount_inc(&node->refs);	/* can be accessed */
>   			BUG_ON(btrfs_inode->delayed_node !=3D node);
> -			spin_unlock(&root->inode_lock);
> +			xa_unlock(&root->delayed_nodes);
>   			return node;
>   		}
>
> @@ -111,10 +111,10 @@ static struct btrfs_delayed_node *btrfs_get_delaye=
d_node(
>   			node =3D NULL;
>   		}
>
> -		spin_unlock(&root->inode_lock);
> +		xa_unlock(&root->delayed_nodes);
>   		return node;
>   	}
> -	spin_unlock(&root->inode_lock);
> +	xa_unlock(&root->delayed_nodes);
>
>   	return NULL;
>   }
> @@ -148,21 +148,21 @@ static struct btrfs_delayed_node *btrfs_get_or_cre=
ate_delayed_node(
>   		kmem_cache_free(delayed_node_cache, node);
>   		return ERR_PTR(-ENOMEM);
>   	}
> -	spin_lock(&root->inode_lock);
> +	xa_lock(&root->delayed_nodes);
>   	ptr =3D xa_load(&root->delayed_nodes, ino);
>   	if (ptr) {
>   		/* Somebody inserted it, go back and read it. */
> -		spin_unlock(&root->inode_lock);
> +		xa_unlock(&root->delayed_nodes);
>   		kmem_cache_free(delayed_node_cache, node);
>   		node =3D NULL;
>   		goto again;
>   	}
> -	ptr =3D xa_store(&root->delayed_nodes, ino, node, GFP_ATOMIC);
> +	ptr =3D __xa_store(&root->delayed_nodes, ino, node, GFP_ATOMIC);
>   	ASSERT(xa_err(ptr) !=3D -EINVAL);
>   	ASSERT(xa_err(ptr) !=3D -ENOMEM);
>   	ASSERT(ptr =3D=3D NULL);
>   	btrfs_inode->delayed_node =3D node;
> -	spin_unlock(&root->inode_lock);
> +	xa_unlock(&root->delayed_nodes);
>
>   	return node;
>   }
> @@ -275,14 +275,12 @@ static void __btrfs_release_delayed_node(
>   	if (refcount_dec_and_test(&delayed_node->refs)) {
>   		struct btrfs_root *root =3D delayed_node->root;
>
> -		spin_lock(&root->inode_lock);
>   		/*
>   		 * Once our refcount goes to zero, nobody is allowed to bump it
>   		 * back up.  We can delete it now.
>   		 */
>   		ASSERT(refcount_read(&delayed_node->refs) =3D=3D 0);
>   		xa_erase(&root->delayed_nodes, delayed_node->inode_id);
> -		spin_unlock(&root->inode_lock);
>   		kmem_cache_free(delayed_node_cache, delayed_node);
>   	}
>   }
> @@ -2057,9 +2055,9 @@ void btrfs_kill_all_delayed_nodes(struct btrfs_roo=
t *root)
>   		struct btrfs_delayed_node *node;
>   		int count;
>
> -		spin_lock(&root->inode_lock);
> +		xa_lock(&root->delayed_nodes);
>   		if (xa_empty(&root->delayed_nodes)) {
> -			spin_unlock(&root->inode_lock);
> +			xa_unlock(&root->delayed_nodes);
>   			return;
>   		}
>
> @@ -2076,7 +2074,7 @@ void btrfs_kill_all_delayed_nodes(struct btrfs_roo=
t *root)
>   			if (count >=3D ARRAY_SIZE(delayed_nodes))
>   				break;
>   		}
> -		spin_unlock(&root->inode_lock);
> +		xa_unlock(&root->delayed_nodes);
>   		index++;
>
>   		for (int i =3D 0; i < count; i++) {
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index ed40fe1db53e..d20e400a9ce3 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -674,7 +674,6 @@ static void __setup_root(struct btrfs_root *root, st=
ruct btrfs_fs_info *fs_info,
>   	INIT_LIST_HEAD(&root->ordered_extents);
>   	INIT_LIST_HEAD(&root->ordered_root);
>   	INIT_LIST_HEAD(&root->reloc_dirty_list);
> -	spin_lock_init(&root->inode_lock);
>   	spin_lock_init(&root->delalloc_lock);
>   	spin_lock_init(&root->ordered_extent_lock);
>   	spin_lock_init(&root->accounting_lock);
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 8ea9fd4c2b66..4fd41d6b377f 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -5509,9 +5509,7 @@ static int btrfs_add_inode_to_root(struct btrfs_in=
ode *inode, bool prealloc)
>   			return ret;
>   	}
>
> -	spin_lock(&root->inode_lock);
>   	existing =3D xa_store(&root->inodes, ino, inode, GFP_ATOMIC);
> -	spin_unlock(&root->inode_lock);
>
>   	if (xa_is_err(existing)) {
>   		ret =3D xa_err(existing);
> @@ -5531,16 +5529,16 @@ static void btrfs_del_inode_from_root(struct btr=
fs_inode *inode)
>   	struct btrfs_inode *entry;
>   	bool empty =3D false;
>
> -	spin_lock(&root->inode_lock);
> -	entry =3D xa_erase(&root->inodes, btrfs_ino(inode));
> +	xa_lock(&root->inodes);
> +	entry =3D __xa_erase(&root->inodes, btrfs_ino(inode));
>   	if (entry =3D=3D inode)
>   		empty =3D xa_empty(&root->inodes);
> -	spin_unlock(&root->inode_lock);
> +	xa_unlock(&root->inodes);
>
>   	if (empty && btrfs_root_refs(&root->root_item) =3D=3D 0) {
> -		spin_lock(&root->inode_lock);
> +		xa_lock(&root->inodes);
>   		empty =3D xa_empty(&root->inodes);
> -		spin_unlock(&root->inode_lock);
> +		xa_unlock(&root->inodes);
>   		if (empty)
>   			btrfs_add_dead_root(root);
>   	}
> @@ -10871,7 +10869,7 @@ struct btrfs_inode *btrfs_find_first_inode(struc=
t btrfs_root *root, u64 min_ino)
>   	struct btrfs_inode *inode;
>   	unsigned long from =3D min_ino;
>
> -	spin_lock(&root->inode_lock);
> +	xa_lock(&root->inodes);
>   	while (true) {
>   		inode =3D xa_find(&root->inodes, &from, ULONG_MAX, XA_PRESENT);
>   		if (!inode)
> @@ -10880,9 +10878,9 @@ struct btrfs_inode *btrfs_find_first_inode(struc=
t btrfs_root *root, u64 min_ino)
>   			break;
>
>   		from =3D btrfs_ino(inode) + 1;
> -		cond_resched_lock(&root->inode_lock);
> +		cond_resched_lock(&root->inodes.xa_lock);
>   	}
> -	spin_unlock(&root->inode_lock);
> +	xa_unlock(&root->inodes);
>
>   	return inode;
>   }

