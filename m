Return-Path: <linux-btrfs+bounces-8329-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34DA798AB97
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Sep 2024 20:04:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB491282F59
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Sep 2024 18:04:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F43019924E;
	Mon, 30 Sep 2024 18:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="W0FkhJ3a"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA7E2198E9E
	for <linux-btrfs@vger.kernel.org>; Mon, 30 Sep 2024 18:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727719324; cv=none; b=aI/TnvW9n+bbWHCjAORHq2hTiW87Ntp27vBL0uVi4NGJKIxjI8PlIx50lL9OYLQ2rOYR4qlA88S+jTvPfLjfHRTNNlGgsJyTWEGg4hb+ndgMROWqlTzfN1lVVzxyLC5znGdCH+oa2clwfVS0R6qkOilkSxgHLzdQVm3f2gtxLyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727719324; c=relaxed/simple;
	bh=+jzIncPBZSY5trRNqe+S8turDhhmeRWeKzRxIjdeQOs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AW4HOWpUOH4vWW0LdPitC7/kE5ZrXCdfyx4V+00tkdHn5Bf+59rcUhwhGhKfNnaJ3eil4gA3jk56n2ZfLVsmgXxDSJhHk74H+31loF/gU9neRPxP61K27HiEk/U6hQzJ5/JOdKFfyeuMxWuahYjoe+POjgiwPeuMpAI9Crv6LYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=W0FkhJ3a; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6cb259e2eafso39010116d6.0
        for <linux-btrfs@vger.kernel.org>; Mon, 30 Sep 2024 11:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1727719322; x=1728324122; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MHH5b6mhuHi4eQSGVTRjkIE4u8aJ3SkLM7jZCaJP+1g=;
        b=W0FkhJ3a2cegHUIr46XZ3+EG3j4K4OFSMx2AjVIPiStqDb9aLOqeIQGCfaRllGz0J/
         ZaqjiI9Nx+gS3NwTAfZN/F9L0jruaP6tzRx1NsZbUEzgWBShX8I8aBrreBufwnp13F7o
         xvnukY6n26Uy+6MYYYXl6Vd/NUwP/DqHBO/Gm0cyx7vDpVqobIlFkEX0scFrge4FFvo+
         4/86lRIFV+QSGAuWBr31KiX6Z5/6S7aAPz5XakwW5hoQyLskmHkIIcdGZfV4J3LJFEVp
         nWX80MLSd+4v01R++wOTMoxk7FwgGjaErPIHJDOGomhxBzs4Q6f6B4KbiJhREHT8ugz/
         12SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727719322; x=1728324122;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MHH5b6mhuHi4eQSGVTRjkIE4u8aJ3SkLM7jZCaJP+1g=;
        b=Z+HQ0MSHg4O4ZrBbeGCTc0/DPjxw46Bszu8laxA/DBnResWHnRpmqv9wQRa/YIkM/q
         90ZfN9Cz+fLq+w/w7EtN0tXUXoQOThKG/7WfMldX9F8Rkbn+L2uLSAW8Dzy7LoqlJBOE
         bvQY2FyCLtQfakyHeqqTjxR7ROQghlRWXnVMLrZOHF6jts/SgUWcGhJ9ChtbT6/qksD/
         lj2dpzX0YpYed3VDAe3sn6Hy+kHyQZnQfrvtedIyLFwGPP2xoHQ3I9blzxWjkrZuzy5T
         XlaH9BMiKcyc/EVZCeBX6KaCkAfMepd5TI97b796GJSGgHp9ggZlUfs7FGRVf5n9CfqQ
         3xng==
X-Gm-Message-State: AOJu0Yw7MBBpUloMFp1EawAw57G0IdG3SUSe4KQp3hEG/dmAGk2clJLf
	0wLaMTQBKcpwOKdyKhw/3hQBVtxJB16lcgYIpC11Qo2r93fOxiRKjSm83LLBuAkexKgY0e1bMI6
	+
X-Google-Smtp-Source: AGHT+IEX21Za/6XisKV6VhHdt9HUNdkyQGMb95VR2lnbyznWC0ZvdQmOFB8vdSKn5OJrjoIOxUEksg==
X-Received: by 2002:a05:6214:2c10:b0:6cb:3f35:7508 with SMTP id 6a1803df08f44-6cb726c528fmr11354606d6.0.1727719321532;
        Mon, 30 Sep 2024 11:02:01 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cb3b5ff5adsm41829886d6.23.2024.09.30.11.01.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 11:01:59 -0700 (PDT)
Date: Mon, 30 Sep 2024 14:01:58 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 1/2] btrfs: remove the dirty_page local variable
Message-ID: <20240930180158.GA667556@perftesting>
References: <cover.1727660754.git.wqu@suse.com>
 <274af9fcd34264fd6e74b707ac33f1544e73c655.1727660754.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <274af9fcd34264fd6e74b707ac33f1544e73c655.1727660754.git.wqu@suse.com>

On Mon, Sep 30, 2024 at 11:20:29AM +0930, Qu Wenruo wrote:
> Inside btrfs_buffered_write(), we have a local variable @dirty_pages,
> recording the number of pages we dirtied in the current iteration.
> 
> However we do not really need that variable, since it can be calculated
> from @pos and @copied.
> 
> In fact there is already a problem inside the short copy path, where we
> use @dirty_pages to calculate the range we need to release.
> But that usage assumes sectorsize == PAGE_SIZE, which is no longer true.
> 
> Instead of keeping @dirty_pages and cause incorrect usage, just
> calculate the number of dirtied pages inside btrfs_dirty_pages().
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef

