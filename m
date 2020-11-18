Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E0732B81E6
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Nov 2020 17:31:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727745AbgKRQ2F (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 18 Nov 2020 11:28:05 -0500
Received: from twin.jikos.cz ([91.219.245.39]:35220 "EHLO twin.jikos.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727154AbgKRQ2F (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 18 Nov 2020 11:28:05 -0500
Received: from twin.jikos.cz (dave@localhost [127.0.0.1])
        by twin.jikos.cz (8.13.6/8.13.6) with ESMTP id 0AIGRsDC019903
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Wed, 18 Nov 2020 17:27:55 +0100
Received: (from dave@localhost)
        by twin.jikos.cz (8.13.6/8.13.6/Submit) id 0AIGRs8S019902;
        Wed, 18 Nov 2020 17:27:54 +0100
Date:   Wed, 18 Nov 2020 17:27:54 +0100
From:   David Sterba <dave@jikos.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 18/24] btrfs: file-item: refactor
 btrfs_lookup_bio_sums() to handle out-of-order bvecs
Message-ID: <20201118162754.GB17322@twin.jikos.cz>
Reply-To: dave@jikos.cz
Mail-Followup-To: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20201113125149.140836-1-wqu@suse.com>
 <20201113125149.140836-19-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201113125149.140836-19-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Nov 13, 2020 at 08:51:43PM +0800, Qu Wenruo wrote:
> @@ -325,81 +428,53 @@ blk_status_t btrfs_lookup_bio_sums(struct inode *inode, struct bio *bio,
>  		path->skip_locking = 1;
>  	}
>  
> -	disk_bytenr = (u64)bio->bi_iter.bi_sector << 9;
> +	for (cur_disk_bytenr = orig_disk_bytenr;
> +	     cur_disk_bytenr < orig_disk_bytenr + orig_len;
> +	     cur_disk_bytenr += (count * sectorsize)) {
> +		u64 search_len = orig_disk_bytenr + orig_len - cur_disk_bytenr;
> +		int sector_offset;
> +		u8 *csum_dst;
>  
> -	bio_for_each_segment(bvec, bio, iter) {
> -		page_bytes_left = bvec.bv_len;
> -		if (count)
> -			goto next;
> +		sector_offset = (cur_disk_bytenr - orig_disk_bytenr) >>
> +				 fs_info->sectorsize_bits;

I replied to the mismatching types already but because you've been
sending out the patchsets too often this got lost, I really don't want
keep seeing the same things again. You left some int type mess in the
new subpage patchset as well.
