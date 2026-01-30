Return-Path: <linux-btrfs+bounces-21227-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CAM3O5L3e2nWJgIAu9opvQ
	(envelope-from <linux-btrfs+bounces-21227-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Fri, 30 Jan 2026 01:13:06 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D3BEB5D17
	for <lists+linux-btrfs@lfdr.de>; Fri, 30 Jan 2026 01:13:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C060B30131F4
	for <lists+linux-btrfs@lfdr.de>; Fri, 30 Jan 2026 00:13:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF96713D53C;
	Fri, 30 Jan 2026 00:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XV26wLCk"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yx1-f66.google.com (mail-yx1-f66.google.com [74.125.224.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE57B41C72
	for <linux-btrfs@vger.kernel.org>; Fri, 30 Jan 2026 00:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769731980; cv=none; b=N0YKR3uu6PIdE6mc4mBjZs29u7eQCaYN33/ik25uObJh4XGB9gWrvDZZnmdL2LYvFQjk1YKrPvWxBrKseLoSsBd7dxyrJcCtpc/5R+3bHebkUGvioJHUGyXqJaXIHQG+FI6bYkxOZGmeou6NsHo1EqmYAi9XCJ9OOj9UxM4DmeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769731980; c=relaxed/simple;
	bh=qyGtGuS+TzD2ucJS0QF9cgDBigkk8d6qf/82/Og5pTA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mcOP6SmiD805hbHGMfqQloAD7xE3iTg9YioJdYNrX64jseoOkt5rY/YKS0gJFAUxw3qbNkYONghd1BIOaYa1Grvd5qmxJKieOoLLzZsiO18ddC5LK9K6avUX+VSBlqt8CMxSaOFwWIsCu2xskeE98fxILoz3/DH6V37fAZhirsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XV26wLCk; arc=none smtp.client-ip=74.125.224.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f66.google.com with SMTP id 956f58d0204a3-649523de91fso1455038d50.2
        for <linux-btrfs@vger.kernel.org>; Thu, 29 Jan 2026 16:12:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769731978; x=1770336778; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dzyXBWH4AwOLTmyjkTZQepHo099/hL+MaJM4zmWuCxY=;
        b=XV26wLCkw4kbm6WgWFIqdC/tnRJJgvVclFP0t3ST37CvNL0PmA/RR0XxG4BZuWDfw2
         /pBhW0ip9P/8IzJ1diNtuNchdGE9fK97jkv+bDJaXsFn92jc3tGCpeviTQefDuDe41G2
         MboM1JJ9OYN37oNOiOt4wyYkDOh6wnXRWRC6og5gI/OOm0J/tr5z8yQf7GPwzqbgvg0j
         YnuVuESgwalIe+X/PCzh6KDk737PjD+C3rZUZVNUNNKO3miCUTAYmAeBENFtN7SGGCi7
         CEbbw1qFL2oL2oq7VqI0u7ZgI13i+bu+mqR/2xxg6JPQX9T0Q124tw3QVSCHXnZ2refA
         lbcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769731978; x=1770336778;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dzyXBWH4AwOLTmyjkTZQepHo099/hL+MaJM4zmWuCxY=;
        b=eKaiFdeID7sm6K4TohuNUx6TXyVP06+cHBjGHJFL110T03UumLUdqCEZRTD1BOXw9d
         QlLy7kIs8B+eORQF1NQ9XiHsYwIx/lQ+3CCwZPoHVVWXQ7iN3gEhHc6ymUfhLQrOJ4Y4
         RNCZYRTFneJLnvCzEE551k90T1eBpacvwt5l9DeTwXEbq4gu1tEu1PC8pbY8aMtCgQk1
         rao4k4M5a8FXfQeLy7AL9s8rgjjVkM2kKd5oEc2g/YewVKqYBSFjoKwHJ/H3ZvGjR8In
         bZGHhuDJiwLjHWShgI7+2/TLgyMpx8AHsn8fL9KfS+NsBEJBUm9QWYsz+Rj3D9hcNYcE
         5zEw==
X-Gm-Message-State: AOJu0Yy8cQbAsVl9178zo1iYFVTkhdRIppPmo93zxdSJRSFe2pdaCmNL
	9xt3jWDy3lACkvGJYZEBUk8ofmAWIq55a4/ZmnHWcUi3BKUobh9sY7m5xJ4Xliis
X-Gm-Gg: AZuq6aLFKZj8OxGxsTJzcC4GRpqbiHnYydVElmH5V7qmWULaYy+1TZwFABRcCGcCfV+
	j9MLMsZmET+n6iJvcfzg1ZdcIdt9MoJTmlzSipDcpohWvqjC6IN3sDWsh/KdFI2xC4tq60CEgtX
	9hGmNSdKchhu2y7MqQOkyy9VhPnANCiEGbIFrngMeufUBFWsyjzzVakvD1QdJiHoDb3cSRBx513
	hcZKSHtxRYrfxAFn7+xqd0AHW9d2lALaC+h6gt+vgll3pXZSe/9ZZ9CPovVqp4PavncJLfstM1y
	ZlO9Taw4PUn0pZdYicziVkJg3dcMS/SGH8T/TleQU5gS87C/LOKOGYGJsPgs3E2DlBw9fSKc37J
	q7a1eM3P10UyXyozxNnDXyAB+bvIm7dAK0HVDIwUq3z+kh13Q/HKjWRvUb9jL3f4BiDBdMvUB3M
	LlIsbQng==
X-Received: by 2002:a05:690e:1c20:b0:644:60d9:7525 with SMTP id 956f58d0204a3-649a850da0dmr770847d50.87.1769731977604;
        Thu, 29 Jan 2026 16:12:57 -0800 (PST)
Received: from localhost ([2a03:2880:25ff:59::])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-649960f3426sm2912133d50.20.2026.01.29.16.12.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jan 2026 16:12:56 -0800 (PST)
From: Leo Martins <loemra.dev@gmail.com>
To: Filipe Manana <fdmanana@kernel.org>
Cc: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: Re: [PATCH] btrfs: prevent COW amplification during btrfs_search_slot
Date: Thu, 29 Jan 2026 16:12:50 -0800
Message-ID: <20260130001254.83750-1-loemra.dev@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <CAL3q7H6P_jJL98Z+ZC6agmcXq1DbK7XXJDGG5WpzrCZtzNsfUg@mail.gmail.com>
References: 
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21227-lists,linux-btrfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[loemradev@gmail.com,linux-btrfs@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-btrfs];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8D3BEB5D17
X-Rspamd-Action: no action

On Thu, 29 Jan 2026 11:52:07 +0000 Filipe Manana <fdmanana@kernel.org> wrote:

> On Tue, Jan 27, 2026 at 8:43 PM Leo Martins <loemra.dev@gmail.com> wrote:
> >
> > I've been investigating enospcs at Meta and have observed a strange
> > pattern where filesystems are enospcing with lots of unallocated space
> > (> 100G). Sample dmesg dump at bottom of message.
> >
> > btrfs_insert_delayed_dir_index is attempting to migrate some reservation
> > from the transaction block reserve and finding it exhausted leading to a
> > warning and enospc. This is a bug as the reservations are meant to be
> > worst case. It should be impossible to exhaust the transaction block
> > reserve.
> >
> > Some tracing of affected hosts revealed that there were single
> > btrfs_search_slot calls that were COWing 100s of times. I was able to
> > reproduce this behavior locally by creating a very constrained cgroup
> > and producing a lot of concurrent filesystem operations. Here's the
> > pattern:
> >
> >  1. btrfs_search_slot() begins tree traversal with cow=1
> >  2. Node at level N needs COW (old generation or WRITTEN flag set)
> >  3. btrfs_cow_block() allocates new node, updates parent pointer
> >  4. Traversal continues, but hits a condition requiring restart (e.g., node
> >     not cached, lock contention, need higher write_lock_level)
> >  5. btrfs_release_path() releases all locks and references
> >  6. Memory pressure triggers writeback on the COW'd node
> >  7. lock_extent_buffer_for_io() clears EXTENT_BUFFER_DIRTY and sets
> >     BTRFS_HEADER_FLAG_WRITTEN
> >  8. goto again - traversal restarts from root
> >  9. Traversal reaches the freshly COW'd node
> >  10. should_cow_block() sees WRITTEN flag set, returns true
> >  11. btrfs_cow_block() allocates another new node - same logical position,
> >      new physical location, new reservation consumed
> >  12. Steps 4-11 repeat indefinitely under sustained memory pressure
> >
> > Note this behavior should be much harder to trigger since Boris's
> > AS_KERNEL_FILE changes that make it so that extent_buffer pages aren't
> > accounted for in user cgroups. However, I believe it
> > would still be an issue under global memory pressure.
> > Link: https://lore.kernel.org/linux-btrfs/cover.1755812945.git.boris@bur.io/
> >
> > This COW amplification breaks the idea that transaction reservations are
> > worst case as any search slot call could find itself in this COW loop and
> > exhaust its reservation.
> >
> > My proposed solution is to temporarily pin extent buffers for the
> > lifetime of btrfs_search_slot. This prevents the massive COW
> > amplification that can be seen during high memory pressure.
> >
> > The implementation uses a local xarray to track COW'd buffers for the
> > duration of the search. The xarray stores extent_buffer pointers without
> > taking additional references; this is safe because tracked buffers remain
> > dirty (writeback_blockers prevents the dirty bit from being cleared) and
> > dirty buffers cannot be reclaimed by memory pressure.
> >
> > Synchronization is provided by eb->lock: increments in
> > btrfs_search_slot_track_cow() occur while holding the write lock, and
> > the check in lock_extent_buffer_for_io() also holds the write lock via
> > btrfs_tree_lock(). Decrements don't require eb->lock because
> > writeback_blockers is atomic and merely indicates "don't write yet".
> > Once we decrement, we're done and don't care if writeback proceeds
> > immediately.
> 
> This seems too complex to me.
> 
> So this problem is very similar to some idea I had a few years ago but
> never managed to implement.
> It was about avoiding unnecessary COW, not for this space reservation
> exhaustion due to sustained memory pressure, but it would solve it
> too.
> 
> The idea was that we do unnecessary COW in cases like this:
> 
> 1) We COW a path in some tree and we are at transaction N;
> 
> 2) Writeback happened for the extent buffers in that path while we are
> in the same transaction, because we reached the 32M limit and some
> task called btrfs_btree_balance_dirty() or something else triggered
> writeback of the btree inode;
> 
> 3) While still at transaction N, we visit the same path to add an item
> to a leaf, or modify an item, whatever. Because the extent buffers
> have BTRFS_HEADER_FLAG_WRITTEN, we COW them again (should_cow_block()
> returns true).
> 
> So during the lifetime of a transaction we can have a lot of
> unnecessary COW - we spend more time allocating extents, allocating
> memory, copying extent buffer data, use more space per transaction,
> etc.
> 
> The idea was to not COW when an extent buffer has
> BTRFS_HEADER_FLAG_WRITTEN set, but only if its generation
> (btrfs_header_generation(eb)) matches the current transaction.
> That is safe because there's no committed tree that points to an
> extent buffer created in the current transaction.
> 
> Any further modification to the extent buffer must be sure that the
> EXTENT_BUFFER_DIRTY flag is set, that the eb range is still in the
> transaction's dirty_pages io tree, etc, so that we don't miss writing
> the extent buffer to the same location again before the transaction
> commits the superblocks.
> 
> Have you considered an approach like this?

I had not considered this, but it is a great idea.

My first thought is that implementing this could be as simple
as removing the BTRFS_HEADER_FLAG_WRITTEN check. However, this
would mess with the assumptions around the log tree. From
btrfs_sync_log():

/*
 * IO has been started, blocks of the log tree have WRITTEN flag set
 * in their headers. new modifications of the log will be written to
 * new positions. so it's safe to allow log writers to go in.
 */

^ Assumes that WRITTEN blocks will be COW'd.

The issue looks like:

 1. fsync A COWs eb
 2. fsync A lock_extent_buffer_for_io(); sets WRITTEN, unlocks tree
 3. fsync B does __not__ COW eb and modifies it
 4. fsync A writes modified eb to disk
 5. CRASH; the log tree is corrupted

One way to avoid that is to keep the current behavior for the log
tree, but that leaves the potential for COW amplification...

Another idea is to track the log_transid in the eb in the same way
the transid is tracked. Then, in should_cow_block we have something
like:

if (btrfs_root_id(root) == BTRFS_TREE_LOG_OBJECTID &&
    buf->log_transid != root->log_transid)
  return true;

Please let me know if you see any issues with this approach or
if you can think of a better method.

Thanks,
Leo

> 
> It would solve this space reservation exhaustion problem, as well as
> unnecessary COW for general optimization, without the need to for a
> local xarray, which besides being very specific for the
> btrfs_search_slot() case (we COW in other places), also requires a
> memory allocation which can fail.
> 
> Thanks.

