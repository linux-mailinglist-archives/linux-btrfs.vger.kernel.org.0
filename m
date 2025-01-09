Return-Path: <linux-btrfs+bounces-10884-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70505A083A9
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 Jan 2025 00:46:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0D22166374
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Jan 2025 23:46:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E68E1A2C0B;
	Thu,  9 Jan 2025 23:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="luGYRE1l"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FD492054EB;
	Thu,  9 Jan 2025 23:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736466355; cv=none; b=NyEkD6Q3PQe7u3kLCXiElQsJMBP2gUTBLmjc3yWPqNYXwz9IP+2nHqUlJwuTPEAob7nvDkcYJP2L37wJhZrVHB8Mx1vC2h/Hu3taRlXXrwYET5x08Q38VvuK1U23gzWaYtnKeB7NTOL/vQCD42EMsYNtH50KcK2OyCleTwj6g+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736466355; c=relaxed/simple;
	bh=yXYWaKztjNOG3RMN2LkLsqnfokDD2MLDGaQnBYQKfQE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Jyj8pWoC8WK8250mAoMwCYGNi5AfCHL0hB2R6E1vdjul9AVPu3Ftf1DUPMBygMB5Jhlt9apB4hlO8E6NQmK/rd9CovInaP5ZpKUWiAmxLRhwKW1NVIX3h+uZuFCLAfP7IZaTrQPHPUTwEMmtm6jydmOq7np+ygNjNGRHGLCjVmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=luGYRE1l; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1736466350; x=1737071150; i=quwenruo.btrfs@gmx.com;
	bh=ECZplTzzuVEb/IEdOM7/c3D64DuteHuWfXR7zTh2IgY=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=luGYRE1ltNLGZR1XSOKV8QpgOTZ4UqoGeK0g9sUOrU9yzZ4YpbbiVy0IUZUfBBif
	 /rs68T5RqOTzaNVYwqFEWPgN+5X9DWLPeyubi2NigYq4/t4pMyHWIkZ2Oefvvj+QF
	 nuP+yrhaqeUG0nIObHC/PmYmWfGFGmjhwoT/D6xrmYekUzELWAYMoUopwYdPfUnO7
	 ep8BK6tGHw+MaMXb+ZvN4yuvbbRWSZkxpHictB4wyG3oe4Q6GpIXBa6TNKSNDWWV6
	 Ff1MLQZGIHSHKA0ZVuhTuO1XWxta1KYjSo7Ky0dqQxARKIl4FU/AtLKc1M6ydX7mU
	 J7b4XxKUHxR+x641Rg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MbAci-1szAJB37Qu-00ohVA; Fri, 10
 Jan 2025 00:45:50 +0100
Message-ID: <1cdcc76f-82e4-4072-bee6-0922f4b41511@gmx.com>
Date: Fri, 10 Jan 2025 10:15:46 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/9] btrfs: do proper folio cleanup when
 run_delalloc_nocow() failed
To: Boris Burkov <boris@bur.io>, Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, stable@vger.kernel.org
References: <cover.1733983488.git.wqu@suse.com>
 <d3a8799772abd1efd309a61f695a1774a742bfb9.1733983488.git.wqu@suse.com>
 <20250109232659.GB2153241@zen.localdomain>
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
In-Reply-To: <20250109232659.GB2153241@zen.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:YGh4KMJjo5nHQXJK/djfUuJa9+TqDlIISvlPVmMXwqsv2r8TTD5
 Zs3B2CmDod59fSyklCxSksAxcEm9EP5F9OazUvlg/ta3GCPQg5XPxvkI6bjxE6WaCkm1QZt
 FhTbUpxNC1BWaiP6HggCsz1LXkJ7AsuBMh9w7DzGVmpAs2fQ7JpGLvyZUKWC+FbXqJLLjuX
 +g9R/ek4O+18NacYpDlfQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:9J5gBOLq1XQ=;UDo8SHfxYW1g0JuOyo9hTr7OAIq
 JKYC12hPRZtG05g7TP+8bh289ZjQ6RhshOXeEqtzJrpNLYAix1Y9iHZjJBgIt/ZhpqVfBLrby
 7wArqUZQn0xPzi+qwqpT9jxOdq0wy6M+LkqzdPsNfSrmDIGBnMc74BZJNg6NwniDr+4V8Q9B7
 m5vsDLD850MIPsFYNWc8y5YvIXaaDlC3UcawG/cDQVQJKXWAg+aGptw0LseMrMuV0ykgfxH8G
 jfNHUJmGrBN3+l5NVTonz16aCfe9Y4HfNOndlofUIIKw2q2+xGW6tgYz9AmPQF4Q8EDfr/q/b
 Y3PKCD3nM0OazG0BE/YDUUuafn8kqAoROZIBg3HLoeYdEofelqMNZDTZ3hhrxBzwInwSze+8y
 a/kvmlPG3L2DvJ0xA+WkIYBFT2tZxhtaeTP53QPm60tw6uxqLwsogvEqSIUC+aLDiZ3RART8a
 Pabjj7ZROzpE0wo8LVuga9+Nbt5RQ+9B7+Y8+vKcHM2qQopfn2aX3xCq5iCVHkUYd7JqScW3y
 UY0DTM+vp9SKcZczUaK0g6BnU+GiwJzryf4CLio+PXDvuoDCbR5sL+ANF7nQjGP72AOw4EwDv
 lmqNXSd0FFiMuwHy80BQ3JM6MOefDW0806J2c1XlbmLHhecECs0rsyqEwhb1lwEQyJAV5sUIt
 DlYMjSMqff2J8Tb19zzLunmQvV9YjiwQ1U8TPYYZuJeRCiPaxLeQ+uASRi+yQJCEzpwsPXYro
 fx86no1p14PQA/G5whjUCbMOjYBvBNVy6AF/07vKSjuffQDdR2iK4I8/yfnKgWm9Avtv+oIaQ
 dt/+7fRKbq9AvO4RsVPDVfpKFnO21aivgCx/NUJYyoDDh/ch5lThNgGreepM4mdC3haVMgbVk
 m8a0SCsNvMnC4cjE6+8/gxS+QLeaHy7ZPJUz3aXf1s/lIa5WiJm7+hCV08R/rStfDzeahbhcE
 0TkSL1ClKzKaT5uMTY/YudrQY3EuNRwjdHGd3KPNLBaclpcYOTmtq+Uyh6y4rTwasY+o89heR
 EmvFmI5pdOj/4O2zMmDhiyB/uxZ0/jOXZ2uem4GC+JeuXNlOfGpRkRog8bMq3AblA7l79jcR+
 7xU2fnFYxlT/7SDNCMeByffr/kw/18



=E5=9C=A8 2025/1/10 09:56, Boris Burkov =E5=86=99=E9=81=93:
[...]
>
> I like this function. Can you add a simple doc with pre and post
> conditions please?

Sure, no problem.

Would be something like this:

/*
  * To cleanup dirty folios when failed to run a delalloc range.
  *
  * When running a delalloc range, we may need to split into
  * different extents (fragmentation or NOCOW limits), and if
  * we hit error, previous successfully executed ranges also need
  * to have their dirty flags cleared, with the address space marked
  * as error.
  */
>
>> +static void cleanup_dirty_folios(struct btrfs_inode *inode,
>> +				 struct folio *locked_folio,
>> +				 u64 start, u64 end, int error)
>> +{
>> +	struct btrfs_fs_info *fs_info =3D inode->root->fs_info;
>> +	struct address_space *mapping =3D inode->vfs_inode.i_mapping;
>> +	pgoff_t start_index =3D start >> PAGE_SHIFT;
>> +	pgoff_t end_index =3D end >> PAGE_SHIFT;
>> +	u32 len;
>> +
>> +	ASSERT(end + 1 - start < U32_MAX);
>> +	ASSERT(IS_ALIGNED(start, fs_info->sectorsize) &&
>> +	       IS_ALIGNED(end + 1, fs_info->sectorsize));
>> +	len =3D end + 1 - start;
>> +
>> +	/*
>> +	 * Handle the locked folio first.
>> +	 * btrfs_folio_clamp_*() helpers can handle range out of the folio ca=
se.
>> +	 */
>> +	btrfs_folio_clamp_clear_dirty(fs_info, locked_folio, start, len);
>> +	btrfs_folio_clamp_set_writeback(fs_info, locked_folio, start, len);
>> +	btrfs_folio_clamp_clear_writeback(fs_info, locked_folio, start, len);
>
> Could this clear dirty; set writeback; clear writeback sequence benefit
> from a good name and a helper function too?

Sure, what about btrfs_folio_clamp_finish_io()?
>
>> +
>> +	for (pgoff_t index =3D start_index; index <=3D end_index; index++) {
>> +		struct folio *folio;
>> +
>> +		/* Already handled at the beginning. */
>> +		if (index =3D=3D locked_folio->index)
>> +			continue;
>> +		folio =3D __filemap_get_folio(mapping, index, FGP_LOCK, GFP_NOFS);
>> +		/* Cache already dropped, no need to do any cleanup. */
>> +		if (IS_ERR(folio))
>> +			continue;
>> +		btrfs_folio_clamp_clear_dirty(fs_info, folio, start, len);
>> +		btrfs_folio_clamp_set_writeback(fs_info, folio, start, len);
>> +		btrfs_folio_clamp_clear_writeback(fs_info, folio, start, len);
>> +		folio_unlock(folio);
>> +		folio_put(folio);
>> +	}
>> +	mapping_set_error(mapping, error);
>> +}
>> +
>>   /*
>>    * when nowcow writeback call back.  This checks for snapshots or COW=
 copies
>>    * of the extents that exist in the file, and COWs the file as requir=
ed.
>> @@ -1976,6 +2018,11 @@ static noinline int run_delalloc_nocow(struct bt=
rfs_inode *inode,
>>   	struct btrfs_root *root =3D inode->root;
>>   	struct btrfs_path *path;
>>   	u64 cow_start =3D (u64)-1;
>> +	/*
>> +	 * If not 0, represents the inclusive end of the last fallback_to_cow=
()
>> +	 * range. Only for error handling.
>> +	 */
>> +	u64 cow_end =3D 0;
>>   	u64 cur_offset =3D start;
>>   	int ret;
>>   	bool check_prev =3D true;
>> @@ -2136,6 +2183,7 @@ static noinline int run_delalloc_nocow(struct btr=
fs_inode *inode,
>>   					      found_key.offset - 1);
>>   			cow_start =3D (u64)-1;
>>   			if (ret) {
>> +				cow_end =3D found_key.offset - 1;
>>   				btrfs_dec_nocow_writers(nocow_bg);
>>   				goto error;
>>   			}
>> @@ -2209,11 +2257,12 @@ static noinline int run_delalloc_nocow(struct b=
trfs_inode *inode,
>>   		cow_start =3D cur_offset;
>>
>>   	if (cow_start !=3D (u64)-1) {
>> -		cur_offset =3D end;
>>   		ret =3D fallback_to_cow(inode, locked_folio, cow_start, end);
>>   		cow_start =3D (u64)-1;
>> -		if (ret)
>> +		if (ret) {
>> +			cow_end =3D end;
>>   			goto error;
>> +		}
>>   	}
>>
>>   	btrfs_free_path(path);
>> @@ -2221,12 +2270,42 @@ static noinline int run_delalloc_nocow(struct b=
trfs_inode *inode,
>>
>>   error:
>>   	/*
>> -	 * If an error happened while a COW region is outstanding, cur_offset
>> -	 * needs to be reset to cow_start to ensure the COW region is unlocke=
d
>> -	 * as well.
>> +	 * There are several error cases:
>> +	 *
>> +	 * 1) Failed without falling back to COW
>> +	 *    start         cur_start              end
>> +	 *    |/////////////|                      |
>> +	 *
>> +	 *    For range [start, cur_start) the folios are already unlocked (e=
xcept
>> +	 *    @locked_folio), EXTENT_DELALLOC already removed.
>> +	 *    Only need to clear the dirty flag as they will never be submitt=
ed.
>> +	 *    Ordered extent and extent maps are handled by
>> +	 *    btrfs_mark_ordered_io_finished() inside run_delalloc_range().
>> +	 *
>> +	 * 2) Failed with error from fallback_to_cow()
>> +	 *    start         cur_start   cow_end    end
>> +	 *    |/////////////|-----------|          |
>> +	 *
>> +	 *    For range [start, cur_start) it's the same as case 1).
>> +	 *    But for range [cur_start, cow_end), the folios have dirty flag
>> +	 *    cleared and unlocked, EXTENT_DEALLLOC cleared.
>> +	 *    There may or may not be any ordered extents/extent maps allocat=
ed.
>> +	 *
>> +	 *    We should not call extent_clear_unlock_delalloc() on range [cur=
_start,
>> +	 *    cow_end), as the folios are already unlocked.
>> +	 *
>
> I think it would be helpful to include cur_offset in your drawings.

I noticed this when crafting a new patch too, there is no @cur_start at
all, but only @cur_offset.

Will fix it in the next update.

Thanks again for the detailed review,
Qu

>
>> +	 * So clear the folio dirty flags for [start, cur_offset) first.
>>   	 */
>> -	if (cow_start !=3D (u64)-1)
>> -		cur_offset =3D cow_start;
>> +	if (cur_offset > start)
>> +		cleanup_dirty_folios(inode, locked_folio, start, cur_offset - 1, ret=
);
>> +
>> +	/*
>> +	 * If an error happened while a COW region is outstanding, cur_offset
>> +	 * needs to be reset to @cow_end + 1 to skip the COW range, as
>> +	 * cow_file_range() will do the proper cleanup at error.
>> +	 */
>> +	if (cow_end)
>> +		cur_offset =3D cow_end + 1;
>>
>>   	/*
>>   	 * We need to lock the extent here because we're clearing DELALLOC a=
nd
>> --
>> 2.47.1
>>
>


