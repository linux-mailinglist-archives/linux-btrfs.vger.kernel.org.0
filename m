Return-Path: <linux-btrfs+bounces-16450-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 72D8CB3875A
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Aug 2025 18:08:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 236A24E0F63
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Aug 2025 16:08:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85AF2322753;
	Wed, 27 Aug 2025 16:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b="SWZleMlx"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 162382F0693
	for <linux-btrfs@vger.kernel.org>; Wed, 27 Aug 2025 16:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756310881; cv=none; b=l5zpfrdH8BfQUvapaacvYFfVuu1u6O4EltpG7WA6ETfU8QBdjkx7CJZaBBGGh1QHnZvtmn+bwf/SY4pNqBiFoJUBtE8hWkxcB9R40ihkM2QOY/KemMu00aX5+E7K71Lxv2xOrXFRq1y7mb3ilJLhU0TeGOWTAkKdZKbis5qEav4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756310881; c=relaxed/simple;
	bh=Gx7xU0EwwmpQsQeC++G48wZoJ0PFQt/ki3BvUcTHe2k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EFRLcWouuiUG/UsJi2Sy1/gULLPdttVyv+eg9vIZfuEz/xKx0ibkfwB1onyMkE2XunwslZ9f+g+RzZ2zKlQ5O6PHQ3Q1nDlwPUqd5MV4MeS+KBKE1oOprBJw7LqYKbgtMIwjTCKxPGvcR+EBM7uRhuwZomtj9IcT38puQXMOZBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=pass smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b=SWZleMlx; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-71ff2b20039so41999337b3.3
        for <linux-btrfs@vger.kernel.org>; Wed, 27 Aug 2025 09:07:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1756310878; x=1756915678; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oeqKXGh2k/fvZbtY7nlqP034nNJp6LLlTEXlFIX7b9M=;
        b=SWZleMlxhKWl40PHYB4ucoxJ0CFao+AtTgt3TDkcEF+/MIZKcVQ+GAlov/YRv2rtvK
         EKA6RVf2O7sn1umpz8AaccX0MpJn+UL1yit4pFTpwXsd+GJYlSjRpO7/z6ldYGIeo56e
         Ig2Ma0567nMVRODn9D80ISJXJK1YYhAqvSUF5Zo6o+zAdkhV29XQPSmG/il+xDb7IQQI
         GsZ9JgFcPAogkG+KhtczUy4egbr+G/WIYRy+yu1qwj/KFeENAc3SmR1LadnCWLJcJJCx
         T0dvrVKpi9rq0pOrIyUAdk6UKFtyeILpNWuC9jn15SbdI/23MJe5OKwjfr+4E38ivHnN
         1n9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756310878; x=1756915678;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oeqKXGh2k/fvZbtY7nlqP034nNJp6LLlTEXlFIX7b9M=;
        b=UZEVlOWixc5n21PT0R6GioTG9CrKDa/nSca6+HS8JjPdQFdLUNwe1iX0zVQQJV2oUJ
         Yhv46df2kSR7jPbkdMIqYwS8mMh1RkA4nIfKuTVkdeBzbhJIHF8+VDSVILqX/x711yGQ
         W9X5hV15YH+j2drOuKMnNEZQwcZA6IwYDdiG8ik23W8sVec5LpnKDKZXjBY8CENDw1Qs
         DirwcucoQQ8vfORfiAjvUtKMCXye0Y74FiIiF1j7MpAzcHJkbG0BnrSehyJLlDaaC+Qz
         VDow+wVDkO62jBhAA6/W6APIIRVmZz5D6do5qgGKieMTv8G5M9WQhIhuBpsIWu6/bvrF
         8/Qw==
X-Forwarded-Encrypted: i=1; AJvYcCVRqkjrNolz1+FvGnSmr+lfHaDj1YBmFIwtAm1hk2H8oVHDBlSjBoxltQEVnfCXVukmvp3LQfoNJXgicQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywu6iocevmClipHgWYpUR9Zxheo2oUEFU3FvTH12XoEiXBzb0n+
	5dRrsRdtBSHRYhQ1w894/4SpXZhG66Na34CpJ6IeUHaziIfYojlDpec5ZIg3Q/3NXes=
X-Gm-Gg: ASbGncsN5SFnrfXko+xPL7vp7YrhfDrU366grXfgx3hzGvt2lFSZsHfrQ710p1gFAPX
	LvSZJhUVRMgrxuD+/szNWn33d5v0HyjaAXz5p/CC4Rf8s5q6FPDJ51S8NADA3L2FXdxGKe5RZ5g
	tmTxLG+dAAj8pA1054WJeTu03S4d/rqWxUl1y7BQTe/NVec7mzDOPNyP3rzSXfCAFYi1t8u7Umk
	9JEayE1ERuLhiWUxTF4tC5ZFO/Sh0rCTGLdTGp8zduf1s92BHI8qePeX1p8qw3DVdeI2q6MTD/7
	HnBr+COGbsurbkzULiQeycbWfl3SXMk6uiln7T24UmhVE2ECR01elCyddTOymiVJF5WVaTkEgta
	1Dp84ggpoKKG5q9l+1UQmxm7Eav9gBrZ05mEDg2DI5FzB1UFYKKNAJhwhLM9a5NNJ8zlWR9yE7V
	NGNVwJ
X-Google-Smtp-Source: AGHT+IHS9aTsbVkGsXkV8bfMPkBsYYqHVpKIqvIIEtcl6YxbxzkP6i6xFIvHd3ui1H2CD+Mz60vqoQ==
X-Received: by 2002:a05:690c:6702:b0:721:370e:2756 with SMTP id 00721157ae682-721370e2aafmr64643697b3.45.1756310877727;
        Wed, 27 Aug 2025 09:07:57 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71ff18b1b7dsm31881287b3.62.2025.08.27.09.07.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Aug 2025 09:07:56 -0700 (PDT)
Date: Wed, 27 Aug 2025 12:07:56 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
	kernel-team@fb.com, linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org, viro@zeniv.linux.org.uk,
	amir73il@gmail.com
Subject: Re: [PATCH v2 15/54] fs: maintain a list of pinned inodes
Message-ID: <20250827160756.GA2272053@perftesting>
References: <cover.1756222464.git.josef@toxicpanda.com>
 <35dc849a851470e2a31375ecdfdf70424844c871.1756222465.git.josef@toxicpanda.com>
 <20250827-gelandet-heizt-1f250f77bfc8@brauner>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250827-gelandet-heizt-1f250f77bfc8@brauner>

On Wed, Aug 27, 2025 at 05:20:17PM +0200, Christian Brauner wrote:
> On Tue, Aug 26, 2025 at 11:39:15AM -0400, Josef Bacik wrote:
> > Currently we have relied on dirty inodes and inodes with cache on them
> > to simply be left hanging around on the system outside of an LRU. The
> > only way to make sure these inodes are eventually reclaimed is because
> > dirty writeback will grab a reference on the inode and then iput it when
> > it's done, potentially getting it on the LRU. For the cached case the
> > page cache deletion path will call inode_add_lru when the inode no
> > longer has cached pages in order to make sure the inode object can be
> > freed eventually.  In the unmount case we walk all inodes and free them
> > so this all works out fine.
> > 
> > But we want to eliminate 0 i_count objects as a concept, so we need a
> > mechanism to hold a reference on these pinned inodes. To that end, add a
> > list to the super block that contains any inodes that are cached for one
> > reason or another.
> > 
> > When we call inode_add_lru(), if the inode falls into one of these
> > categories, we will add it to the cached inode list and hold an
> > i_obj_count reference.  If the inode does not fall into one of these
> > categories it will be moved to the normal LRU, which is already holds an
> > i_obj_count reference.
> > 
> > The dirty case we will delete it from the LRU if it is on one, and then
> > the iput after the writeout will make sure it's placed onto the correct
> > list at that point.
> > 
> > The page cache case will migrate it when it calls inode_add_lru() when
> > deleting pages from the page cache.
> > 
> > Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> > ---
> 
> Ok, I'm trying to wrap my head around the justification for this new
> list. Currently we have inodes with a zero reference counts that aren't
> on any LRU. They just appear on sb->i_sb_list and are e.g., dealt with
> during umount (sync_filesystem() followed by evict_inodes()).
> 
> So they're either dealt with by writeback or by the page cache and are
> eventually put on the regular LRU or the filesystem shuts down before
> that happens.
> 
> They're easy to handle and recognize because their inode->i_count is
> zero.
> 
> Now you make the LRUs hold a full reference so it can be grabbed from
> the LRU again avoiding the zombie resurrection from zero. So to
> recognize inodes that are pinned internally due to being dirty or having
> pagecache pages attached to it you need to track them in a new list
> otherwise you can't really differentiate them and when to move them onto
> the LRU after writeback and pagecache is done with them.
> 

Exactly. We need to put them somewhere so we can account for their reference.

We could technically just use a flag and not have a list for this, and just use
the flag to indicate that the inode is pinned and the flag has a full reference
associated with it.

I did it this way because if I had a nickel for every time I needed to figure
out where a zombie inode was and had to do the most grotesque drgn magic to find
it, I'd have like 15 cents, which isn't a lot but weird that it's happened 3
times. Having a list makes it easier from a debugging perspective.

But again, we have ->s_inodes, and I can just scan that list and look for
I_LRU_CACHED. We'd still need to hold a full reference for that, but it would
eliminate the need for another list if that's more preferable?  Thanks,

Josef

