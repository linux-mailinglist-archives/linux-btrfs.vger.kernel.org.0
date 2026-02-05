Return-Path: <linux-btrfs+bounces-21388-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mPjgBnuIhGl43QMAu9opvQ
	(envelope-from <linux-btrfs+bounces-21388-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Thu, 05 Feb 2026 13:09:31 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AC434F23D4
	for <lists+linux-btrfs@lfdr.de>; Thu, 05 Feb 2026 13:09:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D9B3F307D7F7
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Feb 2026 12:04:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 491E13A9624;
	Thu,  5 Feb 2026 12:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="G/O0/zTs";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="a0fcfpVG";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="G/O0/zTs";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="a0fcfpVG"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C58F6F2F2
	for <linux-btrfs@vger.kernel.org>; Thu,  5 Feb 2026 12:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770293082; cv=none; b=QIzggzpzcKEs4aHNVaiRFOA1VcIdz4jDBucK7i8Ji7PrXHkqgOBiflqRZT8sc3IjlnmSVkpGlGFnaMZXMiwnrt0QHUXKhj8GyBExdJWTE8Ryo4o/quqMpsiYG7ieIMQYMCNvyDq5Wf4hI5Rt9+9WvAqKlJk+81FxGTfYvRrXnSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770293082; c=relaxed/simple;
	bh=HAAclaW5QayzI/T21Sn1X3A0BJOpwEIAFyeVDP3+g5U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jMSSl2zb6LxaLm85IQZICD7BrmUxa68jATtLxYb9gNanvDLiosTa5pGNYkjKY/OWv5UJuDKpvcIJ2MZhq1ViGPIx8Efik2YCouHY63K23NzDCNAb9Tjwi4txo6LF2Zhk33DtfwSUCvTxaj10KdRBmITx2cvsHone6OEhw3eP+T0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=G/O0/zTs; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=a0fcfpVG; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=G/O0/zTs; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=a0fcfpVG; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B81955BD94;
	Thu,  5 Feb 2026 12:04:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1770293080;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=t5jRiOefEbjgXGE9Z68rXK3pgGWS0CoCkFDBIwlHmRM=;
	b=G/O0/zTsDQT1akfxUhpjz94JuFW+lyU1bNSRHsVxwGBc9X2tlJS3xsvszqtFQgs0jPs+lM
	DHr74WhHz0aY8fbHzxDzKBpdum6lFxHXw0e330iXFXi9LFXcRS0TZkaJIYyr5bfCbjEXpR
	BnBLksqBXrGk2/ta1LRIsDmNprD+jCg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1770293080;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=t5jRiOefEbjgXGE9Z68rXK3pgGWS0CoCkFDBIwlHmRM=;
	b=a0fcfpVGsrz9RYY9OL3pxbAGsjdSHHv1K6Vvm1BGiQH+MYIDWfwsEueGVhseap3lSiPB14
	nCTC2K/dtmdkBfBQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1770293080;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=t5jRiOefEbjgXGE9Z68rXK3pgGWS0CoCkFDBIwlHmRM=;
	b=G/O0/zTsDQT1akfxUhpjz94JuFW+lyU1bNSRHsVxwGBc9X2tlJS3xsvszqtFQgs0jPs+lM
	DHr74WhHz0aY8fbHzxDzKBpdum6lFxHXw0e330iXFXi9LFXcRS0TZkaJIYyr5bfCbjEXpR
	BnBLksqBXrGk2/ta1LRIsDmNprD+jCg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1770293080;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=t5jRiOefEbjgXGE9Z68rXK3pgGWS0CoCkFDBIwlHmRM=;
	b=a0fcfpVGsrz9RYY9OL3pxbAGsjdSHHv1K6Vvm1BGiQH+MYIDWfwsEueGVhseap3lSiPB14
	nCTC2K/dtmdkBfBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9DA943EA63;
	Thu,  5 Feb 2026 12:04:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ezVUJliHhGkRNAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Thu, 05 Feb 2026 12:04:40 +0000
Date: Thu, 5 Feb 2026 13:04:31 +0100
From: David Sterba <dsterba@suse.cz>
To: fdmanana@kernel.org
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/7] btrfs: minor tweaks and cleanups to the super block
 writing path
Message-ID: <20260205120431.GW26902@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1770212626.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1770212626.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Spam-Level: 
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21388-lists,linux-btrfs=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[twin.jikos.cz:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.cz:replyto,suse.cz:dkim,suse.com:email]
X-Rspamd-Queue-Id: AC434F23D4
X-Rspamd-Action: no action

On Wed, Feb 04, 2026 at 03:51:57PM +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Details in the change logs.
> 
> Filipe Manana (7):
>   btrfs: change unaligned root messages to error level in btrfs_validate_super()
>   btrfs: mark all error and warning checks as unlikely in btrfs_validate_super()
>   btrfs: pass transaction handle to write_all_supers()
>   btrfs: abort transaction on error in write_all_supers()
>   btrfs: tag error branches as unlikely during super block writes
>   btrfs: remove max_mirrors argument from write_all_supers()
>   btrfs: set written super flag once in write_all_supers()

Reviewed-by: David Sterba <dsterba@suse.com>

