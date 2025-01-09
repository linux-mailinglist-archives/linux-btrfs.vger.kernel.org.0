Return-Path: <linux-btrfs+bounces-10809-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 763A4A06BB9
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Jan 2025 03:56:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59200161CF0
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Jan 2025 02:56:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB4D51474A9;
	Thu,  9 Jan 2025 02:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="fkpiV3tK"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CF1D84FAD;
	Thu,  9 Jan 2025 02:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736391373; cv=none; b=aKFuIzGqzSeIgiBM83LCFT0sveOPJn2GtYsv+ZcGcnwOwOb3W0rVy2ZxL4WLyeX1hSp4yejDWx4LxGiYKimr6Yt+lPf/lw9uKVsClXq7wsqmPN9a1Gw2Jrf5jZY1CGF3nQRC8vvvEQfMX4KU8S4V9/9CwRRG3gW+oFFHmc0kKtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736391373; c=relaxed/simple;
	bh=GUCSzEe/2Sg+7iHjW+lM7fa5gHrj0e61fal8NeRMaEE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N9nCyt3muRs3cn7sceFXsB+1xOiL+2krkJ/MJ/ZEyJSDoQAsJRnrc+05hDIXXqvUmrwQKltdvPe2ZPoKauEs7DHYgQ1tGz2TnpKWLtyIFuDxGFIUXwjgYLDLFkhqGcUpbg4l3pdCQMcV7I2W2MFxaQrldBJZMMdDPR9e09OeLgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=fkpiV3tK; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1736391367; x=1736996167; i=quwenruo.btrfs@gmx.com;
	bh=4mdm1hSevhgHHxUZPtdAA17CQWuumekbSUrS+Z2Toi8=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=fkpiV3tKat/jqnb/bU2CDo6+bnq8LoaGvj/xeCO+KkIzHJVQAdkKXoYgOSBTCNJa
	 nONjilzPKxNyuZOtMD7STKplJympSQLj+/2r3NKbNVNx2NvDN0qV+T3a0oY4Euz9d
	 cVBO49lE+s4Yr4qUxylS1QJKrhWkSKZYLL3qrYzG+fn2RV6iHBdvEWj+qSZKYDAY0
	 U5hV/G6y8Mm/Z60daMAtkbX1MPZ3JGnt/3t9OmzYmKKNY9ifDUdXXRUmQoC1YxJx+
	 /55+RFU9y3p28zL9F7JZFFWaFCAScGJtD8c9zi6d5qcdY9d+DRBlyO+FIGuYQE2GG
	 2K5bXEMxC5u1WutCnA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MBlxM-1tJaAt1SW4-007uY0; Thu, 09
 Jan 2025 03:56:07 +0100
Message-ID: <bc2d3f57-b66a-4a95-bcdd-cf0e9ef7b691@gmx.com>
Date: Thu, 9 Jan 2025 13:26:04 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/9] btrfs: fix double accounting race when
 extent_writepage_io() failed
To: Boris Burkov <boris@bur.io>, Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, stable@vger.kernel.org
References: <cover.1733983488.git.wqu@suse.com>
 <51e0c5f464256c4a59a872077d560cb56b7509a2.1733983488.git.wqu@suse.com>
 <20250108222458.GB1456944@zen.localdomain>
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
In-Reply-To: <20250108222458.GB1456944@zen.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:56GpRVFNgTSd/FsaIgnKHwyIzRUjqwov0MZVZSanGP0xw+9ZRUp
 aC56ZY3MWPwCAUKtVmAPNPx/IJgSWOwt/Ghv6y7QFBnBvI6kUZgvq6WeZRynZoMPRFBBILt
 Qq4XLLp57zQ2Gfyy+s0Q/2NlRJgljJCGnh3/dNuV/Y2qWKagA+aoFfhr/O0czLurchEJSU/
 KXpP5YKk8Sugk74NutlDA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:ZjRR/rZuuI0=;os1aQqvETpiPAIgfU3GKyRx55r7
 A7j59l4WpQQzlh8wLWoO3RuRZ3fZ4TGlHZWr+GjvbMXOfhk9futa+JojnAz5gmeWEvS8RPMSV
 OMX207uy8WTM/QV5Pmp1vXyZ2E84lDbTBdgMWTvCjgPjhdGDs6yO6kSzCJNmTpRBZJE2/DYMI
 7v1ML1ocp2ConIsapIMQChdTKFmkI680XCPE+E2CZhwRD4obcABW/X9iJaxcg5ItTT48J+K/Z
 jkSbXkZI6AxLT79+5pQ2We+qdNWLKr83WaKZ5+AKuCqsuk/Pk6XVZvF478Rkwp4gb+EnN7Ix/
 W+bb3x6WdaxeUJEYYT1LL4CRT1dO1CAT4F9/dVx+YYy8ywKSYYw6xx4ZA1pV+UKUPbOl/DP0p
 e59vWF79mvTjvOk9M+0S51u6lmsMc951UF5pe10xDpvZj3petYNM3p8hT30TWbFUokVNW0EaU
 u1AjIljLLAwoW3cTix7ZZprSOB9qF3LyKN0DWeRVz0GRSeeVod9f/qkQS534k+lMZ2C3nA4Vb
 gPMEY7UzzPtPIZGv/kT2fddsymGKs1e2g0G25c8yuGxpbvOl9h3EXOO+fe+iuJFe2LrrED6c+
 beYMeNfopEyDbDuCrR+3ltTax/nolDyE+RDlcDz+qgXItJ95lVFNpRFm0joFHFcM1AB92jTfW
 v7IzoihbymnIN1oYdyIE1+kRfcLmjTbx0dkz2Fo9d4WEkeoO1C47TbZ1MP+vIypjqTUxkhBUH
 EzOZO3Um+InIVGe1j+2xnr/8/gbjK/I2XFKMVDYujiG22cOuXU6J2SfeDk3XJYteQl3gc7Pqp
 ue/DWFYkfIHbuLN+VIRXiw5pjfeC0clCmbiiVGOSALzEsV16BSmdgxsOoWZJCrvDYc0pcWNqR
 8iWzKz9UfnXpFQOvJikcsbfG6Kqv9NU/XFZjE4VrTiHfDhxdseGly0F2fQBGe2FIzBizOti4h
 NRzPQDJEtngKYzTYTqJj+jEYO2Iz57F5ttiZgaX4kTRudFABvcK8u89iQ/kihs2/7AggfLaVl
 wI3ChFpTHdDrdFKL8KXjaEfQV7dJlo8uzTO5wGuDe/tg5wVBP30MFw3Cklmd18sZGyxsxy/s+
 gDkumCP4KsLMWGEmvzFzfX32kPKvsS



=E5=9C=A8 2025/1/9 08:54, Boris Burkov =E5=86=99=E9=81=93:
> On Thu, Dec 12, 2024 at 04:43:56PM +1030, Qu Wenruo wrote:
>> [BUG]
>> If submit_one_sector() failed inside extent_writepage_io() for sector
>> size < page size cases (e.g. 4K sector size and 64K page size), then
>> we can hit double ordered extent accounting error.
>>
>> This should be very rare, as submit_one_sector() only fails when we
>> failed to grab the extent map, and such extent map should exist inside
>> the memory and have been pinned.
>>
>> [CAUSE]
>> For example we have the following folio layout:
>>
>>      0  4K          32K    48K   60K 64K
>>      |//|           |//////|     |///|
>>
>> Where |///| is the dirty range we need to writeback. The 3 different
>> dirty ranges are submitted for regular COW.
>>
>> Now we hit the following sequence:
>>
>> - submit_one_sector() returned 0 for [0, 4K)
>>
>> - submit_one_sector() returned 0 for [32K, 48K)
>>
>> - submit_one_sector() returned error for [60K, 64K)
>>
>> - btrfs_mark_ordered_io_finished() called for the whole folio
>>    This will mark the following ranges as finished:
>>    * [0, 4K)
>>    * [32K, 48K)
>>      Both ranges have their IO already submitted, this cleanup will
>>      lead to double accounting.
>>
>>    * [60K, 64K)
>>      That's the correct cleanup.
>>
>> The only good news is, this error is only theoretical, as the target
>> extent map is always pinned, thus we should directly grab it from
>> memory, other than reading it from the disk.
>>
>> [FIX]
>> Instead of calling btrfs_mark_ordered_io_finished() for the whole folio
>> range, which can touch ranges we should not touch, instead
>> move the error handling inside extent_writepage_io().
>>
>> So that we can cleanup exact sectors that are ought to be submitted but
>> failed.
>>
>> This provide much more accurate cleanup, avoiding the double accounting=
.
>
> Analysis and fix both make sense to me. However, this one feels a lot
> more fragile than the other one.
>
> It relies on submit_one_sector being the only error path in
> extent_writepage_io. Any future error in the loop would have to create a
> shared "per sector" error handling goto in the loop I guess?

In the long run I'm planning to make extent_writepage_io() to have no
error path, by:

- Remove cow fixup mechanism completely

- Call extent_writepage_io() immediately after each delalloc range has
   OE allocated
   By this we will always have a valid extent map, thus no way to error
   out.

So at least the function extent_writepage_io() should not get more error
paths, but only less.

>
> Not a hard "no", in the sense that I think the code is correct for now
> (aside from my submit_one_bio question) but curious if we can give this
> some more principled structure.
>
> Thanks,
> Boris
>
>>
>> Cc: stable@vger.kernel.org # 5.15+
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>>   fs/btrfs/extent_io.c | 32 +++++++++++++++++++-------------
>>   1 file changed, 19 insertions(+), 13 deletions(-)
>>
>> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
>> index 417c710c55ca..b6a4f1765b4c 100644
>> --- a/fs/btrfs/extent_io.c
>> +++ b/fs/btrfs/extent_io.c
>> @@ -1418,6 +1418,7 @@ static noinline_for_stack int extent_writepage_io=
(struct btrfs_inode *inode,
>>   	struct btrfs_fs_info *fs_info =3D inode->root->fs_info;
>>   	unsigned long range_bitmap =3D 0;
>>   	bool submitted_io =3D false;
>> +	bool error =3D false;
>>   	const u64 folio_start =3D folio_pos(folio);
>>   	u64 cur;
>>   	int bit;
>> @@ -1460,11 +1461,21 @@ static noinline_for_stack int extent_writepage_=
io(struct btrfs_inode *inode,
>>   			break;
>>   		}
>>   		ret =3D submit_one_sector(inode, folio, cur, bio_ctrl, i_size);
>> -		if (ret < 0)
>> -			goto out;
>> +		if (unlikely(ret < 0)) {
>> +			submit_one_bio(bio_ctrl);
>
> This submit_one_bio is confusing to me. submit_one_sector failed and the
> subsequent comment says "there is no bio submitted" yet right here we
> call submit_one_bio.
>
> What is the meaning of it?

It to make sure we have submit the existing bio.

This is a little overkilled, because we have one submit_write_bio() at
immediately after extent_write_cache_pages() call.

But that's exactly a pattern of delayed cleanup, also an easy bug prone
(just like the OE cleanup I'm fixing), so I explicitly added a
submission for it.

I'll add extra comments explaining it.

Thanks,
Qu
>
>> +			/*
>> +			 * Failed to grab the extent map which should be very rare.
>> +			 * Since there is no bio submitted to finish the ordered
>> +			 * extent, we have to manually finish this sector.
>> +			 */
>> +			btrfs_mark_ordered_io_finished(inode, folio, cur,
>> +					fs_info->sectorsize, false);
>> +			error =3D true;
>> +			continue;
>> +		}
>>   		submitted_io =3D true;
>>   	}
>> -out:
>> +
>>   	/*
>>   	 * If we didn't submitted any sector (>=3D i_size), folio dirty get
>>   	 * cleared but PAGECACHE_TAG_DIRTY is not cleared (only cleared
>> @@ -1472,8 +1483,11 @@ static noinline_for_stack int extent_writepage_i=
o(struct btrfs_inode *inode,
>>   	 *
>>   	 * Here we set writeback and clear for the range. If the full folio
>>   	 * is no longer dirty then we clear the PAGECACHE_TAG_DIRTY tag.
>> +	 *
>> +	 * If we hit any error, the corresponding sector will still be dirty
>> +	 * thus no need to clear PAGECACHE_TAG_DIRTY.
>>   	 */
>
> submitted_io is only used for this bit of logic, so you could consider
> changing this logic by keeping a single variable for whether or not we
> should go into this logic (naming it seems kind of annoying) and then
> setting it in both the error and submitted_io paths. I think that
> reduces headache in thinking about boolean logic, slightly.
>
>> -	if (!submitted_io) {
>> +	if (!submitted_io && !error) {
>>   		btrfs_folio_set_writeback(fs_info, folio, start, len);
>>   		btrfs_folio_clear_writeback(fs_info, folio, start, len);
>>   	}
>> @@ -1493,7 +1507,6 @@ static int extent_writepage(struct folio *folio, =
struct btrfs_bio_ctrl *bio_ctrl
>>   {
>>   	struct inode *inode =3D folio->mapping->host;
>>   	struct btrfs_fs_info *fs_info =3D inode_to_fs_info(inode);
>> -	const u64 page_start =3D folio_pos(folio);
>>   	int ret;
>>   	size_t pg_offset;
>>   	loff_t i_size =3D i_size_read(inode);
>> @@ -1536,10 +1549,6 @@ static int extent_writepage(struct folio *folio,=
 struct btrfs_bio_ctrl *bio_ctrl
>>
>>   	bio_ctrl->wbc->nr_to_write--;
>>
>> -	if (ret)
>> -		btrfs_mark_ordered_io_finished(BTRFS_I(inode), folio,
>> -					       page_start, PAGE_SIZE, !ret);
>> -
>>   done:
>>   	if (ret < 0)
>>   		mapping_set_error(folio->mapping, ret);
>> @@ -2319,11 +2328,8 @@ void extent_write_locked_range(struct inode *ino=
de, const struct folio *locked_f
>>   		if (ret =3D=3D 1)
>>   			goto next_page;
>>
>> -		if (ret) {
>> -			btrfs_mark_ordered_io_finished(BTRFS_I(inode), folio,
>> -						       cur, cur_len, !ret);
>> +		if (ret)
>>   			mapping_set_error(mapping, ret);
>> -		}
>>   		btrfs_folio_end_lock(fs_info, folio, cur, cur_len);
>>   		if (ret < 0)
>>   			found_error =3D true;
>> --
>> 2.47.1
>>
>


