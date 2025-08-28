Return-Path: <linux-btrfs+bounces-16471-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C230DB38FC1
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Aug 2025 02:27:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D39D31B27649
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Aug 2025 00:27:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37DBC19049B;
	Thu, 28 Aug 2025 00:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="UAfrB0jn"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE74112FF6F
	for <linux-btrfs@vger.kernel.org>; Thu, 28 Aug 2025 00:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756340815; cv=none; b=EjQXmu9XjWvYh/a63G3SvExhrWm49g8ugxLgMfmP8JQzkse+qODrqcm0z/A8K+GMAH5Q6NYtxb/wyMOJhonnd2XMOQETbW5GQDkcCF7qWPODvx2vLYhtUWrpihJCRn5+tWSJsR/8diGVPF4WZky8rC8Q2qOQ2UBi+nsKF4l9mMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756340815; c=relaxed/simple;
	bh=CiHY/rsMO1JgljnmcpPdzbXavktzcXH6n5jFCBNd7kc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Uu6aHmtIo/lBBL++VPMVOaVwlDcPnGJK6fqCTzQAkneWLJNhU9xTgnVG4e4u90ek78uN2ayPV/+vBUKX/vTpzhwOxoml/pojRdDyaIlTNxlrDgo2P036oaCO59q/Q8gOAt/MRlPn269fXqsxZ0UNOK31Ykjld293pacJebrNLqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=UAfrB0jn; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-76e4fc419a9so475493b3a.0
        for <linux-btrfs@vger.kernel.org>; Wed, 27 Aug 2025 17:26:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1756340813; x=1756945613; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AIbrank/pOEZcuqN2pISiixQG0KXR6H+Lj8n+OUb0e8=;
        b=UAfrB0jnykPMfT5vDgDLf+UhS86I0vX7npGjSpoMLC24bKY+GPsuC785SfrJIg3zHn
         vAAnz2KlnMybJ8OfV3k5uMo3CUG5mhfAOTWpUXN4ZvaVd8MjVn0z1RHN0UyJOazODxtG
         z0sH1460cEygNXwgqS/k7qRzJiU15tnTybJuhT4drX5AojwMoTPXMFxJj429Jx/LS6Z1
         o4ualYIadwaYWFjL/pqv00zZLJtROf1KN8vndiPsv4i0sUvnoUUnOTSMRzOcF5sDXzgb
         2sVFV+r1v98KPquB2H2jiLZY1A8/bpmChBTdQcAJCN5UScVPBkfP8g2TWfAIbhL/uBj6
         D9Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756340813; x=1756945613;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AIbrank/pOEZcuqN2pISiixQG0KXR6H+Lj8n+OUb0e8=;
        b=dtLp8S8WxVjpqq93aHwsohUOjLsMxckGXjjQNBYFZGG4lmdbFIPF1ggKbUScbipl6u
         AlHQblmDRw6npBLzyNLYJl8/wuSCOO4/l0nt/s1B1AX3qbfec7vEAb4ccWul/U/DDGe9
         eSvzPWNIEnPsA9vPsss604DUZVEoBTncYZuhX2+o/BNL+6DfYZNEejSUO5yz5FAYiSXq
         8c5/+H4Z89koKqYRCOikKASD7nycFwODrtt8KIqJbgpT0CkPiK0JlxoAb/eue8OSodfA
         B8Icu+zY+uyunBpEZMShyL46mt3m8Yq8T1uVL4IhzaR/uBxGR5C1id3oY9C6+PbQL7X8
         NI4Q==
X-Forwarded-Encrypted: i=1; AJvYcCU7AHfVHLhX8WfIMdfyzp3WgyPPbgh9eTNLnjGT+0WoRzWlWGKoW9LGTPXZz6GQ0xZLPfEyWRs+VAddCw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxr7TPCS73oGeJP36QC3rCfYztSjwIr5fEeyzF9i6BRFZhT3QaR
	w2tErZFSrrGB9YRq6KsPrjCa3U2R+zl5iEdtNT2bjPuca4H4iDca5wMM3LpacqvLMqs=
X-Gm-Gg: ASbGncsFW7tDX7GUVMT0+4c/1NCN93qO13RtVCzpvB0t9g4LhtlPYM19ZO/PiJ+dZfd
	TwrSdTMHcr+VenDWYUSn/Krs5z2ppb+BOUXjbe+MI0qMW9tQZSaEQFLBsXPqfOS+Hb8uNj9xg/R
	1jPJWtdHLvVMBpRWvs0qzQ03TMkSjTa2QJZvbyhCnwwob0p0AGHcoDn7m5XI4ohfAV8PlbOQchy
	jNIr6A/Ww5YAKpyvpO9cqMC6kC1eLcIkxl3P0VcZ29PuLfnsSX5ED9C21e/bsUWxLHM17KX+3xw
	5i5HBeugT+bssxx9O93eDITNa2Kyl2cAWV75HLS44ChYfjI8yKZ+ufB/BD/OzVohof3XDuR9ixK
	WgOwojKRFj7XpDE49HvXQ+UdColxr+T4OORPptMF/uAgGg3G/wxEC25MjVS7BNKL6bRz76bELeO
	w/uGav+7Lm
X-Google-Smtp-Source: AGHT+IFK5hxc7bYLtaOFxGe9ricq7ACFEmb4qM2KiH4E4yFcbUWB7uOpNMCQ2mvzULlcuE6v1Dn+5Q==
X-Received: by 2002:a17:903:acc:b0:248:b8e0:5e1d with SMTP id d9443c01a7336-248b8e06116mr39556925ad.49.1756340813131;
        Wed, 27 Aug 2025 17:26:53 -0700 (PDT)
Received: from dread.disaster.area (pa49-180-91-142.pa.nsw.optusnet.com.au. [49.180.91.142])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24875471811sm49697605ad.37.2025.08.27.17.26.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Aug 2025 17:26:52 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.98.2)
	(envelope-from <david@fromorbit.com>)
	id 1urQTa-0000000ByQW-0gL8;
	Thu, 28 Aug 2025 10:26:50 +1000
Date: Thu, 28 Aug 2025 10:26:50 +1000
From: Dave Chinner <david@fromorbit.com>
To: Josef Bacik <josef@toxicpanda.com>
Cc: linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
	kernel-team@fb.com, linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org, brauner@kernel.org,
	viro@zeniv.linux.org.uk, amir73il@gmail.com
Subject: Re: [PATCH v2 53/54] fs: remove I_LRU_ISOLATING flag
Message-ID: <aK-iSiXtuaDj_fyW@dread.disaster.area>
References: <cover.1756222464.git.josef@toxicpanda.com>
 <3b1965d56a463604b5a0a003d32fe6983bc297ba.1756222465.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3b1965d56a463604b5a0a003d32fe6983bc297ba.1756222465.git.josef@toxicpanda.com>

On Tue, Aug 26, 2025 at 11:39:53AM -0400, Josef Bacik wrote:
> If the inode is on the LRU it has a full reference and thus no longer
> needs to be pinned while it is being isolated.
> 
> Remove the I_LRU_ISOLATING flag and associated helper functions
> (inode_pin_lru_isolating, inode_unpin_lru_isolating, and
> inode_wait_for_lru_isolating) as they are no longer needed.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

....
> @@ -745,34 +742,32 @@ is_uncached_acl(struct posix_acl *acl)
>   * I_CACHED_LRU		Inode is cached because it is dirty or isn't shrinkable,
>   *			and thus is on the s_cached_inode_lru list.
>   *
> - * __I_{SYNC,NEW,LRU_ISOLATING} are used to derive unique addresses to wait
> - * upon. There's one free address left.
> + * __I_{SYNC,NEW} are used to derive unique addresses to wait upon. There are
> + * two free address left.
>   */
>  
>  enum inode_state_bits {
>  	__I_NEW			= 0U,
> -	__I_SYNC		= 1U,
> -	__I_LRU_ISOLATING	= 2U
> +	__I_SYNC		= 1U
>  };
>  
>  enum inode_state_flags_t {
>  	I_NEW			= (1U << __I_NEW),
>  	I_SYNC			= (1U << __I_SYNC),
> -	I_LRU_ISOLATING         = (1U << __I_LRU_ISOLATING),
> -	I_DIRTY_SYNC		= (1U << 3),
> -	I_DIRTY_DATASYNC	= (1U << 4),
> -	I_DIRTY_PAGES		= (1U << 5),
> -	I_CLEAR			= (1U << 6),
> -	I_LINKABLE		= (1U << 7),
> -	I_DIRTY_TIME		= (1U << 8),
> -	I_WB_SWITCH		= (1U << 9),
> -	I_OVL_INUSE		= (1U << 10),
> -	I_CREATING		= (1U << 11),
> -	I_DONTCACHE		= (1U << 12),
> -	I_SYNC_QUEUED		= (1U << 13),
> -	I_PINNING_NETFS_WB	= (1U << 14),
> -	I_LRU			= (1U << 15),
> -	I_CACHED_LRU		= (1U << 16)
> +	I_DIRTY_SYNC		= (1U << 2),
> +	I_DIRTY_DATASYNC	= (1U << 3),
> +	I_DIRTY_PAGES		= (1U << 4),
> +	I_CLEAR			= (1U << 5),
> +	I_LINKABLE		= (1U << 6),
> +	I_DIRTY_TIME		= (1U << 7),
> +	I_WB_SWITCH		= (1U << 8),
> +	I_OVL_INUSE		= (1U << 9),
> +	I_CREATING		= (1U << 10),
> +	I_DONTCACHE		= (1U << 11),
> +	I_SYNC_QUEUED		= (1U << 12),
> +	I_PINNING_NETFS_WB	= (1U << 13),
> +	I_LRU			= (1U << 14),
> +	I_CACHED_LRU		= (1U << 15)
>  };

This is a bit of a mess - we should reserve the first 4 bits for the
waitable inode_state_bits right from the start and not renumber the
other flag bits into that range. i.e. start the first non-waitable
bit at bit 4. That way every time we add/remove a waitable bit, we
don't have to rewrite the entire set of flags. i.e: something like:

enum inode_state_flags_t {
	I_NEW			= (1U << __I_NEW),
	I_SYNC			= (1U << __I_SYNC),
	// waitable bit 2 unused
	// waitable bit 3 unused
	I_DIRTY_SYNC		= (1U << 4),
....

This will be much more blame friendly if we do it this way from the
start of this patch set.

-Dave.
-- 
Dave Chinner
david@fromorbit.com

