Return-Path: <linux-btrfs+bounces-18321-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6947CC08408
	for <lists+linux-btrfs@lfdr.de>; Sat, 25 Oct 2025 00:44:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B75833BF707
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Oct 2025 22:44:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1BE630BB8C;
	Fri, 24 Oct 2025 22:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="Y+r1pJLC"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58C7B37160
	for <linux-btrfs@vger.kernel.org>; Fri, 24 Oct 2025 22:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761345838; cv=none; b=mIgBvQPPDzBDuVIVNjJaSxTM1SNZPdeh7HjCLHFExQEUHSaGJrDba05jw+Xnf3oLkNk3CIWU8TNNO7zQKeDa30OYUcdRouKuW/jvvanDAoBBdlGDxYJZ3xkmtSRK0SqeCQ0JQVtyO6OL3EzIRE282oGBatbT4Jt3Dk8H6/iMXH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761345838; c=relaxed/simple;
	bh=CAELLJMJmjmrSTuylh/GnDFZ/k7cgmWm2GvgopbpeNI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MLssIx5bmUBnAaaGXHXOiuXx6zwCWpqKPUZfSAEjrw2qyKMx6LhVFU3v4UGX3lvi1rHDMjQEGzga0l3Sj0yiebglWLNPp8YZkgj86GDR3EkQ15+khUhJsxT8DGR1BFMJHWhgnP7RwjZKPnklr8jXT3h/5iHm76nnAGBvENoDXu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=Y+r1pJLC; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1761345830; x=1761950630; i=quwenruo.btrfs@gmx.com;
	bh=aWRP8uw9XbY3cuKRD8Hn2RCYbpuMiyOwYyFCmEysAmU=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=Y+r1pJLCWYZaP7Y9srN9UQZq5A2qOXAX4IbscQ2mqD78D46nICenn87UxRbv4ltf
	 2y89Z9WPFHTTMq27TmwUnJ09WuigbHt/jF2F5cAY/4dDTXoONl3NPZ4N6qdv5KUcl
	 eY4zlK9J6mhL0OvTPhJdXNRPT5ykhUpEWfuSiIP90Kxp+RRTORBBD0sFhsagiNoBq
	 FPA2b5SiNz1xJktPtqv7suo8gwrhp9mJrnQWKWw84WYTkUG1C0/N7soRc7ReqflOu
	 1KOdIEHJsrk2vEy1yJF5uNY9La0l+gudhgdkydfRhLskiVAyliDKQvu3CzjFTD2oN
	 Gb/E0UDIdBut/QfZEA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1ML9uU-1uvRtH2Qj4-00Yb1x; Sat, 25
 Oct 2025 00:43:50 +0200
Message-ID: <b4398e6d-7a2d-4bea-8b03-29205d2c657e@gmx.com>
Date: Sat, 25 Oct 2025 09:13:44 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/8] btrfs-progs: start tracking extent encryption context
 info
To: dsterba@suse.cz, Daniel Vacek <neelx@suse.com>
Cc: David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
 Josef Bacik <josef@toxicpanda.com>,
 Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
References: <20251015121157.1348124-1-neelx@suse.com>
 <20251015121157.1348124-4-neelx@suse.com>
 <20251024212920.GE20913@twin.jikos.cz>
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
In-Reply-To: <20251024212920.GE20913@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:g+ivK3oeoXQrRWtI79QJEPbJcZMbWL+TJbLPtwXk5/ryUKXUo1e
 zZ+qetuSmHpOxYCK6mURSiPhJuAHxThD1QQY0cWMQBUsLTovROy84R1OxT6tzH2NcvCnlPi
 9LCcG4tzEGaG6rMEgVIXUo8ATvp42/Qg0i5KNl7qU1bPb7VNgEOlbEnZwgcRzt6zDGWgOsT
 0k4G7qBSbok8fH2uw/b/Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:wGsjZc5uipg=;nc0OTJNgV/PNigt6mVPtR+JTnMM
 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
 2TL2ugf64WkLLRZppnVfrHYi4I=



=E5=9C=A8 2025/10/25 07:59, David Sterba =E5=86=99=E9=81=93:
> On Wed, Oct 15, 2025 at 02:11:51PM +0200, Daniel Vacek wrote:
>> From: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
>>
>> This recapitulates the kernel change named 'btrfs: start tracking exten=
t
>> encryption context info".
>>
>> Signed-off-by: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
>> ---
>>   kernel-shared/accessors.h       | 43 ++++++++++++++++++++++
>>   kernel-shared/tree-checker.c    | 65 +++++++++++++++++++++++++++-----=
-
>>   kernel-shared/uapi/btrfs_tree.h | 23 +++++++++++-
>>   3 files changed, 118 insertions(+), 13 deletions(-)
>>
>> diff --git a/kernel-shared/accessors.h b/kernel-shared/accessors.h
>> index cb96f3e2..5d90be76 100644
>> --- a/kernel-shared/accessors.h
>> +++ b/kernel-shared/accessors.h
>> @@ -935,6 +935,9 @@ BTRFS_SETGET_STACK_FUNCS(super_uuid_tree_generation=
, struct btrfs_super_block,
>>   BTRFS_SETGET_STACK_FUNCS(super_nr_global_roots, struct btrfs_super_bl=
ock,
>>   			 nr_global_roots, 64);
>>  =20
>> +/* struct btrfs_file_extent_encryption_info */
>> +BTRFS_SETGET_FUNCS(encryption_info_size, struct btrfs_encryption_info,=
 size, 32);
>> +
>>   /* struct btrfs_file_extent_item */
>>   BTRFS_SETGET_STACK_FUNCS(stack_file_extent_type, struct btrfs_file_ex=
tent_item,
>>   			 type, 8);
>> @@ -973,6 +976,46 @@ BTRFS_SETGET_FUNCS(file_extent_encryption, struct =
btrfs_file_extent_item,
>>   BTRFS_SETGET_FUNCS(file_extent_other_encoding, struct btrfs_file_exte=
nt_item,
>>   		   other_encoding, 16);
>>  =20
>> +static inline struct btrfs_encryption_info *btrfs_file_extent_encrypti=
on_info(
>> +					const struct btrfs_file_extent_item *ei)
>> +{
>> +	unsigned long offset =3D (unsigned long)ei;
>> +
>> +	offset +=3D offsetof(struct btrfs_file_extent_item, encryption_info);
>> +	return (struct btrfs_encryption_info *)offset;
>> +}
>> +
>> +static inline unsigned long btrfs_file_extent_encryption_ctx_offset(
>> +					const struct btrfs_file_extent_item *ei)
>> +{
>> +	unsigned long offset =3D (unsigned long)ei;
>> +
>> +	offset +=3D offsetof(struct btrfs_file_extent_item, encryption_info);
>> +	return offset + offsetof(struct btrfs_encryption_info, context);
>> +}
>> +
>> +static inline u32 btrfs_file_extent_encryption_ctx_size(
>> +					const struct extent_buffer *eb,
>> +					const struct btrfs_file_extent_item *ei)
>> +{
>> +	return btrfs_encryption_info_size(eb, btrfs_file_extent_encryption_in=
fo(ei));
>> +}
>> +
>> +static inline void btrfs_set_file_extent_encryption_ctx_size(
>> +					struct extent_buffer *eb,
>> +					struct btrfs_file_extent_item *ei,
>> +					u32 val)
>> +{
>> +	btrfs_set_encryption_info_size(eb, btrfs_file_extent_encryption_info(=
ei), val);
>> +}
>> +
>> +static inline u32 btrfs_file_extent_encryption_info_size(
>> +					const struct extent_buffer *eb,
>> +					const struct btrfs_file_extent_item *ei)
>> +{
>> +	return btrfs_encryption_info_size(eb, btrfs_file_extent_encryption_in=
fo(ei));
>> +}
>> +
>>   /* btrfs_qgroup_status_item */
>>   BTRFS_SETGET_FUNCS(qgroup_status_generation, struct btrfs_qgroup_stat=
us_item,
>>   		   generation, 64);
>> diff --git a/kernel-shared/tree-checker.c b/kernel-shared/tree-checker.=
c
>> index ccc1f1ea..93073979 100644
>> --- a/kernel-shared/tree-checker.c
>> +++ b/kernel-shared/tree-checker.c
>> @@ -242,6 +242,8 @@ static int check_extent_data_item(struct extent_buf=
fer *leaf,
>>   	u32 sectorsize =3D fs_info->sectorsize;
>>   	u32 item_size =3D btrfs_item_size(leaf, slot);
>>   	u64 extent_end;
>> +	u8 policy;
>> +	u8 fe_type;
>>  =20
>>   	if (unlikely(!IS_ALIGNED(key->offset, sectorsize))) {
>>   		file_extent_err(leaf, slot,
>> @@ -272,12 +274,12 @@ static int check_extent_data_item(struct extent_b=
uffer *leaf,
>>   				SZ_4K);
>>   		return -EUCLEAN;
>>   	}
>> -	if (unlikely(btrfs_file_extent_type(leaf, fi) >=3D
>> -		     BTRFS_NR_FILE_EXTENT_TYPES)) {
>> +
>> +	fe_type =3D btrfs_file_extent_type(leaf, fi);
>> +	if (unlikely(fe_type >=3D BTRFS_NR_FILE_EXTENT_TYPES)) {
>>   		file_extent_err(leaf, slot,
>>   		"invalid type for file extent, have %u expect range [0, %u]",
>> -			btrfs_file_extent_type(leaf, fi),
>> -			BTRFS_NR_FILE_EXTENT_TYPES - 1);
>> +			fe_type, BTRFS_NR_FILE_EXTENT_TYPES - 1);
>>   		return -EUCLEAN;
>>   	}
>>  =20
>> @@ -293,10 +295,11 @@ static int check_extent_data_item(struct extent_b=
uffer *leaf,
>>   			BTRFS_NR_COMPRESS_TYPES - 1);
>>   		return -EUCLEAN;
>>   	}
>> -	if (unlikely(btrfs_file_extent_encryption(leaf, fi))) {
>> +	policy =3D btrfs_file_extent_encryption(leaf, fi);
>> +	if (unlikely(policy >=3D BTRFS_NR_ENCRYPTION_TYPES)) {
>>   		file_extent_err(leaf, slot,
>> -			"invalid encryption for file extent, have %u expect 0",
>> -			btrfs_file_extent_encryption(leaf, fi));
>> +			"invalid encryption for file extent, have %u expect range [0, %u]",
>> +			policy, BTRFS_NR_ENCRYPTION_TYPES - 1);
>>   		return -EUCLEAN;
>>   	}
>>   	if (btrfs_file_extent_type(leaf, fi) =3D=3D BTRFS_FILE_EXTENT_INLINE=
) {
>> @@ -325,12 +328,50 @@ static int check_extent_data_item(struct extent_b=
uffer *leaf,
>>   		return 0;
>>   	}
>>  =20
>> -	/* Regular or preallocated extent has fixed item size */
>> -	if (unlikely(item_size !=3D sizeof(*fi))) {
>> -		file_extent_err(leaf, slot,
>> +	if (policy =3D=3D BTRFS_ENCRYPTION_FSCRYPT) {
>> +		size_t fe_size =3D sizeof(*fi) + sizeof(struct btrfs_encryption_info=
);
>> +		u32 ctxsize;
>> +
>> +		if (unlikely(item_size < fe_size)) {
>> +			file_extent_err(leaf, slot,
>> +	"invalid item size for encrypted file extent, have %u expect =3D %zu =
+ size of u32",
>> +					item_size, sizeof(*fi));
>> +			return -EUCLEAN;
>> +		}
>> +
>> +		ctxsize =3D btrfs_file_extent_encryption_info_size(leaf, fi);
>> +		if (unlikely(item_size !=3D (fe_size + ctxsize))) {
>> +			file_extent_err(leaf, slot,
>> +	"invalid item size for encrypted file extent, have %u expect =3D %zu =
+ context of size %u",
>> +					item_size, fe_size, ctxsize);
>> +			return -EUCLEAN;
>> +		}
>> +
>> +		if (unlikely(ctxsize > BTRFS_MAX_EXTENT_CTX_SIZE)) {
>> +			file_extent_err(leaf, slot,
>> +	"invalid file extent context size, have %u expect a maximum of %u",
>> +					ctxsize, BTRFS_MAX_EXTENT_CTX_SIZE);
>> +			return -EUCLEAN;
>> +		}
>> +
>> +		/*
>> +		 * Only regular and prealloc extents should have an encryption
>> +		 * context.
>> +		 */
>> +		if (unlikely(fe_type !=3D BTRFS_FILE_EXTENT_REG &&
>> +			     fe_type !=3D BTRFS_FILE_EXTENT_PREALLOC)) {
>> +			file_extent_err(leaf, slot,
>> +		"invalid type for encrypted file extent, have %u",
>> +					btrfs_file_extent_type(leaf, fi));
>> +			return -EUCLEAN;
>> +		}
>> +	} else {
>> +		if (unlikely(item_size !=3D sizeof(*fi))) {
>> +			file_extent_err(leaf, slot,
>>   	"invalid item size for reg/prealloc file extent, have %u expect %zu"=
,
>> -			item_size, sizeof(*fi));
>> -		return -EUCLEAN;
>> +					item_size, sizeof(*fi));
>> +			return -EUCLEAN;
>> +		}
>>   	}
>>   	if (unlikely(CHECK_FE_ALIGNED(leaf, slot, fi, ram_bytes, sectorsize)=
 ||
>>   		     CHECK_FE_ALIGNED(leaf, slot, fi, disk_bytenr, sectorsize) ||
>> diff --git a/kernel-shared/uapi/btrfs_tree.h b/kernel-shared/uapi/btrfs=
_tree.h
>> index 7f3dffe6..4b4f45aa 100644
>> --- a/kernel-shared/uapi/btrfs_tree.h
>> +++ b/kernel-shared/uapi/btrfs_tree.h
>> @@ -1066,6 +1066,24 @@ enum {
>>   	BTRFS_NR_FILE_EXTENT_TYPES =3D 3,
>>   };
>>  =20
>> +/*
>> + * Currently just the FSCRYPT_SET_CONTEXT_MAX_SIZE, which is larger th=
an the
>> + * current extent context size from fscrypt, so this should give us pl=
enty of
>> + * breathing room for expansion later.
>> + */
>> +#define BTRFS_MAX_EXTENT_CTX_SIZE 40
>> +
>> +enum {
>> +	BTRFS_ENCRYPTION_NONE,
>> +	BTRFS_ENCRYPTION_FSCRYPT,
>> +	BTRFS_NR_ENCRYPTION_TYPES,
>> +};
>> +
>> +struct btrfs_encryption_info {
>> +	__le32 size;
>> +	__u8 context[0];
>> +};
>> +
>>   struct btrfs_file_extent_item {
>>   	/*
>>   	 * transaction id that created this extent
>> @@ -1115,7 +1133,10 @@ struct btrfs_file_extent_item {
>>   	 * always reflects the size uncompressed and without encoding.
>>   	 */
>>   	__le64 num_bytes;
>> -
>> +	/*
>> +	 * the encryption info, if any
>> +	 */
>> +	struct btrfs_encryption_info encryption_info[0];
>=20
> Looking at this again, adding variable length data will make it hard to
> add more items to the file extent. We could not decide the version just
> by the size, as done in other structures.
>=20

Can we put the encryption structure into a dedicated key? Like (ino,=20
ENCRYPT_KEY, fileoff) key.

By this we gain the ability to grab the size through btrfs_item_size(),=20
and each file extent item also get their own encryption info.

Thanks,
Qu

