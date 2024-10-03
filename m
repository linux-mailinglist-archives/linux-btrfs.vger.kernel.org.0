Return-Path: <linux-btrfs+bounces-8482-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B63C98EB0E
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Oct 2024 10:07:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DF671C209C7
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Oct 2024 08:07:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F486136328;
	Thu,  3 Oct 2024 08:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="XB0XcO3D"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F6F6811E2
	for <linux-btrfs@vger.kernel.org>; Thu,  3 Oct 2024 08:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727942859; cv=none; b=fdNr0KbAMpmTbg1dwK+zxxopjoDGO3gvEuH0PWKnLXk2At7JIghErrYO/wgJmLTdSgda9OHD+wXUxSRWRfPUMn0VCykZyoDOKi780PppVe+JMYNK6yYxnPkD1UNU6g5QmoQIQBnpt5RyJvleRwyOQRlbwJjVa4l8yuyGf9GI8oU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727942859; c=relaxed/simple;
	bh=FugMOLDQqIuZ4L/PEeWM8kk/5xXKneg6SZ/DOzcSwgw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h0+GAVaqX2p4m4KZeKmqL6WIz6FfHAFo2Xn2E1Kk++mOA1APsTy+aib74chqPlSuNuXMSpe1YMe11KA6Ba0sm7/epnxgVXT8BGlo9Zn1+ul9rOBHH/6hNvnlS2kHpvIl8bcXk9WmUWFmUzGp0KwBtIlaZ6wZs45vt3L+8b4byRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=XB0XcO3D; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a8a7596b7dfso133798366b.0
        for <linux-btrfs@vger.kernel.org>; Thu, 03 Oct 2024 01:07:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1727942855; x=1728547655; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IUXT90gNIBX5IvviqObIkp/Cv4Bsq10uYsHWhjiiAh8=;
        b=XB0XcO3D7VcjFOh9kKf9E7EQI2uC7/wTZJmqwdyhlE/BW5bS9tOgO/bjDSqVhXBskW
         w93Ve7F/WqCyijJoO/qbWaNQTiUrgqFprEUqSIUy8l78YHDi0xZA5IS+s8tgzycvB/Bx
         R/PwSvnxmvHYY1yn/K8nNWxvN/a+wRZnQMKCXnQhDXX/PqHoJ8+XMwRgBcJ4xca2VJW9
         OUNOqW4ekmbTnTlmfwetoFI0CfOoaF7zb3BKkkNbjz8oZHGLbruf3FHF65xgIJRalNVo
         RNdLuCI4XHcI0rhU5i/yC/VHoS2FGWQssdhyv5KJ/renGwdIqXa292GTF5PpQ/7dXxHd
         8ROA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727942855; x=1728547655;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IUXT90gNIBX5IvviqObIkp/Cv4Bsq10uYsHWhjiiAh8=;
        b=IxZlhCaKYRg054k3hxJZ2Lq51LWkcLypOeGQ+YJ04udcWaIjazrkhbuSO00luQBDUo
         dM9iEQEGznbRVQq1ITymmLCnNaHbeNAPnBDBWZFR1Y4fLIhCLNjxP4Egd5YhjGXH38Rc
         Z4uiQYbfn7jylo2jOBEM0GjbE/ExmAhM0GgnUszIFGm47hk6vvgBes5AdvuADTx5hMve
         /Jq7ruPAlAvfsB7NmosKD2BAUuIDKB9L6OE7com0r2J4eV5opZKqMduRZpfw4QivBHs/
         OU3M8b+8mgwmhoRaNNojHtV3MrIKH1rfCeM8FeJc/EBSEx3L+58CZbpO+7soIXHSoED9
         1PEw==
X-Forwarded-Encrypted: i=1; AJvYcCXrKYdmC1tXYDbCn303W+LTaOMsdTW7LPN6oy2f+aP2zYIjLwRBIBeyQb5Y88JWqK+uGcLUocyz51q4jw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzWLbODAoCgYnk8eZlaHdNvT6uJL/TZRuXFNfaWzw2H8ZEMgG94
	IJF4fLswScrcPIUPDTEYcF/1VK7D9Oqu3Xn3AxLZ7i0mOKpSD7aysINdfsmBBKk=
X-Google-Smtp-Source: AGHT+IH+xvuIkjlVxcoyVHYgYNBpVDt7/vBi0ADchIzadfJi4ipmZdVHHgZySHB9FKOCUfMQwLBbLA==
X-Received: by 2002:a17:907:97d1:b0:a8a:6db7:665d with SMTP id a640c23a62f3a-a990a0692admr240084566b.17.1727942854821;
        Thu, 03 Oct 2024 01:07:34 -0700 (PDT)
Received: from localhost (109-81-85-183.rct.o2.cz. [109.81.85.183])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a99103b5c90sm48663966b.115.2024.10.03.01.07.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2024 01:07:34 -0700 (PDT)
Date: Thu, 3 Oct 2024 10:07:33 +0200
From: Michal Hocko <mhocko@suse.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: Qu Wenruo <quwenruo.btrfs@gmx.com>, Qu Wenruo <wqu@suse.com>,
	linux-btrfs@vger.kernel.org, hannes@cmpxchg.org,
	roman.gushchin@linux.dev, shakeel.butt@linux.dev,
	muchun.song@linux.dev, akpm@linux-foundation.org,
	cgroups@vger.kernel.org, linux-mm@kvack.org,
	"Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Subject: Re: [PATCH] btrfs: root memcgroup for metadata filemap_add_folio()
Message-ID: <Zv5Qxfz4sSwiKqm7@tiehlicka>
References: <b5fef5372ae454a7b6da4f2f75c427aeab6a07d6.1727498749.git.wqu@suse.com>
 <Zvu-n6NFL8wo4cOA@infradead.org>
 <5d3f4dca-f7f3-4228-8645-ad92c7a1e5ac@gmx.com>
 <Zvz5KfmB8J90TLmO@infradead.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zvz5KfmB8J90TLmO@infradead.org>

On Wed 02-10-24 00:41:29, Christoph Hellwig wrote:
[...]
> What I'd propose is something like the patch below, plus proper
> documentation.  Note that this now does the uncharge on the unlocked
> folio in the error case.  From a quick look that should be fine, but
> someone who actually knows the code needs to confirm that.

yes, this is a much cleaner solution. filemap_add_folio_nocharge would
need documentation explaining when this is supposed to be used.

> diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
> index 68a5f1ff3301c6..70da62cf32f6c3 100644
> --- a/include/linux/pagemap.h
> +++ b/include/linux/pagemap.h
> @@ -1284,6 +1284,8 @@ int add_to_page_cache_lru(struct page *page, struct address_space *mapping,
>  		pgoff_t index, gfp_t gfp);
>  int filemap_add_folio(struct address_space *mapping, struct folio *folio,
>  		pgoff_t index, gfp_t gfp);
> +int filemap_add_folio_nocharge(struct address_space *mapping,
> +		struct folio *folio, pgoff_t index, gfp_t gfp);
>  void filemap_remove_folio(struct folio *folio);
>  void __filemap_remove_folio(struct folio *folio, void *shadow);
>  void replace_page_cache_folio(struct folio *old, struct folio *new);
> diff --git a/mm/filemap.c b/mm/filemap.c
> index 36d22968be9a1e..0a1ae841e8c10f 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -958,20 +958,15 @@ noinline int __filemap_add_folio(struct address_space *mapping,
>  }
>  ALLOW_ERROR_INJECTION(__filemap_add_folio, ERRNO);
>  
> -int filemap_add_folio(struct address_space *mapping, struct folio *folio,
> -				pgoff_t index, gfp_t gfp)
> +int filemap_add_folio_nocharge(struct address_space *mapping,
> +		struct folio *folio, pgoff_t index, gfp_t gfp)
>  {
>  	void *shadow = NULL;
>  	int ret;
>  
> -	ret = mem_cgroup_charge(folio, NULL, gfp);
> -	if (ret)
> -		return ret;
> -
>  	__folio_set_locked(folio);
>  	ret = __filemap_add_folio(mapping, folio, index, gfp, &shadow);
>  	if (unlikely(ret)) {
> -		mem_cgroup_uncharge(folio);
>  		__folio_clear_locked(folio);
>  	} else {
>  		/*
> @@ -989,6 +984,22 @@ int filemap_add_folio(struct address_space *mapping, struct folio *folio,
>  	}
>  	return ret;
>  }
> +EXPORT_SYMBOL_GPL(filemap_add_folio_nocharge);
> +
> +int filemap_add_folio(struct address_space *mapping, struct folio *folio,
> +		pgoff_t index, gfp_t gfp)
> +{
> +	int ret;
> +
> +	ret = mem_cgroup_charge(folio, NULL, gfp);
> +	if (ret)
> +		return ret;
> +
> +	ret = filemap_add_folio_nocharge(mapping, folio, index, gfp);
> +	if (ret)
> +		mem_cgroup_uncharge(folio);
> +	return ret;
> +}
>  EXPORT_SYMBOL_GPL(filemap_add_folio);
>  
>  #ifdef CONFIG_NUMA

-- 
Michal Hocko
SUSE Labs

