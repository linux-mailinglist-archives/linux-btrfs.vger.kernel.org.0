Return-Path: <linux-btrfs+bounces-10361-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D89D19F17C6
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Dec 2024 22:05:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4764D1662B0
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Dec 2024 21:04:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E70471922CC;
	Fri, 13 Dec 2024 21:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="HpBX63b0"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD23118660F
	for <linux-btrfs@vger.kernel.org>; Fri, 13 Dec 2024 21:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734123848; cv=none; b=LqJN89VjzCvbQLSOrCBHqirxVoLxOvWOLr/M+ai10uTzhRoyqOO0ViyQi8l2mp/nck1JyIGrZBBIBx1M+1K7BYOnFUIIqOHGhI5Gek3iSDAROrcW7ywzI55L35+ZyxU96XnOoZKXpUGtCMCUjcCF3kPO15G+hUqTfA8nlEnXJLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734123848; c=relaxed/simple;
	bh=FSDI2HAUSbQhAewXFXpiHTto7H/iqWDV1JUlrw0CCNc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=n6cg3n/1FkPLbeWvsrX9XruyfSPhxIEM44/o86lko84giRGOfGGBB1ndHJzoQDFTyNkYpEol1QxoJxhf484pn/s5mB+1iLFp/PHAXnrQrr6bZ1IC4pVQp2dw1mP7oUOcajYhU4i0+K1hXsb6+56fEccJIXOAR4m/dlLWYvASUik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=HpBX63b0; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1734123839; x=1734728639; i=quwenruo.btrfs@gmx.com;
	bh=2h+JOE+11rOz7CSniV8w6HKApbAAM9uS1V5/mQp3EKs=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=HpBX63b0YlboaOTzXGJkityZH8RAmdcLIqBKTy1nSdpd6np/BIclMagruTiTNCd1
	 sclv8bOnZ8J0ozrc0UcE8hWFtPx0cw4LU3BPx6eqVq4AjXNjJYInXxmONlH+LxuKp
	 /m5CU6fAFllWeSQr1r2uSIqPL/wOHMI6silACBzN2zRLgzqhijoOTExzk+5ZCMffc
	 Sf45BaT79xQQA/915qY9dS2xFNyiSURbMy8QdskB+Qm5wQCZgWuPRKyGa4JX0ZDM0
	 PXEt8i8C3/5zSwrQJxq3mw1XCGXWxQ1cu1NaYXMEam3jmn7t8EHoSD40AgDAcUA8z
	 DF+9iZeARj5aO3uThw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MK3Rm-1t1wPo3juY-00Qs2h; Fri, 13
 Dec 2024 22:03:59 +0100
Message-ID: <003eb5c9-188c-4235-9700-32bc0257ad41@gmx.com>
Date: Sat, 14 Dec 2024 07:33:56 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 11/11] btrfs: add assertions and comment about path
 expectations to btrfs_cross_ref_exist()
To: fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <cover.1733929327.git.fdmanana@suse.com>
 <4d5d175428bb38d17fc2214f8f31f511298ba67f.1733929328.git.fdmanana@suse.com>
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
In-Reply-To: <4d5d175428bb38d17fc2214f8f31f511298ba67f.1733929328.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:RvVQ+tYpCNYnWnBgzYSGzPXDuqeOmWrOLNlsERduFYvFXANL4HW
 79lx7U7nurHNjsVScbUyqQL93AXeZi92V7HLwF7Kbt86KpZs/BhToErzp/4dkNwnHXz9amR
 H2cUa0c6G+Ts9mvaMZiJ5z54U4RuldzgPHWIwZLLjENJL9UufjWEDQAGhkp8wSsJnnIX5F0
 I2ncLF4h9zDvzfoSnFZCA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:StaV0MHsOr4=;dtiXw273RyXC0GBnMyrwEEJ+6a9
 /nCQ0ZNUzZ+JqMAUgo5JM81bfhILqhaRUC7lTRhxUmQjbxWyokBNBUH1e+udrHE0s14VSjYQL
 BBDwtrQWy8wUrjplwOeti6M21oWQoHi6VQOzi3OLt0xlyGmQohnU4r2dS9/lGqNTvkpJVGZP7
 7Y1rLIzjPkcexDP+KemuxZ33W1/cOqsDn3A/JwqRy5fdHA9QTSlczYgIIuULANfTGatoXxkYA
 TWpuVHP0Krnq0Svw87bzO9zp6Mszfqy9dh5nNT/gco2fdbK5U6YQMVQEv8L2Xq82vHeBWx6ZT
 H00G4UaB3zE4fSjtmDL0OojEMrXlyUYXZeV6nDeeMz7jPE8HhtsUHMt38MRqe7SNveu+6MFmW
 nE65fNERrw0bxwYfPyLif5DtFMSzp+YEUs+NUl2ek5p5JjaC06QKTn6mEsqa6Lk+pzYdc2JWK
 loxCoMqS8JV5btKc3Eu1adDDLmEonhWb6V7mR3QiJgOJwA79+ldH9gjwr0RHB3o/drgM78LF6
 0jDIZD0ahKpmmE2NXF2vCbtHPavALFSyRnZRG+RzUW/ff+JpRWSk5EoWFO7XHC+i5JMipu6L9
 W2Ey6tjsegxoCaWL2yQuNdAIiVDr6kfL4nP5DYMHdvtuox4V7TTaNazuLcsASlnWhckjMEUXs
 IQQi8N2qWBe3XD8+vGuNTpValdpJjI8T3N3W+2uQPYJa0fFBFrtimeTwesE/gTKURdS68e+m0
 vgVxKKV/+1D7mWzPxF3u5Sni0gqVOuf6de2mk273E/C7zylQMLAZJlfpK/D8pYXVO5mYH0Pjj
 7iXIOXGBqXotc5iIV/FGzXQoo0wRsoZwng03DYzINI1J9N/tFR8H2PuoftArl7V5Ye6tPaFW6
 nTppKXWGACUeL/w5yipGGMABvsnayU4aedKc3ygiRU/CYqm/UK7BxXflAukUQ/Z/pRkOdB3BQ
 Rh5LQJhfjp8/2acdIsWnM2Y9EjY9bFt0LIza6GVY50j4+5NDayBN1Uq6f5YIdtdl8NEctw5cB
 HkaiqRLlKelGs/4CigUvQWlcnNG5rYi2mHUEwvH0+npqLlVJVurtYlKjhhuZdWH6HigyeWHMB
 lvu4lNgjlkTYtk7ANymcBRUPcnFexo



=E5=9C=A8 2024/12/12 01:35, fdmanana@kernel.org =E5=86=99=E9=81=93:
> From: Filipe Manana <fdmanana@suse.com>
>
> We should always call check_delayed_ref() with a path having a locked le=
af
> from the extent tree where either the extent item is located or where it
> should be located in case it doesn't exist yet (when there's a pending
> unflushed delayed ref to do it), as we need to lock any existing delayed
> ref head while holding such leaf locked in order to avoid races with
> flushing delayed references, which could make us think an extent is not
> shared when it really is.
>
> So add some assertions and a comment about such expectations to
> btrfs_cross_ref_exist(), which is the only caller of check_delayed_ref()=
.
>
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Just a small nitpick.
> ---
>   fs/btrfs/extent-tree.c | 25 +++++++++++++++++++++++++
>   fs/btrfs/locking.h     |  5 +++++
>   2 files changed, 30 insertions(+)
>
> diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
> index bd13059299e1..0f30f53f51b9 100644
> --- a/fs/btrfs/extent-tree.c
> +++ b/fs/btrfs/extent-tree.c
> @@ -2426,6 +2426,31 @@ int btrfs_cross_ref_exist(struct btrfs_inode *ino=
de, u64 offset,
>   		if (ret && ret !=3D -ENOENT)
>   			goto out;
>
> +		/*
> +		 * The path must have a locked leaf from the extent tree where
> +		 * the extent item for our extent is located, in case it exists,
> +		 * or where it should be located in case it doesn't exist yet
> +		 * because it's new and its delayed ref was not yet flushed.
> +		 * We need to lock the delayed ref head at check_delayed_ref(),
> +		 * if one exists, while holding the leaf locked in order to not
> +		 * race with delayed ref flushing, missing references and
> +		 * incorrectly reporting that the extent is not shared.
> +		 */
> +		if (IS_ENABLED(CONFIG_BTRFS_ASSERT)) {

I think we can just get rid of the CONFIG_BTRFS_ASSERT() check.

All the assert functions have already done the check anyway.
We only skip the btrfs_item_key_to_cpu() call which shouldn't be that
costly.

Thanks,
Qu
> +			struct extent_buffer *leaf =3D path->nodes[0];
> +
> +			ASSERT(leaf !=3D NULL);
> +			btrfs_assert_tree_read_locked(leaf);
> +
> +			if (ret !=3D -ENOENT) {
> +				struct btrfs_key key;
> +
> +				btrfs_item_key_to_cpu(leaf, &key, path->slots[0]);
> +				ASSERT(key.objectid =3D=3D bytenr);
> +				ASSERT(key.type =3D=3D BTRFS_EXTENT_ITEM_KEY);
> +			}
> +		}
> +
>   		ret =3D check_delayed_ref(inode, path, offset, bytenr);
>   	} while (ret =3D=3D -EAGAIN && !path->nowait);
>
> diff --git a/fs/btrfs/locking.h b/fs/btrfs/locking.h
> index 35036b151bf5..c69e57ff804b 100644
> --- a/fs/btrfs/locking.h
> +++ b/fs/btrfs/locking.h
> @@ -199,8 +199,13 @@ static inline void btrfs_assert_tree_write_locked(s=
truct extent_buffer *eb)
>   {
>   	lockdep_assert_held_write(&eb->lock);
>   }
> +static inline void btrfs_assert_tree_read_locked(struct extent_buffer *=
eb)
> +{
> +	lockdep_assert_held_read(&eb->lock);
> +}
>   #else
>   static inline void btrfs_assert_tree_write_locked(struct extent_buffer=
 *eb) { }
> +static inline void btrfs_assert_tree_read_locked(struct extent_buffer *=
eb) { }
>   #endif
>
>   void btrfs_unlock_up_safe(struct btrfs_path *path, int level);


