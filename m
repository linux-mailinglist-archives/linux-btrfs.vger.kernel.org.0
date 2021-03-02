Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 386C332B286
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 Mar 2021 04:48:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243440AbhCCB6c (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 2 Mar 2021 20:58:32 -0500
Received: from mx2.suse.de ([195.135.220.15]:57980 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1448306AbhCBOTj (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 2 Mar 2021 09:19:39 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 722C6B12F;
        Tue,  2 Mar 2021 14:18:56 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 6A952DA8BB; Tue,  2 Mar 2021 15:17:01 +0100 (CET)
Date:   Tue, 2 Mar 2021 15:17:01 +0100
From:   David Sterba <dsterba@suse.cz>
To:     =?utf-8?B?RMSBdmlzIE1vc8SBbnM=?= <davispuh@gmail.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs-progs: Fix checksum output for "checksum verify
 failed"
Message-ID: <20210302141701.GI7604@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        =?utf-8?B?RMSBdmlzIE1vc8SBbnM=?= <davispuh@gmail.com>,
        linux-btrfs@vger.kernel.org
References: <20210227200702.11977-1-davispuh@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210227200702.11977-1-davispuh@gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Feb 27, 2021 at 10:07:02PM +0200, Dāvis Mosāns wrote:
> Currently only single checksum byte is outputted.
> This fixes it so that full checksum is outputted.

Thanks, that really needs fixing.

> Signed-off-by: Dāvis Mosāns <davispuh@gmail.com>
> ---
>  kernel-shared/disk-io.c | 47 ++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 42 insertions(+), 5 deletions(-)
> 
> diff --git a/kernel-shared/disk-io.c b/kernel-shared/disk-io.c
> index 6f584986..8773eed7 100644
> --- a/kernel-shared/disk-io.c
> +++ b/kernel-shared/disk-io.c
> @@ -160,10 +160,45 @@ int btrfs_csum_data(u16 csum_type, const u8 *data, u8 *out, size_t len)
>  	return -1;
>  }
>  
> +int btrfs_format_csum(u16 csum_type, const char *data, char *output)
> +{
> +	int i;
> +	int csum_len = 0;
> +	int position = 0;
> +	int direction = 1;
> +	switch (csum_type) {
> +		case BTRFS_CSUM_TYPE_CRC32:
> +			csum_len = 4;

This duplicates the per-csum size, you could use btrfs_csum_type_size

> +			position = csum_len - 1;
> +			direction = -1;
> +			break;
> +		case BTRFS_CSUM_TYPE_XXHASH:
> +			csum_len = 8;
> +			position = csum_len - 1;
> +			direction = -1;

So the direction says if it's big endian or little endian, right, so for
xxhash it's bigendian but the crc32c above it's little.

In kernel the format is 0x%*phN, which translates to 'hexadecimal with
variable length', so all the work is hidden inside printk. But still
there are no changes in the 'direction'.

I haven't actually checked if the printed format matches what kernel
does but would think that there should be no direction adjustment
needed.

> +			break;
> +		case BTRFS_CSUM_TYPE_SHA256:
> +		case BTRFS_CSUM_TYPE_BLAKE2:
> +			csum_len = 32;
> +			break;
> +		default:
> +			fprintf(stderr, "ERROR: unknown csum type: %d\n", csum_type);
> +			ASSERT(0);
> +	}
> +
> +	for (i = 0; i < csum_len; i++) {
> +		sprintf(output + i*2, "%02X", data[position + i*direction] & 0xFF);
> +	}
> +
> +	return csum_len;
> +}
> +
>  static int __csum_tree_block_size(struct extent_buffer *buf, u16 csum_size,
>  				  int verify, int silent, u16 csum_type)
>  {
>  	u8 result[BTRFS_CSUM_SIZE];
> +	char found[BTRFS_CSUM_SIZE * 2 + 1]; // 2 hex chars for each byte + null
> +	char expected[BTRFS_CSUM_SIZE * 2 + 1];
>  	u32 len;
>  
>  	len = buf->len - BTRFS_CSUM_SIZE;
> @@ -172,12 +207,14 @@ static int __csum_tree_block_size(struct extent_buffer *buf, u16 csum_size,
>  
>  	if (verify) {
>  		if (memcmp_extent_buffer(buf, result, 0, csum_size)) {
> -			/* FIXME: format */
> -			if (!silent)
> -				printk("checksum verify failed on %llu found %08X wanted %08X\n",
> +			if (!silent) {
> +				btrfs_format_csum(csum_type, (char *)result, found);
> +				btrfs_format_csum(csum_type, buf->data, expected);
> +				printk("checksum verify failed on %llu found %s wanted %s\n",
>  				       (unsigned long long)buf->start,
> -				       result[0],
> -				       buf->data[0]);
> +				       found,
> +				       expected);
> +			}
>  			return 1;
>  		}
>  	} else {
> -- 
> 2.30.1
