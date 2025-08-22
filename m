Return-Path: <linux-btrfs+bounces-16289-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 879A3B3198F
	for <lists+linux-btrfs@lfdr.de>; Fri, 22 Aug 2025 15:31:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1D8C8B6463B
	for <lists+linux-btrfs@lfdr.de>; Fri, 22 Aug 2025 13:29:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC4063002D3;
	Fri, 22 Aug 2025 13:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="dgEwETev"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DC872D480B
	for <linux-btrfs@vger.kernel.org>; Fri, 22 Aug 2025 13:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755869452; cv=none; b=VnzbgUAPPFqfdi6yzVyogYdGq/Zf+i+UAYmiv6T5ijKL0fCZk+yIbOyOcJX0Tps2Fi/326u6G//R/HeaBp6ht8+QxSUHCDwTIOXt+J7zll4QXnvhbMxni0NQARZHCDnRwMaTsh/k81jYCDOGAZ6t02ccWN93oHZ2zKmNzHBRf20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755869452; c=relaxed/simple;
	bh=vawMYpL5MnTwScaPKytLvoy2AK4jNtOc6mZjESzBhco=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LqqK+9XGeIWGrANZe5loJ3mBjz3mobfwUtM+NhDb/sdluYJJ6rR+jhgZiWqtY5/tQ7TQd2C783yCyzrDGcDDadVsLHqTuVm9TFuCO35l90DhOtFHiJL5ms1iAI7+NWXZnOzVC3LNDGwdSvjZtOpU12sUotsPs5SB/aWgVChDLhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=dgEwETev; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-71d6051afbfso17994447b3.2
        for <linux-btrfs@vger.kernel.org>; Fri, 22 Aug 2025 06:30:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1755869449; x=1756474249; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ysGi6IoThbqflSFP0+quOx+igxfKxKnr1laLr0pAEm0=;
        b=dgEwETevblf20PEHJ5z0NjoehlVqLOzlFv1mhAZz9rz41QlPXxXmeqR8LfrYq8+cl8
         YAlUT/A1joboXNNyG+bevf0BSw0PhQprfZm8L7zjcLPag8O64rlIPRqBb0Kdqp7fxJ8z
         BrMRQH+h/brLImw3FLt0nR4UEYTGUc4ZTBR5rYXqIFOPQaDyyYq/WTD/p9yNvDLmZzCz
         sFubt8WzUEI88h3QAIkxvoGFpBRDuTxH/PNiV8jxUJNuJwk11sl/k0apc/BDp343sPZ6
         OFploYZUk8R4UymOOKt8xJxin8Dz7eGSFLjnvkYbf0VUFuXujfwEw+VVnfQ7+a6m0j71
         s/5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755869449; x=1756474249;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ysGi6IoThbqflSFP0+quOx+igxfKxKnr1laLr0pAEm0=;
        b=nNtKESLn85WhGX80jaru2eKJe3VZZeQUHXjz5MdG/gZp743AXmBGRAgDtb8oSHvpFj
         fb/t5dj4QMnCQWsOVWQzYMHCBeweILX9k+5Yvc5um+kVjtbswpK5bl09PT/a270qnEB4
         rC64LEw3k0tSNi7IPRN2pNErsaPpaXkIwNqPINpx6dIJxhh0hqsLQTcdVKvLmmdJ52lv
         KT14bYqaaHUFqQpkWnEy9U2N9Su0eVwwGoaTW0YwXqwkOB8UwJKt8yVeYBQwo0HzIU+1
         1sLWRsa7W0gVFYMJuI4Xh+sqGKIsWTpA42G8AqIEv0lxxLQDfDtnHMTHAFmuH8DVnhcH
         4sYg==
X-Forwarded-Encrypted: i=1; AJvYcCUX/ufvMi24aWFRfZlw4ajuiPUqPmWzsLOV04ueFdmwZhU4AYGetY3LXxsmZl/nhdTn/6Qu5miNN5kK/A==@vger.kernel.org
X-Gm-Message-State: AOJu0YxExvZsxPc/lfYjjZ+wIWC0xWlOEqvwN5i7l87NYTxeHClPUi0Q
	nqVV25mPdBc4YcfyjPPeYSiTATmadj3ghJjKufc7GuB8BsXQzfX77JZt+BbdXezrN3I=
X-Gm-Gg: ASbGncvPSP4mFjoYZXfqbyr7VhIU6h6JuZCeNDYQMQD492lSSTTAEt4i6Wu9PrkuGIn
	WARg5YKInFcR3qc10WPfd8+yxUORDXOrDPT0vHeHuZZblR7sf2D9VR/RXuixw2c1XT3p5fAS4sN
	R8A84h2jzHBXIKyerm7BiOlLZCpBIb+8p21CiQY6viBYhhswHKODHqC2UGNUizvNCn8c/Fv8+jz
	ir+an2DDp6zsPImp677IbFsZrlETIr/4qHK3FRB2J2hIyiYSpGHV/pbtatg4dttjnYd7X9QY21K
	VxBAMgUU/yP+/YBLnJwrZT1mGA0pJ1Sa7sep2jd/8LuuHS4nFWUIzgsK8LIoBq9DW5amVRQ+zPk
	e4Tary0Bkl5FYeiwKEMRFIChj7tY0ZK4pq+GsphPEN3zPCoSKJGrEdgQx/vINgahv6qnnHg==
X-Google-Smtp-Source: AGHT+IE7d8mBxJn5ZH3yrL6qHVvJSHezvTY0uEOPyAXgDu4q6zdL0lvpLU/s1EK3p0Klfj6p9sFXwA==
X-Received: by 2002:a05:690c:6286:b0:71e:727d:7dc5 with SMTP id 00721157ae682-71fdc406db2mr34431647b3.36.1755869449027;
        Fri, 22 Aug 2025 06:30:49 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71e70c426aasm48695597b3.29.2025.08.22.06.30.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 06:30:48 -0700 (PDT)
Date: Fri, 22 Aug 2025 09:30:47 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
	kernel-team@fb.com, linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org, viro@zeniv.linux.org.uk
Subject: Re: [PATCH 00/50] fs: rework inode reference counting
Message-ID: <20250822133047.GA927384@perftesting>
References: <cover.1755806649.git.josef@toxicpanda.com>
 <20250822-monster-ganztags-cc8039dc09db@brauner>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250822-monster-ganztags-cc8039dc09db@brauner>

On Fri, Aug 22, 2025 at 12:51:29PM +0200, Christian Brauner wrote:
> On Thu, Aug 21, 2025 at 04:18:11PM -0400, Josef Bacik wrote:
> > Hello,
> > 
> > This series is the first part of a larger body of work geared towards solving a
> > variety of scalability issues in the VFS.
> > 
> > We have historically had a variety of foot-guns related to inode freeing.  We
> > have I_WILL_FREE and I_FREEING flags that indicated when the inode was in the
> > different stages of being reclaimed.  This lead to confusion, and bugs in cases
> > where one was checked but the other wasn't.  Additionally, it's frankly
> > confusing to have both of these flags and to deal with them in practice.
> 
> Agreed.
> 
> > However, this exists because we have an odd behavior with inodes, we allow them
> > to have a 0 reference count and still be usable. This again is a pretty unfun
> > footgun, because generally speaking we want reference counts to be meaningful.
> 
> Agreed.
> 
> > The problem with the way we reference inodes is the final iput(). The majority
> > of file systems do their final truncate of a unlinked inode in their
> > ->evict_inode() callback, which happens when the inode is actually being
> > evicted. This can be a long process for large inodes, and thus isn't safe to
> > happen in a variety of contexts. Btrfs, for example, has an entire delayed iput
> > infrastructure to make sure that we do not do the final iput() in a dangerous
> > context. We cannot expand the use of this reference count to all the places the
> > inode is used, because there are cases where we would need to iput() in an IRQ
> > context  (end folio writeback) or other unsafe context, which is not allowed.
> > 
> > To that end, resolve this by introducing a new i_obj_count reference count. This
> > will be used to control when we can actually free the inode. We then can use
> > this reference count in all the places where we may reference the inode. This
> > removes another huge footgun, having ways to access the inode itself without
> > having an actual reference to it. The writeback code is one of the main places
> > where we see this. Inodes end up on all sorts of lists here without a proper
> > reference count. This allows us to protect the inode from being freed by giving
> > this an other code mechanisms to protect their access to the inode.
> > 
> > With this we can separate the concept of the inode being usable, and the inode
> > being freed.  The next part of the patch series is to stop allowing for inodes
> > to have an i_count of 0 and still be viable.  This comes with some warts. The
> > biggest wart is now if we choose to cache inodes in the LRU list we have to
> > remove the inode from the LRU list if we access it once it's on the LRU list.
> > This will result in more contention on the lru list lock, but in practice we
> > rarely have inodes that do not have a dentry, and if we do that inode is not
> > long for this world.
> > 
> > With not allowing inodes to hit a refcount of 0, we can take advantage of that
> > common pattern of using refcount_inc_not_zero() in all of the lockless places
> > where we do inode lookup in cache.  From there we can change all the users who
> > check I_WILL_FREE or I_FREEING to simply check the i_count. If it is 0 then they
> > aren't allowed to do their work, othrwise they can proceed as normal.
> > 
> > With all of that in place we can finally remove these two flags.
> > 
> > This is a large series, but it is mostly mechanical. I've kept the patches very
> > small, to make it easy to review and logic about each change. I have run this
> > through fstests for btrfs and ext4, xfs is currently going. I wanted to get this
> > out for review to make sure this big design changes are reasonable to everybody.
> > 
> > The series is based on vfs/vfs.all branch, which is based on 6.9-rc1. Thanks,
> 
> I so hope you meant 6.17-rc1 because otherwise I did something very very
> wrong. :)

Stupid AI hallucination...

Josef

