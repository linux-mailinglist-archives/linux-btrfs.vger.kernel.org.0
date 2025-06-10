Return-Path: <linux-btrfs+bounces-14582-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4914DAD3405
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Jun 2025 12:49:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5CE3D18860F4
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Jun 2025 10:49:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4997128DB4D;
	Tue, 10 Jun 2025 10:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="fMLSpqnr"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24BDC28D8C5
	for <linux-btrfs@vger.kernel.org>; Tue, 10 Jun 2025 10:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749552426; cv=none; b=hfdks6vxw8REnWN0R1KfSuUog1pdu6S/h3USDjfmgqD/AKRu6QEjar7IPD5ACYBecyQXfkar9YHzvGDZrslcqQcPfu0sFx9265uLxzcp5MLOzpHMf4dxrhmXsMyQymB2e7Dcl0Ima6sPd311e537IXHpDwlnQ4WnD/WV4JwMd8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749552426; c=relaxed/simple;
	bh=htV8E4tRsBgzsF0Jez8frZNYAbg0r0Tdim4pwVCUqgY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YzKE6sM7xqkm1pkl+5fgdsYyKn0lqOBRnTcslpsZZ4vmK6n/95RcjcC35MAW3sMNp/JNrYopfDQozMkf1CWWUFdmbX1DvaBS1z4Z7J2y4LpUUV9T7f16hEp4OHmVqEsedOewDBBTwrVfPx1HyDSlSmm800OCM8YAj1tDwAFwVo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=fMLSpqnr; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1749552416; x=1750157216; i=quwenruo.btrfs@gmx.com;
	bh=LDR0CQpTBb5IiSiRd1zeHj0WmYooG62aqgv28hDp354=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=fMLSpqnr1qbvziw0QCDTND9YkRqzeIuE0lOJI0QzTe8MaPRgeFGmABUdsfunciLs
	 Ww3G4JA2I6DGvOic4vFBduy86nwIsjuL/oAwK+lrquFnnWNK4a4h+Hwk33CVWsLuE
	 KqvX3i4fwRfp88+K8XIXHCKi0muOhyEWfmKOpogsIMAm+9c6wtVfwNv/+Wb6U6Mj1
	 9jH6vMf66c6szZE9+QT/zap+vYPvHvLopiYJrZ/PCmg1ziLS5STcv7FRz/+BQuKQJ
	 ak9J9eG/0HNBUz7OdwmSFsbs93acxrEVKVEQLfeFe2/HARern/V+rvrryaUfeSawX
	 a1I9LYi7CB1xE/EX9Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MHG8m-1ucC3L3JOi-005f7a; Tue, 10
 Jun 2025 12:46:56 +0200
Message-ID: <01eb8e34-2306-43f0-8049-693284e7a0fa@gmx.com>
Date: Tue, 10 Jun 2025 20:16:52 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND] btrfs: add extra warning when qgroup is marked
 inconsistent
To: Filipe Manana <fdmanana@kernel.org>
Cc: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <e4811c2208b00be4b3206f24db6b81691b3de74e.1749467712.git.wqu@suse.com>
 <CAL3q7H5MXb0QK02o39HWFS4CHVJ2ybD9SX7njzQbPYjTm5G7NA@mail.gmail.com>
 <20250609185535.GA4037@twin.jikos.cz>
 <1fcb4fd5-a147-4614-a6c5-76857ee9503f@gmx.com>
 <CAL3q7H4BBp-4TyW+agBwM-1-rkjW3-g78s59Fxs8A2EZZTaA7A@mail.gmail.com>
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
In-Reply-To: <CAL3q7H4BBp-4TyW+agBwM-1-rkjW3-g78s59Fxs8A2EZZTaA7A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:tzGCs4fHe/NNjHdCLyf+tTSGLXimVZzNfn0baxi3pYvtBMtk64Q
 LeA6EN+yU+AfJPR+3AiL3St2z1/6Wb/ytoyOvcFTVfi4Y6m7zwgsyZcY+4Mt3C7/+xSr5lj
 mEi+XZZYycFJ1HJ85kPQ5XhNO+DfK5dmMPN4LvO5HFqmyYDs4Ku4wa5MstwvkdHb9e8cjOb
 iIp/27hCtUqz5nGIipeGg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:SWaXjUbMnXQ=;wD8xhz9bupHbGh8dr54/1RUnhh+
 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
 biw4hcie6Zdy32JF



=E5=9C=A8 2025/6/10 20:14, Filipe Manana =E5=86=99=E9=81=93:
> On Mon, Jun 9, 2025 at 11:13=E2=80=AFPM Qu Wenruo <quwenruo.btrfs@gmx.co=
m> wrote:
>>
>>
>>
>> =E5=9C=A8 2025/6/10 04:25, David Sterba =E5=86=99=E9=81=93:
>>> On Mon, Jun 09, 2025 at 01:17:30PM +0100, Filipe Manana wrote:
>>>> On Mon, Jun 9, 2025 at 12:16=E2=80=AFPM Qu Wenruo <wqu@suse.com> wrot=
e:
>>>>>
>>>>> Unlike qgroup rescan, which always shows whether it cleared the
>>>>> inconsistent flag, we do not have a proper way to show if qgroup is
>>>>> marked inconsistent.
>>>>>
>>>>> This was not a big deal before as there aren't that many locations t=
hat
>>>>> can mark qgroup  inconsistent.
>>>>>
>>>>> But with the introduction of drop_subtree_threshold, qgroup can be
>>>>> marked inconsistent very frequently, especially for dropping large
>>>>> subvolume.
>>>>>
>>>>> Although most user space tools relying on qgroup should do their own
>>>>> checks and queue a rescan if needed, we have no idea when qgroup is
>>>>> marked inconsistent, and will be much harder to debug.
>>>>>
>>>>> So this patch will add an extra warning (btrfs_warn_rl()) when the
>>>>> qgroup flag is flipped into inconsistent for the first time.
>>>>>
>>>>> Combined with the existing qgroup rescan messages, it should provide
>>>>> some clues for debugging.
>>>>>
>>>>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>>>>> ---
>>>>> Pure resent, I thought it was already merged but it's not the case.
>>>>> It will be very helpful for debugging qgroup related problems caused=
 by
>>>>> qgroup being marked inconsistent.
>>>>> ---
>>>>>    fs/btrfs/qgroup.c | 2 ++
>>>>>    1 file changed, 2 insertions(+)
>>>>>
>>>>> diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
>>>>> index a1afc549c404..45f587bd9ce6 100644
>>>>> --- a/fs/btrfs/qgroup.c
>>>>> +++ b/fs/btrfs/qgroup.c
>>>>> @@ -350,6 +350,8 @@ static void qgroup_mark_inconsistent(struct btrf=
s_fs_info *fs_info)
>>>>>    {
>>>>>           if (btrfs_qgroup_mode(fs_info) =3D=3D BTRFS_QGROUP_MODE_SI=
MPLE)
>>>>>                   return;
>>>>> +       if (!(fs_info->qgroup_flags & BTRFS_QGROUP_STATUS_FLAG_INCON=
SISTENT))
>>>>> +               btrfs_warn_rl(fs_info, "qgroup marked inconsistent")=
;
>>>>
>>>> About half the callers already log some message right before or right
>>>> after calling this function.
>>>> But this won't tell us much about why/where the qgroup was marked
>>>> inconsistent for all the other callers.
>>>>
>>>> Perhaps we can pass a string to this function and include it in the
>>>> warning message? And then remove the logging from all callers that do
>>>> it.
>>>> Additionally turning this into a macro, and then printing __FILE__ an=
d
>>>> __LINE__ too, would make it a lot more useful for debugging.
>>>
>>> If this is meant for debugging then the message level should be either
>>> debug or info, but not warn. If it's for user information then the fil=
e
>>> and line is not relevant.
>>>
>>> Otherwise agreed about printing the reason why it's marked inconsisten=
t.
>>>
>>
>> The message is to inform the end user that qgroup is marked
>> inconsistent, which is a common thing.
>>
>> It's not for error paths, thus filename and line is not really needed.
>>
>> And for the reason, there are really one or two (except error cases):
>>
>> - We're dropping a high subtree
>>     Either we queue the whole subtree for accounting, which is super sl=
ow
>>     and can hang the current transaction.
>>     Or we mark qgroup inconsistent and call it a day
>>
>> - We're doing snapshot where the source and destination have different
>>     parent qgroup
>>     The reason is pretty much the same as the above case.
>>
>> I can add the reason, but for most cases it will be the above two.
>>
>> In that case do we still really need such reason?
>=20
> It's a lot more friendly to have such a message telling why and what
> caused the inconsistent marking, both for users and for us analysing a
> dmesg dump.
>=20
> Those two cases may be the most common by far, but it's still good to
> look at a log message and be able to distinguish between every
> possible case.

Got it, will add the reason string (or reason enums?) for why the qgroup=
=20
is marked inconsistent.

Thanks for the feedback a lot,
Qu

>=20
> Thanks.
>=20
>>
>> Thanks,
>> Qu


