Return-Path: <linux-btrfs+bounces-8396-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3829A98C328
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Oct 2024 18:21:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 694081C24355
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Oct 2024 16:21:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEB091CEAD3;
	Tue,  1 Oct 2024 16:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="tRHcoahu";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="4TNOA570";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="tRHcoahu";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="4TNOA570"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39C0D1CBEB0;
	Tue,  1 Oct 2024 16:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727799178; cv=none; b=rfoMYO/KA+gOAsTuuaTwZQpg6BYwCxfEVzEbGf2rhwRikZAxQjdlMJ30JmpD2rrY3gI3AXv2umNaN01l6vkpCP1DwdTSWoU4+QpVivT6SPJ+IchGqdu/LK2AYJfNjw1jLYCJZQCnjOPsoZxaOJQ3QUQCOxxecba/405lerDdoYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727799178; c=relaxed/simple;
	bh=ojpVxOToN8POoZGZdSDBaqUDIGJdOqLsns3uoBtC+eI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lIBxfY6kofK64AyGxjey88voLVhDUHV4DNC42jRAkTPtl+9jFWy6G4DZDjhM3R+vFKWrkpYXWQ7NGcPxT5bd78RGbaqDlmxRX3UX+GuJpdtDCXGSZlQWqW4g+qO5gRXsnrzqxw6e0OChbWdrlGH4nWq/WZ/YkQ42+LQE2kRxnc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=tRHcoahu; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=4TNOA570; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=tRHcoahu; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=4TNOA570; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 69C1321B35;
	Tue,  1 Oct 2024 16:12:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1727799174;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=W0wgxnbd8qItmntb2L2gS5efCbVvU4DEZwR0ixLlUDo=;
	b=tRHcoahuRAbemCdEDVjjAwXnRwst4aIWmx91lXZajPCCPCnbS36wE7cg3luL5vYnlL0uy/
	uZ77UGfFKs28nN1FkQ7X3/EAVybduTxyNLozoSE70vcZUwdA0br3AjEjPHX5TnDFRAF65P
	aOCcrfcd14Dlj8rg8IP/vCh3XgFt4Jg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1727799174;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=W0wgxnbd8qItmntb2L2gS5efCbVvU4DEZwR0ixLlUDo=;
	b=4TNOA570OStsMGK3dF3MKrvC8K5DT/iveHd4++fz+s7ebYXXM7754TC257pMIFyoJ9xtqz
	LjvwLlTFRgUrcMBA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1727799174;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=W0wgxnbd8qItmntb2L2gS5efCbVvU4DEZwR0ixLlUDo=;
	b=tRHcoahuRAbemCdEDVjjAwXnRwst4aIWmx91lXZajPCCPCnbS36wE7cg3luL5vYnlL0uy/
	uZ77UGfFKs28nN1FkQ7X3/EAVybduTxyNLozoSE70vcZUwdA0br3AjEjPHX5TnDFRAF65P
	aOCcrfcd14Dlj8rg8IP/vCh3XgFt4Jg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1727799174;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=W0wgxnbd8qItmntb2L2gS5efCbVvU4DEZwR0ixLlUDo=;
	b=4TNOA570OStsMGK3dF3MKrvC8K5DT/iveHd4++fz+s7ebYXXM7754TC257pMIFyoJ9xtqz
	LjvwLlTFRgUrcMBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4A6ED13A73;
	Tue,  1 Oct 2024 16:12:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 46C1EYYf/GYsQgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 01 Oct 2024 16:12:54 +0000
Date: Tue, 1 Oct 2024 18:12:49 +0200
From: David Sterba <dsterba@suse.cz>
To: Shen Lichuan <shenlichuan@vivo.com>
Cc: clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	opensource.kernel@vivo.com
Subject: Re: [PATCH v2] btrfs: Correct typos in multiple comments across
 various files
Message-ID: <20241001161249.GH28777@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20240924030944.5352-1-shenlichuan@vivo.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240924030944.5352-1-shenlichuan@vivo.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[twin.jikos.cz:mid];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Score: -4.00
X-Spam-Flag: NO

On Tue, Sep 24, 2024 at 11:09:44AM +0800, Shen Lichuan wrote:
> Fixed some confusing spelling errors that were currently identified, 
> the details are as follows:
> 
> -in the code comments:
> 	block-group.c: 2800: 	uncompressible 	==> incompressible
> 	extent-tree.c: 3131:	EXTEMT		==> EXTENT
> 	extent_io.c: 3124: 	utlizing 	==> utilizing
> 	extent_map.c: 1323: 	ealier		==> earlier
> 	extent_map.c: 1325:	possiblity	==> possibility
> 	fiemap.c: 189:		emmitted	==> emitted
> 	fiemap.c: 197:		emmitted	==> emitted
> 	fiemap.c: 203:		emmitted	==> emitted
> 	transaction.h: 36:	trasaction	==> transaction
> 	volumes.c: 5312:	filesysmte	==> filesystem
> 	zoned.c: 1977:		trasnsaction	==> transaction
> 
> Signed-off-by: Shen Lichuan <shenlichuan@vivo.com>

Added to for-next, thanks.

