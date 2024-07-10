Return-Path: <linux-btrfs+bounces-6346-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F0A3192DA97
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Jul 2024 23:13:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D3791F22397
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Jul 2024 21:13:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2270712C465;
	Wed, 10 Jul 2024 21:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="BLp9WuCx"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C71F62B9DD
	for <linux-btrfs@vger.kernel.org>; Wed, 10 Jul 2024 21:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720646016; cv=none; b=jUzPxN3Z8UtNRyjgxcYIT2QkSzGUiv4qP+xEmotqZfsP7Xt+8edkXEs2UKr3I0H0xU17rvn4kCY3PL1VuGBw/wCBnqmZCsTX7Cz7QYpj347nkYQfza4yK8v3sdzPQhBGQnzbfqI12JjflqGEteOwu7PpXqWbPF0DNkxatW/x7JU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720646016; c=relaxed/simple;
	bh=qkCara1QsgOFg8mEln6TXczLJGmKe5hySvCNwOGD0k0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=d52VLRv6mtH3bZKFQxs6i5T6Ygug44InrmLXiajM6xPU0H0LOBg1nXJ1QhFke2Y0Z6aP5NzkmAZLoUrH/T4PzwL4RrwAD5EC8Rv5GciPQbMFMBjl+pU/+wNQNim4SMy0uKvW0o7bRJ6eOuGRhtD5ScaJCSvly4cZIVXLOSSrSlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=BLp9WuCx; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1720646010; x=1721250810; i=quwenruo.btrfs@gmx.com;
	bh=Wmw5Jv6A2QO3Gc+s5eurkphZIMVOh82YqynxIrJsGCE=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=BLp9WuCx0nIiIuKvXu+6rzrp+KTt3vhbaVKCjxWg7RusBLpFw9m4JR4M1seVvkvO
	 YJzqgxbqqQbEaF9FDrW0XNpBGgQQ86qGoiG6GfvpJ2/2tXjOtZDzi1KKr4Dqs5EE+
	 Ox/2db3CZASYd+6urASnjFnQBXzDqUdSsCm2Qmm38cKO4xHgQ82nNx0Jht18+GkAO
	 eriSq4542UyVnvbVk7fjJBvwroB5FLwFgeF6TbH1vZPeyjAW4gT6Qi1DNhTm6bnQ2
	 aNer8TeX37j4vHpfRjqgO0cCnVkJua245ZnyMDUyK7NKtDdcdeuT5WtzAA+aQMmr4
	 wElmoxVhT0TbJ7Cw+A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mjj87-1rybOU2cfr-00bRfH; Wed, 10
 Jul 2024 23:13:30 +0200
Message-ID: <96677547-0177-4226-92bd-174c167269b3@gmx.com>
Date: Thu, 11 Jul 2024 06:43:25 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: btrfs-progs: btrfs dev usa as non-root is wrong and should just
 abort
To: Russell Coker <russell@coker.com.au>, linux-btrfs@vger.kernel.org
References: <2159193.PIDvDuAF1L@cupcakke>
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
In-Reply-To: <2159193.PIDvDuAF1L@cupcakke>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:CsNcp/890sZU6FxSCs/Gscf5shFjq7LGQa5axb5UZMgWv1ZYX8O
 41FKEJMZwgzZk+Rw8d+ARFipey3rtMIb7pen9/bqUX+cQM8dNo1wkO9WeWu/sae1arpcUk2
 JCeFukX/stEBc0Q2EKbHd7RvP72u+pygIAiiYNzBNgQVbuR6BfYElwoVTpefYvHgSGVhukB
 FKl7KEAJtUgLCnKe59TTQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:1XOSmAk2SvY=;Ibp/bzcLZvjkiSei7V+12XvwMhY
 LddtcJppuiuPqw7EpDT1MuX15j6efBYOPEDIKE1DTBTJV/oTp3Y0V6eB7QiSa8JRsz0Ivbpzo
 RNcxIXm2G8ZO4i+g48AQyy7OgFCIQaEFMR2J1AaN+vYVIK4vQAYKVoKbKMLVXbrgEqm4W05i2
 zEUKWxlk2uCe/ZYzECcg+oAivGz0lxMIpMONWb9DcgQ2yoCycI2fm4VN3KSgtBMubvdOZfmC7
 XUdN4n+CsPIYWvNSbP9j0qnbYuna6PulN+TlfpgwAWvxOISCRU+aIyba9xne/zBDEdMQ9sftm
 UasK94BIcfL/LfxZuqqFPhEsZWqZe5P+BtJOCZxZi82UrvrQMlZh1ie+R/lzBQo6eRWzJXhW+
 JkRUjYJzvOOz4MYHaRHUykIX69S8QewJKA7Kt5bEs2T36mTD5QHAyYb9/4IybAP7tZgQONioQ
 WPbahOcPfuC6jGcUu+FVWbVVmiaqW+1P9sD4RruKTmcWvC0IY6s3yqakZ9J3sf90vFbjlsuCY
 5hP7C5QuVDOXAoeoNtEs6r5xlGEZThN90ZM1QLE0Wwcv6AmuI0m7VVnwIfbNqLCXlaKCuxQpu
 VdxOtYTX8uj4g1QhEubb7vzYx5FuALWEZk9fVQ/Rn5ln9G1hA1lyF+bUKM9ok46O9QMAhQz8T
 Dit8JqnmVTzsvZLlw0sspOu/XJXerBSmAyC0AqpxEaYTQl0BMkKKwQ+F7WrGGmQai4azOL68z
 LPZA1+FmhU67dCfhch2PsO32kEjVWYl+YRoPPS228efnuNBa8COXo7aa6ApYorGiAUK0Vo8c6
 ZFp5Mt7vuk3He+FYSVjH8zeA==



=E5=9C=A8 2024/7/10 21:22, Russell Coker =E5=86=99=E9=81=93:
> Below is the difference between running btrfs dev usa as root and non-ro=
ot on
> a laptop with kernel 6.8.12-amd64.  When run as non-root it gets everyth=
ing
> wrong and in my tests I have never been able to see it give nay accurate=
 data
> as non-root.  I think it should just abort with an error in that situati=
on,
> there's no point in giving a wrong answer.
>
> # btrfs dev usa /
> /dev/mapper/root, ID: 1
>     Device size:           476.37GiB
>     Device slack:            1.50KiB
>     Data,single:           216.01GiB
>     Metadata,DUP:            6.00GiB
>     System,DUP:             64.00MiB
>     Unallocated:           254.29GiB
>
> $ btrfs dev usa /
> WARNING: cannot read detailed chunk info, per-device usage will not be s=
hown,
> run as root
> /dev/mapper/root, ID: 1
>     Device size:           952.73MiB
>     Device slack:           16.00EiB
>     Unallocated:           476.37GiB
>

Mind to post the raw result?

The 16EiB output definitely means something wrong.

So far the result looks like btrfs-progs is interpret the result wrong
with some offset of the result.

In my case, non-root call of "btrfs dev usage" always shows the slack as
0, and unallocated as N/A, so the 16EiB looks like some shift.

And what's the version of the btrfs-progs?

Thanks,
Qu


