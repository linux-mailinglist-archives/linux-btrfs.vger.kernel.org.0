Return-Path: <linux-btrfs+bounces-20141-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A1560CF7D92
	for <lists+linux-btrfs@lfdr.de>; Tue, 06 Jan 2026 11:44:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 90ACD301B5BD
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Jan 2026 10:44:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C10E133D6D4;
	Tue,  6 Jan 2026 10:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="O/Qhwo3F";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ZlRDNaCe";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="UGo07/80";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="gd9iqkrZ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 925E9322B8D
	for <linux-btrfs@vger.kernel.org>; Tue,  6 Jan 2026 10:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767696283; cv=none; b=oCtMshgcno1kWAXiqrXs+snkYKG6MUUhXlQkDNIkAEZe/pY1V7+S8Ib8B9B9J4VJV/Xs/kWw4UkQ+L7I6uvOCjBwPhfTFKOl2Jl72h2bcw3v4VY8FjpiRQzNNIUxyzzJYAsOsKKkUlBQum25rjQbRfyyrv/C3PqsH5YkqiXh7jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767696283; c=relaxed/simple;
	bh=MZ4+UIAtO8bG/IchaGogED4ciKnLVgSA+QzIWrBc0EE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cRm6nAoA1t3GZYUakf1wd7IN3asy7V8QqvAmRfGjmXLeoH8V5PgSIukU5ZJb/oiV611gXAFZokr76EcEOs8MGx2w8e6tXUiShC0oCDS52JCEvon1mejiDgJULt7IPAn/TPWauJMgIuLq7hvehwrDtwyCLeF7/lgAH1X0VL6mODg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=O/Qhwo3F; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ZlRDNaCe; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=UGo07/80; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=gd9iqkrZ; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8A772339E2;
	Tue,  6 Jan 2026 10:44:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1767696279;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XbOEnUCmnoAVbWz+b8i6WoJVstdgrgWKtCLKjY14lv8=;
	b=O/Qhwo3F+6lQMf1M+EzUhnnUGS3vCjdnMngrOsb0IjEpNk4NsB2mCdi9CE0ic+m28ohUHW
	be0qZ4lbQZfIVArnaxOSlyjnKy7r7yEPHKhYEEJjaHcGFTySTzCQutvh4n0QeIYXX4UX0v
	cVwiZRX/Y2WpLzmgJ/xfH4fJqVWqmO4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1767696279;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XbOEnUCmnoAVbWz+b8i6WoJVstdgrgWKtCLKjY14lv8=;
	b=ZlRDNaCe74J5QtvaTuoj0+g7H2LpdvRTJi0tKstnze7eBQX9nLFvfVhcd9WK110XlqoiUj
	rMvtYiyBmKSRE3Ag==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="UGo07/80";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=gd9iqkrZ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1767696278;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XbOEnUCmnoAVbWz+b8i6WoJVstdgrgWKtCLKjY14lv8=;
	b=UGo07/80LUWVQwXULpGD4ENHXdEkwEydq7oByXf7RZKxDYjfDIlBHvg2dQZ3yznPpdR9db
	u1nvBXdTEGq3FwB8hhSrRx5IzJ9V1qvHZa0ItqT6xvRqW5Vl1z8KhSr4n2etOk6kLgc4yw
	KqksEyWORgcdI/NJSiJTLuY2u4dYZHw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1767696278;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XbOEnUCmnoAVbWz+b8i6WoJVstdgrgWKtCLKjY14lv8=;
	b=gd9iqkrZChqMkZaraTP+JLRu1Ym/Oz7XIR/WnutJerrPnVmP8vmpkOi0FKFDenyhbuP7R4
	FsXjk3JmwJ04QODQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7F1173EA63;
	Tue,  6 Jan 2026 10:44:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id frDZHpbnXGl4LAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 06 Jan 2026 10:44:38 +0000
Date: Tue, 6 Jan 2026 11:44:33 +0100
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2] btrfs: reject single block sized compression early
Message-ID: <20260106104433.GA21071@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <89c6eb7756051dbe2e63693b5051394b16a9080b.1767667652.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <89c6eb7756051dbe2e63693b5051394b16a9080b.1767667652.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-0.996];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCPT_COUNT_TWO(0.00)[2];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:replyto]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spam-Level: 
X-Rspamd-Queue-Id: 8A772339E2
X-Spam-Flag: NO
X-Spam-Score: -4.21

On Tue, Jan 06, 2026 at 01:20:30PM +1030, Qu Wenruo wrote:
> Currently for an inode that needs compression, even if there is a delalloc
> range that is single fs block sized and can not be inlined, we will
> still go through the compression path.
> 
> Then inside compress_file_range(), we have one extra check to reject
> single block sized range, and fall back to regular uncompressed write.
> 
> This rejection is in fact a little too late, we have already allocated
> memory to async_chunk, delayed the submission, just to fallback to the
> same uncompressed write.
> 
> Change the behavior to reject such cases earlier at
> inode_need_compress(), so for such single block sized range we won't
> even bother trying to go through compress path.
> 
> And since the inline small block check is inside inode_need_compress()
> and compress_file_range() also calls that function, we no longer need a
> dedicate check inside compress_file_range().
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Reviewed-by: David Sterba <dsterba@suse.com>

