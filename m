Return-Path: <linux-btrfs+bounces-9245-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A37619B5D47
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Oct 2024 08:58:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D52BF1C210B2
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Oct 2024 07:58:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75E0E1E0489;
	Wed, 30 Oct 2024 07:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="roBrAiLA"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2FB554BD4
	for <linux-btrfs@vger.kernel.org>; Wed, 30 Oct 2024 07:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730275081; cv=none; b=eoBNX/LGjKXScCVVXGjQXd61vE4R0545b5d622YUq3dQD9VELO7ygmINFv/LbsCq1WnwrgaG6ZbwYboFkMwDe0e4BkANwsL2DuAWa7K/Crc069DE5qe5mxHMLxP0TcPj7KAf1UOhgWNtVKQ6SRzvt5yj+M00BUJ1eOHRaJs36mU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730275081; c=relaxed/simple;
	bh=0lpy9uO+OsCgcbSVa57YY/4mcSQwVyBocpIGEJ72VAQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=YjRdMVWcWgsAL6jDAU1gQv5Al+hhINaDKQKl9SYLNSJS9KqHpFEeYZcph61rWdnFVs+32+/1udHkLWVZ56zf85gg9P+G4566HMhi5KaUMBVyufRHjhBTLSlkPoLJiGvsA5WrdSL8BbF8vr/ULw1G8avaMb0Fe4gj/yLfl9B+3O8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=roBrAiLA; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1730275072; x=1730879872; i=quwenruo.btrfs@gmx.com;
	bh=2Viy9+fhZ5g2RQjcY4KXT8kcqENaKNW4ZvKLoDYOlBU=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=roBrAiLAkh5Pthy6480lGWshpMb3cF36mfnztQI62tJ1fpqqWwl21+DIvEc3hNRm
	 e6IG4+G6t2SOWpDzJ9Hw8mjGMnECDXS+eSIftrw1ecKGGYSrYoOdsYNQx9Y/Y1yxE
	 V/cvB8bQXliVyV9eVAooE88vZmnLZD2hWMlmrFUDUQerNaZjUa520q47xuBSKik4l
	 vO00qrAUCZ+a5bHOod/5SAqoTZOCPVM6Az5wZmSpBZzEXJ8kOkBr+UdbsOSm2Bk5P
	 RNrJ6d6PHYbsg79vCeFXLCRVwZ4IHpF4zhI0RwghrsrLivNrSse3a+HqpePm9ddzm
	 ftIWItvCf58bIi7oUw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1M26rD-1t7zOj1FSD-0061SJ; Wed, 30
 Oct 2024 08:57:52 +0100
Message-ID: <a30b8ba9-ec77-43dd-a22c-dc3e33f0454c@gmx.com>
Date: Wed, 30 Oct 2024 18:27:49 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] btrfs: a couple fixes for extent map merging and
 defrag
To: fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <cover.1730220532.git.fdmanana@suse.com>
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
In-Reply-To: <cover.1730220532.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:VeF4HrMmjklCy3uIPI6b6yxCCwoGG9G0Fkc7/b0fEwateEC8zuM
 pA2+ZUsnVogFNw007g6ewQawEIEELAPcTBqpwvLSNr8PwSMzx0h2ebsI+0VHOO4OOUoY4n4
 KDzbKwDiQ97Nhp2fEBmUfXb8jUIv3nnnMmPPKyOqUg5UuDIb/gdFxU2FAAOF04rONugqCfd
 ZqTd+Jf8ZxnF/JOO37hHg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Rwti5vezFE8=;FbkbPd1AYnf2hzTUnJlaCpO4d1F
 q9p62rtD9nxXrk9aGyXBbCjTCzC2ZzBGpuYjL8OkepVcNOdK8CB61Mimq00rkZ2JR2zrYy1H0
 V4SbQ7cloM9iVcIybjFzBY1ZWy7V6v7dCQO4+d1c1xzOdg4iIxamAGNo1vxrPXfAG4I6xnQsO
 GqrqmzJUXTuL+AicPk1j6H82IQpwDD0oAeWsTAl+5s00ctlGwUu0ua6LDvwQ8EIb4pqFCEZWY
 ctCz6PhwIVV+MyqjncvgpfVpanvzjI+VhFH1RUhvYw4rNd6Zz/Xq2M+vTj37xHeGw+/yZY5W7
 UXnHyIaKeGwZXDxdugA5WmOxU7YmkMf3ivf1aLNtjH4hmEI21vIt8L4Nn9NlVRjb29hlMX2+o
 K4M+L6dUlGOZVaLiFawf0fBU/QCQM9w5S1NOM415N64xI5vH6H0R48ecgQ4ve8Oum0DyRQgNl
 XnEbvpUaLaybilOjKNKL70DJ8coO0+pQzg9MW3pTl5nLwYKDY5XZXcTqMGQz+fWbhvWHvo3t/
 vWO5AxMsdjrbBxgdTNYMogd7InPkRRuhyHYv9JM7p16ce4K7h+U22rDafZL2HZ0R2/cBpYkf+
 QE+vBXBm615lvoy6zeCSYH4bsxvZm6t38GYggQnQurfrTJzHKiGOsirnNOn4shHJ1v0VdSB/w
 m+aPsPa+8t2XUX3Cxw+UVVqhITZfYL0jCiGuWcgRzreiidtnpa9cBnMlSFdR80cJSSqoFfk56
 XWdzBt4r73oES6XE+mLfT2fOdT+UIPH91gVkUnx0m0NtFFlz4R2bceMZGVTa+ZWOGm/P9wer2
 sU2hDoe8wWcBcSJdIccMS7Pw==



=E5=9C=A8 2024/10/30 03:52, fdmanana@kernel.org =E5=86=99=E9=81=93:
> From: Filipe Manana <fdmanana@suse.com>
>
> Some fixes for extent map merging not happened when it should (which avo=
ids
> saving some memory) and defrag not merging contiguous extents when it sh=
ould
> due to merged extent maps. Details in the change logs.
>
> Filipe Manana (2):
>    btrfs: fix extent map merging not happening for adjacent extents
>    btrfs: fix defrag not merging contiguous extents due to merged extent=
 maps

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

>
>   fs/btrfs/defrag.c     | 10 +++++-----
>   fs/btrfs/extent_map.c |  7 ++++++-
>   2 files changed, 11 insertions(+), 6 deletions(-)
>


