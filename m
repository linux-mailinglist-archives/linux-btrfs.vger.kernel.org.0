Return-Path: <linux-btrfs+bounces-8177-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FF71983A2C
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Sep 2024 01:12:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C4987B21DBB
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Sep 2024 22:36:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3B1313D516;
	Mon, 23 Sep 2024 22:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="lYn9+LGS"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D834A84E11;
	Mon, 23 Sep 2024 22:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727130876; cv=none; b=gHJi6XiVZhx88HwiyYHhph1UpzGe+baDNQ9SN0dqyFlllZ5uvfPZxAqpX/6fttereCUsnZw7+D46PD1aRGztPorjkXB2xwgtxHhJ96hjroLs9k+qAFFKgVbGI1yErVoYmHjBeJ8L0580rMtJAVozD04QJpLayA4fmjNXhWY11NQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727130876; c=relaxed/simple;
	bh=FHUC8gt4C/Km5NrfVbRsMcFqQOElqrmHuaFrSHX11+w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cmF8d0qTZMyY/wm5wn6Ptz8wubroErP+pGByad3IUcO+n6MOQ0rnHFgX/0pMXGJ5L8CKoSI1LWhl0MZKLabthrJH1P1f7IvGQsU4A5AGyyX/BNLURJgU2QdTSejoOBD9ZjbcqdBj0z5E/m9K86uqlmBonNV/o3GFIfYTqeTPpog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=lYn9+LGS; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1727130235; x=1727735035; i=quwenruo.btrfs@gmx.com;
	bh=FHUC8gt4C/Km5NrfVbRsMcFqQOElqrmHuaFrSHX11+w=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=lYn9+LGS8Hcx9zlOmNLIaYugC/ER3iM4F21O+QOG95DIenEHvMgJUGil+iPJinmM
	 nIyyS+i8yrBWWP8MUNIBwyyyl4LFAyNISX1f36Kk3Ucc4Npl10XlP59lZC9XRGskv
	 9kEZRjzIADqn6UmgvX63u70dZL9C3L48hvcpE/dEJAARv5O8k7BiozQRggu6UrnY0
	 CKWGgZoad43V+vS3zFIaPDiL4+ykrNJPgmaUM+qQl5wXZb8Q+G80Yod3ZwCkFCbcz
	 qbbdk12M4aWo5pRx6LxfUwOq+h/yDHZnTlt8tLdDbP0hXpTEHjsiIOAQI2XGZqOi1
	 8ObVMUAo1ZOqcjQs8Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MAfUe-1smDch15Cq-00B6So; Tue, 24
 Sep 2024 00:23:55 +0200
Message-ID: <f6ae39fd-ee30-4e22-8d0d-6dec5c3bd192@gmx.com>
Date: Tue, 24 Sep 2024 07:53:50 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: also add stripe entries for NOCOW writes
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
 Johannes Thumshirn <jth@kernel.org>, Chris Mason <clm@fb.com>,
 Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
 "open list:BTRFS FILE SYSTEM" <linux-btrfs@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>
Cc: WenRuo Qu <wqu@suse.com>, Naohiro Aota <Naohiro.Aota@wdc.com>
References: <20240923064549.14224-1-jth@kernel.org>
 <71088008-c105-4eb9-9199-882091eafe07@gmx.com>
 <3c0c8517-a642-4e7b-bbcd-ef0022c49c3f@wdc.com>
 <d42756f6-d5a8-4f44-a6f0-6056f5c1015b@gmx.com>
 <aacb742c-2081-441e-ac52-d9e0f580ab1e@wdc.com>
 <47d0f003-ebc8-4959-a22c-ccf9ea7ef35a@gmx.com>
 <887a09bc-3c98-4bd1-aa31-0732fc633315@wdc.com>
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
In-Reply-To: <887a09bc-3c98-4bd1-aa31-0732fc633315@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:TTcF/bjJ8l4vXEfT+qUrttoNpA1+fy6rl+GQrTmV4h5JbFFkjNu
 vDVk+KiGSbeID70EdmknhLCLJQXmERhdsOG5yuilQisLXY+BgmAEXRxOFG1JHF1no0ceOAH
 azDqmpXnrNTd2t3AMBRkOXrlse7eGvWigGbbLpZgSqhTsZ9tOSl9lYG2wrTIHenZkIXW8OZ
 RGt/19Jh/JqoTutyucHBQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:iw8LX7Nst7o=;qGpkp1D15wL38YIq30zBCPUitih
 cTIgz7F4COG+JbsBZza6y5pE7RU8OlEnuKg7SCpGUXSKOUOOhgkRHf/k5xkk9CPUWGeymSryK
 ZJ6gPVHMfk1vHwiP+Yzy4D9Qd6o1y0+e2SJ8LdPDUMSO0t56bn9lVPsiLcmc+udlG9MPmbkxy
 CBNxasnkVLW1l4vyZHk3ItNSfXEIVpf4uyOX4g/hX1KLisYdqwlCzTWNI7H+2TrdJ1Qxr1TLz
 Z7QH8pjJlpWOK4w+ujkYMLe/f3zLlPrbaBc7d94/FP75Mzu8YCvyPPRy0xnrQ6zI+0wp4E/4j
 F2ZCG0D80I6eL7TktTOJ98ER96FS8bCYA8vUi+Nm6Pu2RpXkq8lVQeOuu03vuJYt31eI44gc3
 rvJagJa7pu8IqxV2IsRjTgNPmBWGd7sX1RUQ8WTxK8PwdAGd18fQpZfJBkbkLCN9+owLQls+b
 1j9F/X4x4llhwF179DP+iLQFunzPvAt+g8ZLQsSO960YTY3CTY1ijhjOfA7SwNcrW2USyZKtK
 WCg7ZUoCx7xQH6y7795KCHZzHgO6V3jdRwi0zwz4WpuB1WeOVWAIN+w3suHsyBeW8ZWd1JKGh
 z/rDtZz1pvZHapxLRFe+RbLeRhw+XiVcY82wcNcBL9+AQ0885vsIf8zvjAu4EN6Q9I01oEv38
 k+a5cuxCcK6Rpj01wgAH70o3MODplpkuCw2zOXWkwvOsG5IMXbpkPTV3LWJgSc3sSGb9/6E1y
 OGRp7c1dFwX8YhovjBxruenFbu5iFSGnCo7Te/XFuxqlalgFvyVXUtLGl8a/Sd0m2f90Q39oD
 2qsZaWQ0UjxesvQwoD63how+keSAoNSLveHWbCfJkPlTQ=



=E5=9C=A8 2024/9/24 00:11, Johannes Thumshirn =E5=86=99=E9=81=93:
> On 23.09.24 10:54, Qu Wenruo wrote:
>>
>>
[...]
>> Finally, I do not think it's a good idea to insert RST entries for NOCO=
W.
>> If a file is set NOCOW, it means we'll doing a lot of overwrite for it.
>> Then why waste our time updating the RST entries again and again?
>>
>> Isn't such behavior going to cause more write amplification? Meanwhile
>> for non-RST cases, NOCOW should cause the least amount of write
>> amplification.
>
> The whole idea behind the RST was to write the RST entries _after_ the
> data has been persisted to disk. Otherwise we're back at the write hole
> problem. See for example this imaginary sequence:
>
> Preallocate a range. This will then also preallocate the RST entries
> with the mapping as you describe. Write to it and while you write you
> have a powerloss. The copy/stripe to disk 1 is correctly written but
> disk 2 didn't report back before the power loss happened.
> After we have
> power again, a read to disk 2 comes in, as we have a RST entry, the read
> will be directed to the broken entry and garbage is returned. And this
> is the good case, as we can repair it.
> If it was an overwrite of a block and the same happens, we have a RST
> entry pointing to a good and a bad copy.

Nope, that will not happen.

Because our metadata is still COW protected, after such powerloss, the
file extent is still showing that range is PREALLOCATED, we won't even
trigger a read.

And this is exactly the same as the non-RST PREALLOCATED write.

>
> Once we're adding the RST entries after both writes succeed the problem
> isn't there. So for preallocated extents it is even harmful to add a RST
> entry.

You just forgot the metadata part, which prevents the problem from
happening in the very beginning.

Thanks,
Qu


