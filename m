Return-Path: <linux-btrfs+bounces-10992-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A46EBA149EB
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Jan 2025 08:00:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B1763AA32A
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Jan 2025 06:59:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB2971F76A1;
	Fri, 17 Jan 2025 06:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="S9/Ab5M9"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC4B81F76D5
	for <linux-btrfs@vger.kernel.org>; Fri, 17 Jan 2025 06:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737097193; cv=none; b=OoqukvrNzjbSrkR1dkcjqq+4JxBbU8QL25pc3SLJ6pFWmLU12IKf8t2njZHbt8WPJPABBScYgnwInKeTTOI/6UoXT3BjAwUb4jckFZ9tvt/Z9gY4uvtiI5OZB8g7eDaC6NCCnCXolDd5yGYgRuIN1lZ9OhneZxhrzw2/q/zmoV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737097193; c=relaxed/simple;
	bh=1CdwaUvfjiz1qYpZHjGxYzKp126QkqnhZogAkDeieSM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=bFV/rnIsTl5If8HOWrE/cmj6j5hkgV0wd0eNeANLpQhk5utTioRGoDc9B4WXUAb9kxRBY0Vlec1Sai2ChBmofFw6JJoTgRbW2+1kNlpf1qvQcRoURySh/UjKg1MmqzlJMBtgASJmEeH/KrnkXc5vgaQiaDdAnls6Az2rC6U8KRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=S9/Ab5M9; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1737097186; x=1737701986; i=quwenruo.btrfs@gmx.com;
	bh=M0KxfSvJP9CX4BAU1aNEy/+/nZTVd6EZvcCcapWsfNE=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=S9/Ab5M9B1wdxc4fijzEt6MbjiG/XpG0te1vlO25WbGHE4yWy95B0vup2vQXtaTe
	 37JHMKAU2Sq8uI/rEJ5xZtkzj8Z2NrvOXfZsIBqu2HamCdhRAvPGl9/kBiHHCZDTJ
	 kM2FBcy8QxNEVM0RuJmyb7HVy9Qr3q5w6n3SVm/55jWMHk2leD9gmo68DypwRFlfk
	 eh2zA6OBY6mTkoNtbuV+Bxmeky+erOprHMNniZLCW6WHcwL7NMaw80n5F5aX+bYF9
	 guSeE0biC5nceBcl8N9c4IUewFvsk125LrvMHlkEEdD+KR9liFpFT+DJAwbxtAgXT
	 zVgCvkhKsV5lv3gn0Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MWics-1u19PF3vVg-00PIQz; Fri, 17
 Jan 2025 07:59:46 +0100
Message-ID: <27502a16-9e0d-4317-9ef5-426fc5e8c581@gmx.com>
Date: Fri, 17 Jan 2025 17:29:43 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: export per-inode stable writes flag
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>, WenRuo Qu
 <wqu@suse.com>, "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <a7dd26219b1dba932d48b373fa8189a2bb6989bc.1737092798.git.wqu@suse.com>
 <ae5ea555-0a3b-4e51-96c0-d318a99d5a7e@wdc.com>
Content-Language: en-US
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
Autocrypt: addr=quwenruo.btrfs@gmx.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNIlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT7CwJQEEwEIAD4CGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCZxF1YAUJEP5a
 sQAKCRDCPZHzoSX+qF+mB/9gXu9C3BV0omDZBDWevJHxpWpOwQ8DxZEbk9b9LcrQlWdhFhyn
 xi+l5lRziV9ZGyYXp7N35a9t7GQJndMCFUWYoEa+1NCuxDs6bslfrCaGEGG/+wd6oIPb85xo
 naxnQ+SQtYLUFbU77WkUPaaIU8hH2BAfn9ZSDX9lIxheQE8ZYGGmo4wYpnN7/hSXALD7+oun
 tZljjGNT1o+/B8WVZtw/YZuCuHgZeaFdhcV2jsz7+iGb+LsqzHuznrXqbyUQgQT9kn8ZYFNW
 7tf+LNxXuwedzRag4fxtR+5GVvJ41Oh/eygp8VqiMAtnFYaSlb9sjia1Mh+m+OBFeuXjgGlG
 VvQFzsBNBFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcga
 CbPEwhLj1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj
 /IrRUUka68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fN
 GSsRb+pKEKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0
 q1eW4Jrv0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEv
 ABEBAAHCwHwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCZxF1gQUJEP5a0gAK
 CRDCPZHzoSX+qHGpB/kB8A7M7KGL5qzat+jBRoLwB0Y3Zax0QWuANVdZM3eJDlKJKJ4HKzjo
 B2Pcn4JXL2apSan2uJftaMbNQbwotvabLXkE7cPpnppnBq7iovmBw++/d8zQjLQLWInQ5kNq
 Vmi36kmq8o5c0f97QVjMryHlmSlEZ2Wwc1kURAe4lsRG2dNeAd4CAqmTw0cMIrR6R/Dpt3ma
 +8oGXJOmwWuDFKNV4G2XLKcghqrtcRf2zAGNogg3KulCykHHripG3kPKsb7fYVcSQtlt5R6v
 HZStaZBzw4PcDiaAF3pPDBd+0fIKS6BlpeNRSFG94RYrt84Qw77JWDOAZsyNfEIEE0J6LSR/
In-Reply-To: <ae5ea555-0a3b-4e51-96c0-d318a99d5a7e@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:LQjVEVAtop06xclG7gwBpwIya/0SIsx2Kyk/EskOln7xwkL4p67
 PSfxb2B11jiJaqYpF8oFG7WZrWNmado2L2x78W5yzVekMR8BBeJ3+QzyS0ulHhozGX+QqOV
 vpc6FVRpV/DR1bhMGuGyQ7e6rxZsUYro/1rLg5LASIPtYNvBu2jOO2Zy/lp4J7RXPm3vHVV
 HUmYaFmcOJ6ZYgrxO/XCg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:El/9tUHO+Bo=;YOJW9nqB48e5ryfBWJKkpvE2wvb
 OqgemTgYbZFAXt9oFce12qC65CI2QOEAPq9+sY9UetL4M9nODW50PCAzAbW5BeQ5h6A7YhmI9
 AB3sYF7R+1fJRtV7ASKgsVAkfJiFuVIUtwYvaCcImIPkhuiDQkum/Zcaz4wgtQRUAv97J9EiY
 0rQi7T9cZhqHY7+07QUGArrpU4eKYAzSBP0gPyPS6FsOKiDP50qDT1piInNTm+itmpsaq3tdm
 5d9R6ha5u6BWwRv/kpGgsOnLawke/4fLRTlLon4qt5J4lp7/fq7H8+jvUHuorRE4hqyhVzw4c
 5TXk/oQuc5zebN6XhEsqiDzml/1BWCqQZtVUvuvHKru2XAqpk49ls5T3jgbOpUldhEqJf4Bb4
 scJQXls/aCfgdtvdgSnIanKssMm6Pr2FS0P7BplLIya2Jo1VhaUGELLFkzho+SPh2Mr9BGRfS
 TVHr4pVwMNmEwkvQ4rhSw5o+P5AOST7QAufTEofLWu0YW/N5KH7T+aRSWuvA8MR7MgUNwiINm
 c3DPy2jLXNJC+tMS99UXdijoSf46xPM0wYWxfBRTVVF4Mc+qQnWa+C7l5D8KdhKN8Sop52iv5
 MGrDI2E1fXvQH+qwjE29JIIm81wGWPT7hGQ1UsjtWzPjOmrlTerCodbo5WmFdW4yhWAPIzjRM
 VuIzqOXAnBDX+CKdTzeTMaZOFwQH69Xn7f9bZ4eHyUhY2F5dMQEtk/J9ELrvKIQbvwHCmVhTI
 RAvZ9s+Pvk08KLssSfkRKwl7w5bpNWvzDsia9+9AHej0DiIQ3jFTt+uJQ8VA89ukwtkVVhnNM
 g+nx3i9r/GLE1GuuevOthcaxgfkCc7D+x1BF5T2xO0GN8ERNE3Q6CC9yrhBuyAP5DtKE8iZTn
 2fEqllju+EFUDealOmCh7efR2595ApKicbg3EMMhs22SntNSUqufvbNrDPdysWYmRB56IxelV
 IE5IrUgoR5Naz1P8u+MMQXrUXkGYpzV7yCXMgfBbbQ3UAOA/BCpMeLio5kpgOik9b0Z4vWNke
 b7/5gyBaknzpAm0Qg7rwUaLu0S7anR8GKX1zgE+R0bU6jT/DXw///Ku61xCIqKDFjPA8dOukY
 HquZNAQpAKOT4IeQmnCSWrA7DubzFGcREMQPEiTOz3avY3uQMmClMW9wJdYY7oHvkYrmOTUOW
 fiLJZUfuV/8lRYNC78o6VnMbWy/5zQCPAaxXzMVehig==



=E5=9C=A8 2025/1/17 17:23, Johannes Thumshirn =E5=86=99=E9=81=93:
> On 17.01.25 06:47, Qu Wenruo wrote:
>> diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
>> index f809c3200c21..bd71e57d2978 100644
>> --- a/fs/btrfs/super.c
>> +++ b/fs/btrfs/super.c
>> @@ -962,6 +962,13 @@ static int btrfs_fill_super(struct super_block *sb=
,
>>    	sb->s_xattr =3D btrfs_xattr_handlers;
>>    	sb->s_time_gran =3D 1;
>>    	sb->s_iflags |=3D SB_I_CGROUPWB;
>> +	/*
>> +	 * By default data csum is enabled, thus a folio should not be modifi=
ed
>> +	 * until writeback is finished. Or it will cause csum mismatch.
>> +	 * For NODATACSUM inodes, the stable writes feature will be disabled
>> +	 * on a per-inode basis.
>> +	 */
>> +	sb->s_iflags |=3D SB_I_STABLE_WRITES;
>>
>>    	err =3D super_setup_bdi(sb);
>>    	if (err) {
>
> Just a quick question, when we set SB_I_STABLE_WRITES per default, don't
> we need to clear it in case of mount -onodatasum?

Thanks for point this out.

The truth is, we do not need to set the sb flags at all.
Since btrfs_update_address_space_flags() will be called for every inode
read from disk, newly created one or changed by ioctl, we have covered
all cases and no need to set the super flags.

I'll remove the sb one in this case.

Thanks,
Qu

