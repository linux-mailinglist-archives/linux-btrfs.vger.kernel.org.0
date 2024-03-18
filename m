Return-Path: <linux-btrfs+bounces-3344-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C5A887E566
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Mar 2024 10:08:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07DB2282196
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Mar 2024 09:08:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DA0A28DDC;
	Mon, 18 Mar 2024 09:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="eltQh9CT"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FF1425634
	for <linux-btrfs@vger.kernel.org>; Mon, 18 Mar 2024 09:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710752898; cv=none; b=UlNDBuKFFWLqZULRIGIex/DPt3frC2KVDIwWLiXdsu08+RB2MeQZoyrOiv3RAo/Wbk4VaAOuIQocyNlLu5U7XQJCVv5nQVVGiTRsk8h/hB2+AFiE59qaPygTQUCWksKkOfO+x4AuCvOf//3rzzV2S4fgi+sZHtBJJNKQkmuCnB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710752898; c=relaxed/simple;
	bh=POxkw04zxhfXNtK13GojKb/SpwyDQpON5eacHEUIGPA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=V6AqIpX6HKOy5Y5BK+vvuQB43aj0k/q4hKC95P+xw+HBGiLqmszzd0CP4Pi6/xeM/InZ1UDQ4WC+m7eeEJD9+xBLrSsZtERrbivph3X7ZNXqL5hLaHDJBTYuus/HVZfEbhoQKqaHPCHyCfO1OjQ5w7KOYabC2ySSBnO35nAEMI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=eltQh9CT; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1710752889; x=1711357689; i=quwenruo.btrfs@gmx.com;
	bh=nZfRdaOMm57oxSreaIcg7uPp+3lMTFhmnGLwy0kC8yA=;
	h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
	b=eltQh9CTaUyHv73i0Fr5kWk9fsEDBZgS3/p8Rrq2ggm2UdrGqc/jOYAaH4+j3fWv
	 NgZmdPrJf5U4MbZ7bt6O6XMkwF5IHRibt1LWIzGCf7s9+xY50zKwL0LaxqYYq0fLR
	 6GBbs155wm1Aob3M5+Ku9zwjtAVCWvD7N65SmkyazmYs2NAjY09XdjlANgGd5p6fW
	 WXkN8a8eEKnim/fki05qmu2YfrZvdnRU7BYvJRmE9zaBPzACxdLnNVf7joZK2zPJL
	 Pmbbrh1sUKfn/W+TN7YxRmbiDmd1eSSReXGCiWlDOB8+ENpHpFQwiqZg/JfykOCm2
	 DhaN2MGTo5yW2esT5Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.219] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MpUYu-1qyqBB0eXU-00prnA; Mon, 18
 Mar 2024 10:08:09 +0100
Message-ID: <ccf78ecd-a074-4a39-8873-4dc36f4d9267@gmx.com>
Date: Mon, 18 Mar 2024 19:38:05 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] btrfs: trivial changes to btree lock functions
Content-Language: en-US
To: fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <cover.1710506834.git.fdmanana@suse.com>
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
In-Reply-To: <cover.1710506834.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:X81zGgw7CjIpBJHXYHm6p0pX1toOgGySV9Up2Hx9m53aWu0MhOr
 T1CkbtYyBgvqzjgvvhFwZr64up6raCesmtJQbCBsuVmJDGzvgix4ARExlE1BSNZPbHKwa/c
 yc9W22KvWmFzQQhFK3JK4y48qEszmwetXMgPUebVZie3KZnYMnZFPcR3t9Y7ZWQkxku5G9E
 mloLJa/Vr74WPOjDkUW1Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:/afvZ+tpWfc=;ier8G4XEgPG4T+ph3LeY7vEdFX3
 wOeIjCXLWnSBOe6QKdoXRmh6ownKHogvV6J+GLilQ+KODC0FX6cMoWLcf16uMizuX9imZPQBo
 puKuCxoyhX1OQbI8/TlJIiW4DxOurFJ0WLi3qXS2r3FcIOCkACI7ym/g9alpC2i9qYBE61+RD
 LUn4cVQmFc404vmviI+itaEZtjCXnyvuVXyptL3SiFvGwC4txu+Bi+iXFtFbeCM2QNVwCVlA1
 2P+yBpl+tQM6ifv+niPTWmnbSHj9TqCD7UmOqPxEps64ttVSi7ZXpzbAojPOVNIxNBWpvotcZ
 RiY2gAbErIN2MICDdDM7TdT/a7Y+EfQ78j/WRdy5YvxJgfUwr8A0v8ljkRykK9WCMqD2yC7O1
 snifIfVD/8CGWbxTkwhKR+kPxhI4doP0T72BXIzJUM960XUTP9w87kYoyVz5LEkQhqYiKQt9X
 xHs0skYlXxysk+b/t7f4SIz0py0zzS8jVyK5W4NrTQWmU+MvOzfB9Z6BLNWEObg7h0EN3hhIo
 JhWKMi7YSlwOxvLMHMkDOPXA4LyhYqTFkqH60eu1+pD9IuryO2qX8navQvQoZZdDGwbLPBViP
 XOpjhFmkOXw268dhu+kITHpcM5M15klzJUsSrWJBd8HrW3bnlQRldsaKoNbbqLW8Z9X+CxaAv
 Kj00f/m8j/9z3X18mRYERolkorfPLpvdnrH+r0vpMYYdwIzL/u7BGtNz6CrJn8W8DdqyR1/Sx
 5YsMzzUyUF3RznrEjn7/pkVgCdvZs1ax7gY6mjYaGELHMOp43U/0IkpoYvTYqax4aVjCxoKho
 cd1440y9LRR6/gwIdHzta4CuYctjKA42dEZmYndx1JKsM=



=E5=9C=A8 2024/3/15 23:25, fdmanana@kernel.org =E5=86=99=E9=81=93:
> From: Filipe Manana <fdmanana@suse.com>
>
> Some trivial changes to btree lock functions. Details in the change logs=
.

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

>
> Filipe Manana (2):
>    btrfs: inline btrfs_tree_lock() and btrfs_tree_read_lock()
>    btrfs: rename __btrfs_tree_lock() and __btrfs_tree_read_lock()
>
>   fs/btrfs/ctree.c       | 12 ++++++------
>   fs/btrfs/extent-tree.c |  2 +-
>   fs/btrfs/locking.c     | 16 +++-------------
>   fs/btrfs/locking.h     | 18 ++++++++++++++----
>   4 files changed, 24 insertions(+), 24 deletions(-)
>

