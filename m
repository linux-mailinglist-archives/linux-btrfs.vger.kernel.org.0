Return-Path: <linux-btrfs+bounces-4747-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 24F0A8BBF64
	for <lists+linux-btrfs@lfdr.de>; Sun,  5 May 2024 07:55:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4027F1C20AED
	for <lists+linux-btrfs@lfdr.de>; Sun,  5 May 2024 05:55:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1CA763D0;
	Sun,  5 May 2024 05:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="jvN4i90p"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F07A6112
	for <linux-btrfs@vger.kernel.org>; Sun,  5 May 2024 05:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714888507; cv=none; b=WjZJFN3e/sBy0nna8ALtNRqA08UA5oqjwz4iLFmHfokIZjfmXMKhIlLeAfiJxsN9yoyKBY1pRFpIXWvgv9X38eaMGnve41oeQRdR1xI4wsiUr5Fi0we7YEfRZK9OTBNju44Jj63MyvqQBOuLQz5Mtqa7LTD2bMMQe8vk9EScgkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714888507; c=relaxed/simple;
	bh=g7o4XFKYC/H5SLM+qAdf+OaWs77ljsHIrtehzk0kngw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Jl3y1j1t6wZ1s4fkEbnP4QOx74kufO0IPd4fqTDVa7n9Ku1Ya1VgMSnzuh/sxx49M4m1Nzk4/eRjCLq5zBW6YrYCJlQzNVwUQAI5HwKb4QNCxSXXJl2UKCBs01KXKCPfK0eX3l0S/BNzEiPEbHtQnebL6Undp+kLKndjBtnj2DM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=jvN4i90p; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1714888486; x=1715493286; i=quwenruo.btrfs@gmx.com;
	bh=Wf/EITvpajNOx35ey1gCps86FO/rXhmDe6LqDVrbDGY=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=jvN4i90pgjB09wyErgZZlkmZClWz9blf1yK8+wUe5Je0bqASM4iOZ+r+/7O9phRG
	 uYVSSyrFFJIfgVC6UBV+v9N2lOS5kGmTNqcKpk/siBy82bL9jnfl40HQ9K0ipObp2
	 6OBDcQOY08BQiBwY+Nr84P5b39pQHj1JYfc/OschYLLeIhG6XkFEjDqLErCDGoBL0
	 r6z4wqaG3tSfsc+t836+lcVIfG+w+6BG9pDeugrHFSH8JPpUZnH3CmdVnayol1gl1
	 60E6yEx2H1PuuAw030fKsW8ohIkFzl7VDy9AUzr+o1RPBxnvujWmX2/ta5Ispqf5v
	 bqFKFlE+BNPmB078fQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.219] ([159.196.52.54]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1ML9uK-1sKc0l1JnW-00J7dP; Sun, 05
 May 2024 07:54:46 +0200
Message-ID: <f6aca430-55fe-433c-93ef-4fb2efc19ec5@gmx.com>
Date: Sun, 5 May 2024 15:24:40 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: btrfs-convert on 24Gb image corrupts files.
To: Anand Jain <anand.jain@oracle.com>, jordan.j@mail.bg,
 linux-btrfs@vger.kernel.org
References: <d34c7d77a7f00c93bea6a4d6e83c7caf.mailbg@mail.bg>
 <0fbad9f2-6f26-4fcb-ac8e-a1fa4ebc80db@oracle.com>
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
In-Reply-To: <0fbad9f2-6f26-4fcb-ac8e-a1fa4ebc80db@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:bq5953+lxERwbDRaSpVVIxYYSq62GZzU2BzbXfatwIqwRwx4JQW
 WwJ919qXtWVwtOY+z087WQoHLZCps7DCxh+1Y5enttHKfdLz+qxJK8zdHRxXQWqqkqrOarR
 yskuBY3TolKl0S3UzkR6qMWIgwdSrH/Qgh+8Kb+huGKmD3lt948QFi7Ss1lyAUF63AUXIWW
 /woWLxdDw+KvCVsVdqLSw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:caTPdIaipEg=;vq76XqfQAA0Y7pURoYj6Ul3h86A
 QjJyavl61w5c2w2EfESS06C5Kf4DvVJyKIp3Gzq6rKSSqRyFT0P1TNpWp3WkuSi015upI2DbG
 OizAdnxIlrkSH6RKtGb9XIzRBrU8g6WQRvZdFuACyFxyMnCto0zGJJJNzXYs62HAxYcc7XIDj
 sQCgqVvUVa0dhYo+AF5kNr9npJeqP/CfBhjx3upMY/Hf0L32XXP570lgDwi8GZ7IWYzbI8YBP
 RL5p3ROHSk/Jumhu4+MI1xxqxO1Rp9foxqsF3viBdI4e0UBmxzxHKuuviOXd/06STjJN/DyqM
 ibeDbxLRgWHj4naoSoMBOaAdMJ7qBG0VmSMx53iCyU7Q0BlrEV1LslL3GdVyK1mzRiwUE7IXj
 9WRwQvN72ipKheB4EKVldYvuTcvT4B8e68J4xONq6xkwxRK/5aG+mI5lQahaqg+A++gwqnE7d
 eUOGGHZS1jDNzCFCEPEEbq2p9HvzMIfmQgJahIx1MOHVOMWc3C2TKpgrSeKketQ0+q7upOB5F
 3pvciqN9JvnQEV79mMmawE4chycDu9KNY+mN4LVxkJsmZz8lLluF01Hll784qUVsIIrKxYq3E
 5yyPwYj+Rq1eTnn4gjccI/7JbR6R8N9+Iuzde4LvlAHNqN4M737npwwEOWfPHuHMVdBKHLKbf
 TN61r4uPWXtqgxOUW0uiglUY6mEbut5xRdcevwojyDLTUXnzAcGDug7Rp9b2Ppe+2J0gSn9V8
 inY2kcnysEiAvF3MJ/Z8L2SaDp23eQTWmxiByhC3vi/IfSC5bVLzXR7pifFemwO3xLh9y5ToP
 +ypktbAd5XbTyFuJT3JKT8N4E+t77pXwEDR/uMP3RUlJ0=



=E5=9C=A8 2024/5/5 10:26, Anand Jain =E5=86=99=E9=81=93:
>
>> on ext4:
>>
>> ilefrag -v
>> m/root/.mozilla/firefox/s554srh9.default-release/storage/permanent/chro=
me/idb/3561288849sdhlie.sqlite
>> Filesystem type is: ef53
>> File size of
>> m/root/.mozilla/firefox/s554srh9.default-release/storage/permanent/chro=
me/idb/3561288849sdhlie.sqlite is 49152 (12 blocks of 4096 bytes)
>> =C2=A0=C2=A0ext:=C2=A0=C2=A0=C2=A0=C2=A0 logical_offset:=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 physical_offset: length:=C2=A0=C2=A0 expected:
>> flags:
>> =C2=A0=C2=A0=C2=A0 0:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0..=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1:=C2=A0=C2=A0=C2=A0 2217003..=C2=A0=C2=
=A0 2217004:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 2:
>> =C2=A0=C2=A0=C2=A0 1:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 2..=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 10:=C2=A0=C2=A0=C2=A0 2217019..=C2=A0=C2=A0 22=
17027:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 9:=C2=A0=C2=A0=C2=A0 2217005:
>> =C2=A0=C2=A0=C2=A0 2:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 11..=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 11:=C2=A0=C2=A0=C2=A0 2217028..=C2=A0=C2=A0 2217028:=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1:
>> last,unwritten,eof
>> m/root/.mozilla/firefox/s554srh9.default-release/storage/permanent/chro=
me/idb/3561288849sdhlie.sqlite: 2 extents found
>>
>
>
> btrfs-convert doesn't support ext4's "unwritten" extents. V2 of the fix
> is in progress.
>
>  =C2=A0 [PATCH 0/4] btrfs-progs: add support ext4 unwritten file extent

But the reporter also tried your patchset already:

 > *********
 >
 > Tried the four patches from:
https://lore.kernel.org/linux-btrfs/6d2a19ced4551bfcf2a5d841921af7f84c4ea9=
50.1714722726.git.anand.jain@oracle.com/

 > on the https://github.com/kdave/btrfs-progs.git tree - no change.
 >
 > **********

Any clue why it doesn't work?

Anyway, for now I'd prefer to change those unwritten extents just to holes=
.

Remember every file extent is shared between the inode and the ext4
image, meaning even if we created the preallocated extents correctly,
any newer write would be COWed anyway.

Thus for now, I believe changing the unwritten extents to holes would be
much easier.

Thanks,
Qu
>
>
> Thanks, Anand
>

