Return-Path: <linux-btrfs+bounces-1338-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F1A582919B
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Jan 2024 01:51:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6FA401C241B6
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Jan 2024 00:51:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2BB3645;
	Wed, 10 Jan 2024 00:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Q2LsRcfb";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="k2q3BHhF";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Q2LsRcfb";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="k2q3BHhF"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FC0A389
	for <linux-btrfs@vger.kernel.org>; Wed, 10 Jan 2024 00:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 72C4D1F83D;
	Wed, 10 Jan 2024 00:51:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1704847880;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SemqZoncboEFThI6B63QNb1aZXIsj1asoR8Q9/YKeP0=;
	b=Q2LsRcfb0JJnJfJAlO/DB6i7lqDN9hqit7SrZp0FaCDzMg6I65gmKRYhAHVy6txYR32j5v
	xGnoknIvXvNEReX1IggdD5fmn2VQIqIbGiIHZzcQhYA0neDq235JCLJiRfaAPo8xVJmKzq
	7WXUYhLMwN/izunGlEGaBCizHJeqM5A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1704847880;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SemqZoncboEFThI6B63QNb1aZXIsj1asoR8Q9/YKeP0=;
	b=k2q3BHhF+PIgI9zdUvgHdSNqQFmyIvKPyWPSl2fft6EKoigUPSCzq6lySNBbdmr97zZhT/
	Nu4nJ4FdhgPQjhCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1704847880;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SemqZoncboEFThI6B63QNb1aZXIsj1asoR8Q9/YKeP0=;
	b=Q2LsRcfb0JJnJfJAlO/DB6i7lqDN9hqit7SrZp0FaCDzMg6I65gmKRYhAHVy6txYR32j5v
	xGnoknIvXvNEReX1IggdD5fmn2VQIqIbGiIHZzcQhYA0neDq235JCLJiRfaAPo8xVJmKzq
	7WXUYhLMwN/izunGlEGaBCizHJeqM5A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1704847880;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SemqZoncboEFThI6B63QNb1aZXIsj1asoR8Q9/YKeP0=;
	b=k2q3BHhF+PIgI9zdUvgHdSNqQFmyIvKPyWPSl2fft6EKoigUPSCzq6lySNBbdmr97zZhT/
	Nu4nJ4FdhgPQjhCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 627E113786;
	Wed, 10 Jan 2024 00:51:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id op/IFwjqnWWZaAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Wed, 10 Jan 2024 00:51:20 +0000
Date: Wed, 10 Jan 2024 01:51:05 +0100
From: David Sterba <dsterba@suse.cz>
To: fdmanana@kernel.org
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: remove extent_map_tree forward declaration at
 extent_io.h
Message-ID: <20240110005105.GM28693@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <9298fb200ab3faaaf932d0b166fbefd9e0b917ab.1704815143.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9298fb200ab3faaaf932d0b166fbefd9e0b917ab.1704815143.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-0.95 / 50.00];
	 ARC_NA(0.00)[];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 TO_DN_NONE(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.15)[-0.731];
	 RCPT_COUNT_TWO(0.00)[2];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.00)[37.52%]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -0.95

On Tue, Jan 09, 2024 at 03:46:25PM +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> There's no need to do a forward declaration of struct extent_map_tree at
> extent_io.h, as there are no function prototypes, inline functions or data
> structures that refer to struct extent_map_tree.
> 
> So remove that forward declaration, which is not needed since commit
> 477a30ba5f8d ("btrfs: Sink extent_tree arguments in
> try_release_extent_mapping").
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Added to misc-next, thanks.

