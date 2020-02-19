Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7363C164021
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Feb 2020 10:19:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726270AbgBSJTP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 19 Feb 2020 04:19:15 -0500
Received: from mx2.suse.de ([195.135.220.15]:38948 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726202AbgBSJTO (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 19 Feb 2020 04:19:14 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id EEEE6AD9F;
        Wed, 19 Feb 2020 09:19:11 +0000 (UTC)
Subject: Re: [PATCH 1/2] btrfs-progs: check: Detect file extent end overflow
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Cc:     Samir Benmendil <me@rmz.io>
References: <20200219070443.43189-1-wqu@suse.com>
From:   Nikolay Borisov <nborisov@suse.com>
Autocrypt: addr=nborisov@suse.com; prefer-encrypt=mutual; keydata=
 xsFNBFiKBz4BEADNHZmqwhuN6EAzXj9SpPpH/nSSP8YgfwoOqwrP+JR4pIqRK0AWWeWCSwmZ
 T7g+RbfPFlmQp+EwFWOtABXlKC54zgSf+uulGwx5JAUFVUIRBmnHOYi/lUiE0yhpnb1KCA7f
 u/W+DkwGerXqhhe9TvQoGwgCKNfzFPZoM+gZrm+kWv03QLUCr210n4cwaCPJ0Nr9Z3c582xc
 bCUVbsjt7BN0CFa2BByulrx5xD9sDAYIqfLCcZetAqsTRGxM7LD0kh5WlKzOeAXj5r8DOrU2
 GdZS33uKZI/kZJZVytSmZpswDsKhnGzRN1BANGP8sC+WD4eRXajOmNh2HL4P+meO1TlM3GLl
 EQd2shHFY0qjEo7wxKZI1RyZZ5AgJnSmehrPCyuIyVY210CbMaIKHUIsTqRgY5GaNME24w7h
 TyyVCy2qAM8fLJ4Vw5bycM/u5xfWm7gyTb9V1TkZ3o1MTrEsrcqFiRrBY94Rs0oQkZvunqia
 c+NprYSaOG1Cta14o94eMH271Kka/reEwSZkC7T+o9hZ4zi2CcLcY0DXj0qdId7vUKSJjEep
 c++s8ncFekh1MPhkOgNj8pk17OAESanmDwksmzh1j12lgA5lTFPrJeRNu6/isC2zyZhTwMWs
 k3LkcTa8ZXxh0RfWAqgx/ogKPk4ZxOXQEZetkEyTFghbRH2BIwARAQABzSJOaWtvbGF5IEJv
 cmlzb3YgPG5ib3Jpc292QHN1c2UuZGU+wsF4BBMBAgAiBQJYijkSAhsDBgsJCAcDAgYVCAIJ
 CgsEFgIDAQIeAQIXgAAKCRBxvoJG5T8oV/B6D/9a8EcRPdHg8uLEPywuJR8URwXzkofT5bZE
 IfGF0Z+Lt2ADe+nLOXrwKsamhweUFAvwEUxxnndovRLPOpWerTOAl47lxad08080jXnGfYFS
 Dc+ew7C3SFI4tFFHln8Y22Q9075saZ2yQS1ywJy+TFPADIprAZXnPbbbNbGtJLoq0LTiESnD
 w/SUC6sfikYwGRS94Dc9qO4nWyEvBK3Ql8NkoY0Sjky3B0vL572Gq0ytILDDGYuZVo4alUs8
 LeXS5ukoZIw1QYXVstDJQnYjFxYgoQ5uGVi4t7FsFM/6ykYDzbIPNOx49Rbh9W4uKsLVhTzG
 BDTzdvX4ARl9La2kCQIjjWRg+XGuBM5rxT/NaTS78PXjhqWNYlGc5OhO0l8e5DIS2tXwYMDY
 LuHYNkkpMFksBslldvNttSNei7xr5VwjVqW4vASk2Aak5AleXZS+xIq2FADPS/XSgIaepyTV
 tkfnyreep1pk09cjfXY4A7qpEFwazCRZg9LLvYVc2M2eFQHDMtXsH59nOMstXx2OtNMcx5p8
 0a5FHXE/HoXz3p9bD0uIUq6p04VYOHsMasHqHPbsMAq9V2OCytJQPWwe46bBjYZCOwG0+x58
 fBFreP/NiJNeTQPOa6FoxLOLXMuVtpbcXIqKQDoEte9aMpoj9L24f60G4q+pL/54ql2VRscK
 d87BTQRYigc+ARAAyJSq9EFk28++SLfg791xOh28tLI6Yr8wwEOvM3wKeTfTZd+caVb9gBBy
 wxYhIopKlK1zq2YP7ZjTP1aPJGoWvcQZ8fVFdK/1nW+Z8/NTjaOx1mfrrtTGtFxVBdSCgqBB
 jHTnlDYV1R5plJqK+ggEP1a0mr/rpQ9dFGvgf/5jkVpRnH6BY0aYFPprRL8ZCcdv2DeeicOO
 YMobD5g7g/poQzHLLeT0+y1qiLIFefNABLN06Lf0GBZC5l8hCM3Rpb4ObyQ4B9PmL/KTn2FV
 Xq/c0scGMdXD2QeWLePC+yLMhf1fZby1vVJ59pXGq+o7XXfYA7xX0JsTUNxVPx/MgK8aLjYW
 hX+TRA4bCr4uYt/S3ThDRywSX6Hr1lyp4FJBwgyb8iv42it8KvoeOsHqVbuCIGRCXqGGiaeX
 Wa0M/oxN1vJjMSIEVzBAPi16tztL/wQtFHJtZAdCnuzFAz8ue6GzvsyBj97pzkBVacwp3/Mw
 qbiu7sDz7yB0d7J2tFBJYNpVt/Lce6nQhrvon0VqiWeMHxgtQ4k92Eja9u80JDaKnHDdjdwq
 FUikZirB28UiLPQV6PvCckgIiukmz/5ctAfKpyYRGfez+JbAGl6iCvHYt/wAZ7Oqe/3Cirs5
 KhaXBcMmJR1qo8QH8eYZ+qhFE3bSPH446+5oEw8A9v5oonKV7zMAEQEAAcLBXwQYAQIACQUC
 WIoHPgIbDAAKCRBxvoJG5T8oV1pyD/4zdXdOL0lhkSIjJWGqz7Idvo0wjVHSSQCbOwZDWNTN
 JBTP0BUxHpPu/Z8gRNNP9/k6i63T4eL1xjy4umTwJaej1X15H8Hsh+zakADyWHadbjcUXCkg
 OJK4NsfqhMuaIYIHbToi9K5pAKnV953xTrK6oYVyd/Rmkmb+wgsbYQJ0Ur1Ficwhp6qU1CaJ
 mJwFjaWaVgUERoxcejL4ruds66LM9Z1Qqgoer62ZneID6ovmzpCWbi2sfbz98+kW46aA/w8r
 7sulgs1KXWhBSv5aWqKU8C4twKjlV2XsztUUsyrjHFj91j31pnHRklBgXHTD/pSRsN0UvM26
 lPs0g3ryVlG5wiZ9+JbI3sKMfbdfdOeLxtL25ujs443rw1s/PVghphoeadVAKMPINeRCgoJH
 zZV/2Z/myWPRWWl/79amy/9MfxffZqO9rfugRBORY0ywPHLDdo9Kmzoxoxp9w3uTrTLZaT9M
 KIuxEcV8wcVjr+Wr9zRl06waOCkgrQbTPp631hToxo+4rA1jiQF2M80HAet65ytBVR2pFGZF
 zGYYLqiG+mpUZ+FPjxk9kpkRYz61mTLSY7tuFljExfJWMGfgSg1OxfLV631jV1TcdUnx+h3l
 Sqs2vMhAVt14zT8mpIuu2VNxcontxgVr1kzYA/tQg32fVRbGr449j1gw57BV9i0vww==
Message-ID: <3bc4fa9f-ffbd-9965-bdf7-07606218c526@suse.com>
Date:   Wed, 19 Feb 2020 11:19:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200219070443.43189-1-wqu@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 19.02.20 г. 9:04 ч., Qu Wenruo wrote:
> There is a report about tree-checker rejecting some leaves due to bad
> EXTENT_DATA.
> 
> The offending EXTENT_DATA looks like:
> 	item 72 key (1359622 EXTENT_DATA 475136) itemoff 11140 itemsize 53
> 		generation 954719 type 1 (regular)
> 		extent data disk byte 0 nr 0
> 		extent data offset 0 nr 18446744073709486080 ram 18446744073709486080
> 		extent compression 0 (none)
> 
> Add such check to both original and lowmem mode to detect such problem.
> 
> Reported-by: Samir Benmendil <me@rmz.io>
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  check/main.c          | 4 ++++
>  check/mode-common.h   | 7 +++++++
>  check/mode-lowmem.c   | 7 +++++++
>  check/mode-original.h | 1 +
>  4 files changed, 19 insertions(+)
> 
> diff --git a/check/main.c b/check/main.c
> index d02dd1636852..f71bf4f74129 100644
> --- a/check/main.c
> +++ b/check/main.c
> @@ -597,6 +597,8 @@ static void print_inode_error(struct btrfs_root *root, struct inode_record *rec)
>  		fprintf(stderr, ", odd file extent");
>  	if (errors & I_ERR_BAD_FILE_EXTENT)
>  		fprintf(stderr, ", bad file extent");
> +	if (errors & I_ERR_FILE_EXTENT_OVERFLOW)
> +		fprintf(stderr, ", file extent end overflow");
>  	if (errors & I_ERR_FILE_EXTENT_OVERLAP)
>  		fprintf(stderr, ", file extent overlap");
>  	if (errors & I_ERR_FILE_EXTENT_TOO_LARGE)
> @@ -1595,6 +1597,8 @@ static int process_file_extent(struct btrfs_root *root,
>  		num_bytes = btrfs_file_extent_num_bytes(eb, fi);
>  		disk_bytenr = btrfs_file_extent_disk_bytenr(eb, fi);
>  		extent_offset = btrfs_file_extent_offset(eb, fi);
> +		if (u64_add_overflow(key->offset, num_bytes))
> +			rec->errors |= I_ERR_FILE_EXTENT_OVERFLOW;
>  		if (num_bytes == 0 || (num_bytes & mask))
>  			rec->errors |= I_ERR_BAD_FILE_EXTENT;
>  		if (num_bytes + extent_offset >
> diff --git a/check/mode-common.h b/check/mode-common.h
> index edf9257edaf0..daa5741e1d67 100644
> --- a/check/mode-common.h
> +++ b/check/mode-common.h
> @@ -173,4 +173,11 @@ static inline u32 btrfs_type_to_imode(u8 type)
>  
>  	return imode_by_btrfs_type[(type)];
>  }
> +
> +static inline bool u64_add_overflow(u64 a, u64 b)

Rename this to check_add_overflow and use the generic version from the
kernel :

#define check_add_overflow(a, b, d) ({          \

        typeof(a) __a = (a);                    \

        typeof(b) __b = (b);                    \

        typeof(d) __d = (d);                    \

        (void) (&__a == &__b);                  \

        (void) (&__a == __d);                   \

        __builtin_add_overflow(__a, __b, __d);  \

})

> +{
> +	if (a > (u64)-1 - b)
> +		return true;
> +	return false;
> +}
>  #endif
> diff --git a/check/mode-lowmem.c b/check/mode-lowmem.c
> index 630fabf66919..d257a44f3086 100644
> --- a/check/mode-lowmem.c
> +++ b/check/mode-lowmem.c
> @@ -2085,6 +2085,13 @@ static int check_file_extent(struct btrfs_root *root, struct btrfs_path *path,
>  		err |= INVALID_GENERATION;
>  	}
>  
> +	/* Extent end shouldn't overflow */
> +	if (u64_add_overflow(fkey.offset, extent_num_bytes)) {
> +		error(
> +	"file extent end over flow, file offset %llu extent num bytes %llu",
> +			fkey.offset, extent_num_bytes);
> +		err |= FILE_EXTENT_ERROR;
> +	}
>  	/*
>  	 * Check EXTENT_DATA csum
>  	 *
> diff --git a/check/mode-original.h b/check/mode-original.h
> index b075a95c9757..07d741f4a1b5 100644
> --- a/check/mode-original.h
> +++ b/check/mode-original.h
> @@ -186,6 +186,7 @@ struct unaligned_extent_rec_t {
>  #define I_ERR_MISMATCH_DIR_HASH		(1 << 18)
>  #define I_ERR_INVALID_IMODE		(1 << 19)
>  #define I_ERR_INVALID_GEN		(1 << 20)
> +#define I_ERR_FILE_EXTENT_OVERFLOW	(1 << 21)
>  
>  struct inode_record {
>  	struct list_head backrefs;
> 
