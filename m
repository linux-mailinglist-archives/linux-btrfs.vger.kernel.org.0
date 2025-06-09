Return-Path: <linux-btrfs+bounces-14556-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BC354AD1855
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Jun 2025 07:31:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DD97164D01
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Jun 2025 05:31:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14E9B27F74E;
	Mon,  9 Jun 2025 05:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="mk0m76yF"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA66D10FD
	for <linux-btrfs@vger.kernel.org>; Mon,  9 Jun 2025 05:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749447106; cv=none; b=DMISBFE6AA9CPC9BpH65hxwEe/NZr+4Ui/vrbL3BJHJ3RgQD3ta8OCMrvT68IiJb4GNVT41WSyO4DsZ1OaW9rFbC50WxR2FagNQcCRCRDjntOTUNHIr4rUu5HgGwaCteawFme0vPAagY9V38jv28o1/EsAJQIev6pf25nBGhvTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749447106; c=relaxed/simple;
	bh=NO0J7/BHB7AytDL/tWw/YGVo5uhOCTi7Vw2uN4l8slQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B8d2XuM6uhfKekKXf5SHezPd/2dzsi8861OP/XxYnC4qEUXO9YpBKlqS4C+AQ3c8IiJe7VswrMQy0AotjftGk//75F6h12IeRAY80fNopcFDaf/NZxLvL30/lXvVrs4UySo5/vQKVzLQin9r0QDnlcqGGQhWaRy2d9T0n1xbKu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=mk0m76yF; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1749447096; x=1750051896; i=quwenruo.btrfs@gmx.com;
	bh=NO0J7/BHB7AytDL/tWw/YGVo5uhOCTi7Vw2uN4l8slQ=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=mk0m76yFl3MnXEzcPoW3T7IQ/D4W15P63BkPzjzyLD6Uc0XjkKU/dO4b7E06F/KD
	 E6rRnFDb6QVCB63DXGYSGPTDIO7GUqawp1F0kH71NDGPGKFavAlytzZtwJq1JXfAh
	 5XlSn8Mooqlxsh1/M05MJBZCsU5rCD2IEWTGwVWnOoEBMzdi9QojVH8UowmmaZ2G4
	 llcHxIArzKcYb0HsewwIi0YcydLOKKWO2XYhYds51SABxBb/289sUxL7p5FxWLQje
	 WlJDvgYsY9nmTO23bj/2c2bouOXCG+jdH8B1mcFn5MCJNAmvRQgFjud7a0xiDONdU
	 ntX2x2I0WQ5amZ+uXg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M9o21-1uS3s22PW1-003MiO; Mon, 09
 Jun 2025 07:31:36 +0200
Message-ID: <e2a5a99c-3da8-4b2a-acd1-b892b4f67073@gmx.com>
Date: Mon, 9 Jun 2025 15:01:32 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/4] btrfs: introduce btrfs specific bdev holder ops
 and implement mark_dead() call back
To: Christoph Hellwig <hch@infradead.org>, Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
References: <cover.1749446257.git.wqu@suse.com>
 <aEZvaqtkM6JvLtLL@infradead.org>
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
In-Reply-To: <aEZvaqtkM6JvLtLL@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:yNTCeyrhqdKydrMYNYxm+1qaMwW55LvVtLarRLd5qxp/hjgHUoh
 vHzA1nV1hj4Xtt2RjF5z/Ux9ZTw/gn00e0my8Udbl9MP4J6gqp2pxlBJJ9uERNv4ZnFY8Tv
 AsDj8PhLnltYMTP9Wc8H3omfwEkraxv2uDmHopRS9rMdwHMuKnzo6eIPGHvo0HedzjfSKh2
 WGjGUivzHINMOMHAYzMpA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:P7ddz4qyPDg=;6fkk8/8OkMslbJammQ7MjpIqSDs
 ++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



=E5=9C=A8 2025/6/9 14:51, Christoph Hellwig =E5=86=99=E9=81=93:
> No full reivew yet, but I think in the long run your maintainance
> burdern will be a lot lower if you implement my suggestion of using
> the generic code and adding a new devloss super_uperation.

The main problem here is, we didn't go through setup_bdev_super() at=20
all, and the super_block structure itself only supports one bdev.

Thus even if we implement a devloss call back in super ops, it will=20
still require quite some extra works to make btrfs to go through the=20
setup_bdev_super().


Although I have to admit, if all btrfs bdevs go through fs_holder_ops,=20
it indeed solves a lot of extra races more easily (freeze ioctl vs bdev=20
freeze call back races).

>=20
> This might require resurrecting my old holder cleanup that Johannes
> reposted about a year ago.
>
Maybe it's time to revive that series, mind to share the link to that=20
series?

Thanks,
Qu


