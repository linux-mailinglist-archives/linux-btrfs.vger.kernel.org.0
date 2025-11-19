Return-Path: <linux-btrfs+bounces-19126-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 85468C6D628
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Nov 2025 09:22:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 14B5D34C1DC
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Nov 2025 08:16:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 429F9324707;
	Wed, 19 Nov 2025 08:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="Vy3vX5zn"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D39BA2BD033;
	Wed, 19 Nov 2025 08:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763540211; cv=none; b=tbqLPqtHO2WoGC9ggJhtUjOUg2nI7E7EDT1eJLCMcnoIC9OT9m2PZS+C0ZUXycdp3DViU/TmAsKvSR3tix2/zAL3UZiZH8xDkztbwdZ9rVOPcCEgxHUz4bF23upeXh3NcyguGC1+4z7Vo55rKzFS6suFJxQ0bYIRJxYf2/eAFfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763540211; c=relaxed/simple;
	bh=uJQg48v7aqeC+wSbk4fFy4RH6F0LjB1ggI7o1VOqKJg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HbaPIkNpVwxW2+xGZary9EnOMv6SP9Bz+Mpy8FfM2kWtSIp06N9erqCPQtGxqUn1oHr5zs+CNHNhDNcomoa0WKtF+u8jr9wPM9BvZMBm5Vv/vYVo4mjC0lR0IUO5iNmSz22LvJcHUhGb6J/mNrPQYC7h2TNl+0Yzc5+j6Rxc3yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=Vy3vX5zn; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1763540204; x=1764145004; i=quwenruo.btrfs@gmx.com;
	bh=oCY80wLf4KmU1zpItJAIdNz5tcXNZ9Ps2ws5spn1hc0=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=Vy3vX5znRW1hvo1FUMFNLsimwZaxzs8iReX4RJOr2KuUenGiiiDgyjP5CMoFvcfV
	 xFIQbPZNqMAjFdRliNmRpQHH1uLg3BZ2a7eXWQi0hgfIyqdJHVDjwQ0CttcdBgSAB
	 Ofe/GLoP5Nu6utHFtbe08w7i2rt0r5MT0DyzjKvcAjl3hpwIs7gFOzSdJM5CEZhaj
	 6buVsHrX8FuVJvpKom5mrllMPAFenD20H17yl9ghlfM2yjp9xwcV7ydVWb/V0118f
	 FNjlYsZ2Ee532iP6yEfoDNe6xOVTt+fyd/L/plFrlMzaosHXfKhvTUr4AFnS2CjdM
	 cAQaJwK8nneK2Z397g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N17UQ-1wJbhR1dt4-010gVo; Wed, 19
 Nov 2025 09:16:44 +0100
Message-ID: <e5b6c075-9edd-4729-8da8-65be0a48dea7@gmx.com>
Date: Wed, 19 Nov 2025 18:46:39 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 3/8] btrfs: add a bio argument to btrfs_csum_one_bio
To: Daniel Vacek <neelx@suse.com>
Cc: Qu Wenruo <wqu@suse.com>, Chris Mason <clm@fb.com>,
 Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
 linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251112193611.2536093-1-neelx@suse.com>
 <20251112193611.2536093-4-neelx@suse.com>
 <7de34b24-f189-402a-98f9-83e595b53244@suse.com>
 <CAPjX3FfMaOWtCZ8mjVTbBQ9yt0O-mAistyDsVq7Q1aR-65R_hA@mail.gmail.com>
 <492ac26f-5eb4-49bf-855a-11f021d9e937@suse.com>
 <CAPjX3Fec=qAtWjPNvszKdww=giCUEgoMULc1Zvd37k03VUaUmw@mail.gmail.com>
 <84128576-17f4-460a-9d2f-9e40f43f2ef7@gmx.com>
 <CAPjX3FedNEUeGr3sROdHaT0iKhHDfsi4V=GQHcmvhx6wEJqUcg@mail.gmail.com>
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
In-Reply-To: <CAPjX3FedNEUeGr3sROdHaT0iKhHDfsi4V=GQHcmvhx6wEJqUcg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Y+yeniyFZlIBgmBYSmLqYbIamc/aAzkyZ1FdU1GZQ1uJwwFwEDR
 bKlD9VfpFtHashlN9pnTnR1wfLN0XcArLEcdojtNqk247REuwGnt2XBhehMlcD9b4ZSZXaG
 KBOs7MvnYRnkNL60jtmYdCqMvww5v7KIAVfIuBbC8PINz46lzmYx+Zv1yNgOFSVNQfDKOT1
 wal3GAPtzE9FFvBXOOAAg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:g/L4YZh+iME=;tjyCj3x5XfcmrR/We0Hfv922aLJ
 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
 dLZM1iyPeFjayCLhd2tN1+2ozZbeo8MN39L5ny



=E5=9C=A8 2025/11/19 18:04, Daniel Vacek =E5=86=99=E9=81=93:
[...]
>> Unless you mean the encrypted bio is not encapsulated by btrfs_bio, but
>> a vanilla bio.
>=20

Now it's completely unrelated to the patchset, but I'm still very=20
interested in the workflow of fscrypt.

Is there high level docs about it?

> That's the case. The bounce bio is created when you submit the
> original one. The data is encrypted by fscrypt, then the csum hook is
> called and the new bio submitted instead of the original one.

I guess by "submit" you didn't mean btrfs_submit_bio(), but something=20
else right?
Or the plaintext bio will be submitted to the disks.

> Later
> the endio frees the new one and calls endio on the original bio.

But the encrypted bio still needs to be handled by btrfs_submit_bio(),=20
as we still have a lot of extra works like splitting due to stripe=20
boundary and duplicating to different mirrors.

The end io function of the encrypted bio won't be called until all of=20
our btrfs specific work/IO is done.

> This
> means we don't have control over the bounce bio and cannot use it
> asynchronously at the moment. The csum needs to be finished directly
> in the hook.

Any code I can look into the "hook"?

I checked the ext4's code (althought it doesn't support csum), they just=
=20
call fscrypt_encrypt_pagecache_blocks() on the plaintext folios, and=20
submit the encrypted folios as the bio payload.

It's completely fine to just add those encrypted folios into a=20
btrfs_bio, and submit as usual.

I believe we can handle it inside the endio function, end_bbio_data_write(=
).

In fact, currently for write bios, we use an empty btrfs_bio::private,=20
we can definitely allocate some extra structure for encrypted writes to=20
track the plain text pages (mostly just the start/end file pos).


So my uneducated guess of the encyrpted write would be something like=20
the following, mostly happenin in the function submit_extent_folio():

submit_extent_folio()
{
	/* setup bio_ctrl for encrypted, involving the
          * btrfs_bio::private.
	 * So that alloc_new_bio() will allocate a new
	 * private for encrypted write.
          */
	do {
		if (is_encrypted) {
			data_folio =3D fscrypt_encrypt();
			ret =3D bio_add_folio();
		} else {
			ret =3D bio_add_folio();
		}
		/* the remaining as usual */
	}
}

Then in the endio do the special handling:

end_bbio_data_write()
{
	if (!bbio->private) {
		/* The existing one. */
		end_bbio_data_write_plaintext();
	} else {
		/*
		 * Using bbio->private to grab the page cache folios
		 * and free the encrypted folios.
		 */
	}
	bio_put(&bbio->bio);
}

Thus that's why I didn't see the point to trace the original bbio inside=
=20
btrfs_bio, and also didn't see why we have any problem doing async csum.

BTW, the same can be applied to data read, as we didn't utilize=20
btrfs_bio::private either.

Or did I miss something?

Thanks,
Qu

>=20
> Anyways, the hook changes are not upstreamed yet, so you can only see
> it on the mailing list. And that's also why this patch makes more
> sense to be sent later together with those changes.
>=20
> --nX
>=20
>> In that case you can not even submit it through btrfs_submit_bbio().
>>
>> Thanks,
>> Qu
>>
>>> We'll need to
>>> always compute the checksum synchronously for encrypted bios. In that
>>> case we don't need to store it in btrfs_bio::csum_bio at all. For the
>>> regular (unencrypted) case we can keep using the &bbio->bio.
>>>
>>> I'll drop the csum_bio for there is no use really.
>>>
>>> --nX
>>>
>>>> I thought it's more common to put the original plaintext into the
>>>> encryption specific structure, like what we did for compression.
>>>>
>>>> Thanks,
>>>> Qu
>>>>
>>>>>
>>>>> --nX
>>>>>
>>>>>> The storage layer doesn't need to bother the plaintext bio at all, =
they
>>>>>> just write the encrypted one to disk.
>>>>>>
>>>>>> And it's the dm-crypto tracking the plaintext bio <-> encrypted bio=
 mapping.
>>>>>>
>>>>>>
>>>>>> So why we can not just create a new bio for the final csum caculati=
on,
>>>>>> just like compression?
>>>>>>
>>>>>> Thanks,
>>>>>> Qu
>>>>>>
>>>>>>>
>>>>>>> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
>>>>>>> Signed-off-by: Daniel Vacek <neelx@suse.com>
>>>>>>> ---
>>>>>>> Compared to v5 this needed to adapt to recent async csum changes.
>>>>>>> ---
>>>>>>>      fs/btrfs/bio.c       |  4 ++--
>>>>>>>      fs/btrfs/bio.h       |  1 +
>>>>>>>      fs/btrfs/file-item.c | 17 ++++++++---------
>>>>>>>      fs/btrfs/file-item.h |  2 +-
>>>>>>>      4 files changed, 12 insertions(+), 12 deletions(-)
>>>>>>>
>>>>>>> diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
>>>>>>> index a73652b8724a..a69174b2b6b6 100644
>>>>>>> --- a/fs/btrfs/bio.c
>>>>>>> +++ b/fs/btrfs/bio.c
>>>>>>> @@ -542,9 +542,9 @@ static int btrfs_bio_csum(struct btrfs_bio *bb=
io)
>>>>>>>          if (bbio->bio.bi_opf & REQ_META)
>>>>>>>                  return btree_csum_one_bio(bbio);
>>>>>>>      #ifdef CONFIG_BTRFS_EXPERIMENTAL
>>>>>>> -     return btrfs_csum_one_bio(bbio, true);
>>>>>>> +     return btrfs_csum_one_bio(bbio, &bbio->bio, true);
>>>>>>>      #else
>>>>>>> -     return btrfs_csum_one_bio(bbio, false);
>>>>>>> +     return btrfs_csum_one_bio(bbio, &bbio->bio, false);
>>>>>>>      #endif
>>>>>>>      }
>>>>>>>
>>>>>>> diff --git a/fs/btrfs/bio.h b/fs/btrfs/bio.h
>>>>>>> index deaeea3becf4..c5a6c66d51a0 100644
>>>>>>> --- a/fs/btrfs/bio.h
>>>>>>> +++ b/fs/btrfs/bio.h
>>>>>>> @@ -58,6 +58,7 @@ struct btrfs_bio {
>>>>>>>                          struct btrfs_ordered_sum *sums;
>>>>>>>                          struct work_struct csum_work;
>>>>>>>                          struct completion csum_done;
>>>>>>> +                     struct bio *csum_bio;
>>>>>>>                          struct bvec_iter csum_saved_iter;
>>>>>>>                          u64 orig_physical;
>>>>>>>                  };
>>>>>>> diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
>>>>>>> index 72be3ede0edf..474949074da8 100644
>>>>>>> --- a/fs/btrfs/file-item.c
>>>>>>> +++ b/fs/btrfs/file-item.c
>>>>>>> @@ -765,21 +765,19 @@ int btrfs_lookup_csums_bitmap(struct btrfs_r=
oot *root, struct btrfs_path *path,
>>>>>>>          return ret;
>>>>>>>      }
>>>>>>>
>>>>>>> -static void csum_one_bio(struct btrfs_bio *bbio, struct bvec_iter=
 *src)
>>>>>>> +static void csum_one_bio(struct btrfs_bio *bbio, struct bio *bio,=
 struct bvec_iter *iter)
>>>>>>>      {
>>>>>>>          struct btrfs_inode *inode =3D bbio->inode;
>>>>>>>          struct btrfs_fs_info *fs_info =3D inode->root->fs_info;
>>>>>>>          SHASH_DESC_ON_STACK(shash, fs_info->csum_shash);
>>>>>>> -     struct bio *bio =3D &bbio->bio;
>>>>>>>          struct btrfs_ordered_sum *sums =3D bbio->sums;
>>>>>>> -     struct bvec_iter iter =3D *src;
>>>>>>>          phys_addr_t paddr;
>>>>>>>          const u32 blocksize =3D fs_info->sectorsize;
>>>>>>>          int index =3D 0;
>>>>>>>
>>>>>>>          shash->tfm =3D fs_info->csum_shash;
>>>>>>>
>>>>>>> -     btrfs_bio_for_each_block(paddr, bio, &iter, blocksize) {
>>>>>>> +     btrfs_bio_for_each_block(paddr, bio, iter, blocksize) {
>>>>>>>                  btrfs_calculate_block_csum(fs_info, paddr, sums->=
sums + index);
>>>>>>>                  index +=3D fs_info->csum_size;
>>>>>>>          }
>>>>>>> @@ -791,19 +789,18 @@ static void csum_one_bio_work(struct work_st=
ruct *work)
>>>>>>>
>>>>>>>          ASSERT(btrfs_op(&bbio->bio) =3D=3D BTRFS_MAP_WRITE);
>>>>>>>          ASSERT(bbio->async_csum =3D=3D true);
>>>>>>> -     csum_one_bio(bbio, &bbio->csum_saved_iter);
>>>>>>> +     csum_one_bio(bbio, bbio->csum_bio, &bbio->csum_saved_iter);
>>>>>>>          complete(&bbio->csum_done);
>>>>>>>      }
>>>>>>>
>>>>>>>      /*
>>>>>>>       * Calculate checksums of the data contained inside a bio.
>>>>>>>       */
>>>>>>> -int btrfs_csum_one_bio(struct btrfs_bio *bbio, bool async)
>>>>>>> +int btrfs_csum_one_bio(struct btrfs_bio *bbio, struct bio *bio, b=
ool async)
>>>>>>>      {
>>>>>>>          struct btrfs_ordered_extent *ordered =3D bbio->ordered;
>>>>>>>          struct btrfs_inode *inode =3D bbio->inode;
>>>>>>>          struct btrfs_fs_info *fs_info =3D inode->root->fs_info;
>>>>>>> -     struct bio *bio =3D &bbio->bio;
>>>>>>>          struct btrfs_ordered_sum *sums;
>>>>>>>          unsigned nofs_flag;
>>>>>>>
>>>>>>> @@ -822,12 +819,14 @@ int btrfs_csum_one_bio(struct btrfs_bio *bbi=
o, bool async)
>>>>>>>          btrfs_add_ordered_sum(ordered, sums);
>>>>>>>
>>>>>>>          if (!async) {
>>>>>>> -             csum_one_bio(bbio, &bbio->bio.bi_iter);
>>>>>>> +             struct bvec_iter iter =3D bio->bi_iter;
>>>>>>> +             csum_one_bio(bbio, bio, &iter);
>>>>>>>                  return 0;
>>>>>>>          }
>>>>>>>          init_completion(&bbio->csum_done);
>>>>>>>          bbio->async_csum =3D true;
>>>>>>> -     bbio->csum_saved_iter =3D bbio->bio.bi_iter;
>>>>>>> +     bbio->csum_bio =3D bio;
>>>>>>> +     bbio->csum_saved_iter =3D bio->bi_iter;
>>>>>>>          INIT_WORK(&bbio->csum_work, csum_one_bio_work);
>>>>>>>          schedule_work(&bbio->csum_work);
>>>>>>>          return 0;
>>>>>>> diff --git a/fs/btrfs/file-item.h b/fs/btrfs/file-item.h
>>>>>>> index 5645c5e3abdb..d16fd2144552 100644
>>>>>>> --- a/fs/btrfs/file-item.h
>>>>>>> +++ b/fs/btrfs/file-item.h
>>>>>>> @@ -64,7 +64,7 @@ int btrfs_lookup_file_extent(struct btrfs_trans_=
handle *trans,
>>>>>>>      int btrfs_csum_file_blocks(struct btrfs_trans_handle *trans,
>>>>>>>                             struct btrfs_root *root,
>>>>>>>                             struct btrfs_ordered_sum *sums);
>>>>>>> -int btrfs_csum_one_bio(struct btrfs_bio *bbio, bool async);
>>>>>>> +int btrfs_csum_one_bio(struct btrfs_bio *bbio, struct bio *bio, b=
ool async);
>>>>>>>      int btrfs_alloc_dummy_sum(struct btrfs_bio *bbio);
>>>>>>>      int btrfs_lookup_csums_range(struct btrfs_root *root, u64 sta=
rt, u64 end,
>>>>>>>                               struct list_head *list, int search_c=
ommit,
>>>>>>
>>>>
>>>
>>


