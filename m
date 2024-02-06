Return-Path: <linux-btrfs+bounces-2160-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FF2B84B89E
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Feb 2024 15:58:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 844EC1C24841
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Feb 2024 14:58:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A526B133426;
	Tue,  6 Feb 2024 14:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="CYtqX7BO";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="kuE/+vwr";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="CYtqX7BO";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="kuE/+vwr"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEFD5132C25
	for <linux-btrfs@vger.kernel.org>; Tue,  6 Feb 2024 14:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707231356; cv=none; b=HXCLVgar+TmPeFUhGElqTqS2t/KoY8lU1p66XbPQF+limjCzoB/hT3bjepZYvF2S6QlXKJNaQMSPAhoKar70FCMKS7w5UCfDMlUR0nBGOAwrcef3UkU+lmonpy5s1ndRVWZd5YJAXQRcE0BQJe+Xltl5UYpdJ5ojWAIYjrBuyj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707231356; c=relaxed/simple;
	bh=F6a+Gw3x5iqKHTeNfC59JV6V+S6xbaudj6UVB6ZPf3Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ri5kq6E/6cOMX1LjfjKIJrIEPdoWAGnlY9qPfVPqI4+Af10+qd91dYRteH0sjUzKCIljk65jQlBkdHT96vEDPoIxdGBlZlTkYnoyFJ6TuZ/ZQEyDQ4HDuF+TSi7EjMG4DESJOuAEwiJKbUvU3rtsOfNVpEV0jBoTn4nkJninxKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=CYtqX7BO; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=kuE/+vwr; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=CYtqX7BO; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=kuE/+vwr; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 460E9220AD;
	Tue,  6 Feb 2024 14:55:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1707231353;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GumKa/2xjM5NtjIq4VBWw0W7TzwYlbzYwAZFMv+ow6I=;
	b=CYtqX7BOEApMiPbFAG3Lc1ORijmDXg3QtKDYvTIu8Mgec62sC0BTA9lTQLP4aVROYfiMhV
	hMiydS5PZFc4oGe5oWzi4+puVFuy3rDWEyyymrARzfwOyRqV3TLWjJC/uOBIhjnwfUOPXs
	yds22odn+NLaDlu3m24U8mJ3fU6iru4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1707231353;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GumKa/2xjM5NtjIq4VBWw0W7TzwYlbzYwAZFMv+ow6I=;
	b=kuE/+vwrnv6qRgEM6vwN5HhHLmYLGI0PhLhpW40C2WTpEYgGs+sZYwhWhj5rqrs5pBEQeE
	JtvO+iLesGQNMNDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1707231353;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GumKa/2xjM5NtjIq4VBWw0W7TzwYlbzYwAZFMv+ow6I=;
	b=CYtqX7BOEApMiPbFAG3Lc1ORijmDXg3QtKDYvTIu8Mgec62sC0BTA9lTQLP4aVROYfiMhV
	hMiydS5PZFc4oGe5oWzi4+puVFuy3rDWEyyymrARzfwOyRqV3TLWjJC/uOBIhjnwfUOPXs
	yds22odn+NLaDlu3m24U8mJ3fU6iru4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1707231353;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GumKa/2xjM5NtjIq4VBWw0W7TzwYlbzYwAZFMv+ow6I=;
	b=kuE/+vwrnv6qRgEM6vwN5HhHLmYLGI0PhLhpW40C2WTpEYgGs+sZYwhWhj5rqrs5pBEQeE
	JtvO+iLesGQNMNDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2546F139D8;
	Tue,  6 Feb 2024 14:55:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id E5DjCHlIwmWrVwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 06 Feb 2024 14:55:53 +0000
Date: Tue, 6 Feb 2024 15:55:24 +0100
From: David Sterba <dsterba@suse.cz>
To: Boris Burkov <boris@bur.io>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [RFC PATCH 0/6] btrfs: dynamic and periodic block_group reclaim
Message-ID: <20240206145524.GQ355@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1706914865.git.boris@bur.io>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1706914865.git.boris@bur.io>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -4.00
X-Spamd-Result: default: False [-4.00 / 50.00];
	 ARC_NA(0.00)[];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[3];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-0.999];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Flag: NO

On Fri, Feb 02, 2024 at 03:12:42PM -0800, Boris Burkov wrote:
> Btrfs's block_group allocator suffers from a well known problem, that
> it is capable of eagerly allocating too much space to either data or
> metadata (most often data, absent bugs) and then later be unable to
> allocate more space for the other, when needed. When data starves
> metadata, this can extra painfully result in read only filesystems that
> need careful manual balancing to fix.
> 
> This can be worked around by:
> - enabling automatic reclaim
> - periodically running balance
> 
> Neither of these enjoy widespread use, as far as I know, though the
> former is used at scale at Meta with good results.

https://github.com/kdave/btrfsmaintenance is to my knowledge widely used
and installed on distros.  (Also my most starred project on github.)

The idea is to make the balance separate from kernel, allowing users and
administrators to easily tweak the parameters and timing. We haven't
added automatic reclaim to kernel as it tends to start at the worst
time. The jobs from btrfsmaintenance are scheduled according to the
calendar events (systemd.timer).

Also the jobs don't have to be ran at all, the package not installed.

The problem with balancing amount of data and metadata chunks is known
and there are only heuristics, we can't solve that without knowing the
exact usage pattern.

> This patch set expands on automatic reclaim, adding the ability to set a
> dynamic reclaim threshold that appropriately scales with the global file
> system allocation conditions as well as periodic reclaim which runs that
> reclaim sweep in the cleaner thread. Together, I believe they constitute
> a robust and general automatic reclaim system that should avoid
> unfortunate read only filesystems in all but extreme conditions, where
> space is running quite low anyway and failure is more reasonable.
> 
> I ran it on three workloads (described in detail on the dynamic reclaim
> patch) but they are:
> 1. bounce allocations around X% full.
> 2. fill up all the way and introduce full fragmentation.
> 3. write in a fragmented way until the filesystem is just about full.
> script can be found here:
> https://github.com/boryas/scripts/tree/main/fio/reclaim

A common workload on distros is regular system update (rolling distro)
with snapshots (snapper) and cleanup. This can create a lot of under
used block groups, both data and metadata. Reclaiming that preriodically
was one of the ground ideas for the btrfsmaintenance project.

The reclaim is needed to make the space more compact as the randomly
removed unused extents create holes for new data so this is a good
example for either scripted or automatic reclaim.

However you can also find use case where this would harm performance or
just waste IO as the data are short lived and shuffling around unused
block groups does not help much.

The exact parameters of auto reclaim also depend on the storage type, an
NVMe would be probably fine with any amount of data, HDD not so much.

I don't know from your description above what's the estimated frequency
of the reclaim? I understand that the urgent reclaim would start as
needed, but otherwise the frequency of reclaim of say 30% used block
groups can stay fine for a few days, as there are usually more new data
than deletions.

Also with more block groups around it's more likely to find good
candidates for the size classes and then do the placement.

> The important results can be seen here (full results explorable at
> bur.io/dyn-rec/)
> 
> bounce at 30%, much higher relocations with a fixed threshold:
> https://bur.io/dyn-rec/bounce-30/relocs.png
> 
> hard 30% fragmentation, dynamic actually reclaims, relocs not crazy:
> https://bur.io/dyn-rec/strict_frag-30/unalloc_bytes.png
> https://bur.io/dyn-rec/strict_frag-30/relocs.png
> 
> fill it all the way up, not crazy churn, but saving a buffer:
> https://bur.io/dyn-rec/last_gig/unalloc_bytes.png
> https://bur.io/dyn-rec/last_gig/relocs.png
> https://bur.io/dyn-rec/last_gig/thresh.png
> 
> Boris Burkov (6):
>   btrfs: report reclaim count in sysfs
>   btrfs: store fs_info on space_info
>   btrfs: dynamic block_group reclaim threshold
>   btrfs: periodic block_group reclaim
>   btrfs: urgent periodic reclaim pass
>   btrfs: prevent pathological periodic reclaim loops

So one thing is to have the mechanism for the reclaim, I think that's
the easy part, the tuning will be interesting.

