Return-Path: <linux-btrfs+bounces-8843-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C43AA999BB8
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Oct 2024 06:40:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CAED2863A0
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Oct 2024 04:40:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B0DE1F4FCC;
	Fri, 11 Oct 2024 04:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="tZYmJUq2"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1F8D1922C4
	for <linux-btrfs@vger.kernel.org>; Fri, 11 Oct 2024 04:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728621597; cv=none; b=V/Ksng4GI+ghNU78r4v7bHQ2zNNSFVXzuPYwRBouyAftq9N0P84BeUY+UFx7jE7S65JMb2m2qxq+lIqkvN7Qz18xyVYtIFpyhaq4rDlmU2jeoF+r9SzmJaJkdonR+UfzM4w8saxoH1iMsu1eAoJjlbaHE9q4WKxywZ4Pv3ZBF2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728621597; c=relaxed/simple;
	bh=sOBsMmwbZX3H/EqxU4obaAApGAPNC0AIr6UEMzKYtK0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ecwCNExIE+oBse8+sWBrcAbq4Z4ufK9H9KuxB0cquQJ13VQc3qCYaiCO+av54oQySxzExSSl5D4hPGHSxD+U15/DR3TXz7osH1JTELB6FnK1mCUzHWyXTnH/yZU2ql3y5fK1PjMdc0Yv/Y/pN080uwgI3YMKkPRQO2cRQhpGqNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=tZYmJUq2; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1728621588; x=1729226388; i=quwenruo.btrfs@gmx.com;
	bh=q1ecxXIhbqHfCL6Vghq2yStwugmlMvLsN5TUy0CEEiU=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=tZYmJUq2VyOxl6Wy1sgXgRS+ayskL/MYIJjb27hJ3wcg6WPD3p1vh6P1vX+4aMvK
	 FnyX1DqFoucXbTibA/kqodxhUKj3nt538JDOU83Dm6PMMwkR+IoQZCxzNcJWa7UW1
	 JoatR41zzSY8UCwCD3mSnEIG6hzV+2q1yYMlmlsnI6YM7W/SG+OrkfIjfWs+unvu8
	 3ucUWsoGzy0u4VIhZHJBsII9Vo7gNxGOjpEJCntI66QXDEbp7gmQVoMBca1XGTw97
	 HOsDnHqSnnuOGMxoxOVJ73cfRkI3PAkSgdtjQ0c0yOL10WvtHpiSHD+APQbToFthG
	 d6nLOYFDE8ghyCseLw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MVvPJ-1tQvKr0EwX-00Wfa1; Fri, 11
 Oct 2024 06:39:48 +0200
Message-ID: <32dc259a-4ec0-4582-9c2f-666b56ff1db5@gmx.com>
Date: Fri, 11 Oct 2024 15:09:45 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs-progs: fix usage warning in common/help.c
To: Anand Jain <anand.jain@oracle.com>, linux-btrfs@vger.kernel.org
References: <3ec35c42add1b57d547c9cbd90213a645c7335c9.1728459736.git.anand.jain@oracle.com>
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
In-Reply-To: <3ec35c42add1b57d547c9cbd90213a645c7335c9.1728459736.git.anand.jain@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:udua5ckrWEWX8cZDkj7OmJCP9yprfrgRc6i501m5chonfahTcig
 N3mVkWR6t2CcYEYcF7aC8WgDXAzHGc0MxYapcLnF62OOmg9uZKRxoNPCXZO7CoQwnO5JIck
 xkJYfGUFEE6ENy2j3MpPo/qXYBl96BQVMWaiMu+YA2teXOryazWxHGT1Zc1YXAc+mmLWxtD
 wL8u71knAycSFsxrhfOpg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:h5VCRhSwhiw=;GcM1rYyKZlYHqb3aSClcl9GQruB
 ynJqooqNd0M2WRvKP9DOCea/dsNOAQZFmH9c9x7v7qjOimO7kt5Nt1Cwlh8g0tdH2ew4Rxsfc
 7driQsm36MKyn//j9dEYaWovcbcVb9DbzTFvzIT5kJIVVp79/osAJhSRA82tPA+UpKxpfAsDZ
 HpSYpalSw4VzsPHkeImFDa82ANOTF0lVFaIxTzcPsltwayNgCMV9+zrz0i1NlUXsuxhl4XYxS
 YvL0p2+uaF8Mqfr3wZTjDxcd9JZADlBn+0Nv52yWO5t8a23pP60+97xMhiYwME1PnxBvt+cUX
 ENxvu/MHVAycWucr2Iig0OQNUafhN50lOrXICoAPeMtq8bf5PaLFBdoLUQW1GaiH/UlmkTlpv
 yyOcHaR7ryVzmpfH2icjnPreuvZyblrz7wl1XEupF3Y+FDkkBPU4qS598502R59oVF4Q9CtkX
 /ZO4ZsJoWr/CTx8sW3Sn8v0C963ATC0s5fmaBqVGPW5zjXcQwKVUcnNrZAm7JZn4kAxlipJHc
 djKZs2O8HgqbFaYo6o4tqvMGCsap+GJwNrUN+jWBP1UDb0itEkDRL4KLh5pUfOBbsj2A+aRgS
 2jqVA1bur39TdyfcU5FX/7ussWiVxxjw4xRVZXQxY/2pn+QZTYI1/uwqZXZwTbG4UYYbwfF8Z
 HykWZtkJwF4Lv+NGnALQLjixKPn0Jrdh9W9IJOO0WCGWhXnGT+GXGuqX727oWXrFwnDQEVEma
 D5kNSbAoZTkwmp0Cuo9/zCpA0U5P2EljioXbmO/Em0piY+W1oDLWtLwkfSY6MmvhM4yMQJG5e
 MlqyV0OwL/98qryPONC6OYr8k5pBZ3C7j5qEe1/ZI2Qr4=



=E5=9C=A8 2024/10/11 14:47, Anand Jain =E5=86=99=E9=81=93:
> On systems with glibc 2.34 and 2.39, the following warning appears when
> building the binary, causing concern that something has failed.
>
>      [CC]     common/help.o
> common/help.c: In function =E2=80=98usage=E2=80=99:
> common/help.c:315:58: warning: =E2=80=98%s=E2=80=99 directive argument i=
s null [-Wformat-overflow=3D]
>    315 |                 fprintf(outf, "No short description for '%s'\n"=
, token);
>        |                                                          ^~
> common/help.c:312:46: warning: =E2=80=98%s=E2=80=99 directive argument i=
s null [-Wformat-overflow=3D]
>    312 |                 fprintf(outf, "No usage for '%s'\n", token);
>        |                                              ^~
>
> The compiler warns that in some code paths, the token is `NULL`. Silence
> the warning by checking if the token is `NULL`.
>
> Signed-off-by: Anand Jain <anand.jain@oracle.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Just a small improvement that I will do when merge.
> ---
>   common/help.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/common/help.c b/common/help.c
> index 6cf8e2a9b2ae..eff9aac537db 100644
> --- a/common/help.c
> +++ b/common/help.c
> @@ -309,10 +309,11 @@ static int usage_command_internal(const char * con=
st *usagestr,
>   	ret =3D do_usage_one_command(usagestr, flags, cmd_flags, outf);
>   	switch (ret) {
>   	case -1:
> -		fprintf(outf, "No usage for '%s'\n", token);
> +		fprintf(outf, "No usage for '%s'\n", token ? token : "");

You can just go with 'token ? : ""'

Thanks,
Qu
>   		break;
>   	case -2:
> -		fprintf(outf, "No short description for '%s'\n", token);
> +		fprintf(outf, "No short description for '%s'\n",
> +							token ? token : "");
>   		break;
>   	}
>


