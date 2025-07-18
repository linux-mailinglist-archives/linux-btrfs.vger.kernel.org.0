Return-Path: <linux-btrfs+bounces-15563-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C98B4B0AC3F
	for <lists+linux-btrfs@lfdr.de>; Sat, 19 Jul 2025 00:46:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5D1507B757B
	for <lists+linux-btrfs@lfdr.de>; Fri, 18 Jul 2025 22:44:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 934DA21CC6D;
	Fri, 18 Jul 2025 22:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="Uj7o2y4p"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D1402AD2F
	for <linux-btrfs@vger.kernel.org>; Fri, 18 Jul 2025 22:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752878755; cv=none; b=WP5OLAK7RsnKXQZQl3kr331iK8S6+vsjvBrVnzGdiwaf62EHRliNi7Nmq7fNMWHuGJYUjl9B1FOOosXXSn62w0zRjnRMFkBgjijxKsoTjswbQGI8v9a1V1CJdm+kKDejzd74YSXN6XGiYqnnuW478Q4FfOj7QS0fNMQTel4PoYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752878755; c=relaxed/simple;
	bh=cBkYi5ebdQE0hioTeRsSbwfcAAuY3SuXUA4RLmaAb9Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NLUI/tx7IHfnsmXYRNPM8OUHF49++1dbQxU298Lfl2iTbjgrNE2lvc4g0u1rYCIoCgmqrwpcymub6cl69w+tlc4tNeMgGyJvGfIPW6SKatdY+RfSEwTp9ETyJMK+AdiPNc9LmS3CVqadwON+12mfbx6U2V+WZtWdbim213Q+6Uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=Uj7o2y4p; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1752878750; x=1753483550; i=quwenruo.btrfs@gmx.com;
	bh=ncJl8xSfBL3NZY3PMqPuBknwmeXzLA5DU+CZdBncOPA=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=Uj7o2y4pUz638xqANrFLP7LNdswbUmuxAqp0vAzImdd32Zfj1Vwjlvz8LIT/obux
	 oM7V+/mrcPahScH4OrsjxJ3w7Jh5VVSD/HNPPzyl8JT0zR2z1PAkUwdGTkMvM8dBi
	 20USewFU+DlUbbZptmd5Ep805dsXvZ1s7P5aRkoxTXHE7joSil4bkPz3XKf4SpFI6
	 7YS11plM9F3cKHoMS2OHr8NCDAoUYQJN5xIV/aYZiU8OXvuPGjjYQayHDLxiHp5xc
	 3Do7yqPuDJ3qcnvxV+CetZahUh/0Ah9nT6smRwY6Hit7Q7HpjY/gJQpukWUwK1k11
	 fV58ZhbMfGjMgkaEEg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MXXyJ-1u6hCT0Qs3-00USQ9; Sat, 19
 Jul 2025 00:45:50 +0200
Message-ID: <e92fb2bb-1ebf-49b7-aac1-7d2be1b31362@gmx.com>
Date: Sat, 19 Jul 2025 08:15:46 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: fix subpage deadlock
To: Boris Burkov <boris@bur.io>
Cc: Leo Martins <loemra.dev@gmail.com>, linux-btrfs@vger.kernel.org,
 kernel-team@fb.com
References: <52e3db9d6f775370d963eb5179e3cbfa1ace5e04.1752795616.git.loemra.dev@gmail.com>
 <4b717bb0-d421-43e1-b722-1bf56a611df5@gmx.com>
 <rk53fmeujogdqpwxh5zhrr4p62bd7io2pvxyuxn3w7eo57ygd6@nfb4wxhrorgw>
 <20250718183706.GA4097590@zen.localdomain>
 <0ae559d6-ba95-489c-96fc-feca35a83f9a@gmx.com>
 <20250718222405.GA4169427@zen.localdomain>
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
In-Reply-To: <20250718222405.GA4169427@zen.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:FTuOBBkFdOieaBuUeb2shX8uy98o+ASxp5wdLDUaP26gt+MoaT5
 y5ijCfleuHQ1IwrhqqzoknoHQRb9AzUAF2DZceccN1EeZR30FF4/vxS/jExrFs0xjWg/E/F
 BFd+Yd5Q+8wOfiwttf2tqoDcCF61aZmBazMi82FJnkKTJETxIM0OYj3zypKSffNPEuTsOzA
 4JBhiTtG65CVnW85t3UxA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:0tI6eSRECpU=;MD5PWgJpMErqhq/mMt8Dl36JItW
 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
 InRwcITRNrp753jgBbNsbPc=



=E5=9C=A8 2025/7/19 07:54, Boris Burkov =E5=86=99=E9=81=93:
> On Sat, Jul 19, 2025 at 07:06:45AM +0930, Qu Wenruo wrote:
[...]
>>
>>>
>>> And even if I missed something in that analysis and the writeback flag
>>> does save us, is there a way we can tell lockdep that this is in fact =
a
>>> safe locking relationship? "Theoretically", it's wrong, even if some
>>> other synchronization saves us..
>>
>> I don't think it's theoretical only, since the lockdep is a runtime
>> detection tool, if there is something really preventing it from happeni=
ng,
>> then it should not report this call site at all.
>=20
> I don't think that's necessarily true. IIRC, lockdep globally tracks the
> unique orderings of locks it has seen and reports violations of its
> theoretical invariants, it doesn't have to have seen a sufficiently
> concurrent or deadlock-y state.
>=20
> For example if we have 3 locks A, B, C and code that does
>=20
> lock(A); lock(B); lock(C); unlock(C); unlock(B); unlock(A);
> and
> lock(A); lock(C); lock(B); unlock(B); unlock(C); unlock(A);
>=20
> then I think a deadlock is impossible, but lockdep will complain that
> B and C both depend on each other?

My uneducated guess is, it will not report a deadlock.

> And even if lockdep is clever and
> detect that A protects that particular violation, then imagine if A is a
> type of "I rolled my own condvar" synchronization that lockdep doesn't
> know about. It can be theoretically impossible to have the deadlock but
> in a way lockdep isn't sophisticated enough to understand.

Non-standard synchronization implementation is always going to cause=20
problem, and in that case, I'd prefer to address the lockdep warning anywa=
y.

And even if lockdep is warning about the above BCCB locking sequence,=20
and it's indeed impossible to hit, I still like to address it, just for=20
the sake of consistency, and make it more future-proof when lock A is=20
removed later.

>=20
>>
>> [...]
>>>>>> @@ -4332,15 +4333,18 @@ static int try_release_subpage_extent_buffe=
r(struct folio *folio)
>>>>>>     	unsigned long end =3D index + (PAGE_SIZE >> fs_info->nodesize_=
bits) - 1;
>>>>>>     	int ret;
>>>>>> -	xa_lock_irq(&fs_info->buffer_tree);
>>>>>> +	rcu_read_lock();
>>
>> According to the docs, xa_for_each_range() is already taking and releas=
ing
>> RCU lock by itself, thus the extra RCU lock may not be necessary at all=
.
>>
>> Maybe you can try with the xa_lock_irq() removed for this call site?
>>
>=20
> I believe it is important that we are doing rcu_read_unlock() after we
> take eb->refs_lock. Otherwise, I think that a different thread further
> along in release_extent_buffer() can take eb->refs_lock, decrement the
> ref count to 0, and delete the eb in call_rcu(), because we aren't
> protected by a grace period, then we get a null ptr exception trying to
> take eb->refs_lock.

You're right, I didn't notice the RCU is also utilized to protect the=20
extent buffer, not only the XA array.

In that case we indeed need the rcu lock for the @eb.

>=20
> This is all being maximally paranoid and assuming we can run
> try_release_subpage_extent_buffer() concurrently with another thread
> running release_extent_buffer(), though, which I haven't proven to
> myself one way or the other. I think it seems likely enough to be
> careful with.
>=20
>>
>> Another thing is, since the problem is only possible as metadata write =
endio
>> is happening in an IRQ context, the other solution is to delay the meta=
data
>> endio to happen in a workqueue.
>=20
> I think this is a nice idea, getting rid of work in an interrupt context
> if it isn't strictly necessary seems like a nice improvement. We already
> do this with ordered_extents in end_bbio_data_write(), so I don't see
> why it would be impossible for end_bbio_meta_write().
>=20
>>
>> By that we can even replace the usage of xa_lock_irq() with regular
>> xa_lock(), but that may be a little huge change, thus such change shoul=
d be
>> only the last-resort method.
>=20
> Agreed that it is a much bigger change. I think we agree we should get
> some kind of fix in now and then refactor further if we think it's
> helpful?

Yes, we definitely need a hotfix for this.

And thanks to all the help and discussion, the fix now looks good to me.

Although the commit message can add some extra info on why it's safe to=20
do the convert:


Firstly the xa_for_each*() helper itself doesn't really need the=20
xa_lock(), as it's already taking rcu lock.

Although that also means the xa_for_each*() won't see the newly added=20
entries if there is a concurrent entry adding, it won't be a problem as=20
we do not rely on the xa_for_each*() helper to really make sure there is=
=20
no eb in the range.

Instead we rely on the folio::private, which is more reliable to detect=20
if there is any eb in the folio.


Secondly the rcu lock is also protecting the eb, exactly as explained by=
=20
Boris' reply, thus we won't hit some use-after-free accessing the extent=
=20
buffer.

Thanks,
Qu

>=20
> Thanks,
> Boris
>=20
>>
>> Thanks,
>> Qu


