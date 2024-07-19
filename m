Return-Path: <linux-btrfs+bounces-6572-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24204937431
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Jul 2024 09:09:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 88757B21435
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Jul 2024 07:08:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40F074D8A7;
	Fri, 19 Jul 2024 07:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="VyCIEa+X"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5559D1799B
	for <linux-btrfs@vger.kernel.org>; Fri, 19 Jul 2024 07:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721372932; cv=none; b=ssAco7uV1jTdjnMLlasXWNJ+qOTb0ckPwdmxMRfd8QJWs75lnkMcj5dFV5By8vEEKnGp7MxIdnPVCXDO6OroT2wWjx8Z9JYxcpcgZFMBBUTE5PfoZQ7sin4yaKV1sVg/+LEVAktOUFYT7VgypKUgmJ4EB/nZ+LKNHRubuk4KPy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721372932; c=relaxed/simple;
	bh=lgZnT8HPh+r3pV9+o8cs6rK6F1V9rYHzKy3JRiDNwd8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LrwUv6Pmat9vn3pTFG1ZNumeOig8qsmOWcl2ke5xH3tZNfQTZYD3dFXXorO4m2Ju1eXFBPApaBSzAKZxY48UISUefQ52EfDUe+8ypymUiRTEWI/Yx5rOtPP0q1PYrdTItia+yLVj6xQiMB5mqA0uOh+w/hyFgTxEPmYd7dbTpIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=VyCIEa+X; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4267300145eso10405255e9.3
        for <linux-btrfs@vger.kernel.org>; Fri, 19 Jul 2024 00:08:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1721372929; x=1721977729; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Pa/wjTBweZsxvXKDDr5n5oSubSmOv5/5DhRXO2DEPNU=;
        b=VyCIEa+Xi0Dxf3OlctM71yKi9gyE6Yn/eVrrUU3oxgdZSnQjKcyzA87sMtPc1freA8
         OP9NRg2oV/6gwV6w7IdpkJFkAYfqdPHbCYzH3cKZMvoqJqDbjf/DOnHk8SL+8WOnPPEi
         lWV/GIwPD8v0PTgGYKg5/qg1r2gb/R/2F9m+tIqugeLgPKeeKgdcqOBuLRudSjtIE09y
         CCGXrl19CIWySaQVw2vWURlrESg1lDbRVmBfidHSCGhrCYPF99M//rJLdEgqoG2hQl9h
         kcjM/A/ws0TnIeUYMInY6TalybT9hPGBWUwzV+YyPpTNinw207ITO9Zo93X3zH2ovnDM
         liDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721372929; x=1721977729;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pa/wjTBweZsxvXKDDr5n5oSubSmOv5/5DhRXO2DEPNU=;
        b=P7GuOt9ILVPw+8xbzk03B6FARGckTDyQLYnpZkn9gmZu9xEzNaps8DFN18bQR7cYTg
         Bk8SsLRqmtZCoxG8EIDxeOcM4eQDaH1/wQu6L6jIGyJr2bFSPBw/X01AAtDFAEFTFPHS
         e798KQT8NEQzoY1fl8XcM+Pq5gGbtx5CzP2YVbrrd567SZ6Re8zulZIb9mr5B98rhxFO
         7tvMuux2G5hLdcZ4VADM6+McI78H3KuQr2bThp0q0ZkUyYmB9sj4idOym13YzzYxtDC+
         xzwjkkPwDozWddQqw4RNhpNt1CJNZWodfwvNLCZ/w1WLo28g+k3Aq/dfZMQxjTGCpBtX
         L/Uw==
X-Gm-Message-State: AOJu0Yw/WvkHkjDoawbRiOgf/KAV9/xvxXu4T7yUk+xXSoM4djgt3Gvy
	4B6Mjgrxojcf7FjR+MQC5ArAopRLN1hOoNEw92rtV+ZNegxses6VtzlsZA7FTo28sE+BDX65Kxr
	Z
X-Google-Smtp-Source: AGHT+IGvxSLoeKR75DjLxNGtpDA5OEVgvrsTNQmJqGwY795ZCvSROvN+SvITKf36T5Ue/PpLYGuUOg==
X-Received: by 2002:a05:6000:1faf:b0:367:9114:4693 with SMTP id ffacd0b85a97d-36831650c1fmr6559043f8f.31.1721372928652;
        Fri, 19 Jul 2024 00:08:48 -0700 (PDT)
Received: from localhost (109-81-94-157.rct.o2.cz. [109.81.94.157])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-368787ed7b8sm767752f8f.106.2024.07.19.00.08.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jul 2024 00:08:48 -0700 (PDT)
Date: Fri, 19 Jul 2024 09:08:47 +0200
From: Michal Hocko <mhocko@suse.com>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, Vlastimil Babka <vbabka@kernel.org>
Subject: Re: [PATCH v5 1/2] btrfs: always uses root memcgroup for
 filemap_add_folio()
Message-ID: <ZpoQ_28XHCUO9_TT@tiehlicka>
References: <cover.1721363035.git.wqu@suse.com>
 <d408a1b35307101e82a6845e26af4a122c8e5a25.1721363035.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d408a1b35307101e82a6845e26af4a122c8e5a25.1721363035.git.wqu@suse.com>

On Fri 19-07-24 14:19:05, Qu Wenruo wrote:
[...]
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

I do not think this will compile with CONFIG_MEMCG=n

>  	if (!ret)
>  		goto finish;
>  
> -- 
> 2.45.2

-- 
Michal Hocko
SUSE Labs

