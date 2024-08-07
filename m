Return-Path: <linux-btrfs+bounces-7035-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BDDE94B2B1
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 Aug 2024 00:05:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D684282802
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 Aug 2024 22:05:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 206361514F8;
	Wed,  7 Aug 2024 22:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="Z1I7Dnkp"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16ADD14C59A
	for <linux-btrfs@vger.kernel.org>; Wed,  7 Aug 2024 22:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723068349; cv=none; b=FneTMm4SJPWKGbwI/hMxBZ8JhxrXg+yWb3L9MGs/NDI5kin4fsISswqCfIRSNZ8pT35wykOBqKkk8h8bbsT5CMhKwpnTAkFm/sLw9KE8I0uaUKNKdZ9Vrqi8FtkVbVgrOR3f6DbJuK/78c6fm5FedKN1LCU+UWCLTXQcEr0Ha+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723068349; c=relaxed/simple;
	bh=dBYG+c29EN9zUJf1+sR8UVO9Fx+jat6Oipyi+uUTOaY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CEcVwt2bvLAYCo699tea825+Gt+O0zbNilSM3nHTkqjvc5pjkpBethM58ZKQWkabrcSpimlG7wzt5c5lWbg42w4cf1hnnsOkqcqHMxGdYe3SJN43zpHUJ8ZbcfEnqYrcQGUtiaILq/gweoGDyUQpByAdDYUzNAukjCLNnR3lvOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=Z1I7Dnkp; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1723068344; x=1723673144; i=quwenruo.btrfs@gmx.com;
	bh=yZD/Cy1nkYQNQ6GwcoEuJLEvVwreNmyHqW6LDjQLBWc=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=Z1I7DnkpCstRDl9AsdPLJRHYuxf7tXsaBw8OA6gdMFa6SLad0j6i8ii+GnTcGNZP
	 vlHodKVzxHlfEkYbZwoi3uzXOLL2/z4XLZOllD8xJnf7TPP/0ukkyACvayfNDBcgA
	 ++sTxp4ntkfhT8JT6xfd4hI/q5fLxROEzp+m7UXRWR2Dyguzo5u4FA2eMIPGsQmiW
	 Qc8YekgMKhHvLFxdUuJ9f1H6yatyQH5gr1pNH5iLmROLPaXOimFwYB/Rj2LsRP3Ss
	 wk7ayJsC5Ul0PiGLLGOdJQw+9kCcdZJSDXMj0N7rUSgG4JAQWHExgFkt795uLZkYo
	 hFoLQWo9sQM6XscwyA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mn2WF-1rtuqW1mOV-00ixCd; Thu, 08
 Aug 2024 00:05:43 +0200
Message-ID: <222e8428-4847-4b93-90a9-69b5594756d2@gmx.com>
Date: Thu, 8 Aug 2024 07:35:40 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: refactor __extent_writepage_io() to do
 sector-by-sector submission
To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
References: <9102c028537fbc1d94c4b092dd4a9940661bc58b.1723020573.git.wqu@suse.com>
 <20240807162716.GD17473@twin.jikos.cz>
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
In-Reply-To: <20240807162716.GD17473@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:kul3qq3W/VuSBzETbPg+OjJSj/r5yPJEIptaNyKQpunc7C6uLlX
 OQkcXECMBQyR73/gLJFDByiduT3TDs7bcL32PAbl+zAzI2jRuskP6NTNDg1/o3gIlaU5vVC
 yj4yb+ejWYTUISRdFNyHh6Ywl2cz6ya7BtC/I7Xv3MZdrP7J7KQE75Vm4BjWGTktGceEmuk
 6+ut8R2gi+AGp4r2AslfQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:RMUfpCWvJ7E=;c7PQ7H1EkmsLKijzjJ1Pt1lQzBT
 /+7RIHKrKEoxDZ/7lsXC4Z9fOVyRwVsSHmITL5f4RZtv1D7NNFgJnRQpHuWve+dJYviUrXUw+
 yXnf1wAFkeFT1dIqxomlbKbfE4rQaSL7suN9ANh48cRLv05TNLc0AImRtgT9lv+MvVMhgbkXb
 9r2rEgboUyhUl6XNnKZ4zY/PMFvCaA3nUNQ23nI8d2sowHIULazP0lYtGq5VsKx699ODr0GFM
 cUdDkszfWpUGxoISDj3GZuQF+d/9W4lv99+wIsyQv93uWOFAtZUlR+n9O6GlT7eRVav6hDhEN
 Ijl5DsloFcnJAR2UzdIqxXi9bAPNmiRzMOEyY611o3at1k7PcyYxaNODpgr03l85vYqJxZ5oq
 9TLH6GCIkDayhIkDa6Tm1IX7MRQBcn1/RL+s+OTW8kTdIO8L+JWjC6NrPm7vYHrCSqaTyFSjE
 V54lIjYYgLqBsBh03lmUIyCP0LR41jxI/AjmNLOLli9Hj2RkczkCXRXws8tMMMOW/bpHfvsDd
 79ASWCFhfM2/u8QMg9og3K3GdU7/lp3+/MbAXnGaJi/7s+UJ7rK5o31Y0PnUOr/25TWKudUTJ
 n0BVtEvgecdLLPRpPWPjrJyajF91bPxEsWdIQBGs2aQer7dlZrvj7mwxWMAYwWVtegGd6Ql4c
 KM4RlUCDGK+XCES2MhquXCSpT+T6Mf3bF44y5IFoetig7ao2aT6z2Ln45eHscmebiG+5SQWva
 +hn8BH/7ph17XeQwGtVF43uU2XMX3LHIZe4Cuv7MyvMNjUlM37Fk7sGTfqCm1FrzfGT6RIw0z
 J2atN7MKw/wnV1osqL5d7ngQ==



=E5=9C=A8 2024/8/8 01:57, David Sterba =E5=86=99=E9=81=93:
> On Wed, Aug 07, 2024 at 06:21:00PM +0930, Qu Wenruo wrote:
[...]
>
>> +
>> +	block_start =3D extent_map_block_start(em);
>> +	disk_bytenr =3D extent_map_block_start(em) + extent_offset;
>> +
>> +	ASSERT(!extent_map_is_compressed(em));
>> +	ASSERT(block_start !=3D EXTENT_MAP_HOLE);
>> +	ASSERT(block_start !=3D EXTENT_MAP_INLINE);
>> +
>> +	free_extent_map(em);
>> +	em =3D NULL;
>> +
>> +	btrfs_set_range_writeback(inode, filepos, filepos + sectorsize - 1);
>> +	if (!folio_test_writeback(folio)) {
>> +		btrfs_err(fs_info,
>> +			  "folio %lu not writeback, cur %llu end %llu",
>> +			  folio->index, filepos, filepos + sectorsize);
>
> This is copied from the original code but I wonder if this should be a
> hard error or more visible as it looks like bad page state tracking.
>

I believe this can be removed completely, or converted into ASSERT().

For subpage case, page writeback is set if any subpage sector has
writeback flag set.

For regular case, it's setting the whole page writeback.

As long as the folio is already locked, the folio should always be
marked writeback.

So I prefer to go the ASSERT() path.

Thanks,
Qu

>
>>   	}
>> -
>> -	range_start_bit =3D spi->dirty_offset +
>> -			  (offset_in_folio(folio, orig_start) >>
>> -			   fs_info->sectorsize_bits);
>> -
>> -	/* We should have the page locked, but just in case */
>> -	spin_lock_irqsave(&subpage->lock, flags);
>> -	bitmap_next_set_region(subpage->bitmaps, &range_start_bit, &range_end=
_bit,
>> -			       spi->dirty_offset + spi->bitmap_nr_bits);
>> -	spin_unlock_irqrestore(&subpage->lock, flags);
>> -
>> -	range_start_bit -=3D spi->dirty_offset;
>> -	range_end_bit -=3D spi->dirty_offset;
>> -
>> -	*start =3D folio_pos(folio) + range_start_bit * fs_info->sectorsize;
>> -	*end =3D folio_pos(folio) + range_end_bit * fs_info->sectorsize;
>> +	/*
>> +	 * Although the PageDirty bit is cleared before entering this
>> +	 * function, subpage dirty bit is not cleared.
>> +	 * So clear subpage dirty bit here so next time we won't submit
>> +	 * folio for range already written to disk.
>> +	 */
>> +	btrfs_folio_clear_dirty(fs_info, folio, filepos, sectorsize);
>> +	submit_extent_folio(bio_ctrl, disk_bytenr, folio,
>> +			    sectorsize, filepos - folio_pos(folio));
>> +	return 0;
>>   }
>>
>>   /*
>

