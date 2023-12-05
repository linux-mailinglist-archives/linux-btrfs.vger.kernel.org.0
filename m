Return-Path: <linux-btrfs+bounces-677-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C57BC8060D9
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Dec 2023 22:33:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0216C1C20E51
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Dec 2023 21:33:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F27F6E5BD;
	Tue,  5 Dec 2023 21:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="nux0Pm9y"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4EFCD3
	for <linux-btrfs@vger.kernel.org>; Tue,  5 Dec 2023 13:33:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
	s=s31663417; t=1701811998; x=1702416798; i=quwenruo.btrfs@gmx.com;
	bh=DEcgJe7O1b8D7a20ypL8FZ0HsslvAXDah+q0QpPVbDo=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=nux0Pm9yM6I6UGzLyN6UNqODWu1kZw+1oIVq+OywCH11nsCNkPRPOv+zpgf/lRu0
	 zSMkYnBAWICzzB1tOxP+UKcJMZlAzJ1q5+c3d0wqLHkCokjdSEcdzssAvOMAEduhw
	 k7B22gfeTuK5xk4gvYZRVnLLJ/tYv/SmYnQCvbBlF6M21Vx1tGpKOh4nkHe1xLN2z
	 WqSmAcmFZWaQOPhT247+xTwUzCY+Tpe4KPU/G0FAkNRb9ZdQnybxPpn7uv8275o7s
	 /X5N7fmUDyTLmionrgdjak21oM2cAIph/KCx/MsJVfGMasbQHsTC0ilmWun9FkB3G
	 YrSnkT8uRVCqlG8Aeg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.117] ([122.151.37.21]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mz9Z5-1rViKE13Bb-00wG9l; Tue, 05
 Dec 2023 22:33:17 +0100
Message-ID: <e853465c-b1bd-4205-805e-48bf8cd05645@gmx.com>
Date: Wed, 6 Dec 2023 08:03:13 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] btrfs-progs: tune: add fsck runs before and after a
 full conversion
Content-Language: en-US
To: dsterba@suse.cz
Cc: l@damenly.org, Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1701672971.git.wqu@suse.com>
 <f919ead47c266bbb4c24ba873e565e4c36b9377a.1701672971.git.wqu@suse.com>
 <a5qqguz5.fsf@damenly.org> <455ec3c5adf1dbb10f5ee00bf3a6c955@damenly.org>
 <e051f2dd-dbd6-4e3f-b828-a66a991ed4c2@gmx.com>
 <20231205164636.GL2751@twin.jikos.cz>
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
In-Reply-To: <20231205164636.GL2751@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:q/R+t59EEFAhixCCMHJiMfSyV9M3t9BS0jbXxIJKEuJz1/+Y4+8
 iPqhZ8ZlaYepkg6oYIKKOX3hrheU7tz7D9QCwB7Ov1ARq1PvYcT9QoFUwQp6dC0EfqwKMNk
 sXcCB7ruHaPTNelDJo9NKca81xiBIUBgFbLBbW2br/8xAdgwsWmL338QPm71rku0N6IOQK2
 8OJ7PpluAz7xhipZU7U5g==
UI-OutboundReport: notjunk:1;M01:P0:Oukx12QpUoI=;v9SbtHO3/z8Dt7ItjDkJe3juw+F
 ovg8Ng9os9spgA2PsdNn3PKEYgwJ6XAQ4siF0vTcavpay3jNuDxPXgjy7f702ZvkfDMIG2aQI
 TsPN9/NcBwu3yT0Pj6+GonYCfQ7m6hJoypPaHXLUm4/0LH4/LRbdQTFg9Uao6HwDDb5L3rAXk
 keeIpjafjqn6mXJUSWjJX8Cy5TdQOZOzl1UbFdipwm7VAE19Sg3G7aPNoZsvA2oTm1Fk98VR2
 YD9se8vOjLQsgYjla1dbMjHqqBD2x+akuh20zXJGrMQ5rvvroL4Ta+teNZ233OWcHWMJMFY21
 7Qoxw/eUogq2TPs+9xLx+QFb1QCNWUPDn/ChVgQQvV+LkIYDnp7mPyM4mr/8rq0yTKImrEqrs
 4pG9cGCWFuwCT+j5oxTsHsEoMrfaihr/AV8xOntdHpYYHyAl5bsKrc2GFZpKcxldPEvwWvWsI
 4mQV3pjoPKCtkavwrMRywwt/nDc4GjjazM5dIn47M2o33ekahL4RJp+qAMFEHe1icwXZhA+h8
 xYBcqbKiePMGvz6cdUew2k6n/kpPVNCms5dPo6USvGH+NFySBz1DpTJ229K5Ptsc2Df9rG3gM
 L10I0G+4+Y9KB9nLo1o2EE9ZNR1AvWVeETt34waKiA3VznWivY/EMj4axvQID7sWvJNFvBaL0
 H3oTZdL1bhg13KtLHJ70f0KTte0slST0ngezBjwwEEF+mDEu7cFg9V9NuTF2n9WCt5733pd/a
 mpv7n7E+nh3TKOcw/+VlSNZAwzFEYn4ktGNaew9BX07gcjVjHO1VUpxL60mheRcE23fbUZPFz
 bPv978JKexCGQ5TqXUhAkD414DUe9xkT+IkBVb020aY7xGtpDayquhQ6HYA88CNm9/gYf7lzk
 rY0GilWlVyCxYtw6xsluwbHMLr0GKFMwACHDouxBW76ptwJYll8wYAkeTvvVhzCxgCDcu/WwH
 vuuMdSvjvlcMODVXAE7n/0NWY50=



On 2023/12/6 03:16, David Sterba wrote:
> On Mon, Dec 04, 2023 at 08:52:15PM +1030, Qu Wenruo wrote:
>>> And maybe an option to skip check? People who want to convert to BG tr=
ee
>>> usually have large filesystems, then the original check can be killed
>>> because of OOM...
>>
>> I don't want to allow it to be skipped. Maybe I can add some logic to g=
o
>> lowmem mode depending on the filesystem size.
>
> We have power users who know what they're doing and no way to skip the
> check is considered a usability bug. The check can fail for reasons that
> may not be due to detected problems but due to lack of memory. The
> heuristic regarding lowmem or original mode does not sound like a good
> idea to me, it seems too unreliable.

That's true.

>
>> Just don't want to risk any possible corruption.
>
> Instead of forcing the check in all cases, by default it can skip the
> conversion and print a warning with and recommendation to run check.
> With an option to override it it would start right away.
>

So you mean without any special option, the btrfstune for bgt/csum
change would be no-op but only outputting a warning?

This would be stronger than the 10s delay of btrfs check, and require
less work (no need to export btrfs check).

But I'm not that confident if most users would even follow the
recommendation...

Thanks,
Qu

