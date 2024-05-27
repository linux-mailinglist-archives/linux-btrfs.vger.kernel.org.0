Return-Path: <linux-btrfs+bounces-5298-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 49C748CFCF5
	for <lists+linux-btrfs@lfdr.de>; Mon, 27 May 2024 11:33:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A1021C21470
	for <lists+linux-btrfs@lfdr.de>; Mon, 27 May 2024 09:33:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05B4A13A40D;
	Mon, 27 May 2024 09:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="ngxQgDQd"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0CE7433C8;
	Mon, 27 May 2024 09:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716802386; cv=none; b=sGDoLYQoYrANyZ+U9IYlJ4hhaibpD41Il/C+JN5ksmgfF568gGyKB1NkOrd5UHXN6vqBib9ev5H1AeU8fAeMlLtt5YLk7TBm6K3hPhjPfN7xOdFvTvxZtpOE2/MBsymg09m8abctfLR3rSlBtp4aJFB4v6ujOKvnlP0w+2vK7k0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716802386; c=relaxed/simple;
	bh=4XW+6tbBEy2iyHYT5TIFv/vrwoVC/qccAK8NEh+F1a0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=gvbuoecUDU5AQNJ5sEED5cA2LXa+mHpCYNEAu8Vczdxi5wjn972q1cMnK4kHYhU2aFE9lwnuh/8Y/6cayvoUClRO+MKhyhgmk7TH25U3DfWN9YRcEKvwsRricp6Z525P0rRw7l9Gk1E2ajQc//aMS908CQzNdAFNz9n2Z1GoLvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=ngxQgDQd; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1716802381; x=1717407181; i=quwenruo.btrfs@gmx.com;
	bh=4XW+6tbBEy2iyHYT5TIFv/vrwoVC/qccAK8NEh+F1a0=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=ngxQgDQdPpFHO36fVtkzzoTIWZctk18RZEhLK6X8t3x/FiDgCjUIFkrzi2y62/d7
	 AQ+eCr19///uT4SYciKb7Z8zHzJ3wFBWxW7GScbLJ9/v0Spu8xq2KB8AWWqH+9x86
	 LbKiiaNt3DiaR0KoPE9Dc8EDGK5y3ZabYaBBa+voAzgSl4tzu2m/pbbaRFdHjaatv
	 XLQeqqRopmQDsNrA+4tvA9ZPek/gT802kZg34dWcX98J4w+igSTNBzHGYO2wUqS4r
	 IlAP3J6GOOPsgNik0g6bU2W46CXWo1zNtV1UTtsZotrjdZp1W8meowaxbpFhRmkQw
	 0sJKNibmQr2y/Wmr4Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.219] ([159.196.52.54]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1M3lY1-1sCLfj42XT-000rOL; Mon, 27
 May 2024 11:33:01 +0200
Message-ID: <1d887489-200c-46e1-9ee3-8b18722ce19c@gmx.com>
Date: Mon, 27 May 2024 19:02:56 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: RIP: + BUG: with 6.8.11 and BTRFS
To: =?UTF-8?Q?Toralf_F=C3=B6rster?= <toralf.foerster@gmx.de>,
 Linux Kernel <linux-kernel@vger.kernel.org>,
 "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <e8b3311c-9a75-4903-907f-fc0f7a3fe423@gmx.de>
 <3c053912-4e47-4c44-be80-dee4ade8bc6b@gmx.de>
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
In-Reply-To: <3c053912-4e47-4c44-be80-dee4ade8bc6b@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:zHhdWDzOIf/C3FWPOuwfPQkNz2On5FPg8huhjBBAY/dIO6OOgCH
 p8t/DqHSrNS0CWt8Yg6ZsJaLBquIlTFF6hvPssYU63zhCmeJFR/EuE/dJeinvkatww3cBMy
 NjtWA6bNrROjCWj42emuZ3t/9G41ElLZ5sTkU/UMRbNZVchNSVL5hRqOoBpafYcD4Ttk+Bg
 0STx/qmQ6WrlwZNTRxwPw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:oB+knTX/Cl4=;WM15gvhhh1/W79ievprLXVD9NzQ
 NI58Zze4OCyY/3G9bMANCvgqnlKSvsIyg7y8ZE/saNNifSJDDfDA1zu2jLPijjz1rDdbLIQd7
 e5rG8v6l+rsuPld63qN1MomLCE6IddXCUOgFtRAqTnzeLBQoVfAumW2xdrdyPrAjfHIvnZYDy
 hTPexN9uKndrEctFcUnfES/oqMHUuq9IGivE/cHmN7gx6RGnoJ4t63H09dqoj5RL97joNppOW
 j9nvm7+CdLXeanBRcH1g8+3kNtQJZCuIsX5Too8wDuq8jyL6hNTnJLD5bgYrnJeBtW2v58Oj1
 fRdU4DrkLQV+NL65JRnaTKfGRSbMLUAUdGxUaNW75nNi0gp+U5BG4K9VSXhbqKs9XlnC/FZSQ
 GKFw+WPsb9Tam8bpiLEgNMnIsN2dFkh2z7xOAtjs1OQwstFfSXMHzIFqWRCKlxIbVrvxPclUA
 m09+3NUT0+THK86xffZ5If+bNwcGFYzXS7wdpKZrUG9xQoL3ActZu5zx18TqBoMrCLBHWZlgO
 NuH5omIAfPM+gTgeX/kTQ9apf8LlwUKNOSk+rfcYYpeJYEFOK/fwcynOr+rGkGcILHO+3NAgx
 2pkD1HeYkWiB4gmU1R04KhRF4MdkqOpupwLqrtEs9BUHv6TkFyGsQhcEmMbDCPZh/hwyY5qbs
 oiWJ7Fno3zDgVFKm1gKl07EPVc+A2xDkCGPnWSr4WEcWkxprLTw1N3xCG5zEVl+wgjVJGYohA
 LgG9GfgPzWCki/sp0vPcgdmeztW9pEnNwlZpbVWKite0bKpyFhkvbt4TsfXb8S0JRomFL95d8
 CeT0MqI/3eNOb9QYX3eMNE0+pfb8pjeJOo9guqHEhEK0k=



=E5=9C=A8 2024/5/27 00:16, Toralf F=C3=B6rster =E5=86=99=E9=81=93:
> On 5/26/24 11:08, Toralf F=C3=B6rster wrote:
>>
>> I=C2=A0upgraded=C2=A0yesterday=C2=A0from=C2=A0kernel=C2=A06.8.10=C2=A0t=
o=C2=A06.8.11.
>>
>> The=C2=A0system=C2=A0does=C2=A0not=C2=A0recover=C2=A0from=C2=A0reboot=
=C2=A0in=C2=A0moment.
>
> It recovered eventually, I switched to 6.9.2, which runs fine so far.
> But these are new log messages:

That looks exactly the one Linus recently reported
(https://lore.kernel.org/linux-btrfs/CAHk-=3Dwgt362nGfScVOOii8cgKn2LVVHeOv=
OA7OBwg1OwbuJQcw@mail.gmail.com/)

Unfortunately he is reproducing it with latest master, so I'm not sure
if v6.9 is any better.

Meanwhile if you can reproduce the problem reliably, I can craft several
debug patches for you to test, but I'm afraid it's not that reproducible..=
.

Thanks,
Qu
>
> May 26 13:44:06 mr-fox kernel: WARNING: stack recursion on stack type 4
> May 26 13:44:06 mr-fox kernel: WARNING: can't access registers at
> syscall_return_via_sysret+0x64/0xc2
> May 26 13:44:06 mr-fox sSMTP[29464]: Creating SSL connection to host
> May 26 13:44:06 mr-fox sSMTP[29464]: SSL connection using
> TLS_AES_256_GCM_SHA384
> May 26 13:44:07 mr-fox kernel: perf: interrupt took too long (2635 >
> 2500), lowering kernel.perf_event_max_sample_rate to 75750
> May 26 13:44:07 mr-fox kernel: perf: interrupt took too long (3323 >
> 3293), lowering kernel.perf_event_max_sample_rate to 60000
> May 26 13:44:07 mr-fox kernel: perf: interrupt took too long (4168 >
> 4153), lowering kernel.perf_event_max_sample_rate to 47750
> May 26 13:44:07 mr-fox kernel: perf: interrupt took too long (5273 >
> 5210), lowering kernel.perf_event_max_sample_rate to 37750
> May 26 13:44:07 mr-fox kernel: perf: interrupt took too long (6600 >
> 6591), lowering kernel.perf_event_max_sample_rate to 30250
> May 26 13:44:07 mr-fox kernel: perf: interrupt took too long (8318 >
> 8250), lowering kernel.perf_event_max_sample_rate to 24000
> May 26 13:44:07 mr-fox kernel: perf: interrupt took too long (10415 >
> 10397), lowering kernel.perf_event_max_sample_rate to 19000
> May 26 13:44:09 mr-fox kernel: perf: interrupt took too long (13048 >
> 13018), lowering kernel.perf_event_max_sample_rate to 15250
>
> --
> Toralf
>
>

