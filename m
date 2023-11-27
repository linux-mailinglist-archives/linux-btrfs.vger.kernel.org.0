Return-Path: <linux-btrfs+bounces-397-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 550C17FA6A9
	for <lists+linux-btrfs@lfdr.de>; Mon, 27 Nov 2023 17:40:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1064D2818CB
	for <lists+linux-btrfs@lfdr.de>; Mon, 27 Nov 2023 16:40:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9E7036B0D;
	Mon, 27 Nov 2023 16:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="abnoc1RP"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86317101
	for <linux-btrfs@vger.kernel.org>; Mon, 27 Nov 2023 08:40:14 -0800 (PST)
Received: by mail-yb1-xb36.google.com with SMTP id 3f1490d57ef6-db4422fff15so3507938276.1
        for <linux-btrfs@vger.kernel.org>; Mon, 27 Nov 2023 08:40:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1701103213; x=1701708013; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kLdBwx2WSe0ICpV7nDipSMHgDr905koz80/5ezYqhhk=;
        b=abnoc1RPAlF7eEgieO0soyK6qGBay8AHCe/CRpE9XAlKhyeEdUsGaoshxxvNbM/Cyl
         BUxfWWAkTkQXNVQBkHXaBO8q9f3/4sdrUPIM5yNoio+FRLTYqJzIMulAIjE5cS1G1KKc
         091YMvprp6lIvtIv+uWLCQCyv9ZrxOwgHIOST5PtxtNZ9STIW17T7BlWDUs50N2MmL38
         ENwmNIxFOJ0ajFVKRB79uACCq4DTx2UVmO1dlZhQNR08C7ZA6NpNLDolsJgNPdFrO3LM
         pqWPpKov+YAas3b/+dfnqX95rlFysEP40S21IqVKieN6XYN2hOGKRp/jCqNtSzNZFgeE
         Z0iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701103213; x=1701708013;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kLdBwx2WSe0ICpV7nDipSMHgDr905koz80/5ezYqhhk=;
        b=rC+dVFb2JovoYRem5z+wfvNrbvHh9FrHwx98kLh5B9JJ6Z0zGptKEwQRkEEnZDE68M
         wN7/KwIv3WL3u9FFU4jlxHqw6S99zO7kvhzntj/PMCTFuf33aZ4ER+g4oL/RS+oxkxPV
         qB9dIEM3ygwAsDWdxVaLeT+BSbMRLvCJ5sYYFCWNTY4Z8AaQduaIHXIBZDdmFWcQne5C
         luiHhVUcTn4U3Elvf2FnSK4HbugI+zKA9ikz0YjDtklzxk840rBT8/i0kL6fNvVytFNg
         4BIrSx/4yDMzeTnIOe9pouE7wSoK4wcXl/mGd4ugwTmHnlvUbo5ladSnqa1yItNiqGUl
         0QSw==
X-Gm-Message-State: AOJu0Yx3dzziqyAKvmgzAzeqU1Y4tn8MhHL3B2R5dHp5msAibiXhr32z
	NDHmWHw+eKzY2PvioYxPyxM/zCz4Xr0Cx52jWI0W5qU3
X-Google-Smtp-Source: AGHT+IFrbrwT1X9lnzw5Ozz+uG29668lotofZ9RN8kgpXpBnc/5hPqFRwJor0ULYI68Ymqott4ORQQ==
X-Received: by 2002:a25:c741:0:b0:d9a:f7dc:d8c3 with SMTP id w62-20020a25c741000000b00d9af7dcd8c3mr11839714ybe.15.1701103213645;
        Mon, 27 Nov 2023 08:40:13 -0800 (PST)
Received: from localhost (076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id y10-20020a25320a000000b00d9ca7c2c8e2sm3156004yby.11.2023.11.27.08.40.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 08:40:13 -0800 (PST)
Date: Mon, 27 Nov 2023 11:40:12 -0500
From: Josef Bacik <josef@toxicpanda.com>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v3] btrfs: refactor alloc_extent_buffer() to
 allocate-then-attach method
Message-ID: <20231127164012.GG2366036@perftesting>
References: <d07c880500b59aa457fb267491664aca0e6b4b32.1700811840.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d07c880500b59aa457fb267491664aca0e6b4b32.1700811840.git.wqu@suse.com>

On Fri, Nov 24, 2023 at 06:14:16PM +1030, Qu Wenruo wrote:
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

Sorry I just noticed the updated version of this, I sent my comments in reply to
an older version but they still hold true for this version.  Thanks,

Josef

