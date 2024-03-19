Return-Path: <linux-btrfs+bounces-3433-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52AF488039D
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Mar 2024 18:39:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84B081C22A85
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Mar 2024 17:39:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C65752033E;
	Tue, 19 Mar 2024 17:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="H9zwPQQb"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1558919BDC
	for <linux-btrfs@vger.kernel.org>; Tue, 19 Mar 2024 17:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710869930; cv=none; b=Y6vKj0hQ92nZby2cNo7c2T3Woz82471EIFqWS06WQ2UBS6vy6AjNhUSMKUMbyXjZoqoTtF9JWaO3t4VX7A9CudUYoGTL967LvaeWMx/6KV2pWfwzGYZKN+dMmPKqI27rK4DA0TO4OCi+LblYkmTZtMBTjKkUK8FEL8MPVLcPJ50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710869930; c=relaxed/simple;
	bh=t/f5hO4Ods5x1ISfTIey3m+HRaw2T6BgIk/2b+JSmI8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kIWfyhN9Nn4/wE4fPoyY75MnQw2Jv0Rwj/WAXWvtonPvNMNDJ59LGJeIbK1kjGG1v0cgxiNPKEByzdLwhLkkOs9lQK51FQ/s82DL8Nucf0MU5EyNAOet75+KPV4uagbcKY0RlPwmAZco6WU5vZlXL+GGrGUTaJVzMNr4d9puEos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=H9zwPQQb; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-607c5679842so61625767b3.2
        for <linux-btrfs@vger.kernel.org>; Tue, 19 Mar 2024 10:38:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1710869928; x=1711474728; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hr7Ru1qv6sZdy/EO578FLOKmg6GaZz+1W9NjYNGbXa4=;
        b=H9zwPQQbhk317DJU8QxIkvpSADGLoAqXcWwpjr2wvfl++ANjZOVlOZuRT4zHcAwPGg
         nV7puDccqdlfhU4dcD0xXdkJp0OzOhEYerfnXBRFt/fQfHTrro+Y7qPvE3ZGjGeQ+RA0
         DRIopJq6pC7hZuj59tPuOlDPABAlcYW87uCDGGFRuSGQzwfkvIaPDH/H9LI9x2EsLFqw
         GX1WS7mVAz31YnRNnEr4Vrjyj7xKj6Y5ftfRwWq2jujPRNuQaT8z6R6rGfxXNNxJuoSd
         LjPmzvopN5zRJAWMiixI7vsAiRv8k8o5H5ERplKmN9rtx6lGRvW/ifjvULMuJSnlzI2d
         LB1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710869928; x=1711474728;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hr7Ru1qv6sZdy/EO578FLOKmg6GaZz+1W9NjYNGbXa4=;
        b=sRt5MteD2O4TdFFFwf2puthrfgl+mZKMLlSXECmd5w0eQ5rRZD6Z8J2l9wKFJlkbkB
         1MJVxBbY/rtmckS+RI5mchDjcEDBy1dLsru8dT4L7GjsXwYUYy3jGxhmyR/4TmmzyqHH
         YqTTxob1s+b9syK1CJBWYbbQzx2JD4mRecq4RTYBpVsQMrVublmFkVmAUG9g0Ih4oCEK
         UlvYkHFEoccWBQlgq4jNKl2KS0/6LUFvpWUZ08eXEomoSn0J0lm7OJBcrOby3I6Hzgui
         2oV0UFk2CjepSKKUxC5tdEkWCTvAgyijPh3KossWiI+vs9akv7OmEZt5I9/e7NKVEnJr
         1BHQ==
X-Gm-Message-State: AOJu0YzMK8T4xMA67hUzwgNm+E4ncw0w92gRGcSjtTJ9oI0tSJjWwO0L
	0M+E9JhbgSQ580HAQ1/j+fSFWa3c6/LV1tTTdRtJRcU3IZOLuwnt61qV2OWDLVTtBW2zJ3fE3JQ
	K
X-Google-Smtp-Source: AGHT+IF0mzGjqicuiHMcnI5sbgMfCychBVQqT0G+7oOIwW2GhRj9BngreFhpGzegeb8mQEoE3GTxFQ==
X-Received: by 2002:a05:6902:512:b0:dcb:aa26:50f9 with SMTP id x18-20020a056902051200b00dcbaa2650f9mr12257615ybs.46.1710869928075;
        Tue, 19 Mar 2024 10:38:48 -0700 (PDT)
Received: from localhost (076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id k20-20020ac86054000000b0042f43a486c9sm6085431qtm.77.2024.03.19.10.38.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Mar 2024 10:38:47 -0700 (PDT)
Date: Tue, 19 Mar 2024 13:38:47 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: Anand Jain <anand.jain@oracle.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 01/29] btrfs: btrfs_cleanup_fs_roots rename ret to ret2
 and err to ret
Message-ID: <20240319173847.GA2982591@perftesting>
References: <cover.1710857863.git.anand.jain@oracle.com>
 <b1eaaa193879d4ae920a76dfa3bc5f2e6c7f8a4d.1710857863.git.anand.jain@oracle.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b1eaaa193879d4ae920a76dfa3bc5f2e6c7f8a4d.1710857863.git.anand.jain@oracle.com>

On Tue, Mar 19, 2024 at 08:25:09PM +0530, Anand Jain wrote:
> Since err represents the function return value, rename it as ret,
> and rename the original ret, which serves as a helper return value,
> to ret2.
> 

I hate to be that guy right out the gate, but since we're just using ret2 as the
return value of radix_tree_gang_lookup, and that's just the number of fs_roots,
lets instead a variation of

unsigned int nr_found = 0;
unsigned int nr = 0;
unsigned int found = 0;

since we know this isn't just a temporary ret value, it actually corresponds to
something.  Thanks,

Josef

