Return-Path: <linux-btrfs+bounces-5315-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DE0578D149C
	for <lists+linux-btrfs@lfdr.de>; Tue, 28 May 2024 08:42:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94B49283A88
	for <lists+linux-btrfs@lfdr.de>; Tue, 28 May 2024 06:42:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E23B76BFD2;
	Tue, 28 May 2024 06:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="gfm9XgIL"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 800EA6A039
	for <linux-btrfs@vger.kernel.org>; Tue, 28 May 2024 06:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716878570; cv=none; b=bqimRDlKUfHZUN7XG8FxXcXPecRcLmT7jlgpVm923D7XM+ASIob5BA/4JBWVYFcYZvhwEYHC0EdKcbAfdSj7oDC4uThx5fEMxxa8w7zU8PPppBbBfyA659+IY2ntMAQ3mCLrozA567LW5e9DeHD7MuHTXYrXApDTT9eKrWayDo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716878570; c=relaxed/simple;
	bh=E8X0sS+rI7Jzup+vNd1Q4CwhHQaVNYltihHZJQipSak=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QdH3FNMzzs7cl4UJn1YKovNIeDAFUQvNwuKkp06g8QBNGCch3/3rx/o76ZYh32rLDqOizh0VjVGQ+jnKX22n0x6IfGUGMiMXpUVXppJZNmKKDzMnuOwrr8s+ZyJMwghvmUdSP/ivoXtfs5iAf+U1pHAZOp7F0/au1dpdSq58cw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=gfm9XgIL; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1716878559; x=1717483359; i=quwenruo.btrfs@gmx.com;
	bh=ptVqBN3Tiz11LyWk0xfArdaR/nGVFfuY0hPp18iv4VY=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=gfm9XgILwpuschQDIS+RV3SxFqQESoHAExdnualEXn3+P81OmMQ3l5Zhbs03/aD8
	 lBA0mDXsx4/YUMKXc4Sg/T4ucsfFed4/3SgokTYzpu8BvQ2O7zlK08N8stEujgvQN
	 Jc+70ERoABPde8bnpT4HbQ++iovL4JUzE7slMnARpQLESNRawhpcNmkOkKm0knGBA
	 r+gHMiJ80y2kKbxjmzrDlCR80XFzllZoiqrJ7I5is8w7bg0SyMF4+z4g7ufskmL8p
	 Icg9vO0A1mBByHOoR9MKwdXlerBJvN0TCUL+AbPoLXVyUDA+zCRZV3wjsT4JqNo5v
	 IYmiEKp3mP4U4ZulJw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.219] ([159.196.52.54]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MybKp-1sPuRX0RlF-00vbpG; Tue, 28
 May 2024 08:42:38 +0200
Message-ID: <42631f4d-97ca-4f7b-a851-c06383b35065@gmx.com>
Date: Tue, 28 May 2024 16:12:32 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: qgroup: delete a todo about using kmem cache to
 alloc structure
To: Junchao Sun <sunjunchao2870@gmail.com>, linux-btrfs@vger.kernel.org
Cc: clm@fb.com, josef@toxicpanda.com, dsterba@suse.com
References: <20240528062343.795139-1-sunjunchao2870@gmail.com>
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
In-Reply-To: <20240528062343.795139-1-sunjunchao2870@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:YR8ycdgwbZMfeCIraY4o2/TcAVTY7Lq3yMy/C/oCgUj2ZO9vVVZ
 hSuh5AexLi1410/3vF3GTLPhq1C3vADhWXvYK7fX7v2cTBOJ2jPOOdWfo+At/cEPi7nsyKk
 pFFEJQX9Me+twcbsHRjI9uUZhvFm7icVNUaD86ep9BmgRQ4ciEfxFj1xG30tDuUeSJOdgL1
 jX+jzn0Ie/mb/Y02C1kCw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:XkOaafylbgU=;mMmogNjPYqS67qH7bbvoteHjYQc
 oXmd6NIhlXjoucFW3u3kn7Cg+VITAu7nCQu1qLE9cTVWKiHqFVsz3HvRV7DnEBs/10u0kuEwm
 Jr9oXNkLLx5nsgYC4JHuaMDSF3l6PhzsocUjIO943XILVPqHoS7JfwhB05LJyY1BncdWMzKQy
 Gi4lITK6kf1+mA6yg0UaABlVIhT8SrEdb4s3q6wEebKKIGeE0bKCNRt8DaFwrnVroZSaT0EyK
 UAbMisUOMSb3sjMKORKJP4pMHTjYWxjVh62LPcza+cs5GRmT+4xI0ay1kysvGubqO/ED5W9Ke
 NSIIaJWL90w8BiiNz6Qrj/46tE+Tfs3ou8kc1ZJK3TfpVraJ803z/qF+k07AvbE53z1S3zqnh
 +sreTvXY2+5Yl2AmCTZsSzq/nNqLnWIStS6LdtxOfJknVBfhIX8Xe9m1hZXw2tKjNWkYq51tl
 frxejIVq893NXT0TyeBjAlcqdz1KzhgpgqSGJIfmuK0QUkfW1e6wcAM4M9rIOn0AZ8wG4lmz/
 Zg5cs8U0petwI/Gtg22+Zv6KuKDqKzc1K2IJAqTRb+LDz01i73j476jh0x5Uq/8TaGsJQJCKt
 qjiFKu3roYtPEDmLDvUB/abODoa3JHOEgjhCPfJW6kPHC5Xwohcn4gvvbhoXQSEap3CKDYjNV
 qQGV44g7wcjMEteG2LfGe2qzVBQYFx1zl417pKcSGgrBPbtw4ZKmydfGu86Oq8WbOgX9fJ+wG
 Ymtw4czSp/JWMCKUUW8+BdD1zJXxnn1jIWQLH7zchVVU3JSySIdqTnkpko314s3BvGSjNZ4zE
 LieYmGw1919kgoKlqJ0z/MauQXCJ2GVhVqLo51yqfzELo=



=E5=9C=A8 2024/5/28 15:53, Junchao Sun =E5=86=99=E9=81=93:
> Generic slub works fine so far. And it's not necessary to create a
> dedicated kmem cache and leave it unused if quotas are disabled.
> So let's delete the todo line.
>
> Signed-off-by: Junchao Sun <sunjunchao2870@gmail.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

My bad, at the time of writing I didn't notice that qgroup is not always
enabled.
Furthermore nowadays squota won't utilize that structure either, making
it less meaningful to go kmemcache.

Thanks,
Qu
> ---
>   fs/btrfs/qgroup.h | 1 -
>   1 file changed, 1 deletion(-)
>
> diff --git a/fs/btrfs/qgroup.h b/fs/btrfs/qgroup.h
> index 706640be0ec2..7874c972029c 100644
> --- a/fs/btrfs/qgroup.h
> +++ b/fs/btrfs/qgroup.h
> @@ -123,7 +123,6 @@ struct btrfs_inode;
>
>   /*
>    * Record a dirty extent, and info qgroup to update quota on it
> - * TODO: Use kmem cache to alloc it.
>    */
>   struct btrfs_qgroup_extent_record {
>   	struct rb_node node;

