Return-Path: <linux-btrfs+bounces-3450-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AC4DA880640
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Mar 2024 21:46:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EA967B22A5B
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Mar 2024 20:46:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0C8F40859;
	Tue, 19 Mar 2024 20:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="P3IPnAA7"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD7E83BBEC
	for <linux-btrfs@vger.kernel.org>; Tue, 19 Mar 2024 20:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710881168; cv=none; b=jVSi0TLTHkLKAGM8mVtaTojoo2S2fzeRYDFcK5/BHCvXX0Wpv0CMbwA3b/OhbyfbeqGpvMlSr6p2InYzSKPUwcWaYIl9mSSrfm/aH39ie9YfexLoetrpnbqlWjWdNAqyv8lr5q5Ormtep1nN19mIW1xrADQsPBm1Joc2oMKM6uA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710881168; c=relaxed/simple;
	bh=Dq+kndkLL4Jh+Dkp1ZFP62jLdjXS+xu3u7pkADWzc6Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=FxEY0oUlBqH4T3ux/zGmx1q9TpPrrxCPnGcJZk5nuZFtbG8g8tYT/nou3cz/5/j7DcHg4uZbvKWjCZBV4lRAdeJrJD+AZIoxsXY5/IfWl5CcHK83tv+JYccg8Wogdclesbqjjyi0yDLoswDnVlMlyHh2rnJWkE8cgN1UddaIYzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=P3IPnAA7; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1710881161; x=1711485961; i=quwenruo.btrfs@gmx.com;
	bh=C5Zm0R1SLbiXwI3dxbdFM0l5bb2dFdlO39AmQISo2Uc=;
	h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
	b=P3IPnAA760GcqintQQFiPXsOZX8NqHbScSIuFoEXl6Ia8c6/eEQBp73JfA/tJjDy
	 TrHDXkCpKKOCHOSEBAlEycmmIpVZpXy9AuB+8jbbCh+4BmDaLTJNRkTsbV3bIkkNK
	 s4tgg6u3m1b1MNauNJjHDfeOUK0hGXC5xJkYgFLnpLySA9Y1Ht13j8rI/Og/VBAgX
	 J7NY/jJcAq541lZG+8Ri2w8MQMEWz5N00cdYvCb4iKS/bwPv+d4HJdcNO1YkXVWa3
	 lzXYdeVMpufIUTG3tfKGary1iGUNyhxuuo+7IKwrtE9mpm3/IVwGJphOQi28NL0V0
	 mW2Xh2GNnX4F08n7QA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.219] ([159.196.52.54]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1Mplc7-1qyiPs0jGf-00qEKO; Tue, 19
 Mar 2024 21:46:01 +0100
Message-ID: <168839ea-34b3-48b8-9d82-78f0dc92a468@gmx.com>
Date: Wed, 20 Mar 2024 07:15:58 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Help requested: btrfs can't read superblock
Content-Language: en-US
To: kind.moon1862@fastmail.com, linux-btrfs@vger.kernel.org
References: <37de8ead-fefa-4fab-a0ed-bbdb2bf15cf4@app.fastmail.com>
 <e52a27e8-3b6f-4e33-bf0b-a225d7681454@gmx.com>
 <c233ac4a-dbce-4851-a8f3-78de0827ef19@app.fastmail.com>
 <1cfe630d-ddb4-42fc-ac42-54fa53cab747@gmx.com>
 <6f97071f-2c47-46f7-89f1-b0a80530ad38@app.fastmail.com>
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
In-Reply-To: <6f97071f-2c47-46f7-89f1-b0a80530ad38@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:LJCY5U3hUhiNG6l2QuZXUO0X+xSWQb1Yo7vEPnsTH8Bqa+/Znm4
 4Pv6Y/JAbdWx6NEwLR/AcMcpP6DQ64WYxk819TnEHOZizB4ycZnDUGCngOy4WqKrgxvXdj4
 dooLAtI2it8EJoCEiIOxO0FQdmXls76WfnH/EnoeBxUBpfMOnWgQATJulZZfGJsl+PFLDq0
 8c0R4wmj7kHeOcnJiGa/Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:+3VfQ/hOeCU=;4oYOnoe0jnSt2LLPGYDnT1vaG9C
 ynsqkXfxQjk6Hg/RWpZQLOqBRwl7cZj6NwJLXcMYD7iPn/PNEP41nIX49fxlBAb59X22aw8FC
 76k8n6kSJ173gT1LV4Xa+zSl0lHVVn/u1axMChUh6UBSuE8BRpA92d/iifQ555n380n/olzGo
 +47++kx181nSZtodngTEmUTYpNW+GjPv4/6MgbTtTEYlX2ZeoGuLuJvpqczyyZ887TLT+lQo9
 BJrppG8u1guId1P8l+NclBiDarIzzYZfsHRadvFGJUvmdiM+f0P+qvk0/aQesCXVDotJeaZ9M
 r1G8/EtRyMmLFBCpJW8REpDalg8GvAuVaACXRs4HBdlLJUCaAU/g6tsOVzEWrJk83QeCPR4WN
 hKKpMWiX5iL8ESixTALyrHYQGDOOOH8h6c7v3v2mgpAsyaZcwgVTMdj+xMts6ioDi977wmWXX
 k641VojITrdl2DwsA2iL9jSmVx6DnqXALWGGCheY1rsnM2aPQ3l0456kVSP0sji5t53xj4VI9
 uEYIusJlqPi/vORCDg8MoAoG9Ha6DpKs3HdV0lZfqBrY7Di+TbNJaOVeJ6B8ovU1eTh984qLh
 Q8VD7gtfp7YuFoM1xK5WkCOKlllUcMHJFcYQFJa/cKUJJ/MhgIAb0sFM1qQOTNMmXtv0y40qs
 4vDsfUj07Az6K+LiBRde9bLO/MVBddcVkuiBu1l97vy6sCp8g73PTbFbJxVaGQaboajZmo/U6
 k1QVpNQ1QTJ5/oxdqQ7wolk7vFfyDBwOVvSOR9W6O/IwqIqCWfy8ukSF9LJnZSdcB0pBDfw6p
 q574tT31cK3gNCRxCrjAQrV9/qooIWcHKHTNF8DyJXNu0=



=E5=9C=A8 2024/3/20 07:14, kind.moon1862@fastmail.com =E5=86=99=E9=81=93:
> On Mon, Mar 18, 2024, at 17:53, Qu Wenruo wrote:
>
>> And still, please run memtest before doing any rescue.
>> As faulty hardware can always lead to weird problems no matter what.
>
> memtest86+ found bad RAM.  I will replace that before proceeding.  Thank=
s again.

Btrfs tree-checker, the second best memory tester. :)

