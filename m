Return-Path: <linux-btrfs+bounces-5428-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CED938FA65A
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 Jun 2024 01:21:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60F1E1F2148C
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Jun 2024 23:21:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5F9D83CB9;
	Mon,  3 Jun 2024 23:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="DZ08Zyy3"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C02FC3E49E
	for <linux-btrfs@vger.kernel.org>; Mon,  3 Jun 2024 23:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717456901; cv=none; b=Y5511s2Sx0Ajle8ev3kvABgin6q74nxFqm5R5pFdBLyrUayNDYyU2HxiG5DcSSl0OJRya85mVUHTieItSs4MGKsqQVL1A7ne+HOl54zlgXMpRkKNq5pZTngBVvoI7FCAkmUeB4EsyL09owwt0ztYU+XoIvstGaunfHLYNcukI9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717456901; c=relaxed/simple;
	bh=QoXn/gBPTzgvnEtqTsgwgxA5dpo6qoRJr0vYAACRl78=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bJgjEmDHHtjhgFfDZ3hQ310WdqLHDcQWumFNF1zqFzHlLJNHP5qWi2iU7+0yYj15RViIqzV9TgKyPBtsKwi34zJgZU/+22uWMh7x8hl6h4glhWi9q0WMGVN96PTuZ2+rTy+WkjJf8SvRVyyGzBouuvKrWtYL9Rnfj2Z1Mux9nL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=DZ08Zyy3; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1717456892; x=1718061692; i=quwenruo.btrfs@gmx.com;
	bh=9kXYEEIUF8qwWpO+3akRbIUlyOrNN57fLcsXgUcSqIA=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=DZ08Zyy3lVuS+CNcgqdwdqLgs2naV8JBJ3Hi1QM9E6iLuIhwDl/K49muvEzwlpUD
	 MLeqUDG5SrL2Y6Q1v0JHaVGgvpbj8NB1fSQFinQQPOM6kfove+5GJduY7IvLELyuY
	 iA8PlzJkGHhGh1AWy7IxigkQBY533bgdL3YpO7autdRfdM2Jtmn7QWIgt6F3ZQnMs
	 bDeyatzOqz0PLURd13vjqB6fbuBCjJEhrZP779/sWlPja0G+RtiHwJkA5ViHCN3oG
	 vXbvWtaq+V5c2M7OOD3KpnWqZxl/tyhzs+tkb/ulx1svPLyxY9UHN7XeFz1D4Ix0z
	 9NUo0tGEFjw7q+YGVA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.219] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mzyyk-1sPtvB2g9G-00x6m5; Tue, 04
 Jun 2024 01:21:32 +0200
Message-ID: <03ec8f07-12b4-420c-8153-e8c9cd288d79@gmx.com>
Date: Tue, 4 Jun 2024 08:51:28 +0930
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
In-Reply-To: <CAL3q7H651tkJgzOOO3VU46oPs3N1x21kDww-V5xWH3URP6buaw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:UBeRvboPA8Ng/l0rqWd0uUO9Lqq7gurdkstsjD7ERx8Dsjd1I1b
 Nxg9oVnuijoMfo2Skng5vujdA1ePQOszU1R238lDOEWUcwrpZWTdHWy6lt0DE/ZaHCXUS37
 8LfxBi5Zc0qlZu9KOMJ2L06/IdnP5ofsLFWcZT0rVATrgLta1GolVuEeaLHyreRjnbQBwvP
 KvLJvo9lLLQWmeyNC3Hvg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:mZTgL20ZLDw=;6OkhfGwfFSurcNbsnyLV4qK+Bbb
 IjQQjw2XTOcsRaF/YZD1dDLaUqTlq+g+e+n0PhtOjalME4m03zcrHoWP8ZQ9PlgMYpPQXOWcA
 f0EIR/3K3Y7bI38iJyzh6yVQbq4h8GOUQp7aM0g2uecPK6xjwUNR3wqGyDXDrFVrw/RTl2LY0
 HSzlhrk1SPYfUX2fVvaQvuCznlv2aG97o1m+TP4Q1meGh4H6JrCzZVJjES10WD9WZrwUjOcWI
 76OhwO5vyMZWvoP22M4YRcyhtP8mGj5De4ehA4Qo8cmKo6g84tc9wn6B/9uZObnzsOSGdxHwX
 aoo2/u6cXe04GRDv2t0LPCuMqYP+nC+Fom5Vt9HQm7+UHovWFqkTSoRvgtpUzblGQ6d35mlYQ
 e0BvxaenYqrc9lJ8u0TzGjKQVbOOUSIjSQICkWZTCYEczL5epkf/8yLw9NbKKh0KugpVhoizM
 jwGGzLunZyPdyKjkvR1BgM6WuHd1UKkEGI4Sla0ADPz0szkT68FlxpClwX5XfYwVvIW06Qehc
 Ecekfj+Q/h3Fw6c++lajHIeFbwbg7KUUcazR3onn1m3G75hrHOC1Xed46bUzhegNOgRbvC+HK
 oBK6c4WAb2Kq8kJzcw5PCDECABoC28Q8syFVwItnB7hvyjVvDJ5IpfU81P+DQRYNEG/BElPOp
 aTGULuA+fnG2Xako+k9v8InodPv/UPm0OZD7qGRgRtDZuPC6CN57cTxrrbPWByyx5buTHHONw
 kFhTfybOYtfN0b7th9QXZw8ryQd/Ixvc0OBJMbVFmiTGSqjCp5N1zVCix30zd/RRJyapTV+SY
 kywaF3Dd3yFnYCAwBf/L+RTKfVPh5gFnUmOqriD9siGb4=



=E5=9C=A8 2024/6/4 08:39, Filipe Manana =E5=86=99=E9=81=93:
> On Mon, Jun 3, 2024 at 11:58=E2=80=AFPM Qu Wenruo <quwenruo.btrfs@gmx.co=
m> wrote:
[...]
>>> We can currently have no delayed references because we ran them all
>>> during a transaction commit and the transaction was aborted after that
>>> due to some error in the commit path.
>>>
>>> So fix this by ensuring we btrfs_qgroup_destroy_extent_records() at
>>> btrfs_destroy_delayed_refs() even if we don't have any delayed referen=
ces.
>>
>> Will it cause some underflow for delayed_refs->num_entries?
>>
>> As in the rb tree iteration code, we would try to decrease
>> delayed_refs->num_entries again.
>
> What underflow, where?
>
> btrfs_qgroup_destroy_extent_records() doesn't do anything to the
> counter (or delayed refs).
>
> Or are you seeing that delayed_refs->num_entries can be 0 while the
> delayed_refs->href_root rb tree is not empty?
> How is that possible?

Never mind, I was originally referring to the "atomic_dec()" call inside
"while ((n =3D rb_first_cached())" loop.

But btrfs_run_delayed_refs_for_head() has ensured the entry is properly
removed from ref_tree before decreasing the "delayed_refs->num_entries",
it should be safe.

I'd prefer to call btrfs_qgroup_destory_extent_records() inside the "if
(atomic_read() =3D=3D 0)" branch to be a little more easier to read.
But it's only a preference.

Thanks,
Qu

>
>>
>> Thanks,
>> Qu
>>>
>>> Reported-by: syzbot+0fecc032fa134afd49df@syzkaller.appspotmail.com
>>> Link: https://lore.kernel.org/linux-btrfs/0000000000004e7f980619f91835=
@google.com/
>>> Signed-off-by: Filipe Manana <fdmanana@suse.com>
>>> ---
>>>    fs/btrfs/disk-io.c | 10 +---------
>>>    1 file changed, 1 insertion(+), 9 deletions(-)
>>>
>>> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
>>> index 8693893744a0..b1daaaec0614 100644
>>> --- a/fs/btrfs/disk-io.c
>>> +++ b/fs/btrfs/disk-io.c
>>> @@ -4522,18 +4522,10 @@ static void btrfs_destroy_delayed_refs(struct =
btrfs_transaction *trans,
>>>                                       struct btrfs_fs_info *fs_info)
>>>    {
>>>        struct rb_node *node;
>>> -     struct btrfs_delayed_ref_root *delayed_refs;
>>> +     struct btrfs_delayed_ref_root *delayed_refs =3D &trans->delayed_=
refs;
>>>        struct btrfs_delayed_ref_node *ref;
>>>
>>> -     delayed_refs =3D &trans->delayed_refs;
>>> -
>>>        spin_lock(&delayed_refs->lock);
>>> -     if (atomic_read(&delayed_refs->num_entries) =3D=3D 0) {
>>> -             spin_unlock(&delayed_refs->lock);
>>> -             btrfs_debug(fs_info, "delayed_refs has NO entry");
>>> -             return;
>>> -     }
>>> -
>>>        while ((node =3D rb_first_cached(&delayed_refs->href_root)) !=
=3D NULL) {
>>>                struct btrfs_delayed_ref_head *head;
>>>                struct rb_node *n;

