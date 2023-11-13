Return-Path: <linux-btrfs+bounces-112-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 80E437EA52F
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Nov 2023 22:01:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 03E15B20A72
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Nov 2023 21:01:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 901E1250FD;
	Mon, 13 Nov 2023 21:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="I2+hyAYP"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEB9424A0E
	for <linux-btrfs@vger.kernel.org>; Mon, 13 Nov 2023 21:01:06 +0000 (UTC)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21FE4D52
	for <linux-btrfs@vger.kernel.org>; Mon, 13 Nov 2023 13:01:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
	s=s31663417; t=1699909260; x=1700514060; i=quwenruo.btrfs@gmx.com;
	bh=f575uO4+wgGCTg44lg0cVxHxUHZRAxigyC2jDHKsMUE=;
	h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
	b=I2+hyAYPPqqwzB790NWpQI/hEi6l/nR75K52tzCwzFMtCrXQ9mLyGDPgQsvq3p9q
	 Wp7CWueS34reEA74vPrCixf9fT4kHE4tVzDEZ9bX3UiHMDWWBSWb2wWZi4Z1JK6uq
	 4Cxgoz9fg7GwJppslS3FmLHNmCBLN5ZIMFnl4wOFDMTX10AE3zaZOQc3/3pRxsE7B
	 HJ1kRyT35dUHXLaKLtT4kgvubHFm8x3aPoBVq79lsV5qxvZmShfykyxr0waNeU48H
	 mHUtTCDKocBGlaHN+SxH2umgc87gn2f9mfXyKL2muJ7cPxk1zhw6TfyOmd3M9c2qV
	 OtbsuWfu4hoILGl0fQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.117] ([122.151.37.21]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MSt8W-1qwgSb13Uc-00UGUh; Mon, 13
 Nov 2023 22:00:59 +0100
Message-ID: <f5729921-8f98-4510-b8fc-538b9bcfbad6@gmx.com>
Date: Tue, 14 Nov 2023 07:30:55 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: checksum errors but files are readable and no disk errors
Content-Language: en-US
To: kreijack@inwind.it, Johannes Hirte <johannes.hirte@datenkhaos.de>,
 linux-btrfs@vger.kernel.org
References: <6b6aafe0-811e-4619-91c3-36700e387cec@datenkhaos.de>
 <6a87d788-5f4c-4cb0-8351-233ab924129c@gmx.com>
 <c47b7010-2993-43cb-91b4-13bc0d447260@libero.it>
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
In-Reply-To: <c47b7010-2993-43cb-91b4-13bc0d447260@libero.it>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:wWdnMfg7P1p7t7mgp6Cntf7npeT5Ej7FnzHIvTUZlx3yFDrgGGI
 MNkAZEc5bVyzxNQ7FdWXADPH8/N2NdXM9cXxfoorOTF8iFCHnHa+xUCsX7TzoiUxbjw5g5Y
 VS8UsnwnmDvz6a8hsIqPTGrmHANujkLreCZdPCWL8YB+aUuNqz6pkugi6mT6/Ws+x/5Xc4s
 yxjMde+IVV3CN2SGEGpAw==
UI-OutboundReport: notjunk:1;M01:P0:bHgF7vyN0cs=;x8aE0pU/RgtapAW0h9xQF2YhvUd
 VCtCKTsDmfCkLdWUkuYrquYCfvrkTqu37fdpgqHeRydu++wRD7p4kSF8WwEY6+qsSUqChiafX
 FSEyjds22liCvqKO/dQjpri7NjHVrfX447cl4D6aXYctq4FSkO2hHYIOumu64akXROAtv0qUY
 tOqIlSu0i8Xy1ndAWaIA6o9Lg4Ceq3mh6BrWdV3oxWLlb3sCF8Aevc0S8DvAqgPqTVWHQnjex
 tlZQnl2JWpwHdPIScGJZ0MIFsvNFraJAIKdLqtJOoJyR4N5qsUgiEgsWMsEYjopHfc02NzvBZ
 PEVHaLaWxodIeHuwr4VJ555FIJXllN5UdCLl/T4r8XUvQDNTTqjFn1i8VT0u+LaT8TUQMaRwj
 2NK7XtNP6u5a7CAhWEAq1CZX/oUo36T388pwgQff7CS3uh/kOL59Er+rG8JQl6Y7k9x/354gN
 5A25JM11FOBKa878MXsEOnG65Nr96aD9VBJPQOydQMdVH2Xh0xsbxnhH7YGj3K8evvNBS/K20
 9/apygoMkshi+iR0RoyIcrv3rLwRqqO2teVojmt0XqpOxSUv1tk8yheSBXslkCtn17GC1+cZV
 THW2HBUEnkBdb1DRQ/gb82h5URJ91tzu6z3CTzJbkY+gfk3AO9f97bSqpI/LNeuM9rjNUWJw2
 0MeCbKNqugq/6oMAi8tX4O0Ii9nLYIeEgdYZeIVtCzQ1eE+pkwQAAwxW7ZjgRuTgwbxEY0bAm
 tiRw1WFRgcvGpOePnu2i90//H08xCO/hTQM33NqF1CsWyX7ZsjoLr7oF8bIhf5VHjmMmIGruG
 36LxxJ50+TNPxoC4FU2v1EjSnAPCeWUWP4SXiwy3jnKLaKfqjTAYBJdoygF1s+A1dcyPoHphN
 FD+GQPGGf32Fra1zNh5mKEMWIh/IkhGFSs1zw1Jq50qQdmNsgyKPDIuUKl1601DzwvXAj9qT/
 ML80BitUhb5oFRn3Ko0A8JE7LQo=



On 2023/11/14 07:20, Goffredo Baroncelli wrote:
> Hi Qu,
>
> On 12/11/2023 08.51, Qu Wenruo wrote:
>> For the cause of the error, the most common one is page modification
>> during writeback, which is super common doing DirectIO while modify the
>> page half way.
>> (Which I guess is common for some VM workload? As I have seen several
>> reports like this)
>
> because this is an already known "bug" of btrfs [1], what about taking s=
ome
> (non invasive) countermeasure like:
> - put a warning in a dmesg in case of directio and a file w/csu

This can be overkilled, as most direct IO won't modify their contents
during writeback.

But IMHO we can do a double csum (csum at the beginning of direct IO,
then the regular csum), and compare them, then outputting a warning
message for it.

However this would affect all direct IO, slowing them down due to the
extra csum.

Thanks,
Qu
> - do a csum ^ directio
>  =C2=A0=C2=A0=C2=A0=C2=A0- disable directio in case of a file w/csum
>  =C2=A0=C2=A0=C2=A0=C2=A0- return an error in case of directio and a fil=
e w/csum
>
> If we cannot guarantee the checksum when a directio writing is executed,=
 we
> should not leave the user under the illusion that the file is checksum
> protected.
>
> BR
> GB
>
> [1]
> https://patchwork.kernel.org/project/linux-btrfs/patch/5d52220b-177d-72d=
4-7825-dbe6cbf8722f@inwind.it/
> https://lore.kernel.org/linux-btrfs/1ad3962943592e9a60f88aecdb493f368c70=
bbe1.camel@infradead.org/#r
>

