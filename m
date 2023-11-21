Return-Path: <linux-btrfs+bounces-247-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 19FC97F306D
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Nov 2023 15:12:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA128282B80
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Nov 2023 14:12:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C391454FA1;
	Tue, 21 Nov 2023 14:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="NebtUJ5b"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF7EE10C8
	for <linux-btrfs@vger.kernel.org>; Tue, 21 Nov 2023 06:12:47 -0800 (PST)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-5ca8c606bb7so21164247b3.1
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Nov 2023 06:12:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1700575967; x=1701180767; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bTZPW3dcRKHC2UH+61gm+epiTvsTyR9FCZJoXPjOFv4=;
        b=NebtUJ5bNYZ3gQKUqlbJe8Kz/Cs87ZQq7xc2DXbyEfQPhun5DoCuepxidvQ6Tgg7h+
         w5JJXOVWNHpcHXGTwtNjrmVMr4aqZ8ScXcFlqp2amvYXSRanO3TFtqu/JksH63Vwts9f
         qCCdtcWcLJ93i3VwlUZUHA+iAjW3tyZbEy2+gnxlcep3/nNkFU4/NH4Mlddw+eFp3AY7
         jWS/VyzuMl49MJAETGYB2Sh8h+M5I2eGNWh4xYbtO6uHDI7Dhw26Xe9/iAI6wcoPZNcA
         4+Y5xAJ7h+0Z9uikUA4A+tJSHlwMBB+41gw27UygkqMlksZLD30zrBaBz5f0szJWmzGl
         rCog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700575967; x=1701180767;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bTZPW3dcRKHC2UH+61gm+epiTvsTyR9FCZJoXPjOFv4=;
        b=LCPEF2lguPF8XVXK4/4AWE187huMSXDyctuJuhC9XEurBFbxqkSaM2BZ9I+5Up9OqU
         gsPQs5sjz3pFF4FLFYDtJKh9/UBQ6S03aj2oWnSuC9Mm77MIU2mWjjMJXMfrk+qFWnMF
         6j4dAxurMFX18gNXcVj2OjLC0q109DiEJm1Li1r/yH2R2NM9noDO8b2ORipVLWhrK2Bi
         W5iUXjN2GmDPKgryqOakXQGQR2T8pkajLphbiBkWEYcgl4BdNhz7wT7AYuo4da0JLiC8
         bMaaK0K+4RJRzspawhR1CHntbR+aM6c0CEufzzgsd5Pj2SBhYwJB8PpGZNAElig3YDOH
         8nmA==
X-Gm-Message-State: AOJu0Yy215368pdDJYDEHLAPBepBs6X4SoL6WS+NqGcZZN1x0zmXi4GT
	vpUwHjqCQyLrnERrkH7x3rkQZ77//tmkKwtLex3c1puP
X-Google-Smtp-Source: AGHT+IGA4soejhVSfDl/mETR1qsGiY9rEi5EGA8ASjOp3uhB6/O6CHoW6zlrOHEKmBVURgAsOo/7rg==
X-Received: by 2002:a81:7848:0:b0:5c9:b2ef:dd0d with SMTP id t69-20020a817848000000b005c9b2efdd0dmr7341820ywc.44.1700575966990;
        Tue, 21 Nov 2023 06:12:46 -0800 (PST)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id q28-20020a81431c000000b005cb5ab4093esm635266ywa.38.2023.11.21.06.12.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Nov 2023 06:12:46 -0800 (PST)
Date: Tue, 21 Nov 2023 09:12:44 -0500
From: Josef Bacik <josef@toxicpanda.com>
To: fdmanana@kernel.org
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/8] btrfs: add a btrfs_chunk_map structure and
 preparatory cleanups
Message-ID: <20231121141244.GA1667963@perftesting>
References: <cover.1700573313.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1700573313.git.fdmanana@suse.com>

On Tue, Nov 21, 2023 at 01:38:31PM +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> The following are some cleanups and introducing a dedicated data structure
> for representing chunk maps, in order to make code simpler and use less
> memory - this is achieved in patch 7/8. This patchset is also preparatory
> work for some upcoming changes to extent maps.
> 
> Filipe Manana (8):
>   btrfs: fix off-by-one when checking chunk map includes logical address
>   btrfs: make error messages more clear when getting a chunk map
>   btrfs: mark sanity checks when getting chunk map as unlikely
>   btrfs: split assert into two different asserts when removing block group
>   btrfs: unexport extent_map_block_end()
>   btrfs: use btrfs_next_item() at scrub.c:find_first_extent_item()
>   btrfs: use a dedicated data structure for chunk maps
>   btrfs: remove stripe size local variable from insert_dev_extents()
> 

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef

