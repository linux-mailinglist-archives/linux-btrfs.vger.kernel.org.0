Return-Path: <linux-btrfs+bounces-13622-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A07BDAA706D
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 May 2025 13:11:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A17B4672F2
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 May 2025 11:11:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84254242D7C;
	Fri,  2 May 2025 11:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="BIZgde4A";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Vv9F+Vw8";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="VTnYrFUC";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="obJFcnTK"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A49E241697
	for <linux-btrfs@vger.kernel.org>; Fri,  2 May 2025 11:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746184261; cv=none; b=MMx+PFq5oSL5z06mCJoSGakbFxgi/YgrJBcWu0v+PZmJ97TA5ejMFpJhpMqiSX3WDHy0IBty7s2XlqEOAGrIQCyzLF4AyvSBOOBAa0YVVuToICse6xOTJ6qMI3JgMqftVR2rQ+o2UW9SdKcH9gRyPYjVOX0I0POHXlp/rFPEMKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746184261; c=relaxed/simple;
	bh=s/YKSwmEfZLdYEAVVKpxHe9wk393VQMROKfODJuwNWY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BQFcPVPhyc0SHsgCdTAJTwMcIuYpDMcnManYvYPNEYZOnz2FEVEtDMYgKjwPoTChNZ3nGe+zFpftPVwTAxJPR1J3Wj7EspyMiIvIehs5B6zCW0P0qL16r6VlYNnO1Ptp7IY2ImP2EVw0zWNltYwJ735sJEVVTBB/qF6kgHIornQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=BIZgde4A; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Vv9F+Vw8; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=VTnYrFUC; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=obJFcnTK; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 7791B1F387;
	Fri,  2 May 2025 11:10:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1746184258;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=68RwN3NuFrSs2yXzuINW3GXKrctQtEUkF8f+0ox5Jz8=;
	b=BIZgde4ASTOu02FQCP4guJ0N8EXhOjprNpzmLfCbtjRifNnT49Zhd2OsWVWK3NtDODCE1L
	sZ7yli1v8CjHpHOEL4gpuLY1WzhRnOc6/8LzgD4W8Ewcf5zcTKGmF58OZOD4NuBEyt+SJ/
	zF4hC+frRR9X+YoxuhtGfR+0JO0hQus=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1746184258;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=68RwN3NuFrSs2yXzuINW3GXKrctQtEUkF8f+0ox5Jz8=;
	b=Vv9F+Vw8ACIJFZOiZ6DrbhdhiG4Fe5gBnEniN8xfX0jZgh7XJYMUVJTeM2lfvdzTC/e0fP
	D+US2zRhniX3UMCQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1746184257;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=68RwN3NuFrSs2yXzuINW3GXKrctQtEUkF8f+0ox5Jz8=;
	b=VTnYrFUCgHIbTcmpbXGumJWvwr+lYUBDw/qYSCnas7LysWK0sgW/w0xxtqBJ5ckfodomGo
	w76r1e952kQ/FT6uqtoUVfyUnfqdbk3fT898ikGqyZeSk4IB2Ag/lMPPm6/AypJeR/1TcK
	mPnnqp2DHheBZ6KmO8IYc/iGScGtE/I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1746184257;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=68RwN3NuFrSs2yXzuINW3GXKrctQtEUkF8f+0ox5Jz8=;
	b=obJFcnTK2U27dP3+ZPqoo8i4IK+9zSjDVdPX8eREvfkuvpx9yThmWfVmQQwL9qcEo4e+K5
	1eN8y16BJBo19JAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4F65E13687;
	Fri,  2 May 2025 11:10:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id D9UrE0GoFGi8dAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Fri, 02 May 2025 11:10:57 +0000
Date: Fri, 2 May 2025 13:10:56 +0200
From: David Sterba <dsterba@suse.cz>
To: Kairui Song <kasong@tencent.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
	Matthew Wilcox <willy@infradead.org>,
	Hugh Dickins <hughd@google.com>, Chris Li <chrisl@kernel.org>,
	David Hildenbrand <david@redhat.com>,
	Yosry Ahmed <yosryahmed@google.com>,
	"Huang, Ying" <ying.huang@linux.alibaba.com>,
	Nhat Pham <nphamcs@gmail.com>, Johannes Weiner <hannes@cmpxchg.org>,
	linux-kernel@vger.kernel.org, Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org, Qu Wenruo <wqu@suse.com>
Subject: Re: [PATCH v3 2/6] btrfs: drop usage of folio_index
Message-ID: <20250502111056.GP9140@suse.cz>
Reply-To: dsterba@suse.cz
References: <20250430181052.55698-1-ryncsn@gmail.com>
 <20250430181052.55698-3-ryncsn@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250430181052.55698-3-ryncsn@gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Score: -4.00
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	MID_RHS_MATCH_FROM(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kvack.org,linux-foundation.org,infradead.org,google.com,kernel.org,redhat.com,linux.alibaba.com,gmail.com,cmpxchg.org,vger.kernel.org,fb.com,toxicpanda.com,suse.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[fb.com:email,infradead.org:email,toxicpanda.com:email,suse.com:email,suse.cz:mid,suse.cz:replyto,imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

On Thu, May 01, 2025 at 02:10:48AM +0800, Kairui Song wrote:
> From: Kairui Song <kasong@tencent.com>
> 
> folio_index is only needed for mixed usage of page cache and swap
> cache, for pure page cache usage, the caller can just use
> folio->index instead.
> 
> It can't be a swap cache folio here.  Swap mapping may only call into fs
> through `swap_rw` but btrfs does not use that method for swap.
> 
> Signed-off-by: Kairui Song <kasong@tencent.com>
> Cc: Chris Mason <clm@fb.com> (maintainer:BTRFS FILE SYSTEM)
> Cc: Josef Bacik <josef@toxicpanda.com> (maintainer:BTRFS FILE SYSTEM)
> Cc: David Sterba <dsterba@suse.com> (maintainer:BTRFS FILE SYSTEM)
> Cc: linux-btrfs@vger.kernel.org (open list:BTRFS FILE SYSTEM)
> Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Reviewed-by: Qu Wenruo <wqu@suse.com>

I've added the patch to our for-next, so Andrew can drop it from his
patch queue.

