Return-Path: <linux-btrfs+bounces-7346-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADF18958FE2
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 Aug 2024 23:45:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D20481C21F14
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 Aug 2024 21:45:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE0AD1C6891;
	Tue, 20 Aug 2024 21:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="OpHFwZBm"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9591518E377;
	Tue, 20 Aug 2024 21:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724190329; cv=none; b=RgcWB4CsVg2IjtU9uvyWjuPyjLdvRuNuUK2PttvgEkrO9i+r6gY4wqpAlzO/eumuCHarsMWOom6A69R/2/r8z5EfmsGs5ixoLafwar31XzIY+JkiNe98KlNcixFz782cEtSOLgmS52cVusTwUmvNwqlaaUtlZ8AZN1KF61g7JjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724190329; c=relaxed/simple;
	bh=3kxn8BgPrdccYDzgLGRgpOLkQavUywNpTO9t2iOC0Uc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TUk6/rDEI6qRg5RDjV6/PXsUkXLlTo+HJz+GT57oXkAxzbjqGD7BxsZRrY5kg0zoZT2FY0ZG2wSEvSx62ahr1PnLxzXBzynQCgrZnLL+mEptWC1R2qLSpkNoNoz3N92t2hwFDglrcoT0Hqd8lpMxdNb4+22okkubMR12SygDsYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=OpHFwZBm; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1724190311; x=1724795111; i=quwenruo.btrfs@gmx.com;
	bh=1sYaJog3scACLdPVt33Dhx+scQPOzihP/XAJPS6q3xQ=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=OpHFwZBmosKg9hOvUNnW/1vvnS38pI77AJoxK9soIGlRhST9Ztwl1UkG+7hqUjjk
	 7RgVL3eKr9ROB5G1K+a+PuJut6N77Da9sFGxsHwJLuOc8l+fGmkrJOFx+LXlcLBAx
	 HdxHm0WMnDkUdV3iq9X2I4Ag8Lojxk+WlDhESXT727dLmcz54rMYGkz/ZE/QCjX3e
	 tSPjbnYZcW53/+bQ6vrNlJhWoagYLCD0vPUGnu/j7x/KtDt0vEVXZwNHgQSlGHh9u
	 A+3Bt7ORnNj0yxS70o2ye3vJxj0oaBncFH/NYB0kR5deH1mOKd0Qg3wEqY4+ZnjG0
	 AMmBdY8TqAkeZ3qdYA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MBlxM-1sqRkQ1Syy-00ADdR; Tue, 20
 Aug 2024 23:45:10 +0200
Message-ID: <796068cf-1492-44a7-a495-888a55429ab6@gmx.com>
Date: Wed, 21 Aug 2024 07:15:05 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: scrub: don't mark inline extents as errors on RST
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
 Johannes Thumshirn <jth@kernel.org>, Chris Mason <clm@fb.com>,
 Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
 "open list:BTRFS FILE SYSTEM" <linux-btrfs@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>
Cc: Qu Wenru <wqu@suse.com>
References: <20240820143453.25428-1-jth@kernel.org>
 <3ec1dd40-cdc7-4e47-9f74-9a29f60b6368@wdc.com>
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
In-Reply-To: <3ec1dd40-cdc7-4e47-9f74-9a29f60b6368@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:YWIIyOqoih2/IeWR8WADyIENpS8mLR6KdIDpkgaeEXG/0rtBFy+
 wFDpu9S0NweAqoLgcb4RN5AB/iSNNDPJ/+nG3IAoQsSrErHKqfnybwap2d4Sj383pczArOU
 4T1xqdH033osxGsxUNZKqHF4ss9f3if6PfdjOZrecfBehSbKGAjkDDrqS2+jPtLIqKz9sQz
 gwlu2Hn48pHbGpMYMSQfA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:dh9cSgvPswc=;xkq3q666rV41XTbPmEi/Ez8Jv6F
 WVYB2DIBKffTw4w/Qux/sE0UlsHyza/671poj5e2Gq0GKGGzRd6hZYAULD7v8pVw5IQOFjcGC
 zhuuT/K5AN0zhp85toTJq/j83oy7LOwemm7ha4B0xGI1G2hg0dEG2nQIDeRNKdXyAU9DajVu2
 b9EoQEk/ULId1c/veRWPPh4EJFn0BA4b8q5ZkWYwDDNtD/UfobBAbl101j6rg/QV85PMRTUdy
 LthBRRBZWsj/XnylcmlHTrO4gicDEo9A2qbihShVb9gz/96/Djga9L94JIMivbcnafo6QB6ZI
 HWHfaJTET8jIbxh9vx1BXmnRPgje97O05kcl02PkK6EpMIFc+2/McPHa9ugm6A5b5lTlhxd2S
 KM5KuOIdCWalp+AlYuUjnpmlI2H2QmKt366tU7Bvq4pmMkyIDzyE/79WEc0MUWgFwSErAtNXv
 AegWuM4AJcrHnCrbEHdIJ/mTGxGGjStA7gfLojcF0IL0SG0g6y5CpR+CDHlXBuX0txKU9YTwv
 RYjHdrWV2iQIMBgoMJ4U/4Fc5Aj8wWyxiaEnbGldNTX2uWAC28PZuqYjaLzZdfkIHlFh3xzUH
 X9/AkRTk80F/exCg5hZwNrkD/LiqSzce4Qk63sMjMvyfL8GmT9v0Utst9suNI0YUPqITyDbBs
 lGMht4xTIijEV2cV3gTr0EEiXMB0HjUfw54iee0aJVKR11eEMDetBHjnUM/iVuzz74NlXkIlB
 90Wc7OHY6WxCNNKBpE+c5M0UEGOsgPKvORHEH2+nSPYFY3N+FGTGdF6X4RpfxJqK4Q0fWpM8G
 QOquSggYCXVDGE12eqRmT71g==



=E5=9C=A8 2024/8/21 03:17, Johannes Thumshirn =E5=86=99=E9=81=93:
> On 20.08.24 16:35, Johannes Thumshirn wrote:
>> From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
>>
>> When scrubbing a RAID stripe-tree backed btrfs system, we're doing
>> extent based block mappings. These block mappings go through the RAID
>> stripe-tree to do logical to physical translation.
>>
>> In case we're hitting an inline extent, there is no backing by the
>> RAID stripe-tree for it and the block mapping returns an error. So the
>> bit in the extent bitmap is marked as error.
>>
>> Fix this by not marking mapping failures for inline extents as error.
>>
>> Cc: Qu Wenru <wqu@suse.com>
>> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
>
> Scratch that one, that apparently only works in my test environment.

And I'm also wondering why inline data extents would even show up in
extent tree.

Inlined data won't have any extents, they are just part of metadata.

Thanks,
Qu
>
>
>> ---
>>    fs/btrfs/scrub.c | 41 +++++++++++++++++++++++++++++++++++++++--
>>    1 file changed, 39 insertions(+), 2 deletions(-)
>>
>> diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
>> index b3afa6365823..8240b205699c 100644
>> --- a/fs/btrfs/scrub.c
>> +++ b/fs/btrfs/scrub.c
>> @@ -67,6 +67,7 @@ struct scrub_ctx;
>>    /* Represent one sector and its needed info to verify the content. *=
/
>>    struct scrub_sector_verification {
>>    	bool is_metadata;
>> +	bool is_inline;
>>
>>    	union {
>>    		/*
>> @@ -1479,6 +1480,34 @@ static int sync_write_pointer_for_zoned(struct s=
crub_ctx *sctx, u64 logical,
>>    	return ret;
>>    }
>>
>> +static bool extent_is_inline(struct btrfs_fs_info *fs_info,
>> +			     u64 extent_start, u64 extent_len)
>> +{
>> +	struct btrfs_file_extent_item *ei;
>> +	struct extent_buffer *leaf;
>> +	struct btrfs_path *path;
>> +	struct btrfs_root *extent_root =3D btrfs_extent_root(fs_info, extent_=
start);
>> +	int ret;
>> +	bool is_inline =3D false;
>> +
>> +	path =3D btrfs_alloc_path();
>> +	if (!path)
>> +		return false;
>> +
>> +	ret =3D btrfs_lookup_file_extent(NULL, extent_root, path, extent_star=
t, extent_len, 0);
>> +	if (ret < 0)
>> +		goto out;
>> +
>> +	leaf =3D path->nodes[0];
>> +	ei =3D btrfs_item_ptr(leaf, path->slots[0], struct btrfs_file_extent_=
item);
>> +	if (btrfs_file_extent_type(leaf, ei) =3D=3D BTRFS_FILE_EXTENT_INLINE)
>> +		is_inline =3D true;
>> +
>> + out:
>> +	btrfs_free_path(path);
>> +	return is_inline;
>> +}
>> +
>>    static void fill_one_extent_info(struct btrfs_fs_info *fs_info,
>>    				 struct scrub_stripe *stripe,
>>    				 u64 extent_start, u64 extent_len,
>> @@ -1497,6 +1526,9 @@ static void fill_one_extent_info(struct btrfs_fs_=
info *fs_info,
>>    		if (extent_flags & BTRFS_EXTENT_FLAG_TREE_BLOCK) {
>>    			sector->is_metadata =3D true;
>>    			sector->generation =3D extent_gen;
>> +		} else {
>> +			sector->is_inline =3D extent_is_inline(
>> +				fs_info, extent_start, extent_len);
>>    		}
>>    	}
>>    }
>> @@ -1704,8 +1736,13 @@ static void scrub_submit_extent_sector_read(stru=
ct scrub_ctx *sctx,
>>    					      &stripe_len, &bioc, &io_stripe, &mirror);
>>    			btrfs_put_bioc(bioc);
>>    			if (err < 0) {
>> -				set_bit(i, &stripe->io_error_bitmap);
>> -				set_bit(i, &stripe->error_bitmap);
>> +				struct scrub_sector_verification *sector =3D
>> +					&stripe->sectors[i];
>> +
>> +				if (!sector->is_inline) {
>> +					set_bit(i, &stripe->io_error_bitmap);
>> +					set_bit(i, &stripe->error_bitmap);
>> +				}
>>    				continue;
>>    			}
>>
>

