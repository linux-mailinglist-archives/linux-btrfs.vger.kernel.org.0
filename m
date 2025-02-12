Return-Path: <linux-btrfs+bounces-11425-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 98A98A3334F
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Feb 2025 00:21:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29A36188B097
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Feb 2025 23:21:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2639C24C692;
	Wed, 12 Feb 2025 23:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="VoEL98Pw";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="wjHD0noc";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="VoEL98Pw";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="wjHD0noc"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B841220011F;
	Wed, 12 Feb 2025 23:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739402490; cv=none; b=uYmFtk13jRtlzrqJ7wVUgQ2uGV56alSy+fEAJjCHNosvYryDVLkMo3gMh76XiXYBTKrXv8a+GvVkn4eZkN9UYhFoKuiX72S4De+LGQORWpuHyw7mh4SksHyaPGhnGcSJ7xqkXZZLq8cZfjnr5wtX05GSFsvTqML+7Rm4goDDCpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739402490; c=relaxed/simple;
	bh=NpAEOSGf+XP2VDCu+JFeA55vDL5d6E5QsNLX6kcwwes=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JXGXiVITUDqGA/ugrf8SjN6rfp5cHgwaM2w0TlJ9PKf9zvaWP3rOxVf5EWu1M6FVWa1Ve4ra5AIcU/8qE7lhKuzYbVuhv+3WW6oIbNKOJaRTuqrfGtEV4dEQjHoGc3eQLLhLy+OyzPy8ACFbSGosjJuHDntryH2uhWtAIEfLLv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=VoEL98Pw; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=wjHD0noc; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=VoEL98Pw; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=wjHD0noc; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C54F21F74D;
	Wed, 12 Feb 2025 23:21:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1739402486;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4r2GUZgpBiAJzjqH6WGAsNcYvbP8FRaTXHKsMdUSxr0=;
	b=VoEL98PwHCcqMfxbyjGe3+YPG8/bIq5zCrc7/iN2SjBHE5esnqOiGhiUTVYR6HYQQS4D+S
	nj0wYroh+2iCxEJ6SigfEbay6czMwpzO892BDaDjtyo/coP2D6sHlWl/GFXzrJ/k6lXVGS
	gAb/0rWimc99g4jb8XQ57p72ZSw0tPQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1739402486;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4r2GUZgpBiAJzjqH6WGAsNcYvbP8FRaTXHKsMdUSxr0=;
	b=wjHD0noc07WXWoN709c81Xe7MU/I5z/qmG8xY1vQpcPPDZWutndLopKHdebS9DlQbzBn1o
	JSPigmM2H8tH9CDg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=VoEL98Pw;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=wjHD0noc
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1739402486;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4r2GUZgpBiAJzjqH6WGAsNcYvbP8FRaTXHKsMdUSxr0=;
	b=VoEL98PwHCcqMfxbyjGe3+YPG8/bIq5zCrc7/iN2SjBHE5esnqOiGhiUTVYR6HYQQS4D+S
	nj0wYroh+2iCxEJ6SigfEbay6czMwpzO892BDaDjtyo/coP2D6sHlWl/GFXzrJ/k6lXVGS
	gAb/0rWimc99g4jb8XQ57p72ZSw0tPQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1739402486;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4r2GUZgpBiAJzjqH6WGAsNcYvbP8FRaTXHKsMdUSxr0=;
	b=wjHD0noc07WXWoN709c81Xe7MU/I5z/qmG8xY1vQpcPPDZWutndLopKHdebS9DlQbzBn1o
	JSPigmM2H8tH9CDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B2DD113874;
	Wed, 12 Feb 2025 23:21:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 9sJwK/YsrWcsWAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Wed, 12 Feb 2025 23:21:26 +0000
Date: Thu, 13 Feb 2025 00:21:21 +0100
From: David Sterba <dsterba@suse.cz>
To: fdmanana@kernel.org
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
	Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH 8/8] btrfs: skip tests that exercise compression property
 when using nodatasum
Message-ID: <20250212232121.GZ5777@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1739379182.git.fdmanana@suse.com>
 <ef820042ceee48a9f0aac3eaae34e3abf4094573.1739379186.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ef820042ceee48a9f0aac3eaae34e3abf4094573.1739379186.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Queue-Id: C54F21F74D
X-Spam-Score: -4.21
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Wed, Feb 12, 2025 at 05:01:56PM +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> A couple tests exercise the compression property and that fails when an
> inode has the nodatasum flag set. So skip the tests when running under the
> nodatasum mount option.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: David Sterba <dsterba@suse.com>

