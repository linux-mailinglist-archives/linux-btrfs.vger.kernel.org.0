Return-Path: <linux-btrfs+bounces-6103-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4762291E203
	for <lists+linux-btrfs@lfdr.de>; Mon,  1 Jul 2024 16:13:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4A3D1F2434F
	for <lists+linux-btrfs@lfdr.de>; Mon,  1 Jul 2024 14:13:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5FE8160883;
	Mon,  1 Jul 2024 14:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="jL17IETR"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB2831607B2
	for <linux-btrfs@vger.kernel.org>; Mon,  1 Jul 2024 14:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719843204; cv=none; b=bZUTuUDml79kyVVJbEWqCifj7THvRXJkr/HfZD+Pn435h1XV/WS9S4dJG1y49E11A6Tgu4y0pZJ8trQmE9YjLPlJNsFWtqHvNfXXmHnWq5wVThP9amoq1dzfpi49F13hsv8lZ2OIZfwwkjiFJGVBB9/MQzYU9DtheONgpTThGig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719843204; c=relaxed/simple;
	bh=b526KARkW4JPEtOvnvNzCFTKTu8enJ3nsD5AZ1U3LbQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EVC/4HaHRzUVJ9Vy3073MBvfgY/ZkacU1z5YyIHMGUGIQnr5xygs0bv8AMYmb1FTa+qWFhLfJpJtMPRo9YMEw9aNy925HvMcBXpF7cjz2SLXZJLE9dP1+75O3IC3O9TpiICOtyLFtcRHYiYGIVaqirzypo/UJOBwsXPd1v3NaXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=jL17IETR; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6b52eb2ee2eso12830766d6.1
        for <linux-btrfs@vger.kernel.org>; Mon, 01 Jul 2024 07:13:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1719843202; x=1720448002; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=e8NBj7ByJkavE1ljKuRjFTvom4+FzL+rEh64qCX2RTE=;
        b=jL17IETRWgBuhfFdc6x0FgUJ8Y1ZpWc/H1znk+UebLZ7iljACEpbUXqaxetsPPqW1y
         ei1q8HsaQuRhdBCo8R45B1wSPNd263fRm7ArPDGvcV0eu97YsvMq4TA6UUquVz8UfU3k
         yCwp5q4Mb4Gl8gVJ05fNj52Fm0ZA6zu8pw6Td/0GOJqQ6y0me+BtrLw6A4NsoVTNKpUg
         5OmCL8IlHTeGhfGTClnczDqV36FKR//du319YN5NorgoXouTc8XldbvLmuVHvqIvNoYY
         Y12GNCjtYg5SAF4bUvSkuBeWWLEi4RomaTYXjHMPBscjP1hyC4uJW1BqXGGOv/J/VXtM
         PhcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719843202; x=1720448002;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e8NBj7ByJkavE1ljKuRjFTvom4+FzL+rEh64qCX2RTE=;
        b=f00tf4Wt0gUba0H2CK3/Bwt7ZWqFVSVqZBB/DSN7uUt7gNj9rA4Ui+zxLa6C+FjMYt
         fSoILz9EVymILEiu/Ht0tz1P/DeEY5rkBeIONKJ7IQLIhfVtamx0DS7iM85rlbU+3ldy
         ofrbb6mKySSUMKrf8TjdRJL8tNtbSta9V91LVPblW+MAM+lMdZpl8cJaFZYnOlzqacN0
         uHnZyhv2I3yzVS77OAkkNEJ2KpBh4JJcalnkg3LpX+OfprixlYLA1rTj9MHN3PtRGjUP
         t6qJ3qA4dSJSuQBlZwVk65aCojk9fTZyI7a52ZxbtMkeH/y1xavVUigoE3W/LVNwn1b9
         kJzA==
X-Forwarded-Encrypted: i=1; AJvYcCVOHOb/4JKyqcrpvM+T+4NUf+nQc3RFWRHu2yqdm24w2RcIHZOyaRP46Mzg+N0rTZ8J/JPmhnAOHyK8X/ncXvTQXlYSXIzXn9wlp5w=
X-Gm-Message-State: AOJu0YyUjK8wnpDNhZqO9HASPeWISnsOnmzwraGmcw+3c/PnJTymW3gf
	pcfxC7igh1kJj2sk0c28HLbZPlaeVy19E9dJ9LS69XV9E/h+9rZVYlz7Mxv3mlg=
X-Google-Smtp-Source: AGHT+IFoJPJZrf6KhPJL+Dgw9h/Qr9lx4+O49fQ7jBQy6GA91wG05i//uQX/rglaA6LpruGpLuUxkg==
X-Received: by 2002:ad4:5ecd:0:b0:6b0:71c0:cbaa with SMTP id 6a1803df08f44-6b5b70ca793mr84422836d6.33.1719843201900;
        Mon, 01 Jul 2024 07:13:21 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b59e5f35c0sm33456656d6.91.2024.07.01.07.13.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jul 2024 07:13:21 -0700 (PDT)
Date: Mon, 1 Jul 2024 10:13:20 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: Johannes Thumshirn <jth@kernel.org>
Cc: Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: Re: [PATCH v3 4/5] btrfs: don't hold dev_replace rwsem over whole of
 btrfs_map_block
Message-ID: <20240701141320.GI504479@perftesting>
References: <20240701-b4-rst-updates-v3-0-e0437e1e04a6@kernel.org>
 <20240701-b4-rst-updates-v3-4-e0437e1e04a6@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240701-b4-rst-updates-v3-4-e0437e1e04a6@kernel.org>

On Mon, Jul 01, 2024 at 12:25:18PM +0200, Johannes Thumshirn wrote:
> From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> 
> Don't hold the dev_replace rwsem for the entirety of btrfs_map_block().
> 
> It is only needed to protect
> a) calls to find_live_mirror() and
> b) calling into handle_ops_on_dev_replace().
> 
> But there is no need to hold the rwsem for any kind of set_io_stripe()
> calls.
> 
> So relax taking the dev_replace rwsem to only protect both cases and check
> if the device replace status has changed in the meantime, for which we have
> to re-do the find_live_mirror() calls.
> 
> This fixes a deadlock on raid-stripe-tree where device replace performs a
> scrub operation, which in turn calls into btrfs_map_block() to find the
> physical location of the block.
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef

