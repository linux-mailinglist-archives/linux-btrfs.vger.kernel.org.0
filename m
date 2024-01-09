Return-Path: <linux-btrfs+bounces-1331-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 76660828FC5
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 Jan 2024 23:20:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 720601C250BE
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 Jan 2024 22:20:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53A253DBB1;
	Tue,  9 Jan 2024 22:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="KvZR+2yw"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FC9A3DB9F
	for <linux-btrfs@vger.kernel.org>; Tue,  9 Jan 2024 22:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
	s=s31663417; t=1704838644; x=1705443444; i=quwenruo.btrfs@gmx.com;
	bh=DvTaZldHxuHSANBkjKnuhs50Mh/XS4GkG4G5H45rxrM=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=KvZR+2ywos0uJz7qd3fg4Odn5T8IE1uH5fNwBxu45XaSnubRQzOfvJ2JXShYaS7J
	 88Kn4ff8Lz+XzIaszFePhvHJvcZQ0ltwg1/6RkEdWBGsdOf16ylxq6QdOw+Awivmz
	 CArffZHvV6PUNA1op+6cJOw730qJYINQEsCD4Ltz0kYS7C5xUzc62X+TmlBcM2uIU
	 o6+wPxQtB04Tj9wGRbapHqIcvLuTVmGdhYZkk4zGMmtGT1M+lkvQrx5QzQ8FSFpGj
	 wQJpAhG7lhxHBIHBEleqxDKcsOyoUUXXI9OEr/rRUQ0WYX+gb5cJ8XX/8IkK050NJ
	 fYCIEheMveOh6IdMLA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.153] ([193.115.113.22]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MkHQX-1quMJ83BZR-00kgKb; Tue, 09
 Jan 2024 23:17:24 +0100
Message-ID: <61b6a8db-61ad-4c59-9f35-49e30a6437cc@gmx.com>
Date: Wed, 10 Jan 2024 08:47:19 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: defrag: add under utilized extent to defrag target
 list
Content-Language: en-US
To: Christoph Anton Mitterer <calestyo@scientia.org>,
 Filipe Manana <fdmanana@kernel.org>
Cc: linux-btrfs@vger.kernel.org
References: <2c2fac36b67c97c9955eb24a97c6f3c09d21c7ff.1704440000.git.wqu@suse.com>
 <CAL3q7H5LEjZCkhTwgYJLSeQkG6NsY5AhE__na-2hCa7UuXuCzw@mail.gmail.com>
 <59615d5b-8802-4218-8b0b-18e3eff47cb3@gmx.com>
 <adb8b47a1dcb44747b15dde1aa6ac8c2592edd45.camel@scientia.org>
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
In-Reply-To: <adb8b47a1dcb44747b15dde1aa6ac8c2592edd45.camel@scientia.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:0ymA2vWB3H+oCOL0rkL/KKTnEj+A+Zf1CTM5togmPyfg04shAcY
 L5W3/4G5UF/BGTEpLQ+3v/E1KxF+zbmdAhNmtfX1zDcGmFfCmNXUHH1WyBkK42n8oMdJE8G
 WzoqQIOndHeM+Xw84NM/NCgFIJxGIW76mgHX06tHeZ2eiOgF08g1Bqo5PWmHu+So68hxR2Z
 9q4Egxv4RtjJT5bzAq6IQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:OeKyaakCOX8=;otjKE/mIGw9wj2M90p1vkFJiHx/
 z2S9H7nSi2j2rNC7Ln31XgnOQGVKCPiZQwdb+Xpkv0wU2S37BwnkhDvGIUPsJs4/J4RnePJob
 FfZQUcbNL2lJTCFK8nVMm5RQrhsKCtnGylbj7boeWJ1FgQaVPLjsNZG2wBaSThy03TzdrC1kr
 NmcLMc+K/duLg82LZTSwwg1Ep3CaTVRS1OMCTSlCIrI8TS6boswM+8rfCwuH2Z8WknIA2SmoC
 QrdrIsiC4PluLQMsiDf43HrXfXvTOYbIDae9DCY2GmH0rw2YR7vfpysVbiR2le+p1mqOewWMl
 WOEmwrmbszCpgmC1risxTOgxXX5JtKBKxJzAeAKQ4CYKOi9ND4j//xtScK6Sqb2xhtT6HZAN3
 wZGsHquvf6mtZOG0s30ANbvVYgL2ekKUFifhPSZQYc8p8l3sqiWLs8TNvxn0N28qoo4IVDJ38
 BD3WgnDhm7I0MpqUdln1Ys91r/sAaHjbE/BplTHATlcTSxYs9ocWWR9px7Y5eLJuzhKdvpQRa
 HyNRMDO6J6DGHx9i2JWEyO+2lmn7bb5/imh3S6oSdvdBWbItCEpPkH45H7JWtAqV9r40SHJkO
 E7xlfYQ0nY5SRurT4lSQICAddvhrQIbzTxiOkXBpBC0nK3Go6sx6nai/xUdlwZ4GpiHn5krPD
 hC9zK8INF7EUA5PzIGu34aJunvTenS+MfMn3l5bqO82eYHxXDV3+4sHt2KUTOWSxfsEA/DRdR
 /M7Ny8GfSYfmFukU1O2wX90Fg6Ih2kJQg29uytoCUYBhAVia2+XuP4hXLBySUtMNOIgLjc8Mv
 q4qKO4evVnCdFF781JNac1cklyNWGAky6MshVV/Jh2IAv63w+amFnFEEtNOyosF6hOQdJUVnA
 fT7WkU8KV9JD79TifZliEskVHMk1JGTvMe/1v2nKfGimzeuZ/lYValKI3tgxxDeFtcEsWYCiH
 3k91tJS1uk4/E5YoSLFh/n/g8n4=



On 2024/1/10 08:27, Christoph Anton Mitterer wrote:
> On Wed, 2024-01-10 at 07:34 +1030, Qu Wenruo wrote:
>> The 1/16 is chosen as a trade-off between wasted space and possible
>> unnecessary defrag.
>
> Felipe's point doesn't seem so invalid.... wouldn't it be possible to
> make the trade-off somehow configurable, so that the user can choose
> via some command line option?

We have 16 bytes extra space for the ioctl, I think we can go 2 u32 to
configure both ratio and wasted space if needed.

Unfortunately we don't have any existing checks on
btrfs_ioctl_defrag_range_args::flags, which means we have no way to
detect if the kernel supports new flags.

I'll start adding such rejection first, then we can start adding new
btrfs_ioctl_defrag_range_args flags/options to support configurable
ratio/wasted bytes.

Thanks,
Qu

>
> Cheers,
> Chris.

