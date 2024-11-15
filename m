Return-Path: <linux-btrfs+bounces-9731-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1349F9CF121
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Nov 2024 17:10:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6F482942A1
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Nov 2024 16:10:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC7841D5AC3;
	Fri, 15 Nov 2024 16:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="Db6Sg31H"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3993E1D5AA7
	for <linux-btrfs@vger.kernel.org>; Fri, 15 Nov 2024 16:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731687018; cv=none; b=lsfvvrgRvsGIo4Zot3rzD99j6Jn/GbE8UDwV3gGQ48O9r2rd5ukwyXBNfF8/6nselI/izmHSbPXEVJFIGmtTOknAC/sSfr6RtasMTW8DoZwKDp++yAob40gGmfs7WK4ZvO9/iQTsBOxM0Ul4ixgrd7YCaMqc04+Cihm95zePNGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731687018; c=relaxed/simple;
	bh=A23ADq9VhLRuKtxkzI3iC6LciSx2SmdP+Hkh1qUIl3E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sQCIkBQxtlO06yhzgLFgsGPRi+OApWMWVK9schLzhg82N6SBG+fjAWfQ5cOxL1Foli8NquZGHMr7jhJLmLXQkEOuF4z4VdkExxRM3rBQ+935C035rCgy/lzQ3+hjnzKCekTuBaMXVP3xjpK7g8FCnbx+bqW/YhIiBozvM5UJQQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=Db6Sg31H; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-20cdb889222so9339115ad.3
        for <linux-btrfs@vger.kernel.org>; Fri, 15 Nov 2024 08:10:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1731687016; x=1732291816; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vIliXs8Cw96q54nPVa9sq0YyAsqvVeK21ZbaBTbN3vc=;
        b=Db6Sg31HoRyZGrH/XKlDkMrTVdiwye9VxTiskHtSoHo6EW3RU4oPoZiTnUANO6fGby
         gkyNj9fXPEOjwor5opf9Q8AzgIvEVC+KNaKQ3yzt73dN/lEecKm3aheprsGAdZw2i1i5
         4DhbpmnwXKbMP31ZQCMqMrXY5aL/Un7vOSVt7pIgd4Fbi5PEGf1hQDuPc2jXfOaEvDyy
         qzFMADGASGJyQRTsAcMQCEA2Wxd45S2+BfNSfdqec1Du3eYipYguI8p/hf6c3IpDDU9K
         iLSlQRu6cwA5B7bafVuAsdyvCbZfX9m7GrgbzvMZyeIRoYGGuGrfXP4Ox2W5RGZ3N+bm
         /agw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731687016; x=1732291816;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vIliXs8Cw96q54nPVa9sq0YyAsqvVeK21ZbaBTbN3vc=;
        b=Yph66AYdPAnIOm53kCxvL2Vfv4oKxPexXEGr7Nz+THkTQBUkNtLLUoVAdiS9mxZ0pd
         Ixw2CwqteqL1uP8Gf4qd108qqLWWAs3iborul1Itb8yU/TI9XJFCIeiKp8EAy2O95dve
         jdvu2UnUPytIVJZsaiNgljKDw42hrZWJjJOzGQM+yHprmArljCLctx8UZ+OdKVmenvNJ
         oPLWAOqTf8xLhcH31aeK65MZCwij8Uw0U7t6L4p5Z7s7y5RKgihQKqLq7L8AzBuQQmAD
         OtCycSOY8ZBL/xVaW/TiDdX4NKaeUjKEKvwVnMSkcB0/mRECHs5iK0kbUt0kirKqU71F
         Sj4w==
X-Gm-Message-State: AOJu0YzSRjPAhiko/zdgv/VA0YHRnfVDR4xVQPUx83M4OQ49sYjEMbew
	j+HtZLDqJTs5Z88M7kZGAZchRz1Q8FodXd5VWmFhrRS2QV5KkgOJb4TGErgaGwq8fBpf8+nJf/t
	p
X-Google-Smtp-Source: AGHT+IHUSTpIUUBtfXI7lcWdcdkq7+WnEuerwAwREXc6ZIRpCHaXDcI8J5NkWEPAaH86DZeDaY5xqw==
X-Received: by 2002:a05:6902:2b0d:b0:e2b:df1a:c012 with SMTP id 3f1490d57ef6-e382639f2cbmr2965265276.34.1731687005272;
        Fri, 15 Nov 2024 08:10:05 -0800 (PST)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e38152f11e9sm980107276.27.2024.11.15.08.10.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2024 08:10:04 -0800 (PST)
Date: Fri, 15 Nov 2024 11:10:03 -0500
From: Josef Bacik <josef@toxicpanda.com>
To: fdmanana@kernel.org
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: dont loop for nowait writes when checking for
 cross references
Message-ID: <20241115161003.GA1681877@perftesting>
References: <82b293d9026f9ff3670a4c0ea4df9bf4afa8f4d2.1731685895.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <82b293d9026f9ff3670a4c0ea4df9bf4afa8f4d2.1731685895.git.fdmanana@suse.com>

On Fri, Nov 15, 2024 at 03:52:38PM +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> When checking for delayed refs when verifying if there are cross
> references for a data extent, we stop if the path has nowait set and we
> can't try lock the delayed ref head's mutex, returning -EAGAIN with the
> goal of making a write fallback to a blocking context. However we ignore
> the -EAGAIN at btrfs_cross_ref_exist() when check_delayed_ref() returns
> it, and keep looping instead of immediately returning the -EGAIN to the
> caller.
> 
> Fix this by not looping if we get -EAGAIN and we have a nowait path.
> 
> Fixes: 26ce91144631 ("btrfs: make can_nocow_extent nowait compatible")
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef

