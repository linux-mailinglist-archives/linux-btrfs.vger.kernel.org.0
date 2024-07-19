Return-Path: <linux-btrfs+bounces-6608-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BD0E7937B6B
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Jul 2024 19:02:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0E8D1C215D6
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Jul 2024 17:02:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C47CA146000;
	Fri, 19 Jul 2024 17:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="jX794WpR"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D97CD250EC
	for <linux-btrfs@vger.kernel.org>; Fri, 19 Jul 2024 17:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721408536; cv=none; b=DJrD6D+hsBbY7qiAmvIvSH9580nTM9dyF3bSSByKeAakRELYJ9/uUUUGgRXlz2xbd4qnFGvjfRCTgnl3qOXD5hkPCg9gAz6PXhXZXtvl+rm1xggorZ4OWZR303TfhxViIgNx9r25Ir9PrSYRE82P6FmtESBZLGElnYLQPOlA3dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721408536; c=relaxed/simple;
	bh=h7o6L3DAYkeVS2Vn4GxZazX5f8Lhovk5lhWJfssrk6Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k0FOS4mL7ShZL0TylYU19p/X6MP/MmLsNBtMagkpp5xcBglDElXc+oxlzRkRPLG4QZHaCdQICNq6CbHaRO27zxyZM9qHAOYdyj6DFV4ExOQ5XUo9z2UClQwPr9YMzw72PEcrXS9gWnOBfI6kD54XjJ8LhreaR7ltsrBb5YwaaTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=jX794WpR; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-79f18509e76so99793585a.1
        for <linux-btrfs@vger.kernel.org>; Fri, 19 Jul 2024 10:02:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1721408531; x=1722013331; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Cnk9NxbJkVDBO6rEbrTCNl0EkRG/DVVM+mWiYP6bZrA=;
        b=jX794WpRR0CAKSxpTdkPCWS5MM7gztwaaTVKLa55X1My1PvdCb090Rsd+Ec/cC/1CB
         zheqcqYQJDqieI0FgYJQbtEAKYnAwJT6Eu4afbJTJOUdrKMpVp92KgcfmvLEWWHK8qpk
         ZvwjV0jkxBVC7OOIbhOnXNO8PIKISlK8ST/ir1gxfuqy8/QuxwNZs89JAKhasg+uR7L2
         WC2ceK+WaFtXY6ozTROhTUrwoIygNK8HqqAAMLZyLJYpTmfpIkimhvLDAoQt5miUr8Wo
         A82QhMQt2suRkdfdh485kKPLVlUuIrAX7shYTvmiK8ivZsI4nPSzjkNDmfhMZhZ0WeAP
         DzEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721408531; x=1722013331;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cnk9NxbJkVDBO6rEbrTCNl0EkRG/DVVM+mWiYP6bZrA=;
        b=ZWLtrEpLV8m13GIbK5Y0nzrkWSPf55h0m0pIdT/3S7wIHzOcjkD+x+DvGbLGUjiSUA
         aL18okLkcr0VpEdXVVPOqvrnAnJUtqWGE+Onp+Px1dWYHaVKxiKrvE8xFHWGeEy+CotQ
         BPmZoRv6mSHRR7pm+Sxn/IbJ7weHNyufqdFHCNZcecFPM/Q4ubQriN8KwSavb4DqDApu
         RgbJI6pvgCw/sPloGa2E1aA7xccz0ojqARA/mTwXstVtn7vaQw0iaSs/3BQMiksYhB/q
         DUQMK51qBYb9IMaSs9KiUcPRgZlBa7AlA57yYqWITfG+9uu6eKy/QWPHVTWD/t/DOdcE
         7Wmw==
X-Gm-Message-State: AOJu0YwrAVf1i+EVDhPpdr3Gi2VuMEP3/URcJ3KCVtE97cmn1p4SDYN7
	LQz19R6KaYJiGYfBbiEJHp5e+KVN3ThCxxd2ck2Edkh+YmAOsdfsJ0P5+vxOosA=
X-Google-Smtp-Source: AGHT+IGJpOS3XSHRy7i/fHyIF9ZOh73D7/b4jdB8R2qZ3jDtr4nw9P7TgvwN7pA3m41bG/vJBRUWFg==
X-Received: by 2002:a05:6214:c41:b0:6b5:16b:6998 with SMTP id 6a1803df08f44-6b78e258c37mr118182136d6.42.1721408531253;
        Fri, 19 Jul 2024 10:02:11 -0700 (PDT)
Received: from localhost ([2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b7ac7e4754sm9947136d6.51.2024.07.19.10.02.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jul 2024 10:02:10 -0700 (PDT)
Date: Fri, 19 Jul 2024 13:02:06 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, mhocko@kernel.org,
	roman.gushchin@linux.dev, shakeel.butt@linux.dev,
	muchun.song@linux.dev, cgroups@vger.kernel.org, linux-mm@kvack.org,
	Michal Hocko <mhocko@suse.com>, Vlastimil Babka <vbabka@kernel.org>
Subject: Re: [PATCH v7 2/3] btrfs: always uses root memcgroup for
 filemap_add_folio()
Message-ID: <20240719170206.GA3242034@cmpxchg.org>
References: <cover.1721384771.git.wqu@suse.com>
 <6a9ba2c8e70c7b5c4316404612f281a031f847da.1721384771.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6a9ba2c8e70c7b5c4316404612f281a031f847da.1721384771.git.wqu@suse.com>

On Fri, Jul 19, 2024 at 07:58:40PM +0930, Qu Wenruo wrote:
> [BACKGROUND]
> The function filemap_add_folio() charges the memory cgroup,
> as we assume all page caches are accessible by user space progresses
> thus needs the cgroup accounting.
> 
> However btrfs is a special case, it has a very large metadata thanks to
> its support of data csum (by default it's 4 bytes per 4K data, and can
> be as large as 32 bytes per 4K data).
> This means btrfs has to go page cache for its metadata pages, to take
> advantage of both cache and reclaim ability of filemap.
> 
> This has a tiny problem, that all btrfs metadata pages have to go through
> the memcgroup charge, even all those metadata pages are not
> accessible by the user space, and doing the charging can introduce some
> latency if there is a memory limits set.
> 
> Btrfs currently uses __GFP_NOFAIL flag as a workaround for this cgroup
> charge situation so that metadata pages won't really be limited by
> memcgroup.
> 
> [ENHANCEMENT]
> Instead of relying on __GFP_NOFAIL to avoid charge failure, use root
> memory cgroup to attach metadata pages.
> 
> With root memory cgroup, we directly skip the charging part, and only
> rely on __GFP_NOFAIL for the real memory allocation part.
> 
> Suggested-by: Michal Hocko <mhocko@suse.com>
> Suggested-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/extent_io.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index aa7f8148cd0d..cfeed7673009 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -2971,6 +2971,7 @@ static int attach_eb_folio_to_filemap(struct extent_buffer *eb, int i,
>  
>  	struct btrfs_fs_info *fs_info = eb->fs_info;
>  	struct address_space *mapping = fs_info->btree_inode->i_mapping;
> +	struct mem_cgroup *old_memcg;
>  	const unsigned long index = eb->start >> PAGE_SHIFT;
>  	struct folio *existing_folio = NULL;
>  	int ret;
> @@ -2981,8 +2982,17 @@ static int attach_eb_folio_to_filemap(struct extent_buffer *eb, int i,
>  	ASSERT(eb->folios[i]);
>  
>  retry:
> +	/*
> +	 * Btree inode is a btrfs internal inode, and not exposed to any
> +	 * user.
> +	 * Furthermore we do not want any cgroup limits on this inode.
> +	 * So we always use root_mem_cgroup as our active memcg when attaching
> +	 * the folios.
> +	 */
> +	old_memcg = set_active_memcg(root_mem_cgroup);
>  	ret = filemap_add_folio(mapping, eb->folios[i], index + i,
>  				GFP_NOFS | __GFP_NOFAIL);
> +	set_active_memcg(old_memcg);

It looks correct. But it's going through all dance to set up
current->active_memcg, then have the charge path look that up,
css_get(), call try_charge() only to bail immediately, css_put(), then
update current->active_memcg again. All those branches are necessary
when we want to charge to a "real" other cgroup. But in this case, we
always know we're not charging, so it seems uncalled for.

Wouldn't it be a lot simpler (and cheaper) to have a
filemap_add_folio_nocharge()?

