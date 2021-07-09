Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12ACC3C2A75
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Jul 2021 22:40:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230191AbhGIUmu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 9 Jul 2021 16:42:50 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:33928 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbhGIUmt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 9 Jul 2021 16:42:49 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 457EB22032;
        Fri,  9 Jul 2021 20:40:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1625863205;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uEVg65Zvr4+aBj7yR8JKWQnk4vmniITUtD3fHIkrhPg=;
        b=Hw3QyYL/T8/HwifcX6gbtoyDuCw7OcCora6XinfXJLAtCe61CcxhD3EIPPm0KiMisQNjWl
        D5ZawKfEbYgdtKy5NY2Ge3G/Q7tlIh9b2ZvcOmpDc/4VikwGA6KancOgMSuqagRD5MNcrt
        AZ1AgQ5gaa9rqjFhQYF5SlmNheEgzy8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1625863205;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uEVg65Zvr4+aBj7yR8JKWQnk4vmniITUtD3fHIkrhPg=;
        b=j0KfB1V+QoeZaSb3dKhfpnzawvryhpxw/Aiq44p2mgc6lSzLrX6gUOfWolEZOEby0KooCg
        Zt9hhYUJ8WiWtWDw==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 3B52DA3B9E;
        Fri,  9 Jul 2021 20:40:05 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 5E947DA8E2; Fri,  9 Jul 2021 22:37:30 +0200 (CEST)
Date:   Fri, 9 Jul 2021 22:37:30 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v6 04/15] btrfs: rework lzo_decompress_bio() to make it
 subpage compatible
Message-ID: <20210709203730.GJ2610@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20210705020110.89358-1-wqu@suse.com>
 <20210705020110.89358-5-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210705020110.89358-5-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jul 05, 2021 at 10:00:59AM +0800, Qu Wenruo wrote:
>  int lzo_decompress_bio(struct list_head *ws, struct compressed_bio *cb)
>  {
>  	struct workspace *workspace = list_entry(ws, struct workspace, list);
> -	int ret = 0, ret2;
> -	char *data_in;
> -	unsigned long page_in_index = 0;
> -	size_t srclen = cb->compressed_len;
> -	unsigned long total_pages_in = DIV_ROUND_UP(srclen, PAGE_SIZE);
> -	unsigned long buf_start;
> -	unsigned long buf_offset = 0;
> -	unsigned long bytes;
> -	unsigned long working_bytes;
> -	size_t in_len;
> -	size_t out_len;
> -	const size_t max_segment_len = lzo1x_worst_compress(PAGE_SIZE);
> -	unsigned long in_offset;
> -	unsigned long in_page_bytes_left;
> -	unsigned long tot_in;
> -	unsigned long tot_out;
> -	unsigned long tot_len;
> -	char *buf;
> -	bool may_late_unmap, need_unmap;
> -	struct page **pages_in = cb->compressed_pages;
> +	const struct btrfs_fs_info *fs_info = btrfs_sb(cb->inode->i_sb);
> +	const u32 sectorsize = fs_info->sectorsize;
> +	int ret;
> +	u32 len_in;		/* Compressed data length, can be unaligned */
> +	u32 cur_in = 0;         /* Offset inside the compressed data */
> +	u64 cur_out = 0;        /* Bytes decompressed so far */

This can be u32 as well
