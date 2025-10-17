Return-Path: <linux-btrfs+bounces-17954-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6250CBE8149
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Oct 2025 12:34:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8FA2B4FC9E1
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Oct 2025 10:34:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2369D25393B;
	Fri, 17 Oct 2025 10:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="tbSIFAUj"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C2C44204E
	for <linux-btrfs@vger.kernel.org>; Fri, 17 Oct 2025 10:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760697249; cv=none; b=GUqo7O9gkcjFpXvhjkE8xoJWKsaXeBrkS0rb45sVtU0ppCQ4Y+/PNgf4iSCaQyKayi9zcBCC9QfiJvNZlt8JybAZStEpjQlFfEwyHgqqArArQ/pDVh5lqYbQj1CnnytSVB+xvJfVAgPvw3tHzDHscB0h6X0jsgRggF+jxYHNJgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760697249; c=relaxed/simple;
	bh=ntS2x3YtZXwCRiBmhNj7Y/VSFVKy8SgyAHHJsf6rTng=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y7OrD7xCIAzHHYKX99whfxbnu8KOVzlggFAIPj8xUt9cXkPBKQgsY9XQrtckhL+/C72wpEcuz8Gfz1PfgQkxbWbneWb7OOV8QlCkI3LQ43Etdjtj/ocb9uBzSb7HnfWUAOraZEPp60tPVb3qeTCEXzMHrNxh5mbxzdHpIW7VEEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=tbSIFAUj; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1760697245; x=1761302045; i=quwenruo.btrfs@gmx.com;
	bh=e4mQCAX2/y5AoPcNdadUTdkWbib/FFJ4lsQVF6JTgLk=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=tbSIFAUjMBj3bMfVpZlaTUKOHr8O+vE+NjU7JUmCYtLirpGAOmMpx2P215Kl1SJ/
	 2pSoOBvKDefM88Odg65SMygPFQqoYPnw/9yKHq7PQh5hQihmspyqZtkgUFofxhV0T
	 mvG1CYmvtUY7LjGdfevXGplrMmuD471MfG6aWcnHDytZX9l7YVFsRWv7cj5VvPzhI
	 hLakMhPKrCRiVDVSZclkTn/FqCYGl5MynkniiaYcHOHCaduxqhOO3vnrocrSYDSHA
	 6cqJ2UCjFAnxQEeASJ/4pZHRQOVBBLK57cN69jbUWQPASxwPBYQnEpPMcq1/i5S8S
	 qfc8o0UNB7eOBpaGmQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M59GG-1vAoFE2NVs-000MT9; Fri, 17
 Oct 2025 12:34:05 +0200
Message-ID: <f9db91ea-3a56-4f84-bcc3-326fc4a01064@gmx.com>
Date: Fri, 17 Oct 2025 21:04:01 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] btrfs: scrub: cancel the run if there is a pending
 signal
To: Askar Safin <safinaskar@gmail.com>, wqu@suse.com
Cc: fdmanana@suse.com, linux-btrfs@vger.kernel.org
References: <395c1ee665584f092c089d73895d3f316730c6e8.1760607566.git.wqu@suse.com>
 <20251017094752.1171803-1-safinaskar@gmail.com>
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
In-Reply-To: <20251017094752.1171803-1-safinaskar@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:OZR7EOPFGIYEHCsGvm7qLxNVM3pbmQ27ugtHmU0KJgGyozJiaOM
 fx/KWhyJ1h79r25m/j3DQnGc49k8AFHQ/Y4w1AkniAxcZFlkFX0A61pgP8SnUDoQE6nXJrq
 99pixuuBSVbRirPtFhco2nwiuxaXeiQW8hYXPwAHyno5IXFUC8tkWOaF03yKDdhLymQmG4t
 c4kmBCazZBEjMYKz9lQYA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:CpGso1pWS04=;oBNuUrQf3TIHi0o2Rko5wuStefQ
 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
 KPyVhsqFYhq+LvWsxbSBpXi5E2N28s5I2uE=



=E5=9C=A8 2025/10/17 20:17, Askar Safin =E5=86=99=E9=81=93:
> Qu Wenruo <wqu@suse.com>:
>> +	/*
>> +	 * Signal handling is also done in user space, so we have to return
>> +	 * to user space by canceling the run when there is a pending signal.
>> +	 * (including non-fatal ones like SIGINT)
>> +	 */
>=20
> SIGINT is bad example here. "btrfs scrub" somehow is already able to cat=
ch
> SIGINT on unpatched kernel.
>=20

I can not find any kernel code that checks the signal before this patchset=
.

But btrfs-progs are no longer doing straightforward single ioctl=20
anymore, even with -B option it will still start one thread for each=20
device to do the ioctl.

Thus there is always the main thread which is not falling into the=20
kernel space and can handle the signal.

Thanks,
Qu

