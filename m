Return-Path: <linux-btrfs+bounces-2295-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 311E9850357
	for <lists+linux-btrfs@lfdr.de>; Sat, 10 Feb 2024 08:46:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 81826B23BC9
	for <lists+linux-btrfs@lfdr.de>; Sat, 10 Feb 2024 07:46:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F0C232C84;
	Sat, 10 Feb 2024 07:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="USyFTbDD"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5D122E858
	for <linux-btrfs@vger.kernel.org>; Sat, 10 Feb 2024 07:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707551173; cv=none; b=gL9IWmUIih9FBnFTDYPgyuq4kavYhDl2Cvl7VInVIyaoBy2/GFAyMK5t+evXMotT66H2Rkgf1OjQ0ksAqSPk8kgk5C4E2uYdEK75CPXfXf5jJEwf9dgw8s0jl5oRtUgsCJTb7T5PFBemYgVqsv1rMa6M9vm8CBpvoGzJTTOpyeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707551173; c=relaxed/simple;
	bh=hrpLwmL/2JZyZKJUFyxN+WWVlpsLv77IQ/BKKuz9LJE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=tZn3PZW0fk1HmNq8qpYlQv4+AGX7FcuFFs3oa9Npu2byeqmQSCKA+RNi1KfN+00wp+y0DHLVorMbb9iFnBACMbsP8Yrkvz7eAmpLeUzGPL7BTWQYXWG9khExYlhwJaa3nstLLqGYsOO7UEIwpcT7qsTSAv8+4KJsJqeWmccNk+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=USyFTbDD; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
	s=s31663417; t=1707551166; x=1708155966; i=quwenruo.btrfs@gmx.com;
	bh=hrpLwmL/2JZyZKJUFyxN+WWVlpsLv77IQ/BKKuz9LJE=;
	h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
	b=USyFTbDDzbM/IQ2jdybTaSxLRgOipxCbSzP/zGug/NxVJ+fD/eEmqB5Kpz/EYtd0
	 fspPFjeRcoqEVAdIUjBm1961xOrX0klDRYd7CELeDGgoW0xHNl1VTSjHFyoPxxlHx
	 jG7o6FWE3EnESihwuxKfJ92AAm4g9DynhRIplPJ1y9rOoQje4hvyaMwMGiyZp/NnZ
	 wE8CefNE4Vnx7yajmmDKUW8E6Jzah4v6XAmrQ3QIqmnF3N+nHS13zavsD+jlQ33sS
	 63Ldn/nNR4nTuzxG1nQ89KmiQ+IpsznB1MH3oSi83qTjwS6KO0HSR17/7jVXXNlb2
	 m5xwSt88Eyd1w7lNig==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.101] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M1Ycl-1ra4py2En5-0034xq; Sat, 10
 Feb 2024 08:46:06 +0100
Message-ID: <c2a8f540-0a8c-43f7-a53e-e707bf3b5d8f@gmx.com>
Date: Sat, 10 Feb 2024 18:16:04 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/9] btrfs: assert root delalloc lock is held at
 __btrfs_del_delalloc_inode()
Content-Language: en-US
To: fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <cover.1707491248.git.fdmanana@suse.com>
 <a3014d9834055837c00d4998b313aaa128e1b4eb.1707491248.git.fdmanana@suse.com>
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
In-Reply-To: <a3014d9834055837c00d4998b313aaa128e1b4eb.1707491248.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:iZ9G5tl+p3oHdipOTkdl8I4FrHzDgXT8mw35Qmy/kOSd4BFulyC
 bCuHansbL3AfZGXdUbTY7ssNsl2canRgdNDWXTxvJPcOBGCkR+z389A4fzeXNoaZjxlfkps
 e+T0aMnpzt3pWvDULTHmBFANqm8f9GpWwAXXZKYjFz6aexGyuRRRZJ9vSLj09yb0Q7fXzKA
 j/T+7bdggoBfbEAUxfIJQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:mMxQYj46on4=;AR4fAdN8vtpsRUPEmW6mfLbwEEJ
 NY6ckQf50z3Sx4CQtkUkh64fZ9hccNJWndNQ4vVBLIH9paGJgWcsqZoPO5FgPMrgBhuFSl53e
 rkDPrMWIoo+AtBsbQD4hf8ORJHPce90IXeRAq1PBnfQxXBfFF65bQk+lmt1M97xGxwNeDBUCn
 2fWnNYO8zV44W9mW/iaB/43PT8DKvfWQCflEeOR1K8NuwL9RTB+Hn/R5EVAnwe4udFYPZ7452
 znuyqRClFTqUGNb6kQFo5S9uMQj7idPrNd9hQeNRSBGK3NXicaUcm/IrJ3Aey8XJrnJReMRS9
 w4SpGXO5isgDhz96kzH6ATJ1JlOMi0hkeY8Zj1FrdX9lhL6ijYAksTrLb8G1Jh4mPNaytUYIa
 fGn5C+cAzKBimNdGGd31OvgHOIma1W6+NvFU2608MDReC4AK4O0oMxFEFPa5gs1fyvan9goz6
 deFc/r89aJI+MGq3oFMVYmfdW6y8QBg8TKWzUcmtJ4hsKlQ5RNs7P8p03k+SGzw8up2XGgLDl
 4FQkV1slzkPdnCitLhFHy6JFnPFOIW/0O7QEK393/8to1MnkhGOT6qgZ+9pTYSagZcPJMRnHa
 unEfyLBxdwrePA7gqAsAEnfZ46Y5gOoF4F081/yEOT+ZnfxLgArJGCPWdZx0GqsRN6tCxffJK
 gS4a5kqCOW3LXYYcyNe3erll1/u54RD5Pyh1RbJ0TCOFNYKvCU9lSnQgpke6f7A9yM1NfMopN
 16+ZYIrkt9qibUrJAQKrmISKdGo6NaU8rc4HUA/Vmtx5tl/yyOgen9NMZTN+MYWuR/QC3WR+N
 CTLig+io5dsF/cmGQ1/c/dw0DW+CgpyQ8rffhFhOIi1Mo=



On 2024/2/10 04:30, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
>
> This function requires the delalloc lock of the inode's root to be held,
> so assert it's held.
>
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

> ---
>   fs/btrfs/inode.c | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index ec8af7d0f166..3a19e30676e8 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -2411,6 +2411,8 @@ void __btrfs_del_delalloc_inode(struct btrfs_inode=
 *inode)
>   	struct btrfs_root *root =3D inode->root;
>   	struct btrfs_fs_info *fs_info =3D root->fs_info;
>
> +	lockdep_assert_held(&root->delalloc_lock);
> +
>   	if (!list_empty(&inode->delalloc_inodes)) {
>   		list_del_init(&inode->delalloc_inodes);
>   		clear_bit(BTRFS_INODE_IN_DELALLOC_LIST,

