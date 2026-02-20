Return-Path: <linux-btrfs+bounces-21810-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ECt6MZKfmGnJKAMAu9opvQ
	(envelope-from <linux-btrfs+bounces-21810-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Fri, 20 Feb 2026 18:53:22 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 219A0169E57
	for <lists+linux-btrfs@lfdr.de>; Fri, 20 Feb 2026 18:53:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7D6A93053652
	for <lists+linux-btrfs@lfdr.de>; Fri, 20 Feb 2026 17:53:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB1A1365A13;
	Fri, 20 Feb 2026 17:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ciRN6L9G";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="E6mcQAU3";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ciRN6L9G";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="E6mcQAU3"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E06662EB860
	for <linux-btrfs@vger.kernel.org>; Fri, 20 Feb 2026 17:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771609994; cv=none; b=BfEgbgIfOD0hFoHzBfOXjqEfdHFRkLpapOGZJVnwCOXu3JMlulrWA8/mUS2QDewuxPW9UkQxY/YsIsqRIZWHEnxORzUfoi9F0iCzb/KlhF8gUXTqEtf6C7/YHZ4GPO/fbNKJ4otM4zkkPgKOCSvILMf8IjRlCqDJiSUZrALL9XY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771609994; c=relaxed/simple;
	bh=rMfq2sRAnt2+Yd1xurcAD+nvIESjaERzEr2M6zXCYIw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PAuUMJdFM9Zs2X17NNrZb1QXiENB1hLBM+3kC7/EeO8Vqt2xG5uKWOQy2AHSE9crvr0uf2HCaYvb8yGimFTjrw+k+Gfl3WRweM/5hqMpsy1y+TeBJkN0y0gO5RftiS1oMoQHZokQZB5lWQsjPFknmmoa7NOIOZIbgtWkkcPIP/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ciRN6L9G; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=E6mcQAU3; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ciRN6L9G; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=E6mcQAU3; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 13B4F5BCCC;
	Fri, 20 Feb 2026 17:53:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1771609991;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UYemnrDQNq02hlL30foHCYzUD8m4ThwLQ98LXTzTOOA=;
	b=ciRN6L9GSjjOoln+LExnLMbOgjGv40u/OTmRptaNsxyl2SpeYTxsLT8eSpcOd3mpPb6RiP
	Gtk/TTfZtIp1nwBuvjKOcz4dGbwj0tA5z4z0kere+y6qTfPB7qwOftOEyQj1/QxAI+/kdO
	7eUL2pvglxHNMJmb452NXpKyP8gN/KA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1771609991;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UYemnrDQNq02hlL30foHCYzUD8m4ThwLQ98LXTzTOOA=;
	b=E6mcQAU3Jj8mUYD1sjWf1wrRR62G6GuJRQf8n4bAnHBY8l+Or+tle7h5GUXEk3lJA5N8Wp
	H7GOBfXzZGuMojAg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1771609991;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UYemnrDQNq02hlL30foHCYzUD8m4ThwLQ98LXTzTOOA=;
	b=ciRN6L9GSjjOoln+LExnLMbOgjGv40u/OTmRptaNsxyl2SpeYTxsLT8eSpcOd3mpPb6RiP
	Gtk/TTfZtIp1nwBuvjKOcz4dGbwj0tA5z4z0kere+y6qTfPB7qwOftOEyQj1/QxAI+/kdO
	7eUL2pvglxHNMJmb452NXpKyP8gN/KA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1771609991;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UYemnrDQNq02hlL30foHCYzUD8m4ThwLQ98LXTzTOOA=;
	b=E6mcQAU3Jj8mUYD1sjWf1wrRR62G6GuJRQf8n4bAnHBY8l+Or+tle7h5GUXEk3lJA5N8Wp
	H7GOBfXzZGuMojAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DFD613EA65;
	Fri, 20 Feb 2026 17:53:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id sFBwNoafmGl1eQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Fri, 20 Feb 2026 17:53:10 +0000
Date: Fri, 20 Feb 2026 18:53:09 +0100
From: David Sterba <dsterba@suse.cz>
To: fdmanana@kernel.org
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: stop printing condition result in assertion
 failure messages
Message-ID: <20260220175309.GK26902@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <9c3463215d864eb706860e7d9c853e34d4125408.1771515807.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9c3463215d864eb706860e7d9c853e34d4125408.1771515807.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Score: -4.00
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21810-lists,linux-btrfs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[suse.cz];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	HAS_REPLYTO(0.00)[dsterba@suse.cz];
	RCVD_COUNT_FIVE(0.00)[6];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dsterba@suse.cz,linux-btrfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,suse.cz:dkim,suse.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 219A0169E57
X-Rspamd-Action: no action

On Thu, Feb 19, 2026 at 03:45:39PM +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> It's useless to print the result of the condition, it's always 0 if the
> assertion is triggered, so it doesn't provide any useful information.
> Examples:
> 
>    assertion failed: cb->bbio.bio.bi_iter.bi_size == disk_num_bytes :: 0, in inode.c:9991
>    assertion failed: folio_test_writeback(folio) :: 0, in subpage.c:476
> 
> So stop printing that, it's always ":: 0" for any assertion triggered.

I've put it there because of the single value conditions like

	ASSERT(flag);

In most cases the condition is compound and boolean so the result is not
useful and there are also many cases with simple pointer value so the
exact value is also not providing anything.

For any case we want to know exact values or possibly of subexpressions
too (like start + length or other calculations) we should use the
extended ASSERT syntax.


> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> ---
>  fs/btrfs/messages.h | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/btrfs/messages.h b/fs/btrfs/messages.h
> index 81f59afe4a99..17cdc14dc89d 100644
> --- a/fs/btrfs/messages.h
> +++ b/fs/btrfs/messages.h
> @@ -141,11 +141,11 @@ do {										\
>  	verify_assert_printk_format("check the format string" args);		\
>  	if (!likely(cond)) {							\

This should probably become "if (likely(!cond))" as mentioned recently.

