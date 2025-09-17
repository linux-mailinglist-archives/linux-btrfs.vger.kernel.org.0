Return-Path: <linux-btrfs+bounces-16891-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 03824B81204
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Sep 2025 19:09:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D02434E1C8A
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Sep 2025 17:09:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 800052FD7A0;
	Wed, 17 Sep 2025 17:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="DXb92jkX";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="NF7etFe0";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="DXb92jkX";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="NF7etFe0"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 119952FCC02
	for <linux-btrfs@vger.kernel.org>; Wed, 17 Sep 2025 17:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758128949; cv=none; b=fYP2+vGWqYb0luy28G2Fq6zFbgWeeNGvagS0bpku5tu7wxVCoNwsadHRjIs5BzvWiXf6jRrWvYsh2PiwSCOhFWcfuT+OimWL/CbpPkbtTua6fAZ5rjaNQD73Xu71HbjGzpl2L0Q8Ds1WfG3wOGlYX2fYs1+CJHSDCCTClBCRfMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758128949; c=relaxed/simple;
	bh=OvtHUIS+A7aSQj9Yylza7UUTkYPjpRVTBGbcrWdJmmA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IWaaOmaPWsnevmzCKjKzWr3P08PGdwDRH4Uel+up+l2Zi8np8XWmGUYFqjVNfkuF9y48X1iFKw8I9Gc0BIhXGrp9JxPAmiWYFWY22M5JfRq6kfNRBrNxLJoEWTBYLUR4Mg3cSDRvrLZAlQgwHyqpZWmN86/qNzsaP+GpxTjbBgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=DXb92jkX; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=NF7etFe0; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=DXb92jkX; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=NF7etFe0; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1FC7633E45;
	Wed, 17 Sep 2025 17:09:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1758128946;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HwbIfbqSmgK+K7ktELx8owz81Z6odJLnC6tiG4ZaFwU=;
	b=DXb92jkXbx2ojxmNfiAwynLA0dET3sKd0T4RuxKLJPRLKl7vh5lBzn0/yKbE+foutplYbo
	5UQ6fOXzTlCD9MEkh/63Nq7WBBLco1IBare/cQSDjAEuU91PALkQCSOmss+VsVa0lnh7NL
	O3mIh+4JZuG7AkCSLUmDKBI2YAEJ+VY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1758128946;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HwbIfbqSmgK+K7ktELx8owz81Z6odJLnC6tiG4ZaFwU=;
	b=NF7etFe0sDCbJ8cH3qXtrClL5MMgG6aQ1BSlbUMmzX+rn+tED94BLaao00QBpmhuG1+Krw
	kzYy0uxnyWvzeTAw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1758128946;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HwbIfbqSmgK+K7ktELx8owz81Z6odJLnC6tiG4ZaFwU=;
	b=DXb92jkXbx2ojxmNfiAwynLA0dET3sKd0T4RuxKLJPRLKl7vh5lBzn0/yKbE+foutplYbo
	5UQ6fOXzTlCD9MEkh/63Nq7WBBLco1IBare/cQSDjAEuU91PALkQCSOmss+VsVa0lnh7NL
	O3mIh+4JZuG7AkCSLUmDKBI2YAEJ+VY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1758128946;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HwbIfbqSmgK+K7ktELx8owz81Z6odJLnC6tiG4ZaFwU=;
	b=NF7etFe0sDCbJ8cH3qXtrClL5MMgG6aQ1BSlbUMmzX+rn+tED94BLaao00QBpmhuG1+Krw
	kzYy0uxnyWvzeTAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 103DD1368D;
	Wed, 17 Sep 2025 17:09:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id KszIAzLrymiaPQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Wed, 17 Sep 2025 17:09:06 +0000
Date: Wed, 17 Sep 2025 19:09:04 +0200
From: David Sterba <dsterba@suse.cz>
To: fdmanana@kernel.org
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/5] btrfs: tag as unlikely several unexpected critical
 errors
Message-ID: <20250917170904.GF5333@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1758095164.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1758095164.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-0.997];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWO(0.00)[2];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -4.00

On Wed, Sep 17, 2025 at 08:52:37AM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Several critical error checks are never expected to be hit, so tag them
> as unlikely. Details in the changelogs.
> 
> Filipe Manana (5):
>   btrfs: store and use node size in local variable in check_eb_alignment()
>   btrfs: mark extent buffer alignment checks as unlikely
>   btrfs: mark as unlikely not uptodate check in read_extent_buffer_pages()
>   btrfs: mark as unlikely not uptodate extent buffer checks when navigating btrees
>   btrfs: mark leaf space and overflow checks as unlikely on insert and extension

Reviewed-by: David Sterba <dsterba@suse.com>

Alternatively, as this is an obvious pattern the annotations can be done
in bigger batches.  On a test build with all EIO, EUCLEAN and
transaction abort branches annotated as unlikely the difference in
object size is <200 bytes. The asm code for error handling is reorded as
expected.

The reason for doing it in smaller patches is to avoid endless conflicts
with new patches or backports but as this would be an one time change
maybe we can do it now before the 6.18 freeze. While your changelogs
explaining each case are great I think we can spare ourselves of that,
it's really obvious and too repetitive.

I'll send the EIO/EUCLEAN/abort annotations for RFC.

