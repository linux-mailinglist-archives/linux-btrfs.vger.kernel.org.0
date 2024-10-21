Return-Path: <linux-btrfs+bounces-9046-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 775EA9A9337
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Oct 2024 00:21:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C17B1C229E2
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Oct 2024 22:21:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6D691FDFAF;
	Mon, 21 Oct 2024 22:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="KJc9fFcd";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="n55CCHl6";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="hOk2eDh0";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="E22rJU3q"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01EDB282F0;
	Mon, 21 Oct 2024 22:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729549300; cv=none; b=Q202Fk286otZVxF3z2W0IJ3J4p4ScuUDWq7KuYiI1Msj9Q7VSxsAq4P/aG+OlPiOr//FmkZl3SWskrnyisGjewEIblKpyZuGMis8mJnRkLaUNJxQYaYbBRSYZA4MNBMxAnDOL0vIfXBPB5e8FCtTQ0RH89ZlWZUFJ/BU0vva7X8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729549300; c=relaxed/simple;
	bh=nmwcusJKYHrKotjVQFOqKJBJFglkOVTVDWh0mf1uIf0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FZweBytIGuDWDyiWvkoEHdH8LfsQq+LNm1JpUTfOqg/9AP2Rzmr4ZuBDxX2krUsVcWQv9/RevBnyhdYIjM+/xY+yWZGLr0gX6F4xIUqTeG/GIUJwH3GV6j0sJArjTd4u30aBqj+GX3yjm5FudAF/aiFrD0CFmszFu7SD12TLQFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=KJc9fFcd; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=n55CCHl6; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=hOk2eDh0; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=E22rJU3q; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 00D1A1F8B6;
	Mon, 21 Oct 2024 22:21:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1729549296;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1xcR6+YO/GEwgCGqd6FHE/oCrtyPF7+hYyzu2uE3B2E=;
	b=KJc9fFcdSic5po1LV2wdDlPQm265vEM0h4Yp6eczHCP9DXyBYcIyUAoSiRnmYfo08TU5Et
	0T6OAGIGEW6r3zAgQDEMSiGH3AGD2CBraQmTb7nYA+1BPxm3OmLBowioLgYNqMU4agE9pE
	Fij5Gbq+gU0ab6xcIhDoOhD3PbM7BII=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1729549296;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1xcR6+YO/GEwgCGqd6FHE/oCrtyPF7+hYyzu2uE3B2E=;
	b=n55CCHl6MUl5LnoNJ4S4fAxTg1Nu/wYy2sKY445/xM9PMCizavRDeAaU16Twjxxay3/DIb
	ouOEHK1tHYYiWQAg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1729549295;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1xcR6+YO/GEwgCGqd6FHE/oCrtyPF7+hYyzu2uE3B2E=;
	b=hOk2eDh0LCx0+aQo4OE5kqO6pIp71mGpnDnj9+hAhOP07Cn6q71WfZfy+rNF3oBtfNe1Ht
	pqEfrLiFg4pKMsclfNdaTcAmevElSJOy1ZrfoULFoPq1dTNG7DrbdDMRXdK9alTZr05IA1
	r2DZjzBRsYQ9nLon702cKwAB+B4s9oE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1729549295;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1xcR6+YO/GEwgCGqd6FHE/oCrtyPF7+hYyzu2uE3B2E=;
	b=E22rJU3q51naL1ccXXKikw/3jevpshd5+pVL5X+fnQWOSYUbliUWfSb020layseXeze1Uh
	IbZf3qTgZ8YoCVDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E4AA3139E0;
	Mon, 21 Oct 2024 22:21:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id dR2cN+7TFmeSXwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Mon, 21 Oct 2024 22:21:34 +0000
Date: Tue, 22 Oct 2024 00:21:29 +0200
From: David Sterba <dsterba@suse.cz>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] btrfs: Use str_yes_no() helper function in
 btrfs_dump_free_space()
Message-ID: <20241021222129.GA31418@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20241021214022.31010-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241021214022.31010-2-thorsten.blum@linux.dev>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-0.992];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,suse.com:email,suse.cz:replyto,imap1.dmz-prg2.suse.org:helo,twin.jikos.cz:mid];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Score: -4.00
X-Spam-Flag: NO

On Mon, Oct 21, 2024 at 11:40:22PM +0200, Thorsten Blum wrote:
> Remove hard-coded strings by using the str_yes_no() and str_no_yes()
> helper functions.
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>

Reviewed-by: David Sterba <dsterba@suse.com>

