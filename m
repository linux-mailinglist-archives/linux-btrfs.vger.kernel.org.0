Return-Path: <linux-btrfs+bounces-12801-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AC616A7C2D0
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Apr 2025 19:49:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 88FD17A9697
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Apr 2025 17:48:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8586821C9E3;
	Fri,  4 Apr 2025 17:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="GKJ5wKN5";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="emgHoltP";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="GKJ5wKN5";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="emgHoltP"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E1CC1FF5F3
	for <linux-btrfs@vger.kernel.org>; Fri,  4 Apr 2025 17:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743788925; cv=none; b=hwSq0y344sOkE0vh+T4VguK78OYPM76fIijDHVCI7VZuNZaZ9EfneXEMWkeMRqmyDdsHslmAJQ7NmHvj5UPYy5tHdqiAUPYNeENswrN4bQyixAIMBWZ0R4vd4+baGtDxYPOmiv1FYokexQHcTHFqilSmRkfjC72ohobRIp1L/+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743788925; c=relaxed/simple;
	bh=qAA04ieFu7c+/UqP+v96dzsOQtrUzJHp44lUtGlhDr0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RH7AgcEP0GQTowhnQvQXlQw/JzkWBEZ+yodu1FmMzx0Kx1FWKHZhqsKRp+5NTKh1HMSrAAFHjwpLUkUpH5KxY4P+lCuzwF7kLhedmsh/8/fV5IiWGTxeMyFre3ybgPCCDVnoiJkMljbQzsDrJ/wmoXb3ArMSX4iLAOqSC0hvYOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=GKJ5wKN5; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=emgHoltP; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=GKJ5wKN5; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=emgHoltP; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0D9C2211B3;
	Fri,  4 Apr 2025 17:48:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1743788922;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oRaUNvCOpk/WgdU3pPpyhzBJjknNkACnCgBpEzgYvKk=;
	b=GKJ5wKN5RIZGJ8xvZbmLwPMB/s2+Nuz0UzfsnlzR773oneu6Ecl08fsw1EMNrEV5/zRcLm
	NlttL0gJ0X0J9EMGcS05hVHBbP0pOJK7wTvmS0NOowTEyfJVQWI+4QJsrdFdakxbFWDNH3
	xWyGs0vrcvqSI9OX1XilQzmUvy7kgRE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1743788922;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oRaUNvCOpk/WgdU3pPpyhzBJjknNkACnCgBpEzgYvKk=;
	b=emgHoltPpyPt2bdSr0gSV4cb+b5naSHBzozcEFSYK1zOiEL3yAAPmwLVDhTG6l/NlHc42g
	Yt7ufcszX+3O0bCg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=GKJ5wKN5;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=emgHoltP
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1743788922;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oRaUNvCOpk/WgdU3pPpyhzBJjknNkACnCgBpEzgYvKk=;
	b=GKJ5wKN5RIZGJ8xvZbmLwPMB/s2+Nuz0UzfsnlzR773oneu6Ecl08fsw1EMNrEV5/zRcLm
	NlttL0gJ0X0J9EMGcS05hVHBbP0pOJK7wTvmS0NOowTEyfJVQWI+4QJsrdFdakxbFWDNH3
	xWyGs0vrcvqSI9OX1XilQzmUvy7kgRE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1743788922;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oRaUNvCOpk/WgdU3pPpyhzBJjknNkACnCgBpEzgYvKk=;
	b=emgHoltPpyPt2bdSr0gSV4cb+b5naSHBzozcEFSYK1zOiEL3yAAPmwLVDhTG6l/NlHc42g
	Yt7ufcszX+3O0bCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F33371364F;
	Fri,  4 Apr 2025 17:48:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id rb4jO3kb8GfPJwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Fri, 04 Apr 2025 17:48:41 +0000
Date: Fri, 4 Apr 2025 19:48:36 +0200
From: David Sterba <dsterba@suse.cz>
To: fdmanana@kernel.org
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: tracepoints: use btrfs_root_id() to get the id of
 a root
Message-ID: <20250404174836.GX32661@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <acef2fc25f3912f7cb105e45d4d63a3a096c2eb6.1743762625.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <acef2fc25f3912f7cb105e45d4d63a3a096c2eb6.1743762625.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Queue-Id: 0D9C2211B3
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
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
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Fri, Apr 04, 2025 at 11:31:05AM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Instead of open coding btrfs_root_id() to get the ID of a root, use the
> helper in the tracepoints, which also makes the code less verbose.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: David Sterba <dsterba@suse.com>

