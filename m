Return-Path: <linux-btrfs+bounces-1569-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FBBB832BC4
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Jan 2024 15:54:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC77A2832A0
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Jan 2024 14:54:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0423854BFA;
	Fri, 19 Jan 2024 14:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="xIXDyU75";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="N0471no9";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="xIXDyU75";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="N0471no9"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 506205475D
	for <linux-btrfs@vger.kernel.org>; Fri, 19 Jan 2024 14:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705676016; cv=none; b=YWI1JCFnY6jOVG6tML1EKvDmS4kHG56+A2L42g+LmiLFrxQAKOjEjuJH5ItaVIhEXeI40mLFJ0DlaCf9gsKjQmWE3BLGxIDttOrVCGRIGyBezx+asGYe0OGOKZVuziNJ9+mxwOeefvr4CxYsffBzhnyo9YILFJxG1vdw/oSIDxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705676016; c=relaxed/simple;
	bh=ZAY/5y9gMfePD7Csto3KZfiroyAxcvCEqOUfghlzXho=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F+B83B1tPlmW9rl+PVrPpViCBb4Bk96CSwpoLStlBZDA1Y0HkoL3YsgLdlGbJuj/5f9ihQNtoFCP2y0OTiOnZZWfcQdpskEFNUt3qKicp9wtC03qWtuigTVwyBB+uSM8uLt4wJoUU8XT72kYPV3coDyG0EWp48GILkvB4GKwwn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=xIXDyU75; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=N0471no9; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=xIXDyU75; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=N0471no9; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2F69221E24;
	Fri, 19 Jan 2024 14:53:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1705676012;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CkM0obDGl5da83gxgecLpuAuKSdMqzH7HNygbwer5Lg=;
	b=xIXDyU75hZhCArPuu8f2gN8hlYMeZBhsF+gHL+Xkj9Xfba1qHH7uDhcUiH+r07YpdXkyXJ
	/lGW9EWd50CDMsgnKX3YQGlYl4yAPOgdIlkhmtSjpXhkvmLLQgGqUIGwo3m/Xnb1W+7ZbM
	/iJ5W+HIKBwO85zVkb2r4MCS/03C30k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1705676012;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CkM0obDGl5da83gxgecLpuAuKSdMqzH7HNygbwer5Lg=;
	b=N0471no97294wDq9C3MsGScPNVJKgYOFMgUDNZpQzzgobPhTX5xLCNaaoogyTIC54hCYKj
	HNXPGNFN1xwcq9Dg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1705676012;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CkM0obDGl5da83gxgecLpuAuKSdMqzH7HNygbwer5Lg=;
	b=xIXDyU75hZhCArPuu8f2gN8hlYMeZBhsF+gHL+Xkj9Xfba1qHH7uDhcUiH+r07YpdXkyXJ
	/lGW9EWd50CDMsgnKX3YQGlYl4yAPOgdIlkhmtSjpXhkvmLLQgGqUIGwo3m/Xnb1W+7ZbM
	/iJ5W+HIKBwO85zVkb2r4MCS/03C30k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1705676012;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CkM0obDGl5da83gxgecLpuAuKSdMqzH7HNygbwer5Lg=;
	b=N0471no97294wDq9C3MsGScPNVJKgYOFMgUDNZpQzzgobPhTX5xLCNaaoogyTIC54hCYKj
	HNXPGNFN1xwcq9Dg==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 19F0B133DC;
	Fri, 19 Jan 2024 14:53:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id V4SyBeyMqmUFAwAAn2gu4w
	(envelope-from <dsterba@suse.cz>); Fri, 19 Jan 2024 14:53:32 +0000
Date: Fri, 19 Jan 2024 15:53:12 +0100
From: David Sterba <dsterba@suse.cz>
To: Goldwyn Rodrigues <rgoldwyn@suse.de>
Cc: linux-btrfs@vger.kernel.org, Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: Re: [PATCH 1/4] btrfs: Use IS_ERR() instead of checking folio for
 NULL
Message-ID: <20240119145312.GR31555@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1705605787.git.rgoldwyn@suse.com>
 <e4df9a1068c81f3edeee9bbb4e63d1d453be569b.1705605787.git.rgoldwyn@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e4df9a1068c81f3edeee9bbb4e63d1d453be569b.1705605787.git.rgoldwyn@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=xIXDyU75;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=N0471no9
X-Spamd-Result: default: False [-0.10 / 50.00];
	 ARC_NA(0.00)[];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[3];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.09)[64.55%]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: -0.10
X-Rspamd-Queue-Id: 2F69221E24
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Bar: /

On Thu, Jan 18, 2024 at 01:46:37PM -0600, Goldwyn Rodrigues wrote:
> From: Goldwyn Rodrigues <rgoldwyn@suse.com>
> 
> __filemap_get_folio() returns an error instead of a NULL pointer. Use
> IS_ERR() to check if folio is not returned.
> 
> As we are fixing this, use set_folio_extent_mapped() instead of
> set_page_extent_mapped().
> 
> Fixes: f8809b1f6a3e btrfs: page to folio conversion in btrfs_truncate_block()

This is still in for-next so the fixup should be squashed there.

