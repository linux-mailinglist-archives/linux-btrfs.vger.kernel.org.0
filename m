Return-Path: <linux-btrfs+bounces-1811-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 98DDA83CF67
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 Jan 2024 23:32:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F7361F22DC1
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 Jan 2024 22:32:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ABC010A2D;
	Thu, 25 Jan 2024 22:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="n1G5QWRU";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="8rSc+QVz";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="n1G5QWRU";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="8rSc+QVz"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 297C51877
	for <linux-btrfs@vger.kernel.org>; Thu, 25 Jan 2024 22:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706221920; cv=none; b=CyovDXv8UY1N69GbL4Ucm/W/E1Q345v2JucAu6Oa4Xt/lNEKi3bg6jIfOs+X4YvkhsPh/O1Oki4+9k+gm+pdbBKVRVTnZQWJFJQcXvk0dicqfGyq4kCEyXf0rWRt35r6PwgSbrtY6W6Z43iJxq5piKG3lgekzwXctZriW9Z0Pes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706221920; c=relaxed/simple;
	bh=TJbdxxuENa0IZ3n6riqUr+cSn4qdzCIVhamSoZEsSR4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eqnuRrfHezzLgdFCa5LG40zYN+Dn3gL7t74lureRUhBl/SyYLSWA9s7PHf6ma/IQC69rYB8a1iWhbGz6y4AWFZdgajv5X4GtpWcgD3t+4vsG4ZfF3tAls0fth0uyFUsdeKvWeHB23KQj29vla8SsmEYuYnxym/egPcQiyuQew8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=n1G5QWRU; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=8rSc+QVz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=n1G5QWRU; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=8rSc+QVz; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 106562249D;
	Thu, 25 Jan 2024 22:31:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1706221913;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tT9QVdNHLiKheOuX2h5tDHL1mZ7OGm3a1B2G8zdquYE=;
	b=n1G5QWRUf2A9fndRpMZ799hEu6B6XpmyDW1GiQOy+HmYK3vn7g0S/Uy8WoGSgR7AVDyO/5
	vrw8epHJrga815zq3CvReV2FdKUzPBwyrkH3cp1Amuk7x4wPqgjmkWneR261ti5Gr3KDFc
	M7NBsrj4JVOyF0t/lShwVTHpcVQa2gU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1706221913;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tT9QVdNHLiKheOuX2h5tDHL1mZ7OGm3a1B2G8zdquYE=;
	b=8rSc+QVz0QYvIGc4o7I1t7UH5bb/vgkzDsQcGWxdndN/ZRE+QmANHaxHDxr5n34GSmO6Ro
	Nj3HBJqP/Paa8ECA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1706221913;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tT9QVdNHLiKheOuX2h5tDHL1mZ7OGm3a1B2G8zdquYE=;
	b=n1G5QWRUf2A9fndRpMZ799hEu6B6XpmyDW1GiQOy+HmYK3vn7g0S/Uy8WoGSgR7AVDyO/5
	vrw8epHJrga815zq3CvReV2FdKUzPBwyrkH3cp1Amuk7x4wPqgjmkWneR261ti5Gr3KDFc
	M7NBsrj4JVOyF0t/lShwVTHpcVQa2gU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1706221913;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tT9QVdNHLiKheOuX2h5tDHL1mZ7OGm3a1B2G8zdquYE=;
	b=8rSc+QVz0QYvIGc4o7I1t7UH5bb/vgkzDsQcGWxdndN/ZRE+QmANHaxHDxr5n34GSmO6Ro
	Nj3HBJqP/Paa8ECA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EB98213649;
	Thu, 25 Jan 2024 22:31:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id dHZSOVjhsmX1XwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Thu, 25 Jan 2024 22:31:52 +0000
Date: Thu, 25 Jan 2024 23:31:30 +0100
From: David Sterba <dsterba@suse.cz>
To: David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: remove unused included headers
Message-ID: <20240125223130.GS31555@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20240125164448.18552-1-dsterba@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240125164448.18552-1-dsterba@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=n1G5QWRU;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=8rSc+QVz
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-1.21 / 50.00];
	 ARC_NA(0.00)[];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 RCPT_COUNT_TWO(0.00)[2];
	 MX_GOOD(-0.01)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 NEURAL_HAM_SHORT(-0.20)[-0.995];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.00)[39.93%]
X-Spam-Score: -1.21
X-Rspamd-Queue-Id: 106562249D
X-Spam-Flag: NO

On Thu, Jan 25, 2024 at 05:44:47PM +0100, David Sterba wrote:
> With help of neovim, LSP and clangd we can identify header files that
> are not actually needed to be included in the .c files. This is focused
> only on removal (with minor fixups), further cleanups are possible but
> will require doing the header files properly with forward declarations,
> minimized includes and include-what-you-use care.
> 
> Signed-off-by: David Sterba <dsterba@suse.com>
> ---
> 
> I did extensive build checks with various config options turned on/off,
> this will become part of our CI eventually.

Build tests are now available in the CI when a PR is sent against branch
'build'.

