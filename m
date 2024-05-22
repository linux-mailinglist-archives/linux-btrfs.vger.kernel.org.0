Return-Path: <linux-btrfs+bounces-5212-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 033C08CC401
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 May 2024 17:22:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A0291F2328E
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 May 2024 15:22:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB2D95731B;
	Wed, 22 May 2024 15:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="wQ9YN8W/"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C9131864C
	for <linux-btrfs@vger.kernel.org>; Wed, 22 May 2024 15:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716391319; cv=none; b=DWtCV0WpSv8jjpjAx5KJmL7tC206BQ705hc/j+bCGV9iMyeO2RGWnunw9kIXUeE/YFf8wKE2vWzH+Na/YBlvmPFLgVgXHb4zq0aTssHUU2tqsbItfMZ7emjtFEVLbCRfyv8Ef87ebQtLYhMdm7wQonWRrig9B7iwHYPEShADPXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716391319; c=relaxed/simple;
	bh=aQLNbDz955+5ay/WsxDN6ChnaZG7iZMBySgAraWqIjs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qMIWN/vV84Ld5p+y0FD6qDqn7KAdeNwr5ruFJDogE/uyy+qD7bZz32mGKXDQte99tW5PFCXTmWJJVVz5jnG65dLRfhx4CMc+FR9S8MQkMPkcg7QkiZ0+peKEfQ5Ys9GeQK8/5CToZnq1zXJI4Uq4yKpTNqTjcM/RKnSRpjzvxT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=wQ9YN8W/; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7948b50225bso107471285a.3
        for <linux-btrfs@vger.kernel.org>; Wed, 22 May 2024 08:21:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1716391316; x=1716996116; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mL6oCTm2MGiwsmUsgc8LWMcFXhiIcSr2Ls2POSCt0DY=;
        b=wQ9YN8W/tgbjxZ+JDgMiH+cqp21PjvqX4K3DOqeQMjGCy24aYoHH0qGUToiEn2rYNj
         Ja+m0JAxHyfzd7E2G0oElvxSlE0VEB20a2Nq1nV+RasKpfizpKToBBiWDnMnCjBI/n7x
         IkSy2+JY8yq8nXmPDi9lkuIoY3SvaYvLQeLwVZmbeDEzC47knemZvu3PeVT8zsYti2Pa
         i28lJ6tsxeVl3LSZ54h8gMID/NeVFrVX+4FKOs6dGWMGiqRQpyg4BeauEu7t6+WQlP84
         DmIj2NKPAy2FWw+VV9w/SFS7Jk6jQyp5nD9GtuSrmWrSEWVVkWsqp6rQXQDSOJd/V7xv
         3cqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716391316; x=1716996116;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mL6oCTm2MGiwsmUsgc8LWMcFXhiIcSr2Ls2POSCt0DY=;
        b=YL3ZinZRIIPKZbxr3GgHruUmCR++avSTJy41aHnbCcymUDqpuSjbc768aqGA1sgwIg
         LtIYMccJtxcQYg4YNgyaadC2UqVLsUxPAjbknvheFdCyr+WIvHAaCI/aoEO25/2WXkZb
         TIeeTAj7rJEFpZ1etD4jvmisqqOZOVOFVCPmV7+JgftEnBqqMvWmmUs4xXMWbGJ4g91q
         BhJx5yf3fmjQqsbCZPjnmCHVUOLaGQuDAEW9JH9PVNgSh60v9qCpNmhk9qSWoBt0dPpI
         aRzAhAfY1Zk+nkLQkyMO4kNwoqWAecg8PFr8dmbG+N7uuOQeXo62gg6Do0ZkDZlc7oWf
         /USA==
X-Gm-Message-State: AOJu0YyOwnNw7DTVBBkfMEVBUSmpedy58i7rQIS3lSMo4LXLOxgPYk6i
	CV6TQxthT9xOwLvmLDOqW8sw/zOBnRYItHK/i+INcvJVLpJFZKJxUTIp4wc1hnY=
X-Google-Smtp-Source: AGHT+IGgmxjIjsaG7E0Ww4fn+3Ue/4n0711xMqhOqdJ0h3y+2jsl+Hz/RjeOyjjYhHGKsh8vDt3wuA==
X-Received: by 2002:a05:6214:2c09:b0:6a0:cc2b:dc03 with SMTP id 6a1803df08f44-6ab7f34a4bamr22079126d6.1.1716391316305;
        Wed, 22 May 2024 08:21:56 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6a15f1d73c8sm134428786d6.118.2024.05.22.08.21.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 May 2024 08:21:56 -0700 (PDT)
Date: Wed, 22 May 2024 11:21:55 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: fdmanana@kernel.org
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/7] btrfs: avoid some unnecessary commit of empty
 transactions
Message-ID: <20240522152155.GB1403601@perftesting>
References: <cover.1716386100.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1716386100.git.fdmanana@suse.com>

On Wed, May 22, 2024 at 03:36:28PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> A few places can unnecessarily create an empty transaction and then commit
> it, when the goal is just to catch the current transaction and wait for
> its commit to complete. This results in wasting IO, time and rotation of
> the precious backup roots in the super block. Details in the change logs.
> The patches are all independent, except patch 4 that applies on top of
> patch 3 (but could have been done in any order really, they are independent).

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef

