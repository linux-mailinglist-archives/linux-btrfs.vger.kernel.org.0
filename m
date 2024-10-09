Return-Path: <linux-btrfs+bounces-8738-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E1C9999718F
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Oct 2024 18:31:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DDE31F27B6A
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Oct 2024 16:31:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82DC61E9078;
	Wed,  9 Oct 2024 16:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="07N4W9Xb";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="f1wtkA4c";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="07N4W9Xb";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="f1wtkA4c"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E43871E32BB;
	Wed,  9 Oct 2024 16:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728491146; cv=none; b=qQJ4iwlKkOE0My+upEE9sw0+OLkoQ4HEIgodZyb74jqbpt5WE1JRYkkT564kKK4GKNSDsA2DaNWlh+bQsJdg4++6FIh5sueZfxmqAIH6mTvy/5+6CvXJI2WCX593W105dcxdDe6G+jmqkloIoRas25AOfe8h8tHwaJ1E5Il27ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728491146; c=relaxed/simple;
	bh=aM/6F/8SY0dkOs6K2UbJqM2M8kDDIyYGUkcBkx+0kRA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jVBRk204mYgjUifeyFq38x5gS3iAr1IRbHCEfd0ciaCF56D5ZGpSxpLYvx9nPvLm5qnQMP+f+67+gllpURDUqbtIftFRh65nb4UuWX0x1P6wJ1vY5+Jz7eFdscQPzwuBHklYeNClZan3TDD7b3QNvi2a5Es22HCMWNHBlrK7SGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=07N4W9Xb; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=f1wtkA4c; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=07N4W9Xb; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=f1wtkA4c; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id CE44721B39;
	Wed,  9 Oct 2024 16:25:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1728491142;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Iwsw3fwa1Gp9dvJmP8uOJz7myWQrZUaE29/MXtiF8Zw=;
	b=07N4W9XbXWBOjAuQr571w8PokYwtR0B2Gsjlze7wjdAtdDyTKSg3Az2biK1j6IjwsjdO5B
	EZqUYP6wzTzqMUHiCKEik5Qm7OLcjA9UPI5brT7HDFyk+5sbW9RKZymRhffYQ2nag69Azq
	881Y6I+Iq3PFqDlJ1ZCLTQ4306NUCc8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1728491142;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Iwsw3fwa1Gp9dvJmP8uOJz7myWQrZUaE29/MXtiF8Zw=;
	b=f1wtkA4ceiPpELmd+gz+FdOR38K7g9/PWGN3wHrMmnYUyGxT5fmal3hjj2A0ckRF7fjzoj
	Zt0ZPrlEaUmIxXDw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1728491142;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Iwsw3fwa1Gp9dvJmP8uOJz7myWQrZUaE29/MXtiF8Zw=;
	b=07N4W9XbXWBOjAuQr571w8PokYwtR0B2Gsjlze7wjdAtdDyTKSg3Az2biK1j6IjwsjdO5B
	EZqUYP6wzTzqMUHiCKEik5Qm7OLcjA9UPI5brT7HDFyk+5sbW9RKZymRhffYQ2nag69Azq
	881Y6I+Iq3PFqDlJ1ZCLTQ4306NUCc8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1728491142;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Iwsw3fwa1Gp9dvJmP8uOJz7myWQrZUaE29/MXtiF8Zw=;
	b=f1wtkA4ceiPpELmd+gz+FdOR38K7g9/PWGN3wHrMmnYUyGxT5fmal3hjj2A0ckRF7fjzoj
	Zt0ZPrlEaUmIxXDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AC706136BA;
	Wed,  9 Oct 2024 16:25:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id GNDkKYauBmcbagAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Wed, 09 Oct 2024 16:25:42 +0000
Date: Wed, 9 Oct 2024 18:25:41 +0200
From: David Sterba <dsterba@suse.cz>
To: Roi Martin <jroi.martin@gmail.com>
Cc: clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] btrfs: fix uninitialized pointer free on add_inode_ref
Message-ID: <20241009162541.GL1609@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20241009080833.1355894-1-jroi.martin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241009080833.1355894-1-jroi.martin@gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spamd-Result: default: False [-2.50 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	TAGGED_RCPT(0.00)[];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.cz:replyto];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Score: -2.50
X-Spam-Flag: NO

On Wed, Oct 09, 2024 at 10:08:33AM +0200, Roi Martin wrote:
> The "add_inode_ref" function does not initializes the "name" struct
> when it is declared.  If any of the following calls to
> "read_one_inode" returns NULL,
> 
> 	dir = read_one_inode(root, parent_objectid);
> 	if (!dir) {
> 		ret = -ENOENT;
> 		goto out;
> 	}
> 
> 	inode = read_one_inode(root, inode_objectid);
> 	if (!inode) {
> 		ret = -EIO;
> 		goto out;
> 	}
> 
> then "name.name" would be freed on "out" before being initialized.
> 
> out:
> 	...
> 	kfree(name.name);
> 
> This issue was reported by Coverity with CID 1526744.
> 
> Signed-off-by: Roi Martin <jroi.martin@gmail.com>

Reviewed-by: David Sterba <dsterba@suse.com>

Added to for-next, thanks.

