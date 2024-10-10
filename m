Return-Path: <linux-btrfs+bounces-8793-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E28EA998A9C
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Oct 2024 16:58:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A97DF28A7B9
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Oct 2024 14:58:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB37B1F12E1;
	Thu, 10 Oct 2024 14:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="yd0bvUIA"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DA3D1EF95D
	for <linux-btrfs@vger.kernel.org>; Thu, 10 Oct 2024 14:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728571711; cv=none; b=TdkG90TyLkJgdewg5o1xeittW3oOv7h/WCsHl0ZluWPj1Dz/4ONpjSuoRGQICXsE598QAW9COAt7+DjLjoQX5M0iqocQBqC7P57SMrSNSmwhFCLPhYnpnstXNuhkxpvWtZ2dsBQeDmLX7ewg19qDIrBq9IhOjIXoP4EV7zB5dpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728571711; c=relaxed/simple;
	bh=WtcqMvAJ2Yicn3RbagkjlfH69i2113gLY6P62lqKVI4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l27SE6UWbLIdLZWf8dLqNKXtF42c2bOI0cDtE8QhcpoLJFRgb68NPwOxWqHQWRNjl4WmCSXfX19QYFiFBA/jm1lBIFtVO4CmQMT+7GQTfV7zWUA9HXHTDckfcDa9Uu0izy7K76J3ZhmA033MzkCISkG/au9L98hS7VYs6whKG1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=yd0bvUIA; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-71549d19983so624220a34.0
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Oct 2024 07:48:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1728571709; x=1729176509; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cb9ZzYELvl8lqeEM9x/PhJlsPHEZcbyHcKgmoOtKfN8=;
        b=yd0bvUIAwajbB8VszD0YpPTlwdJsZ6B7MjJuTY2tdFetz75JSYrGqKO39zhZ0ccyhQ
         4tQomtHzmvYc28lHscCIlDY740rayoUqOdFgdYoLJbKroX70TS0wm8CYc29KgtdwwPtL
         J+j9pG6jRt2bMDL7b2PKJB8uAk9J5pSgyQOW/+SnX7hL0v7rf9FOnk5nL1uA77lMJUaf
         b0BgazqtqqRjrKwSu9EsQ1LqPSYQouWiQPVMj9E9yeIcAnzyCHw/rRT9maczKLfD2TVB
         u3obPHPULERz+75xBxho/QJfCNrb6pCa3AbTqvqkjc1yRzHrjUY0Fj2Q0HYtcWWKtcr/
         VKPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728571709; x=1729176509;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cb9ZzYELvl8lqeEM9x/PhJlsPHEZcbyHcKgmoOtKfN8=;
        b=XcKcmtnRF+dPKNNeqtX0a0ZC5DD4j6rMta3jC69/Ts+4A6YRxotWJDPQLW3w0KXURm
         ovADhEaCZI9xkh5txXsLSJH2PI16N/4dVYlye33iDooLcM4b4sDXVKWob4NybPb/hwAt
         +tUwH2ZB5aYhtWisoG5mjnTHZRs+qpfPrqcOURDC6dIxYr6R3rlvxH5vXtMr5v8yfbq5
         QoLUxgoaeD4QLYMfJrD8CX623/AT+K0QWrk7sUUBUdNcbbgqjjXzEwqfyPrlyrps2ECL
         oonqmMHwJKmaVgEmGGbJrCRmqTvupJsiVQVhPvn2O3VId7W4wQ/SIcUmy/JjjJumT6Lm
         OJzA==
X-Gm-Message-State: AOJu0Yx2JvQMSOvrH/SmVxfiGifoyhBl/P70D0U4n57VE3G3EY/68f3f
	V4x2IextdNAOZjeAW5f+D9p18WmNs7Nk/qJ6BN8fUo31zJ/90w1IjxR2GNYYIeA3WyvkC4L4uST
	QTH0=
X-Google-Smtp-Source: AGHT+IH83qHYA5qC96+sax1lLiOMsmgeuxkAsA5vuhambPlNaIOgTK9n/yAyzrB1diWiWWLrkaHS+w==
X-Received: by 2002:a05:6358:60c3:b0:1aa:c492:1d34 with SMTP id e5c5f4694b2df-1c3081e723amr289965855d.23.1728571708943;
        Thu, 10 Oct 2024 07:48:28 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-46049606cadsm635851cf.95.2024.10.10.07.48.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 07:48:27 -0700 (PDT)
Date: Thu, 10 Oct 2024 10:48:26 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: fdmanana@kernel.org
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/5] btrfs: make extent map shrinker more efficient and
 re-enable it
Message-ID: <20241010144826.GA10456@fedora>
References: <cover.1727174151.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1727174151.git.fdmanana@suse.com>

On Tue, Sep 24, 2024 at 11:45:40AM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> This makes the extent map shrinker run by a single task and asynchronously
> in a work queue, re-enables it by default and some cleanups. More details
> in the changelogs of each patch.
> 
> Filipe Manana (5):
>   btrfs: add and use helper to remove extent map from its inode's tree
>   btrfs: make the extent map shrinker run asynchronously as a work queue job
>   btrfs: simplify tracking progress for the extent map shrinker
>   btrfs: rename extent map shrinker members from struct btrfs_fs_info
>   btrfs: re-enable the extent map shrinker
> 

I think as a first step this is good.

I am concerned that async shrinking under heavy memory pressure will
lead to spurious OOM's because we're never waiting for the async
shrinker to do work.  I think that a next step would be to investigate
that possibility, and possibly use the nr_to_scan or some other
mechanism to figure out that we're getting called multiple times and
then wait for the shrinker to make progress.  This will keep the VM from
deciding we aren't making progress and OOM'ing.

That being said this series looks good to me, you can add

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

to the whole thing.  Thanks,

Josef

