Return-Path: <linux-btrfs+bounces-18927-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 246B6C54E46
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Nov 2025 01:22:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B351D3A29E7
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Nov 2025 00:22:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FD873E47B;
	Thu, 13 Nov 2025 00:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="rp5vEMF4"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 115C035CBC1
	for <linux-btrfs@vger.kernel.org>; Thu, 13 Nov 2025 00:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762993327; cv=none; b=i0xLITv19HhunzgLcK410vv95tUrGCrnkXrFruXEhLdy97WTQiI5gDanA6+RgLIdkDxzZ7QDZQh2jTVyMh/Ri+noyGUKbERuhICMbhniVKOvEq1ovKZakJaRINmmWQpkgyjACrWPAMGsp8Bpi9ymx9H+F6sAxbGDy968dPRkN7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762993327; c=relaxed/simple;
	bh=/fKWTN/11H0iK1+nFiUZuBo+ceKG84EnkxUJeC11OF0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KDGxWXZflGijA333tEsm/05mbjKqHLArxWoRXREX8ZhiLn1HptbxzZSEV8j9AOvOM84LZJ+udIf8UBAzmKrpN5h5tegsu/e2prMgvBxCJO2KoTkH5ez1yu4LG+upuwOOanAvPFU2LCCyv0rM36ru0Rn2b9xJ9JUfPvm3WESC2LE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=rp5vEMF4; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1762993322; x=1763598122; i=quwenruo.btrfs@gmx.com;
	bh=I/Ttds9kezZjOKit1glbq30NFQmvdo9mlwG5NJudcsc=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=rp5vEMF4u3Vz/n0TgDqqCH0bGdP6E7J4kGkSHJ4R1ygu+aKNpTIcdrF1Cgq4TvMf
	 2P4QT+v/uvH8Ecxmkyetb9TaTlI9EKsa/4DjjrQUsnm6pyHtxABf/NxI/J3A0x9ky
	 r/9297EkE/c6tRppfZ4r9sQDRcO1ulbSLX+ihAlcH3GOftTwDpqzjpzBYhM3h3rOV
	 GfTGXqYj7bk8+pXDfGq+P9FCGMKhhewc7fiJ2BmQM+Q7RCBHTf8wA6XRvhqsF43/A
	 iN2wiEwfkiuCCrcMKdXF4U08KRGFV91nTr/g/jHsBQ7l7oJavQf4XVNVX+DVp0q/3
	 fI5n/PEEI0xmzBWo2A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mqs0X-1vwma034uf-00eNM1; Thu, 13
 Nov 2025 01:22:02 +0100
Message-ID: <86dfdcb3-5a7e-4f4e-8630-696994d07877@gmx.com>
Date: Thu, 13 Nov 2025 10:51:59 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 7/7] btrfs: introduce btrfs_bio::async_csum
To: Daniel Vacek <neelx@suse.com>, Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
References: <cover.1761715649.git.wqu@suse.com>
 <2b4ff4103f157ffd2d7206a413246990b3ef2746.1761715650.git.wqu@suse.com>
 <CAPjX3FdaDTXcP3v52tofjwhByYnN6Rc4PQ257hz7PFvu4zh9Fw@mail.gmail.com>
 <c6252c65-5106-45e6-b75a-dab09e4faa52@suse.com>
 <CAPjX3FfY+Ov5sksn+e7hEFbUTWf8ROs6RNEj4-_1iwgx1xfD8w@mail.gmail.com>
 <a18a5937-a1c2-41a4-9261-5b337ccbfbf2@suse.com>
 <CAPjX3FfKhYfWd00m-3VMqSE4v-tJYePfE-A3G3cCjTx7F+B3Vg@mail.gmail.com>
 <c4d28607-702b-4817-ad94-2d52d529e344@suse.com>
 <CAPjX3FewjQqUi7pW4egmN5xvpxh5_RS-tT+_d9K6OK2DMn=PBA@mail.gmail.com>
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
In-Reply-To: <CAPjX3FewjQqUi7pW4egmN5xvpxh5_RS-tT+_d9K6OK2DMn=PBA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:QWgrdLVcF96rkOl8MpagU0ltyWCdRu0mlnSL+WhvvTU9Z7RGU68
 9RsKb5J4imrl9HgpaRyCGWaA2rNN5fVYXN7i85OVNU9/5NbZP/tq4BqdQ4824dPBJmTl9Gr
 VIp+53iWYfNbtK7nY8AWZYQjrGxMpfEf0UwF98cp0mlIFOisPKrtbx9GI/3p4YGyYb4EszE
 pI4Xt9U6lGSAobv9tT+OQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:C/ydy1MYdzA=;bMXXv5zxbUmlcqIEJ4y7m0F5PDG
 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



=E5=9C=A8 2025/11/13 08:13, Daniel Vacek =E5=86=99=E9=81=93:
[...]
>>>>>
>>>>> queue_work(btrfs_end_io_wq(fs_info, bio), &bbio->csum_work);
>>>>
>>>> Nope, I even created a new workqueue for the csum work, and it doesn'=
t
>>>> workaround the workqueue dependency check.
>>>
>>> Did you create it with the WQ_MEM_RECLAIM flag? As like:
>>>
>>> alloc_workqueue("btrfs-async-csum", ... | WQ_MEM_RECLAIM, ...);
>>
>> Yes.
>>
>>>
>>> I don't see how that would trigger the warning. See below for a
>>> detailed explanation.
>>
>> It's not the workqueue running the csum work, but the workqueue running
>> the flush_work().
>=20
> The wq running the flush_work() is in the warning condition. *But* the
> early return checks the csum wq.
>=20
>>>
>>>> The check inside check_flush_dependency() is:
>>>>
>>>>            WARN_ONCE(worker && ((worker->current_pwq->wq->flags &
>>>>                                  (WQ_MEM_RECLAIM | __WQ_LEGACY)) =3D=
=3D
>>>> WQ_MEM_RECLAIM),
>>>>
>>>> It means the worker can not have WQ_MEM_RECLAIM flag at all. (unless =
it
>>>> also has the LEGACY flag)
>>>
>>> I understand that if the work is queued on a wq with WQ_MEM_RECLAIM,
>>> the check_flush_dependency() returns early. Hence no need to worry
>>> about the warning's condition as it's no longer of any concern.
>>
>> You can just try to use flush_work() and test it by yourself.
>>
>> I have tried my best to explain it, but it looks like it's at my limit.
>>
>> Just try a patch removing the csum_wait, and use flush_work() instead o=
f
>> wait_for_completion().
>>
>> Then you'll see the problem I'm hitting.
>=20
> No luck. With the change below all fstests pass without any warning or
> deadlocks whatsoever. Just as I expected.
> I don't think there would be any impact on performance, but that needs
> to be tested and confirmed.
>=20
> diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
> index aba452dd9904..02b40d6fa13f 100644
> --- a/fs/btrfs/bio.c
> +++ b/fs/btrfs/bio.c
> @@ -108,7 +108,8 @@ void btrfs_bio_end_io(struct btrfs_bio *bbio,
> blk_status_t status)
>          ASSERT(in_task());
>=20
>          if (bbio->async_csum)
> -               wait_for_completion(&bbio->csum_done);
> +               flush_work(&bbio->csum_work);
>=20
>          bbio->bio.bi_status =3D status;
>          if (bbio->bio.bi_pool =3D=3D &btrfs_clone_bioset) {
> diff --git a/fs/btrfs/bio.h b/fs/btrfs/bio.h
> index 5015e327dbd9..11eb8bcab94d 100644
> --- a/fs/btrfs/bio.h
> +++ b/fs/btrfs/bio.h
> @@ -58,7 +58,7 @@ struct btrfs_bio {
>                          struct btrfs_ordered_extent *ordered;
>                          struct btrfs_ordered_sum *sums;
>                          struct work_struct csum_work;
> -                       struct completion csum_done;
>                          struct bvec_iter csum_saved_iter;
>                          u64 orig_physical;
> diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
> index d2ecd26727ac..f69fa943d3e0 100644
> --- a/fs/btrfs/file-item.c
> +++ b/fs/btrfs/file-item.c
> @@ -790,7 +790,15 @@ static void csum_one_bio_work(struct work_struct *w=
ork)
>          ASSERT(btrfs_op(&bbio->bio) =3D=3D BTRFS_MAP_WRITE);
>          ASSERT(bbio->async_csum =3D=3D true);
>          csum_one_bio(bbio, &bbio->csum_saved_iter);
> -       complete(&bbio->csum_done);
> +}
> +
> +static struct workqueue_struct *btrfs_end_io_wq(struct btrfs_fs_info *f=
s_info,
> +                                                struct bio *bio)
> +{
> +       if (bio->bi_opf & REQ_META)
> +               return fs_info->endio_meta_workers;
> +       return fs_info->endio_workers;

For btrfs_csum_one_bio() it's definitely data IO, thus you can go with=20
endio_workers directly.
>   }
>=20
>   /*
> @@ -823,12 +831,13 @@ int btrfs_csum_one_bio(struct btrfs_bio *bbio, boo=
l async)
>                  csum_one_bio(bbio, &bbio->bio.bi_iter);
>                  return 0;
>          }
> -       init_completion(&bbio->csum_done);
>          bbio->async_csum =3D true;
>          bbio->csum_saved_iter =3D bbio->bio.bi_iter;
>          INIT_WORK(&bbio->csum_work, csum_one_bio_work);
> -       schedule_work(&bbio->csum_work);
> +       queue_work(btrfs_end_io_wq(fs_info, bio), &bbio->csum_work);

This is the what causing the difference, that you're calling=20
flush_work() inside the same workqueue, at least for most cases.

However I'm still not 100% sure if it's fine, as for RAID56 the endio=20
function is called inside rmw_workers, not the same as the regular=20
endio_workers, causing the same cross-wq flush_work() call, which can=20
still lead to the warning.

Personally speaking I'd prefer not to bother the cross-wq situations for=
=20
flush_work() for now, which is a completely new rabbit hole.

Feel free to send out a dedicated patch removing btrfs_bio::csum_done,=20
and we can continue the discussion there.

Thanks,
Qu

>          return 0;
>   }
>=20
>> Thanks,
>> Qu
>>
>>>
>>>> So nope, the flush_work() idea won't work inside any current btrfs
>>>> workqueue, which all have WQ_MEM_RECLAIM flag set.
>>>
>>> With the above being said, I still see two possible solutions.
>>> Either using the btrfs_end_io_wq() as suggested before. It should be s=
afe, IMO.
>>> Or, if you're still worried about possible deadlocks, creating a new
>>> dedicated wq which also has the WQ_MEM_RECLAIM set (which is needed
>>> for compatibility with the context where we want to call the
>>> flush_work()).
>>>
>>> Both ways could help getting rid of the completion in btrfs_bio, which
>>> is 32 bytes by itself.
>>>
>>> What do I miss?
>>>
>>> Out of curiosity, flush_work() internally also uses completion in
>>> pretty much exactly the same way as in this patch, but it's on the
>>> caller's stack (in this case on the stack which would call the
>>> btrfs_bio_end_io() modified with flush_work()). So in the end the
>>> effect would be like moving the completion from btrfs_bio to a stack.
>>>
>>>> What we need is to make endio_workers and rmw_workers to get rid of
>>>> WQ_MEM_RECLAIM, but that is a huge change and may not even work.
>>>>
>>>> Thanks,
>>>> Qu
>>>>
>>>>>
>>>>>> I'll keep digging to try to use flush_work() to remove the csum_don=
e, as
>>>>>> that will keep the size of btrfs_bio unchanged.
>>>>>>
>>>>>> Thanks,
>>>>>> Qu
>>>>>>
>>>>>>>
>>>>>>> --nX
>>>>>>>
>>>>>>
>>>>>>>>
>>>>>>
>>>>
>>
>=20


