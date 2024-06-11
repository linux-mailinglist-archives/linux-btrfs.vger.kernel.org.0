Return-Path: <linux-btrfs+bounces-5658-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B85CC904184
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Jun 2024 18:43:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B93E21C2296C
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Jun 2024 16:43:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E1084084C;
	Tue, 11 Jun 2024 16:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="Uvd0tQn2"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 821CB1CFA9
	for <linux-btrfs@vger.kernel.org>; Tue, 11 Jun 2024 16:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718124192; cv=none; b=dZLdnBMFbuR6gc2w5S46vANic4igw+AqYl2xeX98DmUvnoA4VNKWxUt/2yQGVCx1sI2McLZPDTOPYK/thZQNdXeFKS5yNfocrifsjD4l4Dn2eMJRpGxyDQoVWPzVCezX11qpn8c2cWrha60UgUdc8GO9QkkXArUJONv93s6kV+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718124192; c=relaxed/simple;
	bh=tMkXNzAjK9Hye703E/hnEoJtKeVOG3oxEA2FaCCFzxE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h6//zcX/Y3fWj9lFL0of2URGDR1PRuROKCkvD1X8EnTk2OC+7r/rgPWoZBesik5lOg2caJA+W3HFUTBwDtq4UAqvCExzGPCozh2aEgfcIeve91WCJUMowrVMwzwy57uRFa7foMW+LYFBE/NRgZqOj+HkVRkXSpgqNmXlit7MQlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=Uvd0tQn2; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-62a0849f5a8so58323717b3.2
        for <linux-btrfs@vger.kernel.org>; Tue, 11 Jun 2024 09:43:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1718124189; x=1718728989; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IXGNL8jj6wdRW7QHJC0YjVu1Re5WwhnR5MPNpyTYf98=;
        b=Uvd0tQn2Plq2bdZ93wqM+wdCl8HWY3WPUi/rzNZjeqvTlyG4T+SCVuVkALSkOTrSWa
         8R8E+PBvCPJTTHsc4U0WJjZAUYvvdWfs9Ok8LflUpq/5z6uNreCq41ageGaBHjVDYaZt
         2uPyT7OAU8+4B/kBj9ZTJFTwgzbehkhFMDNUZULsjch1CpUvtc6k+KjKBa0t+uD+ZH13
         cQbmLkxXnYVmN+RNeCTRzKSl/w7A0v5wqGw6Cs38441VgWRUD+pJv0OJOqe6P+eR0d0z
         200Pa5Ry20M2Fo6w9anpHcgT7tNwiKg+dR/iaYVJ/2MlmP4cumcIHi5U5vGxizylbgQM
         UwzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718124189; x=1718728989;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IXGNL8jj6wdRW7QHJC0YjVu1Re5WwhnR5MPNpyTYf98=;
        b=EUDWUFMEksFeOtK2B32fPK3x3u9DheDcFMNU5gPxrNxJQpO+RpPq6GiUFpsxbtzEb+
         /qC6ZTGDS3DyKGnJmKIw/bOEfiDVpkKTpIlJM8IvF2ObP7hcG4PFZaQP3aMz6WWGgARv
         DffPvoG5Wr5Ru+SQJEz6TzdK7fUODtq6iVKn/Dku/OSCRnX/1RLdnhtcBr7njVgCIdDB
         XZ7aBNpqZqRM+jpA48AfToAhe0ZfL319ig8ILgRLa4T4EcPX3tdWCCdpECGuu+pFHjf2
         QD2na6zvp0yZIVSjrTNeUE5pchvTL4Kdtz/jw2iNolcF6aD5TXVtPT7qDlELrkGmZDck
         S5fg==
X-Gm-Message-State: AOJu0YwrEWD2aDi980gcOa0zu09J4cNKffy1W16mkPJSlRe3mdPtHO2A
	rOQJsgwazHN3wy3+ZsGZgEma3RaP1iF2SSNzhK15ogJqeWbpdBsKc6WNVM1Apo0=
X-Google-Smtp-Source: AGHT+IGGX4MXrIOZWeYd9xs+ljsBZAlcF8mHqb63RwU5i2hullvSz1CxHV8tJwhEa0FUAO2GHgH+Yw==
X-Received: by 2002:a0d:e444:0:b0:61b:d8:c5de with SMTP id 00721157ae682-62cd55c55c3mr117808697b3.19.1718124189255;
        Tue, 11 Jun 2024 09:43:09 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-62cf576fb1csm12444247b3.128.2024.06.11.09.43.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jun 2024 09:43:08 -0700 (PDT)
Date: Tue, 11 Jun 2024 12:43:08 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/4] btrfs: rescue= mount options enhancement to support
 interrupted csum conversion
Message-ID: <20240611164308.GA247672@perftesting>
References: <cover.1718082585.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1718082585.git.wqu@suse.com>

On Tue, Jun 11, 2024 at 02:51:34PM +0930, Qu Wenruo wrote:
> [REPO]
> https://github.com/adam900710/linux/tree/rescue_changes
> 
> [BACKGROUND]
> There is an adventurous user using btrfstune to convert a 32T btrfs
> from crc32c to xxhash.
> 
> However for such huge fs, it takes too long time and the reporter
> canceled the conversion.
> 
> This makes the reporter unable to mount the fs at all.
> 
> [CAUSE]
> First of all, for a half converted fs, we will never allow RW mount, so
> everything must be done in rescue mode.
> 
> There are several different stages of csum conversion, and at different
> stage it requires different handling from kernel:
> 
> - Generationg new data csums
>   At this stage only the super flags (CHANGING_DATA_CSUM flag) is
>   preventing the kernel from mounting.
> 
>   Intrdoce "rescue=ignoresuperflags" to address this.
> 
> - Deleting old data cums
>   The same super flags problem, with possible missing data csums.
> 
>   Despite the new "rescue=ignoresuperflags", end users will also need
>   the existing "rescue=ignoredatacsums" mount option.
> 
> - Renaming the objectid of new data cums
>   The new csums' objectid will be changed to the regular one.
> 
>   During this we can hit data csum mismatch.
>   So the same "rescue=ignoresuperflags:ignoredatacsums" can handle it
>   already.
> 
> - Rewriting metadata csums
>   This part is done in-place (no COW), with a new super flags
>   (CHANGING_META_CSUM).
> 
>   So here introduce a new "rescue=ignoremetacsums" to ignore the
>   metadata checksum verification (and rely on the remaining sanity
>   checks like tree-checkers).
> 
> The first 2 patches are just small cleanups, meanwhile the last two are
> the new "rescue=" mount options to handle interrupted csum change.
> 
> Qu Wenruo (4):
>   btrfs: remove unused Opt enums
>   btrfs: output the unrecognized super flags as hex
>   btrfs: introduce new "rescue=ignoremetacsums" mount option
>   btrfs: introduce new "rescue=ignoresuperflags" mount option
> 

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Could you update the docs in btrfs-progs/wherever we're keeping the readthedocs
stuff so that these new flags are documented?  Thanks,

Josef

