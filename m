Return-Path: <linux-btrfs+bounces-14576-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 02664AD293B
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Jun 2025 00:13:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58CA616FDE7
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Jun 2025 22:13:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B280F22488E;
	Mon,  9 Jun 2025 22:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="N1MfFAPx"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D0AC2940D
	for <linux-btrfs@vger.kernel.org>; Mon,  9 Jun 2025 22:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749507230; cv=none; b=j9BZBOt4YvJ3IZdS83FRzW7dXcxkhEhAhrgtFWJJCRNXYCs6bBhyntYzcaMWSpmRWsFRywbx5Tg7ZvbRA5/MC5YqlsBw2YTdMwvnfdSdOTzLKkK28Y7H1Jp3FeaV/lTJquJTyNQG1WstIFCl/BTtp5WW5NA00sAlBYZfnraqJG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749507230; c=relaxed/simple;
	bh=WTXKI/oBQmuoWnGc2EuasljaFGU3qqspXQCuTTV/DtY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Dj6O9BlJGVlAxp+1EL/TDzX28RJ2edEKXt4tDBzntYItME7T5CMVTvtywuIMy2Eu+rLLxBWr/lnQ6zXIAh254pEn7wJmH6/xNSEfOiaSQCzM8dAhaRrElTMzZIq7Mqe/z5QpeyfN6INA905Ewg6IY2skn2Sui1gtw1LR/Sy1pJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=N1MfFAPx; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1749507225; x=1750112025; i=quwenruo.btrfs@gmx.com;
	bh=kiDKtaL/Iuiui74hYzBtojricAAp5/sag01atXSp+Wc=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=N1MfFAPxVquFxuAa/zFXYcoSbcbZTH5ss/N/V/TEuuXsvuDfnyKJvuYUQyM8rRKp
	 YoeCfkgDSLMfQ1PICOYnd3Prre/I/M7vnh3C3EeLVkEMVgN1PCUEbBmLUbk/8DhQm
	 +FBX4ePvUq+9/fwkxNLFcypN25qkWYmiudTgAi7r1PK9UbgSk6+5kOUutWCbI8DJ8
	 K1jwd8spqmA18SCM88ZM1eSxO9CKh7ZkA9Ap5H3ehrmueYMcnehCd4coe4o9263j7
	 S9e/OYdDO5I1nIZrRSak/ihbYrZjrA54XAkvL/Uaa+MamMv4jaOn7YRAwYvRnOlMQ
	 2SAXMkOfb0cStPJHKw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MmlTC-1v5GmN0awA-00qfd0; Tue, 10
 Jun 2025 00:13:45 +0200
Message-ID: <1fcb4fd5-a147-4614-a6c5-76857ee9503f@gmx.com>
Date: Tue, 10 Jun 2025 07:43:41 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND] btrfs: add extra warning when qgroup is marked
 inconsistent
To: dsterba@suse.cz, Filipe Manana <fdmanana@kernel.org>
Cc: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <e4811c2208b00be4b3206f24db6b81691b3de74e.1749467712.git.wqu@suse.com>
 <CAL3q7H5MXb0QK02o39HWFS4CHVJ2ybD9SX7njzQbPYjTm5G7NA@mail.gmail.com>
 <20250609185535.GA4037@twin.jikos.cz>
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
In-Reply-To: <20250609185535.GA4037@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:0ZWu1xxEygEk6VjdOUyZbxoJKw+2+ibF6E/IjDV+ZTvpfhhCF/3
 kRug0lvg6uRRNWhQbeMZ+73Iv4kMsSDoS/6lVb1CQVdwOLSzqjm4qrXCxKaavF4WPW8mglK
 2zQHKfUnAxYuld+qqXO19YCr8PmwPWKN0O73TqkeADmZbvJRmU7skGYG7X0QPRwKopsn7qK
 9I9gblZ54MmQgxSzMDIvQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:7cx09ywdRKs=;Oz8yCquF2pyBFV/AC1cpGDB9ylK
 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
 Ckg7xDvKzdzb9LmA



=E5=9C=A8 2025/6/10 04:25, David Sterba =E5=86=99=E9=81=93:
> On Mon, Jun 09, 2025 at 01:17:30PM +0100, Filipe Manana wrote:
>> On Mon, Jun 9, 2025 at 12:16=E2=80=AFPM Qu Wenruo <wqu@suse.com> wrote:
>>>
>>> Unlike qgroup rescan, which always shows whether it cleared the
>>> inconsistent flag, we do not have a proper way to show if qgroup is
>>> marked inconsistent.
>>>
>>> This was not a big deal before as there aren't that many locations tha=
t
>>> can mark qgroup  inconsistent.
>>>
>>> But with the introduction of drop_subtree_threshold, qgroup can be
>>> marked inconsistent very frequently, especially for dropping large
>>> subvolume.
>>>
>>> Although most user space tools relying on qgroup should do their own
>>> checks and queue a rescan if needed, we have no idea when qgroup is
>>> marked inconsistent, and will be much harder to debug.
>>>
>>> So this patch will add an extra warning (btrfs_warn_rl()) when the
>>> qgroup flag is flipped into inconsistent for the first time.
>>>
>>> Combined with the existing qgroup rescan messages, it should provide
>>> some clues for debugging.
>>>
>>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>>> ---
>>> Pure resent, I thought it was already merged but it's not the case.
>>> It will be very helpful for debugging qgroup related problems caused b=
y
>>> qgroup being marked inconsistent.
>>> ---
>>>   fs/btrfs/qgroup.c | 2 ++
>>>   1 file changed, 2 insertions(+)
>>>
>>> diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
>>> index a1afc549c404..45f587bd9ce6 100644
>>> --- a/fs/btrfs/qgroup.c
>>> +++ b/fs/btrfs/qgroup.c
>>> @@ -350,6 +350,8 @@ static void qgroup_mark_inconsistent(struct btrfs_=
fs_info *fs_info)
>>>   {
>>>          if (btrfs_qgroup_mode(fs_info) =3D=3D BTRFS_QGROUP_MODE_SIMPL=
E)
>>>                  return;
>>> +       if (!(fs_info->qgroup_flags & BTRFS_QGROUP_STATUS_FLAG_INCONSI=
STENT))
>>> +               btrfs_warn_rl(fs_info, "qgroup marked inconsistent");
>>
>> About half the callers already log some message right before or right
>> after calling this function.
>> But this won't tell us much about why/where the qgroup was marked
>> inconsistent for all the other callers.
>>
>> Perhaps we can pass a string to this function and include it in the
>> warning message? And then remove the logging from all callers that do
>> it.
>> Additionally turning this into a macro, and then printing __FILE__ and
>> __LINE__ too, would make it a lot more useful for debugging.
>=20
> If this is meant for debugging then the message level should be either
> debug or info, but not warn. If it's for user information then the file
> and line is not relevant.
>=20
> Otherwise agreed about printing the reason why it's marked inconsistent.
>=20

The message is to inform the end user that qgroup is marked=20
inconsistent, which is a common thing.

It's not for error paths, thus filename and line is not really needed.

And for the reason, there are really one or two (except error cases):

- We're dropping a high subtree
   Either we queue the whole subtree for accounting, which is super slow
   and can hang the current transaction.
   Or we mark qgroup inconsistent and call it a day

- We're doing snapshot where the source and destination have different
   parent qgroup
   The reason is pretty much the same as the above case.

I can add the reason, but for most cases it will be the above two.

In that case do we still really need such reason?

Thanks,
Qu

