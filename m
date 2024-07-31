Return-Path: <linux-btrfs+bounces-6931-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AD1EF943909
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 Aug 2024 00:37:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2EB551F23497
	for <lists+linux-btrfs@lfdr.de>; Wed, 31 Jul 2024 22:37:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA84016D4E5;
	Wed, 31 Jul 2024 22:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="MRlxLTQK"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F252B35280
	for <linux-btrfs@vger.kernel.org>; Wed, 31 Jul 2024 22:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722465447; cv=none; b=p7xzWB0XYCC/W62bCxfvG4ezIBy/vHSol9lpLXEmZcHElD/XzdSTOfzfy5rnALhimjZALE+Gzpssm69TurfGSeO6wstwfhxpnqbdNwrBTU06/DClD7Qz71TUgqqp01GB+rRDFPcsORLT7opabqKKvjl2Diiv78fpyZ4b+9Hp6Oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722465447; c=relaxed/simple;
	bh=ibEkBt48XdAPW5ShswGAwFakZPJ2zOlYNQvke1ox/tc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IOI24bP1njQMszf8Plf7cO4a6J2rroO243ajlUmT91xX99DhL9ogkEo/OP+ytE46xy2VMBcO4aFM0gDzchweriIVvaH/NKkjoRDCo1FRlQllPCHEfVTJA0CxrVGUoVfWFggw/9xF22riCF2B7Udj7o3DtHRyN0ymUEpQpxHtZ/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=MRlxLTQK; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1722465442; x=1723070242; i=quwenruo.btrfs@gmx.com;
	bh=Q1DaGZQwcG3IZ7aczNaqwOtjQdGrNwciHdR++RdQ9Jc=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=MRlxLTQK/COroxxJGstJELB02BUkg3YSfnossjLwQ7nqsI+uM/wKPFIBq9BX5act
	 33PkBz4QsgUrA3eHATiFAA/l9V1Wzbbaua2Drx5LC8uNS2deeaVBcihw/1J3jdPse
	 yGmwhdBQ5YQTQXdW3G/tGR+Kk6j4uXGPe4Hr+DBhRX6rP2LKCo2jbE2MAckQgK2Xd
	 FWMrXqiVSksXdld5zWB+F+OUJPOBH3KJwyofErj0wbNobzpPPEIKgTat9HcVFVZ0d
	 pz7rPhfzIP5emBkDX47M1BOOC+RK0EC4IbLHNczBgH5TeMXrKwFEAMAvRKcRm5oPt
	 gHjzs9QO/i3gMY6SpA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MMXQ5-1srmR42bBP-00ODQR; Thu, 01
 Aug 2024 00:37:22 +0200
Message-ID: <13e9de20-f023-45a4-a133-0464d3811f15@gmx.com>
Date: Thu, 1 Aug 2024 08:07:18 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8] btrfs: prefer to allocate larger folio for metadata
To: Josef Bacik <josef@toxicpanda.com>
Cc: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <c9bd53a8c7efb8d0e16048036d0596e17e519dd6.1721902058.git.wqu@suse.com>
 <20240726145753.GC3432726@perftesting>
 <d5473dd9-69ca-4df3-b4d0-f9d7b0a46a86@gmx.com>
 <20240731151135.GC3908975@perftesting>
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
In-Reply-To: <20240731151135.GC3908975@perftesting>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:+fTSvxMpkhyZJmegKiAoIvfeEnaNvz6PH0Ndq6i+52aB3PpeI6s
 orM1G1OcohAlyavArrh+QDb+K6rBFbL/NYMkof6RTWvNIrZN7YE/2Se7LFnSnA5YycNlw55
 U5vpXknnXoDpH0e3Id7ADywKgQPMt8bm0POGra1Dwd0NVmgLdyUCP5zwN+UW59QhESGmCe6
 tmKdZRkX/YJgfOmMZRL8g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:wBPunHg22NA=;lQgf1lk1Z08QioU3KvRD+tJ3Lod
 sUFcF/ARzKi1JKat+ZG0D3rfvA8DdSKApNL/wY3cKqnPMeWLqWW+biFVzepp7vJ7WhLs4mKPH
 fBE4DMWm5jefuE4q+EYXf9svdM2+YOAbmNwhUMn3eRX6MAuHYPWQbiUoQpoo8W6R6pkfkVAQh
 eji1KkIp4fMJGBzQZuaNBvoLRCV1LGcLuS49ntBzE1i5caiNMBGA6Z4JROQY5GcD/qzbygQc6
 KAdPGgy92RXZDamppvCboRDs9Oig8vJCZck2PviHNnuzUIR4sBgoFSF5OtJdSptOdf/bCbEp9
 2yzRNPCJXbRVec46gB5HCWt7VmVS9LtfsUQY9iy8XloBgpIvvVeLlODtkTV0RlH8c8KST5jzi
 MN01JgPTybvs15qgu6jdpzThluY2979l1ZCnAae4I3+YCAVW+6i7Y9Mi/8oIdyKTAvoJk7FfR
 EfF9KUR9byVsrBefKJNi1oDuhHrRjjh+iXRmVFah8XU8wWikfIjj2NR40sFgo0uqAuFCV9FWu
 MoBAY/PXhOgmlI5sSdPR3ATsz9Y2Co9uzCJCXcHKDZT25rudZO9mCNYvC4wHD2BT/JXQmenCu
 1gp2XECtdbgZBh+ThtGBq8v8wMOmo8rHMBXXmtyGgHUJw6X0POTUjMhENicUof0sGWdDog1aa
 gdzP0ZsZmM5MgIKGHX6xml+MWCVrt2oBSet69QmkS8av0LmOunvJqIQELpDi2pST8xrqukv3R
 q9sBRsMEzm52fWCfKjB3amLaPIgDoXeaXUTZdZPOjIcbn9QMgo1dLhbWP6PR89FfAC3nPawFb
 SS9vdHX3Ru3LcQ7dchLyu3GQ==



=E5=9C=A8 2024/8/1 00:41, Josef Bacik =E5=86=99=E9=81=93:
> On Sat, Jul 27, 2024 at 08:02:26AM +0930, Qu Wenruo wrote:
[...]
>>
>> And in that case, they do the retry if filemap_add_folio() hits -EEXIST
>> just like us.
>
> You're right, I misread the code and thought this was the normal path, s=
o my
> whole rambling was just wrong, sorry about that.
>
> However if we're allocating them at the order that our extent buffer is,=
 this
> means that we previously had an extent buffer that had 0 order pages, an=
d these
> just haven't been cleaned up yet.

Yes, and I believe the situation is caused by the usage of (NO_RETRY |
NO_WARN) gfp flag.

And the fact that btree_release_folio() only handles the folio, making
the remaining one still attached to the filemap (requiring another
release_folio() to free it)

That will be another optimization soon, but I'm still wondering if we
should get rid of (NO_RETRY | NO_WARN) if the folio is not that costly
to allocate, or enhance the release_folio() callback, or even both?

>
> This is kind of an ugly scenario, because now we're widening the possibi=
lity of
> racing with somebody else trying to create an extent buffer here.  I thi=
nk the
> only sane choice is to immediately switch to 0 order folios and carry on=
.
> Thanks,

I'm totally fine with immediately fallback.

Thanks for the review,
Qu

>
> Josef
>

