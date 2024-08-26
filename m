Return-Path: <linux-btrfs+bounces-7524-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 678D095FC9D
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Aug 2024 00:16:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C5291C2034A
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Aug 2024 22:16:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD28019D88A;
	Mon, 26 Aug 2024 22:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="DXsIRRoC"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C56219D088;
	Mon, 26 Aug 2024 22:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724710570; cv=none; b=sAgibM6PoHbTEQKGOwxiMAS+FaarcqqK9wQdbd+AdypnK32Ur6ab7TaCRtQwGyMmXjnNpXrHroOAO9/MsctqCBzAayKkPnf3M6ekogpN/aBBFmj1JpjWaJb+i0ePMmGpYjFEmrjdQwc1CmW0dCln+yE+xHGS7ukmSDN8kQ7Iqw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724710570; c=relaxed/simple;
	bh=9XvTM4wMA78+6qINfD1s2G4S1dwvqzuLP2uiJYp3ZKM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=irutMFjRTuoYgHXd2sadALkVXYukNj9XlOAB2ELSzyYXdzh4j8PXk2IKhyL3Z6fJsEYWKnABBDM3Q5C1QcSSkMclv0Fg/sacEiBIctmjqv1DKyBFIrhlEfli4yna5yLXGbfjlesuVts6+sICuJmrPdc86KgclJ1np1wEZuAnLAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=DXsIRRoC; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1724710556; x=1725315356; i=quwenruo.btrfs@gmx.com;
	bh=g1MkF2A8UY0lY8N2xcqW1C4UynF1W8GTPh761UUE8z4=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=DXsIRRoC/AT58vr67l5eI5kLapdIFc6qFjOgEogw6Pgc1RfOYplC1a9k2U8T70RP
	 j5AAh8JBvbjPldlxMKbNmzrAeMhZZXJ/g7Ptju25iYfRRgACe8/gn+bfSX7HU0N7Q
	 WSUKDZVOv7FEhEfJJkIQy83zUFdb8aBo0rsOCjXzTI0A8ZIMXgccZ98FwDukuHC6Y
	 m1P8X2hSVywthVZu/nWcI8t3pE6Gza+0n6MptIfh1xiCohuDBkyTC/hFiktHb4pn2
	 PDh4lBzkULo4doDyl7oCTOGlQT+mX0aeeI+D9Z7StXY6Ukmw1gcIdFHOXkhuEaBRI
	 NOQ8Cc+uo9lodnJPoQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1N0X8o-1ruz3g1RYq-00viVN; Tue, 27
 Aug 2024 00:15:56 +0200
Message-ID: <e8a39bc8-7efd-421e-8315-b4a5c977d942@gmx.com>
Date: Tue, 27 Aug 2024 07:45:53 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] fstests: btrfs: a new test case to verify a
 use-after-free bug
To: Filipe Manana <fdmanana@kernel.org>, Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
References: <20240824103021.264856-1-wqu@suse.com>
 <CAL3q7H7Hmqr_bn7b7G6aSKK1vWq4EhW=tuWZRPWZGv-MJtbMTQ@mail.gmail.com>
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
In-Reply-To: <CAL3q7H7Hmqr_bn7b7G6aSKK1vWq4EhW=tuWZRPWZGv-MJtbMTQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:OXtvyuu50mNvbHv5ruo2wFrcPK4QFnbSdBRwu/LEIdsiG0HFg8B
 WiOUU8kBvZ1lph1g7XoA5dYlnobn0QvhsnD7v/UMMWXLTMyZFKjOc/Srz5GL9jw6wJChF6v
 xH37LBimFgcOKj2PyJuytV9SlDY76LptNQi2QmJ5EUhz67GRoysEQaezeiBsp9KbV6ur/VW
 VIO1GPQRYlYfE2j8/mhew==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:rK/koKkZaIU=;7UEUPZlrRHJzKPcmFkziJcauH5h
 Qt72qe66yOLAh1pQfm1snVnb16l8tcD3+utPDL7taemESaIE4jLZ8dCEiuEFdHN2SRznbDv/f
 BhtTLpJ9SOuEcG9Xfq1F3ysO+EkeHzRxU3OHvJMj8m/BM/YTYJtWPjdj4yE6JeoKe+1P4tnkB
 GAO9iqUQ82uoPJmqjX2XEPDwNed03U60aCav8LxdY7E6K7Jk9JSk3u22s0T6jCbJEuiZq+e/L
 WXNvq7JwWuXr/BYRcAxqjDiW2TzR682Pc3paYHOaxTW0C9PH45zlH0/PEb7nXqjp694UyfsvZ
 oTw1f2AxwAY06DJRgxOY63oW2FEVTsHh/Vp3S1+K5BC3Pq+rjtqKWj4l6i6Ov9FcYZSkN6+vr
 9QaHfckUAXAlHKW8xC4P26KyiIvODkMKyvnereK5UHeBEUEcme53nXTuQ2kXuv7njBWBhrSo8
 DSKnUvwcRTP9mh069HvEyAvVvKBw3VvcHjbPN/OvCuBKzcO8mHQu6n+PwPdKqU/AgsBqU1/Cw
 nhaO47ZPgz2rzoP0xrcLhsu9b1z2HxnCXqU6BjzWg81y3Ab3Tk9Tr7U3cauRZJy6v5Bn0ASj4
 MSt1yVtp52/ZYoWgDR7JANFYKawXZSddj86ehb/LMrKimlQhmnMfF+rlkVNw6sD4jPPYV+Fwj
 V8o432R3RbPQbTx+8+MC3mtMWqjQQ9Xual53jGWN5v++GAzh0mJo7ENTcFjdABw+Nwb/wD++4
 MD2TdweZpi1eC+PPP/109Dw4uYA49tvDovwE72ONBiMY6saQkZnUn0e/PXTBRo4JqH8vW8cRW
 gM1DK4wqHh10iuUPdjOdYFZw==



=E5=9C=A8 2024/8/26 21:44, Filipe Manana =E5=86=99=E9=81=93:
[...]
>> +       # Manually check the dmesg for "BUG", and do not call _check_dm=
esg()
>> +       # as it will clear 'check_dmesg' file and skips the final check=
 after
>> +       # the test.
>> +       # For now just focus on the "BUG:" line from KASAN.
>> +       if _check_dmesg_for "BUG" ; then
>> +               _fail "Critical error(s) found in dmesg"
>> +       fi
>
> Why do the check manually? The check script calls _check_dmesg when a
> test finishes and if it finds 'BUG:' there, it will make the test
> fail.
> So there's no need to do the unmount and call _check_dmesg_for.

The main reasons are:

1. Fail the test as soon as possible
    Mostly to let the dmesg to contain only the failed iteration.
    I found it especially useful to stop immediately to inspect the
    dmesg, during the verification of my fix.

    This doesn't make too much difference for routine QA runs, but in the
    future if some regression happened and one (maybe myself) is going to
    investigate the failure, this early exit will make life much easier.

2. To avoid too small dmesg buffer
    Since each iteration will trigger some error message due to the
    corrupted tree blocks, combined with the 32 runs, I'm not that
    confident all dmesg buffer size can save all the dmesg.

Hopes this explains the reasons well.

Thanks,
Qu
>
> Thanks.
>
>> +done
>> +
>> +echo "Silence is golden"
>> +
>> +# success, all done
>> +status=3D0
>> +exit
>> diff --git a/tests/btrfs/319.out b/tests/btrfs/319.out
>> new file mode 100644
>> index 00000000..d40c929a
>> --- /dev/null
>> +++ b/tests/btrfs/319.out
>> @@ -0,0 +1,2 @@
>> +QA output created by 319
>> +Silence is golden
>> --
>> 2.46.0
>>
>>
>

