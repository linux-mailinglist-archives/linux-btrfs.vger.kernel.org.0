Return-Path: <linux-btrfs+bounces-8118-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CD4E597C238
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Sep 2024 01:46:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4BC3E1F21FBD
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Sep 2024 23:46:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A565C1CB322;
	Wed, 18 Sep 2024 23:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="RhIeWwx3"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BA8A18732F
	for <linux-btrfs@vger.kernel.org>; Wed, 18 Sep 2024 23:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726703156; cv=none; b=c+MdeFKzCdqmqzbaBaSGeETrkMr2fksH+4Zz01trTNO/Fqf1YMHRvLWV1lYuts3pIHdkwbef5/KTozcqlnQbVp6j6D6HF6KivTAoaRmm8cCm/OZtXy/Bd3xwHAP95sWaAvIuYl/87ewZLCE4p40S3mpor7B8evrHV2XZjAvMFIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726703156; c=relaxed/simple;
	bh=oVgWYIVZApIzh4Wx7odik99kFC0vJtoz3MCruouGzdA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Pfo5NKxcOGccYHXL6chcG5Ka41PhegpJVaQJLpKBZsI1S9Ybazgde620kCBMipSgxo0hNcNTy9Nyq8N8nvCNLFkNWwFq9Kl49KBHdyDgmk89SK/CMaAjQ39+i/oUniAkTo3Z+u1krC7HAu4nA7C3IRm0m9/HZHSyKnvWxS1yxwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=RhIeWwx3; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1726703147; x=1727307947; i=quwenruo.btrfs@gmx.com;
	bh=+bR9xqbmTCyR4i0/8cY0bZcDe88EV96GKSobXOjedSw=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=RhIeWwx3ORhN5aOunxWDV5SwKxDplaljZvxU+GUzUqVcfSpXpxvstTGnpF7fRdtI
	 pbpyPAVIsLIiL8tlmC1irA43iRNE/adiwOi8YdZoAnXgLZz3NmfXh+AR/WQ28SXJn
	 S2fDSWsT9jKczwD4P8+7Ju89KyxLvTj0b2BfIPNoCYGCzcLhsvtrHRcy8WUBZftM4
	 FNqhRrRo3jc9UbhzRmn9om/2BbY8+JxjI6zEEmkwqNMeHjQ+9Mi7Cv9N9dZvxceSv
	 dq7dvhp/rPVVupvx4tT87LiRUp6TvSX+AvwhC/RSSgZE276KDTD9oyxf+MtKxZO8R
	 OI+5goHIqbVm3ESUcg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MD9T1-1shxgB1nUX-002Jcr; Thu, 19
 Sep 2024 01:45:46 +0200
Message-ID: <168e23bd-ab59-45d6-8f46-e01353d03084@gmx.com>
Date: Thu, 19 Sep 2024 09:15:43 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 0/2] Add dummy RAID stripe tree entries for PREALLOC data
To: Johannes Thumshirn <jth@kernel.org>, Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
References: <85888aaa-c8f5-453b-8344-6cabc82f537e@gmx.com>
 <20240918140850.27261-1-jth@kernel.org>
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
In-Reply-To: <20240918140850.27261-1-jth@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:apR1X4YV/3gl8NEGHfXi4zdMl4v4w+PjINAfkUlahaMIpyfhzmX
 qUEg6QMUoU+yxBqMNiSPznpd5ovS1WLVVSJlBZsc7s+rTLcDBqkJnGCMvzsF1wgQ+k2zVlm
 ddGPMw5t3Y75KlZZBPmeUa7eWc5EP/XOi8lTf6PlYlCS50jfYeGEhyGO3XSzA8c73+ZFX8t
 w7yJorqm4dsVbKysFOhXQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:V0VGWhtcoCk=;TPrc7qJbCkwvPzQta3vI4qDG9mG
 q0yIqpEyFxd2O5jgBN2+qr/mGDw6KF0nND2nwMdpOCNdzuUDBUYAe/o6uTtdQfmhauOudlPR3
 9e5gG+vGMfrdwr5ODl7j3m/uvlVxeOI/7IV8giSoW7ENQs+mpcE7Mxzg3g2hBjJmWzJ0E5G0a
 PH1GIfJynDRCflccd/LtIFuJfaQj1RwEW7IKtoe8VX0l1cCyF7WXrB7KNSut9LTA8S+OhxKev
 Anoms4Xrwot1uGk7P9ZbM6VUPA8oSp8eSmBO2I0jl+1S9LnsOUmZR5uvLiNybeMOIQ+1rrFLJ
 WIMW2C81tkI/yWKDr8iWPC1D2Ek6OnLZ83aBuShWFE4iTOok7n5AGRfDgA5Dk6++pfk3h0NiE
 dAV2inQz9osah16GnQnNDEwVka/PlR4+mC7jyH75eRCKO/VSCbUrVnNNM+2SQHyfmFbKXoYXM
 JEjtfZWR4DdM/GnjcuNqtbrHe9dSDhZvZIc4Mygg6YF+vSJHhoYvwEe9zqolR1Vlevn6JbQma
 mpQ8EbZ20OmarBJxj56zqNpar+czuVmCZykIP/F7RY1PcVMtnqC812uesOaYqphqRLo/6j9dQ
 qzereCtgS6eNUb+xZsQS2vBvgXmt5CLFTPtbuYYdOIgurX5R0RrqnqsxgiN6UJdl67+Nsxct4
 sNOwOnHQVefvYLuJl+LaCGdQnw1qRXSSHwcZ0E3Kl4CRLS30h8lYy1LKmh+AaZo4+Dseh6RK2
 ElBpyDnwu1vbRPXTzI5xn+Z+VBaRkup4cbuZtAUrpaXkqtBQWV0EGOOlUyri/Aeu56WxPdTCU
 9QU30+aj4JR9Wuqgf7salG8z7eRtyuLIemZy023gYtuSA=



=E5=9C=A8 2024/9/18 23:38, Johannes Thumshirn =E5=86=99=E9=81=93:
> This is an RFC implementation of Qu's request to be able to
> distinguish preallocated extents in the stripe tree for scrub.
>
> It's not 100% working yet but only showing the basic "how it's going to
> look like".
>
> I'm not really sure this is a better solution than returning ENOENT
> and ignoring it in scrub.

If RST without zoned supports preallocation and NOCOW, then I think we
should not just insert a dummy, but a real RST entries.

So that NOCOW/preallocated writes can just re-use the existing RST
entry, without any new RST updates.

At least logically it makes more sense.

At least a quick glance into the handling shows, NOCOW writes doesn't
trigger any RST updates, so I guess it should also apply to PREALLOCATED
writes too.

Or did I miss something else?

Thanks,
Qu
>
> A third possibility would be to do a full backref walk on
> btrfs_map_block() error and then check if it's a preallocated extent.
>
> Johannes Thumshirn (2):
>    btrfs: introduce dummy RAID stripes for preallocated data
>    btrfs: insert dummy RAID stripe extents for preallocated data
>
>   fs/btrfs/inode.c                | 47 +++++++++++++++++++++++++++++++++
>   fs/btrfs/raid-stripe-tree.c     | 47 +++++++++++++++++++++++++++++++++
>   fs/btrfs/raid-stripe-tree.h     |  2 ++
>   include/uapi/linux/btrfs_tree.h |  1 +
>   4 files changed, 97 insertions(+)
>

