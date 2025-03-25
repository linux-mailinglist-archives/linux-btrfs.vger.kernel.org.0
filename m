Return-Path: <linux-btrfs+bounces-12584-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 11110A70C35
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Mar 2025 22:38:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0BB7F1894AB4
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Mar 2025 21:37:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 607EF269B07;
	Tue, 25 Mar 2025 21:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="Ud03FdN5"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B69F204681;
	Tue, 25 Mar 2025 21:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742938622; cv=none; b=Bn061EvlS/GJJdwPkpqoM7ermZ2YJ7fpwGLMjF3vFnu+MAfD+6ZxE5X/gjXVTrClXntuNxCLlHKyFYRE8sMdNa+Jw3bA1bzXwy1rRyyhbCNsjsL/Pw33jP+pDK1NUWSk+GSJW+gDxzc/byJS4bHoMPMDnjGnpudILSUXJLKFufY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742938622; c=relaxed/simple;
	bh=XrCQgHsazAWNmsAjdOGeRNECHe56NRDgQiVXAlNIA8I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A06XmKwB87glsMKbK3/XBlIVlhYmhNh3VG9E7MImq4nbb6aDWy1GBn5dvOP3QQHpTvD8uAiCCcKTloiawkN5JxGpZmm5jxh0ETtQmEdsed/MzS5m9R/QOpbk25dsm/fRI9Zl8MvzdMbfaX5OOBBiCmi051+zsBkksrihKaytwy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=Ud03FdN5; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1742938618; x=1743543418; i=quwenruo.btrfs@gmx.com;
	bh=SHLL++eIm94Fj/7szCHRTOJz5FFQFiM4Q8AjsWZo9pc=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=Ud03FdN5gZhWfcoVkkd0l2vzgbQyGcbFxY/YY8Tsg8uUQBYcVtFvNP/S9U1eAQuo
	 KGkZ9Ad1uqhfCC9lHi9pwJ/FKm6du4Iv2DcqbI4b4FxxsrbAhL4rerttevnGCusg9
	 3rwwZqRxW886mxb0eQ+SDl8b7JDM0nsxW6IuYtKLocVphyTpESmnFJ/lugszHhdxu
	 2e0r/8XBvP1s+eGCZA1R6XfbWvwGLtcSrJLp8msPl2mSy2tMEEGMKqIi5gHF9tj1H
	 y/r5ZwVYmOU5FoqNoxvHUOdOKGIEnPXbm02mt86sct9FCOkFxFzx4JeYe5h5u4ePI
	 V8Qh7LRiQbqQr3riIw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MNbkp-1tlSks2hFT-00UUZW; Tue, 25
 Mar 2025 22:36:58 +0100
Message-ID: <f32db2c5-fe4b-4152-ae36-f48175e7e64c@gmx.com>
Date: Wed, 26 Mar 2025 08:06:52 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] btrfs: extent buffer flags cleanup
To: Daniel Vacek <neelx@suse.com>, Chris Mason <clm@fb.com>,
 Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250325163139.878473-1-neelx@suse.com>
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
In-Reply-To: <20250325163139.878473-1-neelx@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:QH67u+gVQysItDeOf4gf9KUpxk+QgxBiDEpVfbrweylQU2GwMuv
 q8D2dxCVOFiQ4EX5c025fxyUY7FR1kkSJ79lpZojhF19F43afC4pRvxMHHAVj9YjQZoutFc
 2TsA+L+RnTPUpcjTBniyadecniR7iLtSBot1PVkMo7kjkn2IPUg9rV7GtJ3j/3F7OEU3Q+L
 sUfOA/7tObS3xBlk1ra4g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:C2+wMa6lgAo=;XW5qhPTP/6SqconQD4p+zrOYK5u
 WZPx4P62saODNclGeNlCNKPRUZVYC1PHl/NSXOdh3NDe9KweXwuFsztFR8D1MU8ElmxCigNMY
 rbM8fW971ugbKT8/5zPhFf6Gay3hn0xROZKWyaCQ+cYoTrI9Fqtvg9a63ExG6lo94quTI8S7g
 1Bn4C+vTfFR7/NgT7qMaOvbkFZf0Qk+xgLs65ij1PyXkDvS6ZC1UORGttPvxzL2kJp/yfAN7N
 fG+JDCcsn11OnPMUg7ZCyx2cZM4NRVNyHZsECee0ucUS7XgZN4LAHQkdshOPmBCkS6twi+V/p
 Uekrkg+/8Ub/JjOGVcH6Hb/tlfALKNKUjDbxM47YTnw7HF0K9C+JmPR3McU/RMfzbKQi+POj7
 e8jfTJAkqMS/x7+lGuCUELiOv+Ym/9LqDnWhMO2yK3aH6vslZZv2b9l4Dy9xHgIqn8NKayNoq
 pm7drHSdB6vv5TAjUnjmYjRBptkqfrb5nhtTvWBIXOHHgUStTiXPJn/t0C+ArSyyFrbzyBpOl
 nHXewroZ2rYmtTmTGxHCSGcl27jvbi95gBJFk/pLQ48eRm3DL/S1QYSHsdwOPTERBApLS/rbe
 ZIgqs8dT2VJ9aDkeAuHMNwb6IHihxVjZdD89JbdSO1wk9kwVF+kfa5dixPY7YO1KqZDczddhe
 5sLS6L9TbecHpK4gOSRWR6k1yd00vyPnacwjwAmUCxOALjWSFqqO7XlqYMio/ox1nQ8KArAth
 v1QCzydq6tLCpW0wzOqZ4G+VfasBNCcs8yMykq/VINpMk/ZbR/tHkKKXzZMDuVWc0+5+Luvd3
 kw0GnXkjaOktV8Bu7M4Ki3O3rdGrslrG5jmm6pB5zwzwBFRY9HHrsoI5+Em5UWFXhReL0iZ5F
 JQSqTmbI1K3l0QZLtR9uRkOP4VMJEReYJ4STF1U+OFEamhgoRZTN4bochq1kKEP85mjcdLwB3
 /ik83yG/HH65gzCQ2uvV3nQCgVwI2Cqsoyh9nUKULIcCrR5tnSBRn04TFtuNW03JNp7UKxBPI
 1ECIrbiE0aZHPRQBgy0XXSdqj8FevwZ1qBCBAbhQEiTXzKEtnNGmBt7c5yJRUPAaTCeYaN1Y0
 FpAJbYUXa/1OsVjzeKaCLZpLq6slqA2xKShM/wpnyvXOON9LQooU1S0T1nuea9M9yZf6qR6PA
 blQGeDTYm2O+Lp6JjDQCCGqjoZ7o58rQd2PBgg0hy5R5NaEApYFu0s6p+vySYDFfyMi5c6ze2
 QhQpa8SYn4ta684b1LXUYlROPLbws11ks3Nd3aGBPBwYgXI2swGr1ODmJ83yvIs5JMeLn6gOO
 mHoSICYrV36Pq6PfZG/plY2fuWot7tGhQJDbIldD0lZJBCiWcj5qj0GaaEjqYmOuQ26BkpAYJ
 8TVC0a5R9HSDBLxPcMOa5SCa9KdmqcTRMlW9r42aM6IEyuVCTQwRU3zlffFEVTvZIRvRPi826
 hXKcOgg==



=E5=9C=A8 2025/3/26 03:01, Daniel Vacek =E5=86=99=E9=81=93:
> There are a few leftover extent buffer flags not being meaningfully used
> anymore for some time. Simply clean them up.

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu


>
> Daniel Vacek (3):
>    btrfs: cleanup EXTENT_BUFFER_READ_ERR flag
>    btrfs: cleanup EXTENT_BUFFER_READAHEAD flag
>    btrfs: cleanup EXTENT_BUFFER_CORRUPT flag
>
>   fs/btrfs/disk-io.c     | 11 ++---------
>   fs/btrfs/extent-tree.c |  6 ------
>   fs/btrfs/extent_io.c   |  7 ++-----
>   fs/btrfs/extent_io.h   |  5 -----
>   4 files changed, 4 insertions(+), 25 deletions(-)
>


