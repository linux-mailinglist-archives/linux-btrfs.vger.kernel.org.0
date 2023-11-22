Return-Path: <linux-btrfs+bounces-285-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16BEC7F4897
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Nov 2023 15:14:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4750C1C20BC8
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Nov 2023 14:14:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F19254C3CC;
	Wed, 22 Nov 2023 14:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="px+PMdCp"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78066101
	for <linux-btrfs@vger.kernel.org>; Wed, 22 Nov 2023 06:14:05 -0800 (PST)
Received: by mail-yb1-xb35.google.com with SMTP id 3f1490d57ef6-daf7ed42ea6so6689128276.0
        for <linux-btrfs@vger.kernel.org>; Wed, 22 Nov 2023 06:14:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1700662444; x=1701267244; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=s+jG/DXtywm5zS2rvVRrW+nESwNCAFBDKTE05oZq7NU=;
        b=px+PMdCp6S9RQh9F2MxvnoANuvmmZ2rYBcpkqZGyO0+CrxlilQNqUmiWdiMsqi0nfE
         j0v1wy/7+THNVeKkONRTMFIMoX47nQt1MmDf9E08TwevNHrv0+QUm9QUkPyo7EFapyYI
         tHS3jlh7L5h+YnGBGeB7ZIACSsVsdYs5QqOS95q+e1CbhssA9XHW4c5eDAJ6zhYjFVB7
         Top9+ygFG8+FWKVDebM/tN89c/CmULMmmrdJz/WdL2I+cnd8CGy1GVcx4IDK521pWOI3
         PncZLcJlREutEHBgilQJ71Kln+3HNpZgw/FIhXg8o6WhHmQX7wn7oHlmn9fnKzOZHb7I
         FR0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700662444; x=1701267244;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s+jG/DXtywm5zS2rvVRrW+nESwNCAFBDKTE05oZq7NU=;
        b=b+ZfTgPQkC8wMP3tpnATxO7Fr1Z4K11V6+65F5kUVvMP0C0kc/Fal2TokhZdzUyRnR
         OAQE9T2hHs+CHeH3DPlqS4InppCfIxiVolv80SO5AulK2cvVlDxYPTRu4FvF+ldZNLif
         fOY0paHwhyswv5VB5W2QGFuOSk+IclByBbyUE3zdopGMDfglTYqcF3J++PdAAGBvOktz
         rDyRsHVLjbUIBm11q5VWW2V3iBee01UkaIcY69PVm5kg6TrebdJ6L1QSvPZZMn8xp8fn
         TvuNTkvJoVdcCZlehDH28O4DiaeULn4wNCjoezoD1iC/kaJkCqwbp5rT8DJIJKMV79TM
         l1zg==
X-Gm-Message-State: AOJu0YzR296cVjZ5z6K9Z3SOv2zQIleU3p4BsfHT5AlXuYzdx89d2vbT
	TYZX9W4fYSPoQauxyooz7jR7aGN7+sOVsdxYt2hJczse
X-Google-Smtp-Source: AGHT+IHJ7rOj0D8xc6E9lSk/UVIjFZPR9GXHjJWx5BTEg2jFXOinHALn7uGbzaoEyKCA+K8Kl94Vyg==
X-Received: by 2002:a25:ae92:0:b0:db0:2945:4de with SMTP id b18-20020a25ae92000000b00db0294504demr2300669ybj.7.1700662444401;
        Wed, 22 Nov 2023 06:14:04 -0800 (PST)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id u6-20020a25ab06000000b00da076458395sm1393048ybi.43.2023.11.22.06.14.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 06:14:04 -0800 (PST)
Date: Wed, 22 Nov 2023 09:14:03 -0500
From: Josef Bacik <josef@toxicpanda.com>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: refactor alloc_extent_buffer() to
 allocate-then-attach method
Message-ID: <20231122141403.GD1733890@perftesting>
References: <ffeb6b667a9ff0cf161f7dcd82899114782c0834.1700609426.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ffeb6b667a9ff0cf161f7dcd82899114782c0834.1700609426.git.wqu@suse.com>

On Wed, Nov 22, 2023 at 10:05:04AM +1030, Qu Wenruo wrote:
> Currently alloc_extent_buffer() utilizes find_or_create_page() to
> allocate one page a time for an extent buffer.
> 
> This method has the following disadvantages:
> 
> - find_or_create_page() is the legacy way of allocating new pages
>   With the new folio infrastructure, find_or_create_page() is just
>   redirected to filemap_get_folio().
> 
> - Lacks the way to support higher order (order >= 1) folios
>   As we can not yet let filemap to give us a higher order folio (yet).
> 
> This patch would change the workflow by the following way:
> 
> 		Old		   |		new
> -----------------------------------+-------------------------------------
>                                    | ret = btrfs_alloc_page_array();
> for (i = 0; i < num_pages; i++) {  | for (i = 0; i < num_pages; i++) {
>     p = find_or_create_page();     |     ret = filemap_add_folio();
>     /* Attach page private */      |     /* Reuse page cache if needed */
>     /* Reused eb if needed */      |
> 				   |     /* Attach page private and
> 				   |        reuse eb if needed */
> 				   | }
> 
> By this we split the page allocation and private attaching into two
> parts, allowing future updates to each part more easily, and migrate to
> folio interfaces (especially for possible higher order folios).
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/extent_io.c | 173 +++++++++++++++++++++++++++++++------------
>  1 file changed, 126 insertions(+), 47 deletions(-)
> 
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index 99cc16aed9d7..0ea65f248c15 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -3084,6 +3084,14 @@ static bool page_range_has_eb(struct btrfs_fs_info *fs_info, struct page *page)
>  static void detach_extent_buffer_page(struct extent_buffer *eb, struct page *page)
>  {
>  	struct btrfs_fs_info *fs_info = eb->fs_info;
> +	/*
> +	 * We can no longer using page->mapping reliably, as some extent buffer
> +	 * may not have any page mapped to btree_inode yet.
> +	 * Furthermore we have to handle dummy ebs during selftests, where
> +	 * btree_inode is not yet initialized.
> +	 */
> +	struct address_space *mapping = fs_info->btree_inode ?
> +					fs_info->btree_inode->i_mapping : NULL;

I don't understand this, this should only happen if we managed to get
PagePrivate set on the page, and in that case page->mapping is definitely
reliable.  We shouldn't be getting in here with a page that hasn't actually been
attached to the extent buffer, and if we are that needs to be fixed, we don't
need to be dealing with that case in this way.  Thanks,

Josef

