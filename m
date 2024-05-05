Return-Path: <linux-btrfs+bounces-4744-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A488A8BBEF4
	for <lists+linux-btrfs@lfdr.de>; Sun,  5 May 2024 02:50:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15F081F216A3
	for <lists+linux-btrfs@lfdr.de>; Sun,  5 May 2024 00:50:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6A59EBE;
	Sun,  5 May 2024 00:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="If4AgPUJ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 414457FB
	for <linux-btrfs@vger.kernel.org>; Sun,  5 May 2024 00:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714870218; cv=none; b=RmMypiks5mMIF4RDZ66MPemMnTwxLFgiaBF2qPI05OjsHpOlgOXTSnG2+qmhF0WNPuU9qtPny/unkKX0VSIxzEXS4vhSGZ/zpDHaYs0/rdBsbFJMsTL2JCFDKdV+qL6iZRm+D4xeWHA7pY/gRzthg0hDyEJ0JoRIBKwv6943TxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714870218; c=relaxed/simple;
	bh=CzjIbcZVgS8mCOmfk9KPax5MOSYiXJqnelDTafD8P0s=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=kM5V/IMpePyyw2Nj3rx8nccx/2ELOj+rbMkx/oQDIiGcBq3+JJwlkj0XdHs4kuklzCQc0owj9eD/DOsePPfUuchW4C99t7jDJKB2FB32ExJDlIHEvTOPu+4tIWexYJJMr1h6ex9AuCiVj+JL1DUTQeOD1vsmX3v44lxlKJzmxqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=If4AgPUJ; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1714870207; x=1715475007; i=quwenruo.btrfs@gmx.com;
	bh=W+BSsj3qSRAITP+fUp3Nd1dU278w6SgsOFZZJye5hF4=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=If4AgPUJiYCzBzeJzfoTpwfnQhpyCgHYY5KHcLMQClERAtkLmL7wZvcSFJetdU4s
	 cF0I3TqV/mWFDJaBwe6XoufiQWOL0gYQgk+6vzBXTdhERMDkvaDwU7SddXH7VhDIW
	 SYQW0Oa67QCf7A2e3tlDyX4lSRua59XfmotikOptTU3uQoc1ARHzeCoHpM/6IH3R7
	 ee3WVbNkd/0k57E0p7lshKJM1S5SBo8LX/kViaEJQ2N/qr4zTVEzp+y+NEXFKVqxC
	 o3u7rZX38I8fYvOOAYVBYKGrA0JHXWiviUwDOjVJlX9OvlPFg7pZQZnfNBTrn09pb
	 HuWf58t5jJVHdvQEWg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.219] ([159.196.52.54]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1M2O6e-1s3yIy3HKA-003ti9; Sun, 05
 May 2024 02:50:07 +0200
Message-ID: <10bac394-6b9d-4e07-a197-ccd06c16f781@gmx.com>
Date: Sun, 5 May 2024 10:20:02 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: btrfs-convert on 24Gb image corrupts files.
To: jordan.j@mail.bg, linux-btrfs@vger.kernel.org
References: <d34c7d77a7f00c93bea6a4d6e83c7caf.mailbg@mail.bg>
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
In-Reply-To: <d34c7d77a7f00c93bea6a4d6e83c7caf.mailbg@mail.bg>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:FdpwMKsV/71Ec6OFzISxmCkjfeAA5xTV+Yug9kvd36TprY83tyd
 lOsnKzFBDqKS827TbB+NPVctwe2Pp+yJPSy0AwjKzlzlQ4AkRkCceHidfWiUcyFZ18eSI+f
 6sQKFz13j+f1bXatrkX6jsY9BQmxj54lvkPL7CNeEQvI+njF1BTklXCWHFPNKDQrwQ05gix
 oMxfqstfA+yBjXBO/+pOA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:p5tkcZCC7wI=;q226y5KG/K3bUsi0z8ABs7AeGHx
 eDLRTbBW6ceD/MD44O873FCDhVNQIaGzPi+bXfdNKqCk6iC/qFmAS4a+cCWhYwY/Nj/fUNogL
 vsafZ68FQxp2xAoBcpeVGrvd7MS2W5DAPwySCTrIefrAznirV/CpQVWHLAe621XDRTXbyD5Ru
 uL0VIBLIEmOhgt/bOxdsHdphz+DuSaaCiv1xGcofj/taX7t4aQbB027gNqAvJNEcHoyLJdpsQ
 06yJ1WxF9tKg5V1/lN0bb0bkoa6aebDjxTdl0rYBDF7ZYYQyNNm0VmT7z3Y9mpZgcIK/PMLVQ
 Mbs9A5ebZJU1uu1/QgzjEagUOoYwIlqDah9ka4KDwhWNvAnVHUsZ/7w1hRPZcHC3QdjgCINJY
 N8/MG4o5lwVriTsQNNc0tiwT2kNFJ5FtPjsmKXhhFtw/r9YQYYpSy2ha4fHYG1YAuNOg9CIAM
 VqZ0lajlCpGtYmXOa4A0csWAsCLeXXJ+VKNXlsUqS2gNfTXIBog8oL/azrwccJ45G5fEll/wJ
 Hdx7O30/yxTcLTzt4S2L5aMz2CRFg6/N+AQOdZXas49ac77DqPzeGXTgttSwHxX5sy3DM5jT4
 opXBP8mXDCaN5gSvzGAf3AVkFnxyRAR2BPBiibyNix66YSbHhirHuQwB0JlIF5FysuN3cX1gK
 +Q4gPtRdxUDmE0A8VdjVqHcdI124562iFf713MpcTnWd24RZfcGBWhGtH17R8s2pwJx9R/rdF
 J3Npobd8KO36FGp4cdlbi599/7gQ9WhD4zXa8FNoY/Fd9UwQ7eyeZ48N5QyoRs07y1dj91G+O
 BCVyDnC+2fXoGX1KTGvOBJkoudvU3bp0wKclulWnCD27M=



=E5=9C=A8 2024/5/5 10:04, jordan.j@mail.bg =E5=86=99=E9=81=93:
[...]
> *******
>
> on ext4:
>
> ilefrag -v
> m/root/.mozilla/firefox/s554srh9.default-release/storage/permanent/chrom=
e/idb/3561288849sdhlie.sqlite
> Filesystem type is: ef53
> File size of
> m/root/.mozilla/firefox/s554srh9.default-release/storage/permanent/chrom=
e/idb/3561288849sdhlie.sqlite is 49152 (12 blocks of 4096 bytes)
>  =C2=A0ext:=C2=A0=C2=A0=C2=A0=C2=A0 logical_offset:=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 physical_offset: length:=C2=A0=C2=A0 expected:
> flags:
>  =C2=A0=C2=A0 0:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0..=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 1:=C2=A0=C2=A0=C2=A0 2217003..=C2=A0=C2=A0 221=
7004:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 2:
>  =C2=A0=C2=A0 1:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 2..=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 10:=C2=A0=C2=A0=C2=A0 2217019..=C2=A0=C2=A0 2217027:=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 9:=C2=A0=C2=A0=C2=A0 2217005:
>  =C2=A0=C2=A0 2:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 11..=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 11:=C2=A0=C2=A0=C2=A0 2217028..=C2=A0=C2=A0 2217028:=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 1:
> last,unwritten,eof
> m/root/.mozilla/firefox/s554srh9.default-release/storage/permanent/chrom=
e/idb/3561288849sdhlie.sqlite: 2 extents found
>
> on btrfs:
>
> filefrag -v
> k/root/.mozilla/firefox/s554srh9.default-release/storage/permanent/chrom=
e/idb/3561288849sdhlie.sqlite
> Filesystem type is: 9123683e
> File size of
> k/root/.mozilla/firefox/s554srh9.default-release/storage/permanent/chrom=
e/idb/3561288849sdhlie.sqlite is 49152 (12 blocks of 4096 bytes)
>  =C2=A0ext:=C2=A0=C2=A0=C2=A0=C2=A0 logical_offset:=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 physical_offset: length:=C2=A0=C2=A0 expected:
> flags:
>  =C2=A0=C2=A0 0:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0..=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 1:=C2=A0=C2=A0=C2=A0 2217003..=C2=A0=C2=A0 221=
7004:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 2:
> shared
>  =C2=A0=C2=A0 1:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 2..=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 11:=C2=A0=C2=A0=C2=A0 2217019..=C2=A0=C2=A0 2217028:=
=C2=A0=C2=A0=C2=A0=C2=A0 10:=C2=A0=C2=A0=C2=A0 2217005:
> last,shared,eof
> k/root/.mozilla/firefox/s554srh9.default-release/storage/permanent/chrom=
e/idb/3561288849sdhlie.sqlite: 2 extents found
>

This is exactly the problem of unwritten (preallocated) extents.

Considering all corrupted files are from sqlite, it's highly possible
related to that.

> *********
>
> Tried the four patches from:
> https://lore.kernel.org/linux-btrfs/6d2a19ced4551bfcf2a5d841921af7f84c4e=
a950.1714722726.git.anand.jain@oracle.com/
>
> on the https://github.com/kdave/btrfs-progs.git tree - no change.

Unfortunately this means the fix is not working.

Mind to provide the "filefrag -v" output after conversion using Anand's
fixes?

I'm afraid there is something wrong for the fix.

For the worst case, I can go a simpler solution by just converting
preallocated extents to holes as a hot fix.

To me, there is no chance we can utilize the preallocated space anyway,
since the extent is shared with the ext4 image, thus we have to do COW.
So focusing on creating the same preallocated data extents in conversion
makes no sense.

Thanks,
Qu


