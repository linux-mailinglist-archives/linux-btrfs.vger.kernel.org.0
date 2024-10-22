Return-Path: <linux-btrfs+bounces-9049-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A25E29A955D
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Oct 2024 03:18:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3561F283061
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Oct 2024 01:17:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94BB712D773;
	Tue, 22 Oct 2024 01:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="vKjqv5x/";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="0907rx8N";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="vKjqv5x/";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="0907rx8N"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFE5959B71
	for <linux-btrfs@vger.kernel.org>; Tue, 22 Oct 2024 01:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729559859; cv=none; b=ZVEkGMptSaKAfpcPC+hznGEyZsZ58wQ9LfgJIzF1LLW2KU0u9F+lvCcZjyCKzqgtxP2CglfbAafZZxzPXpZBger/yKz+t6KbQKzVuLD0S7W4LScGo5ZJ4j5F5RPpo6XL/DC6lx3Mcj8nqVHcBNNac0QQw6X2ZO5vH77ZnuqK0vE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729559859; c=relaxed/simple;
	bh=5VpkGHxN4z6aFW0wnCI7ltZWSxa1K9nLvaNDtQfOV8Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GKQXkf0aGzhfPbqGa8+0ur3sKJNDg75dqVvoaawf8sOW5/LphXnRstI+TdqpJzDNScMvDdpyo5r9Ay/sw7LSYphdbsjRJNkhK3KbWnjTlq33MDgtn5fpLmjsJRP5sTIvWQcjx1F6VUIfZ1mcm/p0IOROOJLXOOlKa/AvnYHOkhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=vKjqv5x/; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=0907rx8N; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=vKjqv5x/; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=0907rx8N; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id AC6E71FE8B;
	Tue, 22 Oct 2024 01:17:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1729559855;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=C5uCHuQQ+Lf0RHxbjwJ9avcgTZWNjKqH8+cPiAjmRO0=;
	b=vKjqv5x/CEbsUFThmq72GWL9c0OFj30ughi27aod2lnzF7n7YkA3urpyjyfQMyApLhn7kf
	SwKtgUOGaFB9UqpTzdaMvdaa7EMC9KGotG6u+mDSf+8Fv0v/ISmPoeXERvxeoJyh0LOr6C
	JHHwjI7ttCV7jN6ETgzYym1UhnFLouo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1729559855;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=C5uCHuQQ+Lf0RHxbjwJ9avcgTZWNjKqH8+cPiAjmRO0=;
	b=0907rx8NVZ9gLB38lOEqcHpR1jd/DqE3nUPH5vFhnZx4z9lRyR7bizflbmQT2zyWU9sF6Z
	TwH1Etqj3kcSIyBA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="vKjqv5x/";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=0907rx8N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1729559855;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=C5uCHuQQ+Lf0RHxbjwJ9avcgTZWNjKqH8+cPiAjmRO0=;
	b=vKjqv5x/CEbsUFThmq72GWL9c0OFj30ughi27aod2lnzF7n7YkA3urpyjyfQMyApLhn7kf
	SwKtgUOGaFB9UqpTzdaMvdaa7EMC9KGotG6u+mDSf+8Fv0v/ISmPoeXERvxeoJyh0LOr6C
	JHHwjI7ttCV7jN6ETgzYym1UhnFLouo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1729559855;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=C5uCHuQQ+Lf0RHxbjwJ9avcgTZWNjKqH8+cPiAjmRO0=;
	b=0907rx8NVZ9gLB38lOEqcHpR1jd/DqE3nUPH5vFhnZx4z9lRyR7bizflbmQT2zyWU9sF6Z
	TwH1Etqj3kcSIyBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9738513AC2;
	Tue, 22 Oct 2024 01:17:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id uPOpJC/9FmeMDwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 22 Oct 2024 01:17:35 +0000
Date: Tue, 22 Oct 2024 03:17:34 +0200
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/2] btrfs: convert btrfs_buffered_write() to folio
 interface
Message-ID: <20241022011734.GB31418@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1728532438.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1728532438.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Queue-Id: AC6E71FE8B
X-Spam-Score: -4.20
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.20 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.19)[-0.931];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Thu, Oct 10, 2024 at 03:16:11PM +1030, Qu Wenruo wrote:
> Inspired by generic_perform_write(), convert btrfs_buffered_write() to
> go a page-by-page iteration, then convert it to use folio interface.
> 
> This should provide the basis for use to go
> address_operations->write_begin() and write_end() callbacks.
> 
> There is a tiny timing change.
> Before this patchset we wait for the page writeback after we get an
> uptodate or no need to read the page.
> 
> But now we follow the regular FGP_WRITEBEGIN, which implies FGP_STABLE
> and will wait for writeback before reading the page.
> 
> Qu Wenruo (2):
>   btrfs: make buffered write to copy one page a time
>   btrfs: convert btrfs_buffered_write() to use folio interface

So this is another step towards folios, ok. The first patch got a LKP
bot report about performance degradataion due to the change from
multiple pages to per page loop, but you mention that. The drop is 16%,
that's not something that we should ignore. It was for one workload so
this is mabye acceptable.

Another thing is that how it's changed to the write begin/end, I don't
understand this enough to give it a yes/no. Also this is the buffered
write so quite fundamental file operation. I've had the patches in
misc-next (and in linux-next) for some time, so we have some testing. I
hope we get more reviews too. We're now in rc4, so it's about the time
to get it in or delay until the next cycle if there are doubts.

Regarding the patches, I have only style comments, you touch a lot of
code that is not changed often so it would be good to fix the style of
code or comments but correctness comes first so this can be fixed later,
I'd really like to be sure this is safe.

My suggestion is to add the patches to for-next, we'll have enough time
to catch problems and expose the new code to more testing environments.

