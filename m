Return-Path: <linux-btrfs+bounces-16451-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3114DB38767
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Aug 2025 18:09:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDF133B5299
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Aug 2025 16:09:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19770342C92;
	Wed, 27 Aug 2025 16:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b="HHL+i8Qb"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63274335BBB
	for <linux-btrfs@vger.kernel.org>; Wed, 27 Aug 2025 16:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756310929; cv=none; b=NDDEBTV4u09BEmIqtmixZyZVqPIWqGS2Z9vb9RdcHo915DZya1H+TjDEXLSnA76o7sBgIBPK1YoHHZmvm/mrSFeXzyJUhKo0fFeyX5ij+BWBGBD7cDc5f0UG2ouOlBSzoZyzRnXZgObCdpWTGM3qXw3SB5SKYb7NBNBqVrS0Aak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756310929; c=relaxed/simple;
	bh=1J49svBdPM1VsPk/B72U0p4aTK9KkUwye6nSh+AaCGs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JgKygOgPRQWpmDcv4xNS0/aMJWKAAy6p0Uspzn6+RCPCNxd1gEZ6WwwBQN58mIz/SEtWQM+ik0gHOQK7U3BBJ8u7RsKrq2rOOGlcxYf3z/aqf/8fBSpdXr1km7Lsu55DcxL5FVksNJhkg6bSuP4EKb9FI6V71jSkvP3EWEWP8UM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=pass smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b=HHL+i8Qb; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-e931cddb0e2so5137878276.3
        for <linux-btrfs@vger.kernel.org>; Wed, 27 Aug 2025 09:08:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1756310925; x=1756915725; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=F8MBCOALyLW29tRaKLBmkUdjU0e3m81ua8qM6QlxUc0=;
        b=HHL+i8Qb7TjRo63pGyUAf/QBI3i8b+LbB5ClIfySonbFJLPphyvz6fbpxfI+4XTmvi
         x/HeVAhiJhGSd+lkAihoEOLEBMVa8qn6iuywEC7eaeZOxz5EXgHv/rLSvs1RvENrv1Af
         xUMjIK2b1i02uyJFNniB9wlv63A2IMOG+5RoZ0k66RoUiZj0B9uXRf5sUHOKZ0iLGiuK
         pRQVc7EIvcW2q2nL+W1eZ6qPvKpYY/iC+zJVEJzSlIO+ogcbgSxtSKO+MO1tGHq/iXUs
         akyUEI1PxTccrbNO/QQtRqJhGKZCdGb5bf+FGSsD0rITcQV+TPtqkKNBcj/cd0BLEax3
         FRSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756310925; x=1756915725;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F8MBCOALyLW29tRaKLBmkUdjU0e3m81ua8qM6QlxUc0=;
        b=kA+3qSodnPWvSWx8Xjrf7CJBuIzJYnKMV1pxmiDjKNZQXYmerFNrlo9FTyQClAasku
         krCp3rwrBvvZxEljFlWdEg5SLx0UTA0Odzvvn4hEKX3ULn61DxnuuvRNOlYLXt/0LRz4
         5U+kUhLAWoqtw6QllqKU27EcAOkHBpSg95dgSNqi5aW6pi6z9DebysDu6bXi+UHgx0N4
         ixKtnLZDhJ/+qV1MJNy2FDdVe+WblGGll6iCNbhihTfvrdrDaB0WhZZcGQykEchIVQr0
         erbgkUG15l4M7gOfRetft0XcpLWpvA0xd2ONzhbyJHNFCbpmozDWIwSMmZrr2783FijK
         l7hA==
X-Forwarded-Encrypted: i=1; AJvYcCXJzaL+5PFh7HEF8QlrQYXmiA+x7yc9RO4/jSRb3hsXDRDy4WtA3N/PnJZV1LhYoPokPEnUDKFlITwFmw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyfjkOUS/p7im1UJlEfmhSVnszdv+Q54vsU2MVhqS13ELQadvgc
	ThIiskqPNCAW/dMhlMH3vKe4IcpdsnM62zCJBWQBqnujwEZdo39GjOvzeRGvPp337jU=
X-Gm-Gg: ASbGncuxIcRpZqezhT9LZkfCoQb913FgxpAUpGIwB7/rVyhUMq/KTdNV6fNjfpqyJrl
	l2QRI7TpejW8X7fUeqQVlYnQVvmrb/rc337zfOFUXGmAK9XjMHwS6groZjxKQSV6jKbDQRruHDj
	kHxZqzLrw+GNDG+Il/iILl9NSPMvMPwovL4A80dAzBaJQ3VQurqsKYh61RLwtzilNvTa359SZy/
	ib/wwcNGxGu7OtNawSTAOmux57POXtO8Wi4RmMdPoexb5NIWVsizma0Ro2mOrIa1zNY/mYea2xM
	ljcjM/475hpzYG7bcUqf1TE2o8nGst7YNfFeiUi7Wl2z8QC2gtts912eeUVdJegkaX7Ahx4IhGY
	CVxndfLEmVI6DlSccTkHqjwG4ZeRzcWSCcU6IdFp6EHYZ1j9/t462pDkgrbepLXkanW28klF/9I
	51HGPw
X-Google-Smtp-Source: AGHT+IE9MI02/EGLcEuj8RLfzQi94HthTqFKcq8Wp5g4r4kb41qy9Cy6X8/9v/mHfADNFNYHinugpA==
X-Received: by 2002:a05:6902:e0b:b0:e94:f463:884d with SMTP id 3f1490d57ef6-e951c3ff649mr20553107276.45.1756310925213;
        Wed, 27 Aug 2025 09:08:45 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e952c358cf8sm4133687276.23.2025.08.27.09.08.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Aug 2025 09:08:44 -0700 (PDT)
Date: Wed, 27 Aug 2025 12:08:43 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
	kernel-team@fb.com, linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org, viro@zeniv.linux.org.uk,
	amir73il@gmail.com
Subject: Re: [PATCH v2 17/54] fs: remove the inode from the LRU list on
 unlink/rmdir
Message-ID: <20250827160843.GB2272053@perftesting>
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
> 
> I'm pretty sure that the number of callers that hold i_lock around
> drop_nlink() and clear_nlink() is relatively small. So it might just be
> preferable to drop_nlink_locked() and clear_nlink_locked() and just
> switch the few places over to it. I think you have tooling to give you a
> preliminary glimpse what and how many callers do this...

Fair, I'll make the weird french guy figure it out.  Thanks,

Josef

