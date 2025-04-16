Return-Path: <linux-btrfs+bounces-13074-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E2F5A90631
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Apr 2025 16:24:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 424AC1898AD3
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Apr 2025 14:19:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DFED1DED57;
	Wed, 16 Apr 2025 14:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="TRKoGE/0"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA1B81F462D
	for <linux-btrfs@vger.kernel.org>; Wed, 16 Apr 2025 14:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744813011; cv=none; b=ApIFKicXRbQsFMEDjPxV40dG8nN2vBRzzkjA2EuPOVANTczQpUSm4hL9WHntinZKsws39HXCPUxnl+QglvAlnUtPZMkcPaO8L9FAtFaN9a92vkHLmZBdAN7uPq9FtvUHmZXXKLFG63uL8KiX+INEHEBmWbfo7tpfkALBBGgvpCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744813011; c=relaxed/simple;
	bh=zxjrm30nO1USmTUbSdP5QuRX++6zam2QoAxUmybVTuE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fWVP5GJXz6iEBEyCQE0BOyl5jNPG/SLLK9nfqKWNlWLEV+LPVoMPbnoo0c8CB+hFfX+Q77aoeDsO0emwRFE5P3SASRWHAy9mJGCzHY26evSfYJu1RH3NbmvaBckDYSedArFwpTK48zDaWBIgsKabxjJYgRLNR+zZWnC4Doq0o/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=TRKoGE/0; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-e6dea30465aso5751595276.1
        for <linux-btrfs@vger.kernel.org>; Wed, 16 Apr 2025 07:16:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1744813008; x=1745417808; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FXEpzCPhoL5cxq5bcO2k0VxC53o5bkUB0bTKg/wFJ/Q=;
        b=TRKoGE/0nZC1IxQi+PyRIsc1DT+fI68kO0NJLBrdLbJ7KBwbRPiY0+5x2kMBOGeNbT
         KZd8BZxih2KqNIOqhuxf9OiUy3byy2kwzE8ZYJ7a5/HG4dY47WxEHLwHjVXiB0okObh4
         ykY2qypm/wW0NB4nlFMTwbMA6vQBWltDwk9d8g2JNAmn5SngWDmgDSyLQrcpK15njanf
         JH3RJy1AOhMv8HgJiyXZR4BDn2BrmgaG9tqPJJ8isvOL30wO0E4ibQ6+LLV7A2SWlzPv
         XlewawErsQlo6paaKafx2mM6PT0K8DKFfIX6JNnpE9yXa6DEeq9JFwhbwTFkY2/I6xPq
         rOlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744813008; x=1745417808;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FXEpzCPhoL5cxq5bcO2k0VxC53o5bkUB0bTKg/wFJ/Q=;
        b=TrsqI2080ZfHhaLJQ6FonOkronByw8883ZH6XnNW7zuudV43LAQlkP+BwZMAG8eTya
         vQsJud8fgVj5tmSr6GDBZ0ixJ+RRF6CVww7BewQiHx77r5F5tFM4/1vNvVq3bjYRhaeL
         32Nv9P6P4qFteOwRRHlI2RZerIXVQwlkT4eSB/X8zmqdTLg7oJrROGQRAJkUmfXIu1GJ
         AUy6ffSlMcmr+eSxTxkSWUj1detA/VyQMgSBjQGzmDtL93BhapRgWSieu9DvmMN3k0MM
         9Q6eild/BZka4xC6iaGx1l7Fsgz0P0c/7S8L47HrwQulhFmG3HMqLZrdN53ZnRfJuHMY
         et0g==
X-Forwarded-Encrypted: i=1; AJvYcCX89dFRCwwlX0r17YRR3bU568Mj9i/9rszHN4qx8P/LM6SUfWJq2ZP008OUEKocd1e3ng3xEeDygs1Idw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyF62XphQVpfW584/IhqdG5omeZR5ylnZI9PFrGeKfTqnmSNN2y
	gw9K99+bT4ajoJSdsFIeZ3h8Sp4N1CdI5pBE3aMhnTfSUbfC9TCBKsYcqUNtEbY=
X-Gm-Gg: ASbGnctCkX1hyJqM8EeYAakUwImFuhIt2ArNvv7NNxAk+gaApR4fnDaA7M/hItwcyfd
	UdifEqDaIfL+WZhZvd5kdQLUgx7xGjlt++DGfYSMZy/TDb7lPx/nrTUIedb5WOkeBRlKxSPG0mY
	OS7/9A0ZCh6p87lvDObMYjis/5eHE1I4GLeHq0Ji4rlToC7YCrmCpsUeMYYrEOiPZjMGZz7sBuw
	l/vajuoCbSweAFWIEACo9Eb27ibMgn2jfI2w1zM2h8Z+v43Wmi9yL4QT/6IhRv+7M9yhGIThEpy
	9mn6FBSPX3u7qQynwPCf+5Z08/6HOAUUE/8wWRmzaMoXiIRpO3nrWkdWWHkmU7ivBSqJ2xOMJGp
	k8A==
X-Google-Smtp-Source: AGHT+IEpq4Ybhu2Y06g4nV6fgnVh9WvERC87wB6NUq5sIj9IKx7vihum1GMa6krqrGC21PJKtPsoGw==
X-Received: by 2002:a05:6902:e04:b0:e6b:7d64:fbff with SMTP id 3f1490d57ef6-e7275f1d0b1mr2533507276.47.1744813008551;
        Wed, 16 Apr 2025 07:16:48 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e7032742f02sm3818756276.35.2025.04.16.07.16.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Apr 2025 07:16:47 -0700 (PDT)
Date: Wed, 16 Apr 2025 10:16:46 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: Boris Burkov <boris@bur.io>, linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: Re: [PATCH] btrfs: adjust subpage bit start based on sectorsize
Message-ID: <20250416141646.GA2778901@perftesting>
References: <0914bad6138d2cfafc9cfe762bd06c1883ceb9d2.1744657692.git.josef@toxicpanda.com>
 <7e863b3c-6efc-459b-ae25-cf87734dc38f@gmx.com>
 <27440332-2afb-4fb8-9ebe-d36c8c33a89a@gmx.com>
 <20250415161647.GA2164022@zen.localdomain>
 <7ad4df86-866e-40ce-89a1-48f3c49aeeea@gmx.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7ad4df86-866e-40ce-89a1-48f3c49aeeea@gmx.com>

On Wed, Apr 16, 2025 at 09:19:37AM +0930, Qu Wenruo wrote:
> 
> 
> 在 2025/4/16 01:46, Boris Burkov 写道:
> > On Tue, Apr 15, 2025 at 08:07:08AM +0930, Qu Wenruo wrote:
> [...]
> > > > 
> > > > The problem is, we can not ensure all extent buffers are nodesize aligned.
> > > > 
> > 
> > In theory because the allocator can do whatever it wants, or in practice
> > because of mixed block groups? It seems to me that in practice without
> > mixed block groups they ought to always be aligned.
> 
> Because we may have some old converted btrfs, whose allocater may not ensure
> nodesize aligned bytenr.
> 
> For subpage we can still support non-aligned tree blocks as long as they do
> not cross boundary.
> 
> I know this is over-complicated and prefer to reject them all, but such a
> change will need quite some time to reach end users.
> 
> > 
> > > > If we have an eb whose bytenr is only block aligned but not node size
> > > > aligned, this will lead to the same problem.
> > > > 
> > 
> > But then the existing code for the non error path is broken, right?
> > How was this intended to work? Is there any correct way to loop over the
> > ebs in a folio when nodesize < pagesize? Your proposed gang lookup?
> > 
> > I guess to put my question a different way, was it intentional to mix
> > the increment size in the two codepaths in this function?
> 
> Yes, that's intended, consider the following case:
> 
> 32K page size, 16K node size.
> 
> 0    4K     8K    16K    20K    24K     28K      32K
> |           |///////////////////|                |
> 
> In above case, for offset 0 and 4K, we didn't find any dirty block, and skip
> to next block.
> 
> For 8K, we found an eb, submit it, and jump to 24K, and that's the expected
> behavior.
> 
> But on the other hand, if at offset 0 we increase the offset by 16K, we will
> never be able to grab the eb at 8K.

Right, but this can't actually happen can it?  I mean it could happen the first
eb, but as soon as we allocate eb->start 24k we would fail check_eb_alignment()
because it straddles a folio and then the fs would flipe RO.  So I don't think
this is a problem in general.  Thanks,

Josef

