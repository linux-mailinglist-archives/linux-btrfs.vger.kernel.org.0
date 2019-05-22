Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 389F825F99
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 May 2019 10:33:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728501AbfEVIdn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 22 May 2019 04:33:43 -0400
Received: from mx2.suse.de ([195.135.220.15]:34486 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728406AbfEVIdm (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 22 May 2019 04:33:42 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id BD79DAF4C;
        Wed, 22 May 2019 08:33:40 +0000 (UTC)
Subject: Re: [PATCH v3 11/13] btrfs: directly call into crypto framework for
 checsumming
To:     Johannes Thumshirn <jthumshirn@suse.de>,
        David Sterba <dsterba@suse.com>
Cc:     Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>,
        Chris Mason <clm@fb.com>, Richard Weinberger <richard@nod.at>,
        David Gstir <david@sigma-star.at>
References: <20190522081910.7689-1-jthumshirn@suse.de>
 <20190522081910.7689-12-jthumshirn@suse.de>
From:   Nikolay Borisov <nborisov@suse.com>
Openpgp: preference=signencrypt
Autocrypt: addr=nborisov@suse.com; prefer-encrypt=mutual; keydata=
 mQINBFiKBz4BEADNHZmqwhuN6EAzXj9SpPpH/nSSP8YgfwoOqwrP+JR4pIqRK0AWWeWCSwmZ
 T7g+RbfPFlmQp+EwFWOtABXlKC54zgSf+uulGwx5JAUFVUIRBmnHOYi/lUiE0yhpnb1KCA7f
 u/W+DkwGerXqhhe9TvQoGwgCKNfzFPZoM+gZrm+kWv03QLUCr210n4cwaCPJ0Nr9Z3c582xc
 bCUVbsjt7BN0CFa2BByulrx5xD9sDAYIqfLCcZetAqsTRGxM7LD0kh5WlKzOeAXj5r8DOrU2
 GdZS33uKZI/kZJZVytSmZpswDsKhnGzRN1BANGP8sC+WD4eRXajOmNh2HL4P+meO1TlM3GLl
 EQd2shHFY0qjEo7wxKZI1RyZZ5AgJnSmehrPCyuIyVY210CbMaIKHUIsTqRgY5GaNME24w7h
 TyyVCy2qAM8fLJ4Vw5bycM/u5xfWm7gyTb9V1TkZ3o1MTrEsrcqFiRrBY94Rs0oQkZvunqia
 c+NprYSaOG1Cta14o94eMH271Kka/reEwSZkC7T+o9hZ4zi2CcLcY0DXj0qdId7vUKSJjEep
 c++s8ncFekh1MPhkOgNj8pk17OAESanmDwksmzh1j12lgA5lTFPrJeRNu6/isC2zyZhTwMWs
 k3LkcTa8ZXxh0RfWAqgx/ogKPk4ZxOXQEZetkEyTFghbRH2BIwARAQABtCNOaWtvbGF5IEJv
 cmlzb3YgPG5ib3Jpc292QHN1c2UuY29tPokCOAQTAQIAIgUCWIo48QIbAwYLCQgHAwIGFQgC
 CQoLBBYCAwECHgECF4AACgkQcb6CRuU/KFc0eg/9GLD3wTQz9iZHMFbjiqTCitD7B6dTLV1C
 ddZVlC8Hm/TophPts1bWZORAmYIihHHI1EIF19+bfIr46pvfTu0yFrJDLOADMDH+Ufzsfy2v
 HSqqWV/nOSWGXzh8bgg/ncLwrIdEwBQBN9SDS6aqsglagvwFD91UCg/TshLlRxD5BOnuzfzI
 Leyx2c6YmH7Oa1R4MX9Jo79SaKwdHt2yRN3SochVtxCyafDlZsE/efp21pMiaK1HoCOZTBp5
 VzrIP85GATh18pN7YR9CuPxxN0V6IzT7IlhS4Jgj0NXh6vi1DlmKspr+FOevu4RVXqqcNTSS
 E2rycB2v6cttH21UUdu/0FtMBKh+rv8+yD49FxMYnTi1jwVzr208vDdRU2v7Ij/TxYt/v4O8
 V+jNRKy5Fevca/1xroQBICXsNoFLr10X5IjmhAhqIH8Atpz/89ItS3+HWuE4BHB6RRLM0gy8
 T7rN6ja+KegOGikp/VTwBlszhvfLhyoyjXI44Tf3oLSFM+8+qG3B7MNBHOt60CQlMkq0fGXd
 mm4xENl/SSeHsiomdveeq7cNGpHi6i6ntZK33XJLwvyf00PD7tip/GUj0Dic/ZUsoPSTF/mG
 EpuQiUZs8X2xjK/AS/l3wa4Kz2tlcOKSKpIpna7V1+CMNkNzaCOlbv7QwprAerKYywPCoOSC
 7P25Ag0EWIoHPgEQAMiUqvRBZNvPvki34O/dcTodvLSyOmK/MMBDrzN8Cnk302XfnGlW/YAQ
 csMWISKKSpStc6tmD+2Y0z9WjyRqFr3EGfH1RXSv9Z1vmfPzU42jsdZn667UxrRcVQXUgoKg
 QYx055Q2FdUeaZSaivoIBD9WtJq/66UPXRRr4H/+Y5FaUZx+gWNGmBT6a0S/GQnHb9g3nonD
 jmDKGw+YO4P6aEMxyy3k9PstaoiyBXnzQASzdOi39BgWQuZfIQjN0aW+Dm8kOAfT5i/yk59h
 VV6v3NLHBjHVw9kHli3jwvsizIX9X2W8tb1SefaVxqvqO1132AO8V9CbE1DcVT8fzICvGi42
 FoV/k0QOGwq+LmLf0t04Q0csEl+h69ZcqeBSQcIMm/Ir+NorfCr6HjrB6lW7giBkQl6hhomn
 l1mtDP6MTdbyYzEiBFcwQD4terc7S/8ELRRybWQHQp7sxQM/Lnuhs77MgY/e6c5AVWnMKd/z
 MKm4ru7A8+8gdHeydrRQSWDaVbfy3Hup0Ia76J9FaolnjB8YLUOJPdhI2vbvNCQ2ipxw3Y3c
 KhVIpGYqwdvFIiz0Fej7wnJICIrpJs/+XLQHyqcmERn3s/iWwBpeogrx2Lf8AGezqnv9woq7
 OSoWlwXDJiUdaqPEB/HmGfqoRRN20jx+OOvuaBMPAPb+aKJyle8zABEBAAGJAh8EGAECAAkF
 AliKBz4CGwwACgkQcb6CRuU/KFdacg/+M3V3Ti9JYZEiIyVhqs+yHb6NMI1R0kkAmzsGQ1jU
 zSQUz9AVMR6T7v2fIETTT/f5Oout0+Hi9cY8uLpk8CWno9V9eR/B7Ifs2pAA8lh2nW43FFwp
 IDiSuDbH6oTLmiGCB206IvSuaQCp1fed8U6yuqGFcnf0ZpJm/sILG2ECdFK9RYnMIaeqlNQm
 iZicBY2lmlYFBEaMXHoy+K7nbOuizPWdUKoKHq+tmZ3iA+qL5s6Qlm4trH28/fPpFuOmgP8P
 K+7LpYLNSl1oQUr+WlqilPAuLcCo5Vdl7M7VFLMq4xxY/dY99aZx0ZJQYFx0w/6UkbDdFLzN
 upT7NIN68lZRucImffiWyN7CjH23X3Tni8bS9ubo7OON68NbPz1YIaYaHmnVQCjDyDXkQoKC
 R82Vf9mf5slj0Vlpf+/Wpsv/TH8X32ajva37oEQTkWNMsDxyw3aPSps6MaMafcN7k60y2Wk/
 TCiLsRHFfMHFY6/lq/c0ZdOsGjgpIK0G0z6et9YU6MaPuKwNY4kBdjPNBwHreucrQVUdqRRm
 RcxmGC6ohvpqVGfhT48ZPZKZEWM+tZky0mO7bhZYxMXyVjBn4EoNTsXy1et9Y1dU3HVJ8fod
 5UqrNrzIQFbdeM0/JqSLrtlTcXKJ7cYFa9ZM2AP7UIN9n1UWxq+OPY9YMOewVfYtL8M=
Message-ID: <8452a97a-685d-7cb8-7145-3ad37e8aa385@suse.com>
Date:   Wed, 22 May 2019 11:33:39 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190522081910.7689-12-jthumshirn@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 22.05.19 г. 11:19 ч., Johannes Thumshirn wrote:
> Currently btrfs_csum_data() relied on the crc32c() wrapper around the crypto
> framework for calculating the CRCs.
> 
> As we have our own crypto_shash structure in the fs_info now, we can
> directly call into the crypto framework without going trough the wrapper.
> 
> This way we can even remove the btrfs_csum_data() and btrfs_csum_final()
> wrappers.
> 
> Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
> 
> ---
> Changes to v2:
> - Also select CRYPTO in Kconfig
> - Add pre dependency on crc32c
> Changes to v1:
> - merge with 'btrfs: pass in an fs_info to btrfs_csum_{data,final}()'
> - Remove btrfs_csum_data() and btrfs_csum_final() alltogether
> - don't use LIBCRC32C but CRYPTO_CRC32C in KConfig
> ---
>  fs/btrfs/Kconfig           |  3 ++-
>  fs/btrfs/check-integrity.c | 12 +++++++----
>  fs/btrfs/compression.c     | 19 +++++++++++------
>  fs/btrfs/disk-io.c         | 51 +++++++++++++++++++++++++---------------------
>  fs/btrfs/disk-io.h         |  2 --
>  fs/btrfs/file-item.c       | 18 ++++++++--------
>  fs/btrfs/inode.c           | 24 ++++++++++++++--------
>  fs/btrfs/scrub.c           | 37 +++++++++++++++++++++++++--------
>  fs/btrfs/super.c           |  1 +
>  9 files changed, 106 insertions(+), 61 deletions(-)
> 

<snip>

> @@ -1799,16 +1801,22 @@ static int scrub_checksum_data(struct scrub_block *sblock)
>  	if (!sblock->pagev[0]->have_csum)
>  		return 0;
>  
> +	shash->tfm = fs_info->csum_shash;
> +	shash->flags = 0;
> +
> +	crypto_shash_init(shash);
> +
>  	on_disk_csum = sblock->pagev[0]->csum;
>  	page = sblock->pagev[0]->page;
>  	buffer = kmap_atomic(page);
>  
> +	memset(csum, 0xff, btrfs_super_csum_size(sctx->fs_info->super_copy));

Is this required? You don't do it in other place like
scrub_checksum_tree_block/scrub_checksum_super/__readpage_endio_check.
If it's not strictly require just drop it.

>  	len = sctx->fs_info->sectorsize;
>  	index = 0;
>  	for (;;) {
>  		u64 l = min_t(u64, len, PAGE_SIZE);
>  
> -		crc = btrfs_csum_data(buffer, crc, l);
> +		crypto_shash_update(shash, buffer, l);
>  		kunmap_atomic(buffer);
>  		len -= l;
>  		if (len == 0)
> @@ -1820,7 +1828,7 @@ static int scrub_checksum_data(struct scrub_block *sblock)
>  		buffer = kmap_atomic(page);
>  	}
>  
> -	btrfs_csum_final(crc, csum);
> +	crypto_shash_final(shash, csum);
>  	if (memcmp(csum, on_disk_csum, sctx->csum_size))
>  		sblock->checksum_error = 1;
>  
> @@ -1832,16 +1840,21 @@ static int scrub_checksum_tree_block(struct scrub_block *sblock)
>  	struct scrub_ctx *sctx = sblock->sctx;
>  	struct btrfs_header *h;
>  	struct btrfs_fs_info *fs_info = sctx->fs_info;
> +	SHASH_DESC_ON_STACK(shash, fs_info->csum_shash);
>  	u8 calculated_csum[BTRFS_CSUM_SIZE];
>  	u8 on_disk_csum[BTRFS_CSUM_SIZE];
>  	struct page *page;
>  	void *mapped_buffer;
>  	u64 mapped_size;
>  	void *p;
> -	u32 crc = ~(u32)0;
>  	u64 len;
>  	int index;
>  
> +	shash->tfm = fs_info->csum_shash;
> +	shash->flags = 0;
> +
> +	crypto_shash_init(shash);
> +
>  	BUG_ON(sblock->page_count < 1);
>  	page = sblock->pagev[0]->page;
>  	mapped_buffer = kmap_atomic(page);
> @@ -1875,7 +1888,7 @@ static int scrub_checksum_tree_block(struct scrub_block *sblock)
>  	for (;;) {
>  		u64 l = min_t(u64, len, mapped_size);
>  
> -		crc = btrfs_csum_data(p, crc, l);
> +		crypto_shash_update(shash, p, l);
>  		kunmap_atomic(mapped_buffer);
>  		len -= l;
>  		if (len == 0)
> @@ -1889,7 +1902,7 @@ static int scrub_checksum_tree_block(struct scrub_block *sblock)
>  		p = mapped_buffer;
>  	}
>  
> -	btrfs_csum_final(crc, calculated_csum);
> +	crypto_shash_final(shash, calculated_csum);
>  	if (memcmp(calculated_csum, on_disk_csum, sctx->csum_size))
>  		sblock->checksum_error = 1;
>  
> @@ -1900,18 +1913,24 @@ static int scrub_checksum_super(struct scrub_block *sblock)
>  {
>  	struct btrfs_super_block *s;
>  	struct scrub_ctx *sctx = sblock->sctx;
> +	struct btrfs_fs_info *fs_info = sctx->fs_info;
> +	SHASH_DESC_ON_STACK(shash, fs_info->csum_shash);
>  	u8 calculated_csum[BTRFS_CSUM_SIZE];
>  	u8 on_disk_csum[BTRFS_CSUM_SIZE];
>  	struct page *page;
>  	void *mapped_buffer;
>  	u64 mapped_size;
>  	void *p;
> -	u32 crc = ~(u32)0;
>  	int fail_gen = 0;
>  	int fail_cor = 0;
>  	u64 len;
>  	int index;
>  
> +	shash->tfm = fs_info->csum_shash;
> +	shash->flags = 0;
> +
> +	crypto_shash_init(shash);
> +
>  	BUG_ON(sblock->page_count < 1);
>  	page = sblock->pagev[0]->page;
>  	mapped_buffer = kmap_atomic(page);
> @@ -1934,7 +1953,7 @@ static int scrub_checksum_super(struct scrub_block *sblock)
>  	for (;;) {
>  		u64 l = min_t(u64, len, mapped_size);
>  
> -		crc = btrfs_csum_data(p, crc, l);
> +		crypto_shash_update(shash, p, l);
>  		kunmap_atomic(mapped_buffer);
>  		len -= l;
>  		if (len == 0)
> @@ -1948,7 +1967,7 @@ static int scrub_checksum_super(struct scrub_block *sblock)
>  		p = mapped_buffer;
>  	}
>  
> -	btrfs_csum_final(crc, calculated_csum);
> +	crypto_shash_final(shash, calculated_csum);
>  	if (memcmp(calculated_csum, on_disk_csum, sctx->csum_size))
>  		++fail_cor;
>  
> diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
> index 2c66d9ea6a3b..f40516ca5963 100644
> --- a/fs/btrfs/super.c
> +++ b/fs/btrfs/super.c
> @@ -2465,3 +2465,4 @@ late_initcall(init_btrfs_fs);
>  module_exit(exit_btrfs_fs)
>  
>  MODULE_LICENSE("GPL");
> +MODULE_SOFTDEP("pre: crc32c");
> 
