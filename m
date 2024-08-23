Return-Path: <linux-btrfs+bounces-7463-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 505E395D860
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 Aug 2024 23:16:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 700881C21A4D
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 Aug 2024 21:16:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FED51C7B8E;
	Fri, 23 Aug 2024 21:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="h0KrUkAE"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 985EC14A4C8
	for <linux-btrfs@vger.kernel.org>; Fri, 23 Aug 2024 21:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724447727; cv=none; b=LbuPUKfhaX8B/qxuQxNf4TDWmFkIUIftseeNgbAJ18bFtEf9ufeCk0mZM5od4gVis0hOOcmMc8wj2dZRS48B1B2ER8Vy1fUmE7819erGCman/2OjlPlY7PmnyxQ5evdAWDlytUF9NnkPqlgV3INBleC+NOzSkVs+fklJOvCLdiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724447727; c=relaxed/simple;
	bh=19Yqr6W22Lb+nvGIKr8/DROhDq7Zq1CHC34Zq5OrXug=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m8aL1cwwIaskQjA1LioXV2dpnLR+X3gPj705m+IyS28vK11BhBp30mjmM389qc1omJLUnUcvZFqJ0YDDyYvxsjuKBCwiN/dSgt0X3OhovTwKcqQaXDKddFzaomTnLmHnkJpjK6NoDShZwgamltyId4bx2J+TIxAoU/xnYu3lSwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=h0KrUkAE; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-e0b7efa1c1bso2400727276.3
        for <linux-btrfs@vger.kernel.org>; Fri, 23 Aug 2024 14:15:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1724447724; x=1725052524; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Gi+GBk0V0rBcUQPo7AU1pZEz+s/atBLn1ZFAE3KtYfY=;
        b=h0KrUkAEk6uDiOfvyJdjjFG7dyBbVBebzAF2fa8fvB7AJbFjY82PL/ecngwrzhR3sw
         BjUYCOG7IrGWYaO46aCd07OdocWt1Rkoe0N2GJOpNMOudmt7HTJ/xMZy6Tbx4XjjCztO
         roR4zHeXjswibDaGCmO195WAiEt3Lo650EhJw9fgZLKPAuG1KIsxZ9bmUlm+5DBiTAqc
         wCc/DFkP1kPtD0SCjIQP/sxQj0kpkS0xDa3Lof757qJs4iAA/SV4Nr9peezrWAVEPZGt
         ba6IUpMSJfpD8iqLqT6kpL25ZCm/7h44+B64dfzUddRpJIQgu7B24aHBytSeDnto8BG4
         ILfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724447724; x=1725052524;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gi+GBk0V0rBcUQPo7AU1pZEz+s/atBLn1ZFAE3KtYfY=;
        b=pmRNdQKfxrpUeQK3cOwPPAo/7x+x2/Wpulsg1mLFR5EZzsrx1whpv+MaF3Iroi9qrk
         DskOQBsLNyz67mLTn0YEIiGxvqCgJrwiyYRNswNlm0dxO1u8AitNWKMfqFv89DmNvCKM
         uautJnZdrRYB9bNxZHV0KvcCYnNw49eDV1FIZi/+e9pq+m9++uTgebcyQUEbzmxNWRAE
         YxgwxoVwnX4nvNXwI6WieHWEJqCIv1PgK/vC91mSOlG+mkQA3nzg4+9SO1tJGBOxc8EP
         zztEahclV0GCEiURIEGqck4Ydlh4SMFbEerW24nx+QKEJR5N0gr1NwlXLBX2h0Oburr4
         JENw==
X-Forwarded-Encrypted: i=1; AJvYcCXD5/7HhgzihJRF52PqTI6flLRDqXuTsmegl0u3Wu52BwKfdM8UjqR98Rwna32xXAinTOfH34JxqYF8Dg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxyDizmvMTr+6cE7aFf3QWZcERVYCTI/xMGggcEw1Yqlj/uoE0Z
	muw7bUgXwonMqub083O+pxDXfiNzkVrwKRxsRS3m8VAUpU3h5saC1jX9xws91X0=
X-Google-Smtp-Source: AGHT+IE3KtCby39IHktlYafbomlwtEyUUr/AIpkQ2sYkPsbADMRf6kyiWjTwgrV/3qLf8qmowosXDg==
X-Received: by 2002:a05:6902:230d:b0:e11:82fb:70c with SMTP id 3f1490d57ef6-e17a868246emr3830292276.51.1724447724327;
        Fri, 23 Aug 2024 14:15:24 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e178e4b365csm834285276.27.2024.08.23.14.15.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2024 14:15:23 -0700 (PDT)
Date: Fri, 23 Aug 2024 17:15:22 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: Li Zetao <lizetao1@huawei.com>
Cc: willy@infradead.org, linux-f2fs-devel@lists.sourceforge.net, clm@fb.com,
	terrelln@fb.com, dsterba@suse.com, linux-btrfs@vger.kernel.org
Subject: Re: [f2fs-dev] [PATCH -next 00/14] btrfs: Cleaned up folio->page
 conversion
Message-ID: <20240823211522.GA2305223@perftesting>
References: <20240822013714.3278193-1-lizetao1@huawei.com>
 <20240823195051.GD2237731@perftesting>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240823195051.GD2237731@perftesting>

On Fri, Aug 23, 2024 at 03:50:51PM -0400, Josef Bacik wrote:
> On Thu, Aug 22, 2024 at 09:37:00AM +0800, Li Zetao wrote:
> > Hi all,
> > 
> > In btrfs, because there are some interfaces that do not use folio,
> > there is page-folio-page mutual conversion. This patch set should
> > clean up folio-page conversion as much as possible and use folio
> > directly to reduce invalid conversions.
> > 
> > This patch set starts with the rectification of function parameters,
> > using folio as parameters directly. And some of those functions have
> > already been converted to folio internally, so this part has little
> > impact. 
> > 
> > I have tested with fsstress more than 10 hours, and no problems were
> > found. For the convenience of reviewing, I try my best to only modify
> > a single interface in each patch.
> > 
> > Josef also worked on converting pages to folios, and this patch set was
> > inspired by him:
> > https://lore.kernel.org/all/cover.1722022376.git.josef@toxicpanda.com/
> > 
> 
> This looks good, I'm running it through the CI.  If that comes out clean then
> I'll put my reviewed-by on it and push it to our for-next branch.  The CI run
> can be seen here
> 
> https://github.com/btrfs/linux/actions/runs/10531503734
> 

Looks like the compression stuff panic'ed, the run has to finish before it
collects the dmesg so IDK where it failed yet, but I'd go over the compression
stuff again to see if you can spot it.  When the whole run finishes there will
be test artifacts you can get to.  If you don't have permissions (I honestly
don't know how the artifacts permission stuff works) then no worries, I'll grab
it in the morning and send you the test and dmesg of what fell over.  Thanks,

Josef

