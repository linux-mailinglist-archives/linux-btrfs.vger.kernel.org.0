Return-Path: <linux-btrfs+bounces-13962-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 78910AB4DB6
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 May 2025 10:11:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFCB13AC813
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 May 2025 08:10:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DE5D1F5846;
	Tue, 13 May 2025 08:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="YzdREFzB"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBC51A93D;
	Tue, 13 May 2025 08:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747123860; cv=none; b=HamZdP/EUpSS/x7+g+uU5LcfqtnCl1WsMSdYYiKMT/kIDXjMKpLtpmm0mT0hmWOcU5goOHzoWXQHdEIDBu01130uAfAxV5TZxDVJWAsan+jzR/kewwqIXi6mlyP902VpJh/Ykvqt9SsbDmstz3yLRo1NVJUxXiICxXFJ2GIk/dM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747123860; c=relaxed/simple;
	bh=fkUQRYSyF+mG5SBzJ/i86h9zvzY1mY8LunPCmxE17ew=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EptCBjWs4+VPoqX5f5n+6MdzWRbqWKMQqMuJCmWQrHM6tfEU7xxs7BEPNhv4w7pnmSM3tt/CQj8YdQidkyT6xGiOmnISLCLpT5MO4n9lIeoPlkBpArQYj8xeqdGBhpI/Gh3wrO+vCvpXH6SoBXUetCW1Y6mLmxvGh7+UAZd+aug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=YzdREFzB; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1747123850; x=1747728650; i=quwenruo.btrfs@gmx.com;
	bh=BefIrXmnX0MAUFQydxcjpGCrYpZjN/wYqojnc5aasZo=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=YzdREFzBxRyZU6ujDaF/AXhjh0xosq/jnhfWbdegP9xPlfJgB+5/M+bDlZD3ZnkO
	 lwhlbWSg4OnwdkjCX0aGOFUSEQ8M0Yt44GXmna6N/5N/FTJmBgurDJMFxN08IeJn4
	 HMA+is2VhaoG4vUQ7dJkg/Yn4QQkEZ2jX7P4S3/80g8P9NJg4/p4ggti9aTj91mhp
	 xbtZGRumtcHOPBdih3ePk7AAzu+L73fqLPH0908cU9vUof5NFM3aVT9g3/2+3eiCw
	 VqxJifN9eXNE4atStdFC9tJvsrIJstdHWGn6164xk7oakSWcTgGRA5OPYKVFvRMhA
	 NLPBNgKd6ZESlz84GA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MJE6F-1uYCLi499P-00MehF; Tue, 13
 May 2025 10:10:50 +0200
Message-ID: <cb826215-bfa4-4294-9dfe-8f2378d99348@gmx.com>
Date: Tue, 13 May 2025 17:40:45 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: index buffer_tree using node size
To: Daniel Vacek <neelx@suse.com>
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
 David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250512172321.3004779-1-neelx@suse.com>
 <4b29d4b8-c823-44d0-8647-a53a09e20b5f@gmx.com>
 <CAPjX3FdJGfHarYMjVyR7qzKowbiauepcOMDJjDRt6Rs-5w0pHA@mail.gmail.com>
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
In-Reply-To: <CAPjX3FdJGfHarYMjVyR7qzKowbiauepcOMDJjDRt6Rs-5w0pHA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:kp6UVoX20YUnxlQN8nUZ/HOsuTuXP6EJ79+FI7Xf6DyJWkUa2Wu
 NW+Cm5coBGxQXhTsnbbdsl5tlTp8aUBC2y1zXhh54Dasa4GyOQYPG65CSnhyot4o5DqMKPz
 7AVkvPiaf66HsQTxFmcjkfu8aUsyrhybFuHVz1XAfHnNUyvy9v8POVUuqG3WSrCKFAjV4bo
 OhHjmTMhT5/ZOAxqF12Tg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:hat0rEPBKbQ=;9SZPiUY2yuR5o8A3RTBO2b2XJu4
 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
 EBvA1YLSKTO7u1KaAdpVl7qNkeiQW6XCfZ



=E5=9C=A8 2025/5/13 17:35, Daniel Vacek =E5=86=99=E9=81=93:
> On Tue, 13 May 2025 at 00:44, Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>>
>>
>>
>> =E5=9C=A8 2025/5/13 02:53, Daniel Vacek =E5=86=99=E9=81=93:
>>> So far we are deriving the buffer tree index using the sector size. Bu=
t each
>>> extent buffer covers multiple sectors. This makes the buffer tree rath=
er sparse.
>>>
>>> For example the typical and quite common configuration uses sector siz=
e of 4KiB
>>> and node size of 16KiB. In this case it means the buffer tree is using=
 up to
>>> the maximum of 25% of it's slots. Or in other words at least 75% of th=
e tree
>>> slots are wasted as never used.
>>>
>>> We can score significant memory savings on the required tree nodes by =
indexing
>>> the tree using the node size instead. As a result far less slots are w=
asted
>>> and the tree can now use up to all 100% of it's slots this way.
>>>
>>> Signed-off-by: Daniel Vacek <neelx@suse.com>
>>
>> I'm fine with this change, but I still believe, we should address
>> unaligned tree blocks before doing this.
>=20
> Yeah, we discussed it on chat. But giving it another thought I
> realized that the ebs don't overlap each other. Well, I think they do
> not, right?
>=20
> That means they are always nodesize apart. So no matter what
> alignment/offset each one always falls into a dedicated tree slot. It
> can never happen that two neighboring ebs would fall into the same
> slot. Hence I think we're safe here with this regard.

Oh, this is indeed a brilliant trick/hack.

Yes, even with unaligned tree blocks, we can still get unique index by=20
doing eb->start >> nodesize_shift.

Mind to add this part into the commit message?

In that case, it looks good to me.

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

>=20
>> As this requires all tree blocks are nodesize aligned.
>=20
> Does it? I don't think that's correct. Am I missing something?
>=20
>> If we have some metadata chunks which starts at a bytenr that is not
>> node size aligned, all tree blocks inside that chunk will not be
>> nodesize aligned and causing problems.
>=20
> As explained above, I don't really see any problems. But then again, I
> may be missing something. Let me know, please.
>=20
>> Thanks,
>> Qu
>>
>>> ---
>>>    fs/btrfs/disk-io.c   |  1 +
>>>    fs/btrfs/extent_io.c | 30 +++++++++++++++---------------
>>>    fs/btrfs/fs.h        |  3 ++-
>>>    3 files changed, 18 insertions(+), 16 deletions(-)
>>>
>>> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
>>> index 5bcf11246ba66..dcea5b0a2db50 100644
>>> --- a/fs/btrfs/disk-io.c
>>> +++ b/fs/btrfs/disk-io.c
>>> @@ -3395,6 +3395,7 @@ int __cold open_ctree(struct super_block *sb, st=
ruct btrfs_fs_devices *fs_device
>>>        fs_info->delalloc_batch =3D sectorsize * 512 * (1 + ilog2(nr_cp=
u_ids));
>>>
>>>        fs_info->nodesize =3D nodesize;
>>> +     fs_info->node_bits =3D ilog2(nodesize);
>>>        fs_info->sectorsize =3D sectorsize;
>>>        fs_info->sectorsize_bits =3D ilog2(sectorsize);
>>>        fs_info->csums_per_leaf =3D BTRFS_MAX_ITEM_SIZE(fs_info) / fs_i=
nfo->csum_size;
>>> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
>>> index 4d3584790cf7f..80a8563a25add 100644
>>> --- a/fs/btrfs/extent_io.c
>>> +++ b/fs/btrfs/extent_io.c
>>> @@ -1774,7 +1774,7 @@ static noinline_for_stack bool lock_extent_buffe=
r_for_io(struct extent_buffer *e
>>>         */
>>>        spin_lock(&eb->refs_lock);
>>>        if (test_and_clear_bit(EXTENT_BUFFER_DIRTY, &eb->bflags)) {
>>> -             XA_STATE(xas, &fs_info->buffer_tree, eb->start >> fs_inf=
o->sectorsize_bits);
>>> +             XA_STATE(xas, &fs_info->buffer_tree, eb->start >> fs_inf=
o->node_bits);
>>>                unsigned long flags;
>>>
>>>                set_bit(EXTENT_BUFFER_WRITEBACK, &eb->bflags);
>>> @@ -1874,7 +1874,7 @@ static void set_btree_ioerr(struct extent_buffer=
 *eb)
>>>    static void buffer_tree_set_mark(const struct extent_buffer *eb, xa=
_mark_t mark)
>>>    {
>>>        struct btrfs_fs_info *fs_info =3D eb->fs_info;
>>> -     XA_STATE(xas, &fs_info->buffer_tree, eb->start >> fs_info->secto=
rsize_bits);
>>> +     XA_STATE(xas, &fs_info->buffer_tree, eb->start >> fs_info->node_=
bits);
>>>        unsigned long flags;
>>>
>>>        xas_lock_irqsave(&xas, flags);
>>> @@ -1886,7 +1886,7 @@ static void buffer_tree_set_mark(const struct ex=
tent_buffer *eb, xa_mark_t mark)
>>>    static void buffer_tree_clear_mark(const struct extent_buffer *eb, =
xa_mark_t mark)
>>>    {
>>>        struct btrfs_fs_info *fs_info =3D eb->fs_info;
>>> -     XA_STATE(xas, &fs_info->buffer_tree, eb->start >> fs_info->secto=
rsize_bits);
>>> +     XA_STATE(xas, &fs_info->buffer_tree, eb->start >> fs_info->node_=
bits);
>>>        unsigned long flags;
>>>
>>>        xas_lock_irqsave(&xas, flags);
>>> @@ -1986,7 +1986,7 @@ static unsigned int buffer_tree_get_ebs_tag(stru=
ct btrfs_fs_info *fs_info,
>>>        rcu_read_lock();
>>>        while ((eb =3D find_get_eb(&xas, end, tag)) !=3D NULL) {
>>>                if (!eb_batch_add(batch, eb)) {
>>> -                     *start =3D (eb->start + eb->len) >> fs_info->sec=
torsize_bits;
>>> +                     *start =3D (eb->start + eb->len) >> fs_info->nod=
e_bits;
>>>                        goto out;
>>>                }
>>>        }
>>> @@ -2008,7 +2008,7 @@ static struct extent_buffer *find_extent_buffer_=
nolock(
>>>                struct btrfs_fs_info *fs_info, u64 start)
>>>    {
>>>        struct extent_buffer *eb;
>>> -     unsigned long index =3D start >> fs_info->sectorsize_bits;
>>> +     unsigned long index =3D start >> fs_info->node_bits;
>>>
>>>        rcu_read_lock();
>>>        eb =3D xa_load(&fs_info->buffer_tree, index);
>>> @@ -2114,8 +2114,8 @@ void btrfs_btree_wait_writeback_range(struct btr=
fs_fs_info *fs_info, u64 start,
>>>                                      u64 end)
>>>    {
>>>        struct eb_batch batch;
>>> -     unsigned long start_index =3D start >> fs_info->sectorsize_bits;
>>> -     unsigned long end_index =3D end >> fs_info->sectorsize_bits;
>>> +     unsigned long start_index =3D start >> fs_info->node_bits;
>>> +     unsigned long end_index =3D end >> fs_info->node_bits;
>>>
>>>        eb_batch_init(&batch);
>>>        while (start_index <=3D end_index) {
>>> @@ -2151,7 +2151,7 @@ int btree_write_cache_pages(struct address_space=
 *mapping,
>>>
>>>        eb_batch_init(&batch);
>>>        if (wbc->range_cyclic) {
>>> -             index =3D (mapping->writeback_index << PAGE_SHIFT) >> fs=
_info->sectorsize_bits;
>>> +             index =3D (mapping->writeback_index << PAGE_SHIFT) >> fs=
_info->node_bits;
>>>                end =3D -1;
>>>
>>>                /*
>>> @@ -2160,8 +2160,8 @@ int btree_write_cache_pages(struct address_space=
 *mapping,
>>>                 */
>>>                scanned =3D (index =3D=3D 0);
>>>        } else {
>>> -             index =3D wbc->range_start >> fs_info->sectorsize_bits;
>>> -             end =3D wbc->range_end >> fs_info->sectorsize_bits;
>>> +             index =3D wbc->range_start >> fs_info->node_bits;
>>> +             end =3D wbc->range_end >> fs_info->node_bits;
>>>
>>>                scanned =3D 1;
>>>        }
>>> @@ -3037,7 +3037,7 @@ struct extent_buffer *alloc_test_extent_buffer(s=
truct btrfs_fs_info *fs_info,
>>>        eb->fs_info =3D fs_info;
>>>    again:
>>>        xa_lock_irq(&fs_info->buffer_tree);
>>> -     exists =3D __xa_cmpxchg(&fs_info->buffer_tree, start >> fs_info-=
>sectorsize_bits,
>>> +     exists =3D __xa_cmpxchg(&fs_info->buffer_tree, start >> fs_info-=
>node_bits,
>>>                              NULL, eb, GFP_NOFS);
>>>        if (xa_is_err(exists)) {
>>>                ret =3D xa_err(exists);
>>> @@ -3353,7 +3353,7 @@ struct extent_buffer *alloc_extent_buffer(struct=
 btrfs_fs_info *fs_info,
>>>    again:
>>>        xa_lock_irq(&fs_info->buffer_tree);
>>>        existing_eb =3D __xa_cmpxchg(&fs_info->buffer_tree,
>>> -                                start >> fs_info->sectorsize_bits, NU=
LL, eb,
>>> +                                start >> fs_info->node_bits, NULL, eb=
,
>>>                                   GFP_NOFS);
>>>        if (xa_is_err(existing_eb)) {
>>>                ret =3D xa_err(existing_eb);
>>> @@ -3456,7 +3456,7 @@ static int release_extent_buffer(struct extent_b=
uffer *eb)
>>>                 * in this case.
>>>                 */
>>>                xa_cmpxchg_irq(&fs_info->buffer_tree,
>>> -                            eb->start >> fs_info->sectorsize_bits, eb=
, NULL,
>>> +                            eb->start >> fs_info->node_bits, eb, NULL=
,
>>>                               GFP_ATOMIC);
>>>
>>>                btrfs_leak_debug_del_eb(eb);
>>> @@ -4294,9 +4294,9 @@ static int try_release_subpage_extent_buffer(str=
uct folio *folio)
>>>    {
>>>        struct btrfs_fs_info *fs_info =3D folio_to_fs_info(folio);
>>>        struct extent_buffer *eb;
>>> -     unsigned long start =3D folio_pos(folio) >> fs_info->sectorsize_=
bits;
>>> +     unsigned long start =3D folio_pos(folio) >> fs_info->node_bits;
>>>        unsigned long index =3D start;
>>> -     unsigned long end =3D index + (PAGE_SIZE >> fs_info->sectorsize_=
bits) - 1;
>>> +     unsigned long end =3D index + (PAGE_SIZE >> fs_info->node_bits) =
- 1;
>>>        int ret;
>>>
>>>        xa_lock_irq(&fs_info->buffer_tree);
>>> diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
>>> index cf805b4032af3..8c9113304fabe 100644
>>> --- a/fs/btrfs/fs.h
>>> +++ b/fs/btrfs/fs.h
>>> @@ -778,8 +778,9 @@ struct btrfs_fs_info {
>>>
>>>        struct btrfs_delayed_root *delayed_root;
>>>
>>> -     /* Entries are eb->start / sectorsize */
>>> +     /* Entries are eb->start >> node_bits */
>>>        struct xarray buffer_tree;
>>> +     int node_bits;
>>>
>>>        /* Next backup root to be overwritten */
>>>        int backup_root_index;
>>
>=20


