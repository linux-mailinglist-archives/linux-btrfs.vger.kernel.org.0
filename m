Return-Path: <linux-btrfs+bounces-4928-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E17EE8C3C22
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 May 2024 09:34:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3B7B1C2108C
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 May 2024 07:34:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81407146A9B;
	Mon, 13 May 2024 07:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="YLzScyHF"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79F3652F9B;
	Mon, 13 May 2024 07:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715585663; cv=none; b=Yfat1+vwzQlPQS3wpFIcH536QgmQ4wYZwx382HAsOtK/IfAxn8MSGdyRDWTh547ZOntCKbxmv0EFYlq/eOLfM5CswO4bYCp6lyadASpUoUfmFgYaqNKOFTVaMIq7mTkMj91hPVfXheqwVJ+23mx31hS6Tm+x79fMyiFGHoz17B0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715585663; c=relaxed/simple;
	bh=RUQh6UMIifz7eJvxoMe2rjb6m9G8jkWQaEVWG2hEeoQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z2GNTa4J2jmnE/0rZHr7uCc+0qSGQuUGg5Pe/3OzdnZUuco742NtRNkQjpPqto+IpAMT3Pae8ZGf82WH1R+SMAuVVUfPfwjaIpqgiKKOSmwy3tBFh7oQ09clfaezxTr83BQN8EA2GLkNxcZnHEk/iu6oo8p3ruVjPWfSP/ChkYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=YLzScyHF; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1715585631; x=1716190431; i=quwenruo.btrfs@gmx.com;
	bh=0OQIum97qAAe9o2eYF/Jg6gIBZbPIw+VDnqstE3MBlQ=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=YLzScyHFJ330Bjg+JV5nlO++GcOd3JFdfr95hDQ4WqmA+fW9ZdegdPy0J53RsauP
	 ST76J3fLvmyKgQzPy1Ea0B2aqdmp144PPm7hV19GBAT0tM9T8+iUs/sdlvJcPPnwr
	 tgMumdxPqC+UCI2i6UhC/XgtsJWhpfyx4CGNepBZ5tHwkN/2jkkhskffpmAJ+pFyO
	 VXGF8sZLNe+r/o3da1lU0iPoZyVGsdAxcl+lOuzYcMz3uRoxM1V+kqcnS1Mgfttsw
	 9mKKyeIAYndei1XuQIYpB10QQaVz1s5T2RfZqPMu5NR1+NMbKWCGEs2kQEZTKIn+6
	 HFKmVPgE4zYWI9bxUQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.219] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MDhlf-1sGdL70xTr-00BZOf; Mon, 13
 May 2024 09:33:51 +0200
Message-ID: <b8723562-d154-4171-836c-6194cfd708a5@gmx.com>
Date: Mon, 13 May 2024 17:03:40 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] generic: add gc stress test
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
 Hans Holmberg <Hans.Holmberg@wdc.com>, Zorro Lang <zlang@redhat.com>
Cc: Zorro Lang <zlang@kernel.org>, "Darrick J. Wong" <djwong@kernel.org>,
 "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
 Damien Le Moal <Damien.LeMoal@wdc.com>,
 =?UTF-8?Q?Matias_Bj=C3=B8rling?= <Matias.Bjorling@wdc.com>,
 Naohiro Aota <Naohiro.Aota@wdc.com>, "hch@lst.de" <hch@lst.de>,
 "fstests@vger.kernel.org" <fstests@vger.kernel.org>,
 Jaegeuk Kim <jaegeuk@kernel.org>, "bvanassche@acm.org" <bvanassche@acm.org>,
 "daeho43@gmail.com" <daeho43@gmail.com>, Boris Burkov <boris@bur.io>
References: <20240415112259.21760-1-hans.holmberg@wdc.com>
 <e748ee35-e53e-475a-8f38-68522fb80bee@wdc.com>
 <20240416185437.GC11935@frogsfrogsfrogs>
 <20240417124317.lje5w5hgawy4drkr@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <eddca2b5-0c15-4060-ba7b-89552de4a45d@wdc.com>
 <20240417140648.k3drgreciyiozkbq@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <edcb31e0-cddb-4458-b45e-34518fbb828d@wdc.com>
 <20b38963-2994-401c-88f8-0a9d0729a101@wdc.com>
 <20240508085135.gwo3wiaqwhptdkju@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <9c38fffc-72e9-4766-a9d0-ef90411df6f2@wdc.com>
 <299bf8a4-b71e-4a05-8210-d52ea45d5329@wdc.com>
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
In-Reply-To: <299bf8a4-b71e-4a05-8210-d52ea45d5329@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:QysdlSAtgCj0emzrDG1M1CrF0EN8uw2aHXb3/u3U5A6apXcV4gQ
 6v7jvcuoMhTaTVtsT68gPWubQikck0WaEYA/uZU9F8nZ0dH6+W2CzR/1dOa+adJsLYl5TLN
 klJpKqVHm+hBhryO800AotQWNOBZtyzuFOnOoyGjmhdmZp3DWdYLf8Z/L5MEYtPwuzePxIm
 vL6SofSf9yMEDdTJVgg3A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:UVJsvnMtPEE=;XDQOWHHvCrrJ4Lj0xEXChMP2Xh6
 2fZ8AIZ3mc8EGzemKE/hENdyYCQEbNLS+oro/u7qvV6V9NwHq5LbYDtpg6SUkPS+ZeNmLuh2i
 3lt/WXQCDGYfvC4yBg/ssjSWEdHFBp4lgeDU/nP+n0lCYTqlYObHpEPrmFxgRgnZOdpTCl899
 GQO/AFXNW7ToKvhQxzdkNN8KACoaJjF762JMKIfgZxM1Wtn8Y2lX/reHq65zAWGUh7xQhT09Y
 AS38VJeePTkyYpBxjgLd/VGCrLJbtbTMBN30Tjte26iqVUjiq/9EiE7UX8i4nHEFGUE76TbX4
 pCYLcbKsLMdGyVlkJ2QscxJqjVRfTGaHv3B1PP0JnmhTMH1cW9GFZRxVHSl0zauOzY0ISHD1l
 vYGVPegzq+g3vF/EEOTN7HRL61hdMxtJBpsBKsBBmBOpGhZcx5Dqc6GDGG6P9mpOos7DLgTyj
 Kgu5VqPaiJMFz9CI7wWmrYJrKZx5mSxA+RkkZb7PXmmnFRjCAPnv6nZMdKAMH8rB1JC3VQTTA
 E5d0aGWc4g8bS0cf24KsQBuX0BmxSs5rtgCpWRntP45VWkm9Kyhnlwbg6p/h7iDrYv1Q/tKmZ
 hTssNJC+X5jszVM0Fy/nc+nav2upJK4sms+RA1DCmpC6tWNafWKFzIK8cPNrHovpRrrzylUuV
 izLM9RVwRuwGYnt4+bCX+jO7U+qSvo4GluiPN71I2qcZkbSXOg35yg5v8pxuno1TXYSgbz1lA
 rSGRFOKSC8D0V1DXbRgnitkifGZlVdolHl2p4Vx64jr1VP6FmBcEC9Dv7EWvpds/kI5s3UVEA
 D0a12y0KOgtU5IpmvBxKbOrhYrO+wCve2Ul+cv3fAxaGg=



=E5=9C=A8 2024/5/13 02:26, Johannes Thumshirn =E5=86=99=E9=81=93:
> [ +CC Boris ]
[...]
>> I was surprised to see the failure for brtrfs on a conventional block
>> device, but have not dug into it. I suspect/assume it's the same root
>> cause as the issue Johannes is looking into when using a zoned block
>> device as backing storage.
>>
>> I debugged that a bit with Johannes, and noticed that if I manually
>> kick btrfs rebalancing after each write via sysfs, the test progresses
>> further (but super slow).
>>
>> So *I think* that btrfs needs to:
>>
>> * tune the triggering of gc to kick in way before available free space
>>      runs out
>> * start slowing down / blocking writes when reclaim pressure is high to
>>      avoid premature -ENOSPC:es.
>
> Yes both Boris and I are working on different solutions to the GC
> problem. But apart from that, I have the feeling that using stat to
> check on the available space is not the best idea.

Although my previous workaround (fill to 100% then deleting 5%) is not
going to be feasible for zoned devices, what about two-run solution below?

- The first run to fill the whole fs until ENOSPC
   Then calculate how many bytes we have really written. (du?)

- Recreate the fs and fill to 95% of above number and start the test

But with this workaround, I'm not 100% if this is a good idea for all
filesystems.

AFAIK ext4/xfs sometimes can under-report the available space (aka,
reporting no available bytes, but can still write new data).

If we always go ENOSPC to calculate the real available space, it may
cause too much pressure.

And it may be a good idea for us btrfs guys to implement a similar
under-reporting available space behavior?

Thanks,
Qu
>
>> It's a pretty nasty problem, as potentially any write could -ENOSPC
>> long before the reported available space runs out when a workload
>> ends up fragmenting the disk and write pressure is high..
>
>

