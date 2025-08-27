Return-Path: <linux-btrfs+bounces-16468-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DA5F0B38BEA
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Aug 2025 00:01:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC1D61C22C42
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Aug 2025 22:02:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 241C7212548;
	Wed, 27 Aug 2025 22:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="U/fGG2Uw"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA4241E0DE3
	for <linux-btrfs@vger.kernel.org>; Wed, 27 Aug 2025 22:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756332105; cv=none; b=PZ/eAdSyCGDWu809qvCW9kSEkjQi/OIAB/hHbnolBuxCvbm4QaOolnG+mk9wgCS1dPZZhZKDOkkGV0J+wfhZx00c3Y2TArX8UWfYKe7euRbW3vrkgsm+dOl2nW/FPEz5vMYFFu1u+rDwU76qrHarl6+MGdeFnm72E62eEXCXbeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756332105; c=relaxed/simple;
	bh=gUSbciWGHJSH/JpDm7HHHqG5lHwQEqGuzdo99M+555I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KevPHLBTDuvAAk3Hur8G6P5meLy2+1QwZ4MHngICFbLk7bwq1QH5AjzJk8MRaZlMAxcQ4h/F/bZS3R4ye9hB2eQ2/yu548QodcR4hpbJ/6mHq5FO1YWwPlKv3QipbmNmwjTSGWfofWpIxhnTHBF/HoGPHdsfxvVDkUt1Ft9jiXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=U/fGG2Uw; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-76e4fc419a9so403615b3a.0
        for <linux-btrfs@vger.kernel.org>; Wed, 27 Aug 2025 15:01:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1756332103; x=1756936903; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aRXemL1WOR90JqvB5azJ40zCxySpJVvRo7r3rLc3Ivg=;
        b=U/fGG2UwBpYBMYO3JRPSzPxBQQLKLr0DdLM7TTnaccbvJWfi7CQx2CN4svzQUN6pSz
         PAt7Y3wNatSwMR9gIUGTV+Yj9A5hPkOfb02yfajOYXdQDKs7YuEbSBcSHUDFvlJe3obg
         YMb/exqXhqfkcOaZ+/nj4dqNeVAnpZdArm1ohnNy63uEt35s8yVVhRpYFQjobY/CvRa1
         mYc1IsscPeojFxMjdD0HqtwoOBt+/BGg3176fiMm/krAuuvrxCtcD4Y1fMCcjGOk073W
         6ymLH3YXMxuWTY6ZS7vI5GxYKiiMKAEwTQ5krrCGvZUlX4syMK1VkitNEEB1xC+vWzOA
         +4/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756332103; x=1756936903;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aRXemL1WOR90JqvB5azJ40zCxySpJVvRo7r3rLc3Ivg=;
        b=WMRlFNC+lVzw9F5pq6bdVa6T1uC0+XY4HIYH4gkS4TdXE7uSolb51HCYYOp0geWHYl
         aXu0zchnL2sC30tU8rP0wro73D3NakKIzY5+YulZyt3PDZEu3LCPt1gBwiR5eHjKuQO9
         AwRmVbB7SfUhKF2vWOvP4GZft0schO940JIZ97bkNBZKHSrbcdMPd3VTPi54Skcc6FDG
         /XCueK2bAooiFF/PagBXzEq40jPMCn+W3dEkibCfrk1qhGmtuapa6WPa+rtXCYz3SfIe
         tJ/cULVErBdFkUhOO4G/AoxTZ+KYBswJm9LHfdT7LJgfKlg1qYH+uDoBMSQX7lho4WJG
         uw1Q==
X-Forwarded-Encrypted: i=1; AJvYcCW6Fb6ooPdx2rBESoD0QfepXZgqsgjazPnREGhvYWwj2ol6EmLO4zuZpV/t8s+L19yxFgo28ai9jTPUVg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzWkW3pvhoSswM4KFULgcrjijJubFBSDnPRCnmaQ8tkUqOF7+g0
	QyJ+BPS/IeCvar3ZIKnC+z4RFm9DMqu20W5sj3gI0O+8yp+7wPWVmMNf+sAIg8cKCBw=
X-Gm-Gg: ASbGncsVZSzkpxmd0GgYLwP5xTZ61GEM/8ESrUVJlEgyYu9VR8MV1FNDpZKS5N5aQkl
	DsrUb+ibfaY0yoNprbYWmSXS7rA1Skg9kcxI02nfo5O6xrRwpCtNpykliqlpFGNfhYreznQYDSv
	A9cIJusbaJNT0kBUOzddjm7TSysFMn7IgV3EBHtU3gvFfJPuroimROt9rKimWdNRS0dEJBASNIH
	LhFsgHmPpez6hYJ+suAqRJHyNnFXy0rhaPaNDeLnYOdjEbBtXkdn/350z2dLKQmqRjTcDlRAH+2
	Lo6/92TFAdllpH5PSk3+Sn7HH1dBp+7XqtN10era0f4WG0RLuumhvHkL9sL1EcYKoQEXw6iacZ5
	OVY7IYA8ABX84EgL+0misasXZ4nEu2063IJUjdNmOqH89Gr2A0zoCRQJbOZ1fBh6AdhX2kA1LLX
	6aHbQer9mJ
X-Google-Smtp-Source: AGHT+IEYVXzII1GgnlGLrms99adMC1KeEXXIyK7Szr2EAW6KvmLtHFK4fjFkfyUzwGUkKHyjR/4qEA==
X-Received: by 2002:a17:902:fd45:b0:244:214f:13a0 with SMTP id d9443c01a7336-2462efae428mr176577485ad.52.1756332103113;
        Wed, 27 Aug 2025 15:01:43 -0700 (PDT)
Received: from dread.disaster.area (pa49-180-91-142.pa.nsw.optusnet.com.au. [49.180.91.142])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-248c34589e5sm11007985ad.9.2025.08.27.15.01.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Aug 2025 15:01:42 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.98.2)
	(envelope-from <david@fromorbit.com>)
	id 1urOD5-0000000BvoF-2OcE;
	Thu, 28 Aug 2025 08:01:39 +1000
Date: Thu, 28 Aug 2025 08:01:39 +1000
From: Dave Chinner <david@fromorbit.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Josef Bacik <josef@toxicpanda.com>, linux-fsdevel@vger.kernel.org,
	linux-btrfs@vger.kernel.org, kernel-team@fb.com,
	linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
	viro@zeniv.linux.org.uk, amir73il@gmail.com
Subject: Re: [PATCH v2 17/54] fs: remove the inode from the LRU list on
 unlink/rmdir
Message-ID: <aK-AQ6Xzkmz7zQ6X@dread.disaster.area>
References: <cover.1756222464.git.josef@toxicpanda.com>
 <3552943716349efa4ff107bb590ac6b980183735.1756222465.git.josef@toxicpanda.com>
 <20250827-bratkartoffeln-weltschmerz-fc60227f43e7@brauner>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250827-bratkartoffeln-weltschmerz-fc60227f43e7@brauner>

On Wed, Aug 27, 2025 at 02:32:49PM +0200, Christian Brauner wrote:
> On Tue, Aug 26, 2025 at 11:39:17AM -0400, Josef Bacik wrote:
> > We can end up with an inode on the LRU list or the cached list, then at
> > some point in the future go to unlink that inode and then still have an
> > elevated i_count reference for that inode because it is on one of these
> > lists.
> > 
> > The more common case is the cached list. We open a file, write to it,
> > truncate some of it which triggers the inode_add_lru code in the
> > pagecache, adding it to the cached LRU.  Then we unlink this inode, and
> > it exists until writeback or reclaim kicks in and removes the inode.
> > 
> > To handle this case, delete the inode from the LRU list when it is
> > unlinked, so we have the best case scenario for immediately freeing the
> > inode.
> > 
> > Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> > ---
> 
> I'm not too fond of this particular change I think it's really misplaced
> and the correct place is indeed drop_nlink() and clear_nlink().

I don't really like putting it in drop_nlink because that then puts
the inode LRU in the middle of filesystem transactions when lots of
different filesystem locks are held.

IF the LRU operations are in the VFS, then we know exactly what
locks are held when it is performed (current behaviour). However,
when done from the filesystem transaction context running
drop_nlink, we'll have different sets of locks and/or execution
contexts held for each different fs type.

> I'm pretty sure that the number of callers that hold i_lock around
> drop_nlink() and clear_nlink() is relatively small.

I think the calling context problem is wider than the obvious issue
with i_lock....

-Dave.
-- 
Dave Chinner
david@fromorbit.com

