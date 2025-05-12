Return-Path: <linux-btrfs+bounces-13896-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E001AB3EEF
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 May 2025 19:24:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 005A616D1F7
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 May 2025 17:24:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F02FD296D1F;
	Mon, 12 May 2025 17:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="cfgk9xSm";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="vTo8uXRF";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="B4UfNVZN";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="AlO8yqmD"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA480296D1A
	for <linux-btrfs@vger.kernel.org>; Mon, 12 May 2025 17:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747070653; cv=none; b=XRRYLEVnC6/dSgciwpzbhu9hG3yDf+FSCM7wbeNwOdaPk5n6XO+rq6jLOmNzg7psh1h1cm3geLYvjK6ZIljGpCPjoOqPD6S6qb6muBjxX/lUll7aB4R1nn4R/7Ha28ptDVbYyAlBpCADM8F0En1ldu2KVQPNkhcsiMpVicRxmeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747070653; c=relaxed/simple;
	bh=iyN8PfZ/c5iD6Gh/vNTNKWU7rtU778+ISRgFi7ONqB8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p7UKcO850Cje80EJZV/Us4UvDTiuVO42PZxfdUa0isV+xyqBPO6t7Dvqy+OBQhQlccFvf/IHVnjmwSF+c2XxxlDiWSIfeDQxV/m8oJJmqf3AmXUAZokwIacUanOqnkkidoa6ZQrJG6o/JLOZ6mvsatKDXQuaGh7T0GhP4T3ysk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=cfgk9xSm; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=vTo8uXRF; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=B4UfNVZN; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=AlO8yqmD; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id BA66F2117F;
	Mon, 12 May 2025 17:24:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1747070649;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QtuGmwaBghIjfnMJMhKLOQX6+aBKtY+tNT33VeawD0c=;
	b=cfgk9xSmp36H3OUN4zGm12DSdmwdD7XaeUV49XYkVkVVZbqSOJoNqlHpQOwB6ZNiyqmHgr
	JIE6pwPayhIa9Sg70ID95t9Q4yU/5L8tUeZ1VCiXkgLnW+2fuOzAhmfCgwSQoVxWIWft8H
	pBFNu0p6cq21msrNDL6bNFigbpnbr70=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1747070649;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QtuGmwaBghIjfnMJMhKLOQX6+aBKtY+tNT33VeawD0c=;
	b=vTo8uXRF6lBDNWEwqBV5BHrJM4NYOH5XUdCrjNG/DkvGFTK7KDl1dop4b/kpg8QzBoNDTN
	83Evrqzvoi/1STAw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=B4UfNVZN;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=AlO8yqmD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1747070648;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QtuGmwaBghIjfnMJMhKLOQX6+aBKtY+tNT33VeawD0c=;
	b=B4UfNVZNbZTIRoWk3dMS5hbYIHdEaFgvQ7RIaZFDCDLU8idOSDoEbv3DD/m/ZHVwwNflGR
	AruwVoRW51E5xsnGE/VzKKvbaSQk5nvt9zBJyDbM2GOd/+GGd2ZpEtxMJwKnNI8FAID3vg
	ToteAsWeZHZCUfdxFlgdI8EZUE6zBbE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1747070648;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QtuGmwaBghIjfnMJMhKLOQX6+aBKtY+tNT33VeawD0c=;
	b=AlO8yqmDzmchNFfCylS0aVeVWXJAN9TAkF6MZwUYYapJ02UKPlhBwygkCsyU5N1SgArcqK
	RSWezW0WWkJyc4Cw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 96D39137D2;
	Mon, 12 May 2025 17:24:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id gCWmJLguImgScwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Mon, 12 May 2025 17:24:08 +0000
Date: Mon, 12 May 2025 19:24:07 +0200
From: David Sterba <dsterba@suse.cz>
To: fdmanana@kernel.org
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: simplify error return logic when getting folio at
 prepare_one_folio()
Message-ID: <20250512172407.GQ9140@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <0ef572363b52c57d95cc1a8912430187f868a7d5.1747035909.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0ef572363b52c57d95cc1a8912430187f868a7d5.1747035909.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: BA66F2117F
X-Spam-Flag: NO
X-Spam-Score: -4.21
X-Spam-Level: 
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:replyto,suse.cz:dkim];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action

On Mon, May 12, 2025 at 08:48:10AM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> There's no need to have special logic to return -EAGAIN in case the call
> to __filemap_get_folio() fails, because when FGP_NOWAIT is passed to
> __filemap_get_folio() it returns ERR_PTR(-EAGAIN) if it needs to do
> something that would imply blocking.
> 
> The reason we have this logic is from the days before we migrated to the
> folio interface, when we called pagecache_get_page() which would return
> NULL instead of an error pointer.
> 
> So remove this special casing and always return the error that the call
> to __filemap_get_folio() returned.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: David Sterba <dsterba@suse.com>

