Return-Path: <linux-btrfs+bounces-5725-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 18B26907E49
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Jun 2024 23:46:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD04D2868A1
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Jun 2024 21:46:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35BCD143C53;
	Thu, 13 Jun 2024 21:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="XC3pwXVd"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E8DA6F07A
	for <linux-btrfs@vger.kernel.org>; Thu, 13 Jun 2024 21:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718315177; cv=none; b=YvXF1bKFekphSXqzqogPieH4zRyN4mb2aGWXLdM2k015A5N2WpQu68VRPRJN5bI4mykMTSa73bIop0yauFLgk4sT1rswNNQH7AS/4MS/ZoeHMp2mf4SKoKWiFAEtAAHvPzY29c7WU99oGexbjML0iXnwyj+ecBNjAzhKTluRbxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718315177; c=relaxed/simple;
	bh=azpP8FsTFLbO9A5jVej7N51hcUGugYTr1/UlpoQF23Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iX6xOvaDDEtJsIRWrRr9PbYOynD2mOcRim/dRcTm6aY9GlKjjnrjg06xDtV5wcvOFB4jxg6bSkY3nTfW9ulEGhZHV1CXtiVsQ5a5A890uGr1ddfuWkcjY5SWO4lk+57ipwsP6P+W3wjJLcSMRukIJsJiQJUhPKZVVXVnAt+mC6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=XC3pwXVd; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1718315172; x=1718919972; i=quwenruo.btrfs@gmx.com;
	bh=azpP8FsTFLbO9A5jVej7N51hcUGugYTr1/UlpoQF23Q=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=XC3pwXVdFtgchNPcOmn4vim/Ts0kE3/YEL5ht4uOKyK+VTr1h0ikgpZYfncQOibF
	 weckNjhsU0UA3rJEdKQs+HTlz4FNCpf/jveDDTmhriWpGMBINakTqRzJ0h3mIjQdy
	 jOAiXxg1QlHCsqvaJoIkv5DiHA5BQGC8jKKbe39lWOVKN0DuqDRutVm1JenJz9V7g
	 55LxObwpJThfctPajsfrwqFBgX2xyH75ShzrJb2IQZBBsVIjxzyZDtaVOYdImkE6M
	 u6Mj/MAFGFwT/tBgd6+5p8jttAJCYg46db+vp8XuMPQ/pMQldX7xVH3uEU6rqceR7
	 /QRm1Pc54sWvSaQzbA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.219] ([159.196.52.54]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MAwbz-1s6Yf41KWX-00D8r4; Thu, 13
 Jun 2024 23:46:12 +0200
Message-ID: <2e2a6e1c-de05-482e-973a-6899cbc14d08@gmx.com>
Date: Fri, 14 Jun 2024 07:16:07 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] btrfs: introduce new "rescue=ignoresuperflags" mount
 option
To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
References: <cover.1718082585.git.wqu@suse.com>
 <f76f3c993b70aead20d19390f430a1a03a0370c2.1718082585.git.wqu@suse.com>
 <20240612194234.GL18508@twin.jikos.cz>
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
In-Reply-To: <20240612194234.GL18508@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:w6KM2faudikoZkA3HvWi50JpiJa4iOqLELTxTYo9wl4uEeWqqsQ
 2C07sm1ibRKoKLbutQ3a97LUDPWVOyjz7ykH7R7d2358PMci4Z1sgpPr8dNHl2WY2mWuIky
 kkpq38JcwuGWOndZ3QbbN3E+sL9mvOt4mqGAMeazPxklslJH2FZzj28wuPRHAI5Z8lTCqXe
 HkLG/wbbylrQVQFODioWw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Uf6VqL2Z4kc=;FJmyp15XzPOV1hArCo/JPteDrz5
 F6W0r9UmkmwucG2f7tNf5HB4qa1KcrhZBJBZ1bkZtsYVKg592a5LvWpAhlSs+K5+GloSSEL7b
 M7fGKIApaNmgViFVF5ge+deJxkjWaHmTu6vWhYlbQ5XNjPUPrjPCNiJNFP8virez/Xq++qsCL
 3y7c/B4QqcaooOldWRyvBImeFhXPiou1uZNjtlvidgw3B/wdW1kaHjYDNLoDYjTIfDbsAlApI
 rHe5zmIs3sRMOpHKYzM0/f7C7rRidaptMtm8qA/47tXYj9XJPfa4TnQ5IAXS8/9GrGeJxqtXu
 kjCRzYsD39PKjlcw2msz/ChiBBbL5V8T5381u3WKXwW/vLSnej4UhCeCxaLskOe9zBcLGUOJ9
 ANT4AuXzpsXO+D0HWs6FlYAxaIiV2KY6U5CvKCp8QfThfXMMFZQoNkkSppNdM/7TYKC6HwR5+
 +FcZttg1xMnPq5a+hWm6DNZlM/7zz2kabmQUj+CygmXXNiADyONyJIdp1StmEYGagIbeNEWix
 iLhqB0Xdu/UdeoSN5yye4NbbDJbU3+Hu69Zy3MvPXJWgEHBRmNbTVtoCZ7V8HNuUNPnPEOVpK
 GLJoA5d8ivwjKXYe2VujiMyEvpHMeotrKQrdTlveHZ8mkseJL8u6o3cmWX2tWaN5hOEEm1MtK
 F6ZSCVAHWSs99dppySmAst9Dn7uoOy37TpsbLieMbT+Zwb/b0Mh4eSmOOxfLR0d394a+qygsd
 ku/tHa7/cxOSSy27p2rRgNdJRtZ1VmRJC9YMZH0E5ICexHbMpZJmEwyjUqcHZsEQLh0WwDHWz
 6AOxYNl/oPsJs1swIole75+BCrZFg0VT3/PKCH3jO3GQk=



=E5=9C=A8 2024/6/13 05:12, David Sterba =E5=86=99=E9=81=93:
> On Tue, Jun 11, 2024 at 02:51:38PM +0930, Qu Wenruo wrote:
>> This new mount option would allow the kernel to skip the super flags
>> check, it's mostly to allow the kernel to do a rescue mount of an
>> interrupted checksum conversion.
>
> This is for future-proofing but the current known super flags should be
> at least defined in the kernel code

That's already done in this patch:

https://lore.kernel.org/linux-btrfs/57b836631f9c5dcb24ace616bdb76a37b8d084=
b2.1717818761.git.wqu@suse.com/T/#u

> and with a warning or info message.
> BTRFS_SUPER_FLAG_CHANGING_FSID and _V2.

I can add some extra warning messages, but currently we do not do any
messages for rescue mount options at all, since user is definitely aware
of some problems then go with rescue.
(And rescue has to be paired with ro, which should already rejected the
mount once when tried without ro, thus the end user definitely knows
what they are doing)

Thus I'm more or less fine without any error messages for now.

Thanks,
Qu
>
> Same comment as for the imetacsum, missing sysfs.c entry.
>

