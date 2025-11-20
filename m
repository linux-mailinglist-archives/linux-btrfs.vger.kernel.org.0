Return-Path: <linux-btrfs+bounces-19179-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EBBCFC71AA1
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Nov 2025 02:12:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 00EFE349EE7
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Nov 2025 01:12:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3ACE23504B;
	Thu, 20 Nov 2025 01:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="bGDEctcq"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC664244684
	for <linux-btrfs@vger.kernel.org>; Thu, 20 Nov 2025 01:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763601091; cv=none; b=hVmPbvGb2LHxB7oOVGStHE5HEVctMMx5Rbuo7D1zrtfwmTKIiIXVZE7jH33LIfLwkdoPIov2tsa/BX6pdhYRaYf0oaTtu6nVIJs3+e5MIcjGFVZa4LtsY0/p3uWM7Z/ZOoMZ2ZiVtRYqSr52USnG9Ao/I37rMgjNE4pdEtjB3uY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763601091; c=relaxed/simple;
	bh=mR1N16h3RD/wpVKbOUqvoi4xA3Q9DHp4KIRAc2Uyd1o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IOWSltdiWAFBvY/CXVJdB3g5HjoKfEaBkoMKwYjMqTPXLVgwvXOVgpuulVpUDzEHVMVCr2Y41sPMr31C28rE5fdIyCyLa9n1Fu0QqXRj5mPd5K7WCBmWvnqhnGAGY9qNcjKfek4Ot5FAmxenfejs1ff+nCtKlOxh0mIK3F860Jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=bGDEctcq; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1763601086; x=1764205886; i=quwenruo.btrfs@gmx.com;
	bh=beVrf44o/Gd0Mdiy5nmpXQcLPQ+sOwDa2MmXJb6Tw0Q=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=bGDEctcqHYlN5WXRvkE6cLaXHRxAa34k98GTdhseOtEZQptyqW5ksPa+7oy++phR
	 /U7sAXyS+X7F2pb/+TxjC60F3Wu15BOpCW5bhi8OdqFk8izFyRjSF9F+LVqgX0gWO
	 UtWfIhcAOupynnixURYAsjXVRCbdiGq+TSZCFkS8OXN07kM6cwWlIEhsyug6aDpxE
	 +suvgTAS/z8g0b2oHnnIFJYOLdlPWcQba+u1wDMs9blr8t5BlG9onSdmeCxQYVSvR
	 RnylxnuPjKt//GI2SHWye5g/ZuidFHGqIao7oihi+zJvBEnh9WdB9e88SHSOqlXvV
	 qzqVeJBnDO7LFkDPZw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MAwbp-1vSiov2Xub-008rEB; Thu, 20
 Nov 2025 02:11:26 +0100
Message-ID: <df5b9f51-67cf-4ba9-9027-e8b6d05a0b80@gmx.com>
Date: Thu, 20 Nov 2025 11:41:20 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] btrfs: extract the io finishing code into a helper
To: Boris Burkov <boris@bur.io>, Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
References: <cover.1763596717.git.wqu@suse.com>
 <bd044ad0afecc8d8f65700800cf45939f7bb2d88.1763596717.git.wqu@suse.com>
 <20251120005924.GA2522273@zen.localdomain>
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
In-Reply-To: <20251120005924.GA2522273@zen.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:JCVGjTg4jIXyjMsNXwjVFPh+ql+VlUrUH5jF10WxiUbpxPHx7O+
 wiyeDhtyAqMLmZV7Pn4soM9lFhm2Gd58NvIXATpKgzhLVOhU7My0ajTzKSG7Kf+WuKu48ev
 b6fpt/0qkO0E5G/Vmvrl69rIeFPcugJnRNXRDw+bsFzLo/hUqKpFtfKzV6OQhPTIDapaZXU
 SXVT1nMvNxDerBj6NcrjQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:5uf/drQmlXs=;sIbPKXE2ddv95Z75GfnH71vGMS+
 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
 a1/gSGjgLYScVFst7ygRhYHwqmD+ok+XVkLvIs



=E5=9C=A8 2025/11/20 11:29, Boris Burkov =E5=86=99=E9=81=93:
> On Thu, Nov 20, 2025 at 10:34:32AM +1030, Qu Wenruo wrote:
>> Currently we have a code block, which finishes IO for a range beyond
>> i_size, deep inside the loop of extent_writepage_io().
>>
>> Extract it into a helper, finish_io_beyond_eof(), to reduce the level
>> of indents.
>>
>> Furthermore slightly change the parameter passed into the helper,
>> currently we fully finish the IO for the range beyond EOF, but that
>> range may be beyond the range [start, start + len), that means we may
>> finish the IO for ranges which we should not touch.
>=20
> I'm a little confused about this. I can't see any changes to the
> effective parameters to anything but btrfs_lookup_first_ordered_range()
> but that is getting the first ordered_extent
>=20
> So allowing more past [cur, end] via [cur, folio_end] shouldn't change
> what ordered_extent we get, as we are asserting that we get one with
> the narrower search, and we are getting the first one.
>=20
> the params to min(), btrfs_mark_ordered_io_finished(), and
> btrfs_clear_folio_dirty() seem unchanged.

My bad, I was reading the original code wrong, assuming it's clearing=20
the IO to @folio_end not @end.

So this part is not changed.


On the other hand, we can not rely on btrfs_lookup_first_ordered_range()=
=20
to catch all OEs for a range.
That part only works if there is only one OE for the range.
If there are multiple ones, the remaining OEs are not truncated.

Will update the commit message and the handling of=20
finish_io_beyond_eof() to ensure all involved OEs are properly truncated.
(This also affects  the old code though).

Thanks,
Qu

>=20
> What am I missing?
>=20
> Thanks,
> Boris
>=20
>>
>> So call the finish_io_beyond_eof() only for the range we should touch.
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>>   fs/btrfs/extent_io.c | 62 +++++++++++++++++++++++++------------------=
-
>>   1 file changed, 35 insertions(+), 27 deletions(-)
>>
>> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
>> index 4fc3b3d776ee..cbee93a929f3 100644
>> --- a/fs/btrfs/extent_io.c
>> +++ b/fs/btrfs/extent_io.c
>> @@ -1684,6 +1684,40 @@ static int submit_one_sector(struct btrfs_inode =
*inode,
>>   	return 0;
>>   }
>>  =20
>> +static void finish_io_beyond_eof(struct btrfs_inode *inode, struct fol=
io *folio, > +				 u64 start, u32 len, loff_t i_size)
>> +{
>> +	struct btrfs_fs_info *fs_info =3D inode->root->fs_info;
>> +	struct btrfs_ordered_extent *ordered;
>> +
>> +	ASSERT(start >=3D i_size);
>> +
>> +	ordered =3D btrfs_lookup_first_ordered_range(inode, start, len);
>> +
>> +	/*
>> +	 * We have just run delalloc before getting here, so
>> +	 * there must be an ordered extent.
>> +	 */
>> +	ASSERT(ordered !=3D NULL);
>> +	spin_lock(&inode->ordered_tree_lock);
>> +	set_bit(BTRFS_ORDERED_TRUNCATED, &ordered->flags);
>> +	ordered->truncated_len =3D min(ordered->truncated_len,
>> +				     start - ordered->file_offset);
>> +	spin_unlock(&inode->ordered_tree_lock);
>> +	btrfs_put_ordered_extent(ordered);
>> +
>> +	btrfs_mark_ordered_io_finished(inode, folio, start, len, true);
>> +	/*
>> +	 * This range is beyond i_size, thus we don't need to
>> +	 * bother writing back.
>> +	 * But we still need to clear the dirty subpage bit, or
>> +	 * the next time the folio gets dirtied, we will try to
>> +	 * writeback the sectors with subpage dirty bits,
>> +	 * causing writeback without ordered extent.
>> +	 */
>> +	btrfs_folio_clear_dirty(fs_info, folio, start, len);
>> +}
>> +
>>   /*
>>    * Helper for extent_writepage().  This calls the writepage start hoo=
ks,
>>    * and does the loop to map the page into extents and bios.
>> @@ -1739,33 +1773,7 @@ static noinline_for_stack int extent_writepage_i=
o(struct btrfs_inode *inode,
>>   		cur =3D folio_pos(folio) + (bit << fs_info->sectorsize_bits);
>>  =20
>>   		if (cur >=3D i_size) {
>> -			struct btrfs_ordered_extent *ordered;
>> -
>> -			ordered =3D btrfs_lookup_first_ordered_range(inode, cur,
>> -								   folio_end - cur);
>> -			/*
>> -			 * We have just run delalloc before getting here, so
>> -			 * there must be an ordered extent.
>> -			 */
>> -			ASSERT(ordered !=3D NULL);
>> -			spin_lock(&inode->ordered_tree_lock);
>> -			set_bit(BTRFS_ORDERED_TRUNCATED, &ordered->flags);
>> -			ordered->truncated_len =3D min(ordered->truncated_len,
>> -						     cur - ordered->file_offset);
>> -			spin_unlock(&inode->ordered_tree_lock);
>> -			btrfs_put_ordered_extent(ordered);
>> -
>> -			btrfs_mark_ordered_io_finished(inode, folio, cur,
>> -						       end - cur, true);
>> -			/*
>> -			 * This range is beyond i_size, thus we don't need to
>> -			 * bother writing back.
>> -			 * But we still need to clear the dirty subpage bit, or
>> -			 * the next time the folio gets dirtied, we will try to
>> -			 * writeback the sectors with subpage dirty bits,
>> -			 * causing writeback without ordered extent.
>> -			 */
>> -			btrfs_folio_clear_dirty(fs_info, folio, cur, end - cur);
>> +			finish_io_beyond_eof(inode, folio, cur, start + len - cur, i_size);
>=20
> AFAICT, start + len is still end here, why not do end - cur?
>=20
>>   			break;
>>   		}
>>   		ret =3D submit_one_sector(inode, folio, cur, bio_ctrl, i_size);
>> --=20
>> 2.52.0
>>
>=20


