Return-Path: <linux-btrfs+bounces-4299-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 784938A6A64
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Apr 2024 14:11:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 190461F21282
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Apr 2024 12:11:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 454F712AAC6;
	Tue, 16 Apr 2024 12:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="KJx94qjC";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="PgtcUdHg";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="f8UCg16i";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="yhFtxvjT"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03C0812A16C
	for <linux-btrfs@vger.kernel.org>; Tue, 16 Apr 2024 12:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713269506; cv=none; b=h6nsWwyNwRsJ7XnU3VtnG793a+wSCukdYuf8SVmS93xqpO56zrmehT+URlm28dVpr9gVsfePDZLSHKoSFfZ39Iw0hn2Hecxc7SrFDkn3ZL1Qrq7+9xg8uklGmjrkSaffAtzpXVAl9z42xr+na9zGomoF8G9K+yBuhFeQtfj8JzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713269506; c=relaxed/simple;
	bh=0h/Wl8M0abh6UXsry0mDtBMQJW5XozGFe9NHVU3OdLI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bD+qR5QqM523BPD1kvTKAlGUEMXgLyaSi18oamqxag4MR0n0jHObXnUTXI1Gijg8OHCEbWnYQ7axNIIRH0HH6f/u7RAtgajcBP5TjI856LNm8wqRrfAzB8FqVoKn9xjuFXI4X8509EMjPGcyyCkCJIElz6klLxrwRFEKrjMj7GQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=KJx94qjC; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=PgtcUdHg; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=f8UCg16i; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=yhFtxvjT; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 990EF37AE7;
	Tue, 16 Apr 2024 12:11:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1713269501;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=H9y1YUagPddqeuOoGvuR3juocM3C3VBfVkIK/EJB8CE=;
	b=KJx94qjCkQvt1exW8h+JuPCPPCKENx580qUf/Q+sp9V1+4LfcmodV3IwkuRi1o/8WLjFPD
	lg4sdmWe2j5FxySti1cqfo8Re17jiObdjuRkJE0CrSPm0UVhPNZVwe+uz7PeFCOUoF6RBJ
	ELpHewNCQV+yZIiogeqmH008RvWwl2g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1713269501;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=H9y1YUagPddqeuOoGvuR3juocM3C3VBfVkIK/EJB8CE=;
	b=PgtcUdHgPtiXU042aOCaQJE+8XO6YwROoYSx+TRiOyWD4qQI6pVBR72d0fgBiMgre4p2EH
	1+bOACCdu4I8GxDQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=f8UCg16i;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=yhFtxvjT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1713269500;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=H9y1YUagPddqeuOoGvuR3juocM3C3VBfVkIK/EJB8CE=;
	b=f8UCg16i/rxGr8VXcqR1pRuAjYJ/NAPQ6Kg91g5H7CW/cJe0It2OzphVU7d0Al/ZBR9MPy
	g5n4oEtuCgGOlUR0bQroc3QXwayCABkxLmK6qouDGDs6xC5qB7hssTmqgJ78WeGD0bOUtK
	y1XOVeZUgJKnbjepkP4SZip3BtAeR+E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1713269500;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=H9y1YUagPddqeuOoGvuR3juocM3C3VBfVkIK/EJB8CE=;
	b=yhFtxvjTBECwv62wIOMr14Y/GRJHtANeiOGPM8QnE7EiYy9trbumhZjxEcS4Rvva6Pp4Lf
	eP8ywbmq0r8FbOBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8D2CA13931;
	Tue, 16 Apr 2024 12:11:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id zlFFIvxqHmZhOwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 16 Apr 2024 12:11:40 +0000
Date: Tue, 16 Apr 2024 14:04:07 +0200
From: David Sterba <dsterba@suse.cz>
To: linux@oluceps.uk
Cc: dsterba@suse.com, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs-progs: property set: fix typo in help message
Message-ID: <20240416120407.GR3492@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <171320182308.8.1632190135551877582.308812139@oluceps.uk>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <171320182308.8.1632190135551877582.308812139@oluceps.uk>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spamd-Result: default: False [-3.56 / 50.00];
	BAYES_HAM(-2.35)[96.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:dkim,suse.cz:replyto,oluceps.uk:email]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 990EF37AE7
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Score: -3.56

On Mon, Apr 15, 2024 at 05:23:06PM +0000, linux@oluceps.uk wrote:
> From: oluceps <linux@oluceps.uk>
> 
> Correct a typo by replacing "then" with "than".
> 
> Signed-off-by: oluceps <linux@oluceps.uk>

Added to devel, thanks.

