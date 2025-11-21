Return-Path: <linux-btrfs+bounces-19259-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 00914C7BA3C
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Nov 2025 21:30:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C6E104E5F3E
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Nov 2025 20:29:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69B362765F5;
	Fri, 21 Nov 2025 20:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="hE3ZUVy5"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1204430217E
	for <linux-btrfs@vger.kernel.org>; Fri, 21 Nov 2025 20:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763756977; cv=none; b=WpMikGE0jFr9DG3PdQXw+cpOKlcpugGXb+5IlEowLEnT/JLRhpB458ki3Bm7WSdU3q2WmzyE+DNXcOXX2pUbdtzfco7Jwaa9EERociS6W/Fpfjtu27ODfuzu6/VhFYch3EHzbS5i7pFvKwMKbZPQWgLEWBef5IqAGyKLszjRx8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763756977; c=relaxed/simple;
	bh=FL8hwQZEtV9ScB5GJaBstHhUs2aEA0lcI89U9UbcXM0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dCnRGlAiV7ZZdwLRJBc1DmKuTfzV3II4OS1kBMrgtc4ZXF3YpxfZWLuwQkSGKRDTPKgmpRc1aLWtN3GzMu9w5klTCGhXpyTo1Yz2cJwB9NdJXDSJ1Nu7ik11iSL2Es3+nGhL+7qGSlpatXxzf/vNIwREFnBP9XcxbArv/+fEyFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=hE3ZUVy5; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1763756973; x=1764361773; i=quwenruo.btrfs@gmx.com;
	bh=r2uGgj8JOSwxegnz8M6RUT8lmP4J3dagR97gzKgaD0c=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=hE3ZUVy5QecKgRXzvQ+rHs2jQKkpkPtFbAq/0OfWShIOxb90GnV3uQMaa5jqmm5D
	 BorTcoiWE0Csr1e9TImH2zY0LOwLmqLxEOZBgNYQbIcd3xiA4uhztyMHNsvXxwfdb
	 RxXdQ8Zw8IV8F8wMr6sx9xvQ8KT4H7v+MqbYj/wzdaUlauWfVYPCQVxRmlNGZ57Hh
	 nM5yfght40KT3RJL2XU9Zewmp2v/x/UVSWki91E6hoWB84aRKHLpZilbVcda0Lc77
	 NQ8lHWYJ0YttG26S6n6JFtvW75sojRFvhxbRHa0XwFQSCs1ELqqvvqWW5rUW7T3ne
	 1SQdQ/BlmM4cEzRwew==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M6ll8-1vUntS2P7O-006KLR; Fri, 21
 Nov 2025 21:29:33 +0100
Message-ID: <bff15ad4-1f67-4733-acb4-cd04686f4ec4@gmx.com>
Date: Sat, 22 Nov 2025 06:59:29 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] btrfs: fix data race on transaction->state
To: Filipe Manana <fdmanana@kernel.org>, Josef Bacik <josef@toxicpanda.com>
Cc: linux-btrfs@vger.kernel.org
References: <cover.1763736921.git.josef@toxicpanda.com>
 <7a9d970450cb1531d0a0da5d8e8615b06aba9137.1763736921.git.josef@toxicpanda.com>
 <CAL3q7H7phOax9p2s-pcaeGdE4rgpZc7NP1=0Ny+o93fXYKJ-Nw@mail.gmail.com>
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
In-Reply-To: <CAL3q7H7phOax9p2s-pcaeGdE4rgpZc7NP1=0Ny+o93fXYKJ-Nw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:PRzz+7N7zUt6SyfgpKfpwjBJjUlffkBwHOHZ3E+HAqm1UIzu5yP
 5JlYHEPVvwLVpK41odV1EUPexMosLiUs/WADqYtME5ItROQcSmY3r2TJxIC3yrcP9EKlYWR
 n1BsTCuSwElQmo86dmYEJfNuDSFRTCbZQ/VKWMSGRweAQcvDLthLqBUteDPMApIwwP78rxS
 yy2M/TtNqcsCG5dgovLqg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:XtTn+2lj4b0=;DQQooAgeBY2ftnbHP+EFqab12fB
 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
 nnxUUGyI=



=E5=9C=A8 2025/11/22 01:59, Filipe Manana =E5=86=99=E9=81=93:
> On Fri, Nov 21, 2025 at 3:13=E2=80=AFPM Josef Bacik <josef@toxicpanda.co=
m> wrote:
>>
>> Debugging a hang with btrfs on QEMU I discovered a data race with
>> transaction->state. In wait_current_trans we do
>>
>> wait_event(fs_info->transaction_wait,
>>             cur_trans->state>=3DTRANS_STATE_UNBLOCKED ||
>>             TRANS_ABORTED(cur_trans));
>>
>> however we're doing this outside of the fs_info->trans_lock. This
>> generally isn't super problematic because we hit
>> wake_up(fs_info->transaction_wait) quite a bit, but it could lead to
>> latencies where we miss wakeups, or in the worst case (like the compile=
r
>> re-orders the load of the ->state outside of the wait_event loop) we
>> could hang completely.
>>
>> Fix this by using a helper that takes the fs_info->trans_lock to do the
>> check safely.
>>
>> I've added a lockdep_assert for the other helper to make sure nobody
>> uses that one without holding the lock.
>>
>> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
>> ---
>>   fs/btrfs/transaction.c | 18 +++++++++++++++---
>>   1 file changed, 15 insertions(+), 3 deletions(-)
>>
>> diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
>> index 89ae0c7a610a..863e145a3c26 100644
>> --- a/fs/btrfs/transaction.c
>> +++ b/fs/btrfs/transaction.c
>> @@ -509,11 +509,25 @@ int btrfs_record_root_in_trans(struct btrfs_trans=
_handle *trans,
>>
>>   static inline int is_transaction_blocked(struct btrfs_transaction *tr=
ans)
>>   {
>> +       lockdep_assert_held(&trans->fs_info->trans_lock);
>> +
>=20
> It seems odd to sneak this in when no other change in the patch
> introduces a call to this function.
> I would make this a separate patch.
>=20
>>          return (trans->state >=3D TRANS_STATE_COMMIT_START &&
>>                  trans->state < TRANS_STATE_UNBLOCKED &&
>>                  !TRANS_ABORTED(trans));
>>   }
>>
>> +/* Helper to check transaction state under lock for wait_event */
>> +static bool trans_unblocked(struct btrfs_transaction *trans)
>=20
> This could have a name that is closer to the other helper:
> is_transaction_unblocked()
>=20
>> +{
>> +       struct btrfs_fs_info *fs_info =3D trans->fs_info;
>> +       bool ret;
>> +
>> +       spin_lock(&fs_info->trans_lock);
>> +       ret =3D trans->state >=3D TRANS_STATE_UNBLOCKED || TRANS_ABORTE=
D(trans);
>> +       spin_unlock(&fs_info->trans_lock);
>> +       return ret;
>> +}
>> +
>>   /* wait for commit against the current transaction to become unblocke=
d
>>    * when this is done, it is safe to start a new transaction, but the =
current
>>    * transaction might not be fully on disk.
>> @@ -529,9 +543,7 @@ static void wait_current_trans(struct btrfs_fs_info=
 *fs_info)
>>                  spin_unlock(&fs_info->trans_lock);
>>
>>                  btrfs_might_wait_for_state(fs_info, BTRFS_LOCKDEP_TRAN=
S_UNBLOCKED);
>> -               wait_event(fs_info->transaction_wait,
>> -                          cur_trans->state >=3D TRANS_STATE_UNBLOCKED =
||
>> -                          TRANS_ABORTED(cur_trans));
>> +               wait_event(fs_info->transaction_wait, trans_unblocked(c=
ur_trans));
>=20
> Instead of adding an helper and locking, couldn't this be simply:
>=20
> wait_event(fs_info->transaction_wait,
> smp_load_acquire(cur_trans->state) >=3D TRANS_STATE_UNBLOCKED ||
> TRANS_ABORTED(cur_trans));

Not an expert on memory barriers, but isn't the key point here that=20
we're accessing two different variables in a non-atomic way?

And to be honest, I really do not like introducing low level memory=20
barrier callers, it's really hard to get it right.

Thanks,
Qu

>=20
> Thanks.
>=20
>>                  btrfs_put_transaction(cur_trans);
>>          } else {
>>                  spin_unlock(&fs_info->trans_lock);
>> --
>> 2.51.1
>>
>>
>=20


