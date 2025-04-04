Return-Path: <linux-btrfs+bounces-12789-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12112A7B6BF
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Apr 2025 06:05:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC7F23B8167
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Apr 2025 04:04:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AA5E2770B;
	Fri,  4 Apr 2025 04:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="Jy1EWukf"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAD5F3C38
	for <linux-btrfs@vger.kernel.org>; Fri,  4 Apr 2025 04:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743739507; cv=none; b=UeYXPkCFhIdAX1+Zw2VHFugYRs3X8CzGFR7UL+1hL3x/7e3HxkfVZ4gur+bPowj4I6Z9nIZjtQc+9f5HvX4cleUwKVbYEIdgaOqWjT+rBfOqRGpoAQ5h9EwIDI5ts5T2ERQxHsOYorRWaaLcRwwwSsKfZUSxkLkrCscJzq3kuT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743739507; c=relaxed/simple;
	bh=Yj7gDx1lTU/gxjDuiiSGjQSmoQchUTnUXVTetHqNxwk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BhbBnWvH9/xcbHXMolZ+KmC17JuNLxA+TDnk6q2RGDS7CJvL6kFv/aNRrm3klQs80Pie++bOETb1RuH6G4kgRZlwx+etnsDqpYPRMcN+hF86RJuPwBTln3DCNI55c028RhfjnBpc7ubyAqXSqbmkV5CXi02E/8mRM0sPEnNovQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=Jy1EWukf; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1743739440; x=1744344240; i=quwenruo.btrfs@gmx.com;
	bh=Yj7gDx1lTU/gxjDuiiSGjQSmoQchUTnUXVTetHqNxwk=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=Jy1EWukfZK98w+rEF111uRvCmXlX+ujCco5whY/7u2Rh9I/WrDkl+9e65xEd43uI
	 mT+BxMTGBlfo8MIJM9KUGyCUyQoV9pmFKuSr/jLPpKVjdA6HKSD/j+m14wYZ3dj73
	 L+32IdxjoMNUWBrTiIFgz+UBR2Yw/pyrUIvTDRi26j6JhdAQkdlnFxq8urPwVubS5
	 PQZHMTiU3+66h6SHxq3AR/nSRkaNh9E/7kLSiowBVJ7X2r8LehM6HVHnzhZa+ycXV
	 P6XQhMAaII7zVPA5gRydWRTQRvjxBGXJ9+2iazx1/CdlTShUTq7nY6NWd2byK81Jz
	 PG2++zjAjIrCU6Vnyg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1M1HZo-1txn7t2Xpy-0095ki; Fri, 04
 Apr 2025 06:04:00 +0200
Message-ID: <61996eb1-de0d-4d9c-b1cc-b24145985d38@gmx.com>
Date: Fri, 4 Apr 2025 14:33:56 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: mount compress=zstd leaves files uncompressed, that used to
 compress well with before
To: Dimitrios Apostolou <jimis@gmx.net>
Cc: Gerhard Wiesinger <lists@wiesinger.com>, linux-btrfs@vger.kernel.org
References: <2f70d8f3-2a68-1498-a6ce-63a11f3520e3@gmx.net>
 <d1c2f041-f4f5-9dad-511c-117ed8704565@gmx.net>
 <8aaba46c-f6d5-4f3a-a029-f564b8a6a9ff@wiesinger.com>
 <2858a386-0e8c-51a6-0d8a-ace78eced584@gmx.net>
 <2b33bf94-ec1d-4825-834d-67f4083ea306@gmx.com>
 <ba2a850f-6697-7555-baa4-32bc6bf62f81@gmx.net>
 <b9f7b83d-5efa-4906-9df3-a27f399162fb@gmx.com>
 <d6abe471-8144-3f13-1002-d55cf7d3e672@gmx.net>
 <939a6f4a-837b-4613-8761-b03f8d4809ea@gmx.com>
 <b338d808-f691-9969-9e48-d4a9f0363af3@gmx.net>
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
In-Reply-To: <b338d808-f691-9969-9e48-d4a9f0363af3@gmx.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:uH/O1GHV73nOjaI2MA28tczx2bOHoA+9qMFF4dZPB7RH3nNZgei
 KggsDgTB/w+2RJ1mv5uztABLXNbcFtWycdQpzXSaw3i7c1qxvVBzIuwWJJLiyUReGyrtp1Q
 8RhoOGsGfGl6ifHG3ZXHVBfZ0TIG58IMfJkxwKxNuA2GT5mDgrA6Evd+gD6/ynuoYZU+M6L
 OYKhF/alo2wc1AFQ0qJWQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:nYlx53tS1MU=;BYrqya9YNJ8o6Uq4NCdomz5yzJr
 PyvQm6AuCUtx9SMMA1VNBDQ3CEYl+F+73ZbkzZy6S3tl25W2A/WK4zDFTmHYkyRhZpZJs4OPW
 M/ypW68PiHMOvRfuhxX05kcMyMYi2h+TJW5hTuUWOP7zbWaRwDuNtms0uaCkv1S4I6QqgtP7g
 QxgCsCIuvg2qfp/e4jIT/j/x8MdzqqLM/D6lwRn9z3xq08ERpFicRUgS45smTri7XETXxsN2Y
 CwAERx6H0/EbgtPTMU0uY7rOiGVyC8dtliVI5j5hjXdsCQHgM32f/NEkGPfyxfa6Y6c1ZZrGC
 I3R/c2SgZDxBZg4v7kXxnRkI1jBu7tm+k0p3gEKWQP1G64FIuh1PBOQVHaLjYtUF3U5wY13aG
 pNoGOhpYJmiJmrdK1e5On34OKpXLQVa1jVINw6Eh1aeGtWS+LRznqOdEiDBkjsmw/54broibA
 iWS3ziiMzupojSJV805D7fQzNHCGd1OyH5ESQtN00LwwVeLHQtT+w1Goy8QJnE/IhenmoFywu
 2GOxXUqnFJ+S9ofnJLLvwU9qcXfq58cmhTZpRS4SDjrTUM6MZR6k7JA24nYfVoRRF9BcDbzzI
 qj30SRYmeGNe4d0/c+qEdtuIBGLEg0MeSPqxa+YVFSg/822NlNwueVW3RAdRgRjAsKrvsL0OB
 IchHzwTbqXEOFuc2hccVAMIZpJjBz9FDdg1LQynjRsM87l3YUEl7DNaPcEtC9QZJf/N3UMv9n
 TNdB0oc304zkGzaSDs6VArcmSV4+GvEd7LA1uxv7m5c0Cigjk/pM9HoFxfblbQi4E7fLoIMOZ
 o8Z+Lq43uOGs/kZ9JWbL6ctGEmpWXW0FewEtFoPo4hFsz2PW11NBk5ePG2uql47fbe9BpeipB
 ZOqj6NlXpcBjzacn9rt7D+lYkyViG3wluLRnHk0nIMmn39rlk2wDbBCIqylu5kEkR/I3XviUg
 MLK8zgBNE625HzIy/EkYyGFmQGMP0+bWfUai8jnVLlRryAgl9RgzlNZZ2ew1UoDBZFxy4KsKx
 NmStMbn4i66EeQr1oMx9TVjZiY86jrq2IkhmFdx3sotH0cl5EAhc8+BqvVed1Wep8Yj+5XWQs
 SToBXbaanN6TaAM+tYUenjC5ZBzHFQ6se2oUn/eKeGPNaOvbBQSl5BMr4H7MWrfsNHLMBjfUi
 Fo6sdnf/zd/8oaU0MtWlNmj2INRx4whSFzzJkvV/bCnuQ54Sn+nSdwq/DVQcuqEEdea8NkItL
 0HWMBenz0C95Y8Ww6jhzPSgBqLMEfn+Xn/3TD3B469RdLSHcdJ5H/VJ6q8jF3nY8MdpknZ8ny
 61vZK1oRSvCbQx+Idjt4S1+9Zksn4ftGQH2p/BJVYiDFKaqHTIdEDMS2c0UWVJxKqRpmfv1Ga
 onNA8V8P/8a0N7+YEffcrxtdrC6NYAtTsigpxxAls21dBD/20Yhr2tSDtIQICynEChg8hGv/1
 3sGPi8jxH0Es67inb25DwEZJRlb4=



=E5=9C=A8 2025/4/4 11:53, Dimitrios Apostolou =E5=86=99=E9=81=93:
> Thanks for the feedback, please see the attached patches. I decided to
> omit some details. I also include another simple patch clarifying that
> compress-force might end up writing uncompressed blocks.

Looks good to me.

Feel free to submit a github PR or both patches to the mailing list for
more review.

Thanks,
Qu

>
> Thanks,
> Dimitris

