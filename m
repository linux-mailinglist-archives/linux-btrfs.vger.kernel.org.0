Return-Path: <linux-btrfs+bounces-6562-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB9969370C3
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Jul 2024 00:38:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CC39282738
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Jul 2024 22:38:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB4EB14601C;
	Thu, 18 Jul 2024 22:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="h8GxjyQU"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79BD757CB1
	for <linux-btrfs@vger.kernel.org>; Thu, 18 Jul 2024 22:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721342321; cv=none; b=rPzJ5FUluJC/H5zMBEKUYKE8sWCzDBND1v0K80G6w0uEozmW6TvcPLjqaOXQZkkvNVhPvVx6FPDjyy3bdccycOng8oSTJXOAgI3Dl8wir7J1sNrJxtWC/mmjGSFWKkgOOK9T49NucfdT1sqiz/hYOOBBoQ6ytIIkgozqB2iZJdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721342321; c=relaxed/simple;
	bh=kGmKuROpvUl3DoPErMvyt8WIjjDlM/A3hhuVxqI5w6Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OjUKKduBGbUNDhBC3l4eQ1ibkQ7Dk8BLeopSFkcwpBzQZVDe4iccUNdzKv0E/4NVuxnOLueoF/LExHySNyIf68eeUqxgRSVXEyKJVA53tnTuDWs+gcQQz0qPe9/73ojuPq+ALiYdnmD0gH7+ObkSKDvDTDEifbAX7FO6yH+flJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=h8GxjyQU; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1721342314; x=1721947114; i=quwenruo.btrfs@gmx.com;
	bh=kGmKuROpvUl3DoPErMvyt8WIjjDlM/A3hhuVxqI5w6Q=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=h8GxjyQUU24sm7nTgaJ6/jVTINGpd8esvCWQcqyoVAvuC+KHgMFMONBHyg/2VI9C
	 nPOTI8yyCyv+PweijbfrvfIp0a7wz4sbS5cSUDUfri4zKbIrTiHceG85GqrLW1LrF
	 uU7I6v526li6BwgpOxBjBaT+89Fwt/92djIZ+9yqFxSBrOZrSt9JPbP41xWMdkM4M
	 alBtCfnQm+Sk/DClHGNNjq7RsOdcHw773DvRk3FcBnnEQtXDm+stKFmRtUVYZzJmY
	 PDXGSbnJUflQiGDYXW23/4kYhN/zaFE0dFJckL9s7izgaiiqLO+FTLUvyDcBRepSF
	 HuYpr1rURGmGqjldlA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MS3ir-1st91O2S0B-00VxKz; Fri, 19
 Jul 2024 00:38:34 +0200
Message-ID: <87d78bde-b5aa-44bb-926d-a4eabd710c84@gmx.com>
Date: Fri, 19 Jul 2024 08:08:30 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] btrfs-progs: fix the filename sanitization of
 btrfs-image
To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
References: <cover.1720415116.git.wqu@suse.com>
 <b92f8d33-ff5d-4aa1-93a8-97f26f466320@suse.com>
 <20240718154703.GI8022@twin.jikos.cz>
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
In-Reply-To: <20240718154703.GI8022@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:+KH9cnBwUDTBvvgiEsCvKD/Lw0nMvCMjeoK0D+iZ+sPsGiJLw+N
 aJ4sw/J+G2IRPP5amkV1kUi/bK882Ow2qQilXv+TpOMWVmJctCZ8DKWvO5+58KRjkTIzu0U
 hKexdlUELoDDfxr8tFPoSkh5du+0rVJwHnWYwxy5V6TQ0qzcY0q8M4tHKCD/vlW7nIhqjZZ
 XoTY/5Qcn/6rHR0T2Ihwg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:XQ2XDTDF3jI=;jO/dPYNEwBm70+7HNKkIryRUDsR
 DtFiLGLCdtX+huJ9jlkSDwljPpn6VEJx8lvfKSrdxUdWki+A+m7zdYgaer4bYP+kLns1vUddB
 QOTVxgBq7WtHcqRfi/bC7xTZk63VAssYPATgSIxEgL/t0P/8YXoBowSnvzEJyCImdwduJlQAE
 hxrAJ5HCmJuLEZVepOiagwAkRJ91JskHH4a/d0MSj5bkBMCIX5hJcaCKCloXxhKj1gB1gl5lY
 D+TZ9OJbzMyYBv0mAANPUF+k536Jjfgg5SWROprhxQOlOz1lnN1SZW2QXNn24UhawULoyzUdd
 J7gV+jfm+ua5cL1qHHDrf+2w7dJYokxQDog96O9dk8JnAwdTl6HNlTp5a0XRFKIvK8tomIxIO
 dB3b09bSWST63QuxapthH2yjCQkTJskaQ4BGHpAvmY7zqWDZSWW2/6HTfS8OOz2UvoLQJaAAO
 ncNTteIm61ZSRC/XDO8Dt/gZtCu1SwWnxPwRYD2i2QvGvP8jsqIJs9xHWBdg8OKDRzdAkFPH3
 NGjawcYuVZCnGaeOm6w+5YlFTRxK/ompBK6FsWCJsnKWFapx0U4l1UfmMvW+tf5WqnP9JLEBI
 eUCj/NumDaFwPH8cAJeI3yMXI929f88qukq6cvdlw7Gj8hBpXAwQVrnjBQS3t4IAcfq40anPQ
 ++vdgx33WZxHl+l1e+YJI7CoGGazdcpG4wCYihcwq6u2f8MeGIYCwSDan+Pg2MkHIxUmd7ZOV
 RwiFf8tVL+XcBqXKjmfbz5qPYFnu3kj9U/0HU48bABqU0Ep8JIrIrS8Kmk+hPNXui6XV9prtE
 3AMQ9u5CJLZEWc+V7NxBhHjQ==



=E5=9C=A8 2024/7/19 01:17, David Sterba =E5=86=99=E9=81=93:
> On Mon, Jul 15, 2024 at 07:39:32AM +0930, Qu Wenruo wrote:
>> Ping?
>>
>> Any update on this?
>
> Tracked as https://github.com/kdave/btrfs-progs/pull/837
>

Just to mention, since the github review system is working now, do you
prefer me to still send the updated patches to the ML?
I'm mostly using the ML as a way to track the work...

Thanks,
Qu


