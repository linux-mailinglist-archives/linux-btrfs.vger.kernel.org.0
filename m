Return-Path: <linux-btrfs+bounces-753-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A27C809202
	for <lists+linux-btrfs@lfdr.de>; Thu,  7 Dec 2023 21:03:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A09B21C20936
	for <lists+linux-btrfs@lfdr.de>; Thu,  7 Dec 2023 20:03:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E3A250251;
	Thu,  7 Dec 2023 20:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="PzRasVlj"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B63021AD
	for <linux-btrfs@vger.kernel.org>; Thu,  7 Dec 2023 12:03:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
	s=s31663417; t=1701979407; x=1702584207; i=quwenruo.btrfs@gmx.com;
	bh=VarhqY5uQqrI6fhB0mRAvzMvQalK7tuAP0Zw0yCzUUE=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=PzRasVljcH+xGAzwzhUNrrTqDPv5MftraZKx5T+Muc+dLGU7+KvurZNCul5l2ykT
	 atjpKFsWShsKtJelL0ms1ly7DggKgtH9LI5O6FcWClHUMScXbxaRbyInWmhV5ReIX
	 WSporEnDV2PAjBA51OLWI/iEd737dUxa3BvMykt++hsFkDGr4YAbJxmlNajzlJQcq
	 0JW8Mb+9LJjdyXAQpkIrvGdAC6Rhpq/4uMrK3W9i6mRoyjVfJ2ZLQwMObJp0QQq0W
	 HXcj1d7u3iw7uds2CyHLMuT6+y+k/JLhE5VZfGTFqnylRbDhNdVungK7RmxzThBio
	 80CoxBIkREyr7DRCSQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.153] ([122.151.37.21]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MS3ir-1qmtzZ1tAh-00TQFw; Thu, 07
 Dec 2023 21:03:27 +0100
Message-ID: <d1463937-9917-4cac-83f6-aa5186d8ce41@gmx.com>
Date: Fri, 8 Dec 2023 06:33:25 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs-progs: scrub: improve Rate reporting for sub-second
 durations
Content-Language: en-US
To: David Disseldorp <ddiss@suse.de>, linux-btrfs@vger.kernel.org
Cc: Qu Wenruo <wqu@suse.com>
References: <20231207135647.24332-1-ddiss@suse.de>
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
In-Reply-To: <20231207135647.24332-1-ddiss@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:aYDmcznOGwXo9RhXfKwbOdm9rds+H3BPCyWxO8TLkl6pYijcN7N
 aUSK3QHJzlxb2ANfS3Tx+ye3L0bEDQ/HBZ5WrvBwwHCd9jPJRGoJ3PtolDAVscrlUq5Vr+v
 LTPi0XzvkKMRIwAPbjWrbGDik29HuakGY3b2ELymn9X1kj3E1y3fJ05FEeU7iMUJ3uQPwGB
 bHrZpeV8aYvQxuhc6Fh5w==
UI-OutboundReport: notjunk:1;M01:P0:a+hkTM6MFQA=;aCEqnJbC+ENCe6uZt0Os1U1RiJH
 NZE/nCIMiDTIot+Nf4OtpMth7ZvsWcy+KipyA3UO9njAs91iHpOMy6MQ2O3Ck8HqlLVIYojGW
 b+DgBYKVTrnwsPPu4JJVu8JYFjhE/6R7Cg1AO2MYtFyAH+kwSf3ozi5F+VcN9wqtQWcuVTbYC
 mRfR4jlkI92zzMu1zsmcD479xvC8Z3fLL/Ur8PT4mQUOnY5BVSr79nKm44Or6kgxvBU3OJ7TR
 NwNfWcFFKyn132Gtl2Fdkm+LCY72xttqev91Y4r6N8u088eBe7XPjd2YNdROl9RIdIiJqD3pq
 FpLzsMkzPTAcWAUMaOBw250vtF5hohhAqaaOevGukbGx7HLCo+4Q7A0jEkrIu9Dmpr9YwSoj1
 j1wnHY5cRhq4gUcXOlCkOAyWl8cNvLNLuGQ25oc/jvISpOnOeO4poaEHsiUMTTViq3r2nZarJ
 s1e8J6D9T0QbY3hXPC4eMz4/omYmzAuEMoehDXPDV/Dhq02W/ojosiYP5rm8C2MT7qne6wlKZ
 q1y2Izhmq0IUrrJRf4PoXs11Z77YT1ZcN8GEDS3Xd45Nu9xici864X+jw6BtO1nVFQ8bKg9s8
 d3LeKFrKvDptXXMtuVL1FbEtzj8fEGSipgvPn0i2gt/8JVM3GFoV5GtAyiaOhydnq3gj05MJM
 cX+sDhZ/NpwGM3eg1cWWL7U0++7BpgR6+IpLMiW6nrG/aIolMlcIxrNVWCUbDmiVvOB3uJi7A
 rUpBZ8znWDrA6O5J8lDtZx9Syg4zVYybLMLxYprAy3oSoyXTlDq3hOKsCBZ3XifDZ1/xuqbAG
 UCp4TY3w/kT/+HjX4u10ONnezDFZ5P7mUM+es2T1o9tDHhoa+y8Tqft2JNFYM7vZGmvR913UI
 MBciZv4dgpsbjfeLLNgD0Wwrz/9VarkEWJbNsczL2yimk8zksGABbqPa6u+WTr//Sq5y25uzz
 fmCrgd5uA/5ZqGViR3DOHbnnIjw=



On 2023/12/8 00:26, David Disseldorp wrote:
> Scrubs which complete in under one second may carry a duration rounded
> down to zero. This subsequently results in a bytes_per_sec value of
> zero, which corresponds to the Rate metric output, causing intermittent
> tests/btrfs/282 failures.
>
> This change ensures that Rate reflects any sub-second bytes processed.
> Time left and ETA metrics are also affected by this change, in that they
> increase to account for (sub-second) bytes_per_sec.
>
> Signed-off-by: David Disseldorp <ddiss@suse.de>

Looks good to me.

In the future we should also increase the resolution to proper time
stamp level.

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>   cmds/scrub.c | 9 ++++++++-
>   1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/cmds/scrub.c b/cmds/scrub.c
> index 4a741355..72ea3b67 100644
> --- a/cmds/scrub.c
> +++ b/cmds/scrub.c
> @@ -152,7 +152,14 @@ static void print_scrub_summary(struct btrfs_scrub_=
progress *p, struct scrub_sta
>   	time_t sec_eta;
>
>   	bytes_scrubbed =3D p->data_bytes_scrubbed + p->tree_bytes_scrubbed;
> -	if (s->duration > 0)
> +	/*
> +	 * If duration is zero seconds (rounded down), then the Rate metric
> +	 * should still reflect the amount of bytes that have been processed
> +	 * in under a second.
> +	 */
> +	if (s->duration =3D=3D 0)
> +		bytes_per_sec =3D bytes_scrubbed;
> +	else
>   		bytes_per_sec =3D bytes_scrubbed / s->duration;
>   	if (bytes_per_sec > 0)
>   		sec_left =3D (bytes_total - bytes_scrubbed) / bytes_per_sec;

