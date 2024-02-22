Return-Path: <linux-btrfs+bounces-2647-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB2C285FCE7
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Feb 2024 16:46:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 460381F269EB
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Feb 2024 15:46:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E01A14E2FB;
	Thu, 22 Feb 2024 15:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="WCrjLG2Q"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C31739FFC
	for <linux-btrfs@vger.kernel.org>; Thu, 22 Feb 2024 15:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708616671; cv=none; b=Yv5G9E6bqfUTBFSasAYcahfAMcwjvCGKpbjbEqLqS1Hx43hkLWc3i7oL7v/kbJ3fIufk8lrU93jMcqEv8+b6YZl1/pj7GJocFnyyPIu4grvZw1vM04JfbBhGO8b3SH54ke40UENZUjzF2HD/qVYqN6nHeDuazyEYfssa7cs0h9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708616671; c=relaxed/simple;
	bh=duiRt2peBuQ9/Ht+v3aW7fbI0YpFU+wvmcN1YiOzXeI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j53B3mqKy0HMNVHyxaAsNiW532Twa7Tc2qmxh11gpoAZZX6oR7wwYrUfPap1RwNAI8BFLOLOoDX4wMvpaU3jgki05J7yeQNg0m4rEIQPJZvOA3kbAIuPlh7dG2SQr/HidZ0k0oYGWDRuPTDQwp6iwID0oeKp1yO0ZWRftgSJeKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=WCrjLG2Q; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-6089b64f4eeso7926977b3.2
        for <linux-btrfs@vger.kernel.org>; Thu, 22 Feb 2024 07:44:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1708616668; x=1709221468; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oc7/wvuAFHr4+O6wqMY0sCQlIXMNkC5yYb64gIXk4fA=;
        b=WCrjLG2Qvm6IeMppRICIGl6YIXh8H77fbEW0v/E7803yK7U5CB2bxAAi2ceJbXPYRF
         7w54TnjDNSec70hDunoKX2zBKOdEQ+DaY8EibKcSyj2jGpETBK/OyCfcqccRajPr6PfC
         Z2GsMEky13oELsWiB6hgoZlGOi+o65XAqfKn9DqquT8Fbofvpx2UOyRO8YsYNvFwOc9u
         yTtC/hkUHjDAoBN1UY/8HGdQTCwYUiM6HBDZdQKUshKWqIbsyYd9j7ynHE6zN1eapHUE
         6JJ50MH0uwGShidhT5cR9FP0jTO07XqwOaPZX4iq2j1YPezs9lnNrclvHiI4iGkN1id3
         1h7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708616668; x=1709221468;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oc7/wvuAFHr4+O6wqMY0sCQlIXMNkC5yYb64gIXk4fA=;
        b=ErlO/IPjfXjgWXDfLo764QVM9O23yGPFwi4wJJpYHVgljrHcpoeC3F7Y1zNAxbPvHD
         J4Zzq8hYiQi5q4qVFhoIuOBJn/h2gTVQum2a8r9AHSVO6503uyBXSnesGtkk8UwffHCm
         1aBWnmVeBXysiqBGZovnZla7KSIsd35Gn55X37cw/ETt8gwKcec500Wa92+MX5vuztnH
         VWEmjV/DQdpe8PA1HyKAJNqO3YQeS723zipN+zApgF1b/FDcTLREhrhGlkYkUAqQPAAD
         0L5JyURVNkpPpybQui6mumDocCLPeO7U4CMnpbmYvkiyvD+AiTMpFnbvK2XwZrqYukMK
         reKQ==
X-Gm-Message-State: AOJu0Yy9nlFj5SLZNGIvivrRd7TKk9M6HQZa/VHOHWcArmdVMqjcy7BL
	nBnqE+E5KCOaeOvxTR7feaf1w4SiI+Ay+9kQh9jlzfqEF+TJMo15iyla8SxrEHQ29V/k3seCulL
	C
X-Google-Smtp-Source: AGHT+IH7nGdivKycxKwSQwGP1n+FtKIBiqy1JKuXZdwgyrwt4sT+VbecNll1kZJGW7FpBZsVTkq9BA==
X-Received: by 2002:a81:9297:0:b0:607:cd29:8ae7 with SMTP id j145-20020a819297000000b00607cd298ae7mr23191212ywg.15.1708616668475;
        Thu, 22 Feb 2024 07:44:28 -0800 (PST)
Received: from localhost (076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id j206-20020a816ed7000000b00607af248292sm3133680ywc.49.2024.02.22.07.44.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 07:44:27 -0800 (PST)
Date: Thu, 22 Feb 2024 10:44:27 -0500
From: Josef Bacik <josef@toxicpanda.com>
To: David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/4] Simple cleanups
Message-ID: <20240222154427.GA1219460@perftesting>
References: <cover.1708603965.git.dsterba@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1708603965.git.dsterba@suse.com>

On Thu, Feb 22, 2024 at 01:14:07PM +0100, David Sterba wrote:
> David Sterba (4):
>   btrfs: handle transaction commit errors in flush_reservations()
>   btrfs: pass btrfs_device to btrfs_scratch_superblocks()
>   btrfs: merge btrfs_del_delalloc_inode() helpers
>   btrfs: pass a valid extent map cache pointer to __get_extent_map()
> 

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef

