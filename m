Return-Path: <linux-btrfs+bounces-3877-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4084E8971A9
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 Apr 2024 15:53:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFECA281AFC
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 Apr 2024 13:53:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 144B914882E;
	Wed,  3 Apr 2024 13:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="dbzKLuSl";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="JO5NxmEe"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 919D2147C6C
	for <linux-btrfs@vger.kernel.org>; Wed,  3 Apr 2024 13:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712152401; cv=none; b=nAJaBIYMCjxJjLGIHe+qlO1gaAslCi9s86Tm3QTJxNofz14pPmaxb+IrUbTEjgpNIT/UIZf1pGOUHI8hSajGkf7AAuyAmfMnCUi3jo4uXO1kt7FeN0aVz5/5IXwk1uC+xhkEgeXk18uTsVX7yAMzltDcjbeIam3tZJc3aB8i7Ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712152401; c=relaxed/simple;
	bh=riIRfeTCJkPy+Xyec3sKKMT2Z5tLXPcyUPuCMrxUh0I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cCnw4OMmavA+hSiS4TYscSumC7QQe/KuG5ZUj29vephAq02anBbmPdfPU6iUBn5bW++xUnuwhuqtPHPoTUIoQmIveYsVHGVxxho9Sc6FWZomrM42aEQzn07v6LAe6uE8SIIK8mhEeeLgB99N3dWpkc5rZv98jfpMFe3PcF1BRTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=dbzKLuSl; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=JO5NxmEe; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D76E85CD21;
	Wed,  3 Apr 2024 13:53:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1712152396;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yOwUpCGJakzs6mnrutyY97t3IV0s49P+tCM5uLgZlXM=;
	b=dbzKLuSldzKw0hjI8kA0Vw2zC7qCeRCc43abRsjM9MGf7q2TilXjSKouRTLVTeXIDaZHbG
	nGPT3thmLfpNUyKhVZMOCVfdQ023KUz5Lw2rMqqeg9LO94NB77+zYJhy9eqCp3y44TAUpV
	seBaYWid9a6WADjeby7C8Nmcc1+lQKY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1712152396;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yOwUpCGJakzs6mnrutyY97t3IV0s49P+tCM5uLgZlXM=;
	b=JO5NxmEeWsnc5jWtRPmxHiETqRohY3YwjEEYMlQxOBV/zzazwQceuImJEQpcztVWALNRML
	L2BL25YsHuj2OVBQ==
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id C0AE31331E;
	Wed,  3 Apr 2024 13:53:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id GU3ZLkxfDWasUwAAn2gu4w
	(envelope-from <dsterba@suse.cz>); Wed, 03 Apr 2024 13:53:16 +0000
Date: Wed, 3 Apr 2024 15:45:51 +0200
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/2] btrfs-progs: header cleanups
Message-ID: <20240403134551.GG14596@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1711837050.git.wqu@suse.com>
 <7bb61bcc-b68d-45d6-8217-4b11c23698f1@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7bb61bcc-b68d-45d6-8217-4b11c23698f1@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spamd-Result: default: False [-1.08 / 50.00];
	BAYES_HAM(-1.08)[87.98%];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,imap2.dmz-prg2.suse.org:rdns,imap2.dmz-prg2.suse.org:helo]
X-Spam-Score: -1.08
X-Spam-Level: 
X-Spam-Flag: NO

On Wed, Apr 03, 2024 at 08:35:07AM +1030, Qu Wenruo wrote:
> Please drop the series.
> 
> As David mentioned in the github pull request, the LSP server is pretty 
> aggressive as it can fully understand the different configurations.
> 
> We need a more comprehensive tests on all possible configuration/build 
> targets/linked library etc.

A bit more coverage done, the btrfs.box target is built by default
everywhere and some CI image builds also configure with --experimental.
The static has dependencies that may not exist everywhere but the
coverage seems fine for now.

