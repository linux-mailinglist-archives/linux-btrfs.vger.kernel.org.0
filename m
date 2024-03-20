Return-Path: <linux-btrfs+bounces-3480-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1F2C881586
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 Mar 2024 17:22:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D30BBB232D3
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 Mar 2024 16:22:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6DB854FBB;
	Wed, 20 Mar 2024 16:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="bF5heiU9";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="McsXNZ/m";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="JDIcfAXn";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ZQHvRJC6"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 081F754BFD;
	Wed, 20 Mar 2024 16:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710951716; cv=none; b=gSpy9NnFdV2MCxoUKcsGLwnDmjQ00jUh0zWePc994zC/pI7/Aq/peIKigdWQ45ykDBVEwbsLaZCbWlCsiktJojXVUYIy27mMAfZ+6JyZMJ/3vzA5JSowT2RUG3TXr7MSf1rfy07c7Aol60MbKtDCMWjZJ2aVUY1S7VV++iIqxKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710951716; c=relaxed/simple;
	bh=ZmXcOT2M7y1OmxH/SEp9ytHnYcwwQWvq2UwG3089PQU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tI7I/EE+OEjwglGlKl/FvrCeq6jUrJV3mDHfoalaXDYvHoNwmZrVGk8ph2+9DqqjB0FVmGLoSeeS5k0m2LMeuFkF9IqOlMNQVSW+dtq4PlCOL9A5ALaETxtRZiDFMFiLDvxmwqX+cqk/z/VkPAnR8xclgKv+NCxHKPqZdXGem6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=bF5heiU9; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=McsXNZ/m; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=JDIcfAXn; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ZQHvRJC6; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id BD1BF5BF34;
	Wed, 20 Mar 2024 16:21:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1710951712;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ulbF0+b/Gh4h1bLzsnJVEAgXjbVqI/QZ2p0fDeGTGWc=;
	b=bF5heiU9lZlOxJ7sb27QO9chlKb3kbhK7em6NtYKoN7YBYVxitQCBUUh36OYpm3pmjGcnF
	3waG4fSEVrUyNMY3+9Zxn4z260/sd1qo1jBfjyJ4OSOCyAjDy8GPH3rPEwUfwRm2MUwqhJ
	gzCcHCr/x0HzFdGKMF0KVFBuf/sZJZQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1710951712;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ulbF0+b/Gh4h1bLzsnJVEAgXjbVqI/QZ2p0fDeGTGWc=;
	b=McsXNZ/mbf8MeBIaJemGCPCpS4SUFpZLu87Gl5brQVnG8obcHAecuE99YzRQk7DM78ZxyK
	rwfO4KfVQ8oeAHBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1710951711;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ulbF0+b/Gh4h1bLzsnJVEAgXjbVqI/QZ2p0fDeGTGWc=;
	b=JDIcfAXnDteeFPv+o9oBlO1bHyYU0fRPgMQ5j7Htgnz0KLdk4TLUa0tnRv3I1POz+O4tXl
	T6ciwjBmFIV32CwBSfcUm8w+TpDuPK2/1H1Ks9lHO3ZOg98+SsZCMWzOuq4pJGn6jxj4mv
	Pq/uzGDP6fHruG5ikDHmVWzyRrsWBPY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1710951711;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ulbF0+b/Gh4h1bLzsnJVEAgXjbVqI/QZ2p0fDeGTGWc=;
	b=ZQHvRJC6fn4T+b6WK/fikmf2EAXzHJWDlsbn0Ym/bnnWofpPtSjM8OIolzNG5rFMNTPWBr
	38hXFWq+fPpU9zBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9922C136D6;
	Wed, 20 Mar 2024 16:21:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id m4YzJR8N+2WdZgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Wed, 20 Mar 2024 16:21:51 +0000
Date: Wed, 20 Mar 2024 17:14:33 +0100
From: David Sterba <dsterba@suse.cz>
To: Maximilian Heyne <mheyne@amazon.de>
Cc: Goldwyn Rodrigues <rgoldwyn@suse.com>,
	Anand Jain <anand.jain@oracle.com>, David Sterba <dsterba@suse.com>,
	stable@vger.kernel.org, Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] btrfs: allocate btrfs_ioctl_defrag_range_args on stack
Message-ID: <20240320161433.GF14596@suse.cz>
Reply-To: dsterba@suse.cz
References: <20240320113156.22283-1-mheyne@amazon.de>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240320113156.22283-1-mheyne@amazon.de>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=JDIcfAXn;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=ZQHvRJC6
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-1.31 / 50.00];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 TO_DN_SOME(0.00)[];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[9];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_MATCH_FROM(0.00)[];
	 BAYES_HAM(-0.10)[65.31%];
	 ARC_NA(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 FROM_HAS_DN(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.com:email,oracle.com:email,amazon.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -1.31
X-Rspamd-Queue-Id: BD1BF5BF34
X-Spam-Flag: NO

On Wed, Mar 20, 2024 at 11:31:56AM +0000, Maximilian Heyne wrote:
> From: Goldwyn Rodrigues <rgoldwyn@suse.com>
> 
> commit c853a5783ebe123847886d432354931874367292 upstream.
> 
> Instead of using kmalloc() to allocate btrfs_ioctl_defrag_range_args,
> allocate btrfs_ioctl_defrag_range_args on stack, the size is reasonably
> small and ioctls are called in process context.
> 
> sizeof(btrfs_ioctl_defrag_range_args) = 48
> 
> Reviewed-by: Anand Jain <anand.jain@oracle.com>
> Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
> Reviewed-by: David Sterba <dsterba@suse.com>
> Signed-off-by: David Sterba <dsterba@suse.com>
> CC: stable@vger.kernel.org # 4.14+
> [ This patch is needed to fix a memory leak of "range" that was
> introduced when commit 173431b274a9 ("btrfs: defrag: reject unknown
> flags of btrfs_ioctl_defrag_range_args") was backported to kernels
> lacking this patch. Now with these two patches applied in reverse order,
> range->flags needed to change back to range.flags.
> This bug was discovered and resolved using Coverity Static Analysis
> Security Testing (SAST) by Synopsys, Inc.]
> Signed-off-by: Maximilian Heyne <mheyne@amazon.de>

Acked-by: David Sterba <dsterba@suse.com>

for backport to stable as a prerequisite for 173431b274a9a5 ("btrfs:
defrag: reject unknown flags of btrfs_ioctl_defrag_range_args").

