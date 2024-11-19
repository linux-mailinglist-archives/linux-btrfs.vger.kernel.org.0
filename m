Return-Path: <linux-btrfs+bounces-9757-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BE16C9D1F40
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Nov 2024 05:33:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 31D11B2223D
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Nov 2024 04:33:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34BAB14A09E;
	Tue, 19 Nov 2024 04:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="G5SOtaVe"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C966A1FAA
	for <linux-btrfs@vger.kernel.org>; Tue, 19 Nov 2024 04:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731990813; cv=none; b=JRZF8HnWAsZj2kuDgzLsZzISDG6bPtsriYqsg3nXwjISaF8EFNkpDPTyMH1gyCRY5SRYIY6y7jSx2kBySBPY5iTmiAk/ib8Z5+Yz3IuA+cVV46J6iuZQFIztjlTYf5q8gObkftuy6Ql7TRB3qxZZ2o9FtMru1KKL+wRR8vndVeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731990813; c=relaxed/simple;
	bh=SRB4LRx04f0Q6GCQi1zqUseB2MNp6CrQbUhEYoZMZ48=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=KNmOsjngIJELVmm48HZpkWp48PJ3H7Etq2J35Vh2eladU3sGT3yeezYkgV7rM78Pe2KQLvSqfQVpnOkngTeNQMj90MwT3ldPX5aILZw/Go32+rYndj6egfvFqGkmB2YrvusEhyupcpfVkXdTop3BbjXLbjj21xPemNPWZhcq7Sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=G5SOtaVe; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1731990808; x=1732595608; i=quwenruo.btrfs@gmx.com;
	bh=0yTCUwJVHM2NdHvNFgF36sCIBuEj9Ww2WgE9jw1ukG8=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=G5SOtaVeotBVU4Noq2IiyvfjVk7CTPZImWbPJIrzrvQUbFFcPlnSs78EW3zy2xO+
	 HdfIZIkar0M18oS8ZtuWPCwc9oAfE+oVZTlcuWX5dnmKZczjp/pFV4PiJbm9nMUHy
	 J74SPl7Yd4wqnP6fy6/Vcih7SQk+dRP/9ns1JKCU36ejP9JNKa4ZtW19r8YTvPrr1
	 JxIZJKfyoYAgaK14gqKv72KidPYks+1ytOmmDUgvV5gOkXOQ2ERdar/5RZhiRcAGg
	 vRhKU65B/8VjjBlrRJnOG7x/KTuEeE1HQlgh2SVpr+cfyJMNIZ+4WckMwrZvOqwsk
	 rIPH5Asjdvdr97WD7A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MnakR-1tczq6216z-00fYjl; Tue, 19
 Nov 2024 05:33:27 +0100
Message-ID: <c2eb558f-b145-4567-adc4-9581b8c41962@gmx.com>
Date: Tue, 19 Nov 2024 15:03:24 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs-progs: utils: ask_user: flush stdout after prompt
To: Dominique Martinet <dominique.martinet@atmark-techno.com>,
 linux-btrfs@vger.kernel.org, wqu@suse.com
References: <20241119014339.3640843-1-dominique.martinet@atmark-techno.com>
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
In-Reply-To: <20241119014339.3640843-1-dominique.martinet@atmark-techno.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:wO2Kr3tOU8OdTwNrZy42SLs8kSJEXVIb678jQXzHFHjvvLYNIgd
 c5aFYwyOCJ+DyQi1wdpCJZRDIpljYVtSNIBX3etZJDrLv+hkdmkKCct/ytaVyOTg4jRqP5H
 kZjr/IzQ+H1HrHEMigeqWRkV5+KjIHM/4fwN+CIMuHjk0eP3o3aMKuriFRbPg8dp9bfeYWP
 Vj5XQc5aaV+M7oayJ0/Jw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:FmdBW98xl9g=;c6PIadzJyrD9ryJK5ONGGdWtlAc
 Ko/eEQ0gDituQldp+KV6FOPkw1X4pEjSuT1Ue3ZJR15BDqrEMkZVygaqAxvXeRctgI8tQ2f4D
 tWWE/p0IAwRGqlUDMGaRz6YLAMDo9cuzhsUwEaXy20tVLobx/Ie+Ho8ANrcbkzYhKQifBhkYS
 LGneUnm39K/zeAcLu1uywH0zV5pJefiyd+2E4f457a8MkjLz74WImPvHok91IU2SW0pP+ytvv
 +yTxEFAT68v4eZquUT1Mmb3TZmTuht8lLBpAo2fbb8J310h4qe+kUKls2C0vHDf3mzyKzuRR0
 UMtgKGmtJsnaHYa71j3tizs5hoHDZsc7QDsrUYfUufkpnfeqwdg6EbAmN31xSojpBra9T3r4D
 lCp1QCrf5hW7L2YUb4bFQWdDw84WjbxKJXsYwsG70X6dQFffQXyWDCxnH0gVbNNleiJArXmr7
 KBS803977YRAzel1tcYnkdVFcp7RIqFNuYsdH4VimZWe1FUFKUT4Yded9qgBkAJcPu4R/E6JA
 tDFNH4FYRUOEc2sSCgmzK/hXTF9Pz3yD4cqr1+LffH3D9m9l/pik55+EDpJIPA9ySvToS2FuT
 zmF3S7cx1HEe15DLQ5sKPlMKau4pzB9aT0fNsLJkTqAvfUKK5bhwxtkIwt0sSk5DSdedLGyVD
 Itf733HdVGNro9l7Mhey5bFfNTvaeSmGwZ9t+Bwg5g3J6okqq5UsNzk7eO1HB48ICpG4lCKxr
 SVFrQ/s6aV7u/a/k5sh2z2zdZX7E/Eiiv1uFiPyLZfTnOJ9aHAO1VxaGF1eJHpwHoFYzwkO4S
 3FQxK4lW0NPf7oWRSqHW/8DznbJ2lKhZbS5a7BYWyE21t2o9FZ/Rb1G0gi720fcmNzvMBa+QU
 Us8O43g+FfXtskPqzGbRjj4wi/0LJ/1fqeK6qFtcnndzEXO4TbQm/Enu2



=E5=9C=A8 2024/11/19 12:13, Dominique Martinet =E5=86=99=E9=81=93:
> when stdio is line buffered printf will not flush anything (on musl?),
> leaving the program hanging without displaying any prompt and weird
> dialogs such as the following:
> ```
> alpine:~# btrfstune -S 0 /dev/mmcblk1p1
> WARNING: this is dangerous, clearing the seeding flag may cause the deri=
ved device not to be mountable!
> y
> WARNING: seeding flag is not set on /dev/mmcblk1p1
> We are going to clear the seeding flag, are you sure? [y/N]: alpine:~#
> ```
>
> forcing flush makes the prompt display properly
>
> Signed-off-by: Dominique Martinet <dominique.martinet@atmark-techno.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

> ---
>
> I don't think this behaviour is musl-specific, but it seems odd this was
> never reported before.. perhaps glibc flushes on fgets?
> Anyway, it's easy to fix and there is probably no downside so here's a p=
atch.
>
> I've tested it works as expected, e.g. prompt is now properly displayed
> before waiting for input.
>
>   common/utils.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/common/utils.c b/common/utils.c
> index 3ca7cff396fe..9515abd47af8 100644
> --- a/common/utils.c
> +++ b/common/utils.c
> @@ -416,6 +416,7 @@ int ask_user(const char *question)
>   	char *answer;
>
>   	printf("%s [y/N]: ", question);
> +	fflush(stdout);
>
>   	return fgets(buf, sizeof(buf) - 1, stdin) &&
>   	       (answer =3D strtok_r(buf, " \t\n\r", &saveptr)) &&
> --
> 2.39.5
>
>
>


