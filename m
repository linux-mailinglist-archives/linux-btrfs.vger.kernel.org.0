Return-Path: <linux-btrfs+bounces-12621-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F2A8FA73CBB
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Mar 2025 18:50:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48DB7189C3B4
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Mar 2025 17:49:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B829219317;
	Thu, 27 Mar 2025 17:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="SvEocxmx";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="NpMoUBME";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="SvEocxmx";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="NpMoUBME"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C60E1AD3E0
	for <linux-btrfs@vger.kernel.org>; Thu, 27 Mar 2025 17:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743097777; cv=none; b=SyzHycbJhdEBZHQU8JzvWyGmnRLe0z0/W4vvPOuimZTLZzHUSe5izB+/2jlLA5J5CAcs9PSUooFJcycdaaREkzo4GUbMhiokREXnr/ZVTNeLsdlWws1GRyHFVNoir+FkGyRoD7gfjhwmlBuAeI7JnzORcrVn5t6ECxtj/eLPSpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743097777; c=relaxed/simple;
	bh=ZEIUkoaQPaSzBmYU+I4fLS12CY8Th2qSZbdh3CAQx+k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Eu/qcwmXM3vfg0AMhjo6A9LFlZvk/6bEon+sUbiQywCWssVklHlFbaLpXu3wQYToblbxlyhTbev7Y3uoGN+nv8pA2f/XjXqwTfvaLpTR9jRCNA4AF7mNiiXGzajVZK7PTqJzQHXxwh7jXvToKkuTXfowKzTLFzIEnb8HS5WcYhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=SvEocxmx; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=NpMoUBME; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=SvEocxmx; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=NpMoUBME; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 75B32211BA;
	Thu, 27 Mar 2025 17:49:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1743097774;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=p/KhYhVAzdvVpym7aWDa5JtRnieeD0fVOGzEBeF6J1o=;
	b=SvEocxmxqmoTp8FxH/xWlcRSusyqqF/ngaCYukFSfzj6BhpWLlN8SsjazhhDR6ffcYVNeC
	GhzS3xkKsXLtn3GQbTGa04mx1mIayReO6dAhqlmzn45Pb6GbwIhtntkeQkvYKwejIJpKBx
	pTTQ4Gy+5hGzmHJQxdFeV9dYFEam6cE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1743097774;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=p/KhYhVAzdvVpym7aWDa5JtRnieeD0fVOGzEBeF6J1o=;
	b=NpMoUBMEbQrJDaEpgs4mcI0KluW8NM5dcvS25yg5G+m5To2PX3Eq3alIizcmr48sjZ27tQ
	Go0tiWlpXp/vLiBw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1743097774;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=p/KhYhVAzdvVpym7aWDa5JtRnieeD0fVOGzEBeF6J1o=;
	b=SvEocxmxqmoTp8FxH/xWlcRSusyqqF/ngaCYukFSfzj6BhpWLlN8SsjazhhDR6ffcYVNeC
	GhzS3xkKsXLtn3GQbTGa04mx1mIayReO6dAhqlmzn45Pb6GbwIhtntkeQkvYKwejIJpKBx
	pTTQ4Gy+5hGzmHJQxdFeV9dYFEam6cE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1743097774;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=p/KhYhVAzdvVpym7aWDa5JtRnieeD0fVOGzEBeF6J1o=;
	b=NpMoUBMEbQrJDaEpgs4mcI0KluW8NM5dcvS25yg5G+m5To2PX3Eq3alIizcmr48sjZ27tQ
	Go0tiWlpXp/vLiBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 66B771376E;
	Thu, 27 Mar 2025 17:49:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id BEC7GK6P5WeJIQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Thu, 27 Mar 2025 17:49:34 +0000
Date: Thu, 27 Mar 2025 18:49:33 +0100
From: David Sterba <dsterba@suse.cz>
To: Mark Harmstone <maharmstone@fb.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: fix typo in space info explanation
Message-ID: <20250327174933.GZ32661@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20250318155648.159250-1-maharmstone@fb.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250318155648.159250-1-maharmstone@fb.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWO(0.00)[2];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Score: -4.00
X-Spam-Flag: NO

On Tue, Mar 18, 2025 at 03:56:42PM +0000, Mark Harmstone wrote:
> There's an explanation of how space info works at the top of
> fs/btrfs/space-info.c, which makes reference to a variable called
> bytes_may_reserve.  There's nothing called that in the code, and wasn't
> at time the comment was written; as far I can tell this is a typo, and
> it should actually be bytes_may_use.
> 
> Signed-off-by: Mark Harmstone <maharmstone@fb.com>

Added to for-next, thanks.

