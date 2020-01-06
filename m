Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9076A131574
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Jan 2020 16:53:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726504AbgAFPxl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 6 Jan 2020 10:53:41 -0500
Received: from mx2.suse.de ([195.135.220.15]:39202 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726463AbgAFPxl (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 6 Jan 2020 10:53:41 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 42DB1AD0F;
        Mon,  6 Jan 2020 15:53:39 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 593D3DA78B; Mon,  6 Jan 2020 16:53:29 +0100 (CET)
Date:   Mon, 6 Jan 2020 16:53:28 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Cengiz Can <cengiz@kernel.wtf>
Cc:     linux-btrfs@vger.kernel.org, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Subject: Re: [PATCH] fs: btrfs: prevent unintentional int overflow
Message-ID: <20200106155328.GK3929@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Cengiz Can <cengiz@kernel.wtf>,
        linux-btrfs@vger.kernel.org, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>
References: <20200103184739.26903-1-cengiz@kernel.wtf>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200103184739.26903-1-cengiz@kernel.wtf>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jan 03, 2020 at 01:47:40PM -0500, Cengiz Can wrote:
> Coverity scan for 5.5.0-rc4 found a possible integer overflow in
> tree-checker.c line 364.
> 
> `prev_csum_end = (prev_item_size / csumsize) * sectorsize;`
> 
> Quoting from scan results:
> 
> ```
> CID 1456959 Unintentional integer overflow
> 
> Unintentional integer overflow (OVERFLOW_BEFORE_WIDEN) overflow_before_widen:
> Potentially overflowing expression `prev_item_size / csumsize * sectorsize`
> with type unsigned int (32 bits, unsigned) is evaluated using 32-bit
> arithmetic, and then used in a context that expects an expression of type u64.
> (64 bits, unsigned).
> ```
> 
> Added a cast to `u64` on the left hand side of the expression.
> 
> Compiles fine on x86_64_defconfig with all btrfs config flags enabled.
> 
> Signed-off-by: Cengiz Can <cengiz@kernel.wtf>
> ---
>  fs/btrfs/tree-checker.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/tree-checker.c b/fs/btrfs/tree-checker.c
> index 97f3520b8d98..9f58f07be779 100644
> --- a/fs/btrfs/tree-checker.c
> +++ b/fs/btrfs/tree-checker.c
> @@ -361,7 +361,7 @@ static int check_csum_item(struct extent_buffer *leaf, struct btrfs_key *key,
>  		u32 prev_item_size;
>  
>  		prev_item_size = btrfs_item_size_nr(leaf, slot - 1);
> -		prev_csum_end = (prev_item_size / csumsize) * sectorsize;
> +		prev_csum_end = (u64) (prev_item_size / csumsize) * sectorsize;

The overflow can't happen in practice. Taking generous maximum value for
an item and sectorsize (64K) and doing the math will reach nowhere the
overflow limit for 32bit type:

64K / 4 * 64K = 1G

I'm not sure if this is worth adding the cast, or mark the coverity
issue as not important.
