Return-Path: <linux-btrfs+bounces-22082-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oMSQHgcDomn5yAQAu9opvQ
	(envelope-from <linux-btrfs+bounces-22082-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Feb 2026 21:48:07 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C5CC1BDEEC
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Feb 2026 21:48:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BE7B431B2D6A
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Feb 2026 20:44:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B158477E52;
	Fri, 27 Feb 2026 20:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="Efiu/nCI"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0772F31B131;
	Fri, 27 Feb 2026 20:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772225058; cv=none; b=Stfipye8GKK2FRWr68catPZfSv+TBarapkMCdU0A9I2y/xMM1+nVm9m2WRT0p7wzhgtJyepxoG+QBBwd0W1VOTkt/mYm12Mf6D+XhDCvuFGDWdKHd0wCn/FiHAQ7PcPc1gO0nTawQUHX1EiwtkTtcS+oOP4EwXEMeRjOqzybmMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772225058; c=relaxed/simple;
	bh=EUozAguYG16J7RtAQvIuOWZ/1FpBTQplGom6rqvplCU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MEueYYC20e4JYA1egA6dchSK1XBf6poVGp3Jgi6WK5zU+kfmoeU5ya68eYnFSmpVYL1h8p9FyKUleuUDf8CYA6TCDmpmC/23wp0Dw250C2TF2Dw64oxU4e3NShEidjZlOW7/43rftJ3sA6Vlzj2L8ESMhtNj6M/VyS0EknwLTiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=Efiu/nCI; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1772225046; x=1772829846; i=quwenruo.btrfs@gmx.com;
	bh=prScm4PAOygjZfuFTTh8WU8QmGxe9svqQVgBkUVpogM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=Efiu/nCIH5yAwsumS+cetYvzbR/tgGAJiYDPwyPQ1JMT1oYd2fFtJYpjc2ub4Fqg
	 zxrpeJCmxH6h0sBIDgbulUHiAIgpWvJmUVY/coCEd47z+bLNtDVVkePpbO5pAtIXS
	 9+jUjxJ+0BXYOMQWDhHbaWZuwXFC8JtV+BAUCLppGKyKu5vpQNqcEYDVdiI+tBbFX
	 lrLzHrohh790VP8XlifB4gJQUubUW/Nt35u0G89c6aaTbQzc6QMkVdxT+8ejo535X
	 W44fi89Moi/xA6hcq/jPAvd4ribLC8sHflTkrLHfVTGNAKmd9t2NOOhdLDF9hKyl7
	 PIjzn61/XCFoGX3aXA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N2mBQ-1vZEML2UdI-00xf45; Fri, 27
 Feb 2026 21:44:06 +0100
Message-ID: <76483879-54b1-4cea-ab1c-4642283093bc@gmx.com>
Date: Sat, 28 Feb 2026 07:13:50 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] btrfs: clean coding style errors and warnings in
 compression.c
To: Adarsh Das <adarshdas950@gmail.com>, clm@fb.com, dsterba@suse.com
Cc: terrelln@fb.com, linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260227183111.9311-1-adarshdas950@gmail.com>
 <20260227183111.9311-3-adarshdas950@gmail.com>
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
In-Reply-To: <20260227183111.9311-3-adarshdas950@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:OgocCauu3m1JLoqHu8sI78NzBdD37IgMIxskHdQ6xLH0565bMSR
 tGuNX3k4NoNXsSyAogHsbHCTkGmbflqDVrVPcDNZH5+og1M5VctHbenqOgBs0yzWbQsW4fg
 aK5TsHddVNsSMtVjGBuggW+gNd8BLYwXGcJfKV98X4AcMPrqcnsbUIbzzHhTjVbTPzghtAW
 PpXdS0UmSqhzGhKfo0npw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:RHX+j2prwWs=;54ZbwFhItuFImlz2cBCabLVGNpI
 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
 eDCPnFIEKWZzRI5cEFxHGEWJixenY
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmx.com,quarantine];
	R_DKIM_ALLOW(-0.20)[gmx.com:s=s31663417];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22082-lists,linux-btrfs=lfdr.de];
	FREEMAIL_FROM(0.00)[gmx.com];
	FREEMAIL_TO(0.00)[gmail.com,fb.com,suse.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[quwenruo.btrfs@gmx.com,linux-btrfs@vger.kernel.org];
	DKIM_TRACE(0.00)[gmx.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,gmx.com:mid,gmx.com:dkim]
X-Rspamd-Queue-Id: 1C5CC1BDEEC
X-Rspamd-Action: no action



=E5=9C=A8 2026/2/28 05:01, Adarsh Das =E5=86=99=E9=81=93:
> As the previous patch is making changes to compression.c, this patch
> takes the oppurtunity to fix errors and warning in compression.c
>=20
> Signed-off-by: Adarsh Das <adarshdas950@gmail.com>

This minor cleanup should be folded into the previous patch.

Thanks,
Qu

> ---
>   fs/btrfs/compression.c | 24 +++++++++++++-----------
>   1 file changed, 13 insertions(+), 11 deletions(-)
>=20
> diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
> index 29281aba925e..6c3be3550442 100644
> --- a/fs/btrfs/compression.c
> +++ b/fs/btrfs/compression.c
> @@ -36,9 +36,9 @@
>  =20
>   static struct bio_set btrfs_compressed_bioset;
>  =20
> -static const char* const btrfs_compress_types[] =3D { "", "zlib", "lzo"=
, "zstd" };
> +static const char * const btrfs_compress_types[] =3D { "", "zlib", "lzo=
", "zstd" };
>  =20
> -const char* btrfs_compress_type2str(enum btrfs_compression_type type)
> +const char *btrfs_compress_type2str(enum btrfs_compression_type type)
>   {
>   	switch (type) {
>   	case BTRFS_COMPRESS_ZLIB:
> @@ -478,6 +478,7 @@ static noinline int add_ra_bio_pages(struct inode *i=
node,
>  =20
>   			if (zero_offset) {
>   				int zeros;
> +
>   				zeros =3D folio_size(folio) - zero_offset;
>   				folio_zero_range(folio, zero_offset, zeros);
>   			}
> @@ -780,7 +781,7 @@ struct list_head *btrfs_get_workspace(struct btrfs_f=
s_info *fs_info, int type, i
>   	struct workspace_manager *wsm =3D fs_info->compr_wsm[type];
>   	struct list_head *workspace;
>   	int cpus =3D num_online_cpus();
> -	unsigned nofs_flag;
> +	unsigned int nofs_flag;
>   	struct list_head *idle_ws;
>   	spinlock_t *ws_lock;
>   	atomic_t *total_ws;
> @@ -1163,17 +1164,17 @@ static u64 file_offset_from_bvec(const struct bi=
o_vec *bvec)
>    * @buf:		The decompressed data buffer
>    * @buf_len:		The decompressed data length
>    * @decompressed:	Number of bytes that are already decompressed inside=
 the
> - * 			compressed extent
> + *			compressed extent
>    * @cb:			The compressed extent descriptor
>    * @orig_bio:		The original bio that the caller wants to read for
>    *
>    * An easier to understand graph is like below:
>    *
> - * 		|<- orig_bio ->|     |<- orig_bio->|
> - * 	|<-------      full decompressed extent      ----->|
> - * 	|<-----------    @cb range   ---->|
> - * 	|			|<-- @buf_len -->|
> - * 	|<--- @decompressed --->|
> + *		|<- orig_bio ->|     |<- orig_bio->|
> + *	|<-------      full decompressed extent      ----->|
> + *	|<-----------    @cb range   ---->|
> + *	|			|<-- @buf_len -->|
> + *	|<--- @decompressed --->|
>    *
>    * Note that, @cb can be a subpage of the full decompressed extent, bu=
t
>    * @cb->start always has the same as the orig_file_offset value of the=
 full
> @@ -1295,7 +1296,8 @@ static u32 shannon_entropy(struct heuristic_ws *ws=
)
>   #define RADIX_BASE		4U
>   #define COUNTERS_SIZE		(1U << RADIX_BASE)
>  =20
> -static u8 get4bits(u64 num, int shift) {
> +static u8 get4bits(u64 num, int shift)
> +{
>   	u8 low4bits;
>  =20
>   	num >>=3D shift;
> @@ -1370,7 +1372,7 @@ static void radix_sort(struct bucket_item *array, =
struct bucket_item *array_buf,
>   		 */
>   		memset(counters, 0, sizeof(counters));
>  =20
> -		for (i =3D 0; i < num; i ++) {
> +		for (i =3D 0; i < num; i++) {
>   			buf_num =3D array_buf[i].count;
>   			addr =3D get4bits(buf_num, shift);
>   			counters[addr]++;


