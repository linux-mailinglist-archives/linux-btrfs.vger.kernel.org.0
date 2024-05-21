Return-Path: <linux-btrfs+bounces-5145-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CDBD8CA977
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 May 2024 09:58:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFAB91C212BB
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 May 2024 07:58:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B08F5339E;
	Tue, 21 May 2024 07:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="UWFdYMkh"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C176605BB
	for <linux-btrfs@vger.kernel.org>; Tue, 21 May 2024 07:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716278274; cv=none; b=kdTdfSpxT5VfsPrkHBXH4J8XYLTwMKRUUTPYtbLVzgNZPlkFY5262h3k6aPS4aWPa/tO1iVu8tw6mL/aCl0oAq4UFUsFECj0JtRMOSIewdErclv/i2fu4JgcQun3f7dhy86l0Mfe12DuY+cP1X3xrfhbFhsBp04ETtKb0i+VjkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716278274; c=relaxed/simple;
	bh=eXwB63ufLZ+ewPs4ssHYtQn/aal0o0xvoKUULaYiBmc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a1Z0Yf2/8yqcBIJfLHWB41pePcUN9FDcbNLzWLiRRlc+Ka4kKnciDomKPnVRtPfHMgqeSFu3w1KH0RC3vXoTSaMTZIMPdlEyIQmRn8NcO/8dA7h49n0BFZ3n47eVR1CTY4UnbgNzP6mN90ts2enrRSk5nwSNTC6TIISqwdToJKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=UWFdYMkh; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1716278266; x=1716883066; i=quwenruo.btrfs@gmx.com;
	bh=9hyu1SrZx6PAY25bw3bbIp6TKja8B++/kHBh/dFWPbU=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=UWFdYMkh/4lB5F0Ind1oe+QirWlNXld/s7w+pvaavB54+/g4LYR3V8/yLHA4hVBw
	 vO+EeFOr9jbMsE03r/sAaJlxYYIxlFVlbSUSKPhyTFedNTcHNfAuK2UpfQebHbaOe
	 z+vZRZx26Q8J+JzdHGn+S+Hpj+BW+DPf8/5cC7kdM3NH/yZTXW4l6p7m+bfsuRTyq
	 57RC8I+MRp0KYbExzLhBCtEv1bGU5FGythlgMPGNBaxC+rSsL/fBKVYUKgmqR0hY4
	 K0mwrwcvG8MSoC5YkSGA/zizdrP9cnXSYHYPsb5AfJBYgHkYBvT2m1zas4s1qcV+O
	 HmLJTZIQovfd7FG3vg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.219] ([159.196.52.54]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MsYv3-1sPco63mbj-00ssq6; Tue, 21
 May 2024 09:57:46 +0200
Message-ID: <a879b8e6-b5e1-4328-b05b-6040564f301a@gmx.com>
Date: Tue, 21 May 2024 17:27:40 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/5] btrfs: subpage: introduce helpers to handle
 subpage delalloc locking
To: Naohiro Aota <Naohiro.Aota@wdc.com>, Qu Wenruo <wqu@suse.com>
Cc: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
 Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
 "josef@toxicpanda.com" <josef@toxicpanda.com>
References: <cover.1716008374.git.wqu@suse.com>
 <996c0c3b0807f46f7ae722541e6a90c87b7d3e58.1716008374.git.wqu@suse.com>
 <5faun6sbhn3x37b2kwudtnuumquuiyi4oyferavknmxgoofwgk@tubvkvthpwog>
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
In-Reply-To: <5faun6sbhn3x37b2kwudtnuumquuiyi4oyferavknmxgoofwgk@tubvkvthpwog>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:vGOn53Ia5AFZpAyo6jm4MKd6k4qe9Wh5fqoklOAxhWma1ua8mcS
 uDACD2VeQnqjDsOZuS0Sc7JYNtRMNW1v0A9o921zyXKry3aaf/jQdbQ+GRE8E3CIwK8aWIv
 WBqMGLUFZJuq1mlX9zCaeBO1JYIvNNgpBsUEcFFFd60fLsm9jUo72QAJFZNuMqJcYVkckUt
 olEcvkm2oQtgK0kHlFdeQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:vFLr2aGuByg=;fFzsFsqMkSTwLjfVKGWUIbfW8A7
 WTqIFvSDBQfpzaw6fmX8HDmKtLQkQ1N42D90EB7n+On+Ln2pexmUsMj0MK1NgapngeeJvEgXs
 CTI1tOjKo9LPfjKSLX4yVBLm9RW38M7IMhk6T2cwgI0CspRo1hvJpcKR07Fixti6TxJPA2e9u
 1cVML/ilWeqsBcUh83gHmjoeujP6UeLOYF6jfZxfUCQwJCtSs1HDVtv+1cq80Vj4wPJbAEj84
 U/8lbj/NARmL530RekFS8mIcx8mQcm6TcobYT4gJPTsFD4rb317eA6zK9iDKL1+wfQtkWIlpT
 AclPOCunwoRpuWLadoqZjqvOeqksL1L/VjreUDlQIpBcSOSFCUEd3Xse+QR7miogdP4TksXQQ
 cf1ZZ0WNzSwfCizRGGzdWgc53cBf+Nv4+Noy9duidi4X1GczcFMCdFI1icir8Kc2a9bx628QI
 cfoFFkmRCBsTIPtSEdNihWjch8cNQH/+HS818Ir6bCuHuOO0dRS78x9N6fbAa9TUfbBXvgPF0
 KXSc2LqMrjcCNzvKGK4sA6mIkdleWWSzkgR95l5eHNqg78q19+QmYkJEalYP4ec8OVFb4q8Zm
 5fRQZdFWHENWEr3Cj+Z/+tCXllCZAZe31Xq3DYjBF4A4zlx4i+EoYfcXAOgrkmg0jaBcMag1H
 BpRpNFwjim7BNEEPWaKaF0hjl1ROeh7B1fEsGZdEvXI6tE6bE7Ghnq9dy9PN2xJPvar4ZbiwP
 s5+aCPwHYh6tr6Ptek7fQDtAyt6uOc4mOhO75MkD0MR330hqTVBiMUpIlV93ZINPKbNXjai6L
 x2W+Z38lA2mwucsBTq64OidF2zTcgyTrt4zrMx4h3F8jM=



=E5=9C=A8 2024/5/21 17:20, Naohiro Aota =E5=86=99=E9=81=93:
[...]
>> +void btrfs_folio_set_writer_lock(const struct btrfs_fs_info *fs_info,
>> +				 struct folio *folio, u64 start, u32 len)
>> +{
>> +	struct btrfs_subpage *subpage;
>> +	unsigned long flags;
>> +	int start_bit;
>> +	int nbits;
>
> May want to use unsigned int for a consistency...
>

I can definitely change all the int to "unsigned int" to be consistent
during pushing to for-next branch.

[...]
>> +	found =3D true;
>> +	*found_start_ret =3D folio_pos(folio) +
>> +		((first_set - locked_bitmap_start) << fs_info->sectorsize_bits);
>
> It's a bit fearful to see an "int" value is shifted and added into u64
> value. But, I guess sectorsize is within 32-bit range, right?

In fact, (first_set - locked_bitmap_start) is never going to be larger
than (PAGE_SIZE / sectorsize).

I can add extra ASSERT() to be extra safe for that too.

Thanks,
Qu

>
>> +
>> +	first_zero =3D find_next_zero_bit(subpage->bitmaps,
>> +					locked_bitmap_end, first_set);
>> +	*found_len_ret =3D (first_zero - first_set) << fs_info->sectorsize_bi=
ts;
>> +out:
>> +	spin_unlock_irqrestore(&subpage->lock, flags);
>> +	return found;
>> +}
>> +
>> +/*
>> + * Unlike btrfs_folio_end_writer_lock() which unlock a specified subpa=
ge range,
>> + * this would end all writer locked ranges of a page.
>> + *
>> + * This is for the locked page of __extent_writepage(), as the locked =
page
>> + * can contain several locked subpage ranges.
>> + */
>> +void btrfs_folio_end_all_writers(const struct btrfs_fs_info *fs_info,
>> +				 struct folio *folio)
>> +{
>> +	u64 folio_start =3D folio_pos(folio);
>> +	u64 cur =3D folio_start;
>> +
>> +	ASSERT(folio_test_locked(folio));
>> +	if (!btrfs_is_subpage(fs_info, folio->mapping)) {
>> +		folio_unlock(folio);
>> +		return;
>> +	}
>> +
>> +	while (cur < folio_start + PAGE_SIZE) {
>> +		u64 found_start;
>> +		u32 found_len;
>> +		bool found;
>> +		bool last;
>> +
>> +		found =3D btrfs_subpage_find_writer_locked(fs_info, folio, cur,
>> +							 &found_start, &found_len);
>> +		if (!found)
>> +			break;
>> +		last =3D btrfs_subpage_end_and_test_writer(fs_info, folio,
>> +							 found_start, found_len);
>> +		if (last) {
>> +			folio_unlock(folio);
>> +			break;
>> +		}
>> +		cur =3D found_start + found_len;
>> +	}
>> +}
>> +
>>   #define GET_SUBPAGE_BITMAP(subpage, subpage_info, name, dst)		\
>>   	bitmap_cut(dst, subpage->bitmaps, 0,				\
>>   		   subpage_info->name##_offset, subpage_info->bitmap_nr_bits)
>> diff --git a/fs/btrfs/subpage.h b/fs/btrfs/subpage.h
>> index 4b363d9453af..9f19850d59f2 100644
>> --- a/fs/btrfs/subpage.h
>> +++ b/fs/btrfs/subpage.h
>> @@ -112,6 +112,13 @@ int btrfs_folio_start_writer_lock(const struct btr=
fs_fs_info *fs_info,
>>   				  struct folio *folio, u64 start, u32 len);
>>   void btrfs_folio_end_writer_lock(const struct btrfs_fs_info *fs_info,
>>   				 struct folio *folio, u64 start, u32 len);
>> +void btrfs_folio_set_writer_lock(const struct btrfs_fs_info *fs_info,
>> +				 struct folio *folio, u64 start, u32 len);
>> +bool btrfs_subpage_find_writer_locked(const struct btrfs_fs_info *fs_i=
nfo,
>> +				      struct folio *folio, u64 search_start,
>> +				      u64 *found_start_ret, u32 *found_len_ret);
>> +void btrfs_folio_end_all_writers(const struct btrfs_fs_info *fs_info,
>> +				 struct folio *folio);
>>
>>   /*
>>    * Template for subpage related operations.
>> --
>> 2.45.0
>>

