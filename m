Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBA542AC38C
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Nov 2020 19:18:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729849AbgKISSv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 9 Nov 2020 13:18:51 -0500
Received: from mx2.suse.de ([195.135.220.15]:59560 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729831AbgKISSu (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 9 Nov 2020 13:18:50 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id B46BDAD2F;
        Mon,  9 Nov 2020 18:18:48 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id CE7F3DA7D7; Mon,  9 Nov 2020 19:17:07 +0100 (CET)
Date:   Mon, 9 Nov 2020 19:17:07 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 29/32] btrfs: scrub: introduce scrub_page::page_len for
 subpage support
Message-ID: <20201109181707.GA6756@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20201103133108.148112-1-wqu@suse.com>
 <20201103133108.148112-30-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201103133108.148112-30-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Nov 03, 2020 at 09:31:05PM +0800, Qu Wenruo wrote:
> --- a/fs/btrfs/scrub.c
> +++ b/fs/btrfs/scrub.c
> @@ -72,9 +72,15 @@ struct scrub_page {
>  	u64			physical_for_dev_replace;
>  	atomic_t		refs;
>  	struct {
> -		unsigned int	mirror_num:8;
> -		unsigned int	have_csum:1;
> -		unsigned int	io_error:1;
> +		/*
> +		 * For subpage case, where only part of the page is utilized
> +		 * Note that 16 bits can only go 65535, not 65536, thus we have
> +		 * to use 17 bits here.
> +		 */
> +		u32	page_len:17;
> +		u32	mirror_num:8;
> +		u32	have_csum:1;
> +		u32	io_error:1;
>  	};

The embedded struct is some relic so this can be cleaned up further.
Mirror_num can become u8. The page length size is a bit awkward, 17 is
the lowest number to contain the size up to 64k but there's still some
space left so it can go up to 22 without increasing the structure size.

Source:

struct scrub_page {
        struct scrub_block      *sblock;
        struct page             *page;
        struct btrfs_device     *dev;
        struct list_head        list;
        u64                     flags;  /* extent flags */
        u64                     generation;
        u64                     logical;
        u64                     physical;
        u64                     physical_for_dev_replace;
        atomic_t                refs;
        u8                      mirror_num;
        /*
         * For subpage case, where only part of the page is utilized Note that
         * 16 bits can only go 65535, not 65536, thus we have to use 17 bits
         * here.
         */
        u32     page_len:20;
        u32     have_csum:1;
        u32     io_error:1;
        u8                      csum[BTRFS_CSUM_SIZE];

        struct scrub_recover    *recover;
};

pahole:

struct scrub_page {
        struct scrub_block *       sblock;               /*     0     8 */
        struct page *              page;                 /*     8     8 */
        struct btrfs_device *      dev;                  /*    16     8 */
        struct list_head           list;                 /*    24    16 */
        u64                        flags;                /*    40     8 */
        u64                        generation;           /*    48     8 */
        u64                        logical;              /*    56     8 */
        /* --- cacheline 1 boundary (64 bytes) --- */
        u64                        physical;             /*    64     8 */
        u64                        physical_for_dev_replace; /*    72     8 */
        atomic_t                   refs;                 /*    80     4 */
        u8                         mirror_num;           /*    84     1 */

        /* Bitfield combined with previous fields */

        u32                        page_len:20;          /*    84: 8  4 */
        u32                        have_csum:1;          /*    84:28  4 */
        u32                        io_error:1;           /*    84:29  4 */

        /* XXX 2 bits hole, try to pack */

        u8                         csum[32];             /*    88    32 */
        struct scrub_recover *     recover;              /*   120     8 */

        /* size: 128, cachelines: 2, members: 16 */
        /* sum members: 125 */
        /* sum bitfield members: 22 bits, bit holes: 1, sum bit holes: 2 bits */
};
