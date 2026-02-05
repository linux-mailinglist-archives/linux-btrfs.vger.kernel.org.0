Return-Path: <linux-btrfs+bounces-21387-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CMkvIk+IhGl43QMAu9opvQ
	(envelope-from <linux-btrfs+bounces-21387-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Thu, 05 Feb 2026 13:08:47 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E2027F23AE
	for <lists+linux-btrfs@lfdr.de>; Thu, 05 Feb 2026 13:08:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CBBEE30528B1
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Feb 2026 12:04:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6344F3A7F62;
	Thu,  5 Feb 2026 12:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="q1fyMGdf";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="KcWtK669";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="LlRm7ZIc";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Z7aNsVkS"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E1656F2F2
	for <linux-btrfs@vger.kernel.org>; Thu,  5 Feb 2026 12:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770293065; cv=none; b=KY6pLIMMRpgxUGYq8rl4/inVYzpS2Dy7coXrBxlBh63DKEvmu+7Wl/zeyfbFBPL1/qrdglAL1T5aq9LP2oM5yyIYqCLMtxHftMvceOy7CPKbv9/aqej3zXPE89rDVIiz9CUkLXNK+GbHQ4Jrlwk9itJcbaMrurjkXodrH7ccQe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770293065; c=relaxed/simple;
	bh=lwxtpGKILX4L2AY0GTC3KoCjkgrwIWkCdRZEWPIPRoE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WxJcq4Rqki8I246fZV5O0ptX8GfSR9H7shIHkhRrGBKLFB1DBlfq9E/eL5ckXpSBQprMEkGNhaRn0kZgkT2eXpyloFHd0H2bfRCcN8VVsZoUJwqRhvYEnS3zaOhpkT4geP9mIXvKUtQuR55c21lZcdrf3i/nIWZQErTAtg94SlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=q1fyMGdf; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=KcWtK669; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=LlRm7ZIc; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Z7aNsVkS; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 76D885BD94;
	Thu,  5 Feb 2026 12:04:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1770293063;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=C1LF9Plv7lRAF4OVgHL+oR2523xKP4VVOdRMpXsJpzg=;
	b=q1fyMGdfb0wzS/7neJrl4T83cSomNTbOvrrtlM+PVCB/4J47+wW+X229DxlGywauM4mbG1
	zrQ9cajlJ/kM4qRdAzlX+dRfCIYxXHNfsuw6t05eeqRCOH5Sd0b/UAgk2SigR+AIDDRq6f
	fw9jJU2aW2Bm70j9CxlevYB2ghhfsNk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1770293063;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=C1LF9Plv7lRAF4OVgHL+oR2523xKP4VVOdRMpXsJpzg=;
	b=KcWtK669cwe8EOlHK5qc1wnhya6hHLY1tLbdNhKfWP5GrZM2vP4oQ4fr3SFbo0OJBsappi
	8aofj9zBc2110bAQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=LlRm7ZIc;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=Z7aNsVkS
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1770293062;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=C1LF9Plv7lRAF4OVgHL+oR2523xKP4VVOdRMpXsJpzg=;
	b=LlRm7ZIcZTnuVmXCA3S6Y78hbF3xbSfh2oD/P1+pfiFcSI/ws9EaOxS+kxXNDdPxMy1j9O
	N+ER+qiNSe0XaWavUSE5GIWhN87zehvJMXz1l9Q/VW7ZXq+eObt07g9xTWcXDTpjTafYOK
	1m0L3bIdoB1Vj5F3St6Ru1UjkmVF+bA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1770293062;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=C1LF9Plv7lRAF4OVgHL+oR2523xKP4VVOdRMpXsJpzg=;
	b=Z7aNsVkSMeT9whhCVBDgaSwhJ9XHIY9kQ9tvi2mqA2A7K7/JyDjAMCnyuse+DIpVf2rFDW
	RtQrvKZmJetGbDCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 52CA03EA63;
	Thu,  5 Feb 2026 12:04:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 0PUNFEaHhGlFLwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Thu, 05 Feb 2026 12:04:22 +0000
Date: Thu, 5 Feb 2026 13:04:21 +0100
From: David Sterba <dsterba@suse.cz>
To: fdmanana@kernel.org
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 2/7] btrfs: mark all error and warning checks as unlikely
 in btrfs_validate_super()
Message-ID: <20260205120421.GV26902@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1770212626.git.fdmanana@suse.com>
 <09f9fef601b39776ad0f0c9b46c645f6866b2a17.1770212626.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <09f9fef601b39776ad0f0c9b46c645f6866b2a17.1770212626.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Flag: NO
X-Spam-Score: -4.21
X-Spam-Level: 
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21387-lists,linux-btrfs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_TLS_LAST(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[suse.cz];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	HAS_REPLYTO(0.00)[dsterba@suse.cz];
	RCVD_COUNT_FIVE(0.00)[6];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dsterba@suse.cz,linux-btrfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.cz:replyto,suse.cz:dkim]
X-Rspamd-Queue-Id: E2027F23AE
X-Rspamd-Action: no action

On Wed, Feb 04, 2026 at 03:51:59PM +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> When validating a super block, either when mounting or every time we write
> a super block to disk, we do many checks for error and warnings and we
> don't expect to hit any. So mark each one as unlikely to reflect that and
> allow the compiler to potentially generate better code.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

I've checked the generated assembly and it seems to have the expected
effect of reordering the message prints to the end of the function while
keeping the optimistic hot paths as a series of conditional followed by
jumps. The final .ko size is a bit larger (like +150 bytes), still
acceptable.

So I guess we want to continue these annotations because the compiler
does not infer it from the context or the __cold annotations of
_btrfs_printk().

