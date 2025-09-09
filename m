Return-Path: <linux-btrfs+bounces-16761-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 64E63B508FB
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Sep 2025 00:45:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C268D1C23E6D
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 Sep 2025 22:46:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DADC4271A7B;
	Tue,  9 Sep 2025 22:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="oqMLEUZu";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="v5PVoV0y";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="oqMLEUZu";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="v5PVoV0y"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DE701E3DD7
	for <linux-btrfs@vger.kernel.org>; Tue,  9 Sep 2025 22:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757457927; cv=none; b=gnFLkQh8ptqIw6ErNwNCdCgREYEYffkBdlxVNlFnYwjXa/u5zrQThAnNXa3cWyu8MrgR1S3+RUzIBqWuPdlYT7/j+vmij2XezBh0fpk7jVD+u0XCcweL+kGbGvrHdrH6VMqaxKDbjbfcebqWv9eiBYww/M4mCc3GtX0DvdOiif4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757457927; c=relaxed/simple;
	bh=2BzAX80FoSqqH7pexJgxDzbGJcjxbytEsAj+JMYLYZs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kHtTueQFw7zp+J543CBcInhUjAllg/2C6m9ig7wIrB+DOmn2T3Cnzx/AcflGf9cejfQbyKP76z7WXEaXnWKtNq4C+cFD4qsylO8OY7dF2TPiVSYZirPVA0uM/NcU8zTcsLrDBfddBsNR+MGt2z5kKWt8CMhz7u+qCAJCaxgKs1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=oqMLEUZu; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=v5PVoV0y; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=oqMLEUZu; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=v5PVoV0y; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3030320E7A;
	Tue,  9 Sep 2025 22:45:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1757457922;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SYMj1WDm8ZbNy8YqcRFPqkKLH0gfMOTBQZc9Nfwem8k=;
	b=oqMLEUZuQj0JJT7fm0Fkd0N68X3ZYuFMUw6Wp2ZZa4rnvK2GhM8my9clnqTTWnzaC6nFGr
	qG47Z8/b+aw+M/MCUpMAvRJG6TnpfDnAqB4d56PjppbxNPkntiIdqHUvSpwFeGFdnflzJP
	ZsBW/8aKJOwFtNoSOMX54htcFYF/0ug=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1757457922;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SYMj1WDm8ZbNy8YqcRFPqkKLH0gfMOTBQZc9Nfwem8k=;
	b=v5PVoV0yTLX7Oh6Fh5s1brhZeBs1LawJqVY7Wg65lsQnJ1ewuFSYxscm2xb65J4OV+lvpb
	BkvyDbKgI2nD6XDA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1757457922;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SYMj1WDm8ZbNy8YqcRFPqkKLH0gfMOTBQZc9Nfwem8k=;
	b=oqMLEUZuQj0JJT7fm0Fkd0N68X3ZYuFMUw6Wp2ZZa4rnvK2GhM8my9clnqTTWnzaC6nFGr
	qG47Z8/b+aw+M/MCUpMAvRJG6TnpfDnAqB4d56PjppbxNPkntiIdqHUvSpwFeGFdnflzJP
	ZsBW/8aKJOwFtNoSOMX54htcFYF/0ug=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1757457922;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SYMj1WDm8ZbNy8YqcRFPqkKLH0gfMOTBQZc9Nfwem8k=;
	b=v5PVoV0yTLX7Oh6Fh5s1brhZeBs1LawJqVY7Wg65lsQnJ1ewuFSYxscm2xb65J4OV+lvpb
	BkvyDbKgI2nD6XDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0B4121388C;
	Tue,  9 Sep 2025 22:45:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 4DtKAgKuwGhYBAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 09 Sep 2025 22:45:22 +0000
Date: Wed, 10 Sep 2025 00:45:20 +0200
From: David Sterba <dsterba@suse.cz>
To: Anderson Nascimento <anderson@allelesecurity.com>
Cc: clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] btrfs: Avoid potential out-of-bounds in btrfs_encode_fh()
Message-ID: <20250909224520.GC5333@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <0cc81bcf-b830-4ec3-8d5e-67afbc2e7c47@allelesecurity.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0cc81bcf-b830-4ec3-8d5e-67afbc2e7c47@allelesecurity.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_ALL(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -4.00

On Mon, Sep 08, 2025 at 09:49:02AM -0300, Anderson Nascimento wrote:
> Hello all,
> 
> The function btrfs_encode_fh() does not properly account for the three 
> cases it handles.
> 
> Before writing to the file handle (fh), the function only returns to the 
> user BTRFS_FID_SIZE_NON_CONNECTABLE (5 dwords, 20 bytes) or 
> BTRFS_FID_SIZE_CONNECTABLE (8 dwords, 32 bytes).
> 
> However, when a parent exists and the root ID of the parent and the 
> inode are different, the function writes BTRFS_FID_SIZE_CONNECTABLE_ROOT 
> (10 dwords, 40 bytes).
> 
> If *max_len is not large enough, this write goes out of bounds because 
> BTRFS_FID_SIZE_CONNECTABLE_ROOT is greater than 
> BTRFS_FID_SIZE_CONNECTABLE originally returned.
> 
> This results in an 8-byte out-of-bounds write at 
> fid->parent_root_objectid = parent_root_id.
> 
> A previous attempt to fix this issue was made but was lost.
> 
> https://lore.kernel.org/all/4CADAEEC020000780001B32C@vpn.id2.novell.com/
> 
> Although this issue does not seem to be easily triggerable, it is a 
> potential memory corruption bug that should be fixed. This patch 
> resolves the issue by ensuring the function returns the appropriate size 
> for all three cases and validates that *max_len is large enough before 
> writing any data.
> 
> Tested on v6.17-rc4.
> 
> Fixes: be6e8dc0ba84 ("NFS support for btrfs - v3")
> Signed-off-by: Anderson Nascimento <anderson@allelesecurity.com>

Thanks for finding the problem and the fix. It's 17 years old though the
other patch was sent about 2 years after btrfs merge to linux kernel.
I'll add it to for-next, with the minor whitespace issues fixed.

