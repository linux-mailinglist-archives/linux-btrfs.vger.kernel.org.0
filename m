Return-Path: <linux-btrfs+bounces-5671-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 71C53905C31
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Jun 2024 21:42:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87B1B1C20B4E
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Jun 2024 19:42:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2597983CD3;
	Wed, 12 Jun 2024 19:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="yyWzsb8m";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Em+87GBi";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="yyWzsb8m";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Em+87GBi"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD48283A12
	for <linux-btrfs@vger.kernel.org>; Wed, 12 Jun 2024 19:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718221363; cv=none; b=FZ8RRSU11CIym0Tc4+rErFnt20bgi+mtEsbRip8xd5e9JOlGBPZ6jzj3hsAvH1dIOBk39lXMPOYFjTYfTfxClN+Z61hj1EcEWl6hYAqYfXVT8ooRcl69jGfk3K9sq5F9ypJGwZaDUcqQGK0+PsEXPb+S9FniwlhC7+swgGso1b4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718221363; c=relaxed/simple;
	bh=KrgeqirmTZGmfAAb25VVpAUPqjNcU/hy9bSDbJZoSv8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=olyvk+4OM6RE27XyqR1N4oIQZ015hBJ9JIXcgJo/p+S1Ev2UMJAIoqmUKGwMh8OswmtFMtLwXWjqdPHefmcN6V2hKu//ejBMGblxe/jGTY53/ZQykBUQkwY9NKLBtMVkidXRIBUT4XY2Bo1QjW9LHjczZ8i1JfiE0qowha1AzTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=yyWzsb8m; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Em+87GBi; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=yyWzsb8m; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Em+87GBi; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9570A3482F;
	Wed, 12 Jun 2024 19:42:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1718221359;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KrgeqirmTZGmfAAb25VVpAUPqjNcU/hy9bSDbJZoSv8=;
	b=yyWzsb8mYX0qTCA4mZ5DelqjqQi+Uh6nTAbeqr4Mlv5umzYmfzuQ0i9YP5FwAwjRdgN5WV
	cD2zmK7pTSds4KZYV9/TN0fZKJAtqXINZezBZWb6GxixcDu4TBkCV8jrAYe8mHRSoiMbLL
	LBEE7BW2Cm0kOHZsACEie/t//vHqM7k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1718221359;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KrgeqirmTZGmfAAb25VVpAUPqjNcU/hy9bSDbJZoSv8=;
	b=Em+87GBi5Id2UWCcvphAOPdI8v3dKLr3LWyKnIEhcCGCkxFRyr1llmkAMnMrL1l26O5QmK
	zzyFa/rWCBr+SrCQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=yyWzsb8m;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=Em+87GBi
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1718221359;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KrgeqirmTZGmfAAb25VVpAUPqjNcU/hy9bSDbJZoSv8=;
	b=yyWzsb8mYX0qTCA4mZ5DelqjqQi+Uh6nTAbeqr4Mlv5umzYmfzuQ0i9YP5FwAwjRdgN5WV
	cD2zmK7pTSds4KZYV9/TN0fZKJAtqXINZezBZWb6GxixcDu4TBkCV8jrAYe8mHRSoiMbLL
	LBEE7BW2Cm0kOHZsACEie/t//vHqM7k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1718221359;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KrgeqirmTZGmfAAb25VVpAUPqjNcU/hy9bSDbJZoSv8=;
	b=Em+87GBi5Id2UWCcvphAOPdI8v3dKLr3LWyKnIEhcCGCkxFRyr1llmkAMnMrL1l26O5QmK
	zzyFa/rWCBr+SrCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7EACF132FF;
	Wed, 12 Jun 2024 19:42:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id NUS+Hi/6aWZzIAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Wed, 12 Jun 2024 19:42:39 +0000
Date: Wed, 12 Jun 2024 21:42:34 +0200
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 4/4] btrfs: introduce new "rescue=ignoresuperflags" mount
 option
Message-ID: <20240612194234.GL18508@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1718082585.git.wqu@suse.com>
 <f76f3c993b70aead20d19390f430a1a03a0370c2.1718082585.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f76f3c993b70aead20d19390f430a1a03a0370c2.1718082585.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Queue-Id: 9570A3482F
X-Spam-Score: -4.21
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DWL_DNSWL_BLOCKED(0.00)[suse.cz:dkim];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,suse.cz:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org

On Tue, Jun 11, 2024 at 02:51:38PM +0930, Qu Wenruo wrote:
> This new mount option would allow the kernel to skip the super flags
> check, it's mostly to allow the kernel to do a rescue mount of an
> interrupted checksum conversion.

This is for future-proofing but the current known super flags should be
at least defined in the kernel code and with a warning or info message.
BTRFS_SUPER_FLAG_CHANGING_FSID and _V2.

Same comment as for the imetacsum, missing sysfs.c entry.

