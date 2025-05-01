Return-Path: <linux-btrfs+bounces-13591-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A6B9AA5C56
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 May 2025 10:50:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 06E127B02FE
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 May 2025 08:49:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A4A820F080;
	Thu,  1 May 2025 08:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="p6orWX5I";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="QntaoXpy";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="p6orWX5I";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="QntaoXpy"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3A24B67F
	for <linux-btrfs@vger.kernel.org>; Thu,  1 May 2025 08:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746089428; cv=none; b=XZ2++yEZy3P7+yiGmH0rgV7fQB5v2l/A5hJG2RkccXar0trUhYl+BK2pkNkd8LrNxYUUW56kebrqdpHVyq2ko6HK8/ex1VwaW6sNTTRBXM0JAV5maExpPA6+PMnqknE0QvNIK9CRpmYvE4tgHEBn+9PtyZtigZXcVxjERrZRlcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746089428; c=relaxed/simple;
	bh=nxO2KECHyHyMFH/HMDoyJvxCzvgc1DV8+CQcb9wuWN8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jmXnDtJL7ZdPMRVaWd1Z0wqeGEjwterAJPEdppvs3IcUZCQdWN6y0pRln+TaC3OFjZWpEhgJecZEHmairnO5VeF4wPaQIm/PhnOzUyToF1VVIwwQcRLsHpO1Ckz62efkeTp2GalU1DhPYnR9NMy0E8kQ/Jyo8UGsLbMpsNoMjbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=p6orWX5I; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=QntaoXpy; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=p6orWX5I; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=QntaoXpy; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 5B8211F388;
	Thu,  1 May 2025 08:50:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1746089419;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=r5zIrmd5W9mcaRLQuezc6RZmJaUSbNbg4XZp0yaIFm4=;
	b=p6orWX5IrPomBFqQP3tyGwqXRDqAHdN89S6uPu8QinFYCTWfZ3k0WJ3hg2EWriU0LzHPDO
	8KHynGzipMcBSDv6J85bnfUuw72WBWZTZcmZA8l6jMTj7N1gK04+iKXURnhZgIsmNZhsde
	Ir80m3EhBSd+DzVbsYbn43oop7VBnHc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1746089419;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=r5zIrmd5W9mcaRLQuezc6RZmJaUSbNbg4XZp0yaIFm4=;
	b=QntaoXpyGckBRK9h3U6A7HPb9az9ovf0QpcDepuVPTnft6nHBf2tYH06Bz4mYt/fVf+zBc
	rnj8BaZ3oC4sWxAw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=p6orWX5I;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=QntaoXpy
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1746089419;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=r5zIrmd5W9mcaRLQuezc6RZmJaUSbNbg4XZp0yaIFm4=;
	b=p6orWX5IrPomBFqQP3tyGwqXRDqAHdN89S6uPu8QinFYCTWfZ3k0WJ3hg2EWriU0LzHPDO
	8KHynGzipMcBSDv6J85bnfUuw72WBWZTZcmZA8l6jMTj7N1gK04+iKXURnhZgIsmNZhsde
	Ir80m3EhBSd+DzVbsYbn43oop7VBnHc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1746089419;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=r5zIrmd5W9mcaRLQuezc6RZmJaUSbNbg4XZp0yaIFm4=;
	b=QntaoXpyGckBRK9h3U6A7HPb9az9ovf0QpcDepuVPTnft6nHBf2tYH06Bz4mYt/fVf+zBc
	rnj8BaZ3oC4sWxAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3403213931;
	Thu,  1 May 2025 08:50:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id kWQwDMs1E2h8DwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Thu, 01 May 2025 08:50:19 +0000
Date: Thu, 1 May 2025 10:50:13 +0200
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
Message-ID: <20250501085013.GL9140@suse.cz>
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
X-Rspamd-Queue-Id: 5B8211F388
X-Spam-Score: -4.21
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kvack.org,linux-foundation.org,infradead.org,google.com,kernel.org,redhat.com,linux.alibaba.com,gmail.com,cmpxchg.org,vger.kernel.org,fb.com,toxicpanda.com,suse.com];
	RCVD_COUNT_TWO(0.00)[2];
	MID_RHS_MATCH_FROM(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,suse.cz:mid,suse.cz:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,infradead.org:email,suse.com:email]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
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

The patch is from a series but seems to be independent. I'd like to take
it through the btrfs tree unless you have other work that depends on it.

