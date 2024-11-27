Return-Path: <linux-btrfs+bounces-9939-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 367BA9DA590
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Nov 2024 11:17:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ADFD0B27EAD
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Nov 2024 10:17:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49AA91990A8;
	Wed, 27 Nov 2024 10:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="h6kn5C+i"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FFDE193063
	for <linux-btrfs@vger.kernel.org>; Wed, 27 Nov 2024 10:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732702612; cv=none; b=SoPq3SMjZOOjjSBifqAhpmTkQYpA8//9LW6KWkLcCeXcg6K9rn+O3weRVbJeot4p3U639RhGGDjO3xj+444txxHPHwyL/O+P5yGUM7XoEWxSQdwe6ZWuAfOSm0RrJRsqjdunlRkOfsTZ8M+g4mroZG4QyZYPDe6CiawXxrwmjws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732702612; c=relaxed/simple;
	bh=tB71vMZkgSZex+6VBQ+vvkf1pAYP4pMiupEPmy5DA9o=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=HwcGAOsMv3p4pCjDd98kDVa/0qWyHPGcoRj7f1nCPjQfNKF+zyrwpF7p0aaNO0R4RZLkErY29WDe312sg06SMB54IG/IGtehqOIQYrxLwAJRrvh563Z2XC9fgX/CAL2DNRctJ5qvRcg3Zzm9Bzn0QDRdf3NtvQxIcyc4KdZrFHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=h6kn5C+i; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1732702607; x=1733307407; i=quwenruo.btrfs@gmx.com;
	bh=tB71vMZkgSZex+6VBQ+vvkf1pAYP4pMiupEPmy5DA9o=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=h6kn5C+iHwm6t5egh3xojtyyaYwoWRNua8VtYhqM2U4yZfGB5pCGEJCFAtCg1A8Q
	 fqnr22fxIegYZkt5vm/MulX/Z7BOpk0zwrAuh1QDrc6N6j4VPi4Pzvfm9DQWQbhl5
	 1urJz7SvH2etWrCi715gj3sXpAXLL0FN8u4twCQQRm9kSfFggZVvGaJ240D2WEYiQ
	 pGZxOHLdpppG3EzyUtdWA6p6ZBKx7GQobh5A/yxDpII54RZKDewbJLYOjCl/FZDSX
	 ojO7Ftxg6PkG8M2AlairaQ/ROOtXwNLNlqobCCU/NmwUCoF2jm9LGEYfPsT57Wy7X
	 3OjY9YJ1jjOLa+oq0w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mwfac-1tdg6X1HNC-00zZIa; Wed, 27
 Nov 2024 11:16:47 +0100
Message-ID: <3145e2ec-a25b-4d9d-a5fe-00e0de5fefd5@gmx.com>
Date: Wed, 27 Nov 2024 20:46:44 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: "fixed up error" during scrub reported multiple times for same
 logical
To: Clemens Eisserer <linuxhippy@gmail.com>, linux-btrfs@vger.kernel.org
References: <CAFvQSYRxZ80O6cEVnU5_qG0HP2Lwn0LnBYmyy5EuCvX=Pa8ukQ@mail.gmail.com>
 <902510e3-3793-4444-bef1-ee33309be7c1@gmx.com>
 <CAFvQSYS650FwYj1n_2yZb9x7hw3yui4HyK87cA6pdNP53tav+A@mail.gmail.com>
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
In-Reply-To: <CAFvQSYS650FwYj1n_2yZb9x7hw3yui4HyK87cA6pdNP53tav+A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:gLsso8HVwRgMxDRcKx4ahhlYyP53vZ0a82h+HqpuKSwbfucUD1e
 J4A/azkZwY2hQRKZPQ+53FzDWgcN1OGMhZkSsUlIR0hGaprJodrMg9duU33pInlAVEvH4Qm
 v32AgKhK21mqgXJpvaAhhA1M05cggMnSDORSUAnjnawJgqnCq1ch+2hiaHqG9HVPnrdqnM2
 3N7X/7N18almspGoD2F6Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:2gNyXos9VKk=;/j7khHdnElna6EFwIaCcJ37wb5E
 nQ/VwhJsfihOk1TqwFVjkLXREMyZjZGE5LclyfH8qOnhlDSmNY0vguK6K//C5BxN2BsAnlD9E
 UB1BsHINKLyY7qNB+LVPF2gE1JlqaDMPKNUIhp7NJSk4FdGGBpVycIg78cfn0SilrGr3ZFFq/
 bB0SWgmvur4v+EtsfVlZieeC8sYdRj7K1AkGCj2hkQ6cBdJjsdJusPTasv8Yaj3kzlK2WABW5
 sX5zylpsbsRo2Cscf/rRV0CyIUI0QSyLAmrX94cmId9mkrz1+1Lgnq2ZWW8c6jWXbe96tL8fd
 okSCo3i7Or8xqf1XiiMj+euckpDmY0jGU4j8HHUDKPJqazbEeBWkHjEj2tfk+pLyPNyqnF+l8
 lOuORuBWo7r+VkCkeL0ILZ3sVHoel+71Esn7vl3gOLA27eIj1kC8VIlVXv/JeaSTi5Ov/ERJ4
 EMuO+F6RDaQI2NtsLqI24JZL4x5abFfzVOUXqfCPLgQykKwnHGWUK3xn9veGioK/f8mKwQUkw
 EwFGa3QqQ4gRRy+n2hhPVi9hrUKzrDxR/zPvrrLLEgBeckSO+1DuLn7o/GsNiGTDEOMRmW6vt
 yhcFgbnQR+l8mg1qtXvNLoY3PXAj6P4gS+tzE5itMSNhYASG/AybkSqavlbawJngql6aYUneh
 CM65nDsROmi42OOt3kprw9lTZv5WHQls52oTGKqu+1+cO4tMLHl3ioM4vlbmXHu7/SqehYENc
 zhcmK0Kv+mCde8kgd2gZFf42prWaSBgPG9aZ/my978JBKvHoNtqyQjpl/QgouLWJzCinJL4YH
 qJc3rEsDbQzUVNCCTUpjV+1NcqUJItYCHqCXXbsB9JsRLia8Rt47uKk22iGt/VDndS0iPcWDq
 sgJ+3n9aVjGAS/zCCCYtL+8mXqWrFKNFcUdM2EX7Y68UVFiEQMF6bhYzh



=E5=9C=A8 2024/11/27 19:01, Clemens Eisserer =E5=86=99=E9=81=93:
> Hi Qu,
>
> Thanks for taking a look at the logs / data.
>
>> Kernel version please.
>> We had a big rework on scrub some time ago, it affects both the error
>> reporting and introduce some regression.
>> Thus hard to say what's the situation here.
>
> Currently it is running on 6.6.51.

Then it should be mostly fine.

>
>> The corruption may be inside metadata
> Am I right to assume that inside data it would not end as "fixed up",
> as it is currently not DUP?

Yes, single data will never be able to be fixed, thus this should be
metadata.

What's the profile of the fs?

Anyway since it's not data, you can just go "btrfs check" to verify if
everything is fine if unsure.

Thanks,
Qu
>
>
> Thanks, Clemens
>


