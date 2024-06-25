Return-Path: <linux-btrfs+bounces-5965-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D834E916DF6
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Jun 2024 18:23:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0758D1C21D00
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Jun 2024 16:23:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC1A9172BB4;
	Tue, 25 Jun 2024 16:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="zpVSjoNM";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="B2+VpzEt";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="zpVSjoNM";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="B2+VpzEt"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AB7549629
	for <linux-btrfs@vger.kernel.org>; Tue, 25 Jun 2024 16:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719332603; cv=none; b=uagggIZkzrBIUBWh1ezZe1MkwwWqXceuLUWDuRtbAoh7pdY1B/L4Ymen2EKvaJ7ePBYnsgB0+ytvF36H4O8yKYAVqwR7uxs6RDPOdNjH1wtnXc28CJf7fxXnRM41iC8y24omIWQXGNVjalTuRIizy5/2Up5JlsUeSkq2cnvApvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719332603; c=relaxed/simple;
	bh=9Rhyt3VBPhYr0iX0D0LHh++h0AhZ4CTmrDVLkylPiHQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CSlfKv/9MNmuBa6eYkmYyNx5UuTmeHsxb19eCtoTfDvi5tp2H7A9NMDytVgJR8ezaEKfp9AFNPSgyOONYQEX+gk7SmhWL5EXDylGMVAbnHL1WeQjIS02+6KvvkSYyjJWcqEvBUvyREgQfRYgh8M7WgVq0mzz4JAIsHKZO5kWJ78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=zpVSjoNM; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=B2+VpzEt; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=zpVSjoNM; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=B2+VpzEt; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 27C9021A78;
	Tue, 25 Jun 2024 16:23:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1719332600;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IY6alo94MX5XhuckmO1u9XNUAEu+B+kOcw41+mz7dfk=;
	b=zpVSjoNMx1dQuHuY941OepJBmnIW7VL3BrGFAMtHBVZKT0KmxI7iHZ+QLlMDeTEk0ie7wj
	C3Z8DhtZ85nU7Ucuz5ioP38SZBnKkEaAHlecUgX0U0g22SK8lZ/40GeesghokkE6k3xuWt
	q7537UTvjwF5wWFzF/xJpnLtYgbpbCo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1719332600;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IY6alo94MX5XhuckmO1u9XNUAEu+B+kOcw41+mz7dfk=;
	b=B2+VpzEtNwKxmU03qpgrgugHMWv+Op/NXPh9j2EqCT3h+ksJK3JmSGX5Me1kjSBPplBobn
	vskX/1PcpMq82ADA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=zpVSjoNM;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=B2+VpzEt
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1719332600;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IY6alo94MX5XhuckmO1u9XNUAEu+B+kOcw41+mz7dfk=;
	b=zpVSjoNMx1dQuHuY941OepJBmnIW7VL3BrGFAMtHBVZKT0KmxI7iHZ+QLlMDeTEk0ie7wj
	C3Z8DhtZ85nU7Ucuz5ioP38SZBnKkEaAHlecUgX0U0g22SK8lZ/40GeesghokkE6k3xuWt
	q7537UTvjwF5wWFzF/xJpnLtYgbpbCo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1719332600;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IY6alo94MX5XhuckmO1u9XNUAEu+B+kOcw41+mz7dfk=;
	b=B2+VpzEtNwKxmU03qpgrgugHMWv+Op/NXPh9j2EqCT3h+ksJK3JmSGX5Me1kjSBPplBobn
	vskX/1PcpMq82ADA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 178F113A9A;
	Tue, 25 Jun 2024 16:23:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id uuSQBfjuembMTwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 25 Jun 2024 16:23:20 +0000
Date: Tue, 25 Jun 2024 18:23:14 +0200
From: David Sterba <dsterba@suse.cz>
To: fdmanana@kernel.org
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: move the direct IO code into its own file
Message-ID: <20240625162314.GY25756@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <107dc9437ffcbf6751d018209d037c851a890f4d.1719328515.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <107dc9437ffcbf6751d018209d037c851a890f4d.1719328515.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Queue-Id: 27C9021A78
X-Spam-Score: -4.21
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:replyto,suse.cz:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org

On Tue, Jun 25, 2024 at 04:16:50PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> The direct IO code is over a thousand lines and it's currently spread
> between file.c and inode.c, which makes it not easy to locate some parts
> of it sometimes. Also inode.c is about 11 thousand lines and file.c about
> 4 thousand lines, both too big. So move all the direct IO code into a
> dedicated file, so that it's easy to locate all its code and reduce the
> sizes of inode.c and file.c.
> 
> This is a pure move of code without any other changes except export a
> a couple functions from inode.c (get_extent_allocation_hint() and
> create_io_em()) because they are used in inode.c and the new direct-io.c
> file, and a couple functions from file.c (btrfs_buffered_write() and
> btrfs_write_check()) because they are used both in file.c and in the new
> direct-io.c file.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Makes sense. The only thing that comes to mind is merge target and
potential collisions with other patches but I am not aware of anything.
As usual with the big code movements the future fixes will have to be
manually backported.

I have only paged through the changes and not reviewed it, bug feel free
to add it to for-next.

