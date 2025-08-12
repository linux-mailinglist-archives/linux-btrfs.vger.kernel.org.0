Return-Path: <linux-btrfs+bounces-16006-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 44222B21BEA
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Aug 2025 05:58:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77BEA1A20406
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Aug 2025 03:59:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A9E32DECD2;
	Tue, 12 Aug 2025 03:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hihrJ1bu"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B4361DF27F
	for <linux-btrfs@vger.kernel.org>; Tue, 12 Aug 2025 03:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754971122; cv=none; b=NRx4GRnpJQzwyY+SAB/LNKfTrj4HSLEDr6SxbULoglVRWnxmk3R82bEvufZ5TlLuy/ae9OhYmuqank5vuGSniuDB3jPVi0jRrAmxJmAvUY5UJ5xclIxwLc62jg2prpapDR0zIXuZ24HmuNOylWI5rFxV/UZF8iy6v7zqVnkKsek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754971122; c=relaxed/simple;
	bh=QDW6PgcfQGmvnuZamnjvlDuDj/nN6/r+CzeVaCn9PhA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jQY9vzykcSYtKT2dS21j0zz/x1ThmUEnoEfUbvXwZclT+8Yywpd5y0g3wRh/HXeADcwqebKm0xhh0etid8r8k7evT26C73gMBaj59KbLqY+KXLbqi7E9ElxplIFo6VxQ8CS6x0iKavU3/yd1/+ZD/iXGTe+6pgjt991PsVYgjN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=hihrJ1bu; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-31f4e49dca0so6106603a91.1
        for <linux-btrfs@vger.kernel.org>; Mon, 11 Aug 2025 20:58:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1754971121; x=1755575921; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UsF4i7owr2w64jophO+zO+eW0GN81ddWs4iypkKqJ00=;
        b=hihrJ1bu6sELq8z9mjr/kEdkySRitX2ZcqISoR0PTSKkyQSbp0BF4WtJYLR1JKXZCO
         j83CRm4GSIM3w9rtEMXObIjJkARbBU//RsdBZhHcW3pDcXe+4g6tZr1tqzW3BrA3olCP
         +24KObsBsiVGVgc6BvpbTO1aSlUMd+mMaYNrQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754971121; x=1755575921;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UsF4i7owr2w64jophO+zO+eW0GN81ddWs4iypkKqJ00=;
        b=r6ZZNQWjJCrDrClL8b6u43gQ+r95JzdrFORMyfcez98dvHJ6IkhYurncT4R+o/ZeG7
         nfvOtyt3lM7m+M3qLNhBcVSOTgpw5mQn3vMhVTbgD6BF3SKyWNeZcEs0E683A2OUHuDV
         gN+kl3ga6jSEYX7IOqmicCxkeSJ2rFprB40xJsgPdIUxaNAQ6c/84Rz6uOkFCQ5/wfX+
         2nNrHPK0N6sCpPbqc8mtUkwAsCrw45pxtylzHVwMV1IphHsK/+vnpA7yL2maPbW4JR9L
         iyYLx9i+uI94QFQqkcWY/KrY+07aLZWkaWgHdFFGzMdQI56Jx+TCEcOVahCxkzAC2nI1
         ZBiw==
X-Forwarded-Encrypted: i=1; AJvYcCUZb6RjoebwKS5F9TPvMDZ+QQX8u2AC+r1Pzv1Ohkr5wLm4pjPMhfpDtAX9QxOJQxsED7wyO7ytdJOpQg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyibI2DcZ1nyVb6xrE4ISgDaTQSNQMsHnhnNUbZ85wbPmNvcNmA
	i/PPqf74/aaa/YTV75c3R6lB7aDz0KtDsWMI31s1idilBArZ4xGMxBPV4HDe5ksCoQ==
X-Gm-Gg: ASbGncsVACWnhAL8kQZDt9f6kOuPGNabYkNKqhAWRKuM5BpkZrr1MgGyenRd0zwy85N
	50GsbHP7PkOc872h6kJk+PaUnD+G+FlKFPdZRx64suvQSlhEYUYN9l5sm9eObrSHAf+uQOucGu6
	mt5k4JwMQ+gvCGZas9apexhTi2XpbUziNpgDJ9YdoYvSMPjFIj/BV6FimzsFtPR1KnUXQb0WRap
	i6Ie/6hZesITAMOeJ2l/84sos5kOXf/O7P/xwFDbzeXfk9vpeBFREuafWFmv/OvR3On8+bDzNaK
	IpodqThYInS2feTny5j3v2rHU9BCgLU30LYpvDA+wiendSPbO5t0kTQhV4+0a0aE8OANj1dug8N
	rVqJg8sYjYVS3scK90dw82VlulPfgobWKCjRb
X-Google-Smtp-Source: AGHT+IE0YyrVY5Vt8OKrl33IrgQwBQBekiXEdcW95C5mTt17WuM8Sondsrrkn0NdMV5pujBh12Fm4w==
X-Received: by 2002:a17:90b:2251:b0:31f:1a3e:fe31 with SMTP id 98e67ed59e1d1-321c0a11aa9mr3103600a91.11.1754971120678;
        Mon, 11 Aug 2025 20:58:40 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:e529:c59e:30f9:11d3])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-321611d846esm16436888a91.8.2025.08.11.20.58.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 20:58:40 -0700 (PDT)
Date: Tue, 12 Aug 2025 12:58:29 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linuxppc-dev@lists.ozlabs.org, virtualization@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
	linux-aio@kvack.org, linux-btrfs@vger.kernel.org, 
	jfs-discussion@lists.sourceforge.net, Andrew Morton <akpm@linux-foundation.org>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, 
	Jerrin Shaji George <jerrin.shaji-george@broadcom.com>, Arnd Bergmann <arnd@arndb.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Benjamin LaHaise <bcrl@kvack.org>, 
	Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, 
	David Sterba <dsterba@suse.com>, Muchun Song <muchun.song@linux.dev>, 
	Oscar Salvador <osalvador@suse.de>, Dave Kleikamp <shaggy@kernel.org>, Zi Yan <ziy@nvidia.com>, 
	Matthew Brost <matthew.brost@intel.com>, Joshua Hahn <joshua.hahnjy@gmail.com>, 
	Rakie Kim <rakie.kim@sk.com>, Byungchul Park <byungchul@sk.com>, 
	Gregory Price <gourry@gourry.net>, Ying Huang <ying.huang@linux.alibaba.com>, 
	Alistair Popple <apopple@nvidia.com>, Minchan Kim <minchan@kernel.org>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: [PATCH v1 2/2] treewide: remove MIGRATEPAGE_SUCCESS
Message-ID: <lky6lmpq5hsflc4rcs2hev5i3gctvbrppysttnzo22r6oiryw4@edfre7sprwk5>
References: <20250811143949.1117439-1-david@redhat.com>
 <20250811143949.1117439-3-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250811143949.1117439-3-david@redhat.com>

On (25/08/11 16:39), David Hildenbrand wrote:
> At this point MIGRATEPAGE_SUCCESS is misnamed for all folio users,
> and now that we remove MIGRATEPAGE_UNMAP, it's really the only "success"
> return value that the code uses and expects.
> 
> Let's just get rid of MIGRATEPAGE_SUCCESS completely and just use "0"
> for success.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>

FWIW,
Acked-by: Sergey Senozhatsky <senozhatsky@chromium.org> [zsmalloc]

