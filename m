Return-Path: <linux-btrfs+bounces-2297-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 93713850367
	for <lists+linux-btrfs@lfdr.de>; Sat, 10 Feb 2024 08:48:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A768285A5B
	for <lists+linux-btrfs@lfdr.de>; Sat, 10 Feb 2024 07:48:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F0752B9B7;
	Sat, 10 Feb 2024 07:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="q3BtjUli"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99B19134DD
	for <linux-btrfs@vger.kernel.org>; Sat, 10 Feb 2024 07:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707551310; cv=none; b=ZzXtUCzO7PuOsgqqoNvMUH6tgCWw0ScJoV7mA4thDb+UO7hDIIZonRHIxt0wVrQqZVDtEdCNttwkPdHERSL3wOvcQRRBgahKG3MD2fKPqeUCRsyiQS5RWUp6mzd1HolH0bvEbQTj+ud8d39k3Jp570kRyQuyrxeXMAi+DSmA9Ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707551310; c=relaxed/simple;
	bh=SlpJ4gH9pYus3R6S4F2NZ9ge0iLKY7aJ4qNN9Nvaur8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=EFD4P7r62sUonQOWSGYRNoTA4XlERjqSii7XgubaDIc7W+2KJaINBz9+6Zbhcgd5v49zX6kRe6v75oUQR3iJ6m0WPqM5Dwntntirxf8FcG94apPAGoHwOsYS9VaXouvlMeKrzCrngTYD+dQ07+ESoEluKxPYlpnMQmVk60njrUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=q3BtjUli; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
	s=s31663417; t=1707551303; x=1708156103; i=quwenruo.btrfs@gmx.com;
	bh=SlpJ4gH9pYus3R6S4F2NZ9ge0iLKY7aJ4qNN9Nvaur8=;
	h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
	b=q3BtjUliui80PF4j8M95nnnioXtWvQdaG/CyxFQDa+Oon30E86TqLGkyW0hOjgaA
	 qowMXBYPFEuO+q4z4KlG6zn4ou1XAF6lXHorYqkvuR7P4jY7i5GaprqdC1Pn8N6MG
	 t5obHJgPSu0BaHD58AVs3IungswiyFBOjokIk8Uf3Urg8O+bpMqL/X6JBBuh9Z2qL
	 vynxBJGLMAqb8KtMkel7M1JcuzBXdO155z+OKgG4bl0rVEF+pi5StdiWc6d9C69Vt
	 ZnEWGta7nTppsyuiYg6KAN12MZKkKkAr8XHVPGlJ9KIz109sRWiV6p18pDsDMHy/G
	 jN5OnHSk+vYnxJlfjw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.101] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M6Daq-1rfJoE1QFM-006e40; Sat, 10
 Feb 2024 08:48:22 +0100
Message-ID: <a8a495e8-e3a9-4663-bedd-10369a1fc76f@gmx.com>
Date: Sat, 10 Feb 2024 18:18:19 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/9] btrfs: add lockdep assertion to remaining delalloc
 callbacks
Content-Language: en-US
To: fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <cover.1707491248.git.fdmanana@suse.com>
 <3c6359337ba942d628b989cc7458cde4d9a5373a.1707491248.git.fdmanana@suse.com>
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
In-Reply-To: <3c6359337ba942d628b989cc7458cde4d9a5373a.1707491248.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:wMHwTVf7qsu/bad7aTJVgkY8JkQKg8ii8Jhu1hBD7MIy6fq7KrW
 BswtA/uCvHsdfqmDcEOyOdhJzz2V5ZAYNQftnxAXww4Kjenwnyu5BRP0sZBaStttkD8qzcn
 NkIjtjCdYjzNrNXlCttCWWVKzyOxz7qeidGtisO1hjXEeUtQQ9Bu+6e0LcpwBPVtjuc5eL6
 Vf8k6Bx2sOlNXSEZQFXBw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:jMsMjgT74Q8=;XRfYY5l89Jwo+7X6UJB3fRzdLz5
 izbUZuhxhODiK4r+vIG0i5upNIvK4EI84xSgtB4PNFwg4SKaXf1YIEB3dP1f9GaF2or/Ii26w
 bxWEyIQOkiZacr6m97OeoKaPwvnXi6ixeL4CMnJrxbStswaYj0m4Uzpi99H+DOeFsMKu3Sdgw
 Mjl9xlDrsN3MQNsSrwquxc1HSwOykT6yS2eJhlw0VCnOe1rLkZgMQ/s32MzylZMWvQbR56bkd
 tyAEj8lZV9UaJRGlgISwBs1NDdz7lBEgFbQU/7TVoYkA4Ejhpb6NyQD1P0E34CkpjiEsDTrYk
 F5EGTowrLzHkr+i6mQ/5/MjqFqQXRf4peLYI1syinGHXWGj7Tmu6iFtuXjAtBdSLd7NC6lheV
 D1lC6oNOiipOMVteH/WJsv310USuZxRyFoRHm55VxxWu544PE6Boi9bCDsHwyh/silz6ZUNC7
 v7P7XmHX9jEfgPESuBRXL8csMsuMoRwAP7UIDSSQFHT3KLLciMo7t7xDPal/g5lU0m6OM8YOX
 48HGfM8c/vmpzp8xypiW/v17Tc2X4rwiVvCGKMjMbFRPKk82sdNkSYrv0skbcK7rskRSvdxwQ
 bcIsXOtLezUUFHNZS3vvGSFElf6ufFYjUacXLapImshEcFJs8jdjxZ1G+w6S+Y3oLUVmXUTB5
 pxUohbcFLjc/EtxXOJCNgNa3WzOeI3txN+/3NOHoUM0HUKhw4o6HU8+i9BGpSGwb7eVGIwniq
 SpvkhWUZm9QnyJTu+KmB+BABhonsU8qoz7j/7BzfFBoR4V3esFI1FoXxj3O8DemFmzUKPK3jE
 GzmgVO/Db5VyuyoekWUvntyM9gRbKII4tSSETXArV8ASg=



On 2024/2/10 04:30, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
>
> The merge and split callbacks for an inode's io tree are supposed to be
> called while the io tree's spinlock is being held, so that the given
> extent_state records are stable, not modified or freed while the callbac=
ks
> are using them. So add lockdep assertions in the callbacks.
>
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

> ---
>   fs/btrfs/inode.c | 4 ++++
>   1 file changed, 4 insertions(+)
>
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 778bb6754e00..c7a5fb1f8b3e 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -2300,6 +2300,8 @@ void btrfs_split_delalloc_extent(struct btrfs_inod=
e *inode,
>   	struct btrfs_fs_info *fs_info =3D inode->root->fs_info;
>   	u64 size;
>
> +	lockdep_assert_held(&inode->io_tree.lock);
> +
>   	/* not delalloc, ignore it */
>   	if (!(orig->state & EXTENT_DELALLOC))
>   		return;
> @@ -2338,6 +2340,8 @@ void btrfs_merge_delalloc_extent(struct btrfs_inod=
e *inode, struct extent_state
>   	u64 new_size, old_size;
>   	u32 num_extents;
>
> +	lockdep_assert_held(&inode->io_tree.lock);
> +
>   	/* not delalloc, ignore it */
>   	if (!(other->state & EXTENT_DELALLOC))
>   		return;

