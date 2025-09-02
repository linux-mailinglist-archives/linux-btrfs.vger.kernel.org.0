Return-Path: <linux-btrfs+bounces-16599-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 47A7DB40D51
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Sep 2025 20:48:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C0BF563A83
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Sep 2025 18:48:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C10562E336F;
	Tue,  2 Sep 2025 18:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="nOfTOcB0";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="bpSJeqL/";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="nOfTOcB0";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="bpSJeqL/"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F25A2C11D4
	for <linux-btrfs@vger.kernel.org>; Tue,  2 Sep 2025 18:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756838928; cv=none; b=hg/mX2+/B6hnqjRtm/x47uajzSuyx2+j+ZWCP2nyXizRh2id9InuwvPyKbrFjK50Uu6qkElTVlsdIxXwwa6XwYVrmbJaD0WpBHxKomsolsDR+138VaVvYWzpXnSpOgfdfg2UJB2fKRHsihgiPyHYIfsJ2mThYtSsvIIE2qZC2ZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756838928; c=relaxed/simple;
	bh=ZDpWkvhi7FGlt8LRS/2dUukUYczwtMhe90o8t9I237k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dwEugdyQuBYjCU6Flz1n92j0ncBegpqrnRBWNt/qHO399JY0QMN4mFkI0K2GVNYjVSFZjJFQfhGf2UVe1PqUEH3DRx2lhJn0dwua6bf5op/HOyjHszpPqordRLqUYuyUXZP7tEjUlHJUdJx/WagiEUsEbbNOWWW74VB2ILMaSzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=nOfTOcB0; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=bpSJeqL/; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=nOfTOcB0; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=bpSJeqL/; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 902181F45B;
	Tue,  2 Sep 2025 18:48:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1756838924;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cLvjTunjMOa28lckCS0DNU5LH9RiQYeZ8klBgzps62I=;
	b=nOfTOcB0Rw/HN7tkunT3CPx7gLtFkkYGt9SBfIkvM4FIIOiZrXOTKOxrmt7HPmoHlbUE6E
	Ue/ZT+2ErgY3WKjUbE8tp+hDaSETa8Nqhz62PoWtqOh5mChpZm28YpjcV13O+PPnUtQAde
	v5Ukh6jN/g+lZtB1yX5oJ3y7InfOVS4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1756838924;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cLvjTunjMOa28lckCS0DNU5LH9RiQYeZ8klBgzps62I=;
	b=bpSJeqL/6xrDgNOSLZnuBKsgrQOGwNtICbbvudFf/w84vwzuAC82wGkFx5csLTETMbWvX9
	tYVUvVvSPPIxgoAw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=nOfTOcB0;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="bpSJeqL/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1756838924;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cLvjTunjMOa28lckCS0DNU5LH9RiQYeZ8klBgzps62I=;
	b=nOfTOcB0Rw/HN7tkunT3CPx7gLtFkkYGt9SBfIkvM4FIIOiZrXOTKOxrmt7HPmoHlbUE6E
	Ue/ZT+2ErgY3WKjUbE8tp+hDaSETa8Nqhz62PoWtqOh5mChpZm28YpjcV13O+PPnUtQAde
	v5Ukh6jN/g+lZtB1yX5oJ3y7InfOVS4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1756838924;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cLvjTunjMOa28lckCS0DNU5LH9RiQYeZ8klBgzps62I=;
	b=bpSJeqL/6xrDgNOSLZnuBKsgrQOGwNtICbbvudFf/w84vwzuAC82wGkFx5csLTETMbWvX9
	tYVUvVvSPPIxgoAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8258D13888;
	Tue,  2 Sep 2025 18:48:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id xtWfHww8t2iGawAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 02 Sep 2025 18:48:44 +0000
Date: Tue, 2 Sep 2025 20:48:43 +0200
From: David Sterba <dsterba@suse.cz>
To: fdmanana@kernel.org
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
	Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH] fstests: add commit IDs for kernel fixes already merged
 upstream
Message-ID: <20250902184843.GH5333@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <c2806ea741c0f0d185930c30dbc334bc1fbbfbd5.1756823100.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c2806ea741c0f0d185930c30dbc334bc1fbbfbd5.1756823100.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 902181F45B
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[]
X-Spam-Score: -4.21

On Tue, Sep 02, 2025 at 03:27:54PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Replace the commit ID stubs for btrfs/301, generic/211 and generic/771
> with the commit IDs in Linus' tree.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: David Sterba <dsterba@suse.com>

