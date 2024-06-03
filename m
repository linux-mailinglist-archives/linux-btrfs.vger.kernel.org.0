Return-Path: <linux-btrfs+bounces-5426-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D5F028FA61A
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 Jun 2024 00:58:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B1271F23A95
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Jun 2024 22:58:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EE0513CF8D;
	Mon,  3 Jun 2024 22:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="U9q3Kkv6"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25E7413CF8E
	for <linux-btrfs@vger.kernel.org>; Mon,  3 Jun 2024 22:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717455501; cv=none; b=oUI+JtXNVTirrSwhvv0ccfDPnNAcdwMhC4D3ZvMSqTWg3Qk6/FS8lACP7VbGZMavfJeFvwJ+FioKsSRUiwbGiACT6UdEsUoIHTYxlOMwUPw5gNENJPkyNQqK86+F91q6p1jqM1GGPfGJLibpWYnAQUpUjtALR1x3BLUHxEVFBOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717455501; c=relaxed/simple;
	bh=7JDZSyjhmu8MQ3wjQd2RsA9tSgCC88e6PzPnDDS2ShQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=qbahurA6HYiX6cOW/Ffn+OoN8HV/qgMd7V+a46A868i5h2rW/LtPMz/HvY8CrJVLbJfbxyNu0bwuDrh7t9LVrfJG0vszJHgDhvbJwT9FJImjML2z9RKWSdWjPc4oRsnMpJaUlO12INHDSbL8vyzd/NNoXXqeQJTSNrr7YI6zI5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=U9q3Kkv6; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1717455492; x=1718060292; i=quwenruo.btrfs@gmx.com;
	bh=919IVG+LZiSjnIwx/9+brBz2dTt6eXZrAzGUCYcKdHI=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=U9q3Kkv6Heps83JC5uHPzO6A8ZlRr2HBGCfvLJsmDdCE5v4OL2+W8bOBY743HZHF
	 ZSWMqf7UDl6mbe/bBbeh7VHYbirb5PICpmZK6yCyFDq9XIFHdvQPXQygEJbZ3ncpk
	 MmnwQCrnuIF15wnECsbu6ExsXdQvswDUrM1ZxrpKbNjoBOcVvtC0Jz/X5mBMMydFN
	 +DHRM7C7Ts5wfPKjnGNeenLqsQiqV5eVDn2kxCe8kY3MFpLf4vxGse2vWFogpXX7S
	 mKZ3AXiBV/HPRu9XxDLH80LGPn2bhGasL83wdc3TbA999fP6zSBVH+B2ezNJLVeLz
	 hwzo+hJHSMnh8CsHeA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.219] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N3KTy-1seDTd273S-010Pwn; Tue, 04
 Jun 2024 00:58:12 +0200
Message-ID: <c445c0fb-7a61-4127-9281-13a7c84494a7@gmx.com>
Date: Tue, 4 Jun 2024 08:28:07 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: fix leak of qgroup extent records after
 transaction abort
To: fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <0a4d66f6922f5219c7c8c37d88a919304abdbb55.1717416325.git.fdmanana@suse.com>
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
In-Reply-To: <0a4d66f6922f5219c7c8c37d88a919304abdbb55.1717416325.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:00AjCiV2EbqcRaVYbnobGLrtCqVRShhaSfhVNJI6fcjbh2MKWww
 P4lQtcKv+0nk4DNCHmzEso0rRu57NQA3SYc0f4cxIeSbX3N+EwfE8m65o58qIHJp7JZ77pk
 B84yubQ5tYhKrngS+vqobWlLviRj6GAabWZsXT/qXm8G0HLAva8qUY6qYOQGwVNPF/4Hy+s
 v1VnSbJEx8PjzebanTWNQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:+UECf9GpeEs=;cXzX2z8TMQybKp5HsWyAtZJfK8G
 joErNYUV0OMavtKmAiPZ4E9O/gck8ULB8YzOh6v2zGcAVDpil+9DdtZD83GfC78J0mPBZBXZj
 4uVKq4VAOSm2QXmJ+7DTWYdyf/QK5TM0jci6pSOUMSrdGQsIwseUxq5A8ewD0lN051bPU83So
 b5+1V0n/cyCZ9VLnbfMgKO4BS2xl5lrv3yn6FjCSYfALurl5EoG8vWCZXtGKsSvqyneyZKMim
 wZMStJ2s6lyE/1j+P+yQYXgq9M5pXtgdmC44acF4xHYTsbgdcjRZh6yxqo+CPvYeZykCO6wHr
 T8vsHfHCRfFS+JtWzcoUJwBygH7GqXYbYP1V7PKvSNU5BQsSQrAEffEZ8tncN7jbJ7i/toFx9
 JeFUg2VpwPA9+7IcdV63EtYQKTSEtbkBHUuAKtFRnAP2MXttbrkQwm65jxTjb9ahrluUT5Ye5
 pvS9VcBApLTv+dNn/o0nmu7EgCuNPUGY7x77H0PAVu3GmelaVLswEWwQNsjXSnVnMvZ/bMTJh
 3gfWeSO1HZuxX7qIkDbel4DfkczjDKqaJBaJ54pf/qvXfdkl/yl3ZaKVgHfZWEH/1+ZxAVzcw
 mvcSEbqX64WUsjzHh93qt85xhlSHC8FYWALT2Tt8k0rbeyPCPX3RYKgrzbymLtvDCoCwoqM44
 eYXJncaS68OSGe22L/tebwbUVyLVVFEqtKJ5TOe/i6LqbBjmofulES1yJ3IatXAhfaWUF0/UL
 /H2SpKi4MRZ+8It/hhVEnzgl06RY1L77YBivVXtqG8qoZDEYvhQpmpu572QVQzryE0Xxs5FTT
 9sAEadBK0BsioccwFX0JuUNsiTEtGM7aCzJ5Lc0/KJV5Q=



=E5=9C=A8 2024/6/3 21:36, fdmanana@kernel.org =E5=86=99=E9=81=93:
> From: Filipe Manana <fdmanana@suse.com>
>
> Qgroup extent records are created when delayed ref heads are created and
> then released after accounting extents at btrfs_qgroup_account_extents()=
,
> called during the transaction commit path.
>
> If a transaction is aborted we free the qgroup records by calling
> btrfs_qgroup_destroy_extent_records() at btrfs_destroy_delayed_refs(),
> unless we don't have delayed references. We are incorrectly assuming
> that no delayed references means we don't have qgroup extents records.
>
> We can currently have no delayed references because we ran them all
> during a transaction commit and the transaction was aborted after that
> due to some error in the commit path.
>
> So fix this by ensuring we btrfs_qgroup_destroy_extent_records() at
> btrfs_destroy_delayed_refs() even if we don't have any delayed reference=
s.

Will it cause some underflow for delayed_refs->num_entries?

As in the rb tree iteration code, we would try to decrease
delayed_refs->num_entries again.

Thanks,
Qu
>
> Reported-by: syzbot+0fecc032fa134afd49df@syzkaller.appspotmail.com
> Link: https://lore.kernel.org/linux-btrfs/0000000000004e7f980619f91835@g=
oogle.com/
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> ---
>   fs/btrfs/disk-io.c | 10 +---------
>   1 file changed, 1 insertion(+), 9 deletions(-)
>
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index 8693893744a0..b1daaaec0614 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -4522,18 +4522,10 @@ static void btrfs_destroy_delayed_refs(struct bt=
rfs_transaction *trans,
>   				       struct btrfs_fs_info *fs_info)
>   {
>   	struct rb_node *node;
> -	struct btrfs_delayed_ref_root *delayed_refs;
> +	struct btrfs_delayed_ref_root *delayed_refs =3D &trans->delayed_refs;
>   	struct btrfs_delayed_ref_node *ref;
>
> -	delayed_refs =3D &trans->delayed_refs;
> -
>   	spin_lock(&delayed_refs->lock);
> -	if (atomic_read(&delayed_refs->num_entries) =3D=3D 0) {
> -		spin_unlock(&delayed_refs->lock);
> -		btrfs_debug(fs_info, "delayed_refs has NO entry");
> -		return;
> -	}
> -
>   	while ((node =3D rb_first_cached(&delayed_refs->href_root)) !=3D NULL=
) {
>   		struct btrfs_delayed_ref_head *head;
>   		struct rb_node *n;

