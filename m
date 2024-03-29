Return-Path: <linux-btrfs+bounces-3795-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0088892020
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 Mar 2024 16:17:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E47A9B30438
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 Mar 2024 15:10:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16A55146A9D;
	Fri, 29 Mar 2024 14:01:36 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F795146D42
	for <linux-btrfs@vger.kernel.org>; Fri, 29 Mar 2024 14:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711720895; cv=none; b=d7Udm+8Cr5j9/xonePDZMjLwTo6KgwLEC8WRP0HfmHdFchMBWTv/wW2TZwDMfNp58yESXgPHoXM017JLWEzTKPpbXTLloKi9uUwyQ66AsMa+2Iu8qElimQeLDLV/1D4wnKrYrqwXNHXAUtwScofWwW1Irg233nLUJytxzfvN5Wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711720895; c=relaxed/simple;
	bh=i74F7NjaxnuQxdDtY85xiWNbuiNsx+NkmIsGdmHdShQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L9ehwUISKz4g6WTo3dMP5as/IcvqRzzKCMpR8sa/lkLV1x0wKXAKjDy6mGVyQGZs8fej4oJ0ofIqjf4vbuJdcBl6RjYAadksKYmIyoy3YeV5IrFR0R3/1pCPuprA+6sZUcd5gjImZINwl/4kgKAj1B63BvFVuHZPM14s77gS8QU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=redhat.com; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-6e4e51b0bfcso910672a34.0
        for <linux-btrfs@vger.kernel.org>; Fri, 29 Mar 2024 07:01:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711720893; x=1712325693;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lohjzyD8g/hGhEYvGq+VpCtpRHCNchr+EEmW0UGYQa4=;
        b=b6B02A4vqB/w8KszAvJw/tbcYfE3oaiyZC4z6F/90M0WYYTYlLNycXK4vntwosO63p
         4nS7snjsyWezb3B/wo7Lzr05xhMBui7vdUnUKchWL+2MApe1pP6JvEvy/6Ju3u4RaxcY
         R5gZWQzDxzDH8zMBTPQ06eWznNAMsKHdPLn38vs33uV7dWlg9WLb/WVjnzvoS85C0B7z
         d0KKQlxNCFvXVWovkzDk9BvoOPUaM0AX4UbSBCALG/zlI7SC6xCqlTOheY2hMeppSHA3
         KgC3RICI4TJ6Dy+A9yjFwMujp25/+MvzUYGE8M5qm1rt4O5eWyyBRbdK6cfUj4LoXliy
         sQnQ==
X-Forwarded-Encrypted: i=1; AJvYcCVNVcY/7dacWALHo8BxchMYbYLysOHitVUSQAigqwjOMYg4nbtSanqyfCNzoIjvg/Zmrm5mLHXz3Uh83mHRbQeN/DVDn4mmlFSfJCI=
X-Gm-Message-State: AOJu0YwBAV0XwhhAsAfiXu7O0lgSa0XK/v6HD3wte88c2Z99azbIAK1K
	Cc1DSVdwvS2Q432PPlwjk4K3RamgpGBxmqPCBIcr6rujWam1B1yLZIcym3WG4w==
X-Google-Smtp-Source: AGHT+IFsGhp10NMaL9dWqt1JzkamUY3E/XLNndhoccAqNlbVHfXe9eIcnVwx/GPeWcdOmWfGWY+mtQ==
X-Received: by 2002:a05:6830:1da:b0:6e5:1aca:aa26 with SMTP id r26-20020a05683001da00b006e51acaaa26mr2165579ota.7.1711720892924;
        Fri, 29 Mar 2024 07:01:32 -0700 (PDT)
Received: from localhost (pool-68-160-141-91.bstnma.fios.verizon.net. [68.160.141.91])
        by smtp.gmail.com with ESMTPSA id nf5-20020a0562143b8500b0069044802760sm1663149qvb.120.2024.03.29.07.01.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Mar 2024 07:01:32 -0700 (PDT)
Date: Fri, 29 Mar 2024 10:01:31 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>,
	Mikulas Patocka <mpatocka@redhat.com>,
	Matthew Sakai <msakai@redhat.com>, Chris Mason <clm@fb.com>,
	David Sterba <dsterba@suse.com>, dm-devel@lists.linux.dev,
	cgroups@vger.kernel.org, linux-block@vger.kernel.org,
	linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 3/4] dm: use bio_list_merge_init
Message-ID: <ZgbJu0Dx8uku5cTP@redhat.com>
References: <20240328084147.2954434-1-hch@lst.de>
 <20240328084147.2954434-4-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240328084147.2954434-4-hch@lst.de>

On Thu, Mar 28 2024 at  4:41P -0400,
Christoph Hellwig <hch@lst.de> wrote:

> Use bio_list_merge_init instead of open coding bio_list_merge and
> bio_list_init.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Mike Snitzer <snitzer@kernel.org>

