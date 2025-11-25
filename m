Return-Path: <linux-btrfs+bounces-19349-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 94FFEC8712A
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Nov 2025 21:34:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6C2964EB352
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Nov 2025 20:32:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB1C72147FB;
	Tue, 25 Nov 2025 20:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="TSS2P9iL"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37AB243AA4
	for <linux-btrfs@vger.kernel.org>; Tue, 25 Nov 2025 20:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764102763; cv=none; b=IVNll/nj2p+g91tpNd5fjwYwZgIC5tte81Fy4ZhD7rXbI73sdp8Y/FkZ1ybYhv8ey0khHWs8Nc0DcRTfg2IHPBTlt6BmVDxgsdewwi5uLv/1UY1S1BRYkP5F4AzlklrI6w62n4SA9D8x086osWys3UVCPGPY7iLNngMhq753LEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764102763; c=relaxed/simple;
	bh=mG7eXTmM4Y3nFxW3wCDSyqMsJUZB1tsLInLN11Mz4Gs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fs/bcDR7ElBv97FDADB+oiVNt8ItKtdOuAk2T3QvQLoxwPETLPBoiiKmhup05BUlYckC423wcF4BSuK46EF5+Eog2Jyui1mVkizzrmurjrDasK5+WRUTLNU+WtD0gsiiQC5mNfoSiBuIAotGTJZIZNobor2Bdu3hUhMZDc0ZuA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=TSS2P9iL; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1764102759; x=1764707559; i=quwenruo.btrfs@gmx.com;
	bh=8hmdfQaE1MPLVUfrnpiG1EzcpBRb+cIY81EuY03jQFE=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=TSS2P9iL7eVULCItI3nf06r9UaEEkx5CpKd0ACHKSVwcTwGbxhy9amQ/emyrbLbw
	 7s6peivLO7nGokpqEb5klMBewxPgrMWTefNpnNfHuwG0FL8A7tkcla00OBzimkNKo
	 l64JwdwS17M8+fVMv4+JEBVstett80xd0+3xLxVKnQti7vuM4R/2oqMeyL1iVeI1D
	 XEj5PiZOsD86VzAA2yzrBK9TGnYhf0FosJSLpYwyLFuEg02kylzzvg4yjuH693nwP
	 AvYvxlOG2jGiz5IqcrporOuB+gahM5U9hFss4WLUVegetE00lDG3YF9faFfIeO5JH
	 rIWOA+MXXvmhZG/cPg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N2V0B-1w74LR3bxf-017Mu1; Tue, 25
 Nov 2025 21:32:39 +0100
Message-ID: <24139af7-d3d2-4c8a-bf5e-319f845244ba@gmx.com>
Date: Wed, 26 Nov 2025 07:02:35 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] btrfs: make sure all ordered extents beyond EOF are
 properly truncated
To: Filipe Manana <fdmanana@kernel.org>, Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, Boris Burkov <boris@bur.io>
References: <349a50a207bb672f4d8e48ddfb70da10707902e5.1764057885.git.wqu@suse.com>
 <CAL3q7H5Ue-fSHHUF8daFkp-yZ9QWbKVpdZgbWKrT_gT-4XckgQ@mail.gmail.com>
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
In-Reply-To: <CAL3q7H5Ue-fSHHUF8daFkp-yZ9QWbKVpdZgbWKrT_gT-4XckgQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:gwD8qCzkPzOx+rcDPRo4YRqdyQ9iBEGqXncxoSsW+OBnbWCWcto
 boakSq76Pxe6+/EfIKqYqDXqxiU4DSTvbGUbO9p0aavbORDAghdNFVCEs23bCfCGBuThbUb
 qm7KGRChp0AzQ44/SsGbCIxLtPTgEDubLTB0/KhVxi22lOn6dgt88GvPpb6aiWTzLM9LGA2
 nGqfeQii3my935SynELCw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:5Og5tGgTon4=;a4Nj2a9T4qHo4Q3FirI1dkr0JpD
 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



=E5=9C=A8 2025/11/25 21:15, Filipe Manana =E5=86=99=E9=81=93:
> On Tue, Nov 25, 2025 at 8:08=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrote:
>>
>> [POSSIBLE BUG]
>> If there are multiple ordered extents beyond EOF, at folio writeback
>> time we may only truncate the first ordered extent, but leaving the
>> remaining ones finished but not marked as truncated.
>>
>> Since those OEs are not marked as truncated, it will still insert an
>> file extent item, and may lead to false missing csum errors during
>> "btrfs check".
>>
>> [CAUSE]
>> Since we have bs < ps support for a while and experimental large data
>> folios are also going to graduate from experimental features soon, we
>> can have the following folio to be written back:
>>
>>    fs block size 4K
>>    page size 4K, folio size 64K.
>>
>>             0        16K      32K                  64K
>>             |<---------------- Dirty -------------->|
>>             |<-OE A->|<-OE B->|<----- OE C -------->|
>>                 |
>>                 i_size 4K.
>>
>> In above case we need to submit the writeback for the range [0, 4K).
>> For range [4K, 64K) there is no need to submit any IO but mark the
>> involved OEs (OE A, B, C) all as truncated.
>>
>> However during the EOF handling, patch "btrfs: truncate ordered extent
>> when skipping writeback past i_size" only calls
>> btrfs_lookup_first_ordered_range() once, thus only got OE A and mark it
>> as truncated.
>=20
> And there's a reason why the patch only looks for one ordered extent.
>=20
> Because there shouldn't be more than one: btrfs_truncate() calls
> btrfs_wait_ordered_range() when we truncate the size of a file to a
> smaller value.
> The range goes from the new i_size, rounded down by sector size, to
> (u64)-1. And btrfs_wait_ordered_range() flushed any delalloc besides
> waiting for ordered extents.
>=20
> So how can we find more than one ordered extent after this?

You're right, I forgot the truncation part waiting for ordered extents=20
beyond rounded up i_size.

Please discard this patch.

Thanks,
Qu

>=20
> I think this changelog should explain that, it makes no mention of
> this detail about btrfs_truncate().
>=20
> Thanks.
>=20
>=20
>>
>> But OE B and C are not marked as truncated, they will finish as usual,
>> which will leave a regular file extent item to be inserted beyond EOF,
>> and without any data checksum.
>>
>> [FIX]
>> Introduce a new helper, btrfs_mark_ordered_io_truncated(), to handle al=
l
>> OEs of a range, and mark them all as truncated.
>>
>> With that helper, all OEs (A B and C) will be marked as truncated.
>> OE B and C will have 0 truncated_len, preventing any file extent item t=
o
>> be inserted from them.
>>
>> Reviewed-by: Boris Burkov <boris@bur.io>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>> Changelog:
>> v2:
>> - Fix the ASSERT() inside btrfs_mark_ordered_io_truncated()
>>    Since the range passed in is to the end of the folio during writebac=
k
>>    path, there is no guarantee that there is always one or more ordered
>>    extents covering the full range.
>>
>>    This get triggered during fsstress runs, especially common on bs < p=
s
>>    cases.
>>
>>    Remove the ASSERT() and exit the oe search instead.
>>
>> Resend:
>> - Move the patch out of the series 'btrfs: reduce btrfs_get_extent()
>>    calls for buffered write path'
>>    As this is a bug fix, which needs a little higher priority than
>>    the remaining optimizations.
>>
>> - Fix various grammar errors
>>
>> - Use @end to replace duplicated calculations
>>
>> - Remove the Fixes: tag
>>    The involved patch is not yet merged upstream.
>>    Just mention the patch subject inside the commit message.
>> ---
>>   fs/btrfs/extent_io.c    | 19 +------------------
>>   fs/btrfs/ordered-data.c | 33 +++++++++++++++++++++++++++++++++
>>   fs/btrfs/ordered-data.h |  2 ++
>>   3 files changed, 36 insertions(+), 18 deletions(-)
>>
>> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
>> index 2d32dfc34ae3..2044b889c887 100644
>> --- a/fs/btrfs/extent_io.c
>> +++ b/fs/btrfs/extent_io.c
>> @@ -1725,24 +1725,7 @@ static noinline_for_stack int extent_writepage_i=
o(struct btrfs_inode *inode,
>>                  cur =3D folio_pos(folio) + (bit << fs_info->sectorsize=
_bits);
>>
>>                  if (cur >=3D i_size) {
>> -                       struct btrfs_ordered_extent *ordered;
>> -
>> -                       ordered =3D btrfs_lookup_first_ordered_range(in=
ode, cur,
>> -                                                                  foli=
o_end - cur);
>> -                       /*
>> -                        * We have just run delalloc before getting her=
e, so
>> -                        * there must be an ordered extent.
>> -                        */
>> -                       ASSERT(ordered !=3D NULL);
>> -                       spin_lock(&inode->ordered_tree_lock);
>> -                       set_bit(BTRFS_ORDERED_TRUNCATED, &ordered->flag=
s);
>> -                       ordered->truncated_len =3D min(ordered->truncat=
ed_len,
>> -                                                    cur - ordered->fil=
e_offset);
>> -                       spin_unlock(&inode->ordered_tree_lock);
>> -                       btrfs_put_ordered_extent(ordered);
>> -
>> -                       btrfs_mark_ordered_io_finished(inode, folio, cu=
r,
>> -                                                      end - cur, true)=
;
>> +                       btrfs_mark_ordered_io_truncated(inode, folio, c=
ur, end - cur);
>>                          /*
>>                           * This range is beyond i_size, thus we don't =
need to
>>                           * bother writing back.
>> diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
>> index a421f7db9eec..3c0b89164139 100644
>> --- a/fs/btrfs/ordered-data.c
>> +++ b/fs/btrfs/ordered-data.c
>> @@ -546,6 +546,39 @@ void btrfs_mark_ordered_io_finished(struct btrfs_i=
node *inode,
>>          spin_unlock(&inode->ordered_tree_lock);
>>   }
>>
>> +/*
>> + * Mark any ordered extents io inside the specified range as truncated=
.
>> + */
>> +void btrfs_mark_ordered_io_truncated(struct btrfs_inode *inode, struct=
 folio *folio,
>> +                                    u64 file_offset, u32 len)
>> +{
>> +       const u64 end =3D file_offset + len;
>> +       u64 cur =3D file_offset;
>> +
>> +       ASSERT(file_offset >=3D folio_pos(folio));
>> +       ASSERT(end <=3D folio_pos(folio) + folio_size(folio));
>> +
>> +       while (cur < end) {
>> +               u32 cur_len =3D end - cur;
>> +               struct btrfs_ordered_extent *ordered;
>> +
>> +               ordered =3D btrfs_lookup_first_ordered_range(inode, cur=
, cur_len);
>> +
>> +               if (!ordered)
>> +                       break;
>> +               scoped_guard(spinlock, &inode->ordered_tree_lock) {
>> +                       set_bit(BTRFS_ORDERED_TRUNCATED, &ordered->flag=
s);
>> +                       ordered->truncated_len =3D min(ordered->truncat=
ed_len,
>> +                                                    cur - ordered->fil=
e_offset);
>> +               }
>> +               cur_len =3D min(cur_len, ordered->file_offset + ordered=
->num_bytes - cur);
>> +               btrfs_put_ordered_extent(ordered);
>> +
>> +               cur +=3D cur_len;
>> +       }
>> +       btrfs_mark_ordered_io_finished(inode, folio, file_offset, len, =
true);
>> +}
>> +
>>   /*
>>    * Finish IO for one ordered extent across a given range.  The range =
can only
>>    * contain one ordered extent.
>> diff --git a/fs/btrfs/ordered-data.h b/fs/btrfs/ordered-data.h
>> index 1e6b0b182b29..dd4cdc1a8b78 100644
>> --- a/fs/btrfs/ordered-data.h
>> +++ b/fs/btrfs/ordered-data.h
>> @@ -169,6 +169,8 @@ void btrfs_finish_ordered_extent(struct btrfs_order=
ed_extent *ordered,
>>   void btrfs_mark_ordered_io_finished(struct btrfs_inode *inode,
>>                                      struct folio *folio, u64 file_offs=
et,
>>                                      u64 num_bytes, bool uptodate);
>> +void btrfs_mark_ordered_io_truncated(struct btrfs_inode *inode, struct=
 folio *folio,
>> +                                    u64 file_offset, u32 len);
>>   bool btrfs_dec_test_ordered_pending(struct btrfs_inode *inode,
>>                                      struct btrfs_ordered_extent **cach=
ed,
>>                                      u64 file_offset, u64 io_size);
>> --
>> 2.52.0
>>
>>
>=20


