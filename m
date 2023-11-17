Return-Path: <linux-btrfs+bounces-169-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 23C0D7EF7AE
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Nov 2023 20:08:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB693281303
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Nov 2023 19:08:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FF1A43AAB;
	Fri, 17 Nov 2023 19:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="xoDiHc4m"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCF35CE
	for <linux-btrfs@vger.kernel.org>; Fri, 17 Nov 2023 11:08:10 -0800 (PST)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-5c85e8fdd2dso9769647b3.2
        for <linux-btrfs@vger.kernel.org>; Fri, 17 Nov 2023 11:08:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1700248090; x=1700852890; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=naEDjPKqD+RM/QbLCu0hYTGsY+tCSuuq3neRV09hx54=;
        b=xoDiHc4mrKRkkejKOuPCZcmYCy1zCCWafW2HNrXS46Gg2kEQJGUG2bosehXfT/Vdiv
         /8Alh72Rx0SXmqNnXelHRdTy0E2IkJIBwIV3NgHJst4opBqy4KEUCba72C/qu8JVUrd7
         4oNTkyWYa4Dm3F9E1DL83aoEkhQztnyiLAvfawDOcE/4L60VJrflBePGwx2U+dOJbPL1
         e8lqC/WEg9psERNBb76SIOwRjNS4a/ueqfglJtxb0EM5IVNbi8XtwE230kkBEdNp8T8Y
         uAC5EAO7qw5wbN8wt9bG2wGWTWRcpI7/n/35hx2b1+mEcemFv/WqsE+qLSEbqTzDr8J+
         o4Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700248090; x=1700852890;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=naEDjPKqD+RM/QbLCu0hYTGsY+tCSuuq3neRV09hx54=;
        b=U1NhQ7j0UthkYJ+Y5PwqrEt3/d8I7CIkrmy/w7e5QIyDVxUTDHjHLi2ik1wPnXAc6p
         Nd4rDaAk+IQWS31Qq0bHJ1chAJptXpHvq/ExMadoGrF3xZswFicbpNeM/eqGOlrnthP1
         puDxYL5ze5vkj166suay87BJOHy2USuzjZNDFLdiCxZzVY+eg04SEPABiQDpweezxMCX
         EbyR5eXAUPq6NMW76M12uD159Vz00lgtAuh5x+kPGmg/HWcvNRTpnxU8QN75YIKqBFk/
         ni3DcmLGp1rf4NI/GpWiMRVtl3lNNB6KKTKTiCww6Wyymnhwuutm3Gb2mQ1YlyxMIO6u
         /30Q==
X-Gm-Message-State: AOJu0Yxe5xMURpY7f+JJpnhHkv52Ac3apBZ6Ro8LkaOHp4wg51J6GS69
	hMp1+BpDa0tMvwrhshLiaCclUvrrlh88xYL0+PC0uSR9
X-Google-Smtp-Source: AGHT+IGsmnbsgqTF6zyg9o3fGs8gZQRtL+wKR8Z0RT/8FTz5QWOt4v5VdsVELWidtLfRMZVU8/OOKg==
X-Received: by 2002:a81:470a:0:b0:5a8:e6f4:4b6c with SMTP id u10-20020a81470a000000b005a8e6f44b6cmr541654ywa.25.1700248090071;
        Fri, 17 Nov 2023 11:08:10 -0800 (PST)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id s184-20020a0de9c1000000b00565271801b6sm640770ywe.59.2023.11.17.11.08.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Nov 2023 11:08:09 -0800 (PST)
Date: Fri, 17 Nov 2023 14:08:07 -0500
From: Josef Bacik <josef@toxicpanda.com>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: migrate to use folio private instead of page
 private
Message-ID: <20231117190807.GA1513185@perftesting>
References: <b4097d7c5a887a0e9d8bdedd9cd112aadb716d58.1700193251.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b4097d7c5a887a0e9d8bdedd9cd112aadb716d58.1700193251.git.wqu@suse.com>

On Fri, Nov 17, 2023 at 02:24:14PM +1030, Qu Wenruo wrote:
> As a cleanup and preparation for future folio migration, this patch
> would replace all page->private to folio version.
> This includes:
> 
> - PagePrivate()
>   -> folio_test_private()
> 
> - page->private
>   -> folio_get_private()
> 
> - attach_page_private()
>   -> folio_attach_private()
> 
> - detach_page_private()
>   -> folio_detach_private()
> 
> Since we're here, also remove the forced cast on page->private, since
> it's (void *) already, we don't really need to do the cast.
> 
> For now even if we missed some call sites, it won't cause any problem
> yet, as we're only using order 0 folio (single page), thus all those
> folio/page flags should be synced.
> 
> But for the future conversion to utilize higher order folio, the page
> <-> folio flag sync is no longer guaranteed, thus we have to migrate to
> utilize folio flags.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef

