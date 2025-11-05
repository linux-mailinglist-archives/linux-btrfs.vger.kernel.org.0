Return-Path: <linux-btrfs+bounces-18725-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A2428C34B84
	for <lists+linux-btrfs@lfdr.de>; Wed, 05 Nov 2025 10:15:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5138188967F
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Nov 2025 09:13:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E23A2FA0F6;
	Wed,  5 Nov 2025 09:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="iZR7HfdF"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CEA52F3C3E
	for <linux-btrfs@vger.kernel.org>; Wed,  5 Nov 2025 09:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762333946; cv=none; b=T9bAkFDHUJDE1B8UFT35Pq6NSXgkUsFaW5NQmZ3ANNaJ5RoJers2mU3su2ZC5KJGa6g/ZgKp3eTGm37tJsySockvH/xXzu48Jv4R50IjLTFYqyIpLlYojyP/m+B752xRu5iAvtO+Ts2Yy6RjRyy/lfUMXOA6DMpsddECoGsMU8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762333946; c=relaxed/simple;
	bh=+cgJ3PP9iKVZnEaQSzmun2yua+QcUeVJ5Lwkdvvffjk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BbP2+jdjqSmrBB4p5bMmpzEp+f48sbyOJrRLDjptv05iMA/8+VvWEbY20NPxKWunVJnqx2xjx0G/vYBjTJviVvE3bjR9mbH+hWddN5zg8BK7rBNihJCkBGZMTO+ARKFzoAwXBUptMvY6jSglyAIAuTUGUEuq8bmk+NMP04LKs4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=iZR7HfdF; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1762333942; x=1762938742; i=quwenruo.btrfs@gmx.com;
	bh=i47RLBhjqtcUH0Dd+teP7NQ37iI+p7ShbrcwqA3b/BY=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=iZR7HfdF/BUqjcDOdEg0F0F4MoFLXCGO4gBxFLeSf6pu0q/7d9JtueKdvRsN9kBV
	 wsIohRzrbw6zmWXDdJtJ+NR9D2H+pPF1CfA/4SfAImWLNlIX+DL2MTex4oXR5l1nv
	 VEpi2CU1T9jJ/2r+29PRb2HXvaoy9xSWxlvhWqdcn0s3DptVwDywmg94avxsEb3Mo
	 a9tuwIgNIxwKQ3krejBq1dhpd2TllJbQVfiXHeYm+IjI2s7kRJVDun4HUW18bRn4n
	 S5uiliJQVY+ryX74pImUtyKRBjyl4k3KbHmCtfnjIDN/458lZRJHsLf5WfoW6wWbX
	 WGjQjm7cz+vrKyqeyw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MTzay-1vgWf91kyg-00NOf5; Wed, 05
 Nov 2025 10:12:22 +0100
Message-ID: <f0f633d6-f0e0-4d4c-98cb-096afe77f330@gmx.com>
Date: Wed, 5 Nov 2025 19:42:17 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/8] btrfs-progs: start tracking extent encryption context
 info
To: Daniel Vacek <neelx@suse.com>, dsterba@suse.cz
Cc: David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
 Josef Bacik <josef@toxicpanda.com>,
 Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
References: <20251015121157.1348124-1-neelx@suse.com>
 <20251015121157.1348124-4-neelx@suse.com>
 <20251024212920.GE20913@twin.jikos.cz>
 <CAPjX3Fc6abzXgE+_S6tKjmh9uUmsYo+UUE+5V8uGMK0QqLAKbg@mail.gmail.com>
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
In-Reply-To: <CAPjX3Fc6abzXgE+_S6tKjmh9uUmsYo+UUE+5V8uGMK0QqLAKbg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:NxaRR5vfzPCkeG3PWdXiX9smcp16zCFh7BoN1+nTg8WH1JAukz5
 3SW2p93ntyWCKMOOcBBlGGz3b1lXGVwTIlv6NNbvMn3roq5X10SF0Zcn+/hpR21VPi20XDz
 K3qVbyI/uIfL6HaIkf/7IJKfKpOj8hXSodSfgs5H28fx0lyATC3Ml7FBPpv2Dnpl5MxqJDH
 JOOD/krU1Z2TFd2ckYW8Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:pWqC9BiABX8=;x6ghAfa/1YXzpFj+8D+nc8LbBAZ
 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



=E5=9C=A8 2025/11/5 18:52, Daniel Vacek =E5=86=99=E9=81=93:
> On Fri, 24 Oct 2025 at 23:29, David Sterba <dsterba@suse.cz> wrote:
>>
>> On Wed, Oct 15, 2025 at 02:11:51PM +0200, Daniel Vacek wrote:
>>> From: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
>>>
>>> This recapitulates the kernel change named 'btrfs: start tracking exte=
nt
>>> encryption context info".
>>>
>>> Signed-off-by: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
>>> ---
>>>   kernel-shared/accessors.h       | 43 ++++++++++++++++++++++
>>>   kernel-shared/tree-checker.c    | 65 +++++++++++++++++++++++++++----=
=2D-
>>>   kernel-shared/uapi/btrfs_tree.h | 23 +++++++++++-
>>>   3 files changed, 118 insertions(+), 13 deletions(-)
>>>
>>> diff --git a/kernel-shared/accessors.h b/kernel-shared/accessors.h
>>> index cb96f3e2..5d90be76 100644
>>> --- a/kernel-shared/accessors.h
>>> +++ b/kernel-shared/accessors.h
>>> @@ -935,6 +935,9 @@ BTRFS_SETGET_STACK_FUNCS(super_uuid_tree_generatio=
n, struct btrfs_super_block,
>>>   BTRFS_SETGET_STACK_FUNCS(super_nr_global_roots, struct btrfs_super_b=
lock,
>>>                         nr_global_roots, 64);
>>>
>>> +/* struct btrfs_file_extent_encryption_info */
>>> +BTRFS_SETGET_FUNCS(encryption_info_size, struct btrfs_encryption_info=
, size, 32);
>>> +
>>>   /* struct btrfs_file_extent_item */
>>>   BTRFS_SETGET_STACK_FUNCS(stack_file_extent_type, struct btrfs_file_e=
xtent_item,
>>>                         type, 8);
>>> @@ -973,6 +976,46 @@ BTRFS_SETGET_FUNCS(file_extent_encryption, struct=
 btrfs_file_extent_item,
>>>   BTRFS_SETGET_FUNCS(file_extent_other_encoding, struct btrfs_file_ext=
ent_item,
>>>                   other_encoding, 16);
>>>
>>> +static inline struct btrfs_encryption_info *btrfs_file_extent_encrypt=
ion_info(
>>> +                                     const struct btrfs_file_extent_i=
tem *ei)
>>> +{
>>> +     unsigned long offset =3D (unsigned long)ei;
>>> +
>>> +     offset +=3D offsetof(struct btrfs_file_extent_item, encryption_i=
nfo);
>>> +     return (struct btrfs_encryption_info *)offset;
>>> +}
>>> +
>>> +static inline unsigned long btrfs_file_extent_encryption_ctx_offset(
>>> +                                     const struct btrfs_file_extent_i=
tem *ei)
>>> +{
>>> +     unsigned long offset =3D (unsigned long)ei;
>>> +
>>> +     offset +=3D offsetof(struct btrfs_file_extent_item, encryption_i=
nfo);
>>> +     return offset + offsetof(struct btrfs_encryption_info, context);
>>> +}
>>> +
>>> +static inline u32 btrfs_file_extent_encryption_ctx_size(
>>> +                                     const struct extent_buffer *eb,
>>> +                                     const struct btrfs_file_extent_i=
tem *ei)
>>> +{
>>> +     return btrfs_encryption_info_size(eb, btrfs_file_extent_encrypti=
on_info(ei));
>>> +}
>>> +
>>> +static inline void btrfs_set_file_extent_encryption_ctx_size(
>>> +                                     struct extent_buffer *eb,
>>> +                                     struct btrfs_file_extent_item *e=
i,
>>> +                                     u32 val)
>>> +{
>>> +     btrfs_set_encryption_info_size(eb, btrfs_file_extent_encryption_=
info(ei), val);
>>> +}
>>> +
>>> +static inline u32 btrfs_file_extent_encryption_info_size(
>>> +                                     const struct extent_buffer *eb,
>>> +                                     const struct btrfs_file_extent_i=
tem *ei)
>>> +{
>>> +     return btrfs_encryption_info_size(eb, btrfs_file_extent_encrypti=
on_info(ei));
>>> +}
>>> +
>>>   /* btrfs_qgroup_status_item */
>>>   BTRFS_SETGET_FUNCS(qgroup_status_generation, struct btrfs_qgroup_sta=
tus_item,
>>>                   generation, 64);
>>> diff --git a/kernel-shared/tree-checker.c b/kernel-shared/tree-checker=
.c
>>> index ccc1f1ea..93073979 100644
>>> --- a/kernel-shared/tree-checker.c
>>> +++ b/kernel-shared/tree-checker.c
>>> @@ -242,6 +242,8 @@ static int check_extent_data_item(struct extent_bu=
ffer *leaf,
>>>        u32 sectorsize =3D fs_info->sectorsize;
>>>        u32 item_size =3D btrfs_item_size(leaf, slot);
>>>        u64 extent_end;
>>> +     u8 policy;
>>> +     u8 fe_type;
>>>
>>>        if (unlikely(!IS_ALIGNED(key->offset, sectorsize))) {
>>>                file_extent_err(leaf, slot,
>>> @@ -272,12 +274,12 @@ static int check_extent_data_item(struct extent_=
buffer *leaf,
>>>                                SZ_4K);
>>>                return -EUCLEAN;
>>>        }
>>> -     if (unlikely(btrfs_file_extent_type(leaf, fi) >=3D
>>> -                  BTRFS_NR_FILE_EXTENT_TYPES)) {
>>> +
>>> +     fe_type =3D btrfs_file_extent_type(leaf, fi);
>>> +     if (unlikely(fe_type >=3D BTRFS_NR_FILE_EXTENT_TYPES)) {
>>>                file_extent_err(leaf, slot,
>>>                "invalid type for file extent, have %u expect range [0,=
 %u]",
>>> -                     btrfs_file_extent_type(leaf, fi),
>>> -                     BTRFS_NR_FILE_EXTENT_TYPES - 1);
>>> +                     fe_type, BTRFS_NR_FILE_EXTENT_TYPES - 1);
>>>                return -EUCLEAN;
>>>        }
>>>
>>> @@ -293,10 +295,11 @@ static int check_extent_data_item(struct extent_=
buffer *leaf,
>>>                        BTRFS_NR_COMPRESS_TYPES - 1);
>>>                return -EUCLEAN;
>>>        }
>>> -     if (unlikely(btrfs_file_extent_encryption(leaf, fi))) {
>>> +     policy =3D btrfs_file_extent_encryption(leaf, fi);
>>> +     if (unlikely(policy >=3D BTRFS_NR_ENCRYPTION_TYPES)) {
>>>                file_extent_err(leaf, slot,
>>> -                     "invalid encryption for file extent, have %u exp=
ect 0",
>>> -                     btrfs_file_extent_encryption(leaf, fi));
>>> +                     "invalid encryption for file extent, have %u exp=
ect range [0, %u]",
>>> +                     policy, BTRFS_NR_ENCRYPTION_TYPES - 1);
>>>                return -EUCLEAN;
>>>        }
>>>        if (btrfs_file_extent_type(leaf, fi) =3D=3D BTRFS_FILE_EXTENT_I=
NLINE) {
>>> @@ -325,12 +328,50 @@ static int check_extent_data_item(struct extent_=
buffer *leaf,
>>>                return 0;
>>>        }
>>>
>>> -     /* Regular or preallocated extent has fixed item size */
>>> -     if (unlikely(item_size !=3D sizeof(*fi))) {
>>> -             file_extent_err(leaf, slot,
>>> +     if (policy =3D=3D BTRFS_ENCRYPTION_FSCRYPT) {
>>> +             size_t fe_size =3D sizeof(*fi) + sizeof(struct btrfs_enc=
ryption_info);
>>> +             u32 ctxsize;
>>> +
>>> +             if (unlikely(item_size < fe_size)) {
>>> +                     file_extent_err(leaf, slot,
>>> +     "invalid item size for encrypted file extent, have %u expect =3D=
 %zu + size of u32",
>>> +                                     item_size, sizeof(*fi));
>>> +                     return -EUCLEAN;
>>> +             }
>>> +
>>> +             ctxsize =3D btrfs_file_extent_encryption_info_size(leaf,=
 fi);
>>> +             if (unlikely(item_size !=3D (fe_size + ctxsize))) {
>>> +                     file_extent_err(leaf, slot,
>>> +     "invalid item size for encrypted file extent, have %u expect =3D=
 %zu + context of size %u",
>>> +                                     item_size, fe_size, ctxsize);
>>> +                     return -EUCLEAN;
>>> +             }
>>> +
>>> +             if (unlikely(ctxsize > BTRFS_MAX_EXTENT_CTX_SIZE)) {
>>> +                     file_extent_err(leaf, slot,
>>> +     "invalid file extent context size, have %u expect a maximum of %=
u",
>>> +                                     ctxsize, BTRFS_MAX_EXTENT_CTX_SI=
ZE);
>>> +                     return -EUCLEAN;
>>> +             }
>>> +
>>> +             /*
>>> +              * Only regular and prealloc extents should have an encr=
yption
>>> +              * context.
>>> +              */
>>> +             if (unlikely(fe_type !=3D BTRFS_FILE_EXTENT_REG &&
>>> +                          fe_type !=3D BTRFS_FILE_EXTENT_PREALLOC)) {
>>> +                     file_extent_err(leaf, slot,
>>> +             "invalid type for encrypted file extent, have %u",
>>> +                                     btrfs_file_extent_type(leaf, fi)=
);
>>> +                     return -EUCLEAN;
>>> +             }
>>> +     } else {
>>> +             if (unlikely(item_size !=3D sizeof(*fi))) {
>>> +                     file_extent_err(leaf, slot,
>>>        "invalid item size for reg/prealloc file extent, have %u expect=
 %zu",
>>> -                     item_size, sizeof(*fi));
>>> -             return -EUCLEAN;
>>> +                                     item_size, sizeof(*fi));
>>> +                     return -EUCLEAN;
>>> +             }
>>>        }
>>>        if (unlikely(CHECK_FE_ALIGNED(leaf, slot, fi, ram_bytes, sector=
size) ||
>>>                     CHECK_FE_ALIGNED(leaf, slot, fi, disk_bytenr, sect=
orsize) ||
>>> diff --git a/kernel-shared/uapi/btrfs_tree.h b/kernel-shared/uapi/btrf=
s_tree.h
>>> index 7f3dffe6..4b4f45aa 100644
>>> --- a/kernel-shared/uapi/btrfs_tree.h
>>> +++ b/kernel-shared/uapi/btrfs_tree.h
>>> @@ -1066,6 +1066,24 @@ enum {
>>>        BTRFS_NR_FILE_EXTENT_TYPES =3D 3,
>>>   };
>>>
>>> +/*
>>> + * Currently just the FSCRYPT_SET_CONTEXT_MAX_SIZE, which is larger t=
han the
>>> + * current extent context size from fscrypt, so this should give us p=
lenty of
>>> + * breathing room for expansion later.
>>> + */
>>> +#define BTRFS_MAX_EXTENT_CTX_SIZE 40
>>> +
>>> +enum {
>>> +     BTRFS_ENCRYPTION_NONE,
>>> +     BTRFS_ENCRYPTION_FSCRYPT,
>>> +     BTRFS_NR_ENCRYPTION_TYPES,
>>> +};
>>> +
>>> +struct btrfs_encryption_info {
>>> +     __le32 size;
>>> +     __u8 context[0];
>>> +};
>>> +
>>>   struct btrfs_file_extent_item {
>>>        /*
>>>         * transaction id that created this extent
>>> @@ -1115,7 +1133,10 @@ struct btrfs_file_extent_item {
>>>         * always reflects the size uncompressed and without encoding.
>>>         */
>>>        __le64 num_bytes;
>>> -
>>> +     /*
>>> +      * the encryption info, if any
>>> +      */
>>> +     struct btrfs_encryption_info encryption_info[0];
>>
>> Looking at this again, adding variable length data will make it hard to
>> add more items to the file extent. We could not decide the version just
>> by the size, as done in other structures.
>=20
> Checking the details of btrfs_file_extent_item I understand the item
> is already variable size in case of inline extent.

Yeah, but I'm not sure if that is a good example to follow, or a bad=20
example to avoid.

The biggest concern is for encrypted inline data extents.
We need to put two variable sized data into a single item.
(I know there are examples like btrfs_dir_item for XATTR, but again not=20
sure if we should really follow that)

In that case the structure definition will not help, and you have to=20
determine where to put the appended encryption info, either before the=20
inlined data, or before it.

And all the extra sequence info must be implemented in extra comments,=20
which is way harder to read/understand.
 From this point of view, the original inline extent usage of=20
btrfs_file_extent_item is already an example to avoid.


But sure, the appending solution will save us 25 bytes per file extent=20
item, thus it definitely has its benefit.

I belive David will do final call, trading off between readability or=20
space saving (and more locality and less key search for encrypted file=20
extents).

Although I prefer the dedicated key solution for readability, I'm fine=20
to accept either solution.

Thanks,
Qu


> IIUC, that means that versioning based purely on item size is already
> not possible for inline file extents.
> So in the case of regular one optionally adding the encryption context
> seems similar to adding the file data for the inline case.
> And it still makes sense to me keeping the
>=20
> Perhaps the spare field `other_encoding` could eventually be used for
> versioning if ever needed?
>=20
> Let me know if you'd rather add a dedicated key for the encryption
> context as Qu suggested. To me it still kind of makes sense to keep it
> packed after the file extent info, but I'll be happy with both ways.
>=20


