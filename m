Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBD07235A30
	for <lists+linux-btrfs@lfdr.de>; Sun,  2 Aug 2020 21:17:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726347AbgHBTQ5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 2 Aug 2020 15:16:57 -0400
Received: from mx2.suse.de ([195.135.220.15]:39640 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725925AbgHBTQ4 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 2 Aug 2020 15:16:56 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id B4FF2AF33;
        Sun,  2 Aug 2020 19:17:09 +0000 (UTC)
Subject: Re: [PATCH] btrfs: inode: Fix NULL pointer dereference if inode
 doesn't need compression
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Cc:     Luciano Chavez <chavez@us.ibm.com>
References: <20200728083926.19518-1-wqu@suse.com>
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
Message-ID: <6b8fa62c-0c42-a49b-3961-b247ef8abeb2@suse.com>
Date:   Sun, 2 Aug 2020 22:16:54 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200728083926.19518-1-wqu@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 28.07.20 г. 11:39 ч., Qu Wenruo wrote:
> [BUG]
> There is a bug report of NULL pointer dereference caused in
> compress_file_extent():
> 
>   Oops: Kernel access of bad area, sig: 11 [#1]
>   LE PAGE_SIZE=64K MMU=Hash SMP NR_CPUS=2048 NUMA pSeries
>   Workqueue: btrfs-delalloc btrfs_delalloc_helper [btrfs]
>   NIP [c008000006dd4d34] compress_file_range.constprop.41+0x75c/0x8a0 [btrfs]
>   LR [c008000006dd4d1c] compress_file_range.constprop.41+0x744/0x8a0 [btrfs]
>   Call Trace:
>   [c000000c69093b00] [c008000006dd4d1c] compress_file_range.constprop.41+0x744/0x8a0 [btrfs] (unreliable)
>   [c000000c69093bd0] [c008000006dd4ebc] async_cow_start+0x44/0xa0 [btrfs]
>   [c000000c69093c10] [c008000006e14824] normal_work_helper+0xdc/0x598 [btrfs]
>   [c000000c69093c80] [c0000000001608c0] process_one_work+0x2c0/0x5b0
>   [c000000c69093d10] [c000000000160c38] worker_thread+0x88/0x660
>   [c000000c69093db0] [c00000000016b55c] kthread+0x1ac/0x1c0
>   [c000000c69093e20] [c00000000000b660] ret_from_kernel_thread+0x5c/0x7c
>   ---[ end trace f16954aa20d822f6 ]---
> 
> [CAUSE]
> For the following execution route of compress_file_range(), it's
> possible to hit NULL pointer dereference:
> 
>  compress_file_extent()
>  |- pages = NULL;
>  |- start = async_chunk->start = 0;
>  |- end = async_chunk = 4095;
>  |- nr_pages = 1;
>  |- inode_need_compress() == false; <<< Possible, see later explanation
>  |  Now, we have nr_pages = 1, pages = NULL
>  |- cont:
>  |- 		ret = cow_file_range_inline();
>  |- 		if (ret <= 0) {
>  |-		for (i = 0; i < nr_pages; i++) {
>  |-			WARN_ON(pages[i]->mapping);	<<< Crash
> 
> To enter above call execution branch, we need the following race:
> 
>     Thread 1 (chattr)     |            Thread 2 (writeback)
> --------------------------+------------------------------
>                           | btrfs_run_delalloc_range
>                           | |- inode_need_compress = true
>                           | |- cow_file_range_async()
> btrfs_ioctl_set_flag()    |
> |- binode_flags |=        |
>    BTRFS_INODE_NOCOMPRESS |
>                           | compress_file_range()
>                           | |- inode_need_compress = false
>                           | |- nr_page = 1 while pages = NULL
>                           | |  Then hit the crash
> 
> [FIX]
> This patch will fix it by checking @pages before doing accessing it.
> This patch is only designed as a hot fix and easy to backport.
> 
> More elegant fix may make btrfs only check inode_need_compress() once to
> avoid such race, but that would be another story.

So why not do the elegant fix in the first place rather than adding
cruft like this hotfix which later has to be cleaned up when the
'proper' fix lands?

> 
> Fixes: 4d3a800ebb12 ("btrfs: merge nr_pages input and output parameter in compress_pages")
> Reported-by: Luciano Chavez <chavez@us.ibm.com>
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/inode.c | 16 +++++++++++-----
>  1 file changed, 11 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 611b3412fbfd..9988d754e465 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -653,12 +653,18 @@ static noinline int compress_file_range(struct async_chunk *async_chunk)
>  						     page_error_op |
>  						     PAGE_END_WRITEBACK);
>  
> -			for (i = 0; i < nr_pages; i++) {
> -				WARN_ON(pages[i]->mapping);
> -				put_page(pages[i]);
> +			/*
> +			 * Ensure we only free the compressed pages if we have
> +			 * them allocated, as we can still reach here with
> +			 * inode_need_compress() == false.
> +			 */
> +			if (pages) {
> +				for (i = 0; i < nr_pages; i++) {
> +					WARN_ON(pages[i]->mapping);
> +					put_page(pages[i]);
> +				}
> +				kfree(pages);
>  			}
> -			kfree(pages);
> -
>  			return 0;
>  		}
>  	}
> 
