Return-Path: <linux-btrfs+bounces-16088-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D16BB28895
	for <lists+linux-btrfs@lfdr.de>; Sat, 16 Aug 2025 00:53:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C5E11D059E0
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Aug 2025 22:54:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 986612836B5;
	Fri, 15 Aug 2025 22:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="qBpdmrbI";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="JSjhB2sz";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="qBpdmrbI";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="JSjhB2sz"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4643128C2C6
	for <linux-btrfs@vger.kernel.org>; Fri, 15 Aug 2025 22:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755298410; cv=none; b=J0D0JnBX3ipGUD6fzpec/6//GY7pjvwO9iNscvzxFW3/B5pB6UAfL1QH/R83tE0Ri9z6BxMnDr8Eq3XQOiqWL2PteuQFEAnvF2X4eQUl/Wql2DwTK9oPzvfnDMLGleC6FUayrnhDp6F2nwOwnuZY7HpZW9aprVR2TtIe+bc4nyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755298410; c=relaxed/simple;
	bh=5TCMMOhNjS7/JDmNMRUQjJ6AqrcHkozsQgsMRVLjZbA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rsJI/zac/ay6IgjsFzXntBBKyFLvDekbZes9OIqr69jzvB2vktEr3ht5Wn1mqD7G6m4gbLd9H+fxsSVtX4pjN172HHmPKg5p2xl1/1nQkhospYlo66hxdNiRrxwLZe/yVmpz0xvX1F8zeFZyrVJ+fLhf7SNV7zniZKcaSU59i0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=qBpdmrbI; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=JSjhB2sz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=qBpdmrbI; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=JSjhB2sz; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 5EED71F7EA;
	Fri, 15 Aug 2025 22:53:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1755298407;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0mDBqrUQTauozFAZ+LPhVCY5kTU2q+81nHm1bMlv8vw=;
	b=qBpdmrbIt+U5+G4xrwo3nx9HaYG/I0m3gUs/aTvWgsG8pCUofo/R+MaxdnojXETnFTm/24
	CITAqPCvTLx74F2W0jLMtxMU8vGK1GQ+XEqObsJUgpo4XKjQjZi0HrwhczRafzIT5ZlXL/
	l3RXqqLoOo2S8aPU/969JB8BFszdEuw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1755298407;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0mDBqrUQTauozFAZ+LPhVCY5kTU2q+81nHm1bMlv8vw=;
	b=JSjhB2szk6EgY+8UhEsu3Ff0pmChWhCZofVpAaoqFhUVkcvbPO0FqdY0AerQ2zYnSardEU
	k8enELP8DafWYOAw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1755298407;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0mDBqrUQTauozFAZ+LPhVCY5kTU2q+81nHm1bMlv8vw=;
	b=qBpdmrbIt+U5+G4xrwo3nx9HaYG/I0m3gUs/aTvWgsG8pCUofo/R+MaxdnojXETnFTm/24
	CITAqPCvTLx74F2W0jLMtxMU8vGK1GQ+XEqObsJUgpo4XKjQjZi0HrwhczRafzIT5ZlXL/
	l3RXqqLoOo2S8aPU/969JB8BFszdEuw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1755298407;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0mDBqrUQTauozFAZ+LPhVCY5kTU2q+81nHm1bMlv8vw=;
	b=JSjhB2szk6EgY+8UhEsu3Ff0pmChWhCZofVpAaoqFhUVkcvbPO0FqdY0AerQ2zYnSardEU
	k8enELP8DafWYOAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 49FD31368C;
	Fri, 15 Aug 2025 22:53:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id WoKYEWe6n2ijAgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Fri, 15 Aug 2025 22:53:27 +0000
Date: Sat, 16 Aug 2025 00:53:26 +0200
From: David Sterba <dsterba@suse.cz>
To: Boris Burkov <boris@bur.io>
Cc: David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: convert several int parameters to bool
Message-ID: <20250815225325.GE22430@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20250813104111.1371278-1-dsterba@suse.com>
 <20250815204817.GB2973697@zen.localdomain>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250815204817.GB2973697@zen.localdomain>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-0.997];
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
	RCPT_COUNT_THREE(0.00)[3];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -4.00

On Fri, Aug 15, 2025 at 01:48:17PM -0700, Boris Burkov wrote:
> On Wed, Aug 13, 2025 at 12:41:11PM +0200, David Sterba wrote:
> > We're almost done cleaning misused int/bool parameters. Convert a bunch
> > of them, found by manual grepping.  Note that btrfs_sync_fs() needs an
> > int as it's mandated by the struct super_operations prototype.
> > 
> 
> I noticed a few related return values that could be bool-ified but I
> assume that is a separate effort from the parameters done here?

Yes, the return type conversions have been done too, usually one
function per patch as it may change more lines.

