Return-Path: <linux-btrfs+bounces-8091-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90B4F97B35B
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Sep 2024 19:03:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C23841C238F3
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Sep 2024 17:03:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D4A818133C;
	Tue, 17 Sep 2024 17:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="3XUO71gn";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="0lFCxIrv";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="3XUO71gn";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="0lFCxIrv"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB0F017AE0B;
	Tue, 17 Sep 2024 17:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726592541; cv=none; b=OzvoVnJVMFZYNbbtM/XrEiKgI8UuZxWwJVGuutwbwOjbb7/T6pdu9d0Td+hDEu6ovd+dkNqUjOvQND3R+fUyIeXkMrVxxkV67pGhu0+CLNvoJ23zg7YwhsH82DSdKTIZAo+/pW1rPWEZFIJDHBWlVnz4BQP0dDSl2/OHiqUFbSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726592541; c=relaxed/simple;
	bh=quDRDhd076WHqBIGywku9FWiyXyNXWyvLgVZg9kHrlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V98jbz7lCPhSP2DcMNe82pkj4UfvFCkdjsXabK0dCKIjBtHNAfzyWonAPIskUqW1+avVAIsEsxB847jvEFrXcLPe7WbDsZVtIMbSSGbLW1RvcYGlEBG/jkK0khjWvC1XJhlP2x6PNnrqL88Gf0jSlDF+KFXBP/HUR103mnF17Nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=3XUO71gn; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=0lFCxIrv; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=3XUO71gn; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=0lFCxIrv; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 26E142012D;
	Tue, 17 Sep 2024 17:02:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1726592538;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LjjdywdDGiZtxX/399QVThWd+iLZQJlIvJ5mb1cMV1U=;
	b=3XUO71gnQL78BNN7ZIO0bFUFMRswTMF9l9MgW71YqlYmho2qPF6XrVjz5Qg14VYT8CsNbX
	BwM5fegZwTvl5JaZnhtaXaPwa5QjxKb43/urcH6YetbjDOzvGakRyWcpyhIjzCCes8Sqyr
	SQPwtRcqxOn8gMp3nrbUzVPBakzLc0Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1726592538;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LjjdywdDGiZtxX/399QVThWd+iLZQJlIvJ5mb1cMV1U=;
	b=0lFCxIrvkulel3+kY3ursI7gexIU2io2NVXiGws6qW7xwl9F1mi7X/p3m287fAIXrLWUR3
	O8n87lGjfjj2sGCg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1726592538;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LjjdywdDGiZtxX/399QVThWd+iLZQJlIvJ5mb1cMV1U=;
	b=3XUO71gnQL78BNN7ZIO0bFUFMRswTMF9l9MgW71YqlYmho2qPF6XrVjz5Qg14VYT8CsNbX
	BwM5fegZwTvl5JaZnhtaXaPwa5QjxKb43/urcH6YetbjDOzvGakRyWcpyhIjzCCes8Sqyr
	SQPwtRcqxOn8gMp3nrbUzVPBakzLc0Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1726592538;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LjjdywdDGiZtxX/399QVThWd+iLZQJlIvJ5mb1cMV1U=;
	b=0lFCxIrvkulel3+kY3ursI7gexIU2io2NVXiGws6qW7xwl9F1mi7X/p3m287fAIXrLWUR3
	O8n87lGjfjj2sGCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1399B139CE;
	Tue, 17 Sep 2024 17:02:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id wFlJBBq26WYmcAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 17 Sep 2024 17:02:18 +0000
Date: Tue, 17 Sep 2024 19:02:16 +0200
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] btrfs: qgroup: set a more sane default value for subtree
 drop threshold
Message-ID: <20240917170216.GI2920@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <4ae3d5114b0fcffe9f95e614bb4fc8912b5f6573.1725947462.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4ae3d5114b0fcffe9f95e614bb4fc8912b5f6573.1725947462.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Score: -4.00
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-0.995];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Level: 

On Tue, Sep 10, 2024 at 03:21:04PM +0930, Qu Wenruo wrote:
> Since commit 011b46c30476 ("btrfs: skip subtree scan if it's too high to
> avoid low stall in btrfs_commit_transaction()"), btrfs qgroup can
> automatically skip large subtree scan at the cost of marking qgroup
> inconsistent.
> 
> It's designed to address the final performance problem of snapshot drop
> with qgroup enabled, but to be safe the default value is
> BTRFS_MAX_LEVEL, requiring a user space daemon to set a different value
> to make it work.
> 
> I'd say it's not a good idea to rely on user space tool to set this
> default value, especially when some operations (snapshot dropping) can
> be triggered immediately after mount, leaving a very small window to
> that that sysfs interface.
> 
> So instead of disabling this new feature by default, enable it with a
> low threshold (3), so that large subvolume tree drop at mount time won't
> cause huge qgroup workload.

Sounds like a sane idea to set it to some low value as default.

Reviewed-by: David Sterba <dsterba@suse.com>

