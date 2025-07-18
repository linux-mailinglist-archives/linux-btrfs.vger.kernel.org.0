Return-Path: <linux-btrfs+bounces-15545-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 93722B098FF
	for <lists+linux-btrfs@lfdr.de>; Fri, 18 Jul 2025 02:48:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE1BC188E474
	for <lists+linux-btrfs@lfdr.de>; Fri, 18 Jul 2025 00:48:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49C85286A9;
	Fri, 18 Jul 2025 00:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="PZGOTk6s"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3ED33C38
	for <linux-btrfs@vger.kernel.org>; Fri, 18 Jul 2025 00:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752799694; cv=none; b=DEHnSd9zc3Z1u1MesmV9KA9q9Tm0ComPeuDziEUCd6wYyJDePJa3vqXNUUIQB0VSLGocFifL/aXrlTTGDmUIieQZ4RWkxoHBhbECtgbwgPzpA/V8JUQRmrePpebC3pNhneDzAaO1Q4auahkO1ylEdGqApnPKvG2LK12MjTPTeHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752799694; c=relaxed/simple;
	bh=EggU1NLIlcn2WlMuGgFGWS2oyco/k5ZZIwdBUyBxU4U=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=As2fznyAfNKaUXcoOHvbXVo15ZfKimWgVbV4ILZqJSU2iabpUVQigrRMdZinC2GwkxYFFnia+rG8MWFncR051t757SSV2VRrjc0f9BQ/ybWT2PR1x3SYx1Gq7k7onEH2bOgHOKzZIgirduQVFsqhT0mLt6nrBOWLoeMIZGWpd0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=PZGOTk6s; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1752799687; x=1753404487; i=quwenruo.btrfs@gmx.com;
	bh=Az7OUpEQ6zw1ihb9vJROsW/e3g0x1h0kxfWjMHbJA+E=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=PZGOTk6st8xoshrBq6x/nwCHVm/tsAwKstI/DT3coXJ+2LCgTpaZL+MnXuBbTXw6
	 gTwkgHvGnVzUeGzMouJASMECaRF+EEMG3zBz0pbPKEWSF0/aiW7PxqDipZRekFkiv
	 nKbTVsPrj4nQFJg8+N1pGT3A3iw8DZNDgoIvXHLVCXai3L3xysD7ck2NLSxoBvrq6
	 UkUVFOKpOoA93ggUPG4ksRNf62sZyiD89nEgvoZQ7KvrM96C0vB/72TGZpVVRlbD0
	 2ejJUlurk+8EfgjaliaKpNkYZYiolvg0mAROk96MpKfTEAprfx1FVlj2ubLGTh9+p
	 h3JKrn45GdFPz4RuuQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mwfac-1uo1YC2CJW-00skJW; Fri, 18
 Jul 2025 02:48:07 +0200
Message-ID: <4b717bb0-d421-43e1-b722-1bf56a611df5@gmx.com>
Date: Fri, 18 Jul 2025 10:18:02 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: fix subpage deadlock
To: Leo Martins <loemra.dev@gmail.com>, linux-btrfs@vger.kernel.org,
 kernel-team@fb.com
References: <52e3db9d6f775370d963eb5179e3cbfa1ace5e04.1752795616.git.loemra.dev@gmail.com>
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
In-Reply-To: <52e3db9d6f775370d963eb5179e3cbfa1ace5e04.1752795616.git.loemra.dev@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:H7twEAR+vydffYDmk99GXtBZinNWtr63MU70BlSUkApG6dQef0f
 CnrePWimsYUVUYL03tVe8IF8CAvO6tsbLEecY9qnLPM8E5oj475wMRi03IZEP4uWaumzCrW
 xFjipkP+naBGZhko0g9VOrwIIzD790suThkSrcXV7+Xlq6F9O8CzhEcGTYJiDk/OTZ+jTOk
 YXa629q40O3XgNkBbyaoA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:1t2yRTpz34c=;hgU7LcQQs91YThRur6m1eA8cru7
 +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
 /6UaQ=



=E5=9C=A8 2025/7/18 09:14, Leo Martins =E5=86=99=E9=81=93:
> There is a deadlock happening in `try_release_subpage_extent_buffer`
> because the irq-safe xarray spin lock `fs_info->buffer_tree` is being
> acquired before the irq-unsafe `eb->refs_lock`.
>=20
> This leads to the potential race:
>=20
> ```
> // T1					// T2
> xa_lock_irq(&fs_info->buffer_tree)
> 					spin_lock(&eb->refs_lock)
> 					// interrupt
> 					xa_lock_irq(&fs_info->buffer_tree)
> spin_lock(&eb->refs_lock)
> ```
>=20

If it's a lockdep warning, mind to provide the full calltrace?

I'm wondering at which exact interruption path that we will try to=20
acquire the buffer_tree xa lock.

Since the read path is always happening inside a workqueue, it won't=20
cause xa_lock_irq() under interruption context.

For the write path it's possible through end_bbio_meta_write() ->=20
buffer_tree_clear_mark().

But remember if there is an extent buffer under writeback, the whole=20
folio will have writeback flag, thus the btree_release_folio() won't=20
even try to release the folio.


> https://www.kernel.org/doc/Documentation/locking/lockdep-design.rst#:~:t=
ext=3DMulti%2Dlock%20dependency%20rules%3A
>=20
> I believe that in this case a spin lock is not needed and we can get
> away with `rcu_read_lock`. There is already some precedence for this
> with `find_extent_buffer_nolock`, which loads an extent buffer from
> the xarray with only `rcu_read_lock`.
>=20
> Signed-off-by: Leo Martins <loemra.dev@gmail.com>
> ---
>   fs/btrfs/extent_io.c | 12 +++++++-----
>   1 file changed, 7 insertions(+), 5 deletions(-)
>=20
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index 6192e1f58860..060e509cfb18 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -1,5 +1,6 @@
>   // SPDX-License-Identifier: GPL-2.0
>  =20
> +#include <linux/rcupdate.h>

We already have other rcu_read_lock() usage inside the same file, no=20
need to manually include the header.

Thanks,
Qu

>   #include <linux/bitops.h>
>   #include <linux/slab.h>
>   #include <linux/bio.h>
> @@ -4332,15 +4333,18 @@ static int try_release_subpage_extent_buffer(str=
uct folio *folio)
>   	unsigned long end =3D index + (PAGE_SIZE >> fs_info->nodesize_bits) -=
 1;
>   	int ret;
>  =20
> -	xa_lock_irq(&fs_info->buffer_tree);
> +	rcu_read_lock();
>   	xa_for_each_range(&fs_info->buffer_tree, index, eb, start, end) {
>   		/*
>   		 * The same as try_release_extent_buffer(), to ensure the eb
>   		 * won't disappear out from under us.
>   		 */
>   		spin_lock(&eb->refs_lock);
> +		rcu_read_unlock();
> +
>   		if (refcount_read(&eb->refs) !=3D 1 || extent_buffer_under_io(eb)) {
>   			spin_unlock(&eb->refs_lock);
> +			rcu_read_lock();
>   			continue;
>   		}
>  =20
> @@ -4359,11 +4363,10 @@ static int try_release_subpage_extent_buffer(str=
uct folio *folio)
>   		 * check the folio private at the end.  And
>   		 * release_extent_buffer() will release the refs_lock.
>   		 */
> -		xa_unlock_irq(&fs_info->buffer_tree);
>   		release_extent_buffer(eb);
> -		xa_lock_irq(&fs_info->buffer_tree);
> +		rcu_read_lock();
>   	}
> -	xa_unlock_irq(&fs_info->buffer_tree);
> +	rcu_read_unlock();
>  =20
>   	/*
>   	 * Finally to check if we have cleared folio private, as if we have
> @@ -4376,7 +4379,6 @@ static int try_release_subpage_extent_buffer(struc=
t folio *folio)
>   		ret =3D 0;
>   	spin_unlock(&folio->mapping->i_private_lock);
>   	return ret;
> -
>   }
>  =20
>   int try_release_extent_buffer(struct folio *folio)



