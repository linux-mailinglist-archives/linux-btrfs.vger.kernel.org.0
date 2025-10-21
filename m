Return-Path: <linux-btrfs+bounces-18130-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 41ACBBF8BF9
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Oct 2025 22:42:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 82B414F9780
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Oct 2025 20:41:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CA5D27B4F7;
	Tue, 21 Oct 2025 20:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="Q5vLUXTa"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F328F350A35
	for <linux-btrfs@vger.kernel.org>; Tue, 21 Oct 2025 20:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761079298; cv=none; b=L76iBiHiFan4XP1S+Z6QcwzlIM2+bD9sYT6HSJNALN+wjCo0OU8RiqOcIC1Yobh7dywJlwFnUI+GnLD/ATPu/fTOUjIRnqNUzaWWgquVfYxTBhcx9ynNvjFB00tAEfaSbXwnAc4oFEW3sJbH1wnPUTnq7nMDFi3v2zUY7yptytM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761079298; c=relaxed/simple;
	bh=ODha3GbN68jUlLcGNzDF9CqGlW7kmAH4sOR9Z+PxUn0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=b0/ZQO7hNBMz7PpKxKBReTKLma4Le/dW4ogvWwcODACeFAEiqQvHdgIIVFKY+AA3ambATRdI6HGv8vO0BXsw4lKZ9FDMdPyr0TIqjlgdm3o0RNxDyf7CKbiBkiX+vcFfDJhVK9FSHVFVAjqnie9eeYQDHOMM+FSQbPNmYuZ6MeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=Q5vLUXTa; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1761079291; x=1761684091; i=quwenruo.btrfs@gmx.com;
	bh=20QoeO5/vIHI/pI6u9beQ/QlCyHbKyHQDvfMt84h39o=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=Q5vLUXTaHDQ88yt1yWklShQ+RocMfIIhoCEyJS6MVd9yEXk/grFXGAFHrONDQIBw
	 +O3rUn69RTJ+OH93ycXEFkteY/u4hp5iD3JYv4rsNDyo5/DuoErFwexUKtSI9aaOD
	 UTkffQ4uN+mVaSI/bbH5qGXuvpldLCV5wurpkQ7lufNNvYjrE2ZkRfvxSzeC6UYyW
	 +PzS3KMpYv4+DhpvUGrh7QE62GRWRDknQrd60uOgtOPdJKLQMIEnsx3oaE81sKoxV
	 yTOZBwHEF8xeIJFDeG7tXQeTnlKhhaEzDVLdAMjDrv40q8Jat/Cy6HdGJcYAziiN4
	 rclVsKVR+JfjHLIOLQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MWAOQ-1ui3xg33Qw-00JDXQ; Tue, 21
 Oct 2025 22:41:31 +0200
Message-ID: <dbd85357-0300-4b1a-ad3a-d60621fe46e4@gmx.com>
Date: Wed, 22 Oct 2025 07:11:27 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] btrfs: allocate bounce pages for direct IO
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>, WenRuo Qu
 <wqu@suse.com>, "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <cover.1761030762.git.wqu@suse.com>
 <2d2faa4c2393015d225a27e4a729fd19216467e6.1761030762.git.wqu@suse.com>
 <5d907fc8-8bec-4a9c-914a-e2c3caf5d18d@wdc.com>
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
In-Reply-To: <5d907fc8-8bec-4a9c-914a-e2c3caf5d18d@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:QAPTiOLLvMI3SHxBOeWJiO2R/g7BK+0BJCbxLKVz+Qm2SY+2xCo
 /I9iBWVC1lgFTTFzsqWfGg2d2hO1cljDrx0EWV11s6wudZ5DmcAGjlz77KIk7PjZ6XGMcVF
 l1yOT1VtnJyhweljyLPKwzZkSWXofJe8XuJGzFDnV2o8ylrGsP5N5EHTnQvFLYPQkjWQqz6
 lbpKlmYE6bbJo3ONfCfuw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:CGVIn+oL3oc=;vE2ww1qcoP/5pPcpVp1cq1zv4zr
 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
 MghISekWyoGm5RB3vL6izSSOxM=



=E5=9C=A8 2025/10/21 21:14, Johannes Thumshirn =E5=86=99=E9=81=93:
> On 10/21/25 9:22 AM, Qu Wenruo wrote:
>> +struct bounce_ctl {
>> +	/* The original bio from iomap dio. */
>> +	struct bio *src;
>> +
>> +	/* Procetects @ret update. */
>> +	spinlock_t lock;
>> +
>> +	/* Number of pending bounce btrfs bios*/
>> +	atomic_t pending;
>> +
>> +	/* Record the first hit error. */
>> +	int ret;
>> +};
>> +
>=20
> [...]
>=20
>> +static void put_bounce_bio_ctl(struct bounce_ctl *bounce_ctl, int ret)
>>    {
>> -	struct btrfs_bio *bbio =3D btrfs_bio(bio);
>> +	unsigned long flags;
>> +
>> +	spin_lock_irqsave(&bounce_ctl->lock, flags);
>> +	if (!bounce_ctl->ret)
>> +		bounce_ctl->ret =3D ret;
>> +	spin_unlock_irqrestore(&bounce_ctl->lock, flags);
>=20
> Stupid question, why int ret and spinlock? can't this be solved with
> cmpxchg() as well so there's no need for spin_lock_irqsave()? Especially
> as this is only protecting a single struct member?
>=20

For int, just because it's more common to use "int ret" to indicate=20
error (and more error codes), other than "blk_status_t status".

Thanks a lot! I know the spinlock looks stupid but could not find a good=
=20
way to protect it.
Now cmpxchg() looks like the perfect solution and is already utilized by=
=20
iomap.

Will go that path.

Thanks,
Qu

