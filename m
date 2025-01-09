Return-Path: <linux-btrfs+bounces-10878-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D55AA0816D
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Jan 2025 21:35:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DD333A8778
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Jan 2025 20:35:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2F3B1FCFF7;
	Thu,  9 Jan 2025 20:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="QRFTbNAM"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 697E1B677;
	Thu,  9 Jan 2025 20:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736454901; cv=none; b=pRVObZ634L6d7UsTV5t0WLtB1dh1TjgZoMSbnlV81++LAcVJwSWi8lyUCOIFFaSnx0dOByet8LqeQAqBKsrOG/v7FFXyrT73OACzMhkFBoDyIG+X1/CAngs+MjKg+hE77NoqW8LGwJ1eq1PrtHKuO9IEO5i78xyQKxjgin0a2cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736454901; c=relaxed/simple;
	bh=fpX9ilX8ud4NwJ5Rd7zd+pUtWeUCO4Is5o8WnOVDF5g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kuV1Tj7H8nc2kdfgouyGoVIlqv4/EmTQiAWH3S8zamPB7oMUV+0ErtKgt8B9Ae9hfK6I4/enPgj5SQu0CqwaP9O8M1I4lmvb8jBiyOhy/xeSUEG3cgpIlowaKw1ehCD8YGmm/un09vF+vtouRVjrKeJFeX8KFlpEZxqUgMNKkRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=QRFTbNAM; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1736454893; x=1737059693; i=quwenruo.btrfs@gmx.com;
	bh=l9Aku3xD+vCDV23tHPGgibSS+82F2JYrssNvL6RYP3Q=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=QRFTbNAM5kFj9q23hB4EyqKEZaTNmE9lb+QP3hNv+mQjMJ6Wr0rJ8CWISionhiGb
	 jQMfVdIiGjk7XtqBc/Xs/dvJ90coXg3VTld3fsUQWgGDUS+X4lFcfhoe8Y5R3u1ux
	 EtxrsYdp8tfxg+bKZqnk41u431QDBKPQTRn3Cd9gqxVjx7hqhdHCwU1yfL1fyEYgt
	 ANt/uV+0nLdnNF8iybZB3ooBIFimy1ku7tXl6BkuL2jRPa7kglSIAlnZSs09L2WSI
	 V3gzGrUzhSNo5hWrwjsH153cedNRAva2yx97jCxv1AkiYKCQXqsJ9NYnVeY+3R1Z4
	 LBrSyWKBACdKuP5Oaw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MY6Cb-1u4OGH3CMH-00LKvL; Thu, 09
 Jan 2025 21:34:53 +0100
Message-ID: <5914c71d-26da-49d0-a6df-3909d52450d8@gmx.com>
Date: Fri, 10 Jan 2025 07:04:49 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/9] btrfs: fix double accounting race when
 extent_writepage_io() failed
To: Boris Burkov <boris@bur.io>
Cc: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org,
 stable@vger.kernel.org
References: <cover.1733983488.git.wqu@suse.com>
 <51e0c5f464256c4a59a872077d560cb56b7509a2.1733983488.git.wqu@suse.com>
 <20250108222458.GB1456944@zen.localdomain>
 <deea65a5-8870-4c33-9446-7d531b4b8451@gmx.com>
 <20250109180624.GA1932498@zen.localdomain>
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
In-Reply-To: <20250109180624.GA1932498@zen.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:GXryWXQPb/zSV/21ownULsKHHc8varNtUJ95ZKhwORwf2iU5+tw
 8OwhFPYyxYWx2+/96br6Lpn+H6H+t0ZrODBTwDX04OMoq85iAybuYfpM7BIp9tVBSNeHL4W
 aSox8/YkYNS/84DQcv8bUkv5GDVRgT7Qsyy2DHpzCWemnYp6YWM6NWIISS66TfiwTTtZluR
 Z+q9lwAmd6irNHTGiOAQg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:lghlKbPAy6I=;KNf/pqVCkUZT19jqf1Vx85w5lOE
 JzCPyJ5BP11+nFpv+exWqnm0FpLeSEapC+NN8xW6c0olyKkJH8G5Fk3ENwag7PcMhLweFd7X3
 K0A4A9/Pg3Hpzxth1UoFJDQb5n/HGxDONDRl4Pk1bd80aLO44U3unDtrf91iCzmX3Yd9ePccm
 FdPYo21LNfkHpTXxvyR6aEUs0Zu+FWRu7GH8QkrSJYCrmzljjBg43MIoFWTUraqsxw5qfGBaQ
 z+N/6ojNA4cFDKrUlF08RVBw6x+NjFeGwrJStmCU7mjJ2tZzQrKTr4i/jLU1JPZOBKz9kSEnx
 PDPBx0dTGKZqTn6r5kRZ0TUGFhCRhksxq3GZ+u5yJ/C5vWvMtyNvhz9H5yPlxeUW9Zj28HZuK
 JCJXGa2qZJXzRTCJZnakV59bzVL5fIRhIg5GptopxInuOvrJqCQjNsWC9an9NYd2xVfFQLboJ
 I4v9kh1CqDlAhNFKCpdUwpIxc95VqkdI9rGhKrrC07IVIlAHVzSDgVsxMgWAZkgPONh8AmS8H
 lEUd4c+DL/Hzcje6m6+HSvG1zFTcAGRWxpZhKbYIzIa80Sl3+h5LsggcW+Iu8xbdJ+wItsEy6
 pD5WAs4ERKor2BY+536yEGEI/1CO94uoVuWQCkXLGL4ydgAcwPoDy08x8PlBWbmQxrIHMLKYY
 LJCT63k6FqWT93JeO9QBJWK8OmQkAq9Xlx/ibZzGHpTJ33NMP1+ObEevohL91LlC+N3zi5g4B
 o2/TuV9kNS8j2NtDAPw8noF0XrIs1tndtVHTkmzuJTmMj/NpKPpdQDUToPapzHw863aGb0LBR
 +XIzKDe48kpvOBivE9VZhKUPQpmc6gKx84RnzWqqdf2b2HIQYTOrinMrPim1yQlcpQqt0gCyV
 WnjDmQynQLlwTwCVeKidGbegPeKJq781l2Ml0zJLAiG0/1QckG8KOgt8ZKkG/gRlBcj5hjx4/
 Y7Gy4dCVxIb1tIrR1DWiqKEwU90yLMieCVdTpKKx8POs6WZVAsOwTRm5S/i2llk9s6P1fRnFs
 2+qcZrd7nKYcpg4Vo9jro76PnPrUef6u7S8GuHK2pb46+6EcCnh9w1j90sNcEiqBSGx3i59P6
 ev8zrhR8chuHsc1e0XijdSPbnzFkvy



=E5=9C=A8 2025/1/10 04:36, Boris Burkov =E5=86=99=E9=81=93:
> On Thu, Jan 09, 2025 at 02:15:06PM +1030, Qu Wenruo wrote:
>>
>>
>> =E5=9C=A8 2025/1/9 08:54, Boris Burkov =E5=86=99=E9=81=93:
>>> On Thu, Dec 12, 2024 at 04:43:56PM +1030, Qu Wenruo wrote:
>>>> [BUG]
>>>> If submit_one_sector() failed inside extent_writepage_io() for sector
>>>> size < page size cases (e.g. 4K sector size and 64K page size), then
>>>> we can hit double ordered extent accounting error.
>>>>
>>>> This should be very rare, as submit_one_sector() only fails when we
>>>> failed to grab the extent map, and such extent map should exist insid=
e
>>>> the memory and have been pinned.
>>>>
>>>> [CAUSE]
>>>> For example we have the following folio layout:
>>>>
>>>>       0  4K          32K    48K   60K 64K
>>>>       |//|           |//////|     |///|
>>>>
>>>> Where |///| is the dirty range we need to writeback. The 3 different
>>>> dirty ranges are submitted for regular COW.
>>>>
>>>> Now we hit the following sequence:
>>>>
>>>> - submit_one_sector() returned 0 for [0, 4K)
>>>>
>>>> - submit_one_sector() returned 0 for [32K, 48K)
>>>>
>>>> - submit_one_sector() returned error for [60K, 64K)
>>>>
>>>> - btrfs_mark_ordered_io_finished() called for the whole folio
>>>>     This will mark the following ranges as finished:
>>>>     * [0, 4K)
>>>>     * [32K, 48K)
>>>>       Both ranges have their IO already submitted, this cleanup will
>>>>       lead to double accounting.
>>>>
>>>>     * [60K, 64K)
>>>>       That's the correct cleanup.
>>>>
>>>> The only good news is, this error is only theoretical, as the target
>>>> extent map is always pinned, thus we should directly grab it from
>>>> memory, other than reading it from the disk.
>>>>
>>>> [FIX]
>>>> Instead of calling btrfs_mark_ordered_io_finished() for the whole fol=
io
>>>> range, which can touch ranges we should not touch, instead
>>>> move the error handling inside extent_writepage_io().
>>>>
>>>> So that we can cleanup exact sectors that are ought to be submitted b=
ut
>>>> failed.
>>>>
>>>> This provide much more accurate cleanup, avoiding the double accounti=
ng.
>>>
>>> Analysis and fix both make sense to me. However, this one feels a lot
>>> more fragile than the other one.
>>>
>>> It relies on submit_one_sector being the only error path in
>>> extent_writepage_io. Any future error in the loop would have to create=
 a
>>> shared "per sector" error handling goto in the loop I guess?
>>>
>>> Not a hard "no", in the sense that I think the code is correct for now
>>> (aside from my submit_one_bio question) but curious if we can give thi=
s
>>> some more principled structure.
>>>
>>> Thanks,
>>> Boris
>>>
>>>>
>>>> Cc: stable@vger.kernel.org # 5.15+
>>>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>>>> ---
>>>>    fs/btrfs/extent_io.c | 32 +++++++++++++++++++-------------
>>>>    1 file changed, 19 insertions(+), 13 deletions(-)
>>>>
>>>> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
>>>> index 417c710c55ca..b6a4f1765b4c 100644
>>>> --- a/fs/btrfs/extent_io.c
>>>> +++ b/fs/btrfs/extent_io.c
>>>> @@ -1418,6 +1418,7 @@ static noinline_for_stack int extent_writepage_=
io(struct btrfs_inode *inode,
>>>>    	struct btrfs_fs_info *fs_info =3D inode->root->fs_info;
>>>>    	unsigned long range_bitmap =3D 0;
>>>>    	bool submitted_io =3D false;
>>>> +	bool error =3D false;
>>>>    	const u64 folio_start =3D folio_pos(folio);
>>>>    	u64 cur;
>>>>    	int bit;
>>>> @@ -1460,11 +1461,21 @@ static noinline_for_stack int extent_writepag=
e_io(struct btrfs_inode *inode,
>>>>    			break;
>>>>    		}
>>>>    		ret =3D submit_one_sector(inode, folio, cur, bio_ctrl, i_size);
>>>> -		if (ret < 0)
>>>> -			goto out;
>>>> +		if (unlikely(ret < 0)) {
>>>> +			submit_one_bio(bio_ctrl);
>>>
>>> This submit_one_bio is confusing to me. submit_one_sector failed and t=
he
>>> subsequent comment says "there is no bio submitted" yet right here we
>>> call submit_one_bio.
>>>
>>> What is the meaning of it?
>>>
>>>> +			/*
>>>> +			 * Failed to grab the extent map which should be very rare.
>>>> +			 * Since there is no bio submitted to finish the ordered
>>>> +			 * extent, we have to manually finish this sector.
>>>> +			 */
>>>> +			btrfs_mark_ordered_io_finished(inode, folio, cur,
>>>> +					fs_info->sectorsize, false);
>>>> +			error =3D true;
>>>> +			continue;
>>>> +		}
>>>>    		submitted_io =3D true;
>>>>    	}
>>>> -out:
>>>> +
>>>>    	/*
>>>>    	 * If we didn't submitted any sector (>=3D i_size), folio dirty g=
et
>>>>    	 * cleared but PAGECACHE_TAG_DIRTY is not cleared (only cleared
>>>> @@ -1472,8 +1483,11 @@ static noinline_for_stack int extent_writepage=
_io(struct btrfs_inode *inode,
>>>>    	 *
>>>>    	 * Here we set writeback and clear for the range. If the full fol=
io
>>>>    	 * is no longer dirty then we clear the PAGECACHE_TAG_DIRTY tag.
>>>> +	 *
>>>> +	 * If we hit any error, the corresponding sector will still be dirt=
y
>>>> +	 * thus no need to clear PAGECACHE_TAG_DIRTY.
>>>>    	 */
>>>
>>> submitted_io is only used for this bit of logic, so you could consider
>>> changing this logic by keeping a single variable for whether or not we
>>> should go into this logic (naming it seems kind of annoying) and then
>>> setting it in both the error and submitted_io paths. I think that
>>> reduces headache in thinking about boolean logic, slightly.
>>
>> Unfortunately I can not find a good alternative to this double boolean
>> usages.
>>
>> I can go a single boolean, but it will be called something like
>> @no_error_nor_submission.
>>
>> Which is the not only the worst naming, but also a hell of boolean
>> operations for a single bool.
>
> I think you could do something like:
>
> needs_reset_writeback =3D false;

Unfortunately, that will not work if setting it to false.

We have to set it default to true, and only set it to false in the error
or submission path.

This also means, we need to explain why we need to set the bool to false
in both paths (aka, duplicated comments)

> then set it to true in either case, whether you submit an io or hit an
> error.
>
> It's your call, though, I won't be upset if you leave it as is.

I'm afraid I'll leave it as is for now.

And hope in the future we can remove the @error bool by removing the the
extent map related error path at least.

Thanks,
Qu

>
>>
>> So I'm afraid the @error and @submitted_io will still be better for thi=
s
>> case.
>>
>> The other comments will be addressed properly.
>>
>> Thanks,
>> Qu
>>>
>>>> -	if (!submitted_io) {
>>>> +	if (!submitted_io && !error) {
>>>>    		btrfs_folio_set_writeback(fs_info, folio, start, len);
>>>>    		btrfs_folio_clear_writeback(fs_info, folio, start, len);
>>>>    	}
>>>> @@ -1493,7 +1507,6 @@ static int extent_writepage(struct folio *folio=
, struct btrfs_bio_ctrl *bio_ctrl
>>>>    {
>>>>    	struct inode *inode =3D folio->mapping->host;
>>>>    	struct btrfs_fs_info *fs_info =3D inode_to_fs_info(inode);
>>>> -	const u64 page_start =3D folio_pos(folio);
>>>>    	int ret;
>>>>    	size_t pg_offset;
>>>>    	loff_t i_size =3D i_size_read(inode);
>>>> @@ -1536,10 +1549,6 @@ static int extent_writepage(struct folio *foli=
o, struct btrfs_bio_ctrl *bio_ctrl
>>>>
>>>>    	bio_ctrl->wbc->nr_to_write--;
>>>>
>>>> -	if (ret)
>>>> -		btrfs_mark_ordered_io_finished(BTRFS_I(inode), folio,
>>>> -					       page_start, PAGE_SIZE, !ret);
>>>> -
>>>>    done:
>>>>    	if (ret < 0)
>>>>    		mapping_set_error(folio->mapping, ret);
>>>> @@ -2319,11 +2328,8 @@ void extent_write_locked_range(struct inode *i=
node, const struct folio *locked_f
>>>>    		if (ret =3D=3D 1)
>>>>    			goto next_page;
>>>>
>>>> -		if (ret) {
>>>> -			btrfs_mark_ordered_io_finished(BTRFS_I(inode), folio,
>>>> -						       cur, cur_len, !ret);
>>>> +		if (ret)
>>>>    			mapping_set_error(mapping, ret);
>>>> -		}
>>>>    		btrfs_folio_end_lock(fs_info, folio, cur, cur_len);
>>>>    		if (ret < 0)
>>>>    			found_error =3D true;
>>>> --
>>>> 2.47.1
>>>>
>>>
>>
>


