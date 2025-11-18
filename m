Return-Path: <linux-btrfs+bounces-19113-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DDD9CC6BAE2
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Nov 2025 22:05:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1D8034E3894
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Nov 2025 21:05:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2FF82F6590;
	Tue, 18 Nov 2025 21:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="TrScWkv5"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 880D61898F8;
	Tue, 18 Nov 2025 21:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763499916; cv=none; b=BHCnPtoxMzcfzzXTwpDPLV4xjK93PxgSjiKma2i4tNib5tkVtkivtp7vAhCKcttBsQLnaUk0x2YZQQCXO/KgRjIGwi42Li2IIGdaCjqyh6Wcrgy7QsNEvZA9CdIeH2DrS+wIiAIyCMmUG9uQCNn30H0c4qa9CFS6Zn7l81Ke4gU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763499916; c=relaxed/simple;
	bh=tBXclvDOXaCrToxgM3o9myev9MY2XcTjp9ecL8+hFp4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jV1YtF3ORhC0Lpvst399bZM6XAPP1F1tGVcH4pQ1BIZzRevc7Gk18ZO2imX730s6SljJuSK1pKqtp+TqPW6SdTRPE0/HPvkD7+OGVQAFOsK1xQ0vLbn65DDGmstwVBdrXwA8KJP+RfDKdCSaSs1kJNEjXbieBUgBRiWsyPU2bYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=TrScWkv5; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1763499910; x=1764104710; i=quwenruo.btrfs@gmx.com;
	bh=GEPCBVVNNAPLDX1w1Zs3k3N+A9uPEMnY4P9mTWPw4bg=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=TrScWkv5jlCvzbsP944QxUxfFi+dxfT0iow3NuG34SdrXKJFyusnu9Z9jijMAL5S
	 ZR3PPZB1deXyAryKkyZ7ofVzza2POvJc7enFe14pX8T6uD1/za8A60SQlrXmNOg55
	 SEoO16bne5cczeHTQWC9DlKxpDbQBBbflGnxgH+arLGBe2DfFx0e1QjoB/CHDFwWw
	 MzsbtMLcLSRRUC02DMGFC1sCe+QKN2gSIpBWZg1QCL9fsh7fJrZnhIMtz8SXKZl8w
	 2zvhvnXY2kqPxGkTXa+V3IPTcohGA6uGZas/azivuYnGXFzG0Bz3JEU7xfDd+lkvp
	 wk9+Jql59fshgWOH+A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MAfYm-1vS5fR1m1o-0036ci; Tue, 18
 Nov 2025 22:05:09 +0100
Message-ID: <84128576-17f4-460a-9d2f-9e40f43f2ef7@gmx.com>
Date: Wed, 19 Nov 2025 07:35:04 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 3/8] btrfs: add a bio argument to btrfs_csum_one_bio
To: Daniel Vacek <neelx@suse.com>, Qu Wenruo <wqu@suse.com>
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
 David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20251112193611.2536093-1-neelx@suse.com>
 <20251112193611.2536093-4-neelx@suse.com>
 <7de34b24-f189-402a-98f9-83e595b53244@suse.com>
 <CAPjX3FfMaOWtCZ8mjVTbBQ9yt0O-mAistyDsVq7Q1aR-65R_hA@mail.gmail.com>
 <492ac26f-5eb4-49bf-855a-11f021d9e937@suse.com>
 <CAPjX3Fec=qAtWjPNvszKdww=giCUEgoMULc1Zvd37k03VUaUmw@mail.gmail.com>
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
In-Reply-To: <CAPjX3Fec=qAtWjPNvszKdww=giCUEgoMULc1Zvd37k03VUaUmw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:4vrbjR+ojvxK97XDcjxJeCtj3V3MlFdwBPq6g7EZAlqvvmD2k3c
 Ot6jFP3T4SocfsMuzV103256Ver/G0o3HPoTLY8ZQhY9PHy5SxtpQmvkYE1DeIu8EFP/Aj5
 DHRag+T4bPJBEAfkZ+I9VupQmGYXHvOk6XDxnbZxu4UB9PmumEihc6dbZOFchva5QUBodui
 7MTOiJp2VFXZNwgiGREig==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:IjNWd+mRNlY=;J/S7y5IdBPhTroYyOyycj5eaRfS
 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
 js8qIifuMY3cKLzzk=



=E5=9C=A8 2025/11/19 00:35, Daniel Vacek =E5=86=99=E9=81=93:
> On Thu, 13 Nov 2025 at 21:16, Qu Wenruo <wqu@suse.com> wrote:
[...]
>> Then why put the original bio pointer into the super generic btrfs_bio?
>=20
> When encryption is enabled, it's not going to be the original bio but
> rather the encrypted one.
>=20
> But giving it another thought and checking the related fscrypt code,
> the encrypted bio is allocated in  blk_crypto_fallback_encrypt_bio()
> and freed in blk_crypto_fallback_encrypt_endio() before calling
> bio_endio() on our original plaintext bio.
> This means we have no control over the bounce bio lifetime and we
> cannot store the pointer and use it asynchronously.

Sorry I didn't get the point why we can not calculate the csum async.

Higher layer just submit a btrfs_bio, its content is the encrypted content=
s.

As long as it's still a btrfs_bio, we have all the needed structures to=20
do async csum.
We still need to submit the bio for writes, and that means we have=20
enough time to calculate the csum async, and before the endio function=20
called, we're able to do whatever we need, the bio won't be suddenly=20
gone during the submission.

Unless you mean the encrypted bio is not encapsulated by btrfs_bio, but=20
a vanilla bio.

In that case you can not even submit it through btrfs_submit_bbio().

Thanks,
Qu

> We'll need to
> always compute the checksum synchronously for encrypted bios. In that
> case we don't need to store it in btrfs_bio::csum_bio at all. For the
> regular (unencrypted) case we can keep using the &bbio->bio.
>=20
> I'll drop the csum_bio for there is no use really.
>=20
> --nX
>=20
>> I thought it's more common to put the original plaintext into the
>> encryption specific structure, like what we did for compression.
>>
>> Thanks,
>> Qu
>>
>>>
>>> --nX
>>>
>>>> The storage layer doesn't need to bother the plaintext bio at all, th=
ey
>>>> just write the encrypted one to disk.
>>>>
>>>> And it's the dm-crypto tracking the plaintext bio <-> encrypted bio m=
apping.
>>>>
>>>>
>>>> So why we can not just create a new bio for the final csum caculation=
,
>>>> just like compression?
>>>>
>>>> Thanks,
>>>> Qu
>>>>
>>>>>
>>>>> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
>>>>> Signed-off-by: Daniel Vacek <neelx@suse.com>
>>>>> ---
>>>>> Compared to v5 this needed to adapt to recent async csum changes.
>>>>> ---
>>>>>     fs/btrfs/bio.c       |  4 ++--
>>>>>     fs/btrfs/bio.h       |  1 +
>>>>>     fs/btrfs/file-item.c | 17 ++++++++---------
>>>>>     fs/btrfs/file-item.h |  2 +-
>>>>>     4 files changed, 12 insertions(+), 12 deletions(-)
>>>>>
>>>>> diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
>>>>> index a73652b8724a..a69174b2b6b6 100644
>>>>> --- a/fs/btrfs/bio.c
>>>>> +++ b/fs/btrfs/bio.c
>>>>> @@ -542,9 +542,9 @@ static int btrfs_bio_csum(struct btrfs_bio *bbio=
)
>>>>>         if (bbio->bio.bi_opf & REQ_META)
>>>>>                 return btree_csum_one_bio(bbio);
>>>>>     #ifdef CONFIG_BTRFS_EXPERIMENTAL
>>>>> -     return btrfs_csum_one_bio(bbio, true);
>>>>> +     return btrfs_csum_one_bio(bbio, &bbio->bio, true);
>>>>>     #else
>>>>> -     return btrfs_csum_one_bio(bbio, false);
>>>>> +     return btrfs_csum_one_bio(bbio, &bbio->bio, false);
>>>>>     #endif
>>>>>     }
>>>>>
>>>>> diff --git a/fs/btrfs/bio.h b/fs/btrfs/bio.h
>>>>> index deaeea3becf4..c5a6c66d51a0 100644
>>>>> --- a/fs/btrfs/bio.h
>>>>> +++ b/fs/btrfs/bio.h
>>>>> @@ -58,6 +58,7 @@ struct btrfs_bio {
>>>>>                         struct btrfs_ordered_sum *sums;
>>>>>                         struct work_struct csum_work;
>>>>>                         struct completion csum_done;
>>>>> +                     struct bio *csum_bio;
>>>>>                         struct bvec_iter csum_saved_iter;
>>>>>                         u64 orig_physical;
>>>>>                 };
>>>>> diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
>>>>> index 72be3ede0edf..474949074da8 100644
>>>>> --- a/fs/btrfs/file-item.c
>>>>> +++ b/fs/btrfs/file-item.c
>>>>> @@ -765,21 +765,19 @@ int btrfs_lookup_csums_bitmap(struct btrfs_roo=
t *root, struct btrfs_path *path,
>>>>>         return ret;
>>>>>     }
>>>>>
>>>>> -static void csum_one_bio(struct btrfs_bio *bbio, struct bvec_iter *=
src)
>>>>> +static void csum_one_bio(struct btrfs_bio *bbio, struct bio *bio, s=
truct bvec_iter *iter)
>>>>>     {
>>>>>         struct btrfs_inode *inode =3D bbio->inode;
>>>>>         struct btrfs_fs_info *fs_info =3D inode->root->fs_info;
>>>>>         SHASH_DESC_ON_STACK(shash, fs_info->csum_shash);
>>>>> -     struct bio *bio =3D &bbio->bio;
>>>>>         struct btrfs_ordered_sum *sums =3D bbio->sums;
>>>>> -     struct bvec_iter iter =3D *src;
>>>>>         phys_addr_t paddr;
>>>>>         const u32 blocksize =3D fs_info->sectorsize;
>>>>>         int index =3D 0;
>>>>>
>>>>>         shash->tfm =3D fs_info->csum_shash;
>>>>>
>>>>> -     btrfs_bio_for_each_block(paddr, bio, &iter, blocksize) {
>>>>> +     btrfs_bio_for_each_block(paddr, bio, iter, blocksize) {
>>>>>                 btrfs_calculate_block_csum(fs_info, paddr, sums->sum=
s + index);
>>>>>                 index +=3D fs_info->csum_size;
>>>>>         }
>>>>> @@ -791,19 +789,18 @@ static void csum_one_bio_work(struct work_stru=
ct *work)
>>>>>
>>>>>         ASSERT(btrfs_op(&bbio->bio) =3D=3D BTRFS_MAP_WRITE);
>>>>>         ASSERT(bbio->async_csum =3D=3D true);
>>>>> -     csum_one_bio(bbio, &bbio->csum_saved_iter);
>>>>> +     csum_one_bio(bbio, bbio->csum_bio, &bbio->csum_saved_iter);
>>>>>         complete(&bbio->csum_done);
>>>>>     }
>>>>>
>>>>>     /*
>>>>>      * Calculate checksums of the data contained inside a bio.
>>>>>      */
>>>>> -int btrfs_csum_one_bio(struct btrfs_bio *bbio, bool async)
>>>>> +int btrfs_csum_one_bio(struct btrfs_bio *bbio, struct bio *bio, boo=
l async)
>>>>>     {
>>>>>         struct btrfs_ordered_extent *ordered =3D bbio->ordered;
>>>>>         struct btrfs_inode *inode =3D bbio->inode;
>>>>>         struct btrfs_fs_info *fs_info =3D inode->root->fs_info;
>>>>> -     struct bio *bio =3D &bbio->bio;
>>>>>         struct btrfs_ordered_sum *sums;
>>>>>         unsigned nofs_flag;
>>>>>
>>>>> @@ -822,12 +819,14 @@ int btrfs_csum_one_bio(struct btrfs_bio *bbio,=
 bool async)
>>>>>         btrfs_add_ordered_sum(ordered, sums);
>>>>>
>>>>>         if (!async) {
>>>>> -             csum_one_bio(bbio, &bbio->bio.bi_iter);
>>>>> +             struct bvec_iter iter =3D bio->bi_iter;
>>>>> +             csum_one_bio(bbio, bio, &iter);
>>>>>                 return 0;
>>>>>         }
>>>>>         init_completion(&bbio->csum_done);
>>>>>         bbio->async_csum =3D true;
>>>>> -     bbio->csum_saved_iter =3D bbio->bio.bi_iter;
>>>>> +     bbio->csum_bio =3D bio;
>>>>> +     bbio->csum_saved_iter =3D bio->bi_iter;
>>>>>         INIT_WORK(&bbio->csum_work, csum_one_bio_work);
>>>>>         schedule_work(&bbio->csum_work);
>>>>>         return 0;
>>>>> diff --git a/fs/btrfs/file-item.h b/fs/btrfs/file-item.h
>>>>> index 5645c5e3abdb..d16fd2144552 100644
>>>>> --- a/fs/btrfs/file-item.h
>>>>> +++ b/fs/btrfs/file-item.h
>>>>> @@ -64,7 +64,7 @@ int btrfs_lookup_file_extent(struct btrfs_trans_ha=
ndle *trans,
>>>>>     int btrfs_csum_file_blocks(struct btrfs_trans_handle *trans,
>>>>>                            struct btrfs_root *root,
>>>>>                            struct btrfs_ordered_sum *sums);
>>>>> -int btrfs_csum_one_bio(struct btrfs_bio *bbio, bool async);
>>>>> +int btrfs_csum_one_bio(struct btrfs_bio *bbio, struct bio *bio, boo=
l async);
>>>>>     int btrfs_alloc_dummy_sum(struct btrfs_bio *bbio);
>>>>>     int btrfs_lookup_csums_range(struct btrfs_root *root, u64 start,=
 u64 end,
>>>>>                              struct list_head *list, int search_comm=
it,
>>>>
>>
>=20


