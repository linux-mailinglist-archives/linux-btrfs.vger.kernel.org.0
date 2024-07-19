Return-Path: <linux-btrfs+bounces-6615-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D0422937D41
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Jul 2024 22:20:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7961E1F21ED7
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Jul 2024 20:20:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D493D1487DF;
	Fri, 19 Jul 2024 20:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="hsEKpLR+"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AC8D4696
	for <linux-btrfs@vger.kernel.org>; Fri, 19 Jul 2024 20:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721420444; cv=none; b=Wy6XQMnqh0TdveXSckROpABVkPqFzcq49Rw0/2DWqsCovkeTS2Cr9AlHGNBf98kikcyKQopkZZpeaTnIS7cmsTYBGwK6FJGMmi+XQrk+HXcqlLtkCizv6+nbnfSzswviKHv1MOEc2w2b9Zts7Bc9wGY43zge2ujav2eSJeyjMMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721420444; c=relaxed/simple;
	bh=ePX3DaimQP7elFDNQzoTBqLomgZIz+N+2od20n7fUGY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xu4l21Jav7QrRmlGP3Q+Y1ht6yp9Z9T31u7fbXxA15ytcMvgGOL1+9L/u7hQfso0JIFcs/wPL4R+9AZvmepi0arlblpv6zlO5sf9KPBPhypDE/fTK9oVKs5h5hfyyc+m6V8DT5f+11jgr5WPpAo9DZ3JVvEuZxxUbLNOyduoNJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=hsEKpLR+; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6b79c969329so12821506d6.0
        for <linux-btrfs@vger.kernel.org>; Fri, 19 Jul 2024 13:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1721420442; x=1722025242; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RIvTnQBvlH9O1Ubd/J3dZPUJRDVmFHjjqknM8w+RXz4=;
        b=hsEKpLR+0/eekPVaNnsMsiLW9lewsWs0Zyw9o2uluLNAhimXnxJDlNHpKgh+YigD7g
         3nKyyKCfAt3PMadSlfuXlrBlRQnKmKJk97dX4tCrQjgarcPmEX92sYPAvROcL5GNOo0L
         YKIPYsvOynj5YDRAAbCOuWJ5WISzfNTKFXONAsOMMao2AYtbhaBECmbiO+SFILYulR55
         3mvOvsPRTuWTxncaiNTSQ9XO93uTorBzSkicYJC5bVqkGN/kZHsupbjb/eC/g6X1xx68
         oux/SXvyJIgx3z4as9RxEV58fVFyJFJCzPPSEIlKMUT3ChvaevKb3lSjC1vAKasVEYdP
         Zj3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721420442; x=1722025242;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RIvTnQBvlH9O1Ubd/J3dZPUJRDVmFHjjqknM8w+RXz4=;
        b=ZO6cZLPZiAtJu+Bh1cJHwZ9yJ3cYcQ3yWTMJnc719qWATCw4arCKDfSLPId2XbN+zB
         fJktADRvXvme2y5B0RsHoKgE+LA3Vx+zkjRLGoDAM8l54lIdYz34/WO0ZDquzAXDw+jg
         /1gAvFQPm+Cv/Ngm2osrURAPV+RK2bcumwvMKaT7FDQOsnxLi3ps1w2j00ZK/fqfqDYS
         dpVRrPVqL1WNxbPxLe033qZTuik/JFo26NchqTbpwqvFjv6ddQH6eIUotrVby3BYSbGF
         wi22ShsETnuEvs1XjXrHqLsvWfesHMLXiIercRn1gpC6TymYfHvRTUrP6TyIVbbbYAO7
         Yp2g==
X-Gm-Message-State: AOJu0YzLgIh4o0J4J7HCS8jIypUWjWWSmOV6KlPV9VMDvZTMulPMs52X
	DtnPx+ggeJY7SKq9pPP4SeVEU+e2gtj+8TK17zGQvQ831z2abhF+QdZrJi6ZivyuRtRAGRPgy1I
	2
X-Google-Smtp-Source: AGHT+IFKe1AktrZv69d5V2S1N7uN9W3NSZ++G/4NrThag0YGXozCi7cJjpDYaEZMBksAqVcrRWJWpg==
X-Received: by 2002:a05:6214:21eb:b0:6b5:116:b212 with SMTP id 6a1803df08f44-6b78e200375mr118353356d6.45.1721420441943;
        Fri, 19 Jul 2024 13:20:41 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b7ac7e679fsm11562286d6.54.2024.07.19.13.20.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jul 2024 13:20:41 -0700 (PDT)
Date: Fri, 19 Jul 2024 16:20:40 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: Mark Harmstone <maharmstone@fb.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 2/2] btrfs-progs: set subvol uuids when converting
Message-ID: <20240719202040.GA2312632@perftesting>
References: <20240719150343.3992904-1-maharmstone@fb.com>
 <20240719150343.3992904-2-maharmstone@fb.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240719150343.3992904-2-maharmstone@fb.com>

On Fri, Jul 19, 2024 at 04:03:24PM +0100, Mark Harmstone wrote:
> Currently when using btrfs-convert, neither the main subvolume nor the
> image subvolume get uuids assigned, nor is the uuid tree created.
> 
> Signed-off-by: Mark Harmstone <maharmstone@fb.com>
> ---
>  common/root-tree-utils.c | 29 +++++++++++++++++++++++++++++
>  common/root-tree-utils.h |  1 +
>  convert/common.c         | 14 +++++++++-----
>  convert/main.c           |  8 +++++++-
>  mkfs/main.c              | 29 -----------------------------
>  5 files changed, 46 insertions(+), 35 deletions(-)
> 
> diff --git a/common/root-tree-utils.c b/common/root-tree-utils.c
> index f9343304..9495178c 100644
> --- a/common/root-tree-utils.c
> +++ b/common/root-tree-utils.c
> @@ -59,6 +59,35 @@ error:
>  	return ret;
>  }
>  
> +int create_uuid_tree(struct btrfs_trans_handle *trans)

If we're exporting a new thing then it needs to be renamed to
btrfs_create_uuid_tree.

Also a convert test for this would be good, to validate we're getting the UUID
tree on convert.  Thanks,

Josef

