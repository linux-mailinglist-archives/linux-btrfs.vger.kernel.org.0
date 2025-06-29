Return-Path: <linux-btrfs+bounces-15062-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65337AECADC
	for <lists+linux-btrfs@lfdr.de>; Sun, 29 Jun 2025 03:13:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A2803B5803
	for <lists+linux-btrfs@lfdr.de>; Sun, 29 Jun 2025 01:13:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61FCB4086A;
	Sun, 29 Jun 2025 01:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="jwSh/eJs"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0DBD12E7E
	for <linux-btrfs@vger.kernel.org>; Sun, 29 Jun 2025 01:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751159615; cv=none; b=khN/aNutMK3DHB+Gu2l9kGMIUoNlm463qLqVi/G1aE6H85/QtmNZtmrSRmSgmVoGEEjXcZUde5GAQ8Dip1gXrmB33BZmFIdbhZIu5wDquQMniK3ThoxF1je+PHLNG3g8M8oaGudOr3z7CUNaRsFZrS0KYDEmRvoNle2duWBbPds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751159615; c=relaxed/simple;
	bh=F7EvzSl1AjdX6f2u5GdNzx33FKP3e4S1fRgtHEg2ks4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=UiJSInzARRg59cPRlEADVaaMDtwJnggi32+RN+S+PO9uounF6ucV14mIPYWjuG61Sdrte6P2dk6Uisbtr9pe9KYWxx9WJQjGHSWowcq0BnRXwe7Gm01tdEg4r0XcC8ERivnWKYgcApFdmfZMmwX07IpbP8rMMzKRr0/fXHGPWnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=jwSh/eJs; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1751159610; x=1751764410; i=quwenruo.btrfs@gmx.com;
	bh=eEkdxOkS1uM1dFus//AXxJbrGR+G2AOp6Csl3De/SGU=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=jwSh/eJsqwGSc35eGIp2a90dTogZJLJuIbg5AkQKy7PT5bZTHHMYMOyC8Za4BIgy
	 ZALRfaLn+Z295UfT3zaibWs8Kjf1mrCn/DfLKKLp8PWTIYAd9uswuYmKKqnOqTxLS
	 YtlxJy+uugEY3HXJJtqnNEgsMfdfCNkj9fOgH8zkyQ7a0o5Ffcd61Xs25UR4P16rD
	 iET2ufH56oXT00xdi5aW0AQxzj8MQgFdwGRECIicqIb7OlIUxwlac9UkMfJ6X8cJw
	 WAGM3RVckH1CkUl5QkzkYOxwrsQ7pWOZCjCbna1CavFBuisbkphCt8HlixuK5LlNg
	 2IhjQYYiUymQaYdMvg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MEm27-1uUKkU1ppT-004kkY; Sun, 29
 Jun 2025 03:13:30 +0200
Message-ID: <8993e49a-7fc2-41a0-8dec-3dbbf84ec601@gmx.com>
Date: Sun, 29 Jun 2025 10:43:26 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] btrfs: accessors: delete token versions of set/get
 helpers
To: David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1751032655.git.dsterba@suse.com>
 <a7f51e27606c24c063007273d0189bad487b921f.1751032655.git.dsterba@suse.com>
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
In-Reply-To: <a7f51e27606c24c063007273d0189bad487b921f.1751032655.git.dsterba@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:DTDk+vqWiHb0DbQqURYDt2wo2y+Rc0h9y8a3Pc4KFar8kyrKXDa
 x0VOyK6/DSRxbxYluNHUHmZ4jS5tUwmoFP+UWWIT2B7kVq/69TpbxtrAvuzAksL3FOt2lhR
 uFFOhSpDXRfiJjykyQj0z7gS0zo9jWHr1YURD2EicPgnSWDt41nGhIQgWe1dbSTKfJU/7/e
 lFI1oW0j1sKglVLA8JDJw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:jKi50n1iiJc=;QpranN4J25u7QoSzxY04ZJGKhC1
 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



=E5=9C=A8 2025/6/27 23:33, David Sterba =E5=86=99=E9=81=93:
> Once upon a time there was a need to cache address of extent buffer
> pages, as it was a costly operation (map_private_extent_buffer(),
> cfed81a04eb555 ("Btrfs: add the ability to cache a pointer into the
> eb")).  This was not even due to use of HIGHMEM, this had been removed
> before that due to possible locking issues ( a65917156e3459 ("Btrfs:
> stop using highmem for extent_buffers")).
>=20
> Over the time the amount of work in the set/get helpers got reduced and
> became quite straightforward bounds checking with an unaligned
> read/write, commit db3756c879773c ("btrfs: remove unused
> map_private_extent_buffer").

Thanks a lot for the history of the token accessors.

And this is also a great chance to us to sync the removal of token eb=20
accessors to the progs.

If you haven't yet started that progs removal, I'm totally fine to do that=
.

Thanks,
Qu

>=20
> The actual caching of the page_address()/folio_address() in the token
> was more work for very little gain. This depended on subsequent access
> into the same page/folio, otherwise the cached pointer had to be
> updated.
>=20
> For metadata-heavy operations this showed up in the 'perf top' profile
> where the btrfs_get_token_32 calls were at the top, on my testing
> machine consuming about 2-3%. The other generic 32/64 bit helpers also
> appeared in the profile with similar fraction.
>=20
> After removing use of the token helpers we can remove them completely,
> this leads to reduction of btrfs.ko by 6.7KiB on release config.
>=20
>     text    data     bss     dec     hex filename
> 1463289  115665   16088 1595042  1856a2 pre/btrfs.ko
> 1456601  115665   16088 1588354  183c82 post/btrfs.ko
>=20
> DELTA: -6688
>=20
> Signed-off-by: David Sterba <dsterba@suse.com>
> ---
>   fs/btrfs/accessors.c | 78 --------------------------------------------
>   fs/btrfs/accessors.h | 37 ---------------------
>   2 files changed, 115 deletions(-)
>=20
> diff --git a/fs/btrfs/accessors.c b/fs/btrfs/accessors.c
> index e3716516ca3876..5cfb0801700e6c 100644
> --- a/fs/btrfs/accessors.c
> +++ b/fs/btrfs/accessors.c
> @@ -25,13 +25,6 @@ static bool check_setget_bounds(const struct extent_b=
uffer *eb,
>   	return true;
>   }
>  =20
> -void btrfs_init_map_token(struct btrfs_map_token *token, struct extent_=
buffer *eb)
> -{
> -	token->eb =3D eb;
> -	token->kaddr =3D folio_address(eb->folios[0]);
> -	token->offset =3D 0;
> -}
> -
>   /*
>    * Macro templates that define helpers to read/write extent buffer dat=
a of a
>    * given size, that are also used via ctree.h for access to item membe=
rs by
> @@ -41,11 +34,6 @@ void btrfs_init_map_token(struct btrfs_map_token *tok=
en, struct extent_buffer *e
>    * - btrfs_set_8 (for 8/16/32/64)
>    * - btrfs_get_8 (for 8/16/32/64)
>    *
> - * Generic helpers with a token (cached address of the most recently ac=
cessed
> - * page):
> - * - btrfs_set_token_8 (for 8/16/32/64)
> - * - btrfs_get_token_8 (for 8/16/32/64)
> - *
>    * The set/get functions handle data spanning two pages transparently,=
 in case
>    * metadata block size is larger than page.  Every pointer to metadata=
 items is
>    * an offset into the extent buffer page array, cast to a specific typ=
e.  This
> @@ -57,37 +45,6 @@ void btrfs_init_map_token(struct btrfs_map_token *tok=
en, struct extent_buffer *e
>    */
>  =20
>   #define DEFINE_BTRFS_SETGET_BITS(bits)					\
> -u##bits btrfs_get_token_##bits(struct btrfs_map_token *token,		\
> -			       const void *ptr, unsigned long off)	\
> -{									\
> -	const unsigned long member_offset =3D (unsigned long)ptr + off;	\
> -	const unsigned long idx =3D get_eb_folio_index(token->eb, member_offse=
t); \
> -	const unsigned long oil =3D get_eb_offset_in_folio(token->eb,	\
> -							 member_offset);\
> -	const int unit_size =3D token->eb->folio_size;			\
> -	const int unit_shift =3D token->eb->folio_shift;			\
> -	const int size =3D sizeof(u##bits);				\
> -	u8 lebytes[sizeof(u##bits)];					\
> -	const int part =3D unit_size - oil;				\
> -									\
> -	ASSERT(token);							\
> -	ASSERT(token->kaddr);						\
> -	ASSERT(check_setget_bounds(token->eb, ptr, off, size));		\
> -	if (token->offset <=3D member_offset &&				\
> -	    member_offset + size <=3D token->offset + unit_size) {	\
> -		return get_unaligned_le##bits(token->kaddr + oil);	\
> -	}								\
> -	token->kaddr =3D folio_address(token->eb->folios[idx]);		\
> -	token->offset =3D idx << unit_shift;				\
> -	if (INLINE_EXTENT_BUFFER_PAGES =3D=3D 1 || oil + size <=3D unit_size) =
\
> -		return get_unaligned_le##bits(token->kaddr + oil);	\
> -									\
> -	memcpy(lebytes, token->kaddr + oil, part);			\
> -	token->kaddr =3D folio_address(token->eb->folios[idx + 1]);	\
> -	token->offset =3D (idx + 1) << unit_shift;			\
> -	memcpy(lebytes + part, token->kaddr, size - part);		\
> -	return get_unaligned_le##bits(lebytes);				\
> -}									\
>   u##bits btrfs_get_##bits(const struct extent_buffer *eb,		\
>   			 const void *ptr, unsigned long off)		\
>   {									\
> @@ -110,41 +67,6 @@ u##bits btrfs_get_##bits(const struct extent_buffer =
*eb,		\
>   	memcpy(lebytes + part, kaddr, size - part);			\
>   	return get_unaligned_le##bits(lebytes);				\
>   }									\
> -void btrfs_set_token_##bits(struct btrfs_map_token *token,		\
> -			    const void *ptr, unsigned long off,		\
> -			    u##bits val)				\
> -{									\
> -	const unsigned long member_offset =3D (unsigned long)ptr + off;	\
> -	const unsigned long idx =3D get_eb_folio_index(token->eb, member_offse=
t); \
> -	const unsigned long oil =3D get_eb_offset_in_folio(token->eb,	\
> -							 member_offset);\
> -	const int unit_size =3D token->eb->folio_size;			\
> -	const int unit_shift =3D token->eb->folio_shift;			\
> -	const int size =3D sizeof(u##bits);				\
> -	u8 lebytes[sizeof(u##bits)];					\
> -	const int part =3D unit_size - oil;				\
> -									\
> -	ASSERT(token);							\
> -	ASSERT(token->kaddr);						\
> -	ASSERT(check_setget_bounds(token->eb, ptr, off, size));		\
> -	if (token->offset <=3D member_offset &&				\
> -	    member_offset + size <=3D token->offset + unit_size) {	\
> -		put_unaligned_le##bits(val, token->kaddr + oil);	\
> -		return;							\
> -	}								\
> -	token->kaddr =3D folio_address(token->eb->folios[idx]);		\
> -	token->offset =3D idx << unit_shift;				\
> -	if (INLINE_EXTENT_BUFFER_PAGES =3D=3D 1 ||				\
> -	    oil + size <=3D unit_size) {					\
> -		put_unaligned_le##bits(val, token->kaddr + oil);	\
> -		return;							\
> -	}								\
> -	put_unaligned_le##bits(val, lebytes);				\
> -	memcpy(token->kaddr + oil, lebytes, part);			\
> -	token->kaddr =3D folio_address(token->eb->folios[idx + 1]);	\
> -	token->offset =3D (idx + 1) << unit_shift;			\
> -	memcpy(token->kaddr, lebytes + part, size - part);		\
> -}									\
>   void btrfs_set_##bits(const struct extent_buffer *eb, void *ptr,	\
>   		      unsigned long off, u##bits val)			\
>   {									\
> diff --git a/fs/btrfs/accessors.h b/fs/btrfs/accessors.h
> index 15ea6348800b08..99b3ced12805bb 100644
> --- a/fs/btrfs/accessors.h
> +++ b/fs/btrfs/accessors.h
> @@ -16,14 +16,6 @@
>  =20
>   struct extent_buffer;
>  =20
> -struct btrfs_map_token {
> -	struct extent_buffer *eb;
> -	char *kaddr;
> -	unsigned long offset;
> -};
> -
> -void btrfs_init_map_token(struct btrfs_map_token *token, struct extent_=
buffer *eb);
> -
>   /*
>    * Some macros to generate set/get functions for the struct fields.  T=
his
>    * assumes there is a lefoo_to_cpu for every type, so lets make a simp=
le one
> @@ -56,11 +48,6 @@ static inline void put_unaligned_le8(u8 val, void *p)
>   			    sizeof_field(type, member)))
>  =20
>   #define DECLARE_BTRFS_SETGET_BITS(bits)					\
> -u##bits btrfs_get_token_##bits(struct btrfs_map_token *token,		\
> -			       const void *ptr, unsigned long off);	\
> -void btrfs_set_token_##bits(struct btrfs_map_token *token,		\
> -			    const void *ptr, unsigned long off,		\
> -			    u##bits val);				\
>   u##bits btrfs_get_##bits(const struct extent_buffer *eb,		\
>   			 const void *ptr, unsigned long off);		\
>   void btrfs_set_##bits(const struct extent_buffer *eb, void *ptr,	\
> @@ -83,18 +70,6 @@ static inline void btrfs_set_##name(const struct exte=
nt_buffer *eb, type *s, \
>   {									\
>   	static_assert(sizeof(u##bits) =3D=3D sizeof_field(type, member));	\
>   	btrfs_set_##bits(eb, s, offsetof(type, member), val);		\
> -}									\
> -static inline u##bits btrfs_token_##name(struct btrfs_map_token *token,=
	\
> -					 const type *s)			\
> -{									\
> -	static_assert(sizeof(u##bits) =3D=3D sizeof_field(type, member));	\
> -	return btrfs_get_token_##bits(token, s, offsetof(type, member));\
> -}									\
> -static inline void btrfs_set_token_##name(struct btrfs_map_token *token=
,\
> -					  type *s, u##bits val)		\
> -{									\
> -	static_assert(sizeof(u##bits) =3D=3D sizeof_field(type, member));	\
> -	btrfs_set_token_##bits(token, s, offsetof(type, member), val);	\
>   }
>  =20
>   #define BTRFS_SETGET_HEADER_FUNCS(name, type, member, bits)		\
> @@ -479,18 +454,6 @@ static inline void btrfs_set_item_##member(const st=
ruct extent_buffer *eb,	\
>   					   int slot, u32 val)			\
>   {										\
>   	btrfs_set_raw_item_##member(eb, btrfs_item_nr(eb, slot), val);		\
> -}										\
> -static inline u32 btrfs_token_item_##member(struct btrfs_map_token *tok=
en,	\
> -					    int slot)				\
> -{										\
> -	struct btrfs_item *item =3D btrfs_item_nr(token->eb, slot);		\
> -	return btrfs_token_raw_item_##member(token, item);			\
> -}										\
> -static inline void btrfs_set_token_item_##member(struct btrfs_map_token=
 *token,	\
> -						 int slot, u32 val)		\
> -{										\
> -	struct btrfs_item *item =3D btrfs_item_nr(token->eb, slot);		\
> -	btrfs_set_token_raw_item_##member(token, item, val);			\
>   }
>  =20
>   BTRFS_ITEM_SETGET_FUNCS(offset)


