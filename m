Return-Path: <linux-btrfs+bounces-13135-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E3CEA91CCD
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Apr 2025 14:49:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6187C3B7FC7
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Apr 2025 12:48:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25E4E17A313;
	Thu, 17 Apr 2025 12:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="J4LbPrb6"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E30FC78F5E
	for <linux-btrfs@vger.kernel.org>; Thu, 17 Apr 2025 12:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744894089; cv=none; b=VIWirasKtTNt4rXmqMeLKzR4B3Gfcebt80UmoQA+LCE6RvxN3/O9KzBmqMd3LVSNIxUyus8xhVVpdPjcEsDMSWKJWQkm23pEOZTZwEU6Er0jLj/eezGbV5s6Og0aB09pVd6PxWzkKgR6b3kZl6VuGH/boSYufvi8fSRiW4pfPas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744894089; c=relaxed/simple;
	bh=7iDg860OLcCyX3Y05HDXikBtP1iDAlfubRmUOrFAhY8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DWqD/UoCr62eUC40WBpKXlTqihC+IBHvFOc+g+wlzH61havZ0HzDSuLWq+7Y6/bPwZDzcQcZhoMFK5dOWvQwlCE0hU/ID7phy3CBTkxKJ0dN5PzJvkn6Ei9qdikD+oIbUfuhr8WOuczsg8q8GAdLpkY72hERfMY9/iB2vl//BQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=J4LbPrb6; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e6e50418da6so743919276.3
        for <linux-btrfs@vger.kernel.org>; Thu, 17 Apr 2025 05:48:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1744894087; x=1745498887; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PQDfXWTBhh25iJCD88OMBYfvQOO/9ewWXf4UbyOuyqE=;
        b=J4LbPrb6ELOxMWolM3B75EQB8WGdRVa789UckmeYaSBlrtzTsne9or7VanWNLb9nXV
         awmjszFdOKmzmQ1HGLDkMpT91DxQwWLEJeT+HqxEBNus4Aja+6BD2iwJJP3zcwp6nZDx
         y4xP7GomMMPHXI6g/SwDkCTHXQL35mG0opC9mdtLzRSDjnfydzflO0+yfxwTJy6ncMUN
         BAKIJAe7pqOm3OqL47FhbBvF6y1TSu5BgB40FiIUtd0mz5ItyUWVKWBWFBUit66+8eUZ
         4YJVd5Q70elyRc7gbGKFyh7DnXrhp+sjMC3BHp5c8v1NJPubQNRAPYHuox2XJXvPu6O2
         mOHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744894087; x=1745498887;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PQDfXWTBhh25iJCD88OMBYfvQOO/9ewWXf4UbyOuyqE=;
        b=iAiJZ9TKvGZ7Ce6bakmQ+19u5lyAfcKSKnZ+tjk134ebeHm1qi49OXUrPMCwYg41tY
         dsr4e7kBo0C3K89mX8f0ja3GhoNRIrADa4sPIEUMqnz2NHP+HLmjrtr3DdqG1MRzXc0t
         0HNsuCU6G/XCVmRlkCXDnUq7O2RmbQTsU6qcIggmntOwgmZQBjU9VCVxo0wF++bMqDrk
         qksouv1kzmH7+EwSKNyxVIjAlcqyIBtXTicrUUj2rOAs9IQfc4M2Kt9t4RVzD5pylv/H
         Ann7VbgEyTD/Pj26tsUbX12gqBcQM0rEsPxcxIzpiqvhd90izA0ON/l1lNyDfFWAkH77
         mGQw==
X-Gm-Message-State: AOJu0YxaL2W62mIn7DpnA7RvjbMYp6B5+NwT1zTWf51Gkvr9x0a3znbl
	KjJXJXXeoLCy6GeJOpEIVw8Y4rG30KtsIlCgIwaG9g3E5DooA/8TtUODjuHBMTlFsyHA6qOUOxG
	b
X-Gm-Gg: ASbGncu5uaot+cUfYMqZgG/KkSCs2Qt9qPwTpg3vog6BzvNBo840JiFsbo9HMEJS5Zh
	mFA0oP3KaPIvO3gBw0jf8FTu7jm+/VHH/dq3/u3PsOQOfOUyEQ/ZlAR4A68vfm6SPnWKsF2IoF1
	u9j4fsyKAhhsyGnjUOan5zBrr5NvxFH7DjxFP5AfCgikX8e/7sZRCU5BXrcoH79u06bPr0fFB76
	JRi3wlqlS2c/fiqFyYVUbxaHqamhrCjGNfF50oM7OpIwVL9Ivm+suNZVWunWfp+/zm2MuzYpil5
	eNFOC5ILwL0p6hf49wJzYofh5HtjUXkueb0NmXmHxZ5Ba9qKG4vv5FaZa8/qeipaWfD2rNlNw3V
	W6Hc5tnKzjS/D
X-Google-Smtp-Source: AGHT+IGlH6gufHLoup6uyoToXnCLDm8s8plB4v/jXxnZVFIwKpFvePSDNdBKjhdl2VT/KJ9BtVE0hQ==
X-Received: by 2002:a05:6902:2584:b0:e6d:e8d4:680b with SMTP id 3f1490d57ef6-e727575a1c4mr8094474276.6.1744894086747;
        Thu, 17 Apr 2025 05:48:06 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e72758ed845sm666228276.18.2025.04.17.05.48.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Apr 2025 05:48:05 -0700 (PDT)
Date: Thu, 17 Apr 2025 08:48:04 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: Naohiro Aota <naohiro.aota@wdc.com>
Cc: linux-btrfs@vger.kernel.org,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: Re: [PATCH v3 12/13] btrfs: add block_rsv for treelog
Message-ID: <20250417124804.GE3574107@perftesting>
References: <cover.1744813603.git.naohiro.aota@wdc.com>
 <3a317ad692057695d49cd8428ed660f551eb759b.1744813603.git.naohiro.aota@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3a317ad692057695d49cd8428ed660f551eb759b.1744813603.git.naohiro.aota@wdc.com>

On Wed, Apr 16, 2025 at 11:28:17PM +0900, Naohiro Aota wrote:
> We need to add a dedicated block_rsv for tree-log, because the block_rsv
> serves for a tree node allocation in btrfs_alloc_tree_block(). Currently,
> tree-log tree uses fs_info->empty_block_rsv, which is shared across trees
> and points to the normal metadata space_info. Instead, we add a dedicated
> block_rsv and that block_rsv can use the dedicated sub-space_info.
> 
> Currently, we use the dedicated block_rsv only for the zoned mode, but it
> might be somewhat useful for the regular btrfs too.

We can just use the treelog_rsv for this too, it'll give the same behavior as
the empty_rsv, so just do that and it'll make this cleaner.  Thanks,

Josef

