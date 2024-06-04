Return-Path: <linux-btrfs+bounces-5453-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FAAC8FBF14
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Jun 2024 00:38:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04B291F21650
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 Jun 2024 22:38:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A82B14B09F;
	Tue,  4 Jun 2024 22:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="QePTCk+I"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C89618651
	for <linux-btrfs@vger.kernel.org>; Tue,  4 Jun 2024 22:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717540702; cv=none; b=Fv9VC5WZXsfVhXklFLpGwDnnSwT8qnuFumXnLPNR8Beyqfir5VdmNmUD3upQRRIAKJuG4Zar49CRVFzk/pcf8dOleRMq5crqn9+m14EYoHj0eYnTQ7o0WbeiXLNEWt74d5rf7TbAWdDMO5ajhMgz6tFkIAO/kl/aSvDpNnhLP6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717540702; c=relaxed/simple;
	bh=bE8KMgQ+C/zuVbmGH4LMsABAlRDjFZGwRQ3hDrGIqhU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lExNAV+hrk++Zo1d8PLZK5bIsU8Nd6iBcH7rH5X/SJnujITg3xamIcXr4R683b4nJwn0WkiT7fOm2knXDjxkj9t6z/ucmtZ7XUvTbLWrb/MOXIeC1uNs1G44DlBdn8bHZm8v6dW29nNgcIKB/qaD9AxsHJU0JGHu9nbLUZ4YVcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=QePTCk+I; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1717540694; x=1718145494; i=quwenruo.btrfs@gmx.com;
	bh=cD/ZMHxBfsuDYtLL+rNxd2hUNfjqyrFLjOEW0KkuwM8=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=QePTCk+Ifb5GDO/HLZLXkTzB55s49hKqg2Oa9/pdF/q43I71blYEm22Ip/A8Sn9m
	 Ip8dlZl/a2gA3kxvXJIWpnSfZaY+uWVqcK5HWBaZ4WQxjCMW/cf6G+MqK202OdHtK
	 HV2kdVLNduSYqhv8SBoRBA1aGm0rWs1U/GW2KYrMYEEVCCxMJasOKpGGnUlixNjqG
	 YUX53g8x3vM7sIA+qxahePHUSrAcSxVYR/8x6w4wpNC74L0yc0QeTqPJ68eHveJCf
	 HQHleNp19PV+ZNg5SspGzobusn9+aTB2fGUpqHaPH0Nc08+aOPn80YmkkZNA5wItP
	 wfT05y3EwsfWfadUlw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.219] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mo6qp-1sp5DC2nX9-00paLE; Wed, 05
 Jun 2024 00:38:14 +0200
Message-ID: <2cb94cd9-2f37-4d93-8b76-8f41f6d8674e@gmx.com>
Date: Wed, 5 Jun 2024 08:08:09 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: fix leak of qgroup extent records after
 transaction abort
To: Filipe Manana <fdmanana@kernel.org>
Cc: linux-btrfs@vger.kernel.org
References: <0a4d66f6922f5219c7c8c37d88a919304abdbb55.1717416325.git.fdmanana@suse.com>
 <c445c0fb-7a61-4127-9281-13a7c84494a7@gmx.com>
 <CAL3q7H651tkJgzOOO3VU46oPs3N1x21kDww-V5xWH3URP6buaw@mail.gmail.com>
 <03ec8f07-12b4-420c-8153-e8c9cd288d79@gmx.com>
 <CAL3q7H5uKab2k+894+2sJmR2aZH-JsZ3pOE3WT2-anNg4qkqgA@mail.gmail.com>
Content-Language: en-US
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
Autocrypt: addr=quwenruo.btrfs@gmx.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNIlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT7CwJQEEwEIAD4CGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCY00iVQUJDToH
 pgAKCRDCPZHzoSX+qNKACACkjDLzCvcFuDlgqCiS4ajHAo6twGra3uGgY2klo3S4JespWifr
 BLPPak74oOShqNZ8yWzB1Bkz1u93Ifx3c3H0r2vLWrImoP5eQdymVqMWmDAq+sV1Koyt8gXQ
 XPD2jQCrfR9nUuV1F3Z4Lgo+6I5LjuXBVEayFdz/VYK63+YLEAlSowCF72Lkz06TmaI0XMyj
 jgRNGM2MRgfxbprCcsgUypaDfmhY2nrhIzPUICURfp9t/65+/PLlV4nYs+DtSwPyNjkPX72+
 LdyIdY+BqS8cZbPG5spCyJIlZonADojLDYQq4QnufARU51zyVjzTXMg5gAttDZwTH+8LbNI4
 mm2YzsBNBFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcga
 CbPEwhLj1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj
 /IrRUUka68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fN
 GSsRb+pKEKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0
 q1eW4Jrv0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEv
 ABEBAAHCwHwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCY00ibgUJDToHvwAK
 CRDCPZHzoSX+qK6vB/9yyZlsS+ijtsvwYDjGA2WhVhN07Xa5SBBvGCAycyGGzSMkOJcOtUUf
 tD+ADyrLbLuVSfRN1ke738UojphwkSFj4t9scG5A+U8GgOZtrlYOsY2+cG3R5vjoXUgXMP37
 INfWh0KbJodf0G48xouesn08cbfUdlphSMXujCA8y5TcNyRuNv2q5Nizl8sKhUZzh4BascoK
 DChBuznBsucCTAGrwPgG4/ul6HnWE8DipMKvkV9ob1xJS2W4WJRPp6QdVrBWJ9cCdtpR6GbL
 iQi22uZXoSPv/0oUrGU+U5X4IvdnvT+8viPzszL5wXswJZfqfy8tmHM85yjObVdIG6AlnrrD
In-Reply-To: <CAL3q7H5uKab2k+894+2sJmR2aZH-JsZ3pOE3WT2-anNg4qkqgA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:4M6YJ3rtje0e3FwlMMUWRN0OPevz80fYbogcUlSg6YlKGeTuZsM
 Syr9Gow/lymypg+7ZZF6Zij4LOOL8TApyXDR07i3LEI/5uXB65gadCY7sMZOLqouh+rE+fQ
 9VoxIxrNZK+r5dO1ghXdJozsdCZLwXelbZgYiztasqkYAYhsIH1fwofz7Zrn5+ueTsxfih2
 zoexRhkRM6E7Qwg48Rthg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:kERf6MaBA8E=;2HTsxjqkOWUGYRX7HylSHB5mfmn
 OY21N8rqYT55ylcAdFLcUwtjXoAX3TgB6nfQDdi2/7T5loH9t33s42ui9SwwuLoPj+x72LiNa
 L3U4lSqeArPDOue8fAoIf8aKaA3eCGGLktTzKI0uXHKijyNJjenPUkAcwFeOuxst4ApN+8fKi
 hjAETMbGnAYbef/WhV58/OmOLKp+vtGkI0IHb8HqAKEviHVKpgAon8T9xij6CO6+2yrIJwfwt
 iPW5lnYAtt+hHnir/0oDL+8QC1imVwz3W2i/np959Dr7tG/S/QaKOiPbSbCD+1JWAbbvScco1
 AeBOBsgghJi66m4c4l0P41KlifLmOchgEe5vmYK/RqLO337/j4l8KDLKkkb87OZbN/0WOuzdK
 YXVGCKyi4DCmyut6tqnrXXwaE718XR3WKM/oh6rhZAlXpKxqDPqzVzxzNF3TB7nmwYq9TLJfp
 IPkWVmrYOSDGsjJGEztddtoJO6SarYqFne4BvFIieMFufdBQdVi9Nd2ZzaZ4BHd/zNgTL3kte
 xSIV2ghZaBoDmIyjvC9GfgdDpFOdMfqr+JHJlmOCkRPDny1QCbbTopXK2GxjU2FiSdk7vYBAF
 RP+iwgRX7ewdTAdqaCHW6K4NB0YhE86DCvai9ZMc5J65p1hdp9xluJ/DHtPDg9KemDP7YYok0
 dKU8YSYb0Y+NP6lfJPzXBjS6pvJOvLOXrgthDArXxP3b4nH1iPw6i1orz99u1JwvbxCNBJ4AF
 UPRx/M9a99l4KQyLz8GrWbAE9qxUFLbFre4a+FAx36E2HaWvCkxN5OgbqFN2WpP8o85ZMFVIt
 jsFVGwtyxcaNKVpyoQkGHUMxciX2vhMSaMF22P/i9jNh0=



=E5=9C=A8 2024/6/4 08:58, Filipe Manana =E5=86=99=E9=81=93:
> On Tue, Jun 4, 2024 at 12:21=E2=80=AFAM Qu Wenruo <quwenruo.btrfs@gmx.co=
m> wrote:
[...]
>>
>> I'd prefer to call btrfs_qgroup_destory_extent_records() inside the "if
>> (atomic_read() =3D=3D 0)" branch to be a little more easier to read.
>> But it's only a preference.
>
> Maybe it makes the diff more immediate to understand.
> But the final code is certainly less verbose and clear enough:
>
> while ((node =3D rb_first_cached(&delayed_refs->href_root)) !=3D NULL) {
>      (...)
> }
> btrfs_qgroup_destroy_extent_records(trans);
>
> As opposed to:
>
> if (atomic_read(&delayed_refs->num_entries) =3D=3D 0) {
>      btrfs_qgroup_destroy_extent_records(trans);
>      spin_unlock(&delayed_refs->lock);
>      return;
> }
>
> while ((node =3D rb_first_cached(&delayed_refs->href_root)) !=3D NULL) {
>      (...)
> }
> btrfs_qgroup_destroy_extent_records(trans);
>
>
> More code for absolutely nothing, not even better readability.

It looks like I'm still tending to do empty check, other than let the
loop to  handle empty cases.

And indeed the extra empty check is only going to bloat the code without
much need, and I should change my tendency.

Forgot to give a reviewed by tag:

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
>
>
>>
>> Thanks,
>> Qu
>>
>>>
>>>>
>>>> Thanks,
>>>> Qu
>>>>>
>>>>> Reported-by: syzbot+0fecc032fa134afd49df@syzkaller.appspotmail.com
>>>>> Link: https://lore.kernel.org/linux-btrfs/0000000000004e7f980619f918=
35@google.com/
>>>>> Signed-off-by: Filipe Manana <fdmanana@suse.com>
>>>>> ---
>>>>>     fs/btrfs/disk-io.c | 10 +---------
>>>>>     1 file changed, 1 insertion(+), 9 deletions(-)
>>>>>
>>>>> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
>>>>> index 8693893744a0..b1daaaec0614 100644
>>>>> --- a/fs/btrfs/disk-io.c
>>>>> +++ b/fs/btrfs/disk-io.c
>>>>> @@ -4522,18 +4522,10 @@ static void btrfs_destroy_delayed_refs(struc=
t btrfs_transaction *trans,
>>>>>                                        struct btrfs_fs_info *fs_info=
)
>>>>>     {
>>>>>         struct rb_node *node;
>>>>> -     struct btrfs_delayed_ref_root *delayed_refs;
>>>>> +     struct btrfs_delayed_ref_root *delayed_refs =3D &trans->delaye=
d_refs;
>>>>>         struct btrfs_delayed_ref_node *ref;
>>>>>
>>>>> -     delayed_refs =3D &trans->delayed_refs;
>>>>> -
>>>>>         spin_lock(&delayed_refs->lock);
>>>>> -     if (atomic_read(&delayed_refs->num_entries) =3D=3D 0) {
>>>>> -             spin_unlock(&delayed_refs->lock);
>>>>> -             btrfs_debug(fs_info, "delayed_refs has NO entry");
>>>>> -             return;
>>>>> -     }
>>>>> -
>>>>>         while ((node =3D rb_first_cached(&delayed_refs->href_root)) =
!=3D NULL) {
>>>>>                 struct btrfs_delayed_ref_head *head;
>>>>>                 struct rb_node *n;
>

