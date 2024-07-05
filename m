Return-Path: <linux-btrfs+bounces-6226-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAEB0928B04
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Jul 2024 16:55:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4BBD9B22BC2
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Jul 2024 14:55:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0012D16A954;
	Fri,  5 Jul 2024 14:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="OEjNKj/N"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 982D814A08B
	for <linux-btrfs@vger.kernel.org>; Fri,  5 Jul 2024 14:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720191349; cv=none; b=bq6S6R5nA970TPpY+cTpQoLdaViA3xz0tv2kyJTuCgkgn/49rSAxlLEvxj+oQ4K4NiYmaTxWQz23nzCmJ0ELaXmiwX2lxBA1pQCBxjeYiaKfC7Dw9L6eqdH72wL167ERnHcNQxMdmKRSk0O2jjBRbYKsCDE1I86EP4MMIIanEIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720191349; c=relaxed/simple;
	bh=B/A6DpzSQzsx9/l4fsa+9q9oA5O1gtlTmy1LV9la+I8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QLIdDmkq8b48KLPuRCAMb1WqifKaWlsj1E8kUj12ax4Oz3lZ5HSIFACEI6fEtW5rqbOU6lkjCxTTUUokKtRvApZezcqKAOw/mrD05h14eIqtyhTeH++B0GyUAp9+kGSAgCV75aaQuY9w+vVIQYT11TRZ9fHO4f4Gpxy49NrCmNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=OEjNKj/N; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3d8a935badcso902090b6e.1
        for <linux-btrfs@vger.kernel.org>; Fri, 05 Jul 2024 07:55:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1720191347; x=1720796147; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OW8z0cxg2uXcsMzQWDgYf24OAPRDrrp2T04lKwD1p3s=;
        b=OEjNKj/NeAgYsJCptuDwi2enrIgBM4D6eWWX88H395uNOZioH25SDcEeSaMFymbluw
         TWcFCG86fy/Fqdk5/2gpHcYD87uerjzXpeWtZ1g45QSKbE9s88K4yvobvhGvwkNgl80M
         wIKlgrd3UTIHS2Tewd5sWnVHlPHW9qT2WR54+nOROgmRtZbwcAFe3RPY9P0iGo1z48IW
         b4+/pSIr61MvnUQrZHFCqLo6RhIwbW9ECH/1gdanCNucX1A2rznJyo5QMQ+nvYzZEIA8
         dXxEJuqt1XMqQyqyyrHdAoe/+GqiaGJ7zUoFfJTdW4EQvJesrHV4dVku6UGoGVTsFi3h
         z+NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720191347; x=1720796147;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OW8z0cxg2uXcsMzQWDgYf24OAPRDrrp2T04lKwD1p3s=;
        b=GCV647EJZvUPsdR+k8HicbTHMrZGLdWgRi5LBW0m6wS/XFpUU+7bgAQ9rf0UQIB+Bh
         dtB+wJZ0uWP4blGLmbaod4FjLanti2kg8H55duKViOzJj4SBw9OXXL5HpgTM/oQfLGYO
         Hf/N+6INAvWMVqDQyd2Vw5zYuMiPFbrQKJ/8YlgjzsGt8ZZkWuSpGoas8ggAZYiRxEgb
         SKvJbdiyWGoaQQn4S7aHPPF+OAR7EekXg6Pk8iBMICUrpElnvaFfG0mKSCJCyLW7EzPp
         Aqnc5OCO+eMMW7Vqo6ZzT2zp8McXN9Je3T+3xrQ+Aorx2gc68mJxhVAXaD11JFpZLH1T
         NgbQ==
X-Gm-Message-State: AOJu0YxnlTmrTMwUL85iVaKgdF+m4xX3fNFdDwcmya1TvQdvUk1Y2BNc
	uYQBKejxjm4/hGfGBuVgeP7s4i0UuV6I9SdJ4ycRNPHftIAO5zEbo/RbLBbxWxg639DICAJAlXp
	J
X-Google-Smtp-Source: AGHT+IFha+LVTaxfzJltso83BIgnhBUhZPtFjHz501RexXOG1xv8uKO95ZlcxQ78v7X2pJanMv3TrA==
X-Received: by 2002:a05:6808:3c92:b0:3d9:22df:8e0d with SMTP id 5614622812f47-3d922df8f46mr292922b6e.18.1720191345184;
        Fri, 05 Jul 2024 07:55:45 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79d69260004sm780735485a.27.2024.07.05.07.55.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jul 2024 07:55:44 -0700 (PDT)
Date: Fri, 5 Jul 2024 10:55:43 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/3] btrfs: remove __GFP_NOFAIL usage for debug builds
Message-ID: <20240705145543.GB879955@perftesting>
References: <cover.1720159494.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1720159494.git.wqu@suse.com>

On Fri, Jul 05, 2024 at 03:45:37PM +0930, Qu Wenruo wrote:
> This patchset removes all __GFP_NOFAIL flags usage inside btrfs for
> DEBUG builds.
> 
> There are 3 call sites utilizing __GFP_NOFAIL:
> 
> - __alloc_extent_buffer()
>   It's for the extent_buffer structure allocation.
>   All callers are already handling the errors.
> 
> - attach_eb_folio_to_filemap()
>   It's for the filemap_add_folio() call, the flag is also passed to mem
>   cgroup, which I suspect is not handling larger folio and __GFP_NOFAIL
>   correctly, as I'm hitting soft lockups when testing larger folios
> 
>   New error handling is added.
> 
> - btrfs_alloc_folio_array()
>   This is for page allocation for extent buffers.
>   All callers are already handling the errors.
> 
> Furthermore, to enable more testing while not affecting end users, the
> change is only implemented for DEBUG builds.
> 
> Qu Wenruo (3):
>   btrfs: do not use __GFP_NOFAIL flag for __alloc_extent_buffer()
>   btrfs: do not use __GFP_NOFAIL flag for attach_eb_folio_to_filemap()
>   btrfs: do not use __GFP_NOFAIL flag for btrfs_alloc_folio_array()

The reason I want to leave NOFAIL is because in a cgroup memory constrained
environment we could get an errant ENOMEM on some sort of metadata operation,
which then gets turned into an aborted transaction.  I don't want a memory
constrained cgroup flipping the whole file system read only because it got an
ENOMEM in a place where we have no choice but to abort the transaction.

If we could eliminate that possibility then hooray, but that's not actually
possible, because any COW for a multi-modification case (think finish ordered
io) could result in an ENOMEM and thus a transaction abort.  We need to live
with NOFAIL for these cases.  Thanks,

Josef

