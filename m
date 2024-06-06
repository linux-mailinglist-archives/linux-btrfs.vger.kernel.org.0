Return-Path: <linux-btrfs+bounces-5512-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 00D298FF7A5
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 Jun 2024 00:28:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5CE2B1F22E60
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Jun 2024 22:28:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BECB13C9AF;
	Thu,  6 Jun 2024 22:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="mNRp0vZw"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11B716EB4D
	for <linux-btrfs@vger.kernel.org>; Thu,  6 Jun 2024 22:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717712925; cv=none; b=Yft+E5Zo84UZV2MW7D5exQEqPYje0lXVO46iAj9wonr/XkXAwcBJtHtqT2itq2D4AVF3hcmUuoaPhMBeK1GPRoBv2XXIQVY7Ro0VB2KB3B+yDVbXx51saURw2VKorDPhjvcP1X/rZRHmslpB2zNlTJQ/GLIJKmex/8AK0E/nJvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717712925; c=relaxed/simple;
	bh=nVvFvHa0GLSCOYuuCnTul/VCQlBiA4LKkPg7cOzLb34=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZP3bR2I7Dm+z9Zu8nfhIjfs2Pbk9HbuPD18eWyIW9rBFe7XLBltAHs29ybHzKjqDaxa52MCuNNhNsTtbe57mSO+WLEjNXVU2v1Fk15pZKiH15izUu9/ZSevK8JxJHeIn0z7T1SR0uSFiJY0MXx6YaWgc+mMzupPTk0hHSQrHVnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=mNRp0vZw; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1717712913; x=1718317713; i=quwenruo.btrfs@gmx.com;
	bh=18fKoc0KtrhCnmDq6VWPH0MiVT7G5v0MZjNUCq2c98w=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=mNRp0vZwl1iRcUCv3VBMAKapnQVDb0ZV9j3NhounqTQt9TWXMFDwBBcQtspiskp4
	 OY82l8xij3jIFASo0puw5sqdMzv/sUOt0+TeNI5omU6qSvKn2B25nb/aTamtlgczE
	 HdypoVkVAjBLHt8si/EYktjYDM9x5TJ8sERCJsYayu3v+KWAsJFsWMofS92JyhDsL
	 2hsTFZBbsX9lIUY6vYl38gJQdEG0uaiQ3wmHeT7QnFMU1lU78tp5OTm9k//KnQUel
	 f97pJ7Voagv5To1JwIfLtHaGQg6kjqpw2RLAU5/ZCewgOa6hyMXS7v57kTpwcpOhQ
	 xq9lZ/Nt0juDKejmCg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.219] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N0oG5-1scuqz192z-00z3we; Fri, 07
 Jun 2024 00:28:33 +0200
Message-ID: <c3060faf-f0e8-4bd2-865b-332e423a8801@gmx.com>
Date: Fri, 7 Jun 2024 07:58:25 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] btrfs-progs: convert: Add 64 bit block numbers support
To: Srivathsa Dara <srivathsa.d.dara@oracle.com>, linux-btrfs@vger.kernel.org
Cc: rajesh.sivaramasubramaniom@oracle.com, junxiao.bi@oracle.com, clm@fb.com,
 josef@toxicpanda.com, dsterba@suse.com
References: <20240606102215.3695032-1-srivathsa.d.dara@oracle.com>
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
In-Reply-To: <20240606102215.3695032-1-srivathsa.d.dara@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:vLftRxXbfABc+uDSQ/5sjUM7GXjdcN41OKIgFUgQBRIvNYTKMB7
 pVefJL/2EnAAp83DvdTGjxO58Fff1mtnmij1aRRDPrKqtMA5UC9kjBvs46HMMJQ3QY6Np+e
 ZuYE75/Wx/zzNl8aESNwL52iEKIjU1TGtPvbz01BEmpp73uDVufDh+x8NQabTVGV2VCwcoC
 9bLtYlhpOSHSijrdIVm4A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:mSiUBUp8MpU=;sQdNGi52JFmYLwqRG0cOYM54Whh
 27RtCZfmUBKNCc1+gvJwdSxGqWnHlo03QaFDmtwyDWcoUqen7+r7p11qFwAdyTXkZFXCB3vf0
 nM8NGHuOwcnnilSCWdLMte3jGe+7EmhbX6ZbqtKh1cFaMkuZT7WjPz3hypVxo05ZXESxYVHFw
 R7iX5pcgLi5RhHX62HsYHfjs7vtjkYEn33If3F1eikRjUrkHpj89dbeSPPRJlWMcPmrkUaeSO
 DQjS/GFljueDV3D3ptebUpi7EDmO/C7rt91z192SfPRrfM43To57RXGoYMZ+3luH1Ydxhyqge
 xNua3JT1ft8Is5wxVn9G2frqkx21J8RwuznA12P+5k+BQQaR1jz+UFD47cY4GeGwuiDavhSnr
 mpfqGhPIeN6W8QZs8vtiElpxaC2NuQz5XnZKmCVf35FRQcfsrY9BSUV3cVjhnAP8fpYGkCPGj
 gkKOAARX5mQ/ISi0Mxc+iGZ2+ivAZfifSiS84FTNPggGEM31S0R5YzpECkzYZ/HvVGreTdDFQ
 TbSH4cghISiR5XVAKaMLCL+29f+yv74EKCjbCTyQLXvSiVpE37cYDwMZ4+qmdf/gYlZhYd/Nk
 XPIZFxTgXLlvkr55rapsYTZd9zy1UBVwR1ziG8n6kGK4TfvoUP6q7yhhkvU6kV5cCB+20BsKA
 /KojXkLk1g+/eCpqBQmdf4DmVmdebTCOn1BcXbW9Lyw3UkZLsTn8Vn1BO001tweLb4F8wxDnZ
 zQpOGPCg3Vrlyn3+6IWEq1UD5WORgq8Zt7NcVsP62YkJGnnJBeoNoooDcUpamVhgqjW2aq7Mm
 0q6GQefmieRIGaRX+vUXYz0sOIbWtOMXksVuuKotm5cHM=



=E5=9C=A8 2024/6/6 19:52, Srivathsa Dara =E5=86=99=E9=81=93:
> In ext4, number of blocks can be greater than 2^32. Therefore, if
> btrfs-convert is used on filesystems greater than 16TiB (Staring from
> 16TiB, number of blocks overflow 32 bits), it fails to convert.
>
> Example:
>
> Here, /dev/sdc1 is 16TiB partition intitialized with an ext4 filesystem.
>
> [root@rasivara-arm2 opc]# btrfs-convert -d -p /dev/sdc1
> btrfs-convert from btrfs-progs v5.15.1
>
> convert/main.c:1164: do_convert: Assertion `cctx.total_bytes !=3D 0` fai=
led, value 0
> btrfs-convert(+0xfd04)[0xaaaaba44fd04]
> btrfs-convert(main+0x258)[0xaaaaba44d278]
> /lib64/libc.so.6(__libc_start_main+0xdc)[0xffffb962777c]
> btrfs-convert(+0xd4fc)[0xaaaaba44d4fc]
> Aborted (core dumped)
>
> Fix it by considering 64 bit block numbers.
>
> Signed-off-by: Srivathsa Dara <srivathsa.d.dara@oracle.com>
> ---
>   convert/source-ext2.c | 6 +++---
>   convert/source-ext2.h | 2 +-
>   2 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/convert/source-ext2.c b/convert/source-ext2.c
> index 2186b252..afa48606 100644
> --- a/convert/source-ext2.c
> +++ b/convert/source-ext2.c
> @@ -288,8 +288,8 @@ error:
>   	return -1;
>   }
>
> -static int ext2_block_iterate_proc(ext2_filsys fs, blk_t *blocknr,
> -			        e2_blkcnt_t blockcnt, blk_t ref_block,
> +static int ext2_block_iterate_proc(ext2_filsys fs, blk64_t *blocknr,
> +			        e2_blkcnt_t blockcnt, blk64_t ref_block,
>   			        int ref_offset, void *priv_data)
>   {
>   	int ret;
> @@ -323,7 +323,7 @@ static int ext2_create_file_extents(struct btrfs_tra=
ns_handle *trans,
>   	init_blk_iterate_data(&data, trans, root, btrfs_inode, objectid,
>   			convert_flags & CONVERT_FLAG_DATACSUM);
>
> -	err =3D ext2fs_block_iterate2(ext2_fs, ext2_ino, BLOCK_FLAG_DATA_ONLY,
> +	err =3D ext2fs_block_iterate3(ext2_fs, ext2_ino, BLOCK_FLAG_DATA_ONLY,
>   				    NULL, ext2_block_iterate_proc, &data);

I'm wondering does ext2 really supports 64bit block number.

For ext* fs with extent support (3 and 4), we're no longer utilizing
ext2fs_block_iterate2(), instead we go with iterate_file_extents()
instead, and that function is already using blk64_t for both file offset
and the block number.

I'm guessing the code base doesn't have the latest c23e068aaf91
("btrfs-progs: convert: rework file extent iteration to handle unwritten
extents") commit yet?


>   	if (err)
>   		goto error;
> diff --git a/convert/source-ext2.h b/convert/source-ext2.h
> index d204aac5..62c9b1fa 100644
> --- a/convert/source-ext2.h
> +++ b/convert/source-ext2.h
> @@ -46,7 +46,7 @@ struct btrfs_trans_handle;
>   #define ext2fs_get_block_bitmap_range2 ext2fs_get_block_bitmap_range
>   #define ext2fs_inode_data_blocks2 ext2fs_inode_data_blocks
>   #define ext2fs_read_ext_attr2 ext2fs_read_ext_attr
> -#define ext2fs_blocks_count(s)		((s)->s_blocks_count)
> +#define ext2fs_blocks_count(s)		(((s)->s_blocks_count_hi << 32) | (s)->=
s_blocks_count)

This is definitely needed, or it would trigger the ASSERT().

But again, the newer btrfs-progs no longer go with internally defined
ext2fs_blocks_count(), but using the one from e2fsprogs headers, and the
library version is already returning blk64_t.

So I'm afraid you're testing an older version of btrfs-progs.

Thanks,
Qu
>   #define EXT2FS_CLUSTER_RATIO(fs)	(1)
>   #define EXT2_CLUSTERS_PER_GROUP(s)	(EXT2_BLOCKS_PER_GROUP(s))
>   #define EXT2FS_B2C(fs, blk)		(blk)

