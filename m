Return-Path: <linux-btrfs+bounces-3382-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 517BA87F4C6
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Mar 2024 01:53:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E449F1F214D8
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Mar 2024 00:53:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21A9C816;
	Tue, 19 Mar 2024 00:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="k1fR1K9u"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEC60368
	for <linux-btrfs@vger.kernel.org>; Tue, 19 Mar 2024 00:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710809593; cv=none; b=VpJfnctBNa0rVD84PIyQnwnmSJ9//j8SyzrNGHIHexE8wPNRG9mkQua/2UmNzWUwvgneP0gOIorgQj3gMxdKxjluiE46X5nHrEEvUJXJ0zvLbTRPHcdMaAPdrIjg+4yioRAhZPmqXbJJL3ZiV36ZGM2wUhyIwyStc7elxFMC+84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710809593; c=relaxed/simple;
	bh=+2672b/LR0VW2wKzX/axqY8520oFACaV1RaeoGP7JI0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=dpxNyTWX61dSEvPgiyYd9dtW6W0O6e2EmUzyPGFvgEUjfVSPh1E6wni62yROpBf1VJTJto5iUtCnS2bMxX/Dl5ybJrRlFrM8rViK4Kv0BI8ZVCuqBtt92eRsfOe0uilFSYz85at1XeoIaIMbiOuS1iJisukgDtu2YmGj+WyAj+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=k1fR1K9u; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1710809585; x=1711414385; i=quwenruo.btrfs@gmx.com;
	bh=uBg0HLmezzgvZ12hgDP/2IcgVUh3lwU277LiB6W/290=;
	h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
	b=k1fR1K9ufHSEpp/MQD4OI+iPAxD02Viv7nrELGKlyITQG9ZwowhBd4gi2fRtTmLN
	 MigRWURjD3wYDWlbcEUyXGYTcoz0gcnA1CdHSfufBYr/cJnlarEDL5g3C7mncMzc+
	 9l4Opg7351A/zjv6slAfgTl/3sDemJdegwPZj3pVyPBl8yDUBKmGazogdiRo/M9fl
	 F4KDhub7pMfMDSUZUMlzqoetIAiI5n+GgZqIzrXmOU6YyZuJncAbQt4hgOej4swgu
	 vWykoJdLoAk1ShFgGwF+nUE9bRsDjUCOAS4dD6YVUx7oaFoXzM8Calute4evQcKdc
	 ECe4pmTVEUmn+6dhLQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.219] ([159.196.52.54]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1M2wL0-1rlIKa1aMm-003KLX; Tue, 19
 Mar 2024 01:53:04 +0100
Message-ID: <1cfe630d-ddb4-42fc-ac42-54fa53cab747@gmx.com>
Date: Tue, 19 Mar 2024 11:23:01 +1030
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
In-Reply-To: <c233ac4a-dbce-4851-a8f3-78de0827ef19@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:v05vsJPjD3HZKUzM5bdZfe5x9bo47gyqDSmdB1C6VYLkyy2ZN4k
 l+kKF7w4y2t+SRTzUM59xwaLfdA04sBu51We0IlynnloZMWHXNTIhRjieTr2DJAoPrstv3F
 KjP5JQI5DjMEMdMTubF6zVAQjVKeYYgwD7GArkTg3ezRNjYOBar/+iMu6a7bxuSMP9TMvit
 8ns3Yq1hLf7Yy81IgEqSQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:aK5TZUO8VQw=;t/2M4pq0GVgZkPRwYEmWYVxH/Zb
 m7ltuYNQ6T8Ut2E4ugaWZ+uoJ1NudZgaPbCD0G7han8DPvA1KfFLquRoYiF/29sUtMRPPKULj
 NG/pW7k29MuDXXFLFMBuczveVFtn9cT9u05lRNjDJ3K743Tq6DA8fqlAqs2zWyc8tVjjsZfLH
 yOqNnDURyCwEOH/8sUTrjOTkURrfH6vlRY+XcuL1VeEl9v+PJP+BYhJ6N5SSpnQvb0IZIC++D
 O9FNWK0r4Rg4Cb3LTUfiQcRIMKLhwY1YGgy92zo6ENLtHGQr/QrRXQqpx7VpPQt1LbE1WwPm7
 PPHQboIvNMD5XasZzAd7AeFnzgsHlmpVItPhQjbUhfKsLuRltZdEN5pKJK9NaP59Z4u0IMa7Q
 jhMBuX4aCiBpBnp8fvZOtlreacA0j3A67dhap2+ApnrVhcqbD+55X7YHcWEZANH4r2b4Oyf6c
 1UzX/QZC/vP2Z6/psqB6wOnD+NhgS4NJGCOhYeFdyeuS1kyF8feObnhq3Z16z/2Pz9beIDROg
 p2Wm2TOD/ggXMxklpgY2Yo0tsZRemewH/JKLSkcH5RIpRHdhEdJf6tLmEXi/5Cf1LhCiatPDt
 tULkV6wM+K3/KWiCFyet6kd2vdZT03YAg96KaEjufubdd5ik35q5J6zfjW8on7dNH4hixwcY4
 xMkzpFyWIq+HiFIGtjeMToC2J2SpEg/WmR67+1mPqIck4qfGj5+U4AYYkI1rgjib50mt5xuml
 Ev0MY9s8J2UBRpAHt0REstithtdoTI/TsO7CAeoC1MNIO5yXnUK24pmjKapKqrGI3T0T/TW2V
 oRYqsF4OgqM7v1vbTjdemfJ3/HHc58Tm5uI3wwL7aXNno=



=E5=9C=A8 2024/3/19 11:03, kind.moon1862@fastmail.com =E5=86=99=E9=81=93:
> On Mon, Mar 18, 2024, at 17:06, Qu Wenruo wrote:
>
>> Use "mount -o rescue=3Dall,ro" instead.
>
> Thank you for your suggestion.  Should I run it under CentOS 7 (the orig=
inal OS) or under the newer kernel in the SystemRescue distro?

Newer kernel please.

And still, please run memtest before doing any rescue.
As faulty hardware can always lead to weird problems no matter what.

And CentOS 7 is not recommended for btrfs usage (no proper btrfs related
backport and old kernels, IIRC it's already EOL)

Thanks,
Qu

