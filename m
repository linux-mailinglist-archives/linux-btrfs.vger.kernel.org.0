Return-Path: <linux-btrfs+bounces-790-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B0EDA80BFD4
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Dec 2023 04:18:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6792E1F20F9C
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Dec 2023 03:18:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFA441641D;
	Mon, 11 Dec 2023 03:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="nz7e662p"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F3F7D9
	for <linux-btrfs@vger.kernel.org>; Sun, 10 Dec 2023 19:18:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
	s=s31663417; t=1702264700; x=1702869500; i=quwenruo.btrfs@gmx.com;
	bh=U0K4I9Pu+Of0w5P8GYE7gi2bf5tATwePbi81KfgPBKs=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=nz7e662pWvzSqQLoFMFdnDRG9vNgfNN9h165JN4QsgNBK1d70F6t7emhHv+ue03A
	 a9NWp/4/9zxvYmTR+B5IUb3xDoN6Ae+aZn9fuGyd8iKxtocUFFvYyTHrp4RzkoX/a
	 PddwqfOxgvr1C5DYQIk3AziRhdrKhzCxAvEyKXCfL8J4oyuc1VYa4c5DyPfLd/2hY
	 9W5Cmx4CHIwDwQ37IdkCBxbzJ1lRia8GpQtDMdNGRbHmRVax37fsRo20SHL8NPnTm
	 4aigc0n+mxurBvVdzC/khEC8w+kuTUiDIkxsZxwOOFgkKMonIzUCcM4jQIFCkjDcH
	 +EJVNUagr3Qln0QxZg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.153] ([193.115.79.20]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MOiHf-1qrFh63jRv-00QDBm; Mon, 11
 Dec 2023 04:18:20 +0100
Message-ID: <7d72dca9-d995-40b8-a2f1-97f5526bccc4@gmx.com>
Date: Mon, 11 Dec 2023 13:48:15 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: validate scrub_speed_max sysfs string
Content-Language: en-US
To: David Disseldorp <ddiss@suse.de>, David Sterba <dsterba@suse.cz>
Cc: linux-btrfs@vger.kernel.org, Qu Wenruo <wqu@suse.com>
References: <20231207135522.GX2751@twin.jikos.cz>
 <20231208004156.9612-1-ddiss@suse.de>
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
In-Reply-To: <20231208004156.9612-1-ddiss@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:gh3fypfeYxaMMswFt8Eitcctl5bE8YLdYI1GRFkuf7WFcT8ccBy
 /pnETMzp41jNsx0joxLtDR64jHp5/TtuLAdUE4mKHFxrqhgXVdmc163YhPAWfIsqWbGDbJZ
 arp7vI5+yhXgCI77g4tVzfPjD9OeJNLFuEcGWGSSo2e7wl5o7ihMdpx6fEtynZ92REsr44r
 LDhxX0WN7hXjwsqjPoqJA==
UI-OutboundReport: notjunk:1;M01:P0:E04L0eJ8GNU=;gyeFd1vQLPNPwFEFmp7dVczox8/
 ddrxFpRCUv6Jd872E0tY3QJMaEPApFrMt8VVmUfJmJN9T1lfa+J2l4pPqg3C+XVmR2ptP6iLv
 bWZXB+vszuhJuf/mat0B+zYURBXeSlVwNQZuNZY3JzCHExEGXyyzif2LwS4F9CWNjlV5kDiZL
 GikOtTc6hhLP7Fx8IVuXQgt17t0rLp9DOw2Hsi7gL1Qbux/x2gBd0R4o9ANCZTl2Jl4dsqMVU
 8zOugy2I4WPqHg6Vx63bZ4KFgkIdSk6VoiZu56goql9SFsXeJnbkre+bETFrTYjsbh8iNJ68f
 ZPXy2cEGCo6ULP9+QAXmZ8Km53FK3IPQxapSQfvL8NECRH0JIxDdYsvCGQVMxgWEP+j8maYgI
 zEPG5JJ5eeLd5mX847f4Bc4ECNq58ZVqWSAjSJmct9th/OnEoWAnadSy2JMIVpiWpP0hGLoba
 I3GLlN+sUSqeuKuMsJ5+mxCzVzU1Phn2N/jOkPdvXbJzcFm0v2YAYQOc2MSLSWvBNctkLCuaG
 zfx0Q/s7mD5x+4cmml25QHhZ36nbAAwYZzQWLuaurjCowKWjdcgUtweOK7sjH+w5uh/YerUWO
 dGBeGE3QYlDuqEaER3RV2mS2FyL0g9q4n+DGggK2dtw4wHBWgTqwVWAISGAuYD6RqMC46uOvC
 XlzEsUME8EJCdeJRdR6Si0tnh6uXqOYalh8uiitIWXGfzawpO/SZS2Kd0tZJRZV7L57Bw9OL+
 wZe3qmnlhVrPMX4LGuCz+ZTVnzUvaVVtAlNq+3E+gqbyaLqxzr/hHTtsJbPX1+6f4ec+AABS8
 DStEJ2qXgxEDWpYwkO4/ByMzEC2Yp30SkYODMvsstYOi4HRxw2yCpxf2GxwNB4Mk4qPRlVJ0Z
 WBeZ2FNr6gVuNq02zEw92eYZlnOWAk+zD/cd1dNTen37iTcXvFvqXECHe2Mj5K6WhZE5PCPZg
 v6tYMNTcMPHzckZhEnAsZPnh3/Q=



On 2023/12/8 11:11, David Disseldorp wrote:
> Fail the sysfs I/O on any trailing non-space characters.
>
> Signed-off-by: David Disseldorp <ddiss@suse.de>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Although I have an unrelated idea.

Since memparse() provides the @endptr, can we rewind the @endptr, so
that we can check if the last valid charactor is suffix 'e'.
Then reject it from btrfs size.

I really don't think we need exabytes suffix for our scrub speed limit
usage.

Thanks,
Qu

> ---
>   fs/btrfs/sysfs.c | 3 +++
>   1 file changed, 3 insertions(+)
>
> diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
> index e6b51fb3ddc1e..4c4642ef7c5f0 100644
> --- a/fs/btrfs/sysfs.c
> +++ b/fs/btrfs/sysfs.c
> @@ -1783,6 +1783,9 @@ static ssize_t btrfs_devinfo_scrub_speed_max_store=
(struct kobject *kobj,
>   	unsigned long long limit;
>
>   	limit =3D memparse(buf, &endptr);
> +	endptr =3D skip_spaces(endptr);
> +	if (*endptr !=3D 0)
> +		return -EINVAL;
>   	WRITE_ONCE(device->scrub_speed_max, limit);
>   	return len;
>   }

