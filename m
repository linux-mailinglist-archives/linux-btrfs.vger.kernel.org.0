Return-Path: <linux-btrfs+bounces-9756-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DB9A9D1F3F
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Nov 2024 05:31:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02055282862
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Nov 2024 04:31:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C12414A09E;
	Tue, 19 Nov 2024 04:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="GrIcwqkQ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B27420E6
	for <linux-btrfs@vger.kernel.org>; Tue, 19 Nov 2024 04:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731990696; cv=none; b=dyppUV2yI5f/nrEEtPHxrg3SR1FAqPJJPTXFhJGQBgjfxB4Uz+5qJ62nqmyOlSPb0IxqQ3znOhO4bv8CMKS58n3I/hUZd4vycuf7gezBshccC9nXg3XWi/q0+ZM3cGSuGOjvH2gIky03uW3l9iXVDOavg5vcOc0yrvuqZ/zmsVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731990696; c=relaxed/simple;
	bh=PeCxBQLVk+KCZbcqrJzm+2IDYm+s9czjIcb0CYf0ct4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=OvDwpYU8o+fDfTa/HgKX6BtT+aIEIkb8e5ZeYLKJc8IWjR4c3xiZF5evUEPbjrxmGEy1rk6q77cCe1nMoaH5zXDpxfHVc/h3qBvF9WQF09sCN0DpIa1jH2ztGAjvwET0C0/9Vb6ckA6OJz8H15HKvlz8eWf6dksv3ox8QbRcX4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=GrIcwqkQ; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1731990691; x=1732595491; i=quwenruo.btrfs@gmx.com;
	bh=x+CnndK9hMspg1NCdmiAmJM4UGGVWE7jt6ECR8ubIMQ=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=GrIcwqkQHsSlgIZjpOoB+DDPmSCykiONx+XPLDzhHPRwDmREBPGbg34LC8P47TRs
	 XxTA5zm8I2RGBcbvGrI5Shr/dlBolXXJo0SVFBeQTnI62OaWLaXerqM9AW0+eVTw9
	 8AlumkZ/w/VXRfcdoxXW67ZqoVfwF4BheASKbxcKK1cj4Eb/Al49JDnhR2vw3c8iX
	 pIcxJxHZo2GRUYKZ7aa/sbLFk1s6P2W7r6qGoME3L/F4BiXk6yusUpWzPI0sIx2HO
	 ZrdCn2JNt1tUjYpu2htXotNJz2eIftn6eBZhmYMYwds2nW+w6NDd+TN9v6lBh6yo7
	 KqA8ZziZr/qlPxJvwA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1Mi2Nv-1tiRv92PDN-00mKHG; Tue, 19
 Nov 2024 05:31:31 +0100
Message-ID: <4007dcda-e89f-42c8-ba6f-59895de3a7a6@gmx.com>
Date: Tue, 19 Nov 2024 15:01:27 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs-progs: device-utils: include libgen.h for musl
To: Dominique Martinet <dominique.martinet@atmark-techno.com>,
 linux-btrfs@vger.kernel.org, wqu@suse.com
References: <20241119014326.3639742-1-dominique.martinet@atmark-techno.com>
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
In-Reply-To: <20241119014326.3639742-1-dominique.martinet@atmark-techno.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Dq4Dhrz80j5pqdUFB4ZXcL6/vqbwbRNy2H6IIvvgaHjR4Latyig
 NLYj3jOYO+3UwfRYYHVzkFHSU0kBKmP4TGOWsVq9l8XZVJIZjbEZYHPp+A0X+TLNiKn0qDA
 H+1fRY4EEo614hEtYSMqQoyGu8kczsi5yL2QAgboZ7k3UTkIfqeXtahjRi7VbFbSsbTN5NG
 jIXcgq54tv2p+wvflPleg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:tPeglHfitxg=;TJsy0z1uf+aHj9PvXIl8n6fuu0B
 k/+rFyt9fYri6yTQNxqepk/7ggGb6VszZXL4nUeGrX8qABfgjMwBCRxw6hhAtjBBU05mwYgoP
 okENWl7zDXyxiKu+H79LJP4Ou8RNdHZRHxqjDpfRxkgXBQKxWq1Rww0T7SZepTxQfcLJPdjka
 ClNF34Hncg8X4rcGnpvHaEBbkbTkaTzrM0bLGGysLQJuKEmPthM7gdw70VMdW1xa01cAe3rQh
 LCLiYLEvPedsxHMTS9qtqHpQ0wv+XYB1r2mglvnqaKDjJi8Lz/zAcYjcrAz1F7Q56EZGgDwnl
 RXQQOXcbtInQLnHN80yuroeAK4efq+4fkz3udfhZKG+fuzBdxOgI4h2z4vljc+Sx+zfxuNoym
 12av/ZCG9YOvHKJicJwQ75Lwy+mSjxW68pyXCh+/zHcEt0dL3OEwHTQFUeSD4lz29C+sjaImW
 bb3Q/yTwLlioHPD47xzV/ieK1CUz8p2EtQQyyXFnkhm+xMxPvPyY0Ju2iAndyVkhKjbqxTmHo
 3jdOwLL5zLaHvXN24KuzX+aTTspjNqV87OUD8t+NVmM99mgOSuIODaLhbyKx4wGeVkc3ZNIDk
 PJbU26vhS+BAPXp9T4GY7Px19IHW1TWiZGRAno/Ua7KVJYsdPC0ftpqkEpsz/32w2AJEkJGm9
 pXt7LNW+mjtUxblEzckXDHt1ETEpnpYsg6pX2UeZyDoNLEhg1DUIQ/fvZLZxaffsKBRq72IGD
 owSzmcSYF4JCRy6CKOwBVIM/b335XJymihOpUIrVYRhz8O09qpLPhRjuo45k/bstRCjpyWcse
 Sv+P4PBCV0NROb4l7peLfTNfaMxZYNqE5iPJR2RzG7bncLJX7vClQEQcsMnSRqMQqo3qHc9MB
 Lj8mr94KhhvyHDfTulRlF8X2Cs3LTPD+/c/FP7MqWsAdesAjbdVh31Wd0



=E5=9C=A8 2024/11/19 12:13, Dominique Martinet =E5=86=99=E9=81=93:
> musl 1.2.5 no longer defines basename in strings.h and requires includin=
g
> libgen.h as specified by POSIX, and builds now fail with this without it=
:
> common/device-utils.c: In function 'device_get_partition_size_sysfs':
> common/device-utils.c:345:16: warning: implicit declaration of function =
'basename' [-Wimplicit-function-declaration]
>    345 |         name =3D basename(path);
>        |                ^~~~~~~~
> common/device-utils.c:345:14: warning: assignment to 'char *' from 'int'=
 makes pointer from integer without a cast [-Wint-conversion]
>    345 |         name =3D basename(path);
>        |              ^
>
> Link: https://gitlab.alpinelinux.org/alpine/aports/-/issues/16106
> Signed-off-by: Dominique Martinet <dominique.martinet@atmark-techno.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>
> This was fixed in alpine for a while but the patch never seems to have
> been sent (at least a quick search didn't turn it up)
>
> It doesn't break anything for other libcs so probably harmless as is.
>
>   common/device-utils.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/common/device-utils.c b/common/device-utils.c
> index c39e6d6166ad..56924acd7901 100644
> --- a/common/device-utils.c
> +++ b/common/device-utils.c
> @@ -22,6 +22,7 @@
>   #include <linux/blkzoned.h>
>   #endif
>   #include <linux/fs.h>
> +#include <libgen.h>
>   #include <limits.h>
>   #include <stdio.h>
>   #include <stdlib.h>
> --
> 2.39.5
>
>
>


