Return-Path: <linux-btrfs+bounces-6165-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A0840925499
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 Jul 2024 09:28:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5565C1F23B34
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 Jul 2024 07:28:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E66913699F;
	Wed,  3 Jul 2024 07:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="EHZA9Ljk"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C96A3131BDD
	for <linux-btrfs@vger.kernel.org>; Wed,  3 Jul 2024 07:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719991699; cv=none; b=k65VJxjoq3J6YOYB5tdGH+hqfdf4xJSua+9t876o+oQmTtabZEp2V9wPdF8jlJvM23fesyIikkGipWYWPkHYoZHXdwH8fND8181DmqNbPQp8McwqcQZJNXS6+FgDS5KBOpv7ekFWMIzLTH+eMT6/A2LQNQ0LWNmdMpBpV7zxAfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719991699; c=relaxed/simple;
	bh=gm7hdx3PNXV/QfI9KphcFFX2lhl/K3/HmDmVxp7nOzs=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=EEOb1mqF/juKep7TG5161URZFlSK2W+AcEgR7ZioUuXb5tAnpiyLAZtMA/ZNKNhA/nqhF8PIs/JYpTL0MgqDY2GmX0VkjFnsa/srTJ4a/BBl2f5KSaha5UsMPKukoel+k07z/+sZCTi4dgMwZjh1fE1Dl+q+KGU1RA5jy7t/be4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=EHZA9Ljk; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1719991688; x=1720596488; i=quwenruo.btrfs@gmx.com;
	bh=ZimwR2VMicBO2RcvVGe5eNxwV1Uie7H8rY/UhiTF5+k=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=EHZA9Ljk19M4Jt1hD+NTOVmz/SgxicmW4nbgG9EC/UR1JCn/3Zcci9/6AJbeCkxM
	 Vf8cTQCeckpiN00VErkPJiBADJTzRceNRICG1z9kr7TBY8EBkOgF13MEOf79aRwke
	 YoQsQqH8hTFjE6JQfUBRPQBF6EAyEgtbdadcPwz+6k+w10KMBRc/gVFBEoRX21Kvx
	 p0krbhxUJX5bWS4phXQgSXS69aUJFtP9ZtswBRanxnIWzjfuy5NWFhYrXO1/bJW+F
	 Q8S9AcB1blPn+HCJqVYIXCRjJzG1z6BLpD66ULwuCbFrGwyCg3R8ZyozgKcH+BJ99
	 43+l4NXZMBucYFWLog==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MuUj2-1s7ehu0MQU-00rvZh; Wed, 03
 Jul 2024 09:28:08 +0200
Message-ID: <6be34112-ee2b-4d4e-ab71-31d9c3897b1a@gmx.com>
Date: Wed, 3 Jul 2024 16:58:04 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs-progs: receive: retry encoded_write on EPERM
To: Boris Burkov <boris@bur.io>, linux-btrfs@vger.kernel.org,
 kernel-team@fb.com
References: <8c2e537199608a446d5f97ea0dda319d2b9c0dad.1719937610.git.boris@bur.io>
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
In-Reply-To: <8c2e537199608a446d5f97ea0dda319d2b9c0dad.1719937610.git.boris@bur.io>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:iY3Ry0hfQTBmMyWm7dqnhdDt+xBPHzx7QaVuaHo1STa7WUIOEP9
 v1YJjuUE2m60/fIK+cms2Knp5gaUNT0Pz8a0nNghIdjZAsbKagXQ82QcttG4STb9pcBFLJO
 F684LLF2IyTjEqHT4sB1d8haRZQtC3imBfQzA3Ob4ZgOe+6floV6MckcX+7Y59ke25y+ez5
 +pOgCN6hE8/0x0tEhNp4g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:y81PQkM2W8I=;vZ8JEQIW7l257HBhVc/ujYaVCeT
 u6o7PDfs6uC0z5m79mj25N5RNNrpOZeMLZ8Yy7Jgw7H691KH4d54592/rw9vSvC5Ju1wpw0H+
 eCyd2DWElV2uDkhv46SByoGpN/Ctx5kG8GElzGgkmwgmT1xB78VTwWg4dXjqXd4X70KjIWyim
 H0ApKJvOvS+8QHPAsma1NOs0JlkFV4bSvRJD7hQIeAkr+A7PHC9blUxSDwbqPBTzlBlZ5UC6T
 edhQKK4cgRCljnfTAu2tUrPJ4HZtjBgS9uzOtnioh0uu9VBc9nEJQjM3iN0XdVGSU23hC97s1
 AC3r/Gses1Ibso0HPUx8B3qnmwUPhh4aTFuM4xcC1nMe/DPa28IzFeZ+ju36N6mZ/r4LShh4d
 AJ6Afl9KzveS8tn8XKZFHbJQmML/cMqKhkI5yCr9KwwEK9Od66f3JxpOhSaRDUm/H2OA57Fbf
 1A6tqgH9sD79Y39g9sMOIScsogqazQWg6Ld160baHg2pNlMw3DPNdzvGe2dnLg7ku69SxmO82
 ojFBXeGA/YP98DyNqn0IHP2xeE5MZDqR/Oz+kXx8mDNolXzIUqXGLWrI673Nrk5c4DY39EMDf
 DpSj4tigBNVRhbzpeO05Wc6IQ9aQYIcup/B/yWt66Gi6Gr4COeoh8cYIjw+DMGCPNlun9pJCR
 tU8kzppyV8h+XXpFWZP37kDA1xbMHvxlJD4VwBfoqM/qPpJyWjyuU69GQIflqJSrU3EhfGRCJ
 lpkzD50EBDFgP9z2rkAnYfHhhBUyAa433GFbtPYJSRtqVcqayr2zFFHSxROuD5ru+ReZp6Vvj
 sAcLFOqD8cYBhzfMiFdMQhXETMqhHlvw/f+0MO8F6Nt1s=



=E5=9C=A8 2024/7/3 01:57, Boris Burkov =E5=86=99=E9=81=93:
> encoded_write fails if we run without CAP_SYS_ADMIN, but the decompress
> and write fallback could succeed if we are running with write
> permissions on the file. Therefore, it is helpful to fall back on EPERM
> as well. While this will increase the "silent failure" rate of encoded
> writes, we do have the verbose log in place to debug that while setting
> up a receive workflow that expects encoded_write.
>
> Signed-off-by: Boris Burkov <boris@bur.io>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

> ---
>   cmds/receive.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/cmds/receive.c b/cmds/receive.c
> index 412bc8afe..9101e8ccf 100644
> --- a/cmds/receive.c
> +++ b/cmds/receive.c
> @@ -1285,7 +1285,8 @@ static int process_encoded_write(const char *path,=
 const void *data, u64 offset,
>   		if (ret >=3D 0)
>   			return 0;
>   		/* Fall back for these errors, fail hard for anything else. */
> -		if (errno !=3D ENOSPC && errno !=3D ENOTTY && errno !=3D EINVAL) {
> +		if (errno !=3D ENOSPC && errno !=3D ENOTTY &&
> +		    errno !=3D EINVAL && errno !=3D EPERM) {
>   			ret =3D -errno;
>   			error("encoded_write: writing to %s failed: %m", path);
>   			return ret;

