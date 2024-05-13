Return-Path: <linux-btrfs+bounces-4939-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ABA18C46C7
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 May 2024 20:28:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9D5D282780
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 May 2024 18:28:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8124D374FB;
	Mon, 13 May 2024 18:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="yGforf4E";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="cqaZTTZw";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="yGforf4E";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="cqaZTTZw"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00B4337147
	for <linux-btrfs@vger.kernel.org>; Mon, 13 May 2024 18:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715624902; cv=none; b=g1fn/CYSrz/k1gdVujq3H7AS9dg/miy8p7Q4iF9omxVWgvCrJrnn6mXymrC1gOudGGo0lJ4qnKxeTqlrix2RFTZAak23RznlJOPKEqhkFC0fZ1Vf+JfvbAZ2a2OQ49N4w/5L7GezhMOLPMFzU1iRlYgocaUF6z9eKCiZjtvDxlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715624902; c=relaxed/simple;
	bh=YMpLZIlAVXoMpy/7XaNG1bUz38GL7sBlIN2UYu1gUuY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ief+RZJrzo+gzru7jat75ilJvg6oCDpzsY8NLO05GJ0vEjatJC3ocuYhvz3/zE0GzKx9lSuw5a2SP4kAAxW8QbytBveD3JH6KFEUlTMI7SuhWW5juIe9t2QzWw8ny/ZmWLYruGT8Lm8V0WAqFLcNUJsuv7mBeDHOsthNvm2nq9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=yGforf4E; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=cqaZTTZw; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=yGforf4E; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=cqaZTTZw; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 0EF835CAB6;
	Mon, 13 May 2024 18:28:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1715624899;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xQB3egbj2RCdyKMVXjEak6DBz4Awr96zU9IDonEKWtY=;
	b=yGforf4E6MiHCctAeBUDCDrshzurbQ3CC5uJ7ZIdrdtSQgkIcuV1AnC3v4tizVs8VdVgZV
	Klo6jDtGlfzOYUEI7DZQDO+PKQJMLWfiwUhC7P188/rP8D13NsqX5xcIxaZYuysHEYTMOt
	0lJSkH5xJ8JRrYHBwGn0lPMhhL3dY0g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1715624899;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xQB3egbj2RCdyKMVXjEak6DBz4Awr96zU9IDonEKWtY=;
	b=cqaZTTZw4cXAC14S+3EppY0naxrTXMv9PZRvjAuz/Qqp/ph5aSLWucTHS1HZ9YORyc+Qrj
	rBxa0MrFDiQBZ6DQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1715624899;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xQB3egbj2RCdyKMVXjEak6DBz4Awr96zU9IDonEKWtY=;
	b=yGforf4E6MiHCctAeBUDCDrshzurbQ3CC5uJ7ZIdrdtSQgkIcuV1AnC3v4tizVs8VdVgZV
	Klo6jDtGlfzOYUEI7DZQDO+PKQJMLWfiwUhC7P188/rP8D13NsqX5xcIxaZYuysHEYTMOt
	0lJSkH5xJ8JRrYHBwGn0lPMhhL3dY0g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1715624899;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xQB3egbj2RCdyKMVXjEak6DBz4Awr96zU9IDonEKWtY=;
	b=cqaZTTZw4cXAC14S+3EppY0naxrTXMv9PZRvjAuz/Qqp/ph5aSLWucTHS1HZ9YORyc+Qrj
	rBxa0MrFDiQBZ6DQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 03B941372E;
	Mon, 13 May 2024 18:28:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ClrAAMNbQmaYBgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Mon, 13 May 2024 18:28:19 +0000
Date: Mon, 13 May 2024 20:20:58 +0200
From: David Sterba <dsterba@suse.cz>
To: fdmanana@kernel.org
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: remove no longer used
 btrfs_migrate_to_delayed_refs_rsv()
Message-ID: <20240513182057.GA4449@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <7a6704f8877c76f07ea3fc2e995b0bceea9ef602.1715620125.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7a6704f8877c76f07ea3fc2e995b0bceea9ef602.1715620125.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Flag: NO
X-Spam-Score: -3.98
X-Spam-Level: 
X-Spamd-Result: default: False [-3.98 / 50.00];
	BAYES_HAM(-2.98)[99.93%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.cz:replyto]

On Mon, May 13, 2024 at 06:09:36PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> The function btrfs_migrate_to_delayed_refs_rsv() is no longer used.
> Its last use was removed in commit 2f6397e448e6 ("btrfs: don't refill
> whole delayed refs block reserve when starting transaction").
> So remove the function.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: David Sterba <dsterba@suse.com>

