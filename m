Return-Path: <linux-btrfs+bounces-14284-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6473AAC744C
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 May 2025 01:08:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6505501A6E
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 May 2025 23:08:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83EE4221FC8;
	Wed, 28 May 2025 23:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="JxmwzOk7";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="6W5W2np3";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="u+ZoddXC";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Obg68k4N"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4789E21FF5D
	for <linux-btrfs@vger.kernel.org>; Wed, 28 May 2025 23:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748473701; cv=none; b=jSMHSfH6Ycyva5e6ZsOFwz8AnxcfrCgFXC4p0i2mflLX72IQtOZhPLIZP2r/NIqICmbJZnFuzvFYaVhjUNHPHlBzsLZL3ijFsvPeHVS4oiSKLI9T/9Wh/L/Mk+3W0rZy6ua3nIosVY5N/cBwVauYAeEA2olQt0ihVRPYgs4o51s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748473701; c=relaxed/simple;
	bh=SRCj8l8T44mi9sIaHjf5hjIIDFhQLDTx+zzvlv9xweo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TtuuDoF+Z7waIXu3TNBJjPhbGOZhFiX5zmsTD/UGDJ9gGb5xuUEfsedAovIdro9/1IEGftzecwPgulSMvjnePdCRXsnwzHGlfeFKIPahnPWQ0SlQZ0urs1GFEsdO/x6y6A9ae+LUIymRI7AaacubhpHPz8QyEXJmRYuuyjLiJUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=JxmwzOk7; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=6W5W2np3; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=u+ZoddXC; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Obg68k4N; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 22A241F79C;
	Wed, 28 May 2025 23:08:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1748473697;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uKKDVzUZJvKfLzNbbu5L4ZwIdK4Lt3c506eudVU575I=;
	b=JxmwzOk71lem8zsGegvZox/gXCrvtWyCGrBii9HQhtzyKbWc1YSaJ9UqYVl4EMS1MUrCTY
	j00E3z1k2oMrIs8RrqUK9yegxsoHgKlTmabDqbYf4tDTqzzK9vDKMa2nTKYOcZi3MqP/D8
	3rLkFECn1w/OaTRsrQbadzTs+wCb0x4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1748473697;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uKKDVzUZJvKfLzNbbu5L4ZwIdK4Lt3c506eudVU575I=;
	b=6W5W2np3Hn82r5ak1EY2DwHF444qGnXe0jZofeMtFFkddCejRA1yHFbHLh2nL1jaXkLnWK
	SmvtDQ9ugSKTFsDA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1748473696;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uKKDVzUZJvKfLzNbbu5L4ZwIdK4Lt3c506eudVU575I=;
	b=u+ZoddXCkNyXaXt0KXDL96vD9TIOAJ7v1ERuHcL57su3sAIgEE7Eblrc2zWx8fbC88H4Yh
	AnAyQIA8SM9akmHawX/U9Uo86MqJwwVfIyy3H4ovW3yjr/tcviT503aFIPt4QpclOCrDsP
	dNT/SJJapCvyg8m5KCMHk6e5HyQ8PxQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1748473696;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uKKDVzUZJvKfLzNbbu5L4ZwIdK4Lt3c506eudVU575I=;
	b=Obg68k4NS/GBAudB7GU+MkVzRewrnQBdQbNxmeuZQYfnuSGNX9BA2O4opYvc5z9IIvwsZf
	a5sYUQHMiyih4dCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 069B3136E0;
	Wed, 28 May 2025 23:08:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id IPkOAGCXN2jrWAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Wed, 28 May 2025 23:08:15 +0000
Date: Thu, 29 May 2025 01:08:06 +0200
From: David Sterba <dsterba@suse.cz>
To: Anand Jain <anand.jain@oracle.com>
Cc: linux-btrfs@vger.kernel.org, fdmanana@kernel.org, wqu@suse.com
Subject: Re: [PATCH v2] btrfs: add prefix for the scrub error message
Message-ID: <20250528230806.GJ4037@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <48119a4a4f85402b34f337d1660c08c29de9aaeb.1747741149.git.anand.jain@oracle.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <48119a4a4f85402b34f337d1660c08c29de9aaeb.1747741149.git.anand.jain@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
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
	RCPT_COUNT_THREE(0.00)[4];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,oracle.com:email,suse.com:email];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -4.00

On Tue, May 20, 2025 at 07:42:23PM +0800, Anand Jain wrote:
> Add a "scrub: " prefix to all messages logged by scrub so that it's
> easy to filter them from dmesg for analysis.
> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> Reviewed-by: Qu Wenruo <wqu@suse.com>
> ---
> v2: Improve scrub messages in ioctl.c (suggested by Qu).
>     Update commit log (suggested by Filipe).

Added to for-next, thanks.

