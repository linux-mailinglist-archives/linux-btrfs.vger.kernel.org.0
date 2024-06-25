Return-Path: <linux-btrfs+bounces-5976-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 55F8491745D
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Jun 2024 00:45:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60A601C22F61
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Jun 2024 22:44:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8456417F388;
	Tue, 25 Jun 2024 22:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="Q/PQwAUS"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18893149C6E
	for <linux-btrfs@vger.kernel.org>; Tue, 25 Jun 2024 22:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719355491; cv=none; b=WfSI2aNnB6R2I/HOLNpu8iB0ZCTiY+8RxByq3oZIY0GzSupPES0KHuWGBGIq+xD4rcC6E5eEb4AOUOlsxWH2PVfejPoZpuJm5jqEMxJ3yEVTAVwarylnJuVXZlS6JZNid/RwuMgDaSNAmW+wgb93ozplrFvWj0nZCux5zaZNe8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719355491; c=relaxed/simple;
	bh=QjJ2HuRxP1v+Fo57Ia9ghKnhkD0/bqkUXG7SfRe2RJ0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bB8LU0+SZmV1mM137tV5Lp0ZD5KR5yX40VvNlNCXJMGpB122GTuNW2q5Fg4IpMBg6QMxAFN/YsehCM7RHWtDs9w/Jvm7r/M5KaED8v9/OoZYzBicQc2g99K37mkxzK4yrrH/8k0nwwGQgVxhn3oFBS0mw4fxmEbYQvbWH95qyn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=Q/PQwAUS; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1719355486; x=1719960286; i=quwenruo.btrfs@gmx.com;
	bh=QjJ2HuRxP1v+Fo57Ia9ghKnhkD0/bqkUXG7SfRe2RJ0=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=Q/PQwAUSG1WDaMUE+gevvqeEFqor/5FcVTQlHIakuF6X81JRwIxMRRsYiW93QHV4
	 i2g9vB4Oo60aPXcag4JF9ovkR5gKychoHqwXEzddk9JFdPS9SnqEUGdVJ0LtA1FC5
	 +q7aaIg4Eui4xzJVx0pdNHIebh/6HAvW7dbbiAA+CzpXzrMX8faKcACm2F9KSN5v2
	 vTR3CF3nFrOInE+vNFLvUtI91WFcytZwIfMvV0WX0wOPMHz/V637vhjaSH0ZTXlvd
	 ZMUBQTT+DjS38/CRMoAaINQ3HSyoC05rKZynvcn75hAlCler3kZCqLiTpD9P+VXST
	 Rwnm8uQfsIy08oNnvA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MBm1e-1sCN0r2jQy-0063mN; Wed, 26
 Jun 2024 00:44:46 +0200
Message-ID: <a02831a2-ee8b-4e51-9782-3d9bbcd8b2f1@gmx.com>
Date: Wed, 26 Jun 2024 08:14:41 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs-progs: do not check ram_bytes for non-compressed
 data extents
To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
References: <4ba45162892b90a9a7e9603df9705080e5292f47.1718965319.git.wqu@suse.com>
 <20240625151307.GV25756@twin.jikos.cz>
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
In-Reply-To: <20240625151307.GV25756@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:GsZg298b1273sE2UvWhb1ieIZrJVV1+GhqLuptGGlU/TskfRAOr
 Bzqk16RrmDAMoCbJEoCuamLUGnwyGZO5mo9N0+FHn3sZNMVebf9zZdG+PpVXxjaQjnW/daI
 det7TOnLaso/k0tZ6LClN+6oqimyUL1ct7ITt5/8ygqTxvRa/hxeNvxlkjDdqRtkGrwBnb6
 2SYx2S7zoYIA8RYCGT1/Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:8XPFFWOXzG4=;qUEDQogEZPtyVUyWQLDVAvFrPhA
 hvHPQRPhFFAYhPtYBNpRKlJxV7ByVzzmYOR7PArPxhkPOiLppm7GqyXZOeA6/yXHshe/xUhbC
 vF8DSwE7DeT1bYEMbbqB9tkkbEPpv7i5hSNjnKNUFvd3iCwXAMKyxpY66gsXHrr8nZ8RLv7Fc
 sqrAQzmHc3yze8BoO0SzKTy3csQuuwVx+RU8X30PfUX5EymjuywFToeAfX+O/LUmWa7h/tI1r
 zRb8Bk9DPfeqmMIzeDkU374Gya1dwl0mqvBfcMJb0Cyo9XofdHQP6UYs5baoeNy3oKTJkQFVx
 JjX1Yo3PCmWEtM+9BGuvrX+4FHnGSTJg3vpno4DY7MSxtlGyiVBfSZ/Ii2UmKBbJtW+eKnNI1
 8wpjBYu5iZ+GtKa34lTJqvxRPvrq4To6M6SRewCCUg9s8MNgVwDYqNPWJz5NbiBheJViiE+P3
 jndfHlZBHY0yi9g2od4C9Z7Mfi9Y6kqYVN9RTDk9gk5BHCjX4uSSEJ/0nzZfbOPjv5aVTZ4Ki
 PElmRtmr8Zb3lZUF1QFCjOiwNFCX5goMmAHV04jl/zLsncvckr+dr96I7CCI64w5zAyQNN2mX
 uZaY/voPbHYRC4W8rcqHOomyaTkk5UMMORLo6ajhLPnf3GxXEOoAZ6zmDdOXRcAhM9P1+JyQD
 oExFwKHtRoPY/HZEVq1NL0zs6qgbBwdNl3DAoDJO5OSqGZn/yEbWX94YtpxApS040K8xiQTBT
 20L8aqqRcbA2e4e1D848ubiBHL4EMz4J+CoaC46/VNWJ4VhjBzLV2jOxWmVaFgf0sqAJ8VY99
 xegriVNLL5+8F6ewQ75WXsO3qW7oCyULURrEGW0fsTW8k=



=E5=9C=A8 2024/6/26 00:43, David Sterba =E5=86=99=E9=81=93:
> On Fri, Jun 21, 2024 at 07:52:06PM +0930, Qu Wenruo wrote:
>> This patch reverts the following 3 commits:
>> d0cc40d23aa0 ("btrfs-progs: tests: add test case for ram_bytes detectio=
n and repair")
>> 7313573c1942 ("btrfs-progs: check: original, detect and repair ram_byte=
s mismatch")
>> 97bf7a596900 ("btrfs-progs: check: lowmem, detect and repair mismatched=
 ram_bytes")
>>
>> The problem with the ram_bytes check is, kernel can handle it without
>> any problem, and the original objective for this is to detect such
>> problem as I immaturelly believe the problem is fixed.
>>
>> But it turns out to be incorrect and this check is already causing
>> problems.
>>
>> Fix it by doing a full revert for now.
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>
> Added to devel, thanks.
>

Just to mention, thankfully the root cause is found and the fix is
pretty small.

However I would still prefer to do the revert. Even with "minor errors"
mentioning, end users are still confused and asking for help.

So the lesson here is, we should really not to bother non-corruption
on-disk format violation in btrfs-check.
Just let kernel fix them silently, and with enough time they should
disappear anyway.

Thanks,
Qu

