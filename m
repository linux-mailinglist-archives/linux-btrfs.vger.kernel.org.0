Return-Path: <linux-btrfs+bounces-10810-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C0D2A06C7C
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Jan 2025 04:45:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD37918870E9
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Jan 2025 03:45:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 072631632E4;
	Thu,  9 Jan 2025 03:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="LQ58jHJg"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3105715A848;
	Thu,  9 Jan 2025 03:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736394318; cv=none; b=NEcvLKEeLpifdLkPsktHkZ8jBB5xJbkXnpkpEZEdxTOVmF/FzlbxnGMgnCfnEU0yBej8CXHxGFrRfWlguZ6WORqG4SlX1Ppo6IshN9WF03x55HK0xEGdJTrG7gQOc7ghXLcZvyPIkuln5LuTxDtkjoQ8qvuKfGoe5mIZ50Z6D4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736394318; c=relaxed/simple;
	bh=y8DGOB4LM2ZR6Z/yaPdemZTIeq3ttIsHR6F/flatJvA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lAmAHRYvKh2GsFlwHvng6IIo2YAGl87e60zYoi8QwNAt5og4oL8Bte8H64Ht9GeFyerp+WkhDbQxZPhoh97IOjuOF/wPPX5NODJ21SDR9LCHxy7xaVVKpGdef4rPEqZtuLsf4vKL4i2agobPIExFDbqGhtpScX4CJQSDyC9s+0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=LQ58jHJg; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1736394309; x=1736999109; i=quwenruo.btrfs@gmx.com;
	bh=OQEDOZZuxdXebSwGZ+PCSqu9/qulW1yF7vf/tpLyAWE=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=LQ58jHJgCpXgxPjC9lyxjPnTqimc/qbgidVZhvtEwMGKNHGargkB5IWmR3sTovgT
	 O++1CP4+Tua6yw7tvuRTaTcpC4M2i/fqijVMFEepUmno1hJf34CM5J/U6fpd0+ewS
	 TrBB5M6HNgED8LReD2WHIz4lvHl0O3WcCeCSfDgyatDGyr8OQ7lCmOOqwX4xX3ZXC
	 CL61aPLhE7sNXEsdjVuM9itPkJlA+m7CQOy5OQ/qjFaaa5M/B3/QzbmCL4ll1pWdc
	 qKZgjiOTd2c249UwUPeiVgVsdboP1wmMmETvDHt9gVTM7nusM/z+/t/BV1tNeOHP4
	 ZFIsrzEKeFUHeIy7Kw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MdvmY-1u3PbX1Ft0-00o9YD; Thu, 09
 Jan 2025 04:45:09 +0100
Message-ID: <deea65a5-8870-4c33-9446-7d531b4b8451@gmx.com>
Date: Thu, 9 Jan 2025 14:15:06 +1030
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
X-Provags-ID: V03:K1:iDksX7qNpJkVImqjvzIxtOt4ImKJ66qZbz7HyW+4PctlDKOAKot
 N4u7oa6tonc6vuK/AMjT7hLOdkbNIIYWWFR76pZJaO+snQk6zq2kS7OMzr4iS+B73sUz1qI
 Q0tdGTqiWY117S90OZ3gHuhbFDsOJWYCO6MNEOhDdTlQATitLAL5KrIDjtugIscQGw0pDY8
 IyMkzUA27Ej5HPr4VVl/A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:YPIrflijl00=;w3d7aN2vfgFvZHdV0S+zpJmjDHk
 LEYJ5Zg1auLuz3GdKUolwJn81LPuztgfIcS2I+LmK47PZr05QbhYPVcsq3ExOI5NZmUXuj82T
 zM2AyoyRGmbIO9bXl8kdJAIdYqd1Pg72H8x9CnV3XhjTFb/nytO/zJz8ACmr1O+3IENiYhAfd
 cGreAewx9Bz/RzVbySWK2nvlad90hg/gnJV4p/t99UhE24RXYDedj3o6hetvpAPd5uNP+EbXu
 jiVWl4C7cOU4yNPhHR83GWDdWyVEdozLi6yURP2WwzGjgay+/xKnN/ameu1xRN2+DQzp0QPKr
 wtLU+b00ydusK6Org1mwDgznZ7qfluP7OitlHjFGmfCTye2ggYx/ym0c7+oerkd/IfblS6cKt
 dcxw8YWe+udRoOfxVfLiiIkZuqgM/VPlFyLnyQOT7YnW/plNmeLuvxgX/wvybl69QAFtRHyqZ
 1ngCb2WOOGvSEOzFRHRMzsxYQsuXkXz3tcsTTvf40mGm2LARhs7jUz+f75JcrzJSXyapefrdP
 pEEgfbc/DUCwD84i+K3ZKAEJHzsIWjiLdAvvUjURj7rezXgcn07PdeWFU3fgN10GMmF530bEi
 tHQmD4B5mXbrkmsqjyg9cI/ObLm2YWzBxIvefbTef1taskCvR5B8UhSmvp4/v5fCvny7M4QTB
 GaAqRWKtjPyagZgZ2nMcHcXyWJxi+6C2KuQ0ZgOmd/ugqLEXXAxyQsAA9znRauAnUsKd0cFN4
 k/sVg07MWw2BlEfNo6Flj2D5P469pG4pz8PPjD7J/EXgSLj75yEuRHMMP5uiP1G1qgw5AayH6
 wfu3yuq3ok5veXtc7wu8Lp/12DmxQjLsnowulXcErLlQi8hIqCMENz6PcMF4YIylP+KPqLFpX
 E0ZiOfdP926epQ2kh1fDv8jvSSvDv51kUQi8LTMgmDoegVO5r1wZAWAYzOIiOteRS7sKM6Qjo
 kbw2vRIzLeXKATt6CQ93qal2e4TSFZ41pZqqx0g0zQRzYAAy7GMVmGpzUjxP1kuHZu/YE+mb8
 Nk+ihYeUP5D02C9ss1BZVTfvIY0kyis1aAjUYD/qGOxj2ccvNrD168RqQ5q4MjFw6phChzaGd
 Nk9IqL+j7A3CybqJesofdaoiaAMcH+



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

Unfortunately I can not find a good alternative to this double boolean
usages.

I can go a single boolean, but it will be called something like
@no_error_nor_submission.

Which is the not only the worst naming, but also a hell of boolean
operations for a single bool.

So I'm afraid the @error and @submitted_io will still be better for this
case.

The other comments will be addressed properly.

Thanks,
Qu
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


