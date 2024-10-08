Return-Path: <linux-btrfs+bounces-8661-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 52EAE9958D9
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Oct 2024 22:56:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 761E31C21E65
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Oct 2024 20:56:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8763F2139C7;
	Tue,  8 Oct 2024 20:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="OC1yHU9N"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BD7A58222
	for <linux-btrfs@vger.kernel.org>; Tue,  8 Oct 2024 20:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728421007; cv=none; b=au0AkOAK8B/BmRnyB5z7vTi2Q+8RInBKfxwmSbEbvOJENOORwOrACdMgcjfkPDy+PWnKJ7g+RtFFzUB55Ty2p1/SifKpuoIA+SkpQe/GwyNlIhRTE89RH7JZX8AGJ1jMVVjjgcolOtXMJyEwhqeU61fTDkEVrwTy2JgEmoEPGo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728421007; c=relaxed/simple;
	bh=fbeTpFjfeUX1Xq/KWUCrG40CTc7WIhFtbAwgMEkezT0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DuHlIRoP1OMHdMNlZPevY1UwbhlOzkW0UUt/bDQo88UTiPEz9cloPjCTYsUA+EyseAFtD16rSJtLEyeNt8l4yiZf/GIoehghOZJ2OeJfSxsOxHOedvqZWpvXZ+IT3OtKd75tEX3Ivwy60mLTy/rXkxMx1ZNAgihYHnROub6BVO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=OC1yHU9N; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1728421000; x=1729025800; i=quwenruo.btrfs@gmx.com;
	bh=co2gNJPT3hpqCGeDpUBIbl7xorQlyEhE84zO8DnuE8c=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=OC1yHU9NXXr07CKBLSgo40ET2h3iixKO5+CzWi7LWTL6R7FGIwjWImTbzq0N2+gc
	 EmwrjAjCGh2yWNkhwq1DrKyxn8iaxeF0ZN94m7q85ZdQP/aUBB7otY4Y2+rVoHGsp
	 vz7YBjqy6voF/vxlGO3WTlkXzAlCw0BD6aTs+B7Jf90PclQZI+D9nCr7bB24WsGKl
	 LWquih83RNBXtLpnt9sWs9b3S6dbQTYjW4WD3yBp/5Xnqx5EyVZ+aKzzawS2r7D8G
	 +8yeDnqOd5YDoE5YO+o2GuAfpLQHE8IX9oEwRH/pV+8CFy343v3gmv5QOzb+7kT4c
	 gvoUHz6+tw3No/hqtg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MG9g4-1tCa552aJY-00D5H5; Tue, 08
 Oct 2024 22:56:40 +0200
Message-ID: <9de4892b-f1dc-4dc1-a63b-71564aaf1a94@gmx.com>
Date: Wed, 9 Oct 2024 07:26:36 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: remove btrfs_set_range_writeback()
To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
References: <2c53f7555d45d6697e836fa2bb7dce137ab04c99.1728175215.git.wqu@suse.com>
 <20241008164356.GC1609@twin.jikos.cz>
Content-Language: en-US
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
Autocrypt: addr=quwenruo.btrfs@gmx.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNIlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT7CwJQEEwEIAD4CGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCY00iVQUJDToH
 pgAKCRDCPZHzoSX+qNKACACkjDLzCvcFuDlgqCiS4ajHAo6twGra3uGgY2klo3S4JespWifr
 BLPPak74oOShqNZ8yWzB1Bkz1u93Ifx3c3H0r2vLWrImoP5eQdymVqMWmDAq+sV1Koyt8gXQ
 XPD2jQCrfR9nUuV1F3Z4Lgo+6I5LjuXBVEayFdz/VYK63+YLEAlSowCF72Lkz06TmaI0XMyj
 jgRNGM2MRgfxbprCcsgUypaDfmhY2nrhIzPUICURfp9t/65+/PLlV4nYs+DtSwPyNjkPX72+
 LdyIdY+BqS8cZbPG5spCyJIlZonADojLDYQq4QnufARU51zyVjzTXMg5gAttDZwTH+8LbNI4
 mm2YzsBNBFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcga
 CbPEwhLj1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj
 /IrRUUka68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fN
 GSsRb+pKEKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0
 q1eW4Jrv0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEv
 ABEBAAHCwHwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCY00ibgUJDToHvwAK
 CRDCPZHzoSX+qK6vB/9yyZlsS+ijtsvwYDjGA2WhVhN07Xa5SBBvGCAycyGGzSMkOJcOtUUf
 tD+ADyrLbLuVSfRN1ke738UojphwkSFj4t9scG5A+U8GgOZtrlYOsY2+cG3R5vjoXUgXMP37
 INfWh0KbJodf0G48xouesn08cbfUdlphSMXujCA8y5TcNyRuNv2q5Nizl8sKhUZzh4BascoK
 DChBuznBsucCTAGrwPgG4/ul6HnWE8DipMKvkV9ob1xJS2W4WJRPp6QdVrBWJ9cCdtpR6GbL
 iQi22uZXoSPv/0oUrGU+U5X4IvdnvT+8viPzszL5wXswJZfqfy8tmHM85yjObVdIG6AlnrrD
In-Reply-To: <20241008164356.GC1609@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:gK37oQFiX4u5ovF0CQmzziiQlMVQfgW7UI0W+dzB0owq4H9jwkH
 3ye4BTi2x4vUl67h4UZaI8bZ4qxh/ArWp2EvxsCj7XNXSLVjmd3tSF5laP+3QrM2F6eV63W
 lpXUULvcjRjk7YlnliqdxjVwysc3eBbVl/GFEz01IOuT54pkYiwOItYZfP23ipunXJPTwOx
 BOPIdufPso692YKe3x2Rg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Ij3Hoo+Bpnw=;qlzLPUIOrRG8mrGOBvlsF04r/5I
 yAvICgLeAeEJ42DjTW6g/P+3VxdFrEBNsEpdIyEHfnH9LxYT6JBlPVuR4YZO7PMuDev4+UKh9
 a5A7aHeh/J7Pk7K1IOCrezHIGlejC0MC7KgX8vepYkOFULP0UmUki/qity16xJKbeTjF4/i3R
 twvh9r5bnCxkYK5zMilxAoEtZJ/ujDT4iV+mJLMGZBOTjhzZjBZyQKZmhCE4wNr6EreF9XoYv
 WmogmLqc1v5yJ7Q4CO94ECYS2Yk4Wk+6oPF76SIp0KEVI1ZwBLFJD8xkyel+PYlELEAOWip4W
 yJ31tb73NchVvMR0WXKfOsG7IxlKA62QgvoqhhCBN+ICnGsIIf6ngicnHMeP6J8CaIvM4Fbo6
 o0ncvBUkZNl9XNdiSnd7lEVusWT0BU1OJ9wAZ6LoUyAFT9ceiSZISqBC320PyEK6CPE/WyE1+
 FCaeyK8IlBCA4cl3VYkxSyienjK5pmiiEPMeL039E/zDylvdLWtizY0FkclVDCz/o/UMnB/9O
 mn3xl3b3ZX7arHXRzLMggdJdz0tDyA4l8etm4NlwcoZttrYzw0WR+1p0LaKMhsZr4fRr+m8bd
 jDE3Zcnrc9sDEWXeGTpum0KVpMJivkzoF3LFjknRhZiaxCsyqZKqeKlEPoJLbicEcL7mjdedR
 JTWRqz9oMaqt4Memu5KBlcEzrEeUTx/cYYaNsV+k7ORgmKEbus9DGdRI+cG3YFKotD7DrIEYF
 hgEc/zKoVClScstapSKT3X9zVBKQJQk6un5BI+xuLo02I0NapXFtsQqECL70m0Ll5Z7skTOdz
 lLIa4X0RreSp/O4oMNtEiEsg==



=E5=9C=A8 2024/10/9 03:13, David Sterba =E5=86=99=E9=81=93:
> I have more comments on the grammar than on the code, sorry.
>
> On Sun, Oct 06, 2024 at 11:10:22AM +1030, Qu Wenruo wrote:
>> The function btrfs_set_range_writeback() is originally a callback for
>                                             was
>
>> metadata and data, to mark a range with writeback flag.
>>
>> Then it was converted into a common function call for both metadata and
>> data.
>>
>> >From the very beginning, the function is only called on a full page,
>                                           'had been' because of the othe=
r past tense, idk
>
>> later converted to handle range inside a page.
>>
>> But it never needs to handle multiple pages, and since commit
>                 needed
>
>> 8189197425e7 ("btrfs: refactor __extent_writepage_io() to do
>> sector-by-sector submission") the function is only called on a
>                                               has been
>
>> sector-by-sector basis.
>>
>> This makes the function unnecessary, and can be converted to a simple
>> btrfs_folio_set_writeback() call instead.
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>>   fs/btrfs/btrfs_inode.h |  1 -
>>   fs/btrfs/extent_io.c   |  2 +-
>>   fs/btrfs/inode.c       | 22 ----------------------
>>   3 files changed, 1 insertion(+), 24 deletions(-)
>>
>> diff --git a/fs/btrfs/btrfs_inode.h b/fs/btrfs/btrfs_inode.h
>> index e152fde888fc..c514bab532fa 100644
>> --- a/fs/btrfs/btrfs_inode.h
>> +++ b/fs/btrfs/btrfs_inode.h
>> @@ -577,7 +577,6 @@ void btrfs_merge_delalloc_extent(struct btrfs_inode=
 *inode, struct extent_state
>>   				 struct extent_state *other);
>>   void btrfs_split_delalloc_extent(struct btrfs_inode *inode,
>>   				 struct extent_state *orig, u64 split);
>> -void btrfs_set_range_writeback(struct btrfs_inode *inode, u64 start, u=
64 end);
>>   void btrfs_evict_inode(struct inode *inode);
>>   struct inode *btrfs_alloc_inode(struct super_block *sb);
>>   void btrfs_destroy_inode(struct inode *inode);
>> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
>> index 9fbc83c76b94..d87dcafab537 100644
>> --- a/fs/btrfs/extent_io.c
>> +++ b/fs/btrfs/extent_io.c
>> @@ -1359,7 +1359,7 @@ static int submit_one_sector(struct btrfs_inode *=
inode,
>>   	 * a folio for a range already written to disk.
>>   	 */
>>   	btrfs_folio_clear_dirty(fs_info, folio, filepos, sectorsize);
>> -	btrfs_set_range_writeback(inode, filepos, filepos + sectorsize - 1);
>> +	btrfs_folio_set_writeback(fs_info, folio, filepos, sectorsize);
>>   	/*
>>   	 * Above call should set the whole folio with writeback flag, even
>>   	 * just for a single subpage sector.
>> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
>> index 103ec917ca9d..21e51924742a 100644
>> --- a/fs/btrfs/inode.c
>> +++ b/fs/btrfs/inode.c
>> @@ -8939,28 +8939,6 @@ static int btrfs_tmpfile(struct mnt_idmap *idmap=
, struct inode *dir,
>>   	return finish_open_simple(file, ret);
>>   }
>>
>> -void btrfs_set_range_writeback(struct btrfs_inode *inode, u64 start, u=
64 end)
>> -{
>> -	struct btrfs_fs_info *fs_info =3D inode->root->fs_info;
>> -	unsigned long index =3D start >> PAGE_SHIFT;
>> -	unsigned long end_index =3D end >> PAGE_SHIFT;
>> -	struct folio *folio;
>> -	u32 len;
>> -
>> -	ASSERT(end + 1 - start <=3D U32_MAX);
>> -	len =3D end + 1 - start;
>> -	while (index <=3D end_index) {
>> -		folio =3D __filemap_get_folio(inode->vfs_inode.i_mapping, index, 0, =
0);
>> -		ASSERT(!IS_ERR(folio)); /* folios should be in the extent_io_tree */
>> -
>> -		/* This is for data, which doesn't yet support larger folio. */
>> -		ASSERT(folio_order(folio) =3D=3D 0);
>> -		btrfs_folio_set_writeback(fs_info, folio, start, len);
>
> So the new code is just btrfs_folio_set_writeback(), with the removed
> comment and assertion,

Firstly, the length check is already inside btrfs_folio_set_writeback()
for the subpage cases.
If it's not subpage, we do not even need to check the range (it's always
page aligned).

Secondly for the folio, we do not need the ASSERT(), because this time
we have the folio pointer already.

So for the assert part, there is no change.

> what's the status regarding large folios?

That stays the same, no larger folio support.

The larger folio support requires us to get rid of the per-fs
sectors_per_page check, but using folio_size() to do the calculation.

That will still be a lot of work to do before we can support larger
folios for data.

Thanks,
Qu
>
> I assume that this now implicitly supports them, we don't necessarily
> need the assertion as I think we have more places where this would be
> detected.
>


