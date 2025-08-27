Return-Path: <linux-btrfs+bounces-16467-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D6A4FB38BA0
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Aug 2025 23:47:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 925A016D63D
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Aug 2025 21:47:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F26EC30DEC3;
	Wed, 27 Aug 2025 21:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="oTmL/8S2"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 625C82F0C76
	for <linux-btrfs@vger.kernel.org>; Wed, 27 Aug 2025 21:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756331227; cv=none; b=sGZfuO4f3UOYbmJNwsykrf+Vh5OCa0p7rZXIpQoBPofF+HVTcTBgPpF0rscpidNYCUkdCzstbCMsMMbaAyDdkDgcWT5Ixz97dAGQYb8+xl7LnYl5stxPwmutATB7TTgPWWU+MZgFQfsFnlh+Ry+W3foCUOKcN4BxrUyo2nasq2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756331227; c=relaxed/simple;
	bh=p7brPDy2olHFfAC7S4q3Vp+PKM6Nm9aH82XdvCJ8awI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u0+13u8LFG5wZridnusitiKtgSGrYjBW9JX4l4xvHhYxGNuH20czpVJo/qIn+uXSAsIE0zj/8BCyo6YN8tgC6QxFM5llvqnz+q/VruYJ+fikXeFvmau4HSTAqmPbQA9euAWRngm53jpxpCjS1uRKQOybSzDbO+/NbQIRkdLX+M0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=oTmL/8S2; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-77057266dacso387694b3a.2
        for <linux-btrfs@vger.kernel.org>; Wed, 27 Aug 2025 14:47:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1756331221; x=1756936021; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1brA+k4hD/Yqcu3E+OzWK4Zw3vVchK7SPI3ZmUa+ClY=;
        b=oTmL/8S2U0QYx+4QQGCxzpTYxxbY2M847yIFjACe3uxKSxUtpm9qlqz7Ets000hEGT
         eIlJIh/5HkEN4W8yhMs7iQIcBBI8FCGR6qgATvk8QiXPmAACVNI2FuqOYKsPDLtIC01u
         W5n9bD10pqz1hqvN39di9RF5l7AwgDEZevx+3g0lZpbypK6Mg9oIF2eJWXPanYxofjOF
         sfFkKPdVPpnOU8VyGa/MjGDpJYfJSq4ccjwXjn9iBdSNAR9wIaImSVISg9EHkTjc4TcF
         aqb2Aygkz2vYxwm5obVtQ60Ayx/IneMQkZDZKAS6Fg/q94wLCXZAqV1rvfPcFRjB/hBz
         ADRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756331221; x=1756936021;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1brA+k4hD/Yqcu3E+OzWK4Zw3vVchK7SPI3ZmUa+ClY=;
        b=Ueqfm3aWjV0OjD+gvos3T3I0efz9b1yM5umjQyernzKprXgdfPVs7dVDSu9hm5YjMM
         ie0WddB8qUfs/rRN2UKf5SE5dR/BQsNTJPPmMe/3yubC6NOH2IPp72FX27LQdvuvs5jj
         tVyisAEbjFHp8GP+EGh1hVDiDCayY4gNwSgs1Uv0ctpZoGAol90R3P+W1R1pmb+xGWbe
         q4347sA3vF1M6Wm23B1tDAavevUtmE+i835NZtNlaTHhIMFS9VcdyXoFccIKu05Bk8J8
         O1+h/ue/bHqmb+czGubIP7ZuY9/2RiiokL5IJnoL7fp3SIRSn8JvM2js4ZBAJyHke8FA
         wI0Q==
X-Forwarded-Encrypted: i=1; AJvYcCU6iQprCgoCilymNLyKj09e+gbSxiLOl/aJHBz3tHUINRPDjTt5PEXS67B0Cuz/wqi1XYJaZqToHJZdRQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwZcdRYyWNF+WQSOvlCMby7vA0PEL6MQuO/2w8ceb1b5V7eZhJr
	97BzgQozPguHqur8R8jzW48xStz6JvhGkAK57kt47YUdvVNoFPSBdNisjPsM3Bhn7sM=
X-Gm-Gg: ASbGncvMphnGzpzKnnI5nGuucT9uQcJZw2GPuF7cUOUpwV64lFrJmGKeYWre+Yf9lr2
	GGWP62gHqbHjIrUnhXObmSZ+Qdhk6Ksx7MTK1ZMJIlnwzUlmE57+RS37OBs9rP0IOSMYIj7p88A
	UyvPndYFVqWrXLZTCszHqYmO+RicmtPP+eFqVAymiycYvT70OEtbeesmDbo867swYh1ga9Oc6Zg
	gkJdh50XakqTEtNtiw28EjEjZ/DsDk3z5DFksUXXWUBMM7hwRCb0hDg7B0iZ88hdbJaRzT3rv7L
	vfiOOcY6kT8eCK6hRPzS5/4zM46te7esr+rkwqaTkg3Qo1cyh32wuNNdwZKztN9PR+ojOs2+Ayg
	UKWDm+8EWMMvQmWcGhu5YpA2KVM5zJv0O2nz5BxwG6jXar+4+XEYrPuxzGENn0mBYvJ7jBAVGWC
	hojcm+qkmT
X-Google-Smtp-Source: AGHT+IGwubMhrkeveyZScO9SyGs6JfX0VeRusyOBY+29aVn++TMuUkFVK5pCfTn+imoo/NPkWa8qcg==
X-Received: by 2002:a05:6a00:14ca:b0:771:ea86:3f73 with SMTP id d2e1a72fcca58-771ea864584mr15877772b3a.32.1756331221445;
        Wed, 27 Aug 2025 14:47:01 -0700 (PDT)
Received: from dread.disaster.area (pa49-180-91-142.pa.nsw.optusnet.com.au. [49.180.91.142])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-771f34ecccesm6566839b3a.61.2025.08.27.14.47.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Aug 2025 14:47:00 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.98.2)
	(envelope-from <david@fromorbit.com>)
	id 1urNyr-0000000BvQF-035E;
	Thu, 28 Aug 2025 07:46:57 +1000
Date: Thu, 28 Aug 2025 07:46:56 +1000
From: Dave Chinner <david@fromorbit.com>
To: Josef Bacik <josef@toxicpanda.com>
Cc: linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
	kernel-team@fb.com, linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org, brauner@kernel.org,
	viro@zeniv.linux.org.uk, amir73il@gmail.com
Subject: Re: [PATCH v2 16/54] fs: delete the inode from the LRU list on lookup
Message-ID: <aK980KTSlSViOWXW@dread.disaster.area>
References: <cover.1756222464.git.josef@toxicpanda.com>
 <646d132baae6e5633064645e677dada101681850.1756222465.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <646d132baae6e5633064645e677dada101681850.1756222465.git.josef@toxicpanda.com>

On Tue, Aug 26, 2025 at 11:39:16AM -0400, Josef Bacik wrote:
> When we move to holding a full reference on the inode when it is on an
> LRU list we need to have a mechanism to re-run the LRU add logic. The
> use case for this is btrfs's snapshot delete, we will lookup all the
> inodes and try to drop them, but if they're on the LRU we will not call
> ->drop_inode() because their refcount will be elevated, so we won't know
> that we need to drop the inode.
> 
> Fix this by simply removing the inode from it's respective LRU list when
> we grab a reference to it in a way that we have active users.  This will
> ensure that the logic to add the inode to the LRU or drop the inode will
> be run on the final iput from the user.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Have you benchmarked this for scalability?

The whole point of lazy LRU removal was to remove LRU lock
contention from the hot lookup path. I suspect that putting the LRU
locks back inside the lookup path is going to cause performance
regressions...

FWIW, why do we even need the inode LRU anymore?

We certainly don't need it anymore to keep the working set in memory
because that's what the dentry cache LRU does (i.e. by pinning a
reference to the inode whilst the dentry is active).

And with the introduction of the cached inode list, we don't need
the inode LRU to track  unreferenced dirty inodes around whilst
they hang out on writeback lists. The inodes on the writeback lists
are now referenced and tracked on the cached inode list, so they
don't need special hooks in the mm/ code to handle the special
transition from "unreferenced writeback" to "unreferenced LRU"
anymore, they can just be dropped from the cached inode list....

So rather than jumping through hoops to maintain an LRU we likely
don't actually need and is likely to re-introduce old scalability
issues, why not remove it completely?

-Dave.
-- 
Dave Chinner
david@fromorbit.com

